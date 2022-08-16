Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC062596458
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiHPVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiHPVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3D7968E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e27so9337895wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HuqHqoFYbmtNt1MbnMSurpMVLV+OAZ1x57LShZb1XBM=;
        b=Yj6eE7ccW/ktm/xcV30WSBmrxc3J5OmARqZCCNrpzmdURThYsWcpGPCCocvhZvZRgd
         7QQRMhbOsLqgU5vhLc04+aWLstivwCsNVkwgvjDEmfGSEPxAullIqcfVUyQ4jT4gQ2Z5
         qAzmNsPxjEqUU2xXTGUN0KHBQmQ8ugyOPXVFe7wbVfTWHoRCVbtkVJZFmk978Gu5yG6V
         GMYHuT7XakISmhupJDDtk5rUEgQPvLq67+3sNZ66oy2TgQxVo67QE/htpKPBkhfyApMQ
         Eo/OkMR5a661imu3sBNsr8tHg+Xt6RQcS2N7wtPP9J7kcHqJmYDa658JUnWZikUwYdnV
         8Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HuqHqoFYbmtNt1MbnMSurpMVLV+OAZ1x57LShZb1XBM=;
        b=0X8y+6vxRM7RSg/XfZExJw7+bxsG16tOxeRxetxIHblnCXvIoaLInJFgz91XvHwPuC
         UwFxCvM38a4wFAkQHnp8s8tZ2HYZjh/GYDdahFKnXIpxMSbogE/XrcAcVyJ1VEPukYaF
         ygPoOFrsDkbvKkK5jZ6nIGVUI7dmXdqWFASjZUkGfB55r3d0W2qiw8kAqZF5s+iT5ny1
         paZQ4E05uV+8OIMZQnHUu5VLtEC3w7YRfF1OODmQ4Rb9xdA4jhkgfH2Uk8OhLJdGJETw
         eTs2+ZBjCcrGMWUhC8VFw70RjKHF8CLBcq6QIKdgeMS/6V5NH+LVkyrZzTGvi0ykNCGT
         37sw==
X-Gm-Message-State: ACgBeo11CHL6KIN5TPEJqB3afwO9lVbt5PGWGChhWtXETDmBmPxDDTXt
        8aIy5hgPBLbYdC5hqBAWddAlTg==
X-Google-Smtp-Source: AA6agR7BISwCp1m03wwXCyXQk0ImeL1WjqIbpZ774JlEOuyVF/+MzGAUkAMlcayO5MjOPT/OO5WM8g==
X-Received: by 2002:a05:6000:812:b0:220:5a66:ebd0 with SMTP id bt18-20020a056000081200b002205a66ebd0mr12834998wrb.519.1660684496835;
        Tue, 16 Aug 2022 14:14:56 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:56 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 00/10] RFC on synpsys pwm driver changes
Date:   Tue, 16 Aug 2022 22:14:44 +0100
Message-Id: <20220816211454.237751-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

New version of the pwm timers patch, hopefully all review comments
are sorted out, however I have not had time to fully test this and
I do not have a PCI system to test it on either.

The series has been moved around a bit to try to get some of the
simpler changes in before splitting and to make the OF driver a
single addition.

v4:
 - split pci and of into new modules
 - fixup review comments
 - fix typos in dt-bindings
v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming

v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency


Ben Dooks (10):
  dt-bindings: pwm: Document Synopsys DesignWare
    snps,pwm-dw-apb-timers-pwm2
  pwm: dwc: allow driver to be built with COMPILE_TEST
  pwm: dwc: change &pci->dev to dev in probe
  pwm: dwc: move memory alloc to own function
  pwm: dwc: use devm_pwmchip_add
  pwm: dwc: split pci out of core driver
  pwm: dwc: make timer clock configurable
  pwm: dwc: add of/platform support
  pwm: dwc: add snps,pwm-number to limit pwm count
  pwm: dwc: add PWM bit unset in get_state call

 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml |  69 ++++++
 drivers/pwm/Kconfig                           |  24 ++-
 drivers/pwm/Makefile                          |   2 +
 drivers/pwm/pwm-dwc-of.c                      |  86 ++++++++
 drivers/pwm/pwm-dwc-pci.c                     | 134 ++++++++++++
 drivers/pwm/pwm-dwc.c                         | 197 +++---------------
 drivers/pwm/pwm-dwc.h                         |  60 ++++++
 7 files changed, 402 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
 create mode 100644 drivers/pwm/pwm-dwc-of.c
 create mode 100644 drivers/pwm/pwm-dwc-pci.c
 create mode 100644 drivers/pwm/pwm-dwc.h

-- 
2.35.1

