Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A422352F55F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353751AbiETV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiETV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:57:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1A18C059
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Gm5G4k6pveMN9NJkaiFTPAGu7OpVtfHt62s+D0ab1XgcDnySM9vXVg7GMIGwdcc0NQZ44oqjt0806lAJlmG3boGO907zC7Nxy8NQd56ourNdjQ9lGKdW/aJjtqysdRBpkjHYArQ2+CGXISCqYn8H2gqF74t0smXPnjuP77LhMePM0QDYG6YgnRBylca0dVnF3Uoamz4eENqHet8jH6H41rFSJCIAgqcXImpQ0b0JKvNiwZaDvKfoogxhBq3AqLMev0ZKad8vZOPEkbtCRKddH2D02kHtNT1t6Lngua7PcNwy9dTMeIHLW1RhExIDeOeIMkt2vSQzt/zbGeqpvJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbrAFuI22vshKHzF9XNAWPYJ07VDjOKeBOI3ct2QZHs=;
 b=Cm4mg2gPbnfNW117o8g7n8IVkjk5BQgo8FCwaNKLIjyBoWBXyzk+FsUH9uPgYU/CbM97n+0gS9JUMfrT13z9eho/AjBRCIKg40NkikIYlhItzhOOzolvAeyTYSfB+EHEX/EnXO3uBPnBYlhi239qYiqPdqU+0sEAV86x9rNfLqjv32UdU3xjJuNzbZgQ2skKmCPy6qTL3crNoTA5y06HDo7XC9aFgoS197YZfAcTNWNAbkHldAx+RRexxoQrRH4948LYspgUYMDfNHwobB358GptQS2a6pVdjgRllVa81oz7B8ovh031TjN2BoWSyZ2KETbkjAjkd265u8L2EzS8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbrAFuI22vshKHzF9XNAWPYJ07VDjOKeBOI3ct2QZHs=;
 b=OA6nlDlg84VCjSaZHEM35T8U2RPF2nfMSimrDXRV4EMVO9OOAt/LteGdachEWDSgZO1G3doR6f+VhCffV3DGMihbV+st7b+u/8xgOLuwW2GsyvP0AWpoMpFymniZTLqmq/KmLJjM3Mx/2GDpmZPHY51Ry2Y1NhXx2LIVbclQBDj0Bjvyr/sVtkmSMun9XovXMyeAVX7t5jisKR7Dj89J8C7VNUG39PfIFLyCGUY6eToC37Da2wa41P/rcW+MhrzhAGMxrWOv9EgdUOJp2VTL7167bOcJX6cQ8yAKUGW4qMoRsSiUm85B6Lma7mWew8RP63DuNcJlYhd0zAIYKk28/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 21:56:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 21:56:54 +0000
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
Date:   Fri, 20 May 2022 17:56:52 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <C1636974-A315-4E0A-81C2-845878429920@nvidia.com>
In-Reply-To: <Yofu5wUgov+2eVCE@qian>
References: <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com> <Yod71OhUa3VWWPCG@qian>
 <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com> <Yofu5wUgov+2eVCE@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_0AE5638F-1356-4F7F-A5FF-89BDA0F4413F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7041f1-c75a-40f9-7194-08da3aaba717
