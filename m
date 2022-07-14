Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5255743FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiGNE5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiGNE45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:56:57 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073662648;
        Wed, 13 Jul 2022 21:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GstS9jneHfBDEo8xttNsosxkTd/VmrJcm3INwCI9gthykLRwKhNaPD6imyKviBQXETuAbgIGv6i8J8MexkckE2a6SAPmoIeAWJ8fINHViiqKBHHOVPSPjaCWc979pA3Hvwe18yCZo13LdrqbbWYkP5GycbnCkgwRhMjM0FhR5tjyD4K+JudPxq1Z9ZPCxeY5eCZ5WWDwc7WuN++LDijWsBomCBRavGpGMKzZixPF4HcaYnU43xvjSefXDkeC8T6/H4LhcGjKVZ5Sqtt884Ax8r+dcvW9KzI1FpPDjxw2J8oXD6P89zyHOjZJmvxZBAS7datQO6brXT1WA/fwH0vwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEbyNEOEX88qiR+fPcU11ec3VqGzi22vpcgg0W9Gh/k=;
 b=oRHdV0TA1VuG9LckW8bsOpDdynZRQvISkaY5iwXwHhkpDMwPVGmSSX7649j3RUpe8LjRZhExaUqk2R0XjNouJcyWmeBx9w++7SPx8EIyyDSkgeIRWJgZE64VPT5+uuWp4cKlDUjp1mUObcULN9DCIQxytVwd4q5Mq5zBxbB5ijHmJaVRmGEmr9hBqX3IUv8Al4smWOpsznaTFlVi5I8BQ5QK8EOIyCSO2Qq0wdsVpO3bH0kgrRjyHTu0HyBipJAJ/ZtCuwi3O7/kZB4xtXjrU28fMV09DjlM8iu81qWLFXFogZhw6F0Wgm0bMrd1oX2jsZqEv81gqUlC6/Xsowe21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEbyNEOEX88qiR+fPcU11ec3VqGzi22vpcgg0W9Gh/k=;
 b=k77syiWUtll++X1GqpnamJyZU7IDg0ZNaEvL3lTN2rwUT9l3ihuofsRO0EvQAinyPDKGbS5DvZv+X0ug5BQNllLFz9MyfPKjSq/t6k2MHe5/XusBGGYQ4RQH0HjFcGCTc3wXPEnEmfK+1FReZoXbMp1IqICYPuoKYym83SqUfHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 04:42:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 04:42:02 +0000
