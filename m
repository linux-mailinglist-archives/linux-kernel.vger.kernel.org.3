Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7237E590EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiHLKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiHLKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:13:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923DFABF18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso4095472wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=B9cGc19KPCzbp/HnQ1cU37r4MPElwTFqiMBa6G8MiPE=;
        b=tTWGw1QpiBtbmYksvkCkzZiRzC+Y/f9E42V6KmREw+A9r8MVkUqGxIRRCr1sYcM1HZ
         VxI0f6kDp80bXW6/ASgGBuFQ+A7+++SQLVk6GuFcZS3hs23ZQ7osZZME/ADpknDN2dhI
         hzYWdozqmx1NXZwwbvrHDbIW1KRadpPWpBtGo+A/HJBLkuS7wNtCpjHDRA8ZQVBwgMJA
         42qAQgPL+/Ya19NLUZUKaD2OLge7hOnrH/pWuVCbmzAxxNfzDHAxvW3VaAQDKJNNTAA3
         nIvVv7qhIxGDA9kBYFuD74cViwP0o4zcQ0cBUAp7ObZW4eJJE0oHs6PKWLcCqh82V2yd
         070w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=B9cGc19KPCzbp/HnQ1cU37r4MPElwTFqiMBa6G8MiPE=;
        b=rko27N7fed5kOJ+dCxnCA3dbCgYs8O3A4Ac9Y6Yn9v7FFcBCC43atK3KfzUzVCG/Tm
         l7x3ZSc9FhLktEgcrjY1m3CQHIA205/q3puWH1ke4gErXkkDLMA3rQqAyoW1YjF+jnzI
         x3rWi3R4CiOwGwzlu6L2Co2wJPipMulfCjxglONdCBKTc4vAk43Wp7CvRJ+k5lp1ZRTp
         9n//2Rat8Ls1nXZliud4qkVlnYrRyMGO+6ZOuecEnoAMOoA1fYEwPjDaSBoND7QJNpWM
         Ysu6L7P8flRA7gPGltiAHXITl6GIF9o6++mejUYBUgnaUtax75zUGWpXShE7MdTNIYsO
         JRXA==
X-Gm-Message-State: ACgBeo0iU7Gki23u6UiIaLE3hUNdA1dRxYQ1JYw79q85XKSd1dmStSvm
        /KhIphQRkwHu9AVNzpU7hxkaQw==
X-Google-Smtp-Source: AA6agR4FELZEIhz1T2y8FvYHLJ3zpVGgKHLujHkbOItmTebVTb7bB9U5VYqTYifyO4nB3p3SkoymCA==
X-Received: by 2002:a1c:7401:0:b0:3a3:182f:7be9 with SMTP id p1-20020a1c7401000000b003a3182f7be9mr8359047wmc.189.1660299163675;
        Fri, 12 Aug 2022 03:12:43 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b003a541d893desm2193204wme.38.2022.08.12.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:43 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] soc: qcom: stats: Add SDM845 stats config and compatible
Date:   Fri, 12 Aug 2022 13:12:38 +0300
Message-Id: <20220812101240.1869605-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220812101240.1869605-1-abel.vesa@linaro.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
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

SDM845 is a special case compared to the other platforms that use RPMh
stats, since it only has 2 stats (aosd and cxsd), while the others have
a 3rd one (ddr).

So lets add dedicated stats config and compatible for SDM845 to make the
driver aware of this num_records difference.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changed qcom,rpmh-stats-sdm845 to qcom,sdm845-rpmh-stats, as suggested
by Krzysztof.

 drivers/soc/qcom/qcom_stats.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index d6bfd1bbdc2a..121ea409fafc 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -246,6 +246,14 @@ static const struct stats_config rpm_data_dba0 = {
 	.subsystem_stats_in_smem = false,
 };
 
+static const struct stats_config rpmh_data_sdm845 = {
+	.stats_offset = 0x48,
+	.num_records = 2,
+	.appended_stats_avail = false,
+	.dynamic_offset = false,
+	.subsystem_stats_in_smem = true,
+};
+
 static const struct stats_config rpmh_data = {
 	.stats_offset = 0x48,
 	.num_records = 3,
@@ -261,6 +269,7 @@ static const struct of_device_id qcom_stats_table[] = {
 	{ .compatible = "qcom,msm8974-rpm-stats", .data = &rpm_data_dba0 },
 	{ .compatible = "qcom,rpm-stats", .data = &rpm_data },
 	{ .compatible = "qcom,rpmh-stats", .data = &rpmh_data },
+	{ .compatible = "qcom,sdm845-rpmh-stats", .data = &rpmh_data_sdm845 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_stats_table);
-- 
2.34.1

