Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9355A02B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiFXRm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiFXRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:42:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B5B31;
        Fri, 24 Jun 2022 10:42:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35AEDE0002;
        Fri, 24 Jun 2022 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656092573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGeFKXAsbuWfeBBV1ExpbQrfT21CY1AOWn97gB9KEs4=;
        b=gA3r0hTMAGyJmijmIsxWjZf4IBThS48a+PqiSwOwy5GhmFClzoN+zZ9EgBiYKprVWVE4PJ
        Nl+LVxtlwxQbsGgOQA6a3v6xemfqsvsMJk8/JvyLnKRCfFyzPalqyEf7+/kdPjLZqedXYx
        N7jrMXwt/FoDCsN54PXGvV/eUi5mJCcRHS8YUreVAC7k/xFjFJssC5bQNQdpSkl8J6gim+
        WNnZVSkDyyajIrblsstO0Jb7Re7ZIShYfeNc6rHAE6Pzfq/Ol54BbvxLEyJbktjcVliVVa
        tOqfkizATOR1A+vtMpOOUDzIB6iKFuw9QF4gAZuLouBim8Vh83DkLovY8B0XTg==
Date:   Fri, 24 Jun 2022 19:42:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Dianlong Li <long17.cool@163.com>,
        Wolfram Sang <wsa@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: use simple i2c probe
Message-ID: <YrX3mWxDex7OuEpn@mail.local>
References: <20220610162346.4134094-1-steve@sk2.org>
 <YqSnwf7paZa1+uuh@mail.local>
 <2bd6ab78f649ba282c5369d0e969fea2@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bd6ab78f649ba282c5369d0e969fea2@sk2.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2022 21:23:47+0200, Stephen Kitt wrote:
> Hi Alexandre,
> 
> Le 11/06/2022 16:48, Alexandre Belloni a écrit :
> > On 10/06/2022 18:23:43+0200, Stephen Kitt wrote:
> > > All these drivers have an i2c probe function which doesn't use the
> > > "struct i2c_device_id *id" parameter, so they can trivially be
> > > converted to the "probe_new" style of probe with a single argument.
> > > 
> > 
> > I think you should explain why you want to do that as the trend is to do
> > the exact opposite to allow support for those RTCS on x86 systems.
> 
> Indeed, I should have given more context. The idea is to continue the
> transition started with https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8a1a4cd5a98a2adf8dfd6902cd98e57d910ee12
> (in 2016...). I²C drivers using probe() involve a call to i2c_match_id: in
> drivers/i2c/i2c-core-base.c,
> 
>         /*
>          * When there are no more users of probe(),
>          * rename probe_new to probe.
>          */
>         if (driver->probe_new)
>                 status = driver->probe_new(client);
>         else if (driver->probe)
>                 status = driver->probe(client,
>                                        i2c_match_id(driver->id_table,
> client));
>         else
>                 status = -EINVAL;
> 
> Many drivers don't actually need the second parameter, so instead of having
> probe() with both parameters, the goal is to switch to a probe function with
> only "struct i2c_client *". Probe functions that *do* need the "struct
> i2c_device_id" can call i2c_match_id themselves (as is done currently with
> of_match_id).
> 
> I discussed this briefly with Wolfram beginning of June at Kernel Recipes,
> and as I understood it the plan was still to continue with this transition
> (in fact, the plan was for *me* to continue with this transition).
> 
> Do you have an example of a change requiring id to support RTCs on x86
> systems?

I checked and your patch is actually fine, the issue I referred to is:

1c1b3098ae1e ("rtc: pcf85063: add i2c_device_id name matching support")


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
