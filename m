Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D4533734
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbiEYHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbiEYHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:16:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E61658D;
        Wed, 25 May 2022 00:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653462366; x=1684998366;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wEkQGZ/nmImOT7XHj9mUZ97ZvXI7vO0ezemDacQIh+8=;
  b=ZGPP/z9YkD2EV0t97BrSpY331KQcBdvT/HGXh8L0mqksd2kppKneZENs
   MySFDR23/d92ijMOKvCAuulLL9KYMvt3QRotGzH/B0tvsVp0wiFgHfzZC
   yM8I9rPXU/zkbajlXsto43jvuD92PJfQedEmnhk9HCCO8bLsmmFW+5rE8
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 May 2022 00:06:06 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 00:06:06 -0700
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 00:06:05 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::e8ce:9b2e:57f7:7afc]) by
 nasanex01a.na.qualcomm.com ([fe80::e8ce:9b2e:57f7:7afc%12]) with mapi id
 15.02.0986.022; Wed, 25 May 2022 00:06:05 -0700
From:   "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
To:     "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>,
        'Adrian Hunter' <adrian.hunter@intel.com>,
        quic_spathi <quic_spathi@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] mmc: core: Enable force hw reset
Thread-Topic: [PATCH V1] mmc: core: Enable force hw reset
Thread-Index: AQHYWUgDeSo2V0TNA0e+gb7Em5ZSiq0Ds3AAgCpmXG6AAT7bYA==
Date:   Wed, 25 May 2022 07:06:05 +0000
Message-ID: <f21c11f86bf94e9b881761b9176cc45e@quicinc.com>
References: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
 <7db46c19-a92a-a13a-eb63-38e5ed31580f@intel.com>
 <MWHPR0201MB3466CC9C676988E90D5D7D6FE3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR0201MB3466CC9C676988E90D5D7D6FE3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.25.114]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQpQbGVhc2UgZmluZCBjb21tZW50
