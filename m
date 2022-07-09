Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B056CACB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiGIRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGIRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF312749
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:28 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyJ-0005n0-SW; Sat, 09 Jul 2022 19:10:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 14/14] staging: r8188eu: the bcnhead parameter is always 0
Date:   Sat,  9 Jul 2022 19:10:00 +0200
Message-Id: <20220709171000.180481-15-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220709171000.180481-1-martin@kaiser.cx>
References: <20220709171000.180481-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of efuse_read_phymap_from_txpktbuf sets bcnhead to 0.
Remove this function parameter and simplify the function body.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ddda3f994fa7..fe477438899e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -193,13 +193,11 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 /* FIXME: add error handling in callers */
 static int efuse_read_phymap_from_txpktbuf(
 	struct adapter  *adapter,
-	int bcnhead,	/* beacon head, where FW store len(2-byte) and efuse physical map. */
 	u8 *content,	/* buffer to store efuse physical map */
 	u16 *size	/* for efuse content: the max byte to read. will update to byte read */
 	)
 {
 	unsigned long timeout;
-	u16 dbg_addr = 0;
 	__le32 lo32 = 0, hi32 = 0;
 	u16 len = 0, count = 0;
 	int i = 0, res;
@@ -208,20 +206,10 @@ static int efuse_read_phymap_from_txpktbuf(
 	u8 *pos = content;
 	u32 reg32;
 
-	if (bcnhead < 0) { /* if not valid */
-		res = rtw_read8(adapter, REG_TDECTRL + 1, &reg);
-		if (res)
-			return res;
-
-		bcnhead = reg;
-	}
-
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 
-	dbg_addr = bcnhead * 128 / 8; /* 8-bytes addressing */
-
 	while (1) {
-		rtw_write16(adapter, REG_PKTBUF_DBG_ADDR, dbg_addr + i);
+		rtw_write16(adapter, REG_PKTBUF_DBG_ADDR, i);
 
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		timeout = jiffies + msecs_to_jiffies(1000);
@@ -300,7 +288,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u16 size_byte, u8 *logical_m
 	rtw_write8(padapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 	if (status == _SUCCESS)
-		efuse_read_phymap_from_txpktbuf(padapter, 0, physical_map, &size);
+		efuse_read_phymap_from_txpktbuf(padapter, physical_map, &size);
 	efuse_phymap_to_logical(physical_map, size_byte, logical_map);
 	return status;
 }
-- 
2.30.2

