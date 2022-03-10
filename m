Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D44D3DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiCJAMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCJAMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:12:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0AE1B50;
        Wed,  9 Mar 2022 16:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646871080; x=1678407080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3pfr5P9curXvZ1fvl4ehb5aKg4qPeHIGFChMVk/NXog=;
  b=HOpzek3I80hAx7RDGMWFrYSMpJ/DXzs0I12D5lU954MDCrs7++EaRh1i
   cV4do2SHb6CXDMyzcoAauhKsFwFfrYsgofII9veZtbTAKZJ0BRf7Qtbd8
   CgeQZpybRCBLNqqSMsyOeay5GfYLPCK6CeQPqV9MDcxShuGt231iA6ADl
   84JWGNdqBCefZipoSPdOsMAN/sz/iiMRn1B1YzxFv/ZMqMsfQ3C7K9Twa
   ED4y0nMe3Txq79tC3R0ubhlldnc0piigC4cno+hRLEvGZRZQFOzUKHAQX
   9VOHpXQAe00dWEWL8DhKYusNsbDbo98SHg/DPR0PhLT4Oi55yWHwGJMRX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235728018"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235728018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="688474323"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2022 16:11:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:11:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:11:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 16:11:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 16:11:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHYELnqCMbpe9G5joSIoyu9yiZHwjT/o2dQRGfIBqMnDN3B60ckClxfVoz1v6PqIDslmcf+8eeskDSqmi0anUBFP68hxiprqI7MViwCc2Y3WUdv/w8QRSlnysLh8l7C212yd27YoYibmloCDa5FGXMkB3BZLh3ptCxEqFxvRDV7FIUmjpidZ+95kq81qy8y3ey1TchknLySNpIOX/gfW4McMhZ22y7oX7ZpscNV7neYnL4f39Q+koHxAwywLtTaBU65t37t8kHN35bFwmOygakIe03KarrqEo6s0drvgOj8M7hwybjbNo4cKtMNq/HMVigwY4uog7cmlkOKU0A+8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=660+9LBQY6QZquGu772tAZ2A2eLWvfcOLGmwm/Zh1+E=;
 b=cWHK2vJcEeZXG33Jm8QthQtNvZ+hNMpf/RhAJIYFkPXcyL/qVY9f+HLyfJE3+c5j1UIzP9moheokrJiInSqxkuNRbPBtHwnnxbxHwr7UnTwAi6fdqUwsd53olKYEN1Q3QYB4ap5Bxi6wVFI7x5qhwcy8zCJh9dw8dxz7qLe2WVZ6ogoZahzXSEAdNMHFeD5Fi2YGXdAC5nq8ks+M5P3RwCKacWsmGUmo3F3glXXNwRJbSF/Gh0Fg1QATm5x9Din2R1MVRLhACGZyDTY9bA3aZCpmxtfbSriCZTGqoxgG2ENakYvbPuK4SACul6KwzWIUUy98oANVL72V+E7Ax7HFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 00:11:17 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:11:17 +0000
