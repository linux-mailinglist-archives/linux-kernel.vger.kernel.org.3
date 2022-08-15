Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81551592F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiHOMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiHOMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:53:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E917A91
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXognPXFBzYDB4LpHP8pSSD65VzXFFNptIz7QVXZKkAXFzIq2o+FfcIqppDFKh1MRXtZEsJXUXdiCLxehQ4v9NA1SxzvqUP+qiCp4OOoBelCfIkwNw5Du5Ib/Jh2Zf4BWQy5BhTm7Oy/OEWpXWuTl/WT558nJSeI+vrP5fcSA+oG8yIoVPFNLzyWkEdgk+y8cobo7Aj0QgN13szVTQ/57b6NwrgLsjpE0xTH1trUHwkeHvR0mqxcx+B+ntm2yzRnG7UVA/Vf3me4e8neseb6EQcubgQwewywk9xJJO86F+PHdsnd9/RyDpAshiIAUfX4ESISMU4WJLcYShjMRYOKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yasx0+etA3AxfzUKmBP8pXcD4JD8sywF5OGlR+ATofo=;
 b=mndrsCQ8dMpTvNheAVneq3G9HxGzAtGIsKhMMU9i355H5Fn7ohBqNNQ2hLZz+n86gMp35nDcmlz9151mqWhoszhPV3xpi3czNT17Yjhc1cAVGaXTY8jXUPKs9gF8fACRhbf74gvMpRhyD4bgDc1A8d1VtTcH6Q7ruhW34fi+SSSQhgRzWgKQkVCX9R9u3sCcu63qyOfKreQSsWWcCUKzQ7z1Cns6N5LCFSO7wmP6KitdZcOZVnwhbAX3QtRsWJFI0mnmjJ9moelaA4poxKxMwjnwXTH8uKAjLCzii5Zb0CU7aWVwrOXPCYioahykxPFvl1qsrPGQwfVV+BPzE6pC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yasx0+etA3AxfzUKmBP8pXcD4JD8sywF5OGlR+ATofo=;
 b=I7rHX5j9cu1whXnbsfHv3E+Mr7FcHviEfA7X3w6T+oEmQG6VM5KXb1hLvSfa3ExdFxUgq4cdBz4C/p3gZL1pms3yMZeOzBnrRDzCONRIa4YkMEMxJSRCRAfFq3HqqWwIhePqHGfdcJDcPNeVGZ3Hosz+CnU4PPhWYyIfwcWH9ky02/HIpIOH4NKax3aScBEuJTe5b56qd9eOxmg59baVmK2HcurK/VGIP6ZcK057QnqhagI7aNlEy+cviSqSVbEnpKVFjIJryTAPN8fhHiuhUL0G782k87U+mYoiR17Vo3CkucmVqK3lEPSrsm5mlzr+uKlniycnzJZgjowIb88r/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Mon, 15 Aug 2022 12:53:15 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0%9]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 12:53:15 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/12] arch: mm: rename FORCE_MAX_ZONEORDER to
 ARCH_FORCE_MAX_ORDER
