Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6A4F8D80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiDHEMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiDHEMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:12:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE191CFC2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4ECDB827AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB25C385A1;
        Fri,  8 Apr 2022 04:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649391019;
        bh=a5MW3Y7fTlcWfiSqExChn/gvYPyz15/eSD1A/kNQLm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnPukCRDuNYENUubVhda6jWGi7qBKt0mxnQsXPSIMC+ZMY06KlwQ589fj7QryLIqK
         ATQuvXlavifEXziVeRPHpx4/0N4I4TXp3iamCj8HM+zjmRP8crl90cZyPC4s0RSFW9
         OmkHz4Z/CkX5ZT64tB/BJb7ngw5LfOcXxP4wpTcU=
Date:   Thu, 7 Apr 2022 21:10:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-Id: <20220407211018.875696691e4411a7b5c8f63f@linux-foundation.org>
In-Reply-To: <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
        <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
        <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
        <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
        <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
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

On Fri, 8 Apr 2022 12:06:20 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> 
> >>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >>>
> >>> Are any users affected by this?  If so, I think a Fixes tag
> >>> is necessary.
> >>
> >> Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
> >> affected by this.
> >>
> >> I see that this patch has been merged into the mm tree, can Andrew help
> >> me add the following Fixes tag?
> > 
> > Andrew is helpful ;)
> > 
> > Do you see reasons why we should backport this into -stable trees?
> > It's 8 years old, so my uninformed guess is "no"?
> 
> Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
> problem for the usage at that time, maybe the correct Fixes tag is the
> following:
> 
> Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to 
> atomic mode.")
> 
> But in fact, there is no problem with it, but all current users expect
> the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.
> 
> I have no idea as which Fixes tag to add.

Well the solution to that problem is to add cc:stable and let Greg
figure it out ;)

The more serious question is "should we backport this".  What is the
end-user-visible impact of the bug?  Do our users need the fix or not?

