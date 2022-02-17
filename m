Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995864B9929
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiBQGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:25:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQGZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:25:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC122A4A3E;
        Wed, 16 Feb 2022 22:25:04 -0800 (PST)
X-UUID: 211e60e5e7774d5a9454cdf31f64a04e-20220217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=D5TO2kmrB9d+UmyevkymhP1Fv2/RxsKc120IlOGqKkg=;
        b=T07OJaXRBUhilAYBEbhcNS3a+FB3UFxXbdMH0x+J33B+KqbubmCUUOsPvWruh6LYUveQUUzjwyDbdi4pfVrAVNYMCmUyWGLZF8TwOwwA/xkWvz5ZcWWeMSu+ONn8dUQJB8XJyzHV8ZUA+4pdwGb8dTeUTiLIi0TGCL0fGJjGdJ0=;
X-UUID: 211e60e5e7774d5a9454cdf31f64a04e-20220217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1919872885; Thu, 17 Feb 2022 14:25:00 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Feb 2022 14:24:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Feb
 2022 14:24:58 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 14:24:58 +0800
Subject: Re: [PATCH v11 0/3] Add basic SoC support for mediatek mt8195
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Sean Wang <Sean.Wang@mediatek.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "ryder.lee@kernel.org" <ryder.lee@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>, Fabien Parent <fparent@baylibre.com>,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <e17592b2-5e02-44a6-5c21-ac599af5fce1@mediatek.com>
Date:   Thu, 17 Feb 2022 14:24:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220216113131.13145-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="iso-2022-jp"; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNi8yMiA3OjMxIFBNLCBUaW5naGFuIFNoZW4gd3JvdGU6DQo+IFRoaXMgc2VyaWVzIGFk
ZHMgYmFzaWMgU29DIHN1cHBvcnQgZm9yIE1lZGlhdGVrJ3MgU29DIE1UODE5NS4NCj4gDQo+IC0t
LQ0KPiBDaGFuZ2VzIGluIHYxMToNCj4gICAgLSByZWJhc2Ugb24gNS4xNy1yYzQNCj4gQ2hhbmdl
cyBpbiB2MTA6DQo+ICAgIC0gY2xlYW4gQ0MgbGlzdA0KPiBDaGFuZ2VzIGluIHY5Og0KPiAgICAt
IHJlbW92ZSBkdXBsaWNhdGVkIGNwdXMgZHQtYmluZGluZ3MgcGF0Y2ggaW4gdjgNCj4gQ2hhbmdl
cyBpbiB2ODoNCj4gICAgLSB2NyBtZWRpYXRlayxzcGktbXRrLW5vci55YW1sIHBhdGNoIGlzIGFw
cGxpZWQgaW4gYnJhbmNoIGZvci01LjE3IGF0DQo+ICAgICAga2VybmVsL2dpdC9icm9vbmllL3Nw
aS5naXQNCj4gICAgLSB2NyBwaW5jdHJsLW10ODE5NS55YW1sIHBhdGNoIGlzIGFwcGxpZWQgaW4g
YnJhbmNoIGZvci1uZXh0IGF0DQo+ICAgICAga2VybmVsL2dpdC9saW51c3cvbGludXgtcGluY3Ry
bC5naXQNCj4gICAgLSBhZGQgY29ydGV4LWE3OCBjb21wYXRpYmxlIHRvIGNwdXMgZHQtYmluZGlu
Z3MNCj4gICAgLSBhZGQgbWVkaWF0ZWssZHJpdmUtc3RyZW5ndGgtYWR2IHByb3BlcnR5IHRvIHBp
bmN0cmwgZHQtYmluZGluZ3MNCj4gICAgLSBmaXggZXZiIGR0cw0KPiAgICAgIC0gcmVtb3ZlIGky
YyBub2RlcyB3aXRoIGRpc2FibGVkIHN0YXR1cyBmcm9tIGR0cw0KPiAgICAgIC0gZml4IHBpbiBw
cm9wZXJ0aWVzIG5vdCBtYXRjaCBwaW5jdHJsIGR0LWJpbmRpbmdzDQo+ICAgICAgLSByZW1vdmUg
dW5uZWNlc3NhcnkgdTNwb3J0Kg0KPiAgICAtIGZpeCBkdHNpDQo+ICAgICAgLSBmaXggbm9kZSBm
b3JtYXQNCj4gICAgICAtIHJlb3JkZXIgb3NjaWxsYXRvciogbm9kZXMNCj4gICAgICAtIGZpeCBu
b2RlIG5hbWUgb2YgY3B1IGlkbGUgbm9kZXMNCj4gICAgICAtIHJlbW92ZSBjbG9jay1mcmVxdWVu
Y3kgcHJvcGVydHkgaW4gdGhlIHRpbWVyIG5vZGUNCj4gICAgICAtIHJlb3JkZXIgY2xvY2sgYW5k
IGNsb2NrIG5hbWVzIGluIHVzYiBub2Rlcw0KPiBDaGFuZ2VzIGluIHY3Og0KPiAgICAtIHJlZmlu
ZSB0aXRsZSBvZiBzcGktbm9yIGR0LWJpbmRpbmdzIHBhdGNoDQo+ICAgIC0gcmVmaW5lIGNvbW1p
dCBtZXNzYWdlIG9mIHBpbmN0cmwgZHQtYmluZGluZ3MgcGF0Y2gNCj4gICAgLSB1cGRhdGUgcGlu
Y3RybC1tdDgxOTUueWFtbA0KPiAgICAgIC0gY2hhbmdlIHByb3BlcnR5IHBhdHRlcm4gZnJvbSAn
cGlucycgdG8gJ15waW5zJw0KPiAgICAgIC0gdXBkYXRlIGV4YW1wbGVzIHdpdGggbmV3IHByb3Bl
cnR5IGluIGRlc2NyaXB0aW9ucw0KPiAgICAgIC0gYWRkIG5ldyBleGFtcGxlDQo+ICAgIC0gZHJv
cCAnXycgZnJvbSBub2RlIG5hbWVzIG9mIHBpbmN0cmwgc3Vibm9kZXMgaW4gbXQ4MTk1LWV2Yi5k
dHMNCj4gQ2hhbmdlcyBpbiB2NjoNCj4gICAgLSByZWJhc2Ugb24gNS4xNi1yYzENCj4gICAgLSBh
ZGQgbmV3IGNsb2NrIG5hbWUgdG8gc3BpLW5vciBkdC1iaW5kaW5ncw0KPiAgICAtIGFkZCAicGlu
cyIgcHJvcGVydHkgaW4gcGluY3RybCBkdC1iaW5kaW5ncw0KPiAgICAtIGZpeCBmYWlscyBvZiBk
dGJzX2NoZWNrcw0KPiAgICAgIC0gcmVtb3ZlICJhcm0sYXJtdjgiIG5vdCBtYXRjaGVkIGluIHlh
bWwgZnJvbSBjcHUgY29tcGF0aWxlDQo+ICAgICAgLSBmaXggbm9kZSBuYW1lIG9mIHhoY2kNCj4g
ICAgICAtIHJlbXZvZSB4aGNpIHVwc3RyZWFtaW5nIHdha2V1cCBwcm9wZXJ0aWVzDQo+ICAgICAg
LSByZW1vdmUgeGhjaSB1bnVzZWQgcHJvcGVydGllcyBhZGRyZXNzLWNlbGxzIGFuZCBzaXplLWNl
bGxzDQo+ICAgICAgLSBmaXggbm9kZSBuYW1lIG9mIHVmcy1waHkNCj4gICAgICAtIGZpeCBub2Rl
IG5hbWUgb2Ygc3BpLW5vcg0KPiAgICAgIC0gZml4IG5vZGUgbmFtZSBhbmQgc3ViLW5vZGVzIG9m
IHBpbmN0cmwNCj4gICAgICAtIGZpeCBtbWMgY29tcGF0aWJsZQ0KPiBDaGFuZ2VzIGluIHY1Og0K
PiAgICAtIGVuYWJsZSBiYXNpYyBub2RlcyBpbiBtdDgxOTUtZXZiLmR0cw0KPiAgICAtIHJlbW92
ZSBkZWRpY2F0ZWQgY2xvY2sgbm9kZXMNCj4gICAgLSBhZGQgbW1jMiBub2RlDQo+ICAgIC0gZml4
IGludGVycnVwdCBudW1iZXIgb2YgcGluY3RybCBub2RlDQo+ICAgIC0gdXBkYXRlIGNsb2NrIG5v
ZGVzIHRvIGFwcGx5IGludGVybmFsIGZpeGVzDQo+ICAgIC0gYWRkIGR0LWJpbmRpbmdzIGZvciBw
ZXJmaWNmZyBub2RlDQo+IA0KPiB2NCB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA5MjIwOTMzMDMuMjM3MjAtMi1z
ZWl5YS53YW5nQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyF4djJIN1pYWUlVRzdZ
WTFSNU91RmdidkR4eWZhRTZka2tENUhfUGNpS0FaQWI1amstdVRoZ1NnSXRHdXZ0MmQ2Z0NzJA0K
PiB2MyB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMTA2MDEwNzUzNTAuMzE1MTUtMi1zZWl5YS53YW5nQG1lZGlhdGVr
LmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyF4djJIN1pYWUlVRzdZWTFSNU91RmdidkR4eWZhRTZk
a2tENUhfUGNpS0FaQWI1amstdVRoZ1NnSXRHdXZnSVFTTllvJA0KPiB2MiB0aHJlYWQ6DQo+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MTAzMTkwMjM0MjcuMTY3MTEtMTAtc2VpeWEud2FuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5
d01nMEFSYncheHYySDdaWFlJVUc3WVkxUjVPdUZnYnZEeHlmYUU2ZGtrRDVIX1BjaUtBWkFiNWpr
LXVUaGdTZ0l0R3V2Qng1MEFlVSQNCj4gdjEgdGhyZWFkOg0KPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjEwMzE2MTExNDQzLjMzMzIt
MTEtc2VpeWEud2FuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYncheHYySDdaWFlJ
VUc3WVkxUjVPdUZnYnZEeHlmYUU2ZGtrRDVIX1BjaUtBWkFiNWprLXVUaGdTZ0l0R3V2cEhfTnRF
WSQNCj4gLS0tDQo+IA0KPiBUaW5naGFuIFNoZW4gKDMpOg0KPiAgICBkdC1iaW5kaW5nczogYXJt
OiBtZWRpYXRlazogQWRkIG10ODE5NSBwZXJpY2ZnIGNvbXBhdGlibGUNCj4gICAgZHQtYmluZGlu
Z3M6IHBpbmN0cmw6IG10ODE5NTogQWRkIG1lZGlhdGVrLGRyaXZlLXN0cmVuZ3RoLWFkdiBwcm9w
ZXJ0eQ0KPiAgICBhcm02NDogZHRzOiBBZGQgbWVkaWF0ZWsgU29DIG10ODE5NSBhbmQgZXZhbHVh
dGlvbiBib2FyZA0KPiANCj4gICAuLi4vYXJtL21lZGlhdGVrL21lZGlhdGVrLHBlcmljZmcueWFt
bCAgICAgICAgfCAgICAxICsNCj4gICAuLi4vYmluZGluZ3MvcGluY3RybC9waW5jdHJsLW10ODE5
NS55YW1sICAgICAgfCAgIDM1ICsNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01h
a2VmaWxlICAgICAgICAgfCAgICAxICsNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5NS1ldmIuZHRzICAgfCAgMTYxICsrKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kgICAgICB8IDEwNDkgKysrKysrKysrKysrKysrKysNCj4gICA1IGZp
bGVzIGNoYW5nZWQsIDEyNDcgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS1ldmIuZHRzDQo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gDQoN
Ckp1c3QgdHJ5aW5nIHRvIGNsYXJpZnkgc29tZXRoaW5nLg0KRGVhciBUaW5naGFuLCBpcyB0aGVy
ZSBhbnkgImxpbmVzIG9mIGNvZGUiIGNoYW5nZWQgYmV0d2VlbiB2MTAgYW5kIHYxMSAgDQpkdWUg
dG8gdGhlIHJlYmFzZT8gSXMgdGhhdCB5b3UganVzdCB1cGRhdGVkIHRoZSBwYXJlbnQgY29tbWl0
IGhhc2ggZm9yICANCnJlYmFzaW5nIHRoaXMgcGF0Y2hzZXQgdG8gNS4xNy1yYzQ/IEkndmUganVz
dCBnZXQgY29uZnVzZWQgaWYgdjEwIGFuZCAgDQp2MTEgYXJlIGR1cGxpY2F0ZWQgdGhlbiBzaG91
bGQgd2UgbmVlZCB0byByZXZpZXcgdGhlIHBhdGNoIGFnYWluIGluIGRldGFpbD8NCg0KVGhhbmtz
Lg0KTWFjcGF1bCBMaW4=

