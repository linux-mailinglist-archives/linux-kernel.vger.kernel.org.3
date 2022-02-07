Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6641C4AC734
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiBGRXA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382714AbiBGROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:14:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13295C0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:14:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-261-OsvrFIUnMKKFrChEQsxdNA-1; Mon, 07 Feb 2022 17:14:46 +0000
X-MC-Unique: OsvrFIUnMKKFrChEQsxdNA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 7 Feb 2022 17:14:43 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 7 Feb 2022 17:14:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Stafford Horne <shorne@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Jonas Bonn" <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: RE: [PATCH] openrisc: remove CONFIG_SET_FS
Thread-Topic: [PATCH] openrisc: remove CONFIG_SET_FS
Thread-Index: AQHYG/BjkR+ecsCi7UOyp98rZRODA6yIU2uA
Date:   Mon, 7 Feb 2022 17:14:43 +0000
Message-ID: <3744dcbbf2874875b023548aacdd8b41@AcuMS.aculab.com>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <YgC/8ng5WX6Nt104@infradead.org>
In-Reply-To: <YgC/8ng5WX6Nt104@infradead.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig
> Sent: 07 February 2022 06:45
> 
> On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> This ain't UML :)
> 
> > +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> 
> No need for the inner braces.

Since TASK_SIZE is actually an address wouldn't be better to
swap the condition around (in every architecture).

	return addr <= TASK_SIZE && size <= TASK_SIZE - addr;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

