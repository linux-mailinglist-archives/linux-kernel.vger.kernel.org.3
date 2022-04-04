Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F94F18CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiDDPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378766AbiDDPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:46:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CAEBF53
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VolE74GvjM69ml52Dcw8pGWMbbfaZFN2c62pwRtn+gnBpkbCRm+ENxBHqRRfB25qK/mjy8CeujU+LcP+oMBcEEv/XWEo59dXhM1ZK7wlSScNuEIUqP6+o5xWK59Rerqu+6Zwvz8QxMLyGTLjDfXYTQfOv2NJan7BxsuNlNbM3V5kzsjAVJx2wvODARj0+Ay9nX4KdWvp+TKEfrhYM+0Ia+kFHgGXtxrOr1ocUe3RS1MaiB3On6DCLkDNVfSYwm00qdGZbfNewpWpkk2XmB5C3psqMPeB+IAjW6T6tOmRkdwOu1AX5Gs8qkoJdhlrIbye3wwvVSObhHAmoWuf0Qeoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vx19xhdZzQraWak2utLOkE+LFRoyH1INlOUJhtwu5Y=;
 b=WaAjXmbOzhFVBC/sI+gKRRPJabWCw1mv5AGciF96MWVQknK1Kc4N2JaJ2YuQjYeyyL4TeGzAMFZqGUHt1evydTss07tsTFbh23sclmwEW/48YB8nA3mevuzsZxMDZ+qEmHQ4DmKkuYVhNgQuBvRCbQi58+4T8vZ+TaeSc2Hl/qTrcWqOvVrmNcJHbG/I6/U4AddfTNcSFllVymXaEgmAWHgQTG+FFilORueWF7KlfNzw4fphSyoa5lfcy75Pqbuwc2AAo+zFrgozvsVYlasouJ3nypG3Ctdtg/BOPlANWWTlIqUjYJ1LNL2sRz+OGvmUcRXTQp7OSy2cgisikc5zhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vx19xhdZzQraWak2utLOkE+LFRoyH1INlOUJhtwu5Y=;
 b=dp1oCECSO2IQgAqMAi8hzvg4Y1IizEr6Xn4gzQBosNu5yxtbxFt6zxeBHNgk66Wdj653O48njaK1rN+U1pjE4whOgJhRuMeqap5kRdrWxHQ9E64oF+m2Xswqr8S+8kXd0dCIvkM8O+R1n1XNrAXJ5IFGZRoJe/tTxoyDiVKoHJsB4O0xl/QBaULR3jjUsWwaM4IPzl3MqOPZb5oILNM6uPYA5HOWVSy8MycL4rFsXhk/VrnmQHUQaskGvROVzKBeRB3tJIf38WX9VtsWx0y4D9prU/PY5Y2X1ntMmRsYEeAm29FP1d0+mEkUhOyiX8JrNj26HRc8scDLCBHAKITicg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 15:44:42 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 15:44:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Date:   Mon, 04 Apr 2022 11:44:39 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <857E3E12-5C2D-4990-A667-79E1FC000291@nvidia.com>
In-Reply-To: <20220404151805.GA800317@u2004>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
 <YksAub9UccPZa9DI@casper.infradead.org>
 <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
 <20220404151805.GA800317@u2004>
Content-Type: multipart/signed;
 boundary="=_MailMate_874C3342-ACB7-4EFF-8E8A-55B2428778F2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::28) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f203cf-0fb2-4c46-7ee7-08da16520902
