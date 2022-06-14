Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A232354AF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356171AbiFNLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356034AbiFNLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:07:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49CB96;
        Tue, 14 Jun 2022 04:07:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so16413067eja.8;
        Tue, 14 Jun 2022 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQRKcneckEoQfUsqmL/gDuP5mWDW/X0t3xQBfS3Jwuo=;
        b=kLGoYYcwIJ6dy51CeEEDy8kuyJs/x+mXeTbeBBcigCk4pJ4loGmskQ2xP1f2ONBfye
         wRKi0C6TScDpNEXIuRFNvYCRlWfPBWmA+spZXr/h/vNRAAzf9IDJs6f9CIQJ3hcE65Jr
         IUJFT4NfwQ4wAEcLEhuPIAEyQQw08rTMn6HidDUirxEmFs6kyFIC9KzsEoGqMiCu47mw
         7BcPS+t2f5jDNYCn3VLXbjztNBru6Q6Y0jnut68IptCKvUgDitrAcWNHA1aMAcU71qYT
         glL8NwhWp8jKkrKr8psUW3onOiilQqp9EeeDRTgYd6kKgQgNDky6P3EeqlLI8KetXqsz
         u6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQRKcneckEoQfUsqmL/gDuP5mWDW/X0t3xQBfS3Jwuo=;
        b=W8Ki+Ck9o0hUD6q+/dlwTx54VQCEGsQ4J/1ASUpDjeuq5lqcxSNipqyskg9GcD8wrC
         5+cGdHP4bQed+uiOhOfoXWSbJKmiy/96WHcuNdtJAXe0uFgeZoE8DUzmxzQ/wwnaubLr
         NW56ki21DTKqoL5o0WybByAYveF/c655gP9xCChai/BLob3rP1xv6witT+ZiPnuuo/po
         QrDH1/eOzLNuXuoz2kkA60VJIE8OR/0UngrrcZEryFJ1f4gcKNl+W1arTkmza3hEpxnH
         ik6t1jf5DdlAcQWTGWiSK3jR2xgoSUA2DbydWd//5LGPbInaAjKG7yAMEkBVltD51oZI
         ms6A==
X-Gm-Message-State: AOAM532/FkgZNqcan5lrUJ0RgItxqTnfCqu1KwHKmuxPdaZGU8c/mnYX
        f5DcAaKYZiMO82/mrfN8Fwo=
X-Google-Smtp-Source: ABdhPJztbuXyv1YfbeZOKjCqoXuR2KgLu6Mte9TpLLqB9kpU8+xb6nsz8Nu7M7RYMAu7rQlpAA3Wng==
X-Received: by 2002:a17:907:7f2a:b0:711:dbde:19a1 with SMTP id qf42-20020a1709077f2a00b00711dbde19a1mr3736907ejc.87.1655204843822;
        Tue, 14 Jun 2022 04:07:23 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id cb2-20020a0564020b6200b00433b5f22864sm6867456edb.20.2022.06.14.04.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:07:23 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/5] PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
Date:   Tue, 14 Jun 2022 13:06:59 +0200
Message-Id: <20220614110701.31240-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614110701.31240-1-ansuelsmth@gmail.com>
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
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

The cpufreq passive register notifier can PROBE_DEFER and the devfreq
struct is freed and then reallocaed on probe retry.
The current logic assume that the code can't PROBE_DEFER so the devfreq
struct in the this variable in devfreq_passive_data is assumed to be
(if already set) always correct.
This cause kernel panic as the code try to access the wrong address.
To correctly handle this, update the this variable in
devfreq_passive_data to the devfreq reallocated struct.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3c3322adea03..be8aa6830413 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -395,8 +395,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	if (!p_data)
 		return -EINVAL;
 
-	if (!p_data->this)
-		p_data->this = devfreq;
+	p_data->this = devfreq;
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
-- 
2.36.1

