Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ECA58E0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbiHIUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiHIUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:19:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7A10AD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:19:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso26348pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lgaYMtvXAvEV/Ho11rGuZwK8z8qOmKIv1XQUoKmBom0=;
        b=Rr49S6enPzOon1+0rfWT1HYdfecyoRKPKQAHApNe5/mYPNbTEp3AT0H4+ofY5+C7Ho
         T5hkEXr3UH4HTtY0OPvKSezVgZCu3ttWzKZuHmYR2yaB78T2ImqsGq8x6MjKoCJBzb9s
         LX3QWuNs1hO8UjpPLmOtWMY8WYYGec/QLbi3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lgaYMtvXAvEV/Ho11rGuZwK8z8qOmKIv1XQUoKmBom0=;
        b=f2IjRV3OQLnYHGjyH72NzhtsrZU2Y//qqaDqJCnyP62gMhvqVKpdFrWOGZHOtodNz+
         bdg4qsv/BYSyIzIm7eGl+cGgYbUVt1AMxeo7KI5CrrNBhI7uIs6nSmMKt5c8M49tzHcH
         OTAXi5PX1Nr2ehMq7FvwOdrZ9uhQJZPpDACjen7+GMF8P+wT3QNfW1jbHdJqbNWWU6I/
         Y5ftjZ3+IGjR7WUa8PHfSCzs1TkJEL8/tx/tzjHQ3IHl41ypzWcYqunNLFSirUtf3AYT
         mZytqu0fqdnrNpG93JE6dbBTjxEZdH3tpr0LgnqoLNiSn/lZ8yrZFsp97Z/bAnRarxQC
         nwKA==
X-Gm-Message-State: ACgBeo2D/OMDD77w22xtcqlroo/Lh4F0Ei+QYHkLqfVhMHWTfrC0Drb5
        IsG71YB0oMZGBAQTdUeF0K3ek5vBVDvs4w==
X-Google-Smtp-Source: AA6agR5aHZs4bFslLZr8T2oIVblYnKdXjsyGJfqOmrwxMrTmj7OV3/X39z3FXgK5WZknWol338SBuA==
X-Received: by 2002:a17:902:7247:b0:16f:8361:ba26 with SMTP id c7-20020a170902724700b0016f8361ba26mr24559334pll.83.1660076377553;
        Tue, 09 Aug 2022 13:19:37 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id kk13-20020a17090b4a0d00b001ef81574355sm12792pjb.12.2022.08.09.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:19:37 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>, shawn.guo@linaro.org,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Da Xue <da@libre.computer>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] arm64: defconfig: Enable GPIO SYSCON
Date:   Wed, 10 Aug 2022 01:49:21 +0530
Message-Id: <20220809201921.703287-1-sunil@amarulasolutions.com>
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

Enable driver for SYSCON-based GPIOs.

Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
Changes for v2:
- restore existing configs.
- change subject and commit message to suit the change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..52623c2b505b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -549,6 +549,7 @@ CONFIG_GPIO_MPC8XXX=y
 CONFIG_GPIO_MXC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
+CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_VISCONTI=y
 CONFIG_GPIO_WCD934X=m
-- 
2.25.1

