Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9BB56CAD7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGIRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGIRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:27 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB5412093
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:25 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyI-0005n0-6i; Sat, 09 Jul 2022 19:10:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/14] staging: r8188eu: _offset is always 0 in efuse_phymap_to_logical
Date:   Sat,  9 Jul 2022 19:09:58 +0200
Message-Id: <20220709171000.180481-13-martin@kaiser.cx>
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

The _offset parameter of iol_read_efuse is always 0. Remove the
parameter and use 0 in the function body.

We can now replace the bytewise copy from efuseTbl to pbuf with memcpy.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f552b9adece3..87ebfb013193 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -83,7 +83,7 @@ static s32 iol_InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 }
 
 static void
-efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
+efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 {
 	u8 *efuseTbl = NULL;
 	u8 rtemp8;
@@ -188,8 +188,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	/*  */
 	/*  4. Copy from Efuse map to output pointer memory!!! */
 	/*  */
-	for (i = 0; i < _size_byte; i++)
-		pbuf[i] = efuseTbl[_offset + i];
+	memcpy(pbuf, efuseTbl, _size_byte);
 
 	/*  */
 	/*  5. Calculate Efuse utilization. */
@@ -311,7 +310,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u16 size_byte, u8 *logical_m
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 	if (status == _SUCCESS)
 		efuse_read_phymap_from_txpktbuf(padapter, 0, physical_map, &size);
-	efuse_phymap_to_logical(physical_map, 0, size_byte, logical_map);
+	efuse_phymap_to_logical(physical_map, size_byte, logical_map);
 	return status;
 }
 
-- 
2.30.2

