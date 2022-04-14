Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03C50088E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiDNImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbiDNIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAA6515D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so8660902ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqSU6uGvzefM7JqsLVkp47vheVpreBM8RRaia816jV8=;
        b=fJxEecFFxrOn0EueDfzfdFYNkDi7VyjFuEqZA68NnzPDC5IOQ4sffH4hGLLmq+v6JF
         bD2CrcrYFhseb01NvTx9njFY+1/vVGY8a4gcV33l7BgBHnH77viHZowL9By7aO7rRWxx
         SSFAqSdbLT490hWUKaUMDqIiRsYj/FIW8+98fPf5xE5Pf18m7B85JkUPuKFOxE1X7Oq0
         mKQEaQD4TFRaH5nZpv8RgQD/1bZfuXOIbZFoIMXcL7jtIhNyIDghw2Ndf8y14DNxvunv
         VqmejS60wgWOrpaEOLBXXX6JG2g+qOIDthLzSnWeVMhSFQEmvMYREiArRbS/EVYbfyA0
         8G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqSU6uGvzefM7JqsLVkp47vheVpreBM8RRaia816jV8=;
        b=3OV1i4URDHW8RCzQALlc8gFJhCo+7HiaaR1bv4PboAF9f1Fhkp72ruTLVGwiy6Ulws
         ObWu8v1xoeLJfbCO9Q1a9ZUcXHw1jCsUf8VDaL8qJEENPMISZd5yYKRXGO+Gq7VS4PiH
         lQ83zS5DLIqVMXDWIL6I1sQaSi0o2Ip2NAa5ftNa8JHePPWkddwXmwyoi7y4w4HJ5pfT
         P9cqhN3pfsAXO3RIPYmyJI7xLbJx1HeybfqvXSMrSC1MMB6KUZpRuG7EcCGGyR0GH74B
         UmDDlaE3YBXe6hvzy2OIfuaRNTp/n1AGm/EBwwF0RHJU9bR2tD4G8VwvFiFhVY7vhEsY
         yqlA==
X-Gm-Message-State: AOAM531c6/0hJXlR4CgDErSdloX8iEQoR9Qb2VVsMgQsQIFVqEltq64o
        BaeT+L2oNVVwxAwWj5DKXq8=
X-Google-Smtp-Source: ABdhPJwpaGNjqIdCer8Ui1XN0n5nWE6nuXkwc31+cYETm/IFNZdI5z9zF3n+PWmvD1dljt9eHeVfCg==
X-Received: by 2002:a17:906:c091:b0:6db:62b6:f4cc with SMTP id f17-20020a170906c09100b006db62b6f4ccmr1413652ejz.607.1649925553721;
        Thu, 14 Apr 2022 01:39:13 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: always log firmware info
Date:   Thu, 14 Apr 2022 10:38:52 +0200
Message-Id: <20220414083853.3422-7-straube.linux@gmail.com>
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

The local static variable log_version prevents logging the firmware
information more than once, e.g. when the device is unplugged and
plugged again. That is not necessary and complicates the code. Remove
it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index cbc4980bd938..64963507a346 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -239,7 +239,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct rt_firmware_hdr *fwhdr = NULL;
 	u8 *fw_data;
 	u32 fw_size;
-	static int log_version;
 
 	if (!dvobj->firmware.data)
 		ret = load_firmware(&dvobj->firmware, device);
@@ -253,10 +252,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	if (!log_version++)
-		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-			le16_to_cpu(fwhdr->signature));
+	pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+		DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+		le16_to_cpu(fwhdr->signature));
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
-- 
2.35.1

