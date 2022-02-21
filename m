Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32E4BED43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiBUWdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Feb 2022 17:33:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiBUWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:33:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4073D5FA0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:33:22 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-72-4cM8G8pfPjKRstTRxL7HKQ-1; Mon, 21 Feb 2022 22:33:20 +0000
X-MC-Unique: 4cM8G8pfPjKRstTRxL7HKQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 21 Feb 2022 22:33:19 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 21 Feb 2022 22:33:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Marek" <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] fixdep: use fflush() and ferror() to ensure successful
 write to files
Thread-Topic: [PATCH] fixdep: use fflush() and ferror() to ensure successful
 write to files
Thread-Index: AQHYJ0I5ab4KpWmMiEy1rF7ornjtjayelfMA
Date:   Mon, 21 Feb 2022 22:33:19 +0000
Message-ID: <04d06889d8ea41589628995a6cb53874@AcuMS.aculab.com>
References: <20220221164316.113489-1-masahiroy@kernel.org>
In-Reply-To: <20220221164316.113489-1-masahiroy@kernel.org>
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

From: Masahiro Yamada
> Sent: 21 February 2022 16:43
> To: linux-kbuild@vger.kernel.org
> 
> Checking the return value of (v)printf does not ensure the successful
> write to the .cmd file.
> 
> Call fflush() and ferror() to make sure that everything has been
> written to the file.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: David Laight <dvid.laight@aculab.com>

I'll note that you've lost the perror("fixdep").
But I suspect that isn't very meaningful.
If the disk is full it'd probably get lost anyway.


> ---
> 
>  scripts/basic/fixdep.c | 44 ++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
> 
> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> index 44e887cff49b..fad6f29373a9 100644
> --- a/scripts/basic/fixdep.c
> +++ b/scripts/basic/fixdep.c
> @@ -105,25 +105,6 @@ static void usage(void)
>  	exit(1);
>  }
> 
> -/*
> - * In the intended usage of this program, the stdout is redirected to .*.cmd
> - * files. The return value of printf() must be checked to catch any error,
> - * e.g. "No space left on device".
> - */
> -static void xprintf(const char *format, ...)
> -{
> -	va_list ap;
> -	int ret;
> -
> -	va_start(ap, format);
> -	ret = vprintf(format, ap);
> -	if (ret < 0) {
> -		perror("fixdep");
> -		exit(1);
> -	}
> -	va_end(ap);
> -}
> -
>  struct item {
>  	struct item	*next;
>  	unsigned int	len;
> @@ -189,7 +170,7 @@ static void use_config(const char *m, int slen)
> 
>  	define_config(m, slen, hash);
>  	/* Print out a dependency path from a symbol name. */
> -	xprintf("    $(wildcard include/config/%.*s) \\\n", slen, m);
> +	printf("    $(wildcard include/config/%.*s) \\\n", slen, m);
>  }
> 
>  /* test if s ends in sub */
> @@ -318,13 +299,13 @@ static void parse_dep_file(char *m, const char *target)
>  				 */
>  				if (!saw_any_target) {
>  					saw_any_target = 1;
> -					xprintf("source_%s := %s\n\n",
> -						target, m);
> -					xprintf("deps_%s := \\\n", target);
> +					printf("source_%s := %s\n\n",
> +					       target, m);
> +					printf("deps_%s := \\\n", target);
>  				}
>  				is_first_dep = 0;
>  			} else {
> -				xprintf("  %s \\\n", m);
> +				printf("  %s \\\n", m);
>  			}
> 
>  			buf = read_file(m);
> @@ -347,8 +328,8 @@ static void parse_dep_file(char *m, const char *target)
>  		exit(1);
>  	}
> 
> -	xprintf("\n%s: $(deps_%s)\n\n", target, target);
> -	xprintf("$(deps_%s):\n", target);
> +	printf("\n%s: $(deps_%s)\n\n", target, target);
> +	printf("$(deps_%s):\n", target);
>  }
> 
>  int main(int argc, char *argv[])
> @@ -363,11 +344,20 @@ int main(int argc, char *argv[])
>  	target = argv[2];
>  	cmdline = argv[3];
> 
> -	xprintf("cmd_%s := %s\n\n", target, cmdline);
> +	printf("cmd_%s := %s\n\n", target, cmdline);
> 
>  	buf = read_file(depfile);
>  	parse_dep_file(buf, target);
>  	free(buf);
> 
> +	fflush(stdout);
> +
> +	/*
> +	 * In the intended usage, the stdout is redirected to .*.cmd files.
> +	 * Call ferror() to catch errors such as "No space left on device".
> +	 */
> +	if (ferror(stdout))
> +		exit(1);
> +
>  	return 0;
>  }
> --
> 2.32.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

