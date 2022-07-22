Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0100057DB07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiGVHRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiGVHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:17:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A399642;
        Fri, 22 Jul 2022 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658474158; x=1690010158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e6uYYbPjV1VvUGQvGA+pOMVAexWyDfZ24F8gdv5TEWs=;
  b=BHHSHKdSEpBFy3fjox3ZG/zGLAdgOEy3bTcAjgBoNaTBVZQG7pahIINS
   O39YKlZ5OjtqxTc/pRG3bcfKrd7hLnlSUxaHjPnxjBYbM/tOOFR0SjuvG
   RqftRuGhP/kIk5v5jSt393heTKhRbBzKxnXrEuWnlPZWsgm2tmqW0VeV5
   tkvnk0jX86sqcAb4z/qDujr0ksLVhyxwTOi7JXufrB23o064GA8C2MoWf
   2QIoZmQpYKCUF/61FaREk9eIX+Cfqq7s/wKyGhPwMYdmlCcXOddqZqOJU
   d1PQu5lyR9HVBVPHW38UlWzw8VyJmHJOm4MSNGtmKMisHEDVdgE3B2Wo3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267651967"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="267651967"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 00:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="844684353"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2022 00:15:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 00:15:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 00:15:57 -0700
Received: from fmsmsx611.amr.corp.intel.com ([10.18.126.91]) by
 fmsmsx611.amr.corp.intel.com ([10.18.126.91]) with mapi id 15.01.2375.028;
 Fri, 22 Jul 2022 00:15:56 -0700
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "quic_manafm@quicinc.com" <quic_manafm@quicinc.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Thread-Topic: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Thread-Index: AQHYmI8oPO5l9TAj9UGwIhJx3geWKK2EmOKA///97ICAAU1xgP//4HYAgAD6JQCAAk+PAIAA87JQ
Date:   Fri, 22 Jul 2022 07:15:56 +0000
Message-ID: <86eac26233874ff389498e24c8253e0c@intel.com>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org>
 <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
 <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
 <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
 <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org>
 <e3bfb483aa6ce09756b38b3a568fac819b154beb.camel@intel.com>
 <f0c217a2-7df0-c8ed-d2ae-c6019c7600d8@linaro.org>
