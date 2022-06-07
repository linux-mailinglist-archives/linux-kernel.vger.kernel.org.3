Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F7753F3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiFGCfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiFGCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:35:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9597CB0B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654569312; x=1686105312;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dkG2fZX77aASZzz34khF+LZMnYvqcsIjezLU74uMAFY=;
  b=RMWEF6zyU/ucMTNAHtkxvKi//aLQKpmvt3tMynTIKWp8W++W0D9d5hNF
   bpXbkpja+wZfXiqm/1UiXeQ14NMi0P0CSU+vxXQZrXuQCp7K1dSK2LfW5
   /uuvDUVJVfyMy9CN/yqoIUaHR2D8jr3nW33mfoTfugW47z1scUV6un/fl
   0M0H27EwZLj46f8kzNmuLqe7d9HFOdl2dj7fR5jxxWDl1LLHySnHBo3p3
   36i0ZI/5Z/yieOjjEKdmBF77OX+vjxy+ePMs4XWGPCRxnl/L0mN7xzPNM
   TV+dvxlEufnipSNehv6OLnsUI1Q9Wby/Lt6OTGNfRErzdHN873l95JVLo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274240342"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274240342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 19:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="554703001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 06 Jun 2022 19:35:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 6 Jun 2022 19:35:11 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 6 Jun 2022 19:35:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 6 Jun 2022 19:35:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 6 Jun 2022 19:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATi7WtxI/9bY9YDEim69R3MtENWaQnn1opini72hBGiD+8kDEeCwB+PRxzEadRC5KJTpLbSIGea9/SFpU3kv5DLymddxp+/VbSHXOS0apBohb3+qunjbAGYe9V/Ky6U7dfUiNenCFZEYTNwGqBtp4jcEOJpAiAWnZNIFe/LqgesLvhaNvU7oPffU+t2zdww8xQXj+cJZXeOQ7DYzyxQJRh0lFfrAC5UTq3ZmyBAVMLQXvix3c46/j1KgpAGl3gNZxbrkBzfLziGIeK6z3fFmZvhS2TyozEIJ8tEDzETztBb8U2u5izdZu8vmHEWer2kvBBYEr6Pex62w74cSrdGckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke5M/jcPpaAL/fbjXo4zm/hAMDKq6nWYWQXccgaxdfk=;
 b=fN2kZNJ7EJ19EVQXHa2JRcEjAhloyGeRyg+eMbi9lNYiA47Hu6jzoM2o4eX/Qe9r1CAGtU81LZap8vk5Pxqi6FUAUDXyjlyzVrNqcXjn81RVw478ZvplRXiGVZ2so6YYLUa8AER0YA/oZyowXTEc9CtrnPyznTNFyADY2qHJIFMFxF06mZU0dy+sDeN4H7nag3lAXnzGBFTnAeaLCmukQj3xNBfFPBIkpUnlBeIW6FiTOSVV8bSEIV0IJo3YKYB0UCSMbTo0L4m3cssHUWIq8NV3B56o8S7FEs15EQf2aQzHZcHck5RTSH02asyd7r0XDYkOjIFuPkyqGuZ5K+tgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 02:35:08 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:35:08 +0000
Message-ID: <bde8f635-f9c7-dd5c-0f66-c18e71a17b1a@intel.com>
Date:   Tue, 7 Jun 2022 10:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 5/41]
 fs/cifs/smb2ops.c:4995:2: warning: Undefined or garbage value returned to
 caller [clang-analyzer-core.uninitialized.UndefReturn]
