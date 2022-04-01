Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AEA4EE7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbiDAFvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiDAFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:51:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9C3DA51
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648792193; x=1680328193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B/Yz/XI/qef9KgssG7DJdUHIi3r9Vw11cBFZBvFlugc=;
  b=M43YJ7geYZduFnHipUD/FogV9kJdrlASnhIDHEp2nkc1Zz7gReWM/RFG
   MQktFM3caiY0EZ9bZc/EX8zAF6rX+D3UoSJKVKUlBF2o7fdwZTih8r5kL
   94Xp7jNQgPvRH7V/CoAmm01lliiIh99wFKXW/H0umxEIx7EIkgwuKSOxX
   ilzppvTtvD1vdAT6OhQ1eCTTZ7Gf/bpEpPxLZ/Ipl1mbQg28htq4Q0SEx
   dD8IsjTGvCePjOMj/Vn9/LlMrgSWBpiJ5miC7dYl85R5T3fzkmrQZQ6ID
   TGeaMG2We8VBt6PDUzfmb3tpPdhjXo9myc21AdLGQTk550eavxcWgKesS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="323220282"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="323220282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 22:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="586727210"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2022 22:49:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 22:49:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 22:49:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 22:49:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 22:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE7FF+IzS8tfQlLk/xa5YyPg2Gw7mNIxkQxXTQwz2HYamEejAD4QQ5eoMYB/iUjxDaK/NBNNf3HAz8Kz2s8fc+LVurw4hsj6Scb6+WvVmBkoCgZVS/ECpQMRaE3LzsmTOS8bvnmonEwGsFrbFOpCCy8syR8JJOI58ldDj61M2BfGhcaDY6KZdNiMi5G0weNAJHWOAHyIadJhCu2Qay/NCoRpcpLUceZvutEc8Q+SgznEkL6dr59SJm4u06SSuHAy+QodFjRJAn/N5RFEU559kraxILCjzVCiOGxdnxUo3DthdigRrum4qPUmH7PIeCXyOpjQ3O4kO6tagXGC5PJgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgXQ3D1SuLdpzvd0SWwz++8+VIQyNuNjncimSsO4E3Y=;
 b=UBVipfoJ7lFkyDki8fcSbzgrBpX3B6PyOOEt/xvxinnlGdxSRQKoG28WyFLW0YnaoPLeyvxNCh+1RaBkj78hIgirVABBfwEeYu6/GldHjBrJCjvNRNDL7BE9YWBWEVJHVbSufQIy+5NUC4fv6aW1ZbdhSftONX6LzTjuUm5KXOB78/KpUBPEiRPBJjPaMVAGaV4lOGdT5De4CSy9N/RSuBG5ZKmktkQ4e1FW2CberS1CNvKcC8VBSme04sEMx4U1RzGADZP/KusRIC6FOor5EHS/eVS5N1LHzzeFwJGQelXp43Fo3Jb80rlQOhswyfNkOZo5IjGSHJfq/ZiyoD0h0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by CY4PR11MB1655.namprd11.prod.outlook.com (2603:10b6:910:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Fri, 1 Apr
 2022 05:49:49 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::bc9d:6f72:8bb1:ca36]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::bc9d:6f72:8bb1:ca36%8]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 05:49:49 +0000
Message-ID: <041cb131-2a61-afcf-69b8-5c84234935a1@intel.com>
Date:   Fri, 1 Apr 2022 13:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0174.apcprd02.prod.outlook.com
 (2603:1096:201:1f::34) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12c91cd-bbd4-48e5-55cd-08da13a36f45
