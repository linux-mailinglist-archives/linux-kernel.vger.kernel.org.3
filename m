Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1D4B7C79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiBPBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:31:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiBPBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:31:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AADFDE;
        Tue, 15 Feb 2022 17:31:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lilrVN0A64dwNkDk/OE4nQBcGWFVzRBgk5L+vmEMyws0++YbAq154mkYyAYeCi8cCOwe1ZQsS4xGNUHKeyDjF0mGzX5HDOj/bPY9c/Z+INnf3+dnc//TLr+D3/K3FBYlamaUKohYPzXa7VO7dl99WDiPw3pdIqL3XjrjHEgdWXtz4tnwJhzosH5gN5npKqH0b/LmfvbspAf88ClDsh6VFPRa9p+zX/4YekctHQbUkEtH81UtYQxZoyX+BnhAfSa9R+EkybeczzQ2vH1VTu5TJ6xihx5svEMpxdHfJ7J15vPQTfzA7/9+706m3UOf0Ia+96i4s91cIgYaPcaa3Xvaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwtwEPj/I8RC1BmICnou7+a+nYQzD62pNwW6dKB8shs=;
 b=CZDmjCsEyKwXjxqaRsBpPvxI3xoNWGJNsbk362Mbtt6wp6lgt5qyRyywC6gZGPH/xJPll9317FuI2hRZxhUu0PBN1yGnH5DXvVRtWyvyG2JXpwAfW+n+3yJTp2yGM7NOXZkjwJiurV9ykFNMihvdO1e8ty2BBGyRZPL/M24dS8zdZj4EF4MHvPd0EkLOW5oQKrbuRmkHu8vvqERcMYVP937fPZGxfUpeqe2eo9Yi5XxrcecxIwxluY7fjWKGekumpxA0Q4PaN2gnDcAkpQ66Mwb/A1+5GZYzeK/7DBXLjfdeTa9nOEzI2rdJhDG+SCCqUC7/pCzCDORla1twAm2iSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwtwEPj/I8RC1BmICnou7+a+nYQzD62pNwW6dKB8shs=;
 b=RxsPYup8gW/FszDoA7wiv4IF6nOXP2rPPrRlZGOh6SvM8Osh6QCdY/dRmCcWkm9BzG1if2mhcaILwaSnv4+QOO3ZvjAJzmAcmsID3i272cQ5MueFBRpoTgLU4Jx1ArVSbZJx3gMr25IKeA4nmIpCoNkVRxcA6tUPAtLMWqw9QGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB4025.prod.exchangelabs.com (2603:10b6:5:2b::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Wed, 16 Feb 2022 01:31:38 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7ddf:e242:b5d5:9fe4]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7ddf:e242:b5d5:9fe4%7]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 01:31:38 +0000
