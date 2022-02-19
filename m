Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B54BCAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiBSUog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Feb 2022 15:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbiBSUoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 15:44:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB9D763B8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:44:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-BrTiMTokPKK8woRnAQkmNw-1; Sat, 19 Feb 2022 20:44:08 +0000
X-MC-Unique: BrTiMTokPKK8woRnAQkmNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 19 Feb 2022 20:44:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 19 Feb 2022 20:44:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hans Weber' <hwe.kernel@gmail.com>,
        "torvalds@evo.osdl.org" <torvalds@evo.osdl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] only call the c function set_bios_mode if the value
 CONFIG_X86_64 is set.
Thread-Topic: [PATCH] only call the c function set_bios_mode if the value
 CONFIG_X86_64 is set.
Thread-Index: AQHYJdDhqzvQ94eHk06WTeBVkGzDSaybVuig
Date:   Sat, 19 Feb 2022 20:44:07 +0000
Message-ID: <fa07b3858c254cd8947434bdd89412e2@AcuMS.aculab.com>
References: <20220219203950.106655-1-hwe.kernel@gmail.com>
In-Reply-To: <20220219203950.106655-1-hwe.kernel@gmail.com>
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

From: Hans Weber
> Sent: 19 February 2022 20:40
> 
> Signed-off-by: Hans Weber <hwe.kernel@gmail.com>
> ---
>  arch/x86/boot/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
> index e3add857c2c9..e4df8ff1e228 100644
> --- a/arch/x86/boot/main.c
> +++ b/arch/x86/boot/main.c
> @@ -102,14 +102,12 @@ static void query_ist(void)
>   */
>  static void set_bios_mode(void)
>  {
> -#ifdef CONFIG_X86_64
>  	struct biosregs ireg;
> 
>  	initregs(&ireg);
>  	ireg.ax = 0xec00;
>  	ireg.bx = 2;
>  	intcall(0x15, &ireg, NULL);
> -#endif
>  }
> 
>  static void init_heap(void)
> @@ -152,7 +150,9 @@ void main(void)
>  	}
> 
>  	/* Tell the BIOS what CPU mode we intend to run in. */
> +#ifdef CONFIG_X86_64
>  	set_bios_mode();
> +#endif

That should make absolutely no difference.
The empty static function will be inlined and thus discarded.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

