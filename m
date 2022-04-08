Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8C4F8E59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiDHD43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDHD4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:56:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15ABC6F10
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C7CEB827AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C2C385A1;
        Fri,  8 Apr 2022 03:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649390061;
        bh=1Y2UYLvXIUmwvQoPN0InwWQ3wXYXh87vwoIWlmTeZV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c3movuKx8RCKiLY5fJcN98r6JVGTASOxlDirWlw4KUEfpH3ckiSCbrFoiaq9KPRAe
         TndtDJBiozSYi/57BS4yeuna6299luYfZiZT1YELCjPfitgqrj7665Amq+vNlau23T
         xU8bU+XO3O2lkI4K4Ea7W7bCUMqG+O5bOaXP0AVM=
Date:   Thu, 7 Apr 2022 20:54:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-Id: <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
In-Reply-To: <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
        <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
        <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 11:50:05 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> 
> On 2022/4/8 10:54 AM, Muchun Song wrote:
> > On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
> >> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
> >> before calling percpu_ref_put(), which will cause the value of
> >> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
> >> returns.
> >>
> >> 	CPU0				CPU1
> >>
> >> percpu_ref_switch_to_atomic_sync(&ref)
> >> --> percpu_ref_switch_to_atomic(&ref)
> >>      --> percpu_ref_get(ref);	/* put after confirmation */
> >> 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
> >>
> >> 					percpu_ref_switch_to_atomic_rcu
> >> 					--> percpu_ref_call_confirm_rcu
> >> 					    --> data->confirm_switch = NULL;
> >> 						wake_up_all(&percpu_ref_switch_waitq);
> >>
> >>      /* here waiting to wake up */
> >>      wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
> >> 						(A)percpu_ref_put(ref);
> >> /* The value of &ref is unstable! */
> >> percpu_ref_is_zero(&ref)
> >> 						(B)percpu_ref_put(ref);
> >>
> >> As shown above, assuming that the counts on each cpu add up to 0 before
> >> calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
> >> to atomic mode, percpu_ref_is_zero() can return true. But actually it will
> >> return different values in the two cases of A and B, which is not what
> >> we expected.
> >>
> >> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
> >> just to ensure that the conversion to atomic mode is completed, but it
> >> should not return with an extra reference count.
> >>
> >> Calling wake_up_all() after percpu_ref_put() ensures that the value of
> >> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
> >> So just do it.
> >>
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Are any users affected by this?  If so, I think a Fixes tag
> > is necessary.
> 
> Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
> affected by this.
> 
> I see that this patch has been merged into the mm tree, can Andrew help
> me add the following Fixes tag?

Andrew is helpful ;)

Do you see reasons why we should backport this into -stable trees? 
It's 8 years old, so my uninformed guess is "no"?

