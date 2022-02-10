Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672184B0956
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiBJJVR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 04:21:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiBJJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:21:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B640E10B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:21:12 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-45-lEkQ6zw7PZWqGm8NVfJVHw-1; Thu, 10 Feb 2022 09:21:09 +0000
X-MC-Unique: lEkQ6zw7PZWqGm8NVfJVHw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 09:21:08 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 09:21:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Thread-Topic: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Thread-Index: AQHYDr0JeXBHu5JbA0ymi5sg9Q/cbqxteQpggB8TuXeAABPU4A==
Date:   Thu, 10 Feb 2022 09:21:08 +0000
Message-ID: <eefeb019b58e4b1a814462c709d224b6@AcuMS.aculab.com>
References: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
 <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
 <9c563d78-f883-65ee-9e7b-cf44e3b238e8@wanadoo.fr>
 <20220210080603.GJ1951@kadam>
In-Reply-To: <20220210080603.GJ1951@kadam>
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

From: Dan Carpenter
> Sent: 10 February 2022 08:06
> 
> On Wed, Feb 09, 2022 at 08:15:13PM +0100, Christophe JAILLET wrote:
> > Le 21/01/2022 à 14:34, David Laight a écrit :
> > > From: Jiapeng Chong
> > > > Sent: 21 January 2022 11:50
> > > > Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
> > > >
> > > > Clean the following coccicheck warning:
> > > >
> > > > ./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
> > > > 64-by-32 division, please consider using div64_u64 instead.
> > >
> > > That is one of patchcheck's worse warnings.
> > >
> > > You need to check the domain of the divisor, not its type.
> > >
> > > do_div() exists to avoid expensive 64bit divides when the
> > > divisor is small.
> > >
> > > 	David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> > >
> > >
> >
> > Moreover, the patch is broken by itself.
> >
> > See [1] were it was already reported that do_div() and div64_u64() don't
> > have the same calling convention.
> >
> > Looks that div64_u64() and div64_ul() works the same way.
> 
> We could mark those as __must_check functions.

That, and some kind of AI system to filter out untested patches
from (presumably) students who think that the output from these
tools 'must be right'.

Same for all the patches for using swap(), min() LIST_HEAD() etc.
They are at best churn and make the code harder to read.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

