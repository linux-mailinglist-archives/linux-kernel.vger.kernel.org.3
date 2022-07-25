Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87CF580701
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiGYV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:56:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80861759E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658786215; x=1690322215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F02CvhHIsjOl5BFdU50BBsY3xKrbyDyBVQ+loVaL3/8=;
  b=M1DnLoU6qWJ3UIPYHPs7F0AzweYoqBUB8lQReDzrvO+ZvRU4feSR3kTk
   MVFOpV+dCmaVUWmo6nAdDS6hPAB+iSyJX2UEyEkIhWr8javlDp1YCwCXu
   oSaLONwJR7ZYH12l+pNMznySVH7HiXjrvkydfwvFreNybczy6tXJrqLiF
   QcqGC/biwNGEuZlTnk3w4i7ipbBIqVIXizS1FzewdMdXvi26QxoSHVOtK
   i360BzFmNGx4alV869KEaOGVP2nRd2EPyu0wZG60LeiFX2SQhQaLv89KZ
   gSfm3wvM82ddlc3CP2B65/PmJpUDUPpJz58qeGkLySFc/m2ynVO3ub1S5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="287815772"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="287815772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 14:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="632513717"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2022 14:56:55 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 14:56:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 14:56:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 14:56:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Jul 2022 14:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew3xlRXOIbzDHpnGYdhQlAmhf1rs4bS1Y8RPwGv5PDUaHNarm9KOSsVmlPMXr+mV7W2xYmh57kK+qlepvRkNbfLyQYtkWipIYATNgvP6Di9GfPvAJVyCP1TxHDl10B6LSLyt+flI/o7vLL+8X7EYicWMdX23EcDhjOHBFjTeY/6b1VK1Poy0KoqV1r/wacUkaX4OTAFjvNy+rOIGsgAMr9ePzl0wgKUktp1jQTThmy9sd/8ebYJdOZ7KJhirO9u+bdQF994U+cxfkEdEjx4D6m1x1ehaRASVOmunGQi2SWvvlablHC0XXLkbzHkqUmCp0eHlhX0seSu6BoEr7mS4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F02CvhHIsjOl5BFdU50BBsY3xKrbyDyBVQ+loVaL3/8=;
 b=JKDhL4Kzuv0JtHUA1xMpxnAs1grxDuSoZt9IczrO4stdOk6HH+42UgIoocHQ4i5AKMlSFV+M2HWyTSfPoXTk/mt4hsv0NJHWTXCp4cFqSWVzpaEIx803ad2Rba8NMuUWB1YMOybQbTqzjZKGIMAA8gYOj/Oim4AfeVc2NFUFk0g9wMs5qqF+8CzvbNPrUFG0cnAQ1Uo0xssIwxzFbc1ed3GJzGcaueMYJF7HOkfgSbDGXnw55f9qcLotfWJP2tABlESzFCveUTNpFwXq/nx2ax1SV0f/ccj411q2KN9JU70AomU2G/7hFBYP9eDgan0RRl0kqYQtCJVfRwqTt9nYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by SN6PR11MB2959.namprd11.prod.outlook.com (2603:10b6:805:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:56:52 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::9817:ec25:4cf9:c4a1]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::9817:ec25:4cf9:c4a1%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:56:51 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Thread-Topic: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Thread-Index: AQHYnhCuYSj3l4I2uku/oc/5LfogPa2Pi4oAgAABEYCAABomAA==
Date:   Mon, 25 Jul 2022 21:56:51 +0000
Message-ID: <1A54F61B-DAD8-45E1-BBB4-42338D9B0917@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
 <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
 <4B48A192-8305-4E94-AA0C-10FCE23F424D@intel.com>
 <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
