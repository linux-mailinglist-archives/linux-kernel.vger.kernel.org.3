Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167744FA997
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiDIQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbiDIQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:34:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD623F383
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:32:25 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndE0a-0006Rg-S7; Sat, 09 Apr 2022 18:32:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/10] staging: r8188eu: improve timeout handling in rtl8188e_firmware_download
Date:   Sat,  9 Apr 2022 18:32:06 +0200
Message-Id: <20220409163212.241122-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409163212.241122-1-martin@kaiser.cx>
References: <20220409163212.241122-1-martin@kaiser.cx>
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

Use the standard kernel functions to define and check the timeout in
rtl8188e_firmware_download.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 625d186c3647..7a0997b9bac5 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -247,7 +247,7 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 {
 	int ret = _SUCCESS;
 	u8 write_fw_retry = 0;
-	u32 fwdl_start_time;
+	unsigned long fwdl_timeout;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *fwhdr = NULL;
@@ -290,7 +290,7 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	}
 
 	fw_download_enable(padapter, true);
-	fwdl_start_time = jiffies;
+	fwdl_timeout = jiffies + msecs_to_jiffies(500);
 	while (1) {
 		/* reset the FWDL chksum */
 		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
@@ -298,7 +298,7 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 		ret = write_fw(padapter, fw_data, fw_size);
 
 		if (ret == _SUCCESS ||
-		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && write_fw_retry++ >= 3))
+		    (time_after(jiffies, fwdl_timeout) && write_fw_retry++ >= 3))
 			break;
 	}
 	fw_download_enable(padapter, false);
-- 
2.30.2

