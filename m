Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53A526009
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379310AbiEMKOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiEMKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:14:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB3F880EC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:14:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-3fGZbADZPVKzjU4bvG8Wfg-1; Fri, 13 May 2022 11:14:24 +0100
X-MC-Unique: 3fGZbADZPVKzjU4bvG8Wfg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 11:14:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 11:14:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
Thread-Topic: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
Thread-Index: AQHYZlYbkN98ikiNG0u1ah6OjFcYAq0ck+jA
Date:   Fri, 13 May 2022 10:14:23 +0000
Message-ID: <6f206d410f5b49789e986166ea473a6a@AcuMS.aculab.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
 <87a6bmx5lt.ffs@tglx> <Yn0YdPNG/Q3lf+4G@hirez.programming.kicks-ass.net>
 <87sfpevl1g.ffs@tglx> <87wneqtkb8.ffs@tglx>
In-Reply-To: <87wneqtkb8.ffs@tglx>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner
> Sent: 13 May 2022 00:15
...
> But whatever we chose, it's sad, that we need to have support for
> interfaces which swallow any pointer (user or kernel) because otherwise
> this really boils down to a single OR resp. AND operation plus the
> according mov to retrieve the mask.

Are there any of those left?
Most will have gone with setfs(KERNEL_DS) removal.
Almost all code has to know whether an address is user
or kernel - the value can't be used because of architectures
that use the same address values in user and kernel.

How often do addresses actually need de-tagging?
Probably only code that is looking for page table
entries for virtual addresses?
How often does that happen for user addresses?

If the hardware is ignoring the bits then you don't
need to remove them before memory accesses.
That would include all userspace accesses.
Clearly access_ok() has to work with tagged addresses,
but that doesn't require the tag be masked off.
It can just check the transfer doesn't cross 1u<<63.
It (probably) just requires the fault handler to treat
non-canonical address faults as page faults.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

