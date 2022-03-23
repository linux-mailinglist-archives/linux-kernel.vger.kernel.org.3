Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F834E5440
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiCWOaX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbiCWOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:30:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED67D13E80
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:28:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-Pk1Wyq6qM162T3n3s26yow-1; Wed, 23 Mar 2022 14:28:43 +0000
X-MC-Unique: Pk1Wyq6qM162T3n3s26yow-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 23 Mar 2022 14:28:42 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 23 Mar 2022 14:28:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Martin Kaiser' <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] staging: r8188eu: use ieee80211 define for version
 check
Thread-Topic: [PATCH 1/7] staging: r8188eu: use ieee80211 define for version
 check
Thread-Index: AQHYPoqESUbsEDAaEUG/qobs079+wKzNBQKg
Date:   Wed, 23 Mar 2022 14:28:42 +0000
Message-ID: <3fafd45e349a4bc3aa8db888f08a71d3@AcuMS.aculab.com>
References: <20220323074859.177425-1-martin@kaiser.cx>
 <20220323074859.177425-2-martin@kaiser.cx>
In-Reply-To: <20220323074859.177425-2-martin@kaiser.cx>
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

From: Martin Kaiser
> Sent: 23 March 2022 07:49
> 
> Use the IEEE80211_FCTL_VERS define to check the version number
> of a received frame.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 8800ea4825ff..524a00345501 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1063,7 +1063,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
>  	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
>  	u8 *ptr = precv_frame->rx_data;
>  	__le16 fc = *(__le16 *)ptr;

Those two lines are somewhat horrid.
Casts of pointers to integer types have a nasty habit of being bugs.
In any case 'ptr' should probably be 'frame_data'.
If the first two bytes are some kind of 16 bit id, then what follows?
Should this be a 'struct' that defines the frame data layout??

	David

> -	u8  ver = (unsigned char)(*ptr) & 0x3;
>  	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
> 
>  	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
> @@ -1072,8 +1071,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
>  			pmlmeext->channel_set[ch_set_idx].rx_count++;
>  	}
> 
> -	/* add version chk */
> -	if (ver != 0)
> +	if ((fc & IEEE80211_FCTL_VERS) != 0)
>  		return _FAIL;
> 
>  	pattrib->to_fr_ds = get_tofr_ds(ptr);
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

