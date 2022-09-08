Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09D5B1194
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIHAv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHAvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:51:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9A8A1F6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662598282; x=1694134282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygSh0YVnnXT6v5tSzeRBoYqUFFzzcSDUuFyfbW4+3qI=;
  b=eB04kzEv/PSPGuvmzjlgRvIAtdEXSAu8x7zeRKQ1lW6z4mgpYGxm1U4l
   LsMPIKxqn5t6vi2fDRM06P6CT206wllu1TBwWSHbTO3pCgggzrFn1b9hi
   GFrEi27vEiMMQPlJ4F2DtvtBHCNHOopf3dZxTCYsL+2YPE04Ses/uzGwF
   H0OV7UC9x5ogNGjyVX7CuMbeNqDgfk+eaAn+fKFXQMoCQhu34ZloQueb4
   CXq3h8gQNHueR6ju3ZKhIz0azWQblgCBprsb7pEs9O9ZRkLO1ViEShBM+
   81uD1dYUuh8/UvVOfLeXEJ5whCCkxPKvfBgtCP9vxWq7pGkTk2pXxK+q8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297033302"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="297033302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="676447347"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 17:51:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 17:51:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 17:51:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 17:51:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 17:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6G7ezfC9A0pGF7ilLfMnTfkx3tq0gcXxnhzVFzVeRrXI6HKruqWGCFdEqlDbTimvTUZ5N9wT0ZsMV5/lDfa+t2wxNPiUbfo6ztfPoEtON46n8AdGEkLcNNmJHLL9+eWqheVWZkkn6RcKOI2SliO5usbRtaCyg3LHD+uv+gysgUGhVakKF/AKDQ6idiyXnBopfeZMvLIiFBWko6yIG6hfbfKu3IW6wPqclB3fLTdzDYRNRg/5iKfYjIu9cLvtY+vqlwXRHhHAewd9bIO+1Bf/IHuwbHt2iHgP8fZuSAJgezf40IMP47PUwvxG9nOS+izQjk8fNeD9cHa1Jd9shGpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAtZzhu4bvQH3WlzsSQZoy8SeE6jKm3YMNIoytORn2Q=;
 b=JfzJaaED8dhw3hXxPufkpqdqVZDfL7vK2SG/KA+GEMwdB2Ew3A2Ej7mWl5vPBNtRxpo6SZ6oSb6MOaLRkoVXVXja1QgNID17XHbtJXPtr9scg8+IS63D6gEx2upki5RbaltrYmWueKO12MpRFnil+l7x2uzG6yJSAvx6C/ePaSq7L5OAui1fOtEoonAlkX9o37fke3p3OzdMRrzUHBDa1gXz11iwFTCA+iu39ll7mfsZJNwC4BWV4Kjhpn8I13wNYFL8rRmnxX0GL5wP3jSSXZy5KeUDKypak3hw8Io1UGnZ1+pcAV81o9GUlmNBiJWhMCU9SN5cv8MtZwbG9uu1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Thu, 8 Sep 2022 00:51:17 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 00:51:16 +0000
Message-ID: <591083d2-d1cd-e60d-5331-5a0032bae94b@intel.com>
Date:   Wed, 7 Sep 2022 17:51:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v9 09/16] mei: bus: export common mkhi
 definitions into a separate header
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
 <20220907215113.1596567-10-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907215113.1596567-10-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906b96b5-1aab-4430-e78f-08da91343bb0
