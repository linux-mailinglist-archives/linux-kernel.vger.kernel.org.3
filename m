Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867CF4B09A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiBJJgo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 04:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiBJJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:36:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B5AEC64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:36:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-7VZKaTpWPSS90nYkjpkWNg-1; Thu, 10 Feb 2022 09:36:42 +0000
X-MC-Unique: 7VZKaTpWPSS90nYkjpkWNg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 09:36:41 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 09:36:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>, Michal Simek <monstr@monstr.eu>
CC:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] microblaze: remove CONFIG_SET_FS
Thread-Topic: [PATCH] microblaze: remove CONFIG_SET_FS
Thread-Index: AQHYHcQ6EgAhsRrDe0u1y8RgHhFzdayMhlsA
Date:   Thu, 10 Feb 2022 09:36:41 +0000
Message-ID: <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
References: <20220209144910.1484686-1-arnd@kernel.org>
In-Reply-To: <20220209144910.1484686-1-arnd@kernel.org>
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

From: Arnd
> Sent: 09 February 2022 14:49
> 
> Remove the address space override API set_fs().  The microblaze user
> address space is now limited to TASK_SIZE.
> 
> To support this we implement and wire in __get_kernel_nofault and
> __set_kernel_nofault.
> 
> The function user_addr_max is removed as there is a default definition
> provided when CONFIG_SET_FS is not used.
...
>  static inline int access_ok(const void __user *addr, unsigned long size)
>  {
>  	if (!size)
>  		goto ok;
> 
> -	if ((get_fs().seg < ((unsigned long)addr)) ||
> -			(get_fs().seg < ((unsigned long)addr + size - 1))) {
> -		pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
> -			(__force u32)addr, (u32)size,
> -			(u32)get_fs().seg);
> +	if ((((unsigned long)addr) > TASK_SIZE) ||
> +	    (((unsigned long)addr + size - 1) > TASK_SIZE)) {
> +		pr_devel("ACCESS fail at 0x%08x (size 0x%x)",
> +			(__force u32)addr, (u32)size);
>  		return 0;

Isn't that the wrong check?
If 'size' is big 'addr + size' can wrap.

It needs to be (addr >= TASK_SIZE || size > TASK_SIZE - addr)

Which is pretty much a generic version.
Although typical 64bit architectures can use the faster:
	((addr | size) >> 62)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

