Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE51E5B2832
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIHVN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIHVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:13:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F9FB8FF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662671601; x=1694207601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2pQ0Vf2DlVrLQ1hZ7Nm+3EiHZJByJaBNLW2AooYSMs=;
  b=IzxtLy2yIlpPc8c7jGRsECdMXuKam9ETC+zT/2xHJ8S2d1tbC0A5bbDu
   sZeR6kSl9wdZ653y5wc2onxV2LV2HAOs5WzOjTqHINo0TMRw3KDZBBCSc
   8YXzp8tPHbNsY1OJZoC6EKOc0nK56OoK0V6kB2fkbt0FVwZV/g2y40MFr
   d8Haa/vfyDOxP4AnfYv224isgF0ryawWZBwfon2IRzwx7FH55Bf1lKB+F
   DhJZUJBO98HpkDvIdEc+vBzPgCQsMKvCkOUcIo2/efGv2y7dDJoYzGou/
   0yX1xyMn37i5cCFUww5nnmA33UAU+qS8cxK1B+mttEBR8y18WXJxjqLZ8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280352784"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280352784"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592348321"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 14:13:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:13:20 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:13:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 14:13:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 14:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kor7/4/QAohEWHTQXSxdgcORHtBheaIfDJtAxMbq8MXUknQsWPZnT+9DmbKZOI8Qnjtw45C1xgTKgZfzGy5ywv5mcVcTU2gfFYm13iDfLA+CbCeurrWvfzUyadEBFIaiejao+AEEudf2WC9cN+eoqjzO214CP/JdpAywX5uAaWbuv9IqsADo67gAiZTG+yb1RPKRF+P4jdDVP97/2vwto3kNzXiqKL+SF5OwakhyGHtWJH0RrcGHhH0FbOiPEv6hocSvap9UOPVjBdaA/puFVu3BIZXqfMIWloQbQnYJHDjAlrEGY7ZU9lPgLl1QdsfLQKFsOdByP5+7/ipqkFfj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZTN+e43eOV7RVIdW8iuxULBt7S/P+A3WSgsuAYPhaQ=;
 b=ZdvfbuPOP3l5ClZN/9/V1QXiSodVE7U09L4dpLUyaTaqU2YvmMJTNiII6n4bAFDDY2RLWE1j64Ay2hZP1mKvmNMd0tpiVY7yB1oQJFS5Sf/kuBe6Vq8YBKf7UbZ4T0Mr73jbKgpNJDjMii7/lXdyFB3h6ztIqFXe2mgiuSQ1ECzTXntB8CyKvtApNTgPZZ8CkCRvpJqzt0wn0YzRUuoadUkw1Ltg9RM+H5LmZZUJizXZ79dxAImw0yI21A3E59fKYUVG6HS6zmjzkTDO28oxEuMQTPw5ZO4NuAv0SY0jIr0IImKUMx4lhH29/uZOmU3kIQSecxZ3sWoT183SSZNNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 21:13:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 21:13:17 +0000
Message-ID: <53238b86-5df4-a9cc-c60b-89085b7ab558@intel.com>
Date:   Thu, 8 Sep 2022 14:13:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v6 12/21] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, haoxin <xhao@linux.alibaba.com>,
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
References: <20220902154829.30399-1-james.morse@arm.com>
 <20220902154829.30399-13-james.morse@arm.com>
 <87aa9fd2-cae8-972d-81d4-8855cbd81569@linux.alibaba.com>
 <5b4da95f-28ac-a571-6c01-cf1a94d0753d@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5b4da95f-28ac-a571-6c01-cf1a94d0753d@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4febbd-cd48-45a9-5177-08da91def2e3
