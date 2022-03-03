Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62E4CC343
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiCCQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiCCQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:52:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED019DE90
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:51:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b9so9558536lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0hlDMq4glELTxqqeCYQhCGVz6ASynOhyADKIGNkHxI=;
        b=lM+FtnlKckXCQpElr2JR138CKdeX+U2eun4ELTIZ4sBj13l1AyGsYj/7EbHk76vCy3
         9uZ3XCUX/iKFykOm6EMZNk3bW6ElUA0DOK3o/9ae8J7YDlZv94eOunX4aC1a65y/dMHX
         Jv9rjacTnnoq0vF/+I+UVl281Fmbve3tsoMWsnftCNg3k5Wa+6vWwvQSgx/X3P0MZHsM
         OGW3BGtkPwrceeR/E1z//0w8RGdkjhN6JHG7dQyuFYJNmtfXT1pWbM0vkXqiLwwfZFSc
         V1gr0L20OnEyZQBD/TyZjt51y8g+EWlP5Y3tXHnXxoQLqUfVn8IU9KTRejwkulSLiGVI
         TqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0hlDMq4glELTxqqeCYQhCGVz6ASynOhyADKIGNkHxI=;
        b=IjXIO610kVVcp2tU0l9OKIQaRtw2DnTTF1ViFM/cqAyLhIjqjiyCexQYDiBi5y9vUq
         1Loh+ITqifhyjeFtZIy5nHRS//EKEaIkClG8U8YW4IXwXDxSAGywN+UALhOPXVuwYlLY
         +R1XfJKrnL6f1vjTYQfH3/NgQmtfaIJpjI5oKAcFzDTZ5gqa24AldPuNrhxGSZ1yggOk
         2yzOwebHW7yJTZcdAp/obPZFvb7VauSIb7TPPSkWVpnS8uqxTW+vGOB5WrPmg5WARf0y
         l/myjlt2X9pVe6IfUQkGuncKywD0u6JBOj20cr6JTRRa1nIs9XXDXOeSEKwXWqiQzHfd
         8Qag==
X-Gm-Message-State: AOAM531ExDChLkOAI68awGfcQZMJgUd73JdBPA+ejWDvt4H+X7vXVb2+
        ZopqIVAlC8dAPxzBV7ljMD0DAw==
X-Google-Smtp-Source: ABdhPJz9ZBx87iKT0e1+HeehvcT+hS0gckoWv62UmqP+hGy6tSdepldUbJCmRSoXrlZbeJ6croDQmg==
X-Received: by 2002:a05:6512:33c6:b0:446:e0ce:5c3c with SMTP id d6-20020a05651233c600b00446e0ce5c3cmr1163571lfg.26.1646326306369;
        Thu, 03 Mar 2022 08:51:46 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b0044392f8d4c6sm521749lfh.1.2022.03.03.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:51:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: host: Return an error when ->enable_sdio_irq() ops is missing
Date:   Thu,  3 Mar 2022 17:51:42 +0100
Message-Id: <20220303165142.129745-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Even if the current WARN() notifies the user that something is severely
wrong, we can still end up in a PANIC() when trying to invoke the missing
->enable_sdio_irq() ops. Therefore, let's also return an error code and
prevent the host from being added.

While at it, move the code into a separate function to prepare for
subsequent changes and for further host caps validations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index cf140f4ec864..d739e2b631fe 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -588,6 +588,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static int mmc_validate_host_caps(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+		dev_warn(host->parent, "missing ->enable_sdio_irq() ops\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -600,8 +610,9 @@ int mmc_add_host(struct mmc_host *host)
 {
 	int err;
 
-	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
-		!host->ops->enable_sdio_irq);
+	err = mmc_validate_host_caps(host);
+	if (err)
+		return err;
 
 	err = device_add(&host->class_dev);
 	if (err)
-- 
2.25.1