In-Reply-To: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be6b1ea2-fe21-49d1-b746-08da6e8894dd
x-ms-traffictypediagnostic: SN6PR11MB2959:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhhpgccJpDxqH7NvJzvfvXH5d6PZZMy9gl0zCHxyzf6QznkqFUOUeIaIrNTVoJxOjJNfmO0R4ROeNxAq2OMQfZSpYfDL3eRNY4APCEDIfE0eRjRk2UrqMBYjfNjy2UQRqGEzIbB9V78CmCx5kdViUxn4rOa2PgTx3/82hDq+iHW5OBVBZLoP91nZ5AkcRFM5PCY52yCUaia5uSPOXelhO00cvkNXbDnzKfndFbwrjm8cZpsSa7HjW/fClMTJOagtgWFXVMKP2I+43iElqEW7bRn4zCx5mfHz3Fc01LMU0yGt5Idvz9dZ0w4WjH3uWG/QoK5kGLb0XhuRgP2My//4sUCo9YFk80i/2rcYyqMhQeZ8tqRgtMSO31l0xrtMVm4dBf/z3iGHRJruR9EadIib4AttuqV5I2y7g0ToGRUXPZO9laI28V9L9dAOna03x0eepp/x+zZ6UouyFW8Dii9RQLAukLG7JjxUW/x5+S7AZ7asgBF17f/KK7JBMFHM0cLj7XZsZZeWVdBMsfy4aqp5rRKacF78k3TX6oOzuZDTIbOLm0KDfFUf0iCpuyP9yg1gFyEYyRtpOv6FZpeVCw9aP3CN4pNGsb7DeHN/Hh5U8ypWqTWNYoUbs9pMtq6nXMFRaFbjVeeHTN/g5OLLLkcnJh506zqkB5rz/JkTEQajyBaC8/4HhbQ5AVD2XRfer4HQWyEvHXNkpkZGWeMhPHaiKg9Rec1sUIHMBliHtDqg89Jg0Mqf5Ivv0RJD/fQbvqbeqayBcGQZAtsJIqSE8+0X9MFmMa8ReBC27XHOWw2zlWUf7AV6pX6s2qMkGk9Z0IztK+UjuDpZVejdUg9ehk1r0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(376002)(366004)(396003)(53546011)(6486002)(6512007)(71200400001)(41300700001)(6506007)(478600001)(5660300002)(2616005)(186003)(7416002)(4744005)(38070700005)(8676002)(6862004)(66476007)(66556008)(37006003)(33656002)(66946007)(8936002)(64756008)(66446008)(76116006)(54906003)(316002)(36756003)(4326008)(122000001)(38100700002)(2906002)(86362001)(82960400001)(6636002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhVRkQrSjV1TURmaWRKVnBHL3NxZXdVS0pXUVpFQUdoUWUvblI3YkNNZ2Ur?=
 =?utf-8?B?MVVIMERKM0tzaGtNdklrNWZmSEEzZEl5WXR6U3B3UmVMSGJ5MVE3U1I4N0E1?=
 =?utf-8?B?Q3I0WnVmKzNLd2tFUEUzVnJ2MHk4Yk5vNyt5QjVRZFg3U1N1R1dRN2VXRlRn?=
 =?utf-8?B?QURjQm5pb2VXWFZvTWxiMUJWeVoxM1dhU09DYU5DRVlBYk8wakpuZ29KV1Ur?=
 =?utf-8?B?NXZSc0ZFV2hSd0JGV0wwSE1CUUp0d2tiaHRFT2ROWjQ0SG1yczBZd3F6Uk40?=
 =?utf-8?B?cnE3T05pRCs2UDBNYUR5a3BwcVdISSt2VXcxVXFvUFZIdDhlY1hWeTB6Rmk2?=
 =?utf-8?B?b3MwOFFKcmFtRWNxYkFzWmN1WnlKQTNtQldKMFdpcEpCUVM4WUJUQmllTlZy?=
 =?utf-8?B?cmNJTllxcFQ1ZXBpb1R0Z3ZwQnc4cm5zVGUzNko0aXFRT01BVDFLd1doS2xp?=
 =?utf-8?B?RzBzbHZqNGlIRzdmSE8wYXdjeWI2cG93SXNOSlRTTjVZL3BrMnNHczRCeUFT?=
 =?utf-8?B?NkxoRWNkNE5SUzlFRXg1bTF4UGZ5V2t4aDFuMGJBYmxEdHY2ZXNzZmczRG8y?=
 =?utf-8?B?Ny9zRURNODl5enNoaGxtMXFaVEtTV2dxOW9CeW1BckZYUUkrMk01UUNkY21h?=
 =?utf-8?B?SDVLdzJ1OEtvWGxhMDZuRDl2NWlYbHNBTkp5bGtpeTErcTZYMXdtRzMrYU1p?=
 =?utf-8?B?aGQ3eXFBRnBzeHo5Ym04T0V5bmJDQU1BWkRHYmtEdDJBMWNlUGFkYVY5U3RB?=
 =?utf-8?B?NGpIbjVXWUh1SzlEUENuMThSanNOY3dWK2hVZG1yUmZSVmpsMEFFcTh4cFFh?=
 =?utf-8?B?MHBsR0hyL0FaQXRvUytTQlQrTGdVdFpGMHFDRkZHbUNUSW94N1NhWkpZOCs1?=
 =?utf-8?B?Y1dxNnYwMXZ3MU9LNHlFRWM1NUtVZk83QnVwelp6ZkJ5cm9Pejd3MHk2YjVI?=
 =?utf-8?B?YTI4aGpwQmcyVUd4WVBvK29CTEQvWEI4dGp4OVZXdmdSWHZ0bU50YTFLZEtZ?=
 =?utf-8?B?M2VBMVFxaXdONTRZNEMvSVVUbmRCZnBlTnYyK3JlUnF0aE1RNjl6QnVhQXlJ?=
 =?utf-8?B?MG4zYUhqVzhzNkRVZnB0eEFGQTdkNjgrNVg3bEIrd05jei9xdVdsdytKRi9r?=
 =?utf-8?B?MUs4bVJQOWdQM29EVkxvaXllRUNadURPMFp6b2F5Wmpxc0xmWEk2V1ZzUkdJ?=
 =?utf-8?B?N2JrZjcydnVQTVNIWTFCc0RVTnpDbXNNUC9yN3hxL2xNUXl6cENTd1ZqR2th?=
 =?utf-8?B?RWxqMFhBZHFnV0JFa1ozdGtYaUk2TVlYRTEwZlBVNFIrcXRRQ3pobnlSR29u?=
 =?utf-8?B?dnpWMnBPS1h0OFVNS0lKc2xtZW8xMGpNc3RSQm5NU1Y0OHdZWW9iU3NaTGx6?=
 =?utf-8?B?aXhndE5pNWhzS3JIcENCUVBCVFNjcEpoWE5TR1BPbGJwMkRkNjBTMWtQdG1N?=
 =?utf-8?B?aWZPZmlTTkdUUGxnNGJGc2prTG9kczVEMUxRTm1hWDlhdnhKUmhzZEp0NWJz?=
 =?utf-8?B?c1hicDBQSVNiUHJwWWZzb2tEZ2NGMUEvT1NUWStCWmI2THhlZVp5VFZxdm9i?=
 =?utf-8?B?N3psN3R3UE9mbjcweWlFajdvWEsrUkpWcjhPMll2R1JOdmlPN1ptcHZFN3pU?=
 =?utf-8?B?ZjAvWUJPYkZpTVNnbkpUL2pwZ01SQ0RDc0RJRXAxbzZNa200aUh3VGV5VTRP?=
 =?utf-8?B?OXFuaW1tMkNKNzdsTERlNjloVExzaG9iTUdIVVFlbm1wcGUzVHNRcXdmTjg0?=
 =?utf-8?B?SjRwN3oxTXpVUU1rYkFhdUNRK2YrVjdLRnpJQ3FKRGJSNWJLZUVZZFJZNWds?=
 =?utf-8?B?QXVsTDV3VUkwVGdUb3phKzVHSmMrNXlwclJnTTNzSFcvWXRHajhuR1ZzNmI3?=
 =?utf-8?B?WVA4dmhPUU1STHM3eFdBQ3dSM1NuNkFPK1FnWGpzdldyT3ozdWZKMVpGbFI5?=
 =?utf-8?B?WUw5YTh5OWVOZTYwVnZIYnhvT2xSQlBqYWQ2dU5Sd0VWTHFZaitGTTdiODVW?=
 =?utf-8?B?K1JXQUlOYUM3NFVBY2ZJdzdXYmJISUJ5MldpUGpoZDM1THhROG9pQ0lHdTRQ?=
 =?utf-8?B?d09aQU90S2RycjlXQUo4SFh0SFRZek1LeTZPcDVFc2ZBbFdxU0ZTZnZuaHly?=
 =?utf-8?B?aXlSZjlaa3p6MHdtSWt5M2drbjhOcWRaN2dGR1I2bDZXU1I2NEdVcmlGT0FW?=
 =?utf-8?B?RTdZdzRjSzNYdUg1Njg1REVXd3FvTS8xYzdLbGRUeE5LNG1UN1N3RUJlRHk2?=
 =?utf-8?B?cVVZeWtoQXpmNXBldlFrZFBCdTJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A44C535701C7314E98E7574F929C2AB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6b1ea2-fe21-49d1-b746-08da6e8894dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 21:56:51.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eyTABce/AlYiyZJvOlszmMwEGIi47/dCX1gXlpqD1AFZGwXxlI3Pqbjq1PBRteLQpVd5iL7/bVl+SsKB7bqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEp1bCAyNSwgMjAyMiwgYXQgMToyMyBQTSwgSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gNy8yNS8yMiAxMzoxOSwgTmFrYWppbWEsIEp1
