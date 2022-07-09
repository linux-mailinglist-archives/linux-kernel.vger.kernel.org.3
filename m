Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69256CAD4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGIRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGIRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D138120BA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:28 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyH-0005n0-BG; Sat, 09 Jul 2022 19:10:21 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/14] staging: r8188eu: offset is always 0 in iol_read_efuse
Date:   Sat,  9 Jul 2022 19:09:57 +0200
Message-Id: <20220709171000.180481-12-martin@kaiser.cx>
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

The offset parameter of iol_read_efuse is always 0. Remove the
parameter and use 0 in the function body.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 674ba420a272..f552b9adece3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -299,7 +299,7 @@ static int efuse_read_phymap_from_txpktbuf(
 	return 0;
 }
 
-static s32 iol_read_efuse(struct adapter *padapter, u16 offset, u16 size_byte, u8 *logical_map)
+static s32 iol_read_efuse(struct adapter *padapter, u16 size_byte, u8 *logical_map)
 {
 	s32 status = _FAIL;
 	u8 physical_map[512];
@@ -311,7 +311,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u16 offset, u16 size_byte, u
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 	if (status == _SUCCESS)
 		efuse_read_phymap_from_txpktbuf(padapter, 0, physical_map, &size);
-	efuse_phymap_to_logical(physical_map, offset, size_byte, logical_map);
+	efuse_phymap_to_logical(physical_map, 0, size_byte, logical_map);
 	return status;
 }
 
@@ -538,7 +538,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
 		rtl8188eu_InitPowerOn(Adapter);
 
 		iol_mode_enable(Adapter, 1);
-		ret = iol_read_efuse(Adapter, 0, _size_byte, pbuf);
+		ret = iol_read_efuse(Adapter, _size_byte, pbuf);
 		iol_mode_enable(Adapter, 0);
 
 		if (_SUCCESS == ret)
-- 
2.30.2