X-MS-TrafficTypeDiagnostic: MN0PR12MB5978:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB597873B66F7124AF48F54008C2E59@MN0PR12MB5978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLsypa1/0V084Xx11suYwLldU0rOn99Q+bRQUk7ODTVIz8DUAyk898Uc0aa3e9mJBC/iMLaVTwxMwJPMuED78Dxc8iQ6QHLDTzdGYhSn3pDot07g4BHFAkCqyqLqac5lJstmV2Zub9TXfI22gkgvk6cU/lmm4ApeKKe9Wr8sRkHiO3PGX8VHgY05rxYv8J+Rb7Ib3UKhwiPZAt9rCgtVLqZhKG1z/Pq6ThdfFCcsbos6clDh1Y0UFxO4SVv3Ks0pD3YnMVYIh+r+i9N0kxIIN1lx8YUqRRr3tRHB3cr438IrBNB1B0XMace1GvTJoUpIyd7ZRkMc32iKl6wrwI0EJ6+Iwxe2BAnkxJckPGdQ5DnsG3DGqQBalWmCmc6zXCbRUEQMNtJycXU8Q6r6o6sxK9D08ZZG4+q1vlTIV1EiKPnCPf49gx2DnZXD51ZxL9v+jA07oq+he8kONqkLIq0ACdt/57of9cPwIlSfsadf/C4g0nFxab3FI8rcLTqZI8JQfWgu9OF4QJa53Q/1pmwXSaR0rEKWzqBQFPxfjOSmz1CSo6bDYqxsgxv/8X7KagSecJK2UxmTgCYshLdOW9u7SgGwR3mW0l3X5CCAsX88GAh/T1B/zDrV+ceXPGlAw5BiJ2uKd/RG3KjJo4DQqGVL12aTfTConjOOlHZnAfvg/j/hxVfAqUPQAy54Ntl+dH7+gVCtwGEgnb7dPt1AFITNO7lc82LLFJOpAKxY3yWCC91xcsiZomtoYPxD/Egahx5HjjW0M44+Wd6ew3OI1lS7BXQGUie8OhRCwdG3nnPTlz8urPadq9x8vklq3YoNfCa2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(26005)(186003)(508600001)(45080400002)(6486002)(53546011)(6506007)(6666004)(6512007)(966005)(36756003)(2906002)(21480400003)(2616005)(8676002)(8936002)(4326008)(54906003)(66556008)(110136005)(86362001)(235185007)(5660300002)(66476007)(66946007)(316002)(33656002)(38100700002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1gPj2ZiYT5WBdc8HsLNDIIiQOqwTG94+ZKPW1HbrahiAQhA/LOwVszVYwqS?=
 =?us-ascii?Q?jJnLMfPGw5MlTMc8eJZDzftq++CrZZzTE+SK36bALTBY8OJwpwnXbgm3aNJm?=
 =?us-ascii?Q?h22KDi9GYqySiRlhMrjhglcWLhaUY0SHevLzdH3Az2uSzme6EV18GsSBloGL?=
 =?us-ascii?Q?3RGHVxomImmMPSxaeSpHoDSQqmL7tlA7JCWaOLF48w4c/14SPg2PMJDNEOWJ?=
 =?us-ascii?Q?BhsboA+8axTF3gF2WyBp/ajrdVXua8AiXf74GbfvwWjl3S5kSDnggmT/UoKx?=
 =?us-ascii?Q?5dpwPGmGD1rOuN3hxOhrcIqCNnd31BqZXQP9n0JbRXnYt47pfYXs0wz5QGNv?=
 =?us-ascii?Q?CAhvMUv321ZHbzKGHIGjVjpO7VD3pTGhmCBnjWvHncIcpM/CDVryZcSoSjdA?=
 =?us-ascii?Q?mlIDfEm7CjnAbNlYgzC7noDH1QO/h4EvXnmHrM0FKhMSpp0YyYGoImlpMfG8?=
 =?us-ascii?Q?ynGHsJWnLlI0faz8Ksmr3c3lVLHMu/fmbFVAyK9tdfKswhBAhv6c49uEFj1k?=
 =?us-ascii?Q?4QuTzB+6jEWGi6sm0FFUUOMqG06IqnfjD6+6uVMQTr9Jo5G70eT17lRti695?=
 =?us-ascii?Q?hpHpxiwnVl1UaIAm1fuIPrCeiKSNn1Dc+YBADYaKO64X/QDV2bYCm5kLprj1?=
 =?us-ascii?Q?yah5A9k4d0L74sKxelC47z+Xu5Jit53+sXER0/cDX5V+XmmD+QXiQAYiF4fh?=
 =?us-ascii?Q?Kitz+WVeuBYLbzgdCWWBWbKOexpxMgH/k4vDA3RF7eXmz2+SPPf/q4Pysx34?=
 =?us-ascii?Q?+IKDhUOTQpf/jXGZ69wMI1lO8yhPTp7dxPKq2AbPVBLAtQr0Nh+0CGzz706P?=
 =?us-ascii?Q?0HGbQaAx7r2F0A4aKoi3WN75CfkHx5b8QqYPGJSn+FxEJRi6HLibOJVNiunv?=
 =?us-ascii?Q?CbCrr1+UPfE4rfHoGGBz2b7zZNzDVIbt8iB68IRQrwCW5yjIaP21zjPoM3Lh?=
 =?us-ascii?Q?GCaSR7Mv+RzSGOmhCOgFXUDZDwjJNugwpIz4wUingD/VV/hiLbywRXYiJOTN?=
 =?us-ascii?Q?tYLLanQSSujKlT+DMWvts424qNFy4EHCVrLHz/NYBUSS1sLe/bZXBDrR3/cl?=
 =?us-ascii?Q?gnfATqw7kjk6517NY+GWQT21DcTWvU3TmYcq38NycTezO/RfleXHhKtQ5p5u?=
 =?us-ascii?Q?qzQw/GbkWId1zGEmiRwAHczddHGo5j96d2wb89uOaS7hlB2G/yN9oCMhWFj5?=
 =?us-ascii?Q?wxeiTeyeUBK4UW1Y2CB/W86Wb/NKias5lLUQIy1uuiroWcucTt73dMxYxNv0?=
 =?us-ascii?Q?RFYnYHlDmD2dsXleSSm0DeBTIMFe3nejOPEDXqhmShl8CG/QgNgx7VqddSMa?=
 =?us-ascii?Q?ragemA2ZoZIQsvRb84Ft3NUSxrXKr5adUZarQ8vt5XntPL1EYtKMkUjU2XD6?=
 =?us-ascii?Q?SqbOybjNB/S8Y9m2AHslgEQ8yiIBfwjKzFAMT9TWy2IXSgTFTrvLSqfLwujD?=
 =?us-ascii?Q?BzwmvN1gF5hgDUMxy1smf1qcUSBBa/0/SStUOi6o1poJ/MlD4LYGS84csnEY?=
 =?us-ascii?Q?+CL3EdAbffSj6MBaLPldtVoa5qnGNhg2+KiqEjZx+mlApBQ9oC90s6We5Tak?=
 =?us-ascii?Q?sQ2IGWHP6APfgtBzBSK/Rdp25fh2MznQQyJWlBXzzwSNd0hyjhBGeT9Bov72?=
 =?us-ascii?Q?tyNhliWGKN7op57Jzry5aqnskP6e3D2nVcpGF9Sq8e6Zt8ygujSXb2O3wUpB?=
 =?us-ascii?Q?IdjdS6gZDA6s9tN52RvWG7fKIzQs7PGQ4GVXTvW2g/gKb8H7cFc9YmXAesUc?=
 =?us-ascii?Q?LBzUnoFxig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f203cf-0fb2-4c46-7ee7-08da16520902
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 15:44:42.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0HgG9RaCa72pZ3/WVpVwNb1StgJpZQA6ttJzhNlj928gRRp8/ifehhBrnO96uPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_874C3342-ACB7-4EFF-8E8A-55B2428778F2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Apr 2022, at 11:18, Naoya Horiguchi wrote:

> On Mon, Apr 04, 2022 at 10:47:20AM -0400, Zi Yan wrote:
>> On 4 Apr 2022, at 10:29, Matthew Wilcox wrote:
>>
>>> On Mon, Apr 04, 2022 at 10:05:00AM -0400, Zi Yan wrote:
>>>> On 4 Apr 2022, at 9:29, Naoya Horiguchi wrote:
>>>>> I found that the below VM_BUG_ON_FOLIO is triggered on v5.18-rc1
>>>>> (and also reproducible with mmotm on 3/31).
>>>>> I have no idea about the bug's mechanism, but it seems not to be
>>>>> shared in LKML yet, so let me just share. config.gz is attached.
>>>>>
>>>>> [   48.206424] page:0000000021452e3a refcount:6 mapcount:0 mapping:=
000000003aaf5253 index:0x0 pfn:0x14e600
>>>>> [   48.213316] head:0000000021452e3a order:9 compound_mapcount:0 co=
mpound_pincount:0
>>>>> [   48.218830] aops:xfs_address_space_operations [xfs] ino:dee dent=
ry name:"libc.so.6"
>>>>> [   48.225098] flags: 0x57ffffc0012027(locked|referenced|uptodate|a=
ctive|private|head|node=3D1|zone=3D2|lastcpupid=3D0x1fffff)
>>>>> [   48.232792] raw: 0057ffffc0012027 0000000000000000 dead000000000=
122 ffff8a0dc9a376b8
>>>>> [   48.238464] raw: 0000000000000000 ffff8a0dc6b23d20 00000006fffff=
fff 0000000000000000
>>>>> [   48.244109] page dumped because: VM_BUG_ON_FOLIO(folio_nr_pages(=
old) !=3D nr_pages)
>>>>> [   48.249196] ------------[ cut here ]------------
>>>>> [   48.251240] kernel BUG at mm/memcontrol.c:6857!
>>>>> [   48.260535] RIP: 0010:mem_cgroup_migrate+0x217/0x320
>>>>> [   48.286942] Call Trace:
>>>>> [   48.287665]  <TASK>
>>>>> [   48.288255]  iomap_migrate_page+0x64/0x190
>>>>> [   48.289366]  move_to_new_page+0xa3/0x470
>>>>
>>>> Is it because migration code assumes all THPs have order=3DHPAGE_PMD=
_ORDER?
>>>> Would the patch below fix the issue?
>
> I briefly confirmed that this bug didn't reproduce with your change,
> thank you very much!
>

Thanks.


Hi Matthew,

I am wondering if my change is the right fix or not. folios with order>0
are still available when CONFIG_TRANSPARENT_HUGEPAGE is not set, right?
Then, PageTransHuge always returns false and the VM_BUG will still be
triggered, since there is no code to allocate folios with order>0.

Maybe the patch below could cover !CONFIG_TRANSPARENT_HUGEPAGE too?

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a2516d31db6c..6e60b5c4b565 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1209,7 +1209,7 @@ static struct page *new_page(struct page *page, uns=
igned long start)
                struct page *thp;

                thp =3D alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
-                                        HPAGE_PMD_ORDER);
+                                        thp_order(page));
                if (!thp)
                        return NULL;
                prep_transhuge_page(thp);
