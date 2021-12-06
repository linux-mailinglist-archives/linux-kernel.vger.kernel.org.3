Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C27469154
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhLFITb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:19:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45134 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230001AbhLFIT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:19:27 -0500
X-UUID: 609d79adcd3f4cadbe01c5f4985a4d4f-20211206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Gwi9NQMi+aJlqofRC9/2Cdnnhql1ssg2h7PD3Qu6tws=;
        b=Z08QStxoNbqTiW1WRshvSqF8wGbc7Gv6bihg6mJxnWv1F1KZbkNuOgvRuOcHG0WnUAJHvmesy3d4QAGLM7KenLjfassalmT3Jwgi8OqjEfvDTzhZHRmThBWFjoCTJyp7dG1pOr5iHICqFILsgnnEK1raH/8tUBLYSgD6clsjZpI=;
X-UUID: 609d79adcd3f4cadbe01c5f4985a4d4f-20211206
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1785352478; Mon, 06 Dec 2021 16:15:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 6 Dec 2021 16:15:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Dec 2021 16:15:53 +0800
Message-ID: <303eaeb2d371c96def8e5f0284495b1762879905.camel@mediatek.com>
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <lc.kan@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
Date:   Mon, 6 Dec 2021 16:15:53 +0800
In-Reply-To: <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
         <20211203064027.14993-4-yong.wu@mediatek.com>
         <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTEyLTA0IGF0IDEyOjQ4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwMy8xMi8yMDIxIDA3OjQwLCBZb25nIFd1IHdyb3RlOg0KPiA+IHNsZWVwIGNv
