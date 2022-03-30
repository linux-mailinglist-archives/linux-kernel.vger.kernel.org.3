Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE9E4ED067
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351891AbiC3Xux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiC3Xuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:50:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431C57B20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9vNTU+umteLBMggOyVEKE4hlUgiwAzv8KwXxq/EXeMezqXw7ZcQoiGW8JNpGBxnIITOIBXGj9edAk5qaWmBKHxZsPzdiC9mHpHvC8+j0rwqF7fkLcL+FOrE3vJnfXhKuK1D28uey0ab477CGEWjWmoxhZ+q96T3kZNEY6wXqPXi2SIWq6z/sipuTH4MiXnwmzuDTDE3WuPhadqfbikts00dQupS2R0bnoXtH6Mffl8NNg3swcQWiEZVduVC/Qd7CoxfjJEIrKsWOc+8XptSkL30SKv4WlLQSMQHwRp5sycpCdTYsPfx/Emxuky7qQcNU5fO5ua4VzDeD8tLkZpI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAhxa/PsOoAjfdEWeDLAEU8obCnTt8iiYnTOPibou5M=;
 b=d34jrCdgzwmNqK/mvr81u1F9R4C10Bf7cA3pJUWeemoY3nmeh7h4k+XT9OoHgzpdvtPCqxlZ9vQyrDn8wx1H2+yUz2Jx6WA/HHKNDkecs8hKQJrscGHqSgNO3aW2nwQV0Xkkdv58vBbdZpfBbzUgjIWGRdZNKD7lCJ0zotcW+Yo2NS6wPnsF3yButWyUUB4WA425qMyNLavil0YZBoJKt4yXqM0sx3hgZlKWdlwcoznZ80qPQ/QkG7wdvwSZEEmuePhmmpvXu/H5PGpWcDuFxnanN5GUkYuxRMyEUF2JIkIsdS1nAkE2/pEElQu1SybDnbVCIuShdJaxR5mW3zZ3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAhxa/PsOoAjfdEWeDLAEU8obCnTt8iiYnTOPibou5M=;
 b=YYqOCShBUHnjQm78hkj/zFmr3cLtvD5OZtgCczUuaR5tQiABtrel836nlrVzfjqJK9GGWXyFtuI1KXLEoY3d8thQera2a2C5uYMHuhU/zfq73Q0CEZAfss9fqmVg41SueVN7CVKHK4Hu0sVjP+iAkEGuAJoCBjanwx6q6foMBKtASvBK/V5z3Nx92azP4QV4qeG6BFKi8CanFVwdPB/wfHHeNygGPu23GnN4ACoQfNj1qan7PNXtyH4Ae0nFflyM/2LMhzeWYOZpQxsyZEkjyf88wlF1ts+Al6lvzQUs6Eds19WvS5GxsgiHrES+HumGx3YB7KVJwfEaTvdtkxwebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 23:49:01 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 23:49:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
