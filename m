Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15D58A8C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbiHEJ0M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Aug 2022 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiHEJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:26:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34AFD78207
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:26:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-0nSC5lN1Mf6CKuQecZXkzw-1; Fri, 05 Aug 2022 10:26:03 +0100
X-MC-Unique: 0nSC5lN1Mf6CKuQecZXkzw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 5 Aug 2022 10:26:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 5 Aug 2022 10:26:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kanna Scarlet' <knscarlet@gnuweeb.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Bill Metzenthen" <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Thread-Topic: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Thread-Index: AQHYqC07pBmJLRD/dU+qGFItY3OGOq2gCd9A
Date:   Fri, 5 Aug 2022 09:26:02 +0000
Message-ID: <126271e264204581a42b079b51481740@AcuMS.aculab.com>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
 <20220804152656.8840-2-knscarlet@gnuweeb.org> <Yuvrd2yWLnyxOVLU@zn.tnic>
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
In-Reply-To: <20220804180805.9077-1-knscarlet@gnuweeb.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

From: Kanna Scarlet
> Sent: 04 August 2022 19:08
> 
> On 8/4/22 10:53 PM, Borislav Petkov wrote:
> > Bonus points if you find out what other advantage
> >
> > XOR reg,reg
> >
> > has when it comes to clearing integer registers.
> 
> Hello sir Borislav,
> 
> Thank you for your response. I tried to find out other advantages of
> xor reg,reg on Google and found this:
> https://stackoverflow.com/a/33668295/7275114
> 
>   "xor (being a recognized zeroing idiom, unlike mov reg, 0) has some
>   obvious and some subtle advantages:
> 
>   1. smaller code-size than mov reg,0. (All CPUs)
>   2. avoids partial-register penalties for later code.
>      (Intel P6-family and SnB-family).
>   3. doesn't use an execution unit, saving power and freeing up
>      execution resources. (Intel SnB-family)
>   4. smaller uop (no immediate data) leaves room in the uop cache-line
>      for nearby instructions to borrow if needed. (Intel SnB-family).
>   5. doesn't use up entries in the physical register file. (Intel
>      SnB-family (and P4) at least, possibly AMD as well since they use
>      a similar PRF design instead of keeping register state in the ROB
>      like Intel P6-family microarchitectures.)"

You missed one, and an additional change:

Use "xor %rax,%rax" instead of "xor %eax,%eax" to save
the 'reg' prefix.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