X-MS-TrafficTypeDiagnostic: BN8PR12MB3523:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35236F81EEC039A5D54602FCC2D39@BN8PR12MB3523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVeV6ZaQVZnWPXhiM/6HaegIe3ldQXIRUs0KyG01CVQFEjq9Us29/37xZ6asfwDT2Fnf7d6seqXXlvK73SAURxeKct+gXu8OHiF2v0G48tU0K9PE5KojfNhbqQwYauH5HWohspTLW+q0K8F5u2QeZQ9XhayCDqfw+OyKmPH3Gcy8n+ty21Esbz5gtZ0EOK/lHRv+OldcK8Eznyu+TKf7V+vS0gUokeKH0Azw+kwrhRC2bzeuH8TJgls7aNEYyEfRqihWDrSMDqpvOvnrl2/DeYyNYfue7Yy0UD3McxaBHJocvT/012wmu/E7lv4skbm3jvI7GR3eg1qis34BkRSWei/7BhRG+DXWXA/TUIGsa8Eeo6fFHapjpq1l98zKIHQmqLeCeKXwPw09YSFeB+qqOlAdhfGGoWBXk5HbkxqQAHAj62TiO5KsGdZQdVKZkBLagGGI+E2n67oOeyHqleo0D6OmAMvYy76Ju/YjPTMPwUQyJJmxw/urt0f+ceWq39PVicRoZ10Pnz/ZqoMmWWNsTPM5y1cK766QLj5MSUwY2dX1wKLQeZ8RFgQ5yeul/W50DmK0kGmTh3oDa+RNPHpyK/yGT95jjbnyt5LaKJWwH+M55n3yIoP+3HQ/sSndFmv55lazhW1RQw63/W8kKXiBAU3ta1lQra5m9cQYfY4Bua9nVBoaz6Rl8JmYoEFHXczk11+KvcsWf5BMHDPg8VD4918cnn0OMpxnpShk6QPIWN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(21480400003)(6486002)(2616005)(8936002)(235185007)(66556008)(4326008)(8676002)(66476007)(66946007)(508600001)(33656002)(5660300002)(2906002)(53546011)(316002)(38100700002)(36756003)(6512007)(26005)(83380400001)(6506007)(54906003)(6916009)(86362001)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMwyC2pJhDsmtCd1TjKb793efwWh9H0C5V/nF8HvNIL61W6TmL4bNt02UzLZ?=
 =?us-ascii?Q?tawPUcp6dANd+VToqZOkwaT+fnUf7H5gOTIrLF6AyumILRDMHgD2Nv+7BaOb?=
 =?us-ascii?Q?WxEBA8hNP/OW1/A7Ljjqumimrv0lbyqdZv2XPnf5dIaQo5gWWA0rKBgJr5cM?=
 =?us-ascii?Q?mpSzDCqW6L4EuflAo7BllLHf7+m1t1KUZ3g+X2ud9JBueMGc15sJxWlg2iLR?=
 =?us-ascii?Q?8JcxRBw3EXoqknODKCFpmx3v2BQv2zKCLGw6b7SK/Twti90Fpq7MOIEQWI9s?=
 =?us-ascii?Q?UbYuFJn2EcpQi72L/Smo8vZ+PTLEFFNRX+SFCTMt/OK46EdaqFuObYdkZAQZ?=
 =?us-ascii?Q?kjMe5WhvJW6dEVvM3KfXiYNyf5lGF5qqGd/lqG0qDel1DW3VJlR58l994uDg?=
 =?us-ascii?Q?lPplSZt/T/7X8LyBQYFgnMjAq89RhW3VvBnb/AuQYK5Z3GDg4risuc2g/QlU?=
 =?us-ascii?Q?Zxe1VJUgy2hrACTXRVatJJP/KAK29TeZRy0KE9Iu+b/E/tOFFiv8w/lO+8+p?=
 =?us-ascii?Q?aUuy8JPqlDgyT485AaLhTlSpx1CkbCsp1ZK8U2tXYKLriPzAcQIKZJO0ZBAZ?=
 =?us-ascii?Q?otKneBVLkcsuLYte7rglL4T01Ht454+wd1I0I1OREXDd1PTyeHzHXQiteXBr?=
 =?us-ascii?Q?gw972vfQrjRL4jrxv0bm2k/6O1UUeZwyar9nGCtP0EO39HI0DQRGsL/TkrKg?=
 =?us-ascii?Q?YV1nOywOx1wRSyfYLb+o+bSyWJwJUPpRStXNwsoafF5vfKnd/bw+HBwJVJPY?=
 =?us-ascii?Q?KPfT4zJ6JoNr3PvA3jJaLia5oGTTG8nANx7ksm0OG6kTG8pc8jAzy01O3G87?=
 =?us-ascii?Q?gBhcMcmfKcZ1R8PVWyb0j100+fr7VZtn3fnQKScd0OfLm4kOHk2PlWGuCJgE?=
 =?us-ascii?Q?34uHoRfs3HRxQABsh0ycEHQG10ggUpw3ePHFuzLANFjMnRhXhlUQevdw736t?=
 =?us-ascii?Q?/n/fF3poZfobH55WavpQUzZcovMs57mWBZCAU6QpZB3Il2tmG3OIs3AOD2H3?=
 =?us-ascii?Q?q54yuPhMiwjudtUeizFdCYzYxXG96vun6VAVfb/McYRxECrDYr5AXtMs0t4J?=
 =?us-ascii?Q?17KW7koIRH23Dgr9L0r+D/ClYe1sjrJ7O0NaIelqrR5Bzu7Rw7sPdMNuBfF9?=
 =?us-ascii?Q?t8Yo3ls3dXhGJRvomuKRrdzQ70ScYUPlB/a1tV8aY2fe3Rh0vYOFIOcP9t1m?=
 =?us-ascii?Q?aPU1tlBeyoGGZFMts1imkgwvRu7LTBr4TYc/6Zaw6T5n+gLZkVY4U9Ll/Veq?=
 =?us-ascii?Q?JkCqQ8YDVAvIzQ/3ZE4xqxnjDPsg0tcXWvTkxVir6pLuy4Ct11ezXRXSh4S6?=
 =?us-ascii?Q?wQye63ud3yXtIf5OfbQglLiNzajrmyyfocBurP7rfw54nr2uGRoM4+vzGAvN?=
 =?us-ascii?Q?t4UrokMFQqTTIKZzFIQUFnwiDp9YzTzEQvagX8ML/9h0fEE6AhXhPVMh6nQR?=
 =?us-ascii?Q?RBd/FlnDF9YRlswfwi9pLyLHEyYn4HwMOI4CfQyacIVVKW0OOBCHf1gty4QI?=
 =?us-ascii?Q?2w4Om9v2X32taE7pmKEpCL3oIZA85zUG1mjpZ67EQCy92XKjIt8Td3nvccS0?=
 =?us-ascii?Q?TAc/DrIOs5V2llfDzD5Ac+dtkAL+fp9z61pmiIZDA21IfmNf1ARMLzY4ZNCa?=
 =?us-ascii?Q?rT/FA0WWqNxJBpI9anYYepSyKnm+FyNcJsJ5lS06fgD4xrWAvsKWo9O/H1V5?=
 =?us-ascii?Q?q7crRPtc97h8RqEZ4bRcv73RpzhEP3a3b3QYJCgRB4pWJttgzxdFXos1wFF5?=
 =?us-ascii?Q?4z8fKf5CYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7041f1-c75a-40f9-7194-08da3aaba717
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 21:56:54.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHS/2lGkDY42j4cTZ71B3GBLcEsWlktI6VlVQwWdZCGr0fw+fBjc2NqGdOSDqx63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0AE5638F-1356-4F7F-A5FF-89BDA0F4413F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 May 2022, at 15:41, Qian Cai wrote:

