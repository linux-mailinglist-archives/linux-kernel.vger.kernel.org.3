Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0D573D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiGMUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGMUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:03:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC310FC2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etLpH3sx8niAH9Auu0OZDVbR/IRjimzi/o/P11faicXML2o0zyq2e4/GJg2m12DbiN4WYIw2YyhSyTMc6mADoQDK1wa7xgdfKEcIp2eOrlimZj1MWMHzQARSu2Gr5okwK1zxg7pqWnqQUV4nlMBzlYN5Jsvt/lbCO8unyYc4HLaM+abWMKbNLMMR9qg5WfyLiSjFLgXUCDo0BJWg2GWdjK6iokW1C2UOQ5TMbAKyOT+h0N1itynpjb1S9T/r3jAIkEQ8SWFXetaFYxb70d3EHOqSAVo0MPHhxTq4RZ0HGPk0dSgLGh37H9kViyR1tpQN80lNEYo4N9nmTZm70kpLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGKdj5WqX/vv793WgL1YPtCssJLp7KCkZGs+UxCyMQs=;
 b=lKQTdj+8unwAwLlD+NjR7b+G/RPCqSxQolA6RFOugbBUAT1xffkby19MLPMRpxHk4YOcoJzsBrfS7zrevvPfKdyMA0NzQpK7ieiH8umTPXV/cDfd7S5jvTlkcLwQ4YwZe4MXr/bADMNgzKRHoNVlJL2djTAvcmWVrF5HQ/nmohWQlFBPqk3npPeVhTzINH7pj4m96PO78JhOGyohjpcruvplSZTR1OYIoa/Xx4RjN9AELGsi+QUVL37xukddeiXrgTMSSItMPcmwoKCkbu4rVU3I8/sWhRn3UnnLvZwfDaTWME1ggoy0UNR0iqK01LFGPWorLbA3penEIehU2yXsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGKdj5WqX/vv793WgL1YPtCssJLp7KCkZGs+UxCyMQs=;
 b=ZpcUEJtc5RA0wdDo0V0EFZtMGtLW8aHqG9fIKZMS8s5NzLWIrwei81Urnm/m939micOdRr2A9nliaw6ZgcZWut7M7BWqqW7gdsEP9hRSiZ/B2WGSvrZf9N7NiriFx4vkHBl4tMPXs3PXskQ3Y455xdSTLUYMwZbmhajDRZr1QnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 13 Jul
 2022 20:03:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 20:03:01 +0000
