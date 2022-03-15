Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C584D97BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiCOJg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiCOJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3A39B8A;
        Tue, 15 Mar 2022 02:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C57F60AF4;
        Tue, 15 Mar 2022 09:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD33C340E8;
        Tue, 15 Mar 2022 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647336911;
        bh=tc/AYlU5h+rIvqjL5oTMpd37Nh1Iiz2jAlGUG+y+Abg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q7bQgqkRSdMHOm+/K3QDJHpE1nyNo7Ji1VCcUgPEggRZTuigZa2fouitaaOdiUlPl
         2e4i6K72aVpXtZjFaDGOuPsB68Aa4JU25BusLuar/XS7B741AUbovWEXrcSEoVZKj1
         ztK4enbfxZpuW/7OwLkzPTLPMJU95Mkd9NquoysZkFt9Uh/ldbvfhZ4q2ldXsp/tRH
         qdL/5ZTffFR49LTTg/IgkvEVWesLOVu7Za7Rm7uIdemcseM/GEg20+LP+ocLJCVx2D
         nGLOEKN+AHB4leKMND21ADdNjwWM+pdeOpB9+sq3AJbAcguseZCfjS5ozc1t9tdh6B
         ISqclEZpOq0uw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nU3a8-00EbLe-Tm; Tue, 15 Mar 2022 09:35:09 +0000
MIME-Version: 1.0
Date:   Tue, 15 Mar 2022 09:35:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/5] gpiolib: Handle immutable irq_chip structures
In-Reply-To: <CACRpkdbEDoPeu=TWmsJ_t-4+NtyiiSCXoj9rymspZt0nC+yrsQ@mail.gmail.com>
References: <20220223154405.54912-1-maz@kernel.org>
 <CACRpkdbEDoPeu=TWmsJ_t-4+NtyiiSCXoj9rymspZt0nC+yrsQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e39c68c6c8c99fec796461cde33f78df@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 00:44, Linus Walleij wrote:
> On Wed, Feb 23, 2022 at 4:44 PM Marc Zyngier <maz@kernel.org> wrote:
> 
>> I recently realised that the gpiolib play ugly tricks on the
>> unsuspecting irq_chip structures by patching the callbacks.
> 
> Sorry about that...

No worries. It probably did seem like a good idea at the
time, and I have the benefit of hindsight here...

> 
>> My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
>> which does what it says on the tin: don't you dare writing there.
>> Gpiolib is further updated not to install its own callbacks, and it
>> becomes the responsibility of the driver to call into the gpiolib when
>> required. This is similar to what we do for other subsystems such as
>> PCI-MSI.
> 
> OK if there is a precedent it is usually wise to follow.
> 
>> I'd welcome comments on the approach. If deemed acceptable, there are
>> another 300+ drivers to update! Not to mention the documentation. I
>> appreciate that this is a lot of potential changes, but the current
>> situation is messy.
> 
> I'm happy with this approach as long as the 300+ drivers get fixed
> and the old way of doing it gets deleted.

Of course. Note that it will take some time before it actually happens.
My current plan is to stick in a pr_warn() each time a driver
following the old scheme gets registered, as a nudge for people to
update their driver if they care about it.

Regarding documentation, are you OK with me simply replacing the
current code samples with the new approach? It will at least avoid
giving people the wrong idea. I also want to write a brief migration
guide that people willing to bump up their patch count can follow.

I'll repost something once -rc1 is out.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
