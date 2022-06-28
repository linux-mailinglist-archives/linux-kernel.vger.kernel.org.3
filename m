Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13055EA12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiF1Qng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiF1QmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:42:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064FCD4;
        Tue, 28 Jun 2022 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656434393; x=1687970393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jnXDJ3dIjSp6xHcVtKny8xhd8b/hK+Z5R6b5A+1lEbk=;
  b=Vp0LDYg0HXrIARfMDJmFhDYkuK1MmPwBAbdXABFdm4Pa6Yu66vAawQ1W
   292Y7d6cyYr9/ZEQZFsFnIx3kpD/qtqrkFLWfbR+2wpwoYn3g0Gi7wJ6t
   JfJ116tVYJQCA47YTwqRiisQkJNOQEew9j70ogSJPb9+VZTBciacHJnOv
   FAIPpnISQPK3pZgjc85okzy3/TGAytyUDV5dy+fhfVA9/0AcaHeMAzxCl
   j9HCUE6bzM4kigR6MtGTpdNEUkx7DNhUT440wDHYoJOcAUbqHpa3Bcasf
   9N0dp9HkLvwW4cr21P8qpR1r0BHwh1o7c843nk0IWBQX34LI9j8t0Ubuf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280551371"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="280551371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658198138"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 09:39:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 09:39:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 09:39:31 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Tue, 28 Jun 2022 09:39:31 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        'Linus Walleij' <linus.walleij@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemdOe4e+BwzSVEeUnZkOYa/FOK1JFpkAgAY1RYCAAArrgIAEgNwAgA+7kYCAAdqygP//t3Xw
Date:   Tue, 28 Jun 2022 16:39:31 +0000
Message-ID: <c2fb1376536d471f88b58ad82859a183@intel.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
 <OSBPR01MB203739DD69FB8C50990C356A80B89@OSBPR01MB2037.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB203739DD69FB8C50990C356A80B89@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NzBjY2M1ODgtNDljNi00ZGUxLWJhMmQtMDIyYzBmYmZl?=
 =?utf-8?B?OWYzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0yOFQxMzo0MDo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gVGhlIHJpZ2h0IHdheSB0byBzb2x2ZSB0aGlzIGlzIHRvIG1ha2UgdGhlIExpbnV4IGtlcm5l
bCBjb250YWluIHRoZSBuZWNlc3NhcnkNCj4+IGhldXJpc3RpY3MgdG8gaWRlbnRpZnkgd2hpY2gg
dGFza3MgYW5kIHRodXMgY29yZXMgbmVlZCB0aGlzIHRvIGltcHJvdmUgZWZmaWNpZW5jeQ0KPj4g
YW5kIHRoZW4gYXBwbHkgaXQgYXV0b21hdGljYWxseS4NCj4+DQo+PiBQdXR0aW5nIGl0IGluIHVz
ZXJzcGFjZSBpcyBtYWtpbmcgYSBodW1hbiBkbyBhIG1hY2hpbmVzIGpvYiB3aGljaCBpc24ndA0K
Pj4gc3VzdGFpbmFibGUuDQo+Pg0KPj4gQnkgcHV0dGluZyB0aGUgaGV1cmlzdGljcyBpbiBrZXJu
ZWxzcGFjZSBMaW51eCB3aWxsIGltcHJvdmUgcGVyZm9ybWFuY2UgYWxzbyBvbg0KPj4gd29ya2xv
YWRzIHRoZSBodW1hbiBvcGVyYXRvciBkaWRuJ3QgdGhpbmsgb2YgYXMgdGhlIG1hY2hpbmUgd2ls
bCBkZXRlY3QgdGhlbSBmcm9tDQo+PiBzdGF0aWN0aWNhbCBvciBvdGhlciBiZWhhdmlvdXIgcGF0
dGVybnMuDQo+DQo+SW4gb3JkZXIgdG8gcHV0IHRoZSBoZXVyaXN0aWNzIGludG8ga2VybmVsc3Bh
Y2UgTGludXgsIEkgdGhpbmsgaXQNCj5uZWNlc3NhcnkgdG8gY29uc2lkZXIgdGhlIGZvbGxvd2lu
ZyB0d28gcG9pbnRzLg0KPg0KPjEpIFdoaWNoIGNvcmVzIGFyZSB0aWVkIHdpdGggdGhlIHByb2Nl
c3M/DQo+VGhpcyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgY29yZSBvbiB3aGljaCB0aGUgcHJvY2Vz
cyBjYW4gcnVuLiBJdA0KPnByb2JhYmx5IG5lZWQgdG8gY29tYmluZSBzb21lIENQVSByZXNvdXJj
ZSBsaW1pdCB0byBhdm9pZCBhZmZlY3RpbmcNCj5ub24tdGFyZ2V0IHByb2Nlc3Nlcy4NCj4NCj4y
KSBIb3cgdG8gZGVyaXZlIHRoZSB2YWx1ZSB0byBzZXQgaW4gdGhlIHJlZ2lzdGVyPw0KPkl0IGlz
IG5lY2Vzc2FyeSB0byB2ZXJpZnkgd2hldGhlciBhbiBhcHByb3ByaWF0ZSBzZXQgdmFsdWUgY2Fu
IGJlDQo+ZGVyaXZlZCB1c2luZyBzdGF0aXN0aWNhbCBpbmZvcm1hdGlvbiwgZXRjLiBJbiBhZGRp
dGlvbiwgdG8gcHJldmVudA0KPnRoZSBjb3N0IG9mIGF1dG9tYXRpYyBkZXJpdmF0aW9uIGZyb20g
ZXhjZWVkaW5nIHRoZSB2YWx1ZSB0aGF0IHdvdWxkDQo+YmUgaW1wcm92ZWQgYnkgaXQuDQo+DQo+
SSBkb24ndCBoYXZlIGEgcHJvc3BlY3QgZm9yIHJlc29sdmluZyB0aGVzZSBpc3N1ZXMgeWV0LiBJ
IHdpbGwNCj5jb250aW51ZSB0aGVzZSBjb25zaWRlcmF0aW9ucy4NCg0KQW5vdGhlciBhcHByb2Fj
aCB3b3VsZCBiZSB0byBtYWtlIHRoZSBzZXQgb2YgcHJlZmV0Y2ggc2V0dGluZ3MNCmEgdGFzayBh
dHRyaWJ1dGUuIFRoZW4gc2V0IHRoZW0gaW4gdGhlIGNvbnRleHQgc3dpdGNoIGNvZGUgd2hlbg0K
dGhlIHByb2Nlc3MgaXMgYWJvdXQgdG8gcnVuIG9uIGEgQ1BVLg0KDQpCdXQgdGhhdCBhc3N1bWVz
IHlvdSBjYW4gY2hlYXBseSBjaGFuZ2UgdGhlIGF0dHJpYnV0ZXMuIElmIGRvaW5nDQpzbyByZXF1
aXJlcyBtdWx0aXBsZSBNU1Igd3JpdGVzIChvbiB4ODYpIGl0IG1pZ2h0IGJlIGEgbm9uLXN0YXJ0
ZXIuDQoNCi1Ub255DQo=
