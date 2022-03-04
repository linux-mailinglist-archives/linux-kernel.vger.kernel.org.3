Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A44CD471
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiCDMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiCDMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:47:34 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA3A1B3A78
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:46:46 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8D5AD22175;
        Fri,  4 Mar 2022 13:46:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646398005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6sPMkv3ZNhl4qtSaMaJHc7cKJmVUWN5UINM3iz3B7o=;
        b=dX9+GZoeWrG4v1wZuU11wssiDizM6RodH0n/ie1nbziaF0KVSaVJ42BwiJcfN7ISvZcHbN
        BeeTGIFGu/DneXVIM/FQDVcCA3DffoufsjiweSwpSel9ImVf4Jes6cIyEtOl4wfcWOjGn+
        Yq6EKfBSwkTE0Zoy2dByi6TRYSAb6P8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Mar 2022 13:46:44 +0100
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
In-Reply-To: <20220304120911.i5rngplg5l6gnnyy@soft-dev3-1.localhost>
References: <20220224161021.2197263-1-michael@walle.cc>
 <20220224161021.2197263-6-michael@walle.cc>
 <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
 <2f8a215c67269d639290515931d10b78@walle.cc>
 <20220304120911.i5rngplg5l6gnnyy@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <40ccf0647d7ec0487f71f662eec80528@walle.cc>
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

Am 2022-03-04 13:09, schrieb Horatiu Vultur:
> The 02/25/2022 12:29, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Hi Horatiu,
>> 
>> Am 2022-02-25 10:24, schrieb Horatiu Vultur:
>> > The 02/24/2022 17:10, Michael Walle wrote:
>> > > Right now, when a gpio value is set, the actual hardware pin gets set
>> > > asynchronously. When linux write the output register, it takes some
>> > > time
>> > > until it is actually propagated to the output shift registers. If that
>> > > output port is connected to an I2C mux for example, the linux driver
>> > > assumes the I2C bus is already switched although it is not.
>> > >
>> > > Fortunately, there is a single shot mode with a feedback: you can
>> > > trigger the single shot and the hardware will clear that bit once it
>> > > has
>> > > finished the clocking and strobed the load signal of the shift
>> > > registers. This can take a considerable amount of time though.
>> > > Measuremens have shown that it takes up to a whole burst cycle gap
>> > > which
>> > > is about 50ms on the largest setting. Therefore, we have to mark the
>> > > output bank as sleepable. To avoid unnecessary waiting, just trigger
>> > > the
>> > > single shot if the value was actually changed.
>> >
>> > I have tested this patch series on our lan9668 board and it worked
>> > fine. Thanks!
>> 
>> Thanks for testing!
>> 
>> > I just have few questions:
>> > 1. What about other boards/chips that have this sgpio, do they have
>> > also
>> >    the same issue? Because from what I recall on sparx5 they don't have
>> >    this issue. I have seen it only on lan9668.
>> 
>> Unfortunatly, I don't have any knowledge what IP core is used in
>> which SoC. I assumed the lan9668 used the same as the sparx5. If
>> that is not the case, we need a new compatible. Do you know if it
>> the same?
> 
> From what I see, it is the same IP.

Good to know.

>> On the sparx5 are there any peripheral who you would actually
>> notice that the timing is off?
> 
> There are some SFP connected, similar to lan966x. So I don't understand
> why that issue is not seen there.

Is there an I2C mux, too? Or just the SFP signals connected to
the SGPIO? What I was seeing is that during probing of the SFPs
the SFPs EEPROM is read and when the I2C mux is controlled by the
SGPIO it will switch too late - or even worse, in the middle of
a transaction. I would speculate the timing isn't that critical
with signals just connected directly to the SFP.

In any case, I think it is pretty clear that it cannot work the
way it is right now, no? See the very next paragraph...

>> That being said, I'd assume all the serial gpio controller has
>> this "flaw". Simply because a register write won't block until the
>> value is shifted out to the shift register and actualy loaded by
>> strobing the load signal. It just depends on your burst setting
>> (even with bursts off, and clocking all the time) on how large
>> the delay is. So you might or might not notice it on a board.

.. here

-michael
