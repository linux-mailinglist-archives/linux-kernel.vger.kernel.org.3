Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB14BD0C0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiBTSt0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Feb 2022 13:49:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244554AbiBTStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:49:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43F244A3FF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:49:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-Q5RDfTEoPQK_wlmSaWaQ6g-1; Sun, 20 Feb 2022 18:49:00 +0000
X-MC-Unique: Q5RDfTEoPQK_wlmSaWaQ6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 20 Feb 2022 18:48:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 20 Feb 2022 18:48:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Armin Wolf' <W_Armin@gmx.de>, "pali@kernel.org" <pali@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Topic: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Index: AQHYJdVCkKl8QQjZ0kWJRwIdNPLg26ycx2mg
Date:   Sun, 20 Feb 2022 18:48:58 +0000
Message-ID: <6f4c21b5e1cb4fa38a5e0c1716658329@AcuMS.aculab.com>
References: <20220219211011.16600-1-W_Armin@gmx.de>
In-Reply-To: <20220219211011.16600-1-W_Armin@gmx.de>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Armin Wolf
> Sent: 19 February 2022 21:10
> 
> The new assembly code works on both 32 bit and 64 bit
> cpus and allows for more compiler optimisations by not
> requiring smm_regs to be packed

I'm intrigued about the __packed..

Prior to 5.17-rc1 __packed was only applied to the fields after 'eax'.
This actually has no effect (on any architecture) because there is
no padding to remove - so all the later fields are still assumed to
be 32bit aligned.

5.17-rc1 (565210c781201) moved the __packed to the end of the
structure.
AFAICT this structure is only ever used in one file and for on-stack
items. It will always actually be aligned and is only read by the
code in the file - so why was it ever marked __packed at all!
On x86 it would make no difference anyway.

I can only guess it was to ensure that the asm code didn't go
'wrong' because of the compiler adding 'random' padding.
That isn't what __packed is for at all.
The linux kernel requires that the compiler doesn't add 'random'
padding - even if the C standard might allow it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

