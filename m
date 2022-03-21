Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F44E2D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbiCUQBn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Mar 2022 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbiCUQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:01:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28AFD496BD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:00:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-239-DZcqY6ZCNM-Zxa3ztE6Iiw-1; Mon, 21 Mar 2022 16:00:10 +0000
X-MC-Unique: DZcqY6ZCNM-Zxa3ztE6Iiw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 16:00:11 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 16:00:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
CC:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [PATCH] ocfs2: fix check if list iterator did find an element
Thread-Topic: [PATCH] ocfs2: fix check if list iterator did find an element
Thread-Index: AQHYPSvRVnhy0IZf6EGgy069JPLEqKzJ/HWg
Date:   Mon, 21 Mar 2022 16:00:10 +0000
Message-ID: <75180dd18a3f460891cd93f7fcb3aa1c@AcuMS.aculab.com>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
 <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
 <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com> <20220321135435.GL336@kadam>
In-Reply-To: <20220321135435.GL336@kadam>
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

From: Dan Carpenter
> Sent: 21 March 2022 13:55
> On Mon, Mar 21, 2022 at 02:34:34PM +0100, Jakob Koschel wrote:
> > >> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
> > >> 		}
> > >> 	}
> > >>
> > >> -	list_for_each_entry(res, track_list, tracking) {
> > >> -		if (&res->tracking == &dlm->tracking_list)
> > >> -			res = NULL;
> > >> -		else
> > >> -			dlm_lockres_get(res);
> > >> +	list_for_each_entry(iter, track_list, tracking) {
> > >> +		if (&iter->tracking != &dlm->tracking_list) {
> 
> This is an open coded version of:
> 
> 	if (!list_entry_is_head(iter, &dlm->tracking_list, tracking)) {

Doesn't list_for_each_entry() terminate before that happens?
So this code is probably still horribly broken.

My worry about bugs with these lists isn't really the code
that uses list_for_each_entry() - they are fairly easy to
locate, read and fix.
The problem is all the other code that is scanning these
list in other more obscure ways.

It really isn't a list structure that is easy to use at all.
It's only slight advantage is that you can unlink an item
without knowing the list head.
(Which can stop buggy code generating cross-linked lists.)

Unless you actually need to traverse backwards the 'back
pointer points to forwards pointer' list is much better.
Even if you have to maintain a 'pointer to last' to get
FIFO operation.

The other option is to double-link the items into a loop and
have a 'head' that points to the first item.

Both these loops have 'pointer to items' to don't need
container_of() and get better type checking from the compiler.

	David

> 
> Ideally someone would come through with enough confidence to just delete
> it but the second best option is to just make it readable...
> 
> regards,
> dan carpenter
> 
> > >> +			dlm_lockres_get(iter);
> > >> +			res = iter;
> > >> +		}
> > >> 		break;
> > >> 	}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

