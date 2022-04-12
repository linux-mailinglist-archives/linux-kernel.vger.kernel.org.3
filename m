Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531C4FE85E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358891AbiDLTBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358819AbiDLTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21734C790
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so39151485ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DvvGyyTAhUrGmw9SU82p+PyQ16OeZEs2v/UZsOf+ig=;
        b=Lf3wBfHlGcpJEIkvlyDzvWIMzmkSxJ72dchDveMBA16ZhoSUGNMV0NDM29nKyVzN+n
         ijRe4lYj8gPUTIfYT9Zzl7CWEwx/NLnnXzM5GgrdJOKwG9xWZbc8hk5qVI7F2r57Bu9l
         jpmIeAkGWXfG90/3Yv5h4gkSQutf4VA8uuSI3pDth0yeglsebHmgl97ZGS+a9M6dsyEV
         eu+99nP2jD4N0n7xu3/hNMWpvkUZEBkNFphmv7pLsnFs+RvIaE2O/Ib+UJDqAapggSgW
         vS+musv03qEkS5/xMjl7nFyRDYupByQPHtHx+cPgg/C+B/cNOQ+4TatGcIfikFzLbF6u
         RBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DvvGyyTAhUrGmw9SU82p+PyQ16OeZEs2v/UZsOf+ig=;
        b=RDizJfIH6E4n9+K8obk2HVv3OVQdz03BYR+LNoleKQFXEQyjuxDCKQbJmrxtEnLLSh
         qQO4xnz3PReB67en8PxwQP8icucH/Owfy0AxpDbnH/gvNOWYyfU9coJgV/07LrPz2bSe
         ZT4DE4d3gF7BluA58h+xFDguMfP3QyQNcuSEBLIM1u3mfia8LQzjFReUiVYoBCPN+iAU
         gFNrTATYoesKZArIEDMcZcfxx1cxKpIOe1E+wU/bDRYwraP83AGJBhndwAg4TjmRc5hK
         AuCcc69pd3W4nOX2GAFmLlLQ4H7RZfzrFVFw/k4KwxXK4hatmxWcOWxnBlazYORNhs2s
         UXZg==
X-Gm-Message-State: AOAM5311FRrwNq2mxv7Cg6UmnYXcHPDAkzWLlsPEqaIlmbYTHOpdp38q
        6W96yxhxQ7ciTfA3yRgONBg=
X-Google-Smtp-Source: ABdhPJze3T0Yyj+kvM5Ad2BP4neIXA9XzxUdinMLLQ2K9KROMPh5IFmM7Gp73mjGs3bVxb3rwJSLwg==
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id hd14-20020a170907968e00b006dbaed543c8mr36178503ejc.636.1649789884555;
        Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: reduce variables in block_write()
Date:   Tue, 12 Apr 2022 20:57:52 +0200
Message-Id: <20220412185754.8695-5-straube.linux@gmail.com>
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

For cleaner code and improved readability we can reduce the number
of local variables in block_write(). Use a single variable for block
size, number of blocks and remaining size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 43 +++++++++++----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 3cea4e41ab13..b4ab050a6f23 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -74,49 +74,42 @@ static void fw_download_enable(struct adapter *padapter, bool enable)
 static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 {
 	int ret = _SUCCESS;
-	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
-	u32	blockSize_p2 = 8;	/*  Phase #2 : Use 8-byte, if Phase#1 use big size to write FW. */
-	u32	blockSize_p3 = 1;	/*  Phase #3 : Use 1-byte, the remnant of FW image. */
-	u32	blockCount_p1 = 0, blockCount_p2 = 0, blockCount_p3 = 0;
-	u32	remainSize_p1 = 0, remainSize_p2 = 0;
+	u32 blocks, block_size, remain;
 	u32	i = 0, offset = 0;
 
-	blockSize_p1 = MAX_REG_BLOCK_SIZE;
+	block_size = MAX_REG_BLOCK_SIZE;
 
-	/* 3 Phase #1 */
-	blockCount_p1 = size / blockSize_p1;
-	remainSize_p1 = size % blockSize_p1;
+	blocks = size / block_size;
+	remain = size % block_size;
 
-	for (i = 0; i < blockCount_p1; i++) {
-		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (buffer + i * blockSize_p1));
+	for (i = 0; i < blocks; i++) {
+		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * block_size), block_size, (buffer + i * block_size));
 		if (ret == _FAIL)
 			goto exit;
 	}
 
-	/* 3 Phase #2 */
-	if (remainSize_p1) {
-		offset = blockCount_p1 * blockSize_p1;
+	if (remain) {
+		offset = blocks * block_size;
+		block_size = 8;
 
-		blockCount_p2 = remainSize_p1 / blockSize_p2;
-		remainSize_p2 = remainSize_p1 % blockSize_p2;
-
-		for (i = 0; i < blockCount_p2; i++) {
-			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * blockSize_p2), blockSize_p2, (buffer + offset + i * blockSize_p2));
+		blocks = remain / block_size;
+		remain = remain % block_size;
 
+		for (i = 0; i < blocks; i++) {
+			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * block_size), block_size, (buffer + offset + i * block_size));
 			if (ret == _FAIL)
 				goto exit;
 		}
 	}
 
-	/* 3 Phase #3 */
-	if (remainSize_p2) {
-		offset = (blockCount_p1 * blockSize_p1) + (blockCount_p2 * blockSize_p2);
+	if (remain) {
+		offset += blocks * block_size;
 
-		blockCount_p3 = remainSize_p2 / blockSize_p3;
+		/* block size 1 */
+		blocks = remain;
 
-		for (i = 0; i < blockCount_p3; i++) {
+		for (i = 0; i < blocks; i++) {
 			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(buffer + offset + i));
-
 			if (ret == _FAIL)
 				goto exit;
 		}
-- 
2.35.1

