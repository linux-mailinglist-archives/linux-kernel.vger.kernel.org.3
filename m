Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0E595317
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHPGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiHPGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:54:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEAC1537C8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660619337; x=1692155337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KRv+/yYHLnGWOffE1Akd2GKeQw8P9Z/dwg9WZsvu0CI=;
  b=GK1EKn5Cyovlrm+pKPgDOmxSD3P4hk66nSpAGTQSv3PHSWx60dsvxYv8
   rLVPiCKidB+qqcNvTPCHEZu4cDAse1SQRMwu7DQM/T2SHqn8A3yIJdhki
   96b1antXLzYqzPNvRWH8PrPx8k8VPjBsTJFxPqUDJV4YvMaELYlmmu6rN
   No7kmgFhfuN5vPGuWOVn6+Sdb0CmnxUtza1JQ2AI0r+FvMTQy4sEsNNjK
   Gq0p5HqLZTJViKn2I4e7jRfEom55dgK6XqJOOU/XPAWnAfUs8D52AgMR4
   wg15WnObLq0oAHLkLJDqakJ3atCPuIFB41BNSehR1QM07q1pp+tB3ggv0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378402195"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378402195"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 20:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="557532163"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 20:08:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 20:08:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 20:08:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 20:08:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 20:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1kV2Vd3uXQDYsCmVo79RTEjl0xYHulkoriGBaz2j7hgGvJHaEUxtJyatx8eotXX8ks6VlQtqcPbZNGHSYBKvLprdqpN7T49jw4361HRq77z5smoA6MKMYJlPQyRpY8v0DUaIkbvMSv1OVEtJiDACCsSnKAlicsg+gP6ddo7aagFioRJHLCdI8Qib1RJFXF8hdl3ZKnMsZTHiocDN0JK24vOLWxUNl9Mdb4wa13sMKBUIUuSb/416eZAI8gWrlMbR/PNHDLOQoV+YHqCozOqfQlvzr0v76pLcjSQF3TWWwe9PZvtPp0ja49WA9W02+tkoJVDag5CRudor8VzYHhXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiBrExmvGptkwag2c65fJ3C50mJYJkj8Zdcuxfs9S28=;
 b=ahbGM/qZBa8gfCrFH5DlUu6FJrEdHzbvHQkbsN89tgr+uPQRRgtVWFiA1AsvNZlsOQla9nRtLT0d9+mVbRGRgMBFU3YMaGIMYyTnvZywbPHFcx7OQS7//brCrDfGWgyHKYtDdkSIRYkcEMPniCTzNw0d6AUbPZuvw5vDhnzr0TEan2jaRwMfc+esqrW8bO00pYxnmgcZiEAsOiXPLqKiWR2re5DskoQOEWqVSTF//gfQ3GkoQ5QoOkaiSGWbzEvDvtBz1AdqDXTD9dF2sglaybJKtVN/Eo8n111no8jOi6PTq3/EC02nwHBkjzwnkU29wp/4w2gJ7VOKQN0oOkS6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by DM6PR11MB3787.namprd11.prod.outlook.com (2603:10b6:5:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 03:08:53 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 03:08:53 +0000
Message-ID: <03f8614e-2bd7-afa8-6744-14397cbc9cb1@intel.com>
Date:   Tue, 16 Aug 2022 11:08:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
 <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
 <20220816023951.GB3590@sophie>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <20220816023951.GB3590@sophie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97aee6be-4594-428d-f18f-08da7f34a5fe