Date:   Wed, 16 Feb 2022 09:28:49 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <YgzD0ZfZF34u6whJ@hsj>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215164423.GB8458@willie-the-truck>
X-ClientProxiedBy: CH2PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:610:55::27) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a6a82b-4d2c-4ff0-6d94-08d9f0ec1327
X-MS-TrafficTypeDiagnostic: DM6PR01MB4025:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB40250A3EED2CD1CF5CE7FF81ED359@DM6PR01MB4025.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZXsH5vk3ZmISVEQU9uTU/OYl8cKQChHPugt8XokGuvszO1JFc0k2tNfdexehb1oQCJGUZTdB5JgETQnjTFB95sr0DnAjLUnygAzAYjx58UZwT8QqphPk7VwsAeOmyfHqUdaiOZkGjgoJX3UluXHyWf5MHgitgG0AtDRAAOAfLcm4lGdr5/uLrL3Fl5nK6d1FGkOpeDdJL3QJZ9ZX279jE22cXdkM5OPwK4vkZeZccZ4h8jnCl7PRPAmFVKYEXrq72XxxBj7RCgCDgZuHaVVpf60xQd6oDf2Bk0Tqf12CY2R1RsCXXE+vpKneMl73s2rCWYVvp5peLFqiPwCLAApxUE6OrqOzZdNpDtdFfQI7ovzTVcvG5oI/vzzdP0wKfvCOMZL/rxN64lWEvAD6pUDNyHm7rSE5SYHWU2n52vHlcA7Kgn4pFAY/uiqlVfxoaBfsGifIm5hrO0O4j07IBXcZWXJNDuEjP5vCW5vhbme/tX75n2EQ6QWMjn2FzTYawH9VuVr8/R5CSgRqmRVoukccDJMLcIa43NA2hHD02bif2+2RTn866VxtGizI2KztrwR9ANB1bbM052hJrMLC3UghkHaI5yNDn74iCXnIZcPTBqJiRKKSqJgk/MZo60qXTf8O2VOYx/b8zwGWqzW8qmGaKFV5U+3m4ZDU1mg9ex33IkK/B36Y65IZU8RuWBimkGA0RMs04eSjnL6QmoGCkIl5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8676002)(5660300002)(8936002)(4326008)(66946007)(66556008)(66476007)(83380400001)(6512007)(26005)(9686003)(6506007)(186003)(6486002)(316002)(6916009)(52116002)(6666004)(107886003)(508600001)(7416002)(38100700002)(38350700002)(2906002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MV701y4AdQ67KWHFRbe3yn83YVOrVWXCL8AoytidRyVAWTSHvWm86y4hzlo0?=
 =?us-ascii?Q?UnSQDKtDXLqjIJgzFcSxi3GANDn3FqhzJtqlWMwrjJZxQtEKLqvFpR+dpRkU?=
 =?us-ascii?Q?qSj1LtrNd/gB2uQvVfuF/kHSKFLHMl33IOXxgwcLJN5InCZTfrbayVOAo+eb?=
 =?us-ascii?Q?+TW5z5YLJCKLFI5ulz8W+CweZzwP1aUstiEPL9O/dnz17RqL4jlTDV/ujJdY?=
 =?us-ascii?Q?hzUNmE0+lEFUeKTBnqOzVNbiOclsDbZ5blcTeZRGAaMYNv2fS/hPnu2X27sZ?=
 =?us-ascii?Q?kFKlA+Gkrnda73DEnM3/ZvXaCNEc+eB1/20CtEgNkkq9+TAKaqCcY+FfoIxy?=
 =?us-ascii?Q?S4LORgZaTiIw65JivYV5glJhXXCQ8ANOj3kH3GC3mcuI0nP9UZc9kDsZBxkT?=
 =?us-ascii?Q?MQJBEXqpiF19WyX1Bs0FB3qNrotAhRT1kn8znUL+Bq1pDp8F8Uo5GIqvstX+?=
 =?us-ascii?Q?RKuezfhsRIG8+zqQzdkTuIlb0RyIEShQ/MXMwNtxHFz1HJykWzPO5NFbSNAl?=
 =?us-ascii?Q?0UIS0cISutQV9ZJNU6HByIHVaa+3k1T+zNszMXhB/L5X2buNhb4hVBOcYscz?=
 =?us-ascii?Q?vc+jrkEdH/eXdws010Hl2sjW6BbzAlOu5j43IVTUT7ehnNpkLiRIr3I6Wi9w?=
 =?us-ascii?Q?N/IrQUqEdq+S5SudHaJeFY5D296ebb68O6ZtMr1baDCwQTxFF4h/Iom2g/Kf?=
 =?us-ascii?Q?hTmX3KePU4BdzMatpz4rw1VKsbLujP0DFAUsOMiTvYx03so/BN2t6Z2F/mlh?=
 =?us-ascii?Q?g5V6oHFEOBRPiAD8vT7wdKcnB96g6EkG6TL9F5RjRHG/Cq/HMeHOzlD3O26p?=
 =?us-ascii?Q?3mGHsqvtcbFwKYnz36oyFA2uhLsKIP7X7BEnpQ4FwWXZps0dqQTAk5BujOnj?=
 =?us-ascii?Q?bF5QPnL4Ut+j+/QoKTBCLkIPv0PZcgwoj39VTiR/kAnCC2kHlaCIWRUr//A4?=
 =?us-ascii?Q?K8WLpVJuCfU23WIcSGZRFhxBouWHSNjzb2esEwqoC4qZ/m5Gcf27rfYYa5DM?=
 =?us-ascii?Q?8orQFVE9GD/L9rORqRMrwOy8c7l40CJyJmaeeQkG922QM9q9/A2+XKf0pFGq?=
 =?us-ascii?Q?6hBqRnwfF8gfb6eLPrkrG3jLnAwDglc+fqCy5zUSn2tAxoAEwb1DxbnHUu9f?=
 =?us-ascii?Q?kiUWg/NDEqXWFaUitI+qar10fPa4PgHE9665jsybmZadqpqOpHVvIs8T2HJT?=
 =?us-ascii?Q?64WVpxpZRHNaM+nu9rbG/6tiVTS6ygeymRC1Tz9WsFNd0rgOWJypSwjRXYGX?=
 =?us-ascii?Q?KGUM7M6ut+sB/FeLwfeaRDIS3mqsDJSzAgOVyK9Eh+XlsBAPoJ79DZT3HBfZ?=
 =?us-ascii?Q?W5O94xQypsPRwUGe5DQ0Ext8xj+s7MU8cGbmgBYg9IHh4QEMIhA2eqg1MB49?=
 =?us-ascii?Q?xZSxx9kA9DdpVqvJR6y/pojPxyLYzFZ/KNWVvaeLv6bgfLp7/UYp19z2aJ0U?=
 =?us-ascii?Q?Nc8jpJVHpVAtD1RqPbjep5DoYwUT9FCbEkny2Br0YP8EpQWT0+QS4IHvvaP2?=
 =?us-ascii?Q?eSVFzX6v2vEnI6MJOohnCf/tNn4pPmXlKolzg2CFwwBJbz91g+NEwaY2oyBq?=
 =?us-ascii?Q?WTGsUcJWwgs6Mo8ju25U88OiOKw/LgwfWZTa7rj+X9JbAxXaatG3Htd2i723?=
 =?us-ascii?Q?OagQazDY7QvhgtJrLckxm/ZYlY+7Uz/Sy1tm7cfcsk0iXii6qKLitgPtzT9q?=
 =?us-ascii?Q?nWOx+Dc2d/nZYNAPxKHtWd6HqKVwDe/up5OlkhQTna/0a2VoyFPjTmnHY8MH?=
 =?us-ascii?Q?TMthxrsi+g=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a6a82b-4d2c-4ff0-6d94-08d9f0ec1327
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 01:31:37.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgpcYzFFqXOHrQFX6GnzvrDtAU3z2PllPwiZgrS9QkwdZYi3TNTlkc2KSD0+GgAZRUVN6Oz+WEYBrLP6zRA6jn+PQdO4icRvoPjUUJNG2GhYPdpIWqJICj1xaTpJRoMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4025
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,
On Tue, Feb 15, 2022 at 04:44:23PM +0000, Will Deacon wrote:
> On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> > The following interrelated ranges are needed by the kdump crash tool:
> > 	MODULES_VADDR ~ MODULES_END,
> > 	VMALLOC_START ~ VMALLOC_END,
> > 	VMEMMAP_START ~ VMEMMAP_END
> > 
> > Since these values change from time to time, it is preferable to export
> > them via vmcoreinfo than to change the crash's code frequently.
> 
> Please can you explain _why_ they are needed?

The current Crash code is still based at kernel v4.9.
   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
   +--------------------------------------------------------------------+

The Crash uses MODULES range to set the VMALLOC ranges.
If the ranges are wrong, Crash will _NOT_ works well for some latest kernel
,such as v5.11 later. (Please correct me if I am wrong).
It seems the VMEMMAP range is less important.


I list all the changes since v4.9 to now:

1.) The current crash code is based at kernel v4.9.
   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(VA_START + KASAN_SHADOW_SIZE)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(PAGE_OFFSET - VMEMMAP_SIZE)

