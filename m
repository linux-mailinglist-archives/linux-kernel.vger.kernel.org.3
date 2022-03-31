Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360D4ED7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCaKa6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCaKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:30:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93A0CC3D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:29:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-263-wT2Z8KTZO1SBLQAzOKJ3pQ-1; Thu, 31 Mar 2022 11:29:05 +0100
X-MC-Unique: wT2Z8KTZO1SBLQAzOKJ3pQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 31 Mar 2022 11:29:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 31 Mar 2022 11:29:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alaa Mohamed' <eng.alaamohamedsoliman.am@gmail.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Thread-Topic: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Thread-Index: AQHYROi924sZ22xfrE+zbiso9jQv5KzZSk9w
Date:   Thu, 31 Mar 2022 10:29:04 +0000
Message-ID: <ebbc4a14c30f492f8553e6ef572bbcbe@AcuMS.aculab.com>
References: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
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

From: Alaa Mohamed
> Sent: 31 March 2022 11:19
> 
> Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
> reported by checkpatch
> "CHECK: Macro argument reuse 'gdm' - possible side-effects?"
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 04df6f9f5403..6f0274470e69 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,7 +27,9 @@
> 
>  #define MUX_TX_MAX_SIZE 2048
> 
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +#define GDM_TTY_READY(_gdm) \
> +	({ typeof(_gdm) (gdm) = (_gdm); \
> +	(gdm && gdm->tty_dev && gdm->port.count); })

Did you test this?

see https://godbolt.org/z/cazPrrzPv

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

