Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC446794E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381423AbhLCOXZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Dec 2021 09:23:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32382 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244958AbhLCOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:23:24 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-276-WJXXi7eCOiyQNI0Os2d2EA-1; Fri, 03 Dec 2021 14:19:57 +0000
X-MC-Unique: WJXXi7eCOiyQNI0Os2d2EA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 3 Dec 2021 14:19:56 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 3 Dec 2021 14:19:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Gladkov' <legion@altlinux.ru>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: RE: [PATCH v1 2/2] ucounts: Move rlimit max values from ucounts max
Thread-Topic: [PATCH v1 2/2] ucounts: Move rlimit max values from ucounts max
Thread-Index: AQHX6E1dTG1FDFW9tE25mvS0vl4F7qwg0Mxg
Date:   Fri, 3 Dec 2021 14:19:56 +0000
Message-ID: <62f96ccd41f14b3ab504184951513a90@AcuMS.aculab.com>
References: <bcc85eae4f5e3799f9efdf2d73572bb88616ebac.1637934917.git.legion@kernel.org>
 <202111280022.ugxpiKpA-lkp@intel.com>
 <20211203135453.ld2jblkd3xtlbgrv@example.org>
In-Reply-To: <20211203135453.ld2jblkd3xtlbgrv@example.org>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov
> Sent: 03 December 2021 13:55
...
> > 25f9c0817c535a Eric W. Biederman 2016-08-08  108  		for (i = 0; i < UCOUNT_COUNTS; i++) {
> > 25f9c0817c535a Eric W. Biederman 2016-08-08 @109  			tbl[i].data = &ns->ucount_max[i];
> >
> > The patch changes the size of ->ucount_max[] to MAX_PER_NAMESPACE_UCOUNTS
> > but this loop still goes up to UCOUNT_COUNTS.
> >
> >
> 
> Thanks! But a few days ago I already post a new version of this changeset
> with fix:
> 
> https://lore.kernel.org/containers/24c87e225c7950bf2ea1ff4b4a8f237348808241.1638218242.git.legion@kernel.org/

Use ARRAY_SIZE() so that it 'just doesn't go wrong'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

