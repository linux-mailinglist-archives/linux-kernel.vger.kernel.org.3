Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE504F054F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbiDBR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiDBR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:58:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1118F13F8DF;
        Sat,  2 Apr 2022 10:57:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o10so12085423ejd.1;
        Sat, 02 Apr 2022 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVxMHUicLbUH3Hvb1PPfVYvYyoskkvyv49vbgbrFCNo=;
        b=l4c6G01X/mM7+1GnZ7oTuCLmtLgPbKG3mx7SbFPIku+ccwGTElZ0p+W8JpJcckG2wh
         /lF6CkMeckAATTx3qq8eCxC0mdDSJ0VT019mKzu8JOetLhqQuR09W5RVyrR1UzGEDt7H
         knZw+WaqR0Sidvgu5QJrnqYYMGo1Y1pb08ICafpgzDjkd/Q6yIWrf7dgseR/JD945Em3
         9BH+Nb3SU6TlJBW8YtlSz/fuKkv3a9zHjIUAn2x7LKtTPE+BqSFW9l9bishHF4Eei2fe
         fJhs+n3r7vBmF7oQn92ysEu3AeNjnZ7OlVofn2YH8295+lgWegZ90Ap6GMNXlUY+LxGh
         c2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVxMHUicLbUH3Hvb1PPfVYvYyoskkvyv49vbgbrFCNo=;
        b=ZuGYeZYiUHLKCbhIkK2JhN9wQNBD40VMaoOofC50oIHn7kYCkc881k+M7Py3RDJFJ4
         Kh6tBCrOwcq9zdX9Guk2zcTDwbdiPIl1nRx9zkYQU1VGdo+3L9eTE/KhzfcqPSVML78Z
         8ot3ZdXNP0TSjnAeBgj2YPlY0U6u66AmgW2Le8cpzkF/dShMMQ+CLSQG+5j4s6+fE+A3
         PYLIzXewKj2eGwhP4/MNobn3DkQsLOe8FHeEDXHVbzvPiAIIYIYJHnKfdx//a+/AIPHN
         1eaobQKP++AzLBzK+S1ZGwjBgBBOLKwu8m4Z4npHE7pAhdPRP25lBj8UX/+OpHfQLMDW
         lYCw==
X-Gm-Message-State: AOAM530lOyga1/NAwu8ATbOnwbtK1hkNVGfdOJ6Z5Dxmae/L+J4ceUBT
        V8TYlidUsJOS7SYgxmB7rOc=
X-Google-Smtp-Source: ABdhPJxRkR3w6MzpTeXo9b3BtpKvfUhBJrw6SYUseLvbqksVCDq8E3opTpW2w3JsDEAmAT8cwPaL5Q==
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id nd41-20020a17090762a900b006da79534df0mr4472210ejc.316.1648922220505;
        Sat, 02 Apr 2022 10:57:00 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd7dee980sm2330857ejc.30.2022.04.02.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 10:56:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: sm750fb: Call iounmap() to free mapped bus memory
Date:   Sat,  2 Apr 2022 19:56:55 +0200
Message-Id: <20220402175655.31512-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

If ioremap_wc() fails, the code jumps to the "exit" label and forgets to
free the bus memory mapped into "sm750_dev->pvReg". Mapped bus memory must
always be freed by calling iounmap().

Call iounmap(sm750_dev->pvReg) when the above-mentioned failures happen.

The site of the missing iounmap() has been detected by Smatch.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a7c6eb07b62e..55cb00e8b0d1 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -81,6 +81,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->pvMem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 	if (!sm750_dev->pvMem) {
+		iounmap(sm750_dev->pvReg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-- 
2.34.1

