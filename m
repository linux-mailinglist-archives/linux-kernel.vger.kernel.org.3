Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD884C43AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiBYLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiBYLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:30:25 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3381AC2A4;
        Fri, 25 Feb 2022 03:29:53 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E75092222E;
        Fri, 25 Feb 2022 12:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645788591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1caUnc7kqr4js1sXxxu1ImeMweeeOsre54LlQ8WC5Y=;
        b=EqD98nxdS5l5EzH7RPg1QjHexstlDrV4xLLLBCEuSu100BGC2GrX6bzjpgR/b8TUTcFufX
        KTqNLEr37Xf/11s8/KNUmc3I2/Fgd/B41+q2I5IsKu0OtCS6mytF9zgtRHCvMzNP1pOzgw
        eC0QHXXwTVjrHEMseHKakd7Vjp+yMX0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Feb 2022 12:29:50 +0100
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH v1 5/5] pinctrl: microchip-sgpio: wait until output is
 actually set
In-Reply-To: <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
References: <20220224161021.2197263-1-michael@walle.cc>
 <20220224161021.2197263-6-michael@walle.cc>
 <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <2f8a215c67269d639290515931d10b78@walle.cc>
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

Hi Horatiu,

Am 2022-02-25 10:24, schrieb Horatiu Vultur:
> The 02/24/2022 17:10, Michael Walle wrote:
>> Right now, when a gpio value is set, the actual hardware pin gets set
>> asynchronously. When linux write the output register, it takes some 
>> time
>> until it is actually propagated to the output shift registers. If that
>> output port is connected to an I2C mux for example, the linux driver
>> assumes the I2C bus is already switched although it is not.
>> 
>> Fortunately, there is a single shot mode with a feedback: you can
>> trigger the single shot and the hardware will clear that bit once it 
>> has
>> finished the clocking and strobed the load signal of the shift
>> registers. This can take a considerable amount of time though.
>> Measuremens have shown that it takes up to a whole burst cycle gap 
>> which
>> is about 50ms on the largest setting. Therefore, we have to mark the
>> output bank as sleepable. To avoid unnecessary waiting, just trigger 
>> the
>> single shot if the value was actually changed.
> 
> I have tested this patch series on our lan9668 board and it worked
> fine. Thanks!

Thanks for testing!

> I just have few questions:
> 1. What about other boards/chips that have this sgpio, do they have 
> also
>    the same issue? Because from what I recall on sparx5 they don't have
>    this issue. I have seen it only on lan9668.

Unfortunatly, I don't have any knowledge what IP core is used in
which SoC. I assumed the lan9668 used the same as the sparx5. If
that is not the case, we need a new compatible. Do you know if it
the same?

On the sparx5 are there any peripheral who you would actually
notice that the timing is off?

That being said, I'd assume all the serial gpio controller has
this "flaw". Simply because a register write won't block until the
value is shifted out to the shift register and actualy loaded by
strobing the load signal. It just depends on your burst setting
(even with bursts off, and clocking all the time) on how large
the delay is. So you might or might not notice it on a board.

Could you also have a look at the other supported sgpio block,
the ocelot and the luton? I don't have any register description
of these.

> 2. I remember that I have tried to fix this issue like this [1], but
>    unfortunetly that was never accepted. Is this something that is 
> worth
>    at looking at?

That fix is at the wrong place. You'd need to fix every gpio user, no?
Instead this tries to fix the controller.

> 
> [1] 
> https://patchwork.ozlabs.org/project/linux-i2c/patch/20211103091839.1665672-3-horatiu.vultur@microchip.com/

-michael
