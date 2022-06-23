Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE688557890
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFWLS0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Jun 2022 07:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiFWLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:18:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF9AC64F6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:18:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-135-F5csG3KMMyCOZzSfmLQ2PA-1; Thu, 23 Jun 2022 12:18:15 +0100
X-MC-Unique: F5csG3KMMyCOZzSfmLQ2PA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 23 Jun 2022 12:18:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 23 Jun 2022 12:18:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'George Cherian' <george.cherian@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH] genirq: Increase the number of interrupters
Thread-Topic: [PATCH] genirq: Increase the number of interrupters
Thread-Index: AQHYhrze4USA0Oy8jUywbP1lQPnHp61c1/2A
Date:   Thu, 23 Jun 2022 11:18:14 +0000
Message-ID: <7974b4d7782b4f8682547389d4f294f8@AcuMS.aculab.com>
References: <20220623031541.1716745-1-george.cherian@marvell.com>
In-Reply-To: <20220623031541.1716745-1-george.cherian@marvell.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Cherian
> Sent: 23 June 2022 04:16
> 
> Currently the maximum number of interrupters is capped at 8260 (64 +
> 8196) in most of the architectures were CONFIG_SPARSE_IRQ is selected.
> This upper limit is not sufficient for couple of existing SoC's from
> Marvell.
> For eg: Octeon TX2 series of processors support a maximum of 32K
> interrupters.
> 
> Bump up the upper limit from 8196 to 65536.

This seems to add 7kB of static data to the kernel just on
the off chance that some sparse interrupt numbers are large.

	David

> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> ---
>  kernel/irq/internals.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index f09c60393e559..9bb42757d4afc 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -12,7 +12,7 @@
>  #include <linux/sched/clock.h>
> 
>  #ifdef CONFIG_SPARSE_IRQ
> -# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> +# define IRQ_BITMAP_BITS	(NR_IRQS + 65536)
>  #else
>  # define IRQ_BITMAP_BITS	NR_IRQS
>  #endif
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

