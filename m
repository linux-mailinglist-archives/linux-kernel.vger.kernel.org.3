Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEB52A88E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349948AbiEQQtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiEQQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:49:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4A4F440
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652806170; x=1684342170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rgcsETcu/qmgGWnIt6s6EG+wLa57b82KDiKuKYtihnE=;
  b=iBhmfWJt0WbvSoSSd7BwfWJ1Y/fu8u3arG/vF5JnxrJKDqrcmHY2ZazV
   wHg+gKyEWqj43KV/Kzq3vyaHC7hP6Ea77TxPHnOuJUhZrAe+QA5Dqyeq6
   OP3uvPQb7qIiefLnTygRYicf29leQG03HY0dAcGtgy/joFyFlyiBXGnal
   Zp/AzCDQvbnflk/+Pjasyu/+Hudt0Xf5ApCmbCEXlffAXkaMcwup2nT9j
   slft0WlbR2DHuCvJ2FIZY2EA/rOf7n1NJQb3Zw65rxanJU86Iaj3RjeR0
   7JhFmFbVnFuyn6vADaeO3r+ZA2BiHxPsJC8Pdd6881hCQAXkCXu76Nnx2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253296027"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="253296027"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="741862225"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2022 09:49:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:49:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:49:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 09:49:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 09:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP6XZXjuaahR9kzG26PjVX/ZK1BNUMIn5gKwEtmOO7fd2BRi2y44WVciL4AyUAbii0Y+27thze+3cSx5IUbKgwEQporEIDrNHMxkhV7BYkRbDWw4ijEBnm/y56ml3S7lKG+wqihECP9TR0VmPVxzLfaN2lVoiP1lL8k8lIpOCruwsVDXJRm7qjy4gqciaxnUg2QPmqtxFXgZNsPCA0UZK9hDrweiwlroX+Vu2koBzN6b5rvO4M/J6Noy42RpEExPRKCpx79tDdDNalnKI/iNcKmwqus8JW+GiSpZDfvoYh62UjX3IX7nt2+dPqKYL1gUho2GNqaBZd2JU5k4mJRdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSLp0Y3LyVNzhPOLU1nLP73K31A4SpJcpM+DS0x03g0=;
 b=FGM+i2yid9EGQL7YxhDzPB//4mEYOMVCnLdInaLISpeeNApSmk5HWcu/dQdhks55E4LIiXdgU5ONOurwBOkuDkYM0piu9P7yVfRjfw0Gjb6XVIfQBNptjAyYKfsRIs+c9ACqnsPQx0IvJbbNDBbBHAcW3TyC7gfB5mHPwMzwtqfesAXAZTUxabVkdU0fN2aRtO/p6vsnqrZsduz/bKAn+jqqmK19vaSOW8g3Ir15LlVIsjOfA+Gn8C/MQF0JWkB8nYKxjE57wc9q/f2yzn1c3mmyGn8D2VU+vy4ab7M0UNIYqjjZBsw/r8HYTkXgNMQLkteT9SqsjwmOUWuYSPnF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB3935.namprd11.prod.outlook.com (2603:10b6:208:150::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 16:49:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:49:25 +0000
Message-ID: <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com>
Date:   Tue, 17 May 2022 09:49:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Stephane Eranian <eranian@google.com>
CC:     <linux-kernel@vger.kernel.org>, <babu.moger@amd.com>,
        <x86@kernel.org>
References: <20220517001234.3137157-1-eranian@google.com>
 <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ceafbf5-25ff-4e18-1e18-08da3825338e
