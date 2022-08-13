Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2C591862
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 04:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiHMChZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 22:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMChW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 22:37:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8141F7823F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 19:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRLDQ2vDQs99gLRKmczlwWqsY5GBe5U16VlNdntu4c0YWaD5Ee/1Eyy8iCNvEN1IQUcFa5BCzLz5keyj0czNnAhUwUg3thfZSpp731ATalue7fvq8Aou0keKpw+bddQ3IM+jm6BaHX4iakl3/7Zvo+hjx9XsC2BuJTvcVZ4BPMYX33rhyL3WfA/zbiGHJMyBlHK77atuctQPNXj9DIG38FY84mtm8/8/8J5a3nhI24zlmMIQut4FnIG2QLzLEaOizXlYwqaVr4iucmCqUW4BZVezXcDPBcRggrfylKPRHhjlM8GvZLzFSGbuU/5ZPHGQ97aOHO1eOMhYo/1An8uCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYy9E1Uu9Iiq9DTuMykiwhcUeqAf/hVYgsorkSdk8Ls=;
 b=OfPQJrZWBVGQAsJNKDOtIzLzgkhrKuVA06y6QcJGZH12YdhYyjtDh4z7+nqOpN4ILKtRRKy5qJIRVpb4x+jalWNSDOad4OQhSWDg0gDYYBNIsAK+c9ASfgAvZmnxAJOrnqraIOgxlXxFZbWoNU5fX+E1RpxXdzbNKDebsiJtKpYfTC7brY5XPhrUeDPMU8nkQLBR7v7tlP56Tgwcy40CSSz0yAFoNdW8XSxnNeVl3K76gi6K31JmlyPGIgpC2zR9yHotHJiu+G75fqYNjodF3GQHFQ2Iu1O2VvzjniCjlgukNnMTUUiNr2Z27i5DrFeU+uqQPjcnU/gIHO66KXjXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYy9E1Uu9Iiq9DTuMykiwhcUeqAf/hVYgsorkSdk8Ls=;
 b=TVhDXwJretTfP+hVPnCQBNy5LaR1fnDKeyUG5emJKwyM8cqLWz/NCCRIU8Wi6mnAyu1LGD7OwioFvtq8y+0maIIWXMaXZwOTbPxKyNkHgS3kIZprJEwY21Oe9l0EszHWY/tPquRrUFEQQFPz+tWfY8J93nHPPR2cH8y+Bp7iovmNIyepWgoGlTlVMRULaZ/NrA7pYhFSUBqqco8F3QJKhatAaViWAAIl8Sgc/UbIC/vhIY3zwR54AzDVt5uZv+5HWtZUNyTuZ5vd/BbZx0dS8dE8zjCcqzdEYZvL+0rTG8GOc7LFEbMoH84FrtlBSD3iN5AX6lyDxxqJzfHOHeT4UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN8PR12MB3265.namprd12.prod.outlook.com (2603:10b6:408:6a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Sat, 13 Aug 2022 02:37:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99a3:41e2:da9b:57f0%9]) with mapi id 15.20.5504.025; Sat, 13 Aug 2022
 02:37:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/12] mm: Make MAX_ORDER of buddy allocator
 configurable via Kconfig SET_MAX_ORDER.
Date:   Fri, 12 Aug 2022 22:37:15 -0400
X-Mailer: MailMate (1.14r5907)
Message-ID: <25D8229F-CFB1-46FE-B4C8-7D2EBEAB10AC@nvidia.com>
In-Reply-To: <becc0751-9ce9-6fab-8e58-477e962e54c5@infradead.org>
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-10-zi.yan@sent.com>
 <becc0751-9ce9-6fab-8e58-477e962e54c5@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9924D123-834D-451E-B254-9085BE9745E2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f64998e5-01a8-4b92-a4c7-08da7cd4bd66
