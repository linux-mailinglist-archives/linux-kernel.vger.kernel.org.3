Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AE55E15F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiF1Jkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiF1Jkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:40:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FEE51E3F9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:40:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-166-ihrsEUTYMQSIIyIJiTKbMA-1; Tue, 28 Jun 2022 10:40:42 +0100
X-MC-Unique: ihrsEUTYMQSIIyIJiTKbMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 28 Jun 2022 10:40:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 28 Jun 2022 10:40:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Suzuki K Poulose' <suzuki.poulose@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v5] coresight: etm4x: avoid build failure with unrolled
 loops
Thread-Topic: [PATCH v5] coresight: etm4x: avoid build failure with unrolled
 loops
Thread-Index: AQHYincR0e4J7NlfJEGYF+PtW5m5g61kkK8A
Date:   Tue, 28 Jun 2022 09:40:40 +0000
Message-ID: <bd4a9bad394b478f9ee0d9c0981948f8@AcuMS.aculab.com>
References: <17600de3-b295-ebdf-b9fa-323d2bc3cb93@arm.com>
 <20220623174131.3818333-1-ndesaulniers@google.com>
 <6b330119-fbf2-1c34-7ad3-0ae789658d22@arm.com>
In-Reply-To: <6b330119-fbf2-1c34-7ad3-0ae789658d22@arm.com>
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

Li4uDQo+ID4gUmVnYXJkbGVzcyBvZiB3aGljaCBjb21waWxlciBvciBjb21waWxlciBvcHRpb25z
IGRldGVybWluZSB3aGV0aGVyIGENCj4gPiBsb29wIGNhbiBvciBjYW4ndCBiZSB1bnJvbGxlZCwg
d2hpY2ggZGV0ZXJtaW5lcyB3aGV0aGVyDQo+ID4gX19idWlsdGluX2NvbnN0YW50X3AgZXZhbHVh
dGVzIHRvIHRydWUgd2hlbiBwYXNzZWQgYW4gZXhwcmVzc2lvbiB1c2luZyBhDQo+ID4gbG9vcCBp
bmR1Y3Rpb24gdmFyaWFibGUsIGl0IGlzIE5FVkVSIHNhZmUgdG8gYWxsb3cgdGhlIHByZXByb2Nl
c3NvciB0bw0KPiA+IGNvbnN0cnVjdCBpbmxpbmUgYXNtIGxpa2U6DQo+ID4gICAgYXNtIHZvbGF0
aWxlICgiLmluc3QgKDB4MTYwICsgKGkgKiA0KSkiIDogIj1yIihfX3ZhbCkpOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeIGV4cGVjdGVkIGNvbnN0YW50IGV4cHJlc3Np
b24NCg0KQ2FuJ3QgeW91IHVzZSAoSUlSQykgYW4gIj1pIiBjb25zdHJhaW50IHdpdGggdGhlIEMg
ZXhwcmVzc2lvbg0Kc28gdGhhdCB0aGUgY29tcGlsZXIgZXZhbHVhdGVzIHRoZSBleHByZXNzaW9u
IGFuZCBwYXNzZXMgdGhlDQpjb3JyZWN0IGNvbnN0YW50IHZhbHVlIHRvIHRoZSBhc3NlbWJsZXI/
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

