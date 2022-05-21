Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116BF52F95C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiEUGqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEUGqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:46:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50C522C5;
        Fri, 20 May 2022 23:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJe4zEk1u86UEmeTGKO33RckV5E1s6pGh94Y7hpXhqDv9U5PF1XyLekkLo9At/V35dIpfRvc5J345B1kbtj0yBeGsbdbCvuX7QZqCgBjDOLhvgGyyVj/aRp/0Sd1U+vUTvcZKg1ZIi7YXX7fYGxfPBTeglGZQyl06angK2aHP5OdPJvJVmXTdvitZ2QoyLH4Z4EnaXU80T4yzvUQi4jkWYxXiXlE3dqgQP+8NXAZ2STznF7d7Wc13RVs85kL6+46zX8hlYgrzXHyWscOWBi2KQSgWEhFj33Qcupl5BKqKeDhDga674Xe8taIxWQSMEx7pqyeyf4G9lT8YfxlXjCZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP/ozubGOctAxq7rFBvhOgml7D7tywFMsfNk7m2DZKs=;
 b=ZLwEVb6BwlBPXK+u0cIcjcYyuISuR4SOQNzuWWLBiXJ7MV6zpcI+oguTPZUJEjaznx1JWn/G+KHVNw9UEwHx0H61cuXdaOSMNGktC28HosFMyedkXUBKEmp5EqO9YH++rUY8v+D4A51/vD/RTZ1665COUKTfCT18eydegHS3sdc1AJORscTud47AKALeLSjCVdSFlQWvVhD1eY8RAaempeUWnwCOO2NCtaQl0BOVvjLIJcKJdLIX89rbIz3M72cqRM7euEKxSGZIIe7B/jCeNwYAznftXOwdY4V1YCZMXrHoXYlv9a4QvmNlV0dxwcbTp+ZZ7V/UOQRrdfTTRUxZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP/ozubGOctAxq7rFBvhOgml7D7tywFMsfNk7m2DZKs=;
 b=mSdHgPaPLla0TUPzkvh680iP/39yusV8XamKsXGaoZHvO6kOa4IayElOnBYdR5i4pzVyaOi2QRkt0OKwxFqCBZa4a1o0wP8p3dKhQ3ak2hyiSdWqBlMetb43ND+CR9skl7U7c7JFjKf+jxxp8G9dboHf49oL+CMCr89EPdOfP/FaXlrV5pCnEUQwlq12+b7NltbOvOhQCD+KNOzjZTl/DM8AyENrEKuPu45cHcKnCegBoCdMMehlX+r9Ug5LvngNMDeQkQaDE/xZLjNRBz0V0TxYOGStlU+73WnRu+nAWhHw943X0q3uGzEYa9sTAWa8LVNSFiDQPnlht8JWw96jaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sat, 21 May
 2022 06:46:42 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7%10]) with mapi id 15.20.5273.019; Sat, 21 May 2022
 06:46:41 +0000
