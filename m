Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7755EFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiF1UtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiF1UtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:49:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318FD2FFCB;
        Tue, 28 Jun 2022 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656449343; x=1687985343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cg45xE86ZQPIpdJNzgkrosfv+mhFQVH6uL2peFEdMEk=;
  b=wL9gwpdJi6fiCwotYwWrUwF6zpq82Uvbb90LluPsZVVgqv+u6T8/Hb8q
   X2a9Lk2q9pYOEyBv4Et0eNoarTZ7zNrcHRp0IhqY9mWHtjSfqgQnWwHLR
   dgLVUTpZ9L+d/fMi0NF1scAkZM8RPdF8yM3/Xsvmxe5bTdKi1FyenAeNc
   jDpmVv7x1oo5AP5SbSCxCVcefTOmNBce4h2zVJea+TCwS/zUWvWE5ukWp
   dftXt/VHscpba7X6+L/bkXnauj5Mjbk6I+SjNAurcnECkQlcHCFx6isO4
   2rE2NwJY0NaO+Y09YwYMcjSVkh8bI4dAwW2Qug/1t8XJsbVcpBh9VP3hj
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="170271606"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 13:49:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 13:49:02 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 28 Jun 2022 13:49:01 -0700
Date:   Tue, 28 Jun 2022 22:52:54 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <20220628205254.gnllvaz7w5jmpfe5@soft-dev3-1.localhost>
References: <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
 <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
 <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
 <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/28/2022 22:28, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jun 28, 2022 at 5:17 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 28/06/2022 17:09, Michael Walle wrote:

Hi,

Sorry for joint this late.

> 
> ...
> 
> > > Mh. Assume a SoC with an integrated ethernet switch. Some ports
> > > are externally connected, some don't. I'd think they should be disabled,
> > > no? Until now, all bindings I know, treat them as disabled. But OTOH
> > > you still need to do some configurations on them, like disable port
> > > forwarding, disable them or whatever. So the hardware is present, but
> > > it is not connected to anything.
> >
> > I see your point and the meaning is okay... except that drivers don't
> > touch disabled nodes. If a device (with some address space) is disabled,
> > you do not write there "please be power off". Here the case is a bit
> > different, because I think ports do not have their own address space.
> > Yet it contradicts the logic - something is disabled in DT and you
> > expect to perform actual operations on it.
> 
> You beat me up to this comment, I also see a contradiction of what
> "disabled" means in your, Michael, case and what it should be.
> 
> If you need to perform an operation on some piece of HW, it has not to
> be disabled.
> 
> Or, you may deduce them by knowing how many ports in hardware (this is
> usually done not by counting the nodes, but by a property) and do
> whatever you want on ones, you have  not listed (by port_num) in the
> array of parsed children.

It is not possible to have a defined for the MAX number of ports that
supported by lan966x. Which is 8. And assigned that define to
num_phys_ports instead of counting the entries in DT?
I have seen that sparx5 is doing something similar. [1]

Also unfortunately, I am not aware of any register that says if it is
lan9662 or lan9668.

Also lan9662 can have up to 4 ports.

[1] https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/sparx5/sparx5_main.h#L231

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
