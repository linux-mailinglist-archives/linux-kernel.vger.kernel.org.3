Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33180469250
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbhLFJ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbhLFJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:29:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D8C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:25:52 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so8964798pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iP7gvGikKR2xNziNLZvK7Pmhk4stHCJztbT7jMgPSsQ=;
        b=VNPA3EVzQ2jOWSSWd58JoLbb0q0u0DOtV4Ifm/uyE6dAoNY0SgWXwOVpslXPnRTKKT
         1nfQEiG9o/X3b5lyDwrX4nDM1Lhgf/m1K10O7tTQHBim6ujidddXMP3ibDqO8HW98DBS
         W2P/ON8NERyQbU0R6lkhHc+zNGfd+cFJ0mKCBfPJUsEIiOm4L+YfH93VuGYmBfjA2pai
         uAOBHor1qdaP8f0jf+6X6346SElJQgf2Hr5LdVZm0X99VVHqsB/p8RvONvHa3lJJp21o
         2Ux/ehaXtPyV/sQEmwr+mPjiFvEghUF9WSi/E9vAoGA/4tigh35Bg7Eaf9eFeo/RTh0I
         uu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iP7gvGikKR2xNziNLZvK7Pmhk4stHCJztbT7jMgPSsQ=;
        b=uCnaYAHpVK14dKgHn7Or710pFAVs5lH6hD7WkgjN2su5dKDbsiJrWFil+iOPWfHtaY
         90lsGBHsyMC4xJyU/6Vfzab5E4+JgMqwq8PZ5m3Y0gCGuovJJ45muIe4TFO4uQtGxhp1
         S9osKL3W8DvThaluG9PXH5hte06v5Yj1/NlcqlVSkUKefnzyysMoAMXF5CYc+hxaorMK
         w+45JQchw8BEl2kW/Tdl/wAcAeIqJsiXrmzJ2X3vc5VUg+6T9W6E5Yk5fehFK7YCrW4/
         guIgagq0vZjUujZwpZbaEHNnNOytID3CU2DLK5g1u0aOzSNJwnPTn16mipatf/a7xK1X
         bdCw==
X-Gm-Message-State: AOAM530hIhMcP8P3GzaGFmuWimvrkwlbPx674O8t+xMz9cF/d8SJdBMc
        VV9xU5j9odr3wHNN7CyFBS8CAA==
X-Google-Smtp-Source: ABdhPJwZ17lZ39ARicFadsmI/8CBkSiwtkGXAQiyepTOjNrU3hooJYvsSvNyFegsSbwyLtRF1dW8oA==
X-Received: by 2002:a17:903:2443:b0:142:1e92:1d19 with SMTP id l3-20020a170903244300b001421e921d19mr42477069pls.24.1638782751976;
        Mon, 06 Dec 2021 01:25:51 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 38sm9165890pgl.73.2021.12.06.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:25:51 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/2] Add Qualcomm MPM irqchip driver support
Date:   Mon,  6 Dec 2021 17:25:33 +0800
Message-Id: <20211206092535.4476-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
interrupt controller.

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

 .../interrupt-controller/qcom,mpm.yaml        |  72 +++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/qcom-mpm.c                    | 480 ++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/qcom-mpm.c

-- 
2.17.1

