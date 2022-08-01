Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3D586675
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiHAIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiHAIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:37:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002142F02C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI5aB7WckYsEczCjETbOXbiF8RJ/WVVe+Paqj2ajo8/xiE5dXFAlKEa43xUlDpJaMWsM+SWv/15tc6XxjPvokKfnTgMo65/Vaqtfn8eLOi0qgPSy+GbyyU0+ka74NV1PRFENdTm5ZMKAO/3dpljnHG9fhQFfINk9zDVRstvHPBTA4tspH08JbFbUZmjySHRzAwFDnP4dgSvaeB49vJs03DisfgBKyRKmf52cFeBRqvnETn3Na3e8c7wnU33Nsfw3nOdmbqIVbarnXYfnAAHF5oBeKSnzsFG6WYIjZp+0M3V1KGXfoBe8rA/LsRW88muS1kzaR4UJB2s073lIUMqVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJUFeZC1l62lVKqBERsBSxQhaTYmmjQ1CKLf1oJtnyc=;
 b=il3kZw2gFchUh97wDXuem+Mt7Qq2/UMaGAB47wSywt8rqeQhe7Wck92NPzZRCjjX38AhiFDRMqsXIoFeErOWpqgiKKNSE2CfEBvf6NCEmwe8bqwXZcsK4I/CEqf+aCQB/p9wsQrCaAnSOJAXjY5sHsnUe3IQ1S70pKr7AjyXxlCygXGHgP/FzidZcG45ILOUEHx6a8aHQ9Ox7uAVESZSh7jtEgV1FW8TkT3/keNXlasfI5K0Fg00+/BJayEMXo7eZZgteWTUFAHDlPrdi6g4jyVAypMCB+4E+s9FxWtP0fWAazft+ldMVM/nOVD8+sLXVGariW+LZrZTd+0chO5T2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJUFeZC1l62lVKqBERsBSxQhaTYmmjQ1CKLf1oJtnyc=;
 b=lfcWEU+yGKgP+RaqV2wCCH9kWyRHvPglbt/5k/6+y0WiH4RNfT2a1udTuoqiHTZC92/OKHLuDyIp/3A0X34XYp/AbsYhanN1jbDwjgjA0kM+I6W7gPIXgfvQjMFBvu9uYSMz9QOGbVSOO/RMW/06uXwUXLYyKKQ9nCl5qwn7gcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH2PR12MB3814.namprd12.prod.outlook.com (2603:10b6:610:28::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Mon, 1 Aug 2022 08:37:18 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 08:37:18 +0000
Message-ID: <c2e66e25-d1f1-5c93-9916-25ccbad89d2a@amd.com>
Date:   Mon, 1 Aug 2022 15:37:09 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iommu/amd: Fix compile warning in init code
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20220729100432.22474-1-joro@8bytes.org>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20220729100432.22474-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b19dc5-9953-478f-bbdc-08da73990b5c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ekd/aPeYjC9YTYJKKmM6QG6DJiIhKth94PrXLLzaqTzRQbUi5TGsyhsh4NmFdJRePu8Wy6WO5UELwinYRKtUI9cI/Chz4esOn3nceAR1Hi/PA+9Ai9tA3dfEKE1VajBXxJ+hk0TNUTa3dwLsc4doMHj8VrqmZMG8f1KpsSRokJW0sr00E8Rg6Tv2aJK0RhqDNFeCZraKwGEZY0hfLIb4mduz7PPAKolsvDqJfNDk8tUBk5J5QtI7IEzBqc35mDbKFtpfd9YZGqkJp/dLzqIGt2g+kNQQEV6/IgAP0rwaz77jKUwURH6yJ5c+G9cZJtTwFcJt1N52eGZ0hGVssJPs42D0MgEu56qhtwAKuxscGutxPRzkEJa3ooJ/Fh0srmBRzqudAcZUWNzRBo+HZTo/P8IG2n42qClKHW32wlST1tYHRE3Zt2rN17LM/Uj5nBSiWbutSXd3/1/idMqk6im7hLc5kJ6ZPz/XW5KgS3Da9Yra9pJcEWmCTbVKVtNSjW4OaoWGqwcgdW0I4hWkYH2A9fNBRxVLh4pP8+MV7zTHLugwrWHJ2y81GHkw+uzJRvVSSvOVNWPQ/ynfbCC4uxUfhADPy+qiuEZAYBEvdWS1v8SYHRGelshxPCX0zTV2hmCHMH+P2tS9pCX9u/Gzba7LV688HZ4A1TBQiM53jTi+jj30q2/AgwxrhPXTjEBeOCyGO0PediLY+RJOw48Vxa09jyBbrp9dAz5XGi+1aA8Yn6UZMr1wMz9Z3yzwW3zuosW7lckW+9SObO0JRl3SWi1LFt+2o0nUGzejFYcT6zuKRL0Yd61e3HrYb/L1S8duqlnBcAOX6USy9VbWLbbqnUJinQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(186003)(6916009)(54906003)(31686004)(83380400001)(2616005)(6512007)(38100700002)(26005)(5660300002)(8936002)(6486002)(478600001)(31696002)(6506007)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1V5ODVvWExIem8rUFhEMDM1eWdsQTRyYmZPZzNoMUpLY3VkcDVJUE9MS2ZU?=
 =?utf-8?B?bU5NWUFwOWQ1Y3hpN1FDeUZtNUloUWpIb083Q0UzMjVYa2dtZzRKZXcvMDBG?=
 =?utf-8?B?STdXSkt0V2FyNEFiQWdsS1Z5dmVHYzN6YjNZQ05rTndLbWlSQWEyYjZCWWRo?=
 =?utf-8?B?OVhZa2FoV3RVaEdPQkVmeFo2MHh1ZHEvTmoyMDlMVThmaDlYS2E0SFowbjZm?=
 =?utf-8?B?S3NUTXpJRm81aE1Wb1VZamdXZ1VIZkEyVXphMi9YU1R6YnFFVzFlampNeDJt?=
 =?utf-8?B?aitBbWdqTEUrbzBmMkZhbGtDdjZLUzBZbEt4b3d6SUZrcC95eDdSZXo5VUs1?=
 =?utf-8?B?WUdNSUtnY2YreHQ0MHdsUGFiM05QUEFmOE01d1dac0lCSjJnZDJiSjZpVDkw?=
 =?utf-8?B?Zk05UHlvTXNySk5HSnBIeHloV20zTmUwckJpbmdsb3hYU203anVwZklaVllI?=
 =?utf-8?B?Y2tjSE9RNHJCMDFJbnkvWndvR2M0NkxUdllROTlRS0h3MWhxWE9KNUh4eVRU?=
 =?utf-8?B?ZnNwdUVERkxMNlBqMW41eW1Nc1ZjU0J2TThXaCtCemNhdGQ5a0RGVnlZbGRj?=
 =?utf-8?B?TURZVGFOU28wc0VGQ3hpa2Q2a1pjQkViVHp5VTBVOTR0bWN6RHlhRE45eEV3?=
 =?utf-8?B?NGJSOTdpSk9KKzJtNWVWN1BhaFEwckhZMFkrSFlHNkVQUmE2VXN2cklaN2dG?=
 =?utf-8?B?eEg2MUF0NlZqMDhLZWhYRm0zUGFYSkFPWDNYZW5LQVc3NWhLMWdhK1B1MGV5?=
 =?utf-8?B?bUZkd1NNTXR4MDI4cUdTY0xXOXpNRDVuOTI2QStFeU5oV2VyVHBTd2hXaWNl?=
 =?utf-8?B?MW1rbkJLWncra1pYQW9iSVRvMzY2ejA3aW1qTnpHVXozeUhNVUdZNTN4YmN4?=
 =?utf-8?B?bVFQWHVsSXg4SlB4VUNDWi92Y0QvRkNEWStmenh3em9jZFRGT3Z4QzA3UXhi?=
 =?utf-8?B?TWRWYWgwQ0hGYnNjTFpwclJYRnJBS1R6cC9ma1J6TUNTRVVraFZyU2taZERl?=
 =?utf-8?B?QjNpUWZFL3A0SlBsek1qbll6OHhKU2pwN3EzWnVFaldYdys5OFZaWEU2Qmpl?=
 =?utf-8?B?aHlPUGdIQ1JNQ1BsNUdjbHRLOXBQSityQUZvVjhVQ1lWZ3BpcDlTRlBiUXlW?=
 =?utf-8?B?am5tSEY3V2UyeDI4ckF0YThhaHpRMG9ON21uaTdRL0Z5Q0RLUUtTdmVkZ1g2?=
 =?utf-8?B?WVVJZzRrMitnQzlLQlZnSDFoOVpoRXVsVkd4UVhzRm9XUGxsQXV4YXhoK0pl?=
 =?utf-8?B?dFJvM2xKemx3dkZuOGRSV1QyTmpXN0dnNEdUL3I3VjFZYmpYZkxTN05RWUto?=
 =?utf-8?B?RGRqUTZFSkZDUWd5TTJVVkg0WVhMK01CMjFqVW1uV082Q3hyTGVESXdLZElx?=
 =?utf-8?B?SXIxRk9YTHN3VVZRY05WYUUranR3dzVmYWkvZmgwMXV2YnovTW1zcGhObXd5?=
 =?utf-8?B?VGZEOHlIR3F1VDZWUlo2QjRjRHJJNjdCNjZOaFF6Vko1OWdQbENXZnFRc0Jw?=
 =?utf-8?B?QUlIWVR1UUs4QzRjQkhRQ1dGVklJQitwRVBDR201RkZySWEwdkVlTXgvOFNX?=
 =?utf-8?B?bGxuVzRGeWJBamJmWSs1VW9mZHg1ZUMrVWV0VjlyVjA4c2Z6TmdmeUU0Vlpx?=
 =?utf-8?B?VmlQejZYby9UcEZZT1gxL0xHOVpuU3dDbDBKSERWR2oyR3ZaRVZSNWw5ejVs?=
 =?utf-8?B?d3ZUcUd4QllFelErZlRTNkRvQ3B5UDVWWk9FM2h0cEY5RUtsV1R6clJnU0J6?=
 =?utf-8?B?VmxlcC9zdXlsUHZDVC9rd3BBeGxWYUwyeGRDTUp0YjZtR2J5UU9oTDFRL01D?=
 =?utf-8?B?ajcrb0hRMzFBSWlGQmhWaElzck5jT2xoZlFnUGxRZ0RWdHFHOXkxamN6Rks4?=
 =?utf-8?B?dTNNdkZBNWRaK0ZRVnFyVUlMUE5HcmRsa0gyUS9nMUcrMFNYWHYzWHVlVldT?=
 =?utf-8?B?ZStGdmIrWHhwR2IycmhoRk42aUlzS2o5V0ZEd3RyMEM5VXpKWWV4dDdBMFFh?=
 =?utf-8?B?S2FBME0zenlJTEJzaTdpSXQvNUdXU014bjNpZktET0d2bHpRSm9uL0Zpc2V3?=
 =?utf-8?B?TEVPRjRhWWd3aXloR3Jzajd6OVlqbWxVQ0ZYMzlYTlkvNHhNL0RucGNTZkgz?=
 =?utf-8?Q?ZRZO8nlKjlIgQM3jLAVxXj1AA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b19dc5-9953-478f-bbdc-08da73990b5c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 08:37:18.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZ0Nu4OMh5lO+Gx0NK0xyBYv0CPxFqKhf4dputLV4pNg1lpchstQFb64BW/oIHStNi9f6eqSRzCzQRraHI4OtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3814
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2022 5:04 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent commit introduced these compile warnings:
> 
>    CC      drivers/iommu/amd/init.o
> drivers/iommu/amd/init.c:938:12: error: ‘iommu_init_ga_log’ defined but not used [-Werror=unused-function]
>    938 | static int iommu_init_ga_log(struct amd_iommu *iommu)
>        |            ^~~~~~~~~~~~~~~~~
> drivers/iommu/amd/init.c:902:12: error: ‘iommu_ga_log_enable’ defined but not used [-Werror=unused-function]
>    902 | static int iommu_ga_log_enable(struct amd_iommu *iommu)
>        |            ^~~~~~~~~~~~~~~~~~~
> 
> The warnings appear because both functions are defined when IRQ
> remapping is not enabled, but only used when IRQ remapping is enabled.
> 
> Fix it by only defining the functions when IRQ remapping is enabled.
> 
> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Ah... sorry. I missed this part.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thank you,
Suravee