X-MS-TrafficTypeDiagnostic: SN7PR11MB6946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdeyPwBedEl7Z+o1QCwGhi6yqDHt8J09wqDwK0F4SQ9ro3Rk7wbDidbrxxuq5OnSP0aWRAgH8R62sLW9i/IEP5gqHcefrFQOaKKG9GbO3outNPr+uS6RDS5xqAwO7tdPZbXv5188y8nEMvbdYIo9gy92rdc+TNgbvQ9Y6VvBP+zbk0t2PMbcwFlxeMIkAIdqne3Fo5FtgfsgQhBw8rOjaA8830kpTrKLU9lHjfveTciIRaFoP40uX/838w4JYrLPJKlc/kLIJIExyB6poXcOsGg/xbXo4qYXXO5lgzsu2NJDj0xGeaHvuz6qiSE29inOMOO79y9z2bl5Qb9LfGE8+h1bWzV/J10QQM47J8rtH1LpOau63D7NMzIUc0U7qZebKvRdmBZaxG5KDdrjkoCCHxtd1nUVMMJU+cInM0Cl7C8iirDjm/cNAkI8SFKad49nx6SFnpoXZDat9ZlfBFkeiVYaAa+CtlFA0yeAfoQHov7bnH90HGwY91s2VfHmMhURXaFnRcUWRQmhu5gB64WIFlGhr6fWQd+6NYeK7N3Z+oz2rC0qChmSPT4PqR8z5jHd/1nAtHgolFp0vkqXqK6UHGQf83ZNouozlb9VyChfYR0ClGOSOItEypZJJfSG5FpUlYLnsA65hyWJ8hcjiOCvgyYub2McVGJ7Eibl+gg7Iw6BfH2KqpWo5cvwx5UtKzTynI6qtYPFnc5mHmZ+qeieCwr39sd5djeYbEra6FO4Dgi+d7dxcux4ZYmx2taoVMmZd0LQiUIIy7HLK3BipivxCNtOnoZCBc08cm6N9UAeRqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(38100700002)(316002)(4326008)(2616005)(110136005)(66556008)(66476007)(66946007)(31686004)(86362001)(31696002)(36756003)(82960400001)(83380400001)(26005)(6486002)(54906003)(41300700001)(186003)(6512007)(2906002)(53546011)(7416002)(6506007)(6666004)(478600001)(44832011)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZtZkNyR1F2ZzlZR2gyS0lqY1NBZ0hQeDRBc2htTldUSFRDZWdHbkRMUUtj?=
 =?utf-8?B?cnlCdHFvckZaa2RSSHphTjl1US9hSnlyUk5jbGZhV0hlMzU0TGdITXFQaDF2?=
 =?utf-8?B?TTVvMmRmaWwrS2JGbFgyWTg2Tm94ZEthczZtd2dCR1VtRkp1QXBXMlZLWVkw?=
 =?utf-8?B?ZGErbCttenNtekxONXBhNCtQZmR1eW10Y05Ma0tab2RCK2JFWjNiOGFmcWJs?=
 =?utf-8?B?R0x1L3lnRW96NTNETGNvaFE3QzBBcTBzM2thM2J4ajVBVERzUzQ4ejNScEZj?=
 =?utf-8?B?TmtaQ2M3MXVOWXB1Y3Z6N0p3UGZ6d2VjaTNMbjVkcTB3cHZ5cjhLZ1hzMnBt?=
 =?utf-8?B?TWlXa1dtOVNRcklzbmFuTXcwZ3dxUjZaMHc3ZkhKaUhqRWJhd1E3QWJPRzRy?=
 =?utf-8?B?cTQ3eWFPcTBMQ09MMzl3SWowYVV5Nm9qODJaKzFvRFVwN01FaVFVQ0d4QjlW?=
 =?utf-8?B?c3M5UXA1Ymg1K0RpSmRsYytXWkdOUlRjMnkrNmxrR1FHRUpoYlQwUlAzWjBD?=
 =?utf-8?B?dmhRU2w2OFZMdGY4UmRjUFhtVXY3SW1YVy9mNkRyRUd0L1VSRDVXSmZ2cWMw?=
 =?utf-8?B?WVl4Z01ZbGVQUUg5elhXQVhhVGdacXNOZnpQOWl5U3N5Nk0vL2hIdjhlaCsz?=
 =?utf-8?B?ZWQyRVQwZGM2N2JPYk9JQ2V4SVlEMG5XaUdMMmgwRGRUbjJvRXBVeDJxN3h3?=
 =?utf-8?B?d1FtUzFtSTJtOXo5NS9jbk9BaEZZY0YxQlJFRkczVnB5MEhmcTMveWwxdjR1?=
 =?utf-8?B?Q0FnejZjUWh6bE50UWJ3NEVDTXpReUFwL2hGKzk4d0U5MmtKbFArTDNEemdI?=
 =?utf-8?B?aytWbWVTNVFXd0dyRjBoVEpiY2daODJlTGtXRG5hczJmVE04M0lpeGN3VXFt?=
 =?utf-8?B?b0V3ZEFIRi9nZWNOM0NQWFRPVkt4aFpaTnhMa0FIZWhMd1JiazRoZHd0dXlJ?=
 =?utf-8?B?c0Jsa2JHK3JUcUp4UmtnZVNCVUk4bnhKcVk2dVE4bnNSY0YxbEFBbndsWGJq?=
 =?utf-8?B?S3lkdnRYNmMvRm1sSXdIV25iOU5CWFVvWHBXSHJrRCtjVjJ6bUhuSHJoVTRk?=
 =?utf-8?B?MWlqUzFDQ1p3VVRTc1BOV1dEWU1zOFRJNVBRbm0yUVJrMUpHdm5FL2RyTXg0?=
 =?utf-8?B?aU4yTUI4d3RzWXVBREZPSExLa3NXNzhoNUNpR29DNGV1U1FZdVIvRm1mUTBR?=
 =?utf-8?B?OU13ZU5nQ21oRkh6YkhSSG5vQllFbzhyeUdDczVxWW15UXFyUzcwQ2JrZDkz?=
 =?utf-8?B?M3FjSThSWGhveko2Yzc3R0FlTjNNaUZvVkt2NFZQYjREdHlhUDRXbitQdDJw?=
 =?utf-8?B?c0VhcjlIVnF4VlRKRWRQWGJSV2V6eEowcFZvbmRMYW0wNEFHZW9JbWphT2xq?=
 =?utf-8?B?QVZFbWVUOTU5RlVYNzRIRlJwcFR0MnBqOUZGWjNNYUxYckJkTDZQWlpoOGRp?=
 =?utf-8?B?eTZaN0wyUi9WS1BYTFI3SXNFV3VDUy9iSDFiWGI4QkEzejNlR3R6SktpRG54?=
 =?utf-8?B?S1B6WkJweWgxN2ZHbjJNbnNCVXo0Zkc0L1gySVViR1lXVVdsd0JVNHRtbnJB?=
 =?utf-8?B?dUZnV3dkN2J3dllzdm9VNkFvbzlyMnZlWUpwRG1FWkR1U01uY25EUkhTaGkr?=
 =?utf-8?B?YnRIQjFRUUFCZXZUY0g5SnI4dFdCbGxIT1BWZ3RUaVR3dWc1bVMwZWcxOS9H?=
 =?utf-8?B?dXFUZWZSVzN1MmdBc2FidFNKTnVTVnpPSHZmbnhnOGhYelNWdGU4ZTJLSmdC?=
 =?utf-8?B?c01jSWtUTlJuTVdUa1lCaUxlZTMwczVkT1lzeGtlbCtJcmNLaGRxNFhoU0ZO?=
 =?utf-8?B?eFFsOEpPN0RuaGVHbkwvckxrMlc1elU2a3l3STN5dnFZTjNySmM3Wm9Udll5?=
 =?utf-8?B?bXduYkJXdGY0N3hvQXB4RXNCVHcyMG9lTU4yS21WUkVwYU5WUFhJbWtHNVMv?=
 =?utf-8?B?SUtoWllYS0ZtcTd3NTNjOXE1cWZublRQektIMmpUUTNTWXNXRlRXZXM0QUNU?=
 =?utf-8?B?L2F5SFZ3VVdUT0EzalllazJmNTRDeDVub095UzhkamdTL0RqbUlaOHZUVFNn?=
 =?utf-8?B?RzhRbFF6Y1dGd212RlFlTlRoZEN4dmRvY2ZXL01wRVZWTUM4b1NDc3N5Q1VS?=
 =?utf-8?B?RGI5c1EvQ3M0dGI3RGdYU3QrK05HaSszSWF6YmJhMFlZVGxtTEpsNkxPM0FZ?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4febbd-cd48-45a9-5177-08da91def2e3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 21:13:17.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZePbHA3ags0yyq4hqk1lVF8W4gfl7guEmAgK7R3jbP37LrI8JrPytAfIC1mFSDCxEcrWOL2hCYGydOGJJ1a88ve71/FIreLjTUTAzaXK6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2022 10:00 AM, James Morse wrote:
