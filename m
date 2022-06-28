Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A555E6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346897AbiF1NsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346884AbiF1NsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:48:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6B2A966;
        Tue, 28 Jun 2022 06:48:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E1B4522246;
        Tue, 28 Jun 2022 15:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656424080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvU588fHhLDk/FSFjMsTn0jfhxkTBTaysnF8j0/C2xI=;
        b=A84TCTJU719Ug8WU3XD4Yne89LJC6YZr+gkybgqwpjDiSB4njGiAzm5Qm8v1UEZjCwc8Ok
        NP2ljMffsEG5fWv6cDo7kDQxFWqcpsZKO28C4vhMLVip9NHmN19hc/WSp96p6ORgo5i+ho
        PCcWo1sCd52JVsCXwFtS9tUqH97nvf0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 15:47:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9e58f421c27121977d11381530757a6e@walle.cc>
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

[adding Horatiu Vultur, because we now digress to the bug
in the switch, rather than that odd OF behavior]

Am 2022-06-28 15:29, schrieb Andy Shevchenko:
> On Tue, Jun 28, 2022 at 3:23 PM Michael Walle <michael@walle.cc> wrote:
>> 
>> >> I was trying to fix the lan966x driver [1] which doesn't work if there
>> >> are disabled nodes in between.
>> >
>> > Can you elaborate what's wrong now in the behaviour of the driver? In
>> > the code it uses twice the _available variant.
>> 
>> Imagine the following device tree snippet:
>>   port0 {
>>     reg = <0>;
>>     status = "okay";
>>   }
>>   port1 {
>>     reg = <1>;
>>     status = "disabled";
>>   }
>>   port@2 {
>>     reg = <2>;
>>     status = "okay";
>>   }
>> 
>> The driver will set num_phys_ports to 2. When port@2 is probed, it
>> will have the (correct!) physical port number 2. That will then
>> trigger various EINVAL checks with "port_num >= num_phys_ports" or
>> WARN()s.
> 
> It means the above mentioned condition is wrong: it should be
> 
> "port_idx >= num_phys_ports" (if the port_idx doesn't exists, that's
> the bug in the first place)

I can't follow you here. Please note, that you need the actual
physical port number. It's not a made up number, but corresponds
to a physical port on that ethernet switch. So you can't just skip
the disabled ones. port@2 must have port number 2.

>> So the easiest fix would be to actual count all the child nodes
>> (regardless if they are available or not), assuming there are as
>> many nodes as physical ports.
>> 
>> But num_phys_ports being a property of the hardware
> 
> So, name is wrong, that's how I read it, it should be
> num_of_acrive_phys_ports (or alike).

See above, it is not just an iterator but corresponds to
a hardware property.

>> I don't
>> think it's good to deduce it by counting the child nodes anyway,
> 
> Right.
> 
>> but it should rather be a (hardcoded) property of the driver.
> 
> Also good to update.

Horatiu, can we determine the actual number of ports (or maybe
determine if its a LAN9668 or a LAN9662) from the hardware itself
in an easy way? That way we wouldn't need a new compatible string,
but could use the generic "lan966x" one.

-michael

[1] 
https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