X-MS-TrafficTypeDiagnostic: MN2PR11MB3935:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB3935A2B6CD1C2ED3DD457D91F8CE9@MN2PR11MB3935.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZq2b7ZuCkEzzEKSQrBecY3Pgt9S2Jzx410EcDsqSPnC8Pznz0uMOt3JNtPvHyyVsikijUFYePci6d4WgHA9Qv2C0BOwVPO8P1OB3GDbex3R/RTXSEkHGoKogYYNo6l86ixnihHuUCgyhU+4FftDbT54/TqbXDQpP4axCEMs9gpii8tNh4CUiM9c9DatxSNdO+VWuAI/hOxMFbYPk5NptVro2djuvCeMzs+facXfVkxu3ht/H/bdMtNYoXHHRzBkGRCw6aNI9YQWrOc+vWopyZLiB4YXIDB+hpYdcrlnJdKRuQR4tRje7EKbL/hCK3RwkD/QG1aOarLMUJShr5ubbyQ5Nyy9YbhaAXTq1FsdqMBlGpwbLfQk/U2fbaflL1z/BESqMUeKPBnfxN1JQrkhOgH5nFm5PbuaAzOe2HrijwBEEq5EnNQRJPIi8M/GKT8c7fL3ezXS5WFP1REKjbULP2rzmmWi/WM38iZ9J6SoG6GYxNTR/ew4/DFHSb8auMToidCU6BzST/wZ1tW+oeR8UeJBrPRV9O1PtSbH6ZDRr0SyCjkXvnX3ZSmCtpCpdDtKvVWIZi781IjtB0Jqlyg3S/0GZHHqKRpxpvcFzy1cMq/e8te9tbBjDI5lsZDtphn0Ux0JUeJ8EzA4N9suM26+38wRkSX6aQmgwAYhT6+se3awLxqX+J/selRfLX6O87xOCIbuBPQbYIVShk7cYSgG/OPaC/Ea/j6RbRHZvRcxjMEqKZgjPBANHazLN+vViLGOa3j0Moa/zbaoe3Lvqct9vlOkRyxxpbIeSQO8/jOzwugebazlQZGMlymvxnsbejZ/IT+8xKAq5buPGJJMNov/ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6506007)(5660300002)(53546011)(44832011)(186003)(31696002)(4326008)(66476007)(66946007)(66556008)(8676002)(6666004)(110136005)(86362001)(82960400001)(6486002)(966005)(508600001)(316002)(2616005)(83380400001)(36756003)(31686004)(2906002)(38100700002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVvSWgzNDFiUWxvYlozNkJxd0xVdGpwWERNcm9xdE95OU8wamdOMlpXWXZS?=
 =?utf-8?B?bks5dHYxWEVzNFp6Nm16VCttRnlnOFhKY3E0dldxWFZ1VW1sNmc4WkhxU2lm?=
 =?utf-8?B?TEhtSjNrWEZOWDQ4YkhWcm5WSnRWK2lUcXBSMUoycHJuNm4yVmE0WXpKRUhX?=
 =?utf-8?B?c3VhTzRvbzhpOWEzWUJtL2xzbjEyZnZUU081SkxycTlNUnNjSDRTOXBEME1s?=
 =?utf-8?B?akZQblpSaXhOcFVIaFgrYy9hb3VYSmdXS083UkkvT2NaWTZUam03T2tMT0Vi?=
 =?utf-8?B?eWxmdXdtMG5YcUkzbzc4RGY5SWxkLzMyU2RYSEdqcjE3YlR4eUZKZXlUd3h2?=
 =?utf-8?B?L3VhVmZBNDJHcG5tL1FRQldsTWc0NDA1TUNQVVdqRmp6NndCQ3AxQkdpS3Uw?=
 =?utf-8?B?d3IvUDViM1BpbGZ6M0p6aXFHMHN6VWQ0RkI4NDY0d3JJdlZvRStQMDZmQWxa?=
 =?utf-8?B?TDVhbm1McWR2ZHBad1Q1WWp3SDBnZXlvTzBuOVRQWXZad0hvdWE5NVlJdVR5?=
 =?utf-8?B?WGxaYjk3KzZReEtCVmNVUDdZYWk5djRYcmJRUi9UVm0rZjFjdnMzT0lraThL?=
 =?utf-8?B?cmpZenBMK09wVE9CQWYvZWkrQ2VWUHlCUFE0V3ZFOE5JOUVYQm96RERIL2dP?=
 =?utf-8?B?QkdvK3FHRGRNTm9MVXNvalI4ZmxhSVdabVJzekY5Vkd5Qm1sd3hjRDRxSzUv?=
 =?utf-8?B?SG82TWVHd294M2szSEJqMmYyUnFtbGtONU9BWjU3aktrQ1BoTWN2MGtEWUpC?=
 =?utf-8?B?NmlpMGxHTWFiRUdsWGczSjhnalpLNlV3SjB6OFg0L2E5S09kMmdscWVMWVRT?=
 =?utf-8?B?TXZtL2I1Y3VuSnFhUGV6d3NvUXBKNXZ3R1lHVi9QbGNwNWpMTkRscXpRcmo3?=
 =?utf-8?B?YSs1ZU11S3R1L2pSSmpxSFRtMm5xK3dIM0ZnVHUwbUFaSXpFUktQVW5HTzJM?=
 =?utf-8?B?UGdsRHZzMXpjZ3BYOWdXbkhIb0xKa0EvbjFGZDhERm16WTlVSXg4RWIxa25J?=
 =?utf-8?B?dnZEM2MvemJnaTNzeXAwb1pwOUduc2pUbGtmZ3NOcm5STUpJL1grMXFIV0dQ?=
 =?utf-8?B?TjdKUHJwcmdJSEZLYjZpOTlNejMvY1IrOGw1eHY4N2JNVUV0NWc5MG5KamNZ?=
 =?utf-8?B?OGxFVk1DR2xCRWVhMTNlRHlLNWpZbmd0Sit1blpsdk5Zc2d6NjZOamRwbkYx?=
 =?utf-8?B?MkYyL1lWaFFDMnJ3NXRCaE1mbG1UQWY1VTlKNFowZUluNVdJR09DaDV1MlI0?=
 =?utf-8?B?cEFScFBGVWU4SFJtWWRKK2pmUVVicmtlNzBkR2FuZjR6RVFqYXZXZmFZTTJH?=
 =?utf-8?B?ckgvTEViN0VLa0pOVFFTYVA0eGtRUG5MaFNVdUJEMFZtNEJid3JZc3g2dy80?=
 =?utf-8?B?WisxMnF3Z0FzUEM2TEd2cVIvYzBqVGZYWkZvWGdTYVQ0amhRb3N3Nm81ODZk?=
 =?utf-8?B?TS8wd3NIelk0NThpcnE4OVdlODR6ejBGNFZEVHJQcElMcTcwVUlNRFdTSytF?=
 =?utf-8?B?eXVLZHByV2ovaG5FOWFpdVNEelNZOFZNS0Z2eFNKNlJLd0VkY2pyNFhUUDBY?=
 =?utf-8?B?amM1Yk00S2o0TWcwSU9aREdVYUpVNGtUUUh6NmtGeG1sblNCeHdyM09URmxv?=
 =?utf-8?B?bU8rTjB6bzNFZWIyV2Y3bzk4R1A3SzBvT3ZaQTh6Nk1vM0YwZmNBSXFHOUww?=
 =?utf-8?B?dmM5M2Y3WU50aWVVVmpTRnRxU0JoSFFkQWZNRmxSRTV4Vm8yMTQyQ2FjVWpk?=
 =?utf-8?B?aUVEd0RYckxlVWF4ZHR6TVlONU5XRGwwbjMvSHhCMFZ6ZGl4elJYYi94V1I1?=
 =?utf-8?B?UmwzSVQ1RFJpODVaYU42cGdCYUlxcldxbThFcWRTa0kwb1NLaDRCSlIwQU1I?=
 =?utf-8?B?aHVEdTBZTU1Gbml5Ky84anJSRGc0WlA5MFZUbExFbWtRbFJWNnI3QlJUUDBV?=
 =?utf-8?B?ODZSMUYvMnN1eldrR2tENlk4eCtUTlc3VEUyT0o5WG4xYUxCMWlyckR2U2tC?=
 =?utf-8?B?dHFpMHMxYmtoMHl5NmJBZ3NMZnlNWEtvOG0vOFUzb2xTc3h6VG5IMVpGOC9F?=
 =?utf-8?B?QmMrSTlxTE9ZZGoraHp1Q3BZSHdEcmtSSEZaTzk2bEg1RGkrczhncWxHY2Vt?=
 =?utf-8?B?c0hrVXZuRE80WmlORzRLK1VZcmEzb0c0MnNDRTRxcGgvakJLeXZvOThmTjZE?=
 =?utf-8?B?aUsrUU8zVDF1d1M5Wm1SU2JUN1UyL3g3RnJrUUkva2dKaklzekc5ek9kcDZz?=
 =?utf-8?B?WENwVWd6ZTFsOXVDVzBuU2dydXZyUzJvOFFjWkZXVHlJaE85L2szc1dQTDIy?=
 =?utf-8?B?Mm5xb3M0aDA4S1RydkRjWGlTeFJvQnFoYzc1d043YkdEOTdReWdiMEMrcEdj?=
 =?utf-8?Q?9MUww1GznUylKZxs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceafbf5-25ff-4e18-1e18-08da3825338e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:49:25.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+V9SLm1JKHUe45llKn6T+GjtKhGmnILhtdr1sriIs/26hV7yGvKbDBwqPI8609UvRCAX7KPcMgT9SDt0GFhG1CW8Cd2oDEre8KnJxExta4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3935
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 5/17/2022 9:33 AM, Fenghua Yu wrote:
> Hi, Eranian,
> 
> On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
>> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
> ...
>> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>  	first_bit = find_first_bit(&val, cbm_len);
>>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>>  
>> +	/* no need to check bits if arch supports no bits set */
>> +	if (r->cache.arch_has_empty_bitmaps && val == 0)
>> +		goto done;
>> +
>>  	/* Are non-contiguous bitmaps allowed? */
>>  	if (!r->cache.arch_has_sparse_bitmaps &&
>>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>  				    r->cache.min_cbm_bits);
>>  		return false;
>>  	}
>> -
>> +done:
>>  	*data = val;
>>  	return true;
>>  }
> 
> Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
> Is the following patch a better fix? I don't have AMD machine and cannot
> test the patch.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6055d05af4cc..031d77dd982d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
>  			r->cache.arch_has_sparse_bitmaps = true;
>  			r->cache.arch_has_empty_bitmaps = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
> +			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;

That is actually what Stephane's V1 [1] did and I proposed that
he fixes it with (almost) what he has in V2 (I think the check
can be moved earlier before any bits are searched for).

The reasons why I proposed this change are:
- min_cbm_bits is a value that is exposed to user space and from the
  time AMD was supported this has always been 1 for those systems. I
  do not know how user space uses this value and unless I can be certain
  making this 0 will not affect user space I would prefer not to
  make such a change.

- this fix restores original behavior that was changed in the patch noted
  in the Fixes link.

- this fix itself relies on math on error returns of bit checking on an empty
  bitmap. I find that hides what the code does and this fix is more obvious.
  You can see this feedback in my response to V1. 

- a fix like the above snippet is incomplete. To be appropriate 
  the initialization of rdt_resources_all[] needs to be changed to
  not initialize min_cbm_bits anymore and move the platform specific bits
  to rdt_init_res_defs_amd() and rdt_init_res_defs_intel() respectively.


Reinette

[1] https://lore.kernel.org/lkml/20220516055055.2734840-1-eranian@google.com/
