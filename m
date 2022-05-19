Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A416852E07E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiESXY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiESXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:24:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3B106A51
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbv3FjK9OJypvVM6IePgRVfipnXr+2h0M9Urj+AaPsaKfccJQ/8zdxhWiyaTGHUD+x4m8/5F0l7kTr/zJKikL0mEixjW3PCiHrGmf3DLlFepb7hD/qUMOGNagyaplLEMWlJMO8ggkx9f+L9mPfGwDPSzkcQ9ovDcEfMw+WUaVXLmCE238blwmEz8d2/BmThhJt5vQi/5ZQVCo9/2pfcDcZgviFfgcfjQDg0Vf4BUIcX/PQ9nOPtMkbE/u7CnthzPRVHCOCX0ymA4dDkjJEgNJ8+lQoxb00KMCtGZn90LKre4NNfCCCjSBaxOLkf/VxAwfTuYWSfamQ0m5K1UCz97KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgHu8aRta+QZjwlLgwydf2MqTMkmvvQNujaoPGbTXGo=;
 b=BX8kG8huOqErEwocD7F2ubaqdVIPIdq1A1UsTW/YCBlG/BFQfwucDQbIBeXVN1uIPBvPZMn3TF54MwnxW5K1g92nIi18aWl4QmpQq2TmgQ2n/KvU/MlkEWfXe785kzikzG0PAHEQj985j+FgJt/ORY5P8wXwBZnxCSHgjyukpb6F9l4DwHHRggY782g8RQetH2/9sK6LkicyeysIC+icHWN8KtuCHFXdB+cBk3eeDcDo8zIFutk6p8Rwkm8d4dR7ZbWuuRyjTd6OMJr4nYzmXNecCFu5N1b6axaYVXXJNckv83eUcorPPk9blMZqTtSZK4tAusqZQ2vAUXyeCP3B4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgHu8aRta+QZjwlLgwydf2MqTMkmvvQNujaoPGbTXGo=;
 b=kahmeIWcQjU1ttRgRiRb+w4dZCMEZGyRDhrtMWn2IKfjH/28ag2shONpeYM8GaKyAZzybTB2XNQDqvWBBkUjZkiSclIx/6sTsJXJOTDVJV0LLQUE22Y0RQmUh3LypX86odntYPc6YaZTS86IhGizqn92OooCz3VZtET6O32nEPR4pa1J1lWz1osy3JUNq1KFicWkfw9KHGlvmMtiyrFjMC0ifnsocwPl2eROkiYvLINJ+CiIEwECTaZ1BMeNffmqM8dMHGQUBBBzXIi14hFA/ml7Fp0QUOJTKAenlRpKVPCt1gDebdLBPLWvyj4zmylrtfdBewteEaVeh3Z/GaNFpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 23:24:50 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::bd7d:c3f0:7e0:7b30]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::bd7d:c3f0:7e0:7b30%8]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 23:24:50 +0000
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
Date:   Thu, 19 May 2022 19:24:48 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <7B0CB60B-FF91-4622-ADA1-A221F24F6866@nvidia.com>
In-Reply-To: <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_906E2FD3-285E-4D89-9822-B7752F42390B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16)
 To BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642cc502-e664-47d6-4f55-08da39eec515
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB256869080E4FAD08D15107D5C2D09@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JBgYMLyPghl01FxedHVoGJBi2PhySxyKLPEHOsWV0SskfqVFJv2bZpiZLtYVwe2f01E42UeB4YgqFNSQr3USw8cPFyp4frhuL2Jq9MCObUMcSV4cb3JWSIXjnAP6AKEkeEstDGylfPOTNioM6i/wIxouGPmusA1qfieeQ/kFHUqNu5xDofiSDbE82Ko42W8R9JJyJu3LvHg3dWPoP1W0kC0vhsZpVpgz9jrEJzCauBfx2Z4F1dqEIFyVjKC4WWav31dnbseFHZacubmuHYJgD2fvdd1/7Myr+/nbl3/EiYl9AvM+FE1K5SxZY9UcxnDInc4b5xHz0eF43O3AnvF5er8ftnNn4pzKxidDM7bjx5zjFi8YjdpIZnS3hHVc538Pfa/S9RqYXU3l5JcWILfMR8KmUoxsHOA/RKMhFgjtgZRQS9lekBUP5GpRlCgAyjOl/viWq/F4uRC/d4xHhkPqfBIqo8lon1JWfrflIG29kVqrpWfUd5+4P03bFvLhX4aAHg6kwNMdC3GcZmTZJtS/JcfL3BqM9Q472ySP4PAmgej1nEHoJstUHbM1HkvcxrH75JAzPyb8tseQVvvp/UxI/71IyCbAqC5ZmnpFUk47UZgkxXA6YIiS+Kq11sauxYHD/Z48Rt7PU6pd0eRLGL0/3zNGySLoPMz6+SQ9Aug9SviyeTnde7bql9tdnRcKdMkCUvLW6w5AkXnltxlABK8U8dK/AWBKi7n80/oK0vaTHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(316002)(2906002)(6916009)(54906003)(36756003)(508600001)(6486002)(8936002)(186003)(2616005)(53546011)(6506007)(6512007)(7416002)(26005)(33656002)(66476007)(66556008)(4326008)(66946007)(83380400001)(8676002)(235185007)(86362001)(5660300002)(21480400003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMMvBzOK8jTnPSAj8yw2W7WwkqUtINENefibj5RClb+yfRfv71NQcD76bBqw?=
 =?us-ascii?Q?mylBhtL+VRfqJTWQLT3xeni11gS17z3kRJgmmO6fPH6xCASztZe9czITuXUE?=
 =?us-ascii?Q?nz9QQA4CPzdvL/x4L30SAsNEPJDE9ZBQqByXyABICUPmwivDG+dKFepP8gXr?=
 =?us-ascii?Q?pIaMqp9RALUmc5KHigcH4OtvlRQor4qE4o8GifFnj6gjgH0aj45RoYbrKYxk?=
 =?us-ascii?Q?OGxpNWdvpcBKO95g2s6hiUzqaVDtFvF28skUK9yH4cJnFFJfgKuQfODzKkV9?=
 =?us-ascii?Q?pz0QZlRYRQNJ1OZl+GJoyHF0x8yaE0GeBo/xBx5WAWoHa/fSSU3BcNB4ALoU?=
 =?us-ascii?Q?2lx+kLcDBq6ursrBl+5YGNi4KKXJ81EbCE50SOjBc3Sspo7F9AD65U0ZBPNh?=
 =?us-ascii?Q?k1QUuk0EGIQFp54vuUnlCsQVUhVEcI//EDDh0Y5M9dCKebV9AqcXYmmFdeTh?=
 =?us-ascii?Q?Gy/UVqP1ZCnxjNPUDk6f0JGOyyB//GoX57cv33MdedXkYKyUtO+T5nj/Grjc?=
 =?us-ascii?Q?OLIin2u1tFz/4VjBXhrTY83ond5i704Nfd/UNOL/IO2hNqpXiJW+lsNKfFs0?=
 =?us-ascii?Q?PFvEaPxW2/V48+FY7Pivukvr7PcNVSx60hkfOUpoiqqMQ2VFoM/V/6RHvcZy?=
 =?us-ascii?Q?SymjT0NCKloEfsy8TxmMa1HdB7G0Cwb1MBkkzgJFbbCH53mIUTP7OAWKxxhW?=
 =?us-ascii?Q?gr2Q6D61hy9YyKrnlS/MBHpZjgZeCyaOfdFC6+iUywcBoQYXqfu5zmoUU6nX?=
 =?us-ascii?Q?bwfQnb12o2qtguG2nYx9Ri6gD2uZ5OxuuqRumCO9jG42GekM5kj8hGg7JUi6?=
 =?us-ascii?Q?Vl7N0TgRwtd4CaWPOIQnqiw+6zpR/8hop3zKiqpTUGMetSg0q5xk36IgcrJt?=
 =?us-ascii?Q?xQ/sK1vZZJjVHFI/8XF1ZynorAFC8aA2VxeMbUgS0W5EyK0S+kU1bEhUfSwS?=
 =?us-ascii?Q?k05dopVcmJerSHczm43Sl21y34CKyLRrQF6KvBYKoJox5BRCKujrAa2gvIrN?=
 =?us-ascii?Q?vDMrUrT/VQiqtsDxqO3dPu/agP2u8QfdBqLIkoeFGwD2nE0YSZTuntruIp8G?=
 =?us-ascii?Q?0h3AumQ2A0McKkMb/fLFogW0lP/1ISBMLrXFn8KlQGn6UKVnWp0lEKNCOC+y?=
 =?us-ascii?Q?fHm/AEMiMtCMbE9RU5pYMp+PimjS4o8Rl4vuyUXuQU4G2PmcJU2VdkItQCX6?=
 =?us-ascii?Q?UX/ll1YBrA15IONVlthbnbMRfR1R5LDBd56h8bZEm+fmxFas8TPoF34okps7?=
 =?us-ascii?Q?645vaWL3WNfCrzB6QVGqdXwUWt11YhPOA4m4CWDS5zTs+yZxCagyrzF9dR9u?=
 =?us-ascii?Q?PRwyu2uEBdXUMLVIgKSiL52XFsF1wMTNi1a1qredC0l9b/pWZgyz4ExFkGlI?=
 =?us-ascii?Q?t0B/cKix5eTHWb0L168xjorW5uRgCTscLBYGdvwdxkziEURXt3cFMKF1wHD9?=
 =?us-ascii?Q?pjfF2p3TokgmfbYH88yfMjrEUiBKeLTr5dUhtXNq/+DAM+Hl0lU22/LzKsHm?=
 =?us-ascii?Q?DFwChXeg1UD1krJqEJdhvCfwoeCFXq4AhIE9FP6Q1hqZstmXDJ0snzz3w0nc?=
 =?us-ascii?Q?KbeoxH6OFQ5uFzfPZ/j4E6ptAz7Pod/9/0HEeNlpgg4f/dAI7pOl4AMMlpvF?=
 =?us-ascii?Q?KNa5tcPDwSDG2KQvOzqD/FSLfRXWcbeBaVOo0OoCXziitx1o76zQX/4PIx12?=
 =?us-ascii?Q?1Gah8Fh7ixv5EAZa6lZQ9Rg+PvJamxhjkAM5WQruN0zaaLSjW8qllFN8TCp7?=
 =?us-ascii?Q?1HxTM8KJJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642cc502-e664-47d6-4f55-08da39eec515
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 23:24:49.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgXyIGmK/WVO/z6yktxd9UIjwrGrPPAivNouKHR7ObIUnWkxLZaUgZCyyfrjEhKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_906E2FD3-285E-4D89-9822-B7752F42390B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 May 2022, at 17:35, Zi Yan wrote:

> On 19 May 2022, at 16:57, Qian Cai wrote:
>
>> On Thu, Apr 28, 2022 at 08:39:06AM -0400, Zi Yan wrote:
>>> How about the one attached? I can apply it to next-20220428. Let me k=
now
>>> if you are using a different branch. Thanks.
>>
>> Zi, it turns out that the endless loop in isolate_single_pageblock() c=
an
>> still be reproduced on today's linux-next tree by running the reproduc=
er a
>> few times. With this debug patch applied, it keeps printing the same
>> values.
>>
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -399,6 +399,8 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, gfp_t gfp_flags,
>>                                 };
>>                                 INIT_LIST_HEAD(&cc.migratepages);
>>
>> +                               printk_ratelimited("KK stucked pfn=3D%=
lu head_pfn=3D%lu nr_pages=3D%lu boundary_pfn=3D%lu\n", pfn, head_pfn, nr=
_pages, boundary_pfn);
>>                                 ret =3D __alloc_contig_migrate_range(&=
cc, head_pfn,
>>                                                         head_pfn + nr_=
pages);
>>
>>  isolate_single_pageblock: 179 callbacks suppressed
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 boun=
dary_pfn=3D2151120896
>
> Hi Qian,
>
> Thanks for your testing.
>
> Do you have a complete reproducer? From your printout, it is clear that=
 a 512-page compound
