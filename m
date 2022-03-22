Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03A4E3602
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiCVBhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:37:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416D7678;
        Mon, 21 Mar 2022 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647912963; x=1679448963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qgy/juc1I0r2YeGjveVENOWkM5dKEQi0FD/9Dw7Vy1A=;
  b=JPb1I1x1Pj4ZXVvUK1+G2enBSohUilw3j9I6h2/b2taB3OCpRvYN4GzK
   I2MPISEWJJrpj61GmkqIUwmMUmAj/W7kI/worqZXAXZGSL9P0czXs4vtn
   TdB8lWqo0U0mPgYVAMY9q/583wkMpr34IHHaxnKK1gscjRVz4v640etFL
   xwAlYNTMHY0owIlRy5ks7j+NNd8kiCwf+N9AENWecwltD47eVra3jQ+z3
   XL8FPtoqI5lsggjFW+43XObR29hLNyrgEm1sACfppB1bjHG7MpB3mcJML
   Ki2sFtPEAHyB6D4e3HL/l9XATV8Y2Ne6UnzzMIg1WrOMoBgRU3j/ks0D3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237635136"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="237635136"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="500380607"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2022 18:36:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 18:36:02 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 18:36:00 -0700
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2308.021;
 Tue, 22 Mar 2022 09:35:58 +0800
From:   "Zhang, Cathy" <cathy.zhang@intel.com>
To:     Jethro Beekman <jethro@fortanix.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
Thread-Topic: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure
 in microcode update
Thread-Index: AQHYOAhnN0apP04FNkeGc4yeqoa7EazBPxwAgAAKxgCAAFoygIACtKKAgAZQFgA=
Date:   Tue, 22 Mar 2022 01:35:58 +0000
Message-ID: <f117484666f64892bf47bd743432b537@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
 <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
 <e1682971-4821-8e57-3232-de7a72086991@fortanix.com>
 <e121e972-7689-b2f3-5919-746e3a90cb36@intel.com>
 <4198920d-298c-6565-5d97-9d0a8fcc8441@fortanix.com>
