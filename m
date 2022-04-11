Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7844FB37B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiDKGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiDKGMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:12:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA126115;
        Sun, 10 Apr 2022 23:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH17j2PEJ800ShgZ6dhXZiJhwByN21IIz8VPLjbZHloVaSQIVrtc/sbWt1cVfjtH2h5TqRpn/2fXqMfLh651T9ROtGj4KsvGF2/luctoE4bYLqhyDyE+FkdvNVIjvKO57vADbOuFwzA3yRq6vluVRq4MbkLSw6SZX/nE89LdR2fO1U92oBfloSBRGjxHqFKSphSh90eiATmuiyzlDoqOnXOUQQS2NtSunMppUTeRXx9NhqGnF5VW7G9zsrf6k9sKLhx4G/RHUNhM3gAa6Ge88vZ5kS1R5sVgwpiXqe3R4lNh14CikjbAwcZDcslE+onEwYZqYCxullRa+xRLXVVMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd/x0v4G3E4MeACoxmBsvPs098Cpssmg9EqDIJ8tQBg=;
 b=ncy2baY+gMI9tj/lBFgvhu45iJCx2pSrk4K1uuXqXug8ZhjE1LFhasMt1XoZ++acaB2LE6pZNH+cXrVagqe+4wmxfMvZEiq9ylQRgJUMeh4TRjNGeYYjJYxCfgPH4AqX6VIFG6CMu8Ev7mp0usBZXfwTDsr74Jq1A4Z8pZb/G14L++B/Y4EggSvL/ZtDwts6mThTs4lMOcOk9Gh5RHO3EG1QZKj7Ob0zGlcFEPRcg7flxaJlk8USPwNgZj6L65EMj2REBDtleIhoW3e0kod4hrYcyfNR3rx3SnUgJtdxX7IyKeJj0DsQe/+4AR4IC0gEXJ0o3zAx/KolHb2emwbAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd/x0v4G3E4MeACoxmBsvPs098Cpssmg9EqDIJ8tQBg=;
 b=Gb19Bw0qe2WyCwL/rUJ7YiiFvGZty/ADOhA3cFq+vkG/f03RxwwNL8SbNKN/+DijZThmXrXKR604bPxQYUehXJ4jFosDSM2n279PPmCuf2wWguvmApJNbVtXEW/1pwR8ndvZt1PqbD6c3i3DPR52pZBIRnRhgYK5V2XSW0LmVLK/IvviKDCfXCD3YkUfTjNBfuvlY1fjQhffAYrryfYQc/VtFTPRURxdvK6fp04gU5WUSNISgf5KWbd/8y8EypVjP99xyiKddwAxp5KoLpEBjvxBz2dVvMvIFuRFqb1Q+ZCs/DqXVQC8RkxIwIwjH2ut/xUzC6SJyeahxIaPv/vzrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:10:04 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:10:03 +0000
