Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB250809F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359418AbiDTFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbiDTFfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:35:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C236B63;
        Tue, 19 Apr 2022 22:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL4kPgPe+IfZLQkeAhUWHMA44PZpTHJ/j9Vz5DZJLE1EDETN7ewxUHd//LycUR4N1osiKwEElTNVqZVTPlvIZynCOtskYBDJ+ci8yUc/FTk3CJREamsKmyiqZdBxb1YAvfycPFFmOYwonBIVH7DnJ0MnlPGXgawalE6q/5f6EynTHCqRMNaYd+v4rG4ukrgWr0U4NT/+4WixRcz46mRvu+fBY+wjo3TRVKIjDCeaowo0pe2FAGZ3L3k9uAfcUFFE50i597D/CEB14pCl/PYb4wwbogPPac1UC38ix+8fBxutw6pnXv9RQNxoCU1g31uYuLkbMfRDvbYBF8QTCNxM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/yibClq7gykEmzpjNZZjY8WKSm5G8WhrlHQylLN/CA=;
 b=aJooSVWRIwehLX8iRZnVJ51lnJpN+bhgREjae8nv3sfOf9HpQnmgYtrFuGplBgAagsroOXWC/cKPL+qatfLc8FTEAj75MB2bsHTEEJRz36JDnoPdTfvmmxy6GHggAV8QFhTASz5cWQE/sPU9Acjv2Iyml34Rr2aApIzjCHKYKRxqLkjdznez/469TvVurLppMRyT9uOWAPH19fv0tHq+dpM7Aph8c0eHSNFXTFfRQPXtCD9lY3WsjZgzKkyFOWpi/TbBBhJNlYQp7pH9h++o81fHnQclnD7vRLlrMvLCN/LFH2QURmK+A7B80Nad0paRRcwFFKF40Fq6XUNxNNPbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/yibClq7gykEmzpjNZZjY8WKSm5G8WhrlHQylLN/CA=;
 b=ps6UHEKdijlaTaCUaO3Aw1CADpfjeu48jSfSyHF5dgodWEB7NC2I1ozZbrqPNgv2RXg4uMaEdA/b9Riw4LiJYnByb6+zteLSTkK7UHf6EEw/+QIx/hsDNNnL+m3gzmRPQ9cD9G4aRNIPw4AEZ15lynOuzt2hN/NNa4ydElgQb8u2khETEWi0G/v6uiSajBNMjUeHRBlHOKDqdi+mziu63TnRhfOTb8KgvV6+ypKxOTvKk72tTEpYB8EdGblXtcjz2eyq5AVhP4ujL3DdPr8p+HCfuUE733UkDXqKWtpMicc/yif/qEU/5gw71r+Xa+1s0cvUSnjK7eu+bkQBY5B6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 05:32:24 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 05:32:24 +0000
Message-ID: <9b6b65ed-180b-ed33-43c3-7042ec895cff@nvidia.com>
Date:   Wed, 20 Apr 2022 11:02:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v1] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com,
        vdumpa@nvidia.com, will@kernel.org, joro@8bytes.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, Snikam@nvidia.com,
        Pritesh Raithatha <praithatha@nvidia.com>
