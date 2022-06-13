Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89454803A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiFMHNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbiFMHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:13:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2029.outbound.protection.outlook.com [40.92.15.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80731A39D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJYMcC1h2uNHeDXTNuT9EacLUMBfppaj7GrTaBl2WwxoGV90yqEMA4nPT2oVYqqTENhuX1mvlRCgQDMA8zNxj6G5GGsXd9k3K8RjIqmQVX47lJ95ojg4kJd9YOfIKDdxdj+Pik5wgFhFU1qSbefdRDP/piO+CJTOc/j0IVN/579/1N0ZJzsAWiIZrpoaVUZOP1qp1cHoIioK++nzcIeUb/jU6tvk7My28MjjawB9cjC9BPiV//iNtoB8+LaFHT3ULiouKik+TraAq0F9Lgf0KiCLVykM8B47/+N6oHPTZk8JQMCKPdesv/JqfgKu9wIG+uOPbyT7qIsrgdw7cv2vxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9ZR38d2m9pWWbV7fc5+J+nFUW4ZQH2+cYNkyJ5QDXU=;
 b=a9PcHQhPyxzaAU3yv2y6UH2psva79mk4ktq9MrQkIknQPCkuwNAV8AJDiMVyMqgSBgj014s86zdHzkSrFh7EINW1tTBROGY8cdYKWWojt0IyExXINZFzTNasf0KvP66pFbgDyYzu+W+/c55WUSzjIwrJEOiksEbO93DM2XU/kGp2yvEGABUzhrn+Egms1mD+LYl95S7lA8K84HmmFzrqM3f5QlxJh2hdQbkj2kr/CJR/rRyCCZ0U7jDlYYYM2k4mjsTD1TpVpQBSn6HD8ZAit1ZJ39O90zIfdc6nth1mJiD6DgujAQJJMRDp5Pqk7Fzm9laFpDgRQxuGmP2t0drqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ZR38d2m9pWWbV7fc5+J+nFUW4ZQH2+cYNkyJ5QDXU=;
 b=Lrql+VVAUjE5ytipWtGaasRmRa7EQIB67IgPJhmR7Q2eM78RdNDT4Yeshi0rZSFwx+DyQjgKG6E2aP1FG0tuoK5RE+fHoZGh5DXy5EGHMdLEua8RbO1IlfT2+iKZwqp+HfLYrXkQsw4Bit5iGHFFOfA7liV0p+25UjQeHDPg0E+CZv5dL9OfDK02zTTXUDdu27a1TkESSlU7semcZV50/zLFSwPNkPyhxLunezg9wGEiosCLWNJdbxs68TkwjjEmC6LL8xRqzP7v5dIjlgJcSF1S8WQbimIdA8imFHTS5wC76CU7/C1UpGQV3GbW0oX6xbgCm3pWr1HH9clSNAQp/w==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by BY5PR14MB4216.namprd14.prod.outlook.com (2603:10b6:a03:1f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 07:13:27 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f%7]) with mapi id 15.20.5332.014; Mon, 13 Jun 2022
 07:13:27 +0000
Date:   Mon, 13 Jun 2022 15:13:21 +0800
From:   Coelacanthus <coelacanthus@outlook.com>
To:     Conor.Dooley@microchip.com
Cc:     Celeste Liu <coelacanthus@outlook.com>, xctan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>,
        Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v2] riscv: don't allow write but not read page mapping
 request in mmap
Message-ID: <PH7PR14MB55946D1E731B18BA3497798ECEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
Mail-Followup-To: Coelacanthus <coelacanthus@outlook.com>,
        Conor.Dooley@microchip.com, xctan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Yash Shah <yash.shah@sifive.com>
References: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
 <ea438a37-1736-27bb-32d5-560fd434654c@microchip.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YFluiDTjNFOmVFB+"
