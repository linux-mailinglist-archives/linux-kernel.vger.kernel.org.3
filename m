Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B34C56A2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBZPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiBZPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:33:24 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2638BF;
        Sat, 26 Feb 2022 07:32:47 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4K5VyN4DZVz9sTJ;
        Sat, 26 Feb 2022 16:32:44 +0100 (CET)
Message-ID: <c8c6391ce70ad5940b4951e3329b4f525e12252e.camel@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645889562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1OH+fwFMAkE5HnuGiQoI6sTW5eya7KfWghjENThRfs=;
        b=MUu68CU7dDpmpyscqcIa0HgfC1hvfLrGo3MegEINHcIt17xtaM9qACnMixKUCvjXIfWr+P
        74phmknj19WQ/Co1slOWCX/r0L91B6+aJESY/oLXU182z1F6Ec2BkkLz3lK4/+7XkbhJJA
        8pqFWJQlDoUo0B33eq1ONGMUhKtarZP/FhKeovXmsZdqvl39kMa9/3cMY+bbYpEMS6oJ+b
        Ur5q1VSWrb5pEkFIDalYYmDgtMAeTnZYLQ/jR7F4x/bTEnC8lUR5aPjms9uQpSjtFu9BV8
        eFNYYidp+xz7Fgy1ed9/pCdFIS5cP2m+uk1XFqGf4xYkz+rmspXjQAK83HnOGQ==
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
Date:   Sat, 26 Feb 2022 16:32:37 +0100
In-Reply-To: <8656b67c-e093-0a18-9c5f-02f5b4264bb2@roeck-us.net>
References: <cover.1645108566.git.sylv@sylv.io>
         <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
         <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
         <246de83631dd5e165f95904d7f1628502f030e02.camel@sylv.io>
         <66d4ea0b-0377-c9ae-68eb-7303c32cf87e@roeck-us.net>
         <7a567823d62b6ed00cbdc2ce239dc4a69e48b411.camel@sylv.io>
         <aa82f347-1b1a-8c40-b5cb-9efe292ae0ec@roeck-us.net>
         <337fe0598837b35ee96773339e9cdc8345a7c16e.camel@sylv.io>
         <8656b67c-e093-0a18-9c5f-02f5b4264bb2@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-25 at 08:39 -0800, Guenter Roeck wrote:
> On 2/21/22 04:13, sylv wrote:
> > On Thu, 2022-02-17 at 11:25 -0800, Guenter Roeck wrote:
> > > On 2/17/22 10:38, sylv wrote:
> > > [ ... ]
> > > 
> > > > > 
> > > > > That makes me wonder if the chip needs to be added to this
> > > > > driver
> > > > > in
> > > > > the first
> > > > > place, or if it could be added to pmbus.c instead. Any idea ?
> > > > 
> > > > Oh, we did wrote a standalone driver too, and it works fine.
> > > > Maybe it's better to upsteam it instead. :)
> > > 
> > > No, I meant if it would make sense to just add something like
> > > 
> > >          {"xdpe11280", (kernel_ulong_t)&pmbus_info_one },
> > > 
> > > to drivers/hwmon/pmbus/pmbus.c.
> > > 
> > > You only really need a standalone driver if it does something
> > > special, such as a workaround for some register access (like
> > > the xdpe12284 driver), or if support for manufacturer specific
> > > registers is desired or needed. That would, for example, be
> > > useful
> > > if the xdpe11280 supports per-phase sensors.
> > > 
> > > Thanks,
> > > Guenter
> > 
> > Hi,
> > 
> > I tested if the xdpe11280 can use the generic pmbus driver.
> > Everything
> > works fine except it does only detect READ_TEMPERATURE_1 on page 0.
> > Looking at the pmbus_find_sensor_groups function it looks like only
> > some commands are probed on each page (READ_VOUT, READ_IOUT, and
> > READ_POUT) but not READ_TEMPERATURE_1.
> > The PMBus spec 1.3.1 tells us: "Each page may offer the full range
> > of
> > PMBus commands available for each output or non-PMBus device." How
> > could we adapt the generic driver so that it is possible to probe
> > commands for each page?
> > 
> 
> The problem is the "may". Some chips don't implement multi-page
> support especially for temperature sensors. So we'll have to go
> with adding support to the existing driver.
> 
> Guenter

sgtm. So I'll continue working on this patch set.

> 
> > Furthermore, It would be great to add regulator and DT support. I
> > created a WIP branch on GitHub with a possible way to implement
> > this:
> > https://github.com/9elements/linux/tree/upstreaming_pmbus_regulator_wip
> > 
> > What do you think?
> > 
> > Thanks,
> > Marcello
> > 
> 