X-MS-TrafficTypeDiagnostic: DM6PR11MB3787:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +s/f2H1OvT6rvTEh3T5+hrq1haLoJ/g8cpeY/tfGqVMc9wnslt8wlmjx6mAA0zGUWPm1kMNk7hYV8dB6LoFN0YLn2abNWROYvKVA9yIVqrf+OZudxFJ7ANFvGV80zG78h1QAtmnTStTfJOuILzHbklxPEhJiFxIFoS9SOuVAeF2+ZMzEszq/acldgAcUSMguMVGwHZlvVuYJQiWWxIH9KYPZnHr7dlJ9X+JkR0EG7WIl79sUe6urpDoCsT2HhquX/BlVAAwcBOJaR8c3wBwkxGjNcW+obTELPkctYYTK3q5EIDY0geH/+SHICtH5O7hxVuk3daNg/o3C4ZrgvuJnVMoRa07LAS7p33er8XpQ725LmZ9h5MrB2VDtcZ5Ktq/wvp0EVzUZggSm3GgtAzPoa70vtJWhyyFyw6KAY2lVayfTCeziJTDVlehfp6/XwTmzzOqw23Ud7/hJN4EZ3QbLT57yBm3BlrMoYW5fheVer/TgbLVlmf/qMPwGHHlZjmpwjEstd02EzndCwHbAsOMZugRu0hwsvPlKL+P6YoDhNhHxFlL4rZuTMF4nhwrHpFhEvSPk2ffQlMKxoPeJnJXlGkIWeOV86a2WWKzWzdSMwF3xdeNFSFB/0y5co2wpeo4xnnaO7zTiU3KNQmolxlpNjG+zy9dqB7fKjM156xPeb7p50IFPU3YWCEMtOEIU5H1RAnkvh7iRlAZmyEpymZW6TJbfQvwK7fDbyCR6V2hyKdHFxOSII3wEep7oLF6jXCRbzZiwf7pTZUUNQaP2adPhyYW9tcU7Mts3KdpFqbnqJXNQv4qLDFMO/34Gss/52UCrnitPTMyvKkqqK6xfz/Imb0tyGg55FHJ7txhj7Gzywrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(36756003)(186003)(2616005)(38100700002)(83380400001)(30864003)(5660300002)(66946007)(8936002)(4326008)(41300700001)(8676002)(66476007)(66556008)(2906002)(478600001)(6506007)(6486002)(6512007)(6666004)(26005)(53546011)(54906003)(6916009)(316002)(31686004)(82960400001)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFNV0FER1g1Zlp3b25lWnN2UHpLYkJ0YkcyVVNGWUtSQitOMzhlUVJBb3FV?=
 =?utf-8?B?bUErY3oyQVBtY1p2b2I4ZG52VzFDY0hOOUFMUGhxZVo5V1FCT25lbXBLTkxC?=
 =?utf-8?B?RjNWVmRTeE9rT3ZzWTV1cWYxRm5BYXdCRHk1ZzlneEZwUUlhZGEzSmdaZHF4?=
 =?utf-8?B?YUhCVGpadk9SUVFMU1dydHNFbkNLYkU2UUhYTExQSGlud0xROUVRdHkzc2dT?=
 =?utf-8?B?TFAvYlBIdVRwZjRyVER2UDd5dTZqVWFpYW44UHc5S0RXcmVqRE9uRXBSNkNw?=
 =?utf-8?B?MmUvYWRCVVBBMlYrSGtmTnhnUVRUTVIxZG42OG1BS0lsUmhmbHZRQWwwUU1P?=
 =?utf-8?B?WUxxVXpKT3Mza1BGbTRTMTdKMmt6OVFKNVRUV2lIZDZuY1VVc3FlVDJYci94?=
 =?utf-8?B?dStPNURwUlBvQkhJWHIyYWVVZXpUcUdXSFZxTGVwWkZSTXpaaVBlSWVGT0JU?=
 =?utf-8?B?K1Q5R0hHSmZxczdHQ3NySHRhYUYvTUo3SmlBWHBCREpoY1U1MyswaGlyRUlm?=
 =?utf-8?B?eUdWZ3kwMVFBRDlCVVk5aHlSV0F3Rmk0Z1NSL2VWTzlvbEVPeWZMVHQvM1dl?=
 =?utf-8?B?WEU5b0ZST2Ric2pnUUZEVUUrS1ZHTXc2azBzRVA0dVFOWUE2alhsdTRIMkFw?=
 =?utf-8?B?NmlnMDlKb0tBSEV0Z0ZDbWhtZWdNSko0Zko2VEtVaTRGdEY3QWRjSXZjODdr?=
 =?utf-8?B?dUM5WmNuU09ja2VjTG5MS0NidXgwbGt1c09nT056NW5pVldvWFo0TmQya3pO?=
 =?utf-8?B?ZC95NTN3U2JMZDZrenR5cmlvdFBNQXJVNnhuTXBUeFlPUzlUVXhQZ1AxTkhm?=
 =?utf-8?B?eHhMS0R5dWZhWS9GejZtVC9mcnc4eHlCS1VKWThYWkpCMWtQdTIwd1RWWW4r?=
 =?utf-8?B?UmV2YWo1WkJXakduZ3ppbGJid2xNTE5vSFVJS2EvNktFOEpqNDlGWjlJT21R?=
 =?utf-8?B?M2tWMjAzQ2ZvU3lWa0MwOEFSOTA0QmlDT0ZSZ1cwM1FjdGJZWW9IcFhCTGkv?=
 =?utf-8?B?THBnY3dSZnNyN3ZJV0FubFdYd0ltMnRzL2UwTW8wZEVEMzdEVnBtSlVEV0N4?=
 =?utf-8?B?Z3l3MmtnVXYrcndmVmZtWkRwamM3Vmg4QmZUWjhONXprcHRlTm5iZFVuc2hC?=
 =?utf-8?B?SlNBbVFKOEZuZ0dJNCtpQTNhQmtXZkRFOUhGNEZDK21jbWZpa2NFTE1rU211?=
 =?utf-8?B?c0pRQnR3a1Zlbnc2YzFlRVc2Ti9sQ3dKclNBZHE0QWRiMDBrSktYL1M5dUFk?=
 =?utf-8?B?b1pkN2g0aWFDaUhlT2hPSDBWa0ZuS0c4SWdZSHVOMjEzWFhBaDVTblVrU2Qx?=
 =?utf-8?B?aDZGVFRmbldaYlRsbDY4QjQ0NDkwVmFCQmVpYW5PcjI5V1cycUtrYmlGamN2?=
 =?utf-8?B?REFaMEJtMGh2Nklwck1MOW5SeFBiU2Q1S2xPWnU0QVdXajdOWVAxSG5QNUox?=
 =?utf-8?B?YmxYU2g2RTd0MGFQYk1hbCtUOUFUajlEM2prc1ZqQStjdFNweXZHV0c1WFdL?=
 =?utf-8?B?LzF2c2w1NDBRbHloUzlnUFUrbm1mR0ZBZkJ0V0oxUVd6QUEwbkdyOGJpZ3M2?=
 =?utf-8?B?TlhaSlBkcWVXOUVEYmpNWCsxTktVdXRsZm5FMHd3ZkdwT25VZndqeTZad2c3?=
 =?utf-8?B?VjBycVNXZ2FIcFdMQUlGTm8wRjdOcVFPdHdKcSsyaGdhMXR6THVjQWZYeTgr?=
 =?utf-8?B?SUtIREJyMlY5d0FWcnQ3QUdiK3oxNkVPbUZlTkFDMFhzRkdndlhMZ0Vibmg0?=
 =?utf-8?B?WjE4K3hybzNtQTZMWHpES3MrWHg2WWN1SmlpcDNMa2hkN0xzZm5qYXYzanJP?=
 =?utf-8?B?Qm5TQ3RPYUFqYlJ6VFBUWDBHQm85MC82Um82TXJSMmt6aWY0YXA1aFJ3ZStH?=
 =?utf-8?B?aGNxV2w2L2lsdWNndHF0YzY1ckxaVHk2SmJSOHR1UTkxOEJuVWtMRzdCMkRm?=
 =?utf-8?B?N3Z1T0Q2NWVNM3NjTmFEemx6alVsYlREZ2xMUDE4aVo3NGpkK09mOGtiSkd5?=
 =?utf-8?B?cjRFUkkxY0YyYVVhaStQeDZ0SEZYd3BiaE50Q1dPbXFqNlFEbjQwTCs0cGdO?=
 =?utf-8?B?Qy9KTEJKWnphTzRNSGZQeUJBakZPdHpYRDAvYzl1dzk4eGlpTVc2MEJQWmYy?=
 =?utf-8?B?LzNwMGpkazFvVUJoMUFXZXhRWUhkeFZqYk93c2hQUGQ1TWs3UURweWIvUWZT?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aee6be-4594-428d-f18f-08da7f34a5fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 03:08:52.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSYHRHMhPQmpywr3JDxvhByJ/MHQIB+TzTk2uuAarkZShsbTbbYaTc692ubER5YDcx2xobOnO8vMPu6JxUeq3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3787
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



