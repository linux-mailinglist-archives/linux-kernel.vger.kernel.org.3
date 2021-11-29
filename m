Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612DC461C21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhK2Qww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:52:52 -0500
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:45792
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345295AbhK2Qun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:50:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbUUowUUSbWEip15l3UrDpMc/3D7Ky8ivD6SijG+yL4xLZYDnwFsFY/aq9Insmb+e2rhOAg7JQqByEMsfxPTRMt4W0ib29KnGvH9/yLHGbjYosiRt+kmlDZIEWjzWor5HUe2ygAKIgLiZTSHCd/04qXzCRtgpqlHokdgCWEzQ8vImSwdP0q8cMlS1HXWVw7tyZxN6rSN0c4MVwaQTJrnTEnCdcK5ayMgJ6QpluZQcBka7IbPzdFWUCYZheZ1tgxS3hPVjGHCi45pQDwGOf8Buf72TSkBS8ebONyln3sG0fz8T/ra/voizIDXu9vB8/BRpvtUG+Byfogj+bv415vgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XId+FMCcsKPYo2HuMY1pCP7KJGfvu6f6B8768VyZqJ8=;
 b=oJznZTYJW62R94d8ebZW3fr+qlEU8PoxLUqnmeNZ7sGjdbgXFM6IcYr7NLmo8BbMxC2IsbUNHk/zTLA7qHI6B1YwHwrOkrOtcYGWUECeugF8UDHu8Xm8gZ84XUqylhs/ieONF79seRuKlATLNtQ+Wr4uBTe1cYRYVRnvIPylCs+7YZemjKae7w4tYyB18z8iVIdVUV/DIwMzwsrywUU+BNAGzVTMBlPXALcWDWLavWMF6rE7ZU43Y/BN/+h3/r8NYYd02bQKwBUhrNzEZcUJz/vhYQwxd0Zt3B1OH6qD0x0xXLz4eG30RQUgJRreopGwgjBKkO8Mc60/Ho2t80z7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XId+FMCcsKPYo2HuMY1pCP7KJGfvu6f6B8768VyZqJ8=;
 b=awlRH7skLkyg54uBxBTh+yfUNEeo4o3xc5ZtrnOpKdZP8ITCesjQquA/4W6dSiH24vhHcjwZfO0EU6rRgG8PZX9rkV7wp7/ttny7mkEftFfsGz5UbDwER1t4mmOxkB4OS2YeyRBGbHSogm98OYbDDdvrnhACqYRdFB6M9byEcRqW1zYj8KuOfYn5t6j193eHjyXSZ7xxLg9viF/diBNQLG/ZXKDRV9opnxdoT+mGg7SlB4c2umqQ+rZvuIlNm4dQ1uPSYrhIHv0kCbCQmXIJ/ouh3tzMgx2O01fNhe++p03Q1HYLOxXjQcddzZ5C3dPwaLLugbkxBDDc8QTT2WBqEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 29 Nov
 2021 16:47:19 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::2dea:e478:592:6d66]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::2dea:e478:592:6d66%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 16:47:19 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than MAX_ORDER - 1