Date:   Mon, 15 Aug 2022 08:53:12 -0400
X-Mailer: MailMate (1.14r5907)
Message-ID: <1451B225-DCD0-4F3C-9B53-6A96EFC230B9@nvidia.com>
In-Reply-To: <YvfE9JT5XEPDUcAg@kernel.org>
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-2-zi.yan@sent.com> <YvfE9JT5XEPDUcAg@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_A0E4DDA2-671E-4512-8FF5-005A5ED97913_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4884d550-5db5-4b7a-52da-08da7ebd1e50
X-MS-TrafficTypeDiagnostic: MN2PR12MB2989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RL3FUGkWtg+ifydR6bK30p8D3vxYx+U9gbl+UWwe5Eb1wzGvZooGyU/iYS2C7TYRQwof7+ObR/RxR+dSE/YgvaAnsaDIz9PU6az0FA9EVHU2VyiioR+rARoJSS3UHCOZ2C3ly6fSiXkFmIIvAH/KDvebgdbIB79FCDfXHp+BxoJKjnb2oqqZAzHXun4zV+zVP60BS1zyoKNTQNikZFsAvqkGTvT5Z/dOpl8cwfbG9YgsfySX62ph52RAC26ZEAhG+QBo5VTauex7cx+ZhTbt0TGGIbydCJpfuJWrEmJuhNmbzvLW7/KULkvOSHVlo0StfWvNkQgBCVvLaZIjizM0sY6bh+drp+bU0MGT9jmQbiAKfySuPNKFgr3hRRA7jvb9hhHDS2vk85S/KMtl8YMlHTIgQptEgcxiDJqR8kwg4nMNx5Ct/0nhLHDcVg/VmAX1nopj/FdH4RvoHI3E7MCHXG3063Hu9SB4A8IhspIW2b1mBSrnzxHtHR4kOX5tXkzHkbul9wM0RbpzLkGwzRNHkIeMV0aQ6vkcAqtcMwy1ZPGiIXUkiM5anM0IS7f/znNz4c1SxS+JCJmREWh7u7987+3jRIGKWE6CsPbRdOOFoJqju4sZd1fMygRlxcw4rn0FDJQC4+ABBTpp/Yb1eXiAIw8ci2ymI9gWfqYvcZSdur+PNDiT01HKgMFsuCSmqorN3nxrX+Fx+MrLGNAD+5b29vOVDZkRv53lI5i0g0ywdKD+j7Mf4LU0IQK6LHSuABAXo9M1PlWjeHL1j+Y7L3RyHQtJ3ntwx98LfFOFa8Bsuucfukv1lbTTydXsTBVjqH6G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(478600001)(83380400001)(36756003)(2616005)(5660300002)(30864003)(66556008)(186003)(86362001)(38100700002)(8936002)(66946007)(235185007)(7416002)(2906002)(4326008)(8676002)(33656002)(66476007)(41300700001)(6666004)(54906003)(53546011)(6506007)(6486002)(26005)(6916009)(316002)(6512007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nA/JjsSYTeY0gkqk1BL855d6mgq+6B4EXhB30VSF3NTrS78MZrklvyWYl2n0?=
 =?us-ascii?Q?aA+/Bl/LzZnDx0VZnBwv0t2ZxKo/MiU+fdQDfXUA6dhEKVSvdyGmsLbjZKow?=
 =?us-ascii?Q?ulv6WMp7viqtuGdqKdd3z+y5aceCXxoguf31i8xZZ564sLK+L+CKiRJEyTe0?=
 =?us-ascii?Q?em5+5xQkqKe2qxUEYuVGoYsZ0MnkdB/+4fsFPa2Sw780hNmLJaAC/4F9bqji?=
 =?us-ascii?Q?ghvsg1rs5xzRUq846uFbs0TdM/M9bPg7vVasq0hLrahwb4NCIGnM4dHeVlN6?=
 =?us-ascii?Q?NgtZmShgf6dcB4k6smMUlbg3W6wBge9EZ54pyPVe9WaNMBRSgP/9easM/3Jr?=
 =?us-ascii?Q?JBRUY4x4apMzFxzVxOx2FHe6HnGdgEMlRfXA2lFhCSbsnXDCV/ma7aN5Xt9D?=
 =?us-ascii?Q?IvkdKkdYmRgMDimU8aK3Z5kKHiKyq1EKEcZ/cbIcklyiTvzDLpFfZP0mg0I3?=
 =?us-ascii?Q?Rc44hVZX9PeWRhUpCibVRLLLlPbgdGph26HrkALRrAPVCAmez0Nd7Q5f6JWi?=
 =?us-ascii?Q?848qevwDEkJ8mlTQ+qM9vcr0OsWpDDkHDbGm0JXLgmO4hW4BHSqXD4KRy/cy?=
 =?us-ascii?Q?wuCQqskD2QXibnF4P4V6hVvj3koPDBunxpDTQrt5P7nuY1jn9vDsu968I3Cs?=
 =?us-ascii?Q?5qhi1+ypLW6Ae/E198oX4O+DZPmVIzWnZ9xqjHKQzYixpqIPBER/RYfLTGYu?=
 =?us-ascii?Q?PW7wO/Cex21A7c/jaAuuOQxLdg2TwD3xX2aC0Xr5JWSOFcM/AO6kGOYJc0wo?=
 =?us-ascii?Q?AQlGO4o95h8pcbYqAotnm6cTMPJV/w4AUDbAs89qaMr+TFZQyH7AwwmshpSi?=
 =?us-ascii?Q?WyBeIF2NPhad6nCE055zp2Avq6023RI/ssDWIBRvJ5eCwjkx0JyCuVkDLQh7?=
 =?us-ascii?Q?DPdLgCbaaXxUPI8rOsrizj19lGZV7w5JA6D7FFMhClLMk8f6sIAKstc1dDaB?=
 =?us-ascii?Q?KbHxrVWf/jonFHF5WoBzbC3/LX75zOUYXr3tq/XLPb+W/YHJX8ka94Fld7v4?=
 =?us-ascii?Q?V6uyd3gscTXQ/j0rUGjFLtsUEc1GxtM+hOPXm5VjJDwlVCBDdRKFiQCDFWUW?=
 =?us-ascii?Q?Ku3TdTJYGhm/Voaa5JE42AukB5FsDSe0kGMDnSTD8uhWDkXdURU/yBnJm+Wr?=
 =?us-ascii?Q?yfKD4xL56C+aApYHtlTDdgg4H88Rn5JMawLBof5bAs3GNL13X4fDBW/7Guio?=
 =?us-ascii?Q?UAPeSgc+5woNkELzQY6WEX51+QoU9CtZT2tqd5qkCvJKThPI6sYCsUYnXbxg?=
 =?us-ascii?Q?LHnOF3prWbh/tFiCKvhv6+HjZwrm0kogK5WTMTrSSrA0lElOFpg/TAF4EYZv?=
 =?us-ascii?Q?r7sjMuqAQZvgtENKqMGG4IjFK6fEE1cNnK3kSpF3ZkEhfh0rE2Gb49CQsFZw?=
 =?us-ascii?Q?pNwku9wFWWqr83HomPrXE62IcsJM9+FnEv3qDsBv2M9JezStyzjEEUaXDJCr?=
 =?us-ascii?Q?TzTeWen/M0/YanhysfZ1hpMXSo0xaN4n+o66M99URMTPqRuZMrVCnssEtzZ5?=
 =?us-ascii?Q?q5QGPncky7oCdEKzmdvBZttumSKreXcylz55+N8zOqsNBqRlIXfSKyMe9GTE?=
 =?us-ascii?Q?qWvRcu1J+S8MKf2J8neMF2xFz3PXYFCKvd3sSJAJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4884d550-5db5-4b7a-52da-08da7ebd1e50
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 12:53:15.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lHVS+/oUWgNwNQopkHxjWLN8AOzAi0f15AlIrq/Htvr7+q1ShmW7rsfQB1HAJk7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A0E4DDA2-671E-4512-8FF5-005A5ED97913_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Aug 2022, at 11:36, Mike Rapoport wrote:

> On Thu, Aug 11, 2022 at 07:16:32PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> This Kconfig option is used by individual arch to set its desired
>> MAX_ORDER. Rename it to reflect its actual use.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-oxnas@groups.io
>> Cc: linux-csky@vger.kernel.org
>> Cc: linux-ia64@vger.kernel.org
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: linux-mips@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux-xtensa@linux-xtensa.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/arc/Kconfig                             | 2 +-
>>  arch/arm/Kconfig                             | 2 +-
>>  arch/arm/configs/imx_v6_v7_defconfig         | 2 +-
>>  arch/arm/configs/milbeaut_m10v_defconfig     | 2 +-
>>  arch/arm/configs/oxnas_v6_defconfig          | 2 +-
>>  arch/arm/configs/sama7_defconfig             | 2 +-
>>  arch/arm64/Kconfig                           | 2 +-
>>  arch/csky/Kconfig                            | 2 +-
>>  arch/ia64/Kconfig                            | 2 +-
>>  arch/ia64/include/asm/sparsemem.h            | 6 +++---
>>  arch/m68k/Kconfig.cpu                        | 2 +-
>>  arch/mips/Kconfig                            | 2 +-
>>  arch/nios2/Kconfig                           | 2 +-
>>  arch/powerpc/Kconfig                         | 2 +-
>>  arch/powerpc/configs/85xx/ge_imp3a_defconfig | 2 +-
>>  arch/powerpc/configs/fsl-emb-nonhw.config    | 2 +-
>>  arch/sh/configs/ecovec24_defconfig           | 2 +-
>>  arch/sh/mm/Kconfig                           | 2 +-
>>  arch/sparc/Kconfig                           | 2 +-
>>  arch/xtensa/Kconfig                          | 2 +-
>>  include/linux/mmzone.h                       | 4 ++--
>>  21 files changed, 24 insertions(+), 24 deletions(-)
>
> This misses arch/loongarch.

Will add it.

>
> Other than that I think its a good cleanup regardless of the rest of th=
e
> series.
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks. I will send this out separately.

>
>>
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index 9e3653253ef2..d9a13ccf89a3 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -554,7 +554,7 @@ config ARC_BUILTIN_DTB_NAME
>>
>>  endmenu	 # "ARC Architecture Configuration"
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	default "12" if ARC_HUGEPAGE_16M
>>  	default "11"
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 87badeae3181..e6c8ee56ac52 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1434,7 +1434,7 @@ config ARM_MODULE_PLTS
>>  	  Disabling this is usually safe for small single-platform
>>  	  configurations. If unsure, say y.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	default "12" if SOC_AM33XX
>>  	default "9" if SA1111
>> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/i=
mx_v6_v7_defconfig
>> index 01012537a9b9..fb283059daa0 100644
>> --- a/arch/arm/configs/imx_v6_v7_defconfig
>> +++ b/arch/arm/configs/imx_v6_v7_defconfig
>> @@ -31,7 +31,7 @@ CONFIG_SOC_VF610=3Dy
>>  CONFIG_SMP=3Dy
>>  CONFIG_ARM_PSCI=3Dy
>>  CONFIG_HIGHMEM=3Dy
>> -CONFIG_FORCE_MAX_ZONEORDER=3D14
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D14
>>  CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
>>  CONFIG_KEXEC=3Dy
>>  CONFIG_CPU_FREQ=3Dy
>> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/confi=
gs/milbeaut_m10v_defconfig
>> index 58810e98de3d..8620061e19a8 100644
>> --- a/arch/arm/configs/milbeaut_m10v_defconfig
>> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
>> @@ -26,7 +26,7 @@ CONFIG_THUMB2_KERNEL=3Dy
>>  # CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
>>  # CONFIG_ARM_PATCH_IDIV is not set
>>  CONFIG_HIGHMEM=3Dy
>> -CONFIG_FORCE_MAX_ZONEORDER=3D12
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D12
>>  CONFIG_SECCOMP=3Dy
>>  CONFIG_KEXEC=3Dy
>>  CONFIG_EFI=3Dy
>> diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/ox=
nas_v6_defconfig
>> index 600f78b363dd..5c163a9d1429 100644
>> --- a/arch/arm/configs/oxnas_v6_defconfig
>> +++ b/arch/arm/configs/oxnas_v6_defconfig
>> @@ -12,7 +12,7 @@ CONFIG_ARCH_OXNAS=3Dy
>>  CONFIG_MACH_OX820=3Dy
>>  CONFIG_SMP=3Dy
>>  CONFIG_NR_CPUS=3D16
>> -CONFIG_FORCE_MAX_ZONEORDER=3D12
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D12
>>  CONFIG_SECCOMP=3Dy
>>  CONFIG_ARM_APPENDED_DTB=3Dy
>>  CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
>> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7=
_defconfig
>> index 0384030d8b25..8b2cf6ddd568 100644
>> --- a/arch/arm/configs/sama7_defconfig
>> +++ b/arch/arm/configs/sama7_defconfig
>> @@ -19,7 +19,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=3Dy
>>  # CONFIG_CACHE_L2X0 is not set
>>  # CONFIG_ARM_PATCH_IDIV is not set
>>  # CONFIG_CPU_SW_DOMAIN_PAN is not set
>> -CONFIG_FORCE_MAX_ZONEORDER=3D15
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D15
>>  CONFIG_UACCESS_WITH_MEMCPY=3Dy
>>  # CONFIG_ATAGS is not set
>>  CONFIG_CMDLINE=3D"console=3DttyS0,115200 earlyprintk ignore_loglevel"=

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 571cc234d0b3..c6fcd8746f60 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1401,7 +1401,7 @@ config XEN
>>  	help
>>  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM6=
4.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int
>>  	default "14" if ARM64_64K_PAGES
>>  	default "12" if ARM64_16K_PAGES
>> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
>> index 3cbc2dc62baf..adee6ab36862 100644
>> --- a/arch/csky/Kconfig
>> +++ b/arch/csky/Kconfig
>> @@ -332,7 +332,7 @@ config HIGHMEM
>>  	select KMAP_LOCAL
>>  	default y
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	default "11"
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index 26ac8ea15a9e..c6e06cdc738f 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -200,7 +200,7 @@ config IA64_CYCLONE
>>  	  Say Y here to enable support for IBM EXA Cyclone time source.
>>  	  If you're unsure, answer N.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "MAX_ORDER (11 - 17)"  if !HUGETLB_PAGE
>>  	range 11 17  if !HUGETLB_PAGE
>>  	default "17" if HUGETLB_PAGE
>> diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm=
/sparsemem.h
>> index 42ed5248fae9..84e8ce387b69 100644
>> --- a/arch/ia64/include/asm/sparsemem.h
>> +++ b/arch/ia64/include/asm/sparsemem.h
>> @@ -11,10 +11,10 @@
>>
>>  #define SECTION_SIZE_BITS	(30)
>>  #define MAX_PHYSMEM_BITS	(50)
>> -#ifdef CONFIG_FORCE_MAX_ZONEORDER
>> -#if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BIT=
S)
>> +#ifdef CONFIG_ARCH_FORCE_MAX_ORDER
>> +#if ((CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BI=
TS)
>>  #undef SECTION_SIZE_BITS
>> -#define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIF=
T)
>> +#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHI=
FT)
>>  #endif
>>  #endif
>>
>> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
>> index e0e9e31339c1..3b2f39508524 100644
>> --- a/arch/m68k/Kconfig.cpu
>> +++ b/arch/m68k/Kconfig.cpu
>> @@ -399,7 +399,7 @@ config SINGLE_MEMORY_CHUNK
>>  	  order" to save memory that could be wasted for unused memory map.
>>  	  Say N if not sure.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order" if ADVANCED
>>  	depends on !SINGLE_MEMORY_CHUNK
>>  	default "11"
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index ec21f8999249..70d28976a40d 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -2140,7 +2140,7 @@ config PAGE_SIZE_64KB
>>
>>  endchoice
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
>>  	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
>> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
>> index 4167f1eb4cd8..a582f72104f3 100644
>> --- a/arch/nios2/Kconfig
>> +++ b/arch/nios2/Kconfig
>> @@ -44,7 +44,7 @@ menu "Kernel features"
>>
>>  source "kernel/Kconfig.hz"
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	range 9 20
>>  	default "11"
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 4c466acdc70d..39d71d7701bd 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -845,7 +845,7 @@ config DATA_SHIFT
>>  	  in that case. If PIN_TLB is selected, it must be aligned to 8M as
>>  	  8M pages will be pinned.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	range 8 9 if PPC64 && PPC_64K_PAGES
>>  	default "9" if PPC64 && PPC_64K_PAGES
>> diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/power=
pc/configs/85xx/ge_imp3a_defconfig
>> index f29c166998af..e7672c186325 100644
>> --- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
>> +++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
>> @@ -30,7 +30,7 @@ CONFIG_PREEMPT=3Dy
>>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>>  CONFIG_BINFMT_MISC=3Dm
>>  CONFIG_MATH_EMULATION=3Dy
>> -CONFIG_FORCE_MAX_ZONEORDER=3D17
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D17
>>  CONFIG_PCI=3Dy
>>  CONFIG_PCIEPORTBUS=3Dy
>>  CONFIG_PCI_MSI=3Dy
>> diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/=
configs/fsl-emb-nonhw.config
>> index f14c6dbd7346..ab8a8c4530d9 100644
>> --- a/arch/powerpc/configs/fsl-emb-nonhw.config
>> +++ b/arch/powerpc/configs/fsl-emb-nonhw.config
>> @@ -41,7 +41,7 @@ CONFIG_FIXED_PHY=3Dy
>>  CONFIG_FONT_8x16=3Dy
>>  CONFIG_FONT_8x8=3Dy
>>  CONFIG_FONTS=3Dy
>> -CONFIG_FORCE_MAX_ZONEORDER=3D13
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D13
>>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>>  CONFIG_FRAME_WARN=3D1024
>>  CONFIG_FTL=3Dy
>> diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecov=
ec24_defconfig
>> index e699e2e04128..b52e14ccb450 100644
>> --- a/arch/sh/configs/ecovec24_defconfig
>> +++ b/arch/sh/configs/ecovec24_defconfig
>> @@ -8,7 +8,7 @@ CONFIG_MODULES=3Dy
>>  CONFIG_MODULE_UNLOAD=3Dy
>>  # CONFIG_BLK_DEV_BSG is not set
>>  CONFIG_CPU_SUBTYPE_SH7724=3Dy
>> -CONFIG_FORCE_MAX_ZONEORDER=3D12
>> +CONFIG_ARCH_FORCE_MAX_ORDER=3D12
>>  CONFIG_MEMORY_SIZE=3D0x10000000
>>  CONFIG_FLATMEM_MANUAL=3Dy
>>  CONFIG_SH_ECOVEC=3Dy
>> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
>> index ba569cfb4368..411fdc0901f7 100644
>> --- a/arch/sh/mm/Kconfig
>> +++ b/arch/sh/mm/Kconfig
>> @@ -18,7 +18,7 @@ config PAGE_OFFSET
>>  	default "0x80000000" if MMU
>>  	default "0x00000000"
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	range 9 64 if PAGE_SIZE_16KB
>>  	default "9" if PAGE_SIZE_16KB
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 1c852bb530ec..4d3d1af90d52 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -269,7 +269,7 @@ config ARCH_SPARSEMEM_ENABLE
>>  config ARCH_SPARSEMEM_DEFAULT
>>  	def_bool y if SPARC64
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	default "13"
>>  	help
>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>> index 12ac277282ba..bcb0c5d2abc2 100644
>> --- a/arch/xtensa/Kconfig
>> +++ b/arch/xtensa/Kconfig
>> @@ -771,7 +771,7 @@ config HIGHMEM
>>
>>  	  If unsure, say Y.
>>
>> -config FORCE_MAX_ZONEORDER
>> +config ARCH_FORCE_MAX_ORDER
>>  	int "Maximum zone order"
>>  	default "11"
>>  	help
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 8f571dc7c524..ca285ed3c6e0 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -24,10 +24,10 @@
>>  #include <asm/page.h>
>>
>>  /* Free memory management - zoned buddy allocator.  */
>> -#ifndef CONFIG_FORCE_MAX_ZONEORDER
>> +#ifndef CONFIG_ARCH_FORCE_MAX_ORDER
>>  #define MAX_ORDER 11
>>  #else
>> -#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
>> +#define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
>>  #endif
>>  #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
>>
>> -- =