> On Fri, May 20, 2022 at 10:13:51AM -0400, Zi Yan wrote:
>> Also, do you mind providing the page dump of the 512-page compound pag=
e? I would like
>> to know what page caused the issue.
>
>  page last allocated via order 9, migratetype Movable, gfp_mask 0x3c24c=
a(GFP_TRANSHUGE|__GFP_THISNODE), pid 831, tgid 831 (khugepaged), ts 38998=
65924520, free_ts 3821953009040
>   post_alloc_hook
>   get_page_from_freelist
>   __alloc_pages
>   khugepaged_alloc_page
>   collapse_huge_page
>   khugepaged_scan_pmd
>   khugepaged_scan_mm_slot
>   khugepaged
>   kthread
>   ret_from_fork
>  page last free stack trace:
>   free_pcp_prepare
>   free_unref_page
>   free_compound_page
>   free_transhuge_page
>   __put_compound_page
>   release_pages
>   free_pages_and_swap_cache
>   tlb_batch_pages_flush
>   tlb_finish_mmu
>   exit_mmap
>   __mmput
>   mmput
>   exit_mm
>   do_exit
>   do_group_exit
>   __arm64_sys_exit_group

Do you have the page information like refcount, map count, mapping, index=
, and
page flags? That would be more helpful. Thanks.

I cannot reproduce it locally after hundreds of iterations of flip_mem.py=
 on my
x86_64 VM and bare metal.

What ARM machine are you using? I wonder if I am able to get one locally.=


Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_0AE5638F-1356-4F7F-A5FF-89BDA0F4413F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKIDqQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUEmoP/0dgn/4JliFwH1B4iuKCmUKjtwy9gQP35O+Q
QBmNNiyS9V/DPUqtklXy2bScfAdM3VouC7gdnIZBRDtdnLWnoQgDGOqnFNePOrjj
ePhfdtFcEwzl1GUwDVchTS7Hs3J1wGHa9R8dvPWJ5Wd/Emvt73vcKHkl8jgKzPwO
hww6QjjpIiIfVf+Fb1KcsuXcb9OOs22bSLVsQo2f2QuYAvATTaofJARfPcgDw4vY
pb+J6dKcgfslmERkcOwvrq1q4uWpcVBi4AefNFqMuJtG0q6E7E10sByLLycSJCvE
kT/MW+Gu9tzNcivCyYJmgztCOFQCSI7nsbgKeRZRb471z9fObDAKsIHDIS363OWJ
BeXtO/xNr8ieUzeIqlbP/F5qam3mra9HXbiZllYyNVGv8AsoWi58+hCM3llpmD5x
SS4izOFyrc462j9/OR1fV2Z031b7SYoCjx9Qdie0rAp3WZ523WWLZFMcIz7P+3Mp
vRFuF3ux+FPVEy34l90B35RmY9083MC2cqhmsHIoiYh//5pa+fL67mxnR2A/UV4u
2dc3ohFo4+ny/tSqtrfAnKT0a3cbhu3UDvvpx5kCyzIN3NLpgZmCtINtbGmTCga/
EAfYOQaKYIA9PWfp7g41sMtB8mBG77Q5nbyXZY4WR0q/DUZeZhap/OAw7Au+2Itn
klANYgLj
=gmPn
-----END PGP SIGNATURE-----

--=_MailMate_0AE5638F-1356-4F7F-A5FF-89BDA0F4413F_=--
