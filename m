Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1B574531
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiGNGml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGNGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E73201AF;
        Wed, 13 Jul 2022 23:42:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a15so1822178pjs.0;
        Wed, 13 Jul 2022 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zhjFLQE+pIwK78fFAm/7JZC7JiyhANfhrb3g2gcHtdM=;
        b=CGsSQaxkdNEuTXesN+wwdS0KwZwqcUqTdBF1fcUhQM/oaDiIlJpJC4wlLJmUf+ujKm
         MZAJhAI0nE17Hcj6bXHQF5IWfxAM8cLv1sDHkhhXX+BBXcZ4c+8zxNb7jjflYmSlZOJM
         G7GFj+QRf8dOJseQO0HwZaPox/52VFvP2IscFHG8rCCn3KzrjglRW/8D1jLvBKZxvyJn
         /vlHrRvgYTb2MHRduDRwsmS7uPvF6alt+MjYN1nnYT7mLwzbA510OpHx63dFYfZN1K5X
         g51rz/HvU9pk/LqrykmpOBR/AqwmbNtUR4guH0kbIjVTS0Mq2OeJPWlq3pvE/Q++rG7h
         ea5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zhjFLQE+pIwK78fFAm/7JZC7JiyhANfhrb3g2gcHtdM=;
        b=CY2f6+WMcjXu1leE2q2LQh3HXM3GhPlnR2ss1tUIvKTjlF2bPQOD07+TDFA1pUMEzb
         av4kpVj+fCddqG82D4gcXjuXdq+B8yBfs+Xpxh7rudsqBeQtKXeoklzOazeHWpSbToeI
         MuZNi2k9TEUbrSPJGH2uOqFECbFfz145QLupTqTtbeinmR430bffzJSobqej9umXv3Qb
         JtbnPBYFFK+q32wqII8Bdyiwcr/DrXA8ku9epAB8DcWsZqZbQ1YD6Wg2+DGydSRJ6tH3
         ViRFF8cHH+8WJk1Dot0+Ghqc+GCIykl/jxQsvRSlseZ5ooc7Rwh3gu3O55/zgkIp/bZQ
         xMVQ==
X-Gm-Message-State: AJIora8EyYH3TeMxoGXjRsrnHtbnUxBm0P0oaiq24w8uUfurBXmsYS21
        XI/BLgfyzAQBhUjdULG9eHA=
X-Google-Smtp-Source: AGRyM1vj1iaTBz0ikUkNGNR9/bQwSZBaaOxCIS0UjPP7y6s2tszgzxkR721FMGBwLR20z5Po1bSBXg==
X-Received: by 2002:a17:903:2043:b0:16b:deff:28e with SMTP id q3-20020a170903204300b0016bdeff028emr7210254pla.70.1657780958292;
        Wed, 13 Jul 2022 23:42:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:199:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b001ef82e5f5aesm616291pjb.47.2022.07.13.23.42.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:42:37 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 0/3] Add Richtek RT5120 PMIC support
Date:   Thu, 14 Jul 2022 14:42:14 +0800
Message-Id: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
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

rt5120-regulator can be referred in the below link
Link: https://lore.kernel.org/lkml/165599062767.127406.12571486984170083213.b4-ty@kernel.org/

Since v3:
- Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.
- Simplify the power key irq handler key report
- Since press and release irq not needed to keep in private data, change 'press',
  'release' irq as local variable only.
- Fix Kconfig typo for pwrkey.

Since v2:
- Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
- Fix indention and remove status for powerkey.
- Refine powerkey description for more HW details.
- For the regulator property parsing, use of_property_read_u32 instead.
- Not to overwrite regulator constraint.
- Refine regulator desc coding.

ChiYuan Huang (3):
  dt-binding: mfd: Add Richtek RT5120 PMIC support
  mfd: rt5120: Add Richtek PMIC support
  input: misc: rt5120: Add power key support

 .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 178 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |   9 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rt5120-pwrkey.c                 | 105 ++++++++++++
 drivers/mfd/Kconfig                                |  12 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rt5120.c                               | 121 ++++++++++++++
 7 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c
 create mode 100644 drivers/mfd/rt5120.c

-- 
2.7.4

