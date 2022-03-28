Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5FA4E8F90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiC1IA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiC1IAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:00:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55964220E6;
        Mon, 28 Mar 2022 00:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZwdMgWNEyn6eGghAXlMt7RleE3Dg+UGBdiK/cfljxqIpmNqr+Dr/LODZZTRztKHG4894J3CZSwIWzqdHy+bgl0J/Y0NwTYDuA8A7KXOgsLq/oODly89JDOLJcyuR5zhuZy7i1DihRac+IF3u90la2BipVp/p0OMRNITM4rFJKGgDk5XNOfv4tsHoL52NRHjVDJ+/PMYqtx8hv4wTz33UaVTnjL165y7Jrcmup7Jh3q+SVVkBOPDnXqnLm/mPu2x4gWqpjvQedIO2WoZNGpxSHWsem3qHEeJmehhH/EKKIyZFOX3HlsFnC9V8RdebC1uYQTY04dU55kcbu/Mm2N41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiOiKRtGOKA7FGGFFfsgT/bs6r0++ifaKiGaKZuNQes=;
 b=Ja6UizDZUem0azufFq51YYpR48srfU772ZqIK+GPlEhw1L/uAJ9wWwFoslJdqw/zACUa2zquPxRJQz+7SVKh6ZH+etMj7NLYA5f5pWRIZtMTh3d47v3WkYnx/ac//u/szibz4HKOr3g+PlrRWhMJtzD+ReB4f6ssILwUfcmwTGgXOMuRwUYJ/IEhUG/V5+1n4+6tbZdGiBWpxErKweXXkRwySSCz4mIzArRkay4JAe+9nJ5204ZfTKI3lU4ErV3HAM0dh5bu0V2sdZZ1QJ0O0HObDIOEoPUZHoKTtadf3enaRriPLkCIxcUFWnGklfutqDToOFfam0ohosYpHIuX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiOiKRtGOKA7FGGFFfsgT/bs6r0++ifaKiGaKZuNQes=;
 b=pWadY8qa5wS4+HsF89DMzbNu/auU/gxWtV15/ZMcw8mmxMO6MrmHWqDfepfI6fNEfi4uIJPdEtIDD/FgzO67uxnJTR3qprIIvBLWVYXMhMkiA/l/x+wHiLS+KU4QhA2kmhA/tKIeKkK4IB5PfCnHQxzCcgurhJ1LWZqR+uscfUMhNVW93eaPsZj8l0wVL3J7mFnRzUfw087Ivbh2QEYhzPfK5Jh8IDzppbGJw1Cn9TOMz/55pUwo+aeg2PtRYsnqstB2Lp3knUP8j9yYDTCGRO3kwt76eWRLdnXF/rXaDESxrE/WyhEkYgqlmYgCno/wKI5rDBVQfw7lF5OpPwW0ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 07:59:10 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 07:59:10 +0000
