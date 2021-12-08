Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6529F46CAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhLHCqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:46:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233825AbhLHCqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:46:18 -0500
X-UUID: 47673cb92a834b3582ee9b1b27660b6f-20211208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4JAxauduVQ8yA1sTjjPd8IjqzkeB2Li6o0fP33s9P3Q=;
        b=SOxo7LLXXjX9l6dCzZpK+gNdLBkX5cxmNd05ygg4Hq0Za2vgH3pak/7Hk3OJ7NK9FJgkmj/9CELmgwxVle2/wJHNV5LGoI0Z1zw3V2QCA65L5irbwiWByeZo2Z7d2C53wO7vlUPjqr04Xu2FnlESfIyrzydnOlcciij7+zd+170=;
X-UUID: 47673cb92a834b3582ee9b1b27660b6f-20211208
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820108748; Wed, 08 Dec 2021 10:42:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 8 Dec 2021 10:42:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Dec 2021 10:42:41 +0800
Message-ID: <581d847ede5ce917762e2c5734e23dcd693fef32.camel@mediatek.com>
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
Date:   Wed, 8 Dec 2021 10:42:36 +0800
In-Reply-To: <85ef182a-8ebe-7dbb-aa95-35e77cbb072c@collabora.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
         <20211203064027.14993-4-yong.wu@mediatek.com>
         <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
         <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
         <47c30f6f-ce9d-9ea7-283c-9026ae9ed1c0@collabora.com>
         <e1d72db69f424b9ee8987b7bafa7423c672ceef1.camel@mediatek.com>
         <85ef182a-8ebe-7dbb-aa95-35e77cbb072c@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTEyLTA3IGF0IDEzOjE2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDcvMTIvMjEgMTM6MTAsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBPbiBUdWUsIDIwMjEtMTItMDcgYXQgMDk6NTYgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vDQo+ID4gd3JvdGU6DQo+ID4gPiBJbCAwNy8xMi8yMSAwNzoyNCwgWW9uZyBXdSBoYSBz
