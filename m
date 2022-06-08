Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FF54230E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385823AbiFHCYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445130AbiFHCL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:11:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C7EF67;
        Tue,  7 Jun 2022 17:11:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so38217154ejj.10;
        Tue, 07 Jun 2022 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peEtDnuQnzaJUUeMjl4LqwaDIeftlXgdWfg5usfizDM=;
        b=arIWg9P/rpW9RjH2/kZdbxLIEKz/qsOVFMIqQpAOBi1CmHQHyeKnT3tHNY8v9dM5x5
         UXW7jWkClwvY9b4vrujSkFYIhe9xrWuOCSW12rU6R44Zh0knenIBmnnZ3LdpEKufbG+U
         CVJ73XAj52QFqzGPtaWPDlDkd+0byXkcESSP6Q1e0Gm6QtngzyYcayvCjXTUYp8CgpwI
         Hl0NE62SXCgcvGCGiMZbQd82St+lH2TTvcnsLPuinDOoL7TbTrc8b1/ndsSN/WcocjB8
         KXjmSKD2y9P75k1+dDXYm/wxo5z6U1PF2TQEM7BImXBlFibG658W5fQayCDsA8ThHlBE
         5Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peEtDnuQnzaJUUeMjl4LqwaDIeftlXgdWfg5usfizDM=;
        b=PglSJ/9h9cl5eEibIJ4yya7DWu+GdJtd6TNoCqvmf6Dh8X8/0JI6rotBnHVM/ZlB7O
         9B4qcCzeATqahMn9UClCF7pFUOq5AzVjvNR5qxSSVlAdTIm53OZTxFblp+hYMwYSIzpG
         /38kHHSPXMRxxEC8keXS65uMEPL6Ls9IpNm02/QAeFXY5SNUrwz5BXmHVZSWVEUKkjXm
         wcnOtls49/KcDsCEZMdo8IicwmAdEdVHqnFxkn/JbS8t+Vr0biR1RQDHcP1w1IyDjS+c
         PIQtLg4nARdpFFf1XBw5Pq8DkGijQS3tafCvCnjxf+xX4EGcIYFWF3653kbsiz51yVMs
         GZPg==
X-Gm-Message-State: AOAM530iWk4VCnRjaknx/wPfbtirhhKB2T0x9aPhInpuGspUD0gMGBoa
        LhnO7nXlCxnJ4clGwzHSEzk=
X-Google-Smtp-Source: ABdhPJwVcxROaQW6z1CnZo/uOEvNYmnun8vP30SLXWhuaCTc7t9UfttE1pcsJ8QJRiOq/sMxdxLHng==
X-Received: by 2002:a17:906:685:b0:6fa:8e17:e9b5 with SMTP id u5-20020a170906068500b006fa8e17e9b5mr30668613ejb.522.1654647095641;
        Tue, 07 Jun 2022 17:11:35 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id o19-20020a1709061b1300b006fed85c1a8fsm8434947ejg.202.2022.06.07.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:11:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v5 3/3] mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
Date:   Wed,  8 Jun 2022 02:10:30 +0200
Message-Id: <20220608001030.18813-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608001030.18813-1-ansuelsmth@gmail.com>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
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

Reorder qcom_nand_host to save holes in the struct.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 06ee9a836a3b..110f839c9e51 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -475,11 +475,13 @@ struct qcom_nand_host {
 	int cs;
 	int cw_size;
 	int cw_data;
-	bool use_ecc;
-	bool bch_enabled;
 	int ecc_bytes_hw;
 	int spare_bytes;
 	int bbm_size;
+
+	bool codeword_fixup;
+	bool use_ecc;
+	bool bch_enabled;
 	u8 status;
 	int last_command;
 
@@ -490,7 +492,6 @@ struct qcom_nand_host {
 	u32 clrflashstatus;
 	u32 clrreadstatus;
 
-	bool codeword_fixup;
 	int nr_boot_partitions;
 	struct qcom_nand_boot_partition *boot_partitions;
 };
-- 
2.36.1

