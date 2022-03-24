Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD54E6136
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349300AbiCXJla convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 05:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiCXJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:41:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD765520C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:39:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXJwa-0005UZ-UH; Thu, 24 Mar 2022 10:39:48 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXJwX-002fNY-31; Thu, 24 Mar 2022 10:39:47 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXJwZ-00038f-6M; Thu, 24 Mar 2022 10:39:47 +0100
Message-ID: <3cfc4346d314dbb297841a9caf4e68661013016c.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: add support for fwnode
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 24 Mar 2022 10:39:47 +0100
In-Reply-To: <20220324101929.00f51f01@fixe.home>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
         <20220323095022.453708-3-clement.leger@bootlin.com>
         <ba95a3fec9c726e2cd61665ac5d7f89d16232d60.camel@pengutronix.de>
         <20220323172121.220a26e9@fixe.home> <20220324101929.00f51f01@fixe.home>
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

Hi Clément,

On Do, 2022-03-24 at 10:19 +0100, Clément Léger wrote:
> Le Wed, 23 Mar 2022 17:21:21 +0100,
> Clément Léger <clement.leger@bootlin.com> a écrit :
> 
> > > >         if (id) {
> > > > -               index = of_property_match_string(node,
> > > > -                                                "reset-names",
> > > > id);
> > > > +               index = fwnode_property_match_string(fwnode,
> > > > "reset-names", id);
> > > >                 if (index == -EILSEQ)
> > > >                         return ERR_PTR(index);    
> > > 
> > > I don't think this is good enough any more. At least -ENOMEM is added
> > > as a possible error return code by this change.  
> > 
> > Yes indeed, errors are clearly not correctly handled anymore. At least
> > -EILSEQ won't be triggered.
> > > 
> 
> By the way, even after looking at this more carefully, I'm not sure to
> understand why there is a special handling for -EILSEQ ? From what I
> understand, EILSEQ is returned in case the device tree is malformed
> (string longer than returned property length) but why is it handled
> differently in this case ?

of_property_match_string() can return four error codes:

  -EINVAL (no reset-names property in node)
  -EILSEQ (real error)
  -ENODATA (id is not found in reset-names)
  -ENOSYS (CONFIG_OF is not set)

-EINVAL, -ENODATA and -ENOSYS map to -ENOENT (no reset control
corresponding to id found), or no error if it is optional.

regards
Philipp