Message-ID: <acc54cf1-09d8-3ceb-be20-e9dc553259df@intel.com>
Date:   Wed, 9 Mar 2022 16:11:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org> <YihqwiU3Dr5mvMQx@iki.fi>
 <Yih00gFMaJhLIgxa@iki.fi> <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
 <Yik51tjxXcqamBrO@iki.fi> <Yik7cdUif35yA7ui@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yik7cdUif35yA7ui@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0064.namprd19.prod.outlook.com
 (2603:10b6:300:94::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2202a3-50f8-43d2-fe4a-08da022a7f17
X-MS-TrafficTypeDiagnostic: CH0PR11MB5315:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5315A594A473FEA3A8E7C812F80B9@CH0PR11MB5315.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzhqPV+ITV1Q9+OYP2Gr1gL80BlLtd7LXshy6bXBYOOw+FydJTkBCmFsrqUHxmjUUjs4rXeQoHaPucD/TTPhuohdd0gILUeCJfahUv/q2Z0D1+XBE5bDRcJkZZqmzDzrdTNe0bJL+kiboaTxat5Z+MLRFdnwa3oc58nT2rg8auRof09KT6dgS0+a+dGadyinCswEAx+cb9Lb04dOjxBUVAKA+pGc3W/6dPlFYjMYuuZa/VGvPsvVioJF0PqZqJMZoembJlwZLpOITXDN+UCIUOvzHanDhv/7tRbTIpc0F+Iuo4U5GT4LiclVu3/hU6Pk2toNpbd+5H4uozVecbhvCDK2CdJUM2UFq1otZDn9HZfOMw6Ruyth19Nb5p17qM1HPpFm+oSaKo/+AeeAoznwGtCfgRNmQ9ltnAxSIuUxiA8TFvaDEVNHxzj4ZR2TcV8BKoJ13gRUvTr7YZqKopTdIVHKR0fI4qs1AfLhGOLmBBP4CYuyUri0mlKZuLxJO2G71dDXM9gyhONgFX+SX5PtuH3/SSInqfzJVYJeGLrC+fDP9a2ErZyANWVoDzytegkVXs6+SCvYe+2SKeoFeayQ65E6Agic5llFa1QqIarR/XebNGEhw1/Ryn2K47wkkvPybnL+XWIJUcIJci16xn3lxFEorka0piYu/jx0ZPIj/yxiSJ1HV/vdgsnaUcgxtwpi5y0JB/hqGLrGhPTx3yqxtNwvISxmzxly2NUnadDyeZywrBOtsQqfbJnpt2Nmm8j/c/XpHUAOUr8klbkJcv3P3ChSufAvfL+ydk043Le/jq3SwBHJaGv3fG+67GOAriZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6506007)(6512007)(186003)(2616005)(6486002)(53546011)(2906002)(6666004)(83380400001)(36756003)(86362001)(5660300002)(26005)(82960400001)(8936002)(31696002)(7416002)(44832011)(66556008)(66476007)(66946007)(316002)(54906003)(508600001)(6916009)(4326008)(966005)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFMYkU2Z3owdTZWWTBKVCtFNFd4ODBqMysrN3FtbUVOZUVBa2hoV2pUM3NG?=
 =?utf-8?B?NjNYSWhiSDFUclJWdFFoak1DeDRJQ0tmRnc2Zk5xUWZNNVFQSHNGSlJoUERR?=
 =?utf-8?B?NmMwVTFvdFpLekRUNzU1Z094aFB2RzgvRlQ1cWhOVi9VaU4zMGJMVEovREhw?=
 =?utf-8?B?QkJTeHQ1UGR0dTROd1BrZnNzeDBkTlo5TXRuWW5LKzFrZkRKTWR0ZWpqYjVv?=
 =?utf-8?B?bDIyTE9sVFkzNzBHL3FTalRvc29pOElMb2dKT0dqai9PWWFJTGtMR2hoczlU?=
 =?utf-8?B?MnFkQkVHNGowRWhpNVlLM3FXZGhYS0Eyb09WOXFMRmJIOTdCWmM5VnFDVVQ5?=
 =?utf-8?B?QTlCL0QvWFkxeU1XTW4vdHV1V2pMSWVJcXpreklzTGtvQ0F4L3pHL3FRbGc1?=
 =?utf-8?B?TVpkL0RrOUVIZS9VRDAzWXFhNTJ0UGN6cHhacVVCUHNPOU12UjVLdGxuSVkw?=
 =?utf-8?B?QjZrNmJReWZmRFRRU3FDU1Z5NG1jT2sxNDBzR2I3WVpqT3EzaVZOOThtd0FQ?=
 =?utf-8?B?aFY2MkszaTJuNEU5WHJpb3krbzhmY3R0eGZRMDFaaCswczBxOUxIc0Z4amNK?=
 =?utf-8?B?WXF3RDk2QUJFeEUramFUWmV2S2NJL1FFblJjaThYTkVWUlFuRStjVFdodzRG?=
 =?utf-8?B?Y0hxczYzd2R2eXJEVWNtL1lWaU4xam9Mb1lEc1dTQVZVUHgyWXpSbTRpWVFq?=
 =?utf-8?B?aVBaMjBJbVY5RmJWREdFaC90M3VleHc4UDUvZUxKSDE2SC9rUXdpeng2NUlx?=
 =?utf-8?B?Y1p2Qk1BZ0I0WXAycVJydzQrdFRDem1ocCtIOUJxd3BVY0lZL0d0UHRrRHNj?=
 =?utf-8?B?a1dlb1drVnNwQ014YmNHRDRVOStMa1ByeHl0ajFXU1d0dEJCNkFwS2M0TmI3?=
 =?utf-8?B?TFdxb3BvUFRacXJlcm9Ibjdsdmc0L1JPQjJ6OUVuT2xIZUhQNExjYk1iNUVq?=
 =?utf-8?B?cjY5ZkNwZUMwbldxMVNtU2ZNRDJ0a2RrYUs0M3l3aHk3ZHIzUklqUWdueU5i?=
 =?utf-8?B?VXBraHZZUWh5V1RCU3FmZkJrMmo5SDh0UzRRNkNZbk16bll4RVk5U01qajFs?=
 =?utf-8?B?blRhcWtBVGxYR0luV1FhTThOTGpMbWx2SmxPRExXcjBzWEtqNXZPSWUwZ1A1?=
 =?utf-8?B?cC9ubjlnbjRsalo0cERESmd4RXJUSURqaVl1S2o4K29VM2c4VENYRlZXcHU5?=
 =?utf-8?B?eVdlNkVvdFErUTJJakVET0ZBQnp2NHFCOTUyRFc2RVhhZDRyejFsWm5wRTlT?=
 =?utf-8?B?OENsM1dzRllMUlRCd0JyRmZxUzBqS2MyLzdnMlZMa0FrZ3ltSTd6OThNTTl6?=
 =?utf-8?B?UDcxMitFdC9KMnorSG5wVm9Qb09IZjFmWUVWc3FLZStrUU1xUTk4MFdDdmhN?=
 =?utf-8?B?OXBZVUx1QURtOXhRQkxCNytibEVyelN2dHA2UlZnbHF1OU5qQnVSeGdpK056?=
 =?utf-8?B?a0pJTnNkZkU3T0I5Z2dZbnVBVUVPUWNNY1JrUFJIMVFkQ0hTdS9BaUpPSmwy?=
 =?utf-8?B?dDN1OVhEMkZvK2U2UER6UjQySkJ1dmgyc3daTWtIZmZmUFZqejR3ZFp1R2Jk?=
 =?utf-8?B?SUVQeE1aTGJ6ZmNiUDgzUlZpUGFWaHo1a2FhVytDdlluc0N1Y2oxVVB0Qmdp?=
 =?utf-8?B?bjBMYXpoMmIzbTZpa1lJVEszamVzUHM5dHVheDVSSk1NTEF5OVBPT2krL2Y4?=
 =?utf-8?B?SmxQR2haM2F4eXlyS29NdlhBYkUrR2FyeVh3bUZnWTRldVhscFFXRHhNQ2gz?=
 =?utf-8?B?YURPNWZwT3NYaTdXYU52NmppTzJZcHV4Qnc2TkNXbHlsYWRVUlF2UkhxaHR2?=
 =?utf-8?B?MXoxRGlVL0lPQS9FY256S252aEIzTGpuTGlIR3hLcHA3TnJ0c1dDWERsWkZB?=
 =?utf-8?B?MEZpK1g4RlhsQlljR0NpT1BiNW9qSCtieEdmRTkyM2R0YUJ3UG1GSEFaVENT?=
 =?utf-8?B?d1dXMzJiaDN6dm41eWsyVjdERllXOGt0OEJYOEtVZUVaWDZQVS8yTCtxRmhi?=
 =?utf-8?B?b2tiOFJROW1BPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2202a3-50f8-43d2-fe4a-08da022a7f17
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:11:17.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PezBFZ7eNEYsESSB9OCd9Co3b2Rt36b/H6SKZMJJuUr4+64m0EnduRTsduN9yoMjUyugTDOlZoji1emsVEB+Y2jz6NS63QKIDa4lZBRD3ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/9/2022 3:42 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 10, 2022 at 01:35:53AM +0200, Jarkko Sakkinen wrote:
>> On Wed, Mar 09, 2022 at 08:59:42AM -0800, Reinette Chatre wrote:
>>> Hi Jarkko,
>>>
>>> On 3/9/2022 1:35 AM, Jarkko Sakkinen wrote:
>>>> On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
>>>>> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
>>>>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>>>>> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
>>>>>
>>>>> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
>>>>> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
>>>>> flush out the TLB's, and move a page to pending state, which cannot be done
>>>>> from inside the enclave.
>>>
>>> I see the main ingredient as running EMODPR to restrict the EPCM permissions. If
>>> the user wants to use SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS just to flush TLB it is
>>> already possible since attempting to use EMODPR to relax permissions does not
>>> change any permissions (although it still sets EPCM.PR) but yet will still
>>> flush the TLB.
>>
>> It's not just to flush the TLB. It also resets permissions to zero from
>> which it is easy to set the exact permissions with EMODPE.
>>
>>> Even so, you have a very good point that removing SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>>> removes the ability for users to flush the TLB after an EMODPE. If there are
>>> thus PTEs present at the time the user runs EMODPE the pages would not be
>>> accessible with the new permissions.
>>>
>>> Repurposing SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE to accomplish
>>> this is not efficient because:
>>> - For the OS to flush the TLB the enclave pages need not be in the EPC but
>>>   in order to run EMODPR the enclave page needs to be in the EPC. In an 
>>>   oversubscribed environment running EMODPR unnecessarily can thus introduce
>>>   a significant delay. Please see the performance comparison I did in
>>>   https://lore.kernel.org/linux-sgx/77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com/
>>>   The test shows that running EMODPR unnecessarily can be orders of magnitude slower.
>>> - Running EMODPR on an enclave page sets the EPCM.PR bin in the enclave page
>>>   that needs to be cleared with an EACCEPT from within the enclave.
>>>   If the user just wants to reset the TLB after running EMODPE then it should
>>>   not be necessary to run EACCEPT again to reset EPCM.PR.
>>>
>>> Resetting the TLB is exactly what SGX_IOC_ENCLAVE_RELAX_PERMISSIONS did in an 
>>> efficient way - it is quick (no need to load pages into EPC) and it does not
>>> require EACCEPT to clear EPCM.PR. 
>>>
>>> It looks like we need SGX_IOC_ENCLAVE_RELAX_PERMISSIONS back. We could
>>> rename it to SGX_IOC_ENCLAVE_RESET_PAGES if you prefer.
>>
>> Please do not add it. We do not have any use for it. It's not only used
>> to flush TLB's so it would not do any good. I just use it with fixed
>> PROT_NONE permissions.
>>
>>>>> It's there because of microarchitecture constraints, and less so to work as
>>>>> a reasonable permission control mechanism (actually it does terrible job on
>>>>> that side and only confuses).
>>>>>
>>>>> Once you have this magic TLB reset button in place you can just do one
>>>>> EACCEPT and EMODPE inside the enclave and you're done.
>>>>>
>>>>> This is also kind of atomic in the sense that EACCEPT free's a page with no
>>>>> rights so no misuse can happend before EMODPE has tuned EPCM.
>>>>
>>>> I wonder if this type of pattern could be made work out for Graphene:
>>>>
>>>> 1. SGX_IOC_ENCLAVE_RESET_PAGES
>>>> 2. EACCEPT + EMODPE
>>>>
>>>> This kind of delivers EMODP that everyone has been looking for.
>>>
>>> EACCEPT will result in page table entries created for the enclave page. EMODPE
>>> will be able to relax the permissions but TLB flush would be required to
>>> access the page with the new permissions. SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>>> (renamed to SGX_IOC_ENCLAVE_RESET_PAGES?) that does just a TLB flush is
>>> required to be after EMODPE.
>>
>> For EMODPE TLB flush is not required. I even verified this from Mark
>> Shanahan. And since access rights are zero, the page cannot be
>> deferenced by threads before EMODPE.
> 
> I'm fine of course keeping SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS as it
> is too. It's at least future-proof that way.

Will do.

Reinette
