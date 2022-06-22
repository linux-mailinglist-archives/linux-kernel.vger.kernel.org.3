Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711615546DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiFVKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiFVKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:01:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7A3A18D;
        Wed, 22 Jun 2022 03:01:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso16288383pjg.1;
        Wed, 22 Jun 2022 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LCYMCJjVsXAzcWwbG2hM+Ex1hWpGWp10miCQHz4y3I0=;
        b=fPzlyYJO/wr/7clkIc0Uui4CriLnZmraGYPXDAyuyPeRixr4IM9Tje/DzMewxFkqMs
         3MwQ9GP6lU5z8BVX3ac9Ks+sYebu5HR+gssrGQSMZG6S5NEdV0CrhA9lmZObGOMat64y
         DIG+LGM6Hlgoa/R4ZtRFh6rD5pdSLXKf2tOT5foZLV8K8nhhgqRsp8snjdOoIjsDx1W3
         G6vL+uxd4ePvT8LDdTvdgw1WRs1fYDw6QFt4z/xSQpAJDzIZZiBTKfT3mPpFTFA5YaEP
         WFxJ/m/vR/ey0j6uGw3CYzqNj9zUXb4KvAHQUQttWdBUQ0u7B17M8M4YaDycp5pGyQ2R
         0tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LCYMCJjVsXAzcWwbG2hM+Ex1hWpGWp10miCQHz4y3I0=;
        b=XXEDOlMBU1vRvjHTPXqBmmNigiGz9dqmQfGvmZA4hBLgTahefNqHsrw82JL4/jjRWA
         HQc+IGLPIBWE1zoPN9qw05FLS+d8Bj9bkExdSu4cc6Sk2fE/zBTc/4B9qXI/OS2oTuxK
         uybUC4jFO5rLCJLuu3PQNvormDzEBmHBa3S4CEfE54kyctu/uaUxEqdkaeJNiNH/wCLH
         SK+eWwELnQDOpwCcovSOSrwSBQ0OYEU1XCAsPP+sItEmq6QmkkvGDIbga4Am0VurUGkn
         57klW3wIzfaY5JIh5xPhVgQ8zQxbBKmIvesTcZIz0YS+psJVGtNfyNfQ0DzzB9OThGTR
         Dgig==
X-Gm-Message-State: AJIora+ueXDeaXaXJHIW2mc+KgordLXKV3eg0zM2XPufyWUVPUx3tg0a
        EbihR7qqdvoycprWQVxGEP8=
X-Google-Smtp-Source: AGRyM1sewV0ZPlmRpw4JicO7F9ganj3r8xcbZTTRVzERGi/ygGiyKsTKycj/SeyCB06il05WGEjRuw==
X-Received: by 2002:a17:90b:716:b0:1ec:95da:6164 with SMTP id s22-20020a17090b071600b001ec95da6164mr21260185pjz.92.1655892112182;
        Wed, 22 Jun 2022 03:01:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:d40b:4089:31a8:340d:2f29])
        by smtp.gmail.com with ESMTPSA id w9-20020a639349000000b003fc5fd21752sm12790433pgm.50.2022.06.22.03.01.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:01:51 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 0/4] Add Richtek RT5120 PMIC support
Date:   Wed, 22 Jun 2022 18:01:40 +0800
Message-Id: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series is to add Richtek RT5120 PMIC support.
In RT5120, it integrates four channels of buck converter, one channel of LDO,
and one external enable channel to control the external power source.

Since v2:
- Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
- Fix indention and remove status for powerkey.
- Refine powerkey description for more HW details.
- For the regulator property parsing, use of_property_read_u32 instead.
- Not to overwrite regulator constraint.
- Refine regulator desc coding.

ChiYuan Huang (4):
  dt-binding: mfd: Add Richtek RT5120 PMIC support
  mfd: rt5120: Add Richtek PMIC support
  regulator: rt5120: Add PMIC regulator support
  input: misc: rt5120: Add power key support

 .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 178 +++++++++
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rt5120-pwrkey.c                 | 115 ++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rt5120.c                               | 125 ++++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5120-regulator.c               | 420 +++++++++++++++++++++
 10 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c
 create mode 100644 drivers/mfd/rt5120.c
 create mode 100644 drivers/regulator/rt5120-regulator.c

-- 
2.7.4

