Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE6544D82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiFINYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbiFINYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:24:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4D33E92;
        Thu,  9 Jun 2022 06:24:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq6so34423484ejb.11;
        Thu, 09 Jun 2022 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIwvHle+n2X1mQu/sBa72r2guouaN1SD/l3le1h2rXk=;
        b=HRky5jZwzY5xTj4BXvqGmlXLwHXe0dloHZelSAteZl3sTquOX17mNHse8P9rcxPzQv
         9r07VrAkUjEj3fpb2sFor0XUAT5h85p8EEUkfH2it2ohwW12UznZfnef7Xj5fNJwxsvi
         I77N8yvszS/xopOrwJhK3vMKorVL5bTwIf/iBuxlSDge8Ag1qlQS1qEFnn+QK4Wy/xVI
         1fH4KiujZSVR4taMC+QPc3TecMhwYg/0ADG8VMl1V50vHtXQcrBWKaeWIN5nUQVE/12s
         UJBdHM5OmS/o4oK3qy5w9dmzeDiD++Gw5Hcw9KnAgtcH5KaBsDy16M0ec+ghp13Q+PXL
         TeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIwvHle+n2X1mQu/sBa72r2guouaN1SD/l3le1h2rXk=;
        b=2wv+lCWepIkVNTgYRttJSD5wSbPTU9VSkhU0CbaoTPQcMUtyqgTsn6/cpDfbGHf550
         pKtnNdr6dWVvjVHC3SyXO/1j2HiIVB1zvjA36hz90T9YCy9JZRyXkmstTh7hoSsEZQe4
         nwkzY18llh9zvTxdp/st2DmPF2+/Qd2YZcx7S/G8M40NkzfAKMzjLhjpBVdsBd1wqqrB
         IijExJM4QaREpYqEViWTl7j0AXEHICiE+7jqZN96I/oWMgvY+ykUURrAkThh8Un8VXSs
         Hi2dvBqEcUZ75a/erWCyaWvM7Aqs47LTeIfmr7thdjnqtEQpmz/2n4Q7/e9XWhNRyy0h
         ZebA==
X-Gm-Message-State: AOAM530EzoatK2vuA/7SA+0RvORiOphvyKytpZ1V1LbotD7EpLMF8xC7
        t3rXVQRcEq1LmrFsThpA8w8=
X-Google-Smtp-Source: ABdhPJzdi6Md0ie0GOTMZr35izgM3gdVIkqtDp5YdEOZQonq9YZhxo59/FPb4+1PCMB9SDDABsbx5g==
X-Received: by 2002:a17:906:414f:b0:711:ce99:69ec with SMTP id l15-20020a170906414f00b00711ce9969ecmr19398213ejk.724.1654781055196;
        Thu, 09 Jun 2022 06:24:15 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm8360263edx.81.2022.06.09.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:24:14 -0700 (PDT)
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
Subject: [PATCH v6 1/3] mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
Date:   Thu,  9 Jun 2022 15:23:42 +0200
Message-Id: <20220609132344.17548-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609132344.17548-1-ansuelsmth@gmail.com>
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
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
 drivers/mtd/nand/raw/qcom_nandc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 1a77542c6d67..7fbbd3e7784c 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -431,11 +431,12 @@ struct qcom_nand_controller {
  *				and reserved bytes
  * @cw_data:			the number of bytes within a codeword protected
  *				by ECC
+ * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
+ *				chip
+ *
  * @use_ecc:			request the controller to use ECC for the
  *				upcoming read/write
  * @bch_enabled:		flag to tell whether BCH ECC mode is used
- * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
- *				chip
  * @status:			value to be returned if NAND_CMD_STATUS command
  *				is executed
  * @last_command:		keeps track of last command on this chip. used
@@ -452,11 +453,12 @@ struct qcom_nand_host {
 	int cs;
 	int cw_size;
 	int cw_data;
-	bool use_ecc;
-	bool bch_enabled;
 	int ecc_bytes_hw;
 	int spare_bytes;
 	int bbm_size;
+
+	bool use_ecc;
+	bool bch_enabled;
 	u8 status;
 	int last_command;
 
-- 
2.36.1

