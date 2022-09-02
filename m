Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D605AA89C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiIBHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiIBHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:16:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018552DF0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:16:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oU0uJ-0006c6-5B; Fri, 02 Sep 2022 09:16:03 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oU0uI-0005D1-0d; Fri, 02 Sep 2022 09:16:02 +0200
Date:   Fri, 2 Sep 2022 09:16:01 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
Message-ID: <20220902071601.GU24324@pengutronix.de>
References: <20220831055811.1936613-1-s.hauer@pengutronix.de>
 <20220831055811.1936613-2-s.hauer@pengutronix.de>
 <CAHp75VfbNespbCZ81xcvA7zsr3K8nbb3LBrpXOjH04R-hEFumw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfbNespbCZ81xcvA7zsr3K8nbb3LBrpXOjH04R-hEFumw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Fri, Sep 02, 2022 at 09:42:21AM +0300, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 9:02 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > This driver implements a GPIO multiplexer based on latches connected to
> > other GPIOs. A set of data GPIOs is connected to the data input of
> > multiple latches. The clock input of each latch is driven by another
> > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > are output only.
> 
> So, this is for only one type of latches, now I'm wondering why
> gpio-74xx-mmio can't cover this case (with probably small
> modifications to the code)?

gpio-74xx-mmio is about latches connected to a parallel bus. You can
access the GPIOs by doing readl/writel operations. The latches are
driven by the bus logic and likely an additional address decoder.

What I have here instead is a latch fully driven by GPIOs.

Yes, with enough force you could implement it in the gpio-74xx-mmio
driver, but that wouldn't be mmio at all and likely completely different
code pathes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