X-MS-TrafficTypeDiagnostic: SA0PR11MB4717:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJ5Uacl0fpq/1guTY+a6hKaLVfTPZ0JdshVnq0fY17WdVnR9g6cMFyyzvmc0i0+YC+r24TKL27a+jIGwVwfGJMRuqp38BVPARkFyHLAvUcDMmNABaIXDG4R5ntyfLThH8iRVCzUjAobnw7+xzpD1HwVCIdAofotfky36mGW5qPP2YGqYxiDN7/c5iXUuVlVrfRGp8kB8ab+FxP1vavfMEhbdMpQy2dA0K3abD/5wX0guxU70LZeYjkNTiIIJiSHjiN69Dp4I5ICFz1h6Ut2OJOauoJqvlgznt5A9prGGvuYLj8WX4SETl9q0ikXAGuqAnLHoICr2YPzlupjFC8utvAD/bW2dSaE+iDFpZN7furFV1q3si1brXsedkLCJZ0VSpwfVTjzYWSYqIIXzIBvzux2Fb5SOuC0Pa/wuKpMBBWP0D8YkUOM6baJkftL5XD+cRvzKV5RxXu3TvcYz6+1IXiKArUlgPzbLBxUV9/zryCKZQDOgXERWxoxsg2rqpPehh19QXIOpANBUyjGE5GcyDn5kvzax8oZ2M5bIcahXDHR6fqNKSRGJPQVGlYNEoc8CYOePDlunfGUtkeG37ESh15vk0hAkYi5e90XKpGKoTAisTy6v8wi4koOpBWV5uaMiSxmMDZIwqKe+IpiNoG4Jfez5r2nn+B0obAtRjZXB59BXckxppsFIema8O6fr8Ks3yynnt/byjB4P1ZklLIzZMlRbYfM3vFQb20g5ehwtbWu/4jYq3lu+MZr6ympw2J/rBtCVphfqgbQdjbpVvSwKltIFB8BCNDc8SuH2ZTN2Rgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(39860400002)(396003)(41300700001)(8936002)(2616005)(26005)(6512007)(53546011)(2906002)(6666004)(5660300002)(107886003)(31696002)(6506007)(38100700002)(82960400001)(186003)(83380400001)(66476007)(66556008)(66946007)(8676002)(4326008)(86362001)(478600001)(110136005)(54906003)(31686004)(6486002)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUcrcVBvam5LU1RnUjlZM2F4K2hBb2ZaWUhSd3RYbjAxK1BCek51UUg2R2dh?=
 =?utf-8?B?UVY0QzNLNlpweitNU2JQc21RMTZsK0lXL3BTcEszVDZjMzZQMW9zcExoOVpW?=
 =?utf-8?B?aUtZdFhGeTlvZjY1M3JWM0lnNG93Mlo3UGovNytEcjhrOFF1UGxxZXFjbGJU?=
 =?utf-8?B?V0NTeUUzcEcyRjlEMm9ySnZnejVFbU42MUlaNWcwVVRvNGhEcnZyQk1sNFdS?=
 =?utf-8?B?TEM2K0ozTU1nRXE4ZUVHVnY0d2xrM2wzLy8wRVc4a1NOYTZRTXpMRHkyN2Fy?=
 =?utf-8?B?V0RMa3ZlVDZacUYwOVRsMGRLU3FFT1FqSFl6SUtxeGJ1QlZSM1UzY2NCb0FW?=
 =?utf-8?B?akc5aHZKSFE1bEdLYy9kOTY3dHF6c2FsK00zNmVPekpVd3hKUG1FRE9HUW5H?=
 =?utf-8?B?OW1XRklSUkd0NHJremRkRWhiOEtpRXZodGJmY0FhaDFFSjYyUEhxREJkZmdu?=
 =?utf-8?B?ZVRhZmQ3dDBuTEJPZDB0ZmJwRlVIL0FQRnh3SzlOYi9HVWZIUHBGUUFHQUVW?=
 =?utf-8?B?Y1BBS1lYVFBKK1F1cnNVdE8wQW4rVjIrS042aW5VN21XbkVpZzYwRGNJV2hK?=
 =?utf-8?B?WjIyRUlaR0dhdGFaNE5MMFBCcUt0b3JSQ21wN1d3L2tOREJPTFh2c21jcUZh?=
 =?utf-8?B?RXlEK2FKOWR1dmRld3NaVlpiS3ZQMjR2akhTdEtOTkZXblI4OXVaa2phNUZF?=
 =?utf-8?B?d1BFeE9BZ0tXakdUaWc3c0NBYWdXclJKTDVMYzZVOXBlaGNBUnBxdE1HWG1T?=
 =?utf-8?B?MWNEQ1JQd3FpNm1JYXVoaEtpUllacW5DVllXTWV0V2dpMklFVVlkWjJRczRT?=
 =?utf-8?B?c3A3OHRWTHlOUy9HQnNqWGpEQVlLa0laOGJkelIwTGMrVFMwblp1cUlUT2x3?=
 =?utf-8?B?WG5MWS9yR0pySmhlUWtodFNLUUtKUVlLczB1b1FrSU8raTd5Z3h6dE10OXNW?=
 =?utf-8?B?V245OWJGM0hqNEJsVHd4Z3BzTEJhVEVVaTJhWm8vZWl3MVdNMmY2ZHprSDdM?=
 =?utf-8?B?S2l1SGh1b1doRjBPMS9QTm9jNVMyZGFFeWpVZVlvK3Jndy9IUXA5YitsME9t?=
 =?utf-8?B?V0tkcXY0RVZNZnNRYTh6VkhkR1F3YmtCNGxBNmJadDNscHp5R2IvSGRoeCtH?=
 =?utf-8?B?ZHZLQVBmVE9UTmRCcDhLRnpzSnRpTUhVZEZNQ3BuTk9wZDB2V0dqNy93NFh2?=
 =?utf-8?B?Y0lmcUw1ZnR4QkdXQ1VhYWdqT2EwKytEZGRhQXg2OVhDOVBiSklkU1k3SEJH?=
 =?utf-8?B?T0wxZFhlbVVtWWdsaDlUb0x3UHV4cVVVempJYjVrTDlaNmJUNnZ2VGhQTDJW?=
 =?utf-8?B?UGM4TllScExibEM1Zm5aNDhlZ3JJUm9VanZoWUJHd2hYU2VmSlUrdGVOT3ln?=
 =?utf-8?B?MGdJeDFodjcrU0JVMGY5S1o5SDM5SGV5ZDN0R2tVN2UxazBUdldrQ25raytr?=
 =?utf-8?B?dkkrQWdhQkJKdGsxblR2aTJFUEhvZDhURVpsVmQ1UFErd2t6RkNPV0duVmVV?=
 =?utf-8?B?NlJFUE53L3NiR1lvU1F2ZXJNaGFCWDkrbzBYSzMzS1gyR09TK05VcGVXQzM2?=
 =?utf-8?B?RnErTFlaQ3kzeGdwVC9xTE9TTzVyRlV4ZkNNdGhvMUpMWitpUVlTZ2grUXFt?=
 =?utf-8?B?VDNET2s5R3dUMDErTjJ6Ynk2RkozN21NVG1jOVNTclRyMVFsSXQ0Q2xjZXND?=
 =?utf-8?B?N0hiZUZFQ0x4bHNBR0d0Yk44SkxUbTdqYit2UFFFd3ZZa1UyeGpUdkZNOTlY?=
 =?utf-8?B?NmJkZlowMFV6bE5nbkhnaG5xMUNwa05tTmw2TzFiemRhN1h0RW9tbWxzbmtE?=
 =?utf-8?B?TTN4ZXpHVHRMcHdMYXJzRTV2QWxsanNxYUN4RnFXU1I2R2NyRUhJWncra1dG?=
 =?utf-8?B?blBSZlZsd0RtWHltTkEvTW1wUjM1YldKSDdweVRySmpLeEFKcVFZem4zL3lw?=
 =?utf-8?B?Q3hodGJQMzdrcXdtOExRbWRmaDBseDdMdFdVQUlHQTJpc2FkanBSQ3VrdW9x?=
 =?utf-8?B?ek1iWFBhc2svZUk5RHoxN2dsV2JURHhqbWpFakZaL2hJK0pRTFNjUzMyN2Nn?=
 =?utf-8?B?TmNQTFNOVnFGeWZnQjA2NS9DOFU3MzRJdFVMM21yMzVKLzZqU2JGZTBZZW12?=
 =?utf-8?B?ZUF6dHpWNVZVc1NTMmgvS2tlQXdWREJET2c5YjRVTjU0N0VmRjNGVjBkUFU1?=
 =?utf-8?Q?FKXy/aaxSEqeNTezmbvr8No=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 906b96b5-1aab-4430-e78f-08da91343bb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:51:16.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K9EsPA6RGfbrfikxlCZEK8Iez3VJzUtoG3t3kHleSOBIxXfvPlzdbdOkvooVTccDH4+VYzk2YFKJnzitQu5dZj17ID62lKguhU8ZWnCSDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 2:51 PM, Tomas Winkler wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Exported common mkhi definitions from bus-fixup.c into a separate