cyBpbmxpbmUuDQoNClRoYW5rcywNClNhcnRoYWsNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBLYW1hc2FsaSBTYXR5YW5hcmF5YW4gKENvbnN1bHRhbnQpIChRVUlDKQ0K
PiA8cXVpY19rYW1hc2FsaUBxdWljaW5jLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDI0LCAy
MDIyIDU6MzMgUE0NCj4gVG86ICdBZHJpYW4gSHVudGVyJyA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBxdWljX3NwYXRoaQ0KPiA8cXVpY19zcGF0aGlAcXVpY2luYy5jb20+OyB1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnOyByaXRlc2hoQGNvZGVhdXJvcmEub3JnOw0KPiBhc3V0b3NoZEBjb2RlYXVy
b3JhLm9yZzsgYXhib2VAa2VybmVsLmRrOyBhdnJpLmFsdG1hbkB3ZGMuY29tOw0KPiBrY2hAbnZp
ZGlhLmNvbTsgQ0xvZWhsZUBoeXBlcnN0b25lLmNvbTsgc3dib3lkQGNocm9taXVtLm9yZzsNCj4g
ZGlnZXR4QGdtYWlsLmNvbTsgYmlnZWFzeUBsaW51dHJvbml4LmRlOyBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FydGhhayBHYXJn
IChRVUlDKSA8cXVpY19zYXJ0Z2FyZ0BxdWljaW5jLmNvbT4NCj4gQ2M6IFNoYWlrIFNhamlkYSBC
aGFudSA8c2JoYW51QGNvZGVhdXJvcmEub3JnPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxXSBt
bWM6IGNvcmU6IEVuYWJsZSBmb3JjZSBodyByZXNldA0KPiANCj4gSGksDQo+IFRoZXNlIHBhdGNo
ZXMgd2lsbCBiZSBmdXJ0aGVyIHRha2VuIGJ5IFNhcnRoYWsuDQo+IA0KPiBUaGFua3MsDQo+IFNh
dHlhDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVu
dGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAy
NywgMjAyMiA2OjA0IFBNDQo+IFRvOiBxdWljX3NwYXRoaSA8cXVpY19zcGF0aGlAcXVpY2luYy5j
b20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiByaXRlc2hoQGNvZGVhdXJvcmEub3JnOyBh
c3V0b3NoZEBjb2RlYXVyb3JhLm9yZzsgYXhib2VAa2VybmVsLmRrOw0KPiBhdnJpLmFsdG1hbkB3
ZGMuY29tOyBrY2hAbnZpZGlhLmNvbTsgQ0xvZWhsZUBoeXBlcnN0b25lLmNvbTsNCj4gc3dib3lk
QGNocm9taXVtLm9yZzsgZGlnZXR4QGdtYWlsLmNvbTsgYmlnZWFzeUBsaW51dHJvbml4LmRlOyBs
aW51eC0NCj4gbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogU2hhaWsgU2FqaWRhIEJoYW51IDxzYmhhbnVAY29kZWF1cm9yYS5vcmc+OyBLYW1h
c2FsaSBTYXR5YW5hcmF5YW4NCj4gKENvbnN1bHRhbnQpIChRVUlDKSA8cXVpY19rYW1hc2FsaUBx
dWljaW5jLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMV0gbW1jOiBjb3JlOiBFbmFibGUg
Zm9yY2UgaHcgcmVzZXQNCj4gDQo+IE9uIDI2LzA0LzIyIDExOjMwLCBTcmluaXZhc2FyYW8gUGF0
aGlwYXRpIHdyb3RlOg0KPiA+IEZyb206IFNoYWlrIFNhamlkYSBCaGFudSA8c2JoYW51QGNvZGVh
dXJvcmEub3JnPg0KPiA+DQo+ID4gRHVyaW5nIGVycm9yIHJlY292ZXJ5IHNldCBuZWVkIGh3IHJl
c2V0IHRvIGhhbmRsZSBJQ0UgZXJyb3Igd2hlcmUgY3FlDQo+ID4gcmVzZXQgaXMgbXVzdC4NCj4g
DQo+IEhvdyBkbyB5b3UgZ2V0IElDRSBlcnJvcnM/ICBEb2Vzbid0IGl0IG1lYW4gZWl0aGVyIHRo
ZSBoYXJkd2FyZSBpcyBicm9rZW4gb3INCj4gdGhlIGNvbmZpZ3VyYXRpb24gaXMgYnJva2VuPw0K
DQpUaGlzIHBhdGNoIGlzIG5vdCBpbnRlbmRlZCBmb3IgaWNlIGVycm9ycyBhbmQgd2lsbCB1cGRh
dGUgdGhlIGNvbW1pdCB0ZXh0IGluIFYyLg0KTG9uZyBiYWNrIGludGVybWl0dGVudCByZWNvdmVy
eSBmYWlsdXJlcyB3ZXJlIG9ic2VydmVkIGJ1dCBhZnRlciBmb3JjaW5nIGhhcmR3YXJlIHJlc2V0
IGR1cmluZyBlcnJvciByZWNvdmVyeSB3ZSBoYXZlIG5vIHNpbmdsZSBpbnN0YW5jZSBvZiByZWNv
dmVyeSBmYWlsdXJlLiBUaGlzIGhhdmUgbWFkZSByZWNvdmVyeSBtb3JlIHJvYnVzdCBmb3IgdXMu
DQpBbnkgc3VnZ2VzdGlvbnMgb24gaG93IHdlIGNhbiB0YWtlIGl0IGZvcndhcmQgd2lsbCBiZSBo
aWdobHkgYXBwcmVjaWF0ZWQuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhaWsgU2Fq
aWRhIEJoYW51IDxzYmhhbnVAY29kZWF1cm9yYS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieToga2Ft
YXNhbGkgPHF1aWNfa2FtYXNhbGlAcXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jp
bml2YXNhcmFvIFBhdGhpcGF0aSA8cXVpY19zcGF0aGlAcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyAgICAgIHwgOCArKysrKy0tLQ0KPiA+ICBkcml2
ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYyB8IDcgKysrKystLQ0KPiA+ICBpbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmggICAgICB8IDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGluZGV4DQo+ID4gYjM1ZTdh
OS4uZjYzYmYzMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4g
PiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiBAQCAtMTQ4MiwxMCArMTQ4Miwx
MiBAQCB2b2lkIG1tY19ibGtfY3FlX3JlY292ZXJ5KHN0cnVjdCBtbWNfcXVldWUNCj4gKm1xKQ0K
PiA+ICAJcHJfZGVidWcoIiVzOiBDUUUgcmVjb3Zlcnkgc3RhcnRcbiIsIG1tY19ob3N0bmFtZSho
b3N0KSk7DQo+ID4NCj4gPiAgCWVyciA9IG1tY19jcWVfcmVjb3ZlcnkoaG9zdCk7DQo+ID4gLQlp
ZiAoZXJyKQ0KPiA+ICsJaWYgKGVyciB8fCBob3N0LT5uZWVkX2h3X3Jlc2V0KSB7DQo+ID4gIAkJ
bW1jX2Jsa19yZXNldChtcS0+YmxrZGF0YSwgaG9zdCwNCj4gTU1DX0JMS19DUUVfUkVDT1ZFUlkp
Ow0KPiA+IC0JZWxzZQ0KPiA+IC0JCW1tY19ibGtfcmVzZXRfc3VjY2VzcyhtcS0+YmxrZGF0YSwN
Cj4gTU1DX0JMS19DUUVfUkVDT1ZFUlkpOw0KPiA+ICsJCWlmIChob3N0LT5uZWVkX2h3X3Jlc2V0
KQ0KPiA+ICsJCQlob3N0LT5uZWVkX2h3X3Jlc2V0ID0gZmFsc2U7DQo+ID4gKwl9DQo+ID4gKwlt
bWNfYmxrX3Jlc2V0X3N1Y2Nlc3MobXEtPmJsa2RhdGEsIE1NQ19CTEtfQ1FFX1JFQ09WRVJZKTsN
Cj4gPg0KPiA+ICAJcHJfZGVidWcoIiVzOiBDUUUgcmVjb3ZlcnkgZG9uZVxuIiwgbW1jX2hvc3Ru
YW1lKGhvc3QpKTsgIH0gZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS1j
b3JlLmMgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYw0KPiA+IGluZGV4IGIwZDMwYzMu
LjMxMWI1MTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS1jb3JlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYw0KPiA+IEBAIC04MTIsMTgg
KzgxMiwyMSBAQCBzdGF0aWMgdm9pZCBjcWhjaV9maW5pc2hfbXJxKHN0cnVjdCBtbWNfaG9zdA0K
PiA+ICptbWMsIHVuc2lnbmVkIGludCB0YWcpICBpcnFyZXR1cm5fdCBjcWhjaV9pcnEoc3RydWN0
IG1tY19ob3N0ICptbWMsIHUzMg0KPiBpbnRtYXNrLCBpbnQgY21kX2Vycm9yLA0KPiA+ICAJCSAg
ICAgIGludCBkYXRhX2Vycm9yKQ0KPiA+ICB7DQo+ID4gLQl1MzIgc3RhdHVzOw0KPiA+ICsJdTMy
IHN0YXR1cywgaWNlX2VycjsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgdGFnID0gMCwgY29tcF9zdGF0
dXM7DQo+ID4gIAlzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZhdGU7
DQo+ID4NCj4gPiAgCXN0YXR1cyA9IGNxaGNpX3JlYWRsKGNxX2hvc3QsIENRSENJX0lTKTsNCj4g
PiAgCWNxaGNpX3dyaXRlbChjcV9ob3N0LCBzdGF0dXMsIENRSENJX0lTKTsNCj4gPiArCWljZV9l
cnIgPSBzdGF0dXMgJiAoQ1FIQ0lfSVNfR0NFIHwgQ1FIQ0lfSVNfSUNDRSk7DQo+ID4NCj4gPiAg
CXByX2RlYnVnKCIlczogY3FoY2k6IElSUSBzdGF0dXM6IDB4JTA4eFxuIiwgbW1jX2hvc3RuYW1l
KG1tYyksDQo+ID4gc3RhdHVzKTsNCj4gPg0KPiA+ICAJaWYgKChzdGF0dXMgJiAoQ1FIQ0lfSVNf
UkVEIHwgQ1FIQ0lfSVNfR0NFIHwgQ1FIQ0lfSVNfSUNDRSkpIHx8DQo+ID4gLQkgICAgY21kX2Vy
cm9yIHx8IGRhdGFfZXJyb3IpDQo+ID4gKwkgICAgY21kX2Vycm9yIHx8IGRhdGFfZXJyb3IgfHwg
aWNlX2Vycil7DQo+ID4gKwkJbW1jLT5uZWVkX2h3X3Jlc2V0ID0gdHJ1ZTsNCj4gPiAgCQljcWhj
aV9lcnJvcl9pcnEobW1jLCBzdGF0dXMsIGNtZF9lcnJvciwgZGF0YV9lcnJvcik7DQo+ID4gKwl9
DQo+ID4NCj4gPiAgCWlmIChzdGF0dXMgJiBDUUhDSV9JU19UQ0MpIHsNCj4gPiAgCQkvKiByZWFk
IFRDTiBhbmQgY29tcGxldGUgdGhlIHJlcXVlc3QgKi8gZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVk
ZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGluZGV4DQo+ID4g
YzE5M2M1MC4uM2QwMGJjZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgNCj4gPiBAQCAtNDkyLDYgKzQ5
Miw3IEBAIHN0cnVjdCBtbWNfaG9zdCB7DQo+ID4gIAlpbnQJCQljcWVfcWRlcHRoOw0KPiA+ICAJ
Ym9vbAkJCWNxZV9lbmFibGVkOw0KPiA+ICAJYm9vbAkJCWNxZV9vbjsNCj4gPiArCWJvb2wgICAg
ICAgICAgICAgICAgICAgIG5lZWRfaHdfcmVzZXQ7DQo+ID4NCj4gPiAgCS8qIElubGluZSBlbmNy
eXB0aW9uIHN1cHBvcnQgKi8NCj4gPiAgI2lmZGVmIENPTkZJR19NTUNfQ1JZUFRPDQo+IA0KDQo=
