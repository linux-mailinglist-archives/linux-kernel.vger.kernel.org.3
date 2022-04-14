Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB56350088B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiDNImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiDNIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83665158
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t11so8615588eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMcu7zgQS9k0Bz6hvTLZm8qcxNG9rHsrt5l+a1uteew=;
        b=HxxLqMTpDnGghlOJCrI6VO3kHrRfInik98yusjKYaUCi3PDZAzBVo7Cmyqj9l/M9vI
         eM7XVIgzkTlb8JUdACCp03XO2lX9kUsMcyJ8o1ENHF07lM6tKA9RsQkHi+3Y/o7gkO1e
         ZIJnoAcz/dnvPjbMpJaJulo125qo0mTYoh+l06i/zlm9R8BZCRhJuVmV500t7CY/lLUw
         k5pRX/EQAZxPHDsj0Z4l4gXX1OvsRbXQ2FbeH+d+eGjlu/grZkoaNVlpe8MIW+LN3QLX
         RbRcd6/hFa6/KXqubsywYOCC73ogDUtvKdJlnddbohT7ikSZTkLozY+mOb26PZ9BqSyl
         tGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMcu7zgQS9k0Bz6hvTLZm8qcxNG9rHsrt5l+a1uteew=;
        b=Sg27pVkDmVjBNih59u1l58OfKsJC+nScJpYBQ4Hg12A15jJj4MkSKRYZXF0xI2ibr7
         MUIzLydVY4mmEo03TP1F5v4WwEsJ/VDfmQIpVnSSw5xR8XMDAnhHZbf1VfxAyqxRHRUj
         qB74AyHZbd4tp0kpbJ2kC7YhfBiufJsAIOgF7q8k/tweLh5/uC5zyDXI/B5KCbokfgap
         3b+Xtxsf3zj1iT8rJWSMHE3ISsoug3/09Exfuqhh2Ok0n5xQLEFIMnjKHqg9MydSJeoq
         hL3FPbyShKKI/N7+jXc3pC3mseJdalqFfiut+S+wqCkjyyenOIm6ywawih9JMYwFohZn
         d6EQ==
X-Gm-Message-State: AOAM530LQMTo4+YkNWoMT1sXHwD98mLr4hZSy4/HRTL8aT/MnWuv5Xfx
        IrEfQWHPQBwvIAwQjJOv93s=
X-Google-Smtp-Source: ABdhPJx2hyNJ1+jIf+8bbw/F8ew0aElmPrta6mWMlt6UVwiX2Bw7bpuKF5a4nXYSP4kd//T4qqNPXQ==
X-Received: by 2002:a17:907:d90:b0:6eb:557e:91e6 with SMTP id go16-20020a1709070d9000b006eb557e91e6mr1318440ejc.376.1649925552933;
        Thu, 14 Apr 2022 01:39:12 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: remove variables from rtl8188e_firmware_download()
Date:   Thu, 14 Apr 2022 10:38:51 +0200
Message-Id: <20220414083853.3422-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414083853.3422-1-straube.linux@gmail.com>
References: <20220414083853.3422-1-straube.linux@gmail.com>
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

The local variables fw_version, fw_subversion, fw_signature in
rtl8188e_firmware_download() are only used in one place. Use the
assigned values directly and remove the variables to make the code
shorter and cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 94526064f29b..cbc4980bd938 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -237,7 +237,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *fwhdr = NULL;
-	u16 fw_version, fw_subversion, fw_signature;
 	u8 *fw_data;
 	u32 fw_size;
 	static int log_version;
@@ -254,13 +253,10 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	fw_version = le16_to_cpu(fwhdr->version);
-	fw_subversion = fwhdr->subversion;
-	fw_signature = le16_to_cpu(fwhdr->signature);
-
 	if (!log_version++)
 		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
+			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+			le16_to_cpu(fwhdr->signature));
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
-- 
2.35.1