>> 2.35.1
>>
>
> -- =

> Sincerely yours,
> Mike.

--
Best Regards,
Yan, Zi

--=_MailMate_A0E4DDA2-671E-4512-8FF5-005A5ED97913_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmL6QbgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkToP/1sKicDYb8p+ifIivRNF2WQZoxIeUZoC1l0n
Dte2sggQ8RAb9OXu7R9HjPWW1YKXEC5v7oJglccE8+tpxFTCHiF1aOSozAP4nQzJ
nqm3SrdxrrpkTYGrIz9GoOJh/bOdpz1Y1ldv3h9tz7Jvi10QsbAoJd2z5EpHwvDl
hhRX3jURSjgVLuaoQ794s362ntQUZtcwP3gf+azMkpzmVXxjpLOKGtipwC0qvC3D
QFLcyqQ2UN2H3809fiqvQhJPMsE3t8EZ+5sl2nzQ3UbipO3GesNc0pI9swc0+fB4
Oab71c67VjgeYAs/wHzbws0Lau5AxRATZ0/PJK0J6RgKK/lGKKp8qI+MAzBeNWIC
xl/OoxHXWrYIuyFgTKjqWKvTZnTR3pZIISrEojYpEnLH9aJB7wDLD0yWZw7gKI24
N5CzlqrZDwR69CyW0aQSfJXxjlO9iDOZg3csNmzo3jKNYR0o5BHeH4xRef7Os2e/
p60f02k80xr8gUqLt1SdpWeVxGGWh5Ed9Snht4XFVwKoTM9vAtb86yreo6BuosGF
Ql7ScZauZLVpykjA+6OZMPMVenbkvwC/vrpycRE7K3ZcOB0nqJS5NDNCXMg2fYFW
KoNhkkzFyQoXHDY+Z0xyIhcGzv734LApFInT74nW0e2HKt1CvJ320VLPBKvRAUxy
WUFPGOW0
=uC72
-----END PGP SIGNATURE-----

--=_MailMate_A0E4DDA2-671E-4512-8FF5-005A5ED97913_=--
