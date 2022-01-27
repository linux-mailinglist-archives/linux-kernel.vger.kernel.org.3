Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28849D912
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiA0DPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:15:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57124 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229997AbiA0DPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:15:14 -0500
X-UUID: 0b38b9e9e9654f7dbdc1c4993f352262-20220127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=sSmNaj2Cf5aK0r0+S1x/FHcyLBp62rFR+5TzQWIoaDY=;
        b=VmwJjVUyoJp7TYq/1ouJWxRDN2oRrbxLZrccJhbEVORpgSoXFvUG9g1i9LtI48FelTQPCGAslFpJS8C7qmeY872g5FXSZ718iRZrCv4tppa9sVyQKjHdLtVuhIDV0RMEwbVBBrFDlAlFewWI90rkBghd1BowaSmvJl7R7/ZOU8U=;
X-UUID: 0b38b9e9e9654f7dbdc1c4993f352262-20220127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1126821713; Thu, 27 Jan 2022 11:15:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 27 Jan 2022 11:15:11 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 11:15:11 +0800
Subject: Re: [PATCH v1, 6/8] media: mtk-vcodec: prevent kernel crash when scp
 ipi timeout
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Macross Chen <macross.chen@mediatek.com>
References: <20220127025544.10854-1-yunfei.dong@mediatek.com>
 <20220127025544.10854-7-yunfei.dong@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <220f3e0a-3203-6f6f-8cc6-b5f24bc1feed@mediatek.com>
