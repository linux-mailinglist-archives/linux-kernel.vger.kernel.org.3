Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBA5048B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiDQR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiDQR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E62D71
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g18so23490512ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9MDV0/SfYE0g/BRQSyONptj6V2+VN8KUp8JOekp0ChY=;
        b=dNV9jqlDcvOWKoI9yIR6gNroK1LPp2f7YPSy7sxp6ufMs7u6+8ERSPWJ7o4SWo7Dca
         VJF5X9XZakL7ETn2B2fECY3tKAptRbzBPHTTNi+DNP5PU7rFLs1+VRJ7R4edgzQ9AAyc
         Qvbilq/0pXwTjv/AIAeyl/aPh5jJ8oY253uis81SCI+VmXqobrZEK39LxIRgYWAHCvNK
         qGtbdWi6A/GaOU+dGQcmS6VFLbFktbdJXdHLji0zNq1X+ruyGWj9Q0BdCFGm7oSEN3Sh
         /hrhbUNhTLZ8pVL6CyqqNCL/aWzF8uVjAtL3X4FIpudX/Vf0y59mFXswWIWd1VwSp888
         D7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9MDV0/SfYE0g/BRQSyONptj6V2+VN8KUp8JOekp0ChY=;
        b=2VihkWl1RstB/LmUQW8dd3elmyXrYXzEOsGbFQQZAjbKp1WrG9x9unYUMyvbQXm91o
         Pfqn6m7sSrDwXFyp5JbSUEq3xSv0XnYm9IWcmcrucar9+aked3/KAKn7o5xo+ZK2K/ib
         g3tLTlr/KjR+xKWs8vCNhNRRJtw5RSF2tuhIdcikxX8LNJZehbVWEo4zfyUFp5w+CybZ
         HVqvZ1+d5o2T4SoNPUvESvwO37216mIEyTXBJOxPQM8fOgUXnePbQKQ99sr+exAk9+Ud
         /PLC7WuZEWa6mRn6mmKUDKHmng45LfCfQiNJGDPkX8O6GjQUAQLLdMlKGS7I1j/vBp4h
         wEpg==
X-Gm-Message-State: AOAM530wjxT6tQlo7QpiTmoMO1WYsvqAf1ng0UaaCIMKCOCTMUkTpseR
        zOjN345aeqscCH74fLjFkQs=
X-Google-Smtp-Source: ABdhPJz9wj2GiUC4EiQUAWFDal6IptWIYB4nGu0JskCND41prKDeVnyt02JT+o235OQIcosEHNbnBA==
X-Received: by 2002:a17:906:5006:b0:6ce:3762:c72e with SMTP id s6-20020a170906500600b006ce3762c72emr6396051ejj.30.1650218093041;
        Sun, 17 Apr 2022 10:54:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 7/8] staging: r8188eu: use pr_info_once() to log the firmware version
Date:   Sun, 17 Apr 2022 19:54:40 +0200
Message-Id: <20220417175441.13830-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
References: <20220417175441.13830-1-straube.linux@gmail.com>
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
v4:
- no chages

v3:
- added back logging the firmware version only once, using
  pr_info_once() instead of a static variable and if statement

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 7fa985cc787a..7c0653bb3bbc 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -246,7 +246,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct rt_firmware_hdr *fwhdr = NULL;
 	u8 *fw_data;
 	u32 fw_size;
-	static int log_version;
 
 	if (!dvobj->firmware.data)
 		ret = load_firmware(&dvobj->firmware, device);
@@ -260,10 +259,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
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

