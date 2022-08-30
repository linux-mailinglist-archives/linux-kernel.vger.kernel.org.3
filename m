Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7F5A712A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiH3Wyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH3Wye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:54:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1BC78BF1;
        Tue, 30 Aug 2022 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900074; x=1693436074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hmLFMOsJHiCo9r+LqpXQquXItI0YYemSK3VXCe6G2Q4=;
  b=l49GUG+22RHfhR+9hkIc1NJ1VKhX63xLVzFg9dOViq9tUeFVkHcXBcB5
   T+vh3Tsh6ARwIsw/iCsOfWk9dyTY07REGiq6dtRTPuSF62WMzTRKl1r4Y
   MW00Be5XpeZqgti/Au0B61Jys4tJl0TZAB4Ikc5hf+fMOALmNhs9V/jiP
   YX/OhsNCTdVJsvVW1aQhwUvV0o8pIojMhqvmfXs53hsfDV75Y1oMr2fmo
   R+X6Ua2n4CIZpqDlskh5oBFeBkUo765NJbc1F22CZrqLV0rA1xR8OyW1i
   5cbLgPnfCDzDlABzLLt+4LFfU18jm5knvF4+xRMcM66eF1znO00vqlDl4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="292901525"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="292901525"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="645024921"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 15:54:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:54:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:54:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knxvLT+DD6Up0oic8dh/FplnVuOaWWwD5A+urlzD26OoXD75+kw+qD5l0heeYtniK5ntprtGr77owRPRrompd3aiM5k2krqDiuhHfDJRQYQ4PQ4s1Isk2MbZEFdED30r2OoL62trWZYmLczp9DxTYER+Mk2rbx3LwqYgjRDkw/owAjRRk5qvAGGlrVs/NRzMUigTW2w1F6n7Z7Y/c/M2Z0sSkSznqfmKVWR0Zgt5pvbyagftSr6gw21YL0W2GFw3tAfV2IYhNIAtIIiSHFqcTrVMOvm17hRSh+AC9HHBDDOs0a0NvbUKi2c/DW7tzEgRcbdJLaeAslswV7Cd04ZWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TagwJ9wYpM2AAevpjP8lR9umyb718ZYhfNPnUbCcqMo=;
 b=dMXS9aQRnwKvTjK79DGW2goYBLaJB3vNRX8TjJOfUqv8NdP6bafImblzt+e+Sos/mRQ7DAnW7aSORiKTO0kJ39zdIewAUfxtUUEiOiuLL9Rwku1uNBbNjfxgijjYN1LyrrZ+WsNpor7iDq5ITu4CCDttMEifRmTOw0BK1EGDgg8zmuA3f4//b9wR9tq8uR/flmvcyaGb41bM2EFtNd3UevIr7FIqpyHsXUmD+TD3Rj9vzx6IVPAFawpweUUC0pntui3TAR6En9pX+OC0KZsmPS8lvnsH6aRTdhKlwLit75Or7vSY4IB7AyhWOYUiQKw9vT7KxeVKBh4hJzJu7YkR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 22:54:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:54:30 +0000