> page caused the infinite loop, because the page was not migrated and th=
e code kept
> retrying. But __alloc_contig_migrate_range() is supposed to return non-=
zero to tell the
> code the page cannot be migrated and the code will goto failed without =
retrying. It will be
> great you can share what exactly has run after boot, so that I can repr=
oduce locally to
> identify what makes __alloc_contig_migrate_range() return 0 without mig=
rating the page.
>
> Can you also try the patch below to see if it fixes the infinite loop?

I also have an off-by-one error in the code. The error caused unnecessary=
 effort of
trying to migrate some pages. Your endless loop case seems to be caused b=
y it.
Can you actually try the patch below? Thanks.

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b3f074d1682e..5c8099bb822f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -374,7 +374,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
                        struct page *head =3D compound_head(page);
                        unsigned long head_pfn =3D page_to_pfn(head);

-                       if (head_pfn + nr_pages < boundary_pfn) {
+                       if (head_pfn + nr_pages <=3D boundary_pfn) {
                                pfn =3D head_pfn + nr_pages;
                                continue;
                        }
@@ -417,10 +417,8 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
                                order =3D 0;
                                outer_pfn =3D pfn;
                                while (!PageBuddy(pfn_to_page(outer_pfn))=
) {
-                                       if (++order >=3D MAX_ORDER) {
-                                               outer_pfn =3D pfn;
-                                               break;
-                                       }
+                                       if (++order >=3D MAX_ORDER)
+                                               goto failed;
                                        outer_pfn &=3D ~0UL << order;
                                }
                                pfn =3D outer_pfn;

--
Best Regards,
Yan, Zi

--=_MailMate_906E2FD3-285E-4D89-9822-B7752F42390B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKG0cAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuf4P/ReLRR9KDMcXcEdTCiJZpfbl3ecwUHEjKRRo
qxUIrFK9Om9hz7Kds7fNgsC2bVHV8CqCfgCEyrHyjA2YS+8qeUloWswQmxUyZZAE
GmReC/ID+UxY1SJJBHAGhBPMG9Zmi0SSu6ehrqwbNaxHGSpLSAW7+MYptnbkyBgH
YIhCL4jE5ge9tXyt+cKx1p+5fMBY0IGe/bU4L1GHWkvo2jRePkW4n4TQMvvBoGMM
mHPKL2gQj3gF9Adir1ZaDhIA3jUTxfANMWLNsJHFHEA1MmS3k37WYpuHVAb4Ap9l
cfOqYh9D3uxtus0NN7STWtDj7Ah+9InJ22A1Frdj9l4YVhkzLkjdVlCwbmaU9IiF
7YbN2d+fb5nfoxnMK6Lfsj7LPqJ5K/kg+KuvpXaf7ixxNCulCL6DuDmBfbvSO0N4
uL3Enbolt5yVINGae0WNGwNW+9PTyWEbcVYmnrANX9yTBDeTkyDlxQkhbvBOCPwl
ihneibeYKq06+EHCAysEwyUQyhYrw/A9YkSk6u53DkYo2AjoZU8HqsjQtb8Gg+oC
ib+q7ztB+9mhDToUjJn6f392QDdT9cz84OiDgvnCQQWdC540wmv5J5bJDw0fhXs4
p1C/oXIeD5a0FsyM0bmXrBJwjfUHi5Yzpqws4/NxGUJMgMZfUlfJlwr8qhAvTN5J
a9Ccw9s1
=kHbP
-----END PGP SIGNATURE-----

--=_MailMate_906E2FD3-285E-4D89-9822-B7752F42390B_=--
