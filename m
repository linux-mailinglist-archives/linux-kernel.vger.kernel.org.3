Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF84FE85A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358871AbiDLTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358808AbiDLTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953C49CBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so39197628ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMAct/S8PjX9QPpz0Ylic0owxKculFndXWjJh1Wp6MA=;
        b=D45J6e1pF1z1CQu/h0fcwxA/V3UGywEx3PmOrTzAFdcgyPnHrkMofGu9jBLwnFIhKl
         qIbQXdZu9bt7yU2jlVwd5O2nFhxTtRnwUBUMP6nZzoRVUgOFfDXlq5uAUOeS8rCl8ZqO
         VtEpV4Cr6+USSVICKIFEYFgvcRQlZTHsiSvvKM0rsntua3Zw9II1mGWrSlidtgTXisDi
         KKNsurhDuwAHD8CbMhvjWTGugCfKj249RnTThHr7z2emuTQFN9LflrXPmvunjSgfXaKI
         fJgXAQHoDt5sLWrQAZcWsbnibDZXXnn8qrFKLtLO9V/MrpjLaCAZQC9PFybTfLjFO2Y1
         GRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMAct/S8PjX9QPpz0Ylic0owxKculFndXWjJh1Wp6MA=;
        b=cpsVtt+DxPtmFHABHPK0UJVc/rB/dTkaLg/f38PNv6sQUXptfPPBtHKFg3BZJhhh3n
         yy2OlngYVo9frO7I92AcmECw8jbM6mFg5DwhwAjNdae/WJy/DDMQY3vJNiFljEhal/Z+
         Jgxh2aLCWnepxvjUoEId7dEEBgxqpdJoRhClO1ZhOkdRfgYPrSAqDVKpfK0g3IKlPf3O
         PFXEpIFyjriLbR06Pz9op/VBmAdo+jZptnCv6YSEqA7xOOsz3tm9/e1kfapAMpRXCiPv
         hjTP84He6NzDS6mAzO1iTLHq3IKo+OVG3gDipGrfPGmciz9sLsSNGwf6HhjxfKaaCTE+
         lhPg==
X-Gm-Message-State: AOAM531kAZHPc7Iy2qt3mNEdQfjYBJ4RtZUxhu4wmsGEsCdjFSM//pqq
        6ay63qJKDX4wJ+owMoquFGY=
X-Google-Smtp-Source: ABdhPJyUq5S/ZdO2cE9v0nrsQtQMhDmUvC0XzovmvV2ElN2HNG8I3o5UpPmS34ChyfTA6OltKS8qAw==
X-Received: by 2002:a17:907:7ea2:b0:6e8:92eb:3893 with SMTP id qb34-20020a1709077ea200b006e892eb3893mr10359148ejc.350.1649789883136;
        Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: rename parameter of block_write()
Date:   Tue, 12 Apr 2022 20:57:50 +0200
Message-Id: <20220412185754.8695-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412185754.8695-1-straube.linux@gmail.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
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

Rename the parameter buffSize of block_write() to avoid camel case.

buffSize -> size

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 0905384bafc7..5f59acfd8b5d 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -71,7 +71,7 @@ static void fw_download_enable(struct adapter *padapter, bool enable)
 	}
 }
 
-static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
+static int block_write(struct adapter *padapter, void *buffer, u32 size)
 {
 	int ret = _SUCCESS;
 	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
@@ -85,8 +85,8 @@ static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
 	blockSize_p1 = MAX_REG_BLOCK_SIZE;
 
 	/* 3 Phase #1 */
-	blockCount_p1 = buffSize / blockSize_p1;
-	remainSize_p1 = buffSize % blockSize_p1;
+	blockCount_p1 = size / blockSize_p1;
+	remainSize_p1 = size % blockSize_p1;
 
 	for (i = 0; i < blockCount_p1; i++) {
 		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (bufferPtr + i * blockSize_p1));
-- 
2.35.1