2.) In the kernel v5.0, the patch will add a new BFP JIT region:
       "91fc957c9b1d arm64/bpf: don't allocate BPF JIT programs in module memory"

   The virtual memory layout looks like this:
   +--------------------------------------------------------------------+
   | KASAN | BPF_JIT | MODULE | VMALLOC |     ....     | VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(PAGE_OFFSET - VMEMMAP_SIZE)

    The layout does not changed until v5.4.

3.) In the kernel v5.4, several patches changes the layout, such as:
       "ce3aaed87344 arm64: mm: Modify calculation of VMEMMAP_SIZE"
       "14c127c957c1 arm64: mm: Flip kernel VA space"
    and the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   | KASAN | BPF_JIT | MODULE | VMALLOC |     ....     | VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(- PUD_SIZE - VMEMMAP_SIZE - SZ_64K)

    #define VMEMMAP_START	(-VMEMMAP_SIZE - SZ_2M)

4.) In the kernel v5.11, several patches changes the layout, such as:
       "9ad7c6d5e75b arm64: mm: tidy up top of kernel VA space"
       "f4693c2716b3 arm64: mm: extend linear region for 52-bit VA configurations"
    and the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   |   BPF_JIT | MODULE  |  VMALLOC   |    ....    |     VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(BPF_JIT_REGION_END)
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(VMEMMAP_START - SZ_256M)

    #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
    #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)

5.) In the kernel v5.16, after the patch
      "b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs"
    the virtual memory layout looks like this:

   +--------------------------------------------------------------------+
   |      MODULE     |   VMALLOC   |     ....     |      VMEMMAP        |
   +--------------------------------------------------------------------+

    The macros are:
    #define MODULES_VADDR	(_PAGE_END(VA_BITS_MIN))
    #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)

    #define VMALLOC_START	(MODULES_END)
    #define VMALLOC_END		(VMEMMAP_START - SZ_256M)

    #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
    #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)


BTW:I am currently coding a patch for the Crash to update all the ranges to
the latest kernel version v5.17-rc4.

Thanks
Huang Shijie
