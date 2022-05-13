Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A48526117
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379840AbiEMLi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiEMLi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:38:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A4762B9CB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:38:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-47QNH55mOF2U_dxyQ9hQKA-1; Fri, 13 May 2022 12:38:23 +0100
X-MC-Unique: 47QNH55mOF2U_dxyQ9hQKA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 12:38:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 12:38:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] random: move initialization out of reseeding hot path
Thread-Topic: [PATCH 2/2] random: move initialization out of reseeding hot
 path
Thread-Index: AQHYZrNG22LZp2elLEWapGM10npdEa0crkqw
Date:   Fri, 13 May 2022 11:38:23 +0000
Message-ID: <d0dc54cecff5400d97f877676d7f11b1@AcuMS.aculab.com>
References: <20220509121409.529788-1-Jason@zx2c4.com>
 <20220509121409.529788-2-Jason@zx2c4.com>
 <Yn35k+yyrvgAt3tb@owl.dominikbrodowski.net> <Yn4xLowv+farg814@zx2c4.com>
In-Reply-To: <Yn4xLowv+farg814@zx2c4.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDEzIE1heSAyMDIyIDExOjIyDQo+IA0K
PiBPbiBGcmksIE1heSAxMywgMjAyMiBhdCAwODoyNDoxOUFNICswMjAwLCBEb21pbmlrIEJyb2Rv
d3NraSB3cm90ZToNCj4gPiA+IC0JaWYgKCFjcm5nX3JlYWR5KCkpIHsNCj4gPiA+IC0JCWNybmdf
aW5pdCA9IENSTkdfUkVBRFk7DQo+ID4gPiAtCQlmaW5hbGl6ZV9pbml0ID0gdHJ1ZTsNCj4gPiA+
IC0JfQ0KPiA+ID4gKwljcm5nX2luaXQgPSBDUk5HX1JFQURZOw0KPiA+DQo+ID4gV2h5IHVuY29u
ZGl0aW9uYWxseQ0KPiANCj4gVG8gYXZvaWQgYSB1c2VsZXNzIGJyYW5jaC4NCg0KQXJlIHlvdSBu
b3cgZGlydHlpbmcgYSBjYWNoZSBsaW5lIHRoYXQgd291bGQNCm90aGVyd2lzZSBiZSBjbGVhbj8N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

