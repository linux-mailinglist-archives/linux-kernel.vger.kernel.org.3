Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DEC5A87A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiHaUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHaUnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:43:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51104E9900;
        Wed, 31 Aug 2022 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661978585; x=1693514585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cxngdn/OsXRlFB+jazyMDOD21oYqr9ztVFC/pY8zZ84=;
  b=NM0YWDNivNtuP7C3Fnqw2O0BR38jCr74lRo433ofreq/JqUJiNhRe5MQ
   PuYnlVIlrA4xtDGkSc1kgt2FaFHgRMapJQwMq52rufQy7XPL+wvVruYII
   dE/AqIfpblwcmHb2vgfqyyBn3+k0zc1gRMSbNfmUhKPZkAUuti/NlaXTf
   KiCTqPpnBQ/NIxDfKyteyNIemW2CGXfQj9p3ti0i7m8DKBmTNfmmGwVug
   EqkVxdqF7INvywwCFMPrJF+6HpXtNlx+lNve/vV1kexBa8dukN/b8xdhi
   huDTm4tgsLcT7rp1aRaJlKl/6aQgfkf+88IkhJ8SMxeIUc3jyReqhJD2G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294279963"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="294279963"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612223604"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2022 13:43:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:43:03 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:43:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 13:43:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 13:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKoe3hLBTtGPouA7SeDGa3diIxvtG3Q+L5dN+nifsZEkJheC1k1DjGLMhH6GqnLF3GlsXt2/hwbxicYYkI8YboYeU8PVdUhqP8a8MnBSKl84oO+FFUDURSbx1mOV7fVSwSaB4ev4VDzq5SuOwltopctyrI9uShhJzA727vqDxyOKqYjbe1sTMHPyFPHyvHbyV4S3jWY/oE5jhNfhwFj4deCqGhFpbuQsKMQQPIPKbyJyk4ZyeA2cdBeuWcp9BtSmI9gG3/8R6reMkZ36vKt1DL3kjrqvB/FdsiQqcoCtnVeF4ztgI9alJLBpzdcc9laFiqsbUJEqjQKyNi82Nfn3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxngdn/OsXRlFB+jazyMDOD21oYqr9ztVFC/pY8zZ84=;
 b=AxM8kOzDg04dIcKUNXHNJaj+7kTDH2ryDZ7IDDJoZkh6PFx7AjcdDFE3r5RptnWfXzpAZ84550vC9uZH3Wr8dTz6CQn/taED5tQnPNkYV4l6Mftq6sxOCuj0uxKgGEB2HsGvuZgHpFImRRhcIva+FwX2YRRIcl6wGtbGrnjItq62VGRH6pRGsGnfNj4OKnBFcujLGcxJ7Cl8Iy1sVKrSyszfybjiVsv7RtyqLcCQB1P7sT1nCV1RBCNuhICh8zSriPz1nIwbmQPeJ8/J7LQArnlxgjh0NCnGatuCCOFJhOiplHkrtR8CGUtvB3oQtj7lKK8lGjun1DhP+pD0ppy/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BYAPR11MB3815.namprd11.prod.outlook.com (2603:10b6:a03:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 20:43:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 20:43:00 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgIAAAG0AgAAFhYCAAMlpAIAANTGAgAAB5gCAACO1AA==
Date:   Wed, 31 Aug 2022 20:42:59 +0000
Message-ID: <94993d90b0b3c59fae61427cf0cc78dd10c381bb.camel@intel.com>
References: <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
         <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
         <Yw7EX5GCrEaLzpHV@kernel.org>
         <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
         <Yw7LJa7eRG+WZ0wv@kernel.org>
         <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
         <Yw7OEh7QP8tb7BR1@kernel.org>
         <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
         <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net> <Yw+oR3FKlwbeOl6I@kernel.org>
         <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
In-Reply-To: <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 236e66ae-e53d-484b-4378-08da8b916493
x-ms-traffictypediagnostic: BYAPR11MB3815:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBREnH1LveJXtw6xQ8ko605jJgW3qs25UkVzxxqVSmNhLG6vBzEaYzok8fCObVz9mt8a7V1y9cLQnHbuz1b5Ry4D4GjeyN28iJ3GQGjApxdE0iDVMNoPkF96V0ipN7ibiIh6zVgqNiG1m49dAULPC1elLI0vl0D99hcX+OvINNUIXam3lBRbvePpmXP4oSpc4H1sMFbGWu6NNaC/DOkiIPJxHqoXWDMNZ3+FZzJyXAuSApB3WWIgCVD1YXI6jk7Ay+eRKy0GnyR2b4XrmUaGQHyA91DMXalljhO0u+uG04zVY4Xwbuge5aJwV0bdVaR+0mPRg3xdHRDHOv9wEimJnSESawsNsRZez2e6AvLeo7EW0QuMgG7k57ryfm0hpcR4CmVE2PXvpFdS5URSyYHPznMLrqj9028WCo7FxfHpvF+zzT3EPAgX7iBVhf3YbBL7RwS0qSmPBW9ShloDHlcZLnEbRjfYc7RokNlGKWDNhYYwqul48NQxl3a4FLwl8lvZBINM7aQ0WZI7Kv+us8DGI5LDycmbh+WCvyWE12xLKWj4orNg9kqK5yWsB24VwomWhb1j1hgK/WQyRz9CHm6tS24RJBNWpLXn3nplbnvTYSJeM+PjOFv+tmxNq1VaYi0e4jxBruP2jAFeuI6PrfQi/JAs8n0DOPaNHfCaP045kKt27RVcgvqy3GWHFriAdxNJ6TiM2negMJKEDWbsBIqMPWOhrzapp0pDjV1g7e0kgaAHdPWENtUMP+EKwRzZmIlklx8Awv61ntESB4dYc+Lzng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(39860400002)(136003)(478600001)(53546011)(41300700001)(2616005)(26005)(6512007)(6506007)(71200400001)(83380400001)(6486002)(186003)(2906002)(8936002)(7416002)(110136005)(54906003)(316002)(76116006)(66946007)(4326008)(66476007)(64756008)(91956017)(66556008)(38070700005)(5660300002)(8676002)(36756003)(122000001)(82960400001)(66446008)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNqSkVYc1lSRDAzc2ltcE5kdy9ocE9DbFBQVmZqbXgvL3RobG5wUllma3Qr?=
 =?utf-8?B?a1N1S0xCd2lMWFQvajkraWpsVUxFTnB0cnpxSmcwUjh3UEpibVByUFJCSUE3?=
 =?utf-8?B?cnUwMHcxQTlCU0xBNGY2S2lLS3RteFNpdlYxUUJrY2w2QmQwbStyVmNPcWxS?=
 =?utf-8?B?TmVxQzIzSDVnaUYwSk01WVFiZndiRWgzMEpsUUUwMjJrNXdwYW9NQlhVNWw2?=
 =?utf-8?B?WjZ3Z1hzcGpGZmVUV1VTeFRlZWJOdFZDZU5oSytpcmZKTVhtTS85MXlKemF5?=
 =?utf-8?B?SU9rOHg3dUswS0kraWlQMFBIdWNKcWQ3YXFVaGpsV3BneDhkNzVGNUVQTnJH?=
 =?utf-8?B?KzVFV09XVExPWnZjUVJUOXdsTEdyclFHTzcxYm42aW9WOEVUZThsdW1SdTJj?=
 =?utf-8?B?anZUY0YwamNlYWpVUDhiZUZ2TkpIWFJ0bjRmVDhCOFdoVlBTaFZ2OW00OUk2?=
 =?utf-8?B?YkFhUzFWNlJRdXhrMENkUjlhOHhuVmU0TklDUXBTcURJd3oxK0hnYnJYMkxC?=
 =?utf-8?B?ODRBNEpuZDl6MVU4ektsN2p1MWZ1cWw0K3dia2JoZ2U5dVAvRXhiTnJ6NXY3?=
 =?utf-8?B?QjBqSWwxVXJoSWZuell2cEROTHBiVy9WaUl3OC85aVdKRUpMRVhWQXZiRlpV?=
 =?utf-8?B?QmR3ckJjWEllOXhydEF5bGNJaXVYYWdlOU9oNnRkam9ibDR0YkQ3dzRIL3ph?=
 =?utf-8?B?cmszY1A1Q3lOdXQ3Ynh3RkxtbmEvYXJvR2NDVDBuRml1S2dqRU5sWFdBQ09q?=
 =?utf-8?B?SHJQemZOc1dJRW9GTWZpdzkvTGJXVnZZQlgxalpBMEtMazk5RlpYUVM0ZnRQ?=
 =?utf-8?B?N3V1MUd5ck9xYzJpMUVRcTVhNFY4V05ocWNBUFVuNk10cVhYTEkvN0MreDd0?=
 =?utf-8?B?cFoyZFBIbzl2ZDZzSWFjNnlBVHUvNkJHUWlRcnVSQmMvUnF5eVc1djB1SUdO?=
 =?utf-8?B?Z20wS292ellmUFlmOWNXcEN4SFNocTM3REVFUXM4SmJia0VmU2J1N0RCc2NP?=
 =?utf-8?B?YzhiZFcwOGdPUXYyMGxia2t2aVh3OWdRSitlMCs3MFRVSGhybzNrSm9VbEgw?=
 =?utf-8?B?anU5WVlxQTVLeEhwSGNPTmZrYmVoaHJKTWdpVlZ4dS9vT0pXVVEwdWNxSzFu?=
 =?utf-8?B?VkdlTjJHSDJ3K1VraDFwT2tVdWUrZktrZzZidzZDUk41Y2pwS1NZZVZ6T2ZC?=
 =?utf-8?B?QUJ4Y0s5dnFEeWN0dGxNemhnMVBoOFZlMGFGRmY2U051R0pJUFRodXpJVzVD?=
 =?utf-8?B?a1pjWjB1amMvcTArNDlwcXl6L2kwVGZ2WC9lVmFBYUlxd0VaMWEvYk1LOXJZ?=
 =?utf-8?B?S2lCL05vZHNSZGd1VDlaOGVvM3Y3ekZ4bDY1QXZJdHRINE85dzlxYUlicHNx?=
 =?utf-8?B?ajA0cEZRNjh3cHV4WVRMK2k3dWVGV3dXa3BuSGUrNFJOdkxKY0hEVkhWNkdo?=
 =?utf-8?B?cHl3RUNQNmZZUk43MHkvMWNGcVh2RldJMmtac0t6dDFtSmhaNERXcGlCY0F6?=
 =?utf-8?B?ZVVVRTdIcUlYRnh2YWJxazZwSmxNZDdUWHRmV3NBMWtYTkpKQkZyTGxoWXNW?=
 =?utf-8?B?QzVRU3dMVEdhcHhNait5cjF6NWJTbU9OeXErZ0lNVHhTWGRHV21yMzhkUkdK?=
 =?utf-8?B?aUI2akRmTEhHMFBQMGZXV3Y1cW0vTlZVdlR1KzQya1VBczhDNm9pTXZrdDNP?=
 =?utf-8?B?ejBja3JUS2htS3JMaVBYc1Q3MmtOZVJBOVdDQzRhNmdTZkxqWjQ4UE4wSDhC?=
 =?utf-8?B?Si9sbTFwcjJERW5tSlBFZU91QTJGcnBEY0pua09xcWthd2pjYi9TcFB4UUpI?=
 =?utf-8?B?WjdkMVdxZWVVV0Q0YmJGcWhtYVAzT3dVZU16d3dWZnpsN3hOa2dqYkJJbG9L?=
 =?utf-8?B?Nk9QcCt0MGZldEowbGQzT3pTK1FqdHR2aDYxL3lWOTFsT3RHV3ptOGg0d0Vy?=
 =?utf-8?B?cjFMN3luc2dnYkpNMHdSbmJZMDZ6N204Zk9Ld1NHV0RmTExiM3NxaENybmRp?=
 =?utf-8?B?MDdJS3F3SjJLWXlxSnFpOWpabUhubXNLMDNyODhzNlNyT1d4cUtzTTNPOFJL?=
 =?utf-8?B?YTBGL1RMVHRzWGlIQmI2N0ZyWTFIcG9XWHhnT2V0WHdHM2hrR1dXVmhzSGdy?=
 =?utf-8?B?MDFjcDVWV0IvaUJrRi9qeUY0UnU4c2pnK1doRVYzenFMVHluOWU5U1VPbDhT?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5370B5BD23094CB978CC9D31D462D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236e66ae-e53d-484b-4378-08da8b916493
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 20:42:59.9769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9po/qEpeaMi2oJ1fRijOXH7+TYa8MN6BLKYlztA6r3nYzhe4uUx2cvS83yjb0lqc9asmPKLncKG6GInMjC7Dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3815
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

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDExOjM1IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
SmFya2tvLCBLYWkgYW5kIEhhaXRhbywNCj4gDQo+IENhbiB5b3UgdGhyZWUgcGxlYXNlIHN0YXJ0
IHRyaW1taW5nIHlvdXIgcmVwbGllcz8gIFlvdSBkb24ndCBuZWVkIHRvIGFuZA0KPiBzaG91bGQg
bm90IHF1b3RlIHRoZSBlbnRpcmV0eSBvZiB5b3VyIG1lc3NhZ2VzIGV2ZXJ5IHRpbWUgeW91IHJl
cGx5Lg0KPiANCj4gT24gOC8zMS8yMiAxMToyOCwgamFya2tvQGtlcm5lbC5vcmcgd3JvdGU6DQo+
ID4gPiBXaWxsIGl0IGNhdXNlIHJhY2luZyBpZiB3ZSBleHBvc2UgZGV2IG5vZGVzIHRvIHVzZXIg
c3BhY2UgYmVmb3JlDQo+ID4gPiBrc2d4ZCBpcyBzdGFydGVkIGFuZCBzZW5zaXRpemF0aW9uIGRv
bmU/DQo+ID4gSSdsbCB0byBleHBsYWluIHRoaXMuDQo+ID4gDQo+ID4gU28gdGhlIHBvaW50IGlz
IHRvIGZpeCB0aGUgaXNzdWUgYXQgaGFuZCwgYW5kIGZpeCBpdCBsb2NhbGx5Lg0KPiA+IA0KPiA+
IENoYW5naW5nIGluaXRpYWxpemF0aW9uIG9yZGVyIGlzIHNpbXBseSBvdXQgb2YgY29udGV4dC4g
SXQncw0KPiA+IG5vdCByZWFsbHkgYW4gYXJndW1lbnQgZm9yIG9yIGFnYWluc3QgY2hhbmdpbmcg
aXQNCj4gPiANCj4gPiBXZSBhcmUgZml4aW5nIHNhbml0aXphdGlvbiBoZXJlLCBhbmQgb25seSB0
aGF0IHdpdGggemVybw0KPiA+IHNpZGUtZWZmZWN0cyB0byBhbnkgb3RoZXIgc2VtYW50aWNzLg0K
PiA+IA0KPiA+IEl0J3MgZGljdGF0ZWQgYnkgdGhlIGRldmVsb3BtZW50IHByb2Nlc3MgWypdIGJ1
dCBtb3JlDQo+ID4gaW1wb3J0YW50bHkgaXQncyBhbHNvIGp1c3QgcGxhaW4gY29tbW9uIHNlbnNl
Lg0KPiANCj4gS2FpLCBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbiBpcyByZWFzb25hYmxlLiAgWW91
IG1ha2UgYSBnb29kIHBvaW50IGFib3V0DQo+IG5vdCBuZWVkaW5nIGtzZ3hkIGZvciB2ZXBjLg0K
PiANCj4gKkJ1dCosIEkgdGhpbmsgaXQncyBhIGJpdCB0b28gbXVjaCBmb3IgYSBidWdmaXggdGhh
dCdzIGhlYWRlZCB0bw0KPiAtc3RhYmxlLiAgSSdtIGNvbmNlcm5lZCB0aGF0IGl0IHdpbGwgaGF2
ZSB1bmludGVuZGVkIHNpZGUgZWZmZWN0cywNCj4gKmVzcGVjaWFsbHkqIHdoZW4gdGhlcmUncyBh
IHdvcmtpbmcsIHRlc3RlZCBhbHRlcm5hdGl2ZS4NCg0KQWdyZWVkLiBUaGFua3MgRGF2ZS9KYXJr
a28uDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
