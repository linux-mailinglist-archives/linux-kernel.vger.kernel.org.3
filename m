Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA924D0B52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbiCGWnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbiCGWnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:43:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5E2982F;
        Mon,  7 Mar 2022 14:42:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k24so16155743wrd.7;
        Mon, 07 Mar 2022 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doUASiEkKSCXAFSzEQp6F7J0ad241mwX8xOq8sbVorM=;
        b=XHB5Kp+JDUH60WICe5UwMmi3bPPyLh9hOv9OKWCyeHrPAAWe3qBLn1Kgoe58esYtTP
         eDBBIKQNb+duIemCig5COE9QCqjIW/9Jg48wjbbpOVLdbHBR9drfJOTAUPsBcPlLxr7X
         glRdirD02kHhMJfYRXSzpi/sWzpuhvLEpIjRten57Z2yisGFeeXAandDDWbHjx5qHDkr
         m11Cl1Zp2vQEVcP26mn5Vfn6ALXDWBVWYLYBiLVnK9SowiEu00gHfI+5vSpTW/lAVtAd
         kdHJtfNAvPWui3pO7wIuRus0BF4tDnIEgcYQu0mQtUBJAK4qCsOF0Z/V8qoEr0FhynOB
         Gj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doUASiEkKSCXAFSzEQp6F7J0ad241mwX8xOq8sbVorM=;
        b=VdR5g6HhiFddEiZaJUub9Vqa7nYTui4nLar5A6+0wKpq9hoGdJaz5Gkk8aj395bj0g
         ohJHfu8qtjrgU23iDDRMpOuXI0x/erpDiZl2fDj/A/NJELMtfI8BLqO2fSIzHfDGgKFL
         PfmH0X/1fJyCxUzUvuQe+RTLEWYLU0l/hKfWXiAgI2hyFD4rXakwcjLdyObbC2WVqame
         KARjy9eH6Np7bOR3Zmm+3GfN7nRqNlfBtuMi4tZxMWi267Q57hhmHB6sWxqJ6pEW3kDM
         FavPVt7C95FMk8w8kf0nNhQgDn1oJTPgQbHXAt1lT8bxCERA7dfwU7DqByJ8p8EVDrPr
         x2fA==
X-Gm-Message-State: AOAM533fdaLSJMEsFSpbKOogwexZ2CQ1epO1cqr/9ARDxD/+TMvmaZOr
        amRxcyetrCQbIU9GC4959NZFc/gezZ1/BA==
X-Google-Smtp-Source: ABdhPJz1ftml4JACkXfhIC8v5g7ez3OZ02XSySK0IO+HN357sjY+KWVo8zSkozz34MQPXvwazGGrzQ==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id p17-20020a5d48d1000000b001e32401f229mr10012515wrs.694.1646692968554;
        Mon, 07 Mar 2022 14:42:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003814de297fcsm500430wma.16.2022.03.07.14.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:42:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: make the read-only array table static const
Date:   Mon,  7 Mar 2022 22:42:47 +0000
Message-Id: <20220307224247.167172-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array table on the stack but
instead make it static const. Also makes the object code a little
smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/usb/gspca/spca561.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/spca561.c b/drivers/media/usb/gspca/spca561.c
index d608a518c141..431527ed602b 100644
--- a/drivers/media/usb/gspca/spca561.c
+++ b/drivers/media/usb/gspca/spca561.c
@@ -510,7 +510,7 @@ static void setexposure(struct gspca_dev *gspca_dev, s32 val)
 	/* We choose to use the high bits setting the fixed framerate divisor
 	   asap, as setting high basic exposure setting without the fixed
 	   divider in combination with high gains makes the cam stop */
-	int table[] =  { 0, 450, 550, 625, EXPOSURE_MAX };
+	static const int table[] =  { 0, 450, 550, 625, EXPOSURE_MAX };
 
 	for (i = 0; i < ARRAY_SIZE(table) - 1; i++) {
 		if (val <= table[i + 1]) {
-- 
2.35.1

