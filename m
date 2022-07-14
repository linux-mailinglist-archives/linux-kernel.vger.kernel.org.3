Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DA574C68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiGNLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:46:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9C5A2E2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:46:27 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 24B2622238;
        Thu, 14 Jul 2022 13:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657799185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyZTJmAo73/KD+0kmBp1lm3YUfQV76U2zTjjlCT7XKk=;
        b=ZVhq0w+T6zIY4iYz0A0E59xP4NvgXGWDEeuDuKv0m6Iom2vTeKYkYKk4rebzUs5s6m/eg4
        pERMJLkP5pSTtNgQ2FdFX+iMrFCmKSHFbgp7eicW9+pCHN9Li3swhuMGl1iqlwGRzejCJ9
        7s2XF910sDbUUWK5Z+QlO32abpgXgqw=
From:   Michael Walle <michael@walle.cc>
To:     liuxp11@chinatelecom.cn
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] iov_iter: Fix repeated minus operation
Date:   Thu, 14 Jul 2022 13:46:15 +0200
Message-Id: <20220714114615.3346852-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1657707820-124858-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1657707820-124858-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thanks, I'm getting the same warning and also if you do a cat on any sysfs
file.

> Checking the code, need to delete the duplicate minus in a loop.
>
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Fixes: 3d246b875f31 ("ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives")
Tested-by: Michael Walle <michael@walle.cc>

-michael
