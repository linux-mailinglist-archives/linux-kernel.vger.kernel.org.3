Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0C51550D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380469AbiD2UDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380478AbiD2UDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:03:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A48A88B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so17323855eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6GGGspCpTAF4+99JVypFG14EZxu60b7+uyzMSAWdsj8=;
        b=mg0YVXkCFw9WcvKIC2gqT9LvZFjGgZ/etWM/vssS6AogRR0+Gizm+Adt+8o7gckoRp
         NHIdA/SlY7qfFuhF48VX7PguaAiEAyzi3fMK8fNUOMg1GQ9MOTnArURvwDxNXxaJRMLT
         zzIDNYH6YFvIiayCkW67s2hCPPxvdP0OktVqZXlzNQofG8iyoJnTvfltfwNowU2kFsvN
         s4NLmGxzR7MNMjSqfac4x+1EztHbPbGc68mNy5eM1phZaYUtsO91ZfUp2Pn1Shc8p3f5
         CfshL/nD5QksFe9vFu5wqDu956C9dPvoNRp4jHfc60UKMvVG0AfaWVc7nnaOrbc0WsXY
         entQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GGGspCpTAF4+99JVypFG14EZxu60b7+uyzMSAWdsj8=;
        b=fSPJJXpaWY4xK5yga6z7prPzuRjFfByDQJsHYz6U877XzfpTxsipM6p51t5PIvqyvY
         uRUfeeGmIGpDt/Ns8tSzGAD2g+JGbEsuqMfwTeHGK9Y//+1vOlL/Vzu/3HPT2a7wsjkY
         BZ4HBIkbNmpQ+uCwbxkPKg6EoRAIBEGYPCX6QZuGBzUFpYyGHCmLreeUyDe7IlUPix6p
         hBxz7DK3RxXk3KfNmESuI+1K0THG8AmoArEIWQRmB0wvZIwRdEkveUjSlHnr21tuEi1F
         BTB5k/+V3etOKF5udBrvoA8v3fAW19j/BhMLpCNwe34rg5bXiZcO6rHHjdeCy5riOFlt
         TMdQ==
X-Gm-Message-State: AOAM531YOHFSEjJHm5EVi7DnIRBiWrhlA1XUQreqRZMk5V4bE6Zs0Sip
        J+jamo0ITML84PzZXxVzK/KjdA==
X-Google-Smtp-Source: ABdhPJyv8UENxg6HIl+91LjuLUzautPcnzrePWq/skb36plX7jAvd0Hm86jAvadZYuzJ3q3r7h33sQ==
X-Received: by 2002:a17:907:6d10:b0:6f3:f56a:4620 with SMTP id sa16-20020a1709076d1000b006f3f56a4620mr841346ejc.733.1651262392907;
        Fri, 29 Apr 2022 12:59:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en8-20020a17090728c800b006f3ef214de7sm929486ejc.77.2022.04.29.12.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:59:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rpmsg: use local 'dev' variable
Date:   Fri, 29 Apr 2022 21:59:46 +0200
Message-Id: <20220429195946.1061725-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
References: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'&rpdev->dev' is already cached as local variable, so use it to simplify
the code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 4938fc4eff00..290c1f02da10 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -606,10 +606,10 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 	if (driver_override)
 		strcpy(rpdev->id.name, driver_override);
 
-	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
+	dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
-	rpdev->dev.bus = &rpmsg_bus;
+	dev->bus = &rpmsg_bus;
 
 	device_initialize(dev);
 	if (driver_override) {
@@ -627,7 +627,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 		dev_err(dev, "device_add failed: %d\n", ret);
 		kfree(rpdev->driver_override);
 		rpdev->driver_override = NULL;
-		put_device(&rpdev->dev);
+		put_device(dev);
 	}
 
 	return ret;
-- 
2.32.0

