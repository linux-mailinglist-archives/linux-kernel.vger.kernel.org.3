Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E358975B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbiHDFe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiHDFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:34:57 -0400
Received: from spam.unicloud.com (smgmail.unigroup.com.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABD474E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:34:53 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 2745WPDL028081;
        Thu, 4 Aug 2022 13:32:25 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from zgys-ex-mb09.Unicloud.com (10.10.0.24) by
 zgys-ex-mb10.Unicloud.com (10.10.0.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Thu, 4 Aug 2022 13:32:24 +0800
Received: from zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa]) by
 zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa%16]) with mapi id
 15.01.2375.017; Thu, 4 Aug 2022 13:32:24 +0800
From:   =?gb2312?B?wt63yQ==?= <luofei@unicloud.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtbSwgaHdwb2lzb24sIGh1Z2V0bGI6IEZyZWUgaHdw?=
 =?gb2312?B?b2lzb24gaHVnZSBwYWdlIHRvIGxpc3QgdGFpbCBhbmQgZGlzc29sdmUgaHdw?=
 =?gb2312?Q?oison_huge_page_first?=
Thread-Topic: [PATCH] mm, hwpoison, hugetlb: Free hwpoison huge page to list
 tail and dissolve hwpoison huge page first
Thread-Index: AQHYpletHIJsP7smmUWPl05kT9nW0K2bT4CAgAIr5oCAALWHDA==
Date:   Thu, 4 Aug 2022 05:32:24 +0000
Message-ID: <5f3634ada9c5485cb13538eaf635a852@unicloud.com>
References: <20220802100711.2425644-1-luofei@unicloud.com>
 <YulXz+1iLHuZBEDb@monkey>,<1191d45b-fece-659b-1dd1-8cf4ce89c2f1@huawei.com>
