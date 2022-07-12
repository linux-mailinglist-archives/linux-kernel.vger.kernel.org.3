Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE2571BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiGLNvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGLNvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:51:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA78AC056
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657633880; x=1689169880;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4dK/Q973lAhUqDiwHoY2i9Av5GJYNif+2G2T8xTN5Y=;
  b=GnfdR9Hxfu43UYkvYBNmmvQAvOjDUlXX9WKBUeeT4+1/USewvvtTpjdR
   JeKy8r/GHz5fubiDt6ps3lQx0tqDPqDOapBeNMaTxgUU6i1BvWN73tM4q
   EjgdBrcE5MV0r82J/V2Yb6AySmDHC+DeiSamtm/9fVMEi4TvzHwPPHAci
   Lj4bWQR0HpPYzbu2FYsASy6v/+Jt8331O/vJklxEKByjLBzzL/iTWiJmj
   zt3c0bp+auSVo8uNdWN+U/kuIUC2LsTuUU/CTwrBE8gycEGNjWB3ro0La
   Hr5TfkrW7qVveYkBldudSbqQ8oae7l9c+ekUADKfN9gYexEzXUPC8V0cj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="286065585"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="286065585"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 06:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="721974476"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2022 06:51:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 06:51:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 06:51:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 06:51:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 06:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndsd6xwa+3B6nH/05c2EAMZZR/evY8jYNxnwlCX1hnOhiC6DvfHUEdOvud2cvwiT4aIsOBGm1Rathn9eZewbhLmQu8pdOBSYFGvQLkRJy0QwE8u8wosYQGUTi2zNKyqHBD8I0iE4VjSfsH4NYZNd02zXIiu6qdKKmXguAX205GRj3BI/WD3P6FFkDdmneYIix1G5jX3rrtPxpfRZ1JQ1ARebVKNXYR5xlDj3wjMIvU+6B9JXPvoPDTMAJNBd9OAzq5+hyPRY5SGwV95ISGLO1XECkvSeXNGoZWvQ8rZecy4cgbGdFm5R+TenrlUBKsasuwMj+wD8WpRxOXQ7eaFmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov81e4n955dhWvDBR+SS+689G9qWA34d9luvPlyl/Ng=;
 b=LcndpNAaUZB7Wfr+EUgOls6MYV+DgqOUm9Wzr9Rvba3muad64ygA/vPeWviL+m1e37jSIPek+LvaMQY6RVRjMepXLTS6BzT3VvqYYDpTxU4HxScGiK2AS4hINeJKevvhy0sMrHoZsDZnpCKq8ym5fLeWJMQGBOmnDPCneI8uY8YcVhyKZ1+fDfb31f59ctOicag/1MPLYDL8ihpsoeiSOCVoS6VHULZIbbRaVdZkyhN/r6XQZj9JJQPGrzsZQof6Ic+TSTnVa9Xz7BWmTRNDG6SLJhrS8/4/OVx2MGCLgmvIvunmmrCIMCA3Fe6EpgIJmR+jieqZQn1ouMVkW6D2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH2PR11MB4376.namprd11.prod.outlook.com (2603:10b6:610:40::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 13:51:11 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:51:11 +0000
Message-ID: <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com>
Date:   Tue, 12 Jul 2022 15:51:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
 <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
 <YsnoH64cKCT7gndw@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <YsnoH64cKCT7gndw@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02a86f81-b28d-44de-d912-08da640d9466
X-MS-TrafficTypeDiagnostic: CH2PR11MB4376:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPQ2SLKGjqFIDGqrJ9/CHgkhive5Q+zHXiDn0Iy7qL+ecqsZxZ8aQ9q+Xcv2fLdhBpyFzmJgORAomMdbvffNvcu/rwHr1ukep+NK8APT6xRCOFgvybByPe8u4AEyVS+0fcac6qCtVQziy5VpKY772iQihvbntCKGoYIBPpYoirw1Hnoqw6MDAN+b29kXV5vIvDEvExpo639Xky9HlKODySMCmWRStsjkPCSXBofqF2yf1fCc4TLZazV6qC28aIIHEA50k5ySbxvTMMEbHtd6yDcKT2RDGfR98k8sxGwbUN0K6ynGWuR3CYgMFHlY8f+nXmtsmP2IRG86Wktt4biMM2ooWp3jcT/qQ62UqCYVmlhkrUQBe8MZbbdZNXbZ2G+gT0s6xdbrCI4woQoyrdPYYEkGUOX5fKdsGadKRJ155yK0gj3zuqbUT4o0qR797XwVhHPgeZK/L/KqXJ0zCQmXIdUfQd2o9gF8bAjRw9HhOpeuyjy3ZL00bI6d6/Rk2rsRSyCWLhWKSIpvywbx2bWw3U2dwI9cPhPULUVC1tRUw/EoTWXUdjiAKcGj4yu5BCJr1eQcs+PITinAMADR9Z/UiI/o6ldm5GVv5J/QQdJIgh1Q6fgz9tNZBKgAxSJSrH2Q5ruY3en+GltvEedAmkziVFJWuI6DH4FiCdohZKLhmUPhmjVtPxqwfa6jBMzkzz2tB17anicyvFri5/wn2Q39AVnZiUkiUSqrNXF0Xi1DPlUeScXSaulJJcJHD/V6kvsLjp+appHTdKWddEDm92tsDb/Xyt4rgvHKFNh6a3N/DkZMZmVFnLcRAReKtRvWn3tpDn7Ds3g64HwWwyB1UqBbmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(86362001)(186003)(38100700002)(2616005)(82960400001)(31696002)(66476007)(66556008)(6486002)(4326008)(7416002)(44832011)(8936002)(66946007)(8676002)(5660300002)(6666004)(6512007)(6506007)(41300700001)(2906002)(316002)(54906003)(478600001)(36756003)(6916009)(31686004)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pTNG5veXNkbzZoVTNKUEYxK0NsaDVpUjc5S1paNVBmYXhMajZSYnJpeEpB?=
 =?utf-8?B?NTRWOTh6N3F2Q2FUeW0xSkxZMnFYQzdYZzBEdTBZVDIxaGNEVUhrMEMwVHMv?=
 =?utf-8?B?b3JpUU81dVhaZDR4cVQ3Z1NNWWYyWDh2VjZGOENzUFp2QjBkVkd0dFRPK1Na?=
 =?utf-8?B?cHRJbzFvUUd0cUFGU1l3eXo3aG1vcUs1MVFuOFEwQWZSRVlYeWtiWTRoSzBz?=
 =?utf-8?B?VEFDT0FVWXdXMDFmMnNSVWNVanI2algvRG1KNmtWdjZWWE1FV3Y4bk1qWTl6?=
 =?utf-8?B?bHg0ZzhXY21VdnRoMUNyb0x2OTZrMkJVZ2FiQTQxV0JTbzdYVG8rbFpnUU5Y?=
 =?utf-8?B?RUQ1Tmt4ZzducE5hMGxhT1kwVFJpcmpQTnFUdWF2MkJzQkd3SzBkdlpkSjJU?=
 =?utf-8?B?VVdoVUFCT1d2eGQvRW9PTmp2dlNBcUttR1o2UGYyc2JodmUwNGxLWVFacWhl?=
 =?utf-8?B?MTVIMmhFenJ5L3J5eTljY0NJd25peVBBWXkwSzVCS25JWXlTQ3BVdmQ2bGxz?=
 =?utf-8?B?WWtTNGtra1RPeUMxOTlvdGRKb0RDY3ZDUERnQzRNM3Y2Q0ZZSWJmZEhUZ2Yz?=
 =?utf-8?B?cjZxUXN0YlhTNDd3MEJVbjZGaHRhRGtBaTZoSnk2ems3YmlVdFNIMnBNcjNt?=
 =?utf-8?B?bGw4WmFPR2gvTGtaejdMcEswWm4vVUEzT0NyOXMyUFB5V1dzeFVOeTkrRlFp?=
 =?utf-8?B?TjNDSU84Zk5uWStjMUFkTjJySTNhYlc0MFhCNlBQMmpXWHpCdkp0NkRWelRv?=
 =?utf-8?B?UWdqNHczYkdDckpmQzJtUm9OQmNwUWxZS094WDcrNUlPSnNocTBJTEJ2Zm56?=
 =?utf-8?B?amc3Umo5cklYTS9ETDR4VG1BelZmS0JBN3haS0Q0R2NOeTIyYTdSTVp6QXRD?=
 =?utf-8?B?ZzhZa2QrTGhaWVZUL3ZPd1FtbzJwdTlGOUZ2enM0c2UzUnB1MDBHVGlKemZn?=
 =?utf-8?B?MXZINEZYNHlCSzhCcUU5YzdZcmxYZ25nN3Y0ZEFhK2tRWnAvNW52NjRJekVy?=
 =?utf-8?B?OTlCMXJhdDZsTmlPb3R4MEJtSUpwVjFYZTVmdEg0OTRsUkQ1U2gxQlRjT1FG?=
 =?utf-8?B?WHRSY0Q0SVp0dGZrelJkNXVKVkdHL2ljQlk0Wm5obm1xazE3REN4ckJBZlRr?=
 =?utf-8?B?UjBRVDBYdEpSa3ZYaWpOaFF1ZElRVjY1eVRXa2dLTklnbVdkc0I0TWFSb29z?=
 =?utf-8?B?TDcwUU96V3VXQll1RVFLYzJHWU9IRzFwaSt2Rk1sK1lseHlaalZhZE9MbDc4?=
 =?utf-8?B?UXI1RU9KQW0wNjM5bEN5YlJRc0hVOWgvc0REbjRkRHFhaHlqMm5vZCtvZ1lZ?=
 =?utf-8?B?elczL29EbVhOMmthcGZGK1N5UlFlU3pDTGpJcnpzQXJlMExCQXIyVHpnMFZs?=
 =?utf-8?B?Ri9QV1NNRmNGd1Q4SHlLU2IwQWJabm1ZYXFGRDUzZWN5SWxmM2JiRmhvTjdE?=
 =?utf-8?B?bXFVaWZKYUl4NzlXZWVQbVR0Vld4eksrSzM3Uko2akdJOXdlNk56MXZLWVdo?=
 =?utf-8?B?N0xkR29CanhMb2c4d1ljRWM3N2pCS0FIRG9JYUQ3bkgvZkFpb2tVWUpqMW5r?=
 =?utf-8?B?QWFwYXRUSHNkZDA2Tkg1UnVhK3p3M1VrbkZGWTZWSFF4MnVNUUVKSGZpT3JD?=
 =?utf-8?B?WkFhdjhMM2llR3JWNlpKUjZZMGxxSE9rVE5RQzRGQStqOEIxdis3YzdkTnFT?=
 =?utf-8?B?cDFiTENYYmk3SHFuYU1kbjVoOFhSL2xuRFd4eWRZZE5BUGRzNzZ0UnZsK2o0?=
 =?utf-8?B?bWk4L0Jic0VmeGtYRWVWa3UwaVhpbG54M3oralhiRm1PS1BqOGsvSUo3MkUx?=
 =?utf-8?B?a01YNks4RE1HRDZoUUJ1MHQ4c3VleURITC9MQmNTSUpQS05tYlhIUGphWGRq?=
 =?utf-8?B?YkhJQ25sd3dTbnFmK2pWUmIxNnVTQWZWcUFVYXYwRFpJSGNVaVhPVnNrb0Jv?=
 =?utf-8?B?Z2hmTzMrR2h1NStCQzdBcDRQS2lDUm9YalVoSldQWThsaTZaam1GektKUzY3?=
 =?utf-8?B?a0tBQUM0QTdMQUtQWmx5M2JjU0FQdXpPK1lST0VJNXYyd1orcFR6a0NTWVdx?=
 =?utf-8?B?c0UydmhDUmZQUW1WOTdFS2ZHaHVYdTBBUlpqTGxCd0xnMWk4ejJmbExpejNs?=
 =?utf-8?B?eWF2N2gydkg0YzY4K0cyZXFQREhsa3pnNzRBcS9FNTJTbDZzSVQ1MlUvZU5h?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a86f81-b28d-44de-d912-08da640d9466
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:51:11.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo+dYeeXcTa7Wv7LNhiGSllWQNTBbi2Tcnk5pn2iQMWtbd+r9B9bhrDUfW9a19OpEbWUEdzDlFUDi1Q3mm6UamtOp9rDkHLfrZitB2/5NQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4376
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-09 10:42 PM, Andy Shevchenko wrote:
> On Sat, Jul 09, 2022 at 10:45:49AM +0200, Cezary Rojewski wrote:
>> On 2022-07-08 6:49 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 8, 2022 at 6:32 PM Cezary Rojewski
>>> <cezary.rojewski@intel.com> wrote:
>>>>
>>>> On 2022-07-08 5:25 PM, Andy Shevchenko wrote:
>>>>> On Fri, Jul 8, 2022 at 2:34 PM Péter Ujfalusi
>>>>> <peter.ujfalusi@linux.intel.com> wrote:
>>>
>>>> A long shot, but what if we were to modify get_options() so it takes
>>>> additional element-size parameter instead?
>>>
>>> But why? int / unsigned int, u32 / s32  are all compatible in the current cases.
>>
>> I'd like to avoid any additional operations, so that the retrieved payload
>> can be provided to the IPC handler directly. The IPC handlers for AudioDSP
>> drivers are expecting payload in u32s.
>>
>> // u32 **tkns, size_t *num_tkns as foo() arguments
>> // u32 *ints, int nints as locals
>>
>> 	get_options(buf, 0, &nints);
>> 	if (!nints) {
>> 		ret = -ENOENT;
>> 		goto free_buf;
>> 	}
>>
>> 	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
>> 	if (!ints) {
>> 		ret = -ENOMEM;
>> 		goto free_buf;
>> 	}
>>
>> 	get_num_options(buf, nints + 1, ints, sizeof(*ints));
>>
>> 	*tkns = ints;
>> 	*num_tkns = nints;
>>
>> No additional operations in between. The intermediate IPC handler can later
>> refer to the actual payload via &tkns[1] before passing it to the generic
>> one.
>>
>> Casting int array into u32 array does not feel right, or perhaps I'm missing
>> something like in the doc case.
> 
> C standard.
> 
> int to unsigned int is not promoted. And standard says that "The rank of any
> unsigned integer type shall equal the rank of the corresponding signed integer
> type, if any."
> 
> I don't know why one needs to have an additional churn here. int and unsigned
> int are interoperable with the adjustment to the sign when the other argument
> is signed or lesser rank of.


I still believe that casting blindly is not the way to go. I did 
explicitly ask about int vs u32, not int vs unsigned int. Please note 
that these values are later passed to the IPC handlers, and this changes 
the context a bit. If hw expects u32, then u32 it shall be.

Please correct me if I'm wrong, but there is no guarantee that int is 
always 32bits long. What is guaranteed though, is that int holds at 
least -/+ 32,767. Also, values larger than INT_MAX are allowed in the 
IPC payload.


Regards,
Czarek
