Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875744F50E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843997AbiDFBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572890AbiDERPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:15:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC5DB3;
        Tue,  5 Apr 2022 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649178827; x=1680714827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BABB2nwEfHikOLg3qLX9D0mY5/UGb1ZziOk8Z3YBFV8=;
  b=n9S4eRNw5X8Z1MuY51lOaNKM8kyPe9E6PVsTIsQSuL8mPBWPJyT/KkJg
   agiFJXsfo84+YszAanWFa+wpebHGk6mNkF9GQIgc+miDsXbLSLs41nWrO
   ISAb68M3ZkJ+ohTfmyAvK/bQdn/LfcBPxrp2MvEuVs9NOoH2WbmiExZ/Y
   z5GCW5NE54jLOy6xh2p4wQzqx6vWWFEumFL0rak+eRiBbBgX82/gJ9xU2
   A6mB1uLltmkEwp3hY0wyCfBxQgMbdSfu6NbOAapwdlEyLbF+nroRoxmeo
   /31QFL3wdbkQ3xerwlJ/fodOm/kYzFpiDlmmXXYt5mR0GkTpbriGpgz3j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240744152"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240744152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="641693084"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 10:13:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:13:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:13:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 10:13:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 10:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvSFWFhUAaxPEOm8OXyRmCN6Qo/7/pxoVJV6r15uHavpkfMuIZO+Wk+eJgfvmRUdM8lpJIcVp6PwqYb9nt7Xgr3h6MkSaRQNe6ZI6OMSAppgzwNLzF1vUOYjvEVYOfEsoohi67F8DmSsLwGdBeNg8JmKpO7vCeTqYrd/TJmV94Pg2ci67l0uXNTZS4ut7eXDcv2yvuow6PvxKI190WbhYqK52Q3MHLp5pTNBe6Xs7B7DQsifArbprKPkHolfeUuDBK865k7TCFoxPcP+/PEoV0QBFJjJDKDnFWXsXij6Is4KG9evUZTcoxRbsNrMKHezTJrkpQ7b4Q6oO9xrd1fyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsmVYPpbLg0AyipjGNo80AZpuke8olblRlAWoz94HiA=;
 b=gFEdo1MmBON0pDkYmzri+XxFcCp+wVPeJ9s8hyjecKuMcLwsZ2d4OePJXikutu6i7SvBu8qnKmKnNmT4cHjT2S0m4y7xCtPArvsX7FmXK+Ou7nANdyxmiagWr0LvFJawWH4uKdirit/y4CZ9t1EOxxFCqQAkUnEYwN4UUsVCqCnHwzICiayRc+NoK+hAWJ1rFOSbWuelzW6h4zHopR1b41NsjiW0hxlzWPd7twYcXX4Mwgo5/dALNADH9CPFyh8FsQ6hMhET7xISBAGKAhP2/dzSMT8nn1O1d3Xpv/fyi6eQ7jdTdPOFCpY+WXq9Qt51+UpK6CXSDOulehl0AvemRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2289.namprd11.prod.outlook.com (2603:10b6:405:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:13:40 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:13:40 +0000
Message-ID: <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
Date:   Tue, 5 Apr 2022 10:13:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Ykvrk4hYvBEnNOOl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1ded85-a87f-46ea-c0be-08da1727a10c
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2289:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB228958F918778DC28B310480F8E49@BN6PR1101MB2289.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: julCTSKJ7MMsMmnZJMqr7pzgEZZe/FKRQ/5/mph9Gap9HlP9NW6+b1/o5kqicOf/x6tZhn3V+MCS+SbwpzB6qYAANKTbJ9HChqQ9M9Qulpxk3ksQVsNDube1y2E4vpju1Vea/8+JdL9xAGMcbaHVZ34m/SvhHsx1fPUSIXa+rsKA9I0Nc+CtPCzioqXiANv3RZ5Oa0CcQRiJntWN55oGbfdbz93R/rcYFbGAQOZZUacFVPD7/9ybXsyZUEkJfbsnaR04StqozaEp0zJ0cTbPKB8nr+tvcXjy/VnzgmVO1uvjN3K/IQ7zT5Hwe4PHIiw5NgfOmEycPMfyqNeLwbDginhxkKHw8WgEstlnK6VZuIhGdaDaBJhYritXg3j5Q/iHa3tk8kO06kxvND/E4I3AmG9L4P2jJVHlM8Mj/sLY6a1me0AwpA3ZDf5SNyss0GDyz/qPD4uh4DzjtQ8kmqlU1DQveF1leCB2a7F0ug2n0c/hc+3h8weFAB8kPiehooYrh8teuf8iHkiigUtmE6UKdnoxDVmcSn57DRv44XqeDpEQblICqUt3T0Dj90LunaRJFTpn9deTXKW+jZkTzL6qF+egvwOPe5oWjLi1LIyuspicFjag9ljzUOE3SphaFbB1bU5wedZ5P5cJAjMMTK/b/7bUkL9G88AD0mqFrVCFRyJ67RmlReonDUbyJQ5tvDzZ8E+G8Ifi9RCSYiSM2d8Zh8W3E5vSoMlKvNZOIrDXi7dUf23YLkhc+egmNYkWJyLs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(38100700002)(44832011)(66946007)(66556008)(8936002)(4326008)(2906002)(86362001)(66476007)(7416002)(5660300002)(82960400001)(6666004)(31696002)(83380400001)(508600001)(2616005)(26005)(36756003)(186003)(316002)(6916009)(6506007)(6486002)(6512007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpjblNoYU9Ta1NEcVZvQW5heFZqQUtncE5HZmNFV0FWWkEyUFdLOU04NnJa?=
 =?utf-8?B?MFJGek1scGhEV1gzNWMvUkFWYi9uMHFpSmJaaW0wbk1RWlcxQk9LbnNqaUd5?=
 =?utf-8?B?cTJFWW1pd21Tb3RwUWc1ZU92VkhlQmp3dERzK0lvUXpERnl0a0pkZFRPR0lW?=
 =?utf-8?B?UGNoQmx5ZHE3WDN6NGI1UnA5MnB4L3Jmc2FjUnMwUlhTanRMTXdzOVIrTHRW?=
 =?utf-8?B?SVBuekppNXNXV1hWU0haZjlLdVBqTkQxd3lBWUxrVlAxZkJUTHArMTJSZzVi?=
 =?utf-8?B?S1hHZXNOQkZ0REtpR3ZHZWdvR3lQRVR6d0lnaVdsQUZVMkFGbG1US01YTTJV?=
 =?utf-8?B?RzFWSXVSMDg3MWU1SGpUSlZ1UEl0YkFVVUZOQWEvSDJUWjRoTHNKb3F3SW5F?=
 =?utf-8?B?WkM3VHBnNXo2c3U5Zkh3YlJMbWVpNkdrd2JuV251WitTYWhlT3BoTG5tQmZW?=
 =?utf-8?B?OG54TWMzMG11Wk5lOFR2bVAzRGJGYTRNWXlHT2JhV2lpT0g5K2RNTGRkWlc3?=
 =?utf-8?B?UW4xMndvRlgxREU4ZmdmalhmeVdVeDdpc3RRbUlIVXlIY29Oejh5UFZDanc0?=
 =?utf-8?B?S2pocGlxRlFwcTVFWDFHU2I4bG82bDA0cmpWakRlYUluTDNBZVhhZndHZzUx?=
 =?utf-8?B?WWxQMTZXMnEyOWtqWVV0ZEFDNmNBNld0dlFaQ1dPN0tXK2NKaWVwT2tnREtK?=
 =?utf-8?B?cWpsdTNWTjNMUGZYV2pNL29ZOUpFbVdQZUFZbG9FSnpuQ0Ftam1mN2M3THA4?=
 =?utf-8?B?Q3d6TWxRczJjYkNEazU5My94a1dmaU1IQ2hMVVd4ektWbnZjUXU4dkcrbkRr?=
 =?utf-8?B?WEIvU1dTdW5oYndqRnNRa2ZUUzMvSUJLV0pLSzNXNDBYTWo3VlpmQ2dEMlU1?=
 =?utf-8?B?Ti9pN00wMEl6UnVndmVZdGF2d0pFSERDVlN5SEZQeDRySkFXN1djZHZMOVpC?=
 =?utf-8?B?Q1BtNklyN25IOFpWdWxJL2tKNENocjNSNkhBdTR2aDgxRmNwMG15MUN3Q3p5?=
 =?utf-8?B?UnQvOHFFVXVKemRIMzhrM2llYlJBdDNMbE9lUDVTSkQ0MEZNNC9lSVlzVytT?=
 =?utf-8?B?YzMxbENxTGNTMVpKdXBWYktpM0xwSjlQanA4TDdSck5TdkRyTUtyUnErN2tk?=
 =?utf-8?B?WGJJUGJudzF2WFNKM1VTNVF0cDhTQ2U1eFNpREFZeEtqbElLM295NUJNa2ZS?=
 =?utf-8?B?MW5uMHpzVjNDd1FZalNVQWtEYk9tNUYvTG9hNVV1MUZacVo1Ums0SjJDdkIr?=
 =?utf-8?B?ckx6eEFySjEwNVBKNHFmd0lJMFpYQnlFRGVVVldpcnd4UkVocWNrbXFaZFlp?=
 =?utf-8?B?dmNnNVBjRnp5ODRGVlBDL2lsL3FwS1YxVjFWdzlXTGFyZU1FZ3JOZ0lQNnZD?=
 =?utf-8?B?aHRhTkFzcTZUaXFCVXhHZWE4SUsxL0U5ZFpMSEpJUnJYZnQrc1RUNktKak8v?=
 =?utf-8?B?Z1F0K2QvS2p1Wm0vVkpJVEpldlNLZmJ0Z2pIY0Y1cWxyL0lnd2kvMks1YnA2?=
 =?utf-8?B?RGJ3d2RLOW53emRJckpRaVI3YkJ1aHJicExvc0tnTWJIRm1ubUk0SGtrRFhq?=
 =?utf-8?B?RDNFcldReDAwODFXU3ZjeEpLcVNNQW5PRHBGd2ZKZHA0MEI1M1JWdkEzNzh6?=
 =?utf-8?B?d2F6Y3N5dHJKaGRyb3NTWTVrK3ExQUtxUGRML3NvR3h2S3ZLcmJLd0ZiSWpL?=
 =?utf-8?B?MWlrL0NmRlRQMnBXTjZKeVZyZXlIWkI4UUpabHJ4ODVKUTUzekd6SDZDaXpr?=
 =?utf-8?B?S2dhbjk3RWNmVHplWmt0VE5zYnlWRkdSTTB5aVZYU0syYWdjODRzQUx1ZXVE?=
 =?utf-8?B?aWpDUWhTbVQxbDlGN1FVTlVRWWpBQThkbWxpU3ZaUFZRMlZmeXFLU2lkUThR?=
 =?utf-8?B?YVQ2VXlLa2RlYUh0MzBCSmpabjJRM2NxK2dJNHZGMWVCWkRGc0hZczFZVG1X?=
 =?utf-8?B?MmZUT01iR0lwTys4akI4Z1g3QXpHb0lLUHFmQTR0ZjNQbk9ZMDR3RXpXZ1c4?=
 =?utf-8?B?a3Q2dXNRVVFMeTlxVHZVK3BrNDRHWHVvRGQ4U1F1eWVnc2hFVGNEWC9RdjNw?=
 =?utf-8?B?RmV0ZWZjWUQzelR0R2FqU09zU1V3NXlZK245VmtqNkJHWFNGSnhCamNpVm9U?=
 =?utf-8?B?Vmd1QUZjamJFZHZGM0hpVHNTSFM3UnlienJvblVnRWp6V3g5c3VicTFaY3JE?=
 =?utf-8?B?dzJJOU1pSkVBMFhPTTZqMzV6QVZGQzBSSmZNQWxzemkwRkk2T3A1YTYrMjV5?=
 =?utf-8?B?aGNLSjdJNzFiSWJTU3hhUnp0TUY1Q05hZnR6VlA1aUJiRFBMOXI4SEpac05C?=
 =?utf-8?B?cmhjdU1sWHZOS3lSWm4wbGU2UTJ0UUVGVTc1dGdlS3JHcmtxUGw5RHJhUUcy?=
 =?utf-8?Q?oHrwFUt1xOSF7gOY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1ded85-a87f-46ea-c0be-08da1727a10c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:13:40.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSyP1QXEtoDvfU4vOQeQGioHb4JMWUYZ5u0ob79ycHQNEpkR9WZqDkEf03QwXt6vSD3wOy0ioEHx99lYsxPfZOHnzXRggeUCTC2NVCeSDmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 12:11 AM, Jarkko Sakkinen wrote:
> On Mon, Apr 04, 2022 at 09:49:27AM -0700, Reinette Chatre wrote:
>> The page reclaimer ensures availability of EPC pages across all
>> enclaves. In support of this it runs independently from the
>> individual enclaves in order to take locks from the different
>> enclaves as it writes pages to swap.
>>
>> When needing to load a page from swap an EPC page needs to be
>> available for its contents to be loaded into. Loading an existing
>> enclave page from swap does not reclaim EPC pages directly if
>> none are available, instead the reclaimer is woken when the
>> available EPC pages are found to be below a watermark.
>>
>> When iterating over a large number of pages in an oversubscribed
>> environment there is a race between the reclaimer woken up and
>> EPC pages reclaimed fast enough for the page operations to proceed.
>>
>> Ensure there are EPC pages available before attempting to load
>> a page that may potentially be pulled from swap into an available
>> EPC page.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> No changes since V2
>>
>> Changes since v1:
>> - Reword commit message.
>>
>>  arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
>>  arch/x86/kernel/cpu/sgx/main.c  | 6 ++++++
>>  arch/x86/kernel/cpu/sgx/sgx.h   | 1 +
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 515e1961cc02..f88bc1236276 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -777,6 +777,8 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
>>  	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
>>  		addr = encl->base + modp->offset + c;
>>  
>> +		sgx_direct_reclaim();
>> +
>>  		mutex_lock(&encl->lock);
>>  
>>  		entry = sgx_encl_load_page(encl, addr);
>> @@ -934,6 +936,8 @@ static long sgx_enclave_modify_type(struct sgx_encl *encl,
>>  	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
>>  		addr = encl->base + modt->offset + c;
>>  
>> +		sgx_direct_reclaim();
>> +
>>  		mutex_lock(&encl->lock);
>>  
>>  		entry = sgx_encl_load_page(encl, addr);
>> @@ -1129,6 +1133,8 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
>>  	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
>>  		addr = encl->base + params->offset + c;
>>  
>> +		sgx_direct_reclaim();
>> +
>>  		mutex_lock(&encl->lock);
>>  
>>  		entry = sgx_encl_load_page(encl, addr);
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>> index 6e2cb7564080..545da16bb3ea 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -370,6 +370,12 @@ static bool sgx_should_reclaim(unsigned long watermark)
>>  	       !list_empty(&sgx_active_page_list);
>>  }
>>  
>> +void sgx_direct_reclaim(void)
>> +{
>> +	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> +		sgx_reclaim_pages();
>> +}
> 
> Please, instead open code this to both locations - not enough redundancy
> to be worth of new function. Causes only unnecessary cross-referencing
> when maintaining. Otherwise, I agree with the idea.
> 

hmmm, that means the heart of the reclaimer (sgx_reclaim_pages()) would be
made available for direct use from everywhere in the driver. I will look into this.

Reinette