Message-ID: <1fac370b-a837-c071-0007-33ae8053b871@nvidia.com>
Date:   Mon, 11 Apr 2022 11:39:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
 <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::14) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba70cdd-c9e3-465e-eaa6-08da1b81eaff
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB167121FAC341E505001D584BCAEA9@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKAQ4SwjEnQpC5X5IObUP19bx1Xgc+NLj9La4s9xMys8Ptsv3L4dylR/FU3XC1rkLo1yv0EVEdcSc66jtC6pbbgT+HHE5Zjy7rk7TlS4LoVFZNJCWqK+l37pYaMOZxsivH/40LI9NnMUz6/lx9t5bK4xatEjYBArsVIsO4PxK/6fKCDfnOsgXiNMo50CdrcszumM742UqxUC1QRHq+0j+ZI9qtcxWh0Fvdt5JBMIehFoIfxrazJ4RjWBYtOi9uxMflaRm35CUtDNJf57LMAvkoPhYD1j4+uBO+fiVRBmXL2Sbvz0AXR6VL1Gx5BI72WdhSfT2FEj1lUWWfZ9S+EtWFxpCJQaYrk4i9iHVhweDmq/2ll/SRVOglzcKCIPQcxgrhy0aavFz22NntsZeW3aM70RDFY/PTww5/EL6lXRDG72jTDhRNFFsvkh9boZE6ENTtheYZYXabQz0D46gy6ir9paXetD9C0ObHIdr9+C2Z10Q8XVWDjCHbja+eF/5C033XRv+sw+QUfZvXhSxTcT+xArdfRFGENAF8uTRVbd9LOt2xevPPmiMvT59tFGU6/TcYYq0nSowkFVhNVPA+aIqZKQGAO8DQYZM9m2BwxwqVbuQX+ThYvDmNLobsqA0BOTJzdKLZIFlgSKDAye7+WlmBhSvKMfNWD6vzcpz5ftwKVcqz/0sozGTWcaB/73uRp+IPu9YZmRaE8ZQVAWlfGSXu5BMKVqCucshM7BVHI6QoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(86362001)(5660300002)(31696002)(6506007)(6512007)(508600001)(83380400001)(4744005)(8936002)(38100700002)(53546011)(36756003)(55236004)(8676002)(15650500001)(316002)(6486002)(4326008)(6666004)(107886003)(2616005)(26005)(66476007)(186003)(2906002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkIvdCtPL0dmanJWZTltVUtQaDdsRFloYVhTb1JlLzBHYWVicXlvTEp6YzRU?=
 =?utf-8?B?ejN2eHJjeHZEYzBXSDRnYzdoaVlBNXhPZk1rdG96NXNjN2FoaW5OYnBPZUhV?=
 =?utf-8?B?U2REQWZNei9QSlFZczhncHpkOU11N3ZsdDFYay82RUs0TUtlQ3RMZG4rREVz?=
 =?utf-8?B?bmlMZkdSbmNIb1h1VmppenNRSkk3UkxFellJbG5SQVV5QXFqalFMM04vZTFJ?=
 =?utf-8?B?d3FvSm1CdU5wUnlxQXV3VXdreGVVU1dLd3pOcnMrZXNHd1RFOWxTNTVhZFNr?=
 =?utf-8?B?ajJlSi9QMkprbW9EMUFQSjZyOE9oREVBTmFjWDkyRkd4K3RFYm1GQkNGZmJs?=
 =?utf-8?B?cWIzcUsrSldZYk9Cd1JvZzAyRFlnN2JydklqbUdjRHorZWlER0IwZ2RXcmQx?=
 =?utf-8?B?S0JKQ1VPQjU3K1JCYUlaVHU0MlBBTDdER2JOS1J6NmZxS2xmSFBSQ1U5Qytj?=
 =?utf-8?B?eHJKd1p6dHU3SWJTK25oUnhWa3VYbHpqUXE3L0xWRG1ZQ0tHSG1ROHJqOGQr?=
 =?utf-8?B?ZmFEbHBzVGlaMXhhSGhrZ0lJdHpwRWNFV29ZajBsdXZ3OVkycGhyOGJnc1Jw?=
 =?utf-8?B?UkhodFByMlBWelZxcUVSZk82d0g5TFNxRDBkUng0K2NGNTNEcnp1c0VZU09l?=
 =?utf-8?B?dU43aDFvUmd1dmJ0SmJud0dYd1ZyQ2phVXhhc3RzTCtGTTlmd3I1UFFXQndR?=
 =?utf-8?B?dzYzT3JmbVlSNEFDYlNMU3ZabXVSQkhVWjJvZGNodDZ6c0VxRXB3TEVUSWlk?=
 =?utf-8?B?ZlZVU0hoVzQzaVBHdXg1ajEzODU1WU1TcGE3ZkNOa2hyTStWRk1XSmtEQ1g1?=
 =?utf-8?B?M2RjMldWTTN6dlFIRWF1Umhua2g0azk4UWtHWkhGRXBvYWNmeC95czhpTzlD?=
 =?utf-8?B?MmVhbC8rZ0k2RFQ5U2JyaFViZGJlZkRnWm9YL2lPYkQ5VzZuTzlSSjVzR00r?=
 =?utf-8?B?VHViUmFZR09nQmJFajNnUS9sd2VRdXBwWnZTT2RVT3QxdzdXNTd3bTFhaitE?=
 =?utf-8?B?TTBiV0IvVEJWSUQ1N0JiWXJHY2FHQmdjbFVudkthYUNXWnYwbG1tdGNlc2Ri?=
 =?utf-8?B?eVJzMTVIOTc4RHM5UVVabllETjZ5dHRSOTdUaVBRN09ZOUFuZkwrRUZYdkND?=
 =?utf-8?B?dzZjS1BaUVJkNm5rZGtOQmcwR1RVbGQ2amZlUGFFTVBLSXVOWE1vR3hSd25z?=
 =?utf-8?B?NEdUblZBQUhhVXBKSDdhSVJLbG5EUXd3MFg2N00ybytZTGd1cWsvdVpIaDJO?=
 =?utf-8?B?VUYxaGRueWkxSmpkZ1RGeitQVE1QMFBFQ0RwaTYyQTJRd3ZTVy9SRGRKTlRl?=
 =?utf-8?B?NWZ3dHRaNnZxQ3J4YmY4ei9ac0t4NmVHUjhIVVJTTE9YWUdKbzcxUHBzSCtX?=
 =?utf-8?B?aU1WV0lNdG5SUmFBS2NoZXBiMmRvUVZ2cndiTC9BV3RSd21wWDZIeWd1L1E4?=
 =?utf-8?B?M09ROTRCaVRWRzcyeC8yY2NJTVNOc2NkdDQ1TlR4clZrR2d5Nm5hNkxzeDFT?=
 =?utf-8?B?TWhBRzIvaE5sTjNiUzR3MWdrUzBHWWFueVlIZVN3TTVlSXd0a0htWnpKQTJI?=
 =?utf-8?B?aWdFUXlLL3dTcnhNd25KSmZnMERkRURnbWR1MEwrekhVekJLMnN1VnVUVE8v?=
 =?utf-8?B?SWt4ZGRpdVJjZmxtN1FneFErUVV2MTNwL2xyQkRnb29mZFhYbDJoTkJvN05a?=
 =?utf-8?B?TkZrQTI5L1I2RTlUNGVpM3Z2azZwOExkblhNWUtNYlkrS1J4am9jbllsQ0VR?=
 =?utf-8?B?SWZkUGpqTEVHYXNJNko3Q0QwenFDV2dEZkk3OHlLdlZYbWlIVmtzK25rYWtL?=
 =?utf-8?B?T1oyb2NzL2hGMEdEN24zYkJ2RnpXWWN3dkpUbDY1VUQ3eC9tL0dZbWphMmdr?=
 =?utf-8?B?MHZITlZpL1orN3JKM0U3U2swdUVhOURJZDRwYUd5S0pzTEhmY3hnblVKYWtu?=
 =?utf-8?B?Q1RSVnlkTWVvRTNtVHBhQUNVTStyYWRRdVFiR0Y4eWFWNmlqcGZNbmZkWHhE?=
 =?utf-8?B?eUdTT3JFbytFZm94LzA1UzR1RGdTcE54VFFGRnJyN0pnSllEUHNVdlAzL0du?=
 =?utf-8?B?Y1lnQU5SYmI0bWs5Zi9paTJoUVhVWWp0TUpjaDAvdWozU1JVZWxUTlEweVRo?=
 =?utf-8?B?T1ZkTzZNYWcyMkpiL2tvMkdMWWRiRk12N2oyeEdsbWdMWXNFVXlyclZXNFZ2?=
 =?utf-8?B?S2l1Q0Z4T3ZZUFRSbFNNdGkxc0twcWFtZmFnZHJEbnlTN0xaRHpZMk9UeXVV?=
 =?utf-8?B?Nm5XcGpTbWl6K3l6S2pyaVMxSmthRHFYVEJrVHFkMlNLMVN6eWtWb0R0cGdR?=
 =?utf-8?B?WHkzL2R5ZDhNY1FXWUpTUG9JbVV5UFQ5eWJ2RFNUTHNDWXJ6VnJaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba70cdd-c9e3-465e-eaa6-08da1b81eaff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:10:03.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7w6lLHunzH2TnZLIbHsuN4M3tOFRS5paSQWLygHzIzp9GBzzwPFyi9ZExcNaj5g4Rnku4oPO1n2D4hz3Mci1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
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



On 4/10/2022 7:51 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>>           memory-controller@2c00000 {
>>               compatible = "nvidia,tegra186-mc";
>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3";
> 
> The "mc-" prefix feels redundant to me, I'd name the regs like this:
> 
>    "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"
> 
Okay, I'll update the reg-names by omitting "mc-".
> 
> You should also add validation of the regs/reg-names to the yaml based
> on SoC version. I.e. it's not enough to only bump the maxItems.

Okay, I'll add validation of reg-names as well.

