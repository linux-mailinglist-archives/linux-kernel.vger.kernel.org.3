Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389C148E017
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiAMWLo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jan 2022 17:11:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:56574 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233023AbiAMWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:11:43 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-140-S1wWihjPMYGfmUu8_x_IuQ-1; Thu, 13 Jan 2022 22:11:36 +0000
X-MC-Unique: S1wWihjPMYGfmUu8_x_IuQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Thu, 13 Jan 2022 22:11:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Thu, 13 Jan 2022 22:11:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sven Schnelle' <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "deller@gmx.de" <deller@gmx.de>
Subject: RE: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Topic: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Index: AQHYCMRx7AQ+C6qOvkCW4jNyMLz0qKxhghEQ
Date:   Thu, 13 Jan 2022 22:11:35 +0000
Message-ID: <e66911061f9344fa8de2da982ab98a7b@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>        <20220113125754.0cb5273f@gandalf.local.home>
 <yt9dwnj3wcke.fsf@linux.ibm.com>
In-Reply-To: <yt9dwnj3wcke.fsf@linux.ibm.com>
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

From: Sven Schnelle
> Sent: 13 January 2022 21:28
> 
> Hi Steve,
> 
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Tue, 11 Jan 2022 21:55:53 +0100
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> >
> >> > Isn't there also at least one architecture where you can't differentiate
> >> > between user and kernel pointers by looking at the address?
> >> > (Something like sparc ASI is used for user accesses so both user
> >> > and kernel get the full 4G address range. But it isn't sparc (or pdp/11))
> >> > ISTR it causing issues with the code for kernel_setsockopt() and
> >> > required a separate flag.
> >>
> >> On s390 TASK_SIZE is defined as -PAGE_SIZE, so with the patch above the
> >> kernel would always try to fetch it from user space. I think it would be
> >> the same for parisc.
> >
> > As a work around for these cases, would something like this work?
> 
> Hmm, i don't see how. On s390, TASK_SIZE is -PAGE_SIZE, which means
> 0xfffffffffffff000 so i think the if() condition below is always true.

Isn't TASK_SIZE also dependant on current->xxxx on at least one architecture?
Possibly even x86-64.

> Too bad that the __user attribute is stripped during a normal compile.
> But couldn't we add the information whether a pointer belongs to user
> or kernel space in the trace event definition? For syscall tracing it's
> easy, because pointer types in SYSCALL_DEFINE() and friends are always
> userspace pointers?

Also, when the __user pointer is saved it MUST be checked for being
a valid user pointer (eg with access_ok(ptr, 1).

You really do need to remember whether the pointer is user or kernel
when you save it.

I also suspect that you need to check for contexts where 'current'
isn't really valid (eg any kind on interrupt) and ensure the user
reads aren't even attempted.
The excuse of being 'root' in order to request/read trace isn't
really a very good one.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

