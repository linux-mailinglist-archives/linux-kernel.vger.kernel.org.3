Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389725AFEBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIGIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiIGIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:15:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129AB696F1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:15:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-134-kw6eLy3SNPqzMYl1nRW89A-1; Wed, 07 Sep 2022 09:15:23 +0100
X-MC-Unique: kw6eLy3SNPqzMYl1nRW89A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 09:15:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 7 Sep 2022 09:15:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Georgi Djakov' <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_okukatla@quicinc.com" <quic_okukatla@quicinc.com>
Subject: RE: [PATCH] interconnect: Replace mutex with rt_mutex
Thread-Topic: [PATCH] interconnect: Replace mutex with rt_mutex
Thread-Index: AQHYwox33+Dok3wYiESm8hf7cWD41K3TnN4g
Date:   Wed, 7 Sep 2022 08:15:21 +0000
Message-ID: <760fed2808aa46729eab9d0037d0904e@AcuMS.aculab.com>
References: <20220906191423.30109-1-quic_mdtipton@quicinc.com>
 <3c8965c0-3bc0-252e-381d-bd057fd02af5@kernel.org>
In-Reply-To: <3c8965c0-3bc0-252e-381d-bd057fd02af5@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2VvcmdpIERqYWtvdg0KPiBTZW50OiAwNyBTZXB0ZW1iZXIgMjAyMiAwODozNQ0KPiAN
Cj4gSGkgTWlrZSwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoIQ0KPiANCj4gT24gNi4wOS4y
MiAyMjoxNCwgTWlrZSBUaXB0b24gd3JvdGU6DQo+ID4gUmVwbGFjZSBtdXRleCB3aXRoIHJ0X211
dGV4IHRvIHByZXZlbnQgcHJpb3JpdHkgaW52ZXJzaW9uIGJldHdlZW4NCj4gPiBjbGllbnRzLCB3
aGljaCBjYW4gY2F1c2UgdW5hY2NlcHRhYmxlIGRlbGF5cyBpbiBzb21lIGNhc2VzLg0KPiANCj4g
SXQgd291bGQgYmUgbmljZSBpZiB5b3UgaGF2ZSBhbnkgbnVtYmVycyB0byBzaGFyZSBpbiB0aGUg
Y29tbWl0IHRleHQuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pa2UgVGlwdG9uIDxxdWljX21k
dGlwdG9uQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gV2UndmUgcnVuIGludG8gYSBu
dW1iZXIgb2YgY2FzZXMgaW50ZXJuYWxseSBhbmQgZnJvbSBjdXN0b21lcnMgd2hlcmUNCj4gPiBo
aWdoIHByaW9yaXR5LCBSVCBjbGllbnRzICh0eXBpY2FsbHkgZGlzcGxheSkgYmVjb21lIGJsb2Nr
ZWQgZm9yIGxvbmcNCj4gPiBwZXJpb2RzIG9mIHRpbWUgb24gbG93ZXIgcHJpb3JpdHksIG5vbi1S
VCBjbGllbnRzLiBTd2l0Y2hpbmcgdG8gcnRfbXV0ZXgNCj4gPiBoYXMgcHJvdmVuIHRvIGhlbHAg
cGVyZm9ybWFuY2UgaW4gdGhlc2UgY2FzZXMuDQo+IA0KPiBJIGFtIHdvbmRlcmluZyBpZiBhdm9p
ZGluZyB0aGUgaW52ZXJzaW9uIG9uIHRoaXMgc3BlY2lmaWMgbG9jayBpcyB0aGUgcmlnaHQNCj4g
c29sdXRpb24sIGFzIHRoZXJlIGNvdWxkIGJlIG90aGVyIGxvY2tzIHRoYXQgbWF5IGNhdXNlIHNp
bWlsYXIgaXNzdWVzLiBEbyB3ZQ0KPiBzZWUgc2ltaWxhciBpc3N1ZSB3aXRoIGNsb2NrcyBmb3Ig
ZXhhbXBsZSBvciBpcyBpdCBqdXN0IHdpdGggaW50ZXJjb25uZWN0cz8NCg0KTXkgdGhvdWdodHMg
ZXhhY3RseS4NCg0KQWx0aG91Z2ggSSd2ZSBub3QgdHJpZWQgdG8gdXNlIHRoZSBSVCBrZXJuZWwg
SSBoYXZlIHRyaWVkIHRvDQpnZXQgYSBoaWdobHkgdGhyZWFkZWQgUlQgKGF1ZGlvKSB1c2Vyc3Bh
Y2UgYXBwbGljYXRpb24gdG8NCnJ1biByZWxpYWJsZS4NCg0KVXNlcnNwYWNlIG9ubHkgaGFzIHNs
ZWVwIGxvY2tzIHNvIHlvdSBnZXQgYWxsIHRoZSBwcmlvcml0eQ0KaW52ZXJzaW9uIHByb2JsZW1z
Lg0KVGhpcyBiaWcgcHJvYmxlbXMgYXJpc2Ugd2l0aCBhIGhpZ2hseSBjb250ZW5kZWQgbG9jayB0
aGF0DQppcyBuZXZlciBoZWxkIGZvciB2ZXJ5IGxvbmcgLSBhIHByaW1lIGNhbmRpZGF0ZSBmb3Ig
c3BpbiBsb2NrLg0KSWYgYSBwcm9jZXNzIGlzIGV2ZW4gaW50ZXJydXB0ZWQgd2hpbGUgaG9sZGlu
ZyB0aGUgbG9jayB0aGUNCmVudGlyZSBhcHBsaWNhdGlvbiBzdG9wcy4NClRoZSBvbmx5IHdheSBJ
IGZvdW5kIHRvIGF2b2lkIHRoaXMgaXMgdG8gcmVwbGFjZSBhbGwgdGhlIGxvY2tpbmcNCndpdGgg
YXRvbWljIG9wZXJhdGlvbnMuDQoNCkkgY2FuJ3Qgc2VlIHdoeSB0aGUgUlQga2VybmVsIGRvZXNu
J3QgaGF2ZSBleGFjdGx5IHRoZSBzYW1lIGlzc3Vlcy4NCkdpdmVuIGhvdyBsb25nIGEgcHJvY2Vz
cyBzd2l0Y2ggdGFrZXMgSSByZWFsbHkgc3VzcGVjdCB0aGF0IG1vc3QNCnNwaW5sb2NrcyBzaG91
bGQgcmVtYWluIHNwaW5sb2Nrcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

