Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9D5954B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiHPIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiHPIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:10:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E97DAA34
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660631660; x=1692167660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VWI0dhJBJnvY8pwZp8kyGI6Fe8fybUP4CYidI5X4uk0=;
  b=kt4sdcO93TMkgY2gBH6aYp3/V4jqkoKdvx94Rg1TJauetQQzq+jgIvfH
   XjkPaYroyzL/yutq83OyAQxLNRoMpq3rMy82jcyy0RJfWSMFkU9S3tjke
   qC1/o6ixd3SdxMbcRBRFyYdojU//0UFYkYf1MCDE7ccygjoAysZ4jF7VG
   b99cwZt8hw6OtKDdOz/LPyXRFUJANqGiWMxo4VWfLM6dlxu/w/jVVHniv
   6oreNfPHoGf5cyAFQOjhQ1Xc6By4w4aSyP9S+2DdGCFEYWXqJKViynZJT
   XcBnGZdSreQymcqy833c8TZ39lU/7wIrlpQ7fBkyzP6HV89bUejKxzcKM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="353882253"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="353882253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 23:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="635765177"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2022 23:34:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 23:34:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 23:34:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 23:34:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 23:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGcASkWEB+L7oM4XlnLti5QSMnwItFVMhpB2TEKVh+2pilZZbjMNg0FPIBAHG+5uK0mqSFdcxYuL3IzMJPp6k1FYIv+HdjS6pYU+wP5lCW2HHncTaLToePzIldWE3fOdDgEH+Uteph7X7nZG2rckgGPTALjaZ/uSCSkeM9GlsmeLw1bTNpxTP7RaUUCJ4TgVsWDdipO8hfzdplY93w6fkGjTM5wQr5d2VfvpMMFO8G/S8GJ1pAV3fmJfyMyeJ5s8pcpyr3W7EJvQPqWnqzLrqV6+sFo/wES8nQiV/bPfwQ5d5nG39K4uKcjhdRp9QOqSfbeJzS4+Nx85gM8ZV0ep5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fNKiWF9RLKONE7JTHtXLjOwQaSmtszenVeCrrQ9Qdw=;
 b=IWQQ5nJAbU4xloDpzZ80X0T8fYbGq++5q5jpaUIj49MIi4oWkyUOYhm4e8G5o3erCg8TQ14WSvct9oK8nLt7ho2M8Cr415fJyRAeKpaanGDEaWUmCzIahmcT2xXIMMi8iub40MegKJI0xdUChefao+PGoDcQSZQvpq7/pkkAREfvv9L6o4iVNA+1fr5z5YMsrXNg4SEHK51M/eYsHP+prWYHLVQiLvmru8SlF6v0XW+LOZlJlcA8YtlPfJzPs5nnnhAxN7afONs00LpyF21rOqRl5NDT7ja+hp8tcW9nd+2upfMuxcNYxWejtBJDzaiPlyIQOIikaBWW+Jp01KdP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 06:34:09 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 06:34:09 +0000
