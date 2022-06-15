Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD954C262
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiFOHIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiFOHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A5286D2;
        Wed, 15 Jun 2022 00:08:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso585327wmr.5;
        Wed, 15 Jun 2022 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLemtYN4NjZkALXs/YgJEqQjUNQmyKqkJvuZKJ4dSUA=;
        b=TPvS/VbcNq+6Ypae95gBaHJ4vzgFNq9zVh1oqgug4WGPkNezDU71whbmowt+brLCQD
         gBEOaPbE030U+bmS+tEvLrSPkT3QMhAHAEASiu/LciN7x3KdX9JsiZXGgurBxxuMe/DE
         90/kuxnFrVy2K4reY3E0U5uC2f1U+jTOY6YcOCPrkVzCaFI1IicfRahkp+ca4jsEzBmY
         g35v8qmnAm2BXeGxeWOHqPDbOpJGob11qV24Wk1pNX1Bkug+Pn28nbHMnZQ/riHesrh8
         QjbUGgsK7Sws76W9+ZzQeSfiX7C8o0dczUKITjvKKd5gIsRQA7ActBYJQI4iaUWstWKj
         mx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLemtYN4NjZkALXs/YgJEqQjUNQmyKqkJvuZKJ4dSUA=;
        b=vXrsPhLimTf4hIC6t5SToBn769mJn/Nih/XVXorEyYVwHNY3fd9PHklP2Ft4au8Csf
         XxyXHaUwNBJFi83DmLLSMvXyRlprp1iNzCsHPvRqHt0gtkd+z82sJ7GU86XgxZ6H9TcC
         MM7PEL4FYlr8YiB3JbtEWr45wdx6xExrWmDfieym+vq9xuoJCHymSl3yPPtJOx4STWPz
         /9G6zs95Nb9FJ6F3E8c7fkLeCCw8/4XGwSQVDLQASZbIj7zfeh3N1419sB6RMAzxUPxG
         s9A7QiO6it3pgsOgC+3vNuBtnO8/Tf6MTL7Hqm0X9Tckfi7Qij654MdcXM9xN9OkXZTY
         gc1Q==
X-Gm-Message-State: AOAM531NI5S/wSvJgWUfiU77NFehipN4ydrxSycrHI/EgssNBXWLiNNT
        gK5S35/Fk1I8q8IozCM3BWgQbMrSVGM=
X-Google-Smtp-Source: ABdhPJwNiuycHQju8APe07AfqZFN0zr3QM0A1FSN64O19b05aJ62C/MzuRo6CLKYkDw4Bd4pey9ofg==
X-Received: by 2002:a7b:c7c3:0:b0:398:934f:a415 with SMTP id z3-20020a7bc7c3000000b00398934fa415mr8371171wmk.27.1655276910397;
        Wed, 15 Jun 2022 00:08:30 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id e12-20020adfa44c000000b0020fee88d0f2sm17160103wra.0.2022.06.15.00.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:29 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add PWM for MStar SoCs
Date:   Wed, 15 Jun 2022 09:08:08 +0200
Message-Id: <20220615070813.7720-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This patches series adds a new driver for the PWM found in the Mstar
MSC313e SoCs and newer. It adds a basic pwm driver, the corresponding
devicetree bindings and its documentation.

Daniel Palmer (1):
  pwm: Add support for the MSTAR MSC313 PWM

Romain Perier (4):
  dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings
    documentation
  ARM: dts: mstar: Add pwm device node to infinity
  ARM: dts: mstar: Add pwm device node to infinity3
  ARM: dts: mstar: Add pwm device node to infinity2m

 .../bindings/pwm/mstar,msc313e-pwm.yaml       |  47 ++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/mstar-infinity.dtsi         |  10 +
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |   8 +
 arch/arm/boot/dts/mstar-infinity3.dtsi        |  10 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-msc313e.c                     | 242 ++++++++++++++++++
 8 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
 create mode 100644 drivers/pwm/pwm-msc313e.c

-- 
2.35.1

