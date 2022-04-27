Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DC5119AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiD0NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiD0Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:33:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27E47ACA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC0+hB1cwyX64i1jFmuhzkqcWYGvu863CUkuUx+QEtzBcsoxX6R/7H7ybosXpDBrHt4nC2d9XED7w2fgwouX2f8lnDCDD/hd/IJiw0ad2GqN0JTQc9hu3vvlXx13EO7PHyWVn4Mb40mgfG/eX/tFjKSnQ0zAaBi0fxjhKJ0ubkRamqI9Uz6tG9dnMiTPMc+MCdIcE5AG98+ijugWz42H3NLMXNxERf2tgkshlMIjef6m3cZqFMwAPkW0pFIOgjmDBX1Nbt3DTF6xETtogWzUVfncVUXhN/8jGKjVXP0RFvVUlC4FUdvZp4+Lbm50oyQ/YVpj9YsyRRm+TCjJ+iKjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF08QgFJ+b3+2ughpEGnkgzgCAGM2cMpZLowjOWHwwM=;
 b=G2JauI/Il7hO4C4kyUyKP0Uh/QDgKi+wSd35iy1M05yh1J9KXX7L/S1sIdjc81j7cjkGOOM6qWWM+cjtIUsugSd8spPp4kzUQnznel2YGuGXTz7R4uu98Kw/hKYZK1SsRyM3MB6NwBCdeM86MZP3loHuzSDDPjCxgrXz4aDrR4uS2tcG/mD7HMJKBM/wXmxJrSiUtqxwM70t25jukAD2l0I86dH53Ax3kJXiGYk8iGhz8DKcLA/U6JmEaK9Od6Ohs81FMhBvMURgc66h0c00oyQyDxKFWj0LLexht401VlIAFpuKMbEHC8wk6yaBIgViSkFxv61XJCUtXzl2Rf+nEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF08QgFJ+b3+2ughpEGnkgzgCAGM2cMpZLowjOWHwwM=;
 b=S7TGHpyZapMsw9CtZjN8egmCnL1Z+I+B6oagMCig2dgW2wnc1gRirWc3di+r2Zw6m0uwZwnddwgMtVlVF5Ks0DI6hLb7h0CTidRcTFKShC9bW+VzxB4dYBByZJSTL8q0hphPxvx+J+psDrcnbrmv3KJ0TK5LuvvEW7n49eAjNmpNket1jOr+Z4RiLQ5xiYXBCY/19mAZlfHoTsZXzVk2fHBeAQLyydV2plhfVTRfWokbRPB18I0v5vVOPfR6ooG/ENGHPTlMvGLXCnHWezFHHjoa+jSNMpU4My0HZN5y/al7aUxNVbGROm4nR8A3IpYBNiyDCVqVo00QJRNT5g5y+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 13:30:43 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 13:30:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Wed, 27 Apr 2022 09:30:41 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
