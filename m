Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4B4FB9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiDKKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345630AbiDKKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:32:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B95434AE;
        Mon, 11 Apr 2022 03:30:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q142so13769334pgq.9;
        Mon, 11 Apr 2022 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=VrMR8gvOFjWxaufbBwSvKiS63Y8OuXOfxSp4uF7zIAw=;
        b=bynoAbM8exJk1RavUb1cy3mTryf26m1U2TStm4n/kw7GwzM6YE+84/uNbKwfjsoWtY
         T9Ad79+XdDBOj4YhVgsoRhWpiJg+hu3Mg1N3O6m65iMZUmsNW6+bk4GCrLDfpX52O059
         mpkL4bf22MXomVHepqv93Mf1CMjAN0nTQdftgaoqSS8zn2fnJBs/qj/HFaRbG2aULQU2
         zgSpG7JTQQNtlhvCgQ6pZvzHicROL1kSegg+HciTD2M+FPuXJkp0rnCOWX1d/k2au351
         0YdDWf4ZSUkT5ETpf7L8mn3kJ2maZoC+4RdBKfrtYuvhflgySZcDVaTzp0XhzL+Yx4rG
         lyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VrMR8gvOFjWxaufbBwSvKiS63Y8OuXOfxSp4uF7zIAw=;
        b=R7CUDJ7f7N7Rv1J9l4uWKzzIfnEYgmtc0HeiBfiBDipow5AFCjMu5fQPO3AB7Bbjee
         hLt9oJmJ9nRAUFHBYa7mNuiQ3Zsc/f2ki7gcIWuw/v4S+wMbrLk7pUPlVnAvKGmlEwoT
         JJhaIs7en83F7K+8p0I8MFWCAuK2Xm2mFYdE0CAKWR7mRjh6EOcRczsR+VWLIQ2ff+jL
         UQ7XsYNNmLNq2RqpaSYXgvDLMnkkpHO4pjr1BxTaOx19jnrSB7AgwLd6o/cwRJf0gzPI
         HgJi7hhhXhAT+9v2HKrwaMsCF+FLQkNnVQv4zDY0IzUvFzfQHKvmPVGApDz20klxRdXT
         qBvQ==
X-Gm-Message-State: AOAM530vYTN6uP61TCrUoPdmDe2JQGafxFu/dOv6NZvRfkKiX6Rl3tj/
        USVrVm+0Tsq94H180iFwkqY=
X-Google-Smtp-Source: ABdhPJx0YrCFIkJmWNOPe3U/JuGUNRw8r6HGtDaYdKEXEkFfWj4uwqx3GF4DBIzJEzmlWnwoDkFvmg==
X-Received: by 2002:a05:6a00:891:b0:4fe:1262:9b4e with SMTP id q17-20020a056a00089100b004fe12629b4emr31867142pfj.21.1649673039947;
        Mon, 11 Apr 2022 03:30:39 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s24-20020a17090a441800b001ca9b5724a6sm19450645pjg.36.2022.04.11.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:30:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kees Cook <keescook@chromium.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: stmpe-adc: Fix wait_for_completion_timeout return value check
Date:   Mon, 11 Apr 2022 10:30:27 +0000
Message-Id: <20220411103032.14038-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/iio/adc/stmpe-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index d2d405388499..d475d1c17bfc 100644
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
-- 
2.17.1

