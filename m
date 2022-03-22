Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C24E35E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiCVBND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:13:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5C1AF23;
        Mon, 21 Mar 2022 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647911495; x=1679447495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZZGsa21JbejQvStZlT4IhRGFK0npIzVahgaH4HG7IF4=;
  b=maVcqDNVlcqWEuVcbwUTjanCO+NkzCNzRuB6U+OWznOHxykVzfeZ214j
   Lk98Nb0oZC+BOv/d9/hQOKlnD4G5bF7CMeMo6ZAoKT3QezYAI4PmyMFrq
   ybYPDtlZ/HPaqz7Eepy5uwsRuN7JVgPnlzxjCx84V7wpkqtECspUi+NOJ
   oGUmtelGVyVjYb/Cbz81TxagH9H6UtjiOft67GgttZPUkw0IPnB9FGp/J
   OOYGAebmNcHCQzy35ZROIoDmE3J+1PNG8wW1U9ZXT1sYOU4+5rJ1KH6hM
   eltGYkWvToHg327HxAHJXEFb1Ne+JwUKRKOiRsVG8hNTZ0QF6ol5D8bqD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="255252392"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="255252392"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="785192032"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2022 18:11:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 18:11:35 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 18:11:33 -0700
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2308.021;
 Tue, 22 Mar 2022 09:11:31 +0800
From:   "Zhang, Cathy" <cathy.zhang@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent new
 initializations of EPC pages
Thread-Topic: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent new
 initializations of EPC pages
Thread-Index: AQHYOAhd7zSiVFgIJk6OBix1KI5N6azCdFYAgAEpncD//8xLAIAA9HmggAB0MICABcq4sA==
Date:   Tue, 22 Mar 2022 01:11:31 +0000
Message-ID: <d4af4dab69ab422f9b1d0f102fe1dd14@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-2-cathy.zhang@intel.com> <YjK1PtnutmiSgE6f@kernel.org>
 <86c945969e674be18abfb6c2a5f16701@intel.com> <YjODhqZZjAkXuScd@iki.fi>
 <f773ff19583b42e79c83dc9570313b03@intel.com>
 <a68d6089-8d86-8c85-3bf4-6e3bf0791dc1@intel.com>