@@ -1218,8 +1218,8 @@ static struct page *new_page(struct page *page, uns=
igned long start)
        /*
         * if !vma, alloc_page_vma() will use task or system default poli=
cy
         */
-       return alloc_page_vma(GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL,=

-                       vma, address);
+       return alloc_pages_vma(GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL=
,
+                       folio_order(page_folio(page), vma, address);
 }
 #else

diff --git a/mm/migrate.c b/mm/migrate.c
index de175e2fdba5..b079605854d7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1522,7 +1522,7 @@ struct page *alloc_migration_target(struct page *pa=
ge, unsigned long private)
 {
        struct migration_target_control *mtc;
        gfp_t gfp_mask;
-       unsigned int order =3D 0;
+       unsigned int order =3D folio_order(page_folio(page));
        struct page *new_page =3D NULL;
        int nid;
        int zidx;
@@ -1547,7 +1547,7 @@ struct page *alloc_migration_target(struct page *pa=
ge, unsigned long private)
                 */
                gfp_mask &=3D ~__GFP_RECLAIM;
                gfp_mask |=3D GFP_TRANSHUGE;
-               order =3D HPAGE_PMD_ORDER;
+               order =3D thp_order(page);
        }
        zidx =3D zone_idx(page_zone(page));
        if (is_highmem_idx(zidx) || zidx =3D=3D ZONE_MOVABLE)


