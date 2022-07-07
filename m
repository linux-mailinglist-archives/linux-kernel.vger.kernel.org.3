Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38C56A3EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiGGNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGGNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:41:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5618349
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:41:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o25so32516272ejm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bEbXwAUr62U9cKb63QY1rNsLN9OcySd/oWbXwZF3Pk=;
        b=ePZ/53j6e/I/lKt3xmInmcndXtVSoPWgFMLt8X5fFn4gjwRMF1rstuYm4ku6HhQy7+
         PsLRmQ5HZMNym66abIM0DLZpOVH4MWuQEz7tZecvzzUzz8vTJ21Kw3SFgGZqg9deXDde
         NsiDawpLRTkNzvYEjZyaHVvCjIaWGcnCSLH/jNi4No2D1Z2RwBgZDc7rwN7P7fuTmA8g
         9VwU7Fb0x9cLpLYBV3Cw5Pj5m75Xj+3rBhST8pJL9hkG8/4oqUIW+jOKIdQ70wgLBXeU
         BPss6XgvyXTEiVYCCWbHCD/18LyeLSipgwE35PScEc7HluGcPzriujrlwobG4ZB4IAWN
         zqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bEbXwAUr62U9cKb63QY1rNsLN9OcySd/oWbXwZF3Pk=;
        b=7ob4ZLQ6nlw3av5uvlqMBMgQvBVAE5xhldRmJwuZnCxffi2NaB9Q8sKezGWphKXb9t
         byvXyIJZ6GDH4MP/cX3doNcsLzI49pGZl+tQXDJXczkOF4470I0RrM21/SLRa3llS4tr
         TSd28vQfbUoFnXcBR0+KlSEYT/0fHP6iEaVDo+lyZjtMHtGTsR0ccwjg6XVGmG2hqR8S
         CBQ98hzQB0h4BlRgETG5Csu8RCRQJfDOQAi1zQll/qR+liPHa9IZcIklbIpygt7ohdym
         DRAVmrzhqLXEUmDXVjJjnd4rNAp63PlDmBI4QFvmM68MVDHrCnuakOIqcMJTCnZ7ny9Z
         Er+A==
X-Gm-Message-State: AJIora9ma6bOM4XHb9QZv+rVnFyY/4W4J1To+CA6SVhZBKemrEydV9Xf
        tUWiZjRJ73RZ13KyEr6OyteL/VpiczU3NJHq
X-Google-Smtp-Source: AGRyM1sflON/aidUmxMI4Ur8sCrv67VkU54H15SeO3124s5Ci7HEtN9uSfslYR/a5/6cg65cMfTseg==
X-Received: by 2002:a17:906:149:b0:712:502:bc62 with SMTP id 9-20020a170906014900b007120502bc62mr45615148ejh.720.1657201306110;
        Thu, 07 Jul 2022 06:41:46 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id eg37-20020a05640228a500b0043a587eb95dsm9550141edb.5.2022.07.07.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:41:45 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 0/5] mfd: max597x: Add support for max597x
Date:   Thu,  7 Jul 2022 15:41:36 +0200
Message-Id: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
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

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (4):
  mfd: max597x: Add support for MAX5970 and MAX5978
  regulator: max597x: Add support for max597x regulator
  iio: max597x: Add support for max597x
  leds: max597x: Add support for max597x

 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++
 drivers/iio/adc/Kconfig                       |   9 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max597x-iio.c                 | 156 ++++++
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max597x.c                   | 130 +++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/max597x.c                         | 109 ++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max597x-regulator.c         | 506 ++++++++++++++++++
 include/linux/mfd/max597x.h                   | 100 ++++
 14 files changed, 1211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/iio/adc/max597x-iio.c
 create mode 100644 drivers/leds/leds-max597x.c
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 drivers/regulator/max597x-regulator.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 9f09069cde34dcd86f5ecf3a3139fd752020812f
-- 
2.35.3

