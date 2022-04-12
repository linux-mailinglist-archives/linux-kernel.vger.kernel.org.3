Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE914FCC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiDLB64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDLB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:58:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97B2182D;
        Mon, 11 Apr 2022 18:56:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q142so15759952pgq.9;
        Mon, 11 Apr 2022 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sM5FjahbxiDWtBMcPGoH6sjK50a41Jzz6Kf8kK5IDIA=;
        b=Vb/IP0/ckbo8JnxvOIqofc/GCxVL5OwLwa2/kVvlfWhHBj5G7Byk5xMS+tct28pghZ
         TjiX3jRqDNqNJRMws9ao6amJT7UsZ34eigDIyTwmZMS7Ni61Mi/olKMbLZdYFvQxdj42
         57TwBOzAz7v5OFbDeALkA+a0kLtLFJJcN5kmFvgTZR5LrhWchnZNNsKENwWvJshWtCl6
         AtCcacnD6C2Oi/X8J77PhIIFq2QSY09G/tzc/a16o6RnMxR4amjp6NXs7RcKSBab8wzG
         FOcfqhL/QCvsohG7Vzqypqru1DVwekKsExWvYpZgT/dYWMf34rGB4kQSUED4UgIscY3w
         bmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sM5FjahbxiDWtBMcPGoH6sjK50a41Jzz6Kf8kK5IDIA=;
        b=Rhcsz5TGf7WNUyQTBIoTxKWNVb3s6FSA9xTR7te/3VCzKX+xyzWnvr8vmWb8kj3bkK
         afbPrTc9CMMSI0Fw+NIKDB6esbwksfdM+MwXF9ZiYoNTcukbavPm7hUpBn0jL6bYsgQj
         QAKBYw4tvPN7CCONm606pGNZ3t6uhQN5vw/nepUJ0VaQtVdzdmtPhKnM9JykuUBq+nwh
         0JSZXyds2xIt00/WunYco9q+chOUNyRIxZByEqmXF/iUdDL/8ie54GPV0mHT3Yb/RqLI
         en/hs8l9+pxpGzquF09jrrWyokbpvf8skSAg4bAATcIYtwjtZr32PF2mY3okhBBae39w
         SONg==
X-Gm-Message-State: AOAM530H++1NbHlEHPYWHf2vwgN80qbBbrT68lstkvXkV3oHD9ufVpLg
        8LN9/yz7kj0MWRp27wSfEgY=
X-Google-Smtp-Source: ABdhPJxaKYnF/FBKWSQfNDG/CffffK+XXw6W3BSTU7WQBeJ+uvZ16E1x2om5zLruk4LPuCuEc+5eJg==
X-Received: by 2002:a63:140f:0:b0:399:3005:baf5 with SMTP id u15-20020a63140f000000b003993005baf5mr29409036pgl.193.1649728598072;
        Mon, 11 Apr 2022 18:56:38 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id gn21-20020a17090ac79500b001ca3c37af65sm746815pjb.21.2022.04.11.18.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:56:37 -0700 (PDT)
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
Subject: [PATCH v2] iio: stmpe-adc: Fix wait_for_completion_timeout return value check
Date:   Tue, 12 Apr 2022 01:55:42 +0000
Message-Id: <20220412015547.4137-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <60e67c07-7e40-4187-a90a-1be9acdfe757@gmail.com>
References: <60e67c07-7e40-4187-a90a-1be9acdfe757@gmail.com>
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

