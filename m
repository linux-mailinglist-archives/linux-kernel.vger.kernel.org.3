Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA16C4CD781
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiCDPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbiCDPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:17:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B91C3D14
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:17:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp7ke7tj4J/wMNF5XzHJQ1X8Wwvrjp+NaqLKsSRMkjRenO/pNIlQ785WGLM0fHLfu+HeiRLjbuqqLWkjVmUHhP9bHQI8vA/WoXeHntKmteGdWKEkEScxrQhLKCOM+K1hD0gc4HY/huhgoFzktfa1QSgQenWBbJ+SpdA3VDvz73Ezbj0ufJXWL0oUo+e1NxUwFm/ZjF3P9m9QkCL0XzSu8vPLaJKugiU/gBOStWZZOpKr9t+5VyOuvTL4d/Li7zsDy1fVV2WoZRBZ+GFIPUc5BrGN5MqpzZDS7S9CMMCYvZVltbLAeXMgMoxqBHG0YLbgNywsaOqHdSWbPisJZJM0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iYTX4P8m9VihLwKdir+RT9xEcMrYcoOcBbk6GNJgkw=;
 b=UyI80Cm1QnxTvJdHfrLnQolOhRozzQpDHqvfkYU9v4CMJHGd2hPx5Wosh87ooznSOVFHRvX/fKfpKtgtPKH2o+27ApopG5prfPzgRxE0T/thumrpA2HAcWkGWDPMLNizPXjFmBnGFvDKqWMZAj/BBJqDfl9t3h2DPYEPeJ1hlmd0C+A37D4hrbuR/PvwmqQ5ROCkbVBk7ZkJnAbqS0YFUbP66aJSOwtiuEjh9ur0xmBfvaq83HuSISwOYLm7bxHL6M7/6eE3caFJXiDpNBjDkv43pwMK+gDpKKJ5pueMAWZyzJDW7NIiQhimqJoYqYkbeH7kAvqtK+4pkhGwY5Vw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iYTX4P8m9VihLwKdir+RT9xEcMrYcoOcBbk6GNJgkw=;
 b=G9NM6wPbdiUMbwTw92YxSn6IuWDQ3dMV7Wbt1p7pBUNKh9FQQDlVXa09PIHREHeb9Ka2888VhNNykNNYiuAdd5A2Wt46xUmO5J94jzx4Hdy9g6PtyF4PdJ9OpgrxOvVwIvmJQ7WHlEvEk5vUjueTKMHactTLwgegcmPSpiI3wk0l+mCzyaywLdkzNmfhBYELY//20UvlIQabwW0JKTNWTBcOCjxL8eSGFlUgUltBSCcByZoWdDf5r0Ih5ZWkOFeSJOT2djeU8a3m/tMhABNKjOumrYM5HgitXR1VFZVVYtJ3HWKzL3MH+/FuiRUaCKx/Fhx2pWySdZjI/qfpJzoz/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4783.namprd12.prod.outlook.com (2603:10b6:208:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 4 Mar
 2022 15:17:00 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 15:17:00 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        minchan@kernel.org, apopple@nvidia.com, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] mm/migration: remove some duplicated codes in migrate_pages
