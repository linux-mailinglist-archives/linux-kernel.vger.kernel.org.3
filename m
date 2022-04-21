Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E7509998
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386256AbiDUH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356531AbiDUH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:56:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B311176
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650527644; x=1682063644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sXUCUQJMVaksPZsHWhPF2WG2d7YO8SKxSrhLkMFpyYQ=;
  b=d3vUOeurGQFpA4T7Wzjzx2gn8WSCtz5QP9QMZpYWkKm63vBIO5QORRuP
   Yj6FTvGO9hwOOIwuxf3k9zQ29w0ddIieRue/S7Lw5g4QPElSsyre0K/XC
   7UM+KQovBfJ7MIQoDm9zVYRv7gpQ6x3q6whOIR1x7V/N4nBfqjvUtFaMc
   bkskWxCYxZiVXFfqP6PwuAnArlPgMqUvdHCm2EuYGR5NdZxqWG3Oj8TqO
   dBHLMnyQFCepW0S/kSanPLycgq8ybC4eqrqgciWySDNHfpvrNi8I76GN4
   tnBCvOEAj/SqKfXg0Gai3Fv4VFHRaPfUcWNLolZK5ahFTvE5kxEq/GHsI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264444651"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264444651"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="530160146"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2022 00:54:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 00:54:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 00:54:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 00:54:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 00:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og8YZtFKWK0i/e3RsgvpwP0vM8n38eBBRt7b7GLYYSKBvIfywXlunJPa+tjOB2pVIGsettSJlCbb+Crz7r7scKtEZ/kZMrqKDgX2hueIFXO5nMtKxvxc9wo+zW3lyoQMpYkirFGmpotKhMyhDFT49NI/b3BKRMSu1gVWuMgDE1BGT44LaOJSMHCapFO3idSycrRFUGfexMDUZ2pcC9n4IuN+Gvld8vd5QIJL/sy+u/CAM7LKDFG/c58fjeccMo4riIsPO58PbdaZxqv+qknbRL3hTZAQnaewgy53icTAljMBuVbEdatUoUnphGDYtf+OjGLNjUBMHwNc20prPDXu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXUCUQJMVaksPZsHWhPF2WG2d7YO8SKxSrhLkMFpyYQ=;
 b=fWYRzC+qSSlenvf8tC9AifayULGQ3amRqRrqu97bKyoogz7q+oufuVlrBy5fxA3v/qV3HhUyZAVayXAzYnwv1PWXEhJynLVdqv1jr8miTH+dRoEaa+sUz8NVCy/pPJ5ltzZXG1NdAFSBn7+XDix9kqB+0JgTHJkOh/1YRNYBM6qimQJhxWpxGjVBRXFC3bdGSGQ4QYikcOUpJEzovdqLDTdTTaWd+tfMmI2Q6MskXPqqe/E2kxnIq2sQKlKSeFHzwSVvMEGdhQYSuglzlKaBh2JQftBBcknQOWT/byMmiCzzk6qiFxBtEeKGVBhC+wQ8CbWtoOx7d903rp++fj/iJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) by
 CY4PR1101MB2263.namprd11.prod.outlook.com (2603:10b6:910:19::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 07:53:58 +0000
Received: from DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::edcc:cf0:e4d5:db89]) by DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::edcc:cf0:e4d5:db89%8]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 07:53:58 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/mm: Forbid the zero page once it has
 uncorrectable errors
Thread-Topic: [PATCH 1/1] x86/mm: Forbid the zero page once it has
 uncorrectable errors
Thread-Index: AQHYVLnSBnalfdCv+k25iM82CwKnBqz4zooAgAEpglA=
Date:   Thu, 21 Apr 2022 07:53:58 +0000
Message-ID: <DM8PR11MB566941C063EA44929147035E89F49@DM8PR11MB5669.namprd11.prod.outlook.com>
References: <20220420210009.65666-1-qiuxu.zhuo@intel.com>
 <3720f7d9-a4f3-214c-1dea-f8ffc837c1da@intel.com>
