Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2845812BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiGZMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGZMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616CA2559B;
        Tue, 26 Jul 2022 05:04:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C7C41FCE9;
        Tue, 26 Jul 2022 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658837096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFxbdUTxOSfpkrpCjQtHF0t41MaySwoFvQqoE727Q9s=;
        b=ZGY9/QLugeGs5TEHzW25VmqHmJuYByAfJlkb76S3UNSN4HgP+VCyNv6rsIwc0TGYxqityd
        FpRMqa8MH5sWTBr6YUxTbsYre82gDHy66GSwnYHn79prhInjqCCjAQegLcTZq6WzewNPIH
        FYTBKcUNgXeCttkiOg+N8dsfIQdtdHw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F140613322;
        Tue, 26 Jul 2022 12:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vudbOGfY32JFdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 26 Jul 2022 12:04:55 +0000
Date:   Tue, 26 Jul 2022 14:04:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     mm-commits@vger.kernel.org,
        syzbot+2d2aeadc6ce1e1f11d45@syzkaller.appspotmail.com,
        shakeelb@google.com, roman.gushchin@linux.dev, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: + mm-memcontrol-fix-potential-oom_lock-recursion-deadlock.patch
 added to mm-unstable branch
Message-ID: <Yt/YZ8zVabIpJXw4@dhcp22.suse.cz>
References: <20220725220032.B4C30C341C8@smtp.kernel.org>
 <Yt+iWGnA06DjsHz9@dhcp22.suse.cz>
 <ac3a7af1-08c6-e2de-b93c-327ce6839830@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3a7af1-08c6-e2de-b93c-327ce6839830@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-07-22 20:31:17, Tetsuo Handa wrote:
> On 2022/07/26 17:14, Michal Hocko wrote:
> > As we have concluded there are two issues possible here which would be
> > great to have reflected in the changelog.
> > 
> > On Mon 25-07-22 15:00:32, Andrew Morton wrote:
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Subject: mm: memcontrol: fix potential oom_lock recursion deadlock
> >> Date: Fri, 22 Jul 2022 19:45:39 +0900
> >>
> >> syzbot is reporting GFP_KERNEL allocation with oom_lock held when
> >> reporting memcg OOM [1].  Such allocation request might deadlock the
> >> system, for __alloc_pages_may_oom() cannot invoke global OOM killer due to
> >> oom_lock being already held by the caller.
> > 
> > I would phrase it like this:
> 
> This report is difficult to explain correctly.
> 
> > syzbot is reporting GFP_KERNEL allocation with oom_lock held when
> > reporting memcg OOM [1].
> 
> Correct. But
> 
> >                          This is problematic because this creates a
> > dependency between GFP_NOFS and GFP_KERNEL over oom_lock which could
> > dead lock the system.
> 
> oom_lock is irrelevant when trying GFP_KERNEL allocation from GFP_NOFS
> context. Therefore, something like:

I meant to say there is a dependency chain
	potential_fs_lock
	GFP_NOFS
				oom_lock
				GFP_KERNEL
				potentiaL_lock
	oom_lock
 
> ----------
> syzbot is reporting GFP_KERNEL allocation with oom_lock held when
> reporting memcg OOM [1]. If this allocation triggers the global OOM
> situation then the system can livelock because the GFP_KERNEL allocation
> with oom_lock held cannot trigger the global OOM killer because
> __alloc_pages_may_oom() fails to hold oom_lock.
> 
> Fix this problem by removing the allocation from memory_stat_format()
> completely, and pass static buffer when calling from memcg OOM path.
> 
> Note that the caller holding filesystem lock was the trigger for syzbot
> to report this locking dependency. Doing GFP_KERNEL allocation with
> filesystem lock held can deadlock the system even without involving OOM
> situation.
> ----------

But this sounds good as well.

Thanks!

-- 
Michal Hocko
SUSE Labs
