Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA2574C53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiGNLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiGNLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:39:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119A2A72D;
        Thu, 14 Jul 2022 04:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NupZ9EVOaKyUmszNt1bQ9icsoZkqbKmdsqAtgnLB3yj5jvgSFOqaMREugFSo2zW3FUCxyV6JGF54PbVk1hSMrkZReaMlehjm+tgGeuyPC7PIvEUWZjSZZ4UceF6DQncWMSLG5epI3dBhtS6bUrGtGh3EhsBYf8Qx/r3pxm5IElLBSqrI/tk2bVoTdDzEC4n8mIwcLveU/24h1XaiQtUJkcsxkK2wfClEJUqaFeXTPphrsS5QMT5WpSsDc/Def1M9R9N4F1EeWbkaekPWKXqMTqhUjfJLV64HqMP1ViAN/B/gG0Fta24KP8SBkgBdpCEcoVbwCd2iqvh1dDmjORMvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdXoG3tCH+uUHmNXQ3+dn8Q8bIvzfwARqJ42HU7OU04=;
 b=cgLcz2Ueuao9oyjF4JTvX+dXK/eEt11EyKMUPdSQDSCSfCRjIp68to/q/R9rqYN9eQn11MaMqb2otM1wB8cH0O/EEpNS4lmmz1AWLT8XY4RQQrhHfIRdVjrwCrEEZOjQ18n0yn64wtJg1TqHpqrlaQF23c99e/vJMJp704dcDHdZ58ibWbok47Nhqz5eVQ9g/ZMsykL2eP1jTBv6hW9p+aseqSUs0qUlNuA0aREp3sDQvtYae6z8TEHxxLZ4EBjqNJId5hbNfbisk8mAXv+tQL4dzI6I9ZQwRF78j7whemBgXSbZ4BqOXwPnsSPFiMXfyXghmNfNHg3olNx/wjgw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdXoG3tCH+uUHmNXQ3+dn8Q8bIvzfwARqJ42HU7OU04=;
 b=Jb+BsmMheGKh8RG/L1+7zYoZf3641QjAi/ibzj70EnxGKWbG0Yk+QN2QEQ2GRd3dvz0NsraD5rMjG/AJpXEQmh7zlOj5/M9MX2YEHuXFZiu9Z3qsdV+dMHYns6qIj6XeKbySFo3hF9HqQpzdhGkQpeN3HK4R+kkfOWURxjIoZj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR1201MB0035.namprd12.prod.outlook.com (2603:10b6:405:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 11:39:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 11:39:00 +0000
Message-ID: <1f62503a-6615-b49a-db4d-fff02c1d1087@amd.com>
Date:   Thu, 14 Jul 2022 06:38:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714053752.5124-1-akihiko.odaki@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220714053752.5124-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d270698b-a18a-48ad-8407-08da658d71f0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0035:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1VLLMlpkx1BRfRgGnOSAdSEGRPEZDB8PEqEeG4KsxfJVxZ3F2wob5i/FhlDgioHVbffCnCQwgkpt2KLZqRRf1Q6zkIFDARJGo0MoCk+3+FvIkYaIBT3hrslJpQ342JjWItPqcyS0C9hvOhpoxHTE2kFH7dUMqKAjZ49Ze3afrzZakXRuz8G4LVnzNGPtYzbNNZ0BToLPhhibqJIAEFfkpYcORRY/+ffY7k1Jqw/kfPm0xdcv1LieHrwQmYOV3ogN1pCDn8g9fJcbxe0Iw6j5B546N8wNymXeVRQ/gGbEetQJTxqZKxacJSRa/OmLLWyWK5k8AQ3zPSDwEFYeiqnSvc07eESQiq2Fp9VLKY1x6qJzeGHjr6BvmMal702U8opMeeLEA2te7k3G0SSLxC2Va7JxDRfIn8+EC2VQigELtmXFCBeSJjrBOyEe6ERq7J3RzdJkbdkWv9TGF35iFAxSGxjcm6YqPa8WlHj+uoT5DmfvN6fB1omYsHFU4mfhpBGl+9vytrGzu+yBzXY3y7vrxPjhCJvPM9t0hCqaW4GznXOVonutMFufLCo5SVkyeAbcDGS25MP8ODoq6XXMXRCvMHxTULRbjG1dCL3B+B8UrMvrURpY1/RFurc1JJaC2VKKFzec/ow6rSIasqGAKahrnr+ylMZ68zOF5PGAY4fYvuL+03W58kDAlu+plZ5b/N4A5BqXWrBMqeyPMEqF64oDmmYw3BE0X9nNnE9mWQU0aRgeA/chDTPS0Alz2cftbnOVTXnstHJ/dm0hLM0zTehNmktqfrqcgiz271dx/N6QblJMznphQZuWWEhtXXfgq/1ADJ8oV17m+MkrUeql1A72vc/S77/+swjNNPlJP3jXiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(8676002)(316002)(6486002)(54906003)(6916009)(6666004)(53546011)(41300700001)(44832011)(2906002)(478600001)(66476007)(6506007)(31686004)(4326008)(66556008)(186003)(36756003)(6512007)(66946007)(2616005)(86362001)(83380400001)(31696002)(8936002)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVyckhOcU5EVXBVSFJUc1BsTGlqWTNYZU5ZU1NpYXc1OWZIZzFGNDBLWTFD?=
 =?utf-8?B?dmdKWG9UMXpMbFBJSGJIdlA3QW9IRE4wUlh2SFNIaUtucE9FL0M5cSs3Ykxr?=
 =?utf-8?B?aEhFS01lUm4vdG0rbnJwdUNtcEd3N0wxSHc4QmNwWTFuTk9USGZuRkxJMXpZ?=
 =?utf-8?B?cHhtR1dMMWFQMkFFMXZ4d0JzaE1QMTlCeGFCVW9kNDNwK0VwVGlCMUdzTU9Q?=
 =?utf-8?B?Z0k0Unc4UlpjUGI5d1JyVHlJUjI1dnRueDFFUXJPUThlMGliM3JkWmFkY1U4?=
 =?utf-8?B?TXJiV0NpaVV3ZjBURjAwbGdBOWVWb3ZUMXQ1WHpBZmxmd2svMmVTS09vYXdh?=
 =?utf-8?B?TWd6WkNMVFlmYkV6N0lvV09QZ0E3S0QyNEVwWUVBMk9zaUUwdmVyMVNuN2U0?=
 =?utf-8?B?U3JKUWJJVlRFQlNINXRwMlZxTkVlZU1Fdm9jV3A3OGhhZHJYelNvZks1Ykpr?=
 =?utf-8?B?eVBpcmRRU3lJVTRqSlZwQXZvbnI5am11Y3N3ZHpQNHlYdEw5a3RSQUYvTW83?=
 =?utf-8?B?RFlORUNtc202N3BieXMvNWNXc2YzRDlta0gzcUdFN3N2cEhGeE54aTlSZlZX?=
 =?utf-8?B?WTJ4dVEydmNjNUU4TkFhNUlEVy9ERkdXY1djdk1rdXV1K01rT2JsRU85RkNC?=
 =?utf-8?B?a09tL0lFRUVqcGlkNDdhQnRTbVorUUt4U1dKSnc2emxmRkhwcUZhdUFVNGJa?=
 =?utf-8?B?aU5neVRydHcydVNsdGVsVmlaQzRzK2t5QWV2TTBJOWlIbjZSTDUzRFdNSUF5?=
 =?utf-8?B?N2lVaTNnelo2SWZOYXFPa0Z4a0hVdGdPdTYwRDFteHhOWjdsSitZY2dSbkNF?=
 =?utf-8?B?WDdrbStXVTJDOXpjdVJGVVg0aWZvcm1kSVd5b0lSSXNDY2hVQThFS2tqNWRj?=
 =?utf-8?B?d0NTYzNDWTN4enhaVTZWeS90RVBYcXJobStvcFFNa2ptQkNSQ3NaQmFQay9L?=
 =?utf-8?B?Zm1pTXp5Z0g4VWpSOGJJVmtQMExNVjJ5OWJ0c3FENmcwSlM4SkVkdDFwUEhn?=
 =?utf-8?B?L2dXY1I1VkpDZlFBNUJrME5iZEpqOG9LNVMyWm9tN0pMWVFCcmhFTzkwYUZa?=
 =?utf-8?B?dDg0MnI1UnV3THlvUVlCTnRIMkdyZmZvM2kxaURmaDQ2bTNVTkd3Y3NCT3pn?=
 =?utf-8?B?cW5ldEtBMG5HcHBKVUNzcUJMUjN0OXR4UWJ2U2F0NVcrcy93WWZEc1Z0TzJR?=
 =?utf-8?B?ckRiaUhmdHJreUJrbUd3cW9BK29PYURHSjJTSDBaYktOMXBIRVU3eGVsY0xw?=
 =?utf-8?B?WmFQc0FOUEdHc01ndnhNZnNSL1haM0w3bkhHZzJlQVQzV1haakdyYjVNU3Fa?=
 =?utf-8?B?Z0FySHc2cHQrSEdCdEM2THZ6QTVZbGJVRkFNWkhYNUI0bFdZdWFwaDkrWkoy?=
 =?utf-8?B?Z1BnaGtMZ3RQR0pnS1Y1eDIyWE5GQzZDVHhJaUNiYTdMKytxcXo4MlgxM2Vr?=
 =?utf-8?B?Q1RDc2t1Q3FJY09WVkE5UE1kbENTMHZNTHhwMUpNS3dLRjcyL2kxSmY2cVNI?=
 =?utf-8?B?TUpBNGMxeFFXcjcxQ1ByTmhpYlZrK1ZuRGRHQy9YRlVhMERUSlVqRk9KQkw0?=
 =?utf-8?B?Zi83OUw5dk5nb1RzVXZzT1N6V3FCVjNrZlNMTEIvZUIzUFRacUxHaHB1b3NM?=
 =?utf-8?B?bmVrQzJITUNHanJKV1ZkdVl6enRmNXJOdnc1MUdXeUlHSmp6MmxHNnhWYmQ4?=
 =?utf-8?B?cHpkQmdiQmZ4RlFnZC9xamszdS9VSWNDaytYYyt1OThpQ3k0NC9xNTBzSmJK?=
 =?utf-8?B?NFJXYUZIY2lhTWNGalp3RXU0NUQxcmwwVTdudFhySi9kT1czWWFSQ283OUlF?=
 =?utf-8?B?TWpUaUJmY052Z0E3NDdoSUNEKzVxNzZQU29GcTdPZWpIelB1OHk1cXpFUzQv?=
 =?utf-8?B?aERDVVAwSkRsV1hHa3ZVNm1UZ1cyTzBtTnl2TWMzcWZCblFIUTAwNm5TU2ht?=
 =?utf-8?B?a0ZzNDV0WHJWQXFLWWFGdDJ2ajFPd0JwSFRHTFhBYlVBRFExRDdqRzhuRVRK?=
 =?utf-8?B?ZytKSEs2QnN0NU40NkE3cWdEaGJWVmFybkxRbkg5SmxlSWh6REp0dVhQNEJI?=
 =?utf-8?B?MmNKc1VuTHUzcTl1NHpNUHF3aDNWTWJSUjg5bHNiQ1pvU051OFpHdkZkYi8r?=
 =?utf-8?B?d1JWY0xCYURVVitob09UaWphY3o1eDFUbHY5ZDVYSENXWlIwNWJMdnBKMVRn?=
 =?utf-8?Q?zv15rDpKq714i8JsLOJkj1K+TvfyknFTu52vhXsISqfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d270698b-a18a-48ad-8407-08da658d71f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:39:00.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T46HtG6+/eqaAw8sXLegmf24RXyDNU6uIRronqJ5Eyfo5BxIkBFPrZXm5Ufdf7IUi9ID9hKFgxf5dmbspYiWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 00:37, Akihiko Odaki wrote:
> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> functionalities, even including the registers necessary for feature
> detections.
> 
> The behavior was observed with Lenovo ThinkPad C13 Yoga.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index dadc491bbf6b..b91e1c95e543 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -197,6 +197,18 @@ static const struct dmi_system_id dmi_sensor_mask_overrides[] = {
>   		},
>   		.driver_data = (void *)(ACEL_EN | MAGNO_EN),
>   	},
> +	{
> +		/*
> +		 * Google Chromebooks use Chrome OS Embedded Controller Sensor
> +		 * Hub instead of Sensor Hub Fusion and leaves MP2
> +		 * uninitialized, which disables all functionalities, even
> +		 * including the registers necessary for feature detections.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +		},
> +		.driver_data = (void *)0,
> +	},
>   	{ }
>   };
>   

Did you miss my other comment on v1 on discovery sensor probing or is it 
not a problem?
