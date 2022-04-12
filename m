Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406A4FDAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391734AbiDLJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389894AbiDLJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:24:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7E022BC4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:39:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-oOBMiDLNNWyHBgOE2vxNfQ-1; Tue, 12 Apr 2022 09:39:29 +0100
X-MC-Unique: oOBMiDLNNWyHBgOE2vxNfQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 09:39:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 12 Apr 2022 09:39:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qais Yousef' <qais.yousef@arm.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Subject: RE: Scheduling tasks on idle cpu
Thread-Topic: Scheduling tasks on idle cpu
Thread-Index: AdhNfEgLjonPVH3ESQeb3O9OCn/HMQAeBEWAABN1gYA=
Date:   Tue, 12 Apr 2022 08:39:28 +0000
Message-ID: <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
In-Reply-To: <20220411233447.rcencjivkhyltyxm@airbuntu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUWFpcyBZb3VzZWYNCj4gU2VudDogMTIgQXByaWwgMjAyMiAwMDozNQ0KPiANCj4gT24g
MDQvMTEvMjIgMDg6MjYsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBRYWlzIFlvdXNl
Zg0KPiA+ID4gU2VudDogMDkgQXByaWwgMjAyMiAxODowOQ0KPiA+IC4uLg0KPiA+ID4gUlQgc2No
ZWR1bGVyIHdpbGwgcHVzaC9wdWxsIHRhc2tzIHRvIGVuc3VyZSB0aGUgdGFzayB3aWxsIGdldCB0
byBydW4gQVNBUCBpZg0KPiA+ID4gdGhlcmUncyBhbm90aGVyIGNwdSBhdCBsb3dlciBwcmlvcml0
eSBpcyBhdmFpbGFibGUNCj4gPg0KPiA+IERvZXMgdGhhdCBhY3R1YWxseSBoYXBwZW4/DQo+IA0K
PiBGb3IgUlQgdGFza3MsIHllcy4gVGhleSBzaG91bGQgZ2V0IGRpc3RyaWJ1dGVkLg0KDQpPaywg
dGhhdCBpcyBzb21ldGhpbmcgc2xpZ2h0bHkgZGlmZmVyZW50IGZyb20gd2hhdCBJJ20gc2VlaW5n
Lg0KDQo+ID4gSSd2ZSBzZWVuIHRoZSBmb2xsb3dpbmc6DQo+ID4gICAzNDUzMyBbMDE3XTogc3lz
X2Z1dGV4KHVhZGRyOiAxMDQ5MTA0LCBvcDogODUsIHZhbDogMSwgdXRpbWU6IDEsIHVhZGRyMjog
MTA0OTEwMCwgdmFsMzogNDAwMDAwMSkNCj4gPiAgIDM0NTMzIFswMTddOiBzY2hlZF9taWdyYXRl
X3Rhc2s6IHBpZD0zNDUxMiBwcmlvPTEyMCBvcmlnX2NwdT0xNCBkZXN0X2NwdT0xNw0KPiA+ICAg
MzQ1MzMgWzAxN106IHNjaGVkX3dha2V1cDogcGlkPTM0NTEyIHByaW89MTIwIHN1Y2Nlc3M9MSB0
YXJnZXRfY3B1PTAxNw0KPiANCj4gcHJpbz0xMjAgaXMgYSBDRlMgdGFzaywgbm8/DQoNCkNGUyA9
ICdub3JtYWwgdGltZS1zbGljZSBwcm9jZXNzZXMgPyBUaGVuIHllcy4NCg0KPiA+IGFuZCBwaWQg
MzQ1MTIgZG9lc24ndCBnZXQgc2NoZWR1bGVkIHVudGlsIHBpZCAzNDUzMyBmaW5hbGx5IHNsZWVw
cy4NCj4gPiBUaGlzIGlzIGluIHNwaXRlIG9mIHRoZXJlIGJlaW5nIDUgaWRsZSBjcHUuDQo+ID4g
Y3B1IDE0IGlzIGJ1c3kgcnVubmluZyBhIFJUIHRocmVhZCwgYnV0IG1pZ3JhdGluZyB0byBjcHUg
MTcgc2VlbXMgd3JvbmcuDQo+ID4NCj4gPiBUaGlzIGlzIG9uIGEgUkhFTDcga2VybmVsLCBJJ3Zl
IG5vdCByZXBsaWNhdGVkIGl0IG9uIGFueXRoaW5nIHJlY2VudC4NCj4gPiBCdXQgSSd2ZSB2ZXJ5
IG11Y2ggbGlrZSBhIFJUIHRocmVhZCB0byBiZSBhYmxlIHRvIHNjaGVkdWxlIGEgbm9uLVJUDQo+
ID4gdGhyZWFkIHRvIHJ1biBvbiBhbiBpZGxlIGNwdS4NCj4gDQo+IE9oLCB5b3Ugd2FudCBDRlMg
dG8gYXZvaWQgQ1BVcyB0aGF0IGFyZSBydW5uaW5nIFJUIHRhc2tzLg0KPiANCj4gV2UgaGFkIGEg
cHJvcG9zYWwgaW4gdGhlIHBhc3QsIGJ1dCBpdCB3YXNuJ3QgZ29vZCBlbm91Z2gNCj4gDQo+IAlo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE1NjcwNDg1MDItNjA2NC0xLWdpdC1zZW5kLWVt
YWlsLWppbmctdGluZy53dUBtZWRpYXRlay5jb20vDQoNClRoYXQgc2VlbXMgdG8gYmUgc29tZXRo
aW5nIGRpZmZlcmVudC4NClJlbGF0ZWQgdG8gc29tZXRoaW5nIGVsc2UgSSd2ZSBzZWVuIHdoZXJl
IGEgUlQgcHJvY2VzcyBpcyBzY2hlZHVsZWQNCm9uIGl0cyBvbGQgY3B1ICh0byBnZXQgdGhlIGhv
dCBjYWNoZSkgYnV0IHRoZSBwcm9jZXNzIHJ1bm5pbmcgb24NCnRoYXQgY3B1IGlzIGxvb3Bpbmcg
aW4ga2VybmVsIC0gc28gdGhlIFJUIHByb2Nlc3MgZG9lc24ndCBzdGFydC4NCg0KSSd2ZSBhdm9p
ZGVkIG1vc3Qgb2YgdGhlIHBhaW4gdGhhdCBjYXVzZWQgYnkgbm90IHVzaW5nIGEgc2luZ2xlDQpj
dl9icm9hZGNhc3QoKSB0byB3YWtlIHVwIHRoZSAzNCBSVCB0aHJlYWRzIChpbiB0aGlzIGNvbmZp
ZykuDQooRWFjaCBrZXJuZWwgdGhyZWFkIHNlZW1lZCB0byB3YWtlIHVwIHRoZSBuZXh0IG9uZSwg
c28gdGhlDQpkZWxheXMgd2VyZSBjdW11bGF0aXZlLikNCkluc3RlYWQgdGhlcmUgaXMgYSBzZXBh
cmF0ZSBjdiBmb3IgZWFjaCBSVCB0aHJlYWQuDQpJIGFjdHVhbGx5IHdhbnQgdGhlICdoZXJkIG9m
IHdpbGRlYmVlc3QnIDotKQ0KDQo+IFRoZSBhcHByb2FjaCBpbiB0aGF0IHBhdGNoIG1vZGlmaWVk
IFJUIHRvIGF2b2lkIENGUyBhY3R1YWxseS4NCg0KWWVzIEkgd2FudCB0aGUgQ0ZTIHNjaGVkdWxl
ciB0byBwaWNrIGFuIGlkbGUgY3B1IGluIHByZWZlcmVuY2UNCnRvIGFuIGFjdGl2ZSBSVCBvbmUu
DQoNCj4gQ2FuIHlvdSB2ZXJpZnkgd2hldGhlciB0aGUgUlQgdGFzayB3b2tlIHVwIGFmdGVyIHRh
c2sgMzQ1MTIgd2FzIG1pZ3JhdGVkIHRvIENQVQ0KPiAxNz8gTG9va2luZyBhdCB0aGUgZGVmaW5p
dGlvbiBvZiBhdmFpbGFibGVfaWRsZV9jcHUoKSB3ZSBzaG91bGQgaGF2ZSBhdm9pZGVkDQo+IHRo
YXQgQ1BVIGlmIHRoZSBSVCB0YXNrIHdhcyBhbHJlYWR5IHJ1bm5pbmcuIEJvdGggd2FraW5nIHVw
IGF0IHRoZSBzYW1lIHRpbWUNCj4gd291bGQgZXhwbGFpbiB3aGF0IHlvdSBzZWUuIE90aGVyd2lz
ZSBJJ20gbm90IHN1cmUgd2h5IGl0IHBpY2tlZCBDUFUgMTcuDQoNCkFsbCAzNSBSVCB0YXNrcyBh
cmUgcnVubmluZyB3aGVuIHRoZSByZXF1ZXN0IHRvIHNjaGVkdWxlIHRhc2sgMzQ1MTIgaXMgbWFk
ZS4NCihUaGV5IHdha2UgZXZlcnkgMTBtcyB0byBwcm9jZXNzIFVEUC9SVFAgYXVkaW8gcGFja2V0
cy4pDQpUaGUgUlQgdGFzayBvbiBjcHUgMTcgY2FycmllZCBvbiBydW5uaW5nIHVudGlsIGl0IHJh
biBvdXQgb2Ygd29yayAoYWZ0ZXIgYWJvdXQgMW1zKS4NClRhc2sgMzQ1MTIgdGhlbiByYW4gb24g
Y3B1IDE3Lg0KDQpJbiB0aGlzIGNhc2UgdGFzayAzNDUxMiBhY3R1YWxseSBmaW5pc2hlZCBxdWl0
ZSBxdWlja2x5Lg0KKEl0IGlzIGNyZWF0aW5nIGFuZCBiaW5kaW5nIG1vcmUgVURQIHNvY2tldHMu
KQ0KQnV0IGl0IGxvb2tzIGxpa2UgaWYgaXQgd2VyZSBzdGlsbCBydW5uaW5nIG9uIHRoZSBuZXh0
IDEwbXMgJ3RpY2snDQppdCB3b3VsZCBiZSBwcmUtZW1wdGVkIGJ5IHRoZSBSVCB0YXNrIGFuZCBi
ZSBpZGxlLg0KTm90IGlkZWFsIHdoZW4gSSdtIHRyeWluZyB0byBzY2hlZHVsZSBhIGJhY2tncm91
bmQgYWN0aXZpdHkuDQoNCkkgZG9uJ3QgdGhpbmsgdGhlIGxvYWQtYmFsYW5jZXIgd2lsbCBldmVy
IHBpY2sgaXQgdXAuDQpBbGwgdGhlIHByb2Nlc3Mgc2NoZWR1bGluZyBpcyBoYXBwZW5pbmcgZmFy
IHRvbyBmYXN0Lg0KDQpXaGF0IEkgdGhpbmsgbWlnaHQgYmUgaGFwcGVuaW5nIGlzIHRoYXQgdGhl
IGZ1dGV4KCkgY29kZSBpcyByZXF1ZXN0aW5nDQp0aGUgd29rZW4gdXAgdGhyZWFkIHJ1biBvbiB0
aGUgY3VycmVudCBjcHUuDQpUaGlzIGNhbiBiZSBhZHZhbnRhZ2VvdXMgaW4gc29tZSBjaXJjdW1z
dGFuY2VzIC0gdXN1YWxseSBpZiB5b3UNCmtub3cgdGhlIGN1cnJlbnQgdGhyZWFkIGlzIGFib3V0
IHRvIHNsZWVwLg0KKEkgcmVtZW1iZXIgYW5vdGhlciBzY2hlZHVsZXIgZG9pbmcgdGhhdCwgYnV0
IEkgY2FuJ3QgcmVtZW1iZXIgd2h5IQ0KVGhlIG9ubHkgc2VxdWVuY2UgSSBjYW4gdGhpbmsgb2Yg
aXMgYSBzaGVsbCBkb2luZyBmb3JrK2V4ZWMrd2FpdC4pDQpCdXQgaXQgc2VlbXMgbGlrZSBhIGJh
ZCBpZGVhIHdoZW4gYSBSVCB0aHJlYWQgaXMgd2FraW5nIGEgQ0ZTIG9uZS4NCihPciBhbnkgY2Fz
ZSB3aGVyZSB0aGUgb25lIGJlaW5nIHdva2VuIGlzIGxvd2VyIHByaW9yaXR5LikNCg0KSSBtaWdo
dCBoYXZlIHRvIHJ1biB0aGUgJ2JhY2tncm91bmQgdGFza3MnIGF0IGxvdyBSVCBwcmlvcml0eQ0K
anVzdCB0byBnZXQgdGhlbSBzY2hlZHVsZWQgb24gaWRsZSBjcHUuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

