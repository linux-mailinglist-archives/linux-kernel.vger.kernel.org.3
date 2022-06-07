Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FFE5402C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbiFGPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiFGPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:51:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3186F33A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654617106; x=1686153106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZhvGnesICWqZHa52EHouZeeUBCNU98MRC3TbgEN9Buo=;
  b=J8iA8McIW5M8CR3Uhi50bzK59FK36xGGfiuSDZkPEoqqpNoKiPuqaeWh
   05kLK2rkuFOAX64wc8BswZeHk3qLO5Dd4PT4prWg9sItTFEpXP62UpZOR
   pXLhD7vSvrHxQeOj39WTZHWcd/K5jMMNy5hQromNenLDPI4Vp3Cy/6NBi
   vJfqWHjeFdvyTWIV6WMB7mXGYt40pHu7mtF45zvv9RC2i/ABvWSV2bz/R
   0kEYk/foJiDxLi8re43wdPeHf+7sEi+1fG1gJqq+lrzSHOFV0//4RrS68
   pLq95jcTW0YfFXDTQ12okZtnR3JQki2uKKzgeEdEGwHh9b+uI7FXhgSOR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256563381"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="256563381"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="565484938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2022 08:51:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 08:51:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 08:51:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 08:51:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 08:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsGd1At8aqt5DTwZ2Gm284jXxEl7wiG6+sl4bpJX3JpMnciJBQ9EjHt3XZlBjbOXBrA9FngfaxpTX2+frcAIZm2TdR7M6ewqy7ZUnPto0NoOda+f2OlS3yHJsL+s2GCJ2U5k+vsmWnEDpeDi9UJaume+OW50xPRUQSKJvS3SpncxaBpw2i3PsUYGVif0XDS3iiUqMNB65h8jyc/ZwlfEqcfdx52U9Nc3G6Bp7K09x3UVX8G4U7tdVmPENFUyo7D10NQ02mPCkeqs4F2Yz8YYRdTixA3EWJTJ9OD9g4G21C0VRfz8NQPYBseIl1J9lfa/MQcdIv8LkuQyh/umR7xIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwCs8v8/LiWqW9qbuC5bvA3Qz88/JYfikepAn0ozmyQ=;
 b=ffYwlPlr2CZQrDgV53zykkMB80WOykXrdyskxsMGf/A9cxjgwrmCSvb9vNYRbr/4dSJ+CmGwDyii20Hl0DVsbDpStHQuh1PYnn4w3J02B/b9MlUrEgB91GtaWgr43CXNsbDmfQjxbY0VMXbX7eFAitYTAgucMx3ZuQ+MYOjQr6WunwMYbPWHcBSu1bBuwvqitVwpkQn+GjK+sIulUvvPRhRHto+XeyQcnbml4ykHLGtHLJrp9a0BtiF2k9UDetnBoDB6/YJLpTzQPhCvvBDnf5btnjW8MGuWMAFbDDpbQk4XN1akaZP3tLXoOUxEH7Vc2wUdLXjsa0TOfEkADJLAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 15:51:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 15:51:42 +0000
