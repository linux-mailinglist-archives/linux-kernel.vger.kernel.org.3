Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6329B5819FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiGZSuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4ADA5;
        Tue, 26 Jul 2022 11:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C5A612D4;
        Tue, 26 Jul 2022 18:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B22C433D7;
        Tue, 26 Jul 2022 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658861430;
        bh=/5gd7QG+BicB+4FI0G/7NWSJ43W5Y9zaAjOgMutftug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dYxHJ1v5pBWoYrGo1dhUgt45sbg8vUQ1LLPPLy4jOh9idJ2m39rjGhLLE0jpbRHoc
         wrf47MaC1DBqOAuXjCt69wyPs9o+ETmir9R+PKBOcHHsrG9uIz2GVzSsEIKyAW89r9
         tYTzrYb69kR93S4VoVlXbZ2NW17opBBi2YsJHt3U=
Date:   Tue, 26 Jul 2022 11:50:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Michal Hocko <mhocko@suse.com>, mm-commits@vger.kernel.org,
        syzbot+2d2aeadc6ce1e1f11d45@syzkaller.appspotmail.com,
        shakeelb@google.com, roman.gushchin@linux.dev, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Subject: Re: + mm-memcontrol-fix-potential-oom_lock-recursion-deadlock.patch
 added to mm-unstable branch
Message-Id: <20220726115029.ead4b2dfcd8b3df8e31ccc00@linux-foundation.org>
In-Reply-To: <ac3a7af1-08c6-e2de-b93c-327ce6839830@I-love.SAKURA.ne.jp>
References: <20220725220032.B4C30C341C8@smtp.kernel.org>
        <Yt+iWGnA06DjsHz9@dhcp22.suse.cz>
        <ac3a7af1-08c6-e2de-b93c-327ce6839830@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 20:31:17 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

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

I used the above as the new changelog text.
