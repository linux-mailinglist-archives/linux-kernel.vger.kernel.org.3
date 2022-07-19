Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12819579798
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiGSKYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiGSKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:24:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AB1313F79
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:24:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-3JDAf-T3MjuitJ0ZtV96nw-1; Tue, 19 Jul 2022 11:24:42 +0100
X-MC-Unique: 3JDAf-T3MjuitJ0ZtV96nw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 11:24:41 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 11:24:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: RE: [PATCH 2/3] ocfs2: Remove a useless spinlock
Thread-Topic: [PATCH 2/3] ocfs2: Remove a useless spinlock
Thread-Index: AQHYm1a23J7AKlhcsUK1MlCgSmBBPK2Fe4Yg
Date:   Tue, 19 Jul 2022 10:24:41 +0000
Message-ID: <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
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

From: Christophe JAILLET
> Sent: 19 July 2022 11:02
> 
> 'node_map_lock' is a spinlock only used to protect calls to set_bit(),
> clear_bit() and test_bit().
> 
> {set|clear}_bit() are already atomic and don't need this extra spinlock.
> test_bit() only reads the bitmap for a given bit.
> 
> Remove this useless spinlock.

It looks to me like the calling code is racy
unless there is another lock in the callers.
While map->map is protected, the result of test_bit()
is stale - so can't be used for much.

	David

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> test_bit() is NOT documented as an atomic function. However, I can't see
> how it could return a wrong result here.
> 
> So review with care. There is maybe something I don't think about that is
> lurking here.
> ---
>  fs/ocfs2/heartbeat.c | 11 ++++-------
>  fs/ocfs2/ocfs2.h     |  2 --
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
> index 1d72e0788943..4863ad35c242 100644
> --- a/fs/ocfs2/heartbeat.c
> +++ b/fs/ocfs2/heartbeat.c
> @@ -35,7 +35,6 @@ static void ocfs2_node_map_init(struct ocfs2_node_map *map)
> 
>  void ocfs2_init_node_maps(struct ocfs2_super *osb)
>  {
> -	spin_lock_init(&osb->node_map_lock);
>  	ocfs2_node_map_init(&osb->osb_recovering_orphan_dirs);
>  }
> 
> @@ -67,9 +66,8 @@ void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
>  	if (bit==-1)
>  		return;
>  	BUG_ON(bit >= map->num_nodes);
> -	spin_lock(&osb->node_map_lock);
> +
>  	set_bit(bit, map->map);
> -	spin_unlock(&osb->node_map_lock);
>  }
> 
>  void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
> @@ -79,9 +77,8 @@ void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
>  	if (bit==-1)
>  		return;
>  	BUG_ON(bit >= map->num_nodes);
> -	spin_lock(&osb->node_map_lock);
> +
>  	clear_bit(bit, map->map);
> -	spin_unlock(&osb->node_map_lock);
>  }
> 
>  int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
> @@ -89,13 +86,13 @@ int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
>  			    int bit)
>  {
>  	int ret;
> +
>  	if (bit >= map->num_nodes) {
>  		mlog(ML_ERROR, "bit=%d map->num_nodes=%d\n", bit, map->num_nodes);
>  		BUG();
>  	}
> -	spin_lock(&osb->node_map_lock);
> +
>  	ret = test_bit(bit, map->map);
> -	spin_unlock(&osb->node_map_lock);
>  	return ret;
>  }
> 
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 740b64238312..1df193b97c30 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -302,8 +302,6 @@ struct ocfs2_super
> 
>  	u32 *slot_recovery_generations;
> 
> -	spinlock_t node_map_lock;
> -
>  	u64 root_blkno;
>  	u64 system_dir_blkno;
>  	u64 bitmap_blkno;
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

