Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194D9592CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiHOJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHOJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:16:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071C1BE8A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660554962; x=1692090962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJccKAAQQbNafb/l5YespzEKiZt+rkgScVc4Jv8rMgQ=;
  b=frG9fL6Dcb2GgdB3tJ3XRAybrBAdrGHW/yNgo+5JonszrlpO5uHFI1tV
   F1gPqtqrScmn4ztPTj4DO8ogkiVfwwNjoHj2Wo+xl032BsRRrFOdyikDO
   ylhxKKtdxzRvwxGlFrEoNzqNInifoXyuQwVYRoz+8qjsz9CU5DD+9PqUQ
   DT2HQuRoeGPfCuiLS9MgMzo3cx5fwNC+HrtjEDyqWqtf2NFhUKq4+lzTt
   5hEot8wj+IAQ6eF7oJX8X6KVZaGDnfElRgYUlV9sg5P71TiaFIENM7hV5
   8Y2egC9WvC16Sgfl9flcmycrHiRHp9M92ZqdLHRLcreSangUsk+7e6UsF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290677374"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290677374"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 02:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="639590042"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 02:16:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 02:16:01 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 02:16:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 02:16:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 02:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeGge+ilzKtN+gQNc5hSA7RLKNAp+DIEa4v9wKrO0TmLnbGXAGthWUy0EMJTyNlqzim0nQk8p0B3RVYivtUGziSClTazqpMO5226awLx4+SZyMaIXPlewvxvUTcoBvQOj+5G+RYWAuvZonWKXstLe0xgEqeG2lZozWGvawcIkcoLS/sgOGpx6LGZp5nhYdTssxTMFSHQR3Jn/kk4Fqf2pIzEzSV9yAPDdGFDXcLCEBp7t0NYBf7+AL4qfNBAM6Ut58pjA9vaMC4bE8o4fcuQF9cXBgx36tgkCt5ZEICJ22s53jtTBohmRLL9E2XaifK1RkDIzue+ofKzETB22SqeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f/cIFN0xqOrTk0o1Og/ZpP3CIyUhfxtfKda3CNp3FU=;
 b=RLOyh5pys3yZOfWy2XIQjOkUo78udjHTOG9TgItObIfNx6NNPbbwnVpw5cfxqD/uiduLhMa08Qfiw2N6AjkMrnhD5jNf5lZ8Mnsr8eHLRkMWb2ycQfggdOKks70+KmrJilZj79fJe1rSM4EoV1BJbVrrVXuMCLEX2ocx8BTsWwTAt143h0V17c+qraA/iNqTNVmfbz3EBuVITfYpyGqr64A4xor+l01m5bRcWg9NIPlKbpB12RxWAA7U+CbQ2AvQ0BD/yQp+st4VAoXgnfSe/8XvHrLXkWGRe/JzFwB5IrwJiaau8xr2a6NIhsey+fgbr6Bm1QIO32tVG5qPCvHlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 09:15:57 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 09:15:56 +0000
