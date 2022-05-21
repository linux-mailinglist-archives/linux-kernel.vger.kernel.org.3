Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45CD52FEA3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiEURwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiEURwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:52:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C682286ED
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JFnShOrbXPheK2o1UXw4WQjmlOVuTNamJGsABFX0j4A=; b=gPXYckZgKo33zVw1AIKOTeVdaC
        Op3DaxtoBc+lGvYKBeyh71qX+sdpNyZoda3usBdSUd2CCpbRMZa5djaCwKB6RicdqEtrcuJj7St0m
        RvwqeKy8K4D+oNazcqIel573pWLHIQZmJDV+p4s3Qr7kl938eTna7YxwhAgOoOLmEnFAngWvBV0JO
        MKD2lAtWZjGNBWEUC73c26QGdgaot304nvTJwFUccflMtTjJrHwaZCnhEAeJJfFEesdkqUSObVUob
        TQgRElFOLb1MpmQSMbBqSCaw4xn6sf6FvkMDt+adIJdxQBYeTfzHkFnc1hKn2CXXkzQgpcLQ0UQhW
        MWQ34/tg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsTGd-00Gukc-IW; Sat, 21 May 2022 17:51:55 +0000
Date:   Sat, 21 May 2022 17:51:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Message-ID: <Yokmu7bQpg70Bp8R@zeniv-ca.linux.org.uk>
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
 <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
 <f3878dfd-67f7-9a01-8dcf-7202bf5f3918@kernel.dk>
 <Yoe3ROmrA8sNe3Cb@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoe3ROmrA8sNe3Cb@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:44:04PM +0000, Al Viro wrote:
> On Fri, May 20, 2022 at 09:32:34AM -0600, Jens Axboe wrote:
> 
> > Didn't look closer, but I'm assuming this is _mostly_ tied to needing to
> > init 48 bytes of kiocb for each one. There might be ways to embed a
> > sync_kiocb inside the kiocb for the bits we need there, at least that
> > could get us down to 32 bytes.
> 
> My bet would be on iocb_flags() (and kiocb_set_rw_flags()) tests and
> pointer-chasing, actually.  I'd been sick on and off since early November,
> trying to dig myself from under the piles right now.  Christoph's
> patches in that area are somewhere in the pile ;-/

FWIW, I can't find them, assuming I'm not misremembering in the first place.

iocb_flags() is an atrocity, indeed.  Look what happens in new_sync_write():

[edx holds file->f_flags]
        movl    %edx, %eax
        shrl    $6, %eax
        andl    $16, %eax	// eax = (edx >> 6) & 16; maps O_APPEND to IOCB_APPEND
        movl    %eax, %ecx
        orl     $131072, %ecx
        testb   $64, %dh
        cmovne  %ecx, %eax	// eax = edh & 0x4000 ? eax | 0x20000;
        testb   $16, %dh        // if (edx & O_DSYNC)
        jne     .L175           //	goto L175;	branch not taken
        movq    216(%rdi), %rcx // rcx = file->f_mapping;	// fetch
        movq    (%rcx), %rcx    // rcx = rcx->host;		// fetch
        movq    40(%rcx), %rsi	// rsi = rcx->i_sb;		// fetch
        testb   $16, 80(%rsi)   // if (!(rsi->s_flags & 0x10))	// fetch
        je      .L198           //	goto L198;		// branch likely taken
L175:
        orl     $2, %eax        // eax |= IOCB_DSYNC;
L176:  
        movl    %eax, %ecx
        orl     $4, %ecx
        andl    $1048576, %edx
        cmovne  %ecx, %eax	// eax = edx & __O_SYNC ? eax | IOCB_SYNC : eax;

        movq %gs:current_task, %rdx     # rdx = current;
        movq    2192(%rdx), %rcx        # rcx = rdx->io_contenxt;
        movl    $16388, %edx    #       edx = IOPRIO_DEFAULT;
        testq   %rcx, %rcx      #       if (!rcx)
        je      .L178           #               goto L178;
        movzwl  12(%rcx), %edx  #       edx = rcx->ioprio;
L178:
	...
	fill iov_iter
	call ->write_iter() and bugger off

L198:
        testb   $1, 12(%rcx)    //  if (rcx->i_flags & S_SYNC)
        je      .L176
        jmp     .L175

IOCB_DSYNC part is bloody awful.  To add insult to injury, we end up
doing it in new_sync_read() as well ;-/  Its validity is dubious, BTW -
we only get away with that since O_DSYNC is ignored for all in-tree
character devices and since for block ones ->f_mapping->host->i_sb
ends up pointing to blockdev_superblock, which won't be mounted
sync.

I've sent a patch into old thread ([RFC] what to do with IOCB_DSYNC?);
it's completely untested, though.