Content-Disposition: inline
In-Reply-To: <ea438a37-1736-27bb-32d5-560fd434654c@microchip.com>
X-Operating-System: Linux Coelacanthus-laptop 5.18.3-zen1-1-zen
X-Mailer: Mutt 2.2.6 (2022-06-05)
X-PGP-Key: https://keys.openpgp.org/vks/v1/by-fingerprint/892EBC7DC392DFF9C9C03F1D15F4180E73787863
X-TMN:  [JL7TTZ+t8jP+KrmJfNoObPrZbGUFkaojWGffE12jAtwYPRuW1OCPKvt7xWQ+2xZ/]
X-ClientProxiedBy: TYCPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::9) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <YqbjkfkSOOq+IrNm@Coelacanthus-laptop.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c86bdde-3cca-47e4-0ea5-08da4d0c3607
X-MS-Exchange-SLBlob-MailProps: zswcL9HXbeX0Z+F30L03/a7lqRASefvbMrfFlrSmAR02aMGzdnu8EcgCb6ge+sg/pGxHbrw1CP8i+DrGANhysWjAUGGt2YIGInkSpL2womq28FXjYuvO2omD8S52eaaS/ssbdeMdulHbvQQF8qlPbN+z8OeL8bnNGaSSc3QgvVMkQuMzs8XTahiaf1Y7hiMwQ1hdxZfyKT9y6D5k9Wt+MuA/fYwOeYvTzafslEKmnkD4G6KCmlEPewcZUoCLbhYdILnvOG0Ljce7TbKHf3Kq+eJh61dd8LsCqdcjkf/7BriyQvcs1ThQYrnq8/Jr2LHqc52tHSIkoX4CVWYjyVr25/jbmfXnmCuJ+lt7v+mLBY94cwpBv5lDdF0KQB/q/64MkupUqIU5FvKutPATIQnCWjneiiQtlfLqq2L8HyeT4y2pJq/fm3Oc0xKKU0U+yJpSWcTlDK7ZfGfnDc63jpz77Qq/9XTW+yxN/wMQdUYS9oJ3eAxwHjsXbCZRip24hmIUUNSmrfhza/n97l7cflRKNDhryNlFVOhNNJ+B91roPmwzM6JM8Vu/JpQVgs5ubjHS/Z2NRCr4cS2sW+wKmLNJ/45VXeX+holN+gLevUozVH8XUwVOIEN1PrETDmyRMPL/nO4Ky9tY/SVB9IrjsM2uUqWygaW0eyzMnek74B77sZM0gSAj4kqqxOA+UBFJypw7b2LsZdKwW269JR2UpJTBly5aWU/UCgW7xG+qfb4GDbAllWg68pmNeQpJqMG9ho6y
X-MS-TrafficTypeDiagnostic: BY5PR14MB4216:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A80G0yjetUeSCaHfowR8DLJmWV70q2666rBo1UWCkchjBUsC5J18fzDLVoBrLB7Mdkk3wbCJNj1etpEOPa78kj6Dnhdb9dTh4EjwYvf3XYPgIG93y0zX72/RzQa3wuvWafGrymbzE90wHdGGu7bSt69AuQ4oVw2UirY6lEsGAJr2nTZkdAUz3rAQP1O6na+gUFTtctwPMHi9IwrtJ2UHyvP1MICndSKbHj1xBOBI3MrLBemLqR59YxU0qX9TxvyB4bHI05aQCcR0z0t/yFSsR5HIcsoZvsrhCKHsQLJJK4az7t9D62OycSl01jAAFXUkXTDtBAEmh9vz+vCZ4a3+7XbnJpPzgZzdrnm9yzJUsoGizGeX1pg02Os3QVgaxJpTWKQTC8mZWDEkUMfDj/MhIweb1fcJbp+2UVV/1ADgeZItq8kc9sQRZ8AGhM0gPFEGtkG1/LLcoAk9tQv0q0xaJUZs+xtr4Cbs4B2zKC0VABd59CwSMCVfVyc0HasD0cXp3/LvJ6gJ+caezPmwyRQMXiZENVMKHD0wW58MSoBXhuMxmFZH25RZ87SdUKxFgDs8Ni/uZrWyyvp7zsl9CUq/KkCfrkiHaZKll6FKMbxxwmBWruN1pQdOTx4i/WcQwZ+C
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzwdu21EJobXqlNEbhk5GLr0K18wr9geS9aPHkNibasjCg0EtliYSZzPHlQo?=
 =?us-ascii?Q?BhLMjqPqsZuDUd5nzANqQnrllIWkzoPv1TxxSkdlBwL/tJECb1sRCDLYI70G?=
 =?us-ascii?Q?bdknvf5LKoEpWUE40w9hYzTB2ezdNLxZl2rzvZ1uKBh/wzBmaYYsA8wFmvGX?=
 =?us-ascii?Q?P8FY3MiERLCUBHea9ZpwFatc9A/nPVtanWqER2Q1u4VShOUQIqAlh8m0DhsG?=
 =?us-ascii?Q?TgF2+lkPSNmgfNuMVoukLj4aZ9Vo4khCgdCOctiJIA7Wyjm4zxChp058fZnd?=
 =?us-ascii?Q?1PHy1DuTXDx3AZwRCVms0qzVMbE+X9S9cNcuvICfFiSLRMoD1X2GsD+xuJMw?=
 =?us-ascii?Q?cWflbfNev9F8lfV7wirA6y6ENFxiUKCfOsqigbbqNwtbZDyKPE3zPIkv2Krx?=
 =?us-ascii?Q?fAOq4hVwdmTCHSikiZ9ElFkgzyBQjFsLiXESNGQZCL94XvAOAy3yUR2clrR2?=
 =?us-ascii?Q?QIrVVRBagKzCsKJSu72dG6EZrcosL9VBbd9hXJpUhGPjbEzBHu0fndhBljsq?=
 =?us-ascii?Q?1SGKHbPlmh3kS/d4LeTmAuXc44htlChDzoef0nSma6e/rcp7yoJzv1HgVv50?=
 =?us-ascii?Q?sPCbjOXrzoBVQO3n2iBfEqm7zQkji5UrVeKnzMEnblYOoQaZhT2C8fst/9FZ?=
 =?us-ascii?Q?eHi4belHGdCWNR1+7E3jRuQ7ViCxnhYSZ0hg/iZVgdPadfXZOI4I8nS3hTZa?=
 =?us-ascii?Q?uz95s3uD6f+FN60F6ZVEqFRiW8c/lgAMdVv+XieKFEpLeiERMvuzbY6nSIC5?=
 =?us-ascii?Q?zp8oGbNSNfnZAIAjgDzsvw2slDi6vh3Nu9TuvW/a7WLMRII1bWkB8b3zu9Xe?=
 =?us-ascii?Q?+q6dN2v50SK8clWGJxOUJ00mj+0nUOQS4mxgMQ5dzqHS2XKT/4z78yf5+Au4?=
 =?us-ascii?Q?ccxcDA32jq51PluFibBCtqW0xRrvq+x+7QwEWzsSFIUwiF8PPesCeOaWFynL?=
 =?us-ascii?Q?r0cZNSgZoyABi2Zp+VEILXNswPgMaOPiaRtXttk7ONqloEeFcRLtT2HwF9Tl?=
 =?us-ascii?Q?pJ2GC447KAiLgIfZkjDC5VTCUfhDTN0F+RqQytaVhcatbUBqjqknatU/T2IO?=
 =?us-ascii?Q?WhOaIaAypnrgja9rw1WIQPcifbBZB+4TbGrI27Z1m0xXp9eFsXwGTyOR5fmu?=
 =?us-ascii?Q?iRbXfSPY5ExkzFPGKN4YZ9xfFJ/iSlX3wl6PZByikjNZKq9lBIKWKNuyU7/L?=
 =?us-ascii?Q?LhYPMtgxm6hWRN30o5sU/d5OddZfC57aWBcCA+uuSuuaKQWzLjcg2eCeXcMY?=
 =?us-ascii?Q?P7eOB0a8BFacVhQOI6ohS9RhnE9AYBjnkZGUInC9IoZcKyuepvBjKQRlk4fH?=
 =?us-ascii?Q?ns8DySAxyObvD65ZTKsuAgKHJ6NfovluNZktJbQzmtQU+krVAG++56szJiGZ?=
 =?us-ascii?Q?FVfV9E8rPYTY7NYYoAqr9cw9Qiwwfpk0XbAfA5XH3u4LAoea92Ln4visz81N?=
 =?us-ascii?Q?nVwNbACpTovsI2/iREqU4bCskCqFJ5AG+xKTmihFv2ppazjWWc1d0k9r23lT?=
 =?us-ascii?Q?THaxxPzY+A3fdRdrt78DFODtB+tszYrhcZsy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c86bdde-3cca-47e4-0ea5-08da4d0c3607
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 07:13:26.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB4216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--YFluiDTjNFOmVFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 06:25:22AM +0000, Conor.Dooley@microchip.com wrote:
> Those don't look like "real" names?
> https:
> //www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

oh, I will correct it in next version.

--
Best Regards
 Celeste Liu

--YFluiDTjNFOmVFB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQWueXrpnXi8KYNNJjjXInkWGeuNQUCYqbjjwAKCRDjXInkWGeu
NcyLAQDG2gNL9r+GO0I+ZtN3e5iMjsfLQ8axg2R/lO4zA9q0/QEAgr0OgzNL3EWM
IK3faWw5GKDBCUsj23RgrXeXsU+eTAY=
=jZnh
-----END PGP SIGNATURE-----

--YFluiDTjNFOmVFB+--
