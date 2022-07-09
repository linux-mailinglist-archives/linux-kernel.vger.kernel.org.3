Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4256CACC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiGIRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGIRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499A1A3BB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:27 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyF-0005n0-OR; Sat, 09 Jul 2022 19:10:19 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/14] staging: r8188eu: txpktbuf_bndy is always 0
Date:   Sat,  9 Jul 2022 19:09:55 +0200
Message-Id: <20220709171000.180481-10-martin@kaiser.cx>
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

The only caller of iol_read_efuse sets the txpktbuf_bndy parameter to 0.
Remove the parameter from iol_read_efuse and use 0 in the function body.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0cb653002660..24699e99edff 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -299,18 +299,18 @@ static int efuse_read_phymap_from_txpktbuf(
 	return 0;
 }
 
-static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset, u16 size_byte, u8 *logical_map)
+static s32 iol_read_efuse(struct adapter *padapter, u16 offset, u16 size_byte, u8 *logical_map)
 {
 	s32 status = _FAIL;
 	u8 physical_map[512];
 	u16 size = 512;
 
-	rtw_write8(padapter, REG_TDECTRL + 1, txpktbuf_bndy);
+	rtw_write8(padapter, REG_TDECTRL + 1, 0);
 	memset(physical_map, 0xFF, 512);
 	rtw_write8(padapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 	if (status == _SUCCESS)
-		efuse_read_phymap_from_txpktbuf(padapter, txpktbuf_bndy, physical_map, &size);
+		efuse_read_phymap_from_txpktbuf(padapter, 0, physical_map, &size);
 	efuse_phymap_to_logical(physical_map, offset, size_byte, logical_map);
 	return status;
 }
@@ -538,7 +538,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8
 		rtl8188eu_InitPowerOn(Adapter);
 
 		iol_mode_enable(Adapter, 1);
-		ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
+		ret = iol_read_efuse(Adapter, _offset, _size_byte, pbuf);
 		iol_mode_enable(Adapter, 0);
 
 		if (_SUCCESS == ret)
-- 
2.30.2

