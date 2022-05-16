Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032B528429
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiEPM2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiEPM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:28:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC712ED46
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/ZtVInlwMDVJzf4v1xsh8iDxRvVHnZ+o0uOBZ078jStODvtr7UqQS0YiDsCLt4dFa/gm8ZjK+dwl8C1qSP7+2yc4lKVJHiNSZJxxXGc0KVvgtXpClvew8JaiiPNHsKJ2dPB9MGyNQBJo9SoXZ1GVxc7KRE6hoO39ZJ10/TFVWsgiqPZk/OM6HrtohV4J1y81vRGTYnbRwEySbRUMFIazayioDPgsTS2rcNjDRehEdDWnZ8SQnYR40peVHrCQgMPSuHXXp8VnR2ECHe9aHvsRqL9eYg4bX/Ux9fErv0+JjzPirMDTX+sE1vGUyysRri1zuJYG31ry2jqopokkjhugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CueIAz0Nn1b/IT5I8S4eiY9Ix88WilsNklAjjBW7Vds=;
 b=I1vaRZEn5q8VgKMlsIpxxGRuL+vkH6jfKl7fLkZrKzSXTnzskoEBW14ueq280dNtXkGOaorilKL+2tcOCEDnudS+oW3JqdyOe9GFkyRp5KGKVUvlvzp4wiJ3A4uw63HTvzLf0haP2t2jYOG02QVjkeBTRhd6o865zyksdvgOk/HgQ4J7GibhREqs6bp1s/51bAvrBH91y0EshimfHSTQEAF93rj1kKPMGHSnrusdJCAC79H8emeCKbq3UcuVX/03RVVItN0X6xtfICAoohNu1LQYDuVLql4eXD2cs007ccJ9LMW1xr1pyr8CG76LAeSPFhah+IzK8szYWHUw1+W2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CueIAz0Nn1b/IT5I8S4eiY9Ix88WilsNklAjjBW7Vds=;
 b=CkHT+BS3/c8guPNLrbxw5IJOpoiN5zkVOfgrjVcSUr8s+H/Wv00HTGAIvRPrqsydbOgyrZRqegBz4rhGaN1Vqz0omci/WBn6Ze1hY60+ts7lbaaEVM9JZ9Pqjx8WvQJm+UX6pkA6q0a9AF0H5XxhdJKBk3Ef9im533W+2f8g0y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Mon, 16 May 2022 12:27:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::9894:c8:c612:ba6b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::9894:c8:c612:ba6b%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 12:27:58 +0000
