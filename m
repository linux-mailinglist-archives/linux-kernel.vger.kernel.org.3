Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF24E613F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbiCXJqC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiCXJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:45:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2C9F397
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:44:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXK10-0005rl-8j; Thu, 24 Mar 2022 10:44:22 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXK0w-002fO9-LZ; Thu, 24 Mar 2022 10:44:21 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXK0y-0003BF-MV; Thu, 24 Mar 2022 10:44:20 +0100
Message-ID: <66a8bb8aebf2a6683aca4303f6b6bf598ed7afd0.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: add support for fwnode
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 24 Mar 2022 10:44:20 +0100
In-Reply-To: <20220323172121.220a26e9@fixe.home>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
         <20220323095022.453708-3-clement.leger@bootlin.com>
         <ba95a3fec9c726e2cd61665ac5d7f89d16232d60.camel@pengutronix.de>
         <20220323172121.220a26e9@fixe.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2022-03-23 at 17:21 +0100, Clément Léger wrote:
> Le Wed, 23 Mar 2022 16:29:41 +0100,
> Philipp Zabel <p.zabel@pengutronix.de> a écrit :
> 
> > On Mi, 2022-03-23 at 10:50 +0100, Clément Léger wrote:
> > [...]
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 61e688882643..f014da03b7c1 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -4,6 +4,7 @@
> > >   *
> > >   * Copyright 2013 Philipp Zabel, Pengutronix
> > >   */
> > > +#include <linux/acpi.h>
> > >  #include <linux/atomic.h>
> > >  #include <linux/device.h>
> > >  #include <linux/err.h>
> > > @@ -70,26 +71,49 @@ static const char *rcdev_name(struct
> > > reset_controller_dev *rcdev)
> > >         if (rcdev->of_node)
> > >                 return rcdev->of_node->full_name;  
> > 
> > Could the above be removed, since reset_controller_register() set
> > rcdev->fwnode to of_fwnode_handle(rcdev->of_node) earlier?
> 
> Yes, this should work in all cases, the only difference is that
> fwnode_get_name() returns the basename of the of_node full_name
> field.
> This is potentially a change from what was displayed before. If you are
> ok with that, I'll drop these lines.

Yes, that should be fine. rcdev_name() is currently only used in
warnings that let driver developers know which reset controller they
used incorrectly.

regards
Philipp

