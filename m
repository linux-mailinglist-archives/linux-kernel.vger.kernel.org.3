Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97CF55E87B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbiF1PJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiF1PJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:09:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1E95A8;
        Tue, 28 Jun 2022 08:09:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 91B6222246;
        Tue, 28 Jun 2022 17:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656428963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kEBJdoPP+ZathQ1a3NWo7Je/syyaPZVyg6lZYXe3rs=;
        b=Wfq+AR9EfUagI4NWajhsfogZyWQpriwV3UdxYRqiy3HaMH7uABI87ieWD17CuMGzrpn1Gl
        ahWd2s4pHf8u69MMXw2myhv/sTOOVkxvchTRDpgliweAvW6HsP9nkiVwDguLmQVUqZA3FJ
        LOz/7fZAKUORwLwBMI7QD0rsYuUHSGw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 17:09:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
 <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
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

Am 2022-06-28 16:36, schrieb Krzysztof Kozlowski:
> On 28/06/2022 16:22, Michael Walle wrote:
>>>> I can't follow you here. Please note, that you need the actual
>>>> physical port number. It's not a made up number, but corresponds
>>>> to a physical port on that ethernet switch. So you can't just skip
>>>> the disabled ones. port@2 must have port number 2.
>>> 
>>> The number "2" you get from the reg property, so where is exactly the
>>> problem?
>> 
>> That you need to get the total number of ports of the hardware (which
>> is also used for things beyond validation, eg. during switch init
>> all ports will are disabled). And right now, that is done by counting
>> all the nodes - which is bad, I guess we agree here.
> 
> It's bad also from another reason - the DT node was explicitly 
> disabled,
> but you perform some operation on actual hardware representing this
> node. I would assume that a disabled DT node means it is not
> operational, e.g. hardware not present or missing clocks, so you should
> not treat it as another meaning - power down/unused.

Mh. Assume a SoC with an integrated ethernet switch. Some ports
are externally connected, some don't. I'd think they should be disabled,
no? Until now, all bindings I know, treat them as disabled. But OTOH
you still need to do some configurations on them, like disable port
forwarding, disable them or whatever. So the hardware is present, but
it is not connected to anything.

>> But it works,
>> as long as no ports are disabled and all ports are described in the
>> device tree. But I have device trees where some are disabled.
> 
> I am not sure if I follow this. You have devices which
> 1. have unused ports, but all DT nodes are available/okay,
> 2. have unused ports, which are in DT status=disabled?
> 
> Doesn't case 2 break the bindings? If so, we don't care about such
> out-of-tree users. We cannot support all of possible weird combinations
> in out-of-tree DTS files...

Case 1 is invalid I think.

How does case 2 break the binding? It breaks the driver, yes. But not
the binding. I agree on the out-of-tree argument, *but* isn't that
what the binding is for, that out-of-tree device trees gonna work as
long as they follow the binding? And I don't see where it dictates that 
all
nodes must be enabled; nor that it must either be 2 or 8 children nodes.

>> I assume, you cannot read the hardware itself to get the number of
>> physical ports; and we have the compatible "microchip,lan966x-switch",
>> which is the generic one, so it could be the LAN9668 (with 8 ports)
>> or the LAN9662 (with 2 ports).
> 
> I'll keep that argument for future when I see again patches adding such
> wildcard compatible. :) I had to discuss with some folks...
> 
> Although the compatible difference does not have to be important here,
> because one could say the 9662 and 9668 programming model is exaclty 
> the
> same and they differ by number of ports. This number of ports can be a
> dedicated property or counted from the children (if they were all
> available).

Mh. Rob was always in favor of dedicated compatible strings. And I
think there are also subtle differences. Eg. the LAN9662 has some kind
of accelerating engine, if I'm not mistaken.

So what do you prefer:

   compatible = "microchip,lan9668";
and
   compatible = "microchip,lan9662";

or

   compatible = "microchip,lan966x";
   microchip,num-phys-ports = <8>;
and
   compatible = "microchip,lan966x";
   microchip,num-phys-ports = <2>;
   microchip,accelerating-engine;
   ..

The argument here was always, we don't want too much properties if
it can be deduced by the compatible string.

>> We somehow have to retain backwards
>> compatibility. Thus my idea was to at least make the handling slightly
>> better and count *any* child nodes. So it doesn't fall apart with
>> disabled
>> nodes. Then introduce proper compatible strings
>> "microchip,lan9668-switch"
>> and use that to hardcode the num_phys_ports to 8. But there will be
>> device trees with microchip,lan966x-switch out there, which we do want
>> to support.
>> 
>> I see the following options:
>>   (1) just don't care and get rid of the "microchip,lan966x-switch"
>>       compatible
>>   (2) quick fix for the older kernels by counting all the nodes and
>>       proper fix for the newer kernels with dedicated compatibles
>>   (3) no fix for older kernels, introduce new compatibles for new
>>       kernels
> 
> I propose this one. I would not care about out-of-tree DTSes which
> decided to disable random stuff and expect things working. :)

I'd argue, that is the usual case for all the switch bindings I
know of; not some unusual config. E.g. the SoC dtsi disables all
ports by default and only the ones which are actually connected
by the board are then enabled in the board dts, see
arch/arm/boot/dts/lan966x.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi

That being said, I don't care too much about the older kernels.
So I'm fine with (3).

-michael

> 
>>   (4) keep generic compatible if the hardware can be read out to get
>>       the number of ports.
>> 
>> I think (1) isn't the way to go. (2) was my try until I noticed
>> that odd fwnode behavior. But judging by this thread, I don't think
>> thats possible. I don't know if (4) is possible at all. If not we'd
>> be left with (3).

