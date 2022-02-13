Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA04B393F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 04:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiBMDd5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Feb 2022 22:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiBMDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 22:33:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDF35F26F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 19:33:50 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-m5e4icDAO8m0cbi-5HV2aQ-1; Sun, 13 Feb 2022 03:33:46 +0000
X-MC-Unique: m5e4icDAO8m0cbi-5HV2aQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 13 Feb 2022 03:33:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 13 Feb 2022 03:33:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Victor Erminpour <victor.erminpour@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: RE: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
Thread-Topic: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
Thread-Index: AQHYH6jGUiwsSGsVWkybqVzsUhE0OqyQ00mw
Date:   Sun, 13 Feb 2022 03:33:44 +0000
Message-ID: <f11f91706c704a72b593a183f33ff456@AcuMS.aculab.com>
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
 <202202101415.43750CEE@keescook>
 <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
 <202202111623.A7881CC@keescook>
In-Reply-To: <202202111623.A7881CC@keescook>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook
> Sent: 12 February 2022 00:38
....
> 
> Sure. I think I am trying to take a pragmatic approach here, which is
> that gaining auto-var-init is a big deal (killing entire classes of
> vulnerabilities), but it comes with an annoying compiler bug (that we do
> get a warning about) for an uncommon code pattern that is easy to fix.

My worry about the compiler setting variables to zero is that people
will get lazy and assume it happens.
Then some code will get compiled without that enabled (possibly because
it slows things down too much) and then really horrid bugs start to appear.

If the intent is to detect code that is failing to initialise locals
then setting to a non-zero value (that is likely to cause grief)
is much better than setting to zero.

I'm particularly worried if the compiler starts to zero on-stack arrays.
There is plenty of userspace code that will use char buff[MAX_PATH]
to build a filename or char errmsg[1024] for an error message.
At the moment the size only needs to be 'big enough' but if the compiler
zeros it then there are performance issues and oversize buffers make
a difference.
At which point you start making the arrays 'just big enough' and then
fall foul of truncations and overruns because the calculation was wrong.

Definitely double edged.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

