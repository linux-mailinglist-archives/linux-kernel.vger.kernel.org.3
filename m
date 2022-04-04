Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807C4F178D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbiDDOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378278AbiDDOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:50:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10E17A94
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyAV7dmqrbMZoE0y5UX+3wflFma3pg7tvkZlmatF5NwpHRZ1Ilu0vQuQGLuBYvhUv4wz1Tda64YNwsWJ6IAgLDmDtWxqud8km/FM6teU9ktfVz1+3ZwEko4nN6U6ssKTerD5ypSdiYIGhboMi9NLbRcA6DqQW3jfhn/V6jcp+lb4/A89OZlRZ69PEEGMNBJairzfSm+LVuL31DC1l4mCYSDH56gxJdM1B07etgeQRm6RaOSvevqd/LKEVRtD7T8ZQo108nyRp+VgyKjqe7imrn+HtkRHdBNhWbindpRsCsJHqDlikWXQNFT+3ixhUE4BbwS4hVLgrrAtOIK9Hm2FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZO4i6RReTt+4gmzQ7UwYA+Jl9vn8ET08NUK/NJV1gU=;
 b=P4dYJEm/rfu9rr+dekG0DsQNV4TIWf6nI7jIg/qkRj6SjPDLFNCgLSxQPXtVxTTQuG93HRvcCPlGSSn4alV0WxXtXG6Bn9jWmNrfsxGKb23P6pnXomUsg9bYgQwbCdhc0lBPVQ6w0MGsvTpSZl5AJqRq5wYVb1nDkqFJ19wbHN2178cToc78lOwig05/buEjRnOrICLqHatm8GVrTjTBDqnHqbkfnfhLiF88eje7dKGoIruztR7WFL0zNcLSOhR+MdC9mMYwygPtFMusCEutaKkgMEdVjjMNtmv0qz6ePdlRvLuDN8RXvt2iG5eN951bOctGRKUIMZx17EEpuZEg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZO4i6RReTt+4gmzQ7UwYA+Jl9vn8ET08NUK/NJV1gU=;
 b=BKEG4c+5BKwYwIErYoQkwqA1s6YY0ctvQN195w3B97ts2aoAlMePmV6luvDb7kNHxI2oC7+/eBq9KxEinqT8xMrOifntLoerx3B9EiauBn4rKDZNVr8wXWB8uQ+xxkNgRdyVAXvBXOrXmjGz0kr39zl1TOrtOEM8oK8+MIawtPno2iGYGOIfk3tJgLJIy1rgPfjV7gjgadRgIJ6q+xpqmIrAGrl5GMp2SE5QKPfzshcEM3gB36R7me/prK3VjTeBmP/pnvq3MFbZqgsqcmj0a4tSRWTWonj5+cDWPIW4o6OtYgsuMeBVEJAYKHi5nb57INnZifkRe0q2MU5Ef6k4uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:47:23 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:47:23 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Date:   Mon, 04 Apr 2022 10:47:20 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
