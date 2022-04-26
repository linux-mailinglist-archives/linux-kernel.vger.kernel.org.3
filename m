Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEB510B73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355509AbiDZVm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbiDZVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:42:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118363BC5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7AvbkHWiBvuk8eZ9hN1kVBSSe4Fk4VAR36P9TCfk+PCuDWBxF3E8gqwiHHgSqSXw++1bwLgjDflgSY9AiFRxEh+iyA1J4HFjNMsnHCiaPnrlMbeuDf2oWsra455lYsuLb7VZAeEfNdenLYQTVn4wIbYBc+Phb5fgB//oUivgHk7mDEWt358ahpi0Cv1U3payKM9wOasYe31lF37dsbVRN2f9EHLYBUlBaZLDagmXrc4siRF0Z04lLzQzKuxDy/OwOlUyO0MTEX0VlDm6Qa54HFSpWb5YGrWW5AwVFpdcwUN/c4ZVP6faDlujcMe3qXe6hNCMhymYHqMJkBldzdpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6acqcZjqSy7ovd9KlhHiW1EO4qZHLu5nv51jRo2TJaA=;
 b=RSuWnGyPOQmfkL8hGjvFmC5bCFtpeOzo5y8C/rXMkEudlrRVkCCpbgJ142KxcZyGnf4+58p3A5myRhvgM14lELE1ci+rI/bIv5Sgr6dr7DwwsFgt+WpgCfFNAZqGVdNVMgqhXpIeSK1NeZZvxoH0iaoS03SVyryG0SciWpy8EnPDfnH0F3ybmPK6VvT+M+1qGKeEBxboNVTDMVpSuGQl+52szIhc1weXHHG2gR7A+RA3ElOE3GFkLBR5q7kh8Dtn9LgozmEgMv7wRS1Wdf84Mw7eNh56dyCbV+RcZiyAGiAYwtKCuaJnVboONsrCbAaRWGJY+B41jZJ1Jw3lp7CyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6acqcZjqSy7ovd9KlhHiW1EO4qZHLu5nv51jRo2TJaA=;
 b=gYcZkM+WJ9mUyJoYm+N821s7k9yLwyPqiatA8pcKv/NFoL9muKWjJ4LJ679ICZAjS2X4oTkA0k+ggOI3z95SNXZztFGDtiuNznBtdNJrF47sFTAyccyXEjhyfq0LpWJcBJjedAYFGCG805cpt9uI3E/nToLaHwxlsgOXJpzGaqe/KHhNC62AmdrbJmhYhC7QBmuWp6QOONxsHuo+2tGsHjgjZ39DOQf4GsBlt8ergpgo43DbZ7rP4nTsuW+lYpnYRQl8Wrn4NmsaXaYlrVUszqbV/fWsCTFfVp7DUAMkvduzm6h5HKn+lUVKXGJnwuQg6Gl1es/3JHZ5NzPbzjeoAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2498.namprd12.prod.outlook.com (2603:10b6:207:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 21:39:13 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 21:39:12 +0000
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
Date:   Tue, 26 Apr 2022 17:38:58 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com>
In-Reply-To: <20220426210801.GA1038@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_12640CD4-4573-49EE-93F5-01EF8643F3E2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9a0d9b-5d8a-43f7-f3db-08da27cd345c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2498:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2498193886FFD92CE8D80BCEC2FB9@BL0PR12MB2498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bXm8voi5Pk6UY3WJUcpYGfQff91RLy8vtoC9JqmjMCnP4UX2dECUKe0IYRAgpsLd6t7/vdxmSrWSTA8dGrqkYrdbDgyb2mjEiCQy847qXGantWjLiN8lfJ3pzbZGl66NMndGVVKUq3wXNfCH9g/UrQO4C0lLiKV7e0bZRYQ4HEse2/bT2xxKtZKbtnasEBahiPW+pXv1LWumdhhN7oH6XE+oL9VIAfyoaZ34k6Kh6UW81CijxE6ff5aaLFfQtj6YVfptpB2sAtw9JUFhqQl7R3s7emP9fnW5YFsS+ntKvP+6QCAUvhuMwgEd20drHs+JPcP8vkIGaI6yBlBVhQ/IpR8nrHyq1XSyK5wFsFsduRt9TcRqHNERF3iJUbsUme2hmiIluBLnLx21yIQbEXmP0Oc3TJYWEWBkqtB4/gmmmpBWEhoH+UuV1NmlWXM55qEK6Y+ubGFghBQ2kURfpKAO5FZmLo3uw8+75tmBeLERy9fDCOOG2IwR9ynqNODQZHQW9YibpxxEXaRzA2SSiRl8tRnpgQKWtHVLqOiRx1RkXJ/TyYLvxP9JNhsBZhFeuJcgJMSkf79tJj7oN83Bhbo1a3eGQoUOMFWiz3TDKZrAaZhy3NDJ83XEJWjHF24WkPtucSOaO3xtM8YgdWtzAVuHA/mmuvfWMfpyJcBDzU45BNuMGJStuAAa+Nau+EhO77xW6Um+yFF64pQx+3tKJt4rglxyvDhABRD3UCHRjtL2Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(6666004)(4326008)(26005)(33656002)(5660300002)(53546011)(38100700002)(21480400003)(2906002)(6512007)(6486002)(6506007)(508600001)(316002)(66556008)(83380400001)(54906003)(86362001)(36756003)(235185007)(8936002)(66476007)(2616005)(186003)(8676002)(66946007)(7416002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGjrmNIwIMCLWiebGoAH67wgyONjopXNaoOvMb5z1c8t05WPeLRzNWWf9wIF?=
 =?us-ascii?Q?oZ1cLz/4rb1mQbx0jS6GZHL2Q4uxtQgTmUhoz6yavn3Wcc+ep843K2zWB/BV?=
 =?us-ascii?Q?GNxlhps2VgZpD9oc89p5ksZrXKU+m3HUgXWhHW2dAhZjFFn1tf3QXJrcb4Jn?=
 =?us-ascii?Q?8sZWSCD++DTxN+T7zzU0Ad1rVperHTUt0iV0g6GRAUicN7wVQ+dgiAgjbZzs?=
 =?us-ascii?Q?hrS/MAxQEv73b9rvTmz9zN3rhImwHRWGeyxXm39/wtLYmKntQjASdZXrHUB/?=
 =?us-ascii?Q?dmEr6AuBpPp2zsudJVCamugLKZtorrtODVivu/n88d2+W268McF+hxVZzJ5C?=
 =?us-ascii?Q?0ATUG4pot3wp7clh/Wc/ttkv7SEeLiCPY1NWGpg7+DThImQeLxYVbjOQV26C?=
 =?us-ascii?Q?KE0ZOSSjnaMWgh0nsW5HldfPC7tYWULENDI+b4LOVoR41Iskd42/k2RcnBMk?=
 =?us-ascii?Q?w+yJtfks5V+/Xe3gKAp/GSu6RylcsTQqSGLnvD1LtqAcIMiUf66vnPV/Lq4d?=
 =?us-ascii?Q?syn4SWWaAYw8kl/SCBcfLVJ1DueIEyd69ugIdbkO0ujE0zhcdicZgzb5V/A7?=
 =?us-ascii?Q?zyFIhsL9Cq2ZecPiol5MewgIChOn1w6jGacFbF96kxs0viU+wP2Lj5Ue5QZB?=
 =?us-ascii?Q?OAeCom3wuQ1Wo2zpoVIrl1vh/JiBBzn+V6HkszfKaFcalWiO4KvTPTloL/ml?=
 =?us-ascii?Q?OMgeURWReVqTMY3vXHCQ/NiI6EOYNfjqxHczVM+1xoDvjUmKRHRZowFJk9Dc?=
 =?us-ascii?Q?NC1duLo6Yqj84G6yCAP1Pe1YlXtZcLG46/I2QI1r/ZnKfyirEBPRJmYIukrb?=
 =?us-ascii?Q?SkblEgje3p3tztt0gk2VAJPI6Pbid5yY19P14ZwDIc6n5CoMZS5gYeMD8doT?=
 =?us-ascii?Q?0bcRbKlbU1LLDcpTIDO+BND9A9yuxkijYyACNkOps/DtJzoFEBOBJZ7aO+Qm?=
 =?us-ascii?Q?y7Vs56Syiz8nKI24b7kSz+wOH1QvYiYWGNTKmKTcdgCQ+RfEuJETBwN/0lUA?=
 =?us-ascii?Q?ZXjI80IyQ7wPdIgLElihf2JOZgjkCo2r7qECXydAR3APas4iMbQcDpI5jR8e?=
 =?us-ascii?Q?r6w+Y8KpnWcK3LdCMTgDz8yJovsvnVAGLKLoC+K6TtBlyJ506h+Y/xPYDoA5?=
 =?us-ascii?Q?bPTBMqShM5MXggQFxnF9qJWTQ4D/cWhpy4ag9p8kuVnyNx5oSoKQ3ICjSZ9L?=
 =?us-ascii?Q?g5Zw8a99Y0AqhyLfv1kpFpjdwU3rOhpmT8nZaB91FMWwaT5KvYJhf8pWrM2l?=
 =?us-ascii?Q?E/fJoXqZ7k5U+5wjFqVMoXUPSFBalHD2Sre9jljPb3LATOyaEYXel1ZX+kiX?=
 =?us-ascii?Q?eVMSGyCX+Z8ATJhvFamphn2FCcIo+gDacfkQoZUy+KsRJ4SCtLXZHzKi44qk?=
 =?us-ascii?Q?zqbzLONJvVw8wDor4s6IirCA2PT60vz21sFLZ8o3h7ShbRsAtygwEIOmfdp0?=
 =?us-ascii?Q?NxKoRjAdeN6mX6OjjtRxXG7NkwyaEgTkH+O1yFPNWtdVskoTDFDxK1CdXuOr?=
 =?us-ascii?Q?CqH80mbq2H2mBIOBDHaOqojz41umGRg35py0WWc/8QoqfNm/3gIOF4yjZqAp?=
 =?us-ascii?Q?c52B69k1lI7OBu1ROyNAxl9P6WpJr6Bu6S9NrI0Nwn6ZipmaiDZwf/oQyFs6?=
 =?us-ascii?Q?bEmj5aXRNadRlp+JA9ovGFNkI0DtFimQKeSAqZdQH4HlLLkj3x9KZcSKR1Nh?=
 =?us-ascii?Q?aWvAZ45VSxKPVheChHSAC9j7Nq7/Qf6jTdNZsT7RpaNaHnkqzXEK7iDDysMp?=
 =?us-ascii?Q?e7a5d5iBIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9a0d9b-5d8a-43f7-f3db-08da27cd345c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 21:39:12.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gixsm3C+RNHW6VXtwecqPEAQr2teR3WhPZNbEt8vpnGgpLmY/SNNyphfVqw/kpIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_12640CD4-4573-49EE-93F5-01EF8643F3E2_=
Content-Type: text/plain

On 26 Apr 2022, at 17:08, Qian Cai wrote:

> On Tue, Apr 26, 2022 at 04:26:08PM -0400, Zi Yan wrote:
>> Thanks for reporting the issue. Do you have a reproducer I can use to debug the code?
>
> Nothing fancy. It just try to remove and add back each memory section.
>
> #!/usr/bin/env python3
> # SPDX-License-Identifier: GPL-2.0
>
> import os
> import re
> import subprocess
>
>
> def mem_iter():
>     base_dir = '/sys/devices/system/memory/'
>     for curr_dir in os.listdir(base_dir):
>         if re.match(r'memory\d+', curr_dir):
>             yield base_dir + curr_dir
>
>
> if __name__ == '__main__':
>     print('- Try to remove each memory section and then add it back.')
>     for mem_dir in mem_iter():
>         status = f'{mem_dir}/online'
>         if open(status).read().rstrip() == '1':
>             # This could expectedly fail due to many reasons.
>             section = os.path.basename(mem_dir)
>             print(f'- Try to remove {section}.')
>             proc = subprocess.run([f'echo 0 | sudo tee {status}'], shell=True)
>             if proc.returncode == 0:
>                 print(f'- Try to add {section}.')
>                 subprocess.check_call([f'echo 1 | sudo tee {status}'], shell=True)

Thanks. Do you mind attaching your config file? I cannot reproduce
the deadlock locally using my own config. I also see kmemleak_scan
in the dumped stack, so it must be something else in addition to
memory online/offline causing the issue.

--
Best Regards,
Yan, Zi

--=_MailMate_12640CD4-4573-49EE-93F5-01EF8643F3E2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJoZnIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU7tgQAI0fSeALKcvSURGezqi1l7GhPCgqZ1q5k2gx
Muzde2v1Z4JB2IlWFLyqTI0N7I7+m7Yy9ppgWNBdtDR1+erfHXoAMYOw97CgQrRx
Xir1oqoBQGMk1szbC+FJ41I5JiHfqty1oMy3+Ea9BTGerOMW8zOMBpf+O7Iz9/8z
DgujDv0ppkFqcjSXoN1HTt1LP+cc+kaIrhRBiYO4nIXMmej7zts2tuPT/AW60UVa
oV8YEOUV9nyCnnazrJ3oiSkcKKK7ZyV++vjNvtay24cURBdgwj2g1xdQPW0U+T+Y
XEbDr2Mu4XYrGbZNhHaN87L+w0pvYmcPDAm+cPb5P264ih2/CTeemeCSujwWEGnx
JRU0SYw3kjwHRZsY7ZTXvQ5r+IcOzw7yq2VvdbkbEl0SuBWPdZ7Ui5LXEF8g+BCL
yFSwScZAh+g4VFOQTyu5FGZXHDbvYUDKWquGmyHEFumLb45WWMzBWl2InQW+R9ox
B2fDJQvalytBRN6X5gaH2cGYv/M2ArFt//J3uTw23iUIrX10pW5h1bfWQLIgHozV
f24x3IuoNWjBWu63BNnTquCC+lDZiY5/kcbGSgTL+ppZdC3i5Kk2XAFPU7rOiGVQ
g/I3pdvEICDewsq7BF6YH8GMyaAh4izHvkwGYAz0Ol4OUvrWEeT4rVYjdY5vNtFU
fvKI92Rb
=iXsA
-----END PGP SIGNATURE-----

--=_MailMate_12640CD4-4573-49EE-93F5-01EF8643F3E2_=--