Message-ID: <b4b8a073-33e0-99e1-d21f-dae923d2da03@intel.com>
Date:   Tue, 16 Aug 2022 14:33:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <YvfLxuflw2ctHFWF@kernel.org>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <YvfLxuflw2ctHFWF@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff41be1-4780-465d-9657-08da7f51534f
X-MS-TrafficTypeDiagnostic: DM6PR11MB2633:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBRCuV87nvDLyuezjDTxWNJDWMMUByntBxNET9uSmQYa0Ddt+YOb6UUtOgvjCJMo3MGyOumUb1k/D+XVotJ1iLy94XveZQRFpBIaMJ6fBg/HwY4KCHaounIhIwt4+qWHqwq5xufHqtsM0qKVtARdbHaFMOTQR6x2k8WsoSTedreqd6yMF+uSVDYhIp1PNJEjV0gv9307BjXDDhcmArd2axk+LD6hdDHo3uGijyeoicTqr+l73mZW5tsn54NFlu/lxPOVG5OlGSWuyGXRAA2yXwiqf2blzmvDZA8dMmoJG6jYPnuHu4s5PzwCe+rfCfqpdsLX/O2HdLhGOckuSSvMWkREIBrpTKIuodEx/a3yT0pRwf8OZ7FK4+mEJFDhwCIcYNjli+m/h764vCo8lxllznmvKBAquAV2oFJ5dje5yUB+5FMHIC9XoMM69AjN/41abQzzvG2jCf0r4dxHK4n12d8+o0rvNuuo4rM3mkEoqAdAfQNUsyISauK8HpDmvz+TnwN0HAsAiBWdMvN8DYp3boZp7hMUKlWNbnayE0PzoINfxFhVCQgmQvz0hd4PqKxwOWTOVdCkFX9P0yAoayprolxa9aRt0AhAnTMTqf3VouzC3AnJWe0wnB/zrsWJZRZYPzsxfZ2h/6/BG8K9rhJ+dEN9juyEL8g6eUFaNl2SWwxbXPkHJ/GRmLbj0J8e61DvZC00EaCEKLAjSofqSpyUG2JR8rC8YxfXDZ9JeaHXw1KQ+yyaHHN76BgjXVkeyQh18CRj7lA26eb2x8V/UAIbwrhgPrfa1y7nj46e31/hMl0XFz0jPJjmbiISTyT5PvkbqvKqQK2807fmPQvrhpoywnjL50HTo6YmWcXTnjShh0fGcdSQyfnOT/GiovXeYKGRq5xvCrNX/vZR+TQcMg/3oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(84040400005)(83380400001)(26005)(6512007)(478600001)(8676002)(66476007)(186003)(2616005)(6486002)(66556008)(36756003)(8936002)(4326008)(31686004)(66946007)(54906003)(110136005)(966005)(44832011)(82960400001)(5660300002)(316002)(2906002)(6666004)(41300700001)(53546011)(6506007)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlUUDRuTGh1RU1rcjNQR0dMMlcyU2RUMjNsNGlMeVRQNzNTZWZSVDdidk83?=
 =?utf-8?B?V2pFRDVQMmRkOXJTcXJWeHUzM1phY2htV055T1RFMEx0K2pROS9pejZPM1pS?=
 =?utf-8?B?K3dSdXczYUhHaHJiZmlUZXN5TXhZTHcwZWpleG1pWVYxNEVsVElESWlwNVpz?=
 =?utf-8?B?U0hVZGdXR1FiWEJrMDJrTS9Bd0NqV2RPanBRcXhBa3QweWVuL2hSK0dtcHg4?=
 =?utf-8?B?WWFySHkzbVlHcjhXQUwyK1MydEtDVDRSaE5VZENJUnlqNmkxR0JLT3JFcnhJ?=
 =?utf-8?B?K2lHcElnMytmVUxkTVVBcXNldFJCV2pMRkR4VjhHeHJObHJOS0lyOEl3QVZw?=
 =?utf-8?B?dlVxU0JMTTU4bjNiY0s3aTFZWEV0THM3NTVpenQ4bWt0NHQ0NlJ0ampiQXNw?=
 =?utf-8?B?MFlLRmFMUEVVTmxHUm0waVBYOUszMmErQzRhUnc4S0FpVGpXNW56Y3Q4cFJC?=
 =?utf-8?B?eTVoVVB3eEMyQVdIamV4VE8xbDRtNkdVdnlpOXRqekpVSmdtT0dXbjJkMGNY?=
 =?utf-8?B?UnhjNXlwdDU3Zzd2YzJoVU9vZTRxV3J2bElCdDRDcnQ1MEx0ak9OVnZ4eGJT?=
 =?utf-8?B?clMxUHNQSVJqcDhYSjBOUmdubEhLODVJTERGcVhPRDF1SUhMTDFqRlN0UzFj?=
 =?utf-8?B?bHBzd0xrK2VCNEd0NTVMQVE2cmtpYXd2TEFyTG5iK1lNSENaZHBqSnFKSW5P?=
 =?utf-8?B?d01lalVlUnNSaFAzclhhV0tDREFqd3ZMMnZkNjE5Q3JZbDU0Y3BTZkZpanJN?=
 =?utf-8?B?M2E5R25jRGpCOVZpRjZiaW16d3VYajFPR1h6OEJmNTIvQ2UwSTJGQk5qVGl2?=
 =?utf-8?B?Z0JVc0piWnFDYlJhc1QxVnZIU2lVQTdZc0Q3N1hKZGxPSkxBa0hybHRQLzBE?=
 =?utf-8?B?bDBzdE5mUEpSM2FOVFJkbzBPd1lySjZFMXhKTVkzNFA4YVlOZk1WUTlJSCtK?=
 =?utf-8?B?Z2RkTC8vUjVSeWd2Zjg5cTVCOHUvYzU4bDBZYzUzdHRyTDI0RFNzdjVYVlhT?=
 =?utf-8?B?RFNDZGcveDU1bUE4V1R1U01KODhGK0M5YXVudHVRTFlSbEpweGNoRnNTQkNx?=
 =?utf-8?B?cEVhYjFCbmIyMXVkcVZRbzBXYU5manJZV2ZhdEZtaEg5OFJZaUozN0pqam9m?=
 =?utf-8?B?L1JTSGwwWEtxTUNJL21SMHFMUXRIY1czS0w1NGVUN3pid2FFZTN4dWZKanRz?=
 =?utf-8?B?TzNSR0hLL2Rydk5XS0MvYlY2R3VueUhPUVVtemlabFN2K25zQS9PVUlsWDQy?=
 =?utf-8?B?cnBVMGZxRmJQQWllM1NEL1VMRlJsVko5SzJDTW5nRlZXWUtmSDFsbUxHLzNM?=
 =?utf-8?B?UGduMlNnazZpYkZYWjc1WVlLcVQ0dVRNTXRRRDh0VjVvL21Pbjk5QzFFV2Jt?=
 =?utf-8?B?cHJLZ0hheXhleFZ6bG4rV0Rtekt1ZUxkaHF4NHZHU3RJVWRiODZ0bVBhTGFy?=
 =?utf-8?B?clRjTS9NZFdQYnE3QW5QMXhlUzNkVFArd1FuZ0phdUtNcU1sa2dxL0cyL0hO?=
 =?utf-8?B?RC9iUUF4MmloN0Y5T0pzbFBtbFRzRGN1TnlvRzJZWXpKQTU3azBHTXYzQm9L?=
 =?utf-8?B?YzhBQ1VtQ0Y1ZFRINDBYR2x1d0tYM2o0eGM2OUlPNE8yd1drTEdCSTZLbk54?=
 =?utf-8?B?Vmt1VW5paFBheFl2WnhsZUNvU0xNQmlIQ1dpZmhUTC9nN2JnMG1tZUVsbEcr?=
 =?utf-8?B?bHltak9BT2wyNFRYdlJscTh0Nkh6QjNUV2xrb3FnckJPbTYzd3FKVk9vOTNn?=
 =?utf-8?B?akpVbjhDemhXMitRUk1aNUE0UndURllqUkVNdTgxNE1HSXYvKy9QdkdILzhQ?=
 =?utf-8?B?c3JuYng5dm9XeFpBb21FSDhIeTBGV0w0eE11RVdlc3FFell1RFo4dG5kcW9H?=
 =?utf-8?B?NW9GQTYyL3p6b0sxZzlEeWMzeHVBMlFBWFM3ZUhoSU84dWVRcythMmY1eCtT?=
 =?utf-8?B?MU56a2lzYW1XNElZRGVGUldMUXpiNkliT1M3azFnb2h2M0FNMzh3RUU2QnVn?=
 =?utf-8?B?dUwxazl6c3JtUllUcGovemFlSnNmTVl4amtUSkx6ZEJCOHBpTnZjYVNmdnhl?=
 =?utf-8?B?R2NrYWtkTnRWZ0pqY050VG1SdTRkTDIvbGF6eHBHb2k3M1FEaUFsYzBKVjIv?=
 =?utf-8?Q?ohi5yy0Zr8BBblClbnJra2zoN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff41be1-4780-465d-9657-08da7f51534f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:34:09.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+QYGWlF5mCDA10qsfY43eXhiqhXye8Em8klAn8u6kgLRG8DbiE/q82rGMOa4h9lfkOTbLkh/y7UfDkef3N3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
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

