Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364D52B6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiERKBi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 May 2022 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiERKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:01:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AB2F5DA21
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:01:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-106-mgP8CKeKN82qIoHot0Di4g-1; Wed, 18 May 2022 11:01:28 +0100
X-MC-Unique: mgP8CKeKN82qIoHot0Di4g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 18 May 2022 11:01:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 18 May 2022 11:01:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] netfs: Use container_of() for offset casting
Thread-Topic: [PATCH] netfs: Use container_of() for offset casting
Thread-Index: AQHYao4oLXT4l68gEEWJLPYHyfOk2K0kZt+Q
Date:   Wed, 18 May 2022 10:01:27 +0000
Message-ID: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com>
References: <20220517210230.864239-1-keescook@chromium.org>
 <2692904.1652861114@warthog.procyon.org.uk>
In-Reply-To: <2692904.1652861114@warthog.procyon.org.uk>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells 
> Sent: 18 May 2022 09:05
> 
> I wonder if it would be worth making this explicit in the inode wrappers of
> the users of netfslib.  In afs, for instance, there is:
> 
> 	struct afs_vnode {
> 		struct {
> 			/* These must be contiguous */
> 			struct inode	vfs_inode;
> 			struct netfs_i_context netfs_ctx;
> 		};
> 		...
> 	};
> 
> would it be worth making that:
> 
> 	struct afs_vnode {
> 		union {
> 			struct netfs_i_c_pair netfs_inode;
> 			struct {
> 				/* These must be contiguous */
> 				struct inode	vfs_inode;
> 				struct netfs_i_context netfs_ctx;
> 			};
> 		};
> 		...
> 	};
> 

Can't you just name the structure so it is:

	struct afs_vnode {
 		struct netfs_i_c_pair {
 			/* These must be contiguous */
 			struct inode	vfs_inode;
 			struct netfs_i_context netfs_ctx;
 		};
 		...
 	};

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

