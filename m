Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA04B6BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiBOMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:09:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiBOMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:09:49 -0500
X-Greylist: delayed 48415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 04:09:38 PST
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C29FF68C9;
        Tue, 15 Feb 2022 04:09:37 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:09:33 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/3] input: ps2-gpio: use ktime for IRQ timekeeping
Message-ID: <YguX/dDxtDMYUviz@pollux>
References: <20220211212258.80345-1-danilokrummrich@dk-develop.de>
 <20220211212258.80345-2-danilokrummrich@dk-develop.de>
 <YgtEwMQMrp3uQinK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtEwMQMrp3uQinK@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Feb 14, 2022 at 10:14:24PM -0800, Dmitry Torokhov wrote:
> Hi Danilo,
> 
> On Fri, Feb 11, 2022 at 10:22:56PM +0100, Danilo Krummrich wrote:
> > @@ -128,20 +155,33 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
> >  	unsigned char byte, cnt;
> >  	int data;
> >  	int rxflags = 0;
> > -	static unsigned long old_jiffies;
> > +	static ktime_t t_last, t_now;
> > +	s64 us_delta;
> >  
> >  	byte = drvdata->rx_byte;
> >  	cnt = drvdata->rx_cnt;
> >  
> > -	if (old_jiffies == 0)
> > -		old_jiffies = jiffies;
> > +	t_now = ktime_get();
> > +	if (t_last == 0)
> 
> Instead of checking this every time, do you think we could seed the
> value in ps2_gpio_open() (and also make it per-port, not static)?
Oops! Sure, I'll send a v2.

I will also add another patch to refactor struct ps2_gpio_data to clearly
separate rx and tx state data, otherwise it might start to become a bit messy.
> 
> Thanks.
> 
> -- 
> Dmitry

- Danilo
