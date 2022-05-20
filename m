Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BB52ED64
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349922AbiETNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349911AbiETNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:43:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96616D480
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwLLNy5nVpGtQpiVRNonC5gfx/4UntyBBrO8nikEPZ5fBHkJCUUXFFx097aoqHodQUQH17zqeUPXhJTGCfcsPc0b0PoQsqFp0IHz10NlbPP403ZzCQFecQDHYMYBUZEmCX4Vdf6bugyKBY6G0PRqphNthSpeZ9XQ+i2PeRbFzFfTfBvSKKHgwU0fzFFMn4HcDFsd40biXWJcdklAVN/C2tPaGbhPb96BxKUsFP5ZYdNturQnj73Mu4wkbj+k/CSfcMKWb62jj/NRgeBBES/ytGPwWRd6oTnCxG9I8fJzeSD6B2+wcFV0hW3VqhypFInMeSMLskMUVwz8jAOba0kYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4M+sqQVlzCWkqFoHfX135oGiE6vc4EQfRcFG14B4No=;
 b=b45eOApcMxVIAF0iOUwOP6/1DAsItu9w8goce2Ze0Dp2gkwxasd3ny/9W79kn0Hn8QKeXMLJHkGHCC6XRq44ZI2XPhq8SMC0FRvGJp7/krau0Nv/1DecMDsJ3LGV7QjjWbwnO+1y23dlgvC61Q7I9uCCCVt2raCDbhqYHJzq5JitaYwSNhrV3E0sXvFd8WZBNvnxfirIO4QUzxMLFGTeLCSjtrK580AFCVRZuZAuMA88Cuf0i7Om+16Pr++vYH/Wxf+/c1IzBkbXWMtbX/ua3fsqS5n53ifhpiR1Am1NW7H8iy43OoUC37pWn01p80Mw4WWOk2XLronK6e/ekVZolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4M+sqQVlzCWkqFoHfX135oGiE6vc4EQfRcFG14B4No=;
 b=A4xgwmjctwI3LdEbFtj1kRa6fI5Xo7ZJikqc49pCKkbOP21xjSg8ZZJMeOQamDYewwXHl4HQLgRHDz4mLs1VIVkggobe887866c6lZS680P/OpPEiMKH5SScbRzhg4LiI3lux5F37o7DAEwKV7bT4n+ai5jTKso5EFTPaZZiPj/VTcw0vaDo1AeJoiMi7mP10pLN4h6meEdHraTcbwUN7vbJPErAhTia0W66fAPwkaXIPhNae6epxtgRCpF8cpUIQQhcB/YXKFpRFqqMHLAXXE77xr1lYfz/dq5DarorKbI3+cp7V+pN9ffQ8MNbGM//d0NyhZoGwFRR4cROdIYgmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 13:43:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 13:43:43 +0000
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
Date:   Fri, 20 May 2022 09:43:40 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
In-Reply-To: <Yod71OhUa3VWWPCG@qian>
References: <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com> <Yod71OhUa3VWWPCG@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_3079EEB6-53F6-4C85-A7BF-EA6F1E96194F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9528fae-3987-4750-2886-08da3a66c15e
X-MS-TrafficTypeDiagnostic: IA1PR12MB6115:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6115C595D2DF0BC1289BBA1DC2D39@IA1PR12MB6115.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNmgb3Tv4MH9E06o43PlG/recLyBiAPH1WsgWunfrEnElBCQi4UEYSWwHAHBSgAVFo4k5/1seqv9tRrcCxqHTMEhMiaCmhK/A0kuxCLtrw2NzY4zJo6pYQD7RuFM/Xebp1paQPKrzqKPVKNM27D1EaRTvWxdfLUkoqfi48gDUkfMenuFDxFNCQOqEKnLaUQXVF8DB9hJyzcotZGka0pYrpqhE4Jgt2EPBTdOTHUJiWOLP8pnaNvow9qbk2xnLpxBWngXBVfQn4AIH7ma5CSkEn523SeAZIA6PRfqbcdxWrljQyhaZoUinhWsdcMf4uVkXPvkOB2AP/96kMaY/78QVQsMAUDTJO43FSVPgKaviyIEELiFui5LPZzs4JOTPgThL+7Bb2whVor11l5gq5YgL71ZUG3DCsi+e272/fSmiikQctnDTvUeDBUWD19qKlwTGd0AAsQ/wi3DjZhwWuV/H6pqrBzx0FM7P8iLcn54ewtR/3zOLBoe/Pgj1Th/KDqUNLxKQCDaDA7Oq/VUGQ6jjnuuzYiRc1yiB4fkMKAB53bxomLhsdzGUKOQyiDlgQ5i0H9eZ3OwSBNBlFso4zesUH8REAdu9XXo3/zft4v20rQeToy/o3DzxZ3lBs3vWC1e50TIUXc9Lpy4D3y8uhE7xtlwk8p740oQCxpo6r1iPhzXhz65z5+TcyyOOlIxNqLxqQ2Q/Pm61s8U8AKioYnW21UjDejqhXzt0cN2b+E0wvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(2616005)(8936002)(235185007)(508600001)(36756003)(7416002)(6916009)(6512007)(2906002)(6506007)(86362001)(8676002)(21480400003)(66556008)(54906003)(66476007)(186003)(66946007)(38100700002)(316002)(53546011)(4326008)(33656002)(26005)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFZCjtpYCiqKNRaqRdE1FPqiZ2G5fQewYMlffoiaCIClNvzyE9a77PjbfDiR?=
 =?us-ascii?Q?ly8Ng6fS4eAqU2F7KsOOAwGL23AOB4PK8W/3k9DpX05V5SbZ+YRfm7+8KpUk?=
 =?us-ascii?Q?zp1ZmN12ajufeuEj8HTTIINvzJJ7qR2urG55SC/vHRM//nRLM7dhTYE+DWgL?=
 =?us-ascii?Q?c2/cc1f2EDYqHyTGQoYKk652yXM2Wzz+kY+8ez0uXu2aZNOnvgNAXezZQtZR?=
 =?us-ascii?Q?rIJEN4NQVHONS8czKLs+xrTBRqM/VHZBGGW2bqJ9A1eL03i+of/65MQfZjuK?=
 =?us-ascii?Q?66AldMHTIpQPC9Ugk6O4EWcNCAhPXyYsXdB4HXF9M2D0viLqt8ji76Kk9gjd?=
 =?us-ascii?Q?54lR2zon/ytQTgmLUxcvbH88EC4QzC1hrw3ycLJX4NH/vsc60jZnXndk+vZ7?=
 =?us-ascii?Q?9PH3GhYZ7wxHMSvGTSUWFkgMJLSaMOpKHYVuO6/pxjM7JJE96ur82yPvrkPH?=
 =?us-ascii?Q?Jvq9xVw0PsUzc4mj/ViPTkYu7uSHlfEYsuX91r6A2i3KUCgRIKS+T5rINyog?=
 =?us-ascii?Q?Lkh3XrbNWq2VpjZt5RGFmjqXamBAS8AZd9xz1u/oaXpBTYkthPg0sBbA1EUZ?=
 =?us-ascii?Q?vG6AynwZWY6GA3bj37IQk6h7v1ahjxoXikb7dU7xgjLstzA6MJIEJRz9o1m4?=
 =?us-ascii?Q?yAfREuUAOjxqNLZa49kKfdg5w4e+k9mneXrwvjwLSstMoOkFgpQTIopJ7EXu?=
 =?us-ascii?Q?y+dYj5Zh4Kd6IrUzhp3cuFOEKzvjBWVXedMEGLTOCnUP8gxKB19bS03lR+CW?=
 =?us-ascii?Q?EaGimipI8+eABXAsMHbRQRE1TgcAKwpfBKnzcem9p4exN1sm9MudjYxlyPoX?=
 =?us-ascii?Q?svyhTnCFeLkybPDg3Vcrw1ZN77cIbOWN5MOsbwtL5QVJDXgY9iil8ueRVNZI?=
 =?us-ascii?Q?DkDdcYLY0QloDWiE6/zIKYYOTYpftxr+68cZGPxBD7G+X0IKslNaRDdV80/s?=
 =?us-ascii?Q?bbM4r+9JMHwtGK4EBjb2wNH/3TveY+R51Z6PEArOIb09fX3CI9qr2qIp0WFV?=
 =?us-ascii?Q?JUYlhg9qzU3ixYUPJFcPGBC23guNtZHYN+vPEVgiXnZUIq//cEFfqtFObJwv?=
 =?us-ascii?Q?xQTniELs3i8A7m5O0o0Mg2xnJPohqWHjsM3hB20KboBFE398Z+zA+gJyTSBw?=
 =?us-ascii?Q?P2ZnoaroSyPBMrOxmc3MM5c/B+cMlb4rRcmLa44+uK0sV4e2butIXT5H1p9L?=
 =?us-ascii?Q?5ZNo9nXSLJ9arEWzoBQ8qzf23UPjOthF21ugrmArFeE19kAQuwwoD+9KaL2V?=
 =?us-ascii?Q?GP8dSTd6mPLHzQ26qokFO9dKwobC+iY0tHZmWDgBHGeuuZwbjlBUkFm2SvWN?=
 =?us-ascii?Q?NBTbPgTMAh8eLHlBEnBifqOXM7auf4EiUNVaPCnDa1NBKlfpjU1HuBdO3L7N?=
 =?us-ascii?Q?mdVmXOKxYz2zTqOcwI2F/MSNtXCsVENZmwkVlALfM/JhHT8Mxg9PcZDjywQg?=
 =?us-ascii?Q?P34q6QOuEiH6mHHlGgXdKMjepCP96OVdkHv+Le3kRDW086ijrbGCrFtbTCYi?=
 =?us-ascii?Q?Vqr+blsAnCfimLvsatxUvghkKsnvqjPcfu2YArUlkC7w7zingJxfdMVVyfL3?=
 =?us-ascii?Q?nxTscuXz8NcgEaB5ez/QBLAeMkNE1lq7Jyv0+LtIgcX4NnF3jdcEm/pHlwPI?=
 =?us-ascii?Q?oC5oGobrh05dReRzKSVvasbDBmD8UExCMuSTrT+Ogp/aDS/y4dF37Hq4rXkW?=
 =?us-ascii?Q?S5pYJIJdReC1J7CXEw+zxKej8gbskU4RD3pEGih8Y2PWlLJDKY8r6wyjhYKw?=
 =?us-ascii?Q?VV41ih3/Sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9528fae-3987-4750-2886-08da3a66c15e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:43:43.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jrvu6yuGYytdBXbc/QS+ff0Houa3rOrbbphw8nSPqVvjyeH8hhfSIIEAK1p6z39x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3079EEB6-53F6-4C85-A7BF-EA6F1E96194F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 May 2022, at 7:30, Qian Cai wrote:

