Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3556ABF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiGGTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiGGTke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:40:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C85726C;
        Thu,  7 Jul 2022 12:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFPe5FGIZg4dUKjoYb75W7c0cuFCzCJs7/EvvPqLmwfw/LKNwPNthmCvP0exMf7RoKYfMeeWHS/ZQtXOwQl/2PvQUZsSYu3V91ZJo9PQoaWTpdXXo5BBO5NDvOKIujPHuF3XO3gAR3gW7iR66VC56mxehu4qirw5ZHRJRWhzESDOFZyjXE5+ouXjCnoo1MxPi1lRx3jUSKpfCxcoWxiToI4K2T25bb6kJ/yfeYKW2l2ZGcy0CWSHQ1qgSoTymSysnXXwXgPo7pAuyz8mSQOPn/vcr3qOkENJ7NWJpuoZ4u4pzMg/vg1OugfLLMft2zuUjpzIVHgtyo9Jr2TQ5EX/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSh2ruags+M1bjPYl+L+Fk3hKJJI5KhrklYNO07dYoo=;
 b=cJw1109woraFmjzwFIRD2uovMbsr5ddD07WO/IIYSfU5aPt732THIXvu/hCRDzatgVAN6FUdFSPNeAfg6fUlH7etcU3T+Le0Am4UCgv7Zu4ONTmiOPZQq9luAX3tLDaz7sY1pNKiwNkjLoVPtMMED3TOJ65ds/uyt9FRfb0y80wRcEsBDS9ppzgTJGJNt8c5h9shvmtSCOnQF2G9+asIwAiEVgX9lLSXHmF0+LcLJ9ji1vIq9KsaVcuf2UxdaGA18/zFqPFHtZXXWfDFK2ZOe+gCcw9IgxtlveYZI8XhMXncZXDV8CxCzbsMc4f/P9dvlay2uVvCnYYIYKWN6A/tZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSh2ruags+M1bjPYl+L+Fk3hKJJI5KhrklYNO07dYoo=;
 b=f6T5PLu9AEC45vj0fvyGoDaxnVwiojJtjA617sfb76w6rYVnZp7wYxwlXPr2JQeu6bmgzXJY4iczWIge+eL5RkcLyhqTt9lQWsmLLNYX9JyOsXOL83VJM1yzhYz/VSMBiyzabw5C4qenFTx18Pl3iUw3iuGiLHsShl7CJiokZ+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 19:40:31 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 19:40:31 +0000