> header file mkhi.h for other driver usage.
>
>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
> V8:
> 1. <linux/types.h> is enough for mkhi header.
> 2. drop MCHI_GROUP_ID definition it is not used
> V9:
> 1. Fix duplicated definition caused by wrong --ammend
>
>   drivers/misc/mei/bus-fixup.c | 31 +-------------------------
>   drivers/misc/mei/mkhi.h      | 43 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/misc/mei/mkhi.h
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 344598fcf8e9..c4e527803299 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -15,6 +15,7 @@
>   
>   #include "mei_dev.h"
>   #include "client.h"
> +#include "mkhi.h"
>   
>   #define MEI_UUID_NFC_INFO UUID_LE(0xd2de1625, 0x382d, 0x417d, \
>   			0x48, 0xa4, 0xef, 0xab, 0xba, 0x8a, 0x12, 0x06)
> @@ -89,20 +90,6 @@ struct mei_os_ver {
>   	u8  reserved2;
>   } __packed;
>   
> -#define MKHI_FEATURE_PTT 0x10
> -
> -struct mkhi_rule_id {
> -	__le16 rule_type;
> -	u8 feature_id;
> -	u8 reserved;
> -} __packed;
> -
> -struct mkhi_fwcaps {
> -	struct mkhi_rule_id id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
>   struct mkhi_fw_ver_block {
>   	u16 minor;
>   	u8 major;
> @@ -115,22 +102,6 @@ struct mkhi_fw_ver {
>   	struct mkhi_fw_ver_block ver[MEI_MAX_FW_VER_BLOCKS];
>   } __packed;
>   
> -#define MKHI_FWCAPS_GROUP_ID 0x3
> -#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> -#define MKHI_GEN_GROUP_ID 0xFF
> -#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> -struct mkhi_msg_hdr {
> -	u8  group_id;
> -	u8  command;
> -	u8  reserved;
> -	u8  result;
> -} __packed;
> -
> -struct mkhi_msg {
> -	struct mkhi_msg_hdr hdr;
> -	u8 data[];
> -} __packed;
> -
>   #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
>   			    sizeof(struct mkhi_fwcaps) + \
>   			    sizeof(struct mei_os_ver))
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> new file mode 100644
> index 000000000000..c3fa3c5d5cb6
> --- /dev/null
> +++ b/drivers/misc/mei/mkhi.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + */
> +
> +#ifndef _MEI_MKHI_H_
> +#define _MEI_MKHI_H_
> +
> +#include <linux/types.h>
> +
> +#define MKHI_FEATURE_PTT 0x10
> +
> +#define MKHI_FWCAPS_GROUP_ID 0x3
> +#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> +#define MKHI_GEN_GROUP_ID 0xFF
> +#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> +
> +struct mkhi_rule_id {
> +	__le16 rule_type;
> +	u8 feature_id;
> +	u8 reserved;
> +} __packed;
> +
> +struct mkhi_fwcaps {
> +	struct mkhi_rule_id id;
> +	u8 len;
> +	u8 data[];
> +} __packed;
> +
> +struct mkhi_msg_hdr {
> +	u8  group_id;
> +	u8  command;
> +	u8  reserved;
> +	u8  result;
> +} __packed;
> +
> +struct mkhi_msg {
> +	struct mkhi_msg_hdr hdr;
> +	u8 data[];
> +} __packed;
> +
> +#endif /* _MEI_MKHI_H_ */

