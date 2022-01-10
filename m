Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EB48A244
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiAJWDY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 17:03:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29018 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbiAJWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:03:23 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-BDOvgji-O6a6MU242vGWhA-1; Mon, 10 Jan 2022 22:03:21 +0000
X-MC-Unique: BDOvgji-O6a6MU242vGWhA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 22:03:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Mon, 10 Jan 2022 22:03:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: RE: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Topic: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Index: AQHYBkLm7AQ+C6qOvkCW4jNyMLz0qKxce3DQgAAF6wCAAEzL0A==
Date:   Mon, 10 Jan 2022 22:03:20 +0000
Message-ID: <7c2789f990394df5b7907287fc0e1232@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
 <20220110122436.5302128f@gandalf.local.home>
In-Reply-To: <20220110122436.5302128f@gandalf.local.home>
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
> Sent: 10 January 2022 17:25
> 
> On Mon, 10 Jan 2022 17:11:52 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Steven Rostedt
> > > Sent: 10 January 2022 16:56
> > >
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > >
> > > Pingfan reported that the following causes a fault:
> > >
> > >   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
> > >   echo 1 > events/syscalls/sys_enter_at/enable
> > >
> > > The reason is that trace event filter treats the user space pointer
> > > defined by "filename" as a normal pointer to compare against the "cpu"
> > > string. If the string is not loaded into memory yet, it will trigger a
> > > fault in kernel space:
> >
> > If a userspace pointer can end up the kernel structure then presumably
> > a 'dodgy' user program can supply an arbitrary kernel address instead?
> > This may give the user the ability to read arbitrary kernel addresses
> > (including ones that are mapped to PCIe IO addresses).
> > Doesn't sound good at all.
> 
> Only root has access to the information read here. All tracing requires
> root or those explicitly given access to the tracing data, which pretty
> much allows all access to kernel internals (including all memory). So
> nothing to worry about here ;-)

Is this filtering trace using a filename passed to a system call by a user program?
In which case a user program can set up a system call that normally fails
(because the copy_from_user() errors) but if root tries to run a system
call event trace on that process can read arbitrary addresses and
thus crash the system?

While unlikely root might be persuaded to try to run the trace.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