Hi Mike,

Thanks for the feedback. See below for my comments.

On 8/14/2022 12:05 AM, Mike Rapoport wrote:
> Hi Aaron,
> 
> On Thu, Aug 11, 2022 at 04:50:44AM +0000, Hyeonggon Yoo wrote:
>> On Mon, Aug 08, 2022 at 10:56:45PM +0800, Aaron Lu wrote:
>>> This is an early RFC. While all reviews are welcome, reviewing this code
>>> now will be a waste of time for the x86 subsystem maintainers. I would,
>>> however, appreciate a preliminary review from the folks on the to and cc
>>> list. I'm posting it to the list in case anyone else is interested in
>>> seeing this early version.
>>>
>>
>> Hello Aaron!
>>
>> +Cc Mike Rapoport, who has been same problem. [1]
> 
> Thanks Hyeonggon!
>  
>> There is also LPC discussion (with different approach on this problem)
>> [2], [4]
>>
>> and performance measurement when all pages are 4K/2M. [3]
>>
>> [1] https://lore.kernel.org/linux-mm/20220127085608.306306-1-rppt@kernel.org/
>> [2] https://www.youtube.com/watch?v=egC7ZK4pcnQ
>> [3] https://lpc.events/event/11/contributions/1127/attachments/922/1792/LPC21%20Direct%20map%20management%20.pdf
>> [4] https://lwn.net/Articles/894557/
>>
>>> Dave Hansen: I need your ack before this goes to the maintainers.
>>>
>>> Here it goes:
>>>
>>> On x86_64, Linux has direct mapping of almost all physical memory. For
>>> performance reasons, this mapping is usually set as large page like 2M
>>> or 1G per hardware's capability with read, write and non-execute
>>> protection.
>>>
>>> There are cases where some pages have to change their protection to RO
>>> and eXecutable, like pages that host module code or bpf prog. When these
>>> pages' protection are changed, the corresponding large mapping that
>>> cover these pages will have to be splitted into 4K first and then
>>> individual 4k page's protection changed accordingly, i.e. unaffected
>>> pages keep their original protection as RW and NX while affected pages'
>>> protection changed to RO and X.
>>>
>>> There is a problem due to this split: the large mapping will remain
>>> splitted even after the affected pages' protection are changed back to
>>> RW and NX, like when the module is unloaded or bpf progs are freed.
>>> After system runs a long time, there can be more and more large mapping
>>> being splitted, causing more and more dTLB misses and overall system
>>> performance getting hurt[1].
>>>
>>> For this reason, people tried some techniques to reduce the harm of
>>> large mapping beling splitted, like bpf_prog_pack[2] which packs
>>> multiple bpf progs into a single page instead of allocating and changing
>>> one page's protection for each bpf prog. This approach made large
>>> mapping split happen much fewer.
>>>
>>> This patchset addresses this problem in another way: it merges
>>> splitted mappings back to a large mapping when protections of all entries
>>> of the splitted small mapping page table become same again, e.g. when the
>>> page whose protection was changed to RO+X now has its protection changed
>>> back to RW+NX due to reasons like module unload, bpf prog free, etc. and
>>> all other entries' protection are also RW+NX.
>>>
>>
>> I tried very similar approach few months ago (for toy implementation) [5],
>> and the biggest obstacle to this approach was: you need to be extremely sure
>> that the page->nr_same_prot is ALWAYS correct.
>>
>> For example, in arch/x86/include/asm/kfence.h [6], it clears and set
>> _PAGE_PRESENT without going through CPA, which can simply break the count.
>>
>> [5] https://github.com/hygoni/linux/tree/merge-mapping-v1r3
>> [6] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/kfence.h#L56
>>
>> I think we may need to hook set_pte/set_pmd/etc and use proper
>> synchronization primitives when changing init_mm's page table to go
>> further on this approach.
>>
>>> One final note is, with features like bpf_prog_pack etc., there can be
>>> much fewer large mapping split IIUC; also, this patchset can not help
>>> when the page which has its protection changed keeps in use. So my take
>>> on this large mapping split problem is: to get the most value of keeping
>>> large mapping intact, features like bpf_prog_pack is important. This
>>> patchset can help to further reduce large mapping split when in use page
>>> that has special protection set finally gets released.
> 
> I'm not sure automatic collapse of large pages in the direct map will
> actually trigger frequently. 
> 
> Consider for example pages allocated for modules, that have adjusted
> protection bits. This pages could be scattered all over and even when they
> are freed, chances there will be a contiguous 2M chunk are quite low...
> 