Date:   Wed, 30 Mar 2022 19:48:58 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <63234E12-AF64-4D85-A2BF-8A4EF5359F91@nvidia.com>
In-Reply-To: <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
References: <20220330221238.396357-1-zi.yan@sent.com>
 <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4CD76967-4497-4F21-AB7C-38D29051D9C8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d1694ce-d03a-4b88-ed10-08da12a7dd47
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47226D4F8F1A307F76EDD2B3C21F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTPDv8CBBQ5krF6a7OdsnMWBqDDqufcwIBvebUeI1z3lNlUDEovr0H+yHLOH2aGoCEep3GVCKeDOKCAfxzzEopQ6NsrW6HZ63/zEClMroC+BFVon9SaLQbDHj5H+7YwDa5a8gwLEtAOcmOkq4mZ5LAHZ+MltBSten1D9nM7OZduCbeCC7ajbc6IgfirRJNinEt2P+4hYnl4o3ayGHSIWmGV1CK4FJUioBea6DJej7eMnQjsL0isCjw8IPFIsem3q94SlkeZXbzuux3XW9Q9qME4eGgwafwTINXWOJwYJHX2r4UCroZUK2a401fqgnRkEtuWZaNWu2mivjBsTK6E0S1YhBQwMOH687CCDaAnjJrut3VEIggJnJvopfFV78qFDCzZsOjY14MxysMBKx4ODeEBH80ivbZHb+y4zLgdkuGCG5w/pqRXuh2cXj7Iky2+up7tYY5wYJgbOVPqJc3LwsJpCXdZN3lj7zlVS2i1MAifCfQbYrko1j0UKqYSe5r+Mjofz9iBsUB+uD6BNg4pzACHR9ae8TY8eHNoXy2ttWqkAYfMo4iJurOOvze+n6EidoHDbmxLdzWS1P0Q6RCKaaspcovg8Ny1kh962Oep8qiZ1zT+4ZW1P81SvP6JLaydztpA+0deyaWdrSIJmw4rOiIJe8g0A+3n9F1OJEqrE4yHfhwjQ5rTlQvlRPfl90bfQRqs8v2xlJdGOmIs5c0gNrK1o4lc1DVPY3spu31IW5uU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(8676002)(8936002)(33656002)(66946007)(235185007)(26005)(7416002)(186003)(508600001)(2616005)(86362001)(66556008)(5660300002)(6506007)(53546011)(6512007)(6486002)(2906002)(6666004)(36756003)(54906003)(316002)(38100700002)(6916009)(21480400003)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whNdMPqmprEQ5I0rhP0lsLmBT4j9pkxn7DB25NBC4jnT6ULRBF9n4/969nIt?=
 =?us-ascii?Q?yJYGAG4bSLeYNJxYP/SvWS2V8gD7Ys/j+qhFnneqa9a3o4YBv3nywY/tXns7?=
 =?us-ascii?Q?RwK61vSoDShKW3uuoInHZL8SVQwno3Wz7/UtOpaYnL0GUMQ+zjGKWYUn35iD?=
 =?us-ascii?Q?7wXpBmnO+rn/xTRUlnuNo2iqijsQfvO2VNX0oH9MztxBxtKSpa24eNwOkpEX?=
 =?us-ascii?Q?9RwuW/ziAMlzCP1NYhe87TjR7M0aggnfa/lsPyrtrIlxcA4fYCm+dZ3UkxSY?=
 =?us-ascii?Q?2AIM5ixYXpDzynp0gvIsLlVFT/9ckDP/had9adMihhO+kv2vqgovi3Gk7Qe8?=
 =?us-ascii?Q?w96SlF40D42PKvKCx/8xBXyXlJlN5Zdoctpd2SurFyYhX6v16I7mV3j2jQmR?=
 =?us-ascii?Q?VE9I9V4PdCl/RI4rOfbHyqZIiYv3kvLqpxBLjbVmMm38RV/HLRSnt97bylUa?=
 =?us-ascii?Q?iNHUWqZfFRbDPeUvbDO2Vi9thcRppG58lXLSJyU5JJW9hMhGjjlGDghKG2C/?=
 =?us-ascii?Q?VqOuWBpAwzNr7QbWLgTPhSqJkzcZyoKkqoVfyETC1m0+p1L46mwnuH8rx5v2?=
 =?us-ascii?Q?Fwk8xbExsnBnl4daDmnhpKDEF489JnfS+GVIn/P9Ng8xHa+15rKj0JiS4EOJ?=
 =?us-ascii?Q?v6Oelv3E3H5F4nPBMLNLiNfdrJ3cUmw5tY+joRH6Hm43OhR4J69V1HGzPIJr?=
 =?us-ascii?Q?1/bse1jsfyEz91bNpV19x1AVsldS7m/D3mTpmSjpcHvE/HGpVtK2+vi6J3wC?=
 =?us-ascii?Q?OwX8kXcF8DH0vFFrZ2imRpD6tdX6xavoJIBCE1xCL9rQHaVAgNEbGvpOzUa9?=
 =?us-ascii?Q?Fs74LbKav0GHT1FpBiCPhNYDyCB+RN1VLmu+cMOI+madT64KYm2cxTZ3JiMS?=
 =?us-ascii?Q?uoC8eqcz7L84Q1wHfQZU7DuMJZmOHADsrrk2zuaARX8a3TLLLsnWhgCv7ed1?=
 =?us-ascii?Q?l7v5vzmK5EylKn8jnthmAibTwWZSKifo/CNCe7oCLtuxywDNkAyRvXixFhxm?=
 =?us-ascii?Q?6+Erky3xpPDtreS9JLlCNJDOau+Xh8fzTr+CrZihGN4KV8l7+40hykCbZcZZ?=
 =?us-ascii?Q?1uCsZNP17qAFUOzJhOyvKzCZVKbI3qlxUEo1dpr8qKIsOYTsIox3LMOi4dta?=
 =?us-ascii?Q?FQOB+OMqYj260bfR5Nccte23mCN+zWcNytO1vxNkBLJ9NS4fjffvoWCRujGm?=
 =?us-ascii?Q?tj+8fDQ6+53ItDKBX2faS2izDgAyB8YACOoYKJOS6vuJUEQFJwZAFGasNIKM?=
 =?us-ascii?Q?9oL0h0KyxaVYDYZySt3bGyiGjxmhJAoEwxJqeh6BMWVIfs54AQZfI5Y6P8Vi?=
 =?us-ascii?Q?liphI5QwcffCGk/8Nvlwik96R+nNBsbmUv83r3bkLFP4maa1sHqM/kTXDEOH?=
 =?us-ascii?Q?Ca7a7OhezvyD5bS7Z6b2AtXDMQgnc+gr1HYC/FwOVjTOxG/+TrWnguSBsXFm?=
 =?us-ascii?Q?QzAfud9W9fyPnBy00C3sTgDSfFBre+BP2gcLpDK+1hGq6IwbYtnyKxwEf8tV?=
 =?us-ascii?Q?/06rBIdC8pEj3ZcIcE7cdTqNFRERQsBy/H3R5MxMG3FbD57KCctt/KK6MRaP?=
 =?us-ascii?Q?VGeePk03ex+uBU3l1qnstkQhNidrtUN0ryMVoCEs9PDyskewkpOnj6cKfmNI?=
 =?us-ascii?Q?P5qis/YCZ1FANqxaGjxFkjLYhp9mmLSrtIa6ukdhscM9heDEZ2rdQzkccGR4?=
 =?us-ascii?Q?dVyZSM8gGMYy5qt7WOSTFZGDhC8pTHKGrlsSFkmt5zS4coAtkruzriV9C5Sg?=
 =?us-ascii?Q?Ml15ZgUaKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1694ce-d03a-4b88-ed10-08da12a7dd47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 23:49:01.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2coXwLOfJMM7srR265jy/rt/TAQxHLX/wuZo+i38MOhy1FQUfdxLib64wOpg4Nue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4CD76967-4497-4F21-AB7C-38D29051D9C8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 19:03, Linus Torvalds wrote:

