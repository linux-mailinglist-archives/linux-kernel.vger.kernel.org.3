Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E84500540
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 06:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiDNEwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 00:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 00:52:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03833E092;
        Wed, 13 Apr 2022 21:49:51 -0700 (PDT)
X-UUID: 1efc710421e24dc0b520eb571deabba8-20220414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=RpoR8AYjc38m1SJSBiJnehSXzZ9YYwMS0bcdWs+t5ds=;
        b=m9eUVvwjKVQRR/tvjVTvAJW+T8gIU3X594etA/BZIjo7pyWoZryFBO2ZZ1I7JHnBP0pg03Fd52WNOCq+K3v/NAT/6Ky9ljw3MbjoISWShadfRyigRw8t6cApoAJIHKz2UZ+84dYxVNJHt+xvEmEhI1PPw7ELwgBfDBgLdu2Jnvk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:de61ad08-2fe4-4e50-bbf5-4e23c79a8c47,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:e17319a9-d103-4e36-82b9-b0e86991b3df,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 1efc710421e24dc0b520eb571deabba8-20220414
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2033042117; Thu, 14 Apr 2022 12:49:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 12:49:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 12:49:43 +0800
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
To:     Bean Huo <huobean@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <yohan.joung@sk.com>, <jason.li@sk.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
 <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
 <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
