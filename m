Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65374C33DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiBXRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiBXRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:42:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E921C60CB;
        Thu, 24 Feb 2022 09:42:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089A7B8270D;
        Thu, 24 Feb 2022 17:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05FCC340E9;
        Thu, 24 Feb 2022 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645724524;
        bh=iD5+0LBNH7T6gpbIgLDfaNdtblX7tu5a+rnPBgdz2ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cZjRTQ2AJH31EaiDy2kOqeFg/ZVo9YKsQ+rfXyIwvlJ1MWHCw1TQJQp/2z3Km5uyp
         5u/HLfIDqQ4D3lPJyP3+v5lPnFIgbTvflxesDJh6RqzMvNbL+FPwFBBNj7exCLM5qX
         12gz0AhM95QVbQtdptv9qadAetfCZidcI2vobDykVoYjtmrhTpFOmvPX7CkAynpNDZ
         fdpg1qUtigQ7l4XP54yjT6033TZxiMNZui6jx5mmeapTAETFD9aHB2b2MZ0P3B3W35
         B7aYl3RZD0k1uK04XlaKl+RXwD4Ti5UBEmA+4iXPdFJ+/7+3VUbl4dMfheyzOQKJcE
         qv7yuXxygQ8NQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNI7u-00AGAn-7S; Thu, 24 Feb 2022 17:42:02 +0000
MIME-Version: 1.0
Date:   Thu, 24 Feb 2022 17:42:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
In-Reply-To: <Yhe1Cxdn8t3oVxMZ@orome>
References: <20220223154405.54912-1-maz@kernel.org> <Yhe1Cxdn8t3oVxMZ@orome>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <371a530ea9ae8c58bf13ac16d1f2cd3c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: thierry.reding@gmail.com, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-24 16:40, Thierry Reding wrote:
> On Wed, Feb 23, 2022 at 03:44:00PM +0000, Marc Zyngier wrote:
>> I recently realised that the gpiolib play ugly tricks on the
>> unsuspecting irq_chip structures by patching the callbacks.
>> 
>> Not only this breaks when an irq_chip structure is made const (which
>> really should be the default case), but it also forces this structure
>> to be copied at nauseam for each instance of the GPIO block, which is
>> a waste of memory.
>> 
>> My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
>> which does what it says on the tin: don't you dare writing there.
>> Gpiolib is further updated not to install its own callbacks, and it
>> becomes the responsibility of the driver to call into the gpiolib when
>> required. This is similar to what we do for other subsystems such as
>> PCI-MSI.
>> 
>> 3 drivers are updated to this new model: M1, QC and Tegra, as I
>> actively use them (though Tegra is hosed at the moment), keeping a
> 
> Hosed in what way? Anything I can help with?

Tegra186 doesn't boot as host1x is been broken since -rc1.

I have been carrying this[1] patch which has been in -next for
some time, but still not merged AFAICS.

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gpio-immutable&id=58d1d925f05485020306e5141336cfd2989843dc
-- 
Jazz is not dead. It just smells funny...