> On Thu, May 19, 2022 at 05:35:15PM -0400, Zi Yan wrote:
>> Do you have a complete reproducer? From your printout, it is clear tha=
t a 512-page compound
>> page caused the infinite loop, because the page was not migrated and t=
he code kept
>> retrying. But __alloc_contig_migrate_range() is supposed to return non=
-zero to tell the
>> code the page cannot be migrated and the code will goto failed without=
 retrying. It will be
>> great you can share what exactly has run after boot, so that I can rep=
roduce locally to
>> identify what makes __alloc_contig_migrate_range() return 0 without mi=
grating the page.
>
> The reproducer is just to run the same script I shared with you previou=
sly
> multiple times instead. It is still quite reproducible here as it usual=
ly
> happens within a hour.
>
> $ for i in `seq 1 100`; do ./flip_mem.py; done
>
>> Can you also try the patch below to see if it fixes the infinite loop?=

>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index b3f074d1682e..abde1877bbcb 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -417,10 +417,9 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, gfp_t gfp_flags,
>>                                 order =3D 0;
>>                                 outer_pfn =3D pfn;
>>                                 while (!PageBuddy(pfn_to_page(outer_pf=
n))) {
>> -                                       if (++order >=3D MAX_ORDER) {
>> -                                               outer_pfn =3D pfn;
>> -                                               break;
>> -                                       }
>> +                                       /* abort if the free page cann=
ot be found */
>> +                                       if (++order >=3D MAX_ORDER)
>> +                                               goto failed;
>>                                         outer_pfn &=3D ~0UL << order;
>>                                 }
>>                                 pfn =3D outer_pfn;
>>
>
> Can you explain a bit how this patch is the right thing to do here? I a=
m a
> little bit worry about shooting into the dark. Otherwise, I'll be runni=
ng
> the off-by-one part over the weekend to see if that helps.