Date:   Fri, 04 Mar 2022 10:16:56 -0500
X-Mailer: MailMate (1.14r5870)
Message-ID: <7590C584-7348-4474-BFBC-C130F5BE2F58@nvidia.com>
In-Reply-To: <20220304093409.25829-10-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-10-linmiaohe@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D94D30E7-40C9-4331-80D8-8072581C7100_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 621b610f-a90a-48a7-32c3-08d9fdf20726
X-MS-TrafficTypeDiagnostic: MN2PR12MB4783:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB47836DE4A0F72319D1CB0063C2059@MN2PR12MB4783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQlSm10d+mgWdYdOV/UyiUK7coTjRiJJXdFflDQqCFvZFpC6YW82arR+UkCxaEF32DpQZ7dJjXeSCA7c+gi+fE9ZvScQl0ZF3LsHtCQAx05DVtgMnq3HGvC8MiELha/u8dk6f5PbKbyMjrR0/gEYd9udKYGMLPu07sazr6VpMllFicFYEI2XsU59+RuE83f+6lrfT6h05chqaNPOxXTSg5pPtzTrmW3Rh/spyOrX55CGI5chaPj5idyFc1WOEKFbNXXSCLjbysbg79cucP16op7w2yBHojXIphM1cm6wq0byxmbVzKLbq2F2xgHzjhgxkQPqCZ6OAcDrwgNrEb8UBR1+b2nnjVrO4PYTm/IO1vbD9FbUXpsXqlqfd8xmLeYHttGwnpNG0jmTbzxV9FaHohbouDPsIrN2HFqRZIzkHH1GbU2GSNwrjElzDr14BaqQ6uzzXWfOUbEmg+ZSwJMYKbZ1p6it6/jS/ViPEl9qZZPLfhS61ahgS7vJlPzI9QnILWK7Qk1bvBv7ZrJs4F2S2J9CvbonccnN87Rru/KZGfIx//UjV3pAG3RI32Fn7Jtyj63DAhaILVJof/FhEfwrlpHGl6c/djvwi9TvPbsna0zWt9bOL3qAhmGZRwB0aSZVAvLZQRBV9ujUyuHilEJ6e8Tf70SlSW44sRAQS5UsU5ZJlcm6iO/apUtiTrWXAteoffrQrl2ULi0/LJPz1XtCT/ueQpLUPDdaoo1lbu1UIZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(26005)(83380400001)(2616005)(2906002)(316002)(508600001)(6486002)(21480400003)(66556008)(66946007)(8676002)(53546011)(36756003)(86362001)(4326008)(66476007)(38100700002)(186003)(6666004)(6506007)(235185007)(5660300002)(8936002)(7416002)(6512007)(33656002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NB5YKvVsBhtPcr3chIN9A3HoFd8xNax/D/Lcgce+6K+vMD9CseGjqH9hTaqa?=
 =?us-ascii?Q?fjFMKTAVagJy8VCMebcVB4h1mwrXtPa/uuCMriuDWHhuTUeGutwu+UnDcVdi?=
 =?us-ascii?Q?p/c5mB+s0OTvSSR5t0Wl+wWx+7LVKBs5pzhQ5iExBKeIOLKtHsKyVz4pmOyI?=
 =?us-ascii?Q?QvjwrW4mYS7+GPumqdZOP515SKvehKjqLLg5l6K0ybQRtu/dXWsxPTkdGI43?=
 =?us-ascii?Q?aLi26Xpri4psd+7RiQ9WjhuF2oBuqxY3Ohr8MENpJNbIydhw9ASzVISnvUvq?=
 =?us-ascii?Q?qj/ygVn0gycnyNOHJt8V4NXb3MEBpg6Ki2khRAfMI8h9PfeLbjyHFOzFhBBq?=
 =?us-ascii?Q?+Fy2jBr0ZhoT+Zg2HPmE+O4pjUtRFhzVBvy+DWnr9IqrRjGvJQV9KdB21P+S?=
 =?us-ascii?Q?Y5raM8s3yd6efobwTJJ3Mw86zvwtCgJytTHpPHe/GBdlXjtwN1wNxq9GgoD+?=
 =?us-ascii?Q?Z6mM9eRVBIBKUyVkaK6hy5wwSJoP1Sgp8OT/XAVyz6+8pslccsyyXZFwU3VY?=
 =?us-ascii?Q?HMMgZY14EB0NN8cx2hhQsPFsNB7wGBe05RBp4Gi8q7NbSM02vAOiuBrtu0z0?=
 =?us-ascii?Q?Hin4etYdydDT2MD3eoOV6HKltS7hP310BeSwQ8wAYWFLEHmJ9PbABo7WVmpl?=
 =?us-ascii?Q?Xr4TQKo9qDuMnfMNupR9VXA1wJKKNkux2/7CTFOaZ0AI4OyEuzOFn3zMCVsO?=
 =?us-ascii?Q?fIVPmNSMclZWFo6EDxUjl72inPc+MmIW+j6XkvPetsnXbj4tNg9O0oq+kFyM?=
 =?us-ascii?Q?bqKajwrIpBqy5jEZeyDidAtcvRW6PzkKgHcNeKq54J8K5psbAdMt3GVcjo5V?=
 =?us-ascii?Q?8TMpLnQLZj+CvPGlSOokOL2JVQf2oZm/Kjt3WqVE9AOdlna6HS6nRe3Z6Voi?=
 =?us-ascii?Q?QunDrTy6y9/9f/cDbj21F/SxKNaxZD3VYAVIsYerL54/pfuWcaBfb8VTv7Wf?=
 =?us-ascii?Q?z+Lir9emTRF3JEomFctbpa/MJQl/wfnQ8dVCnvAd979Scd5Xz3lS/b1RsJdv?=
 =?us-ascii?Q?NwYHcdGl3REZoJ9Lzj+UISPXTOLdC8mjh4hdUVmM/jbnPgcDepBm3xGhd43D?=
 =?us-ascii?Q?kdnh6bZJeftBr93ZfPHAumtbKtJX/dNohj8S9Kl+Ly+ZzGdP8nYcN69HqFD/?=
 =?us-ascii?Q?4YhKCThy3MQ9g1W+GTn5WuN8wKOFZ0PSU5tF5Tnf/O9hfgVjeEx3PJj89UBU?=
 =?us-ascii?Q?C7r6nkp3/3FMmdrZ4nyZL3MgpzOxmv1QVlR//LCqqJiH4ZpdrbXUQKJ2LMgH?=
 =?us-ascii?Q?5r4x5azF5p1Ywdmi837Zjr4ABdIopNUNsMVuvhQjGZIg+tR0ZvMGkD7wrQhA?=
 =?us-ascii?Q?ie9QjGpa2tzuZI+XCp4aMfHgh6M254TbGROFfDwtB/MqvbzL/N1SOpSLJKWC?=
 =?us-ascii?Q?cbWZ8iVpCR4K9xjVM6NlyaV88s4JV+9ij+1TNypVoJZmaFiqpaHsYuaW5Jr2?=
 =?us-ascii?Q?NzOEbRtsSFag6bojVqQYN/8V7LpHIcySYcy0SfaHJOcAscuIJVKBwbTsy2xq?=
 =?us-ascii?Q?N4U2I7NpXaltk3QIu88roNyPLcd9Gj82f1Fkp2Ph2UB4HV1qjLkm7IFvzHBJ?=
 =?us-ascii?Q?XpUbkAl3CbwMCVooj9k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621b610f-a90a-48a7-32c3-08d9fdf20726
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 15:17:00.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi1cFmAhJWD/LuiKHlvadOhOKtwvkzsh5Exf8P9oboDu1ZYGPhPZbYOh6kvNddts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4783
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D94D30E7-40C9-4331-80D8-8072581C7100_=
Content-Type: text/plain