In-Reply-To: <4198920d-298c-6565-5d97-9d0a8fcc8441@fortanix.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmV0aHJvLA0KDQpUaGFua3MgZm9yIGhlbHBpbmcgcmV2aWV3IQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpldGhybyBCZWVrbWFuIDxqZXRocm9AZm9ydGFuaXgu
Y29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4LCAyMDIyIDU6MDYgUE0NCj4gVG86IEhhbnNl
biwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgWmhhbmcsIENhdGh5DQo+IDxjYXRoeS56
aGFuZ0BpbnRlbC5jb20+OyBsaW51eC1zZ3hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1IaQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBSYWosIEFzaG9rIDxhc2hvay5yYWpAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MiAwOS8xMF0geDg2L2NwdTogQ2FsbCBF
TkNMU1tFVVBEQVRFU1ZOXQ0KPiBwcm9jZWR1cmUgaW4gbWljcm9jb2RlIHVwZGF0ZQ0KPiANCj4g
T24gMjAyMi0wMy0xNiAxNjo0NywgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4gT24gMy8xNi8yMiAw
MzoyNCwgSmV0aHJvIEJlZWttYW4gd3JvdGU6DQo+ID4+PiBEb2luZyB0aGlzIGF1dG9tYXRpY2Fs
bHkgYW5kIHVuY29uZGl0aW9uYWxseSBkdXJpbmcgYSBtaWNyb2NvZGUNCj4gPj4+IHVwZGF0ZSBz
ZWVtcyB1bmRlc2lyYWJsZS4gVGhpcyByZXF1aXJlcyB0aGUgdXNlcmxhbmQgdG9vbGluZyB0aGF0
DQo+ID4+PiBpcyBjb29yZGluYXRpbmcgdGhlIG1pY3JvY29kZSB1cGRhdGUgdG8gYmUgYXdhcmUg
b2YgYW55IFNHWA0KPiA+Pj4gZW5jbGF2ZXMgdGhhdCBhcmUgcnVubmluZyBhbmQgcG9zc2libHkg
Y29vcmRpbmF0ZSBzZXF1ZW5jaW5nIHdpdGgNCj4gPj4+IHRoZSBwcm9jZXNzZXMgY29udGFpbmlu
ZyB0aG9zZSBlbmNsYXZlcy4gVGhpcyBjb3VwbGluZyBkb2VzIG5vdA0KPiA+Pj4gZXhpc3QgdG9k
YXkuDQo+ID4+IEFsc28sIGEgbWljcm9jb2RlIHVwZGF0ZSBtYXkgbm90IGFmZmVjdCBTR1ggc2Vj
dXJpdHkgYXQgYWxsIGFuZCBkb2luZw0KPiA+PiB0aGUgRVVQREFURVNWTiBwcm9jZWR1cmUgbWF5
IG5vdCBiZSByZXF1aXJlZCBmb3IgdGhpcyBwYXJ0aWN1bGFyDQo+ID4+IHVwZGF0ZS4gVGhpcyBj
YXNlIGlzIGNhbGxlZCBvdXQgc3BlY2lmaWNhbGx5IGluIHRoZSBFVVBEQVRFU1ZODQo+ID4+IGRv
Y3VtZW50YXRpb24uDQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIEludGVsIHByb3ZpZGVzIHRoZSBt
ZXRhZGF0YSBmb3IgdGhlIGtlcm5lbCB0byB0ZWxsIGlmIGFuDQo+ID4gdXBkYXRlIHJlcXVpcmVz
IGFuIEVVUERBVEVTVk4gcHJvY2VkdXJlIG9yIG5vdC4gIElmIHRoaXMgaXMgaW5jb252ZW5pZW50
DQo+ID4gZm9yIHlvdSwgSSdkIHN1Z2dlc3QgcmVwb3J0aW5nIHRoaXMgdG8gdGhlIGZvbGtzIGF0
IEludGVsIHdobyBjYW4gZml4DQo+ID4gaXQuICBJdCBkb2Vzbid0IHNlZW0gbGlrZSBzb21ldGhp
bmcgd2hpY2ggdGhleSBhcmUgbW90aXZhdGVkIHRvIGZpeC4NCj4gDQo+IFdoZXRoZXIgb3Igbm90
IG1ldGFkYXRhIGlzIGN1cnJlbnRseSBtYWRlIGF2YWlsYWJsZSBpcyBvcnRob2dvbmFsIHRvDQo+
IGNyZWF0aW5nIGEgbWVjaGFuaXNtIGJ5IHdoaWNoIHVzZXJzcGFjZSBjYW4gaW5kaWRhdGUgdGhh
dCBhIHBhcnRpY3VsYXINCj4gbWljcm9jb2RlIHVwZGF0ZSBzaG91bGRuJ3QgdHJpZ2dlciB0aGUg
RVVQREFURVNWTiBwcm9jZWR1cmUuDQoNCkknbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSBub3RpY2Vk
IHRoZSBkaXNjdXNzaW9ucyBpbiB2MToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNzQy
YmU5ZS1jMThlLTI4YzktNzVjOC0xNDRiZjFmNmEzMTFAaW50ZWwuY29tL1QvI20xOGU2ZmVjZDhj
OWM1MTdjNjhjYjRkNjJlNTNmMjQ5MDlhYmQ1MGE3DQoNCldlIHJlbW92ZSB0aGUgc3lzZnMgd2hp
Y2ggYWxsb3dzIHVzZXJzcGFjZSB0byBkZWNpZGUgaWYgYW5kIHdoZW4gdG8NCnRyaWdnZXIgdGhl
IEVVUERBVEVTVk4gcHJvY2VkdXJlLiBQbGVhc2UgY29tbWVudCBpZiB5b3UgaGF2ZSBvdGhlcg0K
c3VnZ2VzdGlvbi4NCg0KPiANCj4gLS0NCj4gSmV0aHJvIEJlZWttYW4gfCBGb3J0YW5peA0K
