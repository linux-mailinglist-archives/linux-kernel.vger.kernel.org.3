Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B235749A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiGNJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiGNJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:51:54 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0F201C131
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:51:52 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:46016.629183404
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 7337328008B;
        Thu, 14 Jul 2022 17:51:46 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 67b370444c964ef1ac82f61b4102a6d5 for sfr@canb.auug.org.au;
        Thu, 14 Jul 2022 17:51:48 CST
X-Transaction-ID: 67b370444c964ef1ac82f61b4102a6d5
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH linux-next] iov_iter: Fix repeated minus operation
Date:   Thu, 14 Jul 2022 17:51:34 +0800
Message-Id: <1657792294-56244-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After executing command 'cat /proc/cpuinfo', got a message:

[    6.909745] ------------[ cut here ]------------
[    6.910267] WARNING: CPU: 0 PID: 76 at lib/iov_iter.c:1026
iov_iter_pipe+0x34/0x40
[    6.910951] Modules linked in:
[    6.911584] CPU: 0 PID: 76 Comm: cat Not tainted 5.19.0-rc6-next-20220711 #9
[    6.911916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    6.912668] RIP: 0010:iov_iter_pipe+0x34/0x40
[    6.913062] Code: 72 54 39 72 5c 76 23 48 c7 07 00 00 00 00 48 c7 47 08 00 00
00 00 c6 07 03 48 89 4f 10 48 89 57 18 89 47 20 89 47 24 c3 0f 0b <0f> 7
[    6.914341] RSP: 0018:ffffc900001c7d48 EFLAGS: 00000246
[    6.914647] RAX: 0000000000000010 RBX: ffff888004988700 RCX: 0000000000000000
[    6.914893] RDX: ffff88800490bc00 RSI: 0000000000000010 RDI: ffffc900001c7d58
[    6.915302] RBP: ffffc900001c7e00 R08: 0000000000000000 R09: ffff888004cafad8
[    6.915609] R10: 0000000000020000 R11: 0000000000001000 R12: ffff88800490bc00
[    6.915856] R13: ffffc900001c7e48 R14: 00000000000002d5 R15: ffff88800490bc00
[    6.916352] FS:  00000000016df8c0(0000) GS:ffff88800f600000(0000)

Checking the code, need to delete the duplicate minus in a loop.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 lib/iov_iter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a3451e..642841ce 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -472,7 +472,6 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 			break;
 		memcpy_to_page(page, off, addr, chunk);
 		addr += chunk;
-		n -= chunk;
 	}
 	return bytes;
 }
-- 
1.8.3.1

