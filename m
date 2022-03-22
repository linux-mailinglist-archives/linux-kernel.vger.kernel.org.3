Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FB4E4587
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiCVRxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbiCVRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:53:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590918E18A;
        Tue, 22 Mar 2022 10:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKy00o9iS6PEupRAAM170A9ahBGDMhycebrtEucY1bEpvlAD9crV5dxUJm6NsWtnLaWgpFI+r/Q/Yo8renLkvOEs91JVCh1dPyr+0nf8bnelzeQSbI578AZHDGyR7hAzS9a0cJ00eD1dj3hDuf2Qy4BMChRMcZs5U3PZ4PWm0SLgO3lqHFOAmp1xh8Do3BSXJNc1yGtABMcKI/rFLEVnkgNft803f74FO+oWXQs8WCDh5ozVnlUmw8XqCW+wPNNd2ux4ccNm+JyP3Pc7ac+T+uJ7FPqEYpg2dH6kevucwSKV4yNHL9DJzYn1V/baCkckBQKUpOfqBADcA6ygp5Gf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKz2LFHlewLLFLllgzi9ns1uV3XhiWDzhKypG45cjJI=;
 b=G2SqJlNd3F5wH0AXfKs/D92Yw5rt0ASVQrxIkrP7a8rq0q9H8EOC5GdSZYPcvZWhdONITtGfin9kRbZ7EQA/MKmcjHoneAFRZtSUKZ+TlMWlsxx0O1jmoj0s+b9bPuC2euskNpipCKeeH/QhEBAgFvTGriQlNPIlvrcM7StHlmljmpyp7IWQM4zgBHMHgAikZS8GVegOtqW5EGirr4FRMLIQA0BelWXWyDBmCk4BSJcqzf9CyApRPwPfKj8F08Uzin0Pmx3TpbnnqWdikXCZjAbgf7aqnFF00GIQ1CAZ3Tq8kVhwZGdMb9Tynbd/8YazgRC7ZzSTLiuZD5nG6vmg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKz2LFHlewLLFLllgzi9ns1uV3XhiWDzhKypG45cjJI=;
 b=tV+k42kA0SlVlFWay4jHM4XWKnL03fl5VYbT3rzhdFI2FSGtCpzvNC9O0BYQK1Lnd10b773TuT7l7bnITWwPxdIS4iciD3pG2iU3S0RH0ksTTiVRuG9b7rSFWbNDmzN3C7FpS5HsCgu1yf1jnt/6XG/FbIs4btlQfPvFfmW/n9NtmFReiDM36GM/k4lRRfrKJHhkDwNiT7GGJksEFJle+SgSOQlNijbsPKXlp8DXTItvijbiWh155sfK05TNNwmeX8r8KGk79+dOlRcFHl7pYG5yiEPlObMJkOBCa3Q8FKuWTyILIRmGXuoWZimSBBc4g2Mw8+OqbXjxGVuH36UwSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CY4PR1201MB0150.namprd12.prod.outlook.com (2603:10b6:910:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 17:51:44 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:51:44 +0000
Message-ID: <1291939f-5301-1c94-7cd2-20c0b79476b4@nvidia.com>
Date:   Tue, 22 Mar 2022 23:21:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
 <78a48790-f97c-9897-821b-7f9af0b041bd@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <78a48790-f97c-9897-821b-7f9af0b041bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::26) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f9fabf7-3e4b-41f6-01c5-08da0c2ca0d3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0150:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB015061CA6DB452F4F7D6CEE2CA179@CY4PR1201MB0150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d09CzrVaKmTQdUyqB3AaTUsX6+8N79hYi4adagztsPYenQhx8dfHxx4kg0Yl+xeEwQSvgxa51R0CH9wbmpAwV0AmhSY3Q4yStyIPpSke7RF6ionD8auND2FeOBR0uKqnvXG2Vlo4XoWxdhQ7OQh0XnI71ZfjuAbjb+XExX5ySr/d0uRYEicWIQrZ75igkd5gwb856HGfoyLaa6fEbA+q8TO3Avb1Ehd/5edRYyD7ZX+Tn65hWW3gLPo/pw9L77uQzi8xU7u+8GFmYsNhLqNXdnfdonjzSC69e30EBC2cXXrLQS51fYs/GODYtTF/WEB+kZPlJYPpvskwvdFXZS99z5q8EmD/K0n1Sn+Dvn/zdLUwNp+ZVOI8i4T5j13ExdnEn9JOn4OIV0v5OmS2iqWULAA3e+fBF4j0Cu08Ok5M5ux8t1w6EBoL6e/gJY6tvBqki4dyYrFToOIgAs+MMaZeZVDnr3Wf+IKQa/I97AcsEZXat2Y/MjHyk0C/fEQgd12u0jeRWnvUZWXSekeCdW7Mi/qP/idqpdcx4eo58NAiUkVQq29YFqIFsuxlJWtcIzFbkmVBgm27cVuz1beasuzMBvre0ZhF5um6XnU0CEPRlMXZdGcpJMCytp7DVYBuddjDJ/a0HCjZMYFZCkmshejiBfhPZbrIvTptaS+h9mTmci+V5nCCuCuuGRvG+BhiuJfcpb2b0RUVfa+LwFTrK96GibLelcRoH53lfoxjrLBr7kI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66946007)(66476007)(38100700002)(4326008)(8676002)(36756003)(86362001)(31686004)(31696002)(6506007)(8936002)(5660300002)(508600001)(6486002)(26005)(107886003)(6512007)(186003)(66556008)(4744005)(6666004)(55236004)(2906002)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnA2eURiK2NMWEFaaHI0a1krVDgvRjdBL3VyTXVZUS9yZzlBcVRZN213Nk40?=
 =?utf-8?B?RkxZS1FFOGQ4Nm95cTkrVVgzS250TVdYWENIN0hMRXI2eFRSWW83L3lGaHQ4?=
 =?utf-8?B?cmtSY1lnNFJkaCtibDU1eG1QUkdBMmVTVFBDR2FpWXhxVVBqbzdHUEhTOFVC?=
 =?utf-8?B?bW1CQk93Q3NrZCsyR2dBT2tlekI2cDBUUHdmU0IzME1maUZMOW5nMDN4TWlL?=
 =?utf-8?B?MytyeGZGTUpxaktmaEJlSytBZCt1eE93d21lT2hmNGFrUHpLcmgvanRZWEo5?=
 =?utf-8?B?N1lyNFlwWmlFekZGaTl1U3doVEZsa0ZoM0U0TmtwT01hZVVrYnJlZXVZdVpW?=
 =?utf-8?B?Ulh4OC9adEhwTit2ekpydTRFY3B6eWw2bEFZL1orWkI4Rm9WclZJY0cvcXVP?=
 =?utf-8?B?cDNLcGdwWWVXcjF5YlJFQjdnb3VmeTFrN0kzMzNLYjNqY0pLaCtpWnBxYUtM?=
 =?utf-8?B?TllqVWlra1hJc3pUMklTKzdoc1NLSmNUOXoxVlBNdnFTZlovRStCUml2RDRw?=
 =?utf-8?B?S0k1MS9JNWttVXNET0d1aVhQVHU5aERmK2s0czNoRHp1em9XZEFKQU15TGhJ?=
 =?utf-8?B?cXk1cXltclNIeVJ0YzNXS2MrdEE5RVB4eENZTGVIOWcxT2VTU0hoTEpsODNP?=
 =?utf-8?B?THRhbFhnMkRGYkNlOFNRNjliM2pIOE1ZbURtcy9DQTRWSWNsWlIyRFdwQ0Fj?=
 =?utf-8?B?KzYvUGk4WFBOYmM1U2dJbUFJWXBRN2dwaXhwdVY1RzVhZ3BMQ1JaU2locWox?=
 =?utf-8?B?bE9KWU9nNHRJNnY2WXpFK010SmJhcm9VZ0tnK2Ywd2VRNTdxL0RxUy9rSDVC?=
 =?utf-8?B?dW11cFNwcmU2SENtYXlEMjJ6cnZnTGU0YkMvM0NILytCNUpVQkxKMnZGNjJS?=
 =?utf-8?B?akx5aFhXVzJPcklMVkZvdWZHVEQ5NDFRSXdzeWo4ZFA5TDhFU21nVTlNa1k1?=
 =?utf-8?B?bG5RM3B5OHc1NnVQMHRHZWEwNjZ2RmtYcTZjUGRGd3dJWis5RHBqZE1SNlZj?=
 =?utf-8?B?SVlFZFFIaUpmTnpCdTQvbGZheW9ma1kvU0ZkVGlSVXU4cmY0cXdTR0k3MUZu?=
 =?utf-8?B?ckZqUUVMYmFTTk5GbHYzMGl2eTNuczBFU2U4Z2pzN1RnSHJnZlpGQ3pZR3E5?=
 =?utf-8?B?SFIwNEY1SzJyMUs4VTQxVzVUeTRMN2RHeEppV0ZybXNlTG5saWM4ZHVLZm1S?=
 =?utf-8?B?Tk9EaW5SR2hWME90d3BBQnFUVld4cTE4bXZ1RzQwTWthOVQ5WW9NeVphcTJn?=
 =?utf-8?B?cVJ4dG44ekVDcjAxRC9tSmlxYktXazEyaW8wS0xTSUc5UG1pVDEvYTljemZx?=
 =?utf-8?B?TExzR0srNU1pZVlaSDBNN2FUZU9UUWRtUCtrcTdNSmdMWWNTTjhDWEdaRmpO?=
 =?utf-8?B?dmprMmI3S2Vub25yZVZKK1VRUFZqRXZIeUROcHF2ZFhrWEVGM1NWdUNkbkxT?=
 =?utf-8?B?aEZtbnhXTG9JdHdQRHN5NUdSUVFOZnNDMjRMYWdOaHNlcSs2eC9KS1RIY3hB?=
 =?utf-8?B?MEE4MW5vWVJ4M21jNFBYSk04OUM3c0x6UVBpbXlIYWdDMmVVbCticTVRMmFT?=
 =?utf-8?B?eWtDRHhzcStZcU9mUUtKZVRNT3hZTjhFTXBKc3BHc2trQVk5aDVRbU9JS1hk?=
 =?utf-8?B?ZGp6TC80dWtzWTN0RFBJYVlvSGdBTVBLWWRSTHo2R0w4UnRmSVBIZFROQXRV?=
 =?utf-8?B?cnl6QlpVdWY4WTBRcUs0SkJOd1hETmswcGQyb0M4RHk2c2lsOTIzRlhmRHNh?=
 =?utf-8?B?SVBKMkJoVTlITkg4b3l5SldwaUUycTF5QUtScngxVGlmY0hSbTRFS29oSjRh?=
 =?utf-8?B?TmZhbzFhVVVmWTkvV1VhNFFZdUxvUU9JWktEM04vUkNVTCs5NzFPd1lOMFFs?=
 =?utf-8?B?Y1I2b2hZTllRM1BaZ3FJZTR6WE9WMmhYeEdUeUZ1R0lmQ2JzcER5enF2TWwr?=
 =?utf-8?Q?6kb2OzAQS3eUsPsyRT37auul+HvKok50?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9fabf7-3e4b-41f6-01c5-08da0c2ca0d3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:51:44.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri8WoWdrawRwo0VyQeT9CYkWnj9Vb5cl0MW+FFSWPGFQdtxPnqNIB+k3M1stJ5gLBPxJC7JwAl1njK9L2Bw+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2022 9:49 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 19.03.2022 18:50, Dmitry Osipenko пишет:
>>> +    mc_has_channels = mc->soc->num_channels && mc->soc->get_int_channel;
>>> +    if (mc_has_channels) {
>>> +            int err;
>>> +
>>> +            err = mc->soc->get_int_channel(mc, &channel);
>>> +            if (err < 0)
>>> +                    return IRQ_NONE;
>>> +
>>> +            /* mask all interrupts to avoid flooding */
>>> +            status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
>>> +    } else {
>>> +            status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>>> +    }
>> So if mc_has_channels=false, while it should be true, then you're going
>> to handle interrupt incorrectly?
> 
> I see now that num_channels and get_int_channel are const, so I don't
> see why mc_has_channels variable is needed. Use mc->soc->num_channels.
> 
> if (mc->soc->num_channels) {

Okay, I will remove mc_has_channels and replace it with
mc->soc->num_channels.
