Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3E4F79EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiDGIix convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiDGIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:38:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5ED75B3D5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:36:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-150-biPwcOwTPaWt3B8QWNnyjQ-1; Thu, 07 Apr 2022 09:36:47 +0100
X-MC-Unique: biPwcOwTPaWt3B8QWNnyjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 09:36:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 7 Apr 2022 09:36:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Straube' <straube.linux@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] staging: r8188eu: use round_up() instead of
 _RND8()
Thread-Topic: [PATCH v2 3/5] staging: r8188eu: use round_up() instead of
 _RND8()
Thread-Index: AQHYSe9WHJ0PlHBcbUCkUmsQoIffn6zkIJaQ
Date:   Thu, 7 Apr 2022 08:36:46 +0000
Message-ID: <b00d9bc1cbe24fe4b0f83706427b84db@AcuMS.aculab.com>
References: <20220406172219.15565-1-straube.linux@gmail.com>
 <20220406172219.15565-4-straube.linux@gmail.com>
In-Reply-To: <20220406172219.15565-4-straube.linux@gmail.com>
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

From: Michael Straube
> Sent: 06 April 2022 18:22
> 
> Use in-kernel round_up() instead of custom _RND8().
...
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
...
> @@ -488,7 +488,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
> 
>  		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset *
> PACKET_OFFSET_SZ);
> 
> -		if (_RND8(pbuf + len) > MAX_XMITBUF_SZ) {
> +		if (round_up(pbuf + len, 8) > MAX_XMITBUF_SZ) {

It can't be necessary to round_up there.
It is equivalent to:
		if (pbuf + len > (MAX_XMITBUF_SZ & ~7))
and the limit is/should be a multiple of 8.

	David

>  			pxmitframe->agg_num = 1;
>  			pxmitframe->pkt_offset = 1;
>  			break;

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

