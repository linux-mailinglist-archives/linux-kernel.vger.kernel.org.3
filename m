Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E24D66DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbiCKQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347672AbiCKQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:54:48 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7FADD7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:53:43 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a0a6:d8d9:ef56:e074])
        by albert.telenet-ops.be with bizsmtp
        id 54te270051w1Cbs064tedd; Fri, 11 Mar 2022 17:53:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nSiWH-003aRp-Oc; Fri, 11 Mar 2022 17:53:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nSiWH-009rYw-2i; Fri, 11 Mar 2022 17:53:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Lad@rox.of.borg,
        Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RFC] memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual mode
Date:   Fri, 11 Mar 2022 17:53:32 +0100
Message-Id: <27107f2d578b198078df841ee2e4d7b71b183898.1647017136.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HyperFlash devices fail to probe:

    rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

In HyperFLASH or Octal-SPI Flash mode, the Transfer Data Enable bits
(SPIDE) in the Manual Mode Enable Setting Register (SMENR) are derived
from half of the transfer size, cfr. the rpcif_bits_set() helper
function.

Hence when converting back from Transfer Data Enable bits to transfer
size, the bus width must be taken into account, and all Manual Mode Data
Register access sizes must be doubled when communicating with a
HyperFLASH or Octal-SPI Flash device.

Fixes: fff53a551db50f5e ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Marked RFC, a (1) we should avoid the back-and-forth conversion between
transfer size and Transfer Data Enable bits, and (2) actual HyperFlash
data reads (which follows a completely different code path) still return
all zeros.

On Salvator-XS with unlocked HyperFlash, the HyperFlash is now detected
again, cfr. (with DEBUG_CFI enabled):

    Number of erase regions: 1
    Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
    Primary Algorithm Table at 0040
    Alternative Vendor Command Set: 0000 (None)
    No Alternate Algorithm Table
    Vcc Minimum:  1.7 V
    Vcc Maximum:  1.9 V
    No Vpp line
    Typical byte/word write timeout: 512 \xc2\xb5s
    Maximum byte/word write timeout: 2048 \xc2\xb5s
    Typical full buffer write timeout: 512 \xc2\xb5s
    Maximum full buffer write timeout: 2048 \xc2\xb5s
    Typical block erase timeout: 1024 ms
    Maximum block erase timeout: 4096 ms
    Typical chip erase timeout: 262144 ms
    Maximum chip erase timeout: 1048576 ms
    Device size: 0x4000000 bytes (64 MiB)
    Flash Device Interface description: 0x0000
      - x8-only asynchronous interface
    Max. bytes in buffer write: 0x200
    Number of Erase Block Regions: 1
      Erase Region #0: BlockSize 0x40000 bytes, 256 blocks
    rpc-if-hyperflash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000001 Chip ID 0x007000
    Amd/Fujitsu Extended Query Table at 0x0040
      Amd/Fujitsu Extended Query version 1.5.
    rpc-if-hyperflash: CFI contains unrecognised boot bank location (0). Assuming bottom.
    number of CFI chips: 1

At first, the failure looked like an endianness-issue, as reading two
bytes resulted in e.g. 0x51 0x00 instead of 0x00 0x51.  But it turned
out to be reading a single 8-bit value of 0x51 instead of a 16-bit value
of 0x5100.

Note that commit 0d37f69cacb33435 ("memory: renesas-rpc-if: Correct QSPI
data transfer in Manual mode") in the BSP does not suffer from this bug,
as it bases its decision on the real number of bytes to transfer, not on
the SMENR.SPIDE register bits.
---
 drivers/memory/renesas-rpc-if.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 3fbdd2bb8bfdb6ec..9bf880f843437dc2 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -175,10 +175,16 @@ static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
 
 		if (spide == 0x8) {
-			*val = readb(rpc->base + reg);
+			if (rpc->bus_size == 2)
+				*val = readw(rpc->base + reg);
+			else
+				*val = readb(rpc->base + reg);
 			return 0;
 		} else if (spide == 0xC) {
-			*val = readw(rpc->base + reg);
+			if (rpc->bus_size == 2)
+				*val = readl(rpc->base + reg);
+			else
+				*val = readw(rpc->base + reg);
 			return 0;
 		} else if (spide != 0xF) {
 			return -EILSEQ;
@@ -198,10 +204,16 @@ static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
 		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
 
 		if (spide == 0x8) {
-			writeb(val, rpc->base + reg);
+			if (rpc->bus_size == 2)
+				writew(val, rpc->base + reg);
+			else
+				writeb(val, rpc->base + reg);
 			return 0;
 		} else if (spide == 0xC) {
-			writew(val, rpc->base + reg);
+			if (rpc->bus_size == 2)
+				writel(val, rpc->base + reg);
+			else
+				writew(val, rpc->base + reg);
 			return 0;
 		} else if (spide != 0xF) {
 			return -EILSEQ;
-- 
2.25.1

