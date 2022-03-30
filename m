Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D14ECD72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiC3Tqf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Mar 2022 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiC3Tqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:46:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F241F4831B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:44:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-sTVwhZujNvyjZOKRNVF1Hw-1; Wed, 30 Mar 2022 20:44:44 +0100
X-MC-Unique: sTVwhZujNvyjZOKRNVF1Hw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 30 Mar 2022 20:44:41 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 30 Mar 2022 20:44:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Sands' <sandsch@northvilleschools.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH V2] staging: r8188eu: Fix sparse endianness warnings
Thread-Topic: [PATCH V2] staging: r8188eu: Fix sparse endianness warnings
Thread-Index: AQHYRGdq3t0D07ysn0eWtIbomAsTtKzYUyUw
Date:   Wed, 30 Mar 2022 19:44:41 +0000
Message-ID: <4c7f9a23c9f64662bfef2b4452c3cca4@AcuMS.aculab.com>
References: <YkSnBW70kruOyN9h@sckzor-linux.localdomain>
In-Reply-To: <YkSnBW70kruOyN9h@sckzor-linux.localdomain>
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

From: Charlie Sands
> Sent: 30 March 2022 19:53
> 
> This patch fixes sparse warnings about the endianness of different
> pieces of data in the driver.
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for
> RTL8188eu driver")
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
> V2: Added the "fixes" line to the commit at the request of Dan Carpenter.
> 
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index d68611ef22f8..ed41c4e30262 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
>  	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
>  	int data_len;
> 
> -	data_len = tag->tag_len + TAG_HDR_LEN;
> +	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
>  	if (skb_tailroom(skb) < data_len)
>  		return -1;
> 
> @@ -432,7 +432,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  		/*                Handle PPPoE frame                 */
>  		/*---------------------------------------------------*/
>  		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
> -		unsigned short *pMagic;
> +		__be16 *pMagic;
> 
>  		switch (method) {
>  		case NAT25_CHECK:
> @@ -471,7 +471,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  						tag->tag_len =
> htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
> 
>  						/*  insert the magic_code+client mac in relay tag */
> -						pMagic = (unsigned short *)tag->tag_data;
> +						pMagic = (__be16 *)tag->tag_data;
>  						*pMagic = htons(MAGIC_CODE);
                                              ^ cpu_to_be32()
>  						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN,
> ETH_ALEN);
> 
> @@ -557,9 +557,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN +
> sizeof(*iph));
>  						hdr->icmp6_cksum = 0;
>  						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
> -										iph->payload_len,
> +										be16_to_cpu(iph->payload_len),
>  										IPPROTO_ICMPV6,
> -										csum_partial((__u8 *)hdr, iph-
> >payload_len, 0));
> +										csum_partial((__u8 *)hdr,
> +										be16_to_cpu(iph->payload_len),
> +										0));

That line continuation is horrid.
netdev probably wants the continuation under the (.
But it might be best to assign the result of csum_partial()
to a variable.

	David

>  					}
>  				}
>  			}
> --
> 2.35.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

