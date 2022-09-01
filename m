Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854B65A95CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIALf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiIALfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:35:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F82AC60
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:35:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5101F1FFA4;
        Thu,  1 Sep 2022 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662032106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OG+iIWS5A8fbxQ89HNd8+SKZPeTazSdlBEhzgCR6ffo=;
        b=MSVibIQUQyiVnv795lwK68fNJx0GQAua9hsV7CqQugm08YmLZCJD1XcFsNH95FsXjP2jzW
        lD6VaclLpf38k8BJJLTyg147FqMtHxtQ2TcmgiNv8s/QR2LoDROHnbUXtUMPZYRBXlTkgJ
        xGPuDKDfC+lWgcJEIbC5j44vNfQ8Gcc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A29C2C141;
        Thu,  1 Sep 2022 11:35:04 +0000 (UTC)
Date:   Thu, 1 Sep 2022 13:35:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] kernel/panic: Drop unblank_screen call
Message-ID: <YxCY57DmFfTuHs1q@alley>
References: <20220830145004.430545-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830145004.430545-1-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-08-30 16:50:04, Daniel Vetter wrote:
> console_unblank() does this too (called in both places right after),
> and with a lot more confidence inspiring approach to locking.
> 
> Reconstructing this story is very strange:
> 
> In b61312d353da ("oops handling: ensure that any oops is flushed to
> the mtdoops console") it is claimed that a printk(" "); flushed out
> the console buffer, which was removed in e3e8a75d2acf ("[PATCH]
> Extract and use wake_up_klogd()"). In todays kernels this is done way
> earlier in console_flush_on_panic with some really nasty tricks. I
> didn't bother to fully reconstruct this all, least because the call to
> bust_spinlock(0); gets moved every few years, depending upon how the
> wind blows (or well, who screamed loudest about the various issue each
> call site caused).
> 
> Before that commit the only calls to console_unblank() where in s390
> arch code.
> 
> The other side here is the console->unblank callback, which was
> introduced in 2.1.31 for the vt driver. Which predates the
> console_unblank() function by a lot, which was added (without users)
> in 2.4.14.3. So pretty much impossible to guess at any motivation
> here. Also afaict the vt driver is the only (and always was the only)
> console driver implementing the unblank callback, so no idea why a
> call to console_unblank() was added for the mtdooops driver - the
> action actually flushing out the console buffers is done from
> console_unlock() only.

My understanding is that mtdoops is not a real console. The commit
4b23aff083649eafa141 ("[MTD] oops and panic message logging to MTD
device") suggests that it was just (mis)using the console
infrastructure.

The commit 2e386e4bac90554887e73d ("mtd: mtdoops: refactor as a
kmsg_dumper") converted it to use the new kmsg_dumper API that
was created for this use case.

So, I would consider all the mtdoops-related changes as a misuse
of the console API.


> Note that as prep for the s390 users the locking was adjusted in
> 2.5.22 (I couldn't figure out how to properly reference the BK commit
> from the historical git trees) from a normal semaphore to a trylock.
> 
> Note that a copy of the direct unblank_screen() call was added to
> panic() in c7c3f05e341a ("panic: avoid deadlocks in re-entrant console
> drivers"), which partially inlined the bust_spinlocks(0); call.
> 
> Long story short, I have no idea why the direct call to unblank_screen
> survived for so long (the infrastructure to do it properly existed for
> years), nor why it wasn't removed when the console_unblank() call was
> finally added. But it makes a ton more sense to finally do that than
> not - it's just better encapsulation to go through the console
> functions instead of doing a direct call, so let's dare. Plus it
> really does not make much sense to call the only unblank
> implementation there is twice, once without, and once with appropriate
> locking.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Nice analyze. The change makes perfect sense from my POV:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