In-Reply-To: <1191d45b-fece-659b-1dd1-8cf4ce89c2f1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.1.7]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam.unicloud.com 2745WPDL028081
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+IFNpZ25lZC1vZmYtYnk6IGx1b2ZlaSA8bHVvZmVpQHVuaWNsb3VkLmNvbT4NCj4+PiAtLS0N
Cj4+PiAgbW0vaHVnZXRsYi5jIHwgMTMgKysrKysrKystLS0tLQ0KPj4+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0KPj4+IGluZGV4IDI4NTE2ODgxYTFiMi4uY2E3
MjIyMGVlZGQ5IDEwMDY0NA0KPj4+IC0tLSBhL21tL2h1Z2V0bGIuYw0KPj4+ICsrKyBiL21tL2h1
Z2V0bGIuYw0KPj4+IEBAIC0xMTE2LDcgKzExMTYsMTAgQEAgc3RhdGljIHZvaWQgZW5xdWV1ZV9o
dWdlX3BhZ2Uoc3RydWN0IGhzdGF0ZSAqaCwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4gICAgICAg
bG9ja2RlcF9hc3NlcnRfaGVsZCgmaHVnZXRsYl9sb2NrKTsNCj4+PiAgICAgICBWTV9CVUdfT05f
UEFHRShwYWdlX2NvdW50KHBhZ2UpLCBwYWdlKTsNCj4+Pg0KPj4+IC0gICAgbGlzdF9tb3ZlKCZw
YWdlLT5scnUsICZoLT5odWdlcGFnZV9mcmVlbGlzdHNbbmlkXSk7DQo+Pj4gKyAgICBpZiAodW5s
aWtlbHkoUGFnZUhXUG9pc29uKHBhZ2UpKSkNCj4+PiArICAgICAgICAgICAgbGlzdF9tb3ZlX3Rh
aWwoJnBhZ2UtPmxydSwgJmgtPmh1Z2VwYWdlX2ZyZWVsaXN0c1tuaWRdKTsNCj4+PiArICAgIGVs
c2UNCj4+PiArICAgICAgICAgICAgbGlzdF9tb3ZlKCZwYWdlLT5scnUsICZoLT5odWdlcGFnZV9m
cmVlbGlzdHNbbmlkXSk7DQo+Pj4gICAgICAgaC0+ZnJlZV9odWdlX3BhZ2VzKys7DQo+Pj4gICAg
ICAgaC0+ZnJlZV9odWdlX3BhZ2VzX25vZGVbbmlkXSsrOw0KPj4+ICAgICAgIFNldEhQYWdlRnJl
ZWQocGFnZSk7DQo+Pj4gQEAgLTExMzMsNyArMTEzNiw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAq
ZGVxdWV1ZV9odWdlX3BhZ2Vfbm9kZV9leGFjdChzdHJ1Y3QgaHN0YXRlICpoLCBpbnQgbmlkKQ0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+Pg0KPj4+ICAgICAgICAgICAg
ICAgaWYgKFBhZ2VIV1BvaXNvbihwYWdlKSkNCj4+PiAtICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4+PiArICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+DQo+PiBJSVJDLCBpdCBp
cyAncG9zc2libGUnIHRvIHVucG9pc29uIGEgcGFnZSB2aWEgdGhlIGRlYnVnL3Rlc3RpbmcgaW50
ZXJmYWNlcy4NCj4+IElmIHNvLCB0aGVuIHdlIGNvdWxkIGVuZCB1cCB3aXRoIGZyZWUgdW5wb2lz
aW9uZWQgcGFnZShzKSBhdCB0aGUgZW5kIG9mDQo+PiB0aGUgbGlzdCB0aGF0IHdvdWxkIG5ldmVy
IGJlIHVzZWQgYmVjYXVzZSB3ZSBxdWl0IHdoZW4gZW5jb3VudGVyaW5nIGENCj4+IHBvaXNpb25l
ZCBwYWdlLg0KPg0KPklJVUMsIGFib3ZlIHNjZW5lIHdpbGwgYWN0dWFsbHkgaGFwcGVuLiBXaGF0
J3MgbW9yZSwgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UgbWlnaHQgZmFpbCBhZnRlciBodWdldGxi
DQo+cGFnZSBpcyBod3BvaXNvbmVkIGR1ZSB0byBlLmcuIGFsbCBodWdldGxiIHBhZ2VzIGFyZSBy
ZXNlcnZlZC4gSW4gdGhhdCBjYXNlLCB0aGUgaHdwb2lzb25lZCBodWdldGxiIHBhZ2UNCj5pcyBu
b3QgbW92ZWQgdG8gdGhlIHRhaWwgb2YgaHVnZXBhZ2VfZnJlZWxpc3RzIGFuZCB0aHVzIGNhdXNl
IHByb2JsZW1zLg0KDQpZZXMsIGJvdGggY2FzZXMgY291bGQgaGFwcGVuLg0KSSB0aGluayB0aGUg
a2V5IHByb2JsZW0gaXMgd2hlbiB0aGUgaHVnZXBhZ2UgYWxyZWFkeSBpbiB0aGUgZnJlZSBsaXN0
LCBhbmQgaWYgdGhlIGh3cG9pc29uDQpmbGFnIGNoYW5nZWQgYXQgdGhpcyB0aW1lKHN1Y2ggYXMg
dW5wb2lzb24gb3IgbWNlIGV2ZW50KSwgYWZ0ZXIgdGhlIHByb2Nlc3NpbmcgaXMgZG9uZSwNCmFu
ZCB0aGUgaHVnZSBwYWdlIHN0aWxsIGluIGZyZWUgbGlzdCwgaXQgc2hvdWxkIGJlIGRlbGV0ZWQg
YW5kIHJlaW5zZXJ0ZWQgaW50byBjb3JyZWN0IHBvc2l0aW9uLg0KDQpJZiB0aGUgaHVnZSBwYWdl
IG1heSBzdGlsbCBleGlzdCBpbiB0aGUgZnJlZSBsaXN0IGFmdGVyIHJlY2VudCBjaGFuZ2VzIHRv
IGh1Z2V0bGIgcG9pc29uaW5nIGNvZGUsDQpJIHdpbGwgcmVzdWJtaXQgYSBuZXcgcGF0Y2guDQoN
ClRoYW5rcy4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7I
yzogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQq3osvNyrG85DogMjAyMsTqONTC
NMjVIDEwOjA4OjMzDQrK1bz+yMs6IE1pa2UgS3JhdmV0ejsgwt63yQ0Ks63LzTogTmFveWEgSG9y
aWd1Y2hpOyBzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM
4jogUmU6IFtQQVRDSF0gbW0sIGh3cG9pc29uLCBodWdldGxiOiBGcmVlIGh3cG9pc29uIGh1Z2Ug
cGFnZSB0byBsaXN0IHRhaWwgYW5kIGRpc3NvbHZlIGh3cG9pc29uIGh1Z2UgcGFnZSBmaXJzdA0K
DQpPbiAyMDIyLzgvMyAwOjU4LCBNaWtlIEtyYXZldHogd3JvdGU6DQo+IE9uIDA4LzAyLzIyIDA2
OjA3LCBsdW9mZWkgd3JvdGU6DQo+PiBJZiBmcmVlIGh3cG9pc29uIGh1Z2UgcGFnZSB0byB0aGUg
ZW5kIG9mIGh1Z2VwYWdlX2ZyZWVsaXN0cywgdGhlDQo+PiBsb29wIGNhbiBleGl0IGRpcmVjdGx5
IHdoZW4gdGhlIGh3cG9pc29uIGh1Z2UgcGFnZSBpcyB0cmF2ZXJzZWQsDQo+PiB3aGljaCBjYW4g
ZWZmZWN0aXZlbHkgcmVkdWNlIHRoZSByZXBlYXRlZCB0cmF2ZXJzYWwgb2YgdGhlIGh3cG9pc29u
DQo+PiBodWdlIHBhZ2UuIE1lYW53aGlsZSwgd2hlbiBmcmVlIHRoZSBmcmVlIGh1Z2UgcGFnZXMg
dG8gbG93ZXIgbGV2ZWwNCj4+IGFsbG9jYXRvcnMsIGlmIGh3cG9pc29uIG9uZXMgYXJlIHJlbGVh
c2VkIGZpcnN0LCB0aGlzIGNhbiBpbXByb3ZlDQo+PiB0aGUgZWZmZWN2aXZlIHV0aWxpemF0aW9u
IHJhdGUgb2YgaHVnZSBwYWdlLg0KPg0KPiBJbiBnZW5lcmFsLCBJIHRoaW5rIHRoaXMgaXMgYSBn
b29kIGlkZWEuICBBbHRob3VnaCwgaXQgc2VlbXMgdGhhdCB3aXRoDQo+IHJlY2VudCBjaGFuZ2Vz
IHRvIGh1Z2V0bGIgcG9pc2lvbmluZyBjb2RlIHdlIGFyZSBldmVuIGxlc3MgbGlrZWx5IHRvDQo+
IGhhdmUgYSBwb2lzaW9uZWQgcGFnZSBvbiBodWdldGxiIGZyZWUgbGlzdHMuDQo+DQo+IEFkZGlu
ZyBOYW95YSBhbmQgTWlhb2hlIGFzIHRoZXkgaGF2ZSBiZWVuIGxvb2tpbmcgYXQgcGFnZSBwb2lz
b24gb2YgaHVnZXRsYg0KPiBwYWdlcyByZWNlbnRseS4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IGx1
b2ZlaSA8bHVvZmVpQHVuaWNsb3VkLmNvbT4NCj4+IC0tLQ0KPj4gIG1tL2h1Z2V0bGIuYyB8IDEz
ICsrKysrKysrLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9tbS9odWdldGxiLmMgYi9tbS9odWdldGxi
LmMNCj4+IGluZGV4IDI4NTE2ODgxYTFiMi4uY2E3MjIyMGVlZGQ5IDEwMDY0NA0KPj4gLS0tIGEv
bW0vaHVnZXRsYi5jDQo+PiArKysgYi9tbS9odWdldGxiLmMNCj4+IEBAIC0xMTE2LDcgKzExMTYs
MTAgQEAgc3RhdGljIHZvaWQgZW5xdWV1ZV9odWdlX3BhZ2Uoc3RydWN0IGhzdGF0ZSAqaCwgc3Ry
dWN0IHBhZ2UgKnBhZ2UpDQo+PiAgICAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmh1Z2V0bGJfbG9j
ayk7DQo+PiAgICAgIFZNX0JVR19PTl9QQUdFKHBhZ2VfY291bnQocGFnZSksIHBhZ2UpOw0KPj4N
Cj4+IC0gICAgbGlzdF9tb3ZlKCZwYWdlLT5scnUsICZoLT5odWdlcGFnZV9mcmVlbGlzdHNbbmlk
XSk7DQo+PiArICAgIGlmICh1bmxpa2VseShQYWdlSFdQb2lzb24ocGFnZSkpKQ0KPj4gKyAgICAg
ICAgICAgIGxpc3RfbW92ZV90YWlsKCZwYWdlLT5scnUsICZoLT5odWdlcGFnZV9mcmVlbGlzdHNb
bmlkXSk7DQo+PiArICAgIGVsc2UNCj4+ICsgICAgICAgICAgICBsaXN0X21vdmUoJnBhZ2UtPmxy
dSwgJmgtPmh1Z2VwYWdlX2ZyZWVsaXN0c1tuaWRdKTsNCj4+ICAgICAgaC0+ZnJlZV9odWdlX3Bh
Z2VzKys7DQo+PiAgICAgIGgtPmZyZWVfaHVnZV9wYWdlc19ub2RlW25pZF0rKzsNCj4+ICAgICAg
U2V0SFBhZ2VGcmVlZChwYWdlKTsNCj4+IEBAIC0xMTMzLDcgKzExMzYsNyBAQCBzdGF0aWMgc3Ry
dWN0IHBhZ2UgKmRlcXVldWVfaHVnZV9wYWdlX25vZGVfZXhhY3Qoc3RydWN0IGhzdGF0ZSAqaCwg
aW50IG5pZCkNCj4+ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4NCj4+ICAgICAg
ICAgICAgICBpZiAoUGFnZUhXUG9pc29uKHBhZ2UpKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+PiArICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4NCj4gSUlSQywgaXQg
aXMgJ3Bvc3NpYmxlJyB0byB1bnBvaXNvbiBhIHBhZ2UgdmlhIHRoZSBkZWJ1Zy90ZXN0aW5nIGlu
dGVyZmFjZXMuDQo+IElmIHNvLCB0aGVuIHdlIGNvdWxkIGVuZCB1cCB3aXRoIGZyZWUgdW5wb2lz
aW9uZWQgcGFnZShzKSBhdCB0aGUgZW5kIG9mDQo+IHRoZSBsaXN0IHRoYXQgd291bGQgbmV2ZXIg
YmUgdXNlZCBiZWNhdXNlIHdlIHF1aXQgd2hlbiBlbmNvdW50ZXJpbmcgYQ0KPiBwb2lzaW9uZWQg
cGFnZS4NCg0KSUlVQywgYWJvdmUgc2NlbmUgd2lsbCBhY3R1YWxseSBoYXBwZW4uIFdoYXQncyBt
b3JlLCBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZSBtaWdodCBmYWlsIGFmdGVyIGh1Z2V0bGINCnBh
Z2UgaXMgaHdwb2lzb25lZCBkdWUgdG8gZS5nLiBhbGwgaHVnZXRsYiBwYWdlcyBhcmUgcmVzZXJ2
ZWQuIEluIHRoYXQgY2FzZSwgdGhlIGh3cG9pc29uZWQgaHVnZXRsYiBwYWdlDQppcyBub3QgbW92
ZWQgdG8gdGhlIHRhaWwgb2YgaHVnZXBhZ2VfZnJlZWxpc3RzIGFuZCB0aHVzIGNhdXNlIHByb2Js
ZW1zLg0KDQpUaGFua3MgYm90aC4NCg0KPg0KPiBOYW95YSBhbmQgTWlhb2hlIHdvdWxkIGtub3cg
Zm9yIHN1cmUuDQo+DQo+IFNhbWUgcG9zc2libGUgaXNzdWUgaW4gZGVtb3RlX3Bvb2xfaHVnZV9w
YWdlKCkuDQo+DQoNCg==
