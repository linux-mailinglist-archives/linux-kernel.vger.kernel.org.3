Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4625AFF99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiIGIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIGIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:51:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C669A999
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:51:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 968CF33BD3;
        Wed,  7 Sep 2022 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662540696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVqiRDITeo6/2WfId1Gqy1iWaPcx504+D/1P0NH/A0w=;
        b=B+Da76AvP5qd5n/XSoO+CQ11LjuZAJ/Tc7RSSWkiCoV5OU053CxMIqzzxpjwdZfZ1lUliV
        DaQYMmsjZ3Yx/hxre6tWK8vt8ziWQGj51HY5B3YdZ2rDyoXwy4/d/yvPYDb5yi0jZ9V/Op
        AWtrF6O0U27i5MBjbIP4GaPmS7RRkEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662540696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVqiRDITeo6/2WfId1Gqy1iWaPcx504+D/1P0NH/A0w=;
        b=EnwlkB6gYQpBJjD1PePOjqhi3OWJgkn/eh8l18/3C9T5ZtDr4GZlK3sQBDSu7AacMcYSZo
        Usktknrunp9cyYBQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59A092C141;
        Wed,  7 Sep 2022 08:51:34 +0000 (UTC)
Date:   Wed, 7 Sep 2022 09:51:33 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] sched/fair: cleanup for SIS_PROP
Message-ID: <20220907085133.nazbi7wftff46jrg@suse.de>
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
 <20220901131107.71785-5-wuyun.abel@bytedance.com>
 <20220901140311.xi3y72uxdwbpxzrq@suse.de>
 <6ab7ecbb-d0fb-dc44-cada-fcdc5b9676d0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6ab7ecbb-d0fb-dc44-cada-fcdc5b9676d0@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:59:33PM +0800, Abel Wu wrote:
> On 9/1/22 10:03 PM, Mel Gorman wrote:
> > On Thu, Sep 01, 2022 at 09:11:07PM +0800, Abel Wu wrote:
> > > The sched-domain of this cpu is only used when SIS_PROP is enabled,
> > > and it should be irrelevant whether the local sd_llc is valid or
> > > not, since all we care about is target sd_llc if !SIS_PROP.
> > > 
> > > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > 
> > This could conceivably result in an uninitialised memory access if
> > SIS_PROP was enabled while select_idle_cpu is running. I'm not sure if
> > it can happen when jump labels are in use but I think it could happen
> > for !CONFIG_JUMP_LABEL updating the sysctl_sched_features bitmap updated
> > via sysctl.
> > 
> > The patch is still a good idea because it moves an unlikely rcu_deference
> > out of the default path for sched features but either this_sd needs to
> > be initialised to NULL and checked or the this_sd lookup needs to happen
> > twice at a slight additional cost to the default-disabled SIS_PROP path.
> > 
> 
> Hi Mel, please check the following resent patch, Thanks!
> 
> https://lore.kernel.org/lkml/20220902033032.79846-5-wuyun.abel@bytedance.com/

Weird, I don't remember seeing this patch even though I'm cc'd on it. It
looks fine so even though it's the wrong thread;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
