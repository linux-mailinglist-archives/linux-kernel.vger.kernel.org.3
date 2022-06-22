Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCF554679
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357757AbiFVL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357248AbiFVL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:59:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14983DA7D;
        Wed, 22 Jun 2022 04:59:09 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 34FE622238;
        Wed, 22 Jun 2022 13:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655899148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKfrtHY3354YagDaD5kDsTZTk+EPmD9d+R0Xe29+ymE=;
        b=TMWtsnTu675Ke7jhoWKinpET6mkMw3GxbvwZPy+RJb/N7650dxCLHy8TJI62vQx8NsuP+3
        13UAvuN/Ll/kM0jOnq8U5f/IikGlGZGk03szh/WvESctM5MHmNiUzv2jlHRBsuzKkkwAO+
        vHuqL3JC90M0SeGGqQGyXG20fiwvxHc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jun 2022 13:59:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: remove generic ARM cpuidle support
In-Reply-To: <20220529181329.2345722-1-michael@walle.cc>
References: <20220529181329.2345722-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <09f392794c815cbfb38e5103d92310da@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-29 20:13, schrieb Michael Walle:
> Playing with an own PSCI implementation, I've noticed that the 
> cpuidle-arm
> driver doesn't work on arm64. It doesn't probe because since commit
> 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
> arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit 
> removed
> the cpu_idle_init and cpu_suspend ops.
> 
> It left me puzzled for quite some time. It seems that the cpuidle-psci 
> is
> the preferred one and this has been the case for quite some time. The
> mentioned commit first appeared in v5.4.
> 
> Remove the ARM64 support for the cpuidle-arm driver, which then let us
> remove all the supporting arch code.
> 
> Michael Walle (2):
>   cpuidle: cpuidle-arm: remove arm64 support
>   arm64: cpuidle: remove generic cpuidle support
> 
>  arch/arm64/include/asm/cpu_ops.h |  9 ---------
>  arch/arm64/include/asm/cpuidle.h | 15 ---------------
>  arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
>  drivers/cpuidle/Kconfig.arm      |  3 ++-
>  4 files changed, 2 insertions(+), 54 deletions(-)

Through which tree should this patchset go? I've seen it is marked as
"Handled Elsewere" in the linux pm patchwork [1].

-michael

[1] 
https://patchwork.kernel.org/project/linux-pm/patch/20220529181329.2345722-2-michael@walle.cc/
