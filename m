Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2214BC496
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiBSBaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:30:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:30:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A05FF08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645234189; x=1676770189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6zuk/3P/39p/7bHhTqiEcNJj8s9K3OGHR3ilc4CAjf8=;
  b=RJMsfPLNlGxXldIU6l9OthPPukRwDvh25ybglchgNKKpt0h8/1wvPHcS
   yrqfoSmnI7sSgQ2FOpj7RdFHg8ORlmNlp1JTg9ACgaK9lSuQsWL9x3EKe
   LxVrJDMSrul5lW4zcNU1wQAsgGTOhvfNhQryf+UwiP0rGwgyz2mYWFngt
   yOjQ9aQ8cS8ERgMnJEG3L3VwjqlartEG1JaCHqPYbXsLcTbV2dLyMHVvF
   5KjJARbTi7xQ8fr6gM+uyP9bLYAzZTEAk2aoUxnI6i7Gg81BfAYCq1SHT
   FN1jRzdc4ylzjLoLFMT7IYDpbStGxYUCCaOnZais+uP0PKGcRuoyrlYDE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="275843939"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="275843939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:29:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="546566887"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2022 17:29:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 17:29:48 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 17:29:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 17:29:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 17:29:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgDf+R/UaLuAv9SCWGs1wPgk/92jm0TpCQs1+pixS71yx1DPt27lAmUD0QoSccBTmYBkHNYlfIUSW0ptfv3vjAr2yEymxSrTC2DYF73RFCNHUQNY2ewwSb2tZCnrElD9hT9vxTwzDCFy+frzQnm5DBwmMRRLsvQt6wG1aMiIQnjZENxlTQrb4vu71r+nw8rWeh3rBAx6OtKxBdkOdFl8ICg4lXYERMrAPK3fT+/YI0cc7pFiQXxbiwoSv+5cS8/KORV1erp+G5UUby60bnY8HvEBUMOi9HsVzySsXDSlNXK+FbFTfSwDRunGhk/BxsfX2j3s+LaroOyjceT+MmLwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zuk/3P/39p/7bHhTqiEcNJj8s9K3OGHR3ilc4CAjf8=;
 b=UDv4B3ufmnaSg2A2kipYP1yC5FOW/Dm1fXb8mFX5dmu1h7bvCDfUjARqpmFQeePizul6ZH4vA+OoDbGeMEvs47K2C/y7AE7JZfqKTaGb0PaDcoKD+wtifFxinhp/CLAx9Nr3lAZZqJw+bMVARmXE2XmTGJ+aCBTuS2Fgo0eUD57SOyzzl3i6UPQuieFqa/hDzYBDDhgCdMgsNT5nj4pus6BqSVbF9fOVtbSc9j4wURixYx0iBcEPHlgzmkPFN115W7NlVAS2N0dRlpCGuanu8GnzRWYOn14p6TTcDO1KZFaseakyXT6iId4ne8dJVh0yKiVCqm8xgxGOB5eiBgVdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1383.namprd11.prod.outlook.com (2603:10b6:903:2d::13)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 01:29:46 +0000
Received: from CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::556b:38a4:ae7d:5829]) by CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::556b:38a4:ae7d:5829%12]) with mapi id 15.20.4995.022; Sat, 19 Feb
 2022 01:29:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
