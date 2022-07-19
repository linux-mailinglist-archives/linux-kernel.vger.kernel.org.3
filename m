Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B499A57982D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiGSLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiGSLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:06:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6892F02C;
        Tue, 19 Jul 2022 04:06:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so21113597wrx.0;
        Tue, 19 Jul 2022 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYg14oNiGrfGWkj/lM06y2kVPbkDb3pZlFZT7zIN7Mg=;
        b=W4HzHF6zb6Vv5K1FjCCqrmQ/oFtlgLrQN/6YyyYahENb2Q78zJeTpHVaQavFUqR96W
         w54kqwFIzeZOzb9qcDRyYliKQ27F6tPDoxDQ6bcXnBhN3wwLkxssOf54NctyfuDDUAdN
         jDynmK2RoSlnUuS88Omn3TEtXZFpx0vMldkZQQEgxoPcOwzG6F1ruHv8iBl/IT8QWqam
         bPaMK7B9vAQ6ITcLplHeboI8ccd5cZVj2x3K51gjWT1tJruUmIaYmaj+xpiP1CzH8sVg
         46LT1dwxXEt6WU1xJ0W+zEd2I1SyOPyQ9i67/bjfh5CkqyeOaDT8tqY6gNM0M1hOcZdT
         dd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYg14oNiGrfGWkj/lM06y2kVPbkDb3pZlFZT7zIN7Mg=;
        b=Yrmc6tHfWDBj4y3copP7klJumwc1EITc1VN/99ueXH/KGSe2vxndmZLCtcxYBdzpPp
         4a4A5Jn0CADXHh6pt3TmLOtIpVENujCZUQRPuFey/6dhUINO1VVSb6vuFekKXd/c+i6+
         FDnnrVUUomn4iBIhGqIGEBtglLU9gPhR6/gmNgb/WGqfthXAR1WAThme+ospg/9b2vYd
         HqfhXJ8dsqsrTHV6d6aPdF1/bPRoD/oJg+R2s3fnvfJaIG5v/f+q/EwX27gn1uUzhue7
         fctcCo9AH4qiDH4zVVvXoTR1YnUZjJm4hOeK7tMzqx2fLIsLujadF/8lLzJIYMXgyHCS
         Vjug==
X-Gm-Message-State: AJIora+B9XlAEj8YRw6IK/k69AuiitheU2VvrclKnuSS+LSry/bik7d4
        zLs5+bTM/0mJLPRciwrtqDp1tLEzlZAv5g==
X-Google-Smtp-Source: AGRyM1sc6wqunKQZaY9vburbZEeqwvmVqDs+wuAdswpOPkYI8Ux5VRsIuwjTsk1Z+bNGpvTY4QhQAw==
X-Received: by 2002:adf:eace:0:b0:21d:6e90:2bf8 with SMTP id o14-20020adfeace000000b0021d6e902bf8mr24895959wrn.349.1658228810543;
        Tue, 19 Jul 2022 04:06:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a6-20020adfdd06000000b0021b970a68f9sm12936873wrm.26.2022.07.19.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:06:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: ufs: core: Fix spelling mistake "Cannnot" -> "Cannot"
Date:   Tue, 19 Jul 2022 12:06:49 +0100
Message-Id: <20220719110649.759821-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ddab087dd0bc..581d88af07ab 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8550,7 +8550,7 @@ static enum ufs_ref_clk_freq ufshcd_parse_ref_clk_property(struct ufs_hba *hba)
 	int ret = device_property_read_u32(hba->dev, "ref-clk-freq", &freq);
 
 	if (ret) {
-		dev_dbg(hba->dev, "Cannnot query 'ref-clk-freq' property = %d", ret);
+		dev_dbg(hba->dev, "Cannot query 'ref-clk-freq' property = %d", ret);
 		return REF_CLK_FREQ_INVAL;
 	}
 
-- 
2.35.3

