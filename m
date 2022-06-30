Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449BF5623FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiF3UMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiF3UM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:12:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B045519;
        Thu, 30 Jun 2022 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656619945; x=1688155945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAJNP6Q4x6+0+j5y4dRqku115cNqe9oib6TCpNrW0Yw=;
  b=FzeGQdvOLozG7iwYK73bQ4tRCk/2K2IIgQnFpkiFgD+DVfl5EvHosu8u
   emCa0NEk9aGtRNTIq2c/YWdMV9YutxFttE/87VfYAf+V5ep4hWZLOYsBT
   dYYSVV5sTkVj7EejdRvMWeJaJhn6O60LOXiBuliGjCOuxTGKgLqmqDxs4
   SySgWlzrrYDYLrp1+tW1lCTeQNqt8dN3EYPnYxFx/8K6qMRlmp+3U2WZx
   DN5XCbjMAWq7R9nmvPiMkfpa2P9brvFcQ10/l9hM4jaVCht4ndDDrCDbH
   fqsZjtYKnDxWR/EKUH0XvpXwqREgPZ0K23lAId8w9D5bk/ksmYa5RVjVE
   A==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="170313557"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 13:12:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 13:12:23 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 30 Jun 2022 13:12:23 -0700
Date:   Thu, 30 Jun 2022 22:16:17 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <20220630201617.sqpihcevym7sxqng@soft-dev3-1.localhost>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4782de1fc6692a98bd6c267c2714325f@walle.cc>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/28/2022 23:07, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Am 2022-06-28 22:52, schrieb Horatiu Vultur:
> > The 06/28/2022 22:28, Andy Shevchenko wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > > 
> > > On Tue, Jun 28, 2022 at 5:17 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > On 28/06/2022 17:09, Michael Walle wrote:
> > 
> > Hi,
> > 
> > Sorry for joint this late.
> > 
> > > 
> > > ...
> > > 
> > > > > Mh. Assume a SoC with an integrated ethernet switch. Some ports
> > > > > are externally connected, some don't. I'd think they should be disabled,
> > > > > no? Until now, all bindings I know, treat them as disabled. But OTOH
> > > > > you still need to do some configurations on them, like disable port
> > > > > forwarding, disable them or whatever. So the hardware is present, but
> > > > > it is not connected to anything.
> > > >
> > > > I see your point and the meaning is okay... except that drivers don't
> > > > touch disabled nodes. If a device (with some address space) is disabled,
> > > > you do not write there "please be power off". Here the case is a bit
> > > > different, because I think ports do not have their own address space.
> > > > Yet it contradicts the logic - something is disabled in DT and you
> > > > expect to perform actual operations on it.
> > > 
> > > You beat me up to this comment, I also see a contradiction of what
> > > "disabled" means in your, Michael, case and what it should be.
> > > 
> > > If you need to perform an operation on some piece of HW, it has not to
> > > be disabled.
> > > 
> > > Or, you may deduce them by knowing how many ports in hardware (this is
> > > usually done not by counting the nodes, but by a property) and do
> > > whatever you want on ones, you have  not listed (by port_num) in the
> > > array of parsed children.
> > 
> > It is not possible to have a defined for the MAX number of ports that
> > supported by lan966x. Which is 8. And assigned that define to
> > num_phys_ports instead of counting the entries in DT?
> 
> You mean also for the lan9662? I'm pretty sure that doesn't
> work. Have a look where num_phys_ports is used. One random
> example:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c#L874
> 
> So if your switch only has 4 ports, then I'd guess you'll
> access a non-existing register.

Underneath lan662 and lan668 is the same chip. The HW people disable
some ports/features on each platform but from what I know you will still
be able to access the registers.

> 
> -michael

-- 
/Horatiu
