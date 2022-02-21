Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A74BE90A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357802AbiBUMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:17:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358318AbiBUMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:16:59 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5423BCB;
        Mon, 21 Feb 2022 04:13:24 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4K2Lmf47v0z9sSD;
        Mon, 21 Feb 2022 13:13:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645445600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2k7bqJ/vTjUg+OF74X8lGOPbwp8eKng0+FRC6D3l23o=;
        b=OUBe/JEnj0zfiXLJhNPM9LLj6Kl1oo8J9oSRQEZ0C9GgiyFPxeLa2UwLUZemMQrpEAW0uP
        pyo2mv8l9NLHXbVUAs5wjf+yPtyUKISv/CoLuFAH//7cS1neKadQo5Krewy0KFjUYOsGeV
        8v/joAI3CZa/F7Q56vCC7SOMShWVlMDGotOJvJN+MP0ouYNRCATT/jWGJrXC27pjmSLdHo
        xZuezoLHOH3toRhwlhZStxFvIZ2J6q48/+Oc4/H687m78y/6WHfs3UUm7w+Jw8sUbiVy59
        udy7MRLc73gg8qABo3buHf5lIi1cTUFSfoOINg9nkPVatO8gl47OXqEGl5cPNA==
Message-ID: <337fe0598837b35ee96773339e9cdc8345a7c16e.camel@sylv.io>
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
Date:   Mon, 21 Feb 2022 13:13:15 +0100
In-Reply-To: <aa82f347-1b1a-8c40-b5cb-9efe292ae0ec@roeck-us.net>
References: <cover.1645108566.git.sylv@sylv.io>
         <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
         <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
         <246de83631dd5e165f95904d7f1628502f030e02.camel@sylv.io>
         <66d4ea0b-0377-c9ae-68eb-7303c32cf87e@roeck-us.net>
         <7a567823d62b6ed00cbdc2ce239dc4a69e48b411.camel@sylv.io>
         <aa82f347-1b1a-8c40-b5cb-9efe292ae0ec@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 11:25 -0800, Guenter Roeck wrote:
> On 2/17/22 10:38, sylv wrote:
> [ ... ]
> 
> > > 
> > > That makes me wonder if the chip needs to be added to this driver
> > > in
> > > the first
> > > place, or if it could be added to pmbus.c instead. Any idea ?
> > 
> > Oh, we did wrote a standalone driver too, and it works fine.
> > Maybe it's better to upsteam it instead. :)
> 
> No, I meant if it would make sense to just add something like
> 
>         {"xdpe11280", (kernel_ulong_t)&pmbus_info_one },
> 
> to drivers/hwmon/pmbus/pmbus.c.
> 
> You only really need a standalone driver if it does something
> special, such as a workaround for some register access (like
> the xdpe12284 driver), or if support for manufacturer specific
> registers is desired or needed. That would, for example, be useful
> if the xdpe11280 supports per-phase sensors.
> 
> Thanks,
> Guenter

Hi,

I tested if the xdpe11280 can use the generic pmbus driver. Everything
works fine except it does only detect READ_TEMPERATURE_1 on page 0.
Looking at the pmbus_find_sensor_groups function it looks like only
some commands are probed on each page (READ_VOUT, READ_IOUT, and
READ_POUT) but not READ_TEMPERATURE_1.
The PMBus spec 1.3.1 tells us: "Each page may offer the full range of
PMBus commands available for each output or non-PMBus device." How
could we adapt the generic driver so that it is possible to probe
commands for each page?

Furthermore, It would be great to add regulator and DT support. I
created a WIP branch on GitHub with a possible way to implement this:
https://github.com/9elements/linux/tree/upstreaming_pmbus_regulator_wip

What do you think?

Thanks,
Marcello 

