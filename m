Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C54D706B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiCLSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiCLSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:43:19 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F46A038;
        Sat, 12 Mar 2022 10:42:13 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h11so16420994ljb.2;
        Sat, 12 Mar 2022 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1uGOM5u14MmhWi9rlkVl0ueDCnCUd0QgmfYxjyLPSc=;
        b=Z4FtFIHnrBs7Bo7clCb9t3fLwNx468Jj88pgZxP6sJMo4S5aiVj+ZE5Q+0kJ280rS1
         zY3T8SzGFrB72+A4x9ZSpSql4Zn1C8waUytrhkahQQ/70zNjQuARP3r+UR/TDMQCUI0E
         a/0N71LoJpc5yEZ3btQw1d+EvlNst37lVk8hnFEJfZxEcTeP1xbFI3AC//OeLNpdrhKY
         AajyDBgEzz3XkJ+iMEobjGjCDi084v0vQKqFrCH7EHk5Mc/wH6hsZwJOaM+fMK5ukaLX
         1h3j0RiaW7/Jxhzq4ip9HyrG8/tlEzvbYivJpENh+ekzTGEMZzTI8vWYxCEF+US6iTFg
         ydiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1uGOM5u14MmhWi9rlkVl0ueDCnCUd0QgmfYxjyLPSc=;
        b=m35IyY40/oSDOIyGbSc5C+DtGkJoNkOSkPBt6cOU3pzP48bz/UUgko7zM2F8SA4+NY
         RosyuAUXeiHSec+EOGy5eAeXCZ8b2svgNxNnfjjQqN3sry0SxNzZhZ5UC8GL2m8kMQQM
         ff+8PvFMg2xBGnA+TG8S2DTEt60vNyaCIF1YGd5xI/hDXIkOnXD3ff3qCvgwIEiQmsWO
         bFmTkS0oXS0msALp9i61ZkQcMSgjgxyMtuJwT3xz6rdEYIIxW8dHgNC6T2Vyh3guZmmJ
         g5SrILHNuAnITVCN/rkuCuPLSXD5jlF4+rit3pjxxxI9cH9hDQH5YmZdLJyHhRsdVMKB
         pIFA==
X-Gm-Message-State: AOAM532Gr1SbizDaSeBpQMC21CQp4m4eIBahj21XlG06gIRIDrBkAjym
        yGC7GvhEDhl0e6jI4cmdt/+WYHIq44LiO0zV
X-Google-Smtp-Source: ABdhPJxNolyjlitctLsfFGw0Iq5X8GG9Jj2XPpzo27cyK/1MpnmQZpOOMTK9SCSE2ehkP6rkwejY3A==
X-Received: by 2002:a05:651c:a08:b0:247:eb2e:fb04 with SMTP id k8-20020a05651c0a0800b00247eb2efb04mr9442297ljq.524.1647110531727;
        Sat, 12 Mar 2022 10:42:11 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b1-20020ac247e1000000b0044842b76861sm2311236lfp.140.2022.03.12.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:42:11 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos-upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] extcon: sm5502: Add support for SM5703
Date:   Sat, 12 Mar 2022 20:41:54 +0200
Message-Id: <20220312184156.24912-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220312184156.24912-1-markuss.broks@gmail.com>
References: <20220312184156.24912-1-markuss.broks@gmail.com>
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

SM5703 is another MFD from Silicon Mitus which has a very similar MUIC
unit to the one in SM5502. The only difference I've noticed is slightly different
configuration only enables the interrupts which are exactly the same as on SM5502.
If we make use of different interrupts in the future, this can be improved by having
a separate struct for SM5703, but the main functionality (detecting cable or OTG adapter)
is working properly.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/extcon/Kconfig         | 2 +-
 drivers/extcon/extcon-sm5502.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 0d42e49105dd..88a8b3d7d78a 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -156,7 +156,7 @@ config EXTCON_RT8973A
 	  from abnormal high input voltage (up to 28V).
 
 config EXTCON_SM5502
-	tristate "Silicon Mitus SM5502/SM5504 EXTCON support"
+	tristate "Silicon Mitus SM5502/SM5504/SM5703 EXTCON support"
 	depends on I2C
 	select IRQ_DOMAIN
 	select REGMAP_I2C
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 93da2d8379b1..17a40c3782ee 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -798,6 +798,7 @@ static const struct sm5502_type sm5504_data = {
 static const struct of_device_id sm5502_dt_match[] = {
 	{ .compatible = "siliconmitus,sm5502-muic", .data = &sm5502_data },
 	{ .compatible = "siliconmitus,sm5504-muic", .data = &sm5504_data },
+	{ .compatible = "siliconmitus,sm5703-muic", .data = &sm5502_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sm5502_dt_match);
@@ -830,6 +831,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 static const struct i2c_device_id sm5502_i2c_id[] = {
 	{ "sm5502", (kernel_ulong_t)&sm5502_data },
 	{ "sm5504", (kernel_ulong_t)&sm5504_data },
+	{ "sm5703", (kernel_ulong_t)&sm5502_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);
-- 
2.35.1

