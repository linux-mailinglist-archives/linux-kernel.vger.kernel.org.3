Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B4502972
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbiDOMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353128AbiDOMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28ABF500
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s25so9261383edi.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTYVhYWSzKwAMLeflfz6kIIWiCkCWj7eP186JTpFtoA=;
        b=PJOu5zElcuDrXbf8hOAmTWjYyGseIHiqbrS+V1b1DpzwvELip1pxqjJ2BBTGc5b6gk
         ZS98OfOE7wopGOwS+nJtU4kKPv7DswCCoCjXjJjn2/ao9p+uELfGyxwv/GcMPdYbMb4T
         gfuivYBzfkasFoKkrjOH+UIUjQWKmJeFOWMgA4EIapT8qip+x+W2MM4/uuDVXIKkARCe
         JWCh+eRl/dl7Kt8ilUx+dLt90BpuqjugRDom87xVrLhV4irL71lH3ijBCFTII8Hb54NL
         W0cO0H4OLprKcBsMwpJQwAIqUNzIqqF1eNNN5cYSAsRknY9OgppSRQZqqVfNO7L3Lc+4
         HzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTYVhYWSzKwAMLeflfz6kIIWiCkCWj7eP186JTpFtoA=;
        b=w5Yuy4TOSXT74FkrvJT6eQageVOVpon8WabXfzkMxmNQTSkQYYE49+VWWDuwZYUXmo
         FuqRBm1XxyRMR4XHB0U0g/0uRP+15gwunJe6PVW5c6HLFeYyCeyCwnje5HY52hnyQvAn
         JODdWEh7EaBG79KR0yhCykcs8jDTjrwOL0+b8iB+8vG11abaIrQkBjwMrs8DH92VfSv1
         +Dq4HNM8Wcyn7HqS0mpUIDRxQItG7kdXZQZSYbWcaruvP/bj3MLaECRftShefuLuPM91
         1GkquJsN+WB+VJ31BfIg1qBOsCtnaILwukfxh1aNf1z+4zCBzC3MSpgjjnu07VrzNFc7
         rsZQ==
X-Gm-Message-State: AOAM531dI3mUNVVnwuKMudrNEr1Uwg9zLhOXiYuJFOCRnWdriTRtRaOf
        WfmSwwQj58xXG+nVVahi3iI=
X-Google-Smtp-Source: ABdhPJyBxROMVGQaY33pMHG3ZmIew8vBTdfu5ydjPsIMpCCQdAArrdXf5H9QMfZFDzqXHIYOOU+vmg==
X-Received: by 2002:a50:fc89:0:b0:41d:83d1:9df3 with SMTP id f9-20020a50fc89000000b0041d83d19df3mr7811095edq.19.1650024639443;
        Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 6/8] staging: r8188eu: remove variables from rtl8188e_firmware_download()
Date:   Fri, 15 Apr 2022 14:10:21 +0200
Message-Id: <20220415121023.11564-7-straube.linux@gmail.com>
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

The local variables fw_version, fw_subversion, fw_signature in
rtl8188e_firmware_download() are only used in one place. Use the
assigned values directly and remove the variables to make the code
shorter and cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3:
- no changes

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 0279af37719a..c102aba099f5 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -239,7 +239,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *fwhdr = NULL;
-	u16 fw_version, fw_subversion, fw_signature;
 	u8 *fw_data;
 	u32 fw_size;
 	static int log_version;
@@ -256,13 +255,10 @@ int rtl8188e_firmware_download(struct adapter *padapter)
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