Message-ID: <e07c8739-5c8a-8fe9-039c-3a08ce873026@intel.com>
Date:   Tue, 7 Jun 2022 08:51:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v4 15/21] x86/resctrl: Abstract __rmid_read()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-16-james.morse@arm.com>
 <39264d40-265e-b41f-913f-c21325678735@intel.com>
 <63845ed3-f09e-43b2-5ded-394bbbd874c4@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <63845ed3-f09e-43b2-5ded-394bbbd874c4@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 078380fd-75f9-4e36-a49c-08da489d9ddf
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5118:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5118041CDD35213E90293BBAF8A59@SJ0PR11MB5118.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrWSzRl6czrs/cPc0oqA+FJ1mMvHXU3pfIEPVBsKDSu6+nY4y9lNEYUbRKVncpW0OetY/GPywYzASFLS05Gak+lulg3EQ+7oQsftm+hXM2/+JDzjObsplW7BIs3Fk2lhncXQQZKmEmxyOYH1p5uXyEncMfiwCKFhbhdQdWPAho6aY0YxzSQnkVGz/tRJFMbaeb3PPlj5LCn8ViBSAA2RdkEqZ1/dCEmO30V5sCVupRWLkltIIN/I9iLAIZgmHGETCmS6r9Fpa+ANt5Ajv33JDIy/oEgykTvq6DLw/JaxvytYCUdXzAKAyANEieujeklYH0+HBMynP5fulyuwUF1BxDVoolxdADY1CIjKtrCpasrPTvg4cCYkaVdfECBJFPMe8N8+JbqsXc/og87V30fEXnZMdAKnbxqplhc9Y8I8j1tgnYjYm6Z+YVQw6zu7O5QxMo/Gk5Ni16Rv5m4bimeSyLtX9uh1t4pnRHCyoiLsggkdv8Zi+7FbLm2Oa5ZhCuwEmuDDA6AMh5j8bT7mh92ztwPmaXkea1eDhSPTeegahXTbsoNnxyMyEMm0N429RyhzcMDu4C1YdG+TUwP9lL9sVDaZIsrEH9NB3xQk8inDtiBFmszkfZ0DO5brd1DdWg+qeU5L7c3RYEWav4oyEOniWixBa80nKIMxXzwdWSuJhGSr0sqjS2893mdti8Z4TVMsVHXHGToUk15VlSf6geD4ZRK1lV8MBEq5PSOrI0kiN8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6506007)(66946007)(53546011)(44832011)(4326008)(508600001)(86362001)(6486002)(186003)(2616005)(6666004)(8676002)(31696002)(36756003)(31686004)(66476007)(8936002)(38100700002)(82960400001)(54906003)(7416002)(2906002)(26005)(6512007)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhFZEt6Nkt4eG1Ma3FyMzdFUXg5TkxrdlFtVldHbmV4VHhseHFjWm10SFdD?=
 =?utf-8?B?MS9XVXowSy9UYzJwaTdhZnVkdFlheXNQMjY3RWs2d0YzOGZhSUlyUTVEMlpo?=
 =?utf-8?B?Qk5USjRuS1lPZjh2TFdnU29IMVdyR0xZQnY3MDhIRTFxZzFUVkRNN2UzaENE?=
 =?utf-8?B?V2lwVDBaeGRLTEZpUVkxSmVCUk5IRU5hczlZQ0pSSEV5Vyt1TVNuNkN0dmc1?=
 =?utf-8?B?SUtWMmIremlQazkwcHpXRWlteEJrcEdMOFhodGZhcVNQUUJhUzQ1alZOMElE?=
 =?utf-8?B?cUtObHZ0cXNXZHlPNk9JL0Uvc3RBaVNDSGRGZzBNdTlLakl0NVoxWTNEVVJB?=
 =?utf-8?B?MTBOWDdxLzNTd0RzZGx2QjZ2TFpxWE1YNFVDSFcyVU1aUWhyVERxcnZuRExs?=
 =?utf-8?B?ZWU0UHZWT3Y3anJXZDArY1VwdGdSRlJxK0JYZm5OSFkzNUFsLzY3QnlCNXpG?=
 =?utf-8?B?ZStheG85TUNTV2RkdS9ETGVnVk9ydUFxeHZUcnFyZk5zUVdBRHdrQlMva21D?=
 =?utf-8?B?OE51RUFzNnlJZ3pzdXo3bkhyN0JtYjEvRzhDUzhJd1JYVWRtVmtGUENYWnVP?=
 =?utf-8?B?dmEzRjNvQThWeVdCTzlGeWV1UWpJbEs2WTNNQVFjSFYyR2NETmJGUkhWN1lm?=
 =?utf-8?B?aktnT0xZQnJxWngxNnQvd2JVblJtVkN5MlMyYjgyR01DaFU4VWlaVW9mNFY4?=
 =?utf-8?B?cXo2SXlGWk5zbDZaNVNkVDE5aWhHY3NSelBDUXRMeW93WE1OenlXbUg2WXMv?=
 =?utf-8?B?QVEzZGdtWlArRlFNZHVQNExWTWw3SGJUWmYyMCtBNk91MkdnbjRsYkdEMkM5?=
 =?utf-8?B?a2wrekJEb2JVZzViUXkvTkZQTG9FaEVSNFlYNTNYZDBISFJpQjl5MGtobWJH?=
 =?utf-8?B?WDVWMlpTT3JrSS9KTTJsZ1VaTWdJQjl3OVliOEl0blJScm5Tc0JCSmV4dFAv?=
 =?utf-8?B?N1EvYU1JNndxMXkvLzZhWVpMZmltUVhCUGdBcTdPRVVSRzQ4cmIzMlhaaFdv?=
 =?utf-8?B?ajI0ZmpqVHhLcG5NTWgrQmNEYmZEYzVZTEdzUTFINjMybnA1U2lBcUluUktS?=
 =?utf-8?B?Q00wck9SaFZTaWhGSVp4eUp1dHZya2RkWlIxdjcwOWtLU0lBcG0rQVR2VVVN?=
 =?utf-8?B?VS9VV3NqdExGZ3N5T3VWM1E5b3hPSnQ1bnR5RGdTVkU3ZGYvUnh4K2hKcys1?=
 =?utf-8?B?L1RlR3Q2cDd0cDQvZXJ4dHg2emhmdXJ3VVhwNHAwdUtVMi95R0s4anV2ZDhI?=
 =?utf-8?B?QUtLYVE3Q0tja05zTDU1QU1wWDRJVnpDaklSWGFVNHp0TjlKd2FWclBkcG5Z?=
 =?utf-8?B?YU5hdnRYT1ZVdzJpeGk3N3dYVTRXbEp6eXlrRHB5NmFVODUvdFB5d1pMSEpx?=
 =?utf-8?B?dkFJQi9QaVJpNklWR2NCODFTL29rWFBHOXI2YktnYWtLM0xScVRoNUhYYzl3?=
 =?utf-8?B?eDBSaXBQZllPcStmdEd3V3h2bnRzeTUrNGcxbFI0bC82K1d0S2lSeUp1YUlR?=
 =?utf-8?B?Mi96Y0JFeE9qSG1zZ0JvMGxaZWhFYXpKT0g3cXNFcWdhS2hoZWFjREdScG5n?=
 =?utf-8?B?bUZWWVFxTi9hdDZaVyszeXA4bitxQUVnbHRiaFB5WGFxSE54b1Y3SC8rM2xr?=
 =?utf-8?B?R3NEdzZuLzRuZU4rbWVkcTc3Zk1uUjhudHMzQmowMU9RK05haG9DbnlyMnZY?=
 =?utf-8?B?Mnl3OGV3VE5YK2xHNG1ZcEY5MUhTR3JFakJsb29SZkYreVVFaXp5TnAySFVZ?=
 =?utf-8?B?cnBBTno0NUFST0Z3SkJ2VkNYQ04wZWErTlQydG1aK0xhSXdxZHFSdlZYV0FS?=
 =?utf-8?B?UUx6aDI5SU5ScUVGNmhJUXFYS0FCVXVjZXVVclduc1UwdWVsMlhlNjVoWnFD?=
 =?utf-8?B?VEV1eXIzUGw5VlJnTVRBUzAvcE43eHoxRzFnbml6UXZmTTZ3WmtiRjRVQVVj?=
 =?utf-8?B?N245UlVydktWS1h5WCtQOVExc3ZOLzZzOC9uOEpKejIxVy9zU0pYQVlXVTlr?=
 =?utf-8?B?NVl6cis3a1NIUkpMQmQ5Z2I0YVk5QWhJNlV6NmI5VnZ3L2ZocUN2dnI0eTQr?=
 =?utf-8?B?Q1AxdCtBZUZqU3lhVGlIcm9PTHZMNzA5OEwxbW9YV0ZJTjlrMndOdDFtZStB?=
 =?utf-8?B?enNtc3JQRmNWR1dvUU16d2kzTGdXdDN3YUhJdnp2eVpuZXZESytjVDNVOWF6?=
 =?utf-8?B?ZWo3eDVCaWhqTndTd0x1RTN6cmFsZ09xTUJ2U2NLOTZaSVgrWkYyVmRRZVZ2?=
 =?utf-8?B?dUExUnRHUjdwY0dvTXBockY1MndHNGlHdkpKc1FXQTFCZEVDK3ViL0hsQUNX?=
 =?utf-8?B?bndGT2RLcEp1M1l5TUpBNEZHcEEvdkkwbmx2OFNINURRa01nSWphTTQ0a1o5?=
 =?utf-8?Q?DpC03bNJV8WN2RVY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 078380fd-75f9-4e36-a49c-08da489d9ddf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:51:42.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzNw6OAfs3W8sYUm+x/oBwdnevRpU7g5bVE3t9kEAEnDgdT+6ab1yGzap4QJKC5Q2viAu/fG//1pPq2Oeo8j+E8uPPJjKudTkwIVo586Vgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/7/2022 5:07 AM, James Morse wrote:
