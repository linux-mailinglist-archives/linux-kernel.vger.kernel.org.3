Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567C4D5356
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbiCJVCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiCJVCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:02:33 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFF187E2C;
        Thu, 10 Mar 2022 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646946092; x=1678482092;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/PyYs2vW9kv+wSSTJHemMX2q/9hsBLuuWBaomXRy1N0=;
  b=JpbUpw/FOxyV2HmPkti17QZwde5AMfNB48VMjmWSjsWPzwSyXVA7qLb9
   WUtFFa5ug2Z/8F4bjoMsmdmkEUFyN5iRpDm00PDvrnwDoluw/8PjahatI
   RgsqWLxePz7hJ2OUXF/c/tdu9lZWc1DRybntVPI6BbtwIdFa7DOKpV3JS
   VGLp3fZGimYusG48I5Z8/Vb0JG4EKmA7fe4Hbgh+g5S5hazOkoejd1R9C
   rPsyH+ZB+TxLOJKjoQFiOBpgI5vpmoMu6rHa1ICxjj41ACZD1R6V8L+C3
   Rmzhjw/Ag6ZrtrkHs4SbUfCu1+4s7TYgaeCZZRP/EWD2iy5ogIR7LQa/a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316100661"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="316100661"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="611893428"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2022 13:01:03 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 13:01:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 13:01:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 13:01:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNJ0Yypd6jQ8eTpYLO2R7MkRasBRii8mI/2TZRz9c9ljB5E90OHPp6t+8sK1PdjMj6x4ic0LjNXxjtumsZ83arwQimWAv/daTq/uFjBrEDfQMsWEb1N1ZlQr7frCJUOftgO5DcKBEVRRYwNg8Id2mNdBOSQ3ffbROBpGZeNIRVCQoyx0tAck4b8nTkmbj77bRWlp6+Dvlz97g129E4168aTTClQxEJBvBM3ywzFdwToQzmF/ijRpuf/hbhBiGFWRuVOsEE1u9mbtll2g2yI0VNceBcF8EpSUpYC2Uv0kHAWJF0Cta5I76Y4PUwb1MXQ9tRZDzmOi51TleNy3H76J6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G6FsWXMf8Dp0a+PPGlm6p9ZH9aviN/EMV3HgvHjSYY=;
 b=Pfd/cdjUc0G9X402u2jThjIYSsapnP6Y3fDc4whZNeNTLrsvTgrVMW6tx6u4OBkTv5ok7yOTK4IyqrncxK8GOKYr7P84Qn5OVg1Uk9Su4xdIwYYJudbOt4CZ3S76xTd/w6hzrNefRbSo9MTPj5ZMiNbOl/iJFatQFRbdZQp6yNyXiHWv9JcvbjnGwWLFJo183AapkPCrGruwDefiE57z3nyZw23bC6K+/Kw+mEE5e9PV5JHfyazq0sQOQ6v2o62+nRUDwhKfEjchh5liL+9uo4t8zQIk04BJKrFEaptmzQIrehsMTkORnA+eBqlP91hPNs/uFFiPrAWh1E+MstnjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN6PR11MB1969.namprd11.prod.outlook.com (2603:10b6:404:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Thu, 10 Mar
 2022 21:00:59 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 21:00:59 +0000
Message-ID: <13346402-7580-d60e-bb88-3172dd60406f@intel.com>
Date:   Thu, 10 Mar 2022 13:00:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <ravi.v.shankar@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-2-chang.seok.bae@intel.com>
 <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
 <c6a9632e-cdcb-cf05-183e-a124e9cec0e2@intel.com>
 <4331a0af-2300-ffaa-3e5c-ed15499c213b@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <4331a0af-2300-ffaa-3e5c-ed15499c213b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::29) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c1ec86-4c45-46ab-284e-08da02d913c3
