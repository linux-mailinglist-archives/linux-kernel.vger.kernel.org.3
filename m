Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352164BCE6C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiBTMUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Feb 2022 07:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbiBTMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:20:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE7CD53B66
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:20:18 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-XmNydNefOpKMmaiVw1k89A-1; Sun, 20 Feb 2022 12:20:16 +0000
X-MC-Unique: XmNydNefOpKMmaiVw1k89A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 20 Feb 2022 12:20:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 20 Feb 2022 12:20:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Armin Wolf' <W_Armin@gmx.de>, "pali@kernel.org" <pali@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Topic: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Index: AQHYJdVCkKl8QQjZ0kWJRwIdNPLg26ycWRjg
Date:   Sun, 20 Feb 2022 12:20:13 +0000
Message-ID: <d66ab183f32c49b2b901b432d284edc5@AcuMS.aculab.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> requiring smm_regs to be packed. Also since the
> SMM handler seems to modify the carry flag, the new
> code informs the compiler that the flags register
> needs to be saved/restored. Since clang runs out of
> registers on 32 bit x86 when using CC_OUT, we need
> to execute "setc" ourself.

You always need to save anything from the flags register
inside the asm block - it is never valit afterwards.

> Also modify the debug message so we can still see
> the result (eax) when the carry flag was set.
> 
> Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - fix clang running out of registers on 32 bit x86
> - modify debug message
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 85 ++++++++++------------------------
>  1 file changed, 25 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index c5939e68586d..f1538a46bfc9 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -119,7 +119,7 @@ struct smm_regs {
>  	unsigned int edx;
>  	unsigned int esi;
>  	unsigned int edi;
> -} __packed;
> +};
> 
>  static const char * const temp_labels[] = {
>  	"CPU",
> @@ -165,73 +165,38 @@ static int i8k_smm_func(void *par)
>  	int eax = regs->eax;
>  	int ebx = regs->ebx;
>  	long long duration;
> -	int rc;
> +	bool carry;

I'd use an explicit 'unsigned char' not bool.
Matches the type of the 'setcc' instriction.

>  	/* SMM requires CPU 0 */
>  	if (smp_processor_id() != 0)
>  		return -EBUSY;
> 
> -#if defined(CONFIG_X86_64)
> -	asm volatile("pushq %%rax\n\t"
> -		"movl 0(%%rax),%%edx\n\t"
> -		"pushq %%rdx\n\t"
> -		"movl 4(%%rax),%%ebx\n\t"
> -		"movl 8(%%rax),%%ecx\n\t"
> -		"movl 12(%%rax),%%edx\n\t"
> -		"movl 16(%%rax),%%esi\n\t"
> -		"movl 20(%%rax),%%edi\n\t"
> -		"popq %%rax\n\t"
> -		"out %%al,$0xb2\n\t"
> -		"out %%al,$0x84\n\t"
> -		"xchgq %%rax,(%%rsp)\n\t"
> -		"movl %%ebx,4(%%rax)\n\t"
> -		"movl %%ecx,8(%%rax)\n\t"
> -		"movl %%edx,12(%%rax)\n\t"
> -		"movl %%esi,16(%%rax)\n\t"
> -		"movl %%edi,20(%%rax)\n\t"
> -		"popq %%rdx\n\t"
> -		"movl %%edx,0(%%rax)\n\t"
> -		"pushfq\n\t"
> -		"popq %%rax\n\t"
> -		"andl $1,%%eax\n"
> -		: "=a"(rc)
> -		:    "a"(regs)
> -		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> -#else
> -	asm volatile("pushl %%eax\n\t"
> -	    "movl 0(%%eax),%%edx\n\t"
> -	    "push %%edx\n\t"
> -	    "movl 4(%%eax),%%ebx\n\t"
> -	    "movl 8(%%eax),%%ecx\n\t"
> -	    "movl 12(%%eax),%%edx\n\t"
> -	    "movl 16(%%eax),%%esi\n\t"
> -	    "movl 20(%%eax),%%edi\n\t"
> -	    "popl %%eax\n\t"
> -	    "out %%al,$0xb2\n\t"
> -	    "out %%al,$0x84\n\t"
> -	    "xchgl %%eax,(%%esp)\n\t"
> -	    "movl %%ebx,4(%%eax)\n\t"
> -	    "movl %%ecx,8(%%eax)\n\t"
> -	    "movl %%edx,12(%%eax)\n\t"
> -	    "movl %%esi,16(%%eax)\n\t"
> -	    "movl %%edi,20(%%eax)\n\t"
> -	    "popl %%edx\n\t"
> -	    "movl %%edx,0(%%eax)\n\t"
> -	    "lahf\n\t"
> -	    "shrl $8,%%eax\n\t"
> -	    "andl $1,%%eax\n"
> -	    : "=a"(rc)
> -	    :    "a"(regs)
> -	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> -#endif
> -	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> -		rc = -EINVAL;
> +	asm volatile("out %%al,$0xb2\n\t"
> +		     "out %%al,$0x84\n\t"
> +		     "setc %0\n"
> +		     : "=mr" (carry),
> +		       "=a" (regs->eax),
> +		       "=b" (regs->ebx),
> +		       "=c" (regs->ecx),
> +		       "=d" (regs->edx),
> +		       "=S" (regs->esi),
> +		       "=D" (regs->edi)
> +		     : "a" (regs->eax),
> +		       "b" (regs->ebx),
> +		       "c" (regs->ecx),
> +		       "d" (regs->edx),
> +		       "S" (regs->esi),
> +		       "D" (regs->edi)

If you use "+a" (etc) for the output registers you don't
need to respecify them as input registers.

> +		     : "cc");

No need to specify "cc", it is always assumed clobbered.

	David

> 
>  	duration = ktime_us_delta(ktime_get(), calltime);
> -	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
> -		 (rc ? 0xffff : regs->eax & 0xffff), duration);
> +	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x carry: %d (took %7lld usecs)\n",
> +		 eax, ebx, regs->eax & 0xffff, carry, duration);
> 
> -	return rc;
> +	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> +		return -EINVAL;
> +
> +	return 0;
>  }
> 
>  /*
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