>>>
>>> This looks entirely plausible to me!  I do have changes in this area,=

>>> but clearly I should have submitted them earlier.  Let's get these fi=
xes
>>> in as they are.
>>>
>>> Is there a test suite that tests page migration?  I usually use xfste=
sts
>>> and it does no page migration at all (at least 'git grep migrate'
>>> finds nothing useful).
>>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Flinux-test-project%2Fltp&amp;data=3D04%7C01%7Cziy%40nvidia.com=
%7Cec512f5a763543d4f99608da164e5413%7C43083d15727340c1b7db39efd9ccc17a%7C=
0%7C0%7C637846822934713102%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DIg%2Ba4GE=
kks5vShdpfX8RSX5csCTKq3dmtaOqjpOmelk%3D&amp;reserved=3D0 has some migrate=
_pages and move_pages
>> tests. You can run them after install ltp:
>> sudo ./runltp -f syscalls -s migrate_pages and
>> sudo ./runltp -f sys calls -s move_pages


--
Best Regards,
Yan, Zi

--=_MailMate_874C3342-ACB7-4EFF-8E8A-55B2428778F2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJLEmcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDfMP/0os1Zo1LU2io+HQxv38ucM21bjruMDhVlVu
saCxsv9tMvlisT/qoNrH+21LkFDQNjP43Z5W6/qpH9lyVLkfHhh1G+CJQwMFay5k
NLlyc1q8wgEL6cIkr75NM1TF+1btC4A8jeGyfZD0hhylwF4l18Xx+AqaIDo45q/a
J6kNQ2C+z4zRFc1h71tUIKNL4w96Z/x12b4pDAi7VM+cU9OV59+SSBBswYZtXMYr
P4U1dhPTRolOv8Sh4kefSRNK5GEpBL2wZ4WWbULMHF0nhzrP9V9Cikr6PW7aPYIZ
tsbBAfXnKOabXvRaklrsd6e3OmH9z1GZdQSeVFi/3G1wNjdDoEMdAburk4MBFMHC
N889iODr7wz91Uwr593QUzOllLSningyw1XqDCbkOJJYAXiXQiWhNYSwJ2bUwUtc
mJNt9eqzwtv+NfJNmn52Bn7N3OYSac5ohJGQnzaN2NHM/4OijY6vEwM5RK+5Ns04
DTFuUbDY+URTj9STFpHUDqAgvTzwaqmluQgFBidvTJBCT2zvZ4kRNV38wSNeBxKG
cm/jEH0nm027UAHD155y6OtWw0m1THVwZDr21WxgzQjLZVLc0gDV+1vaLjYAdyhW
gm0U4nf5wzsMs2UbuAJLqzWjT57SakQJekt8vBWu8gE4j6Ntw7ZkeOka3UYJ7tAq
emUfWAnx
=3T+i
-----END PGP SIGNATURE-----

--=_MailMate_874C3342-ACB7-4EFF-8E8A-55B2428778F2_=--
