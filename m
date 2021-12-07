Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1E46B2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhLGG1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:27:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38844 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230027AbhLGG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:27:46 -0500
X-UUID: 5b912bf4d72b42b99a20f911787d68db-20211207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=69qaWgeCtoVl4LXqKx5dxuVaxCCi/f31QLGTc1pclR4=;
        b=bh+PSfggMCrFYUQ7aMLMZc15Or4sTaulKL1h3Qh8Wt3CQGEMuch3SpQMM0vqfcFLIZ/ndKQZifD4THRj79MXMrZadgyXth5dMu+xYCCCDta4ZD40bBuD/zTKmnXcbrIBL3u7lgJ1OTKfwgyi9lbFe5+SRtWVq49UkmKcWEBhneg=;
X-UUID: 5b912bf4d72b42b99a20f911787d68db-20211207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 281838797; Tue, 07 Dec 2021 14:24:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 7 Dec 2021 14:24:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 14:24:11 +0800
Message-ID: <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
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
Date:   Tue, 7 Dec 2021 14:24:07 +0800
In-Reply-To: <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
         <20211203064027.14993-4-yong.wu@mediatek.com>
         <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gTW9u
LCAyMDIxLTEyLTA2IGF0IDE2OjA4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3
cm90ZToNCj4gSWwgMDMvMTIvMjEgMDc6NDAsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4gPiBzbGVl
cCBjb250cm9sIG1lYW5zIHRoYXQgd2hlbiB0aGUgbGFyYiBnbyB0byBzbGVlcCwgd2Ugc2hvdWxk
IHdhaXQNCj4gPiBhIGJpdA0KPiA+IHVudGlsIGFsbCB0aGUgY3VycmVudCBjb21tYW5kcyBhcmUg
ZmluaXNoZWQuIHRodXMsIHdoZW4gdGhlIGxhcmINCj4gPiBydW50aW1lDQo+ID4gc3VzcGVuZCwg
d2UgbmVlZCBlbmFibGUgdGhpcyBmdW5jdGlvbiB0byB3YWl0IHVudGlsIGFsbCB0aGUgZXhpc3Rl
ZA0KPiA+IGNvbW1hbmQgYXJlIGZpbmlzaGVkLiB3aGVuIHRoZSBsYXJiIHJlc3VtZSwganVzdCBk
aXNhYmxlIHRoaXMNCj4gPiBmdW5jdGlvbi4NCj4gPiBUaGlzIGZ1bmN0aW9uIG9ubHkgaW1wcm92
ZSB0aGUgc2FmZSBvZiBidXMuIEFkZCBhIG5ldyBmbGFnIGZvciB0aGlzDQo+ID4gZnVuY3Rpb24u
IFByZXBhcmUgZm9yIG10ODE4Ni4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmFuIFN1biA8
YW5hbi5zdW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
IHwgMzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpbc25p
cF0NCg0KPiA+ICAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfc21pX2xhcmJfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX3Nt
aV9sYXJiICpsYXJiID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlpbnQgcmV0ID0gMDsN
Cj4gPiArDQo+ID4gKwlpZiAoTVRLX1NNSV9DQVBTKGxhcmItPmxhcmJfZ2VuLT5mbGFnc19nZW5l
cmFsLA0KPiA+IE1US19TTUlfRkxBR19TTEVFUF9DVEwpKQ0KPiA+ICsJCXJldCA9IG10a19zbWlf
bGFyYl9zbGVlcF9jdHJsKGRldiwgdHJ1ZSk7DQo+IA0KPiBTb3JyeSBidXQgd2hhdCBoYXBwZW5z
IGlmIFNMUF9QUk9UX1JEWSBpcyBub3QgZ2V0dGluZyBzZXQgcHJvcGVybHk/DQo+ICBGcm9tIHdo
YXQgSSBjYW4gdW5kZXJzdGFuZCBpbiB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIHRoYXQgeW91IHdy
b3RlLA0KPiBpZiB3ZSByZWFjaA0KPiB0aGUgdGltZW91dCwgdGhlbiB0aGUgTEFSQiB0cmFuc2Fj
dGlvbnMgYXJlIG5vdCBvdmVyLi4uLg0KPiANCj4gSSBzZWUgdGhhdCB5b3UgYXJlIGluZGVlZCBy
ZXR1cm5pbmcgYSBmYWlsdXJlIGhlcmUsIGJ1dCB5b3UgYXJlIGFsc28NCj4gdHVybmluZyBvZmYN
Cj4gdGhlIGNsb2NrcyByZWdhcmRsZXNzIG9mIHdoZXRoZXIgd2UgZ2V0IGEgZmFpbHVyZSBvciBh
IHN1Y2Nlc3M7IEknbQ0KPiBub3Qgc3VyZSB0aGF0DQo+IHRoaXMgaXMgcmlnaHQsIGFzIHRoaXMg
bWF5IGxlYXZlIHRoZSBoYXJkd2FyZSBpbiBhbiB1bnByZWRpY3RhYmxlDQo+IHN0YXRlIChzaW5j
ZQ0KPiB0aGVyZSB3ZXJlIHNvbWUgbW9yZSBMQVJCIHRyYW5zYWN0aW9ucyB0aGF0IGRpZG4ndCBn
byB0aHJvdWdoKSwNCj4gbGVhZGluZyB0byBjcmFzaGVzDQo+IGF0IHN5c3RlbSByZXN1bWUgKG9y
IHdoZW4gcmV0eXJpbmcgdG8gc3VzcGVuZCkuDQoNClRoYW5rcyBmb3IgdGhpcyBxdWVzdGlvbi4g
SW4gdGhlb3J5IHlvdSBhcmUgcmlnaHQuIEluIHRoaXMgY2FzZSwgdGhlDQpidXMgYWxyZWFkeSBo
YW5nLg0KDQpXZSBvbmx5IHByaW50ZWQgYSBmYWlsIGxvZyBpbiB0aGlzIHBhdGNoLiBJZiB0aGlz
IGZhaWwgaGFwcGVucywgd2UNCnNob3VsZCByZXF1ZXN0IHRoZSBtYXN0ZXIgdG8gY2hlY2sgd2hp
Y2ggY2FzZSBjYXVzZSB0aGUgbGFyYiBoYW5nLg0KDQpJZiB0aGUgbWFzdGVyIGhhcyBhIGdvb2Qg
cmVhc29uIG9yIGxpbWl0YXRpb24sIHRoZSBoYW5nIGlzIGV4cGVjdGVkLCBJDQp0aGluayB3ZSBo
YXZlIHRvIGFkZCBsYXJiIHJlc2V0IGluIHRoaXMgZmFpbCBjYXNlOiBSZXNldCB0aGUgbGFyYiB3
aGVuDQp0aGUgbGFyYiBydW50aW1lIHJlc3VtZS4NCg0KRm9ydHVuYXRlbHksIHdlIGhhdmUgbmV2
ZXIgZ290IHRoaXMgaXNzdWUuIFdlIGNvdWxkIGFkZCB0aGlzIHJlc2V0IHdoZW4NCm5lY2Vzc2Fy
eS4gSXMgdGhpcyBPSyBmb3IgeW91Pw0KDQpUaGFua3MuDQoNCj4gDQo+ID4gICANCj4gPiAgIAlj
bGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShsYXJiLT5zbWkuY2xrX251bSwgbGFyYi0+c21pLmNs
a3MpOw0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiA+ICAg
DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgc21pX2xhcmJfcG1fb3BzID0g
ew0KPiA+IA0KPiANCj4gDQo=

