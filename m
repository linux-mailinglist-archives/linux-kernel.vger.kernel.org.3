Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F3549C74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiFMS7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jun 2022 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346492AbiFMS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFFBF8CCD6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:11:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-188-UKF4EeJcNpOg5PEFD63RQQ-1; Mon, 13 Jun 2022 17:11:24 +0100
X-MC-Unique: UKF4EeJcNpOg5PEFD63RQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 13 Jun 2022 17:11:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 13 Jun 2022 17:11:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     John Ogness <john.ogness@linutronix.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: RE: [BUG] Threaded printk breaks early debugging
Thread-Topic: [BUG] Threaded printk breaks early debugging
Thread-Index: AQHYfw5tEBAMEt7XXEKQmWQ8WlSw2q1Nf9Zw
Date:   Mon, 13 Jun 2022 16:11:19 +0000
Message-ID: <c81870cef50f4e1fac5083f0b780983d@AcuMS.aculab.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de> <Yqazr060OLp2Rpbk@google.com>
 <87wndlge43.fsf@jogness.linutronix.de> <Yqb9xOBiY/262lhk@google.com>
 <YqcN9mH/aVwBoIMQ@alley>
In-Reply-To: <YqcN9mH/aVwBoIMQ@alley>
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
> Sent: 13 June 2022 11:14
...
> Another interesting alternative is the Peter Zijlstra's mode
> where all messages are printed to the console "immediately".
> They are serialized only by the CPU-reentrant lock.
> 
> This mode is not good for production system. But it might
> be good for debugging. The good thing is that the behavior
> is well defined.

ISTM that all messages should be output (even if this means
that cpu spin waiting for a serial console) until userspace
has a chance to set an option to change the behaviour.

Oh, and can someone stop the distros hiding the console output.
I want to see the 'oops' traceback when I break the kernel!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

