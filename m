Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B64D4030
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiCJETB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiCJES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:18:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986422D1C6;
        Wed,  9 Mar 2022 20:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUhRl5ruSt6tl4x50dBeyw1u38kA9zA18Ezcu5Iyd4wBgaURR/bqxuEEtx6wCnhdXFw6ZlgwE+abKhZ52Fr703WTSJxRDKICkqM0k9ly/h2DX/ZsikZgWierHjrfgnVyKnxq+dh8BaFWuoWton/jDe/LosEkqFnzURcs3zhEM0D1/fm1xy3Hw5Yizb0NlgOHAZO3Iic1Tg18nKhkYsMhCKzCA5mSjA7dvo/lbtPNI/dMa7nr3gZ9RsqHcYSChr5bZQYYRSqCyDU0ZB9Fk71tg3+iB5QLVfe/CJU3C4AfAHXCl7Bgc3/aDSQ0cHkOWSO109UXD+x4bImXtf5JWlLVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6NNouMScyh32p4QvqV6KolpE4sNVC1wIeEcIqkNSnk=;
 b=mrYiO5MzWecnGq1GRPyIVgr5KsG10u5vCdbrTTKcL2oUvfyvX/ER/ZVSe0JPygFxqoIcSwf7/o+Wz2XAeMbxANg3ZlYGn4OWpbIP8LMSCJzna5FTwvRd/PQ+pMcTEgR3jyHTFu40fhFq522kHcZ8kCnZz1IZ0H+F13dK2ZS6xznHRgEWr0Xi/VR5XUB+1nAA3oWkB8gPvDdHTLMS206ytSS2y2s4kAnObPqeTFHUys85EHtJsA9DaqSkeBO3DAoOC48wh/UE0NkAfFZuumxmtkl3fzyd9xoHF+lMncdhmMXIrwrMGWqMJ+5EKzP+s/kEPCv/Bbbm3bWDHeWQ5StcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6NNouMScyh32p4QvqV6KolpE4sNVC1wIeEcIqkNSnk=;
 b=BbtCD+IBK3AbjDj++Fk4phi4efgRSjXr8XusLnB2e3GXtZlow17Fx3XxTT1E1Tyu4oGVfJayjOymvWxnIdQ0SN8SbTU0RLn1/+axpsbSF+w1UblJM74Er+bCQWnkd3Lj3n5/QfvgmjRIfvcxsAo+XkiVwrlsg5fEAKacPmIbOTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 04:17:51 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::3933:c8b5:f45:f848]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::3933:c8b5:f45:f848%2]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 04:17:51 +0000
