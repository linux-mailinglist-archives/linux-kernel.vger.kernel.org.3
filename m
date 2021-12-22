Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399D347CCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhLVGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhLVGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:24:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF311C061574;
        Tue, 21 Dec 2021 22:24:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q17so1107830plr.11;
        Tue, 21 Dec 2021 22:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vP1LOViFn0+7V0Z8YFpxh/XwEIUum39ijaW3BebLLxI=;
        b=fagiSX0TlmeVqPVl5MegpvdJMrKjEx47q+BE0Uo/MmVO64pFRvoE3+1lcwGvPDWaoc
         /QeDAOQ9H+Sae1Yom3iXDYGAHBiO2SkkOK4PbA+owI7UBxwh0mouiwNJnKF4E0FYo+aL
         niNCwmOvBEWDJ5cUk1VzGCyRWrQVpxZwW+HfARrnv0rzKtmg7y5fZnq1lGyOtBvGOQ2P
         A75tHkBbFDLYUIihoTwALQD//WrtURNpY2TPJVwQVUgsVAmNnL/EQFd/SkvNPJNOemKf
         GchWJmHPPF5qAMA/pgciCDbnVz52zgkbTvS5+YU9EohPOwCe8Ju7SpZBN1VMvbr2EAJi
         RRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vP1LOViFn0+7V0Z8YFpxh/XwEIUum39ijaW3BebLLxI=;
        b=3RXiDDYN+jiZnnHcSFJCFXz2vOWYdOmLwLqbXLRjYFXfiH2kcMGOlkHAt8SZzfq7NX
         tzs8SvV4Wf8wlRYx85XpyetgSx7vC5O8VSHV6ZMBjMbpLLnz5mjkHVj1iA0nvevV4ceq
         dFCiaKdFLgS4K70Il+JVqaYnZJdRcLLDZpGiAEiehnHcnNeKNLyDZnAekesOQVCkG5lF
         To3lsgF9MqY7KDogKl7AwlLqSMqONPZDVqsOCLSotxvT5/pz7E0NSX2ERRU0Xrbl8ABY
         /SJIeyXs+B/vuBKPNS4C5lbpIsS8pZdxCKSqKfvFUvNZ0H6yKt85ad2hrJvPKpipMDNe
         aRlA==
X-Gm-Message-State: AOAM533cuC/AKpXCw3694/Nsz1+dW9Uu5XGfYbe6w+CiqpqXxCHP+6MY
        lnrTxUBDz31p2RreZfdNgJs=
X-Google-Smtp-Source: ABdhPJzrFTfdWCZJJj7PQimEL7SGlhd9TvjzNv+9aMRbe+1PjRHxoh7SdCQwTik/GTySzujwK6NFaw==
X-Received: by 2002:a17:90a:ab0f:: with SMTP id m15mr1881870pjq.91.1640154291500;
        Tue, 21 Dec 2021 22:24:51 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j20sm4109730pjl.3.2021.12.21.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 22:24:51 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] scsi: ufs: ufs-mediatek : Fix NULL vs IS_ERR checking in ufs_mtk_init_va09_pwr_ctrl
Date:   Wed, 22 Dec 2021 06:24:44 +0000
Message-Id: <20211222062444.16144-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function regulator_get() return error pointer,
use IS_ERR() to check if has error.

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

