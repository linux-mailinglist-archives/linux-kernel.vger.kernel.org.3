Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F0548044
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiFMHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiFMHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:06:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2033.outbound.protection.outlook.com [40.92.40.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BFE1571F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngh80MwaR6ONyL6ZS2GOTdb7Kp1pfEWF5Wv1i+uFJM5dQMgA7i4A3F8K4opLAjKk/6Fc+3YAzLZ9ewp9a3PoL58n65/l5RJm5KvvVeUb1+AJHtLCSWzoDmgV5h/yNKJLkpxX02iKlojcY4ue+CVijFz5ZWARoVtBCOoO3YuG81qPYRHhHAfKDZ3j8mQJ/HARhAmXiLnEDdCnDjA2OiOpHDU4s4CQQtOFoeAyKUuVhCeTpI0nxohPG4zIZ5xoJbJqbXeYkrO4TSb4ZGxu6+49a499eRV332E3/m3mLAB13acQ2QriKvAb15Y6s1qTKJo0Nod2YAQZJHQSx2+aVSo2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reqVANxZH2cQ80rxEEFPpiOg5vJMzTNBwG16tBk5T3U=;
 b=Z3z0FVtWLZwtOe795p3sCI7afC7PVWwxZET7OpUGzQeh8UtLJ2guqEwPvIIEQmJt7jDPNihTHrvv0gjkxY6AkU006p2DOHtrOfbS3CtDsFGfC25FdV5Ah+deSo9arxrT5dElLzmBA/rQxqSLLR9OjChjOjBeSeXJS9le2WMqh1HyR5LpdkUK1hor/M67wy42mKArXb5+rhwYpoTHoSIYtLkMQpQ2WOm1Rm4N3YpwCdasAOIus4qLyUsDrlhZckoNwr4q1TRHscH5iMXyx9EnfOGjKyX7Svpb5PgDWx4M45r5OE8gAgHVGMGNIuPdzO1RnRUf4eZ3iI/+EPtwFzf9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reqVANxZH2cQ80rxEEFPpiOg5vJMzTNBwG16tBk5T3U=;
 b=fUrSW2t7fPLtyMrzNTbULvLyQK8Wu9bON8oukKAqIUqB/3wMOcEMdKMmGUVTM+olVTfpt4FuAQy2iME5CfM/lVVmh7AGCUGyNHRal3osvJ1G9RVAGTf/GjALds3YyvX9xYvxfODJPVvQMM2brVuEHyeQ5CBF/gcCS6MNcWR+79rA97wy4T/kqAtTyxEwfHazhq2YjQIuuXGzZgwwvGPq96YNXus1Ah6f12GhV0vvxA3yPUyDEM2l+VIorUPPJ9afGOliOGOI0Dn2hwmf2xqn90O3faxhczpXwE1XJTrvv8uH5q42njfY7Sce79UzC0CvqBi0rK4cEX0h2tsdlvTwMA==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by MN2PR14MB3055.namprd14.prod.outlook.com (2603:10b6:208:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 07:06:38 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f%7]) with mapi id 15.20.5332.014; Mon, 13 Jun 2022
 07:06:37 +0000
Date:   Mon, 13 Jun 2022 15:06:32 +0800
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Celeste Liu <coelacanthus@outlook.com>, xctan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>,
        Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v2] riscv: don't allow write but not read page mapping
 request in mmap
Message-ID: <PH7PR14MB5594FC3D152B9D679CBDB597CEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
Mail-Followup-To: Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, xctan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
References: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
 <CAJF2gTQjR_iqbH3ee1GYRnPCQdn79p+vK5-FiKZiTQNZFhPyeA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr1JOsbDIfhZ1bTL"
