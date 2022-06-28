Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA155E64E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbiF1OW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346034AbiF1OWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:22:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF22A721;
        Tue, 28 Jun 2022 07:22:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9FE0F22246;
        Tue, 28 Jun 2022 16:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656426140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA+MwPipS1kw45akCR5mzeWbpA0OPV3LD23nawzTOUU=;
        b=K6ecoJymiNv3Xy9NhukoNQSpxQmxtAUigOWN/bLHVw1gstBfWiElIG/C3v7UGREVPw3B9j
        iUGQNxSPAsQHVdzaeZtz/Ra9B/kYiicanBFPZRTvJsPNGqsQptQxQw0d9lHhYDBM9x4xXd
        n0I1SEmN8+kIjD/DPiMYRk/1rP6xWVY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 16:22:20 +0200
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
In-Reply-To: <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
 <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <288f56ba9cfad46354203b7698babe91@walle.cc>
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

Am 2022-06-28 15:51, schrieb Krzysztof Kozlowski:
> On 28/06/2022 15:47, Michael Walle wrote:
>> [adding Horatiu Vultur, because we now digress to the bug
>> in the switch, rather than that odd OF behavior]
>> 
>> Am 2022-06-28 15:29, schrieb Andy Shevchenko:
>>> On Tue, Jun 28, 2022 at 3:23 PM Michael Walle <michael@walle.cc> 
>>> wrote:
>>>> 
>>>>>> I was trying to fix the lan966x driver [1] which doesn't work if 
>>>>>> there
>>>>>> are disabled nodes in between.
>>>>> 
>>>>> Can you elaborate what's wrong now in the behaviour of the driver? 
>>>>> In
>>>>> the code it uses twice the _available variant.
>>>> 
>>>> Imagine the following device tree snippet:
>>>>   port0 {
>>>>     reg = <0>;
>>>>     status = "okay";
>>>>   }
>>>>   port1 {
>>>>     reg = <1>;
>>>>     status = "disabled";
>>>>   }
>>>>   port@2 {
>>>>     reg = <2>;
>>>>     status = "okay";
>>>>   }
>>>> 
>>>> The driver will set num_phys_ports to 2. When port@2 is probed, it
>>>> will have the (correct!) physical port number 2. That will then
>>>> trigger various EINVAL checks with "port_num >= num_phys_ports" or
>>>> WARN()s.
>>> 
>>> It means the above mentioned condition is wrong: it should be
>>> 
>>> "port_idx >= num_phys_ports" (if the port_idx doesn't exists, that's
>>> the bug in the first place)
>> 
>> I can't follow you here. Please note, that you need the actual
>> physical port number. It's not a made up number, but corresponds
>> to a physical port on that ethernet switch. So you can't just skip
>> the disabled ones. port@2 must have port number 2.
> 
> The number "2" you get from the reg property, so where is exactly the
> problem?

That you need to get the total number of ports of the hardware (which
is also used for things beyond validation, eg. during switch init
all ports will are disabled). And right now, that is done by counting
all the nodes - which is bad, I guess we agree here. But it works,
as long as no ports are disabled and all ports are described in the
device tree. But I have device trees where some are disabled.

I assume, you cannot read the hardware itself to get the number of
physical ports; and we have the compatible "microchip,lan966x-switch",
which is the generic one, so it could be the LAN9668 (with 8 ports)
or the LAN9662 (with 2 ports). We somehow have to retain backwards
compatibility. Thus my idea was to at least make the handling slightly
better and count *any* child nodes. So it doesn't fall apart with 
disabled
nodes. Then introduce proper compatible strings 
"microchip,lan9668-switch"
and use that to hardcode the num_phys_ports to 8. But there will be
device trees with microchip,lan966x-switch out there, which we do want
to support.

I see the following options:
  (1) just don't care and get rid of the "microchip,lan966x-switch"
      compatible
  (2) quick fix for the older kernels by counting all the nodes and
      proper fix for the newer kernels with dedicated compatibles
  (3) no fix for older kernels, introduce new compatibles for new
      kernels
  (4) keep generic compatible if the hardware can be read out to get
      the number of ports.

I think (1) isn't the way to go. (2) was my try until I noticed
that odd fwnode behavior. But judging by this thread, I don't think
thats possible. I don't know if (4) is possible at all. If not we'd
be left with (3).

> If you want to validate it against some maximum number of ports, based
> on DTS, it makes no sense... One can supply a DTS with port number 
> 10000
> and 10000 nodes, or with specific property "maximum-port-number=10000".
> It would make sense if you validate it against driver-hard-coded values
> (which you later mentioned in your reply).

Yes, see above.

-michael
