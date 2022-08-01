Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D555867EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiHALJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHALJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:09:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7525EB9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526B8B80F9C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8994C433D6;
        Mon,  1 Aug 2022 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659352145;
        bh=tfx740fNJTOmx1aSepgTjvdyrSAGTVbfsKqeiddsPjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mV/GhBRSc7gFQ7qefvOxaEthH68eBWrjpGZFcGFGnaYeI1nlwIv71RBwx38300xNn
         mGzIwvC/aItVKR0/0CAY3FbG4fu7l1sqwvdgFf+OSTY0sIFpWobtLymw942hac22nY
         YJfnw38MoCHnhlMZrK87diAnkF1jEtwVC3kBpLq4=
Date:   Mon, 1 Aug 2022 13:09:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace
 breakage, use __BITS_PER_LONG for swap
Message-ID: <Yue0Tj+tnXRhCWab@kroah.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
 <20220731182635.1910069-2-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731182635.1910069-2-hegtvedt@cisco.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 08:26:31PM +0200, Hans-Christian Noren Egtvedt wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> QEMU has a funny new build error message when I use the upstream kernel
> headers:
> 
>       CC      block/file-posix.o
>     In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
>                      from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
>                      from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
>                      from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
>                      from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
>     /usr/include/linux/swab.h: In function `__swab':
>     /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>           |                                  ^~~~~~
>     /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>           |                                         ^
>     cc1: all warnings being treated as errors
>     make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
>     rm tests/qemu-iotests/socket_scm_helper.o
> 
> This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to
> swab() and share globally in swab.h").  That patch is doing
> 
>   #include <asm/bitsperlong.h>
> 
> but it uses BITS_PER_LONG.
> 
> The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.
> 
> Let us use the __ variant in swap.h
> 
> Link: http://lkml.kernel.org/r/20200213142147.17604-1-borntraeger@de.ibm.com
> Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Joe Perches <joe@perches.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit 467d12f5c7842896d2de3ced74e4147ee29e97c8)

As you are passing on patches from others, it is usually requried that
you too sign-off on them.  Can you fix that up on this series and resend
it so that I can take them?

thanks,

greg k-h
