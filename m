Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782553407F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbiEYPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEYPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:40:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6ECA888A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653493251; x=1685029251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ExtpK2u93fj/Vw+yDc45Q7yrexobp9v2iCuvSvmXu4Y=;
  b=hmBxo98Q/6hauTeJU0xRcncYbR5WggKwsSnrfaOWTxPZjUA8GKramONN
   ksVh4Y1WTAxVpRkYELRF4LT6UncjyiQjlZJv4HzggfQYIJ8K+3F+PCCau
   0+bdxD++L4SeP0I1+JegMxOmt90p5U4jPOP737in/ymlcwWd3l+0naEyO
   Bbu+4W9mh9v27hlcxL7IHbNNgEhCXc1WwsRBTOmYfkUJLJFFVUzW2aW3O
   sFLgKbYiFY7XZWF3q7l10rDHCN0yfYLNCGLgvpWj+iiBaURm0bcaReg+z
   9CTz++vUL53jHLaPoCaj/ruYsJ6jI1Pk/xWAw38EOn/rnSDfVKrJpAR8c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271417911"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271417911"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="820783663"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2022 08:40:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 08:40:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 08:40:50 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 25 May 2022 08:40:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Thread-Topic: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Thread-Index: AQHYb9MymCkCxlrsw0uEltRD6R05Oa0vn7QAgAAKeYCAAAHSoIAAgb2A//+M1QA=
Date:   Wed, 25 May 2022 15:40:50 +0000
Message-ID: <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic> <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
 <Yo5LAenZIsYmM9Ie@zn.tnic>
In-Reply-To: <Yo5LAenZIsYmM9Ie@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZXMsIHRoZXkgY2FuIGJlIGFzIG1hbnkgYXMgdGhlcmUgYXJlIGxldHRlcnMgaW4gdGhlIGVu
Z2xpc2ggYWxwaGFiZXQsDQo+IGl0IHNlZW1zOg0KPg0KPiBzdHJ1Y3QgdGFpbnRfZmxhZyB7DQo+
ICAgICAgICBjaGFyIGNfdHJ1ZTsgICAgLyogY2hhcmFjdGVyIHByaW50ZWQgd2hlbiB0YWludGVk
ICovDQo+CV5eXl5eXl5eXl5eXg0KPg0KPiBhbmQgdGhlcmUgYXJlIGFscmVhZHkNCj4NCj4gI2Rl
ZmluZSBUQUlOVF9GTEFHU19DT1VOVCAgICAgICAgICAgICAgIDE4DQoNClRoYXQncyB2ZXJ5IDE5
OTAncyB0aGlua2luZy4gV2UgaGF2ZSBVbmljb2RlIGF2YWlsYWJsZSBub3cuDQpXZSBjb3VsZCBz
dGFydCB1c2luZyBFbW9qaSBsaWtlIFUrMUY0QTkgYXMgYSB0YWludCBjaGFyYWN0ZXIgOi0pIA0K
DQo+IExvb2sgYXQgdGhlIG90aGVyIHRhaW50IGZsYWdzIC0gdGhleSdyZSBzZXQgaW4gYSBidW5j
aCBvZiBkaWZmZXJlbnQNCj4gcGxhY2VzIHNvIGl0IGlzIGhhcmQgdG8gdW5hbWJpZ3VvdXNseSBk
ZWNpZGUgd2hlcmUgdGhlIHRhaW50IHdhcyBzZXQuIElmDQo+IHdlIHdhbm5hIHVzZSBpdCBmb3Ig
ZGVidWdnaW5nLCB0aGVuIHRoZSB0YWludF9mbGFnIHN0cnVjdCBhYm92ZSBzaG91bGQNCj4gcHJv
YmFibHkgc2F2ZSB0aGUgY2FsbGVyIGFkZHJlc3Mgd2hpY2ggc2V0IHRoZSB0YWludC4uLiBvciBz
b21ldGhpbmcgdG8NCj4gdGhhdCBlZmZlY3QuDQoNClRoYXQgc291bmRzIGJldHRlciB0aGFuIGEg
c3RyaW5nIG9mIEVtb2ppIChhbHNvIGJldHRlciB0aGFuIHRoZSBjdXJyZW50DQpzdHJpbmcgb2Yg
dXBwZXIgY2FzZSBjaGFyYWN0ZXJzKS4NCg0KLVRvbnkNCg==
