Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B764BB4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiBRJBK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 04:01:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBRJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:01:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A531867C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:00:51 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-117-Paf7cxtnMtCmxTJ17km-zA-1; Fri, 18 Feb 2022 09:00:48 +0000
X-MC-Unique: Paf7cxtnMtCmxTJ17km-zA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 09:00:46 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 18 Feb 2022 09:00:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
CC:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Shawn Guo" <shawn.guo@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>, Tejun Heo <tj@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH printk v1 09/13] printk: add functions to allow direct
 printing
Thread-Topic: [PATCH printk v1 09/13] printk: add functions to allow direct
 printing
Thread-Index: AQHYI/0/7XPqOu2p+UeF1AvHpJcIY6yZAzcg
Date:   Fri, 18 Feb 2022 09:00:46 +0000
Message-ID: <ca5b7ec96aa444c292b3413a6374028b@AcuMS.aculab.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-10-john.ogness@linutronix.de> <Yg5FCVF5c1jDo116@alley>
In-Reply-To: <Yg5FCVF5c1jDo116@alley>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon 2022-02-07 20:49:19, John Ogness wrote:
> > Once kthread printing is introduced, console printing will no longer
> > occur in the context of the printk caller. However, there are some
> > special contexts where it is desirable for the printk caller to
> > directly print out kernel messages.

Yes - most of them.

It is going to be pretty impossible to do 'hard' kernel debugging
if printk get deferred.

Typically there already is a deferral method.
The prints aren't done by the kernel, but by syslogd.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

