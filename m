Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CDA57C63B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGUI0l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jul 2022 04:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiGUI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:26:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF7AC1AF2F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:26:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-auZpXflvPsSN020UXNPu1Q-1; Thu, 21 Jul 2022 09:26:35 +0100
X-MC-Unique: auZpXflvPsSN020UXNPu1Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 21 Jul 2022 09:26:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 21 Jul 2022 09:26:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Liam Howlett' <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: RE: [PATCH] maple_tree: Do not inline write slow path
Thread-Topic: [PATCH] maple_tree: Do not inline write slow path
Thread-Index: AQHYnJw6aOsbtqNHaEaswARV7Qt6zq2IfbZw
Date:   Thu, 21 Jul 2022 08:26:34 +0000
Message-ID: <040322fa455941ff9b82ebb0f53a576a@AcuMS.aculab.com>
References: <20220721005237.377987-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220721005237.377987-1-Liam.Howlett@oracle.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Howlett
> Sent: 21 July 2022 01:53
> 
> Having the slow path inlined causes too much stack usage.  Create new
> function mas_wr_bnode() to write a big node into the tree

Unless you mark the function 'noinline' the compiler is
likely to inline it anyway.

	David

> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 95d8659c5a99..4c383c780162 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4297,12 +4297,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  	return false;
>  }
> 
> +/*
> + * mas_wr_bnode() - Slow path for a modification.
> + * @wr_mas: The write maple state
> + *
> + * This is where split, rebalance end up.
> + */
> +static void mas_wr_bnode(struct ma_wr_state *wr_mas)
> +{
> +	struct maple_big_node b_node;
> +
> +	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
> +	memset(&b_node, 0, sizeof(struct maple_big_node));
> +	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
> +	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
> +}
> +
>  static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char node_slots;
>  	unsigned char node_size;
>  	struct ma_state *mas = wr_mas->mas;
> -	struct maple_big_node b_node;
> 
>  	/* Direct replacement */
>  	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
> @@ -4338,10 +4353,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  		return;
> 
>  slow_path:
> -	memset(&b_node, 0, sizeof(struct maple_big_node));
> -	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
> -	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
> +	mas_wr_bnode(wr_mas);
>  }
> 
>  /*
> --
> 2.35.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

