Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B605AC0D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiICSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiICSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:38:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD25508E;
        Sat,  3 Sep 2022 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662230296; x=1693766296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpinBAJKB6E6Wwqx7GDFK6m+AcQ6AEB6MqMz5swIr2Y=;
  b=g38UIYZkUn7CAATen4cC1McmvWpu/Lp29/pUnDlxvTXXv9Z0IzfOZdf+
   49Ps4DLXXXzaN+ZHtfT0UmQcIq3oxfEHSKJMEADUz2YZe80vxjwQFGDZ0
   lFYqQ4LRt38vsCqiJykekvnETPkoparRjYa8/7xpIytAHDrFIKfOyzrXS
   wkTYjjTk0TZ2HOsvQk+TWgjljo5+aBqf7w8Se3Hyv2n919K2pa8O6RzV+
   6yoAfiSnjIiH5+MgLzMrTt33r+lIOSNHfDXkWQOsH0wZP+cApCJjethtw
   Fp5/3y+kFatRwjFGGdqczwMer6BFN/VEmYC0UxQqKAh8AyDovVZkqOG8n
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="179063137"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Sep 2022 11:38:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 3 Sep 2022 11:38:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Sat, 3 Sep 2022 11:38:15 -0700
Date:   Sat, 3 Sep 2022 20:42:33 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220903184233.whjduwtdyuvyf6lv@soft-dev3-1.localhost>
References: <20220902124354.630826-1-horatiu.vultur@microchip.com>
 <CAHp75Ve7EkE3q3_nOvT_KLmpmnXzMw179nbOxYEYzUeLY0QRnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve7EkE3q3_nOvT_KLmpmnXzMw179nbOxYEYzUeLY0QRnw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/02/2022 17:51, Andy Shevchenko wrote:

Hi Andy,

> 
> > +       /*
> > +        * It is enough to read only one action because the trigger level is the
> > +        * same for all of them.
> > +        */
> 
> Hmm... this is interesting. How is the hardware supposed to work if
> the user asks for two contradictory levels for two different IRQs?

The HW can detect the changes in line for each pin on which the IRQ is.
And each pin will have a different irq_desc with different actions.
Or maybe I missunderstood the question?

Also maybe a better way to get trigger level is to use
irqd_get_trigger_type.

...

> > +               struct ocelot_irq_work *work = kmalloc(sizeof(*work), GFP_ATOMIC);
> 
> It's more visible what's going on if you split this to definition and
> assignment and move assignment closer to its first user.
> 
> > +               if (!work)
> > +                       return;

So you would like something like this:
---
struct ocelot_irq_work *work;

work = kmalloc(sizeof(*work), GFP_ATOMIC);
if (!work)
    return;
...
---

> 
> ...
> 
> >         type &= IRQ_TYPE_SENSE_MASK;
> 
> This seems redundant, see below.
> 
> 
> > -       if (!(type & (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH)))
> > +       if (type == IRQ_TYPE_NONE)
> >                 return -EINVAL;
> 
> Is it ever possible? IIRC the IRQ chip code, the set->type won't be
> called at all in such a case. Also type is already limited to the
> sense mask, no?

It is not possible. From what I have seen on the callstack, the type is
already anded with IRQ_TYPE_SENSE_MASK, and it would not call
ocelot_irq_set_type for IRQ_TYPE_NONE.
Therefor I will remove these.

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