Message-ID: <2a08a95d-6524-4f54-e6d2-76b43696ec0b@amd.com>
Date:   Thu, 7 Jul 2022 14:40:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/12] cpufreq: cpufreq: export cpufreq cpu release and
 acquire
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com
References: <20220707170103.216736-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220707170103.216736-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4cdceb-e576-40a8-58bf-08da60508d1c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6vK3Tcpym61ThFiN21WqauQT2Rw5t7xUWB1tEfriPU/ZYa6WG2KNemta43Iks0DXdEeyaAP8zViJsUj78q4Ib6oE9RePjfjCEKzSVuIC9zG3VYDK3ENatjH4sL2h6/6I/WQM/XtbzxVNioUnaL7YV0hHKo6sfA1kg52qhZ4Og/oLlx5FfH/LoYE1k8h7/JD1xjg3I++yGpl9C9mHvpPW2PGBaoKoC5WITQTl6Suygnx5tTPaDzEQZ6CtbDUENmdnfxbPzf/VZRDTCd9yd4XjKQBuxGmZueLrQ8T6wutcTod2vaVz2fIrE+QGREgNuiJne5UOvFstxhRmKimMZD1zliqnnqmn5ah05LsHxmOLP4+0Y+WT/VIOv1s6UsDRE09lM4fxOt+vHs3M6gJ3pTAZmvO4QECOXwuPbXgORNmMKw+24SnTbAZgayn+hKXXxxph+KX4eu2+Vram6Z+yD+oldM1q1o/Xr9fpEYoFhhiJu5MZmlQQtZYgP3xcWwXFEz4LexoOlP+Q0AU5jtIedivD/s+lwbxMbIEcaIIv3809LfFrP1+SL52owyMSiDGyPLOc2wM/HvUS+Lh/kJ5yLdsqslOSQW2WbX/48IrOpuebpHOp7uThK/hnx+N36fVAtgrkv1bBTSAFBrwJ5IHZB2gqq6YgBJti4AUX+WNnaZYdOMl41l/vYkUlxiRphpF0eyW37i/9M4VsmhJA9BZJPcvKPI377myVevrcvdscrKI+0VPpxMkVBAJxIq+D9+NMxrh8l4loaFMoRryeQOJZ8ZxleLZ2ZHxzjyXSXNR5jv+UHvGJhZlc9qlhtDgfp/cR6X48BISXYFoYs3r12jJWaUJPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(26005)(2616005)(186003)(31686004)(2906002)(36756003)(6512007)(6486002)(6506007)(31696002)(316002)(53546011)(478600001)(38100700002)(8676002)(41300700001)(83380400001)(8936002)(4326008)(5660300002)(66476007)(110136005)(6666004)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FlVGVNYkVtNXJtaS9IRTgwbGxlWlh4QWdQa0g2N1lENS9FWHNUbmlEOEpJ?=
 =?utf-8?B?OFBUazYvNHl5UEZGYkorSExXQjNRV3pTOUh6WUFEN0htUkp2UUVTelFEbkpp?=
 =?utf-8?B?bCtNUU1nbzlOZzdYVEY4cklrUytDV01yaHRFSTJUN0FCV2ZoMzlEbjNucnRO?=
 =?utf-8?B?M3VZeExQT2ljZnA5OHdDN0F1WjVuR2Eva1NwUWd0VkRjZkVYTGVNWGtZdXFt?=
 =?utf-8?B?TmNKa2g4M0xRWmdLeFlyRkNodkFFZ3ltWHdMcEVpSlZBWTNMMlZMcjRrZnBn?=
 =?utf-8?B?WXdibW54cGllY3JURTZZdHUrL1VZaXlxdXUzT1lZM05ZUzNyU2E1Z1JhU2I2?=
 =?utf-8?B?NThzZXZ2dm0vbFZTUFR2UFU4b1U1RFI2QXczTVJFOHVVSjV2WitLN0RPYmps?=
 =?utf-8?B?ejlJZkpzSkp3emlVNEdJQm94d2d5Q1pvVFJ3T3h6RmRnZWoybG9jb1FNY2Q1?=
 =?utf-8?B?T0lMTWRFelJrNGFZeEE2SFpJMjJnVC9yQmRUT0cwaVZObnlKRVdRdWRKbWxs?=
 =?utf-8?B?b3FpaTREand1akhIMlJjNmxuRGhlU1RUVzY1enUyNzRnNlVIaE1NeTdrUk5M?=
 =?utf-8?B?MDNJQVhBT3dhTUdhak1xUTV0UDk2eGgvVU5CUmtvTS9IK3hoTWhUWm5lZHJN?=
 =?utf-8?B?d3pjcTlRSmRjZ3RMMnovTTZNS0hJRkI1T1BPeExSb3QwWHh0RGx3bGFHT010?=
 =?utf-8?B?ZWNScWpzZTZKN21KaGJReEo4dDdocXBCeTZwMzM3TjZqNUxHTEVnVWM0dlk3?=
 =?utf-8?B?NGxhRmh1UnNpYzdaN0E1dzNlTDJNNmQxUnRLNVpjamQ1SzBmSjBlZ0RMRm1J?=
 =?utf-8?B?MFBTTUM1aGNpbzcwWkJhbng1NVVnRGwxTlpvRVhsL1ZNa2lSQ1RDdUJ6MjZk?=
 =?utf-8?B?QUpZNXFLbDdBRlZNTGJWT2N6N2JJWHhvT3RmQ016aS9hWGVEZ2RuSzdPT3A1?=
 =?utf-8?B?MU9qays1RXU3WS9BNitxWkMrbjgxbTdxakg3VDYydWtEMlVtbjc0QVBuYjhC?=
 =?utf-8?B?YXoydTZlbjFXL3I3UmlycFU1cVp5RDBkenEvdHo4Zjk2MHhWUUphbmNadmxq?=
 =?utf-8?B?NzhPVTVzcTlMNWxIV005dGlXQnlGNEROMGJudGpDbjdnUjFyN005Z2VDS3RI?=
 =?utf-8?B?Z1BxQlV0dFJLNnBkd245a3FiTjZKVFJXNmEvRDN1UER6VnBCNkxZR2VITzlw?=
 =?utf-8?B?UFREZ1NyME1lajY3Ynl4bXp4VlhlZEdkWURqQVJwaklFb0dwWTFiNUNFcXRX?=
 =?utf-8?B?TWVSZis4cmV2SUdOYTlxaWJybE15UlE4M1pDNjRGTGlPci9ITElhaUxwWUJo?=
 =?utf-8?B?Wkw4Si9XK0xSdW1KOEY4U3VsanlZTVYvY3dFU2xBNHNJRXhEYVJpNXdFVXhr?=
 =?utf-8?B?eHBMcnQ3WjhCRmgzV0xaNnZnUWVxayt6VEJTUS9yaXpaUFh4NnpQNTVadVpI?=
 =?utf-8?B?NXlDVnRXOWM2ODhZc1dFck1CYzRwditycFVxZFpVdlVlUVVyVnp2TVU1Nk5k?=
 =?utf-8?B?RmxCRC9YY1lJRlM4VGxLV0ttZ0kvUDB0MWhQN09wdlNYMXdjSy9YZHhkYndW?=
 =?utf-8?B?SjZrb2VLRStWWW81OWJ5L3RZRDg0NGY2cDd5Sm5xaGQya2tYTzlIenFDT2sz?=
 =?utf-8?B?UmNadWlKVGJBR2FSTEJpMDlaSUpmMko5SUtMSHpBc2M2elV5c3BZbkVGRGp5?=
 =?utf-8?B?T2RZRjVDOUM4NVNYaUpmLzBOYmg0TlBmUmwreUZxZTF3c1VqYUtlSDhZNHQy?=
 =?utf-8?B?YXlXTzFTTVhjSGRLdmlTUjZ4ZFZNbEpib3RmNlI5UklvaG45ZGVqYWk0SWJ0?=
 =?utf-8?B?d3ZiUU91ejBTczVJNXZvZGV1eEdtS2l2dWxDUHlxb2dxTzZodmM3R1EyUkVq?=
 =?utf-8?B?b0lrVXg4N1VLY3VDUUtPc1FjUUlMYkkrdzVMY1ZEWkZEVFRlUVF0aVF5Wktp?=
 =?utf-8?B?UU5zWVpJL1pwRW9KZlR0d2h1TE9pR1dUUkQ4LzJqVUVRWGpXWDVHWllCdVFi?=
 =?utf-8?B?VytQVkN3bHQ0Y3JKQXNXemQyNWpxa3RuRUtZenBreXU0anprekNXekpCVDZP?=
 =?utf-8?B?NXBxMlczdE1DN0YrZmlvclFVcHIwd3NXdTl3RHBqZzhxaENJRU50eVZjaHRr?=
 =?utf-8?Q?Pg3Zn/duKXEPhPTWzlb33sbvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4cdceb-e576-40a8-58bf-08da60508d1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 19:40:30.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvqEnfiLbq5HkFTYNZHPOyJcWdSxqnrlegBhyQMom1Hsw6SCCUNUVcUJm6QxO9lGZIVRTx4nwHAbJlW3EyRlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 12:01, Perry Yuan wrote:
> cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
> drivers/cpufreq/cpufreq.c currently.
> Export them so that other drivers such as the AMD P-state driver can use them as well.
> 

Can you provide more information on why this is needed for the amd-pstate driver?

This patch exports the acquire/release functions but I don't see that the amd-pstate
driver is updated to use them.

-Nathan

> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 73432360e6e9..4d3c83da29b7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -262,6 +262,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy)
>  
>  	cpufreq_cpu_put(policy);
>  }
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_release);
>  
>  /**
>   * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
> @@ -291,6 +292,7 @@ struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
>  
>  	return policy;
>  }
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_acquire);
>  
>  /*********************************************************************
>   *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
