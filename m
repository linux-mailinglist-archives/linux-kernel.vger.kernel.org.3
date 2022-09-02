Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE115AB2E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiIBOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiIBOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:04:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F71306F9;
        Fri,  2 Sep 2022 06:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRpKBM2g1osUSemPWeI9cptUWvoCUhZ6LAZc/3FpQ4p8sZ+fZKbcX1/5a9ENtLAtSZSowEREYToBerulsQJPiowEZtjU5Ux018XbFR8UCXfgVspLuDBBGKuotRRSHT8qZ/knMA5QFIT9GX4H/rp6ICn1On+HgsSAqjxAVUgKYHg8jD5qvbC587ighe5R61WPEerLBLyHWvrrvsIAOv2lZ3N1i/PmVUeF4zEVCeS0Dcq/XmR3Bd/eYmt7ZN75TMCLZRO0BeDPCB4iZA5PefvwSCgpdYTGswonziXjJpWmzSO4HvUeTw9oqGuuaGUCbyDshW6HB1waPf8AM20cyCRuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frYyJI7rxtJ8aohvFi48VRL2wgE2ycxmCHYOEfPB9MA=;
 b=eG0dOddGzFbmkHQ8nNmfHh8J5pyL9hfHqMvZkCYfLUT0wShZgYp8RhmPn1FZ268eerlKzY3owvgUnQvWqvClUWgGqKgxGQ04vpk028kIIYttXx73QaHBA3iu8sKYPA2i3xXagTTzuJorAFWg51Q+OI94IPhNkid5GnjlE2EX7gPcW4rJ+5TW/AsbqrDj29YyBs4HqtC09nRE9ms3kj+hLg8rT4sl+QNJUj8daokZNfexZHf4EjGvu34YqJybAUQhyxKAqVM9H/O8ApiFRcmrumcdrw2/nF/9TPlmlWxYvC3aIUPCUeXVDK0YkxkD+2oLiD+uLcjKjHWJkn7jbet9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frYyJI7rxtJ8aohvFi48VRL2wgE2ycxmCHYOEfPB9MA=;
 b=UwKnskhV3do2JaQepXErnj5nVbhwS9im9csvYmreG9q0aDACs5Bjulhtb5lD9Ukjn+JFXBoXYSoSfS4BfKhzoqiTP0G1fH34zC+W/TXUAaxZ9ucQWrjRr0sxeiV/sgBHbrsnjhm74i3wOb3RC8/d7ommm0DN9dt7guKQvuEhRb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 13:32:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 13:32:44 +0000
Message-ID: <a71d8b25-ac83-92fc-ef4a-99a673362364@amd.com>
Date:   Fri, 2 Sep 2022 08:32:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 3/3] thunderbolt: To extend ASMedia NVM formats.
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
References: <20220902094010.2170-1-chensiying21@gmail.com>
 <20220902094010.2170-4-chensiying21@gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220902094010.2170-4-chensiying21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:208:160::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3906e84c-a31a-461c-ac29-08da8ce79dfa
