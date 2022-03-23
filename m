Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D34E4ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiCWCRj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCWCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:17:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1ED670051
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:16:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-188-9RN3NbaTNnehPJOCmKjD3g-1; Wed, 23 Mar 2022 02:15:58 +0000
X-MC-Unique: 9RN3NbaTNnehPJOCmKjD3g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 23 Mar 2022 02:15:55 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 23 Mar 2022 02:15:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: RE: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Topic: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Index: AQHYPiElHr6Egf4vbEGW28icqj7YNKzMOPHg
Date:   Wed, 23 Mar 2022 02:15:55 +0000
Message-ID: <6716f3ffefae4ed8b5fd332bfcca8a9a@AcuMS.aculab.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
In-Reply-To: <20220322191436.110963-1-Jason@zx2c4.com>
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

From: Jason A. Donenfeld
> Sent: 22 March 2022 19:15
> 
> For as far back as I can tell, writing to /dev/urandom or /dev/random
> will put entropy into the pool, but won't immediately use it, and won't
> credit it either. Instead, crediting is controlled by the ioctls
> RNDADDTOENTCNT and RNDADDENTROPY. If, however, this happens during early
> boot before the input pool is ready, we have a dangerous situation with
> seed files as commonly used by shell scripts:
> 
>   dd if=seedfile of=/dev/urandom # write seed into pool
>   dd if=/dev/urandom of=seedfile count=1 bs=32 # read new seed for next boot
> 
> Since the entropy in seedfile isn't credited there, this won't cause the
> RNG to transition from crng_init=0 to crng_init=2, and so when we make a
> new seedfile for next boot, we'll still be getting crng_init=0-quality
> randomness, which may well regress from the original seedfile.

Never mind scripts that try to immediately save a new seedfile [1].

What about code run by later startup scripts that wants random numbers.
They really do want the seedfile data to be used.
If it isn't used then they are likely to get very weak random numbers.

You can't really expect startup scripts to be issuing ioctl requests.

[1] I suspect the initial 'save' is just there to ensure that the
random numbers don't exactly repeat if the system crashes.
The seedfile will be written again during normal shutdown.


	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

