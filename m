Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416294F6ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiDFUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiDFUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:06:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5903BEDF31;
        Wed,  6 Apr 2022 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649267438; x=1680803438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X17Y4T8rB8Ztasx5yMthgbTjl9W6u1YVCq0voA7BqwQ=;
  b=D1xHeazfaSe9JN/FtujFkaH6OJjW/DMAVMpuVgaLhtZsY2OF0pyTprbF
   ZedE5Lj9gn3YreAiY1sf01Q/AquijCIGZSLmc4fsQsHz/sCs9nu267A7x
   MEM6mxHZszursbhDDhMCrdBCDmOW6ljSHbLIU+qzpqYevctZcEWWfrtTT
   KhSRsq5n5GbVGtvWXcDz+8qMcJZ5lHjvgalKGgilBqGl5cx4XnSH1KdkU
   6xpNSkGnwGuKctXgzqneOK3ACVQ4ecmSPK2SYQKnQzW01sZoTwkz1jAw2
   1xXmBafeDd13vQDcl2GIFQRpEk2i8TOYx6aoPgUdGcQpShMyhqJ1IVB9E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286089885"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="286089885"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="608994166"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2022 10:50:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 10:50:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 10:50:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 10:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw6wLsj7f1ldMuI9LgZwDUlZxvpxl+ZCdsmx9/RJqLL/XjajWWlNWnhKnWYfxAmlRo+1hsigbGNhD3Z7J7wdaqKGoIFW5SqWxrH1YnxE6oPvEQdStq2jhP4bPLydpTFtE2c2TnFWXHHxZfXWBNTBpC4pl+rtVh+v/FKUkqzGN+mRSJiAQ3qs2GLQNT0bHIkAUuTlDaBnGIwg2ao5/jbvb+aTnU7TUD/um46HrZ6FNksHsyvO0271btlnYDksIxhaudKt1lQc7gc62nnZnRCXjqqUWMawkeK3/y0779BVRpH5ISbJLBNBlrFwBTPWmkNi9CPF8Nl4w6kr4OaFjHeudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL+Z1XzG5LVMutrhQtaFMhmws1jlmVyV942mKQOdl40=;
 b=BGBOGaPFfAvVYveQxeAlhpM7L2jVLiKGNL7uhUyjn9rtjg8Z1LKpjnQfTBR01vHKEJKVr1ZjQBghvHAtnsxC1+k7wL1E4fvR70+iyPCs0ul9f3s5WyZUUdDX/nXy8oVHRtO9udaI8jwx0lZ34vHIEMNqB37JN+7Y0L3W+0J1OU/Cy/mMr3Z9sFHFEkurUncJQ1IdvMY5wB/ZjQV8rzv78ZaMw+W79j957t2jK3CvtzwSZTe4L9xmm2+zVQ4SEwmW9Wg4YH4BExGHnPB39+4s9SEDRiVMJupxJcXXQWjRsyjJbl7nz4/cuU26HcObMl6jdLym3DfVEvYNKyFCkSV+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4348.namprd11.prod.outlook.com (2603:10b6:5:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 17:50:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 17:50:28 +0000
Message-ID: <573970eb-f466-aad4-3808-fde5f3374e7c@intel.com>
Date:   Wed, 6 Apr 2022 10:50:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
 <Ykvrk4hYvBEnNOOl@kernel.org>
 <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
 <f8d92685-27dd-e7ef-ce0d-100a285aec4b@intel.com>
 <984834578beba18fa5b0196a0d9e4327dc22cf73.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <984834578beba18fa5b0196a0d9e4327dc22cf73.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff78001f-4643-4f67-a4b3-08da17f5efc2
X-MS-TrafficTypeDiagnostic: DM6PR11MB4348:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4348164AB1698180C699029AF8E79@DM6PR11MB4348.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECP9x6ZnKaIPe3F7LRkPGjxnEekyaYDtXK0TK/KNAphwc50OUQiVhbWWvpmpvMqEUgyFFLh11engM60xubCKd113w8GkSaUFMQ2R0CMDexQSm6prAIbnssrLl1UQh2YbW4DMMQK7G5SL0FqxKIvkgIDQKZcUG1XuTXrWAjXqZFIr6ELVbT1sM6h2RmIqkiKXoMdfzzh4Q/42AoCoZOxUxqRv3Iw4IYWcCNWK4EUjzKSObtg7+Czu1BHKwAK6EIwm//u4xTuqhyqaYGJ9sohNXp4BsbOy5gvmrTg1cdMxxo1yOcqpZGhT49pEkzyEwGOts2xVQ1yv6Td5+E2Dtr6btiLO3akhw8t3BZIa0/juI4gB16sTMxCbfTNtpsdFLnHsV6vI8qN6UlxXbX7Wsoy1GCkSakGe+6slVvONnAAI2DZHQG88holfp+0cSwgvx73opF/3PTVr0o23EuIJO+ayDymFp1MVNIDg+Sf73hg3JqXeYPyNM+GqYeZNnyOXkZAUQ3r1ZzZB6huTTL6NmDTF5Mp8vPa0Yy6DFArP6X7xmMxyeH0Adt+2gCTKswLww57fYtvs8KLdo6/39Sc2+J6kVwx83ddUt+LNE8h9QoByiunw5DilsRjJ17SDU5Hh6+tDqFeilaqNXk1Z4/yyEXW5CPZ1815XvlSjc4C8y6ayU3b+VGUZRru94zHFut2xYixUjw+jnZvUNUcv68cmp02zJKiv5g75H8o/fvArMlQM7p+pm5CjLnP2m2jhX+ICX+L/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(508600001)(316002)(31686004)(36756003)(6506007)(53546011)(6486002)(26005)(6636002)(110136005)(2616005)(7416002)(82960400001)(2906002)(31696002)(4326008)(66476007)(8676002)(83380400001)(66946007)(86362001)(44832011)(8936002)(38100700002)(6666004)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZGY0hEMUNzQ1ByR0d4MGQyenBYMllucTBVanZsS3AzOGY3ZC9rVkJFZTNX?=
 =?utf-8?B?dzlMbHlpcWNpazc5TUNkZkRBVGhpem5uYzRnczUzeXI0NFVIVnlKZnJTcmtm?=
 =?utf-8?B?a01LRFVENFZSLzNDYTFjdGc3ZEQyWERRUFd4Z2piMmhhTjQzT2NocFFJK2ZN?=
 =?utf-8?B?ckk5OUwwSnoxSittbGJuUGo1WkxMQVZ5TEZhckM5ZG9oRVBXcDhRcERVRUsw?=
 =?utf-8?B?UEQ0NkZVejdRWWcxOTVHKzRGWWlTcGsyd3hTWG1rNFdVd3phVVFOMVlsT1Vn?=
 =?utf-8?B?b2Y3dUVUZUJWWDNFUFVESTBPWEYzZ0tYSGVwcjNodzB1bEFOZmZ6SERGbHBB?=
 =?utf-8?B?NEdENFNldmQ5RU1DNWNIRTEvR1diazFleW80Z1EzZGw2eWFtWVZtaHN6U0hN?=
 =?utf-8?B?MGl0ZDhIUGlCZmZDTUc1akRJbHpzVFk5akFBcTg1Q2Uxb1N1amtwR2Z3TnR2?=
 =?utf-8?B?TXN5cWtSWGZHYmFzWXFMUnI4YitHMGlsM2ZlVjZXZ2F1SXF4TWRjR3NnNjNW?=
 =?utf-8?B?d3BOY29xUEpibys2MG82cER4dFdBb25uZTlUNHVwWXJta1ZNaUpMUmo1a0pm?=
 =?utf-8?B?YlhvZ21kcTZpR1ZCdzdQeHlOR3REcVNObnZlRG5OUTBwcjcxZ1dKTUpJb1RJ?=
 =?utf-8?B?cXY1aHBwWVp6MGQvMFN2UVFsbmxqRS9nNDRjZWE4eDZOVHRub2RmRFhhaHZo?=
 =?utf-8?B?aFQvVTNHdFlzVSsrVnhMV1MvN3hxZFRrS3liVDBjb09GYU52OElTeWw2bXVp?=
 =?utf-8?B?VzFjZ0NMOGhpWVNDc0dFckJuSmZXK21jMC9hdnk5QUxXUi9vSDhrWnhQQWdF?=
 =?utf-8?B?K3hFbWsvTXc5VXZ1QWpTUnFRWVd1Nk41WC9kT3hlUGZFQTBLTFc1Y2FvUVdk?=
 =?utf-8?B?K3V6SVBDZ3hQb1ZCSWF3TTBvbmZTOEhBOVlkTGkzUWtid0trU1JhM2s3WEcr?=
 =?utf-8?B?ejlLbEE4MzREaU5WTUtXOWl3ZG1zWGpaS0NzeW52ZUgrNFpSS3QzN2ZOZTNL?=
 =?utf-8?B?b3VZUVNvZGtDRnB1dGhjck5TbEV2djIvYzZSM3FJSHhaOG5PWU5uTzVDbUx2?=
 =?utf-8?B?Q2QvL1I2Ri9FcGVxelpsNEp6WE41MlpncERTOWh2eVVLNjdCRklUcVhsWEY2?=
 =?utf-8?B?cTZPTEdqNUpkZlVWKzJqZWhUN2NkR0FTOVNPV2dlYUptcDZoemhreDhCYmJG?=
 =?utf-8?B?UllNbngxQWJjd0JJZ2pTM0V5dFZKUmxMcnBQQ3NwRGF2bCtVdm9Vb0p6YkVq?=
 =?utf-8?B?aGNkMkRCSzVJaVVmZWtBdDRyQms2eTcyajZtcHU3U2NVTG9rc1BXTFR6YUlX?=
 =?utf-8?B?ZnJoREhjZllTYjRWckgzaHBKZU9BUGdPUlZzL2NMN2pDQkZRa21xSmExL0pz?=
 =?utf-8?B?QUNkWmV6YTg0dytSK21nYlBuTWxRZHEzZzlrRnQzSmdDL0FUS3lIbkdOZ29E?=
 =?utf-8?B?Kzd3YTUyVTFTVGo1bnBOdW1COUJiVnBwWVV3KytTZk1rUEZaSGUvTDNjdTFP?=
 =?utf-8?B?KzVGQU9aVmxZMlBzaHBFRnR4SU9FTjJmUFpaQ0IvaDBQQTY1eWpYS2lsU2Mz?=
 =?utf-8?B?VE8rdDg2ekNBaDBHa0dJTTByekVqU1NxNlExUzJsZjNQaDI3emM2bnpCMzN4?=
 =?utf-8?B?RkhWMVB4RVVXZ0ZJL04rYm5qUWZJaFhBZTFYWkJxQ1labG9yVE12aUk4UHNS?=
 =?utf-8?B?S2xvY01FdTlQRzV1V3dhTlNyMEFibUZiaHQ0WGJnbWVITmw1YVljNWU1a01N?=
 =?utf-8?B?V0JDdTh3bnRxTTNTRkR0aXpubTRsK3oxQVo5Vlcyb29jNktSTkVOdjM5YXpy?=
 =?utf-8?B?SS91QUVxeU9hRVNLSlRtTmkxVWxqd0lwcGlsMFd5R01SR2RHYjE2cTMwUVBq?=
 =?utf-8?B?U1ZUUS8vUTN1bnZ3cHBDQ0ZIa0ozTFNITFIyRXRSeWpPSjRvS3BIMmc2Q0Rm?=
 =?utf-8?B?Q1N4enRsL09INmovdmhhZVdhOWtjc3BCMWlSallKWFFESUMyQWdqNFRSVVR4?=
 =?utf-8?B?MWlIKytrcVN5ekVjYkdDR0NzdGpVNjR6Y1Q5bzRDZ25oREZ3TnlUTmFtY2gy?=
 =?utf-8?B?STVzNUhibElRamFxQkRNeEg1cnRTUjdFUVFXZFI4Wk1US3BISzlPRytXU01z?=
 =?utf-8?B?QkpWWVd1MGZ1amkwU2NSTytNbEdZcDE0RStZbkpJUXVtTzE0eVJYUUp4dkVW?=
 =?utf-8?B?SmtmQ2NwT1lwNVdQWCtudHgvNmJDbE15RER2a1lMZUttQXpxL2pvS3VKWWZx?=
 =?utf-8?B?QUh5Sy9aNHVTbnU3akJNNDQ3cll5d0p6elBsTTFBVUE5N1poYitiWWl5R2pV?=
 =?utf-8?B?UDJMbVRKcGpSTjZBQUUxcmIvM1NMS01ucHRHWTNTbkNDWVBBa2NOSFpNNWRt?=
 =?utf-8?Q?14dl51SgYNnN20qM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78001f-4643-4f67-a4b3-08da17f5efc2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 17:50:28.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L1w/kMnkHT1040Uv+P801E7Ty8iKKh2x04MFe1eOc+Zoku4B9b2RbuI0AOi+m/gCh1A0hJdSuVQQPLb/m+zUYJ6JaNybyUdoN63N6ps/FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 11:35 PM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 10:25 -0700, Dave Hansen wrote:
>> On 4/5/22 10:13, Reinette Chatre wrote:
>>>>> +void sgx_direct_reclaim(void)
>>>>> +{
>>>>> +       if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>>>> +               sgx_reclaim_pages();
>>>>> +}
>>>> Please, instead open code this to both locations - not enough redundancy
>>>> to be worth of new function. Causes only unnecessary cross-referencing
>>>> when maintaining. Otherwise, I agree with the idea.
>>>>
>>> hmmm, that means the heart of the reclaimer (sgx_reclaim_pages()) would be
>>> made available for direct use from everywhere in the driver. I will look into this.
>>
>> I like the change.  It's not about reducing code redundancy, it's about
>> *describing* what the code does.  Each location could have:
>>
>>         /* Enter direct SGX reclaim: */
>>         if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>                 sgx_reclaim_pages();
>>
>> Or, it could just be:
>>
>>         sgx_direct_reclaim();
>>
>> Which also provides a logical choke point to add comments, like:
>>
>> /*
>>  * sgx_direct_reclaim() should be called in locations where SGX
>>  * memory resources might be low and might be needed in order
>>  * to make forward progress.
>>  */
>> void sgx_direct_reclaim(void)
>> {
>>         ...
> 
> Maybe cutting hairs but could it be "sgx_reclaim_direct"? Rationale
> is easier grepping of reclaimer functions, e.g. when tracing.

Sure, will do.

This may not help grepping all reclaimer functions though since
the code is not consistent in this regard.

Reinette
