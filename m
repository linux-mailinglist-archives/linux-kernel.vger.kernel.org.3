Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB35624B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiF3VAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiF3VAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:00:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CEE4D15C;
        Thu, 30 Jun 2022 14:00:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3E15522236;
        Thu, 30 Jun 2022 23:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656622837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTq9btX49e5m0sHPzYxeKQ7Uls84RHJVy8UQyM+UM8A=;
        b=ItoMZoyefxT3MZJQUuqoJungzv5DfQ3AS7XH6+UKt/7YkBckqSB1Le3Zes3vqUivhnYZgb
        t5HdLmGbNNcWbSiHZ5RKcNhyiImpM7tQ8aRVo5SRmcX/v6oqxb7+rul4AlW/oeAnBFFrZ9
        j/wpJJna3ICu9q5NCQBOKVV2RKgxIwI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jun 2022 23:00:37 +0200
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <20220630201617.sqpihcevym7sxqng@soft-dev3-1.localhost>
References: <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
 <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
 <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
 <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
 <20220628205254.gnllvaz7w5jmpfe5@soft-dev3-1.localhost>
 <4782de1fc6692a98bd6c267c2714325f@walle.cc>
 <20220630201617.sqpihcevym7sxqng@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b0e3cd1f6b210943030a1e7a355d1a7f@walle.cc>
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

Am 2022-06-30 22:16, schrieb Horatiu Vultur:
> The 06/28/2022 23:07, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-06-28 22:52, schrieb Horatiu Vultur:
>> > The 06/28/2022 22:28, Andy Shevchenko wrote:
>> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> > > the content is safe
>> > >
>> > > On Tue, Jun 28, 2022 at 5:17 PM Krzysztof Kozlowski
>> > > <krzysztof.kozlowski@linaro.org> wrote:
>> > > > On 28/06/2022 17:09, Michael Walle wrote:
>> >
>> > Hi,
>> >
>> > Sorry for joint this late.
>> >
>> > >
>> > > ...
>> > >
>> > > > > Mh. Assume a SoC with an integrated ethernet switch. Some ports
>> > > > > are externally connected, some don't. I'd think they should be disabled,
>> > > > > no? Until now, all bindings I know, treat them as disabled. But OTOH
>> > > > > you still need to do some configurations on them, like disable port
>> > > > > forwarding, disable them or whatever. So the hardware is present, but
>> > > > > it is not connected to anything.
>> > > >
>> > > > I see your point and the meaning is okay... except that drivers don't
>> > > > touch disabled nodes. If a device (with some address space) is disabled,
>> > > > you do not write there "please be power off". Here the case is a bit
>> > > > different, because I think ports do not have their own address space.
>> > > > Yet it contradicts the logic - something is disabled in DT and you
>> > > > expect to perform actual operations on it.
>> > >
>> > > You beat me up to this comment, I also see a contradiction of what
>> > > "disabled" means in your, Michael, case and what it should be.
>> > >
>> > > If you need to perform an operation on some piece of HW, it has not to
>> > > be disabled.
>> > >
>> > > Or, you may deduce them by knowing how many ports in hardware (this is
>> > > usually done not by counting the nodes, but by a property) and do
>> > > whatever you want on ones, you have  not listed (by port_num) in the
>> > > array of parsed children.
>> >
>> > It is not possible to have a defined for the MAX number of ports that
>> > supported by lan966x. Which is 8. And assigned that define to
>> > num_phys_ports instead of counting the entries in DT?
>> 
>> You mean also for the lan9662? I'm pretty sure that doesn't
>> work. Have a look where num_phys_ports is used. One random
>> example:
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c#L874
>> 
>> So if your switch only has 4 ports, then I'd guess you'll
>> access a non-existing register.
> 
> Underneath lan662 and lan668 is the same chip. The HW people disable
> some ports/features on each platform but from what I know you will 
> still
> be able to access the registers.

I noticed that there are still 8 ports in the register description and
assumed that it was wrong [1]. But ok, that makes sense in some way.
OTOH that means, we cannot do the guesswork Vladimir proposed.

-michael

[1] https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html