Message-ID: <a4439005-29f0-b458-6a3a-b6c2758a38bf@nvidia.com>
Date:   Sat, 21 May 2022 12:16:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
 <1652895372-29885-2-git-send-email-spujar@nvidia.com>
 <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
 <90680cfb-c611-63cd-ab5f-5afb86c91cec@nvidia.com>
 <a0eed04a-1380-d96a-a406-217f053354b9@linaro.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <a0eed04a-1380-d96a-a406-217f053354b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36317875-6c13-48c2-8fcc-08da3af5a9b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3420:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3420967CC3226CEA37E54D72A7D29@DM6PR12MB3420.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqCHlcwEJaMoUB19X+uOYM/K03zsDB9sTkm68edZCsdmaVXFJaZz1pdaplRImbF2PLZB/ILBXf5/Mol54JQmluJUX7rakCpYYKGoVc3p+t7TE0Hk/fp5smZiKdDmgrANKe+hp23ca85LlNGdCzDknOXeYZwq3gOuIpYp/yGVZTExzmSqoiVPe6dj2n9TURggGbarkupTbFUdRJfzHJGWFdj4BxK/EkptWAxZnyKWCU3DvcYE7VBsGB2+yxV7ByZA9vAzY70bkxfE5daTV/FBRhimjH/NlFwN7I8I8DgMEJZ7sM0oQ/j3HOfUbgnOos+z07LE6mvEYyQcELB5T3kIovyAbEGnBi+/6+IPIFx1AtfgEkOdG5qEQ3xGN4V7/Yuo7JPhzvkDUrITvHOhQqkWW/On+IPg7dugE4uVJSxq71KOgWOslcadDG7Mi9q0Up9jm8TWTRximR9niDbGKX7T2V0+B1pePfn7+CSOSwVjWpyU6mMPNqrpgg2iJwVgTg9OIQF/RmLBQAVDe3xn5GJkW3eFsI1TCcE4Rdd+OyzgvlG5udN2JuXPxxyufo8U+iWLk2DzMhsXOHml82BwBN+PH3Rw94JTvfB//huCtomK9/kD1iy4F0ps0kcVPueoqR84AjePapa+AnWLmOjd5gbaYuEkzTnCwFNP1OX3g9ey1xqnJj2vm70dX8HQtTucD1QxzpHKNaPRN3/Gbxu4hzcZTv7tvTLYIM6Gk+gIkNzbc5XImLKWMpgWbsrFFjLuDDPF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(36756003)(6486002)(186003)(8936002)(2906002)(31696002)(6666004)(508600001)(6506007)(53546011)(31686004)(86362001)(5660300002)(6512007)(66556008)(38100700002)(26005)(7416002)(2616005)(8676002)(66946007)(66476007)(4326008)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHV3ZHJ3QjBWV3JUQm9DeE5hb2lRb3EwajJTNzJLdGlScENpVjFzaVVKUkVY?=
 =?utf-8?B?TS9jZ0dpQVdEamNmSnZMcFpvQllEZVRGalh6Vy9ZejFBZ2lQZElkejZmNVN0?=
 =?utf-8?B?V1lvbjJ5c0lMZ3E4bHRyUHI3N1R0QURncUFKMmtVd0drQTFsRkhpUUZ4U0JE?=
 =?utf-8?B?WFdhUjFZRy8zakhsejRNbmdIV09aR1VNSnZydC9XSDZ3Mko0ZnlESFcxc2lF?=
 =?utf-8?B?MHlaL1BwYzdhUXFJc1RhenhaazFGVVZZNTg5bndXSDRYRFhVemhBYmtZNUZN?=
 =?utf-8?B?MlpSR3o3U2Fqc3NwTlFjM1dnWnlNMm5qL1RVa2ZmR1YyVlBGQW03ZENPZkNS?=
 =?utf-8?B?ODBkeC9HUGhlM0N5R0tEUTBkYy9WQzRPSmxlNXYwdU1jNk9qc1E1Ly81ZGdL?=
 =?utf-8?B?b2I0dFlwMHpjUjcyU2o1UFByaVlsdFRnWmJBY2hzc3l3ci9CQTFTTmErRVlR?=
 =?utf-8?B?K203MnlkbHM0OHdYTlpKbU1qWUJ0SUhQdXkwQXk5NGVwbk11NHI4YUY2Q1FQ?=
 =?utf-8?B?SmQ1ejBvUTEwSTdkaS9TS25aRVBtTmhLSHpFZkZQaWRuZ2VmUUNETXdoSDdz?=
 =?utf-8?B?eVBqbFkrZmZMczlaYUtrRHArenZCbVVyNzBJKzFIeU9LNm5ubGFUbzRGd0xt?=
 =?utf-8?B?VUNFOVhsZHMwektZOThhRS9qOVcvNTdDRTF2RGNTRkVYUm5IdDlCMUxIZnpC?=
 =?utf-8?B?OUsrUERkZU5mVjcxZ1hlRk10Y1RYUkkyRW05RmxYQWV6eUd6WUttYTZuWHNE?=
 =?utf-8?B?bkMwK1E4Y2NMclRTRFRQT21GL1NrNUFsRmNxRmhWQnNXelBtSlkyZ0Y1TUsy?=
 =?utf-8?B?Q2MvMDFLb2s2Ump3aVM2eWhnRGZyQWtMVE9OMjZaUDh5V1JuUkE3QWNaSlc5?=
 =?utf-8?B?RWdNNGFvY2FEME53UzZEVGRmdElWeHo4SW1ZOGQ5L0JCN0paRU0rWlEzZC9w?=
 =?utf-8?B?ZCt6RmF6ck5xdVFsdW9mQ2YxREZndXJPU2twOWNNSXBkMEtFSU42Z2xZclUx?=
 =?utf-8?B?akljd3NyVGFVd25tRFdaQTNxWWxyVm9pZmNyckh3Y1IwaVhTdFU1ZHFUZHNk?=
 =?utf-8?B?MXJ1SUkzekhWWUlUSUVvVEdvZTJZTGpCdk44Q00zMnhGb0dTTDhEZDZnSHBh?=
 =?utf-8?B?aVJWYlN2SWx0Y0RqVGF6YWVWU2ZPMlprdnQ4M0dEeXA0WnZXczFlQTNLVjhh?=
 =?utf-8?B?bGR5cWtZT3ZVcTZQZzlpR1dwbWI0My9uMnVxQkd5Q0RNMmk4SE54aXVGc0Yz?=
 =?utf-8?B?ZERCY2t0WGdLZHlhU1RqRFNnM3NjS2k5bzlhSWJpR0o0bklwUmNyU3R1NVVD?=
 =?utf-8?B?cWZWRmtFNWhlc3BSQkpPU3JKV2VBMTB4VXc3bzcwNXNQYzZ1YzBVQTBManIx?=
 =?utf-8?B?NjdTMFFaRk40MmI5K3h6NkhzdGlNTUZNdW80NXpCOFVuZG9WOGdSeFVxcHRE?=
 =?utf-8?B?WjY1ZTM1ZWhSRVhMUHUvOGxBTmpxZVJDa29NQWFiVXk0SmJxRGFyL1JEY0Zm?=
 =?utf-8?B?SU5lTG5qbitzdE14Lzd6TTRWbzgvL2hVQ1EwNUhPOEY4U0dVMU1VSzVPd2RC?=
 =?utf-8?B?M3FaUEtXb2lha0lZMEJ2eUN3VEJmVTJzQlNwRXdYUVBuSGI3U3F3U1pFZHNB?=
 =?utf-8?B?R081RnhQMWI3Y2RZaWtPaEhCWWk0eUFROEdwVm5yeXF4M0k2RjNycjA5cGRr?=
 =?utf-8?B?Wm1rWlZPTk5odStCcHJJbytnc0E5elN2T1N2YTV2Y2taZWtpblE5K21INU13?=
 =?utf-8?B?WERKVWJHSkIzbjZCRFhuZDh2NXFXMUdUQzFWcFJYRnJ0YjZOYkp4ZjVBblA0?=
 =?utf-8?B?SURKUkF0ejNCN2RRRW9QYUgzWWkrSDhNN1dhTHJSTkFFa3Q0eXJFdmVBRWFl?=
 =?utf-8?B?bUkxZ1dEUUIyeFloelNLY0pBVVhrblpJV2RTT0R6dkk1L1RwMVZWZjdSa0RN?=
 =?utf-8?B?UmJWaVcyakU2ckQvby9HeVQ2TjJkTUYraGt1T1ltNjVOaHdqbVVVcVMzUXoz?=
 =?utf-8?B?RWlwdFE0NTFsamJ0akV4a3loeG5QcUMzMllid3J5OS9CVXRJMmw0ZkVBb0t3?=
 =?utf-8?B?S3ZoSCtlcGt3cjg4OU1TSDFjd0xpcDAwTGlWUGtHZVJMUFBUS1dOTWkyQlRN?=
 =?utf-8?B?SFgxakFQVmwzaUliLy96S2ZtUmV3ejhXU2dLTW1zbjhZTkRkd1I2bC9jeVdm?=
 =?utf-8?B?U0tWdGtPdlhldFdDOG9xcE9UWDMvOGJORHRUWXcwN0p5bU5jdVp2dDJXTjRK?=
 =?utf-8?B?QVJSV0s5TlR6T3RJdW1hRnFTeHhMYVNlekgzbVd6T0dXNVJlWSsvUklGSTFL?=
 =?utf-8?B?VW1hd21EdVRiZGF2QU9ITk43cms5YjBOVlpJQ2xxNzhrNFIrdWpGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36317875-6c13-48c2-8fcc-08da3af5a9b6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 06:46:41.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y26uyUUVD31P8dTBbX36F/fTPcVn/bHvYer+IV0V3K8ktKQq5d2SYH9iViM4cZLrtozum6yDc4KFrAIcmk34kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3420
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-05-2022 12:21, Krzysztof Kozlowski wrote:
>
>>> On 18/05/2022 19:36, Sameer Pujar wrote:
>>>> +description: |
>>>> +  The Multi Band Dynamic Range Compressor (MBDRC) is part of Output
>>>> +  Processing Engine (OPE) which interfaces with Audio Hub (AHUB) via
>>>> +  Audio Client Interface (ACIF). MBDRC can be used as a traditional
>>>> +  single full band or a dual band or a multi band dynamic processor.
>>>> +
>>>> +maintainers:
>>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>>> +  - Mohan Kumar <mkumard@nvidia.com>
>>>> +  - Sameer Pujar <spujar@nvidia.com>
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^mbdrc@[0-9a-f]*$"
>>> Why? We enforce only generic names in shared schemas and this is neither
>>> shared schema nor is it generic name.
>> Idea was to keep these node names consistent across DT files and parent
>> node can allow a given list of child nodes with strict checks. Does name
>> like "dynamic-range-compressor@xxx"
> The checks are not coming from device node name, but from matching
> schema to compatible. Why do you need consistent names across DTS files?
> They should be anyway generic but what happens if they differ?

The IP is re-used in many Tegra SoC generations and thus it is nice to 
use the same name. But,


> Additionally, the parent schema enforces nodes of children, so if this
> is included in other schema, then the change is pointless.

I see your point. Since parent schema already enforces the child node 
names, another place from child schema to enforce similar rule is not 
really necessary for now. I will drop this. Thanks.


