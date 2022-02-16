Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29314B8D10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiBPP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiBPP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9262A39CB;
        Wed, 16 Feb 2022 07:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6500161A7B;
        Wed, 16 Feb 2022 15:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CBFC004E1;
        Wed, 16 Feb 2022 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027123;
        bh=x+vLuZ6qACLHw+sLfjBq8yrKs8jSFGmNBWNxitqLCPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YXq4+Cu5BTKJCAIYpl8Om38gt6TRAZ7RDgGJaLS6Ed4wLwUI6/rqjix65MqIt3oYq
         h0dr21ioQtYJPnV2HPEqVE+kfvevipqUr+u6QWwNeMfKXqZDQroX1VbxvUUPm6wgEb
         FC3MpjAx2aWhgSznoUcRbHg57d64FvnmKk2PEB/z4E6ZJyHYasfx/G9/fZEN9yV2qB
         JOm/cob+gCNOpo3LadAbV69FJ1VtTRbA43KHUjnbzZKeMo7IXT5szCuaQ26YUBhY7+
         4ZAghXPtr7m694iZugo9KqtffHovVoVT7ENkeAb5TIK+nHEXu++UJD9n2Q/FUS67ET
         96GJBGCT7Uc6Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nKMhV-008Mjp-Nm; Wed, 16 Feb 2022 15:58:41 +0000
MIME-Version: 1.0
Date:   Wed, 16 Feb 2022 15:58:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpuidle: psci: Call cpu_cluster_pm_enter() on the
 last CPU
In-Reply-To: <20220216144937.znsba7zbdenl7427@bogus>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
 <20220216144937.znsba7zbdenl7427@bogus>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9bda65e5bb85b00eaca71d95ad78e93b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sudeep.holla@arm.com, shawn.guo@linaro.org, tglx@linutronix.de, quic_mkshah@quicinc.com, ulf.hansson@linaro.org, bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16 14:49, Sudeep Holla wrote:
> +Ulf (as you he is the author of cpuidle-psci-domains.c and can help 
> you
> with that if you require)
> 
> On Wed, Feb 16, 2022 at 09:28:28PM +0800, Shawn Guo wrote:
>> Make a call to cpu_cluster_pm_enter() on the last CPU going to low 
>> power
>> state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
>> platforms can be notified to set up hardware for getting into the 
>> cluster
>> low power state.
>> 
> 
> NACK. We are not getting the notion of CPU cluster back to cpuidle 
> again.
> That must die. Remember the cluster doesn't map to idle states 
> especially
> in the DSU systems where HMP CPUs are in the same cluster but can be in
> different power domains.
> 
> You need to decide which PSCI CPU_SUSPEND mode you want to use first. 
> If it is
> Platform Co-ordinated(PC), then you need not notify anything to the 
> platform.
> Just request the desired idle state on each CPU and platform will take 
> care
> from there.
> 
> If for whatever reason you have chosen OS initiated mode(OSI), then 
> specify
> the PSCI power domains correctly in the DT which will make use of the
> cpuidle-psci-domains and handle the so called "cluster" state 
> correctly.

My understanding is that what Shawn is after is a way to detect the 
"last
man standing" on the system to kick off some funky wake-up controller 
that
really should be handled by the power controller (because only that guy
knows for sure who is the last CPU on the block).

There was previously some really funky stuff (copy pasted from the 
existing
rpmh_rsc_cpu_pm_callback()), which I totally objected to having hidden 
in
an irqchip driver.

My ask was that if we needed such information, and assuming that it is
possible to obtain it in a reliable way, this should come from the core
code, and not be invented by random drivers.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