Y3JpdHRvOg0KPiA+ID4gPiBIaSBBbmdlbG9HaW9hY2NoaW5vLA0KPiA+ID4gPiANCj4gPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgMjAyMS0x
Mi0wNiBhdCAxNjowOCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gSWwgMDMvMTIvMjEgMDc6NDAsIFlvbmcgV3UgaGEgc2NyaXR0bzoN
Cj4gPiA+ID4gPiA+IHNsZWVwIGNvbnRyb2wgbWVhbnMgdGhhdCB3aGVuIHRoZSBsYXJiIGdvIHRv
IHNsZWVwLCB3ZQ0KPiA+ID4gPiA+ID4gc2hvdWxkDQo+ID4gPiA+ID4gPiB3YWl0DQo+ID4gPiA+
ID4gPiBhIGJpdA0KPiA+ID4gPiA+ID4gdW50aWwgYWxsIHRoZSBjdXJyZW50IGNvbW1hbmRzIGFy
ZSBmaW5pc2hlZC4gdGh1cywgd2hlbiB0aGUNCj4gPiA+ID4gPiA+IGxhcmINCj4gPiA+ID4gPiA+
IHJ1bnRpbWUNCj4gPiA+ID4gPiA+IHN1c3BlbmQsIHdlIG5lZWQgZW5hYmxlIHRoaXMgZnVuY3Rp
b24gdG8gd2FpdCB1bnRpbCBhbGwgdGhlDQo+ID4gPiA+ID4gPiBleGlzdGVkDQo+ID4gPiA+ID4g
PiBjb21tYW5kIGFyZSBmaW5pc2hlZC4gd2hlbiB0aGUgbGFyYiByZXN1bWUsIGp1c3QgZGlzYWJs
ZQ0KPiA+ID4gPiA+ID4gdGhpcw0KPiA+ID4gPiA+ID4gZnVuY3Rpb24uDQo+ID4gPiA+ID4gPiBU
aGlzIGZ1bmN0aW9uIG9ubHkgaW1wcm92ZSB0aGUgc2FmZSBvZiBidXMuIEFkZCBhIG5ldyBmbGFn
DQo+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiA+IGZ1bmN0aW9u
LiBQcmVwYXJlIGZvciBtdDgxODYuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuYW4gU3VuIDxhbmFuLnN1bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDM5DQo+ID4gPiA+
ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiA+ID4gPiA+
ICAgICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gDQo+ID4gPiA+IFtzbmlwXQ0KPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgICBzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIG10a19zbWlfbGFyYl9zdXNwZW5kKHN0cnVjdA0KPiA+ID4gPiA+
ID4gZGV2aWNlDQo+ID4gPiA+ID4gPiAqZGV2KQ0KPiA+ID4gPiA+ID4gICAgIHsNCj4gPiA+ID4g
PiA+ICAgICAJc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYiA9DQo+ID4gPiA+ID4gPiBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gPiA+ID4gPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiArCWlmIChNVEtfU01JX0NBUFMobGFyYi0+bGFyYl9nZW4tPmZsYWdzX2dl
bmVyYWwsDQo+ID4gPiA+ID4gPiBNVEtfU01JX0ZMQUdfU0xFRVBfQ1RMKSkNCj4gPiA+ID4gPiA+
ICsJCXJldCA9IG10a19zbWlfbGFyYl9zbGVlcF9jdHJsKGRldiwgdHJ1ZSk7DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gU29ycnkgYnV0IHdoYXQgaGFwcGVucyBpZiBTTFBfUFJPVF9SRFkgaXMgbm90
IGdldHRpbmcgc2V0DQo+ID4gPiA+ID4gcHJvcGVybHk/DQo+ID4gPiA+ID4gICAgRnJvbSB3aGF0
IEkgY2FuIHVuZGVyc3RhbmQgaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiB0aGF0DQo+ID4gPiA+
ID4geW91DQo+ID4gPiA+ID4gd3JvdGUsDQo+ID4gPiA+ID4gaWYgd2UgcmVhY2gNCj4gPiA+ID4g
PiB0aGUgdGltZW91dCwgdGhlbiB0aGUgTEFSQiB0cmFuc2FjdGlvbnMgYXJlIG5vdCBvdmVyLi4u
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgc2VlIHRoYXQgeW91IGFyZSBpbmRlZWQgcmV0dXJu
aW5nIGEgZmFpbHVyZSBoZXJlLCBidXQgeW91DQo+ID4gPiA+ID4gYXJlDQo+ID4gPiA+ID4gYWxz
bw0KPiA+ID4gPiA+IHR1cm5pbmcgb2ZmDQo+ID4gPiA+ID4gdGhlIGNsb2NrcyByZWdhcmRsZXNz
IG9mIHdoZXRoZXIgd2UgZ2V0IGEgZmFpbHVyZSBvciBhDQo+ID4gPiA+ID4gc3VjY2VzczsNCj4g
PiA+ID4gPiBJJ20NCj4gPiA+ID4gPiBub3Qgc3VyZSB0aGF0DQo+ID4gPiA+ID4gdGhpcyBpcyBy
aWdodCwgYXMgdGhpcyBtYXkgbGVhdmUgdGhlIGhhcmR3YXJlIGluIGFuDQo+ID4gPiA+ID4gdW5w
cmVkaWN0YWJsZQ0KPiA+ID4gPiA+IHN0YXRlIChzaW5jZQ0KPiA+ID4gPiA+IHRoZXJlIHdlcmUg
c29tZSBtb3JlIExBUkIgdHJhbnNhY3Rpb25zIHRoYXQgZGlkbid0IGdvDQo+ID4gPiA+ID4gdGhy
b3VnaCksDQo+ID4gPiA+ID4gbGVhZGluZyB0byBjcmFzaGVzDQo+ID4gPiA+ID4gYXQgc3lzdGVt
IHJlc3VtZSAob3Igd2hlbiByZXR5cmluZyB0byBzdXNwZW5kKS4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYW5rcyBmb3IgdGhpcyBxdWVzdGlvbi4gSW4gdGhlb3J5IHlvdSBhcmUgcmlnaHQuIEluIHRo
aXMNCj4gPiA+ID4gY2FzZSwNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGJ1cyBhbHJlYWR5IGhhbmcu
DQo+ID4gPiA+IA0KPiA+ID4gPiBXZSBvbmx5IHByaW50ZWQgYSBmYWlsIGxvZyBpbiB0aGlzIHBh
dGNoLiBJZiB0aGlzIGZhaWwgaGFwcGVucywNCj4gPiA+ID4gd2UNCj4gPiA+ID4gc2hvdWxkIHJl
cXVlc3QgdGhlIG1hc3RlciB0byBjaGVjayB3aGljaCBjYXNlIGNhdXNlIHRoZSBsYXJiDQo+ID4g
PiA+IGhhbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBJZiB0aGUgbWFzdGVyIGhhcyBhIGdvb2QgcmVh
c29uIG9yIGxpbWl0YXRpb24sIHRoZSBoYW5nIGlzDQo+ID4gPiA+IGV4cGVjdGVkLCBJDQo+ID4g
PiA+IHRoaW5rIHdlIGhhdmUgdG8gYWRkIGxhcmIgcmVzZXQgaW4gdGhpcyBmYWlsIGNhc2U6IFJl
c2V0IHRoZQ0KPiA+ID4gPiBsYXJiDQo+ID4gPiA+IHdoZW4NCj4gPiA+ID4gdGhlIGxhcmIgcnVu
dGltZSByZXN1bWUuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGluayBhYm91dCB0aGUgY2Fz
ZSBpbiB3aGljaCB0aGUgc3lzdGVtIGdldHMgcmVzdW1lZCBvbmx5DQo+ID4gPiBwYXJ0aWFsbHkN
Cj4gPiA+IGR1ZSB0byBhDQo+ID4gPiANCj4gPiA+IGZhaWx1cmUgZHVyaW5nIHJlc3VtZSBvZiBz
b21lIGRyaXZlciwgb3IgZHVlIHRvIGEgUlRDIG9yIGFyY2gNCj4gPiA+IHRpbWVyDQo+ID4gPiBy
ZXN1bWUgYW5kDQo+ID4gPiBzdXNwZW5kIHJpZ2h0IGFmdGVyLi4uIG9yIHBlcmhhcHMgZHVyaW5n
IHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUNCj4gPiA+IG9mDQo+ID4gPiBzb21lIGRldmljZXMuDQo+
ID4gPiBJbiB0aGF0IGNhc2UsIHdlIGRlZmluaXRlbHkgd2FudCB0byBhdm9pZCBhbnkga2luZCBv
ZiBmYWlsdXJlDQo+ID4gPiBwb2ludA0KPiA+ID4gdGhhdCB3b3VsZA0KPiA+ID4gbGVhZCB0byBh
IHN5c3RlbSBjcmFzaCwgb3IgYW55IGtpbmQgb2YgdXNlciBub3RpY2VhYmxlIChvciBVWA0KPiA+
ID4gZGlzcnVwdGluZykgInN0cmFuZ2UNCj4gPiA+IGJlaGF2aW9yIi4NCj4gPiA+IA0KPiA+ID4g
SSB0aGluayB0aGF0IHdlIHNob3VsZCBtYWtlIHN1cmUgdGhhdCB0aGUgc3lzdGVtIHN1c3BlbmRz
DQo+ID4gPiBjbGVhbmx5LA0KPiA+ID4gaW5zdGVhZCBvZg0KPiA+ID4gcGF0Y2hpbmcgdXAgYW55
IHBvc3NpYmxlIGxlZnRvdmVyIGlzc3VlIGF0IHJlc3VtZSB0aW1lOiBpZiB0aGlzDQo+ID4gPiBp
cw0KPiA+ID4gZG9hYmxlIHdpdGgNCj4gPiA+IGEgTEFSQiByZXNldCBpbiBzdXNwZW5kIGVycm9y
IGNhc2UsIHRoYXQgbG9va3MgbGlrZSBiZWluZyBhIGdvb2QNCj4gPiA+IG9wdGlvbiBpbmRlZWQu
DQo+ID4gPiANCj4gPiA+IEFzIGEgc2lkZSBub3RlLCB0aGlua2luZyBhYm91dCBVWCwgbG9zaW5n
IGEgbGl0dGxlIG1vcmUgdGltZQ0KPiA+ID4gZHVyaW5nDQo+ID4gPiBzdXNwZW5kIGlzDQo+ID4g
PiBub3RoaW5nIHJlYWxseSBub3RpY2VhYmxlIGZvciB0aGUgdXNlci4uLiBvbiB0aGUgb3RoZXIg
aGFuZCwNCj4gPiA+IHNwZW5kaW5nDQo+ID4gPiBtb3JlIHRpbWUNCj4gPiA+IGR1cmluZyByZXN1
bWUgbWF5IGJlIHNvbWV0aGluZyBub3RpY2VhYmxlIHRvIHRoZSB1c2VyLg0KPiA+ID4gRm9yIHRo
aXMgcmVhc29uLCBJIHRoaW5rIHRoYXQgZ3VhcmFudGVlaW5nIHRoYXQgdGhlIHN5c3RlbQ0KPiA+
ID4gcmVzdW1lcyBhcw0KPiA+ID4gZmFzdCBhcw0KPiA+ID4gcG9zc2libGUgaXMgdmVyeSBpbXBv
cnRhbnQsIHdoaWNoIGFkZHMgdXAgdG8gdGhlIG5lZWQgb2YNCj4gPiA+IHN1c3BlbmRpbmcNCj4g
PiA+IGNsZWFubHkuDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGlzIGNvbW1lbnQuIEkgd2lsbCBw
dXQgaXQgaW4gdGhlIHN1c3BlbmQgd2hlbiBhZGRpbmcNCj4gPiB0aGUNCj4gPiByZXNldC4gQnV0
IEkgaGF2ZSBubyBwbGFuIHRvIGFkZCBpdCBpbiB0aGlzIHZlcnNpb24gc2luY2UgSSBkb24ndA0K
PiA+IHNlZQ0KPiA+IHRoZSBuZWVkIGZvciB0aGlzIHJpZ2h0IG5vdy4gTWF5YmUgSSBzaG91bGQg
YWRkIGEgY29tbWVudCBpbiB0aGUNCj4gPiBjb2RlDQo+ID4gZm9yIHRoaXMuDQo+ID4gDQo+IA0K
PiBXaGF0IEkgdW5kZXJzdGFuZCBmcm9tIHlvdXIgcmVwbHkgaXMgdGhhdCB0aGUgcmVzZXQgaXMg
bm90IHRyaXZpYWwNCj4gd29yaw0KDQpZZXMuIHRoZSByZXNldCBiaXQgaXMgaW4gZGlmZmVyZW50
IHJlZ2lzdGVyIHJlZ2lvbnMsIGxpa2UgbW1zeXMsDQp2ZGVjc3lzLiBCdXQgdGhlIG1haW4gcHJv
YmxlbSBpcyB0aGF0IEkgZG9uJ3Qgc2VlIHdoeSB3ZSBuZWVkIHRoYXQuIFdlDQpuZXZlciB0aGF0
IHByb2JsZW0uDQoNClRoZSBzbGVlcCBjdHJsIGZ1bmN0aW9uIGlzIGp1c3QgZm9yIHRoZSBzYWZl
dHkgb2YgdGhlIGJ1cy4gSWYgd2UgaGF2ZQ0Kbm90IGl0LCBJdCBhbHNvIHNob3VsZCBiZSBvay4u
LklmIG5vdCwgdGhlIHF1ZXN0aW9uIGlzOiB3aHkgZG9lcyB0aGUNCmxhcmIgbWFzdGVyIGRldmlj
ZSBjYWxsIHBtX3J1bnRpbWVfcHV0IGJlZm9yZSBoaXMgSFcgZmluaXNoIHRoZSBqb2I/DQoNCj4g
YW5kIG5lZWRzIHF1aXRlIHNvbWUgdGltZSB0byBiZSBkb25lIHByb3Blcmx5OyBpbiB0aGF0IGNh
c2U6IHllcywNCj4gcGxlYXNlDQo+IGFkZCBhIFRPRE8gY29tbWVudCB0aGF0IGV4cGxhaW5zIHRo
ZSBzaXR1YXRpb24gYW5kIHRoZSBkaXNjdXNzZWQNCj4gc29sdXRpb24uDQo+IA0KPiBBbHNvLCBz
aW5jZSB0aGlzIFNMUF9QUk9UX1JEWSBmbGFnIHNlZW1zIHRvIGJlIHZlcnkgbmljZSwganVzdCBh
DQo+IHNpbXBsZSBxdWVzdGlvbjogaXMgdGhpcyBhIG5ldyBmZWF0dXJlIGluIHRoZSBTTUkgSVAg
b2YgTVQ4MTg2LCBvciBpcw0KPiB0aGVyZSBhbnl0aGluZyBzaW1pbGFyIHRoYXQgd2UgbWF5IHVz
ZSBvbiBvdGhlciBTb0NzLCBsaWtlIDgxODMsDQo+IDgxOTIsIDgxOTUsIGFzIGEgZm9sbG93LXVw
IG9mIHRoaXMgc2VyaWVzPw0KDQpBbGwgdGhlIHRocmVlIFNvQyBzdXBwb3J0IHRoaXMgZnVuY3Rp
b24uIEkgZXhwZWN0IHRoZSBsYXRlciBTb0Mgd2lsbA0Kc3VwcG9ydCB0aGlzLiBidXQgdGhlIHBy
ZXZpb3VzIFNvQyBoYXMgYWxyZWFkeSBNUC4uLiBJZiBzb21lb25lIGhhcw0KYWxyZWFkeSB0ZXN0
ZWQgb2sgYWZ0ZXIgYWRkaW5nIGl0IGZvciB0aGUgcHJldmlvdXMgU29DLCBJJ20gb2sgb2YNCmNv
dXJzZS4NCg0KPiANCj4gPiA+IA0KPiA+ID4gPiBGb3J0dW5hdGVseSwgd2UgaGF2ZSBuZXZlciBn
b3QgdGhpcyBpc3N1ZS4gV2UgY291bGQgYWRkIHRoaXMNCj4gPiA+ID4gcmVzZXQNCj4gPiA+ID4g
d2hlbg0KPiA+ID4gPiBuZWNlc3NhcnkuIElzIHRoaXMgT0sgZm9yIHlvdT8NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoYW5rcy4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgDQo+
ID4gPiA+ID4gPiAgICAgCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKGxhcmItPnNtaS5jbGtf
bnVtLA0KPiA+ID4gPiA+ID4gbGFyYi0NCj4gPiA+ID4gPiA+ID4gc21pLmNsa3MpOw0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiAtCXJldHVybiAwOw0KPiA+ID4gPiA+ID4gKwlyZXR1cm4gcmV0
Ow0KPiA+ID4gPiA+ID4gICAgIH0NCj4gPiA+ID4gPiA+ICAgICANCj4gPiA+ID4gPiA+ICAgICBz
dGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgc21pX2xhcmJfcG1fb3BzID0gew0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiANCj4gDQo=

