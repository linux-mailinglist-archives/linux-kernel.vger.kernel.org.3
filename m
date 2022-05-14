Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224052749E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiENXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiENXHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 19:07:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496819027
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652569623; x=1684105623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cp7JwIrfp+LORiQyTOPnfe+9TfzE76wgPHqx27KVgYE=;
  b=O/Z46jxtnbk6tTAN8cwsJevIlNVCaXnRBmn4WuGXwgavuC4kpTY9xOlq
   7c5Znvqw8p2PLkPrDfExgAIdg3FTQZMf/Isy4eX0p7Nex4hgCmAPDxs5Y
   LS+KQ+TP8QZGuslHjBDK5iGClE0erPbmYJmjOqCLvKK++GgAGbdD7l9MN
   VA3f+wQK4UKc02PwjcdMcNGywGfmxdIsh3s1uhD8YZJcimqPiHV0xsbu1
   0ecMYwMCAaEFlzD7U871Yz4MrXy0Gw83zEzq87qdvbjNj5j0fL5kHp7dE
   B9hE7k1QzdeNwgKmKbkKV3dq5yw2hx1DJq8RnqKOmZLnOwD3dqvCckoE7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="251088422"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="251088422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 16:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="595833852"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2022 16:07:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 14 May 2022 16:07:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 14 May 2022 16:07:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 14 May 2022 16:07:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 14 May 2022 16:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btfU6I8wWl6uD6amI9InqzZv1+abYxlDZwIIdHqEaDGnracy8hVowqgrAgg9gebFhJi7yXQycuNIMUZ/IcoUS1i3I6Rv7eDgb1mwA1opunOoOEEcEUHHpCc/mLB4IUMWXQpFUNe80nYX1KomWQHy+Yl5Nu3rlpg5RljYfQMTF94AkkTKGjZEa/uWAurkB0ag/QUxWQK/XHvqrQA+1D11FockWO8qEqdEkJqCFs52zYmHQRq+kBIm74coXakp+95rmVybl9ApTexVBfP7CZvZHfkgVm+W6SAXmIE+UdjMiAOSX0Aj7tQFJIl44Z9WJgvGO2cOVkMzR/ybBMNfQbdJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp7JwIrfp+LORiQyTOPnfe+9TfzE76wgPHqx27KVgYE=;
 b=DcigKlYUiq+Vud3LPl6elBrkKnkd5O1PSi/woAIBG69Ok1ZOCEK392/u8YGBjLDAdLwmeWdnuC1dSQB38I6wT1dPatFbFqDtsLJqBX/g49VqF9KoI/uXFxXvIrqSYPa/v+KopD7YxiVMlINXxBpqbGN6LCpvVx01De+vNPce1pUVsdvL4AIHz4boDkbso3Im3+k92hM4gw60aFMOZPmQ257ZcJg8mTt0XhRSY60blFBDgYASxJuxcx+OfPu1noa2wKkaekicHSCUloi/4cbXbtk3+v4seaPzRgye6b1PUzgYF7q8Z+PBYTWbyYLZf/9d1vgmxf44kv+a6ZmgYmV85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3269.namprd11.prod.outlook.com (2603:10b6:a03:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Sat, 14 May
 2022 23:06:59 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Sat, 14 May
 2022 23:06:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Topic: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Index: AQHYZOBkvB2PlILtfUOVczGp43rrrq0c3EGAgAA5TwCAAF3QAIAACzIAgACTWYCAAPLzAA==
Date:   Sat, 14 May 2022 23:06:58 +0000
Message-ID: <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
         <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
         <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
         <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
         <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
         <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
         <87k0aose62.ffs@tglx>
In-Reply-To: <87k0aose62.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44905f7e-38ad-436c-2f09-08da35fe729f
x-ms-traffictypediagnostic: BYAPR11MB3269:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3269B5325B29AD8BCAC30399C9CD9@BYAPR11MB3269.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+i8kfaFHegkSEpDTVv+mYnRXTlFrhBuUby9DmtAlFX0xWtNWiggRHHJEnT+v12cM1Jzawrlr5kgDdhbQw8NcfAYKX9fzqAhSqMqH3CAH7OyXLD9BAFqJ9TcPBnOFiTBEzT8JAHQSfyho9X4et6rSon7gf+SFKiu4O/mfaNmRFN3SXRFpu0DjV4CkGRsfbFuiXe8mjgx85RN/Zs9Bft7GY9GDkSUH7Hrd/r1g9gBSEgLmWpI0HIaI3hTr2dbINUAO3KBCsMNnIXGPvFNCTLWFbwPpL0kH7n3PUvfVij6mF2MXcxPdNxZIrp8l085ZAessil3zv6294Bc30suOCkisTFn88vxdtxpcm9dUXG20bBmQkE90lk53ZPEXfAjogWtRqjmO0EoyaRKtSWLQT+2JIoRja+mfeFPs8GTKNiTDYcIlbU7XGTALJpZDsdvTshqS25f0KAEPef4PksJ4Tc2VnytoRnah0/08hYNnPfav4fqnA+qW/JyvUv0lJYn1uaLiADqNHSWW2RhI+is4qbRMdIOoxJb+EpSEQ6NWqLoCnc0PeTB7R3Xxra7K2LGtDf+ialpKSTEoaiU9DtNXIDifnhGyqO5n867aoVy5yY8uz1v90g6D5ZPK5KfhVsOFzA4SAf3b09verUYY0CuXrYzQgkXwUbkXwNdA5I9uH8KaIYPi/8l8+9gMGGBzieNHfT7BRxSWKkYy9lmaOh6d0qAuaEVp37AnkIMAhkrOjfEKJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38070700005)(71200400001)(7416002)(86362001)(26005)(508600001)(6506007)(8936002)(6512007)(36756003)(82960400001)(110136005)(316002)(64756008)(66446008)(66476007)(66946007)(76116006)(4326008)(66556008)(8676002)(186003)(6486002)(2616005)(91956017)(54906003)(2906002)(122000001)(83380400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzFOUkVpaFBubVJXeWtFSlZ6c0NrMUJ3Tnh4N1h4OTJzTHRjVTdxY1dNMGxO?=
 =?utf-8?B?UWpoV2hHcXJuLzRaTnRRbW5wYkpwZWJLVFB1VysvaEVwSThqQmNucE1vczQx?=
 =?utf-8?B?cXlCZHYzTWp5S09MNWhVZkxHY1Eyemh0dUQ0ZnA2SEpES2VZRkxOS3lOMkhO?=
 =?utf-8?B?K3B0aEExMzlxUmJicm0vbE44VW5xUnFhK3ZrTXVtTS8yK1RsUGJ0eDlrSkNs?=
 =?utf-8?B?WUVtR04yTUhVRHNRUWNTU3U1YUVENjZuWk5oTTFBSFBQb2F5UTVPb1A0S0U3?=
 =?utf-8?B?YWIvdU9ZZmUyS3UwZEc4RVZxT3lHcGlHQ0d1b0d4WHZ1dW9pZHNDbzdDSUZI?=
 =?utf-8?B?V2xYbHpBcWZkc09CMUZ1K2JZTy9BK2cyWDQ2c1VTdEcwMm5jQmN5MDRwaURq?=
 =?utf-8?B?Y09DR1diVmpiaWJEL21SOUI4RE9GY3A0NS9IYWFoM2pzbUFlSkc1U3hIS2h4?=
 =?utf-8?B?ejJuOTI2c1FMYmtuUFo4TUt4UGpPVHptblF4MzRWMnl1cWp2ZURVTzRYYkxU?=
 =?utf-8?B?OTJ6RzJlNHZDbUd1SnJLeko4WjB2VkVxNUphRFlUSHF2TXp6MlJCclFDK2x4?=
 =?utf-8?B?cmQxWXpNUUwyWW5nZWp5STZqWGtBRGJFZ3YzU0tsV0ltVEtuNkdCSzJhOXNy?=
 =?utf-8?B?NnpXanRQTzltRFd1TnRlNHVZakpFY3k2M3Zvb3hoSm1HbWgvTFdyUVpHSW9h?=
 =?utf-8?B?YUJXcVEyQ204d1V0dnI4RWJ4MXYzeWV5S3ROUnRqejMwSUpMUzg4MGh6eUFO?=
 =?utf-8?B?WWVpUnY3QU5HK29iNzZkSXJRc1JndGdVVStPV05aY2JiUVJjdHNESjNURzFT?=
 =?utf-8?B?dHlXUnROazJuaU0vZDFkM2ROSmorYXFjMWpyOVFaRS80Uk5kU09mR3hnYVVO?=
 =?utf-8?B?eGRtRUptblBFZU9MK0puQytMdjRjdU9UYmtOdXBBTWFSNnlZTEJ3bUh0NVpr?=
 =?utf-8?B?SVVLYVY4czEvY1BnTzVqeGNIUGpIRVZnYWYvb0M4NVRsNTV0YmhMMEZzSzdq?=
 =?utf-8?B?eFoxWHQ1SEZiazhqek01V2hyK0VrUk9wMStmb3Rac3RjRXNNNUZDcVdua1NU?=
 =?utf-8?B?MmdyV0hUMC9zUDZxTGpYa1lmZ1hMWlJVZnpnTjl0Qll1ZHQrTWFNbEZlcFB6?=
 =?utf-8?B?dXl6TlJLVUh2ZE9XWi9oSFZ4VkFLdlNPL2FNMEgwZlRhR0dkUVlVZ2pjZmpj?=
 =?utf-8?B?aHNIbkpsaWRRc2hGK1lIcng5aTljUnF0d2o0NE9WbGtIYzhUMHo2SXVyUmph?=
 =?utf-8?B?Tzdpd2tMQjViK3VBaWlkWHNqLzBSQmtPMW03Rkx3T2hyR28zT2g2Y01KZXJ2?=
 =?utf-8?B?eG81aDNhY0MyblVQNTlRZUZGMHZPWGdXMjQvUCsvdTNWM0k2TmZhcmt0b2pJ?=
 =?utf-8?B?TkFneCs5SFZGNTlHajlaMkZrT2NIdnRROG1ibnZwUDA4RG9aVHg1OUJNcWZq?=
 =?utf-8?B?WWo0RTg1bGJESC92ZmJ1RDlnNE5yaWxkZUtuaG53YVlJK1l3QUloNkZ2Rkhp?=
 =?utf-8?B?OFZqSHhPT3RqUVUwR3NNRVNoVnJZT2tQa3FqTzFGNEMvdXNTWml3MzBYVlNl?=
 =?utf-8?B?OU5GVURCejhScCtaN0Vreng0L3BOc3hIblV0WWRpZ2Z6dGY3WnFJN2JEQng3?=
 =?utf-8?B?bm5zZTM1M043THZVemdWR0xjdFdaeTZHZHFia2VBTzhUaEIxUUZzdE5YdW9v?=
 =?utf-8?B?YWQ5ZFkyWWVFY1ZPTlNVVmdKZkwwdVJiWm9sbmhTWkt1UUwzeFVXbzQ1Qldy?=
 =?utf-8?B?VnVNRjBKUHJuUUxEK2M2QjJXbHRyb3h2Q2QxVHRzaHF3Yll2SlJaaXJtL3V5?=
 =?utf-8?B?ZjdhKzB3Mk4wUzB0cjV0MjdDL2dESkpSbitoNUxBUnl0OGw2cUhSUndwWkln?=
 =?utf-8?B?OVBLYnIzeVI3aTZ3M2cvRDI4TkcxOGhGb0FsS0pac0l5cTRjWEN6eVpaNEgr?=
 =?utf-8?B?Vy9QM1duSmlETHRVcTQ0ejNaZlowYWszKys3MHZJbmtIbUJzdTQycDZOZ1My?=
 =?utf-8?B?QjBsU09qdlExUkoveDN6NnpGVno4bEF1OW03UWM1SXpiR2dscWVaVytBL3Vw?=
 =?utf-8?B?QkJJN3VCWnl3blpXR1JHNWQvZXVZSU1pTGpOOGNoOVozNHp5MHNXa0JkVW0w?=
 =?utf-8?B?T1BLQVJ1SzYySG9seG54YTErblNFejZLZkRWb2pBc1ZJQm9LYkY2SFZPWVZx?=
 =?utf-8?B?OVEwcHMvaXVGQkZVVjNjdlFLU3JyK0dDSFF2L1dEZVJGbTZYRVNlSk5rTE5S?=
 =?utf-8?B?MHFMSCsydWxHUGszVlo2UEhFejloTVVlek5sK2JqeW5ZWWNiWE9ncHQrU2JQ?=
 =?utf-8?B?U01IZ29aeFlZdUFKcmV4TVJHeVFrTXVMVUR1bldtSUVRTVdCcmloYjJSMlEx?=
 =?utf-8?Q?7+FA7xJBeeh96wlj2rgfISaImM9PTOqoYjIyQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CB14CDF0D28A741B9AD26BC93280ABD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44905f7e-38ad-436c-2f09-08da35fe729f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2022 23:06:58.7190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yPSIIaRN4M9UwkwCXgc0vdZ6+m0q2K3s39OvnujPClrD/ZnCUktwIpWx5erHwIJ9E090oeCDzF7uzE7qQZ/ESyRjFNs+0EEhkLZctgo9Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA1LTE0IGF0IDEwOjM3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIEZyaSwgTWF5IDEzIDIwMjIgYXQgMjM6NTAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+IE9uIFNhdCwgMjAyMi0wNS0xNCBhdCAwMjowOSArMDMwMCwgS2lyaWxsIEEuIFNodXRl
bW92IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMDU6MzQ6MTJQTSArMDAw
MCwgRWRnZWNvbWJlLCBSaWNrIFANCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDIwMjIt
MDUtMTMgYXQgMTY6MDkgKzAyMDAsIEFsZXhhbmRlciBQb3RhcGVua28gd3JvdGU6DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIC8qIEhhbmRsZSBBUkNIX1RIUkVBRF9GRUFUVVJF
X0VOQUJMRSAqLw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICB0YXNrLT50aHJl
YWQuZmVhdHVyZXMgfD0gZmVhdHVyZXM7DQo+ID4gPiA+ID4gPiArb3V0Og0KPiA+ID4gPiA+ID4g
KyAgICAgICByZXR1cm4gdGFzay0+dGhyZWFkLmZlYXR1cmVzOw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IElzbid0IGFyY2hfcHJjdGwoKSBzdXBwb3NlZCB0byByZXR1cm4gMCBvbiBzdWNjZXNzPw0K
PiA+ID4gPiANCj4gPiA+ID4gSG1tLCBnb29kIHBvaW50LiBNYXliZSB3ZSdsbCBuZWVkIGEgc3Ry
dWN0IHRvIHBhc3MgaW5mbyBpbiBhbmQNCj4gPiA+ID4gb3V0Lg0KPiA+ID4gDQo+ID4gPiBCdXQg
dmFsdWVzID4wIGFyZSB1bnVzZWQuIEkgZG9uJ3Qgc2VlIHdoeSBjYW4ndCB3ZSB1c2UgdGhlbS4N
Cj4gPiANCj4gPiBIbW0sIEkgZG9uJ3Qga25vdyB3aGF0IGl0IHdvdWxkIGJyZWFrIHNpbmNlIGl0
IGlzIGEgbmV3ICJjb2RlIg0KPiA+IGFyZ3VtZW50LiBCdXQgdGhlIG1hbiBwYWdlIHNheXM6DQo+
ID4gIk9uIHN1Y2Nlc3MsIGFyY2hfcHJjdGwoKSByZXR1cm5zIDA7IG9uIGVycm9yLCAtMSBpcyBy
ZXR1cm5lZCwgYW5kDQo+ID4gZXJybm8gaXMgc2V0IHRvIGluZGljYXRlIHRoZSBlcnJvci4iDQo+
ID4gDQo+ID4gU28ganVzdCBjaGFuZ2UgdGhlIG1hbiBwYWdlcz8NCj4gPiAiT24gc3VjY2Vzcywg
YXJjaF9wcmN0bCgpIHJldHVybnMgcG9zaXRpdmUgdmFsdWVzOyBvbiBlcnJvciwgLTEgaXMNCj4g
PiByZXR1cm5lZCwgYW5kIGVycm5vIGlzIHNldCB0byBpbmRpY2F0ZSB0aGUgZXJyb3IuIg0KPiAN
Cj4gV2h5Pw0KPiANCj4gICAgICAgICBwcmN0bChHRVQsICZvdXQpDQo+IA0KPiBpcyB0aGUgcGF0
dGVybiB1c2VkIGFsbCBvdmVyIHRoZSBwbGFjZS4NCg0KSXQgc2VlbXMgYmV0dGVyIHRvIG1lLCBi
dXQgd2UgYWxzbyBuZWVkIHRvIHBhc3Mgc29tZXRoaW5nIGluLg0KDQpUaGUgaWRlYSBvZiB0aGUg
ImVuYWJsZSIgb3BlcmF0aW9uIGlzIHRoYXQgdXNlcnNwYWNlIHdvdWxkIHBhc3MgaW4gYWxsDQp0
aGUgZmVhdHVyZXMgdGhhdCBpdCB3YW50cyBpbiBvbmUgY2FsbCwgYW5kIHRoZW4gZmluZCBvdXQg
YmFjayB3aGF0IHdhcw0Kc3VjY2Vzc2Z1bGx5IGVuYWJsZWQuIFNvIHVubGlrZSB0aGUgb3RoZXIg
YXJjaF9wcmN0bCgpcywgaXQgd2FudHMgdG8NCnBhc3Mgc29tZXRoaW5nIGluIEFORCBnZXQgYSBy
ZXN1bHQgaW4gb25lIGFyY2hfcHJjdGwoKSBjYWxsLiBJdCBkb2Vzbid0DQpuZWVkIHRvIGNoZWNr
IHdoYXQgaXMgc3VwcG9ydGVkIGFoZWFkIG9mIHRpbWUuIFNpbmNlIHRoZXNlIGVuYWJsaW5nDQpv
cGVyYXRpb25zIGNhbiBmYWlsIChPT00sIGV0YyksIHVzZXJzcGFjZSBoYXMgdG8gaGFuZGxlIHVu
ZXhwZWN0ZWQgcGVyLQ0KZmVhdHVyZSBmYWlsdXJlIGFueXdheS4gU28gaXQganVzdCBibGluZGx5
IGFza3MgZm9yIHdoYXQgaXQgd2FudHMuDQoNCkFueSBvYmplY3Rpb25zIHRvIGhhdmluZyBpdCB3
cml0ZSBiYWNrIHRoZSByZXN1bHQgaW4gdGhlIHNhbWUNCnN0cnVjdHVyZT8NCg0KT3RoZXJ3aXNl
LCB0aGUgb3B0aW9uIHRoYXQgdXNlZCB0byBiZSB1c2VkIGhlcmUgd2FzIGEgInN0YXR1cyINCmFy
Y2hfcHJjdGwoKSwgd2hpY2ggd2FzIGNhbGxlZCBzZXBhcmF0ZWx5IHRvIGZpbmQgb3V0IHdoYXQg
YWN0dWFsbHkgZ290DQplbmFibGVkIGFmdGVyIGFuICJlbmFibGUiIGNhbGwuIFRoYXQgZml0IHdp
dGggdGhlIEdFVC9TRVQgc2VtYW50aWNzDQphbHJlYWR5IGluIHBsYWNlLg0KDQpJIGd1ZXNzIHdl
IGNvdWxkIGFsc28gZ2V0IHJpZCBvZiB0aGUgYmF0Y2ggZW5hYmxpbmcgaWRlYSwgYW5kIGp1c3Qg
aGF2ZQ0Kb25lICJlbmFibGUiIGNhbGwgcGVyIGZlYXR1cmUgdG9vLiBCdXQgdGhlbiBpdCBpcyBz
eXNjYWxsIGhlYXZ5Lg0KDQpBbnkgY2hhbmNlIHlvdSBjb3VsZCB3ZWlnaCBpbiBvbiB0aGlzPw0K
DQo=
