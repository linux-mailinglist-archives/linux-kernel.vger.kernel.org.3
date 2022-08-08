Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00DB58CC6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiHHQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:55:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762B2BC5;
        Mon,  8 Aug 2022 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659977704; x=1691513704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CoHcpQKTURlZ8CRF5Ksnd+h7aJcmHhj4uX8yWm8RIOU=;
  b=bQ5hz6ZGUxK1t5Nc0A0PDVTfFM1jPpwRBGOO2lPKCpj7pmbAZJymr+yv
   YHj8EpapagyPn5Vl8Rm6KQ5I4uYTTTBLYgdpkhibYHPuOZSqC++z8ABU7
   tkuKb8/JbRjfkDPiZt+JpVgwho9CQyiL9cuVw8Zvl0PHgSXJMbVj4IimR
   XOYSqPOybP57Q1fsLhvH/0OPFGJjxvJ1Ah62asHmTdkN8mOH0Wup1q5+3
   yXhuGmprcllUwpLI1wuit8IvWmJ2G5vae8UxbEN5DzciNf3p/4epiM0Ll
   qsZH5NMdRosRJdhg3X/mZvnq0S3kK4G5y/eUZRQSU0NxxB4XCOmTnnnUT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273690943"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="273690943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="672562212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2022 09:55:03 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 09:55:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 09:55:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 09:55:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 09:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGbRHrBOpiXtRoPmlui7gO01HID4Zize4gSX40UkBWZQiGaM7ENz/aqBzlKEmk169XyQR+h85VyRzfobjS1Hl/NnfPy6FmLBJ8s6ojRgZyZTt9qLcQPN7dep7dtk7lzmBvm/xAGg2PeLTNwUsmia338XhWXacamAhCB6Udn+7ckfDEz/2KHWZyN6cgdVOXTiWiYKHVFDjUrNksS4CPxr8hXKo+QkCX+sK9HqxkYyfsoYcu1VJYT2RXJPQA1pCpwsInMf7efrp7DqMrFVEqSIBMaxHTmVHEfFqH++u/DPb0CXLs630rvqNDhCtCCoatqRCcfHlqqstQ1cgMv6ZbuUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwrKLA12gKmsha7zJwZbXhNyv6G1ECC5TZqV0A8FgH0=;
 b=AkJmmtkXgwZB8kXEDy+K84NMtFN+q8ct2dgrM1aAAKLD2cfVY4gwIlTDY8zfV0z+ELb0X6v9XfuFyvo15RKbv+wKHVUYe8KNO5IBKTkZW5SBsxBLM2WLjjlGoZeUTC4/FHCB6Vmrj7G9D8mpjYX7zHoGwrDNKXDtgrPHsuzx/dcF3yU34NO5ab2NwLBMDO6AYopxYFZfts9KT2J8ogz6UY/cYQ9edEP+bmachGthtUFvvR3xiF3SP44hG0sdZdzA6y/AzCabNugnYxafVWSr/mJpIyIVuuVv2yxozFx9KIqp2vEN6I/wvfrKWoWcNp1l35PDj5MEk03zCxI43MC9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 8 Aug
 2022 16:54:55 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3ca1:5c8c:1fd4:6057]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3ca1:5c8c:1fd4:6057%9]) with mapi id 15.20.5504.017; Mon, 8 Aug 2022
 16:54:55 +0000
