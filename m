Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3649E826
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbiA0QzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:55:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:23733 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238656AbiA0QzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643302509; x=1674838509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ybxUvAtI2zNGLFznyN1Y3SuKrLBM5S6HWVAB/M0bYxw=;
  b=AQeKGA70fbHq7M4iBTRPXAjHbEljrhhrnPeqpJs/VX4nN3pRGDsZMIZe
   gNYc0IGgkz9OeTUFlwKxbKNgFFOmTTff4IvRemUXNQTQhx6zloScMf8kT
   K26FdvQ5WaiPLlrCGyM11ohTWwifeAac220G5Kic09n0TewggsTMVtwfk
   wuRJ3CArOGVEAb9cL5mLSpbR5iZm43wcjbYmHY+jad9o56iodZC0wWqkP
   XnAyqOKjICozj2GeSKlY+9H5rnSiKmO2tLBGinpofgCiNdRObvERmWDTo
   OZ+d0uXCisAKT5huB/nDFxNwZA2A8DpjhqTG8/agSOWi4br9imYwqkF63
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246686535"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246686535"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="495794343"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 08:52:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 08:52:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 08:52:44 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Thu, 27 Jan 2022 08:52:44 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 2/6] x86/cpu: Merge Intel and AMD ppin_init() functions
Thread-Topic: [PATCH v2 2/6] x86/cpu: Merge Intel and AMD ppin_init()
 functions
Thread-Index: AQHYDu8DikL4mqOUK0y4S02wOfcLTKx3N7KA///mO/A=
Date:   Thu, 27 Jan 2022 16:52:43 +0000
Message-ID: <73464511fcf942389f51095936942b2c@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <20220121174743.1875294-3-tony.luck@intel.com> <YfJyS6/zXGIoasGO@zn.tnic>
In-Reply-To: <YfJyS6/zXGIoasGO@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwlbWDg2X1ZFTkRPUl9BTURdID0gew0KPj4gKwkJLmZlYXR1cmUgPSBYODZfRkVBVFVSRV9B
TURfUFBJTiwNCj4+ICsJCS5tc3JfcHBpbl9jdGwgPSBNU1JfQU1EX1BQSU5fQ1RMLA0KPj4gKwkJ
Lm1zcl9wcGluID0gTVNSX0FNRF9QUElODQo+CQleXl5eXl5eXl4NCj4NCj4gWW91IGZvcmdvdCB0
byByZWJ1aWxkIGFmdGVyIHJlbW92aW5nIHRoYXQgZ3V5IGhlcmUgaW4gdGhlIHN0cnVjdA0KPiBk
ZWZpbml0aW9uLiBJJ2xsIGZpeCBpdCB1cCBub3cgc28gdGhhdCBJIGNhbiBjb250aW51ZSBnb2lu
ZyB0aHJvdWdoIHRoZW0NCj4gYnV0IHBscyBmaXggaW4gdGhlIG5leHQgc3VibWlzc2lvbiBzbyB0
aGF0IGFsbCBwYXRjaGVzIGJ1aWxkIHNlcGFyYXRlbHkuDQoNCk9vcHMuIFNvcnJ5LiBZZXMuIEkg
d2lsbCBtb3ZlIHRob3NlIGluaXRpYWxpemF0aW9ucyBvdXQgb2YgdGhpcyBwYXRjaA0KYW5kIGlu
dG8gdGhlIGxhdGVyIHBhdGNoIHdoZW4gdGhlIC5tc3JfcHBpbiBmaWVsZCBpcyBhZGRlZC4NCg0K
SSdsbCB3YWl0IG9uIHBvc3RpbmcgdjMgdW50aWwgeW91IGZpbmlzaCB3aXRoIHRoZSByZXN0IG9m
IHYyLg0KDQpUaGFua3MNCg0KLVRvbnkNCg0K
