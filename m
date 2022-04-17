Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214045048AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiDQR57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiDQR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940575FAF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t11so23482384eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hjkhnlwJyVMU2AUpWHdvtIxfINbruD73WC12kbTecg=;
        b=onnNgsfGHFMQxV97R5b5CO0cwjKjy0A3+ZYtLhVYhbEWbgJRw+NLdfmH82ZO42k8Q5
         LZAzbTed4Ik3QmRe3eVUZ03nPBH2iuVx5fxhA5dxRGffZ+Fo+9RC8t8fdCx8Bs0P7RBk
         5tXwSuZzod78rX1A4815G7+jgEr04KWI0LBc7VECrE0h/i8C+XUuYLyO59YHC/e39MHn
         sdskRDvwVvdyqJGSMCJ2RPa9p2DYKzn7yd5ijTzdQ+QcYHjWVtWT0HlHGBtQvfQxKg/x
         pRLj8tgZOvU7tVu88qBWV8wL7g7gRZ7Znz+RlBWCzxX0Mb8Fg04SyFw5M3gF+IxwPoNl
         wQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hjkhnlwJyVMU2AUpWHdvtIxfINbruD73WC12kbTecg=;
        b=7whiPmeTvr67gQi6swGECqZStys3v24etdAHGATiFAWfocoHEl6TRGFVg57xF3KBYi
         9QlZINS7S0yl4bL4lTjGjx72oBByhvRoiv1a8GyDb073B/8OJoT+Bulc+PL6hPlVgsRH
         EN6pqe/QfCWkTaWSlCvD6+1yfkiddVn90/zerSIPF0tRa/Fy2B22o0f/mFYVkVrzmfI/
         lhjr1Yjm9UTFX2TPtkWGXy0ON5BOJ1lXEITKr+pWToMpqg85Reg7+v0TcXuYvbnksr7l
         gP31iXr62juajpFh42Giazut74V6rA+4NH9NJbUeRo0DmrGWcL8XIhdHTn3cPU+iDuVf
         LPNQ==
X-Gm-Message-State: AOAM532xLisBi2gx2SlY9QF4rGVUnxQIxyjJuoORuDghXp73IXRF90Kw
        nuXxsKKFfUmv4W4EUaMZ9+FZznW79FQ=
X-Google-Smtp-Source: ABdhPJwRE4TM2Uv9ctJx+uZMtaGNyIBc2VTQiW7EV36qn4EQMF9318gtirSKRpsvEkNiXUdfw3k4lQ==
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id r11-20020a170906280b00b006cef3c7688fmr6248610ejc.468.1650218092200;
        Sun, 17 Apr 2022 10:54:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 6/8] staging: r8188eu: remove variables from rtl8188e_firmware_download()
Date:   Sun, 17 Apr 2022 19:54:39 +0200
Message-Id: <20220417175441.13830-7-straube.linux@gmail.com>
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

The local variables fw_version, fw_subversion, fw_signature in
rtl8188e_firmware_download() are only used in one place. Use the
assigned values directly and remove the variables to make the code
shorter and cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- no changes

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 42b36505cf8b..7fa985cc787a 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -244,7 +244,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *fwhdr = NULL;
-	u16 fw_version, fw_subversion, fw_signature;
 	u8 *fw_data;
 	u32 fw_size;
 	static int log_version;
@@ -261,13 +260,10 @@ int rtl8188e_firmware_download(struct adapter *padapter)
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

