Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376AA4AF30A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiBINkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiBINkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:40:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D80C0613CA;
        Wed,  9 Feb 2022 05:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E46B619FF;
        Wed,  9 Feb 2022 13:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1144C340E7;
        Wed,  9 Feb 2022 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644414015;
        bh=+8aJBPSULxP5Zax04rq5roBRVH/mUwGTvhQVeya08Aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zyx1Un9dpCjcJBBA9WTpIjqyj+P3afDSBYWrucqMYJdMpL+Op9P6lDfxs/IjQ2OXq
         g2bkeD1/F4Ajy7Sdb5KDvRx9A0/dIA0lZiIjI1uy+umxSZyCEfCvBqYoRaCid69Bnx
         8sPjqvn83M5qO9esVwBrate6RVoJBvKqpyYR1Oq7NaHwceS4MpfXK9flTllVh+OZ98
         DOcrXvV9iFowho2pd4JLqN64zb5vGakCxZNVSZkfSPplWGU7n+poOFQHN6b0jFR5F5
         QwqYpoHPWzpcD3CTFwR79T0g0sBg1XYbjmu0xh5Fd/LCqKRLVFWNIr9O9LVgw1Zmx7
         uItQCnP8CHBAg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHnCf-006dDe-M2; Wed, 09 Feb 2022 13:40:13 +0000
MIME-Version: 1.0
Date:   Wed, 09 Feb 2022 13:40:13 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH 03/12] irqchip/renesas-intc-gpio: Move PM device over to
 irq domain
In-Reply-To: <CAMuHMdXbM8kvmv0XKP8=rYj-8k5cFt50VP69LeDNX5oHx2e9dw@mail.gmail.com>
References: <20220201120310.878267-1-maz@kernel.org>
 <20220201120310.878267-4-maz@kernel.org>
 <CAMuHMdXbM8kvmv0XKP8=rYj-8k5cFt50VP69LeDNX5oHx2e9dw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <83f67bec65e4f3cf661e0b6a6bbe9641@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
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

On 2022-02-02 14:27, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Tue, Feb 1, 2022 at 1:12 PM Marc Zyngier <maz@kernel.org> wrote:
>> Move the reference to the device over to the irq domain.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Thanks for your patch!
> 
> s/gpio/irqpin/ in the one-line summary?

Indeed, now fixed.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
