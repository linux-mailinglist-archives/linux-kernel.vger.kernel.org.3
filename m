Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B456254B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiF3Vca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiF3VcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:32:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0E50715;
        Thu, 30 Jun 2022 14:32:25 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2DA3D22236;
        Thu, 30 Jun 2022 23:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656624742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhIM7xkXVLpCgTOC9u3u0l6IjtG+a88bi2pntBrpJIo=;
        b=hT11cBNXtnyB1FKwoVxTYskaPjbn+HRZOW0dtvXqnJjTwl4IOPN22WvQMtA18pog25XKyP
        SnIMOdm11PExB994mPfRKmKLvxSf2D7NXOQAF2cSXI5tC9D/dUfSXs1kCa2XgpQ3UMtEAr
        XJ1mefUOgXAdvhuqdxj2p/hWOZ/ZqlA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jun 2022 23:32:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <20220630212120.t3in6i7s7chaqacr@skbuf>
References: <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
 <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
 <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
 <20220628205254.gnllvaz7w5jmpfe5@soft-dev3-1.localhost>
 <4782de1fc6692a98bd6c267c2714325f@walle.cc>
 <20220630201617.sqpihcevym7sxqng@soft-dev3-1.localhost>
 <b0e3cd1f6b210943030a1e7a355d1a7f@walle.cc>
 <20220630212120.t3in6i7s7chaqacr@skbuf>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <65a17cff8d80b0c27976a2c2a17519bf@walle.cc>
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

Am 2022-06-30 23:21, schrieb Vladimir Oltean:
> On Thu, Jun 30, 2022 at 11:00:37PM +0200, Michael Walle wrote:
>> > > > It is not possible to have a defined for the MAX number of ports that
>> > > > supported by lan966x. Which is 8. And assigned that define to
>> > > > num_phys_ports instead of counting the entries in DT?
>> > >
>> > > You mean also for the lan9662? I'm pretty sure that doesn't
>> > > work. Have a look where num_phys_ports is used. One random
>> > > example:
>> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c#L874
>> > >
>> > > So if your switch only has 4 ports, then I'd guess you'll
>> > > access a non-existing register.
>> >
>> > Underneath lan662 and lan668 is the same chip. The HW people disable
>> > some ports/features on each platform but from what I know you will still
>> > be able to access the registers.
>> 
>> I noticed that there are still 8 ports in the register description and
>> assumed that it was wrong [1]. But ok, that makes sense in some way.
>> OTOH that means, we cannot do the guesswork Vladimir proposed.
>> 
>> -michael
>> 
>> [1] 
>> https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html
> 
> Are you 100% positive that the default values for the flooding PGIDs 
> are
> GENMASK(8, 0) for a 4-port switch? And that the packet buffer has the
> same size for a switch with half as many ports? Ok...
> 
> But in that case, what exactly is the problem if the port count of 8 is
> a synthesis time constant for lan966x, and if the CPU port module is
> always at index 8 in the analyzer (with a gap between indices 4 and 7)?
> Just hardcode lan966x->num_phys_ports to 8 and work with that 
> throughout.
> Allocate lan966x->ports as an array of 8 pointers to struct 
> lan966x_port
> (which they are already), and the pointers themselves are populated as
> being the netdev_priv of the interfaces that are actually present and
> used. Literally the only thing you need to fix is that you need to
> hardcode num_phys_ports to 8, problem solved. It means that lan9662 is
> nothing but a lan9668 where the last 4 ports have 'status = "disabled"'
> in the device tree.

If that's the case, sure. The last four ports can just be omitted no?
Of course you'll lose the possibility to validate the device tree ports
input, i.e. port@5 would perfectly valid although it doesn't make any
sense for the lan9662. (Regardless if it is disabled, or if it's 
omitted)

-michael
