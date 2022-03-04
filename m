Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7444CDF79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiCDVB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiCDVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:01:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9A9FD9;
        Fri,  4 Mar 2022 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646427666; x=1677963666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VjE5SQTXxcv9yH10VlgYyxJXzMzTnv0lxqg2YttM5ew=;
  b=W7zK2rYiW1tXaUw6tdNLagtCRnu0b+g8MogjJzEGFtUyetu8TFP8W/zy
   eRKHWw2jJFf+StRBl9XmAu7hSZ2SeluOzxiWCuFnjjhFN8/SF3uqFLTab
   iFv6sRF7bHpnXfnrPyg6wT/ar8mi1NRnOoS8cWfL64Zit8Jxr1RFcuNns
   nI8lC/8COrNH38Ef9lGK5Ll5lNTqL14RigdQQzhpbDrCR4jsw3h78sLL5
   E5bV1e44xum+bCLRv31LLWDtODJio51uN+5XB2pRb4J688RqaW9qrTaGo
   GZ5A2z9naxKsWFsc9z1Rjo4bTVntzyEZStYNDf4l1ZWCIiiTcxCur6TxF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="234020443"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="234020443"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="610056761"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2022 13:01:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 13:01:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 13:01:04 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Fri, 4 Mar 2022 13:01:04 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Thread-Topic: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Thread-Index: AQHYLaZd5d+yEBuhdEqmhIRDOkET6qyu6T6AgAFSX4D//33N4A==
Date:   Fri, 4 Mar 2022 21:01:03 +0000
Message-ID: <52a16a3eb3f54ec88f7a841baa7000fd@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com>
 <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
In-Reply-To: <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
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
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gWW91IGNvdWxkIGp1c3QgY3V0IHRvIHRoZSBjaGFzZSBhbmQgZG86IHN5c2ZzX2VxKGJ1Ziwg
IjEiKQ0KPg0KPiBUaGFua3Mgd2lsbCB1c2UgdGhpcw0KDQokIGdpdCBncmVwIHN5c2ZzX2VxDQok
DQoNCkkgZG9uJ3Qgc2VlIHRoaXMgZGVmaW5lZCAob3IgdXNlZCkgYW55d2hlcmUgaW4gdGhlIGtl
cm5lbC4gSXMNCml0IHNwZWxsZWQgZGlmZmVyZW50bHkgZnJvbSBob3cgdHlwZWQgaGVyZT8NCg0K
LVRvbnkNCg0K