Message-ID: <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
Date:   Mon, 15 Aug 2022 17:15:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42a067a2-e1d9-441c-e0d9-08da7e9ec2ac
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUdENfsJlJOQ+cAn/JSSKUi4jrkIWli1h3qNYnt1QpNnuW3TqZLnWZrzjH9wYJSIrEiA96I18QV1Qg88u99mOE6g92Cr9lujCPshUZLnFNBK1klJ/buwLF56DJdi3X0E7l1MnWmVAdPkh3sn+778g0SsKBWm6QevjbA+LE1c4+8RuohfADaUZJ3F4XjUga35dc+oSsK+IeBf7tsjRkRzKtlHZJO2nWG4Z+Cy5/NqwIRbcWWJHxELC1iFFgR1fAwM0CvNr6vl6X/bynnI2w3uHqS87IRmDs/pDWR5h2x2fPLUpBbWzN8APhxeS0ayFah+J7nwE14aEingLUgYk47in8z032LYUY6h9U6mEWia7h2wzeg2xNsAEymKFBIl1i3M5+shegl+1s7aM0UjKz1uefR8CQkIW7yVKmZYrHhWq7FH6tqfzaGCVTGMDaf0F0oaMw827NzND/o/LkmVTyrsMZYYD/7f2i0v+NyuUctAVRsJtBjYTaCsA2xbLyU0OqUUWURSPvKorSLM8XGYanWYRlyzHSVlTkzU17cytnmFZmjK9JmzIBopbWTWruOciiD3F/3JxO/C1s38fXIcncCYc8I+AuuiX4crRieK5P/OyomLDEowBj5vHYODCbgrRUjQhBmZDA8MJTfBEmKycyLbXn46+jnWHd4G9BxRFwGfwxYHu3eke+XHVWyEfGL17BVTCkqknLUE2dLYd7LM3PP0fCLQcBAzJKfAENtbnElWcHsHo+BC6BNwa62vL5+UQEXwWv6gLvGtS4jTyUkxdhPgPAHpskkobjze2ZeXNYOmkFuPQ93aFO1CzCwPxTIHd/pEVdXPHxAdtHBAMOCDiF003I1yXFOJPDost9+MZ9reoRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(41300700001)(53546011)(2616005)(6666004)(86362001)(6506007)(26005)(186003)(36756003)(6512007)(83380400001)(316002)(110136005)(31696002)(4326008)(66946007)(66476007)(2906002)(66556008)(31686004)(6486002)(478600001)(5660300002)(82960400001)(8676002)(8936002)(38100700002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3haK09KRy9LZ1IvV0RuaGxTNHRxaFQyVDliVTltQmRaZnV4QzJNdVM3Qmhy?=
 =?utf-8?B?Wk1PcEdKT0RoZnF4V0JYUlV5ckk0RFVQK1hmZU1pd2FwQXhGbHNFYVVPNmY5?=
 =?utf-8?B?RFRmVmg1UjlzdHdpWFFwVnNZbVliMHB3ZHdpa0ZzdklUZTZXdGI2R0V2b0Rp?=
 =?utf-8?B?WHN3ZUtHeEpRdjFXU3VncWtSYmU1MUtYVHY2czBFRzk4aHFMZEZtUWh0dEV6?=
 =?utf-8?B?bXRLVlpwT3U4V094enZmQjJCWFlMdFVPQkVEallWZHFTcXZQRFh4NVZMemJm?=
 =?utf-8?B?cEc5TDJiU2loZ0ErbTRVQ29scnB5dWxBNUcyMHE5RmdHZ3ZhQWM4c21uNDJm?=
 =?utf-8?B?QjNGTHVETHlIUkk0ZkF2TkZwWGxnd3I1NTdxQ0lER0hYMFV5b3VvV2dTMTg2?=
 =?utf-8?B?THJFa3JqYXRQTmg5c1g5Q0dwc1BibE5lTDhXQXJQUDdDWktiYjNqeUV5RkpY?=
 =?utf-8?B?OTc4VUxKa2xRL0pFbTNJam90YXdxWE1qc2JhYzVSbnRoZDVvYmtxWkQ4VzZO?=
 =?utf-8?B?c3dVdW4wSU9PaEdXRzlDS1AyMDlZTUxqUm8xTkRTTW5CM0V5QXBKVnBxT3hE?=
 =?utf-8?B?ajY3OW1ORXBoRUlGdVJYbFhsSkV6MnRDNnVsSWd3ejVOamhBaGdUYW13OGI4?=
 =?utf-8?B?WHhSczNXcjZxNWIzNFI4c2hxQm9jNTJXTC9HSEJFcElOZElZWTdLRFhIVlUv?=
 =?utf-8?B?VG5kNkg3NWFpTWQxR0krMERDcnpkL3FEckp5UVdjQVRZUUJ1VUY2YXk3V3dM?=
 =?utf-8?B?cVlUQkI4RUZ6VU5iT3NXZlRqQktJcEVveHVaczNMN2IyYklTTFdheURPUVBL?=
 =?utf-8?B?TXFVSGc3SEIrODRpVFlsSXppMkY4Ti9WNVpKeldITExLOENBWWdjek02Tlor?=
 =?utf-8?B?bDR1Mm9qR2hSRzZwTkFiWHpnQ0ptWnZkS1E4a29wQm9KOFRMMmxIeitLdTFX?=
 =?utf-8?B?b1hMdzAzSDVMSEF0dHVvdTI0ZGdMd0NLSjlDZGVWSUMvc1dhTThBMmkyUnpr?=
 =?utf-8?B?QjZCMlYxWkpXc0FLZnBDb0hycHMvYWJyY1pMT09kTUtmVzdHWFR5OE5ndXVj?=
 =?utf-8?B?R0ErTlZqUmtudnVGWTh0R0h5MlVDbkU1NzI5YVdXaSt1aEdmejViZU5rZnZx?=
 =?utf-8?B?TVplTU1ocUQrTVNwWm9QNzZiN0pHL09HK3VmdlI4SS8xcnhRMmtDcmpMcWRu?=
 =?utf-8?B?VW9DNGJ0K0NaMlFIT3pYZTd3aDlxMjVEMkU5bmVLVXFiNzhaYmVoUmtCZEcy?=
 =?utf-8?B?M0ozSFVlM2o2THk0QXcxVkt5aFdyVks4cndCRURkUGdxdUhEdlVDNWdNYzAy?=
 =?utf-8?B?MlRsdmRCbUxMYjFaT0FBMFFKUUZUZWFQRk41S2JNQk9ZU3hHOUJ6elp5WXdk?=
 =?utf-8?B?endxa25WWnc5c01zUTJoRG5FUU4veTF2VjljNnZVVHYzbXh6U3ZSS2kvV3c3?=
 =?utf-8?B?Tk1Fc3Z5M2I4TDNjRTBFbm8zVGVydXRKZzhWS3NkeXRwazdvR3NqRENsNjhW?=
 =?utf-8?B?d3NKVjFKYVpzbm1PbFVvalZEcVdQUm8xOWVqL2FzZGY3alR1UjF1aXpyZUYz?=
 =?utf-8?B?TmpaeTFJSG51RzNtVVdWalpoYnFkbkp0c0orRm1EZ0ErZVdtTWRGZXo4RXAy?=
 =?utf-8?B?TTRRS245Q1pRcUVDOHJpdnB6Mk5BZ3A3WTBjSVY1amFDWmRJWjJtdzhwdDlq?=
 =?utf-8?B?UDhkWkMvUTVjb3VXaVBYM3NKenpvV0ExTWl1Rm1uS29CRkRNcmNJcHo1bEVF?=
 =?utf-8?B?MExDQXBGRDJhaDFRakZLbEVtT001d1JLK2RVQkdjakN0WlR0cXB4RzRqUUtN?=
 =?utf-8?B?UDloVG5rL0pZaHFLNjNsWVVWNkUvNjMxQUFzZWN5ZjhzSHBxREVqT0JYRDNj?=
 =?utf-8?B?aGcvcThRRHQya0VWS25yYjB3M0hHS1dzSUo2K0tEeDJCNUpRS1BoRlFMUEhr?=
 =?utf-8?B?NW1XUVdZZWJvMU82eDBmMFo2UTNlZHZ2VEhYbWFsaFJwdUNtalh0ckdTdDBJ?=
 =?utf-8?B?d2UrdjF6UzJLQ01kR3RyeG5hM0Y0aFErd2ZIb3ZPZlQ0eHVNdTFFMHA3bG9q?=
 =?utf-8?B?aUZ2MFJ5dHNia2FvRldUS2NKY1FwaFVQVjFNczJ3RlhvVmp4UDdWQjVBUXBo?=
 =?utf-8?B?dFVXYkdYdTlNSk93dE83UDFHbkJxU2NaS0NwcmFpTldOQ2czaGgyYzdHcjRD?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a067a2-e1d9-441c-e0d9-08da7e9ec2ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 09:15:56.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+VsNWcvt8oI+jcSMnB6iLPD7LN2cp+CrPlsq+gHrLOup2P7U0pOHRKPgYhWANkwFH0SEmyeMcoHoSomPvSTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6204
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

I found original some of test function has the prefix `top_down` and 
`bottom_up`, and some of test function didn't have the prefix.

In this patch, it just modified these functions which didn't have the 
prefix `top_down` or `bottom_up`, and now there are two style about 
these test functions in the code.

One is:
	run_top_down(alloc_in_between_generic_check);
	run_bottom_up(alloc_in_between_generic_check);

Another one is:
	memblock_set_bottom_up(false);
	alloc_top_down_before_check();
	memblock_set_bottom_up(true);
	alloc_bottom_up_before_check();

Thus there gonna be two output style, here is an example:
ok 89 : memblock_alloc_from: top-down: alloc_from_simple_generic_check: 
passed
ok 90 : memblock_alloc_from: bottom-up: alloc_from_simple_generic_check: 
passed

ok 99 : memblock_alloc_try_nid: alloc_try_nid_top_down_simple_check: passed
ok 100 : memblock_alloc_try_nid: alloc_try_nid_bottom_up_simple_check: 
passed

It may make confuse if one is printed between the colon and one is 
inside the function name.

So maybe make the style consistent is more make sense. And I think this 
can be done by modify all these function name which with `top_down` and 
`bottom_up` inside, and replace them with your new run_top_down() and 
run_bottom_up() functions.

On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Generic tests for memblock_alloc*() functions do not use separate
> functions for testing top-down and bottom-up allocation directions.
> Therefore, the function name that is displayed in the verbose testing
> output does not include the allocation direction.
> 
> Add an additional prefix when running generic tests for
> memblock_alloc*() functions that indicates which allocation direction is
> set. The prefix will be displayed when the tests are run in verbose mode.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
>   .../memblock/tests/alloc_helpers_api.c        | 12 +++----
>   tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
>   tools/testing/memblock/tests/common.h         | 16 +++++++++
>   4 files changed, 44 insertions(+), 56 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index 71c89cb9b2a8..73c2c43e702a 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -752,10 +752,8 @@ static int alloc_after_check(void)
>   static int alloc_in_between_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_in_between_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_in_between_generic_check();
> +	run_top_down(alloc_in_between_generic_check);
> +	run_bottom_up(alloc_in_between_generic_check);
>   
>   	return 0;
>   }
> @@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
>   static int alloc_small_gaps_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_small_gaps_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_small_gaps_generic_check();
> +	run_top_down(alloc_small_gaps_generic_check);
> +	run_bottom_up(alloc_small_gaps_generic_check);
>   
>   	return 0;
>   }
> @@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
>   static int alloc_all_reserved_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_all_reserved_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_all_reserved_generic_check();
> +	run_top_down(alloc_all_reserved_generic_check);
> +	run_bottom_up(alloc_all_reserved_generic_check);
>   
>   	return 0;
>   }
> @@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
>   static int alloc_no_space_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_no_space_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_no_space_generic_check();
> +	run_top_down(alloc_no_space_generic_check);
> +	run_bottom_up(alloc_no_space_generic_check);
>   
>   	return 0;
>   }
> @@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
>   static int alloc_limited_space_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_limited_space_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_limited_space_generic_check();
> +	run_top_down(alloc_limited_space_generic_check);
> +	run_bottom_up(alloc_limited_space_generic_check);
>   
>   	return 0;
>   }
> @@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
>   static int alloc_no_memory_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_no_memory_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_no_memory_generic_check();
> +	run_top_down(alloc_no_memory_generic_check);
> +	run_bottom_up(alloc_no_memory_generic_check);
>   
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> index 796527cf3bd2..1ccf02639ad6 100644
> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> @@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>   static int alloc_from_simple_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_from_simple_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_from_simple_generic_check();
> +	run_top_down(alloc_from_simple_generic_check);
> +	run_bottom_up(alloc_from_simple_generic_check);
>   
>   	return 0;
>   }
> @@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
>   static int alloc_from_misaligned_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_from_misaligned_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_from_misaligned_generic_check();
> +	run_top_down(alloc_from_misaligned_generic_check);
> +	run_bottom_up(alloc_from_misaligned_generic_check);
>   
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 71b7beb35526..82fa8ea36320 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
>   static int alloc_try_nid_min_reserved_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_min_reserved_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_min_reserved_generic_check();
> +	run_top_down(alloc_try_nid_min_reserved_generic_check);
> +	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
>   
>   	return 0;
>   }
> @@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
>   static int alloc_try_nid_max_reserved_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_max_reserved_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_max_reserved_generic_check();
> +	run_top_down(alloc_try_nid_max_reserved_generic_check);
> +	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
>   
>   	return 0;
>   }
> @@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
>   static int alloc_try_nid_exact_address_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_exact_address_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_exact_address_generic_check();
> +	run_top_down(alloc_try_nid_exact_address_generic_check);
> +	run_bottom_up(alloc_try_nid_exact_address_generic_check);
>   
>   	return 0;
>   }
> @@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
>   static int alloc_try_nid_reserved_full_merge_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_reserved_full_merge_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_reserved_full_merge_generic_check();
> +	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
> +	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
>   
>   	return 0;
>   }
> @@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
>   static int alloc_try_nid_reserved_all_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_reserved_all_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_reserved_all_generic_check();
> +	run_top_down(alloc_try_nid_reserved_all_generic_check);
> +	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
>   
>   	return 0;
>   }
> @@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
>   static int alloc_try_nid_low_max_check(void)
>   {
>   	test_print("\tRunning %s...\n", __func__);
> -	memblock_set_bottom_up(false);
> -	alloc_try_nid_low_max_generic_check();
> -	memblock_set_bottom_up(true);
> -	alloc_try_nid_low_max_generic_check();
> +	run_top_down(alloc_try_nid_low_max_generic_check);
> +	run_bottom_up(alloc_try_nid_low_max_generic_check);
>   
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 7a16a7dc8f2c..e0dd5b410099 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
>   	prefix_pop();
>   }
>   
> +static inline void run_top_down(int (*func)())
> +{
> +	memblock_set_bottom_up(false);
> +	prefix_push("top-down");
> +	func();
> +	prefix_pop();
> +}
> +
> +static inline void run_bottom_up(int (*func)())
> +{
> +	memblock_set_bottom_up(true);
> +	prefix_push("bottom-up");
> +	func();
> +	prefix_pop();
> +}
> +
>   #endif
