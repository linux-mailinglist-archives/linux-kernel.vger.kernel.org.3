Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2652EE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbiETOcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350304AbiETOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:32:40 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425561737D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:32:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:bcf5:9b9d:233f:7ad])
        by andre.telenet-ops.be with bizsmtp
        id Z2YZ2700V22kPzA012YZ77; Fri, 20 May 2022 16:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ns3g9-0010pW-6i; Fri, 20 May 2022 16:32:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ns3g8-00Bj4b-OK; Fri, 20 May 2022 16:32:32 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] m68k: atari: Make Atari ROM port I/O write macros return void
Date:   Fri, 20 May 2022 16:32:30 +0200
Message-Id: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros implementing Atari ROM port I/O writes do not cast away their
output, unlike similar implementations for other I/O buses.
When they are combined using conditional expressions in the definitions of
outb() and friends, this triggers sparse warnings like:

    drivers/net/appletalk/cops.c:382:17: error: incompatible types in conditional expression (different base types):
    drivers/net/appletalk/cops.c:382:17:    unsigned char
    drivers/net/appletalk/cops.c:382:17:    void

Fix this by adding casts to "void".

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Survived m68k/allmodconfig.
To be queued in the m68k tree for v5.19.

Removing the casts instead causes issues with functions propagating void
return values (return expression in void function), which BTW sparse
complains about, too.
---
 arch/m68k/include/asm/raw_io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/raw_io.h b/arch/m68k/include/asm/raw_io.h
index 80eb2396d01ebf61..3ba40bc1dfaa9471 100644
--- a/arch/m68k/include/asm/raw_io.h
+++ b/arch/m68k/include/asm/raw_io.h
@@ -80,14 +80,14 @@
 	({ u16 __v = le16_to_cpu(*(__force volatile u16 *) (addr)); __v; })
 
 #define rom_out_8(addr, b)	\
-	({u8 __maybe_unused __w, __v = (b);  u32 _addr = ((u32) (addr)); \
+	(void)({u8 __maybe_unused __w, __v = (b);  u32 _addr = ((u32) (addr)); \
 	__w = ((*(__force volatile u8 *)  ((_addr | 0x10000) + (__v<<1)))); })
 #define rom_out_be16(addr, w)	\
-	({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
+	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
 	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v & 0xFF)<<1)))); \
 	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v >> 8)<<1)))); })
 #define rom_out_le16(addr, w)	\
-	({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
+	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
 	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
 	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v & 0xFF)<<1)))); })
 
-- 
2.25.1