In-Reply-To: <3720f7d9-a4f3-214c-1dea-f8ffc837c1da@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8dc040c-b0a4-427a-55e5-08da236c17ab
x-ms-traffictypediagnostic: CY4PR1101MB2263:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR1101MB2263BCA40E3B37FB196F3C4289F49@CY4PR1101MB2263.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPwjWdH9wSdE0A9Ok54Fu8K5E6lbuaKiLMcU58wmhLBe+vSpVksfk/grzWQ3Shx0lbUlWjPTX0ovxWjoM4MMM+FO9Sf+K1xGQFPaS2dJUNusdIMyXwlC6l5SYEBmu6vc3cYMFzl7fS9Tm/thr8UbaPH6eRgBgQRSdxregB5wkwzuDhLnNecpU1iGgEQ9gUAi6a6az9F9u5d2EhXeOPpysRr/wrBtSNC7ICSTyBpILwlGitTC36yRFFf4t1Ui1w5YnqFJSVxWTLwKQ+TU+JEN0h5UcKK0YPJTF2DVWaknsTs73lmwv3ewZm6rwRfAemKxKWXlvBOlZxNR0R3DamiJrfemcQW2GAvUNQAsUiGWIfuJiRkNgYIvD/2ehhiJxjArC2wjPUk5jsAOv00mRs8pBtxL85A3mh4dVOrYyDPR8CiD8Pa+2XdCNV/rEZfG/x/mt/QO5HmYvcqMUt9MyccmqYqTz87y7WXY2ZG9MPxDqecQtK9MI4p9uQLDu78to8DTJ2bo/A5k0TP72lJCvxs5bbInfF/jzDecNOJ7a1XREnec0jYr1LCEtK8laryPri1x/IgfZMk+1WX0KqPRMQImq9LYZf3+2e7CGCIB+8VncDzDyLNXGZXJldRqXYX9YBa0246uGRklIJMIImwOYoGxuPOm3/23FY7IsE34QMENY/XGResdFsj82EEG9G/fQ6tPTREJ+r3sMQWUcBMYgOZHyZTyGBXZ++XBfMybx4NEhKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5669.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(9686003)(186003)(26005)(6506007)(38100700002)(71200400001)(38070700005)(110136005)(54906003)(82960400001)(316002)(33656002)(5660300002)(508600001)(4326008)(66446008)(7416002)(8936002)(86362001)(4744005)(52536014)(66476007)(921005)(55016003)(64756008)(66946007)(66556008)(2906002)(122000001)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1sOTdPc3ZUeUJxTlNYOU03VHFHeUZGU0IxQTJIMTJkRkxSWHpGWnQ5YlNM?=
 =?utf-8?B?YmRmbU03N2xuTjM5R3VSTlkwbC9GV2tVR2VITmlSRSsxQWYzSUpNeEV4eFFE?=
 =?utf-8?B?enRwNEtlREl3SWNXbUFsVGcvbTFZT2pXd3dBTHhXbmlJcjNVR0xBMlh3WU9R?=
 =?utf-8?B?OVc3YVBEMlNWcDQyUWdPdWJRckV1bjFvOGs1cCtXSXVub3FMc0Q5cGliVkF2?=
 =?utf-8?B?aGExNWp4MHYxNmZYalBkNW1hTEZYU2d2TGJQL1dhMU5qRTRLbnVLSGMxeHJG?=
 =?utf-8?B?Q0dSRzRKcGhnbG9HOXljbUgyajJvazljUlJ3ZnRPajcyMXovRnJjZG5zdU1E?=
 =?utf-8?B?SEE2dk1FUWpEMkNFT1VTeXFOcittTUJYSzljcTV0cGFpU0tWZkZwN2ZYVlFD?=
 =?utf-8?B?Nm0xYldUbElEUUhFbi9BZTRieVh1TU5ZT3c4QmJENmkxcjNYanRxNTJvVGhX?=
 =?utf-8?B?b2k3ZkF6RUFmRGQvaXEvSmRjbXZ6TEtLVGlHcUU1V3c4WVVlRzh1bE94ZGs1?=
 =?utf-8?B?QmtzMXBWYkJNN0tLZGZwd0RudTAxV3Z2MnVSdHdra25BaFJidmNXL3ZXeTZG?=
 =?utf-8?B?MW5TTWtIcG5CRkVnRTdldGVSaUVoVTg2Q0lWMThVc3JnZzZSK0diRDhTVndw?=
 =?utf-8?B?MlFxeDF0LzA1dHplb1hqZnpFVXdrK2xDOENac3BBZ1B4ZXVUb1ZVNCt1anlz?=
 =?utf-8?B?RVRHYzFwT0huREVFcFNzK0xYWVJDdFJSSFB0ZTI4eEdnVVZyNXkrZDc3LzhU?=
 =?utf-8?B?TytwQ2dVaDBFdFdMU2J1eDU3YnNvMHVxR2l1c2c4ZDRNT1AzdTR4OUkvekFV?=
 =?utf-8?B?ZTNFQVZRVGhBWnB4WGhVd204eUd5SFJHUEFpby8vaGhNQlU5UlJSQmEvVmpq?=
 =?utf-8?B?bVBGNUVlcTNjWHhCVkxIWnd3U1ZuZGxNazl0ODVmR0FzVFNZUWpJSE1pMGpw?=
 =?utf-8?B?VFpSTEVKbUVrd3orRkREK2xpZWg2QWNUem5ocG1PNVBMUnVWQ0FDZytpZDZD?=
 =?utf-8?B?ckVPdzBRaTNwTldWbC96WTNCVXo0VlVVZWRtcnJnWEVNM3RxTGFWNG56V1NO?=
 =?utf-8?B?dWJCTkd3Q1JBTy8vN3M4d1QwWnVYU2xUS3RJeG0zRTVNQldDREF3a0Q5eFQ2?=
 =?utf-8?B?UUVHWE5JMjdQNTRoUWtuSDQrbFhqRkxpUDArL2dXOTVyUnlKbFpUdzdlcldE?=
 =?utf-8?B?UnUvR2I1dm80UVBsbi85VDJ2N1BwYXZFMll2T0pFcW41U3NYRU42SEp2RERs?=
 =?utf-8?B?STZhYTlnSUorYWV3UE9UTUUwbXlEZDR3bE1xMi8xcmxPNllRWlpTT1dJZWM0?=
 =?utf-8?B?QU1NQituckxnZUlVMGVpUjlPZ3RDRUNCNjNDbjNJZzhKbGttK05KQkhiemFL?=
 =?utf-8?B?N2xkY2FONUh1c0ZBWjNCK2VyajRxMlR2SStmM0pVNE1GYkNiQTVEVU8wVDZq?=
 =?utf-8?B?ZnpFd3BnVWRtK0JmL3J3amVYM2pqMTU3WU55WGRWUDF1cnA0clUvVm41MjhQ?=
 =?utf-8?B?VzJPOG5MQTBmNTNNcWYxVVdXb3RaOVQxNHQ2Zm9kM2dVWTEzQ1dsZVZDcU95?=
 =?utf-8?B?NklwQ2dNdThQT2xKOURkUU9LMmFKcG5qcG9PRlA5VW1SUlJmVllMejlMNGVU?=
 =?utf-8?B?WWNZN0NZOFozaXFMMXNLQVdydDJiZVRiM1pJbU5PKzBOUFRDQklRdmlOYWRQ?=
 =?utf-8?B?VWg4bzB0QmZycTFBLzRTVjlNLytOM3JGYzFSV0VYOVM0T0s2Mjg2Y3EvYnM3?=
 =?utf-8?B?a1dOUXd2SnBlRFdtc1NKMmFaKy9seVQyREdiV0FCR1pKOGdoeWxjNzlGelVW?=
 =?utf-8?B?d2xFMU1qdWpnVXZ0cWxkVU1aOFhVTlBrRVNhRHExUjFnQXFxYkVJU1VSd2VR?=
 =?utf-8?B?eEZ3NGNWUkg2SGl2RFJVYnBOZEFhZmZDNVRVdm1iNnZZY1pwL0d1aEhnYVFH?=
 =?utf-8?B?L2FIVXVFMjV4UU4wd1FpUTRrNDlxSzlQeDk5V1p3TDErdG5LdjI2R2RnZ0dL?=
 =?utf-8?B?NkJ1dWtyNGZTQ21IUEFlSjBaSHBRbHJkWWpZVEtwamJFN1BuRnZmNkt6elYr?=
 =?utf-8?B?Rms3YjVXdVdwRDBYb1BvY3NGenllOGhkTDZFMFdBb29WRVREQjZLTml5eGIw?=
 =?utf-8?B?TWwxVXVHcVFMSWVxeWZBV05PYWRYeHQ5eXFKWGxta3YyeVpkWVZZNzFtbnZI?=
 =?utf-8?B?ODFWaGR5TFVERDFBZTZSREJEOVlDVkhRc0JTajJraHhEQU5DdTVRTnorRnZB?=
 =?utf-8?B?YklhTjJMa0t6OEFQZHlXZ1F2TGhqMXduVzFjbzg2TXZxZWF6eWg5WlV0T2xo?=
 =?utf-8?B?UzdHNWtkNzVvb1I2ZExBRVRsY09iTEkxbnB1bFkwcUY5TWRKeXpwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5669.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dc040c-b0a4-427a-55e5-08da236c17ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 07:53:58.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8+72D8iB6XpVgoaxK7Ykaa+9JVkxajlbbl8mEJkkp6s7OWX9T/lxwa+CwLRGYcE8avvJzR9WvbeMezYnKdu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gLi4uDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSB4ODYvbW06IEZvcmJpZCB0aGUgemVybyBwYWdlIG9uY2Ug