Thread-Topic: [PATCH 00/29] x86: Kernel IBT
Thread-Index: AQHYJSosAdO5VT7wNUCytQNJuoyCo6yaFgWA
Date:   Sat, 19 Feb 2022 01:29:45 +0000
Message-ID: <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
References: <20220218164902.008644515@infradead.org>
In-Reply-To: <20220218164902.008644515@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c413fbc-c7f1-497d-c000-08d9f3474fd1
x-ms-traffictypediagnostic: SA2PR11MB5145:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB51451E822329924F0AB8E485C9389@SA2PR11MB5145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0aG5KrthcdzFxvwL+PHV+Ob+cQjoLvpzb+iHZ9ykO7fy/NT2tblT+zty+YAnRVi0j+0/Ulfo4UMbBeayjEMX6vzYC4KZxx8wUHN65wCUySB9r/xMl8Z7PcS+U3LdsfUaIijGEaqBdI44/lJVWvc1t1YG2IBvb9kArWzCKTJNAN8ZRAaci61tGKplo2qlVbrWMneWzkhICTMDd4V4X6i/juMYJOk9SyHQLbsxRzXMtOvacRJa61Lkr/Ql/+dk/hWYt9ZCOhZRWadMCEygbMMF8iByQwjDAOBRzaDxs0c4E+c2MtNS2yPU9eceRrpxKZEoS5GftIGUtXUbtdb5H8lFdDFlE1zAO3C4HazeBXZpUUegPGJUPKqIv0FbuuLezAe2+zhleevwsJvQWIvMU0lptSxZhtOv1Z0/7kNq2rs3kIY22HQZCQUjmY4mahh2LTQPlr7bPM5UG8LtOAGoSarzfu3xUvyCXP4Veqe0IHUEEvzaYlu7Vl3ottSIUionRCPc4BrPAE0t5/M7MSI9Zo/2HOHBiVJbBuv15AnfK5+SvTcoD7NDi3ePdj0D9CTR5Vv5peTk+e53MI/glGnqFFgmTWvuMu7lPy1TF5fX+WfhBn3X4hCFIMDmPDXs2/Meb9ylglSfRslQsFqbrvRn2MauLPe8LmLAMFYLlUkHnra9x6XOUMjw04obqS2rPbutSawkiFHBb4ZgfF4jUPlBbpDWSQtQsU6m2JgBVW5V30ZhBxI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66446008)(66476007)(66556008)(64756008)(6506007)(8676002)(6512007)(122000001)(110136005)(4326008)(107886003)(54906003)(91956017)(76116006)(86362001)(6486002)(71200400001)(38100700002)(2906002)(508600001)(2616005)(26005)(186003)(38070700005)(82960400001)(5660300002)(36756003)(4744005)(7416002)(8936002)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QktRN2FKYUtsc3I3aHF6Y1gyaUExQ0xXRURpSkxGanh4WHdLV1ZJZ3BCZ0tU?=
 =?utf-8?B?Wktac2JYQnpOTmgvdmMwN1pjcitHS1pJY3RDc0wwWHFSZXhLcXVTTENuTDQ2?=
 =?utf-8?B?Q240THR1WU1Ra3Y0WW95bk5nblJ6ZmJkRjJmeU5Ueis4R1hkNDJnRzNQckx1?=
 =?utf-8?B?L1E3a0krSG03SVplVGRDU21qNmM0M1NOY0xsLzJPUFJHVGcwMmJWMCsrVkFo?=
 =?utf-8?B?dTlBRzZWNVFweUdZNkRvVEFNbll2cGt3WmNrQnl4VVN6VDhrT3lkNnZ0OXFN?=
 =?utf-8?B?V2VKM2hMUUU0STF5bmZ4ZW4yaXZUb0tzNys4SlYzdjRIdGtMNWJIbVNxdVBz?=
 =?utf-8?B?djFpeEhUZVpGN2hjcG5GamZ0c2gzejh3dWM2TnN3OVpaTW9iTDJXQjVENW9i?=
 =?utf-8?B?WTN1aENYY1pWQWVpd1dmNlB4dkhEeFE0aVl1bkxJZmduSXRvbWdWckk5VTZS?=
 =?utf-8?B?alF4S2t6cThQalhrZHFkY1BUMWVsM0ZzSkhiODk1dzV4bi92WDdPN2puTVpj?=
 =?utf-8?B?eDlyaHJHbWc0d2lSZVAyVmUwR1NvMis5WUFZWTdQMkZDMjUrZnRrMUU1OFcy?=
 =?utf-8?B?TEhMKyswcXA4T1Q3TWV3bVVnYjA5MERvdm54THU0MWJnRUViSWhJek5YSG94?=
 =?utf-8?B?SmJxTzZOWmIyTjR0eW9zTDRNM0dQTEpRdnJBcFB0UkluakVMbHBIUFE3TmhM?=
 =?utf-8?B?ZXNCc2VYaGZIUzZJbjJ2QmozUXhyckErdXdna2lienE1R2kwZFNCZ1FtOTJC?=
 =?utf-8?B?NjlCd0FPSTNLTU1ySG9YaVk1aGhPQS84N1BxS0FZWTUrekhsSUtqZmcxd3Jj?=
 =?utf-8?B?WGNpYjRDSndMYnh1SXJ4TlBQbS9oWVpxdHdoZW00U3pZQnphNmZ3NTFxQmJi?=
 =?utf-8?B?Z1pmQU1LUmVjanhOS3pPVkxoQk5jWFltdkdCcUNoMVRZRE1qcWpoRkt3MDlk?=
 =?utf-8?B?NkhnN3d2a3YrUC90Z1JmVkxOb2Zkc2w0NWozdEZwbTFGWmlDMUl3TlJ6MEwv?=
 =?utf-8?B?S1g3OGpzeUJqOURqZ0hDVU1wMnljYkRMODdXN2RpbFNEQ3VaaDRDMGROY2VV?=
 =?utf-8?B?UktXTXpmbTJDUURmZU1qK3VlWHNXeEFWQ0l0UmRkMmxQYkxOK1c5Q0Fubm0r?=
 =?utf-8?B?TkpRUEE0Z0VKWktTNm1xall2VTlHWVU2emgzOW9KZnFQV2FNY1lycWEyZ2VE?=
 =?utf-8?B?RlRjVEZUbUR3ZHVRM0tnbUFIQ2FOYUxXYXZLOTZoYllrbjBHQzBaczR3Qzhy?=
 =?utf-8?B?SlR4R0ttU2lybVo1NHlJQ211U1N0QlhWRE9SK2czRG15cHY2RzRGOTdDTEwy?=
 =?utf-8?B?WXdMVU4xWmRSRjA1YUw4YnREaDI1d3hCNDRKUENjZ2M1MUtKeUlSUmNoQ3ZJ?=
 =?utf-8?B?RjNxR3VqKzdoSmNKTWVRWXhDUEdqS2xZRDFBZ1ZpdmNlY1R0SFpadFA4ZEFF?=
 =?utf-8?B?UzVrV3lsV0hLTDBYMng3a3J5ekNxMWNFQ3l3UTJEZXNVZlFXaFBXRmJkZVMr?=
 =?utf-8?B?NnpjckRuOXZTbjJTaXNhNFh1cTd1UW5IWHhwYUExb0hSdHEwbFlyNmxVb2pi?=
 =?utf-8?B?TWI3YUpCaW9USmdTdDZ6cGhqVnByL0hHUmRYcDM1ZC9PbTUrVFJuS3lsbCtU?=
 =?utf-8?B?RUE1T2hPM1dhVnlTTzhjL3N5UkFpaXVoY09LTlpOWUZHREU4ZFZ6R0ErSXJP?=
 =?utf-8?B?SmFOM09tM3VEZ002d1Z4cjBha1RSVFNaUjN0UjFYTXlySVl6REZpZldwcnBC?=
 =?utf-8?B?eXcxWVRxc25vZklIVzJXa0VMbnVJODhNUTFiNmh3V0h0S0o4V3lnUi8xdVlw?=
 =?utf-8?B?TUs5TjRFM2pzeEhkNUUyYWRVNzhZVi9yRkZnc3JENGlzUTdhZzNaeUI3WnVQ?=
 =?utf-8?B?b2NPZm1nTWl3eUxuMW93ZGN6Q2NMdkxFMjBQTURzSWxRWG5sVGYweENtS2ti?=
 =?utf-8?B?Vy8wMUl5Z1ZlU2lhZ0FFS3VMdkh2ZWFkRjlHSzJnaEhROEN5OEx0WGpWZEtT?=
 =?utf-8?B?cFZwUnFCQWw4RWt5dmE3ZGZYMlhGckZsVXlhZ2FGaFhaTldONUdpUDJub2cv?=
 =?utf-8?B?WTFRWmRzaTRlMUN5NmNac3hMYlJQT3Z4bXJrdG1OcEtUaUJCeUR3OTF5alBm?=
 =?utf-8?B?a2dOb3dFSGtlSVZzWWxWQWpnWmExdTBwNFZ1cXpQeW5nVzZ6NUJyZ1VLRUha?=
 =?utf-8?B?TlFwaUlmem1hbG9UbDkvTVZGQ083ekdkcE9iRlQ5UWw1TnRxT3JrQjZSS0c5?=
 =?utf-8?Q?3R7C1AAwfjn51+CbrZ2JfNGZrp0uKqQ2Fy43/sVxHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E099609A452BB4A906B84EB65EE9378@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c413fbc-c7f1-497d-c000-08d9f3474fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 01:29:45.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G1p+ops4ZDxUES9d1EhrHONtINT8zlPic/m+MmJtRaA1cTwZCUUVlEiMdY/qYhwDou6uBpmpumrN3yo7I28tGytJqnqmkVKKke/Rod4qZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTE4IGF0IDE3OjQ5ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiAoYWxtb3N0ISkgY29tcGxldGUgS2VybmVsIElCVCBpbXBsZW1lbnRhdGlv
bi4gSXQncyBiZWVuDQo+IHNlbGYtaG9zdGluZw0KPiBmb3IgYSBmZXcgZGF5cyBub3cuIFRoYXQg
aXMsIGl0IHJ1bnMgb24gSUJUIGVuYWJsZWQgaGFyZHdhcmUNCj4gKFRpZ2VybGFrZSkgYW5kIGlz
DQo+IGNhcGFibGUgb2YgYnVpbGRpbmcgdGhlIG5leHQga2VybmVsLg0KPiANCj4gSXQgaXMgYWxz
byBhbG1vc3QgY2xlYW4gb24gYWxsbW9kY29uZmlnIHVzaW5nIEdDQy0xMS4yLg0KPiANCj4gVGhl
IGJpZ2dlc3QgVE9ETyBpdGVtIGF0IHRoaXMgcG9pbnQgaXMgQ2xhbmcsIEkndmUgbm90IHlldCBs
b29rZWQgYXQNCj4gdGhhdC4NCg0KRG8geW91IG5lZWQgdG8gdHVybiB0aGlzIG9mZiBiZWZvcmUg
a2V4ZWM/DQo=
