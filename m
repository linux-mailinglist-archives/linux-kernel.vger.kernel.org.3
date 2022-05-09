Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7151451F31C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiEIDw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiEIDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:43:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7FAFACC
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652067554; x=1683603554;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L8UCuUjgLvny8mNVji9RxFKckqCUhb2Eya8DP1o/y+Q=;
  b=IttWfwmE/PN0LWUbMKLv8wZjYMXf8PeNpnSen/B2hdaI4W2UZ0MjVJNP
   4n33dEDWDGwyK4g1lRsPz2R3rCGOEw/HjPSqEg4dY+THmn5TWgvqQsbBY
   EzgRaZwc1Ox9STPT6PTeJkYjB0WDzGT4L77rgIcJSufG3swyvooS1ZdSN
   aWd+rR+19sWyAYn6bXWGYoaBryRQuELC0lgi/u70TG3kjKgngcu7gbTVF
   iZKqE5KjjlhbJZ6JKs0OJF2ZsR45z60V6It1N+xjOImbonijVbEPkNVU9
   pk8IwQXdkFCupynQy47yLFfxPXFWIYI6R0L9Qd9TK9+hwB7W1qSR6WRJQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="256457668"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="256457668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="696179442"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2022 20:39:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:39:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:39:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 8 May 2022 20:39:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 8 May 2022 20:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3WNYnq6EPqeVvp/OtQ5teZ6z9tQszHiPfkjqRN4XZUrMawbYfLta+y/HFUNrzBYXiAeJ+YcCSFunOtuhkFGXF3blzh+nEsNd8UOSZrMsnags4sjlGem0O1PhEEvAsvhNr0H6E6N6lKEAm6YdjevyTA5bFTurIG9ZiXqI+g85P4XjBHnC056f17/u9UkeylFGU++Kiswqi2cUqD6sy982z6CkXcE3TW/7HnBv40vHmLJihwsRYpz2/ijYgaRAVHeH1uZIAcFZ7MDOBLcPR+mZeiMhN8Ul1uTu2ldb9ik1NSPj6mcBFb/K1aLixu5tY1sBGXjLN16trYnT2XFOCSRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIE7M2gwrxLEAzjg+BLpxiYwLXoy1ZxE3qwVOdsQua8=;
 b=Ig4xy/0KPvBLaFi3uqY8BydTtLIRWwN7+Orevqt1+OkTLOVLzAvyGtsy6PBRn7X/Bw9ZHhpIupvZS7KUjb1uzKSd7oIKqdZNIQ48QNY50kxChBA5PrxL37fn4mqOaMJ8KaK7kd8bH/rezglSpmx2XSpLKnyO9I9gLcTjNyNuBp1vwIPUh+Pfd4GhfVZmceEE7shL5XSSmDHyVaCuzG8fli5/44GdtfafsQ4I+x5/PoeDLa5mEY7CS3Z3X6UxLITdfMylCDAjIxJuv2hGJHe9g+b2mWjKx9xiabCwju4pChBm6zf5lo+oOV0vLhZNZWaQQsy2LK9d/qYVo3cg7kiTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB2734.namprd11.prod.outlook.com (2603:10b6:805:59::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 03:39:03 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 03:39:03 +0000
Message-ID: <4ac03ac6-0c5b-041d-291f-3567d14bc929@intel.com>
Date:   Mon, 9 May 2022 11:38:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [allisonhenderson-xfs-work:xfs-5.19-compose_pptrs 32/32]
 fs/xfs/xfs_parent_utils.c: xfs_da_btree.h is included more than once.
References: <202205080555.qIhiigog-lkp@intel.com>
Content-Language: en-US
To:     Allison Henderson <allison.henderson@oracle.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kbuild-all@lists.01.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205080555.qIhiigog-lkp@intel.com>
X-Forwarded-Message-Id: <202205080555.qIhiigog-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e903ec86-35c0-4eb4-d980-08da316d7604
X-MS-TrafficTypeDiagnostic: SN6PR11MB2734:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2734EE59B3C896B2C986B7CAFBC69@SN6PR11MB2734.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l//1wHuk6XPY3tNeJuCmywc6Oay7K3D+aJC38qkZapfOrZQMcNhNL5p6PAiAXob4jezR5I//W+goDl7B+WlTYFYEqwen79Ks3xoQPT89LmMkTshNurNuulWYLdV+1XRFGFuxz1ulmgVlI3o2dDp2Zi+PaSaNk1a3Ic/KAIQ5uw1s1QDSVDKqvn8KjAn++1YTEhdo6TSs/5a1VU8idtscaPOLB4T0dMEGi5M++KCBtKP5DhttBB/ncJPiQUTTLU9FPAuY8Dztn6tuCoXm14tXr9a48n+nDV7LTGMnhj72kURfWshK0tnWLLp7JOn1CGwqEN/RUGZbpu3WAvca6/H7yt4mgpwt2dnFPkqTjnzO24ZdYhvk5PRzTlkK/e15bEGG0rX+oaJF7XqW2pC/NeBm6onWOPvi42GD6zD7HfXBuopLUfCsnWdOHyOSLmZBpFzB9qMVLO7Pe5Uv83YwXi9OO/GIRexatbXueP0jdM52ZFuHhNQBGJOdXmLUosE6fZ0VI3AMO/RrQPyF/f0gMgV5cwSBfhxovUN0+VHRLKoHa+Lq+8RVuRn/SB4sBb0sUyANQh7goqFxaL+1IqnjcZdJ6nuML8pj4Wv9c9qY25ntykcu48Wl82nGQBdZ0JvB4szb2iK0/ksa6P2S5BTf3O0NjXpejhbhmaScmVx+58hZykFHme+2ee1C5YUVgRyEMRy35332mgojaWMkPYx3dclm03BkkhTaG2CrdL80+kAH+scrWuIVX+aJDrvJTcubRgrHKJ2YubqkaJeKLRTAOzAPtp4yOxRrF0zEVCn9+MaqvScU/7qy8wr9mbcgo4eKJoYZVPZwmBymxd4zRoupyjeEZtXRSRYC9gIRpKuIBU9HFo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(316002)(966005)(26005)(6512007)(508600001)(66556008)(6486002)(66476007)(186003)(6666004)(2906002)(4326008)(8676002)(31696002)(6916009)(82960400001)(86362001)(38100700002)(2616005)(31686004)(8936002)(6506007)(83380400001)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NML09ud2kvaGI5NlQrZ2dNazdEVjNJeEFycFZzUVR6bk5Zb2hxNTFlZ2Nv?=
 =?utf-8?B?SStGQk40eDhHS0N4TG1ZVDNtN1Q3K2U0VG1IZnFXWFJPMmMzNVJROG9QRG9j?=
 =?utf-8?B?bnp3aFpvVFZJdTl2eGtwaGIrbGhyZjVwenNweFZzc2tGWHFjU1oyN294SHNk?=
 =?utf-8?B?Q3NtTVFsOVBLR1NrSjIrYm4rUlpBR2tmRkFmVDJoQXNsN1FDaXVqTFJyUTla?=
 =?utf-8?B?NE0wVm04aWFERmZRalhZZzhmZ3ArK2prUUloS3BCUnMyT3VBalBIQkF0clBq?=
 =?utf-8?B?a2RqRXJhQnMzTStPSVFyTkRCOU5yd1JIMlFHVk1OTUE5SkhpZVplLzljZUdK?=
 =?utf-8?B?YytHNzRpQWx3bTVNSUhtS0xEWFlXWVRGYW1jVnRGU20zMnF4R1Z3R2hDVE55?=
 =?utf-8?B?UVh1U00zeUdSaFZUaHNwenRGWk92WHJ3VFlGa1gvOFMxakNrSGIwTHR0UXo0?=
 =?utf-8?B?d25KMzRRbHB3ZzRGcWc4NE43SWRVSG5NZm9obElFMFoyZ1pLK0pQUzFha2Fy?=
 =?utf-8?B?NjdVUHZCU3BxaVkva2YzazY2WTlrd25sZFBTa085NFVRb2xOblNIWkhHQXZC?=
 =?utf-8?B?Rk9ERGRLTXJrNFFrVFJWbzU2aTNmWGJxUlNWZUFCK3VWQUd5RmVjdmhBRTc1?=
 =?utf-8?B?N1J6cVlpRGpidkhvSnlLRTlQeUFGRVFrMFlXNGF2ajMvbldvNDk5ZzV3N3Uy?=
 =?utf-8?B?cUNRSDdaSVZ2RkZCY3pEVFJQNnR2OGR1RGN2NDMwTUNaSE5kTHlGdFdRM3FU?=
 =?utf-8?B?Nk9CQ2RCWkRqY1FDc1FraW5JckhUaFRuQlB3K1VZWHV5Q1ZJTnA0Q0MyTFlz?=
 =?utf-8?B?RHZ4c0czdmxQQjNMR3BsTW5jbkVEQnhNemQxL3NBc2ZNT0hXU1F2L2srcUo5?=
 =?utf-8?B?OGlKUEI5TTEvY1JBVzZqdUZYRklORWlBV0ZvdllCYThuZzJVai9OT3krRE83?=
 =?utf-8?B?UzhWNHFYaUUyNHJiY3A0NEpNZUhrc01EcjBKdFpKNUd2QVEvN242WFZUWW5z?=
 =?utf-8?B?dnBWeGhaVm9GQmlSaWpOTFdzVU1XMlltWUxYUW9hNjdXc3J4Qk5GbWdzZ1d0?=
 =?utf-8?B?TDM1Y3JYV1BGR0pQNi9oMVl0RVNabnRFbzI0dlpzVVY1bFVNNXM1dU92aVlz?=
 =?utf-8?B?SitOWXV5MG51WkMyUmdpNEVMR0Y3ZW9EWk0yOTRRMVpvRDUwTVNLRXR6M3VH?=
 =?utf-8?B?eEV3QzdqWjBULzNCem9tZ3l1US81Z0NhYnJ4SlUxMGg2eXMyRVoyc2UwTUxq?=
 =?utf-8?B?Ti9rZW55NXZYUzlmNVhxTWczdXBhenc0ZFhOY0dwd3crNWR1MmF2MUV5K1dj?=
 =?utf-8?B?V3J0eDdSaU05WDhUQjV2MVJIQmdTeXdtNXFUMk40amIwVDdRQTArVkkvMGc1?=
 =?utf-8?B?K3c5ZEh0ZEg3a0FDVWlyVTNmSG9uZ0lYTTU2SjloWEFiYWRKZkRPdEU2VkJx?=
 =?utf-8?B?bTd5TXhIWHkwVzFWVzY0YzdCd0gwN0NnU2FzZzhjYjN5RWNYemtLZW9JRDcv?=
 =?utf-8?B?cWxacDRMdENWcXFwNHJIYkV1UWVnbE1FYWFjVkMvN1krWC9rQ0xsdUhhc0lW?=
 =?utf-8?B?MzdqRldoVlE4WEJrM25ERFlaVHVLa0VjQkpqYmFIc2Vhak1oVktCSEtQM3pZ?=
 =?utf-8?B?cUQ2UHQxcytjdVQydCtQR0JXMnRDZHlCNjVWTkVoaVltTzZJV0RYdldzVmta?=
 =?utf-8?B?TzRtY2VMSENtc0U3elZpMjJKb3dVQVZkY0x5cFVpNG95TkU5M0FZNXc3Wmx3?=
 =?utf-8?B?MW50bmRmbkE2WjBzQ295OGJGdXZ6MTA4MXZpVzFjOVRDbGhUQnFtUnlnbGsy?=
 =?utf-8?B?QllmZmIzWVM2OU8xNzBrWktRQTBIT3ZIdnQ5TjhlL3BmL0o3SndYWmoxZ3FZ?=
 =?utf-8?B?TWM1Y25JckxDV0J4Y05HNGN5MVF6eVJndnA2RkNobytSeVpkVmJzWldsLzR1?=
 =?utf-8?B?TEpLU25SRDNNazNQVEJNcUZDWVB4MjA4MXNUT20wVmRPc0tjN05IQkVjcVVX?=
 =?utf-8?B?RHBPWUQ3ajEzNU15U0FpVUk1MklONmM3OXdxbkxKZUNsa1oreDBiems2V1BP?=
 =?utf-8?B?SXhOb1EwYjNrTkFWYmdSbHh1dGZXd0tLczBuRzd6NE85alRFYklmaTVQbDdu?=
 =?utf-8?B?N09hYXhZQVpMNk1JT0E2OGdPZnNwZTJINTBFdm1URExnS1lyeEhQaHNzM2NI?=
 =?utf-8?B?ZGdCeTlkMkJXbVV6Q3U0bExTdm9OZnRZMEk0NSs2VkVlcXFyNlB4cWk2d3pr?=
 =?utf-8?B?dDlVOWhKang5cFk5b2RuTXd5VzJCME45SE84SGxTNENvRWNUMzJUMmVXWE1C?=
 =?utf-8?B?RnR5Q1RKQW9OTTZGZ0d2U2hRNWN3U00xWlNnVzBnQlVpTlJVcXF1dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e903ec86-35c0-4eb4-d980-08da316d7604
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 03:39:03.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTYgVQ9R9e/WbwTrElRrB4g4ENsUB/opfzfVC4oK5WQc8gnf55AXIbX3/XnshSnLCkgozOMqRDF9yKMS8WJ0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2734
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git xfs-5.19-compose_pptrs
head:   74ecccf0e89a132c2490f3a63661c535974c6a08
commit: 74ecccf0e89a132c2490f3a63661c535974c6a08 [32/32] xfs: Add parent pointer ioctl
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> fs/xfs/xfs_parent_utils.c: xfs_da_btree.h is included more than once.

74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  17) #include "xfs.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  18) #include "xfs_fs.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  19) #include "xfs_format.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  20) #include "xfs_log_format.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  21) #include "xfs_shared.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  22) #include "xfs_trans_resv.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  23) #include "xfs_mount.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  24) #include "xfs_bmap_btree.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  25) #include "xfs_inode.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  26) #include "xfs_error.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  27) #include "xfs_trace.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  28) #include "xfs_trans.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  29) #include "xfs_da_format.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700 @30) #include "xfs_da_btree.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  31) #include "xfs_attr.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  32) #include "xfs_ioctl.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700  33) #include "xfs_parent.h"
74ecccf0e89a1 (Allison Henderson 2021-07-23 16:44:42 -0700 @34) #include "xfs_da_btree.h"

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
