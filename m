Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195F95048B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiDQR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiDQR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9D1115
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so15326599edu.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CAZCfRACh0L5o3iUpdS1aX8z+UWy3lXInDId0V/Oc4=;
        b=P6HUhtYl1uh3h+roOaxgoAowVSYFjUKLpP+tNwbfMmaT9O7ADedH873ebyC/gPrFIG
         RavjhCD3EO7rHHonqHjgXC+m/4rdPrBVHnFjjNx5pKTxLibdwLwHEYtiz7turkWP/iUk
         iTxZR4aC5QThAkLnlcjYA+PPM7wh7KI9VZj4uP+T4lFOndZ+Qt1erM21H/KlJSCiNFdn
         Ty4Ya1xVqmWRbhu+wHL4XZAPpCai2pq6RAiui2kBbaGUu7liQwSu9Frk8obyHCIjsH85
         rHYPSbADLbBhc1Z3umj4ElOTuUk+6ovVwHLkZKcIEY4Opm82svhm7khoYfH5Ool5T3h4
         An0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CAZCfRACh0L5o3iUpdS1aX8z+UWy3lXInDId0V/Oc4=;
        b=aqDZVpo4/Gn1R0HkRlCzXHFRfuyuGSPRdQqHxe1g+gZMIACtwd4jOrph35UsfDKWCX
         ojdYQf19MYnyGVwB/6POalYbVfvvDboxB1uC9AvA1xB0I2asttW3dM/QBDXi8iG4sMBL
         Z2+1Jfy3pbW/WyDeuBsL3H4xTP2lpXj7zcTZEh7yB3BcQa7jB5pMdd3K2at2/+j1kNtV
         6eepYkUaJVsi1RmmJf+Ba0ywXwpFRgHPld0G7CBQ4vhYYxP+He857szExdAQsHwIL6gG
         6AACmCmsOCJ/CHpUL5P/ie+scg4gIl4O+xjDwtibzwOk0R/M6/yRsK6Gdqs4xzpeybJh
         nYiA==
X-Gm-Message-State: AOAM531sGrlw3Uu27707h/yAhoVlwtkgr/Kc6zWd7sFOKNnpfBaoxszm
        Xv2JE4SWgm3lUf0ZvuncawaoUHyShHg=
X-Google-Smtp-Source: ABdhPJx6nU4bE19M11BfvT5Na8Jb8dh8bqyxVsyfIfqyuMkAshwrYU63shKfcHtbPnlgtLi6asbS4Q==
X-Received: by 2002:a05:6402:1b07:b0:41d:7abf:8337 with SMTP id by7-20020a0564021b0700b0041d7abf8337mr8559736edb.185.1650218093803;
        Sun, 17 Apr 2022 10:54:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 8/8] staging: r8188eu: check firmware header existence before access
Date:   Sun, 17 Apr 2022 19:54:41 +0200
Message-Id: <20220417175441.13830-9-straube.linux@gmail.com>
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

We should access the fields of fwhdr only if the check for firmware
header existence is true. Move the affected code into the if block
that checks firmware header existence.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- no real changes,
  just the pr_info() -> pr_info_once() from patch 7/8 is different

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 7c0653bb3bbc..bf077876ed3d 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -256,14 +256,13 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fw_data = dvobj->firmware.data;
 	fw_size = dvobj->firmware.size;
 
-	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	pr_info_once("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-		     DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-		     le16_to_cpu(fwhdr->signature));
-
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
+		pr_info_once("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+			     DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+			     le16_to_cpu(fwhdr->signature));
+
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
 		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
-- 
2.35.1