Message-ID: <57f48ba3-d01c-f3d8-8e33-65d3cd9a349e@intel.com>
Date:   Mon, 8 Aug 2022 18:54:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [ACPI] 1d52f10917: BUG:KASAN:use-after-free_in_strlen
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>
References: <Yu+z9IMoxRrDTjpd@xsang-OptiPlex-9020>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <Yu+z9IMoxRrDTjpd@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::9) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f444ea5-69ac-46d4-395a-08da795eb84b
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mKjPyJCiVm/nJEPtzqZ8x53FjsTpJIzQm8VuwlnfTFM0aNOIwLzuzpi3S5v+0Kj9V2PGSgT5SGfew43KK06mvvoBwuRcdh1w4+GtFSdO/a31JhxlaKgI/bqB7lbgPqwzWO1VI/FnDRniFxIxNdtzC6yxyuSEAXYV1307gFFT6DsCtaf9qDDDLiTgDFFTsbbXfEyocqVhnVnHCBeHu8b9niV6vdZhPvw36ZeD80ZvC/B3yGX9tFvoUvQDsgRBgH906Y7DSiHGq8EtckGc+LePcjvZ3NnYMT2j202BBaBPXyICaLGj8l90MaNA+tSy6GrB1wHLictGOfiHtuV+tUcv6YOjQIx8TxuqUk4li42RLV76kOo9XQK92ZuyQwgmrdvWqlxpayBGvdcTyxNav6qrTO4dsvb4qnOV/8d52t4n0zmXXMeQxD3NNQBJLKyuEZ3Fzmc6GZl/CWycuto+h0+MrmdkD2PnrDYBUlngjkXlHkUQv8WOUE8zwDcqXrf4OjRGkqMaNA7xQ50l3y9Qe6G0VtmtoZS+E13rMSA22Vf7ii7uGDZ00u4Q8buPKmT2TGh5IxyvXMwMBobYbgX9dTCM6axSJ5p+qmNg0QO62ahkMhx/OLGYnbs3xZswaDEJx8YoAxe0Cl1MfYcwHmLrkidiImcjlPtxQHNDtF+/s35v49Wxd5vi0p8TBBXlEz3jPQNm1uHuhsM92itXzeXqEn38LKybiiRkv+jDrRMnVcwVK3ZDH95X9v6UxHQCqbFMcwyC7/jrMGGuJJ+UIJU8qcFoc9/yLx3AnXURIh7Nmm+Rm5a94Mkf/Il0Q9wjxHQpXfvBnLYRyCRnQvQklzoARbiCCQY8HznjSRrZjnr2P96x9wX2yByrjJlmIy5G+9FQdx26iZ27WXcTB/H+JiVqUS3Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(31696002)(6512007)(26005)(36916002)(53546011)(86362001)(41300700001)(6666004)(38100700002)(2616005)(186003)(83380400001)(6506007)(82960400001)(66476007)(5660300002)(316002)(54906003)(6916009)(2906002)(31686004)(66556008)(4326008)(8676002)(66946007)(8936002)(6486002)(966005)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJxTHF6bGxXTVBEbUFqTDVHYTFndE1udDNJc0tpZlNKK3NIUkJVNXU1Mkxw?=
 =?utf-8?B?TFJySS9Xa2N0T01EK2RrRDUxUnNOOXp5OWw3Sk5janNLYVQ1Tnc0eVF2NUww?=
 =?utf-8?B?YUJkblQwMUt0ei9aZ05ta29ON3RKVFQ4eVZ6QmtiRk1QTlpsQTQzQlA3NWds?=
 =?utf-8?B?N3lsOEFnMHNRVC83UkxwWXRtR1A2bnl1ZDdRR0w0VklvaXp4bmQwRDZsN3pw?=
 =?utf-8?B?ZzZnQWpQWkRtUG10akRUWENxTnVkcnhwTVNzUDFOY0l0LzIvUjdZeVhOUFRP?=
 =?utf-8?B?TDg1a1dONkFGa1Y2Y3JpWGVuTGZQNWQ0MC8vZklCSFJ0NHI5L0x3RnIweloy?=
 =?utf-8?B?NEs4eGxzdTAxcTh0ZTdwR0xTQkJyZjE4T3VqcmJSWnJFYytReUp3cE5haTJz?=
 =?utf-8?B?SXBteGZnY3ZYYnFHdDdrcW5wdnVpeFUvN2ZMZ2RTbnZZSlNKK3Z6Z2xYNWRE?=
 =?utf-8?B?K3VZK3BMN05lbHFvQmFLekxmbEdsUS9WT0ZFamkydXV6OTQwbUJVeHVudmhq?=
 =?utf-8?B?MzdqOEh2eGxsZXFKUkRZVDd6cUIvRG11Nk9aQjdhczZIYWd5c3RrOEs5STM5?=
 =?utf-8?B?cnJrWFlyeUczOGJuM1Z0dTk3aGFWR1B2WGNXbHRRL29FOGV0TTkrUVE5TDVo?=
 =?utf-8?B?VGttUC9EMUh6ZEg2aU4xc3pxd1hScDAxVlhGekZJL3d6Y1puQURqQy82Z1Y1?=
 =?utf-8?B?alY4bnh5WnpOc0dmVTE5cjhyMS81NFJYQnNyU2dheGRPRFRYRVRRUXhkR290?=
 =?utf-8?B?Nm1VdlBqUklYWldKMFk5d1I4NmxIVzFON0xiM0dMdzdOejhndjJSb2poVEtx?=
 =?utf-8?B?RTQwNmE3VGFPTmxKMjVkemVSRmZMclFYK1RRY3hvYkxOYkcwQlFPdXNuNzRv?=
 =?utf-8?B?ZFgzT0FqSWpENjJsT1BRVWh3eHVOTHgyd1FKanRZNTVVY2tjSE1JNDB3eTk4?=
 =?utf-8?B?RThtV2lpRnp2NDlSc3ZORnp0Ri9lRkFqM0hFb25pR0ZDZ3JEcHJJUWcwVTdH?=
 =?utf-8?B?TjhDRmdEV01nWCtOR29XNi9hR1hEN3BFd3V1OXR3dlk0aXpnTlRCWE13RUFE?=
 =?utf-8?B?MWVHL0ZhRU9yTVJ5QUc0a2dyTU9LMWpvQ05ocFZTM0tHWnhVWWFSNEM1Z2tu?=
 =?utf-8?B?bkRaZmxQaUZkTlpjUXFWR2g5NUgrWU1LeWw4OGlpQVltcDdyeUtSck1CYlA0?=
 =?utf-8?B?T1p2TzAvRkgrTFYvbHlqS0RpSUl0ZU9CUVZWSzRTY2FjeEJhM1RQa3BtRmN3?=
 =?utf-8?B?NS9UcHJabnRYcExESitoTFFyWElIMnJkRDA2dDdpVnZ2eUdxbVVqVExlYXkw?=
 =?utf-8?B?T3ArNU1NQ1JvYVk1aTlFazU0cU0xckNrYndrdGdGWlFMZThUdVJOR2p4NHJl?=
 =?utf-8?B?aDQ5VHBzR2JPSUZlZW9oRStzRmhJODFKbnYwRDNOT0tESXFvOTNBZ21rMlVF?=
 =?utf-8?B?T1JOazBtaFdleVcvZlZVempWNlVQSXkySmlnRjRaQmR0SW4zbVNSWVdGWUhY?=
 =?utf-8?B?N0Y4NEIvNkNiV1c4NHFFcUxldXJkdjhPQWIvZ2I2N1V1NUF5d3FsbnJmVFFT?=
 =?utf-8?B?aGljbGsvd3pDZW5oTmFJUXY3QzEwc25kUnoyOTJPN1hab05zNlVYc2dtaWRn?=
 =?utf-8?B?TEdrZlV0a2R5ajBLWEo5d3hUUDcrQyswbnZFdUxGRHljSGQ2Qjg4aXpteFFI?=
 =?utf-8?B?VTg2WnZaS3EvWHIrOGsvYkJHUWgxM1FBWFRXTWxEeTVzQ1lmaDl2UkpHeGV3?=
 =?utf-8?B?eDRURlJqT3FEZkl0dWVGZWpqaVgwd3loQUtQUUM4Yy8wUU1oWlVBcXN3R0NV?=
 =?utf-8?B?VENPdVZvK3R2ZHRjTTdBb1BnUng0bHdpeTM5OVNxYnhDQjFxVVJtN052WGFP?=
 =?utf-8?B?dnE0T3IxbEdHR0tzQ3NkSk5LeGpkWG5kU2c4Z0l6Y1N4c0NadWxaaHNFdVVU?=
 =?utf-8?B?Wjducnp1WmVWam1ySlE2SEJqQW11cmM1SE9GM282M1Zrd1hodWlwODN0TzEw?=
 =?utf-8?B?VFZVS25DWjk3ZHV3ZkZzVlc4cTR0V1psQWxUSXVyOUFyMDY2eVh0MmNMeTl3?=
 =?utf-8?B?K2l2eThQYjVKa0RkemtsQ2dBSEV0UzA5LzQrNjRzQmtIOGVuUXdodVBvSkFi?=
 =?utf-8?B?bGtlVS9CMjN2MlRiVENURVVHaFBJSlVDSThIRkE1c3dWa0FQNnd3QTMybDVl?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f444ea5-69ac-46d4-395a-08da795eb84b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 16:54:55.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy2sQpNw3lU+xXXbhka6npj3WYmTwpi86T1LZ4ELEYhEPJ4d2Oqbo+mAMiQfZ11YWTkDuU2RneR0mgDe7ViMfPGm4oWL/OmfMubMQlCPOtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 8/7/2022 2:45 PM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 1d52f10917a751f90e269a0ed9b6cca60dbe0300 ("ACPI: property: Tie data nodes to acpi handles")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: xsave-test