biB3cm90ZToNCj4+IDMuIE5lZWQgdG8gYmUgYXZhaWxhYmxlIGluIG1pbmltYWwvZWFybHkgcnVu
dGltZSBlbnZpcm9ubWVudHMsDQo+PiBpbmNsdWRpbmcgcHJlLWJvb3QsIGUuZy4gZ3Vlc3QgQklP
Uywgbm8gdXNlci1zcGFjZSB5ZXQuDQo+IA0KPiBKdW4sIGFyZSB3ZSB0YWxraW5nIGFib3V0IHRo
ZSBzYW1lIHRoaW5nIGhlcmU/ICBUaGlzIHBhdGNoIGlzIGZvciBhDQo+IGd1ZXN0IHVzZXJzcGFj
ZSAtPiBndWVzdCBrZXJuZWwgQUJJLiAgVGhpcyBmYWNpbGl0eSBpcyAqRk9SKiB1c2Vyc3BhY2Uu
DQo+IEl0IGNhbid0IHBvc3NpYmx5IGJlIHVzZWQgYmVmb3JlIHVzZXJzcGFjZSBpcyBydW5uaW5n
Lg0KPiANCj4gSSdtIGhvcnJpYmx5IGNvbmZ1c2VkLg0KDQpJIHJlc3BvbmRlZCB0byBvbmUgb2Yg
U2F0aHlh4oCZcyBxdWVzdGlvbnMsIGVzcGVjaWFsbHkgd2h5IHdlIGhhdmUgdGhlIEdldFF1b3Rl
IGluIEdIQ0kuIA0KQW5kIHRoZSBoeXBlcnZpc29yIG5lZWRzIHRvIGltcGxlbWVudCB0aGF0IGFu
eXdheSBiZWNhdXNlIGl0IGRvZXNu4oCZdCBtYXR0ZXIgKG9yIGRvZXNu4oCZdCBrbm93KSB3aGV0
aGVyIHRoZSBURCBndWVzdCBpcyBydW5uaW5nIGluIEJJT1MsIHRoZSBrZXJuZWwsIG9yIHVzZXJz
cGFjZS4gT2YgY291cnNlLCB0aGUgZmFjaWxpdHkgaW4gdGhpcyBwYXRjaCBpcyBmb3IgdXNlcnNw
YWNlLCBidXQgd2UgZG9u4oCZdCB3YW50IHRvIHN1Z2dlc3QgdG8gaW1wbGVtZW50IHR3byBkaWZm
ZXJlbnQgR2V0UXVvdGUgY29kZSBwYXRocyBmb3IgZ3Vlc3RzLCBkZXBlbmRpbmcgb24gdGhlIGd1
ZXN0IHN0YXRlLCBlLmcuIGluIHRoZSBPUyAoa2VybmVsIG9yIHVzZXJzcGFjZSkgb3IgZ3Vlc3Qg
QklPUy4NCg0KLS0tIA0KSnVuDQoNCg0KDQoNCg==