In-Reply-To: <a68d6089-8d86-8c85-3bf4-6e3bf0791dc1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hh
dHJlLCBSZWluZXR0ZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIE1hcmNoIDE5LCAyMDIyIDEyOjI0IEFNDQo+IFRvOiBaaGFuZywgQ2F0aHkgPGNhdGh5Lnpo
YW5nQGludGVsLmNvbT47IEphcmtrbyBTYWtraW5lbg0KPiA8amFya2tvQGtlcm5lbC5vcmc+DQo+
IENjOiBsaW51eC1zZ3hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBIYW5zZW4sIERhdmUNCj4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT47IFJhaiwgQXNob2sg
PGFzaG9rLnJhakBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDAxLzEw
XSB4ODYvc2d4OiBJbnRyb2R1Y2UgbWVjaGFuaXNtIHRvIHByZXZlbnQNCj4gbmV3IGluaXRpYWxp
emF0aW9ucyBvZiBFUEMgcGFnZXMNCj4gDQo+IEhpIENhdGh5LA0KPiANCj4gT24gMy8xNy8yMDIy
IDc6MzMgUE0sIFpoYW5nLCBDYXRoeSB3cm90ZToNCj4gPiBIaSBKYXJra28sDQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFya2tvIFNha2tpbmVuIDxq
YXJra29Aa2VybmVsLm9yZz4NCj4gPj4gU2VudDogRnJpZGF5LCBNYXJjaCAxOCwgMjAyMiAyOjUz
IEFNDQo+ID4+IFRvOiBaaGFuZywgQ2F0aHkgPGNhdGh5LnpoYW5nQGludGVsLmNvbT4NCj4gPj4g
Q2M6IGxpbnV4LXNneEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEhhbnNlbiwNCj4gPj4gRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgUmFqLCBBc2hv
ayA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIg
MDEvMTBdIHg4Ni9zZ3g6IEludHJvZHVjZSBtZWNoYW5pc20gdG8NCj4gPj4gcHJldmVudCBuZXcg
aW5pdGlhbGl6YXRpb25zIG9mIEVQQyBwYWdlcw0KPiA+Pg0KPiA+PiBPbiBUaHUsIE1hciAxNywg
MjAyMiBhdCAwMjowODoyMVBNICswMDAwLCBaaGFuZywgQ2F0aHkgd3JvdGU6DQo+ID4+PiBIaSBK
YXJra28sDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4g
RnJvbTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCj4gPj4+PiBTZW50OiBU
aHVyc2RheSwgTWFyY2ggMTcsIDIwMjIgMTI6MTMgUE0NCj4gPj4+PiBUbzogWmhhbmcsIENhdGh5
IDxjYXRoeS56aGFuZ0BpbnRlbC5jb20+DQo+ID4+Pj4gQ2M6IGxpbnV4LXNneEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4gSGFuc2VuLCBEYXZl
IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBSYWosIEFzaG9rDQo+ID4+Pj4gPGFzaG9rLnJhakBp
bnRlbC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMDEvMTBdIHg4Ni9z
Z3g6IEludHJvZHVjZSBtZWNoYW5pc20gdG8NCj4gPj4+PiBwcmV2ZW50IG5ldyBpbml0aWFsaXph
dGlvbnMgb2YgRVBDIHBhZ2VzDQo+ID4+Pj4NCj4gPj4+PiBPbiBUdWUsIE1hciAxNSwgMjAyMiBh
dCAwOTowMjo1MUFNICswODAwLCBDYXRoeSBaaGFuZyB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4g
Pj4+IFllcywgaXQgcmVxdWlyZXMgdG8gYXBwbHkgdGhlIGZvbGxvd2luZyBTR1gyIHYyIHBhdGNo
ZXMgdG8NCj4gPj4+IHRpcC94ODYvc2d4LCBwcmlvciB0byB0aGlzIHNlcmllcy4gQXMgSSBtZW50
aW9uZWQgaW4gY292ZXIgbGV0dGVyLA0KPiA+Pj4gU0dYMiBpbnRyb2R1Y2VzIG5ldyBTR1ggaW5z
dHJ1Y3Rpb25zIGFuZCBmbG93cywgd2hpY2ggc2hvdWxkIGJlDQo+ID4+PiBoYW5kbGVkDQo+ID4+
IGR1cmluZyBTVk4gdXBkYXRlLg0KPiA+Pj4NCj4gPj4+IFRoZSB2MiBvZiBTR1gyIHN1cHBvcnQg
cGF0Y2ggc2V0LCB3aXRoIDMyIHBhdGNoZXMgaW4gdG90YWwsIHJlZmVyIHRvDQo+ID4+PiB0aGUN
Cj4gPj4gY292ZXIgbGV0dGVyOg0KPiA+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9j
b3Zlci4xNjQ0Mjc0NjgzLmdpdC5yZWluZXR0ZS5jaGF0cmVAaW4NCj4gPj4+IHRlIGwuY29tLyBU
aGUgdHdvIGFkZGl0aW9uYWwgcGF0Y2hlcyBTR1gyIHN1cHBvcnQgcmVxdWlyZXM6DQo+ID4+PiAi
eDg2L3NneDogQWRkIHBvaXNvbiBoYW5kbGluZyB0byByZWNsYWltZXIiDQo+ID4+Pg0KPiA+Pj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+ID4+IHNneC9kY2M5NWViMmFhZWZiMDQy
NTI3YWM1MGQwYTUwNzM4YzdjMTYNCj4gPj4+IDBkYWMuMTY0MzgzMDM1My5naXQucmVpbmV0dGUu
Y2hhdHJlQGludGVsLmNvbS8NCj4gPj4+ICJ4ODYvc2d4OiBTaWxlbmNlIHNvZnRsb2NrdXAgZGV0
ZWN0aW9uIHdoZW4gcmVsZWFzaW5nIGxhcmdlIGVuY2xhdmVzIg0KPiA+Pj4NCj4gPj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiA+PiBzZ3gvYjVlOWYyMTgwNjRhYTc2ZTMwMjZm
Nzc4ZTFhZDBhMWQ4MjNlDQo+ID4+PiAzZGI4LjE2NDMxMzMyMjQuZ2l0LnJlaW5ldHRlLmNoYXRy
ZUBpbnRlbC5jb20vDQo+ID4+DQo+ID4+IFdoeSBkb24ndCB5b3UgcGljayB0aGUgZGVwZW5kZW50
IHBhdGNoZXMgZnJvbSB0aGF0IHBhdGNoIHNldCBhbmQgcHV0DQo+ID4+IHRoZW0gdG8gdGhpcyBv
bmU/IEl0IGRvZXMgbm90IG1hdHRlciBpZiB0d28gcGF0Y2ggc2V0cyBjb250YWluIHNhbWUNCj4g
Pj4gcGF0Y2hlcy4gSWYgdGhpcyBnZXRzIG1lcmdlZCBmaXJzdCwgdGhlbiBSZWluZXR0ZSdzIGpv
YiB3aWxsIGJlIGVhc2llciwgYW5kDQo+IHZpY2UgdmVyc2EuDQo+ID4+IFRhZ3MgbWFrZSBzdXJl
IHRoYXQgZXZlcnlvbmUgZ2V0cyB3aGF0IHRoZXkgZGVzZXJ2ZSBmcm9tIHRoZWlyDQo+IGNvbnRy
aWJ1dGlvbi4NCj4gPg0KPiA+IEZvciBlYXN5IHRvIGRpc2N1c3MsIEkgc3BsaXQgdGhlIFNHWDIg
c3VwcG9ydCBwYXRjaGVzIGludG8gdGhlIGZvbGxvd2luZyB0d28NCj4gcGFydHM6DQo+ID4NCj4g
PiAxLiBhdXhpbGlhcnkgY2hhbmdlczoNCj4gPiBbVjIsMDkvMzJdIHg4Ni9zZ3g6IEV4cG9ydCBz
Z3hfZW5jbF9ld2JfY3B1bWFzaygpDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9j
b3Zlci4xNjQ0Mjc0NjgzLmdpdC5yZWluZXR0ZS5jaGF0cmVAaW50ZQ0KPiA+IGwuY29tL1QvI200
NGUyYjkzMWU4MmE4N2E4YjJjODAwNTgxMzAxODJlYjc0N2ZiY2YwDQo+ID4gW1YyLDEwLzMyXSB4
ODYvc2d4OiBSZW5hbWUgc2d4X2VuY2xfZXdiX2NwdW1hc2soKSBhcw0KPiA+IHNneF9lbmNsX2Nw
dW1hc2soKQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTY0NDI3NDY4
My5naXQucmVpbmV0dGUuY2hhdHJlQGludGUNCj4gPiBsLmNvbS9ULyNtZjYyNjhhNjZiNWM0OGNh
OWExOGE3NzJiNmVhZWEwOTdjMzE1ZGMxZA0KPiA+IFtWMiwxMi8zMl0geDg2L3NneDogTWFrZSBz
Z3hfaXBpX2NiKCkgYXZhaWxhYmxlIGludGVybmFsbHkNCj4gPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sL2NvdmVyLjE2NDQyNzQ2ODMuZ2l0LnJlaW5ldHRlLmNoYXRyZUBpbnRlDQo+ID4g
bC5jb20vVC8jbWEzMzMwZjhlZTgxMzZhYTA4NGQwYTJiNWYxMTAzMzFlMzdmNDRjNTINCj4gPiBb
VjIsMTQvMzJdIHg4Ni9zZ3g6IEtlZXAgcmVjb3JkIG9mIFNHWCBwYWdlIHR5cGUNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE2NDQyNzQ2ODMuZ2l0LnJlaW5ldHRlLmNo
YXRyZUBpbnRlDQo+ID4gbC5jb20vVC8jbTRhZTgwZmRmNjdhZDMzMDExOWJmYzJhYmFlYTg0NWJh
YTI0ZWQxNGMNCj4gPg0KPiA+IDIuIFRoZSBvdGhlciBTR1gyIHN1cHBvcnQgcGF0Y2hlcy4NCj4g
Pg0KPiA+IEZvciAjMSwgd2UgY2FuIHB1dCB0aGVtIGludG8gdGhpcyBzZXJpZXMuIEJ1dCByZWdh
cmRpbmcgIzIsIGl0IGludHJvZHVjZXMNCj4gRUFVRy9FTU9EUFIvRU1PRFQgYW5kIHRoZSByZWxh
dGVkIGZsb3dzLCBpdCBzZWVtcyBub3Qgc2Vuc2libGUgdG8gcGljaw0KPiB1cCBvbmx5IHNvbWUg
b2YgdGhlIHBhdGNoZXMsIGl0IHdpbGwgYmUgbm90IGNvbnZlbmllbnQgdG8gcnVuIHRoZSByZWxh
dGVkIHRlc3QNCj4gd2hpbGUgZG9pbmcgU1ZOIHVwZGF0ZS4NCj4gPg0KPiA+Pg0KPiA+PiBPdGhl
cndpc2UgZm9yIGluc3RhbmNlIGdpdmluZyBhIHRlc3RlZC1ieSBpcyBpbXBvc3NpYmxlLiBZb3Ug
aGF2ZSB0bw0KPiA+PiByb290IHRoaXMgdG8gdGhlIG1haW5saW5lLCBvciBhdCBsZWFzdCB0byB4
ODYgdGlwLmdpdC4NCj4gPg0KPiA+IFB1dCB0aGlzIHNlcmllcyBvbiB0b3Agb2YgU0dYMiBzdXBw
b3J0IGlzIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQNCj4gU0dYMiB3aWxsIGdldCBtZXJn
ZWQgZmlyc3QuIElmIGl0J3MgcmVxdWlyZWQgdG8gbWFrZSB0aGlzIHNlcmllcyBpbmRlcGVuZGVu
dCBvZg0KPiBTR1gyLCB3ZSBuZWVkIHRvIHBpY2sgdXAgdGhlIGFib3ZlICMxLCBhbmQgbWFrZSBj
aGFuZ2UgaW4gcGF0Y2ggIiB4ODYvc2d4Og0KPiBJbnRyb2R1Y2UgbWVjaGFuaXNtIHRvIHByZXZl
bnQgbmV3IGluaXRpYWxpemF0aW9ucyBvZiBFUEMgcGFnZXMiIHRvIHJlbW92ZQ0KPiB0aGUgaGFu
ZGxpbmcgb24gU0dYMiBmbG93cy4gT25jZSBTR1gyIGdldHMgbWVyZ2VkLCBwcm92aWRlIHRoZSBj
aGFuZ2VzIGluDQo+IGZvbGxvd2luZyBwYXRjaGVzLg0KPiA+DQo+ID4gSG93IGRvIHlvdSB0aGlu
aywgSmFya2tvPyBBbmQgSSBhbHNvIHdvdWxkIGxpa2UgdG8gZ2V0IHN1Z2dlc3Rpb24gZnJvbQ0K
PiBAQ2hhdHJlLCBSZWluZXR0ZSBmb3IgdGhpcy4NCj4gDQo+IElzIGl0IHBvc3NpYmxlIHRvIGZh
Y3RvciBvdXQgdGhlIGNoYW5nZXMgdG8gdGhlIFNHWDIgZmxvd3MgaW50byBzZXBhcmF0ZQ0KPiBw
YXRjaGVzPw0KDQpZZXMsIHRoZSBjaGFuZ2VzIGNhbiBiZSBpbnRvIHNlcGFyYXRlIHBhdGNoZXMu
IEFuZCB0aGUgc2VwYXJhdGUgcGF0Y2hlcw0Kc2hvdWxkIGJlIG1vdmVkIG91dCBmcm9tIHRoaXMg
c2VyaWVzLCB0byBtYWtlIHN1cmUgdGhpcyBzZXJpZXMgaXMgYXBwbGllZA0KdG8gdGlwIGJyYW5j
aCBpbmRlcGVuZGVudCBvZiBTR1gyIHNlcmllcy4NCg0KPiANCj4gVGhpcyBzaG91bGQgY29udGlu
dWUgdG8gc3VwcG9ydCB0aGUgdGVzdGluZyB5b3UgbWVudGlvbmVkIGFuZCB0aGUgcGF0Y2hlcw0K
PiBjb3VsZCB0aGVuIGJlIGRyb3BwZWQgZnJvbSB5b3VyIHNlcmllcyBhbmQgbW92ZWQgdG8gdGhl
IFNHWDIgc2VyaWVzIGlmIHRoZQ0KPiBFVVBEQVRFU1ZOIHdvcmsgaXMgbWVyZ2VkIGZpcnN0LiBJ
IGFtIG5vdCBzdXJlIGFib3V0IHRoZSB0ZXN0aW5nIHRob3VnaA0KPiBiZWNhdXNlIEkgZGlkIG5v
dCBub3RpY2UgYSBzZWxmdGVzdCBhcyBwYXJ0IG9mIHRoZSBzZXJpZXMuIEhvdyBjYW4gSSB0ZXN0
IHRoaXMNCj4gd29yayBpZi93aGVuIGl0IG1vdmVzIHRvIHRoZSBTR1gyIHNlcmllcz8NCg0KVG8g
dGVzdCBpdCwgeW91IHdpbGwgdGhlIGZvbGxvd2luZyBjb21tYW5kIHdoaWxlIHlvdSBydW4gU0dY
MiBzdHJlc3MgdGVzdC4NCg0KaXVjb2RlLXRvb2wgLUsgeHh4eHh4LlBEQiAtLW92ZXJ3cml0ZSA7
IGVjaG8gMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L21pY3JvY29kZS9yZWxvYWQNCg0KSGVy
ZSB4eHh4eHguUERCIGlzIGFuIHVjb2RlIHBhdGNoLg0KDQpJJ20gbm90IHN1cmUgaWYgaXQncyBw
b3NzaWJsZSB0byB3cml0ZSBhIHNlbGZ0ZXN0IGZvciBpdCBmb3Igc2VsZnRlc3Qgc2hvdWxkIGNy
ZWF0ZSBhDQp1Y29kZSBwYXRjaC4NCg0KQWRkaXRpb25hbGx5LCByZWdhcmRpbmcgdGhlICJhdXhp
bGlhcnkgY2hhbmdlcyIgSSBsaXN0IGFib3ZlLCB3b3VsZCB5b3UgbGlrZSB0byBtb3ZlDQp0aGVt
IGludG8gdGhpcyBTVk4gdXBkYXRlIHNlcmllcywgb3IganVzdCBsZXQgbWUgcmViYXNlIG9uIHRo
ZW0sIGxpa2UgeW91IHJlYmFzZWQNCndpdGggc29tZSBvdGhlciBwYXRjaGVzPw0KDQo+IA0KPiBS
ZWluZXR0ZSANCg==
