Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A814CD646
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiCDOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCDOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:24:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0FEBAD9;
        Fri,  4 Mar 2022 06:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646403797; x=1677939797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U4D+rWZDzGJXpcju3PJJJDSxJtaedGVbYtfFx7f1Xio=;
  b=wx+UegTL2z1UHegJM4dmqz1WGCQQhKF4/ayfK8Zf5yvHoUTK3Oy/VJFs
   I7N77c995k52aYl73jtMOkWB+XlpYlhreTDZkDUgyuEaieBS8AbT9+lPw
   0JCw585xUIz9m+xf0vTnwkWvrJ4JD4a7LL5MdobvgU//hZRJXDK3ZAZ3h
   qmFcRNgVyKvEaxWzWSIu6bwb3w3I/i0VtMGLhyoSYrUxwnkdMF7e5yetF
   w36+JyuAqtjBHI60PM4a+eEtGeH9LS3/Bp2nFCqEehaaV2s4GfiuCPURD
   ZS0wTdMb6U0+oapsx9/M+xMQXa9J+54pP/tBUYQZAMM4csVPJyZCtRnjB
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164545832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:23:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:23:16 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 07:23:16 -0700
Date:   Fri, 4 Mar 2022 15:26:06 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix interrupt parsing
Message-ID: <20220304142606.3yxwah4k36deqa3e@soft-dev3-1.localhost>
References: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
 <20220303203716.3012703-3-horatiu.vultur@microchip.com>
 <YiIIxXemSB8LIq8L@smile.fi.intel.com>
 <YiII4mMembqLiX5D@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YiII4mMembqLiX5D@smile.fi.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 03/04/2022 14:41, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Mar 04, 2022 at 02:40:38PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 03, 2022 at 09:37:16PM +0100, Horatiu Vultur wrote:
> > > In the blamed commit, it removes the duplicate of_node assignment in the
> > > driver. But the driver uses this before calling into of_gpio_dev_init to
> > > determine if it needs to assign an IRQ chip to the GPIO. The fixes
> > > consists in using of_node from dev.
> >
> > ...
> >
> > > -   irq = irq_of_parse_and_map(gc->of_node, 0);
> > > +   irq = irq_of_parse_and_map(info->dev->of_node, 0);
> >
> > Why platform_get_irq() can't be used?
> 
> Or actually _optional() variant of it?

It can be used. I will update this in the next series.

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
/Horatiu
