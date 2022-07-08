Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082756C2A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiGHTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGHTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:41:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED120BD7;
        Fri,  8 Jul 2022 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657309273; x=1688845273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SBc+jIVZ5D9QGkUd2tKv1znRqGhDqmRrooiolgBYk2E=;
  b=plHOhqcOiUcNZeXBphprcn6J/UorDvmlho9OLm+ZamvcqJH0dkFHMRA3
   oT56co4Qh3BOReOlk5GNMiVftOTxAkkGHIv0pqZPak4dGbxa/VajHIjtJ
   jRhqBoT+bri/Y0K8RwdRX9BX8HJbG4cUVwRSGGZoKqNicPwknUh6qBqW/
   iznKfr8QkxbARLAAY0PODRanRy6ec7TZ1XWb7Wzh6+DSBuLTtGskOqXUy
   LksqO0g8pouJ/NqlwxNFsuQ3Lpch6VjqR/nAm3UOuC+rJguVCSBmO0NCO
   w3KEQ5RIVbw00uLGFeOi+i+B3UZeRn2LJqCHFMbpzZlcwOvO3YPgf50Gb
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="171381528"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 12:41:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 12:41:11 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 12:41:10 -0700
Date:   Fri, 8 Jul 2022 21:45:10 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <UNGLinuxDriver@microchip.com>, <alexandre.belloni@bootlin.com>,
        <colin.foster@in-advantage.com>,
        <kavyasree.kotagiri@microchip.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 1/2] pinctrl: ocelot: Fix pincfg for lan966x
Message-ID: <20220708194510.ufwsj5sqvs42zk4c@soft-dev3-1.localhost>
References: <20220707185342.2697569-2-horatiu.vultur@microchip.com>
 <20220708082752.1745233-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220708082752.1745233-1-michael@walle.cc>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/08/2022 10:27, Michael Walle wrote:

Hi Walle,

> 
> > -static struct pinctrl_desc luton_desc = {
> > -     .name = "luton-pinctrl",
> > -     .pins = luton_pins,
> > -     .npins = ARRAY_SIZE(luton_pins),
> > -     .pctlops = &ocelot_pctl_ops,
> > -     .pmxops = &ocelot_pmx_ops,
> > -     .owner = THIS_MODULE,
> > +static struct ocelot_match_data luton_desc = {
> > +     {
> .desc = {
> 
> Same for all the structs. 

Yes, I will do that.


> Also it looks like it is way too big
> for a stable backport:
>  "It cannot be bigger than 100 lines, with context."

Don't you think it is a little bit silly to apply that rule to this
patch. In the way that 70% of the patch is just indentation.

> 
> > +             .name = "luton-pinctrl",
> > +             .pins = luton_pins,
> > +             .npins = ARRAY_SIZE(luton_pins),
> > +             .pctlops = &ocelot_pctl_ops,
> > +             .pmxops = &ocelot_pmx_ops,
> > +             .owner = THIS_MODULE,
> > +     }
> >  };
> 
> -michael

-- 
/Horatiu