Message-ID: <98b656f3-e506-90be-ebcc-898813051e74@amd.com>
Date:   Wed, 13 Jul 2022 16:02:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: Enable building new display engine with
 KCOV enabled
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Leo Li <sunpeng.li@amd.com>
References: <20220712224247.1950273-1-linux@roeck-us.net>
From:   Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220712224247.1950273-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e7276f5-d6cb-41c9-0f9a-08da650ab0a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyTaU4ovP2kgA5xgJEaKyM92DQ37HBU6ULX59V29gOyeueD60C05VpGOoqt0d1kqIfufA+xtxNK3Edce9Y0jJjiHCseha5MWRHsihr8iWOGJkIQwxnzsAcLiZ7ee4afYbfyu0BX1AN+AlkW7em2zf8m58r9jYCin1E45KjQiGFHr2xSXO4iGkFGp1ymGoPiT/TLUKzX0uVhAvHHuMVEThy6Tbb4MVJXHzZvwnG69DJBqojxfSd3y2B955bKfre3sXZuPEJJluoSMEdXjwGw6WqPceyEqBLCW38OWa54JeRTsakQ13wrCsaTPYiusQGFJPNjW8tTMUOhwiPiCGJkPWXnJhlLIUBf5pLTyRTO4tqCgEjExUa2gxweEsEGUlYn2egGm78yRmXH+NVgo8BlKZtpqHjJNe4sczxUy6m1sqREmFQmCtNUTEnUS2FMEF8NqX5PVuTeLxrHPxfC9TGCtaW9VPr2p7Oz5l86WCG+6Y1jeFrdlKqN7vU/0DjZ/FH6spr26Ph2xYi5Kft8FqdMH9Dp28uXs+CTgYLtAUnKSBcPmpVEYx+lBmww8HexWmf7OP/kuYsSaDrROug+8Uf9ju1Ei0hS3oEBBbklWVU6UUadaflokWPUu02eNsqBKAwuPZIXTVaSYvlgxwv524HAIOyr/+gCzA3x+OiKkrGgTsFsfgMFUmzwd8T4R8c7RlyEnHdk/O4DZnSzdIn43GTodTNXZNVCOeGC2tLV/qc4D4O9LNjlfP8UX3R3oAUCEpoO/DtaGhFrGVJpxPFOwg0jZaa/FBIcSqjwwImbKMv8pU+UzLjIjPskc6r2cOtTwNWVs3x6MpflQmqGHIqTwXngf6lh/Vt5238AgFUZ3pIIO8UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(4326008)(6666004)(66556008)(66946007)(36756003)(54906003)(316002)(2616005)(83380400001)(26005)(38100700002)(6916009)(8676002)(66476007)(186003)(6486002)(44832011)(478600001)(6512007)(86362001)(5660300002)(8936002)(31696002)(2906002)(6506007)(53546011)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNiaERud21jOGhXaXJpU1h2Y1N6dzk3QlZzQ2NEWTRUQ2ZtTGx3NjR5cmta?=
 =?utf-8?B?QlN2cE94cnNVN0ZITTUzWkF4SVo0UWZHWmVJWG9sVDkyWDUvMEY1YnVtelFJ?=
 =?utf-8?B?OXBPY0lhdjBWaEpIY1pzUlhITmJnbVl5bjhxRDczUkxLaTZiZ25kbjNHbFpj?=
 =?utf-8?B?NDFUbTQ3YnhqdEcwcUQxOXg1RWNJOTdPakpQdnpHbHpyM0NGQ3VGMUVkTi84?=
 =?utf-8?B?L1N0NHBkWUMxeVhYS2JaNTVyOUNlYlh2TGNjZ0d3STZIbkFTRWFnR2JEVTNt?=
 =?utf-8?B?ajhocDNIWnN1TWtjcUZGNVZzWE1WYi9XZ3YwYkxUTVFNSDQ4WlAwL256NjhB?=
 =?utf-8?B?TWdQS2F6c28rRDJUaEJzMVlVb2tLQUljY21kZ1Z4Y2VLaTJqbjVlejMrTUJY?=
 =?utf-8?B?MU5kRzZVVWx4eTBPUVNTd251RjNoNWNRYWdQRWJRK3ByVGxCVlpTUG9sY29P?=
 =?utf-8?B?WlllNXJnSEwvL1k3MHh4WEFPRzJjN2hNL0JuTElsM0dhMXJaTzNoR3ZaYzcz?=
 =?utf-8?B?SXZIU2xkaFhpdWJNbzV3MXNTMTRqRDZLZzZtTTEvQmdWaGN0M1oyN1FyUy90?=
 =?utf-8?B?UHZpZ3htZEZuQVdoVjFmY1BwR2ZSUkhzZlVrS3NZTlBJaHdBa1RIY25idXMz?=
 =?utf-8?B?MlFjYWlGRTVBZVoxdjBVQllkb0FWemxGSXJ2RDVtdDNLTXdUS2tpMTUxQmZu?=
 =?utf-8?B?ZjlnM2JIQ015bFpLOWlJRjh3QitjZU81Q2tiZmlFUkRKVFFUc2M1TDdOQi9K?=
 =?utf-8?B?Qm1XbktCdVQ5YWxVZ3V0RkNVT3B0UkVrSnZWL3NLWmx3OHE1T3liMG42WXBz?=
 =?utf-8?B?aE9PN3JOY0xrTUd2WmNQelFaQ21IWERKS3ZhNHUxRWNmVWMvQU1hWUt4MHdi?=
 =?utf-8?B?ZjJyTDFmTk1aMEZKeUVjUytwcGs1cjc3cVdvN1BPOEZqNnZlTVNuUmc3R1lt?=
 =?utf-8?B?ODJvdG82QmUvMWRiNVJ1aElPK1J5VUU2UkhEYlpwYWZTaHNSNnNmbDRwaHpy?=
 =?utf-8?B?Zmg1R0NLSXNzMWhxdHhhOXlEWkl5b21PeHcxSHlEUFF4SVh3bFNoTHR5cW1q?=
 =?utf-8?B?OXpjWHhVNTJob2ZUVzJQa1hJT2dVdDRzYlZYVWNsZzlqTEt4SmxUS1d0WW8x?=
 =?utf-8?B?dlFONlN2dForTEJKNEh1aTBXUjFoa0p0NSt2dTNiaEhJSVA2NzVaMzU2YnVz?=
 =?utf-8?B?S00rdkhEbzVBNFVoS1pKWDI4T3hyVTZLT2t2ajdkMURWMmQ1YThDV25SMGk0?=
 =?utf-8?B?ckM0dGdTemM5NVNMSXc1SWZzV0xGdmlVYjhjMXJCZk52VTQ3aEN6S3pCNmZo?=
 =?utf-8?B?eGZ6c0pETU5oQlRiMDVld3hoOFE0RnZGSkFwSVp3anVoUHJLeHZvazhXTjNi?=
 =?utf-8?B?eEIwdTlmSUwxZzd1eEZNQ1J2R1c2ZHQzaWFRUDdjTHRwNU1wZ3ljamNTMFlT?=
 =?utf-8?B?MFJHSFFCRi9paGVNK25SUElSRUpmQ1paY05SVjhOYytIU0ZIMSsxMndIZ0xq?=
 =?utf-8?B?cHlZbTVpRjl6U2xjaEUwQjE5VkM0N3pNVVEwV2tlcERIamVxK3BQTlZ2RUtt?=
 =?utf-8?B?Zy83TnBFNkFobk85UXNZamwwLzIxaFFWeFpXckhiUUwyZ3V6bk9qY1JxNENn?=
 =?utf-8?B?Uk5jNE9McW1LcXI4Mko5cmZ2eUZWOWF6VGp2RC9IdzR1RmtKSFFOS0o2TlNw?=
 =?utf-8?B?ODNxUkd0dTd4Vk5LVmlYbUdtZzg5SnordmloY1NjdjMxU2hzYWdOOWFHQmE1?=
 =?utf-8?B?SEwxeCtzUTY3OG80Q2xvQzBKQVFvY254KzgzWG9CWFIxVmxneFZURnRPL0xj?=
 =?utf-8?B?K3dBQlZmUlp0STFsdzZ2dWlhaXpUb2hnQTdDR1JpY0dZQ1JJbXZ4WHlrUFM4?=
 =?utf-8?B?ams4Wkh2Z0g1UWJwME51RVBwU1lyYmtrV0xUU2RzZFBkNVcwWCtuRHU1aWI5?=
 =?utf-8?B?am5kYVBKL3VPZndYMHpwWjZXTDdqRnVUbHBvN0xLZXR1SmxoaVRmcHVDZmZn?=
 =?utf-8?B?SFRjNGtqRkpqVWExQTRRNVNZREJWL05DNDQrVWNkWEZGbkpLdHBCV1FFVUV2?=
 =?utf-8?B?cXVxVEJ0c3lVR3lEbTczNHBEQVFPZWlPVmV0T3FMZThzcXg2bDdxTEN1c0Ja?=
 =?utf-8?Q?C543csJXqlG3JG6LGobHFi7D3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7276f5-d6cb-41c9-0f9a-08da650ab0a4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 20:03:01.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r792zghTtKXpYy5LV7akKAPQF3VaSVn9ejp7zfgBNMlZcat4w6LZjHI77Z/bomL8KPYyV9tzywlpKOoHSBzq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 18:42, Guenter Roeck wrote:
> The new display engine uses floating point math, which is not supported
> by KCOV. Commit 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov
> is enabled") tried to work around the problem by disabling
> CONFIG_DRM_AMD_DC_DCN if KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS
> are enabled. The result is that KCOV can not be enabled on systems which
> require this display engine. A much simpler and less invasive solution is
> to disable KCOV selectively when compiling the display enagine while
> keeping it enabled for the rest of the kernel.
> 
> Fixes: 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov is enabled")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/Kconfig     | 2 +-
>  drivers/gpu/drm/amd/display/dc/Makefile | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index b4029c0d5d8c..96cbc87f7b6b 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
> -	select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> +	select DRM_AMD_DC_DCN if (X86 || PPC64)
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> index b4eca0236435..b801973749d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -26,6 +26,9 @@
>  DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
>  
>  ifdef CONFIG_DRM_AMD_DC_DCN
> +
> +KCOV_INSTRUMENT := n
> +
>  DC_LIBS += dcn20
>  DC_LIBS += dsc
>  DC_LIBS += dcn10

