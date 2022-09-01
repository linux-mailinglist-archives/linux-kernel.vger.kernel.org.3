Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCE5A9522
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiIAKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiIAKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:54:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96914132511
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:54:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 72so17111845pfx.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/E3bLVpztjFs44eA5Xz7SMeGWJRyaaTq3Re2Dj7/T3M=;
        b=spXh+pJT5SqG5t6NTOSkq6QW5VYWjZoE8iJPYmc1RP/pmPGs6/qNdz3rukAwbyj7GG
         EfULhk5RoJaAZrdjybCxYfGJlIqaq9VuvINyTAPaXk3ybmZru570YQGIVMnrmtnlQF+i
         toclcMfr42m5YHGSC8iGfSEwVzOrMGFByIsRNdBy8bXkbSy1NpZgEMG6C4a9/HrXoUXK
         2S41rL/ahfqJqfdkV7dXQhoFDUGaK4JP5MmoebYhZttM+Fj7KM66i4jrB40EhptXIpcF
         TzuJ6dA6BI0mXcQopbx46lDHGcQhRaxZoxZgdMn52b9G7TvcJ+dOuEgNmY7ljvsy9hur
         c61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/E3bLVpztjFs44eA5Xz7SMeGWJRyaaTq3Re2Dj7/T3M=;
        b=tjcZRzrHNb8gg0HF6lriC+5h/g4gxA6WqYOjJVB2tdTqo09sVU83Mr+gTzxHA6zF2J
         S1obcLWIQkECiP4BgEy0z5J8LaINYB1PfcmUENLeDO2TZIyVEHM7OsYjua5ZJkWyJfN0
         DDQZM2ZpHW0j/ONajtOvm4ppmSC0pSVxxIFnoMoKFW0IqvwxiJ/7zZWhusnpNWPO5xTt
         X1ohXLC4d7d4bEYzc4/14xdMyLqBcNI0CpyTrvxH2t8T8fIIKj0GYGWQDr9lWurHDr4G
         8FRaUPnoaD4Ti6IeieZAHlyIz8Lcnx7ssHKHmWS+OIpAX6pC4XaA0x6fGYmU1BdASMUb
         TScA==
X-Gm-Message-State: ACgBeo25N8dRbp2p1dZaXtPCPkpINkYm9p+fSbFdsIz2ri/vCeBuNBC+
        hJFfZAV4xhHDxc+Hc8+nFDWiiz4otUPjZw==
X-Google-Smtp-Source: AA6agR550SywU0WxvQxOEqmZLAsYRGMp1aaY9hKI+xKj95WtXCrsyB/gNQQab7KaawgAFWjFNma7fQ==
X-Received: by 2002:a05:6a00:c8e:b0:52e:af2:3d4b with SMTP id a14-20020a056a000c8e00b0052e0af23d4bmr30813724pfv.76.1662029677555;
        Thu, 01 Sep 2022 03:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:8069:f46:34af:eb19])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016c57657977sm13508910plb.41.2022.09.01.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:54:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 2/4] thermal: qcom: tsens: Add hooks for supplying platform specific reinit quirks
Date:   Thu,  1 Sep 2022 16:24:12 +0530
Message-Id: <20220901105414.1171813-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
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

Add hooks inside platform specific data which can be
used by Qualcomm tsens controller(s) which might need
reinitialization via trustzone.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ba05c8233356..92787017c6ab 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -513,6 +513,7 @@ struct tsens_features {
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
+ * @needs_reinit_wa: tsens controller might need reinit via trustzone
  * @feat: features of the IP
  * @fields: bitfield locations
  */
@@ -520,6 +521,7 @@ struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	unsigned int		*hw_ids;
+	bool			needs_reinit_wa;
 	struct tsens_features	*feat;
 	const struct reg_field		*fields;
 };
@@ -542,6 +544,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @needs_reinit_wa: tsens controller might need reinit via trustzone
  * @ul_lock: lock while processing upper/lower threshold interrupts
  * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
@@ -559,6 +562,7 @@ struct tsens_priv {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
+	bool				needs_reinit_wa;
 
 	/* lock for upper/lower threshold interrupts */
 	spinlock_t			ul_lock;
-- 
2.37.1

