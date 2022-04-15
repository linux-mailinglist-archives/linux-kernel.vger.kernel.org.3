Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9192150296C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353176AbiDOMNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353131AbiDOMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E76BF030
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c64so9703705edf.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KAY162R6REHgBPdBqhvvmTxa6PH0xoKVGSpUfSsZF4=;
        b=KfccGz9UIICu5SzHhnvSz+16pHm5dm8jmnihk9YkYRAv9ABjKX5Gazz1WfqSSk9v5O
         A1ctedVvVu6udB3vCVaj13TreytRJlIxbXtwtEGPbbB/RHTB2jTXOe23E/7b1fVB8CuV
         ix1pAqivV7GdXnruLgK9CECcCuYF4IlOl+K7/mB/vdCM/kSyx/X7lgKNX1JkvUvNlrt8
         Bb1kndCNaRchWyTffvipqMwtMHidL9h4HIZM3NWgnpBPJg/QXuQzcxTrKfNeuF3itN6R
         cgqWvzYo+f7VFzzWctzokrnDTrsB73RVDLRWA2FAQvobepzmpfbRNIUIaTe05tLCztEk
         4Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KAY162R6REHgBPdBqhvvmTxa6PH0xoKVGSpUfSsZF4=;
        b=1HC8zJd3MAQb7/ZlGAdfERVS9fbj+TOHWFqqTFLgRXDL04FHF9TCn14DL5r2GYZBVw
         shjxNqEGkIRLmotTwiUWHSo+MV8PMeGGYYsokroB35AL4IALqX8yETzfI4amz3JOcvAj
         jyD2tvX6D1MdkpWqjyFOEqCLImEJaj97AE+5s0oBb6rWueaqhKO6TcGql/e5HIIQOJ95
         d0yGdcjOfMWQSP58ZkHLnTdVR+xB6EqDXVc01AELdQRC8ozumhtdEaBDCqqpP2n7f0Qr
         7sVaKmuj0uYsxYs4tsjHPzKywsbjT47pjWO6E8LfCtMgKYcAPOCW9579STlFPpcl9Err
         iQbg==
X-Gm-Message-State: AOAM531MgwtGt52NvpNNwPnORbL03GuLCWAx9HruZ/7vZuzezydsO+5y
        j2c8rjQsrpkSepJyUzQ48x4=
X-Google-Smtp-Source: ABdhPJzp+eY7lyQyNnnPvE7g/Fr3nWkXH8WYAEr0BptQnA6xyL/897xBASEi3KHTUZ3eiHKZQ19xag==
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id u8-20020a50a408000000b0041ccdc788bdmr8064984edb.399.1650024640201;
        Fri, 15 Apr 2022 05:10:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 7/8] staging: r8188eu: use pr_info_once() to log the firmware version
Date:   Fri, 15 Apr 2022 14:10:22 +0200
Message-Id: <20220415121023.11564-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415121023.11564-1-straube.linux@gmail.com>
References: <20220415121023.11564-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_info_once() instead of a static variable and an if statement
to log the firmware version only once.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3:
- added back logging the firmware version only once, using
  pr_info_once() instead of a static variable and if statement

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index c102aba099f5..7ee72236c7f4 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -241,7 +241,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct rt_firmware_hdr *fwhdr = NULL;
 	u8 *fw_data;
 	u32 fw_size;
-	static int log_version;
 
 	if (!dvobj->firmware.data)
 		ret = load_firmware(&dvobj->firmware, device);
@@ -255,10 +254,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	if (!log_version++)
-		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-			le16_to_cpu(fwhdr->signature));
+	pr_info_once("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+		     DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+		     le16_to_cpu(fwhdr->signature));
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
-- 
2.35.1

