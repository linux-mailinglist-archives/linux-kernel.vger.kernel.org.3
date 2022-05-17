Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E527529CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiEQItN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 04:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbiEQItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:49:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95A824617E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:48:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-34-6UbOAxNsPEi7Kzwns5WYfw-1; Tue, 17 May 2022 09:48:49 +0100
X-MC-Unique: 6UbOAxNsPEi7Kzwns5WYfw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 17 May 2022 09:48:41 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 17 May 2022 09:48:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Topic: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Index: AQHYacnJgt4N7xLw0EK8voqNmmoVIa0iwPIw
Date:   Tue, 17 May 2022 08:48:41 +0000
Message-ID: <ebd0c266697a42c8b7609ff6cbc5f6c9@AcuMS.aculab.com>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <202205161531.3339CA95@keescook>
 <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
 <YoNfiK1qKd9YDVIf@hirez.programming.kicks-ass.net>
In-Reply-To: <YoNfiK1qKd9YDVIf@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 17 May 2022 09:41
...
> > If we use %eax instead of %r10d for the hash transfer (as per Joao), and
> > use int3 instead of ud2, then we can shrink the fineibt sequence to:
> >
> > __cfi_\func:
> > 	endbr				# 4
> > 	xorl	$0x12345678, %eax	# 5
> > 	jz	1f			# 2
> > 	int3				# 1
> > \func:
> > 	...
> >
> > Which is 12 bytes, and needs a larger preamble (up from 9 in the current
> > proposal).
> 
> On all that; perhaps it would be good to have a compiler option to
> specify the preamble size. It can enforce the minimum at 7 to have at
> least the required:
> 
> 	movl $0x12345678, %eax
> 	int3
> 	int3
> 
> but any larger number will just increase the preamble with int3 padding
> at the top.
> 
> That can go right along with the option to supress endbr when preamble
> :-)

You also need a compiler option to specify the register.
While (I think) %eax is usable in kernel, it isn't in userspace.
It is used in varargs calls to pass (IIRC) the number of fp
args that are passed in registers.

(I can't remember which registers userspace has reserved for
the PLT code? - That might include r10??)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