bnRyb2wgbWVhbnMgdGhhdCB3aGVuIHRoZSBsYXJiIGdvIHRvIHNsZWVwLCB3ZSBzaG91bGQgd2Fp
dA0KPiA+IGEgYml0DQo+IA0KPiBzL2dvL2dvZXMvDQo+IA0KPiA+IHVudGlsIGFsbCB0aGUgY3Vy
cmVudCBjb21tYW5kcyBhcmUgZmluaXNoZWQuIHRodXMsIHdoZW4gdGhlIGxhcmINCj4gPiBydW50
aW1lDQo+IA0KPiBQbGVhc2Ugc3RhcnQgZXZlcnkgc2VudGVuY2Ugd2l0aCBhIGNhcGl0YWwgbGV0
dGVyLg0KPiANCj4gPiBzdXNwZW5kLCB3ZSBuZWVkIGVuYWJsZSB0aGlzIGZ1bmN0aW9uIHRvIHdh
aXQgdW50aWwgYWxsIHRoZSBleGlzdGVkDQo+IA0KPiBzL3N1c3BlbmQvc3VzcGVuZHMvDQo+IHMv
d2UgbmVlZCBlbmFibGUvd2UgbmVlZCB0byBlbmFibGUvDQo+IA0KPiA+IGNvbW1hbmQgYXJlIGZp
bmlzaGVkLiB3aGVuIHRoZSBsYXJiIHJlc3VtZSwganVzdCBkaXNhYmxlIHRoaXMNCj4gPiBmdW5j
dGlvbi4NCj4gDQo+IHMvY29tbWFuZC9jb21tYW5kcy8NCj4gcy9yZXN1bWUvcmVzdW1lcy8NCj4g
DQo+ID4gVGhpcyBmdW5jdGlvbiBvbmx5IGltcHJvdmUgdGhlIHNhZmUgb2YgYnVzLiBBZGQgYSBu
ZXcgZmxhZyBmb3IgdGhpcw0KPiANCj4gcy9pbXByb3ZlL2ltcHJvdmVzLw0KPiBzL3RoZSBzYWZl
L3RoZSBzYWZldHkvDQo+IA0KPiA+IGZ1bmN0aW9uLiBQcmVwYXJlIGZvciBtdDgxODYuDQo+IA0K
PiBJbiB0b3RhbCBpdCBpcyBoYXJkIHRvIHBhcnNlLCByZWFsbHkuDQoNCldpbGwgZml4IHRoZW0g
aW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MgZm9yIHJldmlld2luZyBzbyBkZXRhaWxlZGx5LiBT
b3JyeS4gSSBkaWRuJ3QgcGF5IGF0dGVudGlvbiB0bw0KdGhlIGdyYW1tYXIgYmVmb3JlLg0KDQo+
IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuYW4gU3VuIDxhbmFuLnN1bkBtZWRpYXRlay5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDM5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+IC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzUg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5k
ZXggYjg4M2RjYzBiYmZhLi40YjU5YjI4ZTRkNzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4g
QEAgLTgsNiArOCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZv
cm0uaD4NCj4gPiBAQCAtMzIsNiArMzMsMTAgQEANCj4gPiAgI2RlZmluZSBTTUlfRFVNTVkJCQkw
eDQ0NA0KPiA+ICANCj4gPiAgLyogU01JIExBUkIgKi8NCj4gPiArI2RlZmluZSBTTUlfTEFSQl9T
TFBfQ09OICAgICAgICAgICAgICAgIDB4MDBjDQo+ID4gKyNkZWZpbmUgU0xQX1BST1RfRU4gICAg
ICAgICAgICAgICAgICAgICBCSVQoMCkNCj4gPiArI2RlZmluZSBTTFBfUFJPVF9SRFkgICAgICAg
ICAgICAgICAgICAgIEJJVCgxNikNCj4gPiArDQo+ID4gICNkZWZpbmUgU01JX0xBUkJfQ01EX1RI
UlRfQ09OCQkweDI0DQo+ID4gICNkZWZpbmUgU01JX0xBUkJfVEhSVF9SRF9OVV9MTVRfTVNLCUdF
Tk1BU0soNywgNCkNCj4gPiAgI2RlZmluZSBTTUlfTEFSQl9USFJUX1JEX05VX0xNVAkJKDUgPDwg
NCkNCj4gPiBAQCAtODEsNiArODYsNyBAQA0KPiA+ICANCj4gPiAgI2RlZmluZSBNVEtfU01JX0ZM
QUdfVEhSVF9VUERBVEUJQklUKDApDQo+ID4gICNkZWZpbmUgTVRLX1NNSV9GTEFHX1NXX0ZMQUcJ
CUJJVCgxKQ0KPiA+ICsjZGVmaW5lIE1US19TTUlfRkxBR19TTEVFUF9DVEwJCUJJVCgyKQ0KPiA+
ICAjZGVmaW5lIE1US19TTUlfQ0FQUyhmbGFncywgX3gpCQkoISEoKGZsYWdzKSAmIChfeCkpKQ0K
PiA+ICANCj4gPiAgc3RydWN0IG10a19zbWlfcmVnX3BhaXIgew0KPiA+IEBAIC0zNzEsNiArMzc3
LDI0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gbXRrX3NtaV9sYXJi
X29mX2lkc1tdID0gew0KPiA+ICAJe30NCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQg
bXRrX3NtaV9sYXJiX3NsZWVwX2N0cmwoc3RydWN0IGRldmljZSAqZGV2LCBib29sDQo+ID4gdG9f
c2xlZXApDQo+ID4gK3sNCj4gDQo+IE1ha2UgdHdvIGZ1bmN0aW9ucyBpbnN0ZWFkLiBUaGVyZSBp
cyBubyBzaW5nbGUgY29kZSByZXVzZSAoc2hhcmVkKQ0KPiBiZXR3ZWVuIHNsZWVwIGFuZCByZXN1
bWUuIEluIHRoZSBzYW1lIHRpbWUgYm9vbCBhcmd1bWVudHMgYXJlDQo+IGNvbmZ1c2luZw0KPiB3
aGVuIGxvb2tpbmcgYXQgY2FsbGVyIGFuZCBvbmUgbmV2ZXIga25vd3Mgd2hldGhlciB0cnVlIG1l
YW5zIHRvDQo+IHJlc3VtZQ0KPiBvciB0byBzbGVlcC4gSGF2aW5nIHR3byBmdW5jdGlvbnMgaXMg
b2J2aW91cy4gT2J2aW91cyBjb2RlIGlzIGVhc2llcg0KPiB0bw0KPiByZWFkIGFuZCBtYWludGFp
bi4NCg0KTWFrZSBzZW5zZS4gVGhhbmtzIGZvciB0aGlzIHN1Z2dlc3Rpb24uDQoNCj4gDQo+ID4g
KwlzdHJ1Y3QgbXRrX3NtaV9sYXJiICpsYXJiID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4g
KwlpbnQgcmV0ID0gMDsNCj4gPiArCXUzMiB0bXA7DQo+ID4gKw0KPiA+ICsJaWYgKHRvX3NsZWVw
KSB7DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQoU0xQX1BST1RfRU4sIGxhcmItPmJhc2UgKw0KPiA+
IFNNSV9MQVJCX1NMUF9DT04pOw0KPiA+ICsJCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9t
aWMobGFyYi0+YmFzZSArDQo+ID4gU01JX0xBUkJfU0xQX0NPTiwNCj4gPiArCQkJCQkJdG1wLCAh
ISh0bXAgJg0KPiA+IFNMUF9QUk9UX1JEWSksIDEwLCAxMDAwKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlkZXZfd2FybihkZXYsICJzbGVlcCBjdHJsIGlzIG5vdA0KPiA+IHJlYWR5KDB4JXgp
LlxuIiwgdG1wKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQoMCwgbGFy
Yi0+YmFzZSArIFNNSV9MQVJCX1NMUF9DT04pOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIHJldDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdGtfc21pX2RldmljZV9saW5rX2NvbW1v
bihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiA+IGRldmljZSAqKmNvbV9kZXYpDQo+ID4g
IHsNCj4gPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnNtaV9jb21fcGRldjsNCj4gPiBAQCAt
NDc3LDI0ICs1MDEsMzEgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZA0KPiA+IG10a19zbWlf
bGFyYl9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXRr
X3NtaV9sYXJiICpsYXJiID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gIAljb25zdCBzdHJ1
Y3QgbXRrX3NtaV9sYXJiX2dlbiAqbGFyYl9nZW4gPSBsYXJiLT5sYXJiX2dlbjsNCj4gPiAtCWlu
dCByZXQ7DQo+ID4gKwlpbnQgcmV0ID0gMDsNCj4gDQo+IFRoaXMgbGluZSBkb2VzIG5vdCBoYXZl
IGEgc2Vuc2UuDQoNClllcy4gVGhpcyBpcyB1bmhlbHBmdWwuIFdpbGwgcmVtb3ZlIHRoaXMuDQoN
Cj4gDQo+ID4gIA0KPiA+ICAJcmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUobGFyYi0+c21p
LmNsa19udW0sIGxhcmItDQo+ID4gPnNtaS5jbGtzKTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0KPiA+
ICsJaWYgKHJldCkNCj4gDQo+IFdoeSBjaGFuZ2luZyB0aGlzPw0KDQpUaGUgc3VjY2Vzc2Z1bCBy
ZXR1cm4gdmFsdWUgc2hvdWxkIGJlIDAuIEkgd2lsbCB1c2UgYSBpbmRlcGVuZGVudCBwYXRjaA0K
Zm9yIHRoaXMuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRp
YXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlh
dGVrDQo=

