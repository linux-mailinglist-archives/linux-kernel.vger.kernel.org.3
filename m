Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6F4C135A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiBWM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiBWM5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:57:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EDF6468
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o23so3402761pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7p50x25eNVekjg+ymUsqrkEEJjrygmLcJW+jfWZAL4=;
        b=hO8KtL8T4lW0iWOfKNJYOgSwDXKQ2KB3KpJKEZEvQhwg0KLrxXK6yXpgWqV4WFOSf/
         M8SBPEbEW9VOXbbRa1vNA80wMeq+e7FX30FoOtjlyWclj0Eqz1mB6EHH5XWCMVafnhJ/
         hRe7wV8PAx7uSGxJBGvxc4pTf90yD3nNgO7xBPd/T1vrZy2CFwpPcnOuek84uzQYbD82
         0+tns0Wgb067H6YDGtrOj/rArns/nnmTbWmrd1NWDHUuUEPZg+7yacwY0etNwWTLweuD
         nkNaWHAHT9Vp0vo0FvDTnXCeevZmgs0j89+Ln4OM/+jbp0EyVUFUZAs6YELjkyEPsGba
         mQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7p50x25eNVekjg+ymUsqrkEEJjrygmLcJW+jfWZAL4=;
        b=r0aGUKPXzWO5y5B8Vky4Q/UGYOr8rT/ANMFxObMJ/8dKmivKd7EExei+3q8+5k1UWw
         ybMrCJ4jTzY/E3qn1cbnnaYElyTAJeL2yI8lBJzyMpONppDRvP2gJw7RfdMepRSpbpJX
         ahfDsRJcNFxbWoAZcA2RZh5h++D5G7dGvrc1ry2mhKv6ejp9Wv4ZKrUIUVbU1Ve6q+Cc
         BnRlys2xwO3XbSWL30cG7cBbqzdPNdy4sDy+HdNL0lAFOiovuv3Ql5jn73Yl2argfO/k
         +hVcFwaEFuOAzhRRA4BBNM8DgGe0Mo5yS52T7sDHtb1ZPavt978AriHzG5UImbzyF6yn
         c+Cg==
X-Gm-Message-State: AOAM533ToKC8VctMd9G9abTw8Vyjn+XZ5/SvNJLDCvwqRFVKaOcG+BeA
        hxGK8nVvLqTRILMJ2tycpHxhLQ==
X-Google-Smtp-Source: ABdhPJw3oJNN7uI+1rZGMolJCYaTrvpcScHLNMedFT8pmYEybpvBHt++jzQGrywlVm4DHkTdSX/gEQ==
X-Received: by 2002:a05:6a00:1743:b0:4e0:c65e:d656 with SMTP id j3-20020a056a00174300b004e0c65ed656mr30187313pfc.5.1645621028776;
        Wed, 23 Feb 2022 04:57:08 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z23sm22136243pfj.87.2022.02.23.04.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 04:57:07 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v6 0/3] Add Qualcomm MPM irqchip driver support
Date:   Wed, 23 Feb 2022 20:55:33 +0800
Message-Id: <20220223125536.230224-1-shawn.guo@linaro.org>
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

It starts from updating cpu_pm to support CPU_LAST_PM_ENTER (and
CPU_FIRST_PM_EXIT) event, and then adds DT binding and driver support
for Qualcomm MPM (MSM Power Manager) interrupt controller.

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

Shawn Guo (3):
  PM: cpu: Add CPU_LAST_PM_ENTER and CPU_FIRST_PM_EXIT support
  dt-bindings: interrupt-controller: Add Qualcomm MPM support
  irqchip: Add Qualcomm MPM controller driver

 .../interrupt-controller/qcom,mpm.yaml        |  96 ++++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/qcom-mpm.c                    | 439 ++++++++++++++++++
 include/linux/cpu_pm.h                        |  15 +
 kernel/cpu_pm.c                               |  33 +-
 6 files changed, 590 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/qcom-mpm.c

-- 
2.25.1

