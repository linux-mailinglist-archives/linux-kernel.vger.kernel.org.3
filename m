Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989959EB53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiHWSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiHWSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:46:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA53B5A5B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661274601; x=1692810601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Spd/+/aRObGZKMkEg4Ep+CXDn8M9YscW5u8hcSGZAVU=;
  b=YyjgeyxpfCXz2h6PgDDBjJW/dwk9PJphsajC5IsWMDh4PpWOaRP7dvRH
   lyjPZn1FNQYBnU8uqHvx4PdoRCk4HTTbN4PKYQYBly27BNJ1HcK6ZpAff
   PRIwK51FTGuuxExUB0aaJecukQ3nFwi2ie8MK9+dAB6lnD/Lv05rMWIA+
   rfJgA8chT+F3VygTYbyRwyZKb0ob2RKtxYO7YWyBKpqzZbUX7c7rRi4Wk
   1vxS9Z+mUEBEQYqV5jUqnDyo5aNkc5Daedr14hcX9zBL/V4Zwjr3qpbC0
   osM/TmVVnPiYeUcxmiAlGaKzL50WHJxHatZqTT3Vshq9cKvymO1Oknjsq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292491162"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="292491162"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="670121493"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2022 10:10:00 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:10:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:09:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 10:09:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 10:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgNUomgAZ1d9CuLeNga9jJOEniv2w3Ejhby8zAnf7vIQbKGCyFNE1PtgEJKp4sP3HEN94l+7+zrLpa5qWZMJrxSxFFC7Kd7AMgDZHbPap4r3r7RBuAkHYrbJvtagAWN8YHqxE6i0fmnUPudqP2O7pad/NTrg1lQIbXKnkIEeOka85QfKj0gi8g+Yx6CDkrR9g15kdhP5W0tWqR6q+lzbSM/5ZhCueIFBW591nxisN5am129i07JEKtpxJU4+bRg75r3g78FQM1Yemflc+Gq9KmTJbWYNJM8uU+VwICiPHpC0H06pX7gEb+8mCRLg80yeyzdWtx6ZvNtwc+kf+zpRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/Fe+Mm/UdGGZTmjxQL0ujSbsVyjdINGBkysldXhxZU=;
 b=I8xQayOOcs4ndpehYBG15ZuTfzgJN78p04v8f2K3NVHZuZJYmcmeKBW6YK6BjdavND2WFihy6p9cs2sK0FlA6dz88e3l+717X7l3XPbIKIhEEp8lw070WbgE1suXcJWVZUcj3caMFJWaGNOZtycp8BsSh0FUpbiQs4PA3bUarb7DgbTukX7y4rOnK2ppWgJdaPuCRnbw/b/FjsJ+nNPr49JPkBnSZMSF6tvvLm2ZqnrbcOLZ0yVwrVKrApp51I4LjAfjqvEPPvxYqaUuuUddtZkE/ck/6U3hZ1U/CXB7y1/BSn3G21PfEMT2Gm3EjfuzezNeNHudzbpe+SJxB8OmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 17:09:56 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 17:09:56 +0000
Message-ID: <5adf4968-b079-2fd3-dd61-09ed16f74080@intel.com>
Date:   Tue, 23 Aug 2022 10:09:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-US
To:     <xhao@linux.alibaba.com>, James Morse <james.morse@arm.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>
References: <20220622164629.20795-1-james.morse@arm.com>
 <f5ab048c-4a3a-8292-8a08-5fdaff739381@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f5ab048c-4a3a-8292-8a08-5fdaff739381@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b8c876-e588-4770-170c-08da852a4db7