References: <202206010953.pjbFFc6d-lkp@intel.com>
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202206010953.pjbFFc6d-lkp@intel.com>
X-Forwarded-Message-Id: <202206010953.pjbFFc6d-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8478df41-a7b3-47a4-fb33-08da482e564d
X-MS-TrafficTypeDiagnostic: SN6PR11MB2718:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2718EC6F25AF9AEFD679F956FBA59@SN6PR11MB2718.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7o5VGJiCamWuJ/DW9PgA5VNESyl2hlE/y5wUKT7jXEEMJN58t9sJleeuDfKzAnYT+9CBfNkKhOWLRSOtnrS9C3gvJdbtBCKpbP8O4ojZQcUzthjdpF28xFUfwns2WvZ4KUSWsz+O+plLFrldMeP/Z2590fHQRTCNvQ2Pz4DNwf60HoXWKJsI5QV8BvaT5zdTtyPUnP1zMO0Kc5S5gawnxSGsoCoFrjTi84APcE1pG7KjYT3PRP/K1LDdA+hPS16TalO1pUBzLVnuCQ8MI2wFYnMLK6fuPXDZHctz8B6HGEUJPHjZ1uruZPzVPGaOYc7XrNeeszRo9GLc5MQX/BDfoDRKRXVysCdLn00hVZUK+Tmm2qCMXr4/Mr0wTrk3YJwOPjuEtEELizllcbImf/VVyut8L4f9PTPhYZ63lguzLCCmIJgmG2i1bR2TVCDYLYzHuAli4OTdEN6JSGshl/0KYAHpiSv8NyCX6SO/SjJqqfzwAGbJSv9gjW4LEzV8t0mV4zGDBpxJZpld0N1T/YwR0hsFqPbtWlnVnS8QKEeejZnsA4KskdC7Bt56VjYAwPXWnEFlLqjkR+hINL6/XWPbiSINkIDfKBhu0GouL5jhwuGFJnI8/OHRLZ6cpf1NLIUoQNBcUPb01is6B4EOpk/S6D36wplzM0EIGVHIjH6LKEpCO2utza6IdqwAaR9X/TdBHCqhNdnyJzgCeCUpn/OsuYa6oZo6JtC4ByuGyxMXv2JmjFo5jgBVeAbAuudcCQe/t+zyyK39t45H8jk8OiHnOdWc9oKhyEL0t5hxlDim564hrZTvDnNyR5fP1O5buo8IZvwbXlsThubYq3lxRA8xwEO8M5PBE8v19jnrXizd7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(38100700002)(31686004)(31696002)(5660300002)(508600001)(82960400001)(966005)(86362001)(30864003)(6486002)(36756003)(66556008)(66946007)(4326008)(8936002)(2616005)(6666004)(4001150100001)(83380400001)(2906002)(186003)(6506007)(26005)(6512007)(6916009)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUcxd01zQzRjNW5tcHhINUZob3dsTjgzMXFPc1d2bks4MUI5bng0M1AvSUVY?=
 =?utf-8?B?WTlCNEFkNkM3SEtwM3dIc2ZyREpRVXlBcHJBU1RzRVd4dXhLNWRYeDRBOWx5?=
 =?utf-8?B?STVKcVNLM0ZpT0dlQUQ1MGxULy9KSDNtU2RrK1RKTFFFTVM3eXBNSlFSWnNm?=
 =?utf-8?B?d1pBb05GTzhZNFR2L2habkQyd0ZpSWNncXVzVVhSZFlZZFlmcXJnNmgxay9O?=
 =?utf-8?B?dTA1ZzdlYmxmYVhaYnoxbDBnSlJWTGdvQWlNZzh3Z1hNTU9leEtOSklSMFJo?=
 =?utf-8?B?Nnp2OE9NQWJMRVg5M1pyM3F5M1Q5ZENDN3ZBY1VSL2gyUnNoTktJc3Q4eDRp?=
 =?utf-8?B?VVhDUk81TERuMHRDQWhwSm9BWFhPM25PQWVqNXlFYVZiZUd3SHdBNWdESE9R?=
 =?utf-8?B?bXFINXphZFlWWE1yR0loY2hrb2pjaHY1dkNCcUpIZVJMaERVcnlUVGMvaW9q?=
 =?utf-8?B?UXhqajFoTFFvQWFiR0M5Q3dWSFZBWm5XZ0FRT1ZaWlJpeTlwWlI3V09WbGZE?=
 =?utf-8?B?VVBJT1pDNTI2UDMwU2ZabFhjdjJZcFhGNGFTSWIvQzJ2WFFPSi9wVXdvWjM3?=
 =?utf-8?B?YitPRTVtK2N2K2NjczJLQjZZT00yM2FMZFgyb01SMjkrU0hzZDVzd1p0WnhH?=
 =?utf-8?B?SEluLzlZR1ppRU9uUTlBVTlucXdLOGYwNHpGRWJXTDVNdC96UE1GTVd0bjFw?=
 =?utf-8?B?MlMrU2RkNjRzL3BLQzR5aXJtbXY4dWtCS1ZuemlYdFkvU1crblluQ2ZWK2xS?=
 =?utf-8?B?eHBIaUJkblc1T0lBNDF1a2x2MlJxUXJmT2JFeXlYVysvMm9aSC8ya3RDZ0VD?=
 =?utf-8?B?aXJxWnVzZktIYXRqNTZqTUVrT0E4bVErU25VM2pFVXlORHFSQWlpN2EyTGJn?=
 =?utf-8?B?SWhTU3pJZlZEU3VRTFNDOU1SRlpkd29OUHJyMVBRdmZkL0ZQVk8zbitmdWlJ?=
 =?utf-8?B?VTBBemt0WW04VU9mNW9DdFBvNWxDVkxtQnQvVHlWN3hMV3F2TWZzM3g3aW93?=
 =?utf-8?B?QXpYdHFNb1ZCV3FlN1Z2bnptQ1RsS3BtSUZ0MU5yZWRNTTZIL2dtOEViYXZl?=
 =?utf-8?B?RFJPQXY3SWxtU2NhaW1XRWJjbVB5MEhmZHl0TXlZaTVBaGR4OHQ3bmhqWklt?=
 =?utf-8?B?NEZMTTc5aXE5dWJEb2dYR3JHcnBqZmdyK0g3UUFpdm9hYjBSR1BPZk00czd1?=
 =?utf-8?B?NVNtWHBUWjl1dFloWjRreWlLNFFEc1J1T1EwTFRVNzg2UkdTZWQ5QWlENm9j?=
 =?utf-8?B?THE1S3hHUldnbUFmZjdEaDdqdkxPZGhpV2x5MVEwS2x3N0F3eGdpSkEvUEgw?=
 =?utf-8?B?TFNBRmpXajJKdnZ2OVVJaGtRM2pJSmNxU0w5dmlCaTBzZ3RhTWdjSzRJK0Jn?=
 =?utf-8?B?QmhvNE9xRlFML2lBeGZkbXN1K2hvZUxXWWtDeGNBMVVPMzlxTUtIZllyZzlh?=
 =?utf-8?B?WXJKMmdpTnpWSXRJbzlZSmhXUHB5TGFPRm5uM2tLaFJxclFkRG9qMGRTRG9S?=
 =?utf-8?B?YkZ6Sk9aZDVBL29RMDFxc3BkdXhnWU9xN0xoM1BaU0E1cm5WMjJSMTd6V09I?=
 =?utf-8?B?bm94Qmo4V0hFb0ZVTEtsazlxUGR6ZHJaYmMxdVlhSnhiRHZDcjdBYjNKcGZn?=
 =?utf-8?B?U1FFc3d6V0RUcWxiMDZxTGVIQ05uQnp4Ym5yMlpEOEp6MkhwK0RnR2p6V092?=
 =?utf-8?B?UHRHOVJPT05QZ1hxY0xIanArT2dEOG1GL25KbENrR1hjd2hwcVBMU2NxQTNE?=
 =?utf-8?B?ZEhUK213WHhUMmIvc2RETmhCclNlOG53TzVsbjYxUTJLamFIdkl1NkJob3FJ?=
 =?utf-8?B?VGgxTyt3by9TMU5veU01WnFtUGhkdlA3L0xDajEwSTd2eTFVSGdRV3FkbmZm?=
 =?utf-8?B?SUVkeWdRMVZSVTg1UXJ2VEVnMkRnUSs2SnFEQmdta2xULytQM0lTa1hOMDFC?=
 =?utf-8?B?Nk01WUdtcXNiNTlibk5yWDRzWHhTTE8rRWFjVC90cHJuU25SZzhERjRlZitl?=
 =?utf-8?B?dGVaQ21UMzFZN2JRUE5nS0lTSVlXYiswTXpJWGRZZm02T1NYMUppNmY5bXht?=
 =?utf-8?B?bmdxeUZVNG93cUtlMzVWUlFPcVQrNHRUL21sdFpBMnBtci9DZ0xEaS8yUlRh?=
 =?utf-8?B?RU5QSHdmdFJHM09BekFtazFMZGVVZzU5S3M4dVhIUkxycHQvZ2pvZGpMdGlK?=
 =?utf-8?B?elVCVkxOTEZvb1VDeWxiejFraG80SzNiVFpudGlvOVVicmdJazkySzM4dGR5?=
 =?utf-8?B?Sloyb2psV1JUcjBjcFlpdndOcWkyS0hCT0pWYWNpNFhWaWRIM3A1Zi9MYWwv?=
 =?utf-8?B?T0RGdjIvbVpNTTZ6dFVSMDZ4TjhEYWg1VXNWNGlielZBQ3I1dXJzZ0VTbGtn?=
 =?utf-8?Q?wdyAkptY7Y9Myckg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8478df41-a7b3-47a4-fb33-08da482e564d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 02:35:08.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEyF4YIpflvRZ4681d1yZcCggL13chXYxAiTrL88C7VbZzp03vv3mYbLo+h+/RasBmyXlYsdaviOSmdzQIUsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2718
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-netfs
head:   1fc71b6b30f6d2a981c163b77c9aee0aecaecb29
commit: 36c9de734b21b4bc60b7ee86228659d416d53470 [5/41] cifs: Change the I/O paths to use an iterator rather than a page list
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220601/202206010953.pjbFFc6d-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/ammarfaizi2/linux-block/commit/36c9de734b21b4bc60b7ee86228659d416d53470
         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
         git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
         git checkout 36c9de734b21b4bc60b7ee86228659d416d53470
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/cifs/smb2ops.c:4995:2: warning: Undefined or garbage value returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
            return length;
            ^      ~~~~~~

