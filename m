Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE958E5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiHJEFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHJEFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:05:13 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FDF38BA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:05:10 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10ea9ef5838so16455014fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HzcSJs+NvWUdifTJLSaa1lWlyL4/HJWO6YyuNswmu8k=;
        b=F+jj/+NblCgAiqI7gTvhil038xrXyct9C3al/0zb0I0AIF/Q8ANqfp/VQky13ntjWk
         sp838B0eILlMKMNT0J9TyjsfQPZi3ltxstK4VU8OlpdHRpJQavuFO69O5H6nK5+x2BiF
         mABLuh4eHe5gbY8bFROJcDKIPYE4SeX5yu6i2ms1ELAx0jX+R1cFUUW33zzziC5PZBz8
         46JVLpAEpyoPRIlZ42RbUB2EXuQBa0942SHTbrsWot2LrwWiHfCdhf4Z+hJcpgIlzxeV
         IkOMXktCOHhDU99vmycgdZUnpe336z7bJmlJzkxLVYf9aLlp2cjhPib3IambJzqy+Ddd
         bdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HzcSJs+NvWUdifTJLSaa1lWlyL4/HJWO6YyuNswmu8k=;
        b=GXOzvxHJkyn+YrARsXjxaRUmEHtKuEBrkElapwSSQSD3aoH9guznyOzFOkFQu59ENI
         y4b/HZOVOhEn6uydXZzFcm/mmxUJD4oE4LYhD5PZjFXsUPFd6t3Vm3Jgh9/NOOjYjqk5
         aj2pjkKre/Vn+iwYfSg33NMyl4jAhYzdSDm06V6GnynOyt79OCcLSsAUE9CbhG0+mc9K
         yMyN3bAgC32qSQW23sEjBjIuaFMNcbFGDT3C0OSLiHG1qWHS3ORZ1kI8AtUXehDsdios
         pM/0KjxIDPHomC+bmU9O1uriDw/yQAMmXBheAShwGJEzf7F4JTmnrVTMBiICRY/qbuEL
         GOCA==
X-Gm-Message-State: ACgBeo041X5q7l+dm362kYa2NnCLPvCuS27buWZs0pZzxF1k7iS8hJUT
        4JLyJepMQJiRxMLKISNkJ+CDvQ==
X-Google-Smtp-Source: AA6agR73b4wlzonVOhZjp7c4P1ifYkupQzqac6zf6QWTANNg3mP5G3KpN2C/JmlXJeOgYzK+j9Mfeg==
X-Received: by 2002:a05:6870:2423:b0:fe:4131:6db9 with SMTP id n35-20020a056870242300b000fe41316db9mr679490oap.75.1660104310120;
        Tue, 09 Aug 2022 21:05:10 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q6-20020a056830440600b00616dfd2c859sm449027otv.59.2022.08.09.21.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:05:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] phy: qcom: edp: Generate unique clock names
Date:   Tue,  9 Aug 2022 21:07:42 -0700
Message-Id: <20220810040745.3582985-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
References: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple Displayport PHYs the hard coded clock names collides,
generate unique clock names based on the device name instead.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7e3570789845..41aa28291cea 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -571,21 +571,24 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 {
 	struct clk_hw_onecell_data *data;
 	struct clk_init_data init = { };
+	char name[64];
 	int ret;
 
 	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	snprintf(name, sizeof(name), "%s::link_clk", dev_name(edp->dev));
 	init.ops = &qcom_edp_dp_link_clk_ops;
-	init.name = "edp_phy_pll_link_clk";
+	init.name = name;
 	edp->dp_link_hw.init = &init;
 	ret = devm_clk_hw_register(edp->dev, &edp->dp_link_hw);
 	if (ret)
 		return ret;
 
+	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(edp->dev));
 	init.ops = &qcom_edp_dp_pixel_clk_ops;
-	init.name = "edp_phy_pll_vco_div_clk";
+	init.name = name;
 	edp->dp_pixel_hw.init = &init;
 	ret = devm_clk_hw_register(edp->dev, &edp->dp_pixel_hw);
 	if (ret)
-- 
2.35.1

