Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F150B85E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447953AbiDVNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447936AbiDVNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:25:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C8158396
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so7368410pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSqkX7TcWeywMjVGkDaqt4I0CfnOOWaEQNQoX91yxGM=;
        b=sBqYuPt0XifDj11KJF2ArYF8kstCldmcCL7PC0qnMZN5P49dGeJEdwY9Il5Nbmigcm
         vXAl+JKru3xK/8jUDHbzqSn+H80jg3PMAQQdnV4OSgs29xcJ9OVKpENSjCfG8FW5m2+y
         SWHgrwbdOg/S7h2yLDzoYTK3n6rJGFol1s7zAfLq2BVvCleckLrksxLgFlsqPmiy4sF2
         UV9J2EiGTccRVkxHKPvnRfRWBQn4iV3r6w20PkMg9+7pkiKuLrDljST+RrR+g/v8b5F9
         EzPK6kBXX454I+61IhfYh3shai7uT7bWal6WUtObQR0UGnW7MRkJkARV22iYTF8Oypw0
         njWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSqkX7TcWeywMjVGkDaqt4I0CfnOOWaEQNQoX91yxGM=;
        b=6W4weP1OIqw5ushO+c1lS76dOtVvGIWUc1ARKNtNN4uJymb4tG5YopLCR7/IbzXtTi
         iEPz4K/FqBH1Le7jvqllThxY4hl/GQBgxMREgtLv3gkGyl4qcizmzO0+7BOpFB0s+Xdi
         3XZ8vsiphBKX8osbmevOjW9ggjLGnSDMiDInbNcLkNqcc5AEZL3XWjdiKGbvMF3SQZPJ
         1f+/q93ip4bmZNvDBAIjBTKkN7e6PVjzQBoiUtv0Q6jMwYRdI6pN9GGnnRpLukPY5LcU
         gqbi3UhA/0V33PV/e69BPDB4QKQgWdboollBBxJqrwOEsrpnFuoGmMrJTfhOgtbSBIMi
         j5Uw==
X-Gm-Message-State: AOAM533mlchJRR/C7rEVuJIIFK0GuczjSGN2aQnKIaZR4EnVOq4kfVrw
        /Sw4bxrgoc1cUD8KkgoGgImM
X-Google-Smtp-Source: ABdhPJx6Yzon0UefzWSg/IXHpu2HKWdTxoUKSHKl6fEweWwXW51KugE7J+akdjD2lSXiqst2VNTOMQ==
X-Received: by 2002:a62:fb0e:0:b0:505:fd9e:9218 with SMTP id x14-20020a62fb0e000000b00505fd9e9218mr5075359pfm.78.1650633744289;
        Fri, 22 Apr 2022 06:22:24 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id g13-20020a62520d000000b0050a923a7754sm2586840pfb.119.2022.04.22.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:22:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM
Date:   Fri, 22 Apr 2022 18:51:40 +0530
Message-Id: <20220422132140.313390-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the block devices to enter autosuspend mode during
runtime, thereby allowing the ufshcd host driver to also runtime suspend,
let's make use of the RPM_AUTOSUSPEND flag.

Without this flag, userspace needs to enable the autosuspend feature of
the block devices through sysfs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 5b9986c63eed..bbcaefd44699 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -879,6 +879,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
 	hba->caps |= UFSHCD_CAP_WB_EN;
 	hba->caps |= UFSHCD_CAP_CRYPTO;
 	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
+	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
 
 	if (host->hw_ver.major >= 0x2) {
 		host->caps = UFS_QCOM_CAP_QUNIPRO |
-- 
2.25.1