Message-ID: <ba990f87-608c-d2a2-bab1-0585f05bca49@amd.com>
Date:   Wed, 13 Jul 2022 23:41:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710081547.3553-1-akihiko.odaki@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220710081547.3553-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93a7ce9e-9065-4cd8-1365-08da655331b9
X-MS-TrafficTypeDiagnostic: MN0PR12MB6200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpDshYJVfdeSDJnw+8jiMWs4leO1v9Y/Bo3RghUdTX5Gby69zjr6QPb//C1UyPGaEJS6D8tJTA3O48H79UF0H7JUOrtcOF5cAg3aHaWTIkUTvlnu1dIwYEn6P4lFvJqYLoODZSaPV8P98boFJqL7Z1DylLaaVNaf9awbSSjb66iXGXceUauq+42gwdtTPGhHnD3yJ39jprSfBPgi/nUhAJyMJuHXgBgPI49i0ScRPA6IGn/5cwz1tUOy8A6qOe9c5dE6L/V61+gobm229gDAmf3iQNDlmWhnjmP3gtPc9/5ABSZOokAan12p+s8V7Zg8CZwrSSOsnMCdQCZuvlVBExA4M3yN+uktiMN6ArOT5mRMS1ZQftA2un7IMYBEaoOCX9XlGwI5/dhPdVOOAj6tQR/POFmpnTHma/NlP0V48LIwJfhyXJTt+V9N6u3FlgxJUnEIRr9C7IR2wS9RbwN8XLbtdzxQFjlaky+vww1IjE2jYX6kpon0JgnNoPdXKf3MzQ5n0BPH9EuLOFqi43CfMQSpyupljxSA0XcOhkttiqhivhvaU14Xc9njgcq6k93HgJ491yMa9lBzM+P6fwpGqbLlJyWlgtZnKLgZ1FcVAd8+GZce+sO8gVHUVk/MzyzVnhdB+XS/4hwprZtuyQ6wFmixSyvvBMOzloE5VHckUD1o3IHfCWqpmWvM5CyHAC0YhsPugFNzJWA0FouBd5UrtUD2K0CMyHiUCULl+E0ffvPK/7uUmx1xR/ZRZVxQJfe6Dp3ta76QqNBC7vFwgonhkWpSxOJs/zTU3JbZ2iSj1ohysRtjE1r1VPRfltpmEys4BQqHOiOZe0Dtl+ietsdJNVKOG13Sw9i4QSsU3t1NB6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(6506007)(53546011)(316002)(6512007)(8936002)(31696002)(5660300002)(6486002)(38100700002)(478600001)(44832011)(86362001)(2616005)(2906002)(41300700001)(4326008)(54906003)(6666004)(6916009)(8676002)(186003)(31686004)(36756003)(66556008)(83380400001)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtTV2xORFBUaEgzYmxNUFJNWDJqK0pYYmNpTUVvMzBMRWV4TVdsZmxUdkdz?=
 =?utf-8?B?N29STWlnWDZEZko5TWpOc1hHLzRlcm9VOGpIWDFONzBmZm9RZjZrWGplV1g0?=
 =?utf-8?B?MnI0OW50YmlXU0k2c0hVVjkyb2JYemUzeTdIdHJlVTI5RXBlZ2hTVVVsdEhX?=
 =?utf-8?B?YkVLalFrL3VOd1lpWlNGbE10UGxhMUZnRG5aWVJlcEV4dGsxVFdmdmdPVkJw?=
 =?utf-8?B?aUhzanJTUHdHR0ZPaGtSOGJuZjlmRzUvQ0JsQnVVaE5nUk54UlhUR0hCanh0?=
 =?utf-8?B?Zll5ckJ3QXp1dGw3c0UrY0hnYjdOVEhQd1hGU1pvczEzRVFBWE9POHE2ZTdv?=
 =?utf-8?B?ZEZiU2lQOUJ0Q0o5dXB5VHdHMHllNHRnUytXTXBKTzlocGRDbWNyZEJLSksy?=
 =?utf-8?B?aFhPRXRkRUF4QUtIdmhVZzh1Z1VKL2hUOG5PaVhYa25hdHR4amZVMFd5dm5B?=
 =?utf-8?B?K29NM2R1dzZWY0YxV2FNSWpoUkRUMHgwMmhOUFU4OFJHTlNZZWJmTDFzb0Zr?=
 =?utf-8?B?bnFXWDhMNWtHSUxKaVo0bXBEMUxDVXhMZWhTNkw2UkhqVWFwWW1rdFJGaUsz?=
 =?utf-8?B?SWtleWk2cEYrVjhWSFVCRW9pTlQ4clFsTlJRQW1vQmxTMEJVRnBJWjhVWTNU?=
 =?utf-8?B?TXlXQzJjcVRLTmE4Mlg1Zmt6ME9HdXh1UEN2TytkdnFVVWtkTG92aUlzZDV1?=
 =?utf-8?B?SnhkbGpSNy9LdDlVTWhlNGdUUXMyMFFUVHA5K3dscTcxMDg3SEZBb0tkeERZ?=
 =?utf-8?B?UDF0UUsvUTFCSGR1aVN5cWNZdVZVU2JpbGNSZnp5Vi9PY3NIWGw4cTN5TVk4?=
 =?utf-8?B?dTBZdEZuY1YrSGJCVkdJUWo3aEhsSzE3cTJvTmtacGRONTVicStQMHJoMVJX?=
 =?utf-8?B?eG5QdlR3aDBQWFBtN0dQNVJJNE9saWFUK2tsMGFNMTljOEpDckU4MFdUTjlV?=
 =?utf-8?B?QnVteGRtcU5WWlVoVTJSOXNDY1NqRTZCWkZLRGdKVDhvRmRzWXd3VForZkxW?=
 =?utf-8?B?NFppYUNYRjJwaUozVkNYcWwrTE90WU5iNnlzTE9UcUVOSGIwY2x5ODlhSXp4?=
 =?utf-8?B?T3Q4djNFc0x0WGUzQ08rVFZWYlRUdkJBOVVmQyttUnh4bnpBR0ZUczlrbVEr?=
 =?utf-8?B?TVFXdzNmMU01S1hwZVpiT0lKRXg2a1U4dE95aWVOUkNlOWJKeUdvTXJPVGg3?=
 =?utf-8?B?anYrNGVtenZzczRIVkQ4MW1pQnpsaXYvanNpWXU2WFlkenRGUlNWYmRlbkdk?=
 =?utf-8?B?b2w5bVlCdWpqeG5FZ1hjeUlvZUpwQXRXUVkwdHlhZHo5dHZWQXNvcjZTZktJ?=
 =?utf-8?B?T3loZ3hCUktQQnZzVzlpWWU4RllTa1d1cVBXdXk2M3JzT1FEMUIyeCtSdXVV?=
 =?utf-8?B?Q25KNXlBUGkvekVGTDBHSEs2UlB6MXh0MStNdStXWGRBT3JhYk4vNkYwUXgx?=
 =?utf-8?B?VG1tNGlYK0hiSi9BTXFYaVhrbDJ5QXNKNG5rcGFZbXZlSXBuWWVZUXVMdE81?=
 =?utf-8?B?M2ptWEdjWFZEMUR1NjIvWXh6cEdTdTlWdEE0MzN6VXltR3RDQjdPYmY5RmF2?=
 =?utf-8?B?N1VoVjVQclVTZHJNdVBURGJ5dnNla3hVSUtuTTlXUmtYdEV4eDYybmZ1V2FE?=
 =?utf-8?B?aXFkUjdoQ3JvREFkSkpZMFFBSk9nNktxUWs5S0loOGwzR3BNaDgxMVZlekc0?=
 =?utf-8?B?cDdwZ0pueEUzQmxsZldUQjJWRjl5bTI5MGRjTExIT3M2M0xDeXVjaWxDZHRE?=
 =?utf-8?B?N0xtUHY1blovYndpY1d2R3VDZXYrK2JMK3V0YVROVTNIQUp3a0FFVlZ1TklR?=
 =?utf-8?B?bk01ZXBYYlMwaXZ0eHFabi9DTTlibDVrWDE3ei8rR3pWMXdnam9kZzVuc2Y3?=
 =?utf-8?B?ZjVMUkFoenpUZExPaEU5cnppZElDNUFmZnROUHIyS0tqYVdMMWIzV2RuTHBS?=
 =?utf-8?B?OExMWUFzZFBMazdqV1k5YksyT2R2cEVMd3UrNmd4ei9oREZJU1BzSVJ6VHNU?=
 =?utf-8?B?M0JuNmlyVnArV1pBaDlBRmdxclZWKzFVdDAyOFlDelRobTlGNm1SeEVHeE5I?=
 =?utf-8?B?VkNra09lNHZUWnZlelFPSlNyVjRsdEVhaGs4T2orSERkd1dNcnVWYjIrYUdN?=
 =?utf-8?B?b2NsMXdNaG0zOFVUNnVYaTVmMmRWcVJRVFpxWjcyQ0gwNlMxRERzOW0rRFhN?=
 =?utf-8?Q?lxq+g1IiF0dE7hmEYgamlq4D3vu4cq5qO6JzJPYmxvKo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a7ce9e-9065-4cd8-1365-08da655331b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 04:42:01.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1IvoxoIQ2AKANEIHuVsEl3nSJ+JYfg5qp8MSmnOZkX6H9LtciROHF8+3aeY/bzCCc/E7YIyyV8322sqeH2ZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 03:15, Akihiko Odaki wrote:
> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> functionalities, even including the registers necessary for feature
> detections.
> 
> The behavior was observed with Lenovo ThinkPad C13 Yoga.
> 

You missed that I suggested this from your earlier patch, you should add:

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
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

Is this enough actually?  I would think you need to also modify 
amd_sfh_hid_client_init to special case the situation of "no sensors" 
and return -ENODEV otherwise it's going to try to read discovery status 
too and that might not be safe and deterministic.
