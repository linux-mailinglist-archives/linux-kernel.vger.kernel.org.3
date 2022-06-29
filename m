Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE255FADB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiF2Iln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiF2Ilm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:41:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E9083CA74
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:41:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-3YVn8aRSPNyCaLqH6g1oTw-1; Wed, 29 Jun 2022 09:41:38 +0100
X-MC-Unique: 3YVn8aRSPNyCaLqH6g1oTw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 29 Jun 2022 09:41:37 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 29 Jun 2022 09:41:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Hunter' <adrian.hunter@intel.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCHv2] mmc: block: Add single read for 4k sector cards
Thread-Index: AQHYiucLByB3ldQ3gEq/geVsHk3Kha1mEXsA
Date:   Wed, 29 Jun 2022 08:41:37 +0000
Message-ID: <3d9ff280c02042e58e406241599ce893@AcuMS.aculab.com>
References: <e0cce326393645d3b4a163ce65c89fb9@hyperstone.com>
 <e7ebb779-9938-d5f7-d900-dbea55b4ac72@intel.com>
In-Reply-To: <e7ebb779-9938-d5f7-d900-dbea55b4ac72@intel.com>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4+IAkJCWJycS0+ZGF0YS5ibG9ja3MgPSBxdWV1ZV9waHlzaWNhbF9ibG9ja19zaXpl
KHJlcS0+cSkgPj4gU0VDVE9SX1NISUZUOw0KPiA+DQo+ID4gRG8gd2Ugd2FudCB0byBzd2l0Y2gg
dG8gU0VDVE9SX1NISUZUIGluc3RlYWQgb2YgOT8gU28gZmFyIFNFQ1RPUl9TSElGVCBpcyBub3Qg
dXNlZCBhdCBhbGwgaW4gbW1jDQo+IGNvcmUuDQo+IA0KPiBJIGd1ZXNzICc5JyBpcyBtb3JlIGNv
bnNpc3RlbnQNCg0KWW91IGNhbiBqdXN0IG11bHRpcGx5L2RpdmlkZSBieSA1MTJ1IChwcm9iYWJs
eSBTRUNUT1JfU0laRSkuDQooSW4gc29tZSBzZW5zZXMgNTEydSBpcyBhY3R1YWxseSBiZXR0ZXIh
KQ0KTW9yZSBvYnZpb3VzIHN0aWxsIGFuZCB0aGUgY29tcGlsZXIgd2lsbCBnZW5lcmF0ZSBhIHNo
aWZ0IGFueXdheS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