From:   Po-Wen Kao <powen.kao@mediatek.com>
Message-ID: <004b55d8-fcd3-136c-526c-6ada025d6a1c@mediatek.com>
Date:   Thu, 14 Apr 2022 12:49:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVhbiwNCg0KVGhlIGdlbmVyYWwgaWRlYSBsb29rcyBnb29kLg0KDQpBcyB1ZnNocGJfaXNz
dWVfdW1hcF9hbGxfcmVxIGluIHVmc2hwYl9zdGF0ZV90b2dnbGUgd29uJ3QgYWN0dWFsbHkgcnVu
cyANCmF0IGNvbGQgYm9vdCBwcm9iZSBkdWUgdG8gdGhlIGZhY3QgdGhhdCBzZGV2IGFyZSBub3Qg
cHJlc2VudCB5ZXQsIHRoaXMgDQpzaG91bGQgYXZvaWQgc2VuZGluZyBIUEIgY29tbWFuZCBiZWZv
cmUgVUFDIGJlaW5nIGNsZWFyZWQgd2hpbGUga2VlcHMgDQpIUEIgbWFwcGluZyBjbGVhbiB3aGVu
IHJlc3QgZmxvdyBvY2N1cnMuDQoNCkp1c3QgYSBjb25jZXJuLCBzaG91bGRuJ3QgdWZzaHBiX2lz
c3VlX3VtYXBfYWxsX3JlcSBiZSBzZW5kIGZvciBlYWNoIA0Kc2RldidzIGNvcnJlc3BvbmRpbmcg
aHBiPw0KDQpMb29raW5nIGZvcndhcmQgdG8geW91ciBmdXJ0aGVyIGZpeGVzLg0KDQoNClBvLVdl
bg0KDQpPbiA0LzEyLzIyIDExOjIwIFBNLCBCZWFuIEh1byB3cm90ZToNCj4gSGksIFBvLVdlbiwN
Cj4gUHJldmlvdXMgZW1haWwgZGlkIG5vdCBwcm9wZXJseSBhcHBlbmQgdGhlIHBhdGNoLCB0aGlz
IG9uZSBpcyBiZXR0ZXINCj4gZm9yIHlvdXIgcmV2aWV3IGFuZCB0ZXN0Lg0KPg0KPg0KPg0KPg0K
PiBGcm9tOiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiBEYXRlOiBUdWUsIDEyIEFw
ciAyMDIyIDE2OjU2OjM0ICswMjAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gc2NzaTogdWZzaHBiOiBV
RlNIUEIgY2xlYW51cA0KPg0KPiBSZW1vdmUgcmVkdW5kYW50IHVmc2hwYl9yZXNldCosIGFuZCBt
ZXJnZSBpbnRvIGEgc2luZ2xlIGhlbHBlcg0KPiB1ZnNoYnBfc3RhdGVfdG9nZ2xlKCkuDQo+DQo+
IERlbGV0ZSB0aGUgcmVkdW5kYW50IEluYWN0aXZhdGlvbiBjb2RlIG9mIGFsbCBIUEIgUmVnaW9u
cyBpbiB0aGUgY29sZA0KPiBib290IHN0YWdlLA0KPiBhbmQgYWRkIGluYWN0aXZhdGluZyBhbGwg
SFBCIFJlZ2lvbnMgd2hlbiB0aGUgSFBQIHN0YXR1cyBjaGFuZ2VzIGZyb20NCj4gSFBCX1JFU0VU
DQo+IHRvIEhCUF9QUkVTRU5ULg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1
b0BtaWNyb24uY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIHwgIDQg
KystLQ0KPiAgIGRyaXZlcnMvc2NzaS91ZnMvdWZzaHBiLmMgfCAzOCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvc2NzaS91ZnMvdWZzaHBiLmggfCAg
NiArKy0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDMxIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyBiL2Ry
aXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gaW5kZXggMDg5OWQ1YjhjZGFkLi5kOGI1OWQwMTdj
ZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gKysrIGIvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiBAQCAtNzIyMyw3ICs3MjIzLDcgQEAgc3RhdGljIGlu
dCB1ZnNoY2RfaG9zdF9yZXNldF9hbmRfcmVzdG9yZShzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhKQ0K
PiAgIAkgKiBTdG9wIHRoZSBob3N0IGNvbnRyb2xsZXIgYW5kIGNvbXBsZXRlIHRoZSByZXF1ZXN0
cw0KPiAgIAkgKiBjbGVhcmVkIGJ5IGgvdw0KPiAgIAkgKi8NCj4gLQl1ZnNocGJfcmVzZXRfaG9z
dChoYmEpOw0KPiArCXVmc2hwYl9zdGF0ZV90b2dnbGUoaGJhLCBIUEJfUkVTRVQpOw0KPiAgIAl1
ZnNoY2RfaGJhX3N0b3AoaGJhKTsNCj4gICAJaGJhLT5zaWxlbmNlX2Vycl9sb2dzID0gdHJ1ZTsN
Cj4gICAJdWZzaGNkX2NvbXBsZXRlX3JlcXVlc3RzKGhiYSk7DQo+IEBAIC04MTg0LDcgKzgxODQs
NyBAQCBzdGF0aWMgaW50IHVmc2hjZF9wcm9iZV9oYmEoc3RydWN0IHVmc19oYmEgKmhiYSwNCj4g
Ym9vbCBpbml0X2Rldl9wYXJhbXMpDQo+ICAgCS8qIEVuYWJsZSBBdXRvLUhpYmVybmF0ZSBpZiBj
b25maWd1cmVkICovDQo+ICAgCXVmc2hjZF9hdXRvX2hpYmVybjhfZW5hYmxlKGhiYSk7DQo+ICAg
DQo+IC0JdWZzaHBiX3Jlc2V0KGhiYSk7DQo+ICsJdWZzaHBiX3N0YXRlX3RvZ2dsZShoYmEsIEhQ
Ql9QUkVTRU5UKTsNCj4gICBvdXQ6DQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKGhiYS0+aG9zdC0+
aG9zdF9sb2NrLCBmbGFncyk7DQo+ICAgCWlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hwYi5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIuYw0KPiBpbmRleCAz
Y2E3NDVhZDYxNmMuLjRlZDE1NjAzMTQxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3Vm
cy91ZnNocGIuYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hwYi5jDQo+IEBAIC0yMjc4
LDM5ICsyMjc4LDI5IEBAIHN0YXRpYyBib29sIHVmc2hwYl9jaGVja19ocGJfcmVzZXRfcXVlcnko
c3RydWN0DQo+IHVmc19oYmEgKmhiYSkNCj4gICAJcmV0dXJuIGZsYWdfcmVzOw0KPiAgIH0NCj4g
ICANCj4gLXZvaWQgdWZzaHBiX3Jlc2V0KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICt2b2lkIHVm
c2hwYl9zdGF0ZV90b2dnbGUoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBVRlNIUEJfU1RBVEUg
c3RhdGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgdWZzaHBiX2x1ICpocGI7DQo+ICAgCXN0cnVjdCBz
Y3NpX2RldmljZSAqc2RldjsNCj4gICANCj4gICAJc2hvc3RfZm9yX2VhY2hfZGV2aWNlKHNkZXYs
IGhiYS0+aG9zdCkgew0KPiAgIAkJaHBiID0gdWZzaHBiX2dldF9ocGJfZGF0YShzZGV2KTsNCj4g
LQkJaWYgKCFocGIpDQo+IC0JCQljb250aW51ZTsNCj4gICANCj4gLQkJaWYgKHVmc2hwYl9nZXRf
c3RhdGUoaHBiKSAhPSBIUEJfUkVTRVQpDQo+ICsJCWlmICghaHBiIHx8IHVmc2hwYl9nZXRfc3Rh
dGUoaHBiKSAhPSBzdGF0ZSkNCj4gICAJCQljb250aW51ZTsNCj4gICANCj4gLQkJdWZzaHBiX3Nl
dF9zdGF0ZShocGIsIEhQQl9QUkVTRU5UKTsNCj4gLQl9DQo+IC19DQo+IC0NCj4gLXZvaWQgdWZz
aHBiX3Jlc2V0X2hvc3Qoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gLXsNCj4gLQlzdHJ1Y3QgdWZz
aHBiX2x1ICpocGI7DQo+IC0Jc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2Ow0KPiAtDQo+IC0Jc2hv
c3RfZm9yX2VhY2hfZGV2aWNlKHNkZXYsIGhiYS0+aG9zdCkgew0KPiAtCQlocGIgPSB1ZnNocGJf
Z2V0X2hwYl9kYXRhKHNkZXYpOw0KPiAtCQlpZiAoIWhwYikNCj4gLQkJCWNvbnRpbnVlOw0KPiAt
DQo+IC0JCWlmICh1ZnNocGJfZ2V0X3N0YXRlKGhwYikgIT0gSFBCX1BSRVNFTlQpDQo+IC0JCQlj
b250aW51ZTsNCj4gLQkJdWZzaHBiX3NldF9zdGF0ZShocGIsIEhQQl9SRVNFVCk7DQo+IC0JCXVm
c2hwYl9jYW5jZWxfam9icyhocGIpOw0KPiAtCQl1ZnNocGJfZGlzY2FyZF9yc3BfbGlzdHMoaHBi
KTsNCj4gKwkJdWZzaHBiX3NldF9zdGF0ZShocGIsIHN0YXRlKTsNCj4gKwkJaWYgKHN0YXRlID09
IEhQQl9SRVNFVCkgew0KPiArCQkJdWZzaHBiX2NhbmNlbF9qb2JzKGhwYik7DQo+ICsJCQl1ZnNo
cGJfZGlzY2FyZF9yc3BfbGlzdHMoaHBiKTsNCj4gKwkJfQ0KPiAgIAl9DQo+ICsJLyoNCj4gKwkg
KiBJbmFjdGl2YXRpbmcgYWxsIEhQQiBSZWdpb24gaW4gZGV2aWNlIHNpZGUgaW4gY2FzZSBIUEIN
Cj4gc3RhdGUgY2hhbmdlZA0KPiArCSAqIGZyb20gSFBCX1JFU0VUIHRvIEhQQl9QUkVTRU5UDQo+
ICsJICovDQo+ICsJaWYgKCFocGItPmlzX2hjbSAmJiBzdGF0ZSA9PSBIUEJfUFJFU0VOVCkNCj4g
KwkJdWZzaHBiX2lzc3VlX3VtYXBfYWxsX3JlcShocGIpOw0KPiAgIH0NCj4gICANCj4gICB2b2lk
IHVmc2hwYl9zdXNwZW5kKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+IEBAIC0yNDU2LDggKzI0NDYs
NiBAQCBzdGF0aWMgdm9pZCB1ZnNocGJfaHBiX2x1X3ByZXBhcmVkKHN0cnVjdCB1ZnNfaGJhDQo+
ICpoYmEpDQo+ICAgCQkJdWZzaHBiX3NldF9zdGF0ZShocGIsIEhQQl9QUkVTRU5UKTsNCj4gICAJ
CQlpZiAoKGhwYi0+bHVfcGlubmVkX2VuZCAtIGhwYi0NCj4+IGx1X3Bpbm5lZF9zdGFydCkgPiAw
KQ0KPiAgIAkJCQlxdWV1ZV93b3JrKHVmc2hwYl93cSwgJmhwYi0+bWFwX3dvcmspOw0KPiAtCQkJ
aWYgKCFocGItPmlzX2hjbSkNCj4gLQkJCQl1ZnNocGJfaXNzdWVfdW1hcF9hbGxfcmVxKGhwYik7
DQo+ICAgCQl9IGVsc2Ugew0KPiAgIAkJCWRldl9lcnIoaGJhLT5kZXYsICJkZXN0cm95IEhQQiBs
dSAlZFxuIiwgaHBiLQ0KPj4gbHVuKTsNCj4gICAJCQl1ZnNocGJfZGVzdHJveV9sdShoYmEsIHNk
ZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIuaCBiL2RyaXZlcnMv
c2NzaS91ZnMvdWZzaHBiLmgNCj4gaW5kZXggYjQ3NWRiZDc4OTg4Li5hMTMwZjBiMTZjM2UgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaHBiLmgNCj4gKysrIGIvZHJpdmVycy9z
Y3NpL3Vmcy91ZnNocGIuaA0KPiBAQCAtMjg4LDggKzI4OCw3IEBAIHN0YXRpYyBpbnQgdWZzaHBi
X3ByZXAoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0DQo+IHVmc2hjZF9scmIgKmxyYnApIHsg
cmV0dXJuIDA7DQo+ICAgc3RhdGljIHZvaWQgdWZzaHBiX3JzcF91cGl1KHN0cnVjdCB1ZnNfaGJh
ICpoYmEsIHN0cnVjdCB1ZnNoY2RfbHJiDQo+ICpscmJwKSB7fQ0KPiAgIHN0YXRpYyB2b2lkIHVm
c2hwYl9yZXN1bWUoc3RydWN0IHVmc19oYmEgKmhiYSkge30NCj4gICBzdGF0aWMgdm9pZCB1ZnNo
cGJfc3VzcGVuZChzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7fQ0KPiAtc3RhdGljIHZvaWQgdWZzaHBi
X3Jlc2V0KHN0cnVjdCB1ZnNfaGJhICpoYmEpIHt9DQo+IC1zdGF0aWMgdm9pZCB1ZnNocGJfcmVz
ZXRfaG9zdChzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7fQ0KPiArc3RhdGljIHZvaWQgdWZzaHBiX3N0
YXRlX3RvZ2dsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIFVGU0hQQl9TVEFURQ0KPiBzdGF0
ZSkge30NCj4gICBzdGF0aWMgdm9pZCB1ZnNocGJfaW5pdChzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7
fQ0KPiAgIHN0YXRpYyB2b2lkIHVmc2hwYl9pbml0X2hwYl9sdShzdHJ1Y3QgdWZzX2hiYSAqaGJh
LCBzdHJ1Y3Qgc2NzaV9kZXZpY2UNCj4gKnNkZXYpIHt9DQo+ICAgc3RhdGljIHZvaWQgdWZzaHBi
X2Rlc3Ryb3lfbHUoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHNjc2lfZGV2aWNlDQo+ICpz
ZGV2KSB7fQ0KPiBAQCAtMzAzLDggKzMwMiw3IEBAIGludCB1ZnNocGJfcHJlcChzdHJ1Y3QgdWZz
X2hiYSAqaGJhLCBzdHJ1Y3QNCj4gdWZzaGNkX2xyYiAqbHJicCk7DQo+ICAgdm9pZCB1ZnNocGJf
cnNwX3VwaXUoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHVmc2hjZF9scmIgKmxyYnApOw0K
PiAgIHZvaWQgdWZzaHBiX3Jlc3VtZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCj4gICB2b2lkIHVm
c2hwYl9zdXNwZW5kKHN0cnVjdCB1ZnNfaGJhICpoYmEpOw0KPiAtdm9pZCB1ZnNocGJfcmVzZXQo
c3RydWN0IHVmc19oYmEgKmhiYSk7DQo+IC12b2lkIHVmc2hwYl9yZXNldF9ob3N0KHN0cnVjdCB1
ZnNfaGJhICpoYmEpOw0KPiArdm9pZCB1ZnNocGJfc3RhdGVfdG9nZ2xlKHN0cnVjdCB1ZnNfaGJh
ICpoYmEsIGVudW0gVUZTSFBCX1NUQVRFDQo+IHN0YXRlKTsNCj4gICB2b2lkIHVmc2hwYl9pbml0
KHN0cnVjdCB1ZnNfaGJhICpoYmEpOw0KPiAgIHZvaWQgdWZzaHBiX2luaXRfaHBiX2x1KHN0cnVj
dCB1ZnNfaGJhICpoYmEsIHN0cnVjdCBzY3NpX2RldmljZQ0KPiAqc2Rldik7DQo+ICAgdm9pZCB1
ZnNocGJfZGVzdHJveV9sdShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3Qgc2NzaV9kZXZpY2Ug
KnNkZXYpOw==

