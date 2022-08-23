Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D859E54E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiHWOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbiHWOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:45:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B0DF4DA;
        Tue, 23 Aug 2022 05:06:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 1so6075800pfu.0;
        Tue, 23 Aug 2022 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=kyFhrbWpMoqpbaaeBfMKJhxmPkYAP/kAn0s8ogIirHY=;
        b=kUPKmzaoHw0F7lxzyruB2Al7Fo9nFaUBdzgQDJg5hr8Z1+wwIz8Bvtr5xukaPHD8p2
         QD25gRhO9MA1XUZBoplYuVWBk+wpi9ukGuHV9cmBvjS5tldBkMU08Siv3FJPA9kQhxDf
         F3MWe2KYLPVo41OfQ21nzNVzG22Tipt4Wmfv82S83CQbdZyySwR9t4XOeCe2MLq6KXXq
         z+A7CbvPB5jD1ULv9actSJdg/vsp+eNlfcAVh4LuJUS4T0ISQbTT8FbnxYT4Yfzc4NWm
         qB6hxMb7MKZ7od4dU54snzsSGCR9f4RmKfBYF3GJDPRgYJ3y+pzZ4qM7TwKNCT/979tR
         R00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=kyFhrbWpMoqpbaaeBfMKJhxmPkYAP/kAn0s8ogIirHY=;
        b=Ft3/XXMeDuRc0/aWl9as9thbmw7hR978hMdjRfH7bHTOHz/gnpiWZv/iV1l9fDlBzv
         uHOhRgoh3GnKOmtBe0uSwoTv7EkqcTPYC9aWmL3XLOd/QfDb8zDkpdAT39LXszZf9vOK
         efmak0de7AoPqvu0bok38O9ThAVtAEa5j2JH91p0d+wbg6Yt7z6akcB0vfWdeyHqIUg5
         FiBT+OPCgMVZCiE+OWezc3/EFaufJ6QKrQuWDqWP872YjiFxtazVizRzENyR8YeiAw0z
         2A1PqCwsbH8z6p+aofLcJHCt0SATzfGKU9nItwqAzVZHqF1DV3UcZ7vdfus/rqyer+8h
         NjBg==
X-Gm-Message-State: ACgBeo3iH9/D5jvr345WL3leMQeOfwzJz60iFB0lQGfKpiN6uDR1ei9k
        DhsjbbrNkK8IA6e7rMK/Qlk=
X-Google-Smtp-Source: AA6agR7ffd/XO/wZqU88ZC5eF1NtcSC0aUyRg5oeg59+DtqQqTane8yLeJrnkiNw29enLw8LSIOw5g==
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id e4-20020a656bc4000000b003c22f7ccc74mr20199853pgw.307.1661256328479;
        Tue, 23 Aug 2022 05:05:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p63-20020a634242000000b004291cb9c047sm9037934pga.87.2022.08.23.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:05:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Aug 2022 05:05:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Message-ID: <20220823120525.GB203169@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-4-alice.guo@oss.nxp.com>
 <20220822140557.GB4087281@roeck-us.net>
 <AM6PR04MB6053DBC927D643877A2A979AE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6053DBC927D643877A2A979AE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:46:55AM +0000, Alice Guo (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Monday, August 22, 2022 10:06 PM
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog
> > init
> > 
> > On Tue, Aug 16, 2022 at 12:36:39PM +0800, Alice Guo (OSS) wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > When bootloader has enabled the CMD32EN bit, switch to use 32bits
> > > unlock command to unlock the CS register. Using 32bits command will
> > > help on avoiding 16 bus cycle window violation for two 16 bits
> > > commands.
> > >
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > > ---
> > >  drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > b/drivers/watchdog/imx7ulp_wdt.c index b8ac0cb04d2f..a0f6b8cea78f
> > > 100644
> > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > @@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base,
> > > unsigned int timeout)
> > >
> > >  	local_irq_disable();
> > >
> > > -	mb();
> > > -	/* unlock the wdog for reconfiguration */
> > > -	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > > -	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > > -	mb();
> > > +	val = readl(base + WDOG_CS);
> > > +	if (val & WDOG_CS_CMD32EN) {
> > > +		writel(UNLOCK, base + WDOG_CNT);
> > > +	} else {
> > > +		mb();
> > > +		/* unlock the wdog for reconfiguration */
> > > +		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > > +		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > > +		mb();
> > 
> > Now this is intermixing writel() with writel_relaxed(), making the code all but
> > impossible to understand.
> > 
> > Guenter
> 
> Hi Guenter,
> 
> Intermixing writel() with writel_relaxed() is unavoidable here. Because there cannot be a memory barrier between writing UNLOCK_SEQ0 and writing UNLOCK_SEQ1. This may be determined by hardware design.
> 

If it is indeed impossible to configure the watchdog for 32-bit
access mode, that needs to be explained in the code and backed up,
for example with a reference to the documentation. Similar,
it needs to be documented in the code why writel() does not work
here and why mb() is needed.

Thanks,
Guenter

> Best Regards,
> Alice Guo
>  
> > > +	}
> > >
> > >  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> > >  	if (ret)
> > > --
> > > 2.17.1
> > >
