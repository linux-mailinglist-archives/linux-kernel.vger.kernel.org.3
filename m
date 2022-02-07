Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB44ACBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiBGVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbiBGVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:51:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090BC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644270713; x=1675806713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mGGTcNtFwSOc9Gw6HFOZy3a/ArLIZ6uBXrcFHMyiv8E=;
  b=RJXrzG0zoNXylyFkT9xmJBDiQcI6kqZc8whGTly4JRatizs4IMb52N9f
   OrI1EGobSNKQX2xsjPMDCV1ucKI+Y6whEBnA1b4tL+0ysAV7ZGqf8V9fX
   5Ofjcy5vp59sWxCSulBpOu9/60P8/Z9XtSmtaoSpLoDPInbl19cpv8JqG
   ODvORi15RJmrcLrzjicHER/qhXcpk8AvmxqlnhyadqI9TKx5d9IN1hq95
   CN1sImpGGVlCsFml06YkFfi1i+AH85LltGsUKo5fWtOBChikBJo3CsXhI
   ggSYxr0AHd9qdulCyPqEWLi2E+DN5kPzq8F6XHwNbzFuxdpNDZDeJ8ivB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249025065"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="249025065"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="525291949"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2022 13:51:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 13:51:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 13:51:51 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Mon, 7 Feb 2022 13:51:51 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jue Wang <juew@google.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Topic: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Index: AQHYG9xP0gqp+9MoaEye7S91lqAbGKyI9jkA//+C0wCAAJepgP//g7dQgACK9ID//4CNoA==
Date:   Mon, 7 Feb 2022 21:51:51 +0000
Message-ID: <5293d81863b54d6ab0835012201d44da@intel.com>
References: <20220207043640.2829295-1-juew@google.com>
 <YgFqiJOU5tZsHbY6@zn.tnic> <YgFyBRIOIquMI2ng@agluck-desk2.amr.corp.intel.com>
 <YgGAv/aCVG+RDADI@zn.tnic> <be53997f26704089b941d33d9bf47bc6@intel.com>
 <YgGNDenGMCE5ixXw@zn.tnic>
In-Reply-To: <YgGNDenGMCE5ixXw@zn.tnic>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gVGhlIGVycmF0dW0gaGFzIG1hZGUgaXRzIHdheSB0aHJvdWdoIHRvIHRoZSBwdWJsaWMgc3Bl
Y2lmaWNhdGlvbg0KPj4gdXBkYXRlIHlldCA6LSgNCj4NCj4gWW91IG1lYW4gImhhcyBub3QiPw0K
DQpDdXJzZSBteSBwYXRoZXRpYyB0eXBpbmcgc2tpbGxzIC4uLiAiaGFzIE5PVCBtYWRlIGl0cyB3
YXkiIGlzIHdoZXJlIHdlIGFyZSB0b2RheS4NCkkgZG9uJ3Qga25vdyB3aGVuIHRoYXQgc3RhdHVz
IHdpbGwgY2hhbmdlLg0KDQo+IEluIGFueSBjYXNlLCBJIGd1ZXNzIHlvdSBjb3VsZCBzYXkgc29t
ZXRoaW5nIGxpa2U6DQo+DQo+CXByX2Vycl9vbmNlKCJFcnJhdHVtICNYWFggZGV0ZWN0ZWQsIGRp
c2FibGluZyBmYXN0IHN0cmluZyBjb3B5IGluc3RydWN0aW9ucy5cbiIpOw0KPg0KPiBvciBzbyBh
bmQgcGVvcGxlIGNhbiBzZWFyY2ggd2l0aCB0aGUgZXJyYXR1bSBudW1iZXIgbGF0ZXIgd2hlcmUg
dGhlIGRvYw0KPiB3aWxsIGV4cGxhaW4gaXQgaW4gbW9yZSBkZXRhaWwuDQoNCldoZW4gdGhlIGVy
cmF0YSAocGx1cmFsLCB0aGVyZSBhcmUgc2VwYXJhdGUgbGlzdHMgZm9yIFNLWCBhbmQgQ0xYKSBn
byBwdWJsaWMNCndlIGNvdWxkIHVwZGF0ZSB0aGlzIG1lc3NhZ2Ugd2l0aCB0aGUgbmFtZXMuDQoN
Ci1Ub255DQo=
