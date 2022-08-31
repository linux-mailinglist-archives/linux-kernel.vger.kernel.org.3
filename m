Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958E5A7475
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiHaD3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHaD22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:28:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D90B284A;
        Tue, 30 Aug 2022 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661916504; x=1693452504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vhMksU8SxrnZsmOoGnzqU19AwdA/ShcjWpn6TLrXUWA=;
  b=IVTXb3+Vjk8egdwY+dyCP+Rr7VZo1URtHHw3JuG8IQbtNk9+vpwMG77e
   zXhnZ4+psplLJBLHvLdXT3S1w1LdiDCjab0owshVaQeb4sY7aBOKEo7RZ
   kHETVGe3VI2YbWVcdv60gV1tMOx0YqNGx5eL0onwqEZ0gDKMPo8moez5y
   IVkxhRS51EkSIF93EkxP6bVj5apiniDjP83WPTv1UMQnx3u7JPg4U26lp
   8Rjz2gwD7FbWzKlNKiTQsAr9C+BGnrZ55EqrzrPVHZ38ExqDxDQ/Oaowu
   q4ThrPEcV2YsTS4dICxTe1A4AyaSBJuwtJxCnIilNdTFg1y60hRth1Zhg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381658807"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="381658807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 20:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701232161"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 20:28:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 20:28:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 20:28:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 20:28:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 20:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgPsrPxMePE0j4g832fdGz5mwIRgA7Iki6t1a+Yx0bhGGc19Izw9+M2BJyzWIIYxtMGtKBrYYbzkz5AVCElbpvSF3HJ83/xHAatXTSgvSyFcK5tSS2GsLNUEcKHtULCk8CeANXbh8HZEJOqjQHCdTzbUoVsNvTR+BYVScRo1eCL02Mr9O/rvNr2smaRDN7ziIDaXeQrXDHi7qqekxPxhVRqpZheATDNAEV6k+ezPm3o/TlD2cNOl9lDfVSDSYf8kbpWhqEjViMR+Qpqg2J+bq9oE4nWuuhgTLUNmnAXi3whZV1DU3mX2cwPjZdH6LYwLnE5UzduIp7GY2Z7WiTKwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhMksU8SxrnZsmOoGnzqU19AwdA/ShcjWpn6TLrXUWA=;
 b=HYr9oigvyvFE/eMDoeQU4RjbEHfcWufgk6A/Ey09s7wZ2DjM11GQ1hSMH60Sr06h0cdgQWrvHb44u4eNB4fIAogn6OBLH+MJZG/QWQ6nj/1k/giWSiIGQCDOf12f5483OEm8OjcjcxyAZlhJG6Wn931Tqde5e8ba06byABr4znZSeaHYYcRfIK8rvdlNu/eiklJQeAbYS+VyLPeWYOKu2yIwWHY75NfcrWsiG5zSacXdg6L6Lzq2JZnxzcLAb2Lx53t/uflV+pNwR4OgclTK3AB3poonWb4HkXL/6vBt6maJ7cdFDV14SxHLoPaSXOY/GUnZjSFkgCHaY9L+iqhMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4473.namprd11.prod.outlook.com (2603:10b6:5:1de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 03:28:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:28:20 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgIAAAG0AgAADjwCAAAUVAA==
Date:   Wed, 31 Aug 2022 03:28:20 +0000
Message-ID: <7d4e79a9b9751c479378dd0f21605dabc6507cc8.camel@intel.com>
References: <20220830031206.13449-1-jarkko@kernel.org>
         <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
         <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
         <Yw7EX5GCrEaLzpHV@kernel.org>
         <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
         <Yw7LJa7eRG+WZ0wv@kernel.org>
         <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
         <Yw7OEh7QP8tb7BR1@kernel.org> <Yw7RDhRrgJZ8M2EZ@kernel.org>
In-Reply-To: <Yw7RDhRrgJZ8M2EZ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d325e8ec-697b-4014-04de-08da8b00da75
x-ms-traffictypediagnostic: DM6PR11MB4473:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fp2pFkf4DnzwVnmtrlGjtWogsvYUzmOLUsJC2xt0iO2xovPTFHbXCiE/Fij1YP3sRqYRtLV+QHB7SNVQIg0DSOsopQphFyc1UVQmgxhdaKdXQa+7Xf1ebVaAT0BmD6VorjnZ5sKEZH2sP0DHey8cWfDDudBjzcGrCvbbqWFSSnWcFzGFrdgyY+5E09FhIcP8OGmdO+sMKAcseeo6WMOMxs1ChDV9qVQRd6gm3eiiv/UvUVKHtqRgGdH3YpqlNdWEvM5hFLwufifIZbyyyijgjuIsDN7A+tYdrYBLBWT8kX6TL33H80dv21E9vE8OZ2QS5zrrBosoWVOYHTcQURz5WaSUWjtyF2R4fJKX8HZUhw7OyGJF1ppSSOtatrB/ac6Hz6TnEVEhYv3BvXNqo4Q/uoedkluuD+3aBgRu9ib2up7rSCzXTXfdL3uMJPkgjSTh45sy5BlAUvHRuLTf1MbE0UsR7tUQmajhGBKb+APfdVSedjHO6NaWzD6ilJGIO2iEozeRmljQI1jGyEM/YrGfKJ37f5TJr5mayKZ26doGh8T38xdWNWEH7kPzDVZzaz4QaH+Dzb6MAgfHNi8/ffig7/AtxNOaFOYR9wAXiUYfwqlk+mB3ilcFXspRcbSalbXX5HwfeptL1YT29TRcY8B+CH4ORB2BrhZOIAIOY/w579bfh+jEojT4bMiM2yfF2dHQEq5gjBRBfXjv2rvzHbkADhcx3xWdoBKOIRnCZL1mUQUv63sXj0PSZ9gQhyY/BbScOEQU2hR3+421cuLfbGhPaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(316002)(54906003)(478600001)(6916009)(122000001)(36756003)(64756008)(71200400001)(8676002)(91956017)(66556008)(66476007)(66946007)(38100700002)(66446008)(76116006)(38070700005)(82960400001)(6486002)(4326008)(186003)(8936002)(7416002)(5660300002)(2906002)(6506007)(26005)(86362001)(6512007)(53546011)(83380400001)(2616005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlSb0FYMUdMZkN1SnpJSWIyS20vSk5hckJ4RkVjVDI0TkhLcEcxUW16QzhL?=
 =?utf-8?B?dHAva1VrYzJXY1M0WGVJK0tXbzNJZ0dwbEdWd3FUQ3ZER2ZCWHdsd1R6aE1m?=
 =?utf-8?B?V0dBMVdTZyt2SnVFV09TaUh2SFFUMEhGb0N2V2hWWnUyRjllUjlGUjNSNU4x?=
 =?utf-8?B?NzRXb0JLWmdqVVRFZkxDellhaTdVaXJ6RmR0YXczai8zUkFJVEx0anpzUEhL?=
 =?utf-8?B?WCsyaFYvbXVSY1Vrc0NkWlB0T3dBTzZNVDh2M2NTUlZCTnlQbEU2aWJPUEFn?=
 =?utf-8?B?cHVKQWQ3dGFvUXdsc21lRmdXRlVxMnRJRHFwd1pIWExvQVVRRVljTDVVM3Jq?=
 =?utf-8?B?QU9scWtKbFN5UG5TR1ZOL2pLUUZiRjNDQmhCVEZ0K1QzTWFma1pEaWNWMFBW?=
 =?utf-8?B?dnB3V1dnaHowUjc5NU4vS04xY2RYazlZODRVUHhNcE9UdlYxNzBKL2ZJTW1q?=
 =?utf-8?B?UUpRZXlEdUdBZTZ4eTBmU1Ntbi9iUlR0bDdzUXNRYmVrWVhTSWx3a092SlZh?=
 =?utf-8?B?Q0tMSDlnSFZqL3ZqWnFxc0V1eWhiTGYweUVaTThkbFlkVGR0RXFGK3lwWGpm?=
 =?utf-8?B?WjVhNDk3Y01rWjh5aHBNN0NtQjVDQXpaWlhiaVNPOExMdjBBdmpjQWg5TStG?=
 =?utf-8?B?SnpuNCtkQ3I1QklXdnU0VDMzNFdDbjY5ZE9EV2JoNEw2Uk1IbnBBd3Z1Nm1r?=
 =?utf-8?B?a1RVaC9taGlVSlhmVGovUUhPWFdPS09DSXB4UFBUY2tzaHRQOHpxUlg5TVcz?=
 =?utf-8?B?SUE1dXhhSUFDWkh3bkZyNmxLQ2VoYmpBQlVPZmlPNnBnZWFJZlpIRU4rMlBa?=
 =?utf-8?B?aFEyVmZjbFBQQnNFeWUwdWEzQ1lOemE0WnIxNlBZUml2RE9MZ3o2VVRKbWhF?=
 =?utf-8?B?a0hKTE9UWm5nQ1QrbU9MY21DM3NLM2xjNHAveHRrekZpL1RHYWI4QmxpcVJ4?=
 =?utf-8?B?WkVST2QwMW5jUG5Sa3AyUWtZcHRtV2RGb2pJTi84bHpaTXloL29ubFp2Zjl2?=
 =?utf-8?B?V1ErNG1FbVBaS0NDNWNDTTl0M1QrdytQaDZmV1B5MUJ5V3ZNdVg0dVp1dDFm?=
 =?utf-8?B?SS80L2NlZzRSMXp2emZYQ0F5QkZDTkFLTks4LzVDVHdJaEc5L2htWkdyb1Iv?=
 =?utf-8?B?a2hTYUQxWlFrR1dxYUdSbC9jZG1BWTRHbDJxUVJraEljRU1IWjBTbExVdDdH?=
 =?utf-8?B?TEVDZzU3eUlHUHliaVFvV3BweFBneHQvbGhBalp0d09laUo3Uitnb3lkUElV?=
 =?utf-8?B?Zm8zekUyeVdBOUk0QjlZQTYxMkZFaXgrUXNRQXJtb3EyT1BPbDFqMFBCa2x6?=
 =?utf-8?B?eVNyWXMxV2FNVm9haHFBWWZNdGRadDZzNlkwckRMTVBMRlVxQ3hTcDNRSm9Y?=
 =?utf-8?B?aFlCN1hpMXJ6Q1RHRlNSZ3FtUEE5WHJ3NFlucjd4M0FkQkxqdnY3Tjd3bmtW?=
 =?utf-8?B?OExRR1pWZXI4ZUhEaTZaTUkvS0YxTWFKU0ZzV1Roem1obzR6ZzMrQnRjbjNa?=
 =?utf-8?B?TXJsQXdnNW5NZU9ReTloWjRKVW11c2YyQlRETHpXNnBiakltc3hGS2JxVTk0?=
 =?utf-8?B?RmppbW1OZjkyMHEySXRCVWJYS25BQy9ROGFCT284MElzZWdIbkErcUpoRE9n?=
 =?utf-8?B?QlNDclJnM3N6ejg1dEtCZVZqS2NOaVZBdkh1bUEwV09qemE5bkF4amxVRDRw?=
 =?utf-8?B?WmtLVG5SSE9FNGRyMXcrWmlxTXNjaXV0QXlkNm5QSC9IMlJYQ1NERjgxVjh1?=
 =?utf-8?B?cmRsS1UrRWJtU3A2ekFrSE1pQkRtemVRMkwrdEhsdjlEZVFRbEIwUVlaWmda?=
 =?utf-8?B?S3FZckVmY0N1OTIrTUhIL04wcWtTL0U0a29XeVl0eU5wRVpRUk5ITUxGUUZX?=
 =?utf-8?B?aElXTG4za1ZrTEVUcmNRa1UrRXVzc1M5MWE5SjN6MXhhU1BVWm5ydFlZc2ZB?=
 =?utf-8?B?cUVFbUZlaVlRMFdjMnFuOVVZQ2VKdysvUUhYYnJJeWNub3VMVFdQcy9CMFVC?=
 =?utf-8?B?RUdQMzhjcWhBc1FhVE5BbkJwYXBybm9EV0padTRGSzc2Y0pKTnU3MVVkdGw1?=
 =?utf-8?B?UlZUbnppb1ZkTnFPT3J5UU1mcnIvOVBGenYyNFJFREhZRTVwZjczQjRSVFBw?=
 =?utf-8?B?MHNTWnA2cWJtVGQ4RlpFWmp2eGJMam9PZThOYzFHSzgweEJYQXREK0lYaUJR?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B934D2A29D47A44866CEBCDD7E19881@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d325e8ec-697b-4014-04de-08da8b00da75
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 03:28:20.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3LbYScFSwmIN5/zyUopjhqgycoWmsCSZ+I4844ND6dMfHKygZsoI34HcRfN8VGj40dixhZbAivVaPwdRgE4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDA2OjEwICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFdlZCwgQXVnIDMxLCAyMDIyIGF0IDA1OjU3OjIyQU0gKzAzMDAsIGphcmtrb0BrZXJu
ZWwub3JnIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXVnIDMxLCAyMDIyIGF0IDAyOjU1OjUyQU0gKzAw
MDAsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjItMDgtMzEgYXQgMDU6NDQg
KzAzMDAsIGphcmtrb0BrZXJuZWwub3JnIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIEF1ZyAzMSwg
MjAyMiBhdCAwMjozNTo1M0FNICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiA+IE9u
IFdlZCwgMjAyMi0wOC0zMSBhdCAwNToxNSArMDMwMCwgamFya2tvQGtlcm5lbC5vcmcgd3JvdGU6
DQo+ID4gPiA+ID4gPiBPbiBXZWQsIEF1ZyAzMSwgMjAyMiBhdCAwMToyNzo1OEFNICswMDAwLCBI
dWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBUdWUsIDIwMjItMDgtMzAgYXQgMTU6
NTQgLTA3MDAsIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBIaSBKYXJr
a28sDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gT24gOC8yOS8yMDIyIDg6MTIg
UE0sIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IEluIHNneF9pbml0
KCksIGlmIG1pc2NfcmVnaXN0ZXIoKSBmb3IgdGhlIHByb3Zpc2lvbiBkZXZpY2UgZmFpbHMsIGFu
ZA0KPiA+ID4gPiA+ID4gPiA+ID4gbmVpdGhlciBzZ3hfZHJ2X2luaXQoKSBub3Igc2d4X3ZlcGNf
aW5pdCgpIHN1Y2NlZWRzLCB0aGVuIGtzZ3hkIHdpbGwgYmUNCj4gPiA+ID4gPiA+ID4gPiA+IHBy
ZW1hdHVyZWx5IHN0b3BwZWQuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSSBk
byBub3QgdGhpbmsgbWlzY19yZWdpc3RlcigpIGlzIHJlcXVpcmVkIHRvIGZhaWwgZm9yIHRoZSBz
Y2VuYXJpbyB0bw0KPiA+ID4gPiA+ID4gPiA+IGJlIHRyaWdnZXJlZCAocmF0aGVyIHVzZSAib3Ii
IHRoYW4gImFuZCI/KS4gUGVyaGFwcyBqdXN0DQo+ID4gPiA+ID4gPiA+ID4gIkluIHNneF9pbml0
KCksIGlmIGEgZmFpbHVyZSBpcyBlbmNvdW50ZXJlZCBhZnRlciBrc2d4ZCBpcyBzdGFydGVkDQo+
ID4gPiA+ID4gPiA+ID4gKHZpYSBzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgpKSAuLi4iLg0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSU1ITyAiYSBmYWlsdXJlIiBtaWdodCBiZSB0b28g
dmFndWUuICBGb3IgaW5zdGFuY2UsIGZhaWx1cmUgdG8gc2d4X2Rydl9pbml0KCkNCj4gPiA+ID4g
PiA+ID4gd29uJ3QgaW1tZWRpYXRlbHkgcmVzdWx0IGluIGtzZ3hkIHRvIHN0b3AgcHJlbWF0dXJh
bGx5LiAgQXMgbG9uZyBhcyBLVk0gU0dYIGNhbg0KPiA+ID4gPiA+ID4gPiBiZSBpbml0aWFsaXpl
ZCBzdWNjZXNzZnVsbHksIHNneF9pbml0KCkgc3RpbGwgcmV0dXJucyAwLg0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gQnR3IEkgd2FzIHRoaW5raW5nIHdoZXRoZXIgd2Ugc2hvdWxkIG1v
dmUgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSB0byB0aGUgZW5kDQo+ID4gPiA+ID4gPiA+IG9m
IHNneF9pbml0KCksIGFmdGVyIHdlIG1ha2Ugc3VyZSBhdCBsZWFzdCBvbmUgb2YgdGhlIGRyaXZl
ciBhbmQgdGhlIEtWTSBTR1ggaXMNCj4gPiA+ID4gPiA+ID4gaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1
bGx5LiAgVGhlbiB0aGUgY29kZSBjaGFuZ2UgaW4gdGhpcyBwYXRjaCB3b24ndCBiZSBuZWNlc3Nh
cnkNCj4gPiA+ID4gPiA+ID4gaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseS4gIEFGQUlDVCB0aGVy
ZSdzIG5vIGdvb2QgcmVhc29uIHRvIHN0YXJ0IHRoZSBrc2d4ZCBhdA0KPiA+ID4gPiA+ID4gPiBl
YXJseSBzdGFnZSBiZWZvcmUgd2UgYXJlIHN1cmUgZWl0aGVyIHRoZSBkcml2ZXIgb3IgS1ZNIFNH
WCB3aWxsIHdvcmsuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgd291bGQgZm9jdXMgZml4
aW5nIHRoZSBleGlzdGluZyBmbG93IHJhdGhlciB0aGFuIHJlaW52ZW50aW5nIHRoZSBmbG93Lg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJdCBjYW4gYmUgbWFkZSB0byB3b3JrLCBhbmQgdGhl
cmVmb3JlIGl0IGlzIElNSE8gY29ycmVjdCBhY3Rpb24gdG8gdGFrZS4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBGcm9tIGFub3RoZXIgcGVyc3BlY3RpdmUsIHRoZSAqZXhpc3RpbmcgZmxvdyogaXMg
dGhlIHJlYXNvbiB3aGljaCBjYXVzZXMgdGhpcw0KPiA+ID4gPiA+IGJ1Zy4gIEEgcmVhbCBmaXgg
aXMgdG8gZml4IHRoZSBmbG93IGl0c2VsZi4NCj4gPiA+ID4gDQo+ID4gPiA+IEFueSBleGlzdGlu
ZyBmbG93IGluIHBhcnQgb2YgdGhlIGtlcm5lbCBjYW4gaGF2ZSBhIGJ1Zy4gVGhhdA0KPiA+ID4g
PiBkb2VzIG5vdCBtZWFuIHRoYXQgc3dpdGNoaW5nIGZsb3cgd291bGQgYmUgcHJvcGVyIHdheSB0
byBmaXgNCj4gPiA+ID4gYSBidWcuDQo+ID4gPiA+IA0KPiA+ID4gPiBCUiwgSmFya2tvDQo+ID4g
PiANCj4gPiA+IFllcyBidXQgSSB0aGluayB0aGlzIGlzIG9ubHkgdHJ1ZSB3aGVuIHRoZSBmbG93
IGlzIHJlYXNvbmFibGUuICBJZiB0aGUgZmxvdw0KPiA+ID4gaXRzZWxmIGlzbid0IHJlYXNvbmFi
bGUsIHdlIHNob3VsZCBmaXggdGhlIGZsb3cgKGdpdmVuIGl0J3MgZWFzeSB0byBmaXggQUZBSUNU
KS4NCj4gPiA+IA0KPiA+ID4gQW55d2F5LCBsZXQgdXMgYWxzbyBoZWFyIGZyb20gb3RoZXJzLg0K
PiA+IA0KPiA+IFRoZSBmbG93IGNhbiBiZSBtYWRlIHRvIHdvcmsgd2l0aG91dCBpc3N1ZXMsIHdo
aWNoIGluIHRoZQ0KPiA+IGNvbnRleHQgb2YgYSBidWcgZml4IGlzIGV4YWN0bHkgd2hhdCBhIGJ1
ZyBmaXggc2hvdWxkIGRvLg0KPiA+IE5vdCBtb3JlIG9yIGxlc3MuDQo+ID4gDQo+ID4gWW91IGRv
bid0IGdhaW4gYW55IG1lYXN1cmFibGUgdmFsdWUgZm9yIHRoZSB1c2VyIHdpdGggdGhpcw0KPiA+
IHN3aXRjaCBpZGVhLg0KPiANCj4gQW5kIGJlc2lkZXMgdGhpcyBub3QgcHJvcGVyIHdheSB0byBy
ZXZpZXcgcGF0Y2ggYW55d2F5IGJlY2F1c2UgeW91IGRpZA0KPiBub3QgcmV2aWV3IHRoZSBjb2Rl
LsKgDQo+IA0KDQpJIGRpZCByZXZpZXcgdGhlIGNvZGUsIGJ1dCBJIGNvdWxkbid0IGFncmVlIG9u
IHRoZSBmaXguICBUaGF0J3Mgd2h5IEkgZXhwcmVzc2VkDQpteSB2aWV3IGhlcmUuDQoNCg0KPiBJ
J2xsIGZvY3VzIG9uIGZpeCB3aGF0IGlzIGJyb2tlbiBlLmcuIHNvIHRoYXQgaXQNCj4gaXMgZWFz
eSB0byBiYWNrcG9ydCB0byBzdGFibGUgYW5kIGRpc3RybyBrZXJuZWxzLCBhbmQgY2FsbCBpdCBh
IGRheS4NCj4gSXQgY2VydGFpbmx5IGRvZXMgbm90IGhhdmUgdG8gbWFrZSBjb2RlICJwZXJmZWN0
IiwgYXMgbG9uZyBhcyBrbm93bg0KPiBidWdzIGFyZSBzb3J0ZWQgb3V0Lg0KDQpXaHkgY2Fubm90
IHRoZSBmaXggd2hpY2ggZml4ZXMgdGhlIGZsb3cgZ28gdG8gc3RhYmxlPw0KDQo+IA0KPiBZb3Ug
YXJlIHdlbGNvbWUgdG8gcmV2aWV3IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoLCBvbmNl
IEkndmUNCj4gcmVzb2x2ZWQgdGhlIGlzc3VlcyB0aGF0IHdlcmUgcG9pbnRlZCBvdXQgYnkgUmVp
bmV0dGUsIGlmIHlvdSBzdGlsbA0KPiBzZWUgc29tZSBpc3N1ZSBidXQgdGhpcyB0eXBlIG9mIHNw
ZWN1bGF0aXZlIGRpc2N1c3Npb24gaXMgZnJhbmtseSBqdXN0DQo+IHdhc3RpbmcgZXZlcnlvbmVz
IHRpbWUuDQoNCkhtbS4uIFdoeSBwb2ludGluZyBvdXQgYSBiZXR0ZXIgZml4IChteSBwZXJzcGVj
dGl2ZSBvZiBjb3Vyc2UpIGlzIHdhc3RpbmcNCmV2ZXJ5b25lJ3MgdGltZT8NCg0KDQotLSANClRo
YW5rcywNCi1LYWkNCg0KDQo=
