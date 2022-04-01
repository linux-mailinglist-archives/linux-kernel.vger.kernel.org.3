Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8924EE9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiDAIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbiDAIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:51:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5725AEC4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:49:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yy13so4442120ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyxaGkdBaFbFDBr0XmiSIvVcCyMDB5oUwgvGK5gLUz4=;
        b=HwTRGKsANBcBbiq4uCmILV5o70O9u5TO3NcYg7vCaepmazGHHkxf83ZWDqsmaGKpl9
         bPUGqtwo4WFsAnlA/ovSf3/JSDDqg44hsuUKnRuqeEisN7KYBjpli1Zgiban1/q/EwAy
         FB17iCg+us+vXAWdlVFHcsjIEnMkSMzr2yAEZIFcQKeiD/vXhuApeI28hGPdLQuyMztR
         PILFll/Lo7yVAhuKmjpOUaiYcfIbJeNN1S3nJ4gknmPBoCOe9yaFIa+rthzJZMo2zfdb
         9xQYNOIL5f7Wrv9D7AeUwqJWs0NGyzGhsFz9JVgEgG9uMHptV+pFK91TPlaZfUAhu+Ut
         2h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyxaGkdBaFbFDBr0XmiSIvVcCyMDB5oUwgvGK5gLUz4=;
        b=AE7eWSELRpU3ct4yrjrEDQw9X8yx5yFSF5SA8ACuB+QPOYihmLRq5DvLva6yiPwy/f
         uJTeLrJo6LOtMYcvPfJgfvBAMDGUAkOmtIN3gH9n0wqInpJKnOe7+m2OkwbMABxFhdxx
         c6cZgR1nK8G2y1vMqv5hJVrn7DBF1QwNwgFuS4+lDPJ4Bk0cK1fAp5K+eFgrQcGdanpC
         Uz7i8ZGhRFiY5kxBrKNsGBJsRYKrQoyW+dp1kn21o5fg7MpzHh0ZYEdOjkeMpfpbI8um
         DGjMEkzHWwVI/BfcNrbqlvaA206dPXxL53lqiQvIK59ARwgH1QAkd5luVuBWHmoDE+oq
         2unQ==
X-Gm-Message-State: AOAM530FiXnjFGNYKA1lhB3PHo4xbg9weM780EA2PyL6OogrmP2DwhjF
        nvQwcShz1F3G53pAVZK2GK6jFg==
X-Google-Smtp-Source: ABdhPJzAnKpzvuNc8xtUDGSi4nQwIexbeJOFciJ4pqF5qnxo6KsMiAq8ta3Q2qmXSdXORspNRuyqXg==
X-Received: by 2002:a17:907:7da5:b0:6e4:e40f:60a0 with SMTP id oz37-20020a1709077da500b006e4e40f60a0mr225232ejc.486.1648802995649;
        Fri, 01 Apr 2022 01:49:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm905361edv.65.2022.04.01.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:49:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] PM: Domains: Extend dev_pm_domain_detach() doc
Date:   Fri,  1 Apr 2022 10:49:50 +0200
Message-Id: <20220401084950.118998-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Mention all domain attach menthods which dev_pm_domain_detach()
reverses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/base/power/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index bbddb267c2e6..72115917e0bd 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -172,10 +172,10 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
  * @dev: Device to detach.
  * @power_off: Used to indicate whether we should power off the device.
  *
- * This functions will reverse the actions from dev_pm_domain_attach() and
- * dev_pm_domain_attach_by_id(), thus it detaches @dev from its PM domain.
- * Typically it should be invoked during the remove phase, either from
- * subsystem level code or from drivers.
+ * This functions will reverse the actions from dev_pm_domain_attach(),
+ * dev_pm_domain_attach_by_id() and dev_pm_domain_attach_by_name(), thus it
+ * detaches @dev from its PM domain.  Typically it should be invoked during the
+ * remove phase, either from subsystem level code or from drivers.
  *
  * Callers must ensure proper synchronization of this function with power
  * management callbacks.
-- 
2.32.0