X-MS-TrafficTypeDiagnostic: BN6PR11MB1969:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1969CB4FA0E84A2A1A05FFD4D80B9@BN6PR11MB1969.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XXzcr5sbPKSwGmeRd9gj70Vd4kf+aWU2Xjr6cQO79QwkZdwYWsLe9KSU5wTuKRgj/aIodtHvW3yTiEYthrOkHDIwuXNUplYw0yokSQKTnw0v/LEIUulFT9+94/tjroixjNmFcBfOm2RhL2DfkAn8lEw1zEPnBnyOL/xDKwKUqNTfAZHQnH5nU/Poy7LVB0pYrSEQCdYEla4x9MTgs//Hlfzjx0F3hWYB2fubRoFieh/jedHntxUPkzq8VbkeGybV3BzbXd2qTziI6SVm14UavkY1V+yivkBttlh7/QmZV+dwntd2u65maKQDzeJTHWTftXw+fjOgWgMX2K+94/KQgGCxtNRrY5wjr8/JRujCh3d4cOwO3DcYEHLSEjs2/2t5IZZQrkvIP95Kh3TrydSPvCIAbvY/pFniODg55PSaHc/12NjmpFhR1Rg7mwuNQB7T+djPZSBkKX8pmFiGKx0HZx0PBiIMxvmcBuuf5cWhwlLiW8MXh+fI1OtVwZapVMaXtM6eAmxWmyOpdoF+ZkkutzJmoGCoOS50XI+EGIftIMc/0mTZnjjZwP5p3PkuCkxrSP+kX8/bLSyhof8cOVsSuJgV3FlILoblMRm5h6V+dd8RjTeBDxGJOq8gxeih6Rni4PFVk19ywwS/R8WlgD7WcYnPoaCctb7MSlMMyS++uqbtPz3VHM0ws3ogXQK99Fi1okIZCEm7EF96QcloRTUMea2QJQnwW3KBW/w11kw0ZGpQ38RHymZDdoFdfvgzHv9sbCBbb3B9WUdrfpHrj7GUncTLARdOmGkzZ5F0o2agjANaZcydopxE36ev+XcA9lu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(38100700002)(2616005)(4326008)(186003)(83380400001)(36756003)(82960400001)(8676002)(66946007)(66556008)(26005)(66476007)(966005)(6506007)(508600001)(53546011)(6486002)(31696002)(316002)(6512007)(8936002)(5660300002)(2906002)(86362001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldNMEw3Wm5ZUXRRN2YzYkRwbFprM3cxNVRCWElaV1lCelRYc2RPMllqcGZK?=
 =?utf-8?B?alczTmFpbVJQL2VJckxwY0oyUndLQU1SdGVpdVhxZWFiYlpnRU96MGtMY0lk?=
 =?utf-8?B?NmxwU2ZjUzZlZEREVHVGR2tzRGtoMml1SFFZNDJMbGUzYlFoV2ZiVjBZNVJa?=
 =?utf-8?B?dFZsNGl5TEtMRDNoclE3Q045RlJ0V0IvYmxvdWtLM050RXJBZ0gxZEtUM1dB?=
 =?utf-8?B?SUdsYnI5U2pXR3pYbkYvQVh4OWZkcUl4Vk1rbk5HUWZPSXE5d1RUSGU0eDli?=
 =?utf-8?B?SFNrOFpQVk4xS0tYcWVrZzJvMVdrNUwrSGxBVWtERzZmalRYTjdnS1FHb3Yw?=
 =?utf-8?B?c2sxcGQwT3RNNkxlMnBpWEVEeXlVWjB5and5eEdMTHU0b0ZmaWNJRDBPT0N1?=
 =?utf-8?B?RzZNanY2ell1SUQ3UlJxNHBpMUxpbWJNVFd0d0NiZWp1RncxSEZkRHorS3Z0?=
 =?utf-8?B?SEJYZ3NmWWdqb3N6WjhFS1hwUlFWbVJvZ2UrMFBlWDNNbkdpS1A4aXVYQ1N2?=
 =?utf-8?B?TGYwM1VwL2xTQmxrQVJSLzJCeEpmVTRKTmZGUFBZTkJzZ3VrRExIenJ4OC80?=
 =?utf-8?B?VFl2L0lleEh0Z0QxcXNzSEd4S09hL2Z0aHdMb0hvYUozaEVjbzZwVWV5T0gv?=
 =?utf-8?B?M1dEN2V2M0s2RmR4UFBYZDRvM1Nid1FFQ0gyT3BCSEJsYnRsTGRJc2VZcFQ5?=
 =?utf-8?B?ZVJPeW1uazNDQXBHY1h3WW11VmFoRFBHUFdLOUNPQVl2MjZLQUdWWkcyN0tL?=
 =?utf-8?B?dTllVjJUUUhRR01tZW9SRldibERDeEE3b0paT2Q5dy9UNGFZV2Q2dkZKcUR4?=
 =?utf-8?B?eUJHZjN3MUovTnYrenJOR0lDamhNZDdyZTZKUThXbVpFSWRKZ2RFUUdPdWsx?=
 =?utf-8?B?cGFPVUdDVWxuTXd2S2FmdDlrdmNPL1FlUkJ5MnFiZFkrcldRRTc1VVUvcE9K?=
 =?utf-8?B?WGxaZXFQaDkrRDBmVFp6T0ZFS0lMbWZ5aVlPNWwvM0syZGl3a0VscjJoQk9F?=
 =?utf-8?B?MmJjRlpHK1plMmlKaC9HVTA5WG9Jd2NlNCtSVDdFclBGVUdHVGd5amswWmQz?=
 =?utf-8?B?cm1pc1pUdS83MjBmNHdRcmZnNWZRUW5ybWFWbTUrZGZqY0VyMVJuUkFDV1Zq?=
 =?utf-8?B?eXBaSjErdXIySlVQL0tyWmRhdkMwSU5SeldnMW9tWFVNdXBJVTkzcHFXbDRt?=
 =?utf-8?B?WWM4bXJROHNkMzFTWWlna2YvTzBBUHlWcTB1OHVLYVd1ZkNOTzVvOE1WVGRx?=
 =?utf-8?B?SjhmbS9KZUc4NitLdGhwT2d1MllHUm5sU2pNODVHd2txdE9BTDR3KzJ0Rmds?=
 =?utf-8?B?NmUrclhGNXZVTGtPWGpZUUk4VnhTMEZkejY0V09oWUMwNzZFT3Jsck1qdG9u?=
 =?utf-8?B?UVVXZDNlbjhjc0dJemhFcUxFc1lZbmtvMzFZRUhacE9ERk9SbU9abU9xK0My?=
 =?utf-8?B?VktsU0xFdU5yM3JmT2p2Y0ppOVdRME9QQ2RQVWZZcUVXd1YrUDU4Z2xoaldQ?=
 =?utf-8?B?YlBCcEJGNTViK3J2R0daRll2cGpuV0lFeGp3WUtnc1hJRTZlaDhDYktSV2J0?=
 =?utf-8?B?blplZ2FDd2dXTTZoUEljNzNLdStjR0hOYXZ1cG5XVkhZUHA4K2l3eC9uMnlB?=
 =?utf-8?B?VVZVOXlOOExGZGxRendrOFZMZmlaVlBRVi9NbmZoUlUzblM4ZThvK2pYRGt2?=
 =?utf-8?B?QnVhcklZQjRHQXltc1ZhRk16N05OTGtVc05uVGtkTEFieGFpVVlaR0dGd0hm?=
 =?utf-8?B?bDl3ejdZdExDcnRaWFd4ZkEzTGEvT1B4MGZKdkRucVpoM2ZpZU03MkZ3QWI1?=
 =?utf-8?B?WGsvVTVxdHk1VlA5R1JqdUg4czN6YitPLzYvd1RSeFRQWmNkbGd2NkhGK25S?=
 =?utf-8?B?SEJPaVJITVA1UTJqWFZvSUVBMUFMOGpJWVZvc1ZQWENZRmxpcTlCWnhxWHcw?=
 =?utf-8?B?dDFIVHU3NUw5MHFnMTJnOWxNVW9EQnYvaGZxVkViMzk2M2FXYnArcytmR2s2?=
 =?utf-8?B?Z2xYektFbndFY0pvNFcvZkJNbDJMUXVGcXBEeG96cHNIYkxGaWdxS1lvM3NR?=
 =?utf-8?B?NzFldUxsMGIyWjNjTW5VOFVJOWoxelhEbHpCdWRocHNHOG9WTjl3aVdQR3I1?=
 =?utf-8?B?eTdoK2twU0FpNjdFT0lmU005RS9hd09Kek11eE9RM0NIMVo3R0M1N0xpL2hz?=
 =?utf-8?B?bHJtMGVFUGRhbGl1UGJXUXRoVjdLZ2J3U2V0dGlDTURmTUkzYllSbklaN1N5?=
 =?utf-8?Q?FRVnqAI7wOBRwmw0tI/bSWJnGo3mXN4E0PERQs7U0k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1ec86-4c45-46ab-284e-08da02d913c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:00:59.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DC/1zGZ6AarkzROBFN2Tb7xGT1BqFCjQhlXKP9jxBuVQ6+z1CwpDoCvL5rVIXdFIIhQdNX4jX7vg/nEL9uB2cOh7Ltjgn9WrDhFQaNA+oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1969
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

