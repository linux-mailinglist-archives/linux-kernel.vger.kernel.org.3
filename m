Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE76598062
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiHRIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiHRIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:55:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161450052
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660812917; x=1692348917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYSbVa4cUdvIJQ56hr36n4Ipls4mJkPlSxPi1SH5vVs=;
  b=XjYbR7wYs467vnsRmGyJM8K+3YXJ/1U+I4edZzKLDPvxrKsIy0hAoy7W
   cUnklzb9MPgF1REfVQboor79s1J8V+pAsBztSIQycUSp0LBbNZSrEGFwk
   AupcXaVR240TSiN5MK8GXUzNlsMeUw5cCu8dmyqx3XhJwuzlAmn1zBNq6
   P+aSRGj2URCLc8+NVz08dg1bF3zs4OHRVW2pBz4uiCWQD2WbZBAoNhWWI
   hpeP74lAbfdUJ072LPU/VRw07iFZgnuu+MPb9cjudxb+TeZyXsQTAPvJa
   Sx83xu95+IJd2/nRINLTjS5JsaZzDv2UkNkBp97Y7qqYnH+9xJN63PWWo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356699269"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="356699269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 01:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584128025"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 01:54:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 01:54:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 01:54:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 01:54:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 01:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1InfZEKqcc9PMt8Ffb7A6oMrQs8ew10Ek/rfw7E4bwRVxYN3qFLXG0G+iCNafOFfzWtH9UriIvR0YLHs0FThxYqja39QiWwm1M2XvfKHCQCZkvF8pwtwifc3EgIp78MA5PnALwaqDUrr9D8Ywga3iuHHq6bDNhYnpAnzz9C11cAzj+cMC7QgsWVPCy8ZWmL7cBFJuGqRg1QM7XUZXIwhTckDAekMh0HHCj+1CqunUl3iaQFBZHtREfZ0GCvtRu3epGiZtQcPzf922HszRuvyoS+6C74rf43vBs0B88RSinajFbnXsrfTrzI7FMhzMwOckyiwoZTw+PLVtm0GVqlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84L+BwbO2YbELs4p5V0gdacFh5v4ScqjR2eBaWlglXE=;
 b=i3AEC7pLmI9OtT0fyPGUMNhh4x9PlgAkv6xQN5qjaAQzlbPbdjJStS1OdnVnUxEFcUuMyUstVJJWQd2tmgNzwoRyXMh1b1tLqozN/WsLLsz/XluYMmwjE82yhNCf2592JSyug9NTDiLvp6ecxenDRWCtCft6XxGqaK8+ZIHPS7FORf2nhPD9KY/xYNVGmTfjuA6EcxIW9TucAHR34agL8cfRLNsZDDN2ViRkRAhTSYGYezN6Mp/wz/ekNxIEAH+Fs68p0HV7haS4Hk20GeB1J4KpvDRPM/2XwiLhGdjcok1yGd5L4eD6bOuxcmue+fVpQkeItH96zL0durzO8TAa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH2PR11MB4407.namprd11.prod.outlook.com (2603:10b6:610:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 08:54:56 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 08:54:55 +0000
Message-ID: <7408156a-f708-5e73-d0a2-69b1acca9b96@intel.com>
Date:   Thu, 18 Aug 2022 16:54:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Muchun Song" <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
 <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
 <931536E2-3948-40AB-88A7-E36F67954AAA@linux.dev>
 <7be98c64-88a1-3bee-7f92-67bb1f4f495b@huawei.com>
 <3B1463C2-9DC4-43D0-93EC-2D2334A20502@linux.dev>
 <7fa5b2b2-dcef-f264-7932-c4fdbb9619d0@intel.com>
 <C6F3DC27-4819-43A4-B884-DD3D03A2DF90@linux.dev>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <C6F3DC27-4819-43A4-B884-DD3D03A2DF90@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b75ad0e-6591-4a12-5ad4-08da80f7526b
X-MS-TrafficTypeDiagnostic: CH2PR11MB4407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y2qHbkvB7XfXUchDvVnM/jkIKknNjCGsk4BsMUIj8AEYymQ40Oplj3PA0ZTKRqATc3L0r3yDu5PTHjcbulizMZlsBmYYFqHdxy73tpxQoxMjvKQiEkP59rGjXY5M5L15DAbqArABkREp/f8DFdQRlVKtfK7QU7IoAlW0169djHtuX/ya2yo+/WfoVqMuFFgy4NXtNS9AG1zSCI626QLF1wZp291W04T/KTOaBxmeMhd5ITLabsIQ2R4FgmfKeKnPwW1Wdt8vLEjTCqznh+3arKvl5wmXGySB9KgCG2SwsjtpEHy1qPs1/X4b4Zi1xefyYlG2v/WVEt0Z1Gb0Qn0exf6W06dC1XmR5E/OQY4joinfLiTsNyyoXSdeqDbwPJOUWDgXGbLkRqzB3gTjqRdaUx9byDeF+wTrq2Bk1H2RJf/slUf+qS5QzHRMwhcuAHwDUnMF+ANPBgG8/GztNtqKOdb01DXy4Uk/Q6uIw7Qs/sZaANkMcb+U2j8wHUGQ2li4esw3A3W8bSO/0F44odnPiaNWGozSAzpreJND1ENQ/wupLt0gAcOq2bzmRE2XKaVhGHimkZzlvTz54J+d5ywgteopCtW+mE/4xE1w7mE5NOdE1Azv+LlCBePsbNz0of7d8St8E86WriTK3kMpF5hMpYAXFmypx/+LMbFqLwnamvRjZJRzBEHTgfGIPcuSWSfN3XOVQzQ7OSOod5InPiMlvr/N54jimyDVi+JSds4cQWW4Gr0M08+OD12s+Vw9Voz1yvTLAWYb0dmRC6mNEPeVmfN45EP6uFh8ka+U6a+wlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(366004)(136003)(376002)(6666004)(2906002)(41300700001)(53546011)(6506007)(31686004)(54906003)(38100700002)(36756003)(5660300002)(6916009)(186003)(8936002)(316002)(4326008)(26005)(83380400001)(478600001)(66476007)(6486002)(31696002)(6512007)(66556008)(66946007)(86362001)(82960400001)(2616005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJpOUFNK3Bpc2JlNXVsTEFiYkp4bnpyTVQ3TzlMYkRneTJrODhtaVNBc2tF?=
 =?utf-8?B?NWlLNDJQN3oxbkluYitxbjRtYnFwTkhlWjBUcE1nRXhWN2lhUnBSZmZqM29M?=
 =?utf-8?B?aXlVd2lBLzNyWnR2R0JYbjA0T3VQNnlDV3FWbkxIeUdWelR2dDYremNkanZt?=
 =?utf-8?B?VDhpNmxhREZxQTdWRVhsdWNmWjBDMlh5dUV5SEhPcnFzcUtUQmFTYjVqRWVk?=
 =?utf-8?B?Vk11eUM5OWswVHlTUWZpVXVSdk4zWkVWQzFhdVJyLzJhQUZZSW82bHRhbGtW?=
 =?utf-8?B?QS9vWTZUR3pHM1JTbHkzTytqL1FkTGFtSUExRHdMTTFUVDY3aHZjYzJkT2dW?=
 =?utf-8?B?OEx0cnR4clE3Q3FLKytyUkpPSW5ZTDEwb0gwd2ErazJvbEIwcDhSdkREU0ZY?=
 =?utf-8?B?VXgvenplNFpPQzYyemc1TXRsSVBEZHg1RkVBOXZCemcvNGdMeGJoc3dmS2RE?=
 =?utf-8?B?MEk2dXlRWGxuTzBTbXZCZmVqV3Z4RUFVK1NSa1RWZUI1NTR3VGhyWHNxd2V2?=
 =?utf-8?B?U2JDQU41KzM4UXNCWnZOaURMVjg2K1I4VmRpNW04blg1SlhIcTZKZWpCNElR?=
 =?utf-8?B?OUIvb0s3MlVjTVBDK2tuSEY2aHBjdjdPZmVvSGZNR3pqTFpwK0ZOSHZ1WjlX?=
 =?utf-8?B?YnZxYkVqQVVDWS9xL0JUZmpnZUV4eldCelZqT0YyTnlpRE8ra09mQ1JBb25s?=
 =?utf-8?B?dS9ESXArWFhGWHdteEVkdEdXVTBKMVAxRVF2ZHNHNkg4UzFQMEhqYXJZRW5j?=
 =?utf-8?B?b01UeGJWay9mWFVGN0VrR3ZYK05UR2o0VDRYVFV3bGVkc1V5aWFNWGNROUE1?=
 =?utf-8?B?OGVFS21PZGN4YmpKSUlXQ1FGV2dpNUdxb09oRlBYeWRXTDNIU3hPS1NXN3hE?=
 =?utf-8?B?TW8wUDdxTWdES2pDZEpKVURYaE41WVprSTVkMWpsUkhoNGg4dmtCWUUrcEQ4?=
 =?utf-8?B?M0pLNlNSSkI5R2YxTmFEUDdEdlduMVhZbWVTazUycklkSWk4QUt4dVlmenNI?=
 =?utf-8?B?RTI5a3BPMVlXTlFIRVBXZnZVckJjYjd6TWgyVEdjTmdMSWF3QXJxT2NpcEZS?=
 =?utf-8?B?aWgyM2VnUVpUcXhqaVZxMCthOUFWK05aUmpQTTlsS0VlWG1oa056OENLaWRM?=
 =?utf-8?B?SllTRTJUSUoxeG5tdW5MeU9mUS9PK1pSYlJvVUJ0bUszZnFNSVBIc0hWYmQ5?=
 =?utf-8?B?WDk5emIwOXFXdXFMTHBnN0lEb2RtREw4anVHU3pwQ09oSjVnblZaSEdrRGt4?=
 =?utf-8?B?aHovd3pvRVkwTHJGZUpYUFFpLzgrSlUybElRY2Q3Yk96eHdIKy9JMlYxd0l3?=
 =?utf-8?B?NGp5cGpXK1VJcjdQTkNIQjVHQWhYbHRONWJKdzlsOHJFRmNublFsdjFhK0po?=
 =?utf-8?B?aDdyMjlTUGM3OVlqOEZOazQ4aCszTW5uTkNudCtIekFEU2dNQUVlVzlTVVhC?=
 =?utf-8?B?TzJSVWhyKzVyUUUvWUFpYzJHWlZjb1FWN1RJVm5IQkh6UDlYUGlXWmNMVmRy?=
 =?utf-8?B?QnMwcTZlRkx1aG5nTk1MN3NKcyt1OXJ2MnY2S3Viekg5VWI0ZlloVjI0RXh3?=
 =?utf-8?B?TjhuQ3dDT2s1aUtEYVVaYTRMRk1OWlVmVHhqMUFLTm5CQkg0Kzl3S3dVdkhO?=
 =?utf-8?B?TDluZ1U5elFnekoxRDlQaitxQ2dDc0pLblN5YVQyRmVnenNuZ1lwK1djc3d6?=
 =?utf-8?B?TWNoVnFubzNsQWVRTzhPWmlNUnFGbXQyNkJ0TW1oTDh6Q3VTSFVjVjVsQTVN?=
 =?utf-8?B?NUtaVy9XOWN5YmVjTFpuTVdlaHY3UGZGT2lFTCtFTGxpN2EvTDFEaHdyMXRK?=
 =?utf-8?B?MnBxWTZmQmtYNGY5NEJTNVdKeFNnSDM1Zm44QjVtbWhuZWxaZ2ttSVAxNHEv?=
 =?utf-8?B?czQzQ1NrNUJ5dVZzSXdsMGJLdmx1MFVXdzZWSU50RDVpNi9wOUdhZGx4VEZE?=
 =?utf-8?B?Y1FrdXZ0eTNEL1ZiNWQxWFlGMTFKdTFJN0xXMVlKc3ZwWlczK2dYbElzTnVu?=
 =?utf-8?B?N0tFV0ZaaG0yUE81eEhWWVdDZTBGWjArNGlOcFRxNEJpR0RhZGVPbGFlSjZU?=
 =?utf-8?B?bnNBaTZ6YkcyREljL1VFU29oZU92blk4ajI1Y0tGc1RMRWl6T0pzMEJnWWht?=
 =?utf-8?Q?IbfQewq01mYB7UBGHvIT+ihvT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b75ad0e-6591-4a12-5ad4-08da80f7526b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 08:54:55.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUaAxDN0PXBG01pM2pRiNo5hxXbdCu6/BFfqaXMhenx8hL1JP/bLWFw7w4GAgJgpvASLK7qmriLsz7XqgHF5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 4:40 PM, Muchun Song wrote:
> 
> 
>> On Aug 18, 2022, at 16:32, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/18/2022 3:59 PM, Muchun Song wrote:
>>>
>>>
>>>> On Aug 18, 2022, at 15:52, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> On 2022/8/18 10:47, Muchun Song wrote:
>>>>>
>>>>>
>>>>>> On Aug 18, 2022, at 10:00, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>>>>>>>> 	/*
>>>>>>>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>>>>>>>> 	 * preceding stores to the page contents become visible before
>>>>>>>>>> 	 * the set_pte_at() write.
>>>>>>>>>> 	 */
>>>>>>>>>> 	__SetPageUptodate(page);
>>>>>>>>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>>>>>>>>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>>>>>>>>> can tell us more details.
>>>>>>>>>
>>>>>>>>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>>>>>>>>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>>>>>>>>> to make sure the order between the page’s contents and subsequent memory
>>>>>>>>> accesses using the corresponding virtual address, do you agree with this?
>>>>>>>> This is my understanding also. Thanks.
>>>>>>> That's also my understanding. Thanks both.
>>>>>> I have an unclear thing (not related with this patch directly): Who is response
>>>>>> for the read barrier in the read side in this case?
>>>>>>
>>>>>> For SetPageUptodate, there are paring write/read memory barrier.
>>>>>>
>>>>>
>>>>> I have the same question. So I think the example proposed by Miaohe is a little
>>>>> difference from the case (hugetlb_vmemmap) here.
>>>>
>>>> Per my understanding, memory barrier in PageUptodate() is needed because user might access the
>>>> page contents using page_address() (corresponding pagetable entry already exists) soon. But for
>>>> the above proposed case, if user wants to access the page contents, the corresponding pagetable
>>>> should be visible first or the page contents can't be accessed. So there should be a data dependency
>>>> acting as memory barrier between pagetable entry is loaded and page contents is accessed.
>>>> Or am I miss something?
>>>
>>> Yep, it is a data dependency. The difference between hugetlb_vmemmap and PageUptodate() is that
>>> the page table (a pointer to the mapped page frame) is loaded by MMU while PageUptodate() is
>>> loaded by CPU. Seems like the data dependency should be inserted between the MMU access and the CPU
>>> access. Maybe it is hardware’s guarantee?
>> I just found the comment in pmd_install() explained why most arch has no read
> 
> I think pmd_install() is a little different as well. We should make sure the
> page table walker (like GUP) see the correct PTE entry after they see the pmd
> entry.

The difference I can see is that pmd/pte thing has both hardware page walker and
software page walker (like GUP) as read side. While the case here only has hardware
page walker as read side. But I suppose the memory barrier requirement still apply
here.

Maybe we could do a test: add large delay between reset_struct_page() and set_pte_at?

Regards
Yin, Fengwei 

> 
>> side memory barrier except alpha which has read side memory barrier.
> 
> Right. Only alpha has data dependency barrier.
> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>> Thanks,
>>>> Miaohe Lin
> 
