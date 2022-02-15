Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9004B7A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiBOWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiBOWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:23:32 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD96FA36;
        Tue, 15 Feb 2022 14:23:21 -0800 (PST)
Date:   Tue, 15 Feb 2022 23:23:17 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] input: ps2-gpio: refactor struct ps2_gpio_data
Message-ID: <Ygwn1ZhLGuWctfkP@pollux>
References: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
 <20220215160208.34826-2-danilokrummrich@dk-develop.de>
 <YgwhJkRGdduf5oYc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgwhJkRGdduf5oYc@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Feb 15, 2022 at 01:54:46PM -0800, Dmitry Torokhov wrote:
> Hi Danilo,
> 
> On Tue, Feb 15, 2022 at 05:02:05PM +0100, Danilo Krummrich wrote:
> 
> > +static inline struct ps2_gpio_data *
> > +to_ps2_gpio_data(struct delayed_work *dwork)
> > +{
> > +	struct ps2_gpio_data_tx *txd = container_of(dwork,
> > +						    struct ps2_gpio_data_tx,
> > +						    work);
> > +
> > +	return container_of(txd, struct ps2_gpio_data, tx);
> > +}
> > +
> >  static void ps2_gpio_tx_work_fn(struct work_struct *work)
> >  {
> >  	struct delayed_work *dwork = to_delayed_work(work);
> > -	struct ps2_gpio_data *drvdata = container_of(dwork,
> > -						    struct ps2_gpio_data,
> > -						    tx_work);
> 
> This can simply be written as:
> 
> 	struct ps2_gpio_data *drvdata = container_of(dwork,
> 						     struct ps2_gpio_data,
> 						     tx.work);
> 
> No need to resubmit unless you disagree - I can change it on my side.
Thanks, please do so.

The tx and rx members of struct ps2_gpio_data can then be anonymous structs.
Do you mind changing that too? Or should I resubmit?
> 
> Thanks.
> 
> -- 
> Dmitry

- Danilo
