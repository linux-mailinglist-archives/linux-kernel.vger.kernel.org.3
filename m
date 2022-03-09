Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD874D385F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiCISEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiCISEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:04:34 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54B63F0;
        Wed,  9 Mar 2022 10:03:33 -0800 (PST)
Received: from 1nS0ep-00041V-UI by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS0eq-000439-VD; Wed, 09 Mar 2022 10:03:32 -0800
Received: by emcmailer; Wed, 09 Mar 2022 10:03:32 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS0ep-00041V-UI; Wed, 09 Mar 2022 10:03:31 -0800
Received: from tsdebian (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id B4966E3C;
        Wed,  9 Mar 2022 11:03:30 -0700 (MST)
Message-ID: <1646848995.2231.2.camel@embeddedTS.com>
Subject: Re: [PATCH v2] gpio: ts4900: Do not set DAT and OE together
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Date:   Wed, 09 Mar 2022 10:03:15 -0800
In-Reply-To: <CAMRc=McuAB96JSKVeAPQLOgjGZkD5hOtYt=904Aw4t4aYVVKqg@mail.gmail.com>
References: <20220308181847.3276-1-kris@embeddedTS.com>
         <CAMRc=McuAB96JSKVeAPQLOgjGZkD5hOtYt=904Aw4t4aYVVKqg@mail.gmail.com>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=0LUNo57BRIswNUx1tYkZhqzyj6GufMslGG3HBmMGVGA=;b=heTgNilBp3VtXq6bnR91XF6e6cDE1pb+bbo9AavVuxBuDWYu5tX7XbBBUOD3e+OlXKhsWnaDYXRjdXmosXPYOFtKE31r1vJu0hWBIWcEV1bCNKSuuh5+hvwiZ9oJBDVE4Vcg7VDsLxOZqCQxysRXD0/xj/TmEq03pHr2zte1QMFSGJVYvYW8bZ8ftFTqB9uiAejtFL0CcYSb7J7yzF47RVLpSsH+TGIP0Ve5ek2QHbWguYfa+zRZFh080Ko9rNG2ByApd08WRA2q3z8r52teXGC6dDBRJ8eyjNmxDbhrP83sQ2L6RNHWllHrlk8f0wf03xHAsUVrA5CUuKPTlUs6IA==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-09 at 09:32 +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 8, 2022 at 7:19 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > 
> > diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
> > index d885032cf814..fbabfca030c0 100644
> > --- a/drivers/gpio/gpio-ts4900.c
> > +++ b/drivers/gpio/gpio-ts4900.c
> > @@ -1,7 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> This is not part of the fix, please send a separate patch that comes
> after the fix adding the SPDX identifier.
> 
> >  /*
> >   * Digital I/O driver for Technologic Systems I2C FPGA Core
> >   *
> > - * Copyright (C) 2015 Technologic Systems
> > + * Copyright (C) 2015-2018 Technologic Systems
> >   * Copyright (C) 2016 Savoir-Faire Linux
> >   *
> >   * This program is free software; you can redistribute it and/or
> 
> If you're adding the SPDX identifier, you can drop the license boilerplate here.
> 
> Bart
> 

Thanks for the feedback. I'll get a v3 series out soon to address these.

Kris
