Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAD4DD0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiCQWlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCQWlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:41:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F704263676
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647556818; x=1679092818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KB7mH4laCjl6yMQ+iGeEPSM/NqMV2R3n+Vr+9wtjrAo=;
  b=jOv/b5AzZLZcsYgTMAflxBksXB7JL3l7+sRrWFZJcdGtG9xgOXpy/wm4
   2YPMkpbhSZ0w+RfiNxzgJDDpmQYmk8xyP8sMj+rvm1I/1a4gnvqJtxeHu
   RVKf/2ap3a2ksHlIrmy4kxWJCiZg95JJALQKFArW4XOxFa1AFmQOjF/SR
   hPM2mPPEWTiCfjgKTlsRFuj0deVaCAIzisYaHvq4LZmjJqk9Pr/5gOOnt
   +abD+GaHAr/T1Ij2+3JMWnURM3bF87X1ZVmXrpSPdEY8Wej4I+p7gI7MI
   TR2J13l7OMQOf/STaMaTp4Aeo0kc3mhpUDqVgCPaH0bll2/6ywP0AFb61
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254554083"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254554083"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647223646"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 15:40:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:40:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:40:16 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Thu, 17 Mar 2022 15:40:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Topic: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Index: AQHYNMBHgmgs1nbay0qYe8hPygXs9azD68qAgABzpACAAEb9gP//juYg
Date:   Thu, 17 Mar 2022 22:40:16 +0000
Message-ID: <8ceaa1e7624b46feafb15da0935e161c@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com> <20220317111305.GB2237@amd>
 <87fsngcv25.ffs@tglx> <e2baf93885684512b4c7dc5363620a6f@AcuMS.aculab.com>
In-Reply-To: <e2baf93885684512b4c7dc5363620a6f@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGV5IGFyZSBhY3R1YWxseSBtb3JlIGxpa2VseSB0byBoYXBwZW4gaW4gdGhlIGtlcm5lbA0K
PiB3aGVuIGNvZGUgY2FzdHMgaW50W10gdG8gbG9uZ1tdIGFuZCB0aGVuIHVzZXMgdGhlICdCSVQn
IGZ1bmN0aW9ucyB0bw0KPiBzZXQvY2xlYXIgYml0cyAtIHdoaWNoIGRvIGxvY2tlZCBvcGVyYXRp
b25zLg0KPiBRdWl0ZSBvZnRlbiB0aGVuIGRvbid0IG5lZWQgdGhlIGxvY2tzIGFueXdheS4NCj4g
QW5kIHRoYXQgY2FzdCBpcyBzdXJwcmlzaW5nbHkgY29tbW9uIGFuZCBjb21wbGV0ZWx5IGJyb2tl
biBvbiBCRS4NCg0KRGVmYXVsdCBzcGxpdCBsb2NrIG1vZGUgaXMgImtlcm5lbCBkaWVzIi4gV2Ug
aGFkIHRvIGZpeCB1cCBhIGRvemVuIG9yDQpzbyBwbGFjZXMgKG1vc3RseSBpbnZvbHZpbmcgc2V0
X2JpdC9jbHJfYml0IGFzIHlvdSBkZXNjcmliZSkuIEJ1dA0KYWxsIEljZSBMYWtlLiBUaWdlciBM
YWtlIGFuZCBBbGRlciBMYWtlIHN5c3RlbXMgYXJlIHJ1bm5pbmcgaW4NCnRoYXQgbW9kZSAuLi4g
YW5kIHdlIGhhdmVuJ3QgaGVhcmQgb2Ygd2lkZXNwcmVhZCBkZWF0aCAob3IgZGlzYWJsaW5nDQp0
aGUgYm9vdCBvcHRpb24pLg0KDQotVG9ueQ0K
