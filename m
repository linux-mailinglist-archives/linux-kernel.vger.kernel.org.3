Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB4500B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiDNKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiDNKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DD6FA2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so9178120ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkswkCkzkfuTkcC/MPeEn0SGFUoxOD74D06SLg3Ufn0=;
        b=iWlnSum74zWq9k1VdmcjywmgcKKEeTiTo4Edj/3kWQ3mphEoEhp54slxtjXphSS4Ux
         Tpk8EmwCVTNLptsx6NjCrpCHDZNQ6jSd3E0+BxBZKWJAwwAyueP/wF6bVeJ4QWImzNJh
         mXraTy9ukq5tEigcDXYUDA4mmw6GMy68jysVh/0OJL6KTe0dJ4TtmnPgAUDzqLclV2ed
         giaDgrGU8qvaCkc+qfCzSWTPLexpbph+DQdzOg2D0ZPkMl8lYFBT0J6y08Bp42oBp0jz
         S/ArhcDel9UqRBcFQMtELR3H72iCq16zeHJhOqrC+G4idVxp8wD/7MtPIlh64Q+YLcOS
         cN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkswkCkzkfuTkcC/MPeEn0SGFUoxOD74D06SLg3Ufn0=;
        b=fzlL3PkD9He3w5KqMa0Q4bdU9QGObDapXDtuMEY/gsNriAUSMIEnkAkiYThTKO2j7n
         XKMGGdupitmxVCi2EpVS/jG9Mcm5s4b6XH994dpklFy+Thv+qnDa2CHqYVTfli/FzzKW
         DWevcYHTchayDcx+GQcODm4CcYdKSyLSJCpIrO8MVDD7AY6VM5eYWYOKkmile68L/mlf
         BdDoWrOi3C4b/OpHiOxa1AlNarrSKmGzSTm59jbt8HcXU8XJKH+SLnhmcIP6Bn1OT+vq
         EWnx4TSwGTU92lD7M5MLQGfEsHDtojvvOTZZBUxsx5EmsElP3rmMer3igPkw+sEkjphd
         qBEQ==
X-Gm-Message-State: AOAM53021LHMAejr49/b84YZ8j+wCYtMJqw0o4Ii+Ho/bq8QaLViEqnC
        9ieMK6PgimSjwTveP6dYHIY=
X-Google-Smtp-Source: ABdhPJwSuPzquu8kUAxNyiwAm9/xkpxEyLKBIK+2FStPtDiTfsFEn7Q5tANPnti58aaRIauri31amA==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr1728945ejn.437.1649933032340;
        Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/8] staging: r8188eu: check firmware header existence before access
Date:   Thu, 14 Apr 2022 12:43:22 +0200
Message-Id: <20220414104323.6152-8-straube.linux@gmail.com>
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

We should access the fields of fwhdr only if the check for firmware
header existence is true. Move the affected code into the if block
that checks firmware header existence.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 64963507a346..c58bce1a1856 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -249,14 +249,13 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fw_data = dvobj->firmware.data;
 	fw_size = dvobj->firmware.size;
 
-	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-		DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-		le16_to_cpu(fwhdr->signature));
-
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
+		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+			le16_to_cpu(fwhdr->signature));
+
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
 		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
-- 
2.35.1