Message-ID: <6e63dd2b-de01-c707-cf4b-33eb7d1eb0c4@amd.com>
Date:   Thu, 10 Mar 2022 09:47:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] Documentation: x86: Add documenation for AMD IOMMU
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
References: <20220309175805.1298503-1-alexander.deucher@amd.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20220309175805.1298503-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::12) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588281b1-525a-4e46-9566-08da024cf0d5
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5455:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB545575AD3E64DC32E922A0AF870B9@SJ0PR12MB5455.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fG2gNhPfCQ+AbKN9wL7rqhOawGE9FDMaQ7dIpzech61YMdjKNcV1mfhe1KeEp+ZMhWAYcG2KADijPuiIgrD/BsM6WnAM2FTS9GWeAoP1FLyPBswCj7R+2SGWCTctnDe4n3NbucBlpydYprY8nS8cFyWEIytQ3asQhkQ1MYY9MNodTuGKOEuob8Ct8hachGzN+y2PRSia5JpEtGdXyuxSrp0wvNPkpmybGuA1dOg/2yvJbk65EnHylvySWYGikSdBy8iZSJTwBNFd39uP4p2HWs5XMnwy1O/eUZ5JjJZw+/CHA8WwKq36m6y7zdd4U/s1Xuc3hc8ynJu3bd1f5EcyQPQ3fAfcmUGIAfRoe8tMuQCE50Db6Yqvo4jxPVZxjVlgH69qMF4EDMIZdZIjCqPIziBiBQwZanaounDHUv5SaRsZ4olXRro63xZcG9KrjfCaEc4BPkUO50wfjoSx+UMau8HAhFEDC6zMoiPUIIo4u0WQNnRp9Ui/xb1ALDDdZYuokETYtlxgN4l5K5YxWvalCMp/R3tz9KWzJTbSDzBC00w1+sn9em+p8sZw3DWlj7LHuSy7q1100t9j21iBf8q0uxkW2d50GEYMB4SK9RjeGT7IQJ03MNy8b19ZK/gDYIxSNcRysT6wIfgDm82STIQIXRqTV+LySAK1p9Q4SiJYPJyKNH/1IL5BpNsq+x9tC9NFYiiQeRaxmhglJqQPLblTn5vVj0QDtHrkWElX6AxbiuvHCPAQCFpNgKHHjA/8GHffWrCl24+I9g97Pn/uW37zSsHcfjo4/9kqyTolXPzubdQXudnP6TmR564hdBx1uANjAvjn9NUycFz2KoyNYgTH8j6DfMBZ7ThrQnxNtTvXjTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(6666004)(6512007)(31696002)(86362001)(921005)(31686004)(66556008)(66476007)(316002)(8676002)(66946007)(36756003)(508600001)(2906002)(5660300002)(6486002)(26005)(2616005)(53546011)(186003)(38100700002)(7416002)(44832011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1R4b0lpd292dG9kR1hTYjhhcEVZY1FjcTh2MzY1a0lEeWQzSjg2dGpScHA3?=
 =?utf-8?B?NHRXWWlOWWh5aVlLYnlHQ1JydGNOcksxNUVobHRJb1lQS2F4cng2RUFIcjlR?=
 =?utf-8?B?SUV1Z0wrbmp2OW9CcUVJRjMrNXZnZDdYR3NJSTJGMUNJMTdwYlVLWCtSZTcv?=
 =?utf-8?B?dXVtRnlhK1RrY1AxczBIMDFWV2g1MjZyR2NSZFRJb3pwU0Y2NzVFMUlpRzVk?=
 =?utf-8?B?Z25MY08zaDF6YXgrbWJ5SXZLL29BdU5hVFhWQjdPWHJnVzkvbmV3OGpxZFFl?=
 =?utf-8?B?dXBKaUxjYUZ2QXNRTThTWDVKbEhXRWZBY0lDVUovYUQvYyt3cG1xN3ZtZEpl?=
 =?utf-8?B?WkZUaGFhTjVJQURvVHk1Mk56WVhjQzNNSi9hVm5TWVVKc1ZUWm03QTRORnZC?=
 =?utf-8?B?V3g3TGsxSGU5Tm56M0N3Y3huZXErbkVtOEJyMHpNZU5HbHN6WTU2L0themxX?=
 =?utf-8?B?MVZwUnRvOFpzR0NoK055aEg3NU1OaUlHeUJ0RXhQcm5YbVpKU2k5MkZtUXhE?=
 =?utf-8?B?K05NYzVPZklta2tqRU1ieU5WZEZBOHM1dDNHcVJEM01IbmhyNlQ1QWhLWVNK?=
 =?utf-8?B?K0VQVGNyaVNGbHE0QXhTd3lCVitvbDR3OUl0eTN0SlpKN0NYWThRSlJBZEdF?=
 =?utf-8?B?UXFUM0t6UFFjOXZpTDlSajJUVHpjOEhJSzNEZXZhSnJna0ZjYU95bEtmS2th?=
 =?utf-8?B?cWwyVzc1S3d1N3Axd055eU5scFRoVWNVQWJMQS9SY29VWGFyUlAwTWVWTXZD?=
 =?utf-8?B?UnphZENjbDFuU0RjbCtWVHlrNU1ETDZpSEUydk5iOC9KaVZhbUdNdHhhZGNv?=
 =?utf-8?B?VTdSTFZvSDNFOHpWNVNaMHhLTVc5NmtSZXl5LzAyLzVnWE9UTUpvd2xweVRm?=
 =?utf-8?B?dnZ2cktVd2NkMnRIZGxWdHF2ekxEbjgrZ08vVVlGeUppaDdwMHdqYUU0NHpP?=
 =?utf-8?B?WDJiUWV6R0xvbk9RU3U4Y3ZxZng4Y3haZlBuM1ZVN2dZRmhGbEdTbWswcVZv?=
 =?utf-8?B?SnR1ZjRreUJxY3RZeVVMeFRJMU1jWHFLSXg3d3hMMUhFc2d5MXk4cmNXYTh4?=
 =?utf-8?B?YXVMQk1xYU1qaDcwMkRLaDVsYzJjeUl3aU5GMk1qVDRLeFhLeXpVcHNIbmY3?=
 =?utf-8?B?NXQ4ajNhTkVnNFpoR25VR3FZUzdxbmNVeWwyM1cyUEgrVTRibEVtRU9ycWFX?=
 =?utf-8?B?YzZScnZ6aVhlMDAzS2NXK0FDb0wyOEFzdm92VVFwYVc1OTZNcjFIVkhtcnkv?=
 =?utf-8?B?M2dmUnRrRlI3YlZqT2hUaUxsdTV0eGV2SEpGQjZRQ2hFRGU4UnVqOWV5elFK?=
 =?utf-8?B?QnUrT3gvVUxtY0lVWW50VmVmcEFnUzJwMDhWeXlQblpyeE5wQUd4RmtEUkFu?=
 =?utf-8?B?ajhEbURVZU4yYnMxN0FzbksxdkNNRzFvT1BEVVgvTDB3QlIwZkErbE1xQWUx?=
 =?utf-8?B?ak9KMUtCYWl0MHNsZlBiWmdLZnJlVXlYVWhKVld0MGtNRU1hUkxabVhjNXVo?=
 =?utf-8?B?cVFhb3NJNlNIRXJyQkVXOSt0blY4eUhOMU04MTVGSlpNQTFxK3NkNkFidUhE?=
 =?utf-8?B?SW1lbXY2cGtBZTFhYzdCYUVwWXl2Y1NQZ3BKN0dJTjdETkNIbEtHdm9iU2tk?=
 =?utf-8?B?TjZsbmk1LzVUTFFoazhzWGJ4aDM4TUdxOGN5SU51K1lSaTZDaVo3TFErNkFM?=
 =?utf-8?B?cDJ5b0VxVXpjM0hGNmlaaDdpNWZYazB2eWVBSmp0eFNSVmR5anMvaWhha21n?=
 =?utf-8?B?QTdJUitObWRJL2xUNW1OU2lQUjBCdVRONlFPZThFQ01zbGJ5dFdQeDVKWDFH?=
 =?utf-8?B?NXRtaWNTeSthUUliSHA2eStYUmFsdGdra0s1eVQ4UmZ3OXp6T3dwbWlXZDZi?=
 =?utf-8?B?VnpzbzJLWmlQLythaGFGa3A1TUNoVlBLZU5aTjh6UWppSTVqQUNrdlJXWWFC?=
 =?utf-8?B?TmhZdzQ4RVhSUHFpa2J0K2YyMHMrTGRIckVIVjE3R25IWVNNVWJRRDhyNWRP?=
 =?utf-8?B?dGR6NXBDRUlmbEhQZHhqTWs2OVdYNjFsOWtXd1NYeHdJSEp0UTYycCtIWTNx?=
 =?utf-8?B?M0xKL3JJS1psMTdBU2I3a3lmZitZeXpVMkhlZXFSZVVnWkNiNzFFRXZLclNu?=
 =?utf-8?B?aHorY0tJNWxjRHMxOUVadDJ2K2ZkRExOeC9FQUw3bm96aWxxbzBIY0NBbmRD?=
 =?utf-8?Q?wBf3tGWa43ddm6VYdtR3wiQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588281b1-525a-4e46-9566-08da024cf0d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 04:17:51.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0z4n0PCtBRgvzbnW5b1MDWqL6mOWFTD/JpPxWG9pWJt2BXm3eFoI92IszQjDPqZV2rpt29tB7nadGTXIzmTGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2022 11:28 PM, Alex Deucher via iommu wrote:
> Add preliminary documenation for AMD IOMMU.

s/documenation /documentation/

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> V2: incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>     a device) and document proper DMA API.  Also correct the fact that
>     the AMD IOMMU is not limited to managing PCI devices.
> 
>  Documentation/x86/amd-iommu.rst   | 69 +++++++++++++++++++++++++++++++
>  Documentation/x86/index.rst       |  1 +
>  Documentation/x86/intel-iommu.rst |  2 +-
>  3 files changed, 71 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/x86/amd-iommu.rst
> 
> diff --git a/Documentation/x86/amd-iommu.rst b/Documentation/x86/amd-iommu.rst
> new file mode 100644
> index 000000000000..6ecc4bc8c70d
> --- /dev/null
> +++ b/Documentation/x86/amd-iommu.rst
> @@ -0,0 +1,69 @@
> +=================
> +AMD IOMMU Support
> +=================
> +
> +The architecture spec can be obtained from the below location.
> +
> +https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
> +
> +This guide gives a quick cheat sheet for some basic understanding.
> +
> +Some Keywords
> +
> +- IVRS - I/O Virtualization Reporting Structure
> +- IVDB - I/O Virtualization Definition Block
> +- IVHD - I/O Virtualization Hardware Definition
> +- IOVA - I/O Virtual Address.
> +
> +Basic stuff
> +-----------
> +
> +ACPI enumerates and lists the different IOMMUs on the platform, and
> +device scope relationships between devices and which IOMMU controls
> +them.
> +
> +What is IVRS?
> +-------------
> +
> +The architecture defines an ACPI-compatible data structure called an I/O
> +Virtualization Reporting Structure (IVRS) that is used to convey information
> +related to I/O virtualization to system software.  The IVRS describes the
> +configuration and capabilities of the IOMMUs contained in the platform as
> +well as information about the devices that each IOMMU virtualizes.
> +
> +The IVRS provides information about the following:
> +- IOMMUs present in the platform including their capabilities and proper configuration
> +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are
> +generally exclusion ranges to be configured by system software.
> +
> +How is IOVA generated?
> +----------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to device
> +that needs to perform DMA. Once DMA is completed and mapping is no longer
> +required, driver performs dma_unmap_*() calls to unmap the region.
> +
> +Fault reporting
> +---------------
> +
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it with fault reason is printed on console.

May be just say "... and device cause it is printed on console."?

Rest looks good to me.

-Vasant

