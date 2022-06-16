Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEF54DAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359206AbiFPGfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiFPGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:35:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2441A56B2C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:35:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-sCnYHqVNOFmgVXEq4wuTBA-1; Thu, 16 Jun 2022 07:35:45 +0100
X-MC-Unique: sCnYHqVNOFmgVXEq4wuTBA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 16 Jun 2022 07:35:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 16 Jun 2022 07:35:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Thread-Topic: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Thread-Index: AQHYgRCKqYZTWjd2ckufHWAySodJ3K1Rk5mQ
Date:   Thu, 16 Jun 2022 06:35:44 +0000
Message-ID: <9708d6cf72184b7788bfb95ea1f46faf@AcuMS.aculab.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <20220615225200.lflv4tbqus6lnj5u@black.fi.intel.com>
 <db63853f-dbd8-7593-032d-e674046bff8e@intel.com>
In-Reply-To: <db63853f-dbd8-7593-032d-e674046bff8e@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMTYgSnVuZSAyMDIyIDAwOjM1DQo+IA0KPiBPbiA2
LzE1LzIyIDE1OjUyLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4+ICsJdmFkZHIgPSAo
dW5zaWduZWQgbG9uZylpbnNuX2dldF9hZGRyX3JlZigmaW5zbiwgcmVncyk7DQo+ID4+ICsJaWYg
KHZhZGRyIC8gUEFHRV9TSVpFICE9ICh2YWRkciArIHNpemUpIC8gUEFHRV9TSVpFKQ0KPiA+IE9v
cHMuIEkganVzdCByZWFsaXplZCBpdCBoYXMgb2ZmLWJ5LW9uZS4gSXQgc3VwcG9zZWQgdG8gYmU6
DQo+ID4NCj4gPiAJaWYgKHZhZGRyIC8gUEFHRV9TSVpFICE9ICh2YWRkciArIHNpemUgLSAxKSAv
IFBBR0VfU0laRSkNCj4gDQo+IFRoYXQgd2FzIGJ1Z2dpbmcgbWUuICBHbGFkIHlvdSBjYXVnaHQg
dGhpcy4NCj4gDQo+IFdvdWxkbid0IHRoaXMgYmUgbW9yZSBvYnZpb3VzbHkgY29ycmVjdD8NCj4g
DQo+IAlpZiAoQUxJR05fRE9XTih2YWRkciwgICAgICAgIFBBR0VfU0laRSkgIT0NCj4gCSAgICBB
TElHTl9ET1dOKHZhZGRyICsgc2l6ZSwgUEFHRV9TSVpFKSkNCj4gCQkuLi4NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgd2UgaGF2ZSBhIFBBR0VfQUxJR05fRE9XTigpLg0KDQpPcjoNCglpZiAoKHZhZGRy
IF4gKHZhZGRyICsgc2l6ZSAtIDEpKSA+PiBQQUdFX1NISUZUKQ0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

