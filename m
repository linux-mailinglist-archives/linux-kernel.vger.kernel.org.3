Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18954E2CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbiCUPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348811AbiCUPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:55:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C1B0A42;
        Mon, 21 Mar 2022 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647878064; x=1679414064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yzFpC7VxjWrIafcSj+avkexiroeO263rG7Ei9+ahZKI=;
  b=QWIHcaiAYakiQ+jQDmckC/zn/bjGBiSyiz3viRDYfstwZeaQvvM5nPpx
   joaSbV0Ugz1+/xGt7fGs61c/KyA7odcCBp9iROXidTky+W37ScXOkvOGf
   6ZneXVP0dqurV76xYqDcjNLtyqueoCSR7g53NSEg4/Zg+LzM3KLRb2zJw
   kXBXHTMTeoHHhOILC5BrSx3sZNA+Dxo6ZGst3Q8OR+vP8f2Lgnu6H0uLJ
   m49pV30gndSQeYsOCL8nF6V6+uQnjeOFLuFme8WNj1wETgwlODnQuakCY
   POU1lktwctMs4nwfzo/hcTiCEWb2UhcARaa2MGb17xYSJ1fuGO7lkiuzn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="256404011"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="256404011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="692216313"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2022 08:54:23 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 08:54:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 23:54:19 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Mon, 21 Mar 2022 08:54:17 -0700
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
Thread-Index: AQHYMqwUN/kZY3Cbfk+jlxJiPgOL36zCUXmAgAETuICAAHR30IAE7oAAgAFGNfA=
Date:   Mon, 21 Mar 2022 15:54:17 +0000
Message-ID: <16c12d3d310f414ba43219cdf4b31539@intel.com>
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
 <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
 <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
 <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
 <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com>
In-Reply-To: <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com>
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
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBcyBmYXIgYXMgSSBrbm93LCBBUEVJIG9ubHkgZGVmaW5lcyBmaXZlIGluamVjdGlvbiBpbnN0
cnVjdGlvbnMsIEFDUElfRUlOSl9SRUFEX1JFR0lTVEVSLA0KPiBBQ1BJX0VJTkpfUkVBRF9SRUdJ
U1RFUl9WQUxVRSwgQUNQSV9FSU5KX1dSSVRFX1JFR0lTVEVSLCBBQ1BJX0VJTkpfV1JJVEVfUkVH
SVNURVJfVkFMVUUgYW5kDQo+IEFDUElfRUlOSl9OT09QLiBBQ1BJX0VJTkpfVFJJR0dFUl9FUlJP
UiBhY3Rpb24gc2hvdWxkIHJ1biBvbmUgb2YgdGhlbSwgSSBkb24ndCBzZWUNCj4gYW55IG9mIHRo
ZW0gd2lsbCBraWNrIHRoZSBwYXRyb2wgc2NydWJiZXIuIEZvciBleGFtcGxlLCB0cmlnZ2VyIHdp
dGggQUNQSV9FSU5KX1JFQURfUkVHSVNURVI6DQoNCktpY2tpbmcgdGhlIHBhdHJvbCBzY3J1YmJl
ciBpcyBkb25lIHdpdGggYSB0cmlnZ2VyIGFjdGlvbiB0aGF0IHdyaXRlcw0KdG8gbWVtb3J5IGNv
bnRyb2xsZXIgcmVnaXN0ZXJzIHVzaW5nIEFDUElfRUlOSl9XUklURV9SRUdJU1RFUl9WQUxVRS4N
Cg0KLVRvbnkNCg==
