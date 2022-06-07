Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5453F5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiFGFwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiFGFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:52:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88C60D7;
        Mon,  6 Jun 2022 22:52:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso19839182pjl.3;
        Mon, 06 Jun 2022 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ogw5CSsvpaaXGZURlAkQnHXVkK1HBWHlB5QWz//Ik9Q=;
        b=LSHDyPHNWYiPhd9aFhvXZeMZ7l4rvIUdgZGJc95z/p8IVMUsEMgDxxt4bYKW86cDH7
         pcaKtpWuNM3QPl9spSZO0VuAtwE1hPOoL0ZRKRm6SfhpSeckvXmno0/S12AuAwEnMeXX
         HMgN8aIf17IYruMqiEnz0a3vVNwTEhexIjHWZQc0mdVZleZ4CbvLFHEbPLwSd1jY0VdV
         jj/2nGkeXFCwAONnjy1p/AwQVId4s/LieY7MXoXeiw9UdBQ+UfKIpNpk2QS9uGl7N/Vm
         PSsvW/ghQcfYvRMvDqTTTeFpOLMQBs33vb7OTDnB3yQwpN14w+Gfld4Nj0Wexkp3PlYc
         bbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ogw5CSsvpaaXGZURlAkQnHXVkK1HBWHlB5QWz//Ik9Q=;
        b=TGF0QH6+fBuvNdwzV4LPZAkhhumW2Zq3oPqdzKQlxhKrhCgnQSoVoymOCs3aIX5r3F
         rM0SL0F79XLiC1L6EN9PUrqeDsP/gcSFMB9lN0OSFwjxi7MturoL1YOPd6yN42eyZChR
         6h8HiNssTVWYdIdRJLqeUXXgp43/x3Tzib6XyPCVP9lFSN7/S27URh/SFCpS2jhuO4HH
         HE+Ix1oUqCVhsQW3E65AD8t/cDiggIVX+nSyYeiZL2Za82PeBUHBZ7nUrOebVo88Z8Sp
         zyFL2MoRyLXqMiQFsy9nKoylUa5K5oF2B/A+/+WiKgJqRgrnq9XgrMEKDYYtTFDSQVdp
         lq8Q==
X-Gm-Message-State: AOAM531c95CGnN3vJiwCoUmlOfS6XiDSeJpSLAGQhQrlajkPrBQaA2Xa
        0tByBCeXB7Tfi+OO/bgk+RQ=
X-Google-Smtp-Source: ABdhPJwKUJYnuFYDpS4HuEOMFjXq0u5VQn/ocFajz0YPO8VaBCHRtuFbVrX+4/4LfQ7g14HfCAgObw==
X-Received: by 2002:a17:902:7449:b0:167:9520:d063 with SMTP id e9-20020a170902744900b001679520d063mr1592807plt.146.1654581169285;
        Mon, 06 Jun 2022 22:52:49 -0700 (PDT)
Received: from localhost.localdomain ([49.216.54.77])
        by smtp.gmail.com with ESMTPSA id z41-20020a056a001da900b0051b62689ec2sm9203520pfw.129.2022.06.06.22.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 22:52:48 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 0/4] Add Richtek RT5120 PMIC support
Date:   Tue,  7 Jun 2022 13:52:37 +0800
Message-Id: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
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

ChiYuan Huang (4):
  dt-binding: mfd: Add Richtek RT5120 PMIC support
  mfd: rt5120: Add Richtek PMIC support
  regulator: rt5120: Add PMIC regulator support
  input: misc: rt5120: Add power key support

 .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rt5120-pwrkey.c                 | 115 ++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rt5120.c                               | 125 ++++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5120-regulator.c               | 417 +++++++++++++++++++++
 10 files changed, 871 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c
 create mode 100644 drivers/mfd/rt5120.c
 create mode 100644 drivers/regulator/rt5120-regulator.c

-- 
2.7.4