The code kept retrying to migrate a 512-page compound page, so it seems t=
o me
that __alloc_contig_migrate_range() did not migrate the page but returned=

0 every time, otherwise, if (ret) goto failed; would bail out of the loop=

already. The original code above assumed a free page can always be found =
after
__alloc_contig_migrate_range(), so it will retry if no free page is found=
=2E
But that assumption is not true from your infinite loop result, the new
code quits retrying when no free page can be found.

I will dig into it deeper to make sure it is the correct fix. I will
update you when I am done.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_3079EEB6-53F6-4C85-A7BF-EA6F1E96194F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKHmw0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzVkQAKQ6/W+xdyzAtyX4xe8sDNyXqbtFw4jCx/E7
Iuw7mcSW3FzQkGtd0/fYe3gMIwx3arK9DorFCHVbd76Gra4INlHIt7jBUrnP2qG4
KOmn77sN1h7Mu+CWeTBZmO8rlcq7l3YB+UGpba8RJ3jV5cb4JJSxzZaHBonFWo6y
q3nz5v2UhEZFET3fYRCDJjq+KQlc0nnYeGHLBHtgx/sky8q4OZPzSP7nueGnf0Hf
2v/ReMtdFObInyVkYbRfqMxoLx3PMhN5P1tynOXhA8zi2y7bMOdLqB1bcT7wJJy8
9DS+qL7ABqCdMF294VIlYIqEpPEDnky35aIMXAD1sc61RGqC1kYhCviXRbEmsDg8
qzfCr9dOMDb02wgCdBq7DB5++eQyT4WeFDflppQQs1SDVKabad+qGCgoDZrBPSXK
Ft8FuiMIDvQeSypklyYYEvn1npvRfnuyyGsTPfpGWMRfqjrrX1+wdimF/U3lNcZX
CqC37qd8w8qR7RtoRsd+PySXPkDqz6LDtUIr6SO6RP/jvhJkns7piPVuIrfwCUC6
4z1tObtDa1shyXntL7WLWhvbMx97OxmXPlB49Rm5ekr0Fl+VyjtQ5RaWhFWYXX2V
AGp7dinVsTRSQo4d4xCKipqpdgOFl72w2jVHj/SYSWlsmZQg6WtPeDH5iPm4B3Hf
ixiBI0Zi
=Z4xu
-----END PGP SIGNATURE-----

--=_MailMate_3079EEB6-53F6-4C85-A7BF-EA6F1E96194F_=--