aXQgaGFzDQo+IHVuY29ycmVjdGFibGUgZXJyb3JzDQo+IC4uLg0KPiBUaGVyZSBhcmUgbG90cyBv
ZiBwYWdlcyB3aGljaCBhcmUgZW50aXJlbHkgZmF0YWwgaWYgdGhleSBoYXZlIHVuY29ycmVjdGFi
bGUgZXJyb3JzLg0KPiBPbiBteSBsYXB0b3AsIGlmIHRoZXJlIHdlcmUgYW4gZXJyb3IsIHRoZXJl
IGlzIGEgMC4wMDAwMDU5NiUgY2hhbmNlIGl0IHdpbGwgYmUgaW4NCj4gdGhlIHplcm8gcGFnZS4N
Cj4gDQo+IFdoeSBpcyB0aGlzIHdvcnRoIHNwZWNpYWwgY2FzaW5nIHRoaXMgb25lIHBhZ2U/DQoN
CkhpIERhdmUsDQoNCiAgIFllcywgdGhpcyBpcyBhIHJhcmUgcHJvYmxlbS4gSnVzdCBmZWVsIHRo
YXQgdGhlIGZpeCBpcyBzaW1wbGUsIHNvIHBvc3QgaXQgaGVyZSB0byBzZWUgd2hldGhlciB5b3Un
bGwgY29uc2lkZXIgaXQg8J+Yii4NCg0KVGhhbmtzIQ0KLVFpdXh1DQoNCg==
