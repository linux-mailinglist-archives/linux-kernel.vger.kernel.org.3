Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6352F504
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbiETVZA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 May 2022 17:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiETVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:24:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2834F19C752
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:24:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-uAkP6drMODaD-3dcxYufPg-1; Fri, 20 May 2022 22:24:51 +0100
X-MC-Unique: uAkP6drMODaD-3dcxYufPg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 20 May 2022 22:24:51 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 20 May 2022 22:24:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Topic: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Index: AQHYbFCwvu9LSlrdFk+NviNR2+4IRK0nyjDg
Date:   Fri, 20 May 2022 21:24:50 +0000
Message-ID: <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
References: <20220520135103.166972-1-Jason@zx2c4.com>
In-Reply-To: <20220520135103.166972-1-Jason@zx2c4.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld
> Sent: 20 May 2022 14:51
> 
> Most kernel code prefers read_iter over read and write_iter over write,
> yet the read function pointer is tested first. Reverse these so that the
> iter function is always used first.

There will be a measurable performance hit for the xxx_iter versions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