When these pages that scattered a 2M chunk with special protection bits
set are all freed, then we can do merge for them. I suppose you mean
it's not easy to have all these special pages freed?

> I believe that to reduce the fragmentation of the direct map the 4K pages
> with changed protection should be allocated from a cache of large pages, as
> I did on older version of secretmem or as Rick implemented in his vmalloc
> and PKS series.

I agree that allocation side is important to reduce direct map
fragmentation. This approach here doesn't help when these special pages
are in use while the approaches you mentioned can help that.

> 
> Then CPA may provide a method for explicitly collapsing a large page, so
> that such cache can call this method when an entire large page becomes
> free.

I think this is a good idea. With things like your Unmap migratetype
patchset, when a order-9 page is free, it can somehow notify CPA about
this and then arch code like CPA can manipulate direct mapping as it
sees appropriate, like merging lower level page tables to higher level.

This also saves the trouble of tracking pgt->same_prot and nr_same_prot
of the kernel page tables in this patchset. CPA now only need to get
notified and then do a page table scan to make sure such a merge is correct.

I suppose this should work as long as all pages that will have
protection bits changed are allocated from the page allocator(so that
your approach can track such pages).

> 
>>> [1]: http://lkml.kernel.org/r/CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com
>>> [2]: https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
>>>
>>> Aaron Lu (4):
>>>   x86/mm/cpa: restore global bit when page is present
>>>   x86/mm/cpa: merge splitted direct mapping when possible
>>>   x86/mm/cpa: add merge event counter
>>>   x86/mm/cpa: add a test interface to split direct map
>>>
>>>  arch/x86/mm/pat/set_memory.c  | 411 +++++++++++++++++++++++++++++++++-
>>>  include/linux/mm_types.h      |   6 +
>>>  include/linux/page-flags.h    |   6 +
>>>  include/linux/vm_event_item.h |   2 +
>>>  mm/vmstat.c                   |   2 +
>>>  5 files changed, 420 insertions(+), 7 deletions(-)
>>>
>>> -- 
>>> 2.37.1
>>>
>>>
> 