Date:   Mon, 29 Nov 2021 11:47:13 -0500
X-Mailer: MailMate (1.14r5850)
Message-ID: <F0D31D41-7843-4313-8264-E1C97979471B@nvidia.com>
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
References: <20211126134209.17332-1-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A0C5B904-3471-4B8F-A10F-EEF98A2B3D45_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:d4::18) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.59.46] (216.228.112.21) by MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 16:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfbd1c9-1a34-4117-e6da-08d9b357e830
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-Microsoft-Antispam-PRVS: <MN2PR12MB406315F8A775880CEFAF3498C2669@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tibwAUJwE+NQK/aQm/d/1rMjOrI3+zo+BW5lbL8KNXz5bWnTyaneNWFklx3ID79ugu2vVIjQCmrw/Wa+jg6UffrsT8ie5LoT4syeqbP6DQ8qOkOZl0G8Li6+EGihPwuJ5L9Q+WVbTdtDllW3piqA2+9QVuAd9Qk3u2KhPxgSGgZjiIx5OZtPYJVDdwFf7G7TaPJgRS8Yw0SfGuUqeiTWV2o8lxiTQLW07QUI9nRx6Q8F4j4r6cnQjcOjdcXUHq5cD+KUPeq1iDzySQQglOJL5x5yna8aFx9TcJV8U+UnykGniQBS+C/3ASIf0saDcPz7SgNHAJDrdoPQxoo0eXjXbIkVcW2FJvELKMeRg98aay7kpYFWNkXN4KkQZXCzR4uNEPJYgP/AYuRJrAJvL/J2ZFM18TrNubIdmAhGnsBDrOJdU3RnsSGBBzkvrEDvVLRa/Unj0zjrCLlwbdmcl2JXXDRzmncuAftKf0tNdABRranj0Tt685qo5pvY0kO9zV8SWFh0B/RnBGuV5cbHrd4AEJ/udPKNYUWj+/iEEhKNcalyi44vt7ubzTtlXmLI/hDEIU2u9DFuJ8tPFAI/QLSkdqzqGPI5y2MMuzWOhSiGiTnyywhdoR+D+gPDVYce2n+MeAGI/xCegkDGQvtmEQYmEmqtYhFQeQZ9VKRto3xWeKWDqZoIcDKCl97uQjq3J6ix+Y4rNb1EgooqCbQQ8TZwpW8fmvPYWuxAPycHpgrI4cJzB3uJpbW5Cjvx9zbm8YjSm+PjmGp+HhYcr6suRVpF+qwP9m4oD625pWpQeLhu/04ZpkpKIKa2E8OIsVVj3vbM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(21480400003)(66556008)(66476007)(186003)(66946007)(4326008)(235185007)(86362001)(16576012)(6486002)(316002)(6916009)(33656002)(2906002)(26005)(508600001)(966005)(6666004)(53546011)(956004)(7416002)(54906003)(2616005)(36756003)(8676002)(83380400001)(8936002)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3QdfLc+5H0KryvaSHOrCC00lbOZq96hUuOdEAhTcC59V+XYkK0xAnD6PSlQ?=
 =?us-ascii?Q?L/nP/5Wh5/Sx7z2AsElNw/qydrRy0gwbXmUZgycveKnTXrgXl6fP2LmbyYD9?=
 =?us-ascii?Q?UUpc0FBscSZGQkzNadqZ2CYHi7MMzYmfbhTyQHGm0V1mfpDVi4XKxz0WICsa?=
 =?us-ascii?Q?/cApJ6qOMCQ3llPYWpIFLCYDGJjGvry88l7TAFw1CuwZQUz7x1uCllkm4dyW?=
 =?us-ascii?Q?xerQqPnkcV0b+CUJmPFAPBFva0JAY2bOZ2fpCcio68c7thhMFrnNBsroocUC?=
 =?us-ascii?Q?Clyz7HCKbKhIQfmm+9V0DxMbL+mBvZoawDuI+sYO8La5Sf74y5mgcv/9AUYY?=
 =?us-ascii?Q?H6zsKF4UE132INvN49SO72ctRwDMfHXinx5a7po4ymFw13XpE5hz50i0ILr8?=
 =?us-ascii?Q?f6/2hdt74/VF12dgs6XNrCI+vXjEwCTaL2tIvLYyS3P6w1pwujoGfsTcJ+Ks?=
 =?us-ascii?Q?+zaQpZ8OykcV/RGGfUTfKUYp4nf0N7c2oaURFzKjha5NH6k6+NLC7QWeq2Pj?=
 =?us-ascii?Q?qHCCYmZrdVA7zCez4z8aiJG2MyBtPOx0RNcr9HQlP6Adq86XntO8WlqCHBwA?=
 =?us-ascii?Q?O0qmgukID5Ry+h1a2bMxezJm7EcSutioXNjrEyo0aNtYpkKttzo7keQXlHT3?=
 =?us-ascii?Q?V9mkrDiQ7fntC6+9sYMK/WbPZFZCgNbjJil0si59YgE5BMEcFRqjFhESwvFq?=
 =?us-ascii?Q?EIX4tPpD7YUIHTxRKWwVQtQlSQUR/l5dVw9xYCXR47/aZM2s3VmU+wlAb7hI?=
 =?us-ascii?Q?xXdtaHtIYsRx8nBaIQWcodF4CZvzgJ/CoEI8EgLhAdqVvp6X9bKrQ0De0+3X?=
 =?us-ascii?Q?iM1tJV3FtkXP6DmatRQnaSq2ANGAJhxXjS1CBPhZHSWOMZ6pzyzwi8qfC7Du?=
 =?us-ascii?Q?ysyKrhn47Sq+a30or76juLzXlu7RB+2wswsHhnFwKtWErtbYKS6fJQcgdbkX?=
 =?us-ascii?Q?nkGVGpoFwBhQItLwkeCRVH7eYZKSH7vHlymixX/v3OOtPvNxeYsiNjFtwd9s?=
 =?us-ascii?Q?p/xqK8oZFZzkbe9V7fBM6VcpbA+xLCXwyH4CgRBIZhf0wlcu4x6Jvg+adg5M?=
 =?us-ascii?Q?5yni25Hw2eFPTOv/zc/PdidkRXSKnYDrwXjVlpHghWOA+YwCFKMW3i4onLA+?=
 =?us-ascii?Q?fgdiH5nW5gCo+y1Ocv+xm25eKdICsQE4rjLW/+7rvBzvk9oL/AXYZ5kikgWy?=
 =?us-ascii?Q?bRhHIcm+cCK7RZK7Pxm1xCVSbY7AFO/1dpVbLdlIJBH+//O0IHZepDAbC/S0?=
 =?us-ascii?Q?KSz5ThWuuuszUfhYPIrndDPgymOnrvGeiuzNszSzh4LhXxvVdFqHZIcPIdKJ?=
 =?us-ascii?Q?6hrQ45wGXEsYM2M9yt7KRIpnHonirud6WeDh9aYHt31pvedvBRwMqmhPgVkC?=
 =?us-ascii?Q?cG0Hc4n3HlIevRy3JKdM6U7jwdMn5NPXRTrQO+Gj4TMcQL/eJLN3apAv2Isg?=
 =?us-ascii?Q?Sc4I9nAMuc4SuunPgstoFhExkqKsHLZMxywqqgvznsHRlHT3vI8Df9/WIW38?=
 =?us-ascii?Q?a9EmLHsJAHyE006QZqEVng9gkLmT0iKZaYQrHrQbWBFcQu6cP7bkg4paUxVl?=
 =?us-ascii?Q?JE9lzNIy0IQdKBcqhnM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfbd1c9-1a34-4117-e6da-08d9b357e830
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 16:47:19.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ankjLAoaljpRUYyKWrXpWQ2gXS59lWWeB5U/6f/mCqSp3GYqQvEaQpjie08DgE4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A0C5B904-3471-4B8F-A10F-EEF98A2B3D45_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Nov 2021, at 8:42, David Hildenbrand wrote:

