Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DF4B9085
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiBPSmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:42:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbiBPSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:42:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7B9F3B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645036920; x=1676572920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xDWjGvsFBrq0ZdxBzAcydsP/AMMl02rxok1sZdO6bbI=;
  b=eCHADF1nbV2Oi+Bg6dvDXLyUWkOQizz63Ahp0BMSeD2wViFwcjWcuKtt
   8aceZ8DiMlZNjStj6eVnMqGBylc22Y4bo/mjkVIEHRP8euz0KHNZeS1i5
   oYHH/pf9PE3Mp891IKEsk/oHQfF654QVSY38Ca119Rs0/p0S6sL2u+RRY
   QFVXUCpgQo9gqc0qsRONtRkGyvZGZLLTicH/q1eMneOe7YJwRXAYIJn3M
   jiN1ShS38NpgSSc8AYBBWEqGQ59w/bjvR7GhwD1FW1iMz4bnEgod/Euje
   wHxt2bR2/CKRV03OyBU/kgukRYHdY1HlQCMCU7qi2MscrcQbOp9iNsDRE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250432934"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250432934"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 10:41:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="774185960"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 10:41:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 10:41:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 10:41:58 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Wed, 16 Feb 2022 10:41:58 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Topic: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Index: AQHYHP3vSEwGqGB1nUuCa46AJSTbFqyVvVCA//99xQCAAVDKgIAAWhMAgAAlCgD//4KmEA==
Date:   Wed, 16 Feb 2022 18:41:58 +0000
Message-ID: <9f402331d25c47b69349c8171bbd49c1@intel.com>
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com> <Ygwka++3eipjQzB2@zn.tnic>
 <YgwnqTc8FGG3orcE@agluck-desk3.sc.intel.com> <YgzRsfWOmqkNiNI7@zn.tnic>
 <CAPcxDJ4=iknzYbN=b2oQxvJyODkQ_MWEj1wkKEuGwf4HQ3aPZA@mail.gmail.com>
 <Yg08Uhg0fZ9xZuP2@zn.tnic>
In-Reply-To: <Yg08Uhg0fZ9xZuP2@zn.tnic>
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
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXZWxsLCB3ZSBjb3VsZCB0cnkgdG8gZGVjb2RlIHRoZSBpbnN0cnVjdGlvbnMgYXJvdW5kIHJJ
UCB3aGVuIHRoZSAjTUMNCj4gaXMgcmFpc2VkIGFuZCBzZWUgd2hhdCBjYXVzZWQgdGhlIE1DRSBh
bmQgcGVyaGFwcyBwaWNrIGFwYXJ0IHdoaWNoIGluc24NCj4gY2F1c2VkIGl0LCBpcyBpdCBhY2Nl
c3NpbmcgYmVoaW5kIHRoZSBidWZmZXIgYm91bmRhcmllcywgZXRjLg0KDQpJcyB0aGlzIGEgY2Fz
ZSBvZiAicGVyZmVjdCBpcyB0aGUgZW5lbXkgb2YgZ29vZCBlbm91Z2giPw0KDQpJdCBpcyBhIHJh
cmUgc2NlbmFyaW8gKG9ubHkgYSBwYWluIHBvaW50IGZvciBKdWUgYmVjYXVzZSBHb29nbGUgaGFz
IGJpbGxpb25zIGFuZCBiaWxsaW9ucw0Kb2YgY29yZXMgcnVubmluZyB0aGlzIGNvZGUpLiAgWW91
IG5lZWQ6DQoNCjEpIEFuIHVuY29ycmVjdGVkIGVycm9yDQoyKSBUaGF0IGVycm9yIG11c3QgYmUg
aW4gZmlyc3QgY2FjaGUgbGluZSBvZiBhIHBhZ2UNCjMpIEtlcm5lbCBtdXN0IGV4ZWN1dGUgcGFn
ZV9jb3B5IGZyb20gdGhlIHBhZ2UgaW1tZWRpYXRlbHkgYmVmb3JlIHRoYXQgcGFnZQ0KDQoJV2hl
biBhbGwgdGhyZWUgaGFwcGVuLCBrZXJuZWwgY3Jhc2hlcyBiZWNhdXNlIHdlIGRvbid0DQoJaGF2
ZSBhIHJlY292ZXIgcGF0aCBmcm9tIGtlcm5lbCBwYWdlX2NvcHkNCg0KLVRvbnkNCg==
