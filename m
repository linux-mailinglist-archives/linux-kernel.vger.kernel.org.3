Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493AE50296B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353166AbiDOMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353126AbiDOMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F9BF021
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u18so9737874eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIzdnXqq8wGLmGwxNERvkoiK7wlULE8JtNhbbdlQcXU=;
        b=AhZkde2UDiS6UAXvRn0HZ6uJDRpn0vfl8QQd12Hfwe7oU9pGBHHce640fZjHAMRORy
         9KOrxP0tjpZTzpw+0d3JlaFy/jI/1GSXxztGSGUFivq3dlP0oS60vxeI5TaKRL8TrOmY
         4j3+fKRNWTFy+0h/44cxsg/FbQ8QoKkTSsVoLyBiDZBAvF3BOqsMyQ4t9Dtr5Ohpuxd1
         Sm3wrar3z/aOrBSz3QV3BQczvUVQTh8jfi6M2hPbT8vUZ0ix3e0/YUlcZjMpWTJz7QYK
         xUAlEGpjc946/wF9mxly3nSoDh1qSPTukAMHJU8lsdZrbEWcEYsN4drC6BB0I7R7DXBl
         Glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIzdnXqq8wGLmGwxNERvkoiK7wlULE8JtNhbbdlQcXU=;
        b=Tz/bA87vYbpQH9IbLiJEt8bATkekpee3qN8eyeGIYCm3pDkGuD887Cl7PooVT6H7Uc
         TDtFe+K02602PTeQTz1/6iAV7XxJ3FswAGdj2yH28al0jUXa41G1GRFTNeOTTAEMjPEh
         d4Dh17EZIoEt1/uJNrV2YsXQe9+s4r5Krde7qYlWhtktGSmtxJ9O+Ctcl2UuITzP6eMS
         xUKI90YTBOmr3l2HIWgAVkIrPDhkgTp8B5ZG14xRO9uZnzkK2UDcuWZR+4P48YhEJDih
         RXflN79X0sJhBzuSCCoLxJKHkr2i9oysg6aXbTNIIcuBgAs92QLlNg+tCdOH30gbhBa3
         qPnA==
X-Gm-Message-State: AOAM530U5gKrxTkKgq/xliyauP7LbHk9vCEbv9QrzUHDbonQMboFXd4+
        Pzm0x/w+878/sHZDGq5l1X0=
X-Google-Smtp-Source: ABdhPJxBzgAc60hojY9aRNWWERHCOl6M0oNxLqNlqslWmJlPsWaCWeT+juQcpPcQkopMEWbEz0enDw==
X-Received: by 2002:a05:6402:ea8:b0:41d:78ca:b929 with SMTP id h40-20020a0564020ea800b0041d78cab929mr7906887eda.289.1650024638617;
        Fri, 15 Apr 2022 05:10:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 5/8] staging: r8188eu: use sizeof instead of hardcoded firmware header size
Date:   Fri, 15 Apr 2022 14:10:20 +0200
Message-Id: <20220415121023.11564-6-straube.linux@gmail.com>
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

Use sizeof() instead of hardcoding the firmware header size and add
a compile time check to ensure struct rt_firmware_hdr has the correct
size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3:
- added the compile time size check from patch 8/8 of v2

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 3da52a1ba23c..0279af37719a 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -34,6 +34,8 @@ struct rt_firmware_hdr {
 	__le32	rsvd5;
 };
 
+static_assert(sizeof(struct rt_firmware_hdr) == 32);
+
 static void fw_download_enable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
@@ -263,9 +265,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		/*  Shift 32 bytes for FW header */
-		fw_data = fw_data + 32;
-		fw_size = fw_size - 32;
+		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
+		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
-- 
2.35.1

