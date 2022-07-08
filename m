Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CDA56B8A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiGHLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbiGHLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:33:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25189951C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657279988; x=1688815988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DlzL/4MLpYLFAfs66jRi3hMD/5VVBK9BhxIgVj3lqxM=;
  b=mcclLiXDAfAUNwnlRtQ0ZaxBFZZIhZrrwUF6MGnRSstFluuzN5M+dOk4
   byCW9dHRx62dFn1nGCLw59FlrFRYCxAhmqNTP9z0OMAFTdy99ZpG2q4Wa
   S3R/VCNQIknO8WzqH3FEbcbAcp/fYP7xa/scbE+SBzCHKlFRSIV4BEnF+
   UuhHEZ/439Il2cwdvcIKWq62uJnOYS5qT68r1SumhtjEioeCMzqBA6haa
   i9wK9oDs+TRj9teCB/Hfm3t8TM4+Z45Vi3Lro9K1u/UorRzIff4m2VqSY
   MovqQRJhYlPA9Kog+BibLShdo6ZhjvH7paz8ln7CyuC/bOyNKsf1Xmbca
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="345949352"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="345949352"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="696857240"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jul 2022 04:33:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 04:33:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 04:33:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 04:33:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 04:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqqT2cxsxsBKYbY79MZ/pRvHCz2leBwD/zeGAYZBLcyDbn2+Kdr6Dp4e9LmyJgu81Y0NMeMbm3ieSNpxdTIHBAHTPHpIifr+Lwu9M2lxoULK1wYNQtWEliMbqJb6K0Ut1xAS5OH2Wxqp2pg6xpt0dGVnf0iCZF7WwbgOI3zAxWlAuqqWGmelmW+JmDx3PJnTQC/XZScTJBuLTky5PT2nRoGI9NsQ3Ngy22e1rWwxsyGzRqKxIi3h7jJ7jOl6mZiV4X3kHfQ/PnbZafDrAb0n26K5Y2KSaSU44FlzjfIJRrKvD0DKCpkbE991EIOZUTB2oeKE5siGDCgNEkYs6IKJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYnUaF7vRgH1NXS0J/xu/sTMtA6kJ1fQF3r62dEz8SY=;
 b=dUc8bK0kKJfK7j0JE3rq4I5XmCFpBwMwn5bJOCFgb9DlLJE6EXSB7L0vJBfRf8XyF8ywqwcZyl9zD+TJw9KF8VNunOsud40ChJGLuJE67WyqP/X4rwD6KzxzdCXyiEhzBuL9vaES3zCfQUGWr5xtvDkaFIxPTiLcAr1sgU3bMHrZWlbBKkm5Nh+2f9MQpQEfPwwwi+Cz2FBPS3N5FogBgKFZNkaEMMlhqzSKokJlxFxclAAZ0gvygtwMaWTq5VVoNlgOZpJjOErXPlvohwlv05MQSZr8aqCuPzJTRarK2q7REToJIt3L2VkzotwLeoRjMnaF1qmXotMfyREoqxmOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN6PR11MB3923.namprd11.prod.outlook.com (2603:10b6:405:78::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Fri, 8 Jul 2022 11:33:04 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 11:33:04 +0000
Message-ID: <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
Date:   Fri, 8 Jul 2022 13:32:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::37) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399aa2ce-444c-4fc5-8ad7-08da60d59f0a
X-MS-TrafficTypeDiagnostic: BN6PR11MB3923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: op4r5cCzTIaF2lek0xlSx301OAWOpAmP48DcM8FJda649d7dn6wcZ0kS12t2UuLoK+os6fMuw7avTq/NyZwQAVN8DAzoX19c5ABdiOuvAjbc1i/qbA/I7TlMOgJ6Wa9c5k0ozzYFNEtARqXWE6/H3Wn9QvJiVU8cA5Svsgz+DutdntvY7hePRwGKnBdJ8PqtfY9/OgnO1/Gt1z+tuK15U9vzwSYHJqmB1QoQfAvrFtYbqt8WhoEPmXwYWpJ+yFRV+6boEnb+B3+Bu0qVM2vqVaubgErevCNK58HJo+FpNkU/xIEni85DoA7eIMQN7AX288edASPzJkPFXYB2nK9qIuSjIvX9tVAUflYsC44lkXDpqIVLRH0K9fEonGfV7IGhCP/blShK03qCTEqrSl/latlM8Cm6i1pUpJ4HIx4CnF0hYAq/iAGfxwrB3Vk7zHMEQUlhrgTSj/VwWyNjJ4rP+NtEjKXNFa3LGDox0/lePIjnF/tJOwhH4nBMK3LdIblnDfGjSHUvoelUBKrgQ80+4/Mc+SjhQPZ7D3YxJENvmTs7nbYRjbv19iPO2pEvf8TmLz/Gi+wXFCNdPeq2Aiqja20nDHTcgoB4fS7FTMROe3vBSULrrqJpSVQ97/e9Zf2kueEcF1zAgo1rtOkXUxBPdbMW0k5p2qVurvxANCoBleYFXsdjWQFjvO4JVzYc/3ck6UWobHj3Hjp1js7kmJK3JBhNhSn0H3rY0fqaMLsIrfWyo6GWSeKcsQrRR1Wf89++3Urjq21jbjYjujKp3H7NG1U5aT4glU6dH0fo1vNBNtHgJ01lmNEZ8r+V5LvhGlHr1Rq7VnOBwNIq9baL6wO8vnTwPIx9GqBIcp1mERM7rcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(376002)(366004)(31686004)(4326008)(8676002)(66476007)(2616005)(66946007)(66556008)(83380400001)(6506007)(2906002)(36756003)(38100700002)(82960400001)(186003)(44832011)(7416002)(6512007)(478600001)(6666004)(26005)(6486002)(54906003)(86362001)(31696002)(53546011)(5660300002)(316002)(41300700001)(6916009)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZQd2diYUthcTliY0ErZ1FwR3NnNDVMU3FCV3JOVmUyWi9GMHZ3TFVNZHc3?=
 =?utf-8?B?d3dpWG81aW5EOEFSTHN1RzRrbmN2YUZGaFpueWUraXc4QVVRNDVqWkVSV3R3?=
 =?utf-8?B?Q3dDUVk1c0tsUUlqa1U3ekswYzJWVnBWYkNIODFqZFBrYUFUb1RnSVRQUzNY?=
 =?utf-8?B?VlBpWTRYK0hwZHluT2ZCUGVzYjJYenFQdXZQc0IvMld1NW5ZdW5yQ0oxcE5T?=
 =?utf-8?B?Z0YyWU5PZHVEc1liazRpWHFCWlFKTzkxRDBTMmp4RUFoSUI3WTVDb1BvNWIz?=
 =?utf-8?B?dWt4ZmI2TFB5MlZJZXZzYXd6bDRYMzhlZ1pSdCtOSExSMmo0Z054V2ZVVG10?=
 =?utf-8?B?Nyt3eDZOOUZOUmFiUDlOcnB5UklPK01sZEhZV2FnUGtFblZRaGl3ODZGVWN6?=
 =?utf-8?B?VGt5THVMNmx2Vlg0TTN4cnNsQ1N2ZW83NGZCbVg5MHBSaVhzSERweDVob2lj?=
 =?utf-8?B?eUFwYU5mY2Z0M3NMamJYcS9XZ0ZjZFFBSUhESitXU3lxZTdWZlNpN0FiYUxr?=
 =?utf-8?B?TTY2WmZVK0Z6VFdMQ1ZwUjhENko3R09HbUs3WWFSQ0xpNVlkSnhmMDkzRUls?=
 =?utf-8?B?Ukk3eTRLVXV1dmw1VFB3MW9XUXc2T2dWUnJEQXA1SUdkQlUrQXZMaDMvUVJr?=
 =?utf-8?B?V3hiWmltLzJadXkzLzNEMkZETWdWRGw1ZDlyeGM3VklaaHBlQXRtdUFvZmQr?=
 =?utf-8?B?MUJPR3VVZkNHT2o1eXd5RmtYZzZ0cXZ4WnpTQlJ0bHVJRlkybElyaGx0L1A3?=
 =?utf-8?B?SmU4SVRKYVgwejE3dkNuZit6YW5hSkdPTHMxeTZnMkY1Z0ZKRHR4aTRwc2pI?=
 =?utf-8?B?cnI5ZVEvRXZsaXB5QXAzdjM4SzRZTnRlTm03N29kQ1NQWTlZSkgwWFBKeXpZ?=
 =?utf-8?B?cmMxVUFmbjk2NFRhNitMaFNjQ0pDSmdXakJsL3d6MEx4MFdISVJodkNvWkQv?=
 =?utf-8?B?TVdrREYzTW9DRE43VXVmd0VpWWJZSHJRN05Wcm1EdHhyWVNZeEhmM243MVZ3?=
 =?utf-8?B?QURMdVZITHlZNkdrVnBacjI1Z21Sd3l4MGZwNGVjandEYnNKelB4UDZJUzU3?=
 =?utf-8?B?dmliT1Z1ZEZXOXNWa2Fzb2hzMThZeU1lbnd3QmtKNURZTTVEbzdUaTFBVmU2?=
 =?utf-8?B?bGYyT09DMDJDRTBHY0s2eUxMRDBxQVRiY0lneHlNclhwYW5zQjFXLzRIODkr?=
 =?utf-8?B?TVhaZGE2K29BUmNmd1duTXRpS3l4ekFKbGYvYUdPUzNiMGxwVjZSMzdCbzNJ?=
 =?utf-8?B?bVd0MEdsTUMxbzJGd2ZIZzFsd3ZTb3lxSEt6dE9UN1VmR05nUU4zSXI2MWMx?=
 =?utf-8?B?UTJlNlNxRFlCM3I5RzVKWC9XS3lqaXEzSE5WcVZOWjNjekRzYm1aTEQ2M3Zy?=
 =?utf-8?B?bytRSnd6MjFIdTdhdXNzanNaUGllaVN0a01ZUUx6aFNKWFFlTER5Rm5SZHdL?=
 =?utf-8?B?NHdQcFhUQ1dWYW5DWUtLb1hsc0E5aVloSTJmRmIyQUVseGZPN2VqSkY2bEN3?=
 =?utf-8?B?bG5uMlY0OTdSM04xRzZRYmp4blZuQ045bHgwSHl4WmY5SXJseVhOL2JVNXJ4?=
 =?utf-8?B?akhqNGFhK3h2U1BvTFU3endrbSs1OUgvQ20rNTlLcG5YVmtRRDJYQU5KU1pk?=
 =?utf-8?B?L2M2UHNaVUNFQVgwV3NhaTl5aGtGbzBZWWRHY21hQk9meS9XWE54ODdOM0FC?=
 =?utf-8?B?Q0p1bTV5ZGhCVlVOTVdLdFdaVm1namVpdkVET1J4cmRkNzB5bVlJcXJGU3BO?=
 =?utf-8?B?M2xZY25Fb2l1OHQ4SnJqTmYyZUpONjQzdDBaUUlXTFkrVitDbFlvQ0plZ3VI?=
 =?utf-8?B?dE0zYkVUQ2hPVDRtN3lFWVZwazJJWW5LbDF6dTRoNkFzMllNNXRJY3pmSk9E?=
 =?utf-8?B?VmRTV3h3NkJTaFZ0RS8rdFlqNmRwT2lpdWNBOTN1ak83dVlkc2pDWm1PMUJy?=
 =?utf-8?B?VlNFWmQyUUQwZ3BhNmlWd1g0ajFYQXlJSElmbXlZM0hwVkJWQW1vSktOamI5?=
 =?utf-8?B?N1laSkVmREZDV29hbmoweC9JVFFxbDlzQVZ2YUVNejNSZ1BEbEp0MUF6Vi9v?=
 =?utf-8?B?bTZnK056ekxSN0JiV0NSdno3eG5xNFBSSGQ3bW9sODlNK05sRkFLU0RBMUF1?=
 =?utf-8?B?OU1JcTYzOUhqL0RlMUIyL1ZpaUEyNHdoSmt0cGIwSnhpcGxNeW5xNUtWS1RP?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 399aa2ce-444c-4fc5-8ad7-08da60d59f0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:33:04.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSzAr5USy4Bml44V5MUoF9mAaiDDQgU00mOPlIXpAgic8usxomdfg7mOEN+IDell2MoLI2xnm/31OWT45czYqdUeO2/3LgBtz98g90rdbMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 12:22 PM, Andy Shevchenko wrote:
> On Thu, Jul 7, 2022 at 11:03 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>
>> Add strsplit_u32() and its __user variant to allow for splitting
>> specified string into array of u32 tokens.
> 
> And I believe we have more of this done in old code.
> Since all callers use ',' as a delimiter, have you considered using
> get_options()?


Thanks for your input, Andy.

When I'd written the very first version of this function many months 
ago, get_options() looked as it does not fulfill our needs. It seems to 
be true even today: caller needs to know the number of elements in an 
array upfront. Also, kstrtox() takes into account '0x' and modifies the 
base accordingly if that's the case. simple_strtoull() looks as not 
capable of doing the same thing.

The goal is to be able to parse input such as:

0x1000003,0,0,0x1000004,0,0

into a sequence of 6 uints, filling the *tkns and *num_tkns for the caller.

>> Originally this functionality was added for the SOF sound driver. As
>> more users are on the horizon, relocate it so it becomes a common good.
> 
> Maybe it can be fixed just there.

avs-driver, which is also part of the ASoC framework has very similar 
debug-interface. I believe there's no need to duplicate the functions - 
move them to common code instead.


Regards,
Czarek
