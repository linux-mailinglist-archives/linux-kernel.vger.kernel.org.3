Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C24FD750
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355482AbiDLH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351710AbiDLHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171E15FE7;
        Mon, 11 Apr 2022 23:51:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q19so16335177pgm.6;
        Mon, 11 Apr 2022 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=RBbYU01e+AFbhWY3ZuGeFMRIuU/CVxN8Q/n9EQ09lHU=;
        b=a8AKCKRLwEJ+ICpyl0Ua49RR5GoUvlGs65zLny8zLr9rq8FPqaowjaciyPlu0e0Ra5
         K38C9SACTeDtneV0qgjKDJBJUEWchIR3VIhC9SpjB3IXVvUnsnuVOkKl9UFn60wHF9N4
         JMw0aiBOyEdWx9p+NYgkcgqLhB7jNVb8eS1V2+vluyREM6O2fqdKfAdlLOt1xz7uWDTN
         dws3dSdt0MyP5UQhVa68Spk7WNjnYcPTgH+KtTzNkjZwyCBJHqy2nDP9oqdP1YDoavPZ
         MA6Qx75v3pkISAyQJgVWK+UJjDfbAk4jHEqdT5BM1mpcOuzxHlGUkGZ32J3dlFvJxCxN
         SZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=RBbYU01e+AFbhWY3ZuGeFMRIuU/CVxN8Q/n9EQ09lHU=;
        b=YIqAbpAtf2hwWBiPWfpIWDryoprTp9g9xkBpfgTwBCV852cqazVIAl5tRtX8UWO2TG
         0ftFffsEWSKSEr8qBvY2gWdUy00ERydWBlM3Sku5flgw9bJgLwNcPRa9hB5YLgHcXGvo
         awaO13NC+pSoxHtGMxBoqs4Af0B3hpL7E9gpxClnIEkpmgHqy/UTZw8pwjPltgN8hXeH
         YHWx8U2H3Lpx9KDFqAbXUpGHeG7MdCY84jKQjBm6OW0271UqGHrcI3mesU77wLgyNGPg
         kGuzIMl2QrhgffkvUJ3ESbY7HipbEvyF6/mpjd4DMnCes9h27bGtx/GrvGITmEiFzESA
         u2mA==
X-Gm-Message-State: AOAM530gMkwAUxPgeaGu/7k5zsLvldYKNrycSvr9R9LPilV3tt1w4FZr
        P24L3X/TTEQ7jDAUDBDJXk8=
X-Google-Smtp-Source: ABdhPJxPK9vIH5rkg+Zivi5zxRj7BATlOjv/oQFrgbrSqTgZiffo9i573UyyUxob/kW5MlB279CmGA==
X-Received: by 2002:a05:6a00:1488:b0:4fa:ac61:8b11 with SMTP id v8-20020a056a00148800b004faac618b11mr37315301pfu.58.1649746315502;
        Mon, 11 Apr 2022 23:51:55 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm1654577pjb.25.2022.04.11.23.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:51:55 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: stmpe-adc: Fix wait_for_completion_timeout return value check
Date:   Tue, 12 Apr 2022 06:51:45 +0000
Message-Id: <20220412065150.14486-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <PH0PR03MB6786157EDA63137DF0071D1F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <PH0PR03MB6786157EDA63137DF0071D1F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not long.
it returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case

Fixes: e813dde6f833 ("iio: stmpe-adc: Use wait_for_completion_timeout")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- Fix same issue in stmpe_read_temp.
---
changes in v3:
- update the patch subject.
---
 drivers/iio/adc/stmpe-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index d2d405388499..83e0ac4467ca 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -61,7 +61,7 @@ struct stmpe_adc {
 static int stmpe_read_voltage(struct stmpe_adc *info,
 		struct iio_chan_spec const *chan, int *val)
 {
-	long ret;
+	unsigned long ret;
 
 	mutex_lock(&info->lock);
 
@@ -79,7 +79,7 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 
 	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
-	if (ret <= 0) {
+	if (ret == 0) {
 		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA,
 				STMPE_ADC_CH(info->channel));
 		mutex_unlock(&info->lock);
@@ -96,7 +96,7 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 static int stmpe_read_temp(struct stmpe_adc *info,
 		struct iio_chan_spec const *chan, int *val)
 {
-	long ret;
+	unsigned long ret;
 
 	mutex_lock(&info->lock);
 
@@ -114,7 +114,7 @@ static int stmpe_read_temp(struct stmpe_adc *info,
 
 	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
-	if (ret <= 0) {
+	if (ret == 0) {
 		mutex_unlock(&info->lock);
 		return -ETIMEDOUT;
 	}
-- 
2.17.1