Message-ID: <ffe25a55-944a-7912-5cfb-a28a80c97703@nvidia.com>
Date:   Mon, 28 Mar 2022 13:28:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 2/6] ASoC: dt-bindings: Add audio-graph-port
 bindings to rt5659
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-3-git-send-email-spujar@nvidia.com>
 <95cb1ea9-a737-7d01-f81f-f94ea92c7a4d@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <95cb1ea9-a737-7d01-f81f-f94ea92c7a4d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::14) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b63080-13e0-45bd-8464-08da1090d76e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4113A2DC029D536582EC5A07A71D9@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3xKct1ZL5suVEy3RguT2x2gNCymXsqbdVta73tciymhKCWbmKqsDmt6Q6YpiSIjZ13UTKPdAqG7JlRn2zfos7T/JgSp36j/qDgsm03IxBO+gioDmO42CtHBhoY7xqq0DOuglCTucW1fWhE/KLS8qH3iQZE7Q8JWe73R5QtLPmqwcEZsPIjtm5N2jHkaGp5k76ItM5ufAVEzMTUZCUIfI+LwnP0CDMilxqEz3UlYAxzboCU7vvSVk/IkAzry2mE38UdFp7KM71/SDbn9p5bqE2iAg5GgJT9sa9LMYnlPeoF6PqnNjfDPZOG+P64mY5JJTBlL1Vesm+vKr6unPBSLDC8NJevdW3mKPt10IrDQ7V6B34RRKL/JNiuOOvVHI+QNfej8wFJweXNmHa6CtULhvp1SZoQRka5XWXBN0taL4t3oHwvWiQT6m2see5TVAwPL3iEDrqzUlYzXWYjzBhYQ1bPYFdzQzj5wOOLDLWmo81Ft3KflxW3Z9PnPLIZuoNFY1ySySMa7rCf4Sp/e5H6wdF51g1Rg4FjRZohwquGCR7dWwy/3bGZmxQinGGUWaUHJA0/fsfcOp+IDenv9rarbYjF2i7j5SBcbJlQM2QBHSHdx6/M1nF1i/DSSDVrh/H6mJ1m99v6tBr/UuRIrJqr7wVkjYEwIDxGulPdS8ho80KH1NHYeksXPYzbwl6QOBaUSjca5Gbg6lExvYm1dyuUtSyV2vRdXo3J08O+U7L7Kn28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(8676002)(66476007)(36756003)(66946007)(26005)(31686004)(186003)(38100700002)(2616005)(4744005)(53546011)(7416002)(8936002)(6506007)(6512007)(6666004)(508600001)(86362001)(66556008)(6486002)(5660300002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2NiNlFKc2lRSE4wNkVFOGtpWUNrL0dXZzdKeHVNbjFycnpCYktIdkd5T21i?=
 =?utf-8?B?QW0ySVE5MWN3eCttd1hLMjA3c21tVXhXOTRMTENaNk1XbFVPM2dNVmw1anh4?=
 =?utf-8?B?cG5oZ0huODE3U2xrekRwaGVFVzAzUmdodjFvWFp1emJKUWdMTWVVRDBiYkFK?=
 =?utf-8?B?alVCdGNMRjJMTmM1WENMaGpZMktCYWdFdjFBeE9JT2pFSWxweTNVemtrUEh1?=
 =?utf-8?B?aEYzNmRITzRkWXFWWXB0ckw1QjB6SVY2REhNYWFrLzVkdE9pczFKNVZPYlcz?=
 =?utf-8?B?aTVLbVRHYlFmUG5BVEhEaEUrZzhncHpFU09OWnFMMmw0c0orVWszTDhSYkxS?=
 =?utf-8?B?WDlGdEtVQmI1cWwvMEl0T1BxREg3cHRObXF2VE9qN3pmZjZYQjlpV1AvbVZM?=
 =?utf-8?B?Zmo1R0tZT3RNZW1FdCs0TWIweHJTbTFScjFFWndBZmtnNkIra3JjemVJci82?=
 =?utf-8?B?UUxFZlJocWFmM2w5WUZLbkFtY3RSSkVSS2FRZXNuM2pxWjBSUFNxaFZJUXVI?=
 =?utf-8?B?T3I0cDhjMXM5VDc3MktsSERCSU10YVZQd0JoNTdFNlNwRnVvZEE3bllTTUw3?=
 =?utf-8?B?Q21nY1A4Q1gyUlJKOS9UWW5LR05naTFWVDdsQXRIWEI2VnJlenJOZjBvV1Rq?=
 =?utf-8?B?blgwNEp0aUhQYVZ2UUYvU243ejBlR1U4eTZWcS9pN0Q1czErNHBrUTI4UmZT?=
 =?utf-8?B?VWdVcDYvYlZWMXlUTS9YMU0yenFtdTBLRk1FQjUyNFQ5VUxDOFMzRDdUKzc2?=
 =?utf-8?B?MFFmYkJLRWZGZWl3M1ZXeFB0bWpncHdGVWpESEVUZHhhMWFqeitlU3JwcFdl?=
 =?utf-8?B?VERiQ0ZacHlWbVo5dDlFRERYY3FhUmp6b0ZyZDRMMm9RNXgwTGZINjg3OTVN?=
 =?utf-8?B?aVA3b2V2cEE0UDNTQm5RQXdBVldwUE1YV3BZUEd2ejlPVWdSSzl5Nkw2Q3J0?=
 =?utf-8?B?a0wrM1MzcmVFTGZwOEFhS0dsSmQxamxPYkp1YzhZY3RNMlBFSmdTalNRYVRs?=
 =?utf-8?B?cnhtaCtwVTNwZ1NWUFZ0Vy9MRVdNVSt0cDFZRkhQSUgxOVpDbmdxblEyRHpF?=
 =?utf-8?B?V1JTaFZDQXVMbFZhZDJxNm45OEs5VC9maW1RQ1oxS203YkErOVBpd3plSmRL?=
 =?utf-8?B?enY1aU50MFI3enFpRDBFeTJoU0Q2K1FBcDdUNmtZaHBsSjNtcnVHYVN4U2Zw?=
 =?utf-8?B?MnpHTUdKRXpwMnhBVjJ0VlpubksyRmtCeHNHbkxsVXFsUTIwNDBLRWRHKzI0?=
 =?utf-8?B?c2d5QTNrVGk4RVlzZXBSKyszckJSbEU5cGxVTC9TcFp2RXBvOGlqc1dNS0hZ?=
 =?utf-8?B?YlZKakc1VTBtYkcrS2JhZ3NpNnR5d0lYR09FeDFOR3M5L2hIUlNPZ255QjdJ?=
 =?utf-8?B?YWFPOXR3aWswaGRleGcxMXRSSndNNytwbHdRQXVJUjhHRGlLVmNjQ2pXZ01q?=
 =?utf-8?B?K3lMMlF4YUpZZTRNZUJ1dkxLbnJNZ0JRankyUFVQQU1TcmN2di9yaDlQRDZK?=
 =?utf-8?B?WkMxUkNHQmsrQjRSTW1FNzFmaThSSTgvZ0NheEl1aFdjR2UrTE9yR0VmcUxv?=
 =?utf-8?B?Sk1zQW5nbXczRWlpSVJJUGVsS1prTy9PeG9JY09wM2hnTGJXUlhMWjQ4Q2Vq?=
 =?utf-8?B?VHV3SjdVT2lFTTYrcittQ0RiMGVFdGlLOU9tNHFrSEpPM0VtZzAvWnFpZnRa?=
 =?utf-8?B?WFlBUFJmM2RZTVM1MUQ1OHJXbWZJYUpSMUttNEkxWGYxS2JROWNIUmpYLzRF?=
 =?utf-8?B?dWJ3ZnV1cWZjbnYxc1J2Y0lDS2pSWWxMSXl4L0JlaFFoQXh4Nk44Z1BvNFpl?=
 =?utf-8?B?aStFMUVjUkdxZjNCVFR6TGxwZk40MzY5MytGTi83ZlAzeVVFK1JYekVUMDRx?=
 =?utf-8?B?akNuVjllaVlLV1JsTVcvK29uUGRlUzlJVVFCR0x6amlQcEVCbnM3bTNJMU1t?=
 =?utf-8?B?MXVsZ1c1VkFPZDFFMGZQRzRucmlTUHY3VWVZVFFuSnVzbVJ0c2dzNHZzZVF5?=
 =?utf-8?B?YzFod1dYcEF0TU80eG1ycllLRnNkRkowMVFXbm9ISzBLMjlaUGNOR3lIc25h?=
 =?utf-8?B?ZGhqNGZOK3RoU3Jzeit5bk9aYTU0Wk83OVRrVUJoTnd3VzRTeXFJZXJPZ095?=
 =?utf-8?B?bCtYb0JsTXFZalRvUUFXeGI2VkZZWXMzdnorOG9nbkNIL1V5Sys0U21WcnZk?=
 =?utf-8?B?UVFha25jMTVDa3daak0zNUdZTUhYYWFzOEVjRUc0WW1reVVRV2dzNjZnMDha?=
 =?utf-8?B?YlpoM2pkZzZMOVdlbEUwZ2hGb1hCUlFwL1RTQmVXSXFWMC84UjhIMUhScFc1?=
 =?utf-8?B?QkhPUmlpT1VmeWxtdnI1K1d3azViVWVTK0YyblRUU1lHdnJld0pRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b63080-13e0-45bd-8464-08da1090d76e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 07:59:10.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6+r1j2czbSDGEr5QknBglyRMgpyV1kUsvFzGkQyEv2BXckbU2HhOUH9a5iMZnUiEEsz0tRnFjOFD7eI1igYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-03-2022 12:33, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 28/03/2022 08:14, Sameer Pujar wrote:
>> To use rt5658 or rt5659 audio CODEC with generic audio-graph-card machine
>> driver, the CODEC requires "port" bindings. Thus add "audio-graph-port"
>> reference to the rt5659 binding.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Oder Chiou <oder_chiou@realtek.com>
>> ---
>>   Documentation/devicetree/bindings/sound/realtek,rt5659.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> This should be squashed with your previous patch, otherwise that one is
> not a complete conversion.
>
OK. I will squash this. Thanks.
