Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2658850F19A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiDZHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbiDZHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:02:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4C60055
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:59:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ADF3B1F388;
        Tue, 26 Apr 2022 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650956371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQZAfakINXXUF6QkmKLshpcGVsJFPzKHe9GL9BtpKHQ=;
        b=gCaf9t121tHQp1fEYxinnaNc7/2/j88so7AtrAFXPKKCZKHFB15rIc0owCHyFx+J7ojKCy
        aXivEz47i1AhOBwwKe+ytyEcoOJ+8hqqjtifEmWnraD/Yb7gfZodnr2Chyz2YxDjZziKLU
        TVGMsvLaRRGTbV3wfG3YGche3u1h1h0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 601DC2C149;
        Tue, 26 Apr 2022 06:59:31 +0000 (UTC)
Date:   Tue, 26 Apr 2022 08:59:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC 3/3] exit: Check for MMF_OOM_SKIP in exit_mmap
Message-ID: <YmeYUX7Nh47j3gKc@dhcp22.suse.cz>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-4-npache@redhat.com>
 <YmLMBDkHmcjf9Nem@dhcp22.suse.cz>
 <19303483-5700-fb6e-ba4a-398913370100@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19303483-5700-fb6e-ba4a-398913370100@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-04-22 15:00:24, Nico Pache wrote:
> 
> 
> On 4/22/22 11:38, Michal Hocko wrote:
> > On Thu 21-04-22 15:05:33, Nico Pache wrote:
> >> The MMF_OOM_SKIP bit is used to indicate weather a mm_struct can not be
> >> invalided or has already been invalided. exit_mmap currently calls
> >> __oom_reap_task_mm unconditionally despite the fact that the oom reaper
> >> may have already called this.
> >>
> >> Add a check for the MMF_OOM_SKIP bit being set in exit_mmap to avoid
> >> unnessary calls to the invalidate code.
> > 
> > Why do we care about this?
> Is there no cost to the MMU/TLB invalidation? The MMU notifier contains a lock
> too so perhaps we can also avoids some unnecessary MMU notifier lock contention.

I am pretty sure that this area can be micro optimized but I do not
really see a strong reason for that. OOM victims are/should be really
rare so I do not think that any performance optimization would be really
visible.

If you want to improve the code then I think a much better plan would be
to get rid of the whole oom special case altogether. This might be much
closer than ever after Hugh's recent m{un}lock changes. I didn't have
time to think that through though. I believe Suren Baghdasaryan has been
looking into that as well.
-- 
Michal Hocko
SUSE Labs
