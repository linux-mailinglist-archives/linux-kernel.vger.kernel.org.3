Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAA5758E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiGOAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbiGOAzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:55:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8AB474FB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i5V0rq365/EZ+PBYKdlyx+p+aeyqnp0HDqLpcN9uOvE=; b=PgbJ8vYzVGvJurKL9zxzlFf/iC
        iZP6QSMY71LlILA+ejJyUuVc627DekfEDNGu6LzwlluaBmCu/DatLCbd5QUy49pjW5t94LO/lFjF1
        jwQR6AgLk2iB3QdxpdUA19yRbaL7qRHbGLJFTUahvEEGnnNLr6jC0nj22C0ZgTP6Pw13H+/7ENziS
        bb9bnWnOLXYLCHDU2AKn5YD9Nw6sM2lWOhFooxC7Nh7aFsG956BKW+1XMlFfFSyGKYABssfPEeWzs
        HKwvHlegDqRZKfaUifm4kdRjqMIcfFsSggzc1CfDgPEcnrYzhVS/p5lVUPZ5XRy2HmbiBlw2bktIv
        DL1SE+nA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oC9bi-00C8Cw-DN;
        Fri, 15 Jul 2022 00:55:02 +0000
Date:   Fri, 15 Jul 2022 01:55:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: Fix repeated minus operation
Message-ID: <YtC65m42qMdOqSzT@ZenIV>
References: <1657707820-124858-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657707820-124858-1-git-send-email-liuxp11@chinatelecom.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 06:23:40PM +0800, Liu Xinpeng wrote:
> After executing command 'cat /proc/cpuinfo', got a message:
> 
> [    6.909745] ------------[ cut here ]------------
> [    6.910267] WARNING: CPU: 0 PID: 76 at lib/iov_iter.c:1026
> iov_iter_pipe+0x34/0x40
> [    6.910951] Modules linked in:
> [    6.911584] CPU: 0 PID: 76 Comm: cat Not tainted 5.19.0-rc6-next-20220711 #9
> [    6.911916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [    6.912668] RIP: 0010:iov_iter_pipe+0x34/0x40
> [    6.913062] Code: 72 54 39 72 5c 76 23 48 c7 07 00 00 00 00 48 c7 47 08 00 00
> 00 00 c6 07 03 48 89 4f 10 48 89 57 18 89 47 20 89 47 24 c3 0f 0b <0f> 7
> [    6.914341] RSP: 0018:ffffc900001c7d48 EFLAGS: 00000246
> [    6.914647] RAX: 0000000000000010 RBX: ffff888004988700 RCX: 0000000000000000
> [    6.914893] RDX: ffff88800490bc00 RSI: 0000000000000010 RDI: ffffc900001c7d58
> [    6.915302] RBP: ffffc900001c7e00 R08: 0000000000000000 R09: ffff888004cafad8
> [    6.915609] R10: 0000000000020000 R11: 0000000000001000 R12: ffff88800490bc00
> [    6.915856] R13: ffffc900001c7e48 R14: 00000000000002d5 R15: ffff88800490bc00
> [    6.916352] FS:  00000000016df8c0(0000) GS:ffff88800f600000(0000)
> 
> Checking the code, need to delete the duplicate minus in a loop.

Nice catch.  Fix folded in...
