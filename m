Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1850D883
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiDYEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiDYEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:52:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C119C3D;
        Sun, 24 Apr 2022 21:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVnA3dyZn2cfMz3sv3OGpJyzKSAIsQSbSA5ffh3HCpBpHJaiBeAf8YhN/e6xHSXnZzTYy31E8iBndHEv9DNGCgzE2U1XmbUQKKQw2q9tX8+b4t4c7S02/7Vek3DXBbXi8aQpvSJxlkQuou6Oe+vAYVNolBvKAIz1vko27MoR2F81A5PnMhm8FJ3R+h/Q3uFbWjb8x2628bRkgRtcH1tmNvb+fJDASYcmdS0eeTE1Ddv1iQPI90QkkXbAtUAaXTvdavOnxaw2u58TuL9bSeAT7ep0qHgRIf5qqf2uIZkSwBlcudcw65MPu5yvE1DJatHv7Rb/O7xLVGFemgWZjJSX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojHBnDG9GUU+T6j/Zrw+7rgMZ7Gjn0DepT0xJCLT7kY=;
 b=mtCwRb7MbStH8cfEdutaNgX+LhtHAiol/GEnQn7nPKPE9xWD476LJwUFDvKIJcoQvfnBI+GdCqMhVs/G1QNtKzs7uZobR7ppv6QVik27bPYL1mq4010HJ6WqApY+zpjdRaLoelPZAkCxeD95X7iMr8Q8PXLE1ekKRFH0Po/wcBpTX6NAPRFTPc0yoZ/3EQW5v2mf5o/DOQOFGLg8vXOmoyuEOvtucxUkh6onnIJbiJ46vmHEYNcmMqCkVLzVWC/lUiZqwSdqrZI71dHWSDH2zigJZTsLUkNXqg29/pBk1UxwgR+nQ0hjz2HuQW2cLdoPyf/s6423CRgSMnwZL5np1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojHBnDG9GUU+T6j/Zrw+7rgMZ7Gjn0DepT0xJCLT7kY=;
 b=su2QeguJpPl019NKdhRLRIKa/5JFwlQoSuPG9geeq8sK1dHb63VYgeLD6Gz4nidX8lfhgvJ8riI0oNZTRG4zIrci73jcVmBMyNRN7BypIeAAK2iqhbfRaqamVidgGBT0Wa+elnd+Pc88Q2fu8AKbYcAmzhhnZ46j3HicGrdlxChdxCoYWSXrelifxTi3RK21GaOO12kPvfsCVk6gHsU4nKhaUoyqkj8tasPRnMJQRNAi2oHF8pPYuQyvKMsL1vuSGyBI+MOY7pLWAJLuw08AsQVggc8BkkLVPnHaK3mFzhrOdNLR7bL8ODtn0YpQ4YltqmCpqKxipxyrSv5hH/3XFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 04:48:58 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d%5]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 04:48:58 +0000
Message-ID: <b0c06b65-ada4-b357-9481-cb95f4799d29@nvidia.com>
Date:   Mon, 25 Apr 2022 10:18:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     dmitry.osipenko@collabora.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-4-amhetre@nvidia.com>
 <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
 <60db2153-2d78-646c-1e5e-e89346991b0c@nvidia.com>
 <011311d4-7139-c10c-edd7-119f5466469e@nvidia.com>
 <47ccfe2d-5b96-2a76-90b7-6c3679dcec27@linaro.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <47ccfe2d-5b96-2a76-90b7-6c3679dcec27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::33) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5cbd18c-ffd1-4756-dc5d-08da2676e89a
