Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D825663A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGEHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGEHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6151910FEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n12so10755419pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRrnUdGamCbkam2j5LdYTW9gHcI75hKYFbox7BL3/XY=;
        b=A2orPeJku745omSXs6i631qSAIyedbYWwRJe+I8/EzOxnJxgVNjsj6m1/GAEPXFIUr
         zJc0wmZ++SjzRezgPQcyPmuqFyReGWC4w4+IgoTLGyf2cyk1txI6qj3+epZaaBdp0WNz
         8MJVZHM8L4UoZoD9hJnhD6iiyN3MKVH7/fU+SZmfD5oBSFQinQkSzx83jEFMi/OZQ3My
         9rpVe0EzDKTKDrE1CqP7nCUpOCA/Q1nwhrHlvVwFL1faD3MyCNm0NX57aySCzmJ0LhTh
         KDB/fWStNikhy2rXNZYaT/GFdTJ3uX5WIPtcbrnC7Sd3j8BZTb6i0iXy+Fnk3HI1Vfz0
         W0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRrnUdGamCbkam2j5LdYTW9gHcI75hKYFbox7BL3/XY=;
        b=UwXrDsusGrYIkKK13tW0qkIgXO0Ad9urbLydne/pA8Bi27snQ1xDn2eogs32PSTXyG
         ZTpCLWSWCHJJUUPSSM23oXVacWsB06XybBkPpeUUel1vaQgCww+KLEutNesgiscXTrkF
         ydrQOHqI3GPN6WtDUrvZrGO4y5p7n1VoLFOrn1zaSUksU8d/g6LukDT8qKynj7590TXQ
         2ErYvqp1AKivhR3KuBIu+y4AWjdTdemZaXdLXlMSsv6Sju69geC79K8t2WBWtygoxvK0
         fo+RJerPwisYQoWLpg5+Z552+xyaK3/+OppjkFi4xsUHjZA9CZqk3LyTrO7Ky4sns1EB
         hXUA==
X-Gm-Message-State: AJIora8czQa6gt0DsEAN+KMQFBLmDf9IIs360K37rvD8mQE8S2RvtxXQ
        OLoOCK6Jw9qfuJhPEW/0lW+3uw==
X-Google-Smtp-Source: AGRyM1u4GrAbNDy2dSBIvKZmivsrXDdqiCIQz4jE23OQrwxwEJJcdwNLC2vnadE4U7N8y3wBPlViLA==
X-Received: by 2002:aa7:989a:0:b0:525:252f:3c51 with SMTP id r26-20020aa7989a000000b00525252f3c51mr40356737pfl.39.1657004439921;
        Tue, 05 Jul 2022 00:00:39 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm22566988pls.100.2022.07.05.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/13] OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
Date:   Tue,  5 Jul 2022 12:30:06 +0530
Message-Id: <fd2b901d2d2441c76137b9b69181db248f7866a3.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

Reuse _opp_compare_key() in _opp_add_static_v2() instead of just
comparing frequency while finding suspend frequency. Also add a comment
over _opp_compare_key() explaining its return values.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++++
 drivers/opp/of.c   | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ae5949656d77..00d5911b20f8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1636,6 +1636,12 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+/*
+ * Returns
+ * 0: opp1 == opp2
+ * 1: opp1 > opp2
+ * -1: opp1 < opp2
+ */
 int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
 {
 	if (opp1->rate != opp2->rate)
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index bec9644a7260..bb49057cb1fc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -929,8 +929,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
-			/* Pick the OPP with higher rate as suspend OPP */
-			if (new_opp->rate > opp_table->suspend_opp->rate) {
+			/* Pick the OPP with higher rate/bw/level as suspend OPP */
+			if (_opp_compare_key(new_opp, opp_table->suspend_opp) == 1) {
 				opp_table->suspend_opp->suspend = false;
 				new_opp->suspend = true;
 				opp_table->suspend_opp = new_opp;
-- 
2.31.1.272.g89b43f80a514