vim +4995 fs/cifs/smb2ops.c

c42a6abe301283 Pavel Shilovsky    2016-11-17  4849
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4850  static int
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4851  handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
36c9de734b21b4 David Howells      2022-01-24  4852  		 char *buf, unsigned int buf_len, struct xarray *pages,
36c9de734b21b4 David Howells      2022-01-24  4853  		 unsigned int pages_len, bool is_offloaded)
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4854  {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4855  	unsigned int data_offset;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4856  	unsigned int data_len;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4857  	unsigned int cur_off;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4858  	unsigned int cur_page_idx;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4859  	unsigned int pad_len;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4860  	struct cifs_readdata *rdata = mid->callback_data;
0d35e382e4e96a Ronnie Sahlberg    2021-11-05  4861  	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17 @4862  	int length;
74dcf418fe3446 Long Li            2017-11-22  4863  	bool use_rdma_mr = false;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4864
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4865  	if (shdr->Command != SMB2_READ) {
3175eb9b577e82 Ronnie Sahlberg    2019-09-04  4866  		cifs_server_dbg(VFS, "only big read responses are supported\n");
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4867  		return -ENOTSUPP;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4868  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4869
511c54a2f69195 Pavel Shilovsky    2017-07-08  4870  	if (server->ops->is_session_expired &&
511c54a2f69195 Pavel Shilovsky    2017-07-08  4871  	    server->ops->is_session_expired(buf)) {
de9ac0a6e9efdf Rohith Surabattula 2020-10-28  4872  		if (!is_offloaded)
183eea2ee5ba96 Shyam Prasad N     2021-07-19  4873  			cifs_reconnect(server, true);
511c54a2f69195 Pavel Shilovsky    2017-07-08  4874  		return -1;
511c54a2f69195 Pavel Shilovsky    2017-07-08  4875  	}
511c54a2f69195 Pavel Shilovsky    2017-07-08  4876
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4877  	if (server->ops->is_status_pending &&
66265f134acfb2 Pavel Shilovsky    2019-01-23  4878  			server->ops->is_status_pending(buf, server))
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4879  		return -1;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4880
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4881  	/* set up first two iov to get credits */
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4882  	rdata->iov[0].iov_base = buf;
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4883  	rdata->iov[0].iov_len = 0;
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4884  	rdata->iov[1].iov_base = buf;
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4885  	rdata->iov[1].iov_len =
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4886  		min_t(unsigned int, buf_len, server->vals->read_rsp_size);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4887  	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4888  		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4889  	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4890  		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4891
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4892  	rdata->result = server->ops->map_error(buf, true);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4893  	if (rdata->result != 0) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4894  		cifs_dbg(FYI, "%s: server returned error %d\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4895  			 __func__, rdata->result);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4896  		/* normal error on read response */
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4897  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4898  			mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4899  		else
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4900  			dequeue_mid(mid, false);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4901  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4902  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4903
1fc6ad2f10ad6f Ronnie Sahlberg    2018-06-01  4904  	data_offset = server->ops->read_data_offset(buf);
74dcf418fe3446 Long Li            2017-11-22  4905  #ifdef CONFIG_CIFS_SMB_DIRECT
74dcf418fe3446 Long Li            2017-11-22  4906  	use_rdma_mr = rdata->mr;
74dcf418fe3446 Long Li            2017-11-22  4907  #endif
74dcf418fe3446 Long Li            2017-11-22  4908  	data_len = server->ops->read_data_length(buf, use_rdma_mr);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4909
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4910  	if (data_offset < server->vals->read_rsp_size) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4911  		/*
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4912  		 * win2k8 sometimes sends an offset of 0 when the read
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4913  		 * is beyond the EOF. Treat it as if the data starts just after
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4914  		 * the header.
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4915  		 */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4916  		cifs_dbg(FYI, "%s: data offset (%u) inside read response header\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4917  			 __func__, data_offset);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4918  		data_offset = server->vals->read_rsp_size;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4919  	} else if (data_offset > MAX_CIFS_SMALL_BUFFER_SIZE) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4920  		/* data_offset is beyond the end of smallbuf */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4921  		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4922  			 __func__, data_offset);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4923  		rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4924  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4925  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4926  		else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4927  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4928  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4929  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4930
c42a6abe301283 Pavel Shilovsky    2016-11-17  4931  	pad_len = data_offset - server->vals->read_rsp_size;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4932
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4933  	if (buf_len <= data_offset) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4934  		/* read response payload is in pages */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4935  		cur_page_idx = pad_len / PAGE_SIZE;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4936  		cur_off = pad_len % PAGE_SIZE;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4937
c42a6abe301283 Pavel Shilovsky    2016-11-17  4938  		if (cur_page_idx != 0) {
c42a6abe301283 Pavel Shilovsky    2016-11-17  4939  			/* data offset is beyond the 1st page of response */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4940  			cifs_dbg(FYI, "%s: data offset (%u) beyond 1st page of response\n",
c42a6abe301283 Pavel Shilovsky    2016-11-17  4941  				 __func__, data_offset);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4942  			rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4943  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4944  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4945  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4946  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4947  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4948  		}
c42a6abe301283 Pavel Shilovsky    2016-11-17  4949
36c9de734b21b4 David Howells      2022-01-24  4950  		if (data_len > pages_len - pad_len) {
c42a6abe301283 Pavel Shilovsky    2016-11-17  4951  			/* data_len is corrupt -- discard frame */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4952  			rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4953  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4954  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4955  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4956  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4957  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4958  		}
c42a6abe301283 Pavel Shilovsky    2016-11-17  4959
36c9de734b21b4 David Howells      2022-01-24  4960  		/* Copy the data to the output I/O iterator. */
36c9de734b21b4 David Howells      2022-01-24  4961  		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
36c9de734b21b4 David Howells      2022-01-24  4962  							cur_off, &rdata->iter);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4963  		if (rdata->result != 0) {
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4964  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4965  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4966  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4967  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4968  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4969  		}
36c9de734b21b4 David Howells      2022-01-24  4970  		rdata->got_bytes = pages_len;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4971
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4972  	} else if (buf_len >= data_offset + data_len) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4973  		/* read response payload is in buf */
36c9de734b21b4 David Howells      2022-01-24  4974  		WARN_ONCE(pages && !xa_empty(pages),
36c9de734b21b4 David Howells      2022-01-24  4975  			  "read data can be either in buf or in pages");
36c9de734b21b4 David Howells      2022-01-24  4976  		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
36c9de734b21b4 David Howells      2022-01-24  4977  		if (length < 0)
36c9de734b21b4 David Howells      2022-01-24  4978  			return length;
36c9de734b21b4 David Howells      2022-01-24  4979  		rdata->got_bytes = data_len;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4980  	} else {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4981  		/* read response payload cannot be in both buf and pages */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4982  		WARN_ONCE(1, "buf can not contain only a part of read data");
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4983  		rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4984  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4985  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4986  		else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4987  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4988  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4989  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4990
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4991  	if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4992  		mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4993  	else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4994  		dequeue_mid(mid, false);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17 @4995  	return length;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4996  }
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4997

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