X-MS-TrafficTypeDiagnostic: LV2PR12MB5774:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5774464DB2C296DC2AFB06FBCAF89@LV2PR12MB5774.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSJmjAugKVIobhFisRjFZyqnJRL1BLONKXbRLg7Lkne+8+YFSCb7PyLvR7wyUTOm/98LjPPnJen1K2LJshqqs9Ov47StfL9NA9+tmIYI8/21YCkYiQDax9VVJEDJD5UIr4NtEtY2cYVeaby3fJmOeEA8gWGxMWjhi7MJImDq6hNt50VoTMAtjMYzwxjJjWnk82UuXWrX+6CR7JCvgga7XiD5LLI/HhrtEuv9xmTmdZP+PFz70p0UD0/59Dx89xHY6nUhdHeXFFhsSlJO+s1CeYO0UiZuvVh0G/i3qM6K1bZHzEZIomGG1c2ypG43Oeh/SusknrnO14SWZL/PlKSksMhP1UgO3kqoqyunwNDfNpTTmLICBjTfZChwakSWuQ3UMUH8KUDB7BYO1MzJkn3LRKf4Dw51e+MF4DGc1iGFcAFDhFe2R4brciqbPtkA1WtTXY8sZB2z48rId3V7ceInF1Y6SUJn10n/VEi9x5oSzNqkyw75Cy/+KmfQ/f55e3Qp+G6tr3A8OOqRbSxdiqGpsl0xt39Le2+Uu+9maD4xPtgtyTmtluDxhWceraQ6OqijBu8MgZpWUMT2JigsdehA03g7uhYsvvgnDRU/Kvz0YR+jutU3ALBTe+U/sAdBiQPIZ9RdF+gPMI/DfoUZ/9Xahghh5Me6G3AK+SC3PEmCX14rRWBDysBA743txrOC25MGl+m+o/5LfsaFoLkjyvGNPY7Tw0OuuQ3CCBFP8Or2UHdn9VF9wYU1wH+h0+bosx46
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(186003)(508600001)(6486002)(55236004)(66556008)(107886003)(8676002)(36756003)(86362001)(31696002)(31686004)(66946007)(66476007)(4326008)(8936002)(5660300002)(15650500001)(2906002)(2616005)(26005)(83380400001)(53546011)(316002)(6506007)(6666004)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZhVmdlQjd6RzBQMFVLUjJpaml1b2pVeUZWbXl2enM4YW00amQzR2g3TWRv?=
 =?utf-8?B?SjYwVlJ3dXhUaThtVjlPUllDMjFmNkkzVlFBbUd4TnRUQmtvRzcvbW41cW1E?=
 =?utf-8?B?YVowdGJmUWFOWVhoWDNwZTJPSE9sWG5lWVpxRCtoVjZWZXpzdEZoVWZBVndJ?=
 =?utf-8?B?TVI4TGI0czNMTWU1VE0zaG5IVC9RbUwwNzB4TitPdk5QVHJJVUhENEN2UXF2?=
 =?utf-8?B?bVRuRm1nOGxSSHBkQjBaVHN5ZlVNam1aNVdRRVFUaEdVZ3B3QkNyTlh1MlVI?=
 =?utf-8?B?OGhCU2tjVnl3N3d1b0VNcm9ieGlMZDVZS2NCLzF5dTdlWVB0M2RHVlZuY1Qx?=
 =?utf-8?B?eTVyU2ZVeDEwVW5jbWFOM0lRVit3VVhQOGsyU1B2emJGSTNNeVdoUVphNFNp?=
 =?utf-8?B?NmZpUHBHWHNQNWJpVXE4UE11cVc5c3pLYUtaWVFRZmFNZG9scDhCZE5Ib3pP?=
 =?utf-8?B?NitHMUUwNGtjdzEwNFBaR2NibUtJczJQcDVFellKUEFVbG15cjdKU2t0YWRI?=
 =?utf-8?B?aUJMZ2VWWXdBdHFXY2R4U2RqQkt0bFNDZmdmUG9sSVdtazNQN3JpY0RnOVhz?=
 =?utf-8?B?QXZ0UjNGL0pFNDRCeWtXK0RENnVnOUhJRUJRYzVlU0ZsSXMvWG9vWEtZalBr?=
 =?utf-8?B?a3I4eXZqSkhlaDBzVU1XVUZNV2VPSEZELytWQW5HWWRmUFBib0FRc3hOb0Yz?=
 =?utf-8?B?SXAybDdWVGFmcThGaDRCYlVNaDR6cVhQdHlsSHI0VlJFWHdORW11RTZRSXRO?=
 =?utf-8?B?UUNIT2g5ZHB2ZFpiWisxMFN3WUtXSDZiS3R3bGkzNHNVbllwMStYVE15UzZa?=
 =?utf-8?B?S2VDdUpHMjFFdE4wSFhpb2I1bCt4VW1PcEhvR2I4cllnYUpHZTA5V3I1SmlD?=
 =?utf-8?B?TFZsUzdWS3pPUlV5SFpCazQ5V2RXRlhqUHF6NklnWTMvU1lENHBKWkJjRUl2?=
 =?utf-8?B?V0ppODdlcUpsZDdyVE5KdUFQajdGSTFUOE8yKytQdW15RWlhcE9kR2FuS0tm?=
 =?utf-8?B?TmU1OXArcGdaZWxiTWRwSjVRYklRWldSRTJoZGpzdzg3c1VVRUtYbWw2Rldp?=
 =?utf-8?B?Rk1sdlpKcHRTcTBtc011TCtmY3lRUHNCZHk3MzZ2NkVYL0ZLYkl4dW1IQU0y?=
 =?utf-8?B?Q1Nkc2ZVdWIyTjBQZ2F3U1RxbUJXczVWUzV5UmdEQ0hTNUN6L1lRNTJwUThF?=
 =?utf-8?B?NCtZVll6THI0ZlhCQVdOQUJuUGUrajlwQzlnbE0xNzJLdjhOc0pOVGQ4aGlN?=
 =?utf-8?B?MGVnaWJvN2R3Q0FoT2hWdDU3UjIreTFEekxpQ2hZb2x4MFJ2Q3IwWWUzaTRF?=
 =?utf-8?B?c0RyZ3Blc0Y2SmRqNWt3M1VJcGt6dGM0c1NhU3k4Sm5uQU1WYW95WFBHN1NJ?=
 =?utf-8?B?KzVJSkFQQ0ZUWks0QVoxYjhwZFlIZ3NlMUZaR3lRV1dCTlhiN2xzRmNhSVc1?=
 =?utf-8?B?czE3M3JlUWk0bnFtS3pIT3lMYUNuYi94QUdteE9veDlYWUpTOFViMFlXR2Zh?=
 =?utf-8?B?elJHRk1wNVZwdHlNNkxnOWU5Q1dyaVJrY3M5VnNPWmZNOXBNMFhJYy9mWFpS?=
 =?utf-8?B?bS92bXVJZXBGRWRYTWpFZDl5TlAzV0cwUSsxY3ArS3lrS2U4cEFaV1lmRE15?=
 =?utf-8?B?a0pSWmRsTlQ4R1RTa1pQa0h2ajJwb3E2RFkrSGlEK3BMNkJuZnRQaDZlTUNF?=
 =?utf-8?B?cUVxM3JENFFuNjZYVHI5L0VZVUJDWllLYW8xb3dVQ3lKVzdYcjFRWGJubkd3?=
 =?utf-8?B?eUtLdHlEYWF4cGxJblA4WURBT0Z6bGlXRE1vZUZiVDZScFIrNkxVWklsZXJr?=
 =?utf-8?B?a2VZb05YZDNLWkd5YmlUZm5PQTdiRXdLVk9pNkEyUEFOc0s5TTlYTWZ1NGtT?=
 =?utf-8?B?Zld1UDRtTUZLdmxlLzNGYmJidG5GOGNma1JiMnowQTlENnZsVktuR1NuQ0w5?=
 =?utf-8?B?eW92SHQ2dUdTbkdVaDhHTW4wb1hIS0J4TDVmTzY5alFXSDFERmpweUFtVlJF?=
 =?utf-8?B?K0ZsbmZ4cVJBVTNFNEJMZmdqRWxvWjc4a0pBMXhFdkF6VnAvTFVjR21LbVhi?=
 =?utf-8?B?YVpBc2d3ZXZNY05kT0tXYWxlRnRQZDZ0dU5pUHNsYWQzL2pvN0p3MkhPMUhG?=
 =?utf-8?B?ME05YVJESnFIbVdRU2dRbUIwYi80MGw2RlVkVEo4ZEtUWkdFN056UlR3VVla?=
 =?utf-8?B?aDhtM1VWREhLeUJOaDlWLzdabk1MbmFYZ1owSE83RWpsRTZNcnF0M1cvT25N?=
 =?utf-8?B?MkVJNzdGSENvenhvaVI1UHpLRVQyU2RPckNiVkVKZWxvd0NqQ1hidzVXMUtl?=
 =?utf-8?B?RXZKVzNqS0pKdGswMFp6ZmdHRzJDd0EwNmtJaUFQekxjNll6S0hnZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cbd18c-ffd1-4756-dc5d-08da2676e89a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:48:58.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps+e16F2x7KW9eT4F8zq90idzyzcTRi/Z9lW8XPKwuBZNXqDC6RKn8fmpIO+fsn/mI751hdKPG2cidX7m/nbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2022 8:04 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 24/04/2022 07:20, Ashish Mhetre wrote:
>>>>
>>>> New, added properties cannot be required. That's an ABI break.
>>>>
>>> This is handled in driver code to make sure driver works with old dts
>>> as well. So is this bindings change fine or shall I change it such that
>>> dt bindings check shall pass with older dts as well?
>>> Or as mentioned by Dmitry, I can update the commit message to reflect
>>> that ABI change is intended and driver is compatible with older DTBs as
>>> well.
>>>
>> Hi Rob,
>> Can you please confirm how shall I go in next version?
>> Is it fine for dt bindings check to fail if driver is compatible with
>> old as well as new dts? Or dt bindings check shall pass with old as
>> well as new dts?
> The driver works fine without reg-names and accepts old DTB, right? In
> such case, just mention this in commit msg, that the bindings require
> reg-names but backwards compatibility will be preserved in the driver. I
> think it's fine to alter bindings such way.
> 
Thanks for confirming Krzysztof. I'll send v8 with this information.

> Best regards,
> Krzysztof