X-MS-TrafficTypeDiagnostic: CY4PR11MB1655:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB16558CC739F4E4904CF38301C3E09@CY4PR11MB1655.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLV25zJwOa4RtjbkT+7SU3ZeOSp/7NkUvBnceA/RnWbWDH1caFSKH+UqdiuBIAL44HZALWPJ3wDx2sfjemp3SQjabv/K1fG9FTTWl6G0Z2ofij9qHvrOF8UiYNW8t86SZDKHOnRTRNW9KBxY+yVBRIlCa/MmZk6dc8JTwYcFT0JiDKAtvQ9dFSFSN0yxVfmShPKKCSuI05sMVQQa/CHHaYkLzvfrX3l5Lb67DQmUZbgVEHs+aWiEvYx+siWnTAudMHMQalLXcYpP8PfGJiFnAqjNpOE5kgx3gI/AuMVanzK9WaCWyPnvXLkBdVl8ftKnTgfAZZiT+LmahBTWgmDLuW4rfmL7v81R27qJVZrwSOjWvdOvleYb7YBfmUh7YmGc+gkHLgJUxtcoVMLBA82qAw/fVxYe2U7gkEjIhzPXj4MC943fU7nHSMUwfsOHk1ymJ3zGTAP/LIni4f9TfwCO/WL84IFvWwJgP1tKQ7sfqAtj+Tels66vwxpkqsn0kdh/Yu8Nvr2BcOkVpXF0KrA4mokoC4JYgjffRI5qDmStry3kzDAN+BAs0o4/0X66cMvOkitXT6xxRn1btnwVfJiyUM28P8kV8PvOEh1g4OWjg44erIfUPz4MhUZwK4u3TRg2Wud+9m1h3zxm0+5GUZ1oVq2kExycq01Armyw91Cc8frh1ntIewNzwhhRAN6aoE3LafJtlfnMeMtWAAuNXfPuy6NC/JwqaSwprk9Uhr2/nTJgbR6X46GW6mPrSb4mCqjs4IRGIruQZbzZWE1LwJRugwBJ6U9Ig1XM1+KxPRHvbJXpkZOMyGtFgzYWwrAAReLSCrQV94ds+g3y2L2LCMkBbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(82960400001)(508600001)(6486002)(6506007)(31696002)(921005)(5660300002)(86362001)(8936002)(7416002)(53546011)(31686004)(6666004)(4326008)(66946007)(316002)(6512007)(36756003)(110136005)(2906002)(54906003)(2616005)(83380400001)(66476007)(38100700002)(66556008)(186003)(26005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGc5b0JvSHQzeENad0FRcURabXhUQkhhZ3BjVERsRStvU1RkOS9yTjFnaUlY?=
 =?utf-8?B?M2VqUDFTaVAzS3ZsNk1aUjdQTjVyZUdvRXRHWDNoWEZ6RE1DWCtWRUpnWFJw?=
 =?utf-8?B?QjhMdzZzY1pISGhOYTVVcktWcWExckVNblF0ZFdRNGd0VTdBaTIzRVgxRlFY?=
 =?utf-8?B?WXFLRWRpTHhtUFRwY1dmR0JGOW9lUFowZ2RlUVQ0N2JWSnFrRWhyVThNVW14?=
 =?utf-8?B?eDhxTmgvL1RsSWl2OGhobzhNSGdCakwveSt4ejN1ek5KU3N4QTkxZXRCQXR6?=
 =?utf-8?B?ZS9TOTdOS2tyalJGSmxPeFFGbkVaaWRidWxjeGI1ZDlRQWhCV3JlYytNOWNq?=
 =?utf-8?B?R3BPRExFT2RGT2FpOXNxUzhEWlZoVG5KcXdmZHZOTWxwRVVwOGxGb3pVSW1H?=
 =?utf-8?B?R3JPbEtsaFlHNDFGV3ZwZXBPNTVxRlV3NlllMVMyaHpTMlFlYXFlNVdXbXZE?=
 =?utf-8?B?UXJyZ1ROZ3B3dDRWRk5pOFo5QllTaUdNQkNCQXhUNWVxZ05nZk1EME41YldW?=
 =?utf-8?B?Uld6ZlZZUzlKSzRpdldFVldLRWwxTU5NeS9ENG1aOWt0MWsxelZuckQ3Vkcw?=
 =?utf-8?B?cDFsNjZWRW4zZEphSlJneEZyWGZoOFVBbm1SSDA3UVJXamdlWDU5RmtrdXdo?=
 =?utf-8?B?dzNzYm1vOWZEbDFjNVBaZGx1R1Z5a3FZT2M4R25IbGwxZ01zWXVUU0NvYk5y?=
 =?utf-8?B?OHExb0VuelNoSGViaTlSNWRYOGpqTlc3SzBEbTdoK3lBeDdVQUcyTmo4SEM3?=
 =?utf-8?B?RG9qazRaL3hpWmJseWV5ZjU3bUF1Y1hySWNkVzJidzlpRVVhSGtVbWRjWjVY?=
 =?utf-8?B?aVY1cGhQSHFaanVOZkpYemlMZFNFaTJOZ0ZkQzZ3cU5RcDh3L21zbnJ1bUpt?=
 =?utf-8?B?V0xSd1dhRytQUHVpWVVTQ01mbzd0UjZ5WVczMVNaT2xHbkh4TUZmUFoyc2gx?=
 =?utf-8?B?VjBGUmJvK1FZaTNTZkZGSys5Q0ZhZDZiMFV2ZkhFVnk4Z2w5OHl6dGhKOXc2?=
 =?utf-8?B?cXFXMlVKRFBnUWthdWl5TndiOE9FTjlJYTBvMGUxb3dkNFFFb05rWDBKVG5j?=
 =?utf-8?B?UVRQcUxnZCtMQUYyelVjS3ErQThCV0FyRnAwYkUyZTVTei9McGFnRnpITW5I?=
 =?utf-8?B?eFBGQTZmUFAwQXY4UjRHbThHc1RuMVhHWTNGQXI5M1k5U3Vya2VOU09vTStV?=
 =?utf-8?B?OFRjbmxuOWRtakZ5Nk8wZHZFZHdUc0ZGZDRYbEpOZi9sQnFTQUI0eGZWNGkx?=
 =?utf-8?B?c0tXeHJyVU44dUJxOWhZR2xwd2xEdXhZUmlnMGpselBZMHQzZUtERzdSTGRS?=
 =?utf-8?B?eElNSVdvTzgwaVJlV3NxRUtocjR6cEsvOUZKOHE1Ny96Yk5jS1hqQTMzdXNu?=
 =?utf-8?B?QmZFZURuUjZkb0RrMW5LVTJuS0RieEFNVzlVbW1zZTA1eE51TWZ5UkorS1R6?=
 =?utf-8?B?OGZaYUl3SFQxdnhuc3pVMU5GSlVzc3Y2TzM0ZEJydDBuaUVrb3FqSTBiMHRW?=
 =?utf-8?B?YzJ2empyRTU3S05FTHpaL0hIU1BXZng5aFRNOWhZOWJIL0FCU1lraDBqZzJE?=
 =?utf-8?B?djJYbjM1eGdrZjFUaE5yRXM4MnhDMHlJclo1Y3d2VG5rb0RGVWY3ejFhYVA0?=
 =?utf-8?B?ZFZ2RWtpNnFmQnAvUGc4SlZJNlNvUXJ0SExOYVF2S0lremFTaENzOGI1VjVQ?=
 =?utf-8?B?d2EzTVg4cndRV1pVVGlsQ1BtMXNsYlE2STBId24wZVp5SjcyMkhkMGdoSUJQ?=
 =?utf-8?B?WXhaNEZyUVVoVkhIVDNNRm1naEw3L3dmN1ZDY1F6c0FlbkM4ckEzZ0c3QWJu?=
 =?utf-8?B?SDZDdjNabkJVSXptNjFyd0cvdy9zSUplWXZndVRJSFdiQ0JYamJKT1VWSTlp?=
 =?utf-8?B?WFpnRlRBL3UvZUQxeVhaS29NR2N5bG1IYVZKaDRzN2xWeTZKTUpqZlFJR2ht?=
 =?utf-8?B?S2dGTWFhUW4rRG9idmZKWmQwUmRiSEVxNGxZOXNBM1RKanZVY1FRb09WTFRE?=
 =?utf-8?B?N2V0b2VTeXpYWUpWU0UvNmNiVm1VUElxNklkc2VQY1lJWXl1MGdJWmRNZTcz?=
 =?utf-8?B?am9XeFpScEhoaDI3aFlFNURTamNhSi9BVFYrQW1VNDVrYlVjVTRGUjY3YXps?=
 =?utf-8?B?QVphbmdWU0RSVUs3UEtPOEExbUhlYURHVmN4NW1GZTdRRlpzTk9hejJyeU91?=
 =?utf-8?B?VHBGL1JSYWJDNXZuRkdhRFlPcDZNRnpmRFFwUUp4cnZSa085ZGM1a253RUNZ?=
 =?utf-8?B?eGZNRGUrNjViQVpyKzFISXg0Yno1dzh3dytCdmFveFVwM0JERHRIUDFMblF4?=
 =?utf-8?B?UW4ydjhOck9CbVJ6TERrdGkyYjJSbzc0RzA3aFVJUE5lZkVZYjhEdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f12c91cd-bbd4-48e5-55cd-08da13a36f45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 05:49:49.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suV+EuBEJobkgHRIe7QPEsmujsVCKrixwOU+YFESVINnc4rQrhXt7kbpYFi/laJZn1do+N6vvUw5jyE5rt6c0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/29 16:42, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, March 29, 2022 1:38 PM
>>
>> Some of the interfaces in the IOMMU core require that only a single
>> kernel device driver controls the device in the IOMMU group. The
>> existing method is to check the device count in the IOMMU group in
>> the interfaces. This is unreliable because any device added to the
>> IOMMU group later breaks this assumption without notifying the driver
>> using the interface. This adds iommu_group_singleton_lockdown() that
>> checks the requirement and locks down the IOMMU group with only single
>> device driver bound.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++++++------------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0c42ece25854..9fb8a5b4491e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -48,6 +48,7 @@ struct iommu_group {
>>   	struct list_head entry;
>>   	unsigned int owner_cnt;
>>   	void *owner;
>> +	bool singleton_lockdown;
>>   };
>>
>>   struct group_device {
>> @@ -968,15 +969,16 @@ void iommu_group_remove_device(struct device
>> *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_remove_device);
>>
>> -static int iommu_group_device_count(struct iommu_group *group)
>> +/* Callers should hold the group->mutex. */
>> +static bool iommu_group_singleton_lockdown(struct iommu_group *group)
>>   {
>> -	struct group_device *entry;
>> -	int ret = 0;
>> -
>> -	list_for_each_entry(entry, &group->devices, list)
>> -		ret++;
>> +	if (group->owner_cnt != 1 ||
>> +	    group->domain != group->default_domain ||
>> +	    group->owner)
>> +		return false;
> 
> Curious why there will be a case where group uses default_domain
> while still having a owner? I have the impression that owner is used
> for userspace DMA where a different domain is used.
> 
>> +	group->singleton_lockdown = true;
>>
>> -	return ret;
>> +	return true;
>>   }
> 
> btw I'm not sure whether this is what SVA requires. IIRC the problem with
> SVA is because PASID TLP prefix is not counted in PCI packet routing thus
> a DMA target address with PASID might be treated as P2P if the address
> falls into the MMIO BAR of other devices in the group. This is why the
> original code needs to strictly apply SVA in a group containing a single
> device, instead of a group attached by a single driver, unless we want to
> reserve those MMIO ranges in CPU VA space.
> 
> Jean can correct me if my memory is wrong.

I think so. I remember the major gap is PASID info is not used in the PCI's 
address based TLP routing mechanism. So P2P may happen if the address
happens to be device MMIO. Per the commit message from Jean. Even for 
singular groups, it's not an easy thing. So non-sigleton groups are not
considered so far.

"
IOMMU groups with more than one device aren't supported for SVA at the
moment. There may be P2P traffic between devices within a group, which
cannot be seen by an IOMMU (note that supporting PASID doesn't add any
form of isolation with regard to P2P). Supporting groups would require
calling bind() for all bound processes every time a device is added to a
group, to perform sanity checks (e.g. ensure that new devices support
PASIDs at least as big as those already allocated in the group). It also
means making sure that reserved ranges (IOMMU_RESV_*) of all devices are
carved out of processes. This is already tricky with single devices, but
becomes very difficult with groups. Since SVA-capable devices are expected
to be cleanly isolated, and since we don't have any way to test groups or
hot-plug, we only allow singular groups for now.
"

https://lore.kernel.org/kvm/20180511190641.23008-3-jean-philippe.brucker@arm.com/

-- 
Regards,
Yi Liu
