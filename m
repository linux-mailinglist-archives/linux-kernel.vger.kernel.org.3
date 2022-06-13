Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578E0549C01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiFMSoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345600AbiFMSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:43:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5743EE15;
        Mon, 13 Jun 2022 08:02:36 -0700 (PDT)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LMF9x2m5Qz1K9S3;
        Mon, 13 Jun 2022 23:00:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 23:02:32 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Mon, 13 Jun 2022 16:02:30 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: RE: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Thread-Topic: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Thread-Index: AQHYfbD23+8d70keY0OaZ8DRkMZOaa1KXTQAgAD2BwCAAGN5gIAAFy8AgAAWoICAAAV3AIAADdIAgAAWawCAAIpHgIAADq2AgAAFgACAACxngIAAk8XA
Date:   Mon, 13 Jun 2022 15:02:30 +0000
Message-ID: <110bbec5cee74efba0aad64360069a12@huawei.com>
References: <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
In-Reply-To: <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.77]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIFttYWlsdG86emhhbmdmZWkuZ2FvQGZveG1haWwuY29tXQ0KPiBTZW50OiAxMyBK
dW5lIDIwMjIgMDc6NTYNCj4gVG86IHBhdWxtY2tAa2VybmVsLm9yZw0KPiBDYzogUGFvbG8gQm9u
emluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFpoYW5nZmVpIEdhbw0KPiA8emhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByY3VAdmdlci5r
ZXJuZWwub3JnOyBMYWkgSmlhbmdzaGFuIDxqaWFuZ3NoYW5sYWlAZ21haWwuY29tPjsgSm9zaCBU
cmlwbGV0dA0KPiA8am9zaEBqb3NodHJpcGxldHQub3JnPjsgTWF0aGlldSBEZXNub3llcnMNCj4g
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT47IE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPjsNCj4gU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gbXRvc2F0dGlAcmVkaGF0LmNvbTsgQXVnZXIg
RXJpYyA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogQ29tbWl0IDI4MmQ4
OTk4ZTk5NyAoc3JjdTogUHJldmVudCBleHBlZGl0ZWQgR1BzIGFuZA0KPiBibG9ja2luZyByZWFk
ZXJzIGZyb20gY29uc3VtaW5nIENQVSkgY2F1c2UgcWVtdSBib290IHNsb3cNCj4gDQogDQo+IEJ5
IHRoZSB3YXksIHRoZSBpc3N1ZSBzaG91bGQgYmUgb25seSByZWxhdGVkIHdpdGggcWVtdSBhcGNp
LiBub3QgcmVsYXRlZA0KPiB3aXRoIHJtciBmZWF0dXJlDQo+IFRlc3Qgd2l0aDogaHR0cHM6Ly9n
aXRodWIuY29tL3FlbXUvcWVtdS90cmVlL3N0YWJsZS02LjENCj4gDQo+IExvb2tzIGl0IGNhdXNl
ZCBieSB0b28gbWFueSBrdm1fcmVnaW9uX2FkZCAmIGt2bV9yZWdpb25fZGVsIGlmDQo+IGFjcGk9
Zm9yY2UsDQoNCkJhc2VkIG9uIHRoZSBzZXR1cCBJIGhhdmUsIEkgdGhpbmsgaXQgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCBHdWVzdCBrZXJuZWwgYm9vdGluZyB3aXRoDQpBQ1BJIHBlciBzZShpZSwg
YWNwaT1mb3JjZSBpbiBRZW11IGtlcm5lbCBjbWQgbGluZSkuDQpJdCBpcyBtb3JlIHRvIGRvIHdp
dGggUWVtdSBoYXZpbmcgdGhlICItYmlvcyBRRU1VX0VGSS5mZCIgd2hpY2ggc2V0cyB1cA0KcGZs
YXNoIGRldmljZXMgcmVzdWx0aW5nIGluIGxhcmdlIG51bWJlciBvZiBwZmxhc2ggcmVhZC93cml0
ZSBjYWxscyhiZWZvcmUgR3Vlc3Qga2VybmVsDQpldmVuIGJvb3RzKSB3aGljaCBpbiB0dXJuIHNl
ZW1zIHRvIGJlIHRyaWdnZXJpbmcgdGhlIGJlbG93IGt2bV9yZWdpb25fYWRkL2RlbCBjYWxscy4N
CiANClRoYW5rcywNClNoYW1lZXINCg0KPiBJZiBubyBhY3BpLCBubyBwcmludCBrdm1fcmVnaW9u
X2FkZC9kZWwgKDEwMDAgdGltZXMgcHJpbnQgb25jZSkNCj4gDQo+IElmIHdpdGggYWNwaT1mb3Jj
ZSwNCj4gRHVyaW5nIHFlbXUgYm9vdA0KPiBrdm1fcmVnaW9uX2FkZCByZWdpb25fYWRkID0gMTAw
MA0KPiBrdm1fcmVnaW9uX2RlbCByZWdpb25fZGVsID0gMTAwMA0KPiBrdm1fcmVnaW9uX2FkZCBy
ZWdpb25fYWRkID0gMjAwMA0KPiBrdm1fcmVnaW9uX2RlbCByZWdpb25fZGVsID0gMjAwMA0KPiBr
dm1fcmVnaW9uX2FkZCByZWdpb25fYWRkID0gMzAwMA0KPiBrdm1fcmVnaW9uX2RlbCByZWdpb25f
ZGVsID0gMzAwMA0KPiBrdm1fcmVnaW9uX2FkZCByZWdpb25fYWRkID0gNDAwMA0KPiBrdm1fcmVn
aW9uX2RlbCByZWdpb25fZGVsID0gNDAwMA0KPiBrdm1fcmVnaW9uX2FkZCByZWdpb25fYWRkID0g
NTAwMA0KPiBrdm1fcmVnaW9uX2RlbCByZWdpb25fZGVsID0gNTAwMA0KPiBrdm1fcmVnaW9uX2Fk
ZCByZWdpb25fYWRkID0gNjAwMA0KPiBrdm1fcmVnaW9uX2RlbCByZWdpb25fZGVsID0gNjAwMA0K
PiANCj4ga3ZtX3JlZ2lvbl9hZGQva3ZtX3JlZ2lvbl9kZWwgLT4NCj4ga3ZtX3NldF9waHlzX21l
bS0+DQo+IGt2bV9zZXRfdXNlcl9tZW1vcnlfcmVnaW9uLT4NCj4ga3ZtX3ZtX2lvY3RsKHMsIEtW
TV9TRVRfVVNFUl9NRU1PUllfUkVHSU9OLCAmbWVtKQ0KPiANCj4gW8KgIDM2MS4wOTQ0OTNdwqAg
X19zeW5jaHJvbml6ZV9zcmN1IGxvb3A9OTAwMA0KPiBbwqAgMzYxLjA5NDUwMV0gQ2FsbCB0cmFj
ZToNCj4gW8KgIDM2MS4wOTQ1MDJdwqAgZHVtcF9iYWNrdHJhY2UrMHhlNC8weGYwDQo+IFvCoCAz
NjEuMDk0NTA1XcKgIHNob3dfc3RhY2srMHgyMC8weDcwDQo+IFvCoCAzNjEuMDk0NTA3XcKgIGR1
bXBfc3RhY2tfbHZsKzB4OGMvMHhiOA0KPiBbwqAgMzYxLjA5NDUwOV3CoCBkdW1wX3N0YWNrKzB4
MTgvMHgzNA0KPiBbwqAgMzYxLjA5NDUxMV3CoCBfX3N5bmNocm9uaXplX3NyY3UrMHgxMjAvMHgx
MjgNCj4gW8KgIDM2MS4wOTQ1MTRdwqAgc3luY2hyb25pemVfc3JjdV9leHBlZGl0ZWQrMHgyYy8w
eDQwDQo+IFvCoCAzNjEuMDk0NTE1XcKgIGt2bV9zd2FwX2FjdGl2ZV9tZW1zbG90cysweDEzMC8w
eDE5OA0KPiBbwqAgMzYxLjA5NDUxOV3CoCBrdm1fYWN0aXZhdGVfbWVtc2xvdCsweDQwLzB4NjgN
Cj4gW8KgIDM2MS4wOTQ1MjBdwqAga3ZtX3NldF9tZW1zbG90KzB4MmY4LzB4M2IwDQo+IFvCoCAz
NjEuMDk0NTIzXcKgIF9fa3ZtX3NldF9tZW1vcnlfcmVnaW9uKzB4MmU0LzB4NDM4DQo+IFvCoCAz
NjEuMDk0NTI0XcKgIGt2bV9zZXRfbWVtb3J5X3JlZ2lvbisweDc4LzB4YjgNCj4gW8KgIDM2MS4w
OTQ1MjZdwqAga3ZtX3ZtX2lvY3RsKzB4NWEwLzB4MTNlMA0KPiBbwqAgMzYxLjA5NDUyOF3CoCBf
X2FybTY0X3N5c19pb2N0bCsweGIwLzB4ZjgNCj4gW8KgIDM2MS4wOTQ1MzBdwqAgaW52b2tlX3N5
c2NhbGwrMHg0Yy8weDExMA0KPiBbwqAgMzYxLjA5NDUzM13CoCBlbDBfc3ZjX2NvbW1vbi5jb25z
dHByb3AuMCsweDY4LzB4MTI4DQo+IFvCoCAzNjEuMDk0NTM2XcKgIGRvX2VsMF9zdmMrMHgzNC8w
eGMwDQo+IFvCoCAzNjEuMDk0NTM4XcKgIGVsMF9zdmMrMHgzMC8weDk4DQo+IFvCoCAzNjEuMDk0
NTQxXcKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YjgvMHhjMA0KPiBbwqAgMzYxLjA5NDU0NF3C
oCBlbDB0XzY0X3N5bmMrMHgxOGMvMHgxOTANCj4gW8KgIDM2My45NDI4MTddwqAga3ZtX3NldF9t
ZW1vcnlfcmVnaW9uIGxvb3A9NjAwMA0KPiANCj4gDQoNCg==
