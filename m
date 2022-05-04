Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB651ADB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355828AbiEDTZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiEDTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:25:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 773514B40C;
        Wed,  4 May 2022 12:22:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484A01042;
        Wed,  4 May 2022 12:22:07 -0700 (PDT)
Received: from bogus (unknown [10.57.1.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D54F3FA35;
        Wed,  4 May 2022 12:22:04 -0700 (PDT)
Date:   Wed, 4 May 2022 20:21:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add Qualcomm MPM irqchip driver support
Message-ID: <20220504192159.gw5sccasbdmqz4dt@bogus>
References: <20220223125536.230224-1-shawn.guo@linaro.org>
 <CAPDyKFpTyj86deODjOLwVoWM_PoK8458xYY=kn0srEGYZj9+mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpTyj86deODjOLwVoWM_PoK8458xYY=kn0srEGYZj9+mQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:08:58PM +0200, Ulf Hansson wrote:
> On Wed, 23 Feb 2022 at 13:57, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > It starts from updating cpu_pm to support CPU_LAST_PM_ENTER (and
> > CPU_FIRST_PM_EXIT) event, and then adds DT binding and driver support
> > for Qualcomm MPM (MSM Power Manager) interrupt controller.
> >
> > Changes for v6:
> > - Add new event CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT) in cpu_pm
> > - Drop vendor driver notes from commit log
> > - Check NULL mpm_gic_map instead to save the use of MPM_NO_PARENT_IRQ
> > - Add lock protection for register read in qcom_mpm_handler()
> > - Return IRQ_NONE if there is no pending interrupt
> > - Drop IRQF_TRIGGER_RISING flag from devm_request_irq() call since it's
> >   being specified in DT
> > - Drop dev_set_drvdata() call which is a leftover from previous version
> > - Fix dt_binding_check errors reported by upgraded dtschema
> 
> My apologies for the late reply to this series. FYI, I fully agree
> with the responses from Sudeep, etc, that have been made on this
> series.
> 
> The proper thing is to use genpd on/off notifiers, which should get
> fired if you model the PM domain topology correctly in DT - and use
> PSCI OSI.
> 
> That said, please keep me posted when/if you submit a new version for
> this. I will make sure to pay more attention next time.
> 

[1] is the latest I believe. It now implements power domain as I requested and
I was happy with that version.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20220308080534.3384532-1-shawn.guo@linaro.org
