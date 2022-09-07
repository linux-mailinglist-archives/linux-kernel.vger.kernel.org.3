Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317A15B0D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIGToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:43:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38EBD2B8;
        Wed,  7 Sep 2022 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662579837; x=1694115837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SqKdsVfuMNfF/kYon0FinpmGSA9ou1xdxHFefw2RUE0=;
  b=EWQPOLgf3yPdy7fNut7sFuBKFIYdsQjbwnDL9AgakUdMroBpOQCWn2Gm
   Zfhp3s2QJha8cRR4r9S11eSHmUjbuaArWU4qdf4zK9JBz46yOqbiNyA+5
   vjnJ+vpv//bRk5JLlH/AF2r/6pD2nrQa5+nhkAD9yfXBhZsoFfjAfRHpR
   fzSq8WLrv5lgoV++/dyzz0ANMkWyGNPyaOQLtNuWkoo2cod7hfmXq9Rla
   xaCA8WWpDeCgDQqvnxRTVxEX+cKpzKAdUu5XK2lv1PRR/i3q9kaB89ZBh
   rhGDv102e0i9QxwlbPGNmTlpZv8piFXOEqW8+dwD6oUIl30ki9ix1hYoE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="179463234"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 12:43:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 12:43:34 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 12:43:34 -0700
Date:   Wed, 7 Sep 2022 21:47:54 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220907194754.nw4jpghsjzuz2jcu@soft-dev3-1.localhost>
References: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
 <CAHp75VecfNvj3Ji1ivZk3cpwbpr8F4FX0xR5H+=CjAO_o-uuxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VecfNvj3Ji1ivZk3cpwbpr8F4FX0xR5H+=CjAO_o-uuxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/07/2022 11:36, Andy Shevchenko wrote:
> > +        * handler.
> > +        */
> > +       if (active && !ack) {
> > +               struct ocelot_irq_work *work;
> > +
> > +               work = kmalloc(sizeof(*work), GFP_ATOMIC);
> > +               if (!work)
> > +                       return;
> > +
> > +               work->irq_desc = desc;
> > +               INIT_WORK(&work->irq_work, ocelot_irq_work);
> > +               queue_work(system_wq, &work->irq_work);
> > +       }
> 
> Here I see potential issues with the object lifetime. 1) The memory is
> allocated here and what does guarantee its freeing? 2) What does
> guarantee that work will be not scheduled if the driver or its parts
> are gone?

You are right, if the driver is removed once the work is queued, then
that object will not be freed or even worst get NULL pointers.

A solution to this would be not to use system_wq but allocate own workqueue
and once the driver is removed, make sure to destroy it.
In this way we make sure that all the work is done.

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