On 8/16/2022 10:39 AM, Rebecca Mckeever wrote:
> On Mon, Aug 15, 2022 at 05:15:47PM +0800, Huang, Shaoqin wrote:
>> I found original some of test function has the prefix `top_down` and
>> `bottom_up`, and some of test function didn't have the prefix.
>>
>> In this patch, it just modified these functions which didn't have the prefix
>> `top_down` or `bottom_up`, and now there are two style about these test
>> functions in the code.
>>
>> One is:
>> 	run_top_down(alloc_in_between_generic_check);
>> 	run_bottom_up(alloc_in_between_generic_check);
>>
>> Another one is:
>> 	memblock_set_bottom_up(false);
>> 	alloc_top_down_before_check();
>> 	memblock_set_bottom_up(true);
>> 	alloc_bottom_up_before_check();
>>
>> Thus there gonna be two output style, here is an example:
>> ok 89 : memblock_alloc_from: top-down: alloc_from_simple_generic_check:
>> passed
>> ok 90 : memblock_alloc_from: bottom-up: alloc_from_simple_generic_check:
>> passed
>>
>> ok 99 : memblock_alloc_try_nid: alloc_try_nid_top_down_simple_check: passed
>> ok 100 : memblock_alloc_try_nid: alloc_try_nid_bottom_up_simple_check:
>> passed
>>
>> It may make confuse if one is printed between the colon and one is inside
>> the function name.
>>
>> So maybe make the style consistent is more make sense. And I think this can
>> be done by modify all these function name which with `top_down` and
>> `bottom_up` inside, and replace them with your new run_top_down() and
>> run_bottom_up() functions.
>>
> So you're saying use run_top_down() and run_bottom_up() even for functions
> with `top_down` and `bottom_up` in the name, but don't change the names?
> 