> Hi Hao Xin,
> 
> On 07/09/2022 07:47, haoxin wrote:
>> 在 2022/9/2 下午11:48, James Morse 写道:
>>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>>> second. It reads the hardware register, calculates the bandwidth and
>>> updates m->prev_bw_msr which is used to hold the previous hardware register
>>> value.
>>>
>>> Operating directly on hardware register values makes it difficult to make
>>> this code architecture independent, so that it can be moved to /fs/,
>>> making the mba_sc feature something resctrl supports with no additional
>>> support from the architecture.
>>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>>> register using __mon_event_count().
>>>
>>> Change mbm_bw_count() to use the current chunks value most recently saved
>>> by __mon_event_count(). This removes an extra call to __rmid_read().
>>> Instead of using m->prev_msr to calculate the number of chunks seen,
>>> use the rr->val that was updated by __mon_event_count(). This removes an
>>> extra call to mbm_overflow_count() and get_corrected_mbm_count().
>>> Calculating bandwidth like this means mbm_bw_count() no longer operates
>>> on hardware register values directly.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 3e69386cfe00..2d81b6cd9632 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> 
>>> @@ -516,10 +521,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain
>>> *d, int rmid)
>>>        */
>>>       if (is_mbm_total_enabled()) {
>>>           rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;>> +        rr.val = 0;
> 
>> In mbm_update,  there no use the rr.val, so there no need to initialize ？

This patch introduces using rr.val into mbm_bw_count() that is called
from mbm_update(). This patch thus introduces the requirement that rr.val needs
to be initialized. 

> 
>>>           __mon_event_count(rmid, &rr);
>>>       }
>>>       if (is_mbm_local_enabled()) {
>>>           rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>>> +        rr.val = 0;
> 
>> ditto.
> 
>>>           __mon_event_count(rmid, &rr);
>>>             /*
> 
> No, but this just leaves that problem for someone else to discover the hard way! I think
> its fair for the compiler to complain that addition on an uninitialised field is a bug.
> 
> I'd prefer to keep this as it is on the principle of 'least surprise'.

Yes, please do keep this. If rr.val is not initialized then the software controller will
use wrong data to compute the delta bandwidth.

Reinette
