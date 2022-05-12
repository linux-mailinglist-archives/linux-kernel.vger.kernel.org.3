Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEDD524897
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351834AbiELJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiELJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:09:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB465D3F;
        Thu, 12 May 2022 02:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA2WnhG0u2IDzidLtnBppa05aRg/IMwSZbznPcT3hXeMiGLVoz8L/STEhWWT4HZS9uxlKpyUFveYnB4tFBqItbAsN5SFeEgpeLNf+IzCkyU43YtNs1WSBzF+jmG+apPgSyUWS225bzdg+57clnmaoN/X+SI+ibcaR7mcdDeCOwha7xUbLhzqG5g2gu5FQa+YyTFf74GY1PshaGvhY6kMypowahARcdPQeRLM7Yqw2uEO4kHZEyop1cfYNnXwwZepwPf2RYb5QseAkqr0kFQys6vvDXDBF8aS1OTns7aU9yXAwlW8+E/MGJx4IMJqQeiP9GhrWLWaCbgLz9to6Yeqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA2UKXwV+FGgrM8VoDHCj+gPMJu7URsh3LA4rA4IYkI=;
 b=a6KIQa6pMF4fBVODQZju/2vadVACnsLDJ1LgtRLSKhfiXDGdN7vIMOpV5lAQy/pNt4NPkM6RvNTE72iv4bkBeGTk63mJjqmDl/+85i+jaM4FSf8MDVf1WF3VO7Puqx0aCsJ9y7AnIEeSm2gq6dS8YO0YeFWBkwLzu7uVRZov1kM4U+KlevaTw0c6uq1b0t3lQz2ymovzDtC+8QWqgmGqKK47gZQmivyq7qrAdXyyLUaBhTQguXtOToQMHtxkKMCi4Qu5JeASqzRATgeD0iMolIJlCEslpmQA7ddz8T3td2kU/Y1/wfZTgMTS10VtjwpVZrZK2s8omJ33bFWYFhQWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2UKXwV+FGgrM8VoDHCj+gPMJu7URsh3LA4rA4IYkI=;
 b=cll+ug7mNxc8nKbQuVMKIG3WbyMk+66HnaOG12+Heks1scy1aTk6mN5kT1JtGSNlYH4asVDLDbkLqh5DHZ/sLtHWVE1DRKouCzXkgBwDfMOIGQulYyq8SLrERGWtUngt117y0lWJKAvU5YfLWOV8NWvR/51eL1MOlDEX3fI92b4iBylJlCTo4Dkhtucz8OgUbFlw1B9BpD+ZooxPeJkNuUn+tOPmUhVwTrSpg2wT7laiyn/erHK0KtVNB4u5+Cv6nSQ5ZDFZ8nXDBbB96yS6RaJeyWxeYnfUE61N0YCahmJmKCAQFuVHIRQ+4sdh3w8gbpJiDORXcP1SR/2QmoiwAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 09:09:21 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 09:09:21 +0000