Content-Disposition: inline
In-Reply-To: <CAJF2gTQjR_iqbH3ee1GYRnPCQdn79p+vK5-FiKZiTQNZFhPyeA@mail.gmail.com>
X-Operating-System: Linux Coelacanthus-laptop 5.18.3-zen1-1-zen
X-Mailer: Mutt 2.2.6 (2022-06-05)
X-PGP-Key: https://keys.openpgp.org/vks/v1/by-fingerprint/892EBC7DC392DFF9C9C03F1D15F4180E73787863
X-TMN:  [Sr9tvYOPW32BGkxPdO6ivO0rpoJUUl27g//yLxnhLAQOsuGqnZVvRubprZEE2YCR]
X-ClientProxiedBy: TYAPR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:15::36) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <Yqbh+C2/VZshR8ZQ@Coelacanthus-laptop.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c669d486-afe1-40b7-cd58-08da4d0b420d
X-MS-Exchange-SLBlob-MailProps: zswcL9HXbeX0Z+F30L03/a7lqRASefvb7ydwfjpMoU5v9U4HKL+ColH8DQKfChXM4ek/6ignfVp42hDrej1Du5e9U9G6RlvuyyqNQ3Ko0EXSOFpTiC5bqGoKpdqyJk5Tyba6txX60fqfgD72Z2yQVYaBn2QreWGR8bqUkZD3pFDPC5VWHM93qIXFTWQMYVBK78xENGcKKG2W5wEGxKku+OmZlJ7ExQXmq71npZ0gaNah0e9xK9ctI/IGYpmfw1IKk9Rc7KPTAD/Tz6GF2CfeuiBsHEVLPBSUNYEoswgezu8I3ekCMcVOjS0Zx5EZbRHe98Ne2otvW5hKxDcnTHUvlthHWqz7RFWcn25aMf1hlQ0oid5bSD67V2K4ZzUm4OURqD7ZJwYIyS1fi3cp566VzLybF76Jkb3AldE5UVqB8JHoUD5QgQOmopFy5ViEBaBUeUaI8LfCin9juAcJq6o4ctdsaY0YOcM6z5Lq7ZAQFPLcbNLGk1U1Y3gIvVGacGOJogX4MyoZVAjxyF66mMkUc08Dcm8OaYiehYMPKtEiDJ/eNBQmui6mZ//KUVQbADJrtDlmjh+f50mdZBsC4N0TVz57cd0d1JvmODz5ShZn9gWaKNeRKBFm1qCxFQLgB95d4yLQV8R6K9/QhqlW88QUSaIH/N4SSVwyYFT4geORA1xbNAKqnYCVg60iVAuLxmmr5660LltvPtTg044Rr//B5KIZqLCHKJ9yN2l7ZqcCe0kwZs+984ztazd/MD8o8nSc
X-MS-TrafficTypeDiagnostic: MN2PR14MB3055:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXAtfCgDBHNVInklzNQIzuUL3Rtwjf4QqlBR3AD1FU9w9lwq/RdeZNzLQCKPB8QxNq9l5SgEzeqW5VH/lu7KEbiGz8PoelXzJfOui3K6uxvZVbEfMfTbEBovAdO3sTkazOk5KxqTCW2pKDWi06bXGgRgMotmfAFN1+oFJHrSW9prN5A9zQtTfefA3xqq9fbBz3F1ecuCAbu/gLd5dasLGOKosloZ0Lpx+VBUPE9gczfYn6HkDSwYIiGVtkj8brrlMcOdvjvk4ToPOFoWfG74cmTYq0KdavmYWwFi+Nl8X8sEGEtxlDIdO4KCvnQa6wVeqrWqEiEANED0uQ9Ri+IGNEcFWuTpoQll2UZ61zmXwFwJwbsV+pFqc9wPXHmiqJiC1MfLnl4IW19IQxK3cDCsPfBZobxX0PHO6GSooUOgN7EhOzB8wwrnooeeEoG2rm04KVZAzDQbvF2yAg/pg5QNQixE6h4B3l7Yo2ZSkSi1zrTxET9ZRovEMQj7vudQO/rkRQq+huCKiAfFyWJFFM5GFSwkwgRPp2/gZHI6v+NXND1fdIetk4+1/E6ntBMLDNZSQfPIWJZCrtZ3IE0OJFsRzg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsyWn9JDIBdsrU0DYBztq28MW+sdOq6ADPs3kmn0vhRD3uY8z7OBaEUJPvZS?=
 =?us-ascii?Q?M1HOCWnP2qykEMKyGJJpz3OpwmZg3iwRBcDpsBtQEBIsSLigGruBLXWCT9hX?=
 =?us-ascii?Q?hyqkV4r08b8lcjIpzP4Ly03hjJ4bJTaA3NVKF6uzGi3vVfc2N1ZjVdFf45HX?=
 =?us-ascii?Q?biZrAm7o9+8N1F8D6aJpjmjVEyS2t2LSMQUbCCioNBPlbyPQwrkJdz7LNz8H?=
 =?us-ascii?Q?/9dxpD9XNTBnzUEnjX364YxaKLCLVslIDYZyHy2f0l4F3WIBKSDGTuf4wnby?=
 =?us-ascii?Q?+vCMbuKpZVJjPqv/ihOzI295wmijT6IGCgNF5/WLzsCWVGMIdMKeqK/K8Job?=
 =?us-ascii?Q?tTOrSOmMaIWT8lIYMKTzvDY0D+a5kB81yP2lvdeUyd7EjNhF17Dwp/l7lpNJ?=
 =?us-ascii?Q?WoWRRk0wKaKg1QJn+/TLnZpuObIk7DkGwq73fGT/spFgPZ7JPoyK8VJoU10L?=
 =?us-ascii?Q?0fXocF3l5XcpHd54JPrp0pN5HbPFv220le3p/Ov9SsrEP7IHjIzE8VPz4kTw?=
 =?us-ascii?Q?WCC5fU3Q/QEJRxQ+MoR0VO4di3FHEiR8MZE+7C/iszg4+Ll6mKlS7YCJN56Q?=
 =?us-ascii?Q?fCtCfWBlYOgPD9lg0mT1Uuex54rfUXwpGgPmzs6CWNBNG0zubHnzKzahUa5o?=
 =?us-ascii?Q?nDZVn+Fy3+k7ufsWhNfPRJmXG/LwMd3ZXgQKo/pn01aALjPQGpimNoeoLwmu?=
 =?us-ascii?Q?vbFqBMbPD4s5e95O1okD0B0yWh3bpo4gVwvSRHn2YUPtZdqzF/GCaeeLXjUw?=
 =?us-ascii?Q?f5OPMkMjvZ8wIUGx3JgNed7i5J/sQeSQSorZPYKcmN0266M2PwkKvAXoskHa?=
 =?us-ascii?Q?k6u9+iSAaNMBH9dZ1HWh5d/1n42vnAryw6aUidx5blU/zRXrTNOXGjC54uOj?=
 =?us-ascii?Q?GcYa548KlSHRR4jicGxlcysEzHCwECDs6tRUI0asTWFNyP9+o/Dv9caMjZib?=
 =?us-ascii?Q?YfT+JGmKWqFsrDgAosFgE74F2DBoe3GfzRqwEGHaUAs12sDiUz6J4Vwqj1ZS?=
 =?us-ascii?Q?vgD/5s+TQSku1Sq/c0VLE/+P4dyRHceQ3YnBTnhIPpkRJxC09BSKTGk3mgRV?=
 =?us-ascii?Q?lfMhVgD2rdA7LxlgHHfsVhCmp7AFbpPr1vTXEq3Ijk2vjIDPiIPZV9XfconB?=
 =?us-ascii?Q?YQ+cBlS8fJT4XPcRuvMBGTfUdJk538sfqxcpqC1I/NwQG0kdcRyxEtpEdI1n?=
 =?us-ascii?Q?n8zCvVw/tRH87erZXxAIAgexQsmQXbouBqIZkO4idxCfAFZWV1r8LCsg1wqw?=
 =?us-ascii?Q?LIS9EvVNyMj/fg6a5zqamG9MLSRXG3aQvLik/tehu3SrTXAvAXMa6tB4B0rJ?=
 =?us-ascii?Q?8qldCVVeQAQcwq6HGmCLqZROGG9CJVgtyuhK+gybjNl8hf2KwsTAzDA2YDsn?=
 =?us-ascii?Q?ldcFV8M6PsqVKMLnkSA/IVEgUFHkK7fSCwbaaOh0wqrAtcdHOYbkEftyo5G3?=
 =?us-ascii?Q?+W1m1suPesleNHpGcof2Plwq3SmTSqg8FHmlF2kr7CTzeeTQ7IGlIKcOPdvx?=
 =?us-ascii?Q?uAXIICm5EWuWPp1pd4ggF0nGWGBSXIMh0LVm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c669d486-afe1-40b7-cd58-08da4d0b420d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 07:06:37.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gr1JOsbDIfhZ1bTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 01:44:28PM +0800, Guo Ren wrote:
> Yes, PROT_EXEC would prevent next PROT_READ check.
>=20
> Looks good to me.
>=20
> Reviewed-by: Guo Ren <guoren@kernel.org>

> > -               if (unlikely(!(prot & PROT_READ)))
> > -                       return -EINVAL;
> Could we put your comment here?
>=20
> /*
>  * As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
>  * "20211203 Privileged Architecture v1.12, Ratified"[1], the PTE permiss=
ion
>  * bit combination of "write+!read" is "Reserved for future use.". Hence,=
 don't
>  * allow such mapping request in mmap call. In the current code[2], write=
+exec
>  * only is marked as invalid, but write only is not marked as invalid.
>  */
>=20

ok, I will add it in next verison.

--
Best Regards
 Coelacanthus

--gr1JOsbDIfhZ1bTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQWueXrpnXi8KYNNJjjXInkWGeuNQUCYqbh9wAKCRDjXInkWGeu
Nf4oAQDvLbXtJISh+txvt0I1AGMK4/bmfxvBiQHisQGbOKQhUwD7BxtBjfq3KCum
ox5Prk+0YAPOr7ST3DQlYYxL7MLCXA8=
=fC/4
-----END PGP SIGNATURE-----

--gr1JOsbDIfhZ1bTL--