> On 17/05/2022 22:23, Reinette Chatre wrote:
>> On 4/12/2022 5:44 AM, James Morse wrote:
>>
>>> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>>>  	 * are error bits.
>>>  	 */
>>>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>>> -	rdmsrl(MSR_IA32_QM_CTR, val);
>>> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>>>  
>>> -	return val;
>>> +	if (msr_val & RMID_VAL_ERROR)
>>> +		return -EIO;
>>> +	if (msr_val & RMID_VAL_UNAVAIL)
>>> +		return -EINVAL;
>>> +
>>> +	*val = msr_val;
>>> +
>>> +	return 0;
>>>  }
>>>  
>>
>> In above EIO is used to represent RMID_VAL_ERROR ...
>>
>>> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>>  		 * Code would never reach here because an invalid
>>>  		 * event id would fail the __rmid_read.
> 
> (I'll fix this comment)
> 
>>>  		 */
>>> -		return RMID_VAL_ERROR;
>>> +		return -EINVAL;
>>>  	}
>>>  
>>>  	if (rr->first) {
>>
>> I understand it can be seen as a symbolic change but could
>> RMID_VAL_ERROR consistently be associated with the same error?
> 
> This one isn't really RMID_VAL_ERROR - it was never read from the hardware, this was an
> invalid argument supplied by the caller.
> 
> You can only hit this if resctrl_arch_rmid_read() doesn't read RMID_VAL_ERROR from the
> hardware, because the hardware supports the event, but its an invalid argument as far as
> this code is concerned.
> 
> I'd prefer to avoid EIO as the error was not reported from hardware - its only reachable
> if the hardware does support the event!

ok, yes, that is fair. I believe no functional change is intended with this change so
please do highlight any such change(s).

Reinette