Message-ID: <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
Date:   Tue, 30 Aug 2022 15:54:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a0f787-73c0-4bbc-0dfe-08da8ada9932
X-MS-TrafficTypeDiagnostic: PH7PR11MB6523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdUfXyv/K3NO4vTgBUdCzZ/jB4uR5YVptFVhrhCRjHhXsowh/Cvc8cWS2zmRWRFr+ix5nNcuMGpa4/dYqGlFkTiYx2zjgiyn+wiBTs/m1Hn+5fkjPd5xkjg8O24GpbN8zs8GXB48JIKbgAvGGpZMpnDbNK8n4mppziBcNmOYNmBOd5xNkWWrSrrNfXDrqWGT2CT6l8iOajH1tc8IdzxNLJRHe8+6Pg7lxCD3SKPzaZJYzzDeDJWrLTYrKjw6m5+9EeUfv7ia/6TcPZajCeWqG4h8XzrV+MppotBd+wYxHAY/mdDTq2I72+Z2cQQ54CqCt0P3EgrSpO+Aw4n887djwyFyor58qwQ1Pefb6tn6zIVeo4nBGH5DE92ASNjtuxhrkXGPse+uvEL2RwDGceCaHoYAwqvivAlKl/9FHgYWZhYJ3g/R1L/VFIaYDz39Kx49/lvHC+o0uE47QpPlHeD/9m4GHyZAaq5BHuz5niQZC6PbcmLLPTdFo10ZI9S0MNfA0KSKxrNjcgpknEFX2loXntd+eMixyWQNuEKBtN8euV54fEHAPue1AKtxiFVOw3u8tfa65+Qsr6rJbD5X5kOr/eEewRVcMWD4dBFeD4CDNPc55I1Bh2OnmX0luM7XdJt7bXQAkAlsK7kQ4aPWJF62MKERWJ1ls+DVx4mjrDBZQu2yEjYchna6cKhmcpC+p16F8k5mTnOjHSMSEhqT7A6bS7aO7aO1dfBPlCY+0FswU/QEjr2ePZOf2XNxG1i39AAR9qf5VHQVXyL069MdjGjzdif0cZND6Rpy+0XGFrYi5FjHBwc8Mp1jcYwCRZEVdOIrZbuTjlVzMOpkZGqF+enG1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(39860400002)(136003)(316002)(54906003)(86362001)(4326008)(45080400002)(31686004)(66556008)(6486002)(8676002)(966005)(66476007)(31696002)(66946007)(478600001)(82960400001)(36756003)(5660300002)(7416002)(41300700001)(8936002)(6666004)(2616005)(44832011)(6506007)(2906002)(53546011)(38100700002)(83380400001)(26005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xBUVdxZWFJbEo2a3pVMEx4Wnh1KzJ5cHA0elYyS2RTbWkzNjhISkh5Vk5r?=
 =?utf-8?B?ZVpUWlJuMkU3cXJrMzVzSisrYThiblVVbkFFYW1xNlBPY3BqQS9ZV2g1SGxI?=
 =?utf-8?B?VjhOTGF6K2Erc1BKaDNLRjdWb0dkZmp3eHdoWHZIZkFLei9BVzV2S25ZMy9y?=
 =?utf-8?B?UGxqTG1nOERjZk16ZldrTkZRWjhZRTQ2NkNzV0RMMWlvUW1CRUtsb21mMks3?=
 =?utf-8?B?U0cwTnlCKzVJZDdYZlM1ZkU0TzdFN3dTc1UyZFEzNGdjS01vVzU5L2pFdDRk?=
 =?utf-8?B?TWs2eGd6MU54MTUrUDV6YmpLSnlDYnJpRVNCZnptR3lOZFF5L1ZVelVHNUY5?=
 =?utf-8?B?TncwQ3VYMC9KRDNTMTRTWmZRZ05FLzNqeXRhbGwyRHpsb0IrUkxPeW9haDVr?=
 =?utf-8?B?Y0lIWWZqYlNjYWpBaEdJWE9sd2pjYWlRdTRrRVh6bVBVMndHRnpWRHYvQ3E0?=
 =?utf-8?B?cC9DSUE4bnB3MTNMS0gvZkw2dWtsNlMvUXZzMWZ1cGNKS01YVTVpVmtJbDl4?=
 =?utf-8?B?VjVUQWNaOHV4ZmFnQ29CYk1tV3V3cWN1M1oxZHhJVUlwN2dnSEFOUk15dW9w?=
 =?utf-8?B?MlVSZGNZVVlGcSt2OXNJMTlnV2YwNnFxbUZvSHkrUXBnZWVpOU4yR1MwN3JB?=
 =?utf-8?B?akRrZy9MSWx3dFZUaHlCTWdrTGk3K2orZnh5Rk0ydUJ2RVI1N01zdVFpYXMz?=
 =?utf-8?B?N3FtK09mSjZBSVBUZW1FOGF4dXFIZVNzZTl3dHF2UHBOOXpzSEVXV2kzZW9t?=
 =?utf-8?B?dXBoT1Z6bUhQM1R2a0NpWGFScFdrUkIveDhTUFZwNmdjWm9ISjEyZjVuNEQv?=
 =?utf-8?B?S3poMEJLK09LbHAvRktJR3hEMUdvTlZLbDVVc0h3M0JoNHF0MXJsOWVmVVoy?=
 =?utf-8?B?bzZCbEdXMVF0N1pQa0c2TmtIeTZZc2pnZHdrVWNCdG9Rcjdxb0R2UzFwTnU5?=
 =?utf-8?B?R2Q5cG4vbXVCYjFpeUVFSE05aVJmckZDS05HQkxKd0JlVmdLQURVdDAraDlR?=
 =?utf-8?B?NW04NGFERUlQSlh5Vk5OYkVqZlVXNERoaFdkMGZSR2txejJzWGRUaTlUTGw4?=
 =?utf-8?B?eUJ2NHgxUUg5UUFCV0M3eFhHQ2JTL0VxSGZZYnZ0LzZKZ2pQSmpXRWhGZlpo?=
 =?utf-8?B?bnNkMzNsUytuRmtRRDAwQzh1dFNPTHoxWGFmcjR6TVo4dGUrdkMrU21EaVAr?=
 =?utf-8?B?eVZ3SEo0NU9UYTdlTEdueEZFVmtNa0thZGNEbTlyZ2FqRW9YRXRmMkU3YTRV?=
 =?utf-8?B?eEdpdnFUNWRNcjZOVE81QVJ6bjJVOE4zRHRFVURjek96ZmhCUU5RalNzZ05p?=
 =?utf-8?B?RUUyK2VVNmJPVEZITm9aZlFZb2huN0RDc0x5aHpUTno0YWhJM3p6eFhuQWFT?=
 =?utf-8?B?ZklHRnN0MzdCb1RtRzFpWmFWVXR4S3lUb2JNUEZPWHlRZHlTYXQ1RTM1QWZE?=
 =?utf-8?B?eWdybGVodENsOGt3MlJlN0J5c1VTdzJwNkMrREJlYnEyaEV2WVFnSFhOaFAz?=
 =?utf-8?B?cjZ1SExPVlB1dVJTTEUvYnA1WjVkSHJwLzFFWTBJdHhXZENmZS9hclZFYytQ?=
 =?utf-8?B?bDJIM2gzTnhsV3dOY2xJSFZyTG1rL2VoNDBEMVZRbVpjTXRvR0hmOFJHdldh?=
 =?utf-8?B?bXg0YlZFUzFhUEhtdGQ5QXZkejVVR0VNcGJjWHh6M2pLeWN6VWZValczMm9B?=
 =?utf-8?B?aUdHRitWb0lyTCs2RTByUStOeVhBbkpNVEpzUDhzcUpqa0hyNVJhL0ZsYys2?=
 =?utf-8?B?WFd2d3BZU3NSeGlNSWFhV0pwQlN4b0NZckdyeE5QMVNqTlNWcjUyakJwZkhR?=
 =?utf-8?B?WmFVdlN3SGV4eUgvaDYxSFZtT2UzTkh2cEVuTlV3OCtCYzA4RWVzQXk5aUZj?=
 =?utf-8?B?dWwzUWpxSEcyb1A3SkxjTmI1eDdPQlhzTGc2UFhFdHFTM2djZjR2Z0ZZNjNV?=
 =?utf-8?B?Z0tjUVZMcWduQ3hKYmlIcUFibUVhS2RtK2o2bkU0Y3JPYUQxcTdpUFRJbE1W?=
 =?utf-8?B?VGUrOXRkaXNPSHJmaE5ZbEhwbkg5NXp1QzRSOEVhUFBZWldoL0gzZmZUdnRx?=
 =?utf-8?B?MTFSVE9zU1Z0WkRPMmJuSVFMZlFDV29obEJXYmhUS3M4TFF1M0s0aEtORGFm?=
 =?utf-8?B?UUVJcGdnY0JhbmxRK0ZGT0t4endFdnU1L1J0bFdFaW5oNGJzSXFnRndnTFU1?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a0f787-73c0-4bbc-0dfe-08da8ada9932
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:54:30.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unJcVB1btk7EX1FHrKA9Ei8Cy51/I8HXw/BqkN+yXTwu7mByU8BoBL6SfD2PoIUIU7SC7MHtUSpQZhC0846V8/9Vr2zzKol/xp2R3CvnbIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> In sgx_init(), if misc_register() for the provision device fails, and
> neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> prematurely stopped.

I do not think misc_register() is required to fail for the scenario to
be triggered (rather use "or" than "and"?). Perhaps just
"In sgx_init(), if a failure is encountered after ksgxd is started
(via sgx_page_reclaimer_init()) ...".

To help the reader understand the subject of this patch it may help
to explain that prematurely stopping ksgxd may leave some
unsanitized pages, but that is not a problem since SGX cannot
be used on the platform anyway. 

> This triggers WARN_ON() because sgx_dirty_page_list ends up being
> non-empty, and dumps the call stack:
> 

Traces like below can be frowned upon. I recommend that you follow the
guidance in "Backtraces in commit mesages"(sic) in 
Documentation/process/submitting-patches.rst.

> [    0.000000] Linux version 6.0.0-rc2 (root@4beb429beb4a) (gcc (Debian
> 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #382 SMP
> PREEMPT_DYNAMIC Fri Aug 26 12:52:15 UTC 2022
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.0.0-rc2
> root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> module_blacklist=psmouse initcall_debug log_buf_len=4M cryptomgr.notests
> […]
> [    0.268089] calling  sgx_init+0x0/0x409 @ 1
> [    0.268103] sgx: EPC section 0x40200000-0x45f7ffff
> [    0.268591] ------------[ cut here ]------------
> [    0.268592] WARNING: CPU: 6 PID: 83 at
> arch/x86/kernel/cpu/sgx/main.c:401 ksgxd+0x1b7/0x1d0
> [    0.268598] Modules linked in:
> [    0.268600] CPU: 6 PID: 83 Comm: ksgxd Not tainted 6.0.0-rc2 #382
> [    0.268603] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0
> 07/06/2022
> [    0.268604] RIP: 0010:ksgxd+0x1b7/0x1d0
> [    0.268607] Code: ff e9 f2 fe ff ff 48 89 df e8 75 07 0e 00 84 c0 0f
> 84 c3 fe ff ff 31 ff e8 e6 07 0e 00 84 c0 0f 85 94 fe ff ff e9 af fe ff
> ff <0f> 0b e9 7f fe ff ff e8 dd 9c 95 00 66 66 2e 0f 1f 84 00 00 00 00
> [    0.268608] RSP: 0000:ffffb6c7404f3ed8 EFLAGS: 00010287
> [    0.268610] RAX: ffffb6c740431a10 RBX: ffff8dcd8117b400 RCX:
> 0000000000000000
> [    0.268612] RDX: 0000000080000000 RSI: ffffb6c7404319d0 RDI:
> 00000000ffffffff
> [    0.268613] RBP: ffff8dcd820a4d80 R08: ffff8dcd820a4180 R09:
> ffff8dcd820a4180
> [    0.268614] R10: 0000000000000000 R11: 0000000000000006 R12:
> ffffb6c74006bce0
> [    0.268615] R13: ffff8dcd80e63880 R14: ffffffffa8a60f10 R15:
> 0000000000000000
> [    0.268616] FS:  0000000000000000(0000) GS:ffff8dcf25580000(0000)
> knlGS:0000000000000000
> [    0.268617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.268619] CR2: 0000000000000000 CR3: 0000000213410001 CR4:
> 00000000003706e0
> [    0.268620] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    0.268621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    0.268622] Call Trace:
> [    0.268624]  <TASK>
> [    0.268627]  ? _raw_spin_lock_irqsave+0x24/0x60
> [    0.268632]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [    0.268634]  ? __kthread_parkme+0x36/0x90
> [    0.268637]  kthread+0xe5/0x110
> [    0.268639]  ? kthread_complete_and_exit+0x20/0x20
> [    0.268642]  ret_from_fork+0x1f/0x30
> [    0.268647]  </TASK>
> [    0.268648] ---[ end trace 0000000000000000 ]---
> [    0.268694] initcall sgx_init+0x0/0x409 returned -19 after 603 usecs
> 
> Ultimately this can crash the kernel, if the following is set:
> 
> 	/proc/sys/kernel/panic_on_warn
> 
> Print a simple warning instead, and improve the output by printing the
> number of unsanitized pages, in order to provide debug informnation for
> future needs.

informnation -> information

 
...

> Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Should this go to stable?

> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 515e2a5f25bb..903100fcfce3 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
>   * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
>   * from the input list, and made available for the page allocator. SECS pages
>   * prepending their children in the input list are left intact.
> + *
> + * Contents of the @dirty_page_list must be thread-local, i.e.
> + * not shared by multiple threads.

Did you intend to mention something about the needed locking here? It looks
like some information is lost during the move to the function description.

>   */
> -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> +static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
>  {
>  	struct sgx_epc_page *page;
> +	int left_dirty = 0;

I do not know how many pages this code should be ready for but at least
this could handle more by being an unsigned int considering that it is
always positive ... maybe even unsigned long?

>  	LIST_HEAD(dirty);
>  	int ret;
>  
> -	/* dirty_page_list is thread-local, no need for a lock: */
>  	while (!list_empty(dirty_page_list)) {
>  		if (kthread_should_stop())
> -			return;
> +			break;
>  
>  		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
>  
> @@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
>  		} else {
>  			/* The page is not yet clean - move to the dirty list. */
>  			list_move_tail(&page->list, &dirty);
> +			left_dirty++;
>  		}
>  
>  		cond_resched();
>  	}
>  
>  	list_splice(&dirty, dirty_page_list);
> +	return left_dirty;
>  }
>  
>  static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
> @@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
>  
>  static int ksgxd(void *p)
>  {
> +	int left_dirty;
> +
>  	set_freezable();
>  
>  	/*
> @@ -395,10 +402,10 @@ static int ksgxd(void *p)
>  	 * required for SECS pages, whose child pages blocked EREMOVE.
>  	 */
>  	__sgx_sanitize_pages(&sgx_dirty_page_list);
> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
>  
> -	/* sanity check: */
> -	WARN_ON(!list_empty(&sgx_dirty_page_list));
> +	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
> +	if (left_dirty)
> +		pr_warn("%d unsanitized pages\n", left_dirty);
>  
>  	while (!kthread_should_stop()) {
>  		if (try_to_freeze())


Reinette
