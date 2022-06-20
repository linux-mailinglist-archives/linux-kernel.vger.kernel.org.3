Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB2550F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiFTEEx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 00:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiFTEEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:04:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB25CE20
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:04:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-165-e5yh6TCONnuS7f8iHaYztw-1; Mon, 20 Jun 2022 05:04:44 +0100
X-MC-Unique: e5yh6TCONnuS7f8iHaYztw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 20 Jun 2022 05:04:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 20 Jun 2022 05:04:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Ogness' <john.ogness@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH v2] printk: allow direct console printing to be enabled
 always
Thread-Topic: [PATCH v2] printk: allow direct console printing to be enabled
 always
Thread-Index: AQHYhDK2LzSE1w01lESn0JdhEbFj6K1Xqs5Q
Date:   Mon, 20 Jun 2022 04:04:41 +0000
Message-ID: <f40bdc5335ab4c3fa46562a0a096487d@AcuMS.aculab.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de>
In-Reply-To: <87letsw8en.fsf@jogness.linutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness
> Sent: 20 June 2022 00:17
> 
> On 2022-06-19, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c7900e8975f1..47466aa2b0e8 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> 
> Sorry, I missed this in your v1. But I think this config belongs in
> lib/Kconfig.debug under the "printk and dmesg options" menu.
> 
> > @@ -798,6 +798,18 @@ config PRINTK_INDEX
> >
> >  	  There is no additional runtime cost to printk with this enabled.
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
> >  #
> >  # Architectures with an unreliable sched_clock() should select this:
> >  #
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ea3dd55709e7..43f8a0074ed6 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -178,6 +178,14 @@ static int __init control_devkmsg(char *str)
> >  }
> >  __setup("printk.devkmsg=", control_devkmsg);
> >
> > +static bool printk_direct = IS_ENABLED(CONFIG_PRINTK_DIRECT);
> 
> I understand why you would name the variable to match the boot arg. But
> I would prefer the _internal_ variable had a name that makes it clear
> (to us developers) that it is a permanent setting. Perhaps
> printk_direct_only or printk_direct_always?
> 
> The reason is because when kthreads are active, direct printing is
> turned on and off dynamically (using @printk_prefer_direct). And if this
> new variable is named @printk_direct, one could easily mistake its
> meaning to be related to the dynamic turning on and off.

Do you need both variables?
I presume the whole lot can be compiled out (for small kernels).
Apart from that having a sysctl to control which message levels
get 'direct printing' (much like the one that controls whether
they get printed at all) would surely be enough.

That just leaves the question of the initial level at boot.

	David

> 
> > +
> > +static int __init control_printk_direct(char *str)
> > +{
> > +	return kstrtobool(str, &printk_direct);
> > +}
> > +__setup("printk.direct=", control_printk_direct);
> > +
> >  char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
> >  #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
> >  int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> > @@ -3602,6 +3610,9 @@ static int __init printk_activate_kthreads(void)
> >  {
> >  	struct console *con;
> >
> > +	if (printk_direct)
> 
> I'm wondering if we should output a message here. My suggestion is:
> 
> pr_info("printing threads disabled, using direct printing\n");
> 
> > +		return 0;
> > +
> >  	console_lock();
> >  	printk_kthreads_available = true;
> >  	for_each_console(con)
> 
> Otherwise it looks OK to me. But you may want to wait on a response from
> Petr, Sergey, or Steven before sending a v3. You are adding a kernel
> config and a boot argument. Both of these are sensitive topics that
> require more feedback from others.
> 
> John Ogness

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

