Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C84E387F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiCVFda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 01:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiCVFd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:33:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB5F12770
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:32:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-107-DY-7PGaiPlWGRoKUJuKviQ-1; Tue, 22 Mar 2022 05:31:58 +0000
X-MC-Unique: DY-7PGaiPlWGRoKUJuKviQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 05:31:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 05:31:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: RE: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Topic: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Index: AQHYPXZY+Z6jqI0tL02PF2iQrRNCEqzK30EQ
Date:   Tue, 22 Mar 2022 05:31:58 +0000
Message-ID: <82fba71fdb9f4e34960aa3743f4bba81@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
In-Reply-To: <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
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

From: Andy Lutomirski
> Sent: 21 March 2022 22:30
> On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
> > Hi,
> >
> > This patchset makes use of Upper Address Ignore (UAI) feature available
> > on upcoming AMD processors to provide user address tagging support for x86/AMD.
> >
> > UAI allows software to store a tag in the upper 7 bits of a logical
> > address [63:57]. When enabled, the processor will suppress the
> > traditional canonical address checks on the addresses. More information
> > about UAI can be found in section 5.10 of 'AMD64 Architecture
> > Programmer's Manual, Vol 2: System Programming' which is available from
> >
> > https://bugzilla.kernel.org/attachment.cgi?id=300549
> 
> I hate to be a pain, but I'm really not convinced that this feature is suitable for Linux.  There are
> a few reasons:
> 
> Right now, the concept that the high bit of an address determines whether it's a user or a kernel
> address is fairly fundamental to the x86_64 (and x86_32!) code.  It may not be strictly necessary to
> preserve this, but violating it would require substantial thought.  With UAI enabled, kernel and user
> addresses are, functionally, interleaved.  This makes things like access_ok checks, and more generally
> anything that operates on a range of addresses, behave potentially quite differently.  A lot of
> auditing of existing code would be needed to make it safe.
> 
> UAI looks like it wasn't intended to be context switched and, indeed, your series doesn't context
> switch it.  As far as I'm concerned, this is an error, and if we support UAI at all, we should context
> switch it.  Yes, this will be slow, perhaps painfully slow.  AMD knows how to fix it by, for example,
> reading the Intel SDM.  By *not* context switching UAI, we force it on for all user code, including
> unsuspecting user code, as well as for kernel code.  Do we actually want it on for kernel code?  With
> LAM, in contrast, the semantics for kernel pointers vs user pointers actually make sense and can be
> set per mm, which will make things like io_uring (in theory) do the right thing.

You also need the kernel to be able to use the 'tagged'
addresses to access userspace - ie without having to
mask off any tag.

This is really for the same reason they want hardware
support for tagged addresses to avoid having to 'untag'
before calling library routines.

I'm not even sure which address the page fault handler
should see - it will need to the difference between a
normal process using a non-canonical address and a PF
on a tagged address.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