In-Reply-To: <YksAub9UccPZa9DI@casper.infradead.org>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
 <YksAub9UccPZa9DI@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_790DAD05-CAED-4973-9978-3BCEBA3139A6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca7d3bb-5f68-456a-93b0-08da164a0741
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2877B1E5DD1FDC81A8684FB6C2E59@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NaE6T45AMpL8IU2s9jL8mlldLzqBH96ZytmQ621qE4P4WiJ64lcBERZovpcCTW/t3j7xlXr6ehZP0QFQ1I5JBQO8Ks8AAwKJcRpTFiDgZJaGomiRPcTqOk7mXpFiF2G8Y+0Wb43hLVZqU70g9hQyhBjmW810yF/HmyWesCOb2K14FMBy8qwpK/O6jlsAMZv7BvpofT6RUQouA/vyp8DhgoQ5zudTuwOgE5OwL/ygmCGCar3FVmL1PQ8wf549/AJOXxdZkQAX0LyWHw4ID+8uDPgp2cnL9zpvogsm0FtZrchcr1979D6lGoKu2kTxbC+PBqQuuNuaFWWDVoztiT0DywRLt9NtHEu2Mb7Zex5jhgX77vXD8Ar55phzVFgcX008bSfTkT0I0JTQe6bJvmK6qd5wo4rcaGzFCZiTLdmQmU7po/RoDqZ24h0CaKYkKZ1S29D5w4uoT56Dxo4nnHWvmzLaYOa0djYgmv/JGqX0ZFOnrUQ2UD70ARHvMH5uSu0dzxsLO9ZbAlTdy3cGOmvASZnqQts9eaYmtYGZohs6TCV0mqVSiQtjqs0pq9RYZ2dXfy+IUgdrlt40AxXBeCx0UQ0qL3tb5Q15YgQ4DgwkClarrjP1VFV8ypwVdEo/ZlUCN/w0y4XbH8mLHmbtcmvqFAkV6YOptt4CwIRNBIkNuzsgfT7q8RCz9z2YVAmA3/f3N6nfiCqj5/LowEz7U8Lf85xu0YcV38r24qFotuny0fpL51rc98UMB9K+5ObvuB/QsAZUH3OwTzsc9HpKbjHFPi0kYzvb/BnyIYXTCNW5w0RoTGJoOklGpPLrfJr7OgF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(6486002)(36756003)(966005)(54906003)(6916009)(53546011)(6512007)(508600001)(33656002)(6506007)(2616005)(21480400003)(66476007)(83380400001)(86362001)(8676002)(66946007)(26005)(4326008)(186003)(66556008)(235185007)(5660300002)(2906002)(38100700002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3rBhHJ9tADhJNimDfbvSEt9mTLP2IPV7f+tlqQXWbLor36KFjwfCpdg66lD?=
 =?us-ascii?Q?jqr+WUuxXKFecC3PLKdFc2op4cihs5bnMQUFAmmLWxLEguZWXoipCjj49NUG?=
 =?us-ascii?Q?abPD2/M76ytrILnxBWuWDK9tgORXOYvAK5HVfo+W/TCH50+onO4jC/xKoa+8?=
 =?us-ascii?Q?lOfxJFLhWGxQSl9zAHQ7iLA3u/X2D+WoLge3+6eUOxTuPriMD52u3B8AzvjM?=
 =?us-ascii?Q?yyrnPYcV7L747/Blvz+VlJCP3ld/DTyjR/96K0gGk4nsubcbMOSpToEnmMOD?=
 =?us-ascii?Q?yZYtrLf/BPHbwu7mkbGeGO/ATtjhRbyeb8HHHog94/K4YbkvUFsVosrXKO+Q?=
 =?us-ascii?Q?YxnCAZPelgWK1K+JAy5JkWo6wGK8GTGWguKZpQXT/Rm/ECMfowrpp18LfXuV?=
 =?us-ascii?Q?N4//vtIQnNcO76DmJMUevmHSUlTZtliQes+xuP4+yEhe9V0psJhr0zaj8vzl?=
 =?us-ascii?Q?cLcAXJZb8zGjQbPRrM2p5qJGJnaA2pW6e4LgWJQgeBANxriqngkozri/bY22?=
 =?us-ascii?Q?Fdw2JE1k9TItNJcfDBjcqZ9CgU5mAMXmtWtM7K0cf2CmAA980RW0Bt0jacGA?=
 =?us-ascii?Q?rtvYdP81ex6BSksLRA3pcx2jBnBq3/seBtxlEKEeyocz7YqI7Htz4iYWtvD1?=
 =?us-ascii?Q?IGYFeLZ9lqvIsG8bu8qEuXaloWF2feDUHQ/5FBUZ/w3A+p11qdDNVQGgNW+S?=
 =?us-ascii?Q?2d9ApA7hYtzabdBO52pE38XG4i8wTPSYMQddxgxahbe2fPGolm6dazSrc0IA?=
 =?us-ascii?Q?69hyXl/Qz2WYfMwvYnxsXdi6Z4cZXP5hmFGzX0VywqRNsh4MAsVwBi8hLSwh?=
 =?us-ascii?Q?yw2EgX4qvIecDrmtUNSXfcB67crUc9Ox2iesWXKL5B+ccnMaqhqFajXotF4z?=
 =?us-ascii?Q?qKM3DIIztj6E2ZRCbYvWqVo6mWO5WcWzkmLjW+xyk/pee2WZf3ClaqNLV5XZ?=
 =?us-ascii?Q?8g4pTT7PPYfUN3auZ+dlPYK455pW36tEa0p5Tsn3+mTGRetqkqzDGQ/hveLv?=
 =?us-ascii?Q?Bj7FhbqtqFY6NOB/DoM/DCW4kq8b8LNKb+P8LwQH4wpEj7F2dxohGNdXT7au?=
 =?us-ascii?Q?cw6sgY//3SMgp2Kjl5q3w5+QcYnQsDavil8Mr2TJV/h1G1sMk4sv2zBceL4y?=
 =?us-ascii?Q?pUuOoQW2XR53E5Hnb8ahXcaen9jEzl1nGjiyswjo6jUaTAkeoNaLHNpgTAX3?=
 =?us-ascii?Q?Ku/GlMcdiHq9O2O8wSSYZ2OsCH+joY6wPqZjZ5C810b8sQoZrUoSq2z/KuTn?=
 =?us-ascii?Q?SSBuFWx+/fWJ/fMKNedDwioC4BA1MxIfR+ma/TehgaVg3Y3DlL/IkywQH0uU?=
 =?us-ascii?Q?EFqgBoI7KwILEMzpqKYX4cmVHtV/cmuJKOTKrCLAcrULVegDZDw9EtUNnlMh?=
 =?us-ascii?Q?k5jHvRhflqW3EFdc+5BinO+d04LV1hsX3cHEhacZbfVkoqsF5R/OEtfAyiPf?=
 =?us-ascii?Q?x8U5A+zzZS2UA56FwySDagTOf01MVNjx3J2H4lIfKwNr4ulaZIPIVxO6Rsc3?=
 =?us-ascii?Q?QPi9xu827qnq743twuojhZmHgM2ABu6p2mH8Jn2DJr7awYZp2o6DGTEQF7V1?=
 =?us-ascii?Q?VUZHtHiAfLj3GxeRM+cAGzpn+V470krZV/vIIiKpuCNEpckElY/4aw5ogpus?=
 =?us-ascii?Q?mJDbIwF+kS+dgwTAJbwOTaKevga9W3CG3Hkafnp48EyU115g3QmMmFe9Bc5T?=
 =?us-ascii?Q?aNGaTpOimEattT9txWR7R0nQlAQd8DmYh1DpjDKswyUUQlvGK/A7BA30RNv0?=
 =?us-ascii?Q?jzRXuapRNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca7d3bb-5f68-456a-93b0-08da164a0741
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 14:47:23.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o82D7fy4RlwPJCNJiiQi6jrrKVNu2kiEVj+aNUt6jVSHk+D4fQe5VRGzJ7s8+eVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_790DAD05-CAED-4973-9978-3BCEBA3139A6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Apr 2022, at 10:29, Matthew Wilcox wrote:

> On Mon, Apr 04, 2022 at 10:05:00AM -0400, Zi Yan wrote:
>> On 4 Apr 2022, at 9:29, Naoya Horiguchi wrote:
>>> I found that the below VM_BUG_ON_FOLIO is triggered on v5.18-rc1
>>> (and also reproducible with mmotm on 3/31).
>>> I have no idea about the bug's mechanism, but it seems not to be
>>> shared in LKML yet, so let me just share. config.gz is attached.
>>>
>>> [   48.206424] page:0000000021452e3a refcount:6 mapcount:0 mapping:00=
0000003aaf5253 index:0x0 pfn:0x14e600
>>> [   48.213316] head:0000000021452e3a order:9 compound_mapcount:0 comp=
ound_pincount:0
>>> [   48.218830] aops:xfs_address_space_operations [xfs] ino:dee dentry=
 name:"libc.so.6"
>>> [   48.225098] flags: 0x57ffffc0012027(locked|referenced|uptodate|act=
ive|private|head|node=3D1|zone=3D2|lastcpupid=3D0x1fffff)
>>> [   48.232792] raw: 0057ffffc0012027 0000000000000000 dead00000000012=
2 ffff8a0dc9a376b8
>>> [   48.238464] raw: 0000000000000000 ffff8a0dc6b23d20 00000006fffffff=
f 0000000000000000
>>> [   48.244109] page dumped because: VM_BUG_ON_FOLIO(folio_nr_pages(ol=
d) !=3D nr_pages)
>>> [   48.249196] ------------[ cut here ]------------
>>> [   48.251240] kernel BUG at mm/memcontrol.c:6857!
>>> [   48.260535] RIP: 0010:mem_cgroup_migrate+0x217/0x320
>>> [   48.286942] Call Trace:
>>> [   48.287665]  <TASK>
>>> [   48.288255]  iomap_migrate_page+0x64/0x190
>>> [   48.289366]  move_to_new_page+0xa3/0x470
>>
>> Is it because migration code assumes all THPs have order=3DHPAGE_PMD_O=
RDER?
>> Would the patch below fix the issue?
>
> This looks entirely plausible to me!  I do have changes in this area,
> but clearly I should have submitted them earlier.  Let's get these fixe=
s
> in as they are.
>
> Is there a test suite that tests page migration?  I usually use xfstest=
s
> and it does no page migration at all (at least 'git grep migrate'
> finds nothing useful).

https://github.com/linux-test-project/ltp has some migrate_pages and move=
_pages
tests. You can run them after install ltp:
sudo ./runltp -f syscalls -s migrate_pages and
sudo ./runltp -f sys calls -s move_pages


--
Best Regards,
Yan, Zi

--=_MailMate_790DAD05-CAED-4973-9978-3BCEBA3139A6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJLBPkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPskP/igovihsqosaQ+52NvlVYkFDDqjC1jpa7ARo
dr5Li+V+9TIaXloLZIWbO61CPJ7hXo8NGsO/pzi6F9/IZHecgG2RyXUuc3EP3Cfq
dKdd5YjCiLfDPIVt7ZqF3AEj8mksrzxIyZBDUd9XTEpT+DLh8kgRORtUUcjrmYPv
8ozTZCfg9OrcLDDLyvVjNaZiGxJvsnLSnULejG9mnPlpiS/1HUtP0m/ZUlSZdP6I
DU9Okk39VSqUUFOj6rooUA/X5EQLDYlczIYnk032CgJOVfS2K99O+STkmzWISwm1
PUNUjlxymmWhhWwYk4Vn83Qk+Gp/NMCoAFnpqoDZjPu/OLMjQ52VpXPPF2owMexg
nZkcgXxJzHKXIV+9Vsc2wsHkzlEIGwEOvM0EA2GmTxt6pqzoVPL6jqZgw56S1Yvu
yejkX+5vu6jK+od7bsNTWF2Mr6GBW8fvYO/V0o1L8zHPwdaXSp/DFFHNb/m4Sddc
WR1rX02H74c5FxFhVr9i2GBA0LfyZQeresIwJ9V8rJ7vs8NUuoZ28/ElsIba/Og4
Wlf4EoZW0cFTkHWoCxPl9XcxkUoyNnNDzacds6/6NopJn2vkNAVu2MDLl0ZQbYwu
oVBbRli2kJJAfiyBCDiCHBhTqtP/Z2LMYeRaLlBn6yTA5stAGP0uyl2g24Jbh9uk
BI3u9zTB
=OPMO
-----END PGP SIGNATURE-----

--=_MailMate_790DAD05-CAED-4973-9978-3BCEBA3139A6_=--
