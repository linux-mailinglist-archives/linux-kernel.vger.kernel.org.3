Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C04E3DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiCVLkl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiCVLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:40:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 534B513F90
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:39:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-38-lnX6-H1VMiaQvmmh42a07A-1; Tue, 22 Mar 2022 11:39:06 +0000
X-MC-Unique: lnX6-H1VMiaQvmmh42a07A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 11:39:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 11:39:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPdalMvftIu2CIkSH1LImoy2kmazLRP7A
Date:   Tue, 22 Mar 2022 11:39:06 +0000
Message-ID: <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
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

From: Ammar Faizi
> Sent: 22 March 2022 10:21
> On i386, the 6th argument of syscall goes in %ebp. However, both Clang
> and GCC cannot use %ebp in the clobber list and in the "r" constraint
> without using -fomit-frame-pointer. To make it always available for
> any kind of compilation, the below workaround is implemented.
> 
...
> diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
> index 125a691fc631..9f4dc36e6ac2 100644
> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -167,6 +167,72 @@ struct sys_stat_struct {
>  	_ret;                                                                 \
>  })
> 
> +
> +/*
> + * Both Clang and GCC cannot use %ebp in the clobber list and in the "r"
> + * constraint without using -fomit-frame-pointer. To make it always
> + * available for any kind of compilation, the below workaround is
> + * implemented.
> + *
> + * For clang (the Assembly statement can't clobber %ebp):
> + *   1) Push the 6-th argument.
> + *   2) Push %ebp.
> + *   3) Load the 6-th argument from 4(%esp) to %ebp.
> + *   4) Do the syscall (int $0x80).
> + *   5) Pop %ebp (restore the old value of %ebp).
> + *   6) Add %esp by 4 (undo the stack pointer).
> + *
> + * For GCC, fortunately it has a #pragma that can force a specific function
> + * to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
> + * var is a variable bound to %ebp.
> + *
> + */
> +#if defined(__clang__)
> +static inline long ____do_syscall6(long eax, long ebx, long ecx, long edx,
> +				   long esi, long edi, long ebp)

That should probably be:
static inline long ____do_syscall6(long nr, long arg1, long arg2, long arg3,
				   long arg4, long arg5, long arg6)
and the input constraints changed to match.

> +{
> +	__asm__ volatile (
> +		"pushl	%[arg6]\n\t"
> +		"pushl	%%ebp\n\t"
> +		"movl	4(%%esp), %%ebp\n\t"
> +		"int	$0x80\n\t"
> +		"popl	%%ebp\n\t"
> +		"addl	$4,%%esp\n\t"
> +		: "=a"(eax)
> +		: "a"(eax), "b"(ebx), "c"(ecx), "d"(edx), "S"(esi), "D"(edi),

Does having "=a" for an output constraint and "a" for an input
constraint actually DTRT?
There is a special syntax for tying input and output to
the same register.
Or you could use "+a"(nr_rval) and 'return nr_rval'.

	David

> +		  [arg6]"m"(ebp)
> +		: "memory", "cc"
> +	);
> +	return eax;
> +}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

