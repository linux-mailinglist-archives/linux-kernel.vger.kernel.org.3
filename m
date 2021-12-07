Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9823346BABA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhLGMNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:13:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57494 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231564AbhLGMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:13:51 -0500
X-UUID: 2c38ce735eed4c60bcca5a6138e31378-20211207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ErNc6dqMUUlRs4F4DGw4rb5Z4EkAGv9FuADQx2A/QOI=;
        b=btpGXCsJrm3RFLyfINGXPY4S3lGP6nXD+9i7XPgvqzoWdBK7LJsedhXpzz7s8fS+DabKRqBJbxkiD7Oqn+tiXmP+voh0DhiqOy59EI+To+w5fcCd+k0Ffp2ggdKcmmQEZXkoJtiO19IOyGf4cUk8sYPtw0GSGtl2yEynn89vGN8=;
X-UUID: 2c38ce735eed4c60bcca5a6138e31378-20211207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1172882727; Tue, 07 Dec 2021 20:10:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 7 Dec 2021 20:10:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 20:10:12 +0800
Message-ID: <e1d72db69f424b9ee8987b7bafa7423c672ceef1.camel@mediatek.com>
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
Date:   Tue, 7 Dec 2021 20:10:08 +0800
In-Reply-To: <47c30f6f-ce9d-9ea7-283c-9026ae9ed1c0@collabora.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
         <20211203064027.14993-4-yong.wu@mediatek.com>
         <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
         <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
         <47c30f6f-ce9d-9ea7-283c-9026ae9ed1c0@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTEyLTA3IGF0IDA5OjU2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDcvMTIvMjEgMDc6MjQsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBIaSBBbmdlbG9HaW9hY2NoaW5vLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcu
DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIxLTEyLTA2IGF0IDE2OjA4ICswMTAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMDMvMTIvMjEgMDc6NDAsIFlv
bmcgV3UgaGEgc2NyaXR0bzoNCj4gPiA+ID4gc2xlZXAgY29udHJvbCBtZWFucyB0aGF0IHdoZW4g
dGhlIGxhcmIgZ28gdG8gc2xlZXAsIHdlIHNob3VsZA0KPiA+ID4gPiB3YWl0DQo+ID4gPiA+IGEg
Yml0DQo+ID4gPiA+IHVudGlsIGFsbCB0aGUgY3VycmVudCBjb21tYW5kcyBhcmUgZmluaXNoZWQu
IHRodXMsIHdoZW4gdGhlDQo+ID4gPiA+IGxhcmINCj4gPiA+ID4gcnVudGltZQ0KPiA+ID4gPiBz
dXNwZW5kLCB3ZSBuZWVkIGVuYWJsZSB0aGlzIGZ1bmN0aW9uIHRvIHdhaXQgdW50aWwgYWxsIHRo
ZQ0KPiA+ID4gPiBleGlzdGVkDQo+ID4gPiA+IGNvbW1hbmQgYXJlIGZpbmlzaGVkLiB3aGVuIHRo
ZSBsYXJiIHJlc3VtZSwganVzdCBkaXNhYmxlIHRoaXMNCj4gPiA+ID4gZnVuY3Rpb24uDQo+ID4g
PiA+IFRoaXMgZnVuY3Rpb24gb25seSBpbXByb3ZlIHRoZSBzYWZlIG9mIGJ1cy4gQWRkIGEgbmV3
IGZsYWcgZm9yDQo+ID4gPiA+IHRoaXMNCj4gPiA+ID4gZnVuY3Rpb24uIFByZXBhcmUgZm9yIG10
ODE4Ni4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuYW4gU3VuIDxhbmFuLnN1
bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICAgZHJpdmVycy9tZW1vcnkvbXRr
LXNtaS5jIHwgMzkNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tDQo+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IFtzbmlwXQ0KPiA+IA0KPiA+ID4gPiAgICBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIG10a19zbWlfbGFyYl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gPiA+ID4g
KmRldikNCj4gPiA+ID4gICAgew0KPiA+ID4gPiAgICAJc3RydWN0IG10a19zbWlfbGFyYiAqbGFy
YiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ID4gPiArCWludCByZXQgPSAwOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJaWYgKE1US19TTUlfQ0FQUyhsYXJiLT5sYXJiX2dlbi0+ZmxhZ3NfZ2Vu
ZXJhbCwNCj4gPiA+ID4gTVRLX1NNSV9GTEFHX1NMRUVQX0NUTCkpDQo+ID4gPiA+ICsJCXJldCA9
IG10a19zbWlfbGFyYl9zbGVlcF9jdHJsKGRldiwgdHJ1ZSk7DQo+ID4gPiANCj4gPiA+IFNvcnJ5
IGJ1dCB3aGF0IGhhcHBlbnMgaWYgU0xQX1BST1RfUkRZIGlzIG5vdCBnZXR0aW5nIHNldA0KPiA+
ID4gcHJvcGVybHk/DQo+ID4gPiAgIEZyb20gd2hhdCBJIGNhbiB1bmRlcnN0YW5kIGluIHRoZSBj
b21taXQgZGVzY3JpcHRpb24gdGhhdCB5b3UNCj4gPiA+IHdyb3RlLA0KPiA+ID4gaWYgd2UgcmVh
Y2gNCj4gPiA+IHRoZSB0aW1lb3V0LCB0aGVuIHRoZSBMQVJCIHRyYW5zYWN0aW9ucyBhcmUgbm90
IG92ZXIuLi4uDQo+ID4gPiANCj4gPiA+IEkgc2VlIHRoYXQgeW91IGFyZSBpbmRlZWQgcmV0dXJu
aW5nIGEgZmFpbHVyZSBoZXJlLCBidXQgeW91IGFyZQ0KPiA+ID4gYWxzbw0KPiA+ID4gdHVybmlu
ZyBvZmYNCj4gPiA+IHRoZSBjbG9ja3MgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHdlIGdldCBhIGZh
aWx1cmUgb3IgYSBzdWNjZXNzOw0KPiA+ID4gSSdtDQo+ID4gPiBub3Qgc3VyZSB0aGF0DQo+ID4g
PiB0aGlzIGlzIHJpZ2h0LCBhcyB0aGlzIG1heSBsZWF2ZSB0aGUgaGFyZHdhcmUgaW4gYW4gdW5w
cmVkaWN0YWJsZQ0KPiA+ID4gc3RhdGUgKHNpbmNlDQo+ID4gPiB0aGVyZSB3ZXJlIHNvbWUgbW9y
ZSBMQVJCIHRyYW5zYWN0aW9ucyB0aGF0IGRpZG4ndCBnbyB0aHJvdWdoKSwNCj4gPiA+IGxlYWRp
bmcgdG8gY3Jhc2hlcw0KPiA+ID4gYXQgc3lzdGVtIHJlc3VtZSAob3Igd2hlbiByZXR5cmluZyB0
byBzdXNwZW5kKS4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHRoaXMgcXVlc3Rpb24uIEluIHRoZW9y
eSB5b3UgYXJlIHJpZ2h0LiBJbiB0aGlzIGNhc2UsDQo+ID4gdGhlDQo+ID4gYnVzIGFscmVhZHkg
aGFuZy4NCj4gPiANCj4gPiBXZSBvbmx5IHByaW50ZWQgYSBmYWlsIGxvZyBpbiB0aGlzIHBhdGNo
LiBJZiB0aGlzIGZhaWwgaGFwcGVucywgd2UNCj4gPiBzaG91bGQgcmVxdWVzdCB0aGUgbWFzdGVy
IHRvIGNoZWNrIHdoaWNoIGNhc2UgY2F1c2UgdGhlIGxhcmIgaGFuZy4NCj4gPiANCj4gPiBJZiB0
aGUgbWFzdGVyIGhhcyBhIGdvb2QgcmVhc29uIG9yIGxpbWl0YXRpb24sIHRoZSBoYW5nIGlzDQo+
ID4gZXhwZWN0ZWQsIEkNCj4gPiB0aGluayB3ZSBoYXZlIHRvIGFkZCBsYXJiIHJlc2V0IGluIHRo
aXMgZmFpbCBjYXNlOiBSZXNldCB0aGUgbGFyYg0KPiA+IHdoZW4NCj4gPiB0aGUgbGFyYiBydW50
aW1lIHJlc3VtZS4NCj4gPiANCj4gDQo+IFRoaW5rIGFib3V0IHRoZSBjYXNlIGluIHdoaWNoIHRo
ZSBzeXN0ZW0gZ2V0cyByZXN1bWVkIG9ubHkgcGFydGlhbGx5DQo+IGR1ZSB0byBhDQo+IA0KPiBm
YWlsdXJlIGR1cmluZyByZXN1bWUgb2Ygc29tZSBkcml2ZXIsIG9yIGR1ZSB0byBhIFJUQyBvciBh
cmNoIHRpbWVyDQo+IHJlc3VtZSBhbmQNCj4gc3VzcGVuZCByaWdodCBhZnRlci4uLiBvciBwZXJo
YXBzIGR1cmluZyBydW50aW1lIHN1c3BlbmQvcmVzdW1lIG9mDQo+IHNvbWUgZGV2aWNlcy4NCj4g
SW4gdGhhdCBjYXNlLCB3ZSBkZWZpbml0ZWx5IHdhbnQgdG8gYXZvaWQgYW55IGtpbmQgb2YgZmFp
bHVyZSBwb2ludA0KPiB0aGF0IHdvdWxkDQo+IGxlYWQgdG8gYSBzeXN0ZW0gY3Jhc2gsIG9yIGFu
eSBraW5kIG9mIHVzZXIgbm90aWNlYWJsZSAob3IgVVgNCj4gZGlzcnVwdGluZykgInN0cmFuZ2UN
Cj4gYmVoYXZpb3IiLg0KPiANCj4gSSB0aGluayB0aGF0IHdlIHNob3VsZCBtYWtlIHN1cmUgdGhh
dCB0aGUgc3lzdGVtIHN1c3BlbmRzIGNsZWFubHksDQo+IGluc3RlYWQgb2YNCj4gcGF0Y2hpbmcg
dXAgYW55IHBvc3NpYmxlIGxlZnRvdmVyIGlzc3VlIGF0IHJlc3VtZSB0aW1lOiBpZiB0aGlzIGlz
DQo+IGRvYWJsZSB3aXRoDQo+IGEgTEFSQiByZXNldCBpbiBzdXNwZW5kIGVycm9yIGNhc2UsIHRo
YXQgbG9va3MgbGlrZSBiZWluZyBhIGdvb2QNCj4gb3B0aW9uIGluZGVlZC4NCj4gDQo+IEFzIGEg
c2lkZSBub3RlLCB0aGlua2luZyBhYm91dCBVWCwgbG9zaW5nIGEgbGl0dGxlIG1vcmUgdGltZSBk
dXJpbmcNCj4gc3VzcGVuZCBpcw0KPiBub3RoaW5nIHJlYWxseSBub3RpY2VhYmxlIGZvciB0aGUg
dXNlci4uLiBvbiB0aGUgb3RoZXIgaGFuZCwgc3BlbmRpbmcNCj4gbW9yZSB0aW1lDQo+IGR1cmlu
ZyByZXN1bWUgbWF5IGJlIHNvbWV0aGluZyBub3RpY2VhYmxlIHRvIHRoZSB1c2VyLg0KPiBGb3Ig
dGhpcyByZWFzb24sIEkgdGhpbmsgdGhhdCBndWFyYW50ZWVpbmcgdGhhdCB0aGUgc3lzdGVtIHJl
c3VtZXMgYXMNCj4gZmFzdCBhcw0KPiBwb3NzaWJsZSBpcyB2ZXJ5IGltcG9ydGFudCwgd2hpY2gg
YWRkcyB1cCB0byB0aGUgbmVlZCBvZiBzdXNwZW5kaW5nDQo+IGNsZWFubHkuDQoNClRoYW5rcyBm
b3IgdGhpcyBjb21tZW50LiBJIHdpbGwgcHV0IGl0IGluIHRoZSBzdXNwZW5kIHdoZW4gYWRkaW5n
IHRoZQ0KcmVzZXQuIEJ1dCBJIGhhdmUgbm8gcGxhbiB0byBhZGQgaXQgaW4gdGhpcyB2ZXJzaW9u
IHNpbmNlIEkgZG9uJ3Qgc2VlDQp0aGUgbmVlZCBmb3IgdGhpcyByaWdodCBub3cuIE1heWJlIEkg
c2hvdWxkIGFkZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUNCmZvciB0aGlzLg0KDQo+IA0KPiA+IEZv
cnR1bmF0ZWx5LCB3ZSBoYXZlIG5ldmVyIGdvdCB0aGlzIGlzc3VlLiBXZSBjb3VsZCBhZGQgdGhp
cyByZXNldA0KPiA+IHdoZW4NCj4gPiBuZWNlc3NhcnkuIElzIHRoaXMgT0sgZm9yIHlvdT8NCj4g
PiANCj4gPiBUaGFua3MuDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIAlj
bGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShsYXJiLT5zbWkuY2xrX251bSwgbGFyYi0NCj4gPiA+
ID4gPnNtaS5jbGtzKTsNCj4gPiA+ID4gLQlyZXR1cm4gMDsNCj4gPiA+ID4gKwlyZXR1cm4gcmV0
Ow0KPiA+ID4gPiAgICB9DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiAgICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgc21pX2xhcmJfcG1fb3BzID0gew0KPiA+ID4gPiANCj4gPiA+IA0KPiA+
ID4gDQo+IA0KPiANCg==