Yes. We can't delete these `top_down` and `bottom_up` in the name and 
makes two functions to have the same name. Due to these functions with 
`top_down` and `bottom_up` have different implementation.

If use run_top_down() and run_bottom_up() for these functions. We can 
get the consistent output style, but a little redundant output(Maybe 
this isn't a good idea).

>> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
>>> Generic tests for memblock_alloc*() functions do not use separate
>>> functions for testing top-down and bottom-up allocation directions.
>>> Therefore, the function name that is displayed in the verbose testing
>>> output does not include the allocation direction.
>>>
>>> Add an additional prefix when running generic tests for
>>> memblock_alloc*() functions that indicates which allocation direction is
>>> set. The prefix will be displayed when the tests are run in verbose mode.
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>    tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
>>>    .../memblock/tests/alloc_helpers_api.c        | 12 +++----
>>>    tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
>>>    tools/testing/memblock/tests/common.h         | 16 +++++++++
>>>    4 files changed, 44 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
>>> index 71c89cb9b2a8..73c2c43e702a 100644
>>> --- a/tools/testing/memblock/tests/alloc_api.c
>>> +++ b/tools/testing/memblock/tests/alloc_api.c
>>> @@ -752,10 +752,8 @@ static int alloc_after_check(void)
>>>    static int alloc_in_between_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_in_between_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_in_between_generic_check();
>>> +	run_top_down(alloc_in_between_generic_check);
>>> +	run_bottom_up(alloc_in_between_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
>>>    static int alloc_small_gaps_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_small_gaps_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_small_gaps_generic_check();
>>> +	run_top_down(alloc_small_gaps_generic_check);
>>> +	run_bottom_up(alloc_small_gaps_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
>>>    static int alloc_all_reserved_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_all_reserved_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_all_reserved_generic_check();
>>> +	run_top_down(alloc_all_reserved_generic_check);
>>> +	run_bottom_up(alloc_all_reserved_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
>>>    static int alloc_no_space_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_no_space_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_no_space_generic_check();
>>> +	run_top_down(alloc_no_space_generic_check);
>>> +	run_bottom_up(alloc_no_space_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
>>>    static int alloc_limited_space_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_limited_space_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_limited_space_generic_check();
>>> +	run_top_down(alloc_limited_space_generic_check);
>>> +	run_bottom_up(alloc_limited_space_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
>>>    static int alloc_no_memory_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_no_memory_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_no_memory_generic_check();
>>> +	run_top_down(alloc_no_memory_generic_check);
>>> +	run_bottom_up(alloc_no_memory_generic_check);
>>>    	return 0;
>>>    }
>>> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
>>> index 796527cf3bd2..1ccf02639ad6 100644
>>> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
>>> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
>>> @@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>>>    static int alloc_from_simple_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_from_simple_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_from_simple_generic_check();
>>> +	run_top_down(alloc_from_simple_generic_check);
>>> +	run_bottom_up(alloc_from_simple_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
>>>    static int alloc_from_misaligned_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_from_misaligned_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_from_misaligned_generic_check();
>>> +	run_top_down(alloc_from_misaligned_generic_check);
>>> +	run_bottom_up(alloc_from_misaligned_generic_check);
>>>    	return 0;
>>>    }
>>> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
>>> index 71b7beb35526..82fa8ea36320 100644
>>> --- a/tools/testing/memblock/tests/alloc_nid_api.c
>>> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
>>> @@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
>>>    static int alloc_try_nid_min_reserved_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_min_reserved_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_min_reserved_generic_check();
>>> +	run_top_down(alloc_try_nid_min_reserved_generic_check);
>>> +	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
>>>    static int alloc_try_nid_max_reserved_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_max_reserved_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_max_reserved_generic_check();
>>> +	run_top_down(alloc_try_nid_max_reserved_generic_check);
>>> +	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
>>>    static int alloc_try_nid_exact_address_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_exact_address_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_exact_address_generic_check();
>>> +	run_top_down(alloc_try_nid_exact_address_generic_check);
>>> +	run_bottom_up(alloc_try_nid_exact_address_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
>>>    static int alloc_try_nid_reserved_full_merge_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_reserved_full_merge_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_reserved_full_merge_generic_check();
>>> +	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
>>> +	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
>>>    static int alloc_try_nid_reserved_all_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_reserved_all_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_reserved_all_generic_check();
>>> +	run_top_down(alloc_try_nid_reserved_all_generic_check);
>>> +	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
>>>    	return 0;
>>>    }
>>> @@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
>>>    static int alloc_try_nid_low_max_check(void)
>>>    {
>>>    	test_print("\tRunning %s...\n", __func__);
>>> -	memblock_set_bottom_up(false);
>>> -	alloc_try_nid_low_max_generic_check();
>>> -	memblock_set_bottom_up(true);
>>> -	alloc_try_nid_low_max_generic_check();
>>> +	run_top_down(alloc_try_nid_low_max_generic_check);
>>> +	run_bottom_up(alloc_try_nid_low_max_generic_check);
>>>    	return 0;
>>>    }
>>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>>> index 7a16a7dc8f2c..e0dd5b410099 100644
>>> --- a/tools/testing/memblock/tests/common.h
>>> +++ b/tools/testing/memblock/tests/common.h
>>> @@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
>>>    	prefix_pop();
>>>    }
>>> +static inline void run_top_down(int (*func)())
>>> +{
>>> +	memblock_set_bottom_up(false);
>>> +	prefix_push("top-down");
>>> +	func();
>>> +	prefix_pop();
>>> +}
>>> +
>>> +static inline void run_bottom_up(int (*func)())
>>> +{
>>> +	memblock_set_bottom_up(true);
>>> +	prefix_push("bottom-up");
>>> +	func();
>>> +	prefix_pop();
>>> +}
>>> +
>>>    #endif
