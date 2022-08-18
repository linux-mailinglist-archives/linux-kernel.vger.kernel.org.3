Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C85597AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiHRBVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHRBVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:21:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB229C515;
        Wed, 17 Aug 2022 18:21:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f28so238766pfk.1;
        Wed, 17 Aug 2022 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=bQ9h3/m4DKwQOMZt0ypQf8mAiw8P/AmyzNZlTqdNR8s=;
        b=EEACGvg7LkDUIb/BCBN3mMig8Jx1dR4mAUNTTMR6YnL/eSymKP9UH2i42LnSp5HeFU
         err8JQj/S1jC19rfWxVf5iHOsLF38v35mNDNP662nUdC6x2haaFRefEExiam2mcMpsI0
         5XW82fuH0/sljZMvi0QvnbXqpeBtvQQx9V2LvLKbIRuQljvZcTqhFitvFZRxQ68RcVWT
         wStFqIowg9PUFbsg0g/LAlyq1vzk2xV107VM8AUpubEVZGT2jFHwYKpE4SKa4X0QVvX6
         0TO9WD6AR021fVPBNcrcZecNx7uCq8KKMQ6KVKQHVjEexyhflY/3S+OmEGT/gsUv7HOU
         tluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bQ9h3/m4DKwQOMZt0ypQf8mAiw8P/AmyzNZlTqdNR8s=;
        b=2LEr26HT5m6m0KRaJQyQbs2CxsoCvL4VqMlt6busCuW+BaYFRfn7i6HAJXj97j5FXg
         mm0Q0w9farbcZuoOb9P36kzQFtc2o3aJrpS4cdb8bm+zRRni7veUhIDoCNIsAlPpR2BC
         3uiL1/HAk8zCiIxRltW2hJSa5x5BvBxzOz75wdmrOgQBMeGPMjaP3K1y4UltK2/EAawt
         Sxjt7CoeIvnbWIVticDIgqs0ZY+raX0se5jmqwrIUyAcNBJmvEGNohuwhhDd47szRtP+
         8x4mqrZN4CPHf/wIBZP4qHDf+zXGWoZ0+OhRLc6aL12LM3/t0TsR8JVGIt+mxatT8YUu
         p5jQ==
X-Gm-Message-State: ACgBeo3z9iemENhH3tVgbXBb/x8VpfePhEKesr5vQ8DTtAbk2aMDWT1Y
        5PLJR1fy75pCBNqju04vT4M=
X-Google-Smtp-Source: AA6agR6ithQHu1bJS1mVjIkXIiyjpWfTqXuGGPEgJeN7grWQGgaFD+WoySBH7K9DD2nx5FumpKwmdg==
X-Received: by 2002:a05:6a00:1910:b0:52f:13d7:44c4 with SMTP id y16-20020a056a00191000b0052f13d744c4mr769959pfi.32.1660785704323;
        Wed, 17 Aug 2022 18:21:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57a:2602:4c40:2a8:e5c1:f4fa])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm51691plh.209.2022.08.17.18.21.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2022 18:21:43 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add Richtek RT9471 3A battery charger support
Date:   Thu, 18 Aug 2022 09:21:34 +0800
Message-Id: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
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

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v3:
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (2):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver

 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 953 +++++++++++++++++++++
 drivers/power/supply/rt9471.h                      |  76 ++
 5 files changed, 1119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c
 create mode 100644 drivers/power/supply/rt9471.h

-- 
2.7.4