In-Reply-To: <f0c217a2-7df0-c8ed-d2ae-c6019c7600d8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.108.32.68]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDIxLCAy
MDIyIDU6MzUgUE0NCj4gVG86IFpoYW5nLCBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+OyByYWZh
ZWxAa2VybmVsLm9yZw0KPiBDYzogcXVpY19tYW5hZm1AcXVpY2luYy5jb207IGFtaXRrQGtlcm5l
bC5vcmc7IGx1a2Fzei5sdWJhQGFybS5jb207DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMv
NF0gdGhlcm1hbC9jb3JlOiBCdWlsZCBhc2NlbmRpbmcgb3JkZXJlZCBpbmRleGVzDQo+IGZvciB0
aGUgdHJpcCBwb2ludHMNCj4gSW1wb3J0YW5jZTogSGlnaA0KPiANCj4gT24gMTkvMDcvMjAyMiAx
NjoxNywgWmhhbmcgUnVpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMi0wNy0xOSBhdCAwOToyMiAr
MDIwMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4+IE9uIDE5LzA3LzIwMjIgMDM6MTQsIFpo
YW5nIFJ1aSB3cm90ZToNCj4gPj4+IE9uIE1vbiwgMjAyMi0wNy0xOCBhdCAxNToyMSArMDIwMCwg
RGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBIaSBaaGFuZywNCj4gPj4+Pg0K
PiA+Pj4+IHRoYW5rcyBmb3IgdGhlIHJldmlldw0KPiA+Pj4+DQo+ID4+Pj4gT24gMTgvMDcvMjAy
MiAwNzoyOCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+Pj4+PiBPbiBGcmksIDIwMjItMDctMTUgYXQg
MjM6MDkgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gWyAuLi4g
XQ0KPiA+Pj4+DQo+ID4+Pj4+PiBJbnN0ZWFkIG9mIHRha2luZyB0aGUgcmlzayBvZiBicmVha2lu
ZyB0aGUgZXhpc3RpbmcgcGxhdGZvcm1zLA0KPiA+Pj4+Pj4gdXNlIGFuIGFycmF5IG9mIHRlbXBl
cmF0dXJlIG9yZGVyZWQgdHJpcCBpZGVudGlmaWVycyBhbmQgbWFrZSBpdA0KPiA+Pj4+Pj4gYXZh
aWxhYmxlIGZvciB0aGUgY29kZSBuZWVkaW5nIHRvIGJyb3dzZSB0aGUgdHJpcCBwb2ludHMgaW4g
YW4NCj4gPj4+Pj4+IG9yZGVyZWQgd2F5Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiA+Pj4+Pj4g
LS0tDQo+ID4+Pj4NCj4gPj4+PiBbIC4uLiBdDQo+ID4+Pj4NCj4gPj4+Pj4+ICtzdGF0aWMgdm9p
ZCBzb3J0X3RyaXBzX2luZGV4ZXMoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UNCj4gPj4+Pj4+
ICp0eikNCj4gPj4+Pj4+ICt7DQo+ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqBpbnQgaSwgajsNCj4g
Pj4+Pj4+ICsNCj4gPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCB0ei0+dHJp
cHM7IGkrKykNCj4gPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0ei0+dHJp
cHNfaW5kZXhlc1tpXSA9IGk7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqBm
b3IgKGkgPSAwOyBpIDwgdHotPnRyaXBzOyBpKyspIHsNCj4gPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBmb3IgKGogPSBpICsgMTsgaiA8IHR6LT50cmlwczsgaisrKSB7DQo+
ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlu
dCB0MSwgdDI7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHR6LT5vcHMtPmdldF90cmlwX3RlbXAodHosIHR6LQ0KPiA+
Pj4+Pj4+IHRyaXBzX2luZGV4ZXNbaV0sICZ0MSk7DQo+ID4+Pj4+DQo+ID4+Pj4+IFRoaXMgbGlu
ZSBjYW4gYmUgbW92ZWQgdG8gdGhlIHVwcGVyIGxvb3AuDQo+ID4+Pj4NCj4gPj4+PiBSaWdodCwg
dGhhbmtzIQ0KPiA+Pj4+DQo+ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHR6LT5vcHMtPmdldF90cmlwX3RlbXAodHosIHR6LQ0KPiA+Pj4+Pj4+
IHRyaXBzX2luZGV4ZXNbal0sICZ0Mik7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+DQo+ID4+Pj4+IHdo
YXQgYWJvdXQgdGhlIGRpc2FibGVkIHRyaXAgcG9pbnRzPw0KPiA+Pj4+Pg0KPiA+Pj4+PiB3ZSBz
aG91bGQgaWdub3JlIHRob3NlIHRyaXAgcG9pbnRzIGFuZCBjaGVjayB0aGUgcmV0dXJuIHZhbHVl
IHRvDQo+ID4+Pj4+IG1ha2Ugc3VyZSB3ZSdyZSBjb21wYXJpbmcgdGhlIHZhbGlkIHRyaXBfdGVt
cCB2YWx1ZXMuDQo+ID4+Pj4NCj4gPj4+PiBXZSBkb24ndCBoYXZlIHRvIGNhcmUgYWJvdXQsIHdo
YXRldmVyIHRoZSBwb3NpdGlvbiwgdGhlDQo+ID4+Pj4gY29ycmVzcG9uZGluZyB0cmlwIGlkIHdp
bGwgYmUgZGlzYWJsZWQgYnkgdGhlIHRyaXAgaW5pdCBmdW5jdGlvbg0KPiA+Pj4+IGJlZm9yZSBj
YWxsaW5nIHRoaXMgb25lIGFuZCBpZ25vcmVkIGluIHRoZSBoYW5kbGVfdGhlcm1hbF90cmlwKCkN
Cj4gPj4+PiBmdW5jdGlvbg0KPiA+Pj4NCj4gPj4+IGhhaCwgSSBtaXNzZWQgdGhpcyBvbmUgYW5k
IHJlcGxpZWQgdG8geW91ciBsYXRlc3QgcmVwbHkgZGlyZWN0bHkuDQo+ID4+Pg0KPiA+Pj4gVGhl
IHRoaW5nIEknbSBjb25jZXJuaW5nIGlzIHRoYXTCoGlmIHdlIGRvbid0IGNoZWNrIHRoZSByZXR1
cm4gdmFsdWUsDQo+ID4+PiBmb3IgYSBkaXNhYmxlZCB0cmlwIHBvaW50LCB0aGUgdHJpcF90ZW1w
ICh0MS90MikgcmV0dXJuZWQgaXMgc29tZQ0KPiA+Pj4gcmFuZG9tIHZhbHVlLCBpdCBhbGwgZGVw
ZW5kcyBvbiB0aGUgcHJldmlvdXMgdmFsdWUgc2V0IGJ5IGxhc3QNCj4gPj4+IHN1Y2Nlc3NmdWwg
LmdldF90cmlwX3RlbXAoKSwgYW5kIHRoaXMgbWF5IHNjcmV3IHVwIHRoZSBzb3J0aW5nLg0KPiA+
Pg0KPiA+PiBUaGUgaW5kZXhlcyBhcnJheSBpcyB0aGUgc2FtZSBzaXplIGFzIHRoZSB0cmlwIGFy
cmF5LCB0aGF0IG1ha2VzIHRoZQ0KPiA+PiBjb2RlIG11Y2ggbGVzcyBwcm9uZSB0byBlcnJvcnMu
DQo+ID4+DQo+ID4+IFRvIGhhdmUgdGhlIHNhbWUgbnVtYmVyIG9mIHRyaXAgcG9pbnRzLCB0aGUg
aW5kZXggb2YgdGhlIGRpc2FibGVkDQo+ID4+IHRyaXAgbXVzdCBiZSBpbnNlcnRlZCBhbHNvIGlu
IHRoZSBhcnJheS4gV2UgZG9uJ3QgY2FyZSBhYm91dCBpdHMNCj4gPj4gcG9zaXRpb24gaW4gdGhl
IGluZGV4ZXMgYXJyYXkgYmVjYXVzZSBpdCBpcyBkaXNjYXJkZWQgaW4gdGhlDQo+ID4+IGhhbmRs
ZV90cmlwX3BvaW50KCkgZnVuY3Rpb24gYW55d2F5LiBGb3IgdGhpcyByZWFzb24sIHRoZSByYW5k
b20NCj4gPj4gdGVtcGVyYXR1cmUgb2YgdGhlIGRpc2FibGVkIHRyaXAgcG9pbnQgYW5kIHRoZSBy
ZXN1bHRpbmcgcG9zaXRpb24gaW4NCj4gPj4gdGhlIHNvcnRpbmcgaXMgaGFybWxlc3MuDQo+ID4+
DQo+ID4+IEl0IGlzIG1hZGUgb24gcHVycG9zZSB0byBpZ25vcmUgdGhlIHJldHVybiB2YWx1ZSwg
c28gd2UgaGF2ZSBhDQo+ID4+IHNpbXBsZXIgY29kZS4NCj4gPj4NCj4gPiBMZXQncyB0YWtlIGJl
bG93IGNhc2UgZm9yIGV4YW1wbGUsDQo+ID4gc2F5LCB3ZSBoYXZlIHRocmVlIHRyaXAgcG9pbnRz
IDAsIDEsIDIsIGFuZCB0cmlwIHBvaW50IDEgaXMgYnJva2VuIGFuZA0KPiA+IGRpc2FibGVkLg0K
PiA+DQo+ID4gdHJpcCB0ZW1wIGZvciB0cmlwIHBvaW50IDAgaXMgMTAgYW5kIGZvciB0cmlwIHBv
aW50IDIgaXMgMjAuDQo+ID4gLmdldF90cmlwX3RlbXAodHosIDEsICZ0KSBmYWlscywgYW5kIHQg
aXMgYW4gdW5pbml0aWFsaXplZCByYW5kb20NCj4gPiB2YWx1ZQ0KPiA+DQo+ID4NCj4gPiBJbml0
aWFsOg0KPiA+ICAgICB0cmlwX2luZGV4ZXNbMF09MCx0cmlwX2luZGV4ZXNbMV09MSx0cmlwX2lu
ZGV4ZXNbMl09Mg0KPiA+IHN0ZXAxOg0KPiA+ICAgICBpPTAsaj0xDQo+ID4gICAgIGdldCB0cmlw
IHRlbXAgZm9yIHRyaXAgcG9pbnQgdHJpcF9pbmRleGVzWzBdPTAgYW5kIHRyaXBfaW5kZXhlc1sx
XT0xDQo+ID4gICAgIHRyaXAgcG9pbnQgMSByZXR1cm5zIHRyaXAgdGVtcCA1LCBhbmQgaXQgc3dh
cHMgd2l0aCB0cmlwIHBvaW50IDANCj4gPiAgICAgc28NCj4gPiAgICAgdHJpcF9pbmRleGVzWzBd
PTEsdHJpcF9pbmRleGVzWzFdPTAsdHJpcF9pbmRleGVzWzJdPTINCj4gPiBzdGVwMjoNCj4gPiAg
ICAgaT0wLGo9Mg0KPiA+ICAgICBnZXQgdHJpcCB0ZW1wIGZvciB0cmlwIHBvaW50IHRyaXBfaW5k
ZXhlc1swXT0xIGFuZCB0cmlwX2luZGV4ZXNbMl09Mg0KPiA+ICAgICB0cmlwIHBvaW50IDEgcmV0
dXJucyB0cmlwIHRlbXAgMjUsIGFuZCBpdCBzd2FwcyB3aXRoIHRyaXAgcG9pbnQgMg0KPiA+ICAg
ICBzbw0KPiA+ICAgICB0cmlwX2luZGV4ZXNbMF09Mix0cmlwX2luZGV4ZXNbMV09MCx0cmlwX2lu
ZGV4ZXNbMl09MQ0KPiA+DQo+ID4gQW5kIHRoZSBzb3J0aW5nIGlzIGJyb2tlbiBub3cuDQo+ID4N
Cj4gPiBwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gbWlzc2luZyBhbnl0aGluZy4NCj4gDQo+IE9o
LCBuaWNlISBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCj4gDQo+IFdlIGNh
biBpbml0aWFsaXplIHQxIGFuZCB0MiB0byBJTlRfTUFYLCBzbyBpZiB0aGUgZ2V0X3RyaXBfdGVt
cCgpIGZhaWxzLCB0aGV5DQo+IHdpbGwgYmUgc2V0IHRvIHRoZSBtYXhpbXVtIHRlbXBlcmF0dXJl
IGFuZCBpdCB3aWxsIGJlIGF0IHRoZSBlbmQgb2YgdGhlIGFycmF5Lg0KPiANCj4gQWx0ZXJuYXRp
dmVseSwgd2UgY2hlY2sgdGhlIGRpc2FibGVkIGJpdCBhbmQgc2V0IHRoZSB0ZW1wZXJhdHVyZSB0
byBJTlRfTUFYLg0KDQpJTU8sIHdlIGNhbg0KMS4gZ2V0IHRoZSB0cmlwIHRlbXAgZm9yIGVhY2gg
dHJpcCBwb2ludCBhbmQgY2FjaGUgdGhlbQ0KMi4gc2V0IHRoZSB0cmlwc19kaXNhYmxlZCBiaXQN
CjMuIGRvIHRoZSBzb3J0aW5nIHVzaW5nIHRoZSBjYWNoZWQgdHJpcCB0ZW1wIHZhbHVlcw0KaW4g
dGhlcm1hbF96b25lX2RldmljZV90cmlwX2luaXQoKSBhbHRvZ2V0aGVyLg0KDQpUaGFua3MsDQpy
dWkNCj4gDQo+IA0KPiANCj4gDQo+IA0KPiAtLQ0KPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4g
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBG
b2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFj
ZWJvb2sgfA0KPiA8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8IDxo
dHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLQ0KPiBibG9nLz4gQmxvZw0K
