Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC8489E17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiAJRL4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 12:11:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:20019 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238000AbiAJRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:11:55 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-LoDN_n7ePqC-BXUk2ZRpdw-1; Mon, 10 Jan 2022 17:11:53 +0000
X-MC-Unique: LoDN_n7ePqC-BXUk2ZRpdw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 17:11:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Mon, 10 Jan 2022 17:11:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: RE: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Topic: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Index: AQHYBkLm7AQ+C6qOvkCW4jNyMLz0qKxce3DQ
Date:   Mon, 10 Jan 2022 17:11:52 +0000
Message-ID: <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
In-Reply-To: <20220110115532.536088fd@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 10 January 2022 16:56
> 
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Pingfan reported that the following causes a fault:
> 
>   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
>   echo 1 > events/syscalls/sys_enter_at/enable
> 
> The reason is that trace event filter treats the user space pointer
> defined by "filename" as a normal pointer to compare against the "cpu"
> string. If the string is not loaded into memory yet, it will trigger a
> fault in kernel space:

If a userspace pointer can end up the kernel structure then presumably
a 'dodgy' user program can supply an arbitrary kernel address instead?
This may give the user the ability to read arbitrary kernel addresses
(including ones that are mapped to PCIe IO addresses).
Doesn't sound good at all.

...
> +	if (likely((unsigned long)str >= TASK_SIZE)) {
> +		/* For safety, do not trust the string pointer */
> +		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
> +			return NULL;
> +	} else {
> +		/* user space address? */
> +		ustr = (char __user *)str;
> +		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
> +			return NULL;

Is that check against TASK_SIZE even correct for all architectures?
copy_to/from_user() uses access_ok() - which is architecture dependant.

I think you need to remember where the pointer came from.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