> version: xsave-test-x86_64-c2e44fa-1_20220609
> with following parameters:
>
> 	ucode: 0xec
>
>
>
> on test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 16G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

The crash below occurs right after a "Can't tag data node" message from 
acpi_tie_nondev_subnodes() and I'm really unsure why acpi_attach_data() 
has failed here, because none of the arguments is NULL.

Can you have a look at this, please?


>
> [ 1.735553][ T1] BUG: KASAN: use-after-free in strlen (lib/string.c:487)
> [    1.735787][    T1] Read of size 1 at addr ffff8881036e8820 by task swapper/0/1
> [    1.735787][    T1]
> [    1.735787][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc8-00002-g1d52f10917a7 #1
> [    1.735787][    T1] Hardware name: Dell Inc. Vostro 3670/0HVPDY, BIOS 1.5.11 12/24/2018
> [    1.735787][    T1] Call Trace:
> [    1.735787][    T1]  <TASK>
> [ 1.735787][ T1] ? strlen (lib/string.c:487)
> [ 1.735787][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 1.735787][ T1] print_address_description+0x1f/0x200
> [ 1.735787][ T1] ? strlen (lib/string.c:487)
> [ 1.735787][ T1] print_report.cold (mm/kasan/report.c:430)
> [ 1.735787][ T1] ? acpi_ns_opens_scope (drivers/acpi/acpica/nsutils.c:638)
> [ 1.735787][ T1] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 1.735787][ T1] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493)
> [ 1.735787][ T1] ? strlen (lib/string.c:487)
> [ 1.735787][ T1] strlen (lib/string.c:487)
> [ 1.735787][ T1] kstrdup (mm/util.c:61)
> [ 1.735787][ T1] kobject_set_name_vargs (lib/kobject.c:257)
> [ 1.735787][ T1] ? kobject_init (arch/x86/include/asm/atomic.h:41 include/linux/atomic/atomic-instrumented.h:42 include/linux/refcount.h:136 include/linux/kref.h:31 lib/kobject.c:184 lib/kobject.c:180 lib/kobject.c:336)
> [ 1.735787][ T1] kobject_init_and_add (lib/kobject.c:353 lib/kobject.c:441)
> [ 1.735787][ T1] ? kobject_create_and_add (lib/kobject.c:434)
> [ 1.735787][ T1] ? acpi_get_data (drivers/acpi/acpica/nsxfname.c:48)
> [ 1.735787][ T1] ? sysfs_create_file_ns (fs/sysfs/file.c:347)
> [ 1.735787][ T1] acpi_expose_nondev_subnodes (drivers/acpi/device_sysfs.c:100)
> [ 1.735787][ T1] acpi_device_setup_files (drivers/acpi/device_sysfs.c:598)
> [ 1.735787][ T1] ? acpi_device_uevent_modalias (drivers/acpi/device_sysfs.c:517)
> [ 1.735787][ T1] __acpi_device_add (drivers/acpi/scan.c:745)
> [ 1.735787][ T1] ? acpi_add_id (drivers/acpi/scan.c:460)
> [ 1.735787][ T1] ? acpi_scan_check_dep (drivers/acpi/scan.c:674)
> [ 1.735787][ T1] ? up (include/linux/list.h:292 kernel/locking/semaphore.c:188)
> [ 1.735787][ T1] ? acpi_ns_attach_data (drivers/acpi/acpica/nsobject.c:336)
> [ 1.735787][ T1] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:1307)
> [ 1.735787][ T1] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:329)
> [ 1.735787][ T1] acpi_add_single_object (drivers/acpi/scan.c:1868)
> [ 1.735787][ T1] ? up (include/linux/list.h:292 kernel/locking/semaphore.c:188)
> [ 1.735787][ T1] acpi_bus_check_add (drivers/acpi/scan.c:2099)
> [ 1.735787][ T1] ? acpi_add_single_object (drivers/acpi/scan.c:2052)
> [ 1.735787][ T1] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 1.735787][ T1] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
> [ 1.735787][ T1] ? acpi_scan_match_handler (drivers/acpi/scan.c:1936 drivers/acpi/scan.c:1952)
> [ 1.735787][ T1] ? up (include/linux/list.h:292 kernel/locking/semaphore.c:188)
> [ 1.735787][ T1] acpi_ns_walk_namespace (drivers/acpi/acpica/nswalk.c:233)
> [ 1.735787][ T1] ? acpi_bus_check_add_2 (drivers/acpi/scan.c:2113)
> [ 1.735787][ T1] ? acpi_bus_check_add_2 (drivers/acpi/scan.c:2113)
> [ 1.735787][ T1] acpi_walk_namespace (drivers/acpi/acpica/nsxfeval.c:606 drivers/acpi/acpica/nsxfeval.c:554)
> [ 1.735787][ T1] acpi_bus_scan (drivers/acpi/scan.c:2428)
> [ 1.735787][ T1] ? acpi_bus_check_add_1 (drivers/acpi/scan.c:2420)
> [ 1.735787][ T1] acpi_scan_init (drivers/acpi/scan.c:2600)
> [ 1.735787][ T1] ? acpi_match_madt (drivers/acpi/scan.c:2550)
> [ 1.735787][ T1] ? hest_ghes_dev_register (drivers/acpi/apei/hest.c:233)
> [ 1.735787][ T1] ? acpi_install_address_space_handler (drivers/acpi/acpica/evxfregn.c:88)
> [ 1.735787][ T1] acpi_init (drivers/acpi/bus.c:1405)
> [ 1.735787][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1379)
> [ 1.735787][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1379)
> [ 1.735787][ T1] do_one_initcall (init/main.c:1295)
> [ 1.735787][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1286)
> [ 1.735787][ T1] ? parse_one (kernel/params.c:170)
> [ 1.735787][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1106)
> [ 1.735787][ T1] ? kasan_unpoison (mm/kasan/shadow.c:108 mm/kasan/shadow.c:142)
> [ 1.735787][ T1] do_initcalls (init/main.c:1367 init/main.c:1384)
> [ 1.735787][ T1] kernel_init_freeable (init/main.c:1614)
> [ 1.735787][ T1] ? console_on_rootfs (init/main.c:1581)
> [ 1.735787][ T1] ? usleep_range_state (kernel/time/timer.c:1897)
> [ 1.735787][ T1] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169)
> [ 1.735787][ T1] ? rest_init (init/main.c:1491)
> [ 1.735787][ T1] ? rest_init (init/main.c:1491)
> [ 1.735787][ T1] kernel_init (init/main.c:1501)
> [ 1.735787][ T1] ret_from_fork (arch/x86/entry/entry_64.S:306)
> [    1.735787][    T1]  </TASK>
> [    1.735787][    T1]
> [    1.735787][    T1] Allocated by task 1:
> [ 1.735787][ T1] kasan_save_stack (mm/kasan/common.c:39)
> [ 1.735787][ T1] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524)
> [ 1.735787][ T1] acpi_ut_initialize_buffer (drivers/acpi/acpica/utalloc.c:327)
> [ 1.735787][ T1] acpi_evaluate_object (drivers/acpi/acpica/nsxfeval.c:400)
> [ 1.735787][ T1] acpi_evaluate_object_typed (drivers/acpi/acpica/nsxfeval.c:84)
> [ 1.735787][ T1] acpi_init_properties (drivers/acpi/property.c:447)
> [ 1.735787][ T1] acpi_init_device_object (drivers/acpi/scan.c:1105 drivers/acpi/scan.c:1790)
> [ 1.735787][ T1] acpi_add_single_object (drivers/acpi/scan.c:1844)
> [ 1.735787][ T1] acpi_bus_check_add (drivers/acpi/scan.c:2099)
> [ 1.735787][ T1] acpi_ns_walk_namespace (drivers/acpi/acpica/nswalk.c:233)
> [ 1.735787][ T1] acpi_walk_namespace (drivers/acpi/acpica/nsxfeval.c:606 drivers/acpi/acpica/nsxfeval.c:554)
> [ 1.735787][ T1] acpi_bus_scan (drivers/acpi/scan.c:2428)
> [ 1.735787][ T1] acpi_scan_init (drivers/acpi/scan.c:2600)
> [ 1.735787][ T1] acpi_init (drivers/acpi/bus.c:1405)
> [ 1.735787][ T1] do_one_initcall (init/main.c:1295)
> [ 1.735787][ T1] do_initcalls (init/main.c:1367 init/main.c:1384)
> [ 1.735787][ T1] kernel_init_freeable (init/main.c:1614)
> [ 1.735787][ T1] kernel_init (init/main.c:1501)
> [ 1.735787][ T1] ret_from_fork (arch/x86/entry/entry_64.S:306)
> [    1.735787][    T1]
> [    1.735787][    T1] Freed by task 1:
> [ 1.735787][ T1] kasan_save_stack (mm/kasan/common.c:39)
> [ 1.735787][ T1] kasan_set_track (mm/kasan/common.c:45)
> [ 1.735787][ T1] kasan_set_free_info (mm/kasan/generic.c:372)
> [ 1.735787][ T1] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374)
> [ 1.735787][ T1] kfree (mm/slub.c:1780 mm/slub.c:3536 mm/slub.c:4584)
> [ 1.735787][ T1] acpi_init_properties (drivers/acpi/property.c:467)
> [ 1.735787][ T1] acpi_init_device_object (drivers/acpi/scan.c:1105 drivers/acpi/scan.c:1790)
> [ 1.735787][ T1] acpi_add_single_object (drivers/acpi/scan.c:1844)
>
>
> To reproduce:
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
>
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>

