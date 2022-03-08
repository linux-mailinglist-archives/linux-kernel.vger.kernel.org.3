Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A44D118A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbiCHIGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiCHIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:06:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E23E5F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:05:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n15so6375030plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZikuJ18uvuOiGO/Z5TqeMdxhS/RgrRntG4ZC8iCtgc=;
        b=aEsdM/xXxJNNVMLr6098DXXoqTgW+FybK9ueVcE+jhIJ1r3J2e52fYxBEtPibrkdKO
         7X6l711jOnX6WSqqcrTtvmnJ3q2IvHWNcSw8am1cEGWtRK4e4xgsjeGnXBsPS31nRafU
         D7umlbfzYl0I/tRF34fwCoBMLz5uLg1ambtZrZMe/VPea6O1eHxWHjKGkPmEW1uhN5vd
         RL7JCfij+BBQl9z94cYdzzrWaYPoHjpNy+9usjHfvIBTO1qKFK1PVzF4ew9dmTZfvaw2
         zdWSGc8qlrxycerEa6J8L42NWCBaTmfvABkB0JWyPvxIihWVqyNYezgqUWN1VXxvVECQ
         xpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZikuJ18uvuOiGO/Z5TqeMdxhS/RgrRntG4ZC8iCtgc=;
        b=dngVTrRo+J6t0iAj2vp1BHLezs5G7ZqC2AGRaYUmS4M8zEXNI/qQQMSGikmgDwsvTP
         gXeRr1LCDUOEWSjzmuirbgelj9/TlP23ouqJ9RZMPnCkB7Qc9UGU5VDd0TJc39Bl4TTE
         E9dnrBtGw6oEypYswoNqQ5KNF/qA9B16nv3Mo+B0vjb7XLm8oaIbr9IlNsXixAT0VdZJ
         GXeDLS9DdKXK/9tRN7ZrwKYObilPEiYPjAeIq5iiKuR/RsQyCVkY3RXAgIlyXoHiWEHc
         lfB8flcgyPpanitGLTDMV5xT/gRwPIblTcYv6WcSceHE65BELJFhld5awhrWgSi7uoC9
         yYfg==
X-Gm-Message-State: AOAM532NVixulqEJ/oIfV5Ct7A2hEymsaspEEPCXboFfRWCnj9VJ8ukq
        SIwoZ6yMvyVfwzmwuogF2n5P6A==
X-Google-Smtp-Source: ABdhPJyhJsumTbxfX3yOqd7vQfyJlJangpfqYABDkQvmkHdWH/sfR5DI79tXgzKyrDAr37BuKpNbRQ==
X-Received: by 2002:a17:90a:4306:b0:1b9:80b3:7a3d with SMTP id q6-20020a17090a430600b001b980b37a3dmr3383447pjg.66.1646726753111;
        Tue, 08 Mar 2022 00:05:53 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm1944212pjb.52.2022.03.08.00.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:05:52 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v8 0/2] Add Qualcomm MPM irqchip driver support
Date:   Tue,  8 Mar 2022 16:05:32 +0800
Message-Id: <20220308080534.3384532-1-shawn.guo@linaro.org>
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

It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
interrupt controller.

Changes for v8:
- Drop include of arm-gic-v3.h
- Use __assign_bit() to set & clear bit
- Merge qcom_mpm_enter_sleep() into mpm_pd_power_off()
- Fix broken qcom_mpm_set_type() by respecting the downstream logic
- Initialize vMPM registers at probe time
- Enforce 1:1 hierarchy mapping between MPM pin and GIC interrupt

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
 drivers/irqchip/irq-qcom-mpm.c                | 461 ++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/irq-qcom-mpm.c

-- 
2.25.1