In-Reply-To: <20220427132720.GC71@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_0AB0F1C2-2034-487C-BA7A-581A3A5B18CC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0396.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::11) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afef5d9f-f250-4d62-7282-08da28522116
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30086CD7BE57FAB44AFE25A4C2FA9@MN2PR12MB3008.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUBFljBLbkyW1kyfP/tq6x27beLYf17yRA7BVMG2QEPKTZ0cGFnAd0/92iNofh1LFbKhl/PefiL5LJqi7SXboeJ05cPFz2q1R2BzXXcpAjTHVwBl3/k5lR2jaq+b0nOA/WiV8WSoOyGvIz2yA3uRpJjMkmoKiwNZb3+s78OPh/4dp/9Ffki6HbeqowE3TA/EAqaUwlXlV7ByaLT4NrFu67Ea3PGKoQCpSo4G75ooOU14QZ/y8B/ko4JywXiBp88ZrhThwRisfMoXV9NxAt7ofQzbSjRXbropMHPbADoSJClVXRjmL4QaeAriapyIVDs0AR2q0jX77OLAc7tMOff9oCgnhZa0FQQiVGfyqsVxbZv1qO5eyTz/x524eGE6BvTD+Op87P9skobfwXuzfS5rWPrFAvBcwOSxLQ1f/tNcR2Hsjy23kas1lHqnhNzvk1k1U/puKoJVa+ywWBQ+1WUQM7cZOEhEW1q0oR9IAI0oMmZo+Y+RgoXdNpTGFfzSdkO0G0pIfivxoYenLt+vYCnLufTS8RTAYKxs1F1JmdlqbhltDH/NjxEMbfOKPbCNtiG25shb2qoUaH6BOWD6A+RXHt/iymskKXYNzux45w2RhDcuGDz81HndaTElsIeFrN46yxSKflkd188mbPiDPQz0uauFTBHXg2YImje4U92UEcbxPOzkTFU5Xpg5utsvcXtRIR9suvY5YXzWgwPdFxkP7TjvQx7UNOfWjJRX0ITsxuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(66476007)(53546011)(26005)(21480400003)(6512007)(8936002)(83380400001)(66556008)(66946007)(6506007)(316002)(54906003)(4326008)(6486002)(38100700002)(508600001)(86362001)(2616005)(8676002)(7416002)(235185007)(5660300002)(186003)(36756003)(33656002)(2906002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyrPS4zvkTXM0tAZ68/detitRpdhXJeCrXVXe41m+AnqvylXIq2wHOlJN5pR?=
 =?us-ascii?Q?5fiWUbJdMEW3EaK7aoHFhplRHgsBXeRO3CrBwqwW9m8ub6lTXhMBJQ5XG5dO?=
 =?us-ascii?Q?x/Bg8Y8Ft2NPmaIvkKM7BH6e4g9bN69qTGyUXoJn+d9j96yliIQIWuNJWzLq?=
 =?us-ascii?Q?gw6hyodG3p9BrKIcOaMKPItrexShiw5s97Vt4UOfLrWYHv4TUMCM6sDXWQjV?=
 =?us-ascii?Q?o/JPZUEUgmz5u9Lbz02LRSrFp526TNex7R399sG9zMIXpO4ZITa1ct9c9mlp?=
 =?us-ascii?Q?wJcY3wFKjS25FYMEHNrtHigcxhN2R0GozNff8X8fA1Ml8dIYxvHAaLBGXshp?=
 =?us-ascii?Q?gZ+VxW2bG6PZXoE7UaIO8sHiE28hukzO78OgbXgd3X1+9We2qu+N8jlSFbdy?=
 =?us-ascii?Q?EV7rMpHpehTPuCiGly1EOYuolnUlKBJyRoQqkLjAAgNAH2M+cJl7ERJYScdu?=
 =?us-ascii?Q?8LFugr4ZK4mUCnbwhDwYqGp5TPnNYuDKayZcThT+Do7Rk/+zfO864ExFU4PL?=
 =?us-ascii?Q?AZJ8qapMgZKwuMyJZCpW/Iq6f75vuXvNCPoEhfWOxKyA0iwwzrCGgkdLxXLH?=
 =?us-ascii?Q?ipnTrYOLtkFbAqYyGLGIPiDVDqU2f6JpXozCJC0nxuBhr7kvTOCsJAHwy48x?=
 =?us-ascii?Q?5BV4sRQ4rAzk4sLUrkWV91Rz5KTt2TiiAeS/G4A1j3LbhBfKbJN8RS+MZ5YT?=
 =?us-ascii?Q?9hpO7YzQ7mb6lAIF+qHQod5qws2kfqOML2dTrFzwyE15xPuN2WoZbscyG4hP?=
 =?us-ascii?Q?g1iCNucIKRBV07QkTsmme0CNO9YezvhU1f5GZP7L4I9zdmU4vQ9xvT6ZuZeu?=
 =?us-ascii?Q?niKULIOe8TRREg80wHwdpnc9bL4zHlcZt1C54BpXG1j3sIp9vxe/1j/kSVMG?=
 =?us-ascii?Q?px7fsN2w4p/4FfrZwl+Vh6LXnGKGkFjGXjqdCIfSeh4HAEaZdTAagMMenCWv?=
 =?us-ascii?Q?kcDWLrOg2R2ojml2i50D3ZWQ+pXCwabQHJzqMsFeHE4VnmgRMs/kmeBwNcSg?=
 =?us-ascii?Q?3tfLydRr1wYAwFJnCyx9BlTIhAI/4nwNTOJQANUbZi1xBEgAW1wI6WZ11Co+?=
 =?us-ascii?Q?2rJTB/yMvmiNF6B2JfSjCpdanwFkeWTcELOpgTldvh5/EmqMEJXoeY0YZgVd?=
 =?us-ascii?Q?jpt36LqS2temkbvTl55nqR3tAFPO11F3eTnFtjTEOgAJOiwv72n2e95fOuWk?=
 =?us-ascii?Q?2RkiGL+xogkajy32ymMOVkusLMZWuPutYXTo61tf+bLryMWfeZXTDs1a/vJc?=
 =?us-ascii?Q?idr9FF/1bVzmNXsYHiQ45ASm/APMvoCWmNu28vmjOm54xBgwKeIeYpsNtYs9?=
 =?us-ascii?Q?F/+lgJ0pAuHIga+2H/C+DmtyMYlp4N/ILtr+71qRnA26Bcs5Lvtmk9WbZJMi?=
 =?us-ascii?Q?Yt+Zhs4nB/fLqwT+CYDi+9T6vcbJucYS3Ros+tP1K77WUpxj31EZi2NCv5QC?=
 =?us-ascii?Q?VWRoJ1AG6/hqgfPmtJf6uZVSSLE2mGXHzOjaaDjQbkCpm+pzVC5WTSwQ6nyH?=
 =?us-ascii?Q?hKnr42ym6XJ5RHiAIIhubeB74bS1gabArnyK3LEQ6t6oy1uHXG3OBpzWk+kK?=
 =?us-ascii?Q?hopUAEh9xGJT4pXpFfXcaqeNUqYAkcQFIE78wDmnsagpJjYNdIJrWItBEtn0?=
 =?us-ascii?Q?bdFsmK+hBvok68d1v/b/vmI23//C6wQdcyqq558WMsLkc2CZVWmDTXuuivu8?=
 =?us-ascii?Q?Qs4OcocqBcywjqofNF2WERLFxNUC7pRPnTDNx7VeULrJ8x+qKQobgDAmpbUf?=
 =?us-ascii?Q?5z9yh7rPjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afef5d9f-f250-4d62-7282-08da28522116
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:30:43.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/EgzbDR66FpLz7Ly3ecN1ROMqD3b416yqqVa3KSaVwChmmXgKRMT10UV2LN/oR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0AB0F1C2-2034-487C-BA7A-581A3A5B18CC_=
Content-Type: text/plain

On 27 Apr 2022, at 9:27, Qian Cai wrote:

> On Tue, Apr 26, 2022 at 05:38:58PM -0400, Zi Yan wrote:
>> Thanks. Do you mind attaching your config file? I cannot reproduce
>> the deadlock locally using my own config. I also see kmemleak_scan
>> in the dumped stack, so it must be something else in addition to
>> memory online/offline causing the issue.
>
> Actually, it is one of those *offline* operations, i.e.,
>
> echo 0 > /sys/devices/system/memory/memoryNNN/online
>
> looping forever which never finish after more than 2-hour.

Thank you for the detailed information. I am able to reproduce the
issue locally. I will update the patch once I fix the bug.

--
Best Regards,
Yan, Zi

--=_MailMate_0AB0F1C2-2034-487C-BA7A-581A3A5B18CC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJpRYEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU1BYP/0/PWRYgJrza56Dfa4mGN/ezdRD6aVh3dkVY
nCiA6+rK9k47zYKxHgbtPvR8AxHa9NK+hkP5QtK2XRux+Pz+T8GkYZhrNX4PpxLz
VyWyijsCZpj7Hq4YgJX2xJeQiq3Crj+7oD6ZNyO3Mb7grqm3R1NSTlh71qRNXHSJ
qReEA6Soc6z4ur6l1oR8G5gakbog475q8znuiWx/LHiT8/g0wnqs+eK0eEHkeqvJ
iueOC2GoqN9gjGiFGr3yQdkgNEhOXi1/vlVkf+0b5NDua8EXIP29N7N65p7FHE00
nBi+GdejduxozkExojM8nm6TpltwShSarA0IaNne22ofgb6weAlvgjuFxrm+nq52
D1fGcmAnApNsW/fhaVsN7kbXmbYC1cxuntZNsF6/S9tC3IcTvcda/4GGpn7GPz+L
tPKqWp39tpCV6mXr+defK+C+YMH/R0kGaTh48ntf2TAekML7kk1NUIQUVKLD1STE
f6SYG7urGUelNRu9a2A0uk4mSjYcHI8kgTW8KwoFSJC4kPeBtw6UaFOTLduxij9D
6mTrwa9e+Q9eqSLB4h2q/vO53OWYUm7wlmZtmTM9ioqJVX4Fed//WFrLyH/munwi
j3OPrjMMtFnyC5BBTVrcZhXywPLjqa/veqFQylQZNmD6Z1oEHWd3wK05Nq8WyeWZ
xJXs1rNH
=5sJ1
-----END PGP SIGNATURE-----

--=_MailMate_0AB0F1C2-2034-487C-BA7A-581A3A5B18CC_=--