> On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>>
>> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable p=
ageblocks with others")
>
> Oh, btw - should this perhaps be backported further back than that
> alleged "fixes" commit?
>
> It does look like maybe the problem potentially existed before too,
> and was just much harder to trigger.
>
> That said, google doesn't find any other reports that look like
> Steven's oops, so maybe it really never happened and backporting isn't
> called for.
>
> Or possibly my google-fu is just bad.
>

There might not be any issue with the original code because this bug
could only be triggered when CONFIG_FLATMEM and CONFIG_MEMORY_ISOLATION
are both set, which never happens, since CONFIG_MEMORY_ISOLATION
depends on CONFIG_SPARSEMEM.

By checking Steven's boot log, it should be PFN 0x21ee00 that triggers
the bug, since the physical memory range ends at PFN 0x21edff.
PFN 0x21ee00 is 2MB aligned instead of MAX_ORDER-1 (4MB) aligned.
The original code assumes all physical memory ranges are at least
MAX_ORDER-1 aligned, which is true when CONFIG_SPARSEMEM is set
(CONFIG_MEMORY_ISOLATION depends on it), since CONFIG_SPARSEMEM
allocates pageblock_flags array (the NULL-deferenced bitmap points
to) at section size granularity (128MB > 4MB). However, CONFIG_FLATMEM
does not do this. It allocates pageblock_flags array at the exact size
of the physical memory. So checking 0x21ee00 will not cause NULL
dereferencing when CONFIG_MEMORY_ISOLATION is set and the original
if statement can be true.

Now I am wondering if the page_is_buddy() check is correct for
CONFIG_FLATMEM. Is mem_map allocation aligned to MAX_ORDER-1
or just the present physical memory range? Is PageBuddy(0x21ee00)
accessing some random memory location?

--
Best Regards,
Yan, Zi

--=_MailMate_4CD76967-4497-4F21-AB7C-38D29051D9C8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJE7GsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTA0P/1UA0aldAORGslnwVUzD95IkDWmama5WGKy3
e4znE8fGWsXCDrT5D7f511A3JjbpryFuWiH3V/mz+6dhnJIcrsr6hL16FdesygOS
j1q9ecglf2mgZStM+08R04xGppekiPFwmnuYi8HQ2pScK9UtTPZI0yQjgnlsKZ8T
8c+dherwvTsSha7ZaO1XTEKoxX4cPk9Ki8rEtYnUUc9yjUVyVI/Wptd4/30SRwAE
wZ29lwIfPL8XDWi6VMNQDL0gGNGGyp4Lnc6pFhJCRRBsX6I0GDXQPMtcv8NWl6QI
sTPTxyaZYNwvpkekClY57vALte1NDzMVegAlh8QtavLEHyUrUKysf5dOgrLd+Jtk
AvZ7pYEZNbTmEnhe9Q631qN8itrVFuiJhTQ7PsCnRmXmhaTioRFxxRSZXALLd0bu
oPOnpX3ZMIYtf26MP82mcxTIpaEAnnVXedlMB/aYmt80D2HPLmzo/GlnnO6RfIZh
spRYatl7ER/UXTb7jj+1M/KQanGU7TWUe/YZI/D3+5fc/BHEvCTqeZcOtXvoIgVb
l8cMWSfBHFb9Wto9N5B39iZ8XX5QmaB8z4ZLNtGmuDVvqb5lI6U6fhBqyRmZwMoh
UGsE/p9dvf5WugkHvj5MwnZ046bTEBa9LMs/JfahteenBJc92u65wvyN07fWPoZZ
FL4YlE+9
=Zkx3
-----END PGP SIGNATURE-----

--=_MailMate_4CD76967-4497-4F21-AB7C-38D29051D9C8_=--
