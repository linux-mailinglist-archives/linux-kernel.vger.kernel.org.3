Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A04FEDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiDMD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDMD4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:56:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7D3FBD9;
        Tue, 12 Apr 2022 20:53:56 -0700 (PDT)
X-UUID: 0375909283bf4a278f890936e69388b9-20220413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=K+aUO8UW8SOQ5Vm/IXmVyKeIBheRPwDIFzKm8KfstR4=;
        b=HDp7u3HkOASfryjiAnITsge0UltZnUftLpTnNzSg+J8/oSECTs+puPvWA9PRJAlnSR2HfAzm/R+sVsOfwoc4eWoxfDBLZyFqFsFKIi6GFrUbt9Boh5aQyZOFD17uDmyNhtShfxfeXV6c+MOGEi8yR9bKJlXel6p2DQvThAhp91o=;
X-UUID: 0375909283bf4a278f890936e69388b9-20220413
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 764632688; Wed, 13 Apr 2022 11:53:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 13 Apr 2022 11:53:50 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Apr 2022 11:53:49 +0800
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
To:     Bean Huo <huobean@gmail.com>, Po-Wen Kao <powen.kao@mediatek.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <alice.chao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <yohan.joung@sk.com>, <jason.li@sk.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
 <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
 <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <7e979863-21e5-ba63-862a-8ba6a63a8ae4@mediatek.com>
