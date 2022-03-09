Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781744D31AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiCIPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCIPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:22:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7327664D;
        Wed,  9 Mar 2022 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646839283; x=1678375283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bO8okl1hmxh4t43D2Dtv8xfBbsfAGq22v5BCdLm8u9Y=;
  b=RNxBVgstbJHZ15/dLji3qp1t5vUh3Khf/0SlXa8ZNnHPmiwHz5DL2Vuk
   6GzNgXRGHbB4S+zSgNT9324OSQFeos8zlDiQvoeu2Jjovbw5cRaftjKyf
   zCHrLwXuzjZgaGtciQiOI2TdHIFwCfUId6u1RBMZF4xspzkBKPRCCBLP0
   Lm8mPyk6A5el5SaJTQ8vjLrhVhLLCdvEU8JAhf423XvMdPPr0n/hBXHoA
   Ucfo93lmyKio8NM0J5k3NZi10AGHTruNtOtUnbTyYiw3bGrw5IXy0yJH5
   ArL60GVgoAc/PXD+G6fe41J+xXSqfg2DJOeZEwo3ss0GP971No8cyje+c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279726140"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="279726140"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 07:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="578415173"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 07:21:21 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 07:21:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 07:21:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 07:21:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYFn0+2lsXeK274rp1vN0P7KpXU1HEXUaBIYhVWNd9zWLEWxkQHnZWfnrRDjTrI1cazgbkGjgcwqTF73O0Q4BMsQERvs0aeCz00qBsXIwWoes++L2lVL3qJ56v5Wh59OYNAhxUYy2iWVa/NTQc2L+rI3gDcPOQMqnuppt7903Wpa4AtblC+gKAhdkWRVVxLPYgRI/rnUdfVhgidHbWdKBN0YEI5FffbZnSWp7KMSr1GTUJ+pH29gyBek9Q/zsDHWnQ5GCd5fcOnlp1MHjJqqA7kthtsZPUlF0qc2gk96GEKzhwzUnwfCsgXaf6MWBX5JOHm8P94MzwUpZNrlAXm7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5KmzjRBdgbatTozem42m5aDHK2Dqi2ojWO2q7oq5B4=;
 b=dtydwFUl4t2Xb2r4diqZwH55pO71OSGdO63YpfNbUgeZGMB0s87l3ivtX+yAK3seW3pfXvYFYaqlr8US5d9cOM9E0e1/koi0BbMNFJVeVROqaLoefjmA/4dXBTNn7iwlXBltTlaSxUDe2Wmo9aAOHseHiFAYV3thN5/E+NJFsoD1Sh5EnUZkFyXdhbfwIKqVvpPo9CP5FaO9G/OPPsHGuqfO9OfkTuqYWjWVWRUQV38DJF7W/jV0B3Ony1VXUCYY0nNW99oMHL9FoNSvpmO0TymJyVTpqobys685Obu2yW87d/ve/l29HQPbyhmIGpdnOwNuEu9MT1MWMZteD5dRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CY4PR1101MB2071.namprd11.prod.outlook.com (2603:10b6:910:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 15:21:17 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 15:21:17 +0000
Message-ID: <a52f9cfb-818f-6ed9-42aa-1385584c8103@intel.com>
Date:   Wed, 9 Mar 2022 16:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: Re: Bisected regression: 4287509b4d21 causes HP Spectre 14t-ea100 to
 overheat while suspended
Content-Language: en-US
To:     Philippe Troin <phil@fifi.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <e1b3112fd6c8c889408915e9a849301d13acf2f1.camel@fifi.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <e1b3112fd6c8c889408915e9a849301d13acf2f1.camel@fifi.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99d3ba1a-d8a4-46db-f237-08da01e074e9
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2071:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2071ED25A6969689FD2CEE4ECB0A9@CY4PR1101MB2071.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlGoKrpUvH/08Bs9wScY8iFvmXpmqfghkOHjtXfb16AQC97tAXQYTo7jfufeWKzRz8s4sPfapCEzZRgjcdJnJ/z5PqzEAYDCyL9JHfIJyMsNDe0dnXgnR/FR/1/n2OU8/B8xrIMQ3CmHGMvHqOpamdkw29i2CpQilejx0Ruie9pul0GZJtx+01qDXvIR6SilgZmBTZxFmqHIPvh1Q+Wzlt8YUwY6mQP2zAjLTgq8CLbhBG1ZbEgQCSk7hg85V9MPmELE6N+kRMMt27ztD+NbvE1HMoWCvYSttkVwSWV4MUMFwKqz8toQgoEoJr2FGZmXMMfR21HWPTwVTwIv0nXrIOKhJBmwBSYOwQrSswCjgQ1NzblMO0RYnNxKCbWvOmPswlR2IsaC1i4DidUzSNeUMr0L5CkBUiAIdo0a+IGcnbXBQlaDeFKSQPh2GqpnT70Lb3HQaKKYHa2I+dFDWygjoT2iZTvfL1RKo1epS/P8THHCPb1X77323tdLQXmK+fsts8B/Qpx+nIAfzsRSlpk/xDGzvp5xfFpzNn3ST20jPBO6CdH5uis1gv49jN9RYBF/3zzV76i85IeV5HcfcPPKcIp63tYdX/n3zvknjPlCzoHEPxnpr6xS25fiGaM8jcL2F86e9SwoLa9gc3/d58rTBjTaYxc7Ma54zo4+swUlue/KatoiFnOr3giHz0dL833p85WpdSNdLfcjam4vpyFCQKoadxigZ3D2B22BdaqvY4HYHJasAE6qk0zT02kJI1hXguVLhB3Fx0wmiFBRsrtdQbPOwy8OzQT3b3wFvbKXF/XtSIPQdRQaLZa219aXwLB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6486002)(6512007)(53546011)(508600001)(966005)(6666004)(6506007)(36916002)(186003)(83380400001)(82960400001)(66476007)(86362001)(2616005)(26005)(8936002)(5660300002)(31686004)(4326008)(8676002)(66556008)(66946007)(36756003)(15650500001)(4744005)(2906002)(6916009)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpvU1JnRTVxV1lCallCaVg0cWZuQ21VdTFoeUdjbkRRTU12Sk1xVUNtMzBj?=
 =?utf-8?B?Z214VUhiU1U0SEFhTWVqM3BTbUYyQ1hpemZjUDMyR055ZlNzcXdFeHAvc3Rz?=
 =?utf-8?B?czZpY21zVHBmS1RnZHFwSjdyL3k5aXVaVWZxenVRSmFYc29JU0kvQ2hhbGZY?=
 =?utf-8?B?TWJqWDRRbnMxSFpUNEloR1Vqdi9tYzNKMDBDbXpocUVDcGo1c2VzeWxpeFZu?=
 =?utf-8?B?UW9WT0hVemdCTzN4L09jQjZFUWpESy9BTXg4RitkN1lnQ2wyRjJ5ODJZNmt4?=
 =?utf-8?B?THIvT1hCcDdJbWcxTEc3OUN6bGJKMjRwT2JYN0ZTZXR5OG9NTGp6RzUxdEtO?=
 =?utf-8?B?SjdVbzJhQnY1bGhaUUVwdzhTNk94ZGdoYWpSRURMK1dCdW1aMWMxcUZxRUt0?=
 =?utf-8?B?eXg0QTA1bkdINFI5YVlyWXQ5dmRuUjBNNFN1N0JSTVkzZ0ZiQ0ZkZUV5M0My?=
 =?utf-8?B?bE9KYUFmUVNyUzZkNmVTRUFMeXZES1NvQ2Z1eUdtRmhwN2szT2lKNkI1T2l6?=
 =?utf-8?B?T0dUVzcvdjRHb0F4ZExmYjc4T0VjZmZYMDNUNkdtQStkV3gyR2pxUVBOdUFs?=
 =?utf-8?B?aTI1V2R3RHJ1S2k2SFJxMGJBTENPbER0S1oxS0NvM25mQ3B4bDkrc09TOTdF?=
 =?utf-8?B?Z0o2VGpmdWkwRVh0NFNqMzU4MXNWRnpXQkFrK2Y4ZndpalIydEdyMlV3WWpH?=
 =?utf-8?B?a1RBNkZGQnNKei9BeXExTkNwRS9MeVlKMUx6ZG4wSmVBQkE1b2cyTExQM0pE?=
 =?utf-8?B?RHdjTDcxYUFlWFcwcDNtKzN1V2tKaThBK3hWZ0JKczZWRjVvOXc2b2s4anow?=
 =?utf-8?B?emg5aTRqT21oRjkxb2JmckVqcGFEOTF2amE4SFFiNXZ5K01qUFM5K0U4LzU5?=
 =?utf-8?B?ZTcvSlhVRVVIRytkOHNWOWtBQjE5Ykk4SnZ0TXJIaWlZOEt2cVdEd05GbXo3?=
 =?utf-8?B?c1ROY01LN0toUnVjZlN4ZUdBc01IWkJJandpMWVWSGVXM3RZRWIyV2s1ZGJr?=
 =?utf-8?B?L21hcVhkM0l3RlRmcCtpVnpFSUt1cks4UVRBQm9DejllaWZHYnJxRmdKODF1?=
 =?utf-8?B?S200Z1AvV3FGZFoycGRsbzVEQ2g1N1FEajZtYjZLcExyR1BON3p6OXlkUGR0?=
 =?utf-8?B?cHRkVkIybzhqMUE4Zm10dk51VE54RldZQlZBUlF5UUVNLytvVURBYkpQczJi?=
 =?utf-8?B?M3hMWUdYOTlmZ0RiQzhNUkJHSHU0N3dHbE5yWlNHb1ZtVW82dDBNdVlBVkhL?=
 =?utf-8?B?VVhScEtyakd3UVN5TEIrKzR2WWdta3NscXhaWXRiSEF3YS82M0taTkgwb0FM?=
 =?utf-8?B?VG5ZV1A0cDlMWWJYMDlJQ1hhSWdPY24rejUxNUx6VVBmai8zTll3Z281bUth?=
 =?utf-8?B?RVgrNE1tQm43V2lJdnhSMGluTkdqMDdlb2Q0VjNXN3g2SEh0YlZTdnVFemhE?=
 =?utf-8?B?LzhCOVRMNmt4aVFsTFRhRkpQN3lkV05ickZvTjN5aklGM3kzdTNXYmQxNTBN?=
 =?utf-8?B?UVowcnJUWG1KdFJmUXIxUUhzczEvRDRCbWFnQUdWcmhWVExIZG1iQXZ5bGNH?=
 =?utf-8?B?aTFxVTB3dUN0WDFzYUZ0ZmtzQ1YzZ3N1THNkcWM3Qm1KSmlML01uU3MyTndw?=
 =?utf-8?B?Rm1Dc2pVVzNIOWVuNWYyOHdzaUw0bVdTVnlFdDd0NzV5Z2owUmtJWmZzZUFj?=
 =?utf-8?B?SEcxY0ZoVDlJNGpsTkd0bE1TK3Z1RHIwREFWdzNzOEJEdVRSZ0tHRjR2YjJM?=
 =?utf-8?B?WjB0a3EreW1OVm5Xd3VwUUUxalFpMUhYQVRPOXRnSk1FaGNCQ1R6ZWRoTjJn?=
 =?utf-8?B?WlJNb3BDVnhoeGRZNmpiTHdBNC94TnROUFpNZElMK2NxSVZHZFJXeWp4ZjBJ?=
 =?utf-8?B?TzlOOUhPT3dMbnNObngyTWcyOGR0Rk1mVFRxemUyY2tWZkhUT0dRRVl6MzZ2?=
 =?utf-8?B?WnkyZUMvQzV4UGNnQlVSMk1vWXAxVDhFbk9tWXZ1NDZXTElEeFEwYmNIR2Iw?=
 =?utf-8?B?VTIzWnk2MS9RdzZhMW5LdTVKS2x1OFQwZUo1djY4c21RWXdtY05uSHBWU21D?=
 =?utf-8?B?L0oyS3YzL1JuL0xZZkwvaEFNS3RYZzM2K0RObm9jYTJ1Sm1mblp4UDRLTzhj?=
 =?utf-8?B?U2ZNZzRraUZudmVtTnNVS2dqclM3WVVYb29COUNNeEY5VUlCN3Fla0loVXRt?=
 =?utf-8?B?YzQ0TnB4bXQrTnl0Q3Z0MU9MWmR2NkhPMjJIcmRKaGcyV1JYMDFIUkUzZkV0?=
 =?utf-8?Q?Ali10iD0Oz5fs/9RTLfo0nT/mr86HB0OTxbmARmaSg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d3ba1a-d8a4-46db-f237-08da01e074e9
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 15:21:17.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AdoH2NEkOo0ewiBr6xW6rqgu9p8OexufefAwh7dj9ltgSelFUmJkmV/l/kooFmAutxbw8aWKNwogr1gcMramaExOQtAJcT30HF4O75a7JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2071
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2022 4:50 AM, Philippe Troin wrote:
> Linux 5.16.9 was working fine, but starting with 5.16.10 my main laptop
> has been overheating while suspended.
> I've also tried 5.16.11, 5.16.12 and 5.16.13 and they also show the
> same issue (overheating while suspended).
>
> I could not spot any difference between the dmesg messages issued
> during suspend between a working version (5.16.9) and the the broken
> ones (5.16.1[0-3]).
>
> I've bisected the regression down to commit 4287509b4d21
> https://lore.kernel.org/lkml/20220214092510.074083242@linuxfoundation.org/
>
> I have also tried reverting that change on top of 5.16.12, and the
> overheating behavior is gone.

OK, so it is not clear if this is a regression in -stable only or in the 
mainline.

Would it be possible to try 5.17-rc7 and see if the issue is still there?


