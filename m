Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD0552F04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiFUJn5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jun 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349619AbiFUJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:43:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C7FC1A07A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:43:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-168-bVQTvNNEM_uczimQWYB4OA-1; Tue, 21 Jun 2022 10:43:32 +0100
X-MC-Unique: bVQTvNNEM_uczimQWYB4OA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 21 Jun 2022 10:43:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 21 Jun 2022 10:43:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH v3] printk: allow direct console printing to be enabled
 always
Thread-Topic: [PATCH v3] printk: allow direct console printing to be enabled
 always
Thread-Index: AQHYhMbxDgh8TJZ3TESIjSW/xv0YW61Zm+IA
Date:   Tue, 21 Jun 2022 09:43:31 +0000
Message-ID: <182076f58e5943af88f38e5202942d41@AcuMS.aculab.com>
References: <Yq+xGcBO06ILMUFy@zx2c4.com>
 <20220619233302.601092-1-Jason@zx2c4.com> <YrCnJTIB/7MexV3K@alley>
In-Reply-To: <YrCnJTIB/7MexV3K@alley>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek
> Sent: 20 June 2022 17:58
> 
> On Mon 2022-06-20 01:33:02, Jason A. Donenfeld wrote:
> > In 5.19, there are some changes in printk message ordering /
> > interleaving which leads to confusion. The most obvious (and benign)
> > example appears on system boot, in which the "Run /init as init process"
> > message gets intermixed with the messages that init actually writes() to
> > stdout. For example, here's a snippet from build.wireguard.com:
> >
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -35,6 +35,18 @@ config PRINTK_CALLER
> >  	  no option to enable/disable at the kernel command line parameter or
> >  	  sysfs interface.
> >
> > +config PRINTK_DIRECT
> > +	bool "Attempt to flush printk output immediately"
> > +	depends on PRINTK
> > +	help
> > +	  Rather than using kthreads for printk output, always attempt to write
> > +	  to the console immediately. This has performance implications, but
> > +	  will result in a more faithful ordering and interleaving with other
> > +	  processes writing to the console.
> > +
> > +	  Say N here unless you really need this. This may also be controlled
> > +	  at boot time with printk.direct=0/1.
> > +
> 
> I am fine with the patch except for the config option. Is there
> any particular reason why we need it, please?
> 
> We should be careful to add new build options in general because they
> make building the kernel more complicated. People need to understand
> what each option is about and what they want.

Especially since most people use pre-built kernels.
I suspect that kernels only get build for very big and
very small/embedded systems.
For the latter you may want to completely remove using kthreads
for printk in order to shrink the kernel size.
But that doesn't look like what this option is for.

	David

> Kernel parameters are less intrusive. People need to care about
> it only when they need some special behavior. And everyone has
> its own default command line anyway. For example, I always use
> ignore_loglevel.
> 
> Best Regards,
> Petr

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

