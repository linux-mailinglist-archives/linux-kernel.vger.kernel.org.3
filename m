Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32B587902
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiHBIaI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Aug 2022 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHBIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:30:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B56825C68
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:30:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-LJ-MnU9LMyyehVzQxMP1Kg-1; Tue, 02 Aug 2022 09:29:59 +0100
X-MC-Unique: LJ-MnU9LMyyehVzQxMP1Kg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 2 Aug 2022 09:29:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 2 Aug 2022 09:29:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v8 02/31] kallsyms: avoid hardcoding buffer size
Thread-Topic: [PATCH v8 02/31] kallsyms: avoid hardcoding buffer size
Thread-Index: AQHYphJye/tEVINqhkC+eCkeMuTkcq2bR13g
Date:   Tue, 2 Aug 2022 08:29:58 +0000
Message-ID: <c2bdc599a30e4cb887aa97e7c9d0355a@AcuMS.aculab.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-3-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-3-ojeda@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda
> Sent: 02 August 2022 02:50
> 
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
> hardcoded size of the input buffer.
> 
> It will also make it easier to update the size in a single place
> in a later patch.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 52f5488c61bc..f3c5a2623f71 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -27,8 +27,14 @@
> 
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
> 
> +#define _stringify_1(x)	#x
> +#define _stringify(x)	_stringify_1(x)
> +
>  #define KSYM_NAME_LEN		128
> 
> +/* A substantially bigger size than the current maximum. */
> +#define KSYM_NAME_LEN_BUFFER	499
> +
>  struct sym_entry {
>  	unsigned long long addr;
>  	unsigned int len;
> @@ -198,13 +204,13 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
> 
>  static struct sym_entry *read_symbol(FILE *in)
>  {
> -	char name[500], type;
> +	char name[KSYM_NAME_LEN_BUFFER+1], type;
>  	unsigned long long addr;
>  	unsigned int len;
>  	struct sym_entry *sym;
>  	int rc;
> 
> -	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> +	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);

Think I'd use "%*s" - simpler.
Although I normally completely avoid scanf() - too easy to get wrong.

	David

>  	if (rc != 3) {
>  		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
>  			fprintf(stderr, "Read error or end of file.\n");
> --
> 2.37.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