X-MS-TrafficTypeDiagnostic: SN7PR11MB6946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub/PA5cwjY88bPm/Rf4wf3auXtqUTStILiV1+dcahOt8H1ZVHH+rX1vsFqkqaPvQh1EL5QhzVRAnxuoCE8jNaYoWsJVItdLvt6BfNgEPXLKo1O4bL0aNrKC178pDbazEneVZBbyjM2Ui13xdeE3wX0nL78wlqQBfAfmO1gFOZ9eQfvhN/ztx3ITaQKO0b1DVqVB7IiVrA23L5oTZ0lNTqFRsO0+Y4mE30VQFDzbT6Eiza1u1aQvNqOu+ukxcayv8fnedJVveOTW9tr0ebGoLUFkpP+gJGbN3vhl0Nrq/jegUxpb6Khtg1RCNX+w1z7Nfaq3dOqYBlNs1IZNFCf35/Dc9cF8yXdtWvw48a2eSq0sxy6N2iMOcpV8twz7UHBfpfYaAf5UnUB16XiCrhUwzqXBPPW9afAW4031mBD9C3qUeqfVR3CrEKCXfp/xffz5lQRlEYqtMRhv42R6EBbfQGA5B9axtS2PJMPYndEPZ1mW8eTYqdozHzo3rAvKmk3PeaDwfHB6MULdaC9Nr6TAuo0UCgdYMIfGJYhW6gsmuZ72NsNK9ecyzcHyvBwJYOzG/MOQotMhaFWaWNpQNVX68vDaJjL7gRFSz88Plw3RKr+NyScvLnFZz1+5C7BaHiheOSd7SqaOX5xCKZkh6O52RonKWc3er5+4I0fYYxw3CvnJ4pJIZhEyOa92xs7WCjIS/mjIhSJ5LmWGnKIifaDtkXunNEyeQCgAAw1LaM2FVQ2kIL8Zb7IX6dOgy3JwEcGwm34h1IK0b3QI4G3QSVtpmTZnA90ctYHy7s7vUrhEUy3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(136003)(39860400002)(396003)(53546011)(6666004)(6506007)(2616005)(186003)(26005)(7416002)(6512007)(8936002)(5660300002)(44832011)(478600001)(31696002)(86362001)(36756003)(31686004)(6486002)(41300700001)(83380400001)(82960400001)(8676002)(54906003)(4326008)(2906002)(316002)(38100700002)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmdVRktkem53S0dkTUhUTWllY29SR2M4eG1ldDVhcmw4aHk2SWgzWDNpK1gx?=
 =?utf-8?B?OGp0RUNTVkVvTklGNnBlMFVyU3lXa2l6UHVORHJBQ20yREpmWnBjK3UzZHpw?=
 =?utf-8?B?eXdKckxRY0RId0UrdnMvQmxmY05JRlNNL01FZnJyK2lhb2pHdGMyT0VMclhK?=
 =?utf-8?B?NHpLeElZNGxwb0NJR25mbmVxVC9sMXpKbzlhV0REM0VFamZuVHRMT1FieVlU?=
 =?utf-8?B?empHMGVZdUpWc0R1ZjRJcjlrOERTNzk2ay8vcTJqVlR3V0NST3lvaWE4K0No?=
 =?utf-8?B?c0dOYkNDQnhvWjI4MG50Njh5aXgvYTRaazBub0ZGNmduVFBneDRJQVJsMTYy?=
 =?utf-8?B?OTBSMHhzS0pSY3docUpIMnNVR3hTZWZ2aERLS2hUNWRqZWgzZmFZR1RXckph?=
 =?utf-8?B?S2hDVWtOUllQeEsxU3VjN1pDdXNabWpSczN4Tm81QVExdWU1a3lleWk3dzVr?=
 =?utf-8?B?NHJrZmphbzB0SU45Wk10RTd0ZFNicmI1SzRIVU9WSU4xYnVZc01XSHBUVWh0?=
 =?utf-8?B?MUg5QUwxTzlUeWtsOUh2RXF3MzlvUXNiMlFlYnFxdC9aaFoweFJFd0dJUlI3?=
 =?utf-8?B?ZVk5ckZ2eHpERGdJckFMb3hVWW0rbFNIT2ZBa1BYOWxnSHBlUDA0T2c0c1J4?=
 =?utf-8?B?K0IxNlZ3WXcwamx3Y0Fmd2JzeEk2ZExVNnRnbkNyQzNFRUJ2U1BJR2Eyc2JM?=
 =?utf-8?B?WVpRTlRobWU4S2llNy9SaTk5c08vRElVVGxlVEI2alJGeXV5ak9GTW9ac0FE?=
 =?utf-8?B?SXNiRnRVUjRvNm5VaExFSitsVzdteGZhOUZXRG5ZK1hEWmdaMlR4MzVTWmJM?=
 =?utf-8?B?OGp4QnplaDFyZUVCbGJyNWhnQ1UvQmNQMlJNYTk0aDR0WTAyUElNU3BJQm0x?=
 =?utf-8?B?NTI0Y2dGa2g2Z2hCUXNMNDVkZklMVVRxQ3dXc0ZjdU5WT1kxbjhPWEFTYzY1?=
 =?utf-8?B?amN3bXhxbEpxN3dRZzE2YXV5akFidm1DQU9NTnRid3RXemxzTTl4a05xalFE?=
 =?utf-8?B?K1N3TU4xejdOTjhCenBQa3VDeXAwWFU1RjhLcDhUWWh0djZrN21WOUovbUEw?=
 =?utf-8?B?clUwZ20rSzA4Y3VkemlNdnBzRDRvVEZhRXF3aWVybHBCZW5FZXB1ZUtFb0Z5?=
 =?utf-8?B?cVBxNjVDR0orM3dXZHVjUWY2WGwwSmc0ODRRMjU1R0c2MFBKcUc3Y0RkRVI1?=
 =?utf-8?B?ZzF6MXpLZWxEWXc2c3lqUVFpWlpnRCs1cjhtY0FDcFNqelJLMlRYSFRYKzdQ?=
 =?utf-8?B?R0VTMWVOMlVsVXByVHhraitwYjJMdWtRdTBtZ2d3YStKRzVWemRTTjZ3b3E2?=
 =?utf-8?B?bW1BWk1sZ1Mrb1FHc1dTZEVwOEVXcFhDZjJ0a1p6ZmJJd1JrSDFnRVFuSFZS?=
 =?utf-8?B?VzQ1c1VuODNhZ1RjTkRuSG1rQXFkVlAzbVpFS3A1ZmxZZXVKZFljSFptSkxG?=
 =?utf-8?B?OGpXV0xFTXFUZ1BIQ05veGlYK2RjTExOdVpkelZUUFo4L1NXemhOU2tHRjhi?=
 =?utf-8?B?eWJKVlJaMWM4SnZkYXo2QkcxTXQzMXh6eFVmQUxsL3FzWmN5dGRVOVgrYlVZ?=
 =?utf-8?B?alR2Yzh0d2xSc0VyeFNzMlhvYWFJYnd1Zkpmd21NSk5zUjNKb1JwZ0JPY2hT?=
 =?utf-8?B?VmJvTVM2bW9MV3RSYllybk9Gc1g1R0VyRjVtOGJoR1Qrek9uZVc5eWtQbWNw?=
 =?utf-8?B?UE4zVForZitTSTEzWG13RCtCRlRRcFNFdThTZ3BlSjdHUXNhWmQ3SitWa0k5?=
 =?utf-8?B?NzJkRDRRWWM4N1dOeDR4NXdxUnk0alJkQStrNFlwa0FNVXo0NFZUNjE0Tkxa?=
 =?utf-8?B?dWdqcjhIUzQyQWpmMGtYMEtXUnVkL04zc2MzeTFKV3BkMzVCcDg1L1VJRDFa?=
 =?utf-8?B?OE5zKy9PVlZjVDBWSUVKNldHdTVER3oxSzY3MG1ISUdpMC8rdW0yL212K0N0?=
 =?utf-8?B?Umw0bzhjdHdYUWpSNFFITzQ4MXNlR29XVVE4eWRUMVVaU2JPSTJRUFA1ZHpq?=
 =?utf-8?B?U2lMdVRVYXFvZUREc1NHcVVaQ1hpRTlaWEY5ZC9YVXZjUi90Si9HUWI0SXpU?=
 =?utf-8?B?c216OXpyMExCaGEvUzlqZWVLSHlhYnIzRVFFSGh1OXJEV3pQcTdlRHc1UzNi?=
 =?utf-8?B?WnBOYzJlMG5mNm5WeVlSZDIvdlNXTUd6RDBTTTlSdHEveGhvbk5lNHBMWmR6?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b8c876-e588-4770-170c-08da852a4db7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 17:09:56.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvB53QSa6nmCKR8u20xP3g/sgJHCuc0Qg4Ij52YVLg4MXIyJZZEgPi8XglLQPhEEmdAecLrpAskSuZkRQGM630ZDriLppjUG2XkVoYj4+aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/3/2022 8:54 AM, Xin Hao wrote:
> Hi  james,
> 
> I have a review all of the patches, it looks goot to me, but i also test them once again, i have a little confusion with my test.
> 
> # mkdir p1
> 
> # echo "L3:0=001;1=001" > p1/schemata
> 
> # [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat schemata
>     MB:0=100;1=100
>     L3:0=001;1=001
> 
> # memhog -r1000000 1000m > /mnt/log &
> 
> [1] 53023
> [root@iZbp1bu26qv0j3ddyusot3Z p1]# echo 53023 > tasks
> [
> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
> 3833856
> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
> 3620864
> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
> 3727360
> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat size
>     MB:0=100;1=100
>     L3:0=3407872;1=3407872
> 
> Obviously, the value has been overflowed,  Can you explain why？

Are you seeing different behavior before and after you apply this
series?

I do not think the conclusion should immediately be that there is an
overflow issue. Have you perhaps run into the scenario "Notes on
cache occupancy monitoring and control" described in
Documentation/x86/resctrl.rst?

When "memhog" starts it can allocate to the entire L3 for a while
before it is moved to the constrained resource group. It's cache
lines are not evicted as part of this move so it is not unusual for
it to have more lines in L3 than it is allowed to allocate into.

Understanding the occupancy values require understanding of the workload
as well as the system environment.

Depending on the workload's data usage (for example if it keeps loading
new data - note that if the workload keeps loading the same data and the
data is already present in an area of cache that the workload cannot
allocate into then the data read would still result in a cache hit for the
workload, the data would not be moved to the area the
workload can allocate into) and other workloads on the system (there is
other load present also that evicts the lines owned by the workload) the
L3 occupancy rate should go down after a while to match the space it
can allocate into.

Reinette
