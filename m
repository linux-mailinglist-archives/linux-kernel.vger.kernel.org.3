Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF66454F9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382950AbiFQPBm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382627AbiFQPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:01:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A64A3E0E4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:01:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-yIBenb7EPhWdGuPCD_Wigg-1; Fri, 17 Jun 2022 16:01:36 +0100
X-MC-Unique: yIBenb7EPhWdGuPCD_Wigg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 17 Jun 2022 16:01:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 17 Jun 2022 16:01:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: 5.19 printk breaks message ordering
Thread-Topic: 5.19 printk breaks message ordering
Thread-Index: AQHYglWHYY5jQBSQoEy5fw0dudLMr61Tr9rQ
Date:   Fri, 17 Jun 2022 15:01:33 +0000
Message-ID: <a35dc47eb9924d56bb6dca7868c34c94@AcuMS.aculab.com>
References: <YqyANveL50uxupfQ@zx2c4.com> <YqyN20jpRw1SaaTw@alley>
In-Reply-To: <YqyN20jpRw1SaaTw@alley>
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
> Sent: 17 June 2022 15:21
...
> > I assume this is mostly caused by your threaded printk patchset
> 
> Console has never been fully synchronous. printk() did console_trylock()
> and flushed the message to the console only the lock was available.
> The console kthreads made it asynchronous always when the kthreads
> are available and system is in normal state.

What priority do these kthreads run at?

I'd have thought they ought to run at a high priority?
That should tend to give kernel messages priority over user ones.

Quite how high is another matter.
Probably a bit below the RT/FIFO:50 of threaded ISR.

Although if an x86 one ends up doing software scrolling of
the vga text buffer using the ISA speed accesses that usually
requires maybe not!
Maybe that is faster on modern systems - but I doubt it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