On 4 Mar 2022, at 4:34, Miaohe Lin wrote:

> Remove the duplicated codes in migrate_pages to simplify the code. Minor
> readability improvement. No functional change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_D94D30E7-40C9-4331-80D8-8072581C7100_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmIiLWgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKuaIQAJ/RGf6CIWZwJZ/eo8nImRwXwH7xbh5t1vx/
e0WYSJr7/gTN/2gyIHi8p9Xov1uRywvCXks0ohNi4a0J5nC+AM9hgjFzjfwlDQ2C
6gNLPi17ibcLGw1o5bAlMBOWAoejwIq8oGNxNYDxvfStsWOGDMUpmZTMG8gHMVA9
cPbYBsqZ+CDEUmR0D7x0Vzb7wIL0sFtdwfOzhxyCNgHloLZoMX+rJIQUFtFidgYz
HmY8zLrPunIh8VFUy43yRyb+yOTd76UMFYsydblTV/DdLxQ+eza2IzhjwTuiqBY5
K6fEFPGuFLzqCDv4OpT/Dy1KhvrmfHnGsFxBlnmgJpeZIMS5PscEXBJZYPmc6OiI
DD+5c0hxrUOOVSTwUiwlzTmKtUO1HciQw+Sgc6KoNAd7c6S5CsEPm70QBUHai0rS
96C6P62pHGzmznKrcjMirJNu7fXRp5Zik1dmdozqV0rq5jFJR3nqqPM0yz7U8wNG
73qBdtaDJ6j/sP4rbAGb9D5itiW24lu+xPh1E0QKOI1Spjkc3kJgnG+jvF4crVVd
uJThhvuc2jPbAWmDp4/IQiM1c4JTHk6x9WV8OiFPey2Zz9TLkdiKXydEMi0NV0fI
/Bm5wNJ1vGPwUCtS7vEperhp5Kwcowm2ZYrnvEz/nwYLQmHDLmExLTQSyu+Ihtsl
vmZee5+B
=ylv6
-----END PGP SIGNATURE-----

--=_MailMate_D94D30E7-40C9-4331-80D8-8072581C7100_=--