Message-ID: <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
Date:   Mon, 16 May 2022 19:27:51 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
In-Reply-To: <Yn5YIfzmerwAM30M@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b4da5bb-5f8b-4809-44bb-08da37378281
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031345A7F13DB125BA88E07F3CF9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZlaqtcVACO4XtTgfaIsuDdOKHkdnA5w7APStjP6wYzAEFGzKZTpaIgs5IAWS9LiHeqNFpBTOVoSg6QKa5eOhnzGhkH6KcXGBA+ICa4Eby1HH81MJuyRP7eKIrbL402yZAIEas3gBW8iXtHIPg/GWBx5PX3nZPm0PiUQeYE65ob22wzrsRRrn3t4QaNw6Zt0txrymPMdPKIOdMrdzO2IyYOfJ868+kWzhvpJhxiq41b4YUs3J/ggJt56utM/1KfU9s43HsPXxAOSfNBm8teKRsOFWxvWLPL//xTBCaTl+pKWPgZWZcUoNq+9Eu4L6O2ureZ0DSlfD1zb0xGGOuIQVbFnRFNmWq20DRSK5JoyoiDRvTDIv/cNk+rbq3/5oE3H7ZgC/BykqQlOAIw9WutaMvgiq2bmyZPmikpyviL5GU9E6oRd4v5aR+LXv3FR/YY7ng/YL935nvOH287Z/rpcALMJKHX1yxk3N5SGpDXlcR4GJ7IMEL07gM0gefQazgYIXpk9VfgKz51Vz9MYMlaBI5GTq/Zn4HRVKt5NYlYkweflY/T5WAKiSmqOIqc+ig5pM9dpm/G6tpJrUpTReQ09WP9pPC9CHzCXD2+84EIh7fiKP6CATN8ksHXsutNZsLDgqzLvnFFiOtaVqkz9lvAlZHLZttwF7K8Qc3cpXzGWimllRW9xZtv1UmbHW1KjaYKP6ViN7EHI88MY0yLMNZiARUpxdIDZMiRY6EOTbgZdITcAiwvqxF7kq1ZMQxVuL3jvgFtSIBNnoEcBsJ06mD39kpl+c+t53W4P/uSXRnDbl//2cJzoSnNFBaBrfIsjSwtpHAb5Kjwmtq8xPKdRcNic8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(2906002)(44832011)(966005)(6916009)(2616005)(186003)(83380400001)(6666004)(53546011)(6512007)(66476007)(66946007)(66556008)(508600001)(8936002)(6486002)(31696002)(86362001)(4326008)(31686004)(36756003)(38100700002)(8676002)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBXaVI4YWM5anJyOGpQaGE5WGFsajZsZy9paC9hRlpCK0FEbVlhSHcyOGhn?=
 =?utf-8?B?QU56bG8ycU1HNk1DVzJNNTBQOU96N0VTMFhPOXdpRmlOdTBSOXJBeXlrNldS?=
 =?utf-8?B?UUJ5Z05DTXVFTHB0TDkydDF3WmpsOE9BU1BrYThBbWhXNm5BdXdKMDFSSnU3?=
 =?utf-8?B?TXZST3FMdFQ3Zy9adDFOK3Z1STY1Tk9nSHZMMGsyQnQ0bGd6cjlPUVlUNG5O?=
 =?utf-8?B?VUIzbTJ1Y3dzd3d4SWhNeDVNalRZWnRQczhIdGdqUGhicFNQMStieUg5U0Mz?=
 =?utf-8?B?U25MdFU0UmQrQUl5ZVZ1WkcwQVdub0Fqd1Z1RS9zd3ZCVm1tSXgzamR2d0h3?=
 =?utf-8?B?aHhwMkZLQ2s3NVZPV2tLV1pKOHptVUQwajhLOHorYzUxQkM3aXZJd0tuOHg4?=
 =?utf-8?B?OHhJVi9jM0xpWEFNQjFlM0NmMnFCYWdnb2V6VDRTTVpkOHBybmEweFdOYkJP?=
 =?utf-8?B?Y3pWTjdTSDN4T2ZWbXpqVG5MTGdVdTFsNnZmVlZUcGU2dXFyY29IcUk4Zk9i?=
 =?utf-8?B?cTIyaGZrUXJkTEhPOXhWdDZFcTNPVVBINlNlaDFBOXdNaE9MaVlYemUzREZJ?=
 =?utf-8?B?MmxJamNGSDlCbDNNVldlbU8xcE1YRjAwKzNlbG1RNU1BZDJ5bGo3dE0ya0k1?=
 =?utf-8?B?aS9ndTN1SE1TT2RJRHBsYXpNUXptbmRxWXpjSlV5Z01EaE91Q1l6U2lKU1Zl?=
 =?utf-8?B?b0c1bWEvUmhLNXppS3d6OGgxT1Q4eUcvbE41TzYzQlVwSVJwVDdoenVVSW5B?=
 =?utf-8?B?ZEF5RVdBNTN2L282MnNzWG91YjcxelFGZUVnM2RWTWVoemE1OXJJaGJnSVZk?=
 =?utf-8?B?eWJGcm5yRHBORnZMNVlJRi9tc0FRbU4zZDBsL21hRjdNeWFWcXZsWmhyVXJx?=
 =?utf-8?B?Q0FUdk8vVkNQU3BoZzNRVmxRazBJNmtNc3FwVTJ5UnNvZzVEUERxRWpIcXJ0?=
 =?utf-8?B?QkxIbmlhVHZaeGVFY3hldldxMm9tVnk1cjV4dzJNT2JBdHljV2l2UlNMdVUr?=
 =?utf-8?B?U1VuSmtscWZPUFkwVnl5WHlFKzZhQkgvcU9QQ2U2RjdwK25LQlM5VjRjZUsz?=
 =?utf-8?B?YndFRUdNejNnSTVpbnlpN0hXV3F2WEVaYXZjcFQyOWpTZVhKVlZTNWRWMmg2?=
 =?utf-8?B?VjRwSi9qVVkyTkNIMGNrYkJGL1hickdPNXBEaW9UTUZ4dFFwcHQxNjZnajRt?=
 =?utf-8?B?Y0JBS2NqcVE2ZDBUczhNMkVzM2N6OUZqUXJQc0dqU3NOeEVyUXZxYktKZTdN?=
 =?utf-8?B?eEVVeE5nZmhiZTlnK1hSMEJzRHZQaVZ5UUlqTzBlRzAvVjkvNUVId3hNWmJr?=
 =?utf-8?B?MnpaTlRZVlErTExYT1lPZUpkMXErdEd6amNJaHhRSEV1UFZnS01QNkJNT0Zk?=
 =?utf-8?B?N1kwUnU2RXRwbU15MVpuT1Fia29yQ04wNVR5N1kwR295WFF1MVdMc2l4MUJ5?=
 =?utf-8?B?dHFSS0RqSGxYWTRUZ3c1TTV6blVVWmhVVjVOOVl2THI2b0J5ajV0UTZOS1NK?=
 =?utf-8?B?QjBhL2tGOHNOaDIzYzBYamVpemtZUm9pcmpsdjdMYVZ4Z2VBZ3J6dHVLQjR2?=
 =?utf-8?B?eUQrQmRsRlg1S2I3TUVXMGVaTWQ2RzVKcnRCODBaOG44b1NhaXQrNW9pYnlK?=
 =?utf-8?B?OWc2Q0l0eXVSWVYxS1ViTy9rR2VXSGY5aFltajVYYnAvV3pIZVBLU0FBZ1or?=
 =?utf-8?B?SFp2dnhmc2dHRW9qanJBV1V0S1M5UUl2VlBzZGorTE92V0w4RCthSEFFUUh2?=
 =?utf-8?B?VEdmMVh4SVRjWG05RXhSK05UM0RDZk16Y2l2RnBXTGxmT25MTmpxbjdjSklw?=
 =?utf-8?B?b2hnL1JTcWU5WGhjTzZZQUMycDNFM3ZuS2o3akhkZm81OFVaNXJBVjVMUGlq?=
 =?utf-8?B?NjFnSEV4VU1zZjh4NUkrc0NHbGJUYzhRbTV3di9KckZtMGE1b291TEFNOTcw?=
 =?utf-8?B?RGRzc0hkM3Bud3RYRzloUTFmeTBXREVPUWdBYWxRK0VTbDlGWEtaRTBiT1FD?=
 =?utf-8?B?U2VGamI3RzNURjc0M1kvVmZXVG1zUVBjcWZCMWp5M1pEUWFSOVhoaHJKMG9K?=
 =?utf-8?B?S3Q1dnJQaVp5a3BpQkNhbGZ5YzVxaTNmM2E1eTJ1SjdJbkZURUF1QUxLWWJ4?=
 =?utf-8?B?YlQ3ZTAxSFFGdCtSVjdkdFpkdkY3OHZZaEFFRk5OVElzQzYyUytNUy9admQv?=
 =?utf-8?B?WktOV3ZrN0llcGNsTHkwa3M5US9Bb2RySS9DckluZTRWK1NNNkVaUjhicFYx?=
 =?utf-8?B?Qy9GdWVDWFBxQ0txY1pXUkRaYUYreVdDMzUvNXBPMTlFeWU4ZWxFN2ppUEJm?=
 =?utf-8?B?d2VCN1hxbHV4TFhORng0N0FlV1FIWmMzdG9ZZk9FYWtRTEprbzU1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4da5bb-5f8b-4809-44bb-08da37378281
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 12:27:58.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWZ0fYpY5Klo5RWztONGyzlO4lQhIieqkW0/wvhgR9ACn5HUsrjCmyw7bTND/bZqidv5wj5dH98fAE+11genCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg,

