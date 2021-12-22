Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4551F47CD54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhLVHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbhLVHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:09:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603CC061574;
        Tue, 21 Dec 2021 23:09:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1688074pjp.0;
        Tue, 21 Dec 2021 23:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9GdW/41SP4WrMLD62L5i1Oi6nl/ztOuq8F7Z8uPVG5M=;
        b=d4xX+3wfxCkfdGqTy8rJxAzpQr5osvD4jWUvj06/jX7cTZCMpr9oUsuI6ui82n7U1D
         sx7f0A2Xg6Z7MN/C/tZTEMzSu6D8BNtjQk3bfYORQFJwPbmUN6Hrz5H49gc7+YxRVZKs
         plo2+CvVgPK4uj4I3ZPSDoyO3FY8VWde4O/+tT4jbakkywcnra9dPmcD11tVF+0TJ7kZ
         m9zwbT+CrQMhvsA/FToYb6gXl1aaSHyuQ8Vu8gWJI0wUlfhMlsBH+R0g2lRcK1TlbqtT
         Ltz+fHUrez6g+FyOtbX2uk9Ja3BIwVvDPuc8cw9wFZ+bq6u4jL4Q+L9ZuQrhMuGY8YgH
         qCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9GdW/41SP4WrMLD62L5i1Oi6nl/ztOuq8F7Z8uPVG5M=;
        b=yP3WRmCQTjeu0mNqnLDwEKMwqXpHzF5+b4RmiPA2qihjgz10XQ/UTOUtuStrTh9qnP
         XuUBT0Lm/J7ZZsPsSesMRaeSqdyIJVQ1nvdUNrX73BBt2qUHKLfhNe+FyfRNidvGzDWd
         jKLzv53OplRk+r2pXD8jUpIS4N3sw6FJ56iupjXnGDnnDaYn36EOaRM7QdVXTKqEsXXH
         FPjJk2i+EcHn8edeD/0bK4iQQiK6dGGwqMlA3/YZ8cfQOtmHfqsWB+KwNO1HYl3SAiNb
         XxRZVKH8xBpgRa8b5A2X+doPIpNZBfTebOD3csJftH8mlGdJsun/ia1hibmMMtwdi0A1
         IxSA==
X-Gm-Message-State: AOAM530q1QiArwoHJKmI08WVyyhwOljhToWDpDrKvOnRfYWw6BfPxAzL
        UzaocV292+9zAGLpuTLon0Y=
X-Google-Smtp-Source: ABdhPJwZMIWyuezHxoS0eEV1QyePk8qBBpAvONjwkpZ0nJM/hOCtaZAmf0Gi3iURX9rUP4RvQ8bBXw==
X-Received: by 2002:a17:902:848b:b0:148:a2e8:2c53 with SMTP id c11-20020a170902848b00b00148a2e82c53mr1563940plo.162.1640156977237;
        Tue, 21 Dec 2021 23:09:37 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q10sm4546268pjd.0.2021.12.21.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 23:09:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] scsi: ufs: ufs-mediatek : Fix NULL vs IS_ERR checking in ufs_mtk_init_va09_pwr_ctrl
Date:   Wed, 22 Dec 2021 07:09:30 +0000
Message-Id: <20211222070930.9449-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGXv+5GF1WOeXVtnknAa4GYXE3Hd-UzcCBCyQzT6KY3tJCrVGA@mail.gmail.com>
References: <CAGXv+5GF1WOeXVtnknAa4GYXE3Hd-UzcCBCyQzT6KY3tJCrVGA@mail.gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function regulator_get() return error pointer,
use IS_ERR() to check if has error.

Fixes: cf137b3ea49a ("scsi: ufs-mediatek: Support VA09 regulator operations")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/scsi/ufs/ufs-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index 5393b5c9dd9c..86a938075f30 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -557,7 +557,7 @@ static void ufs_mtk_init_va09_pwr_ctrl(struct ufs_hba *hba)
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
 
 	host->reg_va09 = regulator_get(hba->dev, "va09");
-	if (!host->reg_va09)
+	if (IS_ERR(host->reg_va09))
 		dev_info(hba->dev, "failed to get va09");
 	else
 		host->caps |= UFS_MTK_CAP_VA09_PWR_CTRL;
-- 
2.17.1

