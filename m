Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5294FC11F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbiDKPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiDKPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:43:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C23A732;
        Mon, 11 Apr 2022 08:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tgyeus1nHc5Ibtxk8SOcjlvT6QIcJUMoIloaO9gSnV7zOMCKCAo3GbRbub5DKvHn+DnnxBp8jl5bXb0rzTiHFCyUVW5cHajPwej2JtAEG9tnMBDdx4j03sUlkJadOjdI6qrfYembBcsyZDqjcpoutrNP/zAc5ta+UwA1ViJjid+F0oGIhThvRUw9L6UACQ7OSDxWxbA6o5uIuTYp3uj3jw0lVuz1oAc1xlFHGdRgzO+VT4Zt6CON6xsGaBPBBepnKQiAhmOL/jnSw+czqykFJoLQ7yW+m+LrXyt+38GoVFFRlqOD8HylnXe3e73EfzS1Ye+vjhBaOmSWT22FIT/8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVedXVoIinG5QlS4uTx4+Mwh0mAo16TDFrsgoy18D9I=;
 b=J5dg/j4E0dG5UESfi35ISXldF/EX+LLX8pbKqnB8Q9SdjWuNGaMN/E2JXO5bdnlpwxCItLC0eRqNnjfo/k2wIH3zSzSp5yJPRw+0KyVp1xlrB996OxDZ0XjjcEeFRFUCR9RhXRikCwRwGxkNai01Q5tpQkpnOLuUUAMXLSTRgs2y929yFfvLX7xNbz2OxPuJQG9K6l2oVdMENpcWdrSoQQCb0J3oLNI9coH8DEtV+proKNgQIXlPoglC/kmFfh9SB5mLZ8u3BFzBeshtd19MvUJuOkQ/i1UerJMOugCDCTWw3Yj8YAliuGGC7FcU+Ulj4ypKz3VbuAS2iCMWMTSt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVedXVoIinG5QlS4uTx4+Mwh0mAo16TDFrsgoy18D9I=;
 b=eBLUxdAKaSOpqLw9YoPOjCZa3CFV66QX+Iv59tqpYaEMOkv95vbfOqh326XxQyKzekG303oHV7mFaN5KVZSIrgDxejYZ5JXHwFIHigI3ad6GVF/7i3MgBh2t8Xj7/U6Ra87TOFf2lZ4sXEdtEWCf2nDRfkF3ZVF0Q/CyWrk2U5c9P0j7XyVuKY+U8d2WvyZzKH/Fk01Kk4puE4qE3GM0JU4lHv5Tcc7KzaGqMG6My5EwAKjoC2icA/+ILB+xZHAVD8yXmKb+0C0iVnH688iyv8lTHbEbE28UXjB0uTuELduh9xafOd61AutW6AldUz0SOGRgZhqUEwqa8DFY7xwofQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MWHPR1201MB0031.namprd12.prod.outlook.com (2603:10b6:301:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 15:41:44 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:41:43 +0000
Message-ID: <8930bbfe-2c33-ea90-c48d-c6a00005b6a5@nvidia.com>
Date:   Mon, 11 Apr 2022 21:11:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
 <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
 <81686bc4-c580-862b-1c29-51b34e419154@nvidia.com>
 <57825f4a-8cfa-ef00-6462-fea37cd4d7be@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <57825f4a-8cfa-ef00-6462-fea37cd4d7be@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b1f047-f50d-421d-e376-08da1bd1c761
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0031:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0031D944CBA0DF710ED71168CAEA9@MWHPR1201MB0031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKnOoVMAR/3uaKdg8onEVfagBWRPkw2DfelyaFPMQkOGi06ckNAyCjQH/tO5c/+etuBBf+i4r9xhoZ01YeD2xxoqv10jK6J/Xvhjx5ppBe8yCtpkJWJfrRzH4QhQOmj3pbCBQzF8rJC/jWuXpPdkaqf8rqNGeRK7xcdkDHKIYgCbgqJ/V/lknBXHg5h69sdnobMiVzdQb3nVekfnya2xQc5gMhSn7n2U+JUlccbFLq6i6ohuJYlYG99dTcYB9mPA7zqqOUx+xYyOCeIwyMMD3L3e0VYmB2/KApkoBeNRKjLr6pnGzB4unk9303JSYvlTZoTuS8MEnckzg+Ti0V0Z8c9HNskCK0/b0UibWLjNftSOE8e6UMU9CZO+3g3A5z93+pcENffUnlFuGLqvrMYs2d4uGm7U1jDswXDFLwoNtA00xXe7C4tEKN7RGIfRubG8arrydV2VzUDLkc7spHsghDXUUQA7M+Wm9RV0jEjRTZnvD8gX86icXmLSTEoPIgxcO+xTDh88fVVFDcJlk9+GWGLWRA9oZxO8zbI1/MXQlZJ04w5YsVenYQpgt9nHT/0ygbN4l/cPEQsdZNdxVn+PgJl2jbZaN4VwxieChq2j55SVl/OXW1TRYMP184l5VQT3TkaP7DP7fdSV421JDOCjvcc2cyv3YRxDLvsLRg4+A4BlIhX+Dkg3/QtviW5J3iYqOuRfFFnb8IA3jiMtfkUYGZLN6Sh3CHSl9Yh87ROoEPJq4iPak5b9dVIaOlSXZW87vSq33QauVdg2yUIWRx3vONWFIxq4XNdcklYRICfi+WleAjko3tW7UcNP2Q0Rn2zz9vgQzO21cmCZvykJlXeiKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(66556008)(66946007)(26005)(316002)(6512007)(36756003)(4326008)(6506007)(15650500001)(66476007)(83380400001)(966005)(6486002)(8676002)(508600001)(186003)(921005)(6666004)(86362001)(5660300002)(31696002)(31686004)(55236004)(53546011)(107886003)(8936002)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1o2ZjViL3JlckJhZDZGUFd4YXM2MmozNkY1bWpDd0xqZGpMVCttQXlsc0s2?=
 =?utf-8?B?elhiSDNneFRsUVUvM2RZamtPNU1PRWNKUVVIK3lVWVVEc1NZRFkwdW1yUDlr?=
 =?utf-8?B?dGNaNW1qeGMyVHdiUUtQdFVXYW96TEtzUnAzTHlvUlJJOTUzSDE4NFhFMEs4?=
 =?utf-8?B?dGwzYTVaclFQbCtzLzRId0Z3TG9iTHdJTmxqMmNYVmFBMzBjaGpLb1F6bW1B?=
 =?utf-8?B?SWkvMExVTXY2YzNpemZjKzZMZTIySEZiaVpGUEdCSmtXZHpIVHFtb3MwV1Fv?=
 =?utf-8?B?V2NFK1JubnN0NUJEMHB1bGNmSmNQdVdEQUVXczdSb25uQ3g5RUtIdVAzdHdH?=
 =?utf-8?B?aUQ3WllxUGMzblhTS3JEVHVWeUl0encwT1Z6dk4xUXhydVR4SEgzMnMyMlYy?=
 =?utf-8?B?V2k2OEoxeGYzUnpGcXhIMmF1TjR0QmY1ckZjZ1VPL0lNT09HZHFEbFhmRmdZ?=
 =?utf-8?B?VE5Lb3JtTWl4M0lVdVJRWWV3cmJTZDJzYWR3VHNhUXcxdFRKa2N6UTJkYmI2?=
 =?utf-8?B?a09JSXBNVXFzNU9sdTlTcWFvVnlBd0NVazZTSFpKVVU2WEtmNVIzTXVqTE9p?=
 =?utf-8?B?K0lpbXdpcC9SVzdFSngydmdVbjkvcHdyRXpQSE5EQzZyR3Yrdk0veFdMa0lV?=
 =?utf-8?B?N3ZGK0EyVWVFcFpPcnVlVW9iQkpTM3lUVklRTm1aWXBBb0FMcDhtRjd4aDll?=
 =?utf-8?B?QlZSNVpiS0NVa1o2dEd6dnFWTnFnZTJTTklqellrYUNqRS9EWnlXRjB3RFNH?=
 =?utf-8?B?N1lBSXJnWENPTUU0aGxYaW8wSWF2N3NKOHlvZDZtekgwS2ZlSU5paEF4L0NI?=
 =?utf-8?B?M2VwdERLSzNJTFhSUXhLeDQwd3VjbDBPY1dWYW9wdmJjaWRXUWF5VGR6a3BR?=
 =?utf-8?B?Z2NINEswZ2RLd1pYL1BJQlhDNGpCdXdYY1dEYmlPYkZYRnF3RzdnUlc4WEw1?=
 =?utf-8?B?amptVWU4dmpkSFNQVGJ1VkdmOWs1SWppcTI0SEhHckdVUWE1S0RHYkxralIy?=
 =?utf-8?B?M1NJVmc4TFdNYzdYNEI3R2hzSVRSWXdtK1BITHF6WHRlTU1KRU5pcHlNL1dx?=
 =?utf-8?B?NHIwSzFvRCt3aU5kS1c5NnZONGxHVDgzUkN6TWRUcnNkcGo4NjFoNzhCVndD?=
 =?utf-8?B?OGlaKzVwSjRac0I4SW4xMmdIbi81Uk1IbTFpL09mRGx5SnpoWC9LdUIrUjVu?=
 =?utf-8?B?VzJ0eHFlNjFtd25OTlZIekFERFlIc0thMElpL2tZdktNKzI4NTNDUFBKVUxn?=
 =?utf-8?B?RUQyRUhvUUhZK2l2K1VOZkNjTyt0ZUQ5YVdiVXRXMEduaTlNMU8ydFFYWit1?=
 =?utf-8?B?UFhiM0FEYkx5Tm5UZi9yS0Y4VGd3RWFRVjA4d09uWWFVVVV4eitQaEJjRlJK?=
 =?utf-8?B?cnMxd3ZnU0ZjdmZoS0M0SGpIUnN4ZjNTcEdYTmVTYk92N1lFN0E3ZDN3MmM2?=
 =?utf-8?B?TXhvcWlURW1vNDMwUFRiMEZ6TzU3Wk5DUEo3cGNDcjYyOVhMejFlbGVPcEIz?=
 =?utf-8?B?M2gzQXlzRUlla1h1MWl1d3gvMHNESEI2clF3eVdRb2N2d01xTHV2a1JaakJm?=
 =?utf-8?B?bTVnVmZBNXd4MFc2c3c3aXZDNldIeVNWekd6M1pUUnY2ZUpOMXNaSkdlcGFp?=
 =?utf-8?B?eU40dWpXS2RIa25Pd1BPZ2wwUlUvRjQ3NkhDMndEeDFkdWhTbGFWZTk2L3cz?=
 =?utf-8?B?akNLQTlGYmhCbzd3ZjNLcjlGeHUrZ2FhS0p0WEw0MzA5bUtKSllCenZoZmlZ?=
 =?utf-8?B?UXl0WlQ3aWlDaEM4OFZEdVlEenZydUErVjVGSkl1QlNKNW45ejcweVN4bmxM?=
 =?utf-8?B?eXcrdmFPZVZrSGJFNHoyNWZzbWxaRnRIaGNsbFMzd3E2NDVFSUM4N3V2QVVX?=
 =?utf-8?B?aVRjYit2bEk3Q1ExNWRVWFJuTmhWNW5BalRvTFM0MDVrdWVVb3FuMU1mbDZY?=
 =?utf-8?B?VWlxcDR1bVU4dlJ1NHRvd2ZmRDdoZGVmNFBMbm5wcFVSaGhPVEJpa2ZzOUEv?=
 =?utf-8?B?SkNXRmpCT3pHcmRZekhSaytObFp5bHFtZnpvNjBBN3ROL1hYdWJTSkhJUnFB?=
 =?utf-8?B?SURWNFZxNHhkc1BmTWVNOWVCck0vRTcrWXpUaWpydmEyamhVVUdDQzVRZ1R6?=
 =?utf-8?B?ZDM1azU1aTJuK2ZYSVR1bkRqOTQ1N0hDcUIwN2YyZG56SUI2c0xvTVp6SkZH?=
 =?utf-8?B?aG9JWXhlNHhtTnRlSFQxUlgwdVFNcUZlRk9uNDh6aXRRblNtQWxmdjk4Zncz?=
 =?utf-8?B?dHdhQXo3SnBNV2V0Mjl5TVJZRWFFOXZPQmVpNXM3T2FmVUJkcE9ha0dZVWcw?=
 =?utf-8?B?Mjd3ZDhjTFJFQnl0MTdJdURBRm53eVZleUlDMmlWZ3lPd0h2VWFvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b1f047-f50d-421d-e376-08da1bd1c761
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 15:41:43.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ks0FDJjowAIyt8IxUhfqCCIG3+vdJvkp7NMw6UnIh/cqW/ZC4SzyVvgSvlyCsofgLNldf/bx9Yyl8YJLKjSX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0031
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2022 8:59 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/11/22 18:02, Ashish Mhetre wrote:
>>
>>
>> On 4/10/2022 7:51 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>>            memory-controller@2c00000 {
>>>>                compatible = "nvidia,tegra186-mc";
>>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast
>>>> channel */
>>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>>> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1",
>>>> "mc2", "mc3";
>>>
>>> The "mc-" prefix feels redundant to me, I'd name the regs like this:
>>>
>>>     "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"
>>>
>>>
>>> You should also add validation of the regs/reg-names to the yaml based
>>> on SoC version. I.e. it's not enough to only bump the maxItems.
>>
>> Okay, I will add validation of reg-names as following:
>>
>>    reg-names:
>>      minItems: 0
>>      maxItems: 6
>>      items:
>>        - const: sid
>>        - const: broadcast
>>        - const: ch0
>>        - const: ch1
>>        - const: ch2
>>        - const: ch3
>>
>>
>> We will have to keep minItems to 0 in order to make it compatible with
>> old DT, right?
> 
> Bindings are about the latest DTs. In general older dtbs must be updated
> and you must get error from the schema checker for older DTs. It's only
> drivers that should care about older dtbs.

On v5 Krzysztof mentioned that old DTS will start failing with new
bindings https://lkml.org/lkml/2022/3/22/907.
So I just wanted to confirm whether it's fine if updated bindings
start to fail with old DTS?
