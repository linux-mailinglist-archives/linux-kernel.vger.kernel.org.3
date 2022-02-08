Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE54ACD9D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbiBHBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbiBHARb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:17:31 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D7CC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:17:30 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so15867387pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTlV3k37gSPHQGzmdqOm/GQ1i6HEcGZeJS3MfQHco/Q=;
        b=M5IpI7YRyKlWY4qBdZy1pKA9RYnZ+Ebe1N0CcXRXZlljjHQ4/zokdaM2NCNybfFofw
         lxmzOksfUzhLpcPbp+YuUqxl+teCZFbXQH+POfhpO/FOimCe6m+UAfM0ghM9ljIv6Xhm
         q0/JbWU8GqMIChOD0YZNK62Kfw/7SdPt9d/S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTlV3k37gSPHQGzmdqOm/GQ1i6HEcGZeJS3MfQHco/Q=;
        b=rG4K8ibuqI2K1gYV8W0r3CFvdoGMgN9DzKEdbZea3oJRZCRLz5NO2jPUWMscVKqDo0
         hz+DnhRVUJBK9AQSoSQxPxSJvcJTXr/Hz5XdXrCzkNu3GWq9BVv2m24zQHS860KFnoGr
         VVHEIX3T7W8AuhZ9NTz5inPMduZynM4ZrPEPBUoDHYV1O9lGFwi1ZirwrN2YDnWMJCw/
         4hGZU+1+dwIBJMQliQ9U7ZrE2folBLn8kdIJmJj5k58kk9M9IXQnix+z/lMDzNurjSVI
         L6SneKuaLa92TRwsISvesexAuoS99Qj943s4gUGyQIyh2mQ+irayf2aH8zdfXi1tovrQ
         pQiw==
X-Gm-Message-State: AOAM533fuitt96rgnbix1IHl+pvo/vzV2x6G6TVIh3i/hTsdWnrXaOJz
        Aev5hRnh0SZ4WEt6jhjs1nYn5w==
X-Google-Smtp-Source: ABdhPJwG98yng7p3MlBGXtlfXIidY+MiUfzYLK2chW7OnBZeCQhdaEAEQTFW4ym+ghAdjmC8mLTLQQ==
X-Received: by 2002:a05:6a00:23d3:: with SMTP id g19mr1808125pfc.27.1644279449844;
        Mon, 07 Feb 2022 16:17:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c4d:c442:5b4:f597])
        by smtp.gmail.com with ESMTPSA id mz4sm456185pjb.53.2022.02.07.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 16:17:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        robdclark@gmail.com, quic_khsieh@quicinc.com,
        quic_abhinavk@quicinc.com, linux-phy@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH v1 2/3] phy: qcom: Add support for eDP PHY on sc7280
Date:   Mon,  7 Feb 2022 16:17:03 -0800
Message-Id: <20220207161612.REPOST.v1.2.Iff75c0ea8499f0baf2aa5800f2c45c4128e2415a@changeid>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208001704.367069-1-dianders@chromium.org>
References: <20220208001704.367069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sankeerth Billakanti <quic_sbillaka@quicinc.com>

The sc7280 platform supports native eDP controller and PHY.
This change will add support for the eDP PHY on sc7280.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/phy/qualcomm/phy-qcom-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index a8ecd2e8442d..21cafbb623f8 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -654,6 +654,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
+	{ .compatible = "qcom,sc7280-edp-phy" },
 	{ .compatible = "qcom,sc8180x-edp-phy" },
 	{ }
 };
-- 
2.35.0.263.gb82422642f-goog