On 3/9/2022 4:24 PM, Dave Hansen wrote:
> 
> I assume that splat is because 0day found a CPU which doesn't support
> XGETBV1.  Since fpu_state_size_dynamic() only ever returns true on
> XGETBV1 systems so it works as a proxy for checking XGETBV1 support.
> 
> Right? >
> If so, then fpu_state_size_dynamic() is a *bit* of an oblique way to
> check for XGETBV1 support.
> > Why don't we do a good old:
> 
> 	cpu_feature_enabled(X86_FEATURE_XGETBV1)
> 
> check?

Agreed, checking XGETBV1 support is the reason for this, so this looks 
to be straightforward here.

> 
> Also, did we get the asm constraints wrong on xgetbv()?  Surely we
> shouldn't be allowing the compiler to reorder it.  Do we need a "memory"
> constraint?

I think this is a good point. Perhaps x{get|set}bv() may follow this 
change [1] to prevent any reordering.

BTW, now I'm suspicious of this JMP as patched at runtime with 
fpu_state_size_dynamic():

   22:   eb 01                    jmp    0x25
   24:   c3                       retq
   25:   b9 01 00 00 00           mov    $0x1,%ecx
   2a:*  0f 01 d0                 xgetbv           <-- trapping instruction

Still, the question is, if so, why it was patched on non-XFD systems. 
Let me analyze the case a bit further with 0day folks.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa5cacdc29d76a005cbbee018a47faa6e724dd2d