On 5/13/22 8:07 PM, Joerg Roedel wrote:
> On Mon, May 09, 2022 at 02:48:15AM -0500, Suravee Suthikulpanit wrote:
>> On AMD system with SNP enabled, IOMMU hardware checks the host translation
>> valid (TV) and guest translation valid (GV) bits in the device
>> table entry (DTE) before accessing the corresponded page tables.
>>
>> However, current IOMMU driver sets the TV bit for all devices
>> regardless of whether the host page table is in used.
>> This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
>> do not the host page table root pointer set up.
> 
> Hmm, this sound weird. In the early AMD IOMMUs it was recommended to set
> TV=1 and V=1 and the rest to 0 to block all DMA from a device.
>
> I wonder how this triggers ILLEGAL_DEV_TABLE_ENTRY errors now. It is
> (was?) legal to set V=1 TV=1, mode=0 and leave the page-table empty.

Due to the new restriction (please see the IOMMU spec Rev 3.06-PUB - Apr 2021
https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf) where the use of
DTE[Mode]=0 is not supported on systems that are SNP-enabled (i.e. EFR[SNPSup]=1),
the IOMMU HW looks at the DTE[TV] bit to determine if it needs to handle the v1 page table.
When the HW encounters DTE entry with TV=1, V=1, Mode=0, it would generate
ILLEGAL_DEV_TABLE_ENTRY event.

Note: I am following up with HW folks for the updated document for this
specific detail.

Therefore, we need to modify IOMMU driver as following:

- For non-DMA devices (e.g. the IOAPIC devices), we need to
modify IOMMU driver to default to DTE[TV]=0. For Linux, this is equivalent
to DTE with domain ID 0.

- I am still trying to see what is the best way to force Linux to not allow
Mode=0 (i.e. iommu=pt mode). Any thoughts?

- Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
will no longer be supported on system w/ SNPSup=1. Any thoughts?

> When then IW=0 and IR=0, DMA is blocked. From what I remember this is a
> valid setting in a DTE.

Correct.

> Do you have an example DTE which triggers this error message?

This is specifically from the device representing an IOAPIC.

[  +0.000108] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=c0:00.1 pasid=0x00000 
address=0xfffffffdf8140000 flags=0x0008]
[  +0.000011] AMD-Vi: DTE[0]: 0000000000000003
[  +0.000003] AMD-Vi: DTE[1]: 0000000000000000
[  +0.000002] AMD-Vi: DTE[2]: 2008000100258013
[  +0.000001] AMD-Vi: DTE[3]: 0000000000000000

Best Regards,
Suravee
