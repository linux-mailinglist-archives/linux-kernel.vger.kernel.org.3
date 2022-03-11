Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C664D645B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiCKPOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 10:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiCKPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:14:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDE8F65FE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:13:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-103-xBMgNJtJNn2luR1K6f_Okw-1; Fri, 11 Mar 2022 15:13:04 +0000
X-MC-Unique: xBMgNJtJNn2luR1K6f_Okw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Mar 2022 15:13:02 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Mar 2022 15:13:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] x86/unwind/orc: delete dead write in __orc_find()
Thread-Topic: [PATCH 5/5] x86/unwind/orc: delete dead write in __orc_find()
Thread-Index: AQHYNVZ8GGri+f1+t0mvolzUfhJiRqy6SM+A
Date:   Fri, 11 Mar 2022 15:13:02 +0000
Message-ID: <6257b01104da4891af46eec530df1dcb@AcuMS.aculab.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-5-adobriyan@gmail.com>
In-Reply-To: <20220311144312.88466-5-adobriyan@gmail.com>
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

From: Alexey Dobriyan
> Sent: 11 March 2022 14:43
> 
> Also move "mid" variable to the innermost scope and delete useless
> parenthesis while I'm at it.

Hiding the definition of 'mid' in the inner scope is pointless.

I'm also not 100% sure that 'found' is always set.
Consider the ip < orc_ip(first) case.

	David

> 
> Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
> ---
>  arch/x86/kernel/unwind_orc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 2de3c8c5eba9..d38125ea1bf6 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
>  {
>  	int *first = ip_table;
>  	int *last = ip_table + num_entries - 1;
> -	int *mid = first, *found = first;
> +	int *found = first;
> 
>  	if (!num_entries)
>  		return NULL;
> @@ -47,7 +47,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
>  	 * ignored when they conflict with a real entry.
>  	 */
>  	while (first <= last) {
> -		mid = first + ((last - first) / 2);
> +		int *mid = first + (last - first) / 2;
> 
>  		if (orc_ip(mid) <= ip) {
>  			found = mid;
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