Date:   Wed, 13 Apr 2022 11:53:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVhbiwNCg0KSG93IGFib3V0IGlmIHJlc2V0IGZsb3cgbm90IGNsZWFyIGhwYiBtYXBwaW5n
Pw0KDQpBZnRlciBkZXZpY2UgaXMgcmVzZXQgYnkgUlNUX04gcGluLCBpZiB0aGUgaHBiIG1hcHBp
bmcgdGFibGUgc3RpbGwgZXhpc3Q/DQoNCkJUVywgSG9zdCBzZWVtIG5vdCBjbGVhciByZWdpb24g
bWFwcGluZyB0YWJsZSBpbiByZXNldCBmbG93Lg0KDQpUaGFua3MuDQoNCg0KT24gNC8xMi8yMiAx
MToyMCBQTSwgQmVhbiBIdW8gd3JvdGU6DQo+IEhpLCBQby1XZW4sDQo+IFByZXZpb3VzIGVtYWls
IGRpZCBub3QgcHJvcGVybHkgYXBwZW5kIHRoZSBwYXRjaCwgdGhpcyBvbmUgaXMgYmV0dGVyDQo+
IGZvciB5b3VyIHJldmlldyBhbmQgdGVzdC4NCj4NCj4NCj4NCj4NCj4gRnJvbTogQmVhbiBIdW8g
PGJlYW5odW9AbWljcm9uLmNvbT4NCj4gRGF0ZTogVHVlLCAxMiBBcHIgMjAyMiAxNjo1NjozNCAr
MDIwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNjc2k6IHVmc2hwYjogVUZTSFBCIGNsZWFudXANCj4N
Cj4gUmVtb3ZlIHJlZHVuZGFudCB1ZnNocGJfcmVzZXQqLCBhbmQgbWVyZ2UgaW50byBhIHNpbmds
ZSBoZWxwZXINCj4gdWZzaGJwX3N0YXRlX3RvZ2dsZSgpLg0KPg0KPiBEZWxldGUgdGhlIHJlZHVu
ZGFudCBJbmFjdGl2YXRpb24gY29kZSBvZiBhbGwgSFBCIFJlZ2lvbnMgaW4gdGhlIGNvbGQNCj4g
Ym9vdCBzdGFnZSwNCj4gYW5kIGFkZCBpbmFjdGl2YXRpbmcgYWxsIEhQQiBSZWdpb25zIHdoZW4g
dGhlIEhQUCBzdGF0dXMgY2hhbmdlcyBmcm9tDQo+IEhQQl9SRVNFVA0KPiB0byBIQlBfUFJFU0VO
VC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyB8ICA0ICsrLS0NCj4gICBkcml2ZXJz
L3Njc2kvdWZzL3Vmc2hwYi5jIHwgMzggKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gICBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hwYi5oIHwgIDYgKystLS0tDQo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5jDQo+IGluZGV4IDA4OTlkNWI4Y2RhZC4uZDhiNTlkMDE3Y2U0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZz
aGNkLmMNCj4gQEAgLTcyMjMsNyArNzIyMyw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2hvc3RfcmVz
ZXRfYW5kX3Jlc3RvcmUoc3RydWN0DQo+IHVmc19oYmEgKmhiYSkNCj4gICAJICogU3RvcCB0aGUg
aG9zdCBjb250cm9sbGVyIGFuZCBjb21wbGV0ZSB0aGUgcmVxdWVzdHMNCj4gICAJICogY2xlYXJl
ZCBieSBoL3cNCj4gICAJICovDQo+IC0JdWZzaHBiX3Jlc2V0X2hvc3QoaGJhKTsNCj4gKwl1ZnNo
cGJfc3RhdGVfdG9nZ2xlKGhiYSwgSFBCX1JFU0VUKTsNCj4gICAJdWZzaGNkX2hiYV9zdG9wKGhi
YSk7DQo+ICAgCWhiYS0+c2lsZW5jZV9lcnJfbG9ncyA9IHRydWU7DQo+ICAgCXVmc2hjZF9jb21w
bGV0ZV9yZXF1ZXN0cyhoYmEpOw0KPiBAQCAtODE4NCw3ICs4MTg0LDcgQEAgc3RhdGljIGludCB1
ZnNoY2RfcHJvYmVfaGJhKHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+IGJvb2wgaW5pdF9kZXZfcGFy
YW1zKQ0KPiAgIAkvKiBFbmFibGUgQXV0by1IaWJlcm5hdGUgaWYgY29uZmlndXJlZCAqLw0KPiAg
IAl1ZnNoY2RfYXV0b19oaWJlcm44X2VuYWJsZShoYmEpOw0KPiAgIA0KPiAtCXVmc2hwYl9yZXNl
dChoYmEpOw0KPiArCXVmc2hwYl9zdGF0ZV90b2dnbGUoaGJhLCBIUEJfUFJFU0VOVCk7DQo+ICAg
b3V0Og0KPiAgIAlzcGluX2xvY2tfaXJxc2F2ZShoYmEtPmhvc3QtPmhvc3RfbG9jaywgZmxhZ3Mp
Ow0KPiAgIAlpZiAocmV0KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIu
YyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaHBiLmMNCj4gaW5kZXggM2NhNzQ1YWQ2MTZjLi40ZWQx
NTYwMzE0MTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaHBiLmMNCj4gKysr
IGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIuYw0KPiBAQCAtMjI3OCwzOSArMjI3OCwyOSBAQCBz
dGF0aWMgYm9vbCB1ZnNocGJfY2hlY2tfaHBiX3Jlc2V0X3F1ZXJ5KHN0cnVjdA0KPiB1ZnNfaGJh
ICpoYmEpDQo+ICAgCXJldHVybiBmbGFnX3JlczsNCj4gICB9DQo+ICAgDQo+IC12b2lkIHVmc2hw
Yl9yZXNldChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiArdm9pZCB1ZnNocGJfc3RhdGVfdG9nZ2xl
KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gVUZTSFBCX1NUQVRFIHN0YXRlKQ0KPiAgIHsNCj4g
ICAJc3RydWN0IHVmc2hwYl9sdSAqaHBiOw0KPiAgIAlzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXY7
DQo+ICAgDQo+ICAgCXNob3N0X2Zvcl9lYWNoX2RldmljZShzZGV2LCBoYmEtPmhvc3QpIHsNCj4g
ICAJCWhwYiA9IHVmc2hwYl9nZXRfaHBiX2RhdGEoc2Rldik7DQo+IC0JCWlmICghaHBiKQ0KPiAt
CQkJY29udGludWU7DQo+ICAgDQo+IC0JCWlmICh1ZnNocGJfZ2V0X3N0YXRlKGhwYikgIT0gSFBC
X1JFU0VUKQ0KPiArCQlpZiAoIWhwYiB8fCB1ZnNocGJfZ2V0X3N0YXRlKGhwYikgIT0gc3RhdGUp
DQo+ICAgCQkJY29udGludWU7DQo+ICAgDQo+IC0JCXVmc2hwYl9zZXRfc3RhdGUoaHBiLCBIUEJf
UFJFU0VOVCk7DQo+IC0JfQ0KPiAtfQ0KPiAtDQo+IC12b2lkIHVmc2hwYl9yZXNldF9ob3N0KHN0
cnVjdCB1ZnNfaGJhICpoYmEpDQo+IC17DQo+IC0Jc3RydWN0IHVmc2hwYl9sdSAqaHBiOw0KPiAt
CXN0cnVjdCBzY3NpX2RldmljZSAqc2RldjsNCj4gLQ0KPiAtCXNob3N0X2Zvcl9lYWNoX2Rldmlj
ZShzZGV2LCBoYmEtPmhvc3QpIHsNCj4gLQkJaHBiID0gdWZzaHBiX2dldF9ocGJfZGF0YShzZGV2
KTsNCj4gLQkJaWYgKCFocGIpDQo+IC0JCQljb250aW51ZTsNCj4gLQ0KPiAtCQlpZiAodWZzaHBi
X2dldF9zdGF0ZShocGIpICE9IEhQQl9QUkVTRU5UKQ0KPiAtCQkJY29udGludWU7DQo+IC0JCXVm
c2hwYl9zZXRfc3RhdGUoaHBiLCBIUEJfUkVTRVQpOw0KPiAtCQl1ZnNocGJfY2FuY2VsX2pvYnMo
aHBiKTsNCj4gLQkJdWZzaHBiX2Rpc2NhcmRfcnNwX2xpc3RzKGhwYik7DQo+ICsJCXVmc2hwYl9z
ZXRfc3RhdGUoaHBiLCBzdGF0ZSk7DQo+ICsJCWlmIChzdGF0ZSA9PSBIUEJfUkVTRVQpIHsNCj4g
KwkJCXVmc2hwYl9jYW5jZWxfam9icyhocGIpOw0KPiArCQkJdWZzaHBiX2Rpc2NhcmRfcnNwX2xp
c3RzKGhwYik7DQo+ICsJCX0NCj4gICAJfQ0KPiArCS8qDQo+ICsJICogSW5hY3RpdmF0aW5nIGFs
bCBIUEIgUmVnaW9uIGluIGRldmljZSBzaWRlIGluIGNhc2UgSFBCDQo+IHN0YXRlIGNoYW5nZWQN
Cj4gKwkgKiBmcm9tIEhQQl9SRVNFVCB0byBIUEJfUFJFU0VOVA0KPiArCSAqLw0KPiArCWlmICgh
aHBiLT5pc19oY20gJiYgc3RhdGUgPT0gSFBCX1BSRVNFTlQpDQoNCm1heSBuZWVkIGNoZWNrIGhw
YiBpcyBub3QgbnVsbD8NCg0KPiArCQl1ZnNocGJfaXNzdWVfdW1hcF9hbGxfcmVxKGhwYik7DQo+
ICAgfQ0KPiAgIA0KPiAgIHZvaWQgdWZzaHBiX3N1c3BlbmQoc3RydWN0IHVmc19oYmEgKmhiYSkN
Cj4gQEAgLTI0NTYsOCArMjQ0Niw2IEBAIHN0YXRpYyB2b2lkIHVmc2hwYl9ocGJfbHVfcHJlcGFy
ZWQoc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gICAJCQl1ZnNocGJfc2V0X3N0YXRlKGhwYiwg
SFBCX1BSRVNFTlQpOw0KPiAgIAkJCWlmICgoaHBiLT5sdV9waW5uZWRfZW5kIC0gaHBiLQ0KPj4g
bHVfcGlubmVkX3N0YXJ0KSA+IDApDQo+ICAgCQkJCXF1ZXVlX3dvcmsodWZzaHBiX3dxLCAmaHBi
LT5tYXBfd29yayk7DQo+IC0JCQlpZiAoIWhwYi0+aXNfaGNtKQ0KPiAtCQkJCXVmc2hwYl9pc3N1
ZV91bWFwX2FsbF9yZXEoaHBiKTsNCj4gICAJCX0gZWxzZSB7DQo+ICAgCQkJZGV2X2VycihoYmEt
PmRldiwgImRlc3Ryb3kgSFBCIGx1ICVkXG4iLCBocGItDQo+PiBsdW4pOw0KPiAgIAkJCXVmc2hw
Yl9kZXN0cm95X2x1KGhiYSwgc2Rldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZz
L3Vmc2hwYi5oIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIuaA0KPiBpbmRleCBiNDc1ZGJkNzg5
ODguLmExMzBmMGIxNmMzZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNocGIu
aA0KPiArKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hwYi5oDQo+IEBAIC0yODgsOCArMjg4LDcg
QEAgc3RhdGljIGludCB1ZnNocGJfcHJlcChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3QNCj4g
dWZzaGNkX2xyYiAqbHJicCkgeyByZXR1cm4gMDsNCj4gICBzdGF0aWMgdm9pZCB1ZnNocGJfcnNw
X3VwaXUoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHVmc2hjZF9scmINCj4gKmxyYnApIHt9
DQo+ICAgc3RhdGljIHZvaWQgdWZzaHBiX3Jlc3VtZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7fQ0K
PiAgIHN0YXRpYyB2b2lkIHVmc2hwYl9zdXNwZW5kKHN0cnVjdCB1ZnNfaGJhICpoYmEpIHt9DQo+
IC1zdGF0aWMgdm9pZCB1ZnNocGJfcmVzZXQoc3RydWN0IHVmc19oYmEgKmhiYSkge30NCj4gLXN0
YXRpYyB2b2lkIHVmc2hwYl9yZXNldF9ob3N0KHN0cnVjdCB1ZnNfaGJhICpoYmEpIHt9DQo+ICtz
dGF0aWMgdm9pZCB1ZnNocGJfc3RhdGVfdG9nZ2xlKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0g
VUZTSFBCX1NUQVRFDQo+IHN0YXRlKSB7fQ0KPiAgIHN0YXRpYyB2b2lkIHVmc2hwYl9pbml0KHN0
cnVjdCB1ZnNfaGJhICpoYmEpIHt9DQo+ICAgc3RhdGljIHZvaWQgdWZzaHBiX2luaXRfaHBiX2x1
KHN0cnVjdCB1ZnNfaGJhICpoYmEsIHN0cnVjdCBzY3NpX2RldmljZQ0KPiAqc2Rldikge30NCj4g
ICBzdGF0aWMgdm9pZCB1ZnNocGJfZGVzdHJveV9sdShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1
Y3Qgc2NzaV9kZXZpY2UNCj4gKnNkZXYpIHt9DQo+IEBAIC0zMDMsOCArMzAyLDcgQEAgaW50IHVm
c2hwYl9wcmVwKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHN0cnVjdA0KPiB1ZnNoY2RfbHJiICpscmJw
KTsNCj4gICB2b2lkIHVmc2hwYl9yc3BfdXBpdShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3Qg
dWZzaGNkX2xyYiAqbHJicCk7DQo+ICAgdm9pZCB1ZnNocGJfcmVzdW1lKHN0cnVjdCB1ZnNfaGJh
ICpoYmEpOw0KPiAgIHZvaWQgdWZzaHBiX3N1c3BlbmQoc3RydWN0IHVmc19oYmEgKmhiYSk7DQo+
IC12b2lkIHVmc2hwYl9yZXNldChzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCj4gLXZvaWQgdWZzaHBi
X3Jlc2V0X2hvc3Qoc3RydWN0IHVmc19oYmEgKmhiYSk7DQo+ICt2b2lkIHVmc2hwYl9zdGF0ZV90
b2dnbGUoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBVRlNIUEJfU1RBVEUNCj4gc3RhdGUpOw0K
PiAgIHZvaWQgdWZzaHBiX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSk7DQo+ICAgdm9pZCB1ZnNo
cGJfaW5pdF9ocGJfbHUoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHNjc2lfZGV2aWNlDQo+
ICpzZGV2KTsNCj4gICB2b2lkIHVmc2hwYl9kZXN0cm95X2x1KHN0cnVjdCB1ZnNfaGJhICpoYmEs
IHN0cnVjdCBzY3NpX2RldmljZSAqc2Rldik7

