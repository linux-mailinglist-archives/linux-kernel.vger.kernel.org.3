Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC9500B62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiDNKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiDNKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DF6FA2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t25so5790919edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMcu7zgQS9k0Bz6hvTLZm8qcxNG9rHsrt5l+a1uteew=;
        b=owKXAll23qDyqfo0QPXWSi6YM2YVa3BJCIc6zCarnqr1bxlbxBIHIcuTsDXNO7AXTY
         JMzA8cAcsb92yA9yn5mnNvwoAucOL94HWDzJBgfuJ6lyU9oSekQkwNSq1Dewe60BkKtD
         1UJUSqy9rbGNvD1WaUU1Sjfqgt5Qthp4UAfLp9yWgk0GmAjedZ8kTC5vkYSWihKiUjsv
         P2iEA0tT9odaJQqe/6kMyY77vdJGPSc+fkYqkN0g7KkCrH22rgqU6Cffs3dEtAwrSHj/
         H0z4Oclyz9sDlEz58wu/9+io5GvaqbCjNIM2si6pTMb//L6tuLUKdI/57PhUbP8IL1hE
         wcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMcu7zgQS9k0Bz6hvTLZm8qcxNG9rHsrt5l+a1uteew=;
        b=BQeKtZ3IIg6WHXMWVL8U0BUql1zYYZ7hTn9VfaoLSRCjEYqzdSsPzHFFZ304Wmmtjt
         rQuyXmZwOh82KMIhT3yoV05kilb6cx9UkBl8NvwCzUX4H6Yq2VYNeezQPT5TteM8nT0a
         8vJvRWTjhe6enZr7Li7HVAc3WAyysaLYWrYlReGCOSPslmuQLne8H3c04A7Q1ag4giRy
         KstDohO5f8Y+NGITQOfwd9m5XSwOyXXL6ZItV8J8l0BtWfdLlkY22SKbrq9fX8NkP8uq
         o5yzrx3paUtd5gCBIqEihfNlX1spwh5N3fS8fqQ9KtRF6t2wrp74t+gw64AR4wXx07Ag
         7T5A==
X-Gm-Message-State: AOAM531IChLLYz3ByqW/uDfnhp5GB7yKt6zsuXPmyx/vvSHHECsGFbAR
        MyFzG4iptzbmyQgdOeVhzyM=
X-Google-Smtp-Source: ABdhPJwH3JmT4QONevs0qREw8ct63mE8YvnUqehS0MI05unk99lQFWNO6+xk90GjMwWJvw0mGY30+w==
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr2211955edu.385.1649933030803;
        Thu, 14 Apr 2022 03:43:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/8] staging: r8188eu: remove variables from rtl8188e_firmware_download()
Date:   Thu, 14 Apr 2022 12:43:20 +0200
Message-Id: <20220414104323.6152-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
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

