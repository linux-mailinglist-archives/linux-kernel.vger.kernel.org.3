Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3743519003
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiECVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbiECVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:21:17 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB040918
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:17:43 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s12-20020a4aeacc000000b0035ebb6d1a5fso2133278ooh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/4H8B/Rtj6Gbw/X7Ko9Cs2NaKraCTutfr1bJWw/laU=;
        b=gPm6e1vXbSqA/vxl+I6ZnWOUs+DAlSqrtdMRd9BZ9hSmXsQD5LSfbbPeHsHZzhDw3B
         ZVUqAxAKCpQ/xP+hmF/rzAxC/2qGXlKhq0M4uu2J8vIFDDfzz1ZzHnAA0z+dl/dMqHNV
         +yCz9dsAQDW7q2ogUz8DmoBAJuZyJh3uu4zvGjKjHQI45D44up//9alq+rsm6YsjhuyM
         sX0mxotyEumP96dbyUnHT/UhIL7P+9OgpWgTDLzG/PmxsZ4Eu8Y9y5yFLJuI0R+g69io
         KzJeGRodUvLGLTmHqBbzm//sy5Cw9myycGLZRkLzW/cIWelHyPwsW9wJWLI7pJQQozqL
         FVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/4H8B/Rtj6Gbw/X7Ko9Cs2NaKraCTutfr1bJWw/laU=;
        b=XUf8yHOI7S44laJuyPQu1B+HwFLfJr/uGWVrQenSMoSxrFgNMyc1xq+vGjfSqYIonW
         lzQUHwDIbaWjTtLMN8B9Yg4mTinEz1sjGmq56VTv8UiTXUeZ4TzwmcH4eoDSC1WWQVmt
         +tOVPCxwE58NcUmGRyK2RlkD0qYE2bN4u8AxPmNbqaWR2mPkPQWGEZqNBaJfTa7XDewz
         ODm/jLu6JCiL80zLEWw4/CHwz4mG+DfxYs+lKCA3bMN3yGeg0mtYQckMO9N1sDPpUzTM
         +fogtHaK+fV3nNuaWo/QSGT2tbLTKXcGUBfORD0TbVvPnYlc4lfNPXh1Ypn0dz/ICV74
         uC9w==
X-Gm-Message-State: AOAM530VEUdmUketlhI6QW5fU+qsrRZWrRIt2i3V/9gP/WZMT9PfO3wx
        9g3muAo1k3GVtl4JS5tnUu7ZzQ==
X-Google-Smtp-Source: ABdhPJyNNYOpSOkCK75gMPnwtMcQXNofLeMQzHCto/3PAuV1Mki7pz2MkqCXA3en8kikedFN1gvXmA==
X-Received: by 2002:a4a:e694:0:b0:35e:99e7:80e4 with SMTP id u20-20020a4ae694000000b0035e99e780e4mr6368669oot.97.1651612662998;
        Tue, 03 May 2022 14:17:42 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b0060603221263sm4305906otp.51.2022.05.03.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:17:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] interconnect: qcom: sc8180x: Modernize sc8180x probe
Date:   Tue,  3 May 2022 14:19:23 -0700
Message-Id: <20220503211925.1022169-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
References: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the Qualcomm SC8180X provider raced with the
refactoring of the RPMh common code and SC8180X was left with the old
style of duplicating the probe function in each provider driver.

Transition the driver to the "new" design.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 95 +----------------------------
 1 file changed, 2 insertions(+), 93 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 136c62afb3b2..467083661559 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -503,97 +503,6 @@ static const struct qcom_icc_desc sc8180x_system_noc  = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node * const *qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
 
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sc8180x-aggre1-noc", .data = &sc8180x_aggre1_noc },
@@ -612,8 +521,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc8180x",
 		.of_match_table = qnoc_of_match,
-- 
2.35.1

