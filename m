Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3EF5260F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379912AbiEML2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379622AbiEML2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:28:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79C6D87A3F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:28:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-xf0pVlSGM5qUsyVK2HFRJA-1; Fri, 13 May 2022 12:28:01 +0100
X-MC-Unique: xf0pVlSGM5qUsyVK2HFRJA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 12:28:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 12:28:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Potapenko' <glider@google.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFCv2 00/10] Linear Address Masking enabling
Thread-Topic: [RFCv2 00/10] Linear Address Masking enabling
Thread-Index: AQHYZrnErY7g4wB/gUe/NECu92+S/a0cqjCA
Date:   Fri, 13 May 2022 11:28:00 +0000
Message-ID: <8a47d0ee50b44520a6f26177e6fe7ec5@AcuMS.aculab.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
In-Reply-To: <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
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

Li4uDQo+IE9uY2Ugd2UgaGF2ZSB0aGUgcG9zc2liaWxpdHkgdG8gc3RvcmUgdGFncyBpbiB0aGUg
cG9pbnRlcnMsIHdlIGRvbid0DQo+IG5lZWQgcmVkem9uZXMgZm9yIGhlYXAvc3RhY2sgb2JqZWN0
cyBhbnltb3JlLCB3aGljaCBzYXZlcyBxdWl0ZSBhIGJpdA0KPiBvZiBtZW1vcnkuDQoNCllvdSBz
dGlsbCBuZWVkIHJlZHpvbmVzLg0KVGhlIGhpZ2ggYml0cyBhcmUgaWdub3JlZCBmb3IgYWN0dWFs
IG1lbW9yeSBhY2Nlc3Nlcy4NCg0KVG8gZG8gb3RoZXJ3aXNlIHlvdSdkIG5lZWQgdGhlIGhpZ2gg
Yml0cyB0byBiZSBpbiB0aGUgUFRFLA0KY29waWVkIHRvIHRoZSBUTEIgYW5kIGZpbmFsbHkgZ2V0
IGludG8gdGhlIGNhY2hlIHRhZy4NCg0KVGhlbiB5b3UnZCBoYXZlIHRvIHVzZSB0aGUgY29ycmVj
dCB0YWdzIGZvciBlYWNoIHBhZ2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

