Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944E510AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354661AbiDZUnr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiDZUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:43:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8453139B91
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:40:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-215-Rl5h__tWMV6h7ynZt8pZJg-1; Tue, 26 Apr 2022 21:40:32 +0100
X-MC-Unique: Rl5h__tWMV6h7ynZt8pZJg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 21:40:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 26 Apr 2022 21:40:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: RE: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Thread-Topic: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Thread-Index: AQHYWaQPIReaMXdvC0yn2siMv2N/Ya0Cp+Iw
Date:   Tue, 26 Apr 2022 20:40:31 +0000
Message-ID: <09211d4bba86400bbc27fa3a2d38cd76@AcuMS.aculab.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <YmhEqCCfUvYYPmci@casper.infradead.org>
In-Reply-To: <YmhEqCCfUvYYPmci@casper.infradead.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 26 April 2022 20:15
 ()
> 
> On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> HEY!  You still have the buggy IFF -> IF change.  FIX IT.
> My R-b was very clearly conditional on you fixing it.
> 
> > - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> > + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or

my 2c

Iff doesn't really go with an 'or' clause.
(With a maths degree I know what it means!)

so it probably reads better as 'if'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

