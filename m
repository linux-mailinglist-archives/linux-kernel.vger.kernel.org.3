Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6E520335
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiEIRJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiEIRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:09:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE752B9C8C;
        Mon,  9 May 2022 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652115923; x=1683651923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3scayCu6ID1aDNn8OBm96/lJRF8vjKYB0DQAdtKYOc0=;
  b=jj+crfWBUsSbeetSYp9V3o2a4LsL/LArIN48QWg04oc24Pw52VWmwB6F
   ybMDS59kafVrPECltxMxO9QeXEWI68+gB7vSqmKzSZW/tJLIa3qI201Bb
   R89PMGmGtbDzupEHwAgn4Bi9v9M3OQZiPSWDRjr0jYVsfVdmLZvspdOo9
   hQf3n/0jiTyyvBhTHO/0yH+SD5jwo1eItIu+YQEciSuz41tkfXzQzioa2
   sFC123eulWTYoOeNKSvJYnZwJk67jSAKhAImyy8bVYNhhDs6AgY9bM+n9
   veBFaa7QnytAbRKYKUCTXL2PyGZft470jHrfZnEdT+LNC4mI49Ia+Fr5n
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355538406"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="355538406"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="602054410"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 09 May 2022 10:05:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 10:05:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 10:05:21 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 9 May 2022 10:05:21 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v5 00/10] Introduce In Field Scan driver
Thread-Topic: [PATCH v5 00/10] Introduce In Field Scan driver
Thread-Index: AQHYWxYVdsKdZt61BUSHj1qB1cqAT60MLiKAgAGW8wCABKLQAP//o/BAgAClR4CABCX1EA==
Date:   Mon, 9 May 2022 17:05:20 +0000
Message-ID: <05b3c44c62a944f793b66b2e8e8c0cfe@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
 <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
 <15cca88b82cd46a3a2a98b7cf336a6ed@intel.com>
 <4fda831b-c132-53cd-cd75-4f46b45219ac@redhat.com>
In-Reply-To: <4fda831b-c132-53cd-cd75-4f46b45219ac@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gRG8geW91IHN0aWxsIHRha2UgcGF0Y2hlcyBhZnRlciAtcmM2Pw0KPg0KPiBJZiB0aGUgcGF0
Y2hlcyBhcmUgc2VuZCBzb29uICgxLTIgZGF5cykgYWZ0ZXIgcmM2IEkgY2FuIHN0aWxsIHRha2Ug
dGhlbS4NCg0KSGFucywNCg0KVjcgd2FzIHBvc3RlZCBGcmlkYXkuIEl0IHN1cnZpdmVkIG15IHdl
ZWtlbmQgdGVzdGluZywgYW5kIGFub3RoZXIgcm91bmQgb2YgdGdseCBzY3J1dGlueSAoZW5kaW5n
IHdpdGgNCmhpcyAiUmV2aWV3ZWQtYnkiIG9uIHRoZSBsYXR0ZXIgcGFydHMgb2YgdGhlIHNlcmll
cy4NCg0KTGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgZWxzZSB5b3UgbmVlZCB0byBn
ZXQgdGhlbSBhcHBsaWVkLg0KDQpUaGFua3MNCg0KLVRvbnkNCg==