> The virtio-mem driver currently supports logical hot(un)plug in
> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to suppor=
t
> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
> flexible, and to improve hotunplug when using ZONE_NORMAL.
>
> With pageblock granularity, we then have a granularity comparable to
> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so=

> we really want to decouple it from MAX_ORDER.
>
> While ZONE_MOVABLE should mostly work already, alloc_contig_range() sti=
ll
> needs work to be able to properly handle pageblock granularity on
> ZONE_NORMAL. This support is in the works [1], so let's prepare
> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.
>
> Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
> limitation in virtio-mem, and using different device block sizes (2MiB,=

> 4MiB, 8MiB).
>
> [1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com

The patchset looks good to me. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.co=
m>


> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Hui Zhu <teawater@gmail.com>
> Cc: Eric Ren <renzhengeek@gmail.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
>
> David Hildenbrand (2):
>   virtio-mem: prepare page onlining code for granularity smaller than
>     MAX_ORDER - 1
>   virtio-mem: prepare fake page onlining code for granularity smaller
>     than MAX_ORDER - 1
>
>  drivers/virtio/virtio_mem.c | 110 ++++++++++++++++++++++++------------=

>  1 file changed, 74 insertions(+), 36 deletions(-)
>
> -- =

> 2.31.1


--
Best Regards,
Yan, Zi

--=_MailMate_A0C5B904-3471-4B8F-A10F-EEF98A2B3D45_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGlBBEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK75kP/R1sOzI0YDQl5dD1mpQq/2Wtybr8u9omdWU9
Lna/VomciLbyIVjgThF8Q67Pkzs62/YP/eTJyqbkLHFaJmQ7DiAUnELVbOgyrA8Z
0BtNK2B86LIhtEpzx8fflyO3cD5bT4BprOcgKnCKGIQ5PaHf2+MjJKVKkUsFGOOt
a4p4JQP1/aUl6EUt9bjsMtgp4H+8vkXcmBIL+yvmEvtUs7OGqOJluYCCyRVxsP2n
DLoKeHdhuifZ2QRH/TVmAkw8NfEmm3pntG+zt5+QaTnvMT51BjYrSChBkA3C0NxG
mCj3H0pjCTCQwY5RW8ooRu8IU9BBtttNG37T8lyOLpPXBf5H6hZd7x4Xqv7xFbyY
8WhTq2HRs/tCTlP+ADdZv3LqLY5UT1VxUJvPpq2VN7ef+zDtnnUxfR1w/9jX5yyr
FfIFNvCAxihl7kET5pPR0FWD6X1yjbpsHIZH3akO7NtG1w3i8AvX9uaD3d8HDOUC
cAXYt0mQs4vf6a8FQmpOCiOaRX+OY5L6s/oBuEUqSAKVs8f96vVyLVP4U7EWF0Nt
xdr1eBXem5w7YjuTzDmCJSEHPTG3iZnb9SjTM1frZIYxZsPRwcflgb1zE1ZNl47A
aycOS/19TDMByAiD9hfjocbK8iepo2x85YxEMcp0anskmxnx1pcqLHlXfCR87wYy
Abe4WrvF
=gRct
-----END PGP SIGNATURE-----

--=_MailMate_A0C5B904-3471-4B8F-A10F-EEF98A2B3D45_=--
