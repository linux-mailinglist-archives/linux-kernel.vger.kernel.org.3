Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC658E4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiHJCzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHJCzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:55:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FE6E894;
        Tue,  9 Aug 2022 19:55:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m2so13068719pls.4;
        Tue, 09 Aug 2022 19:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=WO6tQqM10EHYIi2tDllBbfU+5oiZu0xp+kjAXZmD9VQ=;
        b=fGPt2iWbKcUPtUbpJePn5tIAHZ7SdQUi4IxwD/UgqI6GkyvPx2GK9kw8OY1NgtdqB2
         K/4m070tKHcKSzpKYwu6kYf94You4aJiu2Tj5SWDzC0n2Dxo06CWzFkb3/Sq5KPlERO/
         8oR36xbflcLxc9GIIXBAsEEpRvns/d4zESYVOxDVrcWFY87gOPzA4+3N40cKNugxk/1r
         M75hZwcTHrx32b8KqJ9GwmtxaKaaYkETRjxC7yW3GUVQeA0bwndkN+fPT9T9eotqu3gB
         SaoOj2RYZ7bJS1xPfMbyFzIXONW05Rv6KxvbUNVFgH9pse20VGGpMWbsEO5ASlImolyG
         bOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WO6tQqM10EHYIi2tDllBbfU+5oiZu0xp+kjAXZmD9VQ=;
        b=G1pFzw//G5X/HWriL7jnPtD7kKYXxJZYZ/fWUDNjz+9WsllbrOu0PZXieiHqeosANN
         QeMAiWQcLj9SdiTki2aWXwBWRtTl7Ff5vZ+Tt2WZJy9XXKShwuEsmkMpH/NQoXsYAxNi
         qB9WIkfEX+7PTTpaN1m3dXx2PySGz0nJ/NQ6RaKGX3hcsUeiYkaq+rNQBxQVSyI4pMTj
         V3bHTmf4H0Kym1zYXEee02dNDPJ705JSZoV9UMUF9sTUnJ70vew+UtaeYjqVADkAQ6O1
         dlIK0bH7d5sqwS8H9YXhZL3mwt6JgX41Ey99DKFcw0Jr9S67ZHFGW61WLzVGireXRDTD
         Z5Ow==
X-Gm-Message-State: ACgBeo1WEHLXWFBK2ifLPGyBNtFs9KVA5wl8G7aXWWKnCNA95EUy9Wr8
        fEHgNHGa/8i27ssRKzK0nr4=
X-Google-Smtp-Source: AA6agR4ccL0bsqHiZDiLBp/aEdJ0eH5feiNRFH/CTpVYuJNPArD7GDNymKRIs9b+Mu54CQzhqlsYcQ==
X-Received: by 2002:a17:90b:38cc:b0:1f7:2835:d45e with SMTP id nn12-20020a17090b38cc00b001f72835d45emr1413068pjb.177.1660100149685;
        Tue, 09 Aug 2022 19:55:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:d15f:416a:c0:aecd:5d6e])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b0016d1f474653sm11785654pla.52.2022.08.09.19.55.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 19:55:49 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, dmitry.torokhov@gmail.com
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 0/3] Add Richtek RT5120 PMIC support
Date:   Wed, 10 Aug 2022 10:55:39 +0800
Message-Id: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
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

Since v4:
- Add "Copyright" string and refine for GPL version string.
- Refine the comma usage in mfd. For the last uncertain terminated element in
  struct arrays, put the comma for it to keep the extensibility.

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
 drivers/input/misc/rt5120-pwrkey.c                 | 109 +++++++++++++
 drivers/mfd/Kconfig                                |  12 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rt5120.c                               | 124 ++++++++++++++
 7 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c
 create mode 100644 drivers/mfd/rt5120.c

-- 
2.7.4