X-MS-TrafficTypeDiagnostic: SA1PR12MB6799:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve1y5iS0e1VwsI6uo+AtAxM505pFOBbBJQ0kGxYRhCpDNAKCadM6igLv3A6xkQ3IQlQfw1QZcGszeXyDIlm/liQ+YRqKdDIQSMROFmevIsh7MQ6ykK7cxuylgFU5FmP/2oSYKngInKqBZRAMulWmjyY/Zs9xL6665qhA/B/5DEUgyl8STNTJpbU6mUNYoIKt+z5MRmMZAWxBmTCDEgsix5oLNz5RD0++raYdkw5SzRa2uAqWGZtJeOmQ4PUeLWa7/VGx6UVD2ldwPGM58E6lLFICuEEl7f14UFoele4BR7CzF/OMWUcGAlwOZnTs/MoJSqn9IyF2ije9c4f/e8XCb/wE/C+VMG6N2Cqex8MImf77k+zU+oCyOfAYSOPFghJ4XYH5c+0BUbxp+v8ME+1CXj7u91q/C6Tyv5JrBCLqhSjpZgQ8o9R6TbSgdwynLey/wImFQ4eUxbKBUV1XbC043JWQOScKk7QZH78ObTVKy2G1bmIPXNh/YWFnCCLh+uD8ZfHG6jr+fNos8V5Tr3FG3ZHunLUn6o1M8KIfCwQOtVgSeexrHHL09ftTIeIo5dEIiMT4/Q0CjZMaNUx11qmaIiJjAf1ePvrUyBNTvc8E4j1c79iD2Y3EHszgINpzO3kQgM+K7m/c4eF2ZHrWTfzoDQDVUT49KOmqcMTgp9ER64I73wACW/fI4hmKTbg86phlHv9IClEBmqi8iqn4XIixZlKvgus7piqFxnX3TrTSaZYfKT+/X4PUTcO9Pnehhvk/a4zsjOPBj4LfODfat4TFEKioUSTMX54kqEK7kFmhjpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(6666004)(26005)(478600001)(6486002)(41300700001)(6512007)(7416002)(6506007)(83380400001)(2906002)(8936002)(2616005)(5660300002)(66574015)(53546011)(186003)(316002)(38100700002)(66476007)(66946007)(66556008)(8676002)(31686004)(36756003)(86362001)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNuQlIyVTdxajNoZHYvR1VMdlpSdFVVbWxKTmFaK1M1alZNdnZwckVCUnh1?=
 =?utf-8?B?KzhTOUpLdWVVenE0SnNaQjJ2aWtJY3BQYUtWNUx3Z1FOVHBxekcyeWMxbEVK?=
 =?utf-8?B?RnhPb3hZdU5TekdtWm5YRy9GalB1MGRidGFOY1ZhZzRTalhHSDJBMkh3RVNT?=
 =?utf-8?B?bkpCdDVIQ1R2NlBSVjdQTWFobkJKcXovV0EwNzZ5Zi91Q29DUGNLci93K0th?=
 =?utf-8?B?ZDRLYXVqV285Qmg5L08xekZsM0ErS2N1VGVvTHM4a0lEYlU1Q1ZxL0dFN0RE?=
 =?utf-8?B?cGRXTlJhVmJRN2g3bitFS2xTZU9zVmx2ZlY5dXEwUCtndVdxU3Z6Qk56aXli?=
 =?utf-8?B?bXJHVU5YK0FZRUFjYzRyZnlMbE1EZUxGaTcyNVlBM3ZhWXZIcmQvT1UvS0tu?=
 =?utf-8?B?dllKSjlUbDc0WWpGYU9CT1c1UVFBNFZ6T0FFMWlITkZsbzEwZFN5UjJNUER5?=
 =?utf-8?B?V3hVK3NtcUJrUWcxc0dGMzMyRzFkdTZRRGh3ZTI1NDlrLzhzMTN1cGF0M0th?=
 =?utf-8?B?MzRRWUJ0MDZNa3Qrb2VQS2JWT1hWRFg4b3ZmSUR0N2VQUENWRDRlTlJHNVVG?=
 =?utf-8?B?U0lDOG1YYi95T1UwdHJzUXo3c1YzYVBjM1pXTHh5L2dFRnJMejhra0lnUVRF?=
 =?utf-8?B?aFQwYmt1Yk1DbmFTK0p6RkZYdVVFNmZHbVVLQkZKVi9GSEFkSTZZNmhOaWt6?=
 =?utf-8?B?eGVjZ3VvR1Q4ZnNWN05mMlE3dUZwZ1BoeUZmRmo4Z0hXSk5LUWRScUFNZE8v?=
 =?utf-8?B?U2hKZHVxaElaRmpZL0dFVTBFeURJK1p4OEQxRllLR3Z5M3BtK0ZqT3dqOTIy?=
 =?utf-8?B?RXhIeXhQam93b1YzaFlNcno3VGVpQUh6Q3owR3J1SGoxRDhiRmVaVVhSSDZx?=
 =?utf-8?B?TzhpaFlWNGhXZkttakJzNmd3WHpPWkJ5VTUya3dJby8wVk5aWkhwUlgrc0Z1?=
 =?utf-8?B?UVd0QmZWZngvYTFTZFVMWFN2dVpQTzRVSkI3VUdtWU1SN0ozZ1pyendxTjNq?=
 =?utf-8?B?Z1hnN3c2OHJJMFB4QmwrcVZyL2xBL2F2NTJKcVJrTU54NTJBdzFRcmo3ZlMy?=
 =?utf-8?B?N0Y0aHkvdnoxOWYyaDFvSjVaMisySHNyUW9JOGZDQnJlRU1DblNwME5VMHlm?=
 =?utf-8?B?K0ZvMENPc1hkQmdsclU3T3k4OU9ra3IweHRRVGZ1U1JURzI4bmtML1hNYzlt?=
 =?utf-8?B?K0VsU2dmVlBTYS9uREVqc0RlYWEyZVpJM0xGdDRRbnpQQldtcjljcVJ0cndQ?=
 =?utf-8?B?a1VaRW1Bdjh2bEZYbHcvdEd3RTVRTFRibW5CSUlWb0d4Yk9tYkczbnk2ZVkv?=
 =?utf-8?B?Qy9zUG1CZjd2NGs1VlVBNzJ2dldOWHJlWHN5UzY5UEIyek50cVlPZzRoc2NL?=
 =?utf-8?B?TllLNEhBM2tyTnQ3dllzalRIZFZHTHVqelQ5VWUvdkJ1T25mRytWcG4zaUVu?=
 =?utf-8?B?QnRpVFlnOVZNVHZlTkVYWi9SVDZEQmVHYTRtTmNzdkM1NkFscXJHalBCMW5s?=
 =?utf-8?B?clV4akJFSXZMR1pGZ1BMV3JxVzArTHJLUUdFc2NwK1hQMzZkZ2lIQVBsOTBI?=
 =?utf-8?B?OHVUMGRBUVJucVRUT0orZkJsTEo3WnYwUWRKTXlQWU9Sck05ZTdsWkJuSExU?=
 =?utf-8?B?eERDK2tHaDRoSjF2TVdPcFVSWFNGN3VaZzd4QUFDS1hFZ0F6K0svVXN5alpN?=
 =?utf-8?B?MWJUUWR0VGxHZjAyQjU0VjZqSE8rcGQydE9yVUxreVdaVU40Ykt2bHJrYkha?=
 =?utf-8?B?VGNGOVREc1c5WEtlQVo1ZUdDaUhqeDRwaWVTN3J3aHRBQ2ovdjc2bk5LejZS?=
 =?utf-8?B?bXZxbHFHUmZnQjdXaUM3ejQ4WXUxcUtPR2wvMkNZZEVFUmNXZGIzR3gzeWc1?=
 =?utf-8?B?TXdSeDJRVTVwZDdtREptN0tON2FTblI0aitFMVd2Wk9RVzduRzRKT3UvTGNo?=
 =?utf-8?B?WG9ETXpaTVVhUGdld2QxbnVNNk4rdllPQUgyWEhOS2dHOWQ4dENTTUZhK1dl?=
 =?utf-8?B?eklLak9wWWE4WXdHQ0VaV0ExNGt2a3hRK2h6M0d4VWZCWU9tSlhwbzVWY3RE?=
 =?utf-8?B?cExzT1NXK090dFM2ME1VUEVBU1BVdFZMcXlhQ3ljZWtRUjlEVDJLemhCRFBw?=
 =?utf-8?Q?1Aulq+NuvQww/pmJDiXancGEf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3906e84c-a31a-461c-ac29-08da8ce79dfa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 13:32:44.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV59fPHTV2Tw3vNUJ/MHhfHF0oxbKD00i4jtScvZP2lKqdCjkDeU51YmBD/QmT4Sxz5Eq+BRmIGstwtqJ6eGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2022 04:40, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add ASMedia NVM formats.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> v7->v8: Fix the no_nvm_upgrade bit setting on suggestion by Mika.