Date:   Thu, 27 Jan 2022 11:15:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127025544.10854-7-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEvMjcvMjIgMTA6NTUgQU0sIFl1bmZlaSBEb25nIHdyb3RlOg0KPiBGcm9tOiBUaW5n
aGFuIFNoZW4gPHRpbmdoYW4uc2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBXaGVuIFNDUCB0aW1l
b3V0IGR1cmluZyBwbGF5aW5nIHZpZGVvLCBrZXJuZWwgY3Jhc2hlcyB3aXRoIGZvbGxvd2luZw0K
PiBtZXNzYWdlLiBJdCdzIGNhdXNlZCBieSBhY2Nlc3NpbmcgTlVMTCBwb2ludGVyIGluIHZwdV9k
ZWNfaXBpX2hhbmRsZXIuDQo+IFRoaXMgcGF0Y2ggZG9lc24ndCBzb2x2ZSB0aGUgcm9vdCBjYXVz
ZSBvZiBOVUxMIHBvaW50ZXIsIGJ1dCBtZXJlbHkNCj4gcHJldmVudCBrZXJuZWwgY3Jhc2hlZCB3
aGVuIGVuY291bnRlciB0aGUgTlVMTCBwb2ludGVyLg0KPiANCj4gQWZ0ZXIgYXBwbGllZCB0aGlz
IHBhdGNoLCBrZXJuZWwga2VlcHMgYWxpdmUsIG9ubHkgdGhlIHZpZGVvIHBsYXllciB0dXJucw0K
PiB0byBncmVlbiBzY3JlZW4uDQo+IA0KPiBbNjcyNDIuMDY1NDc0XSBwYyA6IHZwdV9kZWNfaXBp
X2hhbmRsZXIrMHhhMC8weGIyMCBbbXRrX3Zjb2RlY19kZWNdDQo+IFs2NzI0Mi4wNjU0ODVdIFtN
VEtfVjRMMl0gbGV2ZWw9MCBmb3BzX3Zjb2RlY19vcGVuKCksMzM0Og0KPiAxODAwMDAwMC52Y29k
ZWNfZGVjIGRlY29kZXIgWzEzNV0NCj4gWzY3MjQyLjA2NTUyM10gbHIgOiBzY3BfaXBpX2hhbmRs
ZXIrMHgxMWMvMHgyNDQgW210a19zY3BdDQo+IFs2NzI0Mi4wNjU1NDBdIHNwIDogZmZmZmZmYmI0
MjA3ZmIxMA0KPiBbNjcyNDIuMDY1NTU3XSB4Mjk6IGZmZmZmZmJiNDIwN2ZiMzAgeDI4OiBmZmZm
ZmZkMDBhMWQ1MDAwDQo+IFs2NzI0Mi4wNjU1OTJdIHgyNzogMWZmZmZmZmEwMTQzYWEyNCB4MjY6
IDAwMDAwMDAwMDAwMDAwMDANCj4gWzY3MjQyLjA2NTYyNV0geDI1OiBkZmZmZmZkMDAwMDAwMDAw
IHgyNDogZmZmZmZmZDAxNjhiZmRiMA0KPiBbNjcyNDIuMDY1NjU5XSB4MjM6IDFmZmZmZmY3Njg0
MGZmNzQgeDIyOiBmZmZmZmZiYjQxZmE4YTg4DQo+IFs2NzI0Mi4wNjU2OTJdIHgyMTogZmZmZmZm
YmI0MjA3ZmI5YyB4MjA6IGZmZmZmZmJiNDIwN2ZiYTANCj4gWzY3MjQyLjA2NTcyNV0geDE5OiBm
ZmZmZmZiYjQyMDdmYjk4IHgxODogMDAwMDAwMDAwMDAwMDAwMA0KPiBbNjcyNDIuMDY1NzU4XSB4
MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiBmZmZmZmZkMDQyMDIyMDk0DQo+IFs2NzI0Mi4wNjU3
OTFdIHgxNTogMWZmZmZmZjc3ZWQ0YjcxYSB4MTQ6IDFmZmZmZmY3N2VkNGI3MTkNCj4gWzY3MjQy
LjA2NTgyNF0geDEzOiAwMDAwMDAwMDAwMDAwMDAwIHgxMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBb
NjcyNDIuMDY1ODU3XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDAgeDEwOiBkZmZmZmZkMDAwMDAwMDAx
DQo+IFs2NzI0Mi4wNjU4OTBdIHg5IDogMDAwMDAwMDAwMDAwMDAwMCB4OCA6IDAwMDAwMDAwMDAw
MDAwMDINCj4gWzY3MjQyLjA2NTkyM10geDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogMDAwMDAw
MDAwMDAwMDAzZg0KPiBbNjcyNDIuMDY1OTU2XSB4NSA6IDAwMDAwMDAwMDAwMDAwNDAgeDQgOiBm
ZmZmZmZmZmZmZmZmZmUwDQo+IFs2NzI0Mi4wNjU5ODldIHgzIDogZmZmZmZmZDA0M2I4NDFiOCB4
MiA6IDAwMDAwMDAwMDAwMDAwMDANCj4gWzY3MjQyLjA2NjAyMV0geDEgOiAwMDAwMDAwMDAwMDAw
MDEwIHgwIDogMDAwMDAwMDAwMDAwMDAxMA0KPiBbNjcyNDIuMDY2MDU1XSBDYWxsIHRyYWNlOg0K
PiBbNjcyNDIuMDY2MDkyXSAgdnB1X2RlY19pcGlfaGFuZGxlcisweGEwLzB4YjIwIFttdGtfdmNv
ZGVjX2RlYw0KPiAxMjIyMGQyMzBkODNhNzQyNmZjMzhjNTZiM2U3YmM2MDY2OTU1YmFlXQ0KPiBb
NjcyNDIuMDY2MTE5XSAgc2NwX2lwaV9oYW5kbGVyKzB4MTFjLzB4MjQ0IFttdGtfc2NwDQo+IDhm
YjY5YzJlZjE0MWRkMzE5MjUxOGI5NTJiNjVhYmEzNTYyN2I4YmZdDQo+IFs2NzI0Mi4wNjYxNDVd
ICBtdDgxOTJfc2NwX2lycV9oYW5kbGVyKzB4NzAvMHgxMjggW210a19zY3ANCj4gOGZiNjljMmVm
MTQxZGQzMTkyNTE4Yjk1MmI2NWFiYTM1NjI3YjhiZl0NCj4gWzY3MjQyLjA2NjE3Ml0gIHNjcF9p
cnFfaGFuZGxlcisweGEwLzB4MTE0IFttdGtfc2NwDQo+IDhmYjY5YzJlZjE0MWRkMzE5MjUxOGI5
NTJiNjVhYmEzNTYyN2I4YmZdDQo+IFs2NzI0Mi4wNjYyMDBdICBpcnFfdGhyZWFkX2ZuKzB4ODQv
MHhmOA0KPiBbNjcyNDIuMDY2MjIwXSAgaXJxX3RocmVhZCsweDE3MC8weDFlYw0KPiBbNjcyNDIu
MDY2MjQyXSAga3RocmVhZCsweDJmOC8weDNiOA0KPiBbNjcyNDIuMDY2MjY0XSAgcmV0X2Zyb21f
Zm9yaysweDEwLzB4MzANCj4gWzY3MjQyLjA2NjI5Ml0gQ29kZTogMzhmOTY5MDggMzUwMDM2Mjgg
OTEwMDQzNDAgZDM0M2ZjMDggKDM4Zjk2OTA4KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGluZ2hh
biBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5m
ZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL210ay12Y29kZWMvdmRlY192cHVfaWYuYyB8IDUgKysrKysNCj4gICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL3ZkZWNfdnB1X2lmLmMgYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL210ay12Y29kZWMvdmRlY192cHVfaWYuYw0KPiBpbmRleCAzNWY0ZDU1ODMwODQuLjEw
NDFkZDY2M2U3NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNv
ZGVjL3ZkZWNfdnB1X2lmLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNv
ZGVjL3ZkZWNfdnB1X2lmLmMNCj4gQEAgLTkxLDYgKzkxLDExIEBAIHN0YXRpYyB2b2lkIHZwdV9k
ZWNfaXBpX2hhbmRsZXIodm9pZCAqZGF0YSwgdW5zaWduZWQgaW50IGxlbiwgdm9pZCAqcHJpdikN
Cj4gICAJc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSA9IChzdHJ1Y3QgdmRlY192cHVfaW5zdCAq
KQ0KPiAgIAkJCQkJKHVuc2lnbmVkIGxvbmcpbXNnLT5hcF9pbnN0X2FkZHI7DQo+ICAgDQo+ICsJ
aWYgKCF2cHUpIHsNCj4gKwkJbXRrX3Y0bDJfZXJyKCJhcF9pbnN0X2FkZHIgaXMgTlVMTCIpOw0K
PiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICAgCW10a192Y29kZWNfZGVidWcodnB1LCAiKyBp
ZD0lWCIsIG1zZy0+bXNnX2lkKTsNCj4gICANCj4gICAJdnB1LT5mYWlsdXJlID0gbXNnLT5zdGF0
dXM7DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVr
LmNvbT4NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

