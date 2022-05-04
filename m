Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20B51A1DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351118AbiEDONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351100AbiEDONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:13:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0A419BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:09:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v4so1797664ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXxGrmQdSrMAdgM6NKkZr+YUm7PNfDBSQKuYDgtFekk=;
        b=v5L6+vlO1JziId6xo4NIZ1qZpZX5de3qvCDfydB6T6nKaixiak/bCnImso2ZrwciFg
         uem5dH/3BIj33AF3fymM9Dm++rCBnCYYLQ+sduXiCLoAmYfafjEJQKkNxmMD2075jHdD
         fEd1nJHbUIH3bYTGWGfnoKgr+NUlNkEfB+wUOrZkWoS65Fm9x5XKa3uff2dmBH5sQyu9
         UeBWF48DCNw40us6UlvkExdtpTC+rP6IDuPt60vjuAYoLAfdDi6YOgXxiBK1jB0sY9K0
         I9qLLlHLg8TxHmEQPvXXuD+PRIPSanEd/dk9eSD3r3/cYrB42TILanCZbXkMw/7j/Ffb
         xu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXxGrmQdSrMAdgM6NKkZr+YUm7PNfDBSQKuYDgtFekk=;
        b=jiRpJZPzlqSwaTCHmBTFcF/Rafk0p3B5sau8aKmn4s8suQGHI122uu0UdZUkmy78/9
         VlC5Q9ClmmnEbiTFBzTtnXhwPa4Xhoh7sM7+TyhBCOKq3l5dDR8aWQpLm3lwKpF0Ay56
         7+BUHb+6Uqfsqw3JZtJCRo9EWXSZ6jwy/uWzXaPbyR+kWn05YYOLXx7WYrXvQiSL7LyL
         bXYdTgDBH3nBoixdfdBI8S7vuKyZBXvQH4LXaadFyg/kA+QJopM4ohqNIhk7/fsGo+2/
         ljL8lkHiV/mi6w+zfy/+327XIYLO4XTrFIguhMpv+UpelkRPitTXW9Y/hpphnZraMn+0
         BB2A==
X-Gm-Message-State: AOAM5304s0YaRlCiR2S8YKpPTXH21rWsxsC9JpsWUucSRjhl+oYK69k+
        D177tPYa0ZHgAxGShC59anpmym+aVbmndRtzNNMLLA==
X-Google-Smtp-Source: ABdhPJxbrzddvy2FPwyfMsPdzhIS4LXL0C4hUf6AFGOm/2YPmtbyftB56FzxJVYzEacQw0HiNcK/2AxUn68tYGi/Syk=
X-Received: by 2002:a2e:8798:0:b0:24f:12ec:5268 with SMTP id
 n24-20020a2e8798000000b0024f12ec5268mr12082888lji.367.1651673374744; Wed, 04
 May 2022 07:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220223125536.230224-1-shawn.guo@linaro.org>
In-Reply-To: <20220223125536.230224-1-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 16:08:58 +0200
Message-ID: <CAPDyKFpTyj86deODjOLwVoWM_PoK8458xYY=kn0srEGYZj9+mQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add Qualcomm MPM irqchip driver support
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 13:57, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> It starts from updating cpu_pm to support CPU_LAST_PM_ENTER (and
> CPU_FIRST_PM_EXIT) event, and then adds DT binding and driver support
> for Qualcomm MPM (MSM Power Manager) interrupt controller.
>
> Changes for v6:
> - Add new event CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT) in cpu_pm
> - Drop vendor driver notes from commit log
> - Check NULL mpm_gic_map instead to save the use of MPM_NO_PARENT_IRQ
> - Add lock protection for register read in qcom_mpm_handler()
> - Return IRQ_NONE if there is no pending interrupt
> - Drop IRQF_TRIGGER_RISING flag from devm_request_irq() call since it's
>   being specified in DT
> - Drop dev_set_drvdata() call which is a leftover from previous version
> - Fix dt_binding_check errors reported by upgraded dtschema

My apologies for the late reply to this series. FYI, I fully agree
with the responses from Sudeep, etc, that have been made on this
series.

The proper thing is to use genpd on/off notifiers, which should get
fired if you model the PM domain topology correctly in DT - and use
PSCI OSI.

That said, please keep me posted when/if you submit a new version for
this. I will make sure to pay more attention next time.

Kind regards
Uffe

>
> Changes for v5:
> - Drop inline attributes and let compiler to decide
> - Use _irqsave/_irqrestore flavour for spin lock
> - Assignment on a single for irq_resolve_mapping() call
> - Add documentation to explain vMPM ownership transition
> - Move MPM pin map data into device tree and so use a generic compatible
> - Drop the code that counts CPUs in PM and use CPU_CLUSTER_PM_ENTER
>   notification instead
>
> Changes for v4:
> - Add the missing include of <linux/interrupt.h> to fix build errors
>   on arm architecture.
> - Leave IRQCHIP_PLATFORM_DRIVER infrastructural unchanged, and use
>   of_find_device_by_node() to get platform_device pointer.
>
> Changes for v3:
> - Support module build
> - Use relaxed accessors
> - Add barrier call to ensure MMIO write completes
> - Use d->chip_data to pass driver private data
> - Use raw spinlock
> - USe BIT() for bit shift
> - Create a single irq domain to cover both types of MPM pins
> - Call irq_resolve_mapping() to find out Linux irq number
> - Save the use of ternary conditional operator and use switch/case for
>   .irq_set_type call
> - Drop unnecessary .irq_disable hook
> - Align qcom_mpm_chip and qcom_mpm_ops members vertically
> - Use helper irq_domain_translate_twocell()
> - Move mailbox requesting forward in probe function
> - Improve the documentation on qcm2290_gic_pins[]
> - Use IRQCHIP_PLATFORM_DRIVER infrastructural
> - Use cpu_pm notifier instead of .suspend_late hook to write MPM for
>   sleep, so that MPM can be set up for both suspend and idle context.
>   The TIMER0/1 setup is currently omitted for idle use case though,
>   as I haven't been able to successfully test the idle context.
>
> Shawn Guo (3):
>   PM: cpu: Add CPU_LAST_PM_ENTER and CPU_FIRST_PM_EXIT support
>   dt-bindings: interrupt-controller: Add Qualcomm MPM support
>   irqchip: Add Qualcomm MPM controller driver
>
>  .../interrupt-controller/qcom,mpm.yaml        |  96 ++++
>  drivers/irqchip/Kconfig                       |   8 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/qcom-mpm.c                    | 439 ++++++++++++++++++
>  include/linux/cpu_pm.h                        |  15 +
>  kernel/cpu_pm.c                               |  33 +-
>  6 files changed, 590 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
>  create mode 100644 drivers/irqchip/qcom-mpm.c
>
> --
> 2.25.1
>