X-MS-TrafficTypeDiagnostic: BN8PR12MB3265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CLPBci9+2agie/pEMEE2G2bdYXS8mgyTx9lAFeXriR41lbxDnPBhxdjKdpvwD39XqqXFlElvMO0YQN5dg8ZUaa1PjzXUSV8U52tZAA1k09X4T1PBp1XfbfpfWRXD7t7/xFAdbyxTkTe8JF3Pnu/icnDW7Fd8Tjw/URQFzZB9CUSKYUYVZ83rTAYzHnQ0b/tr//9SWWFJ1exDKlo6AAJFjH+4Gc2tdklFT9cz81FYNwaf8Qj/5cB6ai7pFYfSMVUPCMfd22KS2KFdZQ9E/okNNv+AZdbOkbopqZdRO6vUJewODkSlXinszeE/VocBzKRyzHswQBV6BxqT6qSJzJv0hlNdohR00LodOJP5zuSAffLsoyh+7fSOOv0nrCuuAC+/JZNWbbwpoJnBHzRTg3PvIuXUydK4DSIYfAOdD38+XnT15rYxXwlx+7yULEu5zNXWkrpqEQo5U1j349F/xkj4288wqajRmhDQuDlMUIlhHVIwirJPi5n9TepUyzfQAbzCStikY7MDLApRQj4W4HL63pJAE5iuK/r1zY0Cdtjwt9YJdP0x8PXibVMd0DC2vPS9ndz5/+mfWTS02KUfJ3jIILCnmf/PkcacFnvkbx4rBbZz0FhH97fRZt2ZTieERwpkfqZ9QfLahZ3Vubzr37DR6MnyoaDJNK9w5rLUOLQvrP60oxuXLtVp2Quq3viTgh6fuQrQwsQVgCT053AGi62pZAaPzlSr39CApTcSxGo2ZlxZRILCGREmlYsCJ5MXtySBF2Xing/p1vUHQQpuVujpcNVMkVb9ly2kNXc89XTUYDz2+h9WA7IRNs7E9hN6QcG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6916009)(478600001)(41300700001)(54906003)(316002)(6486002)(2906002)(38100700002)(8936002)(7416002)(66476007)(66556008)(66946007)(4326008)(235185007)(5660300002)(8676002)(86362001)(6506007)(33656002)(36756003)(2616005)(186003)(6666004)(6512007)(26005)(53546011)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRPKY9JXt8xkDlvSOUBMwTguzasotcx4OWO1LCEwGx9Q6HKXjjQCTQfrU+9l?=
 =?us-ascii?Q?5xNAgfWtkxW9Qrukv8F6MOPaW4Z+7Sbu5Zdkw03GZp/6Npfdi7V3D9v+spT1?=
 =?us-ascii?Q?y1FUpI5dvGhekL6IcWr2oZv0jI7D0Y49/s6bGKSEB8vIk7n3yPNs3MhQYBMv?=
 =?us-ascii?Q?y1Bw87NIefm/owcLqS+X8lLdFiPJI1isXfwQnY/m7AZ8dLL+SpHKhdBZ7NtA?=
 =?us-ascii?Q?aD5O5rqdyLZv0XjnlbR8lneL1N9pyhsRZOHf6UPSVPYw15IbwLbOrIAYhyez?=
 =?us-ascii?Q?422MMzzpN7F5Zdz7JC7IZe0ncQ1L/Z5Xp6zVeCS6lN0laP6r8++5rV3iu6Po?=
 =?us-ascii?Q?FKEn5N7hTnJUDA9fCg+WKw8fHabZ/sO3yB4jEU+DCS+flnNqqdICo6Slku+T?=
 =?us-ascii?Q?hNiCWj89zoLKMTGmlQHKp7kHgbkYWreZXnvLZvadWtQmmFQsxuw7uxvo0d5Z?=
 =?us-ascii?Q?1pLfA991CdmOBll5IZoGhlMOuNPUeTg1eDXDizuJe8cOLGERCwAEVGompc3w?=
 =?us-ascii?Q?r5+KPqqOMJuxuPblsxgDV4VnXNr500QlZoTUgCEJHXO4qbjf1w2BRwbxjM93?=
 =?us-ascii?Q?+Yc4y6uoIPGkXokSR8HBqOsaHxjVWte/ybSlDVmUxnsvbioYHnLSxeYz/SHR?=
 =?us-ascii?Q?YtBSemWMOEweNhJ+xZwxWn+bDexFphJA5XPqjnejpi14PBHeWsZSa64I8y8k?=
 =?us-ascii?Q?vRz2SlHX1fzf9xWwjIf39dPFN/vZyCHZQv+bkE2jCJCNrZVEb9Wym48cM4O9?=
 =?us-ascii?Q?aoehAUbiRWuZVPXl2LdSh7njZ8Px+au93lbyLEGw8CZoeyGmbIFNxutX8Csg?=
 =?us-ascii?Q?6fh8A5x22WlMLQskLSzQh/NDyJFijGKWwJsJyDx3WlxnuGBQUt7ViFv2G8V9?=
 =?us-ascii?Q?9TgtsBHr1aSCu7YVO2qitCmVT8vQamA12jo0KR1zXHKSNH0m3OV/AqsQq88U?=
 =?us-ascii?Q?ZTmpKXbjJJsEvFbPG/KkCie+oScd8bAkYoziQsJQnzPareA3XU3pfGkGcIqH?=
 =?us-ascii?Q?jBczWlPB6h4YLuvOeKI3JCGQSMS3ff0sPE/MjS6K72nIHKOiUjt8WRQ5cmGq?=
 =?us-ascii?Q?KkRXa1roEeicydJYx43xdll/P2jrpdLRSVdJp+ukxw5N/2NnUyJtQ9x4bG81?=
 =?us-ascii?Q?+8niiccVgyxmRFEDFoi3SKFfaBTg1tlWO0k4qH2Ui5qiaBjcXBvKbYhf+9lP?=
 =?us-ascii?Q?1IAt1DL6H+YOlvWX7JrQPN2kJ0NRlHldRrRlpqP86mAB4om+UcN+oOEl4Gj2?=
 =?us-ascii?Q?ICHRuM5DSYvaKJa6dlJhZF/XX4QuZdiSrYlr+4cI60zrID9P2u/lrBVXjyWY?=
 =?us-ascii?Q?+7QXekIRXVMi17AVBoM7zB2qPpJtJNMYP6zYVH4pc7eOWq8l5kyb6LNvjzb9?=
 =?us-ascii?Q?Wb3sxtoKdx7I7muB4ooBCa/wTJLtN+6AEx+9o+8ZqJsoh6HSMVTaSDpo+fVO?=
 =?us-ascii?Q?iEsdpRBRWqIhgWtmdFD/hO9dstxW3Rhjw6FIzHisfOdVuL7uOeFJf2Zqs+vA?=
 =?us-ascii?Q?XSDBhN7Tjm0gMCkgPAAKWY9pz1baK25a3/liS1ib8hqQh7RimlKQ/gKGKQBO?=
 =?us-ascii?Q?z7RPorKlsjE6+sqhedvUMKDufwQ0GXT6xo+Ws/Sn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64998e5-01a8-4b92-a4c7-08da7cd4bd66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:37:18.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Myb8KKWXelisXNE6Pl5IW8DTRiDmY9XqiNfroNyAR2mIpGDQ6+nQrKPSJGKYrUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3265
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9924D123-834D-451E-B254-9085BE9745E2_=
Content-Type: text/plain


