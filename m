Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AF4CD684
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCDOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiCDOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:38:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D943E1BAF3A;
        Fri,  4 Mar 2022 06:37:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E369143D;
        Fri,  4 Mar 2022 06:37:13 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DE923F70D;
        Fri,  4 Mar 2022 06:37:12 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:37:09 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Edwin Chiu =?utf-8?B?6YKx5Z6C5bOw?= <edwin.chiu@sunplus.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Message-ID: <YiIkFZNGUihnoVPI@bogus>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
 <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
 <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
 <fda1e55e576b4cdf9ab412529a3dfc7b@sphcmbx02.sunplus.com.tw>
 <fd39f73e-8317-38c4-6002-8defd784caec@kernel.org>
 <YiCSQCG4NkepeZKs@bogus>
 <ffdcb88f0ea240f68b5e5ec40f0f525c@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffdcb88f0ea240f68b5e5ec40f0f525c@sphcmbx02.sunplus.com.tw>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:24:32AM +0000, Edwin Chiu 邱垂峰 wrote:
> 
> Thanks your advice.
> Look like key point still only WFI function when cpuidle.

Indeed.

> As I explain before, only enable generic ARM cpuidle driver is not work.

Why do you think it is a must. Most arch(including arm) has default
arch_cpu_idle handler that will be called if no cpuidle driver is active.
It does execute the default WFI, so you don't need a driver to achieve
the same.

> It need enable-method code to assign cpuidle_ops functions.

Correct, but you may not need that driver to be active at all. That is the
main point of these discussions. Sorry if that was not mentioned explicitly
earlier.

> "psci" is one of enable-method, but there have problem in my side due to smc
> or secure code unsupported. > So I create cpuidle-sunplus.c code with
> "sunplus,sc-smp" to let cpuidle code complete for our source code.
> With this structure, I can add more custom low power code in the future.
>

So you want to add custom low power mode support in future, so add the driver
when that is ready. The platform must do WFI even now without the driver
you are adding. Have you checked that ?

> What does it mean for "please document the chosen "sunplus,sc-smp" as bot
> cpu idle and hotplug methods" ?

I meant if you are adding any custom SMP+Idle mentods you need to add the
compatible to [1] or [2] based on what is more appropriate.

> Does it mean "edit yaml file"? (Previously, I submit yaml file also, but Rob
> say I don't need submit when I use compatible="arm,idle-state")

Yes that covers the description of idle states but not the entry method.
There are 2 separate things. You need both "arm,idle-state" and
"sunplus,sc-smp" or "psci" whichever you decide to implement on your
platform. If there is no implementation yet, it is strongly suggested
to go for "psci" unless you have reasons not to. Please add that info
when you submit the custom support, I will check on that again when
you post. But for now you don't need anything.

-- 
Regards,
Sudeep

[1] Documentation/devicetree/bindings/arm/cpu-enable-method/
[2] Documentation/devicetree/bindings/arm/cpus.yaml
