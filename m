Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC14B8BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiBPOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:50:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiBPOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:50:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B64262A39D0;
        Wed, 16 Feb 2022 06:50:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ECD1113E;
        Wed, 16 Feb 2022 06:50:28 -0800 (PST)
Received: from bogus (unknown [10.57.3.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C16E3F66F;
        Wed, 16 Feb 2022 06:50:26 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:49:37 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpuidle: psci: Call cpu_cluster_pm_enter() on the
 last CPU
Message-ID: <20220216144937.znsba7zbdenl7427@bogus>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216132830.32490-2-shawn.guo@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ulf (as you he is the author of cpuidle-psci-domains.c and can help you
with that if you require)

On Wed, Feb 16, 2022 at 09:28:28PM +0800, Shawn Guo wrote:
> Make a call to cpu_cluster_pm_enter() on the last CPU going to low power
> state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> platforms can be notified to set up hardware for getting into the cluster
> low power state.
>

NACK. We are not getting the notion of CPU cluster back to cpuidle again.
That must die. Remember the cluster doesn't map to idle states especially
in the DSU systems where HMP CPUs are in the same cluster but can be in 
different power domains.

You need to decide which PSCI CPU_SUSPEND mode you want to use first. If it is
Platform Co-ordinated(PC), then you need not notify anything to the platform.
Just request the desired idle state on each CPU and platform will take care
from there.

If for whatever reason you have chosen OS initiated mode(OSI), then specify
the PSCI power domains correctly in the DT which will make use of the
cpuidle-psci-domains and handle the so called "cluster" state correctly.

-- 
Regards,
Sudeep