> 
>   drivers/thunderbolt/nvm.c | 40 +++++++++++++++++++++++++++++++++++++++
>   drivers/thunderbolt/tb.c  |  2 +-
>   2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index 878d705bd0cb..8393d82dd108 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -12,9 +12,16 @@
> 
>   #include "tb.h"
> 
> +/* ID of Router */
> +#define ROUTER_VENDOR_ID_ASMEDIA 0x174c
> +
>   /* Switch NVM support */
>   #define NVM_CSS		0x10
> 
> +/* ASMedia specific NVM offsets */
> +#define ASMEDIA_NVM_DATE	0x1c
> +#define ASMEDIA_NVM_VERSION	0x28
> +
>   static DEFINE_IDA(nvm_ida);
> 
>   /**
> @@ -120,11 +127,43 @@ static int intel_nvm_validate(struct tb_switch *sw)
>   	return 0;
>   }
> 
> +static int asmedia_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u32 val;
> +	int ret;
> +
> +	/* ASMedia get version and date format is xxxxxx.xxxxxx */
> +	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +
> +	ret = nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +
> +	/*
> +	 * Asmedia NVM size fixed on 512K. We currently have no plan
> +	 * to increase size in the future.
> +	 */
> +	nvm->nvm_size = SZ_512K;

Any chance this can also be gleamed from your NVM?  It would future 
proof the kernel code if you did come up with a need to change it in the 
future some day rather than hardcoding.

> +
> +	return 0;
> +}
> +
>   static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
>   	.read_version = intel_nvm_version,
>   	.validate = intel_nvm_validate,
>   };
> 
> +static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
> +	.read_version = asmedia_nvm_version,

I recall an earlier version of your patch series was reading the 
customer ID as well.  Would it make sense to have an 
`asmedia_nvm_validate` that checks this matches?

Or any other safety validation that the image is good the kernel might 
want to do?  Checksum or signature or anything?

Even if the hardware does all these verifications it's much easier to 
debug problems if the kernel can do a first line verification to tell 
you what is wrong with the image instead of trying to trace an error 
code from the hardware.

> +};
> +
>   struct switch_nvm_vendor {
>   	u16 vendor;
>   	const struct tb_nvm_vendor_ops *vops;
> @@ -133,6 +172,7 @@ struct switch_nvm_vendor {
>   static const struct switch_nvm_vendor switch_nvm_vendors[] = {
>   	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
>   	{ 0x8087, &intel_switch_nvm_ops },
> +	{ ROUTER_VENDOR_ID_ASMEDIA, &asmedia_switch_nvm_ops },
>   };
> 
>   /**
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 9853f6c7e81d..55faa1b5f815 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -1417,7 +1417,7 @@ static int tb_start(struct tb *tb)
>   	 * mode that is not available so disable firmware upgrade of the
>   	 * root switch.
>   	 */
> -	tb->root_switch->no_nvm_upgrade = true;
> +	tb->root_switch->no_nvm_upgrade = !tb_switch_is_usb4(tb->root_switch);
>   	/* All USB4 routers support runtime PM */
>   	tb->root_switch->rpm = tb_switch_is_usb4(tb->root_switch);
> 
> --
> 2.34.1
> 

