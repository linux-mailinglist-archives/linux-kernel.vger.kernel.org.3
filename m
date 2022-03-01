Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB14C83E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiCAGZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCAGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:25:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E236F4AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:24:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1331442pjw.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f20kNOMjMtE9MgJIYcqHl8IryMpaQZzT7Jpjq4RoMzI=;
        b=BT+KjkIwqwuF4SNwB4yd6YKMW8nzT7PP4Z4eOcki1C/VfniLIPMDpb0F/9Kk+vNj3O
         zSQOrHlFVXVa+aQOGotwrVX2VafupmmKghwYiZRUs65ABXc0dCjkSq7KlPIaE+xrcUco
         H6GBjsNGqpuuAByej41usyj4iFejik9C+eY/Nqod2YDpVs27MHrQd/ja6dUGmdURBZgB
         4ZjQ0FsnjFAniP0UvxogrCApsmz5i6VRo6wSPwR7O45JryBH3AASMklRUiANn0j0W2nI
         D4CFOIQN3vTs44Ph4QrR1k+8O6S0DVvpBOUXEztsenT46R1yVaWOxos0KoAyncA3U8Um
         2MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f20kNOMjMtE9MgJIYcqHl8IryMpaQZzT7Jpjq4RoMzI=;
        b=aMWUe2QAnwdnAu4cHR8DRgqqfwj+j9WLMtXZ9p+ljZyjtWu0X3ZgENERm7m6mRZEKS
         MFktVpwp/s/CVXkHVIBVGFoEySwIdUl3lLi9BFYC4tR497UmiswfMm3e+ngfa0zJiNnz
         cbNkcQbWvxWziCYI+r0wvR8SAEESBqZca/NpbX9+rHvPwh8rd80OMNNUSb9qBeNBUuMD
         rBjVdUNjcsupFCXKfcuWoM8MM8KeoCTp+Eccd6/lLzZ7ukhFy0Rn7iRprPv6ym94JdAT
         GKwJOpsEman8TGvEM2LbHEqIZTliKCtn9PAYN0GwTGWFx7rinC0LOq2VHqpbPf3Dwlf5
         cxNg==
X-Gm-Message-State: AOAM533rzMCaTpZSzaVxci80dIK7NxZFmsovGBrxppEClXO5xKjdvjfC
        x9Ro2Ox1wZ6uYhK3DtAlrQTWqQ==
X-Google-Smtp-Source: ABdhPJxT03HUKR7vqw3VGBBZ+cwsu4QEn75pI0xRdp7OSS+Xr1FHCRaqKL3jE035snWEB+/pN+R2Bg==
X-Received: by 2002:a17:902:e943:b0:14f:4a2b:203 with SMTP id b3-20020a170902e94300b0014f4a2b0203mr24063936pll.113.1646115863722;
        Mon, 28 Feb 2022 22:24:23 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm16461364pfk.171.2022.02.28.22.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:24:23 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v7 0/2] Add Qualcomm MPM irqchip driver support
Date:   Tue,  1 Mar 2022 14:24:12 +0800
Message-Id: <20220301062414.2987591-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
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

It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
interrupt controller.

Changes for v7:
- Add the missing 'static' declaration for get_mpm_gic_map()
- Add PD in MPM driver and call qcom_mpm_enter_sleep() from .power_off
  hook of the PD
- Rename driver file to irq-qcom-mpm.c

Changes for v6:
- Add new event CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT) in cpu_pm
- Drop vendor driver notes from commit log
- Check NULL mpm_gic_map instead to save the use of MPM_NO_PARENT_IRQ
- Add lock protection for register read in qcom_mpm_handler()
- Return IRQ_NONE if there is no pending interrupt
- Drop IRQF_TRIGGER_RISING flag from devm_request_irq() call since it's
  being specified in DT
- Drop dev_set_drvdata() call which is a leftover from previous version
- Fix dt_binding_check errors reported by upgraded dtschema

Changes for v5:
- Drop inline attributes and let compiler to decide
- Use _irqsave/_irqrestore flavour for spin lock
- Assignment on a single for irq_resolve_mapping() call
- Add documentation to explain vMPM ownership transition
- Move MPM pin map data into device tree and so use a generic compatible
- Drop the code that counts CPUs in PM and use CPU_CLUSTER_PM_ENTER
  notification instead

Changes for v4:
- Add the missing include of <linux/interrupt.h> to fix build errors
  on arm architecture.
- Leave IRQCHIP_PLATFORM_DRIVER infrastructural unchanged, and use
  of_find_device_by_node() to get platform_device pointer.

Changes for v3:
- Support module build
- Use relaxed accessors
- Add barrier call to ensure MMIO write completes
- Use d->chip_data to pass driver private data
- Use raw spinlock
- USe BIT() for bit shift
- Create a single irq domain to cover both types of MPM pins
- Call irq_resolve_mapping() to find out Linux irq number
- Save the use of ternary conditional operator and use switch/case for
  .irq_set_type call
- Drop unnecessary .irq_disable hook
- Align qcom_mpm_chip and qcom_mpm_ops members vertically
- Use helper irq_domain_translate_twocell()
- Move mailbox requesting forward in probe function
- Improve the documentation on qcm2290_gic_pins[]
- Use IRQCHIP_PLATFORM_DRIVER infrastructural
- Use cpu_pm notifier instead of .suspend_late hook to write MPM for
  sleep, so that MPM can be set up for both suspend and idle context.
  The TIMER0/1 setup is currently omitted for idle use case though,
  as I haven't been able to successfully test the idle context.

Shawn Guo (2):
  dt-bindings: interrupt-controller: Add Qualcomm MPM support
  irqchip: Add Qualcomm MPM controller driver

 .../interrupt-controller/qcom,mpm.yaml        |  96 ++++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-qcom-mpm.c                | 448 ++++++++++++++++++
 4 files changed, 553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/irq-qcom-mpm.c

-- 
2.25.1

