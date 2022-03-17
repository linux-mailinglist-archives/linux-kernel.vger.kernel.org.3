Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539074DCBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiCQQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiCQQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:59:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E102700;
        Thu, 17 Mar 2022 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647536280; x=1679072280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wb78o+XM//VuJF36GZU4ISSlgqvujy19VTeneq6vSSA=;
  b=Aw3qBi6KeuZewHzQUICz2NGYJkPlO/D1dfeJatDH3/el8rcXwiOH10k5
   OEjqYBDLndJvrXNl18wIYRBJ05KlZZ9V6d1q70oHuL1LmbWdoKbIB9bVd
   SBYQ4Zky+SD3HoyoRUOVSzpZX8B52ZohaZR5uzu6IE1dU/LfVVnPstONI
   Qa5rTPqCayXQCLQO1K+3bWMsBQey74Hw4HEY1mydA40NGzL4lIdQcnNWQ
   pU6v1OK9SzZaMA4dFvRdT8Zp8SDveapLD0mA106+TibRWBenqg5dt4L9g
   HsbNhv52p15m5YXl9IOb+VGxxlEWWe+6BroWre5lpF+Lz20pjhw5n126T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="244369526"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244369526"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 09:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541442193"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 09:57:55 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:57:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 00:57:43 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Thu, 17 Mar 2022 09:57:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: RE: [BUG] kernel side can NOT trigger memory error with einj
Thread-Topic: [BUG] kernel side can NOT trigger memory error with einj
Thread-Index: AQHYMqwUN/kZY3Cbfk+jlxJiPgOL36zCUXmAgAETuICAAHR30A==
Date:   Thu, 17 Mar 2022 16:57:41 +0000
Message-ID: <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
 <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
 <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
In-Reply-To: <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
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
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtICAgICAgIHJjID0gYXBlaV9leGVjX3J1bigmdHJpZ2dlcl9jdHgsIEFDUElfRUlOSl9UUklH
R0VSX0VSUk9SKTsNCj4gKyAgICAgICBwdHIgPSBrbWFwKHBmbl90b19wYWdlKHBmbikpOw0KPiAr
ICAgICAgIHRtcCA9ICoocHRyICsgKHBhcmFtMSAmIH4gUEFHRV9NQVNLKSk7DQoNClRoYXQgaGFj
ayB3b3JrcyB3aGVuIHRoZSB0cmlnZ2VyIGFjdGlvbiBpcyBqdXN0IHRyeWluZyB0byBhY2Nlc3Mg
dGhlIGluamVjdGVkDQpsb2NhdGlvbi4gQnV0IG9uIEludGVsIHBsYXRmb3JtcyB0aGUgdHJpZ2dl
ciAia2lja3MiIHRoZSBwYXRyb2wgc2NydWJiZXIgaW4gdGhlDQptZW1vcnkgY29udHJvbGxlciB0
byBhY2Nlc3MgdGhlIGFkZHJlc3MuIFNvIHRoZSBlcnJvciBpcyB0cmlnZ2VyZWQgbm90IGJ5DQph
biBhY2Nlc3MgZnJvbSB0aGUgY29yZSwgYnV0IGJ5IGludGVybmFsIG1lbW9yeSBjb250cm9sbGVy
IGFjY2Vzcy4NCg0KVGhpcyByZXN1bHRzIGluIGEgZGlmZmVyZW50IGVycm9yIHNpZ25hdHVyZSAo
Zm9yIGFuIHVuY29ycmVjdGVkIGVycm9yIGluamVjdGlvbg0KaXQgd2lsbCBiZSBhIFVDTkEgb3Ig
U1JBTyBpbiBJbnRlbCBhY3JvbnltLXNwZWFrKS4NCg0KLVRvbnkNCg==