Message-ID: <2e2cac21-1071-546b-7091-8be26860f5f0@nvidia.com>
Date:   Thu, 12 May 2022 10:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] Add GPCDMA support for Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220512090052.47840-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:208:55::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f36e34-2b86-4185-2f18-08da33f719d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4861:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB486124420C60D9281EF0E9E9D9CB9@DM6PR12MB4861.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2UQxwOpoY2IQeqFVVk20K00p64eoKbjxqNC/+SMbXFn9jITqRwy/ZGMIZEkBdrabI1PADak6dm4KkjCq7wIAH5b7rHAIjnA6NGqfPzaShgo7M22RGEffChcKB2mULYgi3uwKriS0d6ZpIzw7OxRDlZxK0c2AIFNosZGgIQLtdJkGvqWtvh9Fm+s5Qvnt1H2UkmW8DEHVmsCNtO/S3OQ8AiQz0oo8zybU6ji6BocvNSKDJ9IKO98IzVSDRir2VWBCrNwUnIuqqZxAuzcsNh/0VUjiRS64KprHjzUxlcPHon9dc18McNAAg019Y8yzv9SuwS748EzglEu6uHGbt3279lzf+CFta3haTtpviEGiNoKvysf63Ya5bs+/X8J/mvViNpN78z8ic53Dw6Xtl1V4+y2usR9lumzDpVXSXq2Y1hMyoUKXZYSPtSrLD0P4/36GT4YsgUvvq7bEJRbFmarn5k9HhV+7GgX+Tf4B6vVJdlAQdZitr6nxAZ5fnlibz4o3SPFGmI9SG6udjSBveAIdwaTkDcZyOhtWrQS5N/QHV15O+f5h6HrHV+9GasyKM3W7QSMT6sO6YDt9Z4RtZ8kAf3Fwtco7eDIheydQ7YiqsnHxvL9UjD+7hBEHYB001oo8fOx4qN/Pn4oDLb06EgkAPQYKeTUp/ZPWqIuVQNn4PYU3fUiFpAUMZj63pHIsxvBl2oWn42LPiu1S/sE8cONjdEV/jzamA3Gt92kvz/0j50eXM+fyTmnclgA1J0HE8rj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(26005)(6512007)(5660300002)(186003)(6506007)(6666004)(8936002)(53546011)(316002)(4744005)(55236004)(38100700002)(31686004)(508600001)(66946007)(6486002)(66476007)(66556008)(31696002)(8676002)(86362001)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZ0cmVwcGI5OG95L2wvNElaaFVZY0RvTW5oZlJRdmc0VU44eEpuQ05LMTda?=
 =?utf-8?B?bVNQc21tUnFqSDdhVjN5TG1OaStjZHFKakZ2QW1xVEhLZHl3TWlIa1llZ0g0?=
 =?utf-8?B?MDVHR3NSVlZrZXM4Y1dkWGNEWDF6VkcvVEJlV1FGQ1A1OW5TVmxqM092NTAv?=
 =?utf-8?B?NW5xWkFBR20ydzRsdW9TSjlnbDlTdGJJcFBvUjBEcDNjcVpmMHZ3MjlBb1lI?=
 =?utf-8?B?cytxZmJ6RUVkYnJVc25qM0NoWmxpb1lnVVZ0S1FVaHJURU4wdXF1RzBlN1lR?=
 =?utf-8?B?a1VYK1pTTmp1ZTBTWUJKQ3hNdnFmMXZWMnNlMUdrOTcwREMrYXAwVUxweDhn?=
 =?utf-8?B?VnU0R09JbTk4R2JtdEhDdUN5TEVZbDNUTlgxZVBnTEd3MEVCR2ZGSUZMN2l2?=
 =?utf-8?B?NWtJWWJGWnBuTGtveU1DLzd3SmVPSmtGMmduYm1ScDI1cmNLL3dlR3JSM1pj?=
 =?utf-8?B?eGFZWEY1WU55RWthbmJRUm9tVXlHVkZkR01NMVcrK1kzbnJGNU5lbUp4MzB5?=
 =?utf-8?B?Si9RVFNrRU1uM1dGalB6NmxUKytvblVHOTlDKzVYaEc3VHF3R2VJZGN6QUN4?=
 =?utf-8?B?QTlvS2RQdEpYa01kNVJhNFN3VDNZSEdFd0dkWVJXWUt1OWoxb1dIbGZ6Q0xw?=
 =?utf-8?B?TnZpRGhBMkdVVWpVS25aTm9rdWVzNVpLYWRUcUJkNkRDUlVqOHMvTkpjTkNm?=
 =?utf-8?B?Z2RiT0dXWC9XRjhLL3h5eEIrMHZ4K3pOb3NzYzZ2NGlLR0ZXRUQ4dllwRVlR?=
 =?utf-8?B?NjFnR1YrVWRJU2NQdWxIRTBJSzBaVVpadHk5K1FyN21tWnQxY0Zuclo4Z3Uz?=
 =?utf-8?B?M0NOUTBzbDZ6ZzVueGxLb3N6OFpBNDIxU2tzNElGNlord2pVbE5WYkh2TkFr?=
 =?utf-8?B?WUVRblFXVUNySnpMY3RiMFFiUjA0NWo4UjM4ZTNHTENPS2VQNFFtL0wzSWZC?=
 =?utf-8?B?c2dad050WkRlYWZmS0xQOVp6MnE2V1BScmZkRnh5Q1IycjlQcm9LNzNvR1Uz?=
 =?utf-8?B?WWZ4NGlCZkREMlhFWEdST1RSSTJGTDdxTXV5UElTanlNQXc1UDNCUkhET1cv?=
 =?utf-8?B?S2tVYW9FZ3V4UVVGZit6QjNKcmlpQXpQUU9ueXlBUEtUcTJ0a01VbjJ5MThE?=
 =?utf-8?B?c1BRQ0NGOUFWeDU2aEZjOWI5cjFlbUo0dlpWVU1yVGRnNnY0Sm5JSStSZ01X?=
 =?utf-8?B?aC94eURSelFvVE11YUFaV090MFVzRHJiZDgranNyTFVNM2NMU1Z1YzVSMWIr?=
 =?utf-8?B?M1ZRN1FTaDFLQUxmSkJSRjZiQ3FXTmxRMXFlbEdMdDRjdDdET2FjbUJBK0xo?=
 =?utf-8?B?L2wxQ1kwa0tKZjVGVStvT1h5RGRTSnZGUEdueU5icDV3bnJHZFFQcXRTRzVr?=
 =?utf-8?B?UWdrcGt0QlF1Ri92Q01peE1XNmpOZlZ5VWVFS3Nqbk5WckVFdzA3RitlN0cr?=
 =?utf-8?B?MGZ5cGRUamQwYlZoZUdDQ01vSXNBQUU4aDVZWm5GaVFZcmgxZ3FJZVd4K09n?=
 =?utf-8?B?ZldhSTFMNGJZS3lJNldEamZaTnhWbDVxK2llZ0RjbHh3YnIyMXNnUi96MzZa?=
 =?utf-8?B?cWJwTWYySno4UE1NcmhEMG1OUCs2cm90ZUtKeU5xb3hzUnB0dkZjaEpvSDd6?=
 =?utf-8?B?eE1OVElTcjV6czQrbW93MCtkaXpsYXZIaEp1aFZUbnZ5UWR0Z1crakxWUzNM?=
 =?utf-8?B?QlQxL1NJME9WQ0JZc2trbmNEQTJkR0krWC9ta0NmTnlaZ3p4MUcxVm0yZnhk?=
 =?utf-8?B?YmNMSXNocFBOMTVjbytxVDhPK3ZWelZxL2JBWFNCdTFKTzFPUWlrTFd6aklF?=
 =?utf-8?B?bzNjWEo4c3NKQ1JsbzJHSkJHQks3a0NPenNHNDFUMnh1Tm9md2JySzFoMXhm?=
 =?utf-8?B?ZzRFUUFBcGhhM2FsSC9xODU0S0c1TnBUWWtEOFdKZEFmWk5wMnFlWkRLeFEz?=
 =?utf-8?B?ZEVPZi9yU0pCMm0rOEVkbEk5NjVYUDUvZk9zZURYSUJJV2w2dStTU21jMVlw?=
 =?utf-8?B?NitKVWE3VFVVSVFWSTNYSWtucW5FUVNnM0JEY3plZzlDaXBUcU5mb3crRWM0?=
 =?utf-8?B?TVFQcExGUGNmV3NBVU54RXNkaE9MYUpNSkVxcGF4VWpMTmZYRUJBdW0vRHVR?=
 =?utf-8?B?ajJBM2hsbkVGbWwzK2RGdjhxRUk2RW4zb1pDZ0xzYUhUa1JMaXhoYlBZUzRY?=
 =?utf-8?B?WUZGckpLQ1RjMEN0OFVOZzF3b3VHc3lPd0dGU2ZvdCt5a2VIeXVsODdraThH?=
 =?utf-8?B?VWxSUkRPWEljc0FLMGpwOGhXOWZiVXRzQzh0ZXBvdzVZTk05MFBTLzNPeHZ4?=
 =?utf-8?B?TURNeUdJYTBNeDlzVkFYWElyaFdtRGp1RmhqR0tvOE04SHdjWmtDNnRHNWNh?=
 =?utf-8?Q?E4FaS5RARzuRHQUU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f36e34-2b86-4185-2f18-08da33f719d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:09:21.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFU5PHb6V+I/xH68a4OfiTChCnUtmk6EeTQAsmwnV5Yl8weHVbfTFBR37ow/a5IvJvRAJUF1grVvk4cS80h+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2022 10:00, Akhil R wrote:
> Add headers and device tree node to support GPCDMA in Tegra234
> 
> Akhil R (2):
>    dt-bindings: Add headers for Tegra234 GPCDMA
>    arm64: tegra: Add Tegra234 GPCDMA device tree node
> 
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 43 ++++++++++++++++++++++
>   include/dt-bindings/memory/tegra234-mc.h   |  1 +
>   include/dt-bindings/reset/tegra234-reset.h |  1 +
>   3 files changed, 45 insertions(+)
> 

This should be V2 right? Otherwise looks good to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon
