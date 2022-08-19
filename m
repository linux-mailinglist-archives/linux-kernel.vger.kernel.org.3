Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434259A7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352665AbiHSVbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Aug 2022 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350061AbiHSVbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:31:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE2114189
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:31:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-ftTluvfLP_yQT57jEBdPxg-1; Fri, 19 Aug 2022 22:31:46 +0100
X-MC-Unique: ftTluvfLP_yQT57jEBdPxg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Fri, 19 Aug 2022 22:31:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Fri, 19 Aug 2022 22:31:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'cgel.zte@gmail.com'" <cgel.zte@gmail.com>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>
CC:     "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [PATCH] nilfs2: delete unnecessary checks before brelse()
Thread-Topic: [PATCH] nilfs2: delete unnecessary checks before brelse()
Thread-Index: AQHYs6QzVivB1J0+p0G/dRvjohFw+a22vqKA
Date:   Fri, 19 Aug 2022 21:31:45 +0000
Message-ID: <0d78d24dd26441818dbaedffde611485@AcuMS.aculab.com>
References: <20220819081700.96279-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220819081700.96279-1-chi.minghao@zte.com.cn>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cgel.zte@gmail.com
> Sent: 19 August 2022 09:17
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.

The test is the caller makes sense if it is a 'hot' path
and bh is normally NULL.

	David

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  fs/nilfs2/btree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index f544c22fff78..b3b5a46488c2 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -1668,8 +1668,7 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
>  	maxkey = nilfs_btree_node_get_key(node, nchildren - 1);
>  	nextmaxkey = (nchildren > 1) ?
>  		nilfs_btree_node_get_key(node, nchildren - 2) : 0;
> -	if (bh != NULL)
> -		brelse(bh);
> +	brelse(bh);
> 
>  	return (maxkey == key) && (nextmaxkey < NILFS_BMAP_LARGE_LOW);
>  }
> @@ -1717,8 +1716,7 @@ static int nilfs_btree_gather_data(struct nilfs_bmap *btree,
>  		ptrs[i] = le64_to_cpu(dptrs[i]);
>  	}
> 
> -	if (bh != NULL)
> -		brelse(bh);
> +	brelse(bh);
> 
>  	return nitems;
>  }
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