References: <20220417090432.21110-1-amhetre@nvidia.com>
 <52df6c79-3ee7-35e2-b72a-44ee9cb48c34@arm.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <52df6c79-3ee7-35e2-b72a-44ee9cb48c34@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::32) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddbcca7-4093-49a0-d220-08da228f2630
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2979C970F7082F05A1C10ADCCAF59@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7JqmURINwGXor6yurXLPEejlBytVH/N2nJRBlDSsDSOcGMATidtUcc5xnirB+rOzrPCyybHA6LjXuENlG48I8VT6ZU8lOscvPMZGMH7LAIwhpFuau0ZT2gGZ8r57xZl6poOTHWV9AtYCwinR0gfUAbEAclLKempPH25grXGfdHpEYO1EYDP1WZNgDNT2ATBZrtj9sjk8+55diXJgZhFdN6aP6t3odBwLfltsbkO7mCIvlKfcWra6ktuDxvACw+4m73l5yeBL+tkByBDd8sjRdgni9tJ+rVPFfQTBlOShy1ZOJRopAAuQxsvE2KbJt0oFcuRBhTPr55aorcUCuTsWrx8WTLZHLZ5xovcTJZyabJ518NRT+j19vUoqchdFFy7yjMmdMHbTN/Z/SLgKaa5DGdmy3Asa/A5pwRWMrh2dHBjqL1jeL8qwhuxpekHr5Fhy7lL+VdAOwaHAD1rTU5AOxTnRE7A4p3ZucFoItQStfxec4X3FNOjzs1JvTwXbJ71sbcPhqNFrblos+N+ZfCLVLXLtIFgHzKOkKbPoipVTq/QByPLEyNdi0rL76vOrywZX1Rvy0dzoN4Ukuel6HACbW/kvy1Y8AdRfDHAbH1EusLWMv/jA8IrLU7sPcCNPmWw0+BS4vWe1WjFqqRljI7O7ByiSqL3nPXlu0myKH4ZE6wqo3M6pcu1/5ih7CHxLgj4h7nLANc2tZQYIJCIfSwBPrtr6s+6dd4KHJu2VNczi9oaIYdyqlp/RTbRPqgOgEgS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(508600001)(186003)(86362001)(107886003)(6512007)(6486002)(8936002)(2616005)(2906002)(5660300002)(53546011)(55236004)(83380400001)(6506007)(31696002)(6666004)(66946007)(66476007)(36756003)(31686004)(4326008)(66556008)(8676002)(921005)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdxKzdrSWtuK0w1ajB5c2N2V1VZN0NiWGRlcnJ5TGE4QUcyRnhUTmtIL2Yw?=
 =?utf-8?B?c291ZWFwYUlBQUxldVFnZFdlMmRqMDVUZExnSnVPRVNyajN0TlVqeWh1eGlG?=
 =?utf-8?B?dHVoYlVyWXM2MEtWN2JQL3ZWanVyZlhLYWM2V3BPMjFPaVhrL3NOcUI1RGx5?=
 =?utf-8?B?dUdkazRkQ2NJRmxPelZOSXhjOUJ6N2ZLTEhVY1orOWFTTDlFZ0lhTlhnTlh1?=
 =?utf-8?B?UHpuUk43dUs1bUhuMmhDcmx5cVp1WHRRZzNZdUdKTnJ1b3d3YlJHZ2paaXlm?=
 =?utf-8?B?a2d4TWo5SVNuNitNWGtOeFBjdTJCdkRSMlQzVUJ6QnU4bUVITjNQSE9EWTkr?=
 =?utf-8?B?Wm9lc3AraEs5eWtWUkY0QjZxMEFTVk9HdXl1NXljMFF0amtDbVdUdm1yZ0pL?=
 =?utf-8?B?b2o0bVBvYUFIS1l2QUZHS1g0UmhWUHRaNE9vK2hSUVdoeWxkMG1sZWp3c0hR?=
 =?utf-8?B?cFRRTE5iZ2Z2WE51OEJoSzRTUGtCelAwYWNDK0M2QXFpQ0p0K29uUDRBSDk3?=
 =?utf-8?B?cGFUNVBqT2hZMEpSeTBUcy9VKyswMUI4RU9oMVRlY3hoT09lYVFsOEVGMWly?=
 =?utf-8?B?Sk1BaFRENGo0R012dTU5bU0zK1lUNGpUSmgzenhYNnZzZGpCQUxDdFgxY1RK?=
 =?utf-8?B?blMwZVRoSUpobDZPZENESXdQeFB0MUdQY1VRWlVmampEaE80K0k5L3VPQlBw?=
 =?utf-8?B?WWppNVhKNHIwMTBIYTZYMTYzVHFuMUZkSnA3a291b2p1bXdrQmZZWTY5UDE5?=
 =?utf-8?B?bS9rU2JPK0M2QnNzOTFxZVIvWGk2WHdFYkxuS1hFSjBBN1hFRlBCRHRITzR6?=
 =?utf-8?B?ZHZGT044SmRnTEZVOTkxUWE2Z21xUFdNSW82NDZhMUljaHdjcEh4K2VkcWtm?=
 =?utf-8?B?Mkl1VFNjLzBETGR1VkhnTnk3SElicFVuZVBEOTY4NEd3dnpvZlRDQW0rMnlw?=
 =?utf-8?B?RHR3UjQyZTFJZ3Jqai9ZYmpGZjJvTGQ4K0ZpaVRreW1VQW9CalZscHpLdlNt?=
 =?utf-8?B?RzFHb21XTUJFMnZBcFZUcTEzYWVzZHczL21maWxCd0NuOCtsYXlYNXlGdVk1?=
 =?utf-8?B?allpcDRJOUNBSUEybDQ4cUlvS1QxdmJjdmREbVBXb0FNUzF0STZLT1JGNFI1?=
 =?utf-8?B?RHpTdkxqYnUrWXNtRjM2Q1BSTEFEU245TlphL1B3ajlnMnc0Y1V2QmV5Qm5D?=
 =?utf-8?B?d2FJSXFiV1NNWjA4K1dYQUl5TmlqS0o2Mm5VZkt4YWVVV056YUZnQVZjUDF4?=
 =?utf-8?B?NkhCTXFzUjRpcTd2bUNvNXBCa2lxdDFHV1pyQTFmR2dLczZUN0VLbXM3WTdI?=
 =?utf-8?B?VWpYUlVhV3hUN3lXTWh4aFhvQmo1ZFVjbVh0UTRVUmF3czdITEdLTjVJYWti?=
 =?utf-8?B?aGllb3d5WnVPaGFhL296TlpLZngrOSt5bHFwTEFVUHJuRCt0Y0tXLzZKd1Z5?=
 =?utf-8?B?UUtrRUQ4VXYvVy9QMSttZkFNaXVXOUJmd25MM0x5TFBCRHJ0MFFTVnNUTDhy?=
 =?utf-8?B?VUtzMnNiRmU4eWhHVE5rdVl1eXVEa1pzOTBUaVJzZVVkSFMrMEg5MHlWamQ0?=
 =?utf-8?B?V2MyV0tOK3l1RnhZQnQ1OXp2OWkvWE5jaWphcVcydUZCRmxqR2t1aC8xVjZB?=
 =?utf-8?B?VzltVkNqREdSbE5VMVFvOXp5ajJuU1NvZ0dtRDlUcUpQZmlsd1JYVVlEdytk?=
 =?utf-8?B?NTlueGExNWlkdU9wQUZNeCtkMThvN0R4dXc4c3kzZ05FU2pwUEw1MnVKM2g5?=
 =?utf-8?B?OTBMTkxCaFpyZ09NRzE2NW0vNGl4YUpLVWM1a0V0bGFVa0FIVEZTWDBwZTZW?=
 =?utf-8?B?eEUxQ0k3cHRPMSt5c3ZRYmZUYzJZbDdLa0ZyQkhxR3pYSlRrT2RQNE1uUmhy?=
 =?utf-8?B?MURMTWIva0dSVHhnandWbFlveEhwS2RIYlRSUDRnNFplV3FkbkJyd09LZHVR?=
 =?utf-8?B?a3lxd2Jnd2s1dTMvbHYzbERFRjkrZ1ZzMllsU2tXOExYdzN2d0VHc3NqYjlS?=
 =?utf-8?B?bkZUaTg5UTNwUTcrSTJKYktqaWg4eHlFQXc4cS9pTHRlWDhLSG5tcE5FSStF?=
 =?utf-8?B?YVBhdmZjdnpPNkJtZnViK2xTcmR1Rm5kWTV3dFppTWkzb1N6dzFsZ0I0Vjdv?=
 =?utf-8?B?cWZxTjNGWWMrWitXTThwS05YbmlDSE14R0YvdS82aENxUnNtandWUHNTWUZh?=
 =?utf-8?B?RldlYzZqejE5QU56VXRxejhKeEJWaXljVTIwV1VoS2l6N2VpeHpBbllOcWpJ?=
 =?utf-8?B?YktXTkdoNWNDOWV6RmR1SWZZQStVT0xsbnBvWlZEZjJpR3FLdkpjR0dpaEZF?=
 =?utf-8?B?QmdscVk1dEJOcE0reDdIQU9kUWs5d3E4Q04rNWNLTE1YVHMzRGd5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddbcca7-4093-49a0-d220-08da228f2630
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:32:24.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80okRS9fZ4EU8No8KimrNLsvw6ZK3MlCwlinetesTtB7BOsJPjWO8+GZfrzHIMri7tlVSJay4qotaEW554EHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2022 1:57 AM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-04-17 10:04, Ashish Mhetre wrote:
>> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
>> entries to not be invalidated correctly. The problem is that the walk
>> cache index generated for IOVA is not same across translation and
>> invalidation requests. This is leading to page faults when PMD entry is
>> released during unmap and populated with new PTE table during subsequent
>> map request. Disabling large page mappings avoids the release of PMD
>> entry and avoid translations seeing stale PMD entry in walk cache.
>> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
>> Tegra234 devices. This is recommended fix from Tegra hardware design
>> team.
> 
> Is this related to any of the several known MMU-500 invalidation errata,
> or is it definitely specific to something NVIDIA have done with their
> integration?
> 
It's not a known MMU-500 errata. It is specific to NVIDIA.

>> Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
>> Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 23 ++++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c        |  3 +++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h        |  1 +
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> index 01e9b50b10a1..b7a3d06da2f4 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> @@ -258,6 +258,27 @@ static void nvidia_smmu_probe_finalize(struct 
>> arm_smmu_device *smmu, struct devi
>>                       dev_name(dev), err);
>>   }
>>
>> +static void nvidia_smmu_cfg_pgsize_bitmap(struct arm_smmu_device *smmu)
>> +{
>> +     const struct device_node *np = smmu->dev->of_node;
>> +
>> +     /*
>> +      * Tegra194 and Tegra234 SoCs have the erratum that causes walk 
>> cache
>> +      * entries to not be invalidated correctly. The problem is that 
>> the walk
>> +      * cache index generated for IOVA is not same across translation 
>> and
>> +      * invalidation requests. This is leading to page faults when 
>> PMD entry
>> +      * is released during unmap and populated with new PTE table during
>> +      * subsequent map request. Disabling large page mappings avoids the
>> +      * release of PMD entry and avoid translations seeing stale PMD 
>> entry in
>> +      * walk cache.
>> +      * Fix this by limiting the page mappings to PAGE_SIZE on 
>> Tegra194 and
>> +      * Tegra234.
>> +      */
>> +     if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
>> +         of_device_is_compatible(np, "nvidia,tegra194-smmu"))
>> +             smmu->pgsize_bitmap = PAGE_SIZE;
>> +}
>> +
>>   static const struct arm_smmu_impl nvidia_smmu_impl = {
>>       .read_reg = nvidia_smmu_read_reg,
>>       .write_reg = nvidia_smmu_write_reg,
>> @@ -268,10 +289,12 @@ static const struct arm_smmu_impl 
>> nvidia_smmu_impl = {
>>       .global_fault = nvidia_smmu_global_fault,
>>       .context_fault = nvidia_smmu_context_fault,
>>       .probe_finalize = nvidia_smmu_probe_finalize,
>> +     .cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>>   };
>>
>>   static const struct arm_smmu_impl nvidia_smmu_single_impl = {
>>       .probe_finalize = nvidia_smmu_probe_finalize,
>> +     .cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>>   };
>>
>>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device 
>> *smmu)
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 568cce590ccc..3692a19a588a 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -1872,6 +1872,9 @@ static int arm_smmu_device_cfg_probe(struct 
>> arm_smmu_device *smmu)
>>       if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
>>               smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
>>
>> +     if (smmu->impl && smmu->impl->cfg_pgsize_bitmap)
>> +             smmu->impl->cfg_pgsize_bitmap(smmu);
> 
> I'm not the biggest fan of adding a super-specific hook for this, when
> it seems like it could just as easily be handled in the init_context
> hook, which is where it is precisely for the purpose of mangling the
> pgtable_cfg to influence io-pgtable's behaviour.
> 
Yes, we can use init_context() to override pgsize_bitmap. I'll update
that in next version.

> Thanks,
> Robin.
> 
>> +
>>       if (arm_smmu_ops.pgsize_bitmap == -1UL)
>>               arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
>>       else
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 2b9b42fb6f30..5d9b03024969 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -442,6 +442,7 @@ struct arm_smmu_impl {
>>       void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
>>       void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 
>> reg);
>>       void (*probe_finalize)(struct arm_smmu_device *smmu, struct 
>> device *dev);
>> +     void (*cfg_pgsize_bitmap)(struct arm_smmu_device *smmu);
>>   };
>>
>>   #define INVALID_SMENDX                      -1