On 12 Aug 2022, at 21:11, Randy Dunlap wrote:

> Hi--
>
> On 8/11/22 16:16, Zi Yan wrote:
>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index bbe31e85afee..e558f5679707 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -441,6 +441,20 @@ config SPARSEMEM_VMEMMAP
>>  	  pfn_to_page and page_to_pfn operations.  This is the most
>>  	  efficient option when sufficient kernel resources are available.
>>
>> +config SET_MAX_ORDER
>> +	int "Set maximum order of buddy allocator"
>> +    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER = 0)
>> +	range 10 255
>> +	default "10"
>> +	help
>> +	  The kernel memory allocator divides physically contiguous memory
>> +	  blocks into "zones", where each zone is a power of two number of
>> +	  pages.  This option selects the largest power of two that the kernel
>> +	  keeps in the memory allocator.  If you need to allocate very large
>> +	  blocks of physically contiguous memory, then you may need to
>> +	  increase this value. A value of 10 means that the largest free memory
>> +	  block is 2^10 pages.
>
> Please make sure that all lines of help text are indented with one tab + 2 spaces,
> as specified in Documentation/process/coding-style.rst.

I guess you mean the wrong indentation of "depends on" here, since all
the help text is correctly indented. Thanks. I fixed it locally.

--
Best Regards,
Yan, Zi

--=_MailMate_9924D123-834D-451E-B254-9085BE9745E2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmL3DlwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUAtsQAKKsWUniasu3pa9GAudR7raCULZiG3z0/cuF
L1RNPQsZU4P0/MbDC8xQz9UAqeDmt4kZ/G0IOGIRAiStlgbddQT0VjrZDVCkRuvS
zXwGVchwii5+uPCRPwUztCtbaltqSx3712t6vWIWjOELXHyoJJIYeCE8mh1d3gih
in5mANfAObqsBf2EyBgpJLMuZ6D0ZBxtLR5oB0CnY06goU+iQMn6WoYqohcyuim6
BFXvi+hBU55VTpprXoQ4MAaVzX/QhdmB/owVd4bSwGxADCJpo0Kh4PoQcT15vpfF
cCRHEF78D2Q5z3J5rmL8SSYxflst3gQu+5GgCXZ9ZVVY8+pfoJ1V7FVLkuwO7qy8
gSgEa422TyFTn1dOvY6Eorue97ECjdcXhPWCDzX4LSif+LuPnY8dG8gq65h/ahxr
/o4MNTqbKx3tDTyJFhZWihstkSuZfC2T3/7Z1EbRHt9HxqLdeyGd8q8JzG75uz+8
qW00ZnRpOvmgKQ5qYWIeZApuIHSEWyBkr+V7IjRhrg4Mhnj/8aBLsfZ9J/KaOCyA
2jVFUK/eiCrpeyhDq6W2vLPBygyjJPC6ynH56sK64evdGVEOgbbB6MljGMp6MiCp
KBUKusJ0NeN5v9x5plU7ciZabwwRDPBnWY8yLygyD68uOuWP1+t22nhpvxGP9X2p
hCa9/wQB
=4TXV
-----END PGP SIGNATURE-----

--=_MailMate_9924D123-834D-451E-B254-9085BE9745E2_=--
