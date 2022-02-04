Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5364AA080
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiBDTvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiBDTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:51:01 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F384C06175D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:50:59 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m17so5719421ilj.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q42zjW8xahSVhGaNilfnj63EHK+Wikk3dCoDovWBQQY=;
        b=Fqu8+ypIkgxeVioleBdx7cz2kzcNe89AS6NsggXAOlU1Ts4IPADKZ7XQeqdEbNyf89
         SAwWXPLyU9ULlM70bsTCwyoO4AYCOLi9/eUmNITJ8VrsmKVKrxSjiJqvPtseykw4EZcI
         7i8RqubLHz8YGtUo1UHLJKtlFDeKXKdw9yb2FasbkTYh78guITuK5WoEem40G8WTdxNI
         N2ZTPzSdf0zgrNKA7v4PckXQhcoazag/+YBMSZrJJ51D1Yj4DXi3d3/mwjcQ34YFtLul
         GJRRg3fl06CGSyOoSnuyNX5UWetE1yfvt15CEfeAHhUtgBC2UVyjdv2AnnMPDzCd61Vc
         tpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q42zjW8xahSVhGaNilfnj63EHK+Wikk3dCoDovWBQQY=;
        b=fMdp+aDzV/PSSnlmnK5rWteLg6ny7mzDh6RqnsMuKt/25Id2RwNa8Kxyd21eQzpxsj
         TE0obGtAlAZv4iQuBIggHGIatF8AxUkLmM1qLqRDBXGWgMmyl7XLMn5LTFyiMivA+YAm
         D8TGmt/iLhY5b7zmE2b8BgdqRTjX8Jj4ZWoVoZypi1hAa+pn6O65WKHuK1+bB8SAaL7s
         MOLehbH4SFQklbVprNyQimA8biH1WgipAq4AFxuI3lf4DQKURsUaBSdpEvcNnihFv0mj
         N2nJgdQeaxEBllHmoo20J3wUrDJWdmoZUOlVdbEfRWBRcJ+C5P21MCzYWRTXvuR6r1YO
         OuiA==
X-Gm-Message-State: AOAM5310HU5LPHgx681MblRTtHeF5KbLutw5gntZOee/kbsNJGSPt8qx
        NMpGLJh6rw85DKsP6oc+pQVxrQ==
X-Google-Smtp-Source: ABdhPJwifcbLNOdRURW/rAIAn/Qb8lZQb1jM5cBMyOnP8fsp1/pvuwPkQuyCiwRCNj/Yx2I45RV8vQ==
X-Received: by 2002:a92:c569:: with SMTP id b9mr374353ilj.140.1644004258743;
        Fri, 04 Feb 2022 11:50:58 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k13sm1417564ili.22.2022.02.04.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:50:58 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/7] net: ipa: use IPA power device pointer
Date:   Fri,  4 Feb 2022 13:50:44 -0600
Message-Id: <20220204195044.1082026-8-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204195044.1082026-1-elder@linaro.org>
References: <20220204195044.1082026-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipa_power structure contains a copy of the IPA device pointer,
so there's no need to pass it to ipa_interconnect_init().  We can
also use that pointer for an error message in ipa_power_enable().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_power.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 8a564d72799da..16ece27d14d7e 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -71,7 +71,7 @@ struct ipa_power {
 };
 
 /* Initialize interconnects required for IPA operation */
-static int ipa_interconnect_init(struct ipa_power *power, struct device *dev,
+static int ipa_interconnect_init(struct ipa_power *power,
 				 const struct ipa_interconnect_data *data)
 {
 	struct icc_bulk_data *interconnect;
@@ -89,7 +89,7 @@ static int ipa_interconnect_init(struct ipa_power *power, struct device *dev,
 		interconnect++;
 	}
 
-	ret = of_icc_bulk_get(dev, power->interconnect_count,
+	ret = of_icc_bulk_get(power->dev, power->interconnect_count,
 			      power->interconnect);
 	if (ret)
 		return ret;
@@ -123,7 +123,7 @@ static int ipa_power_enable(struct ipa *ipa)
 
 	ret = clk_prepare_enable(power->core);
 	if (ret) {
-		dev_err(&ipa->pdev->dev, "error %d enabling core clock\n", ret);
+		dev_err(power->dev, "error %d enabling core clock\n", ret);
 		icc_bulk_disable(power->interconnect_count,
 				 power->interconnect);
 	}
@@ -385,7 +385,7 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
 	spin_lock_init(&power->spinlock);
 	power->interconnect_count = data->interconnect_count;
 
-	ret = ipa_interconnect_init(power, dev, data->interconnect_data);
+	ret = ipa_interconnect_init(power, data->interconnect_data);
 	if (ret)
 		goto err_kfree;
 
-- 
2.32.0

