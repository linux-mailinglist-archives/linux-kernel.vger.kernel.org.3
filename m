Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381C4B8735
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiBPL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:56:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiBPL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:56:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9664C3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:56:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAHzoTyCyO4lsEI5tDMPgeXRBNxKH+DGT27b6scpc0cFHmR9K4F3wZDVtp+JZImTlc6PJXl6Up75eEqs7T1/86TXu7u5L2vrJ6/mmOI5Jt+WJTj1lIknbj7sS49uiPr+Xi0clQNcDbqBq9a6UbK0DWNGHIqksxJ5eJQ1MIMwuSl//5Oqk3Yi6AfHFAMsRS1kJt2OsFRG7Tsh5aS9iMDFDpxr/LMmC4s8ON3HP3eATJRVNF1rn74nRWOwRSWXfcsbf5mkOwgm+pRM+OQSdipdG9vupAJNSV5yQKW6WkD6UZkHbZ/BphJ/lfdJHNAGqro+M/lIHWmjMEnGdjg+rV5rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCmfdc0IwwCJOwRv/ZjPB+C4oAyaarmPYfqTA0SVJcs=;
 b=nyfNMKr5OZlWHxk40Z6c4p1uLW52m/nL7f0zYfJEgFOF9nKgZus7XZtWXl94lpfElI5HgtnAbrBdMmK5oyyytq2gPi6n9GjtgCE23y6XdV1k57hxl6gQ3Omgp1FVoDSjqUtXB9vPY5LtEFktQmOVec4/5GV8BzxpVFssuIPGMvb15+MBhr6pLARQyZGaOjhcd3LvlU84oUqeSljoxgtIc/kqnVEYh/aVVYfaF080iUFLRR1zYym3Za3S7DC53gfsFF0c/uO8otWwwhO+vU8OW0wQ7Tdz+UVivazE1O6yFWXyryLqOBo7h8mAz6IkHQ1FU3r4/OWHBNlMKt/Gs6Kdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCmfdc0IwwCJOwRv/ZjPB+C4oAyaarmPYfqTA0SVJcs=;
 b=DoJunuDNh+Fcix7OM3AiMP+xcBeI/Rf7pv7NYgssrDesAk95dYerChjrHl5dc/Ck2N1qF6/4CnzlgLwb8U8y1jQvyT0aaWPZLjVsqyq9TADxJJp2CR4mRzacy/4pCcPOMgDTGjrhXBSbC+pfv7ZgJfExSxvOv1ZtayuwT+pdLAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:56:21 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::1b3:e483:7396:1f98]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::1b3:e483:7396:1f98%3]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 11:56:21 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: check the return value of devm_kmalloc()
Date:   Wed, 16 Feb 2022 12:56:14 +0100
Message-ID: <1660310.YPgQWDYhUI@pc-42>
Organization: Silicon Labs
In-Reply-To: <tencent_BD0AC737C546F88052FF7F11881D3350EE06@qq.com>
References: <tencent_BD0AC737C546F88052FF7F11881D3350EE06@qq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::25)
 To PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e3a89e-4551-4b45-7c68-08d9f14358d2
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5133:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB51336C15F44B0279B052BC8993359@SJ0PR11MB5133.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4y+EgOLSosn9JZPnkznIq9TUeSX9nbn6qOOG2UnTDJo9PKFFh1FfzZ21A21HCJMMhrV7UsT2juWBuDdLaQNbtavieg42doWCabbu+wO/Ht41jWv76reJ57kD25SfsOVG+NhwSd9BIOVMONfGr883sWIDXysGZYMmsyOCiDHO9yvB3deldFlbT+f3O4P/HMeuciwJlbOuxa05wgSmZ6iaic9GJ7+9QueWOYUdIGAB42NV+vv9+6XkMlo2GdpZF1Okwb1eAlF0B/zHAV/h/3qN5xEbVmTZyKTRvdTOQ97VsYXC6G0fdi+ZaooS9F4QhO+uEedchmSyaIoDGc+gKyDAg7XlO0/06tD+53q073+malq2Ioa6C94p456rKcSNmdN97izbiYMq9gXYJOsMXN5+2wTZhYiJPo/aI9bALWG/3L2drwuiW1KNdOS6eVJHI0yuk+HNCYVuLsm9GHazFS+lZOq2aOvw34eQ9WVwL5/OfoZbNR1e/ojwQcZ7Yu6xZA/kPoZTdGIauT9K0PPCY2mQmnmjcijQ9jkNZ5WkHI6MAAz62f5AYJmrxI5WAu+hIOem1wOVLYtG0Km/ekUbXFF3e/+fuD8z8aQTT4zrVPYK9Zy6gRjdEEUcqih/zKYIuUhS0La37taxuE9coZrIKhaeJ5Bqxne9WePWE4w5BSwTspINgSixSira11G45zSlE7yMIfSgMx9NxxRmUTQlChfrWZFCM/TfwMxf9v7eXZ7amo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(508600001)(66574015)(86362001)(66946007)(66476007)(52116002)(26005)(186003)(83380400001)(8936002)(6486002)(316002)(38350700002)(38100700002)(6916009)(4326008)(33716001)(8676002)(9686003)(6506007)(6512007)(66556008)(2906002)(6666004)(36916002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2DrZtLQrXL4dDs89Li9Jf9pvxEJo5bzHc/6+jO5gbnYcl29+oK5jhQUETY?=
 =?iso-8859-1?Q?0O29v/YKvjvTVU0+d8B+EPsaJ5HI8Ld6DMvvXBcm7iRP0bM9cckHv+1eWU?=
 =?iso-8859-1?Q?H6NqiOPA/Mfv6S32qbHrSLkEnZMLfvPh+BPNTkNbuGXCi54nqSjGAnbyH4?=
 =?iso-8859-1?Q?gRYHQIiXIgh8hANzo8Ap5nTI/pGlbOl1pPykDGpwRaNCZXCYPiYnsH42Wa?=
 =?iso-8859-1?Q?IVppQpNnCO/Ivq8BBDcsyGbYnqt3M24npiHw/u9ptk4+hcq+fUwkEYqAzF?=
 =?iso-8859-1?Q?LzyWwp9q4Jfd2Bu3qOYP41vPqIWoK/TzkZjqdxebv7lIYvke28926YtVUh?=
 =?iso-8859-1?Q?AIvepy1IFZlSlFKDN1SgdWIqBvz9ASOweaSr26SDFI6CF9js6vE2YE3pfH?=
 =?iso-8859-1?Q?KUmtK5JuxKUIv8eGUL1VeSKIHo2R7yluYmSy+qizQTILs4vyT+txhJDG9E?=
 =?iso-8859-1?Q?VGnwCHxcspr5Y4uyxeFpWiQUOjUAxzDvilht0FaOcWG/KSI/S5fjfar1mH?=
 =?iso-8859-1?Q?Ol+uxOhIPGWrTxTtXoFeoA2EPQq0yeGv6Jh0d+vokK4R1g/b9eDc4GURh+?=
 =?iso-8859-1?Q?FK3a+6HYZOaipVij9+rbeeZVBSwywXa8Q68ZjPPJdTlKf1OKegkL7nBh1a?=
 =?iso-8859-1?Q?3PkI8ZAdZ+1bxWjEssky/d4eaag+z46maVer11O/zId6odAtGLIGctzQEC?=
 =?iso-8859-1?Q?gBTEHPEhmmP9rQwOcqdFJtoIi3DYeKAcffhX9TusP1G+wRNim2+m4fJULG?=
 =?iso-8859-1?Q?AFvsqyBJ2uoHTYWmvuqCTxcKP8qZs83UxnzhWIcgtQr3t4sIhNvwma5COs?=
 =?iso-8859-1?Q?UrcZdTk+SrLJL3skMvvHTstK7Ea7ACyx+GtXfNmmAROL6mO5xFvycq10gf?=
 =?iso-8859-1?Q?J7aSj2gDDhef17poq6qhL07+yhhwdHZMIMMw6fwteqfi0VUCv6s1LS1I1a?=
 =?iso-8859-1?Q?/uHCLS90TC5RmZOlzVERpJWL90a1WPvVjuRWh8f5iSjSEuXYBk0mMi33QZ?=
 =?iso-8859-1?Q?wuJOPMi1wbh+uW9ziKnyepyfGInix5QJU97edu3kG53K8nOe4DXiX50O0M?=
 =?iso-8859-1?Q?u0kKXnL6Hau26mVV5pkNAhj1245cYkNVYdu2+2ui/xzoKeqfpLSM7StLBl?=
 =?iso-8859-1?Q?pb/nigLNm8xqd/dv/LeMyV1gLyVTGV7+DU+UFZqCGnHvTtfwghylvqfZRg?=
 =?iso-8859-1?Q?tzSJ2WVf2yaIFkmB5Xj0yENQfIycu7UHLWbkwYWlmuTh0TEr3wpG604DCw?=
 =?iso-8859-1?Q?Mdu17Gh1Q3URbjs+zLF6ZXIAWX8LW4mM4de2CERC/EWDD9WacKcQqTTsKh?=
 =?iso-8859-1?Q?4U5PDO3elYtEwO5psjVpnyIVFSP+sZPVJRjtObtcnWVCbHSaqCcUZ36Rri?=
 =?iso-8859-1?Q?opc4L60dCZ4mVINxeFSH1UPauesGVzk98XetYB6/e9tRKMOD0HX+EOnf8z?=
 =?iso-8859-1?Q?ABjF7O32pbTXj93jeAtCE8/fS3OPS5So3D7fZU34ysUNWONpnUHF1pJNIs?=
 =?iso-8859-1?Q?a8sVWHRw7lz71Xrv7w+iXh7tVSDGKDX4lgsYkkVPogLHThVwES9AR+7eew?=
 =?iso-8859-1?Q?HL11AIKNMm2XG4alpgs1i2xem/jvCItScYVHxu1Acqii5p4M1pCGsQwZeg?=
 =?iso-8859-1?Q?5EBx4sX+PvBRmKGmw5ra1r5Z2Yl7/bHj72aiYe7+af7pje9a9ROXBYGz4g?=
 =?iso-8859-1?Q?oZ46ZwohmWnW3GOsbd8=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e3a89e-4551-4b45-7c68-08d9f14358d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:56:20.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOkY4K4sxxa6pDPE1bLoakHrbkrI00b3sa3J0ywl5/t4HoNg+SNLKIx/5Dj6v867jtDh3blR7aLhV71CM7Bq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2022 12:29:50 CET xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> devm_kmalloc() returns a pointer to allocated memory on success, NULL
> on failure. While there is a memory allocation of devm_kmalloc()
> without proper check. It is better to check the return value of it to
> prevent wrong memory access.
>=20
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/wfx/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 4b9fdf9..0ef9225 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -294,6 +294,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>         hw->wiphy->n_iface_combinations =3D ARRAY_SIZE(wfx_iface_combinat=
ions);
>         hw->wiphy->iface_combinations =3D wfx_iface_combinations;
>         hw->wiphy->bands[NL80211_BAND_2GHZ] =3D devm_kmalloc(dev, sizeof(=
wfx_band_2ghz), GFP_KERNEL);
> +       if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
> +               return NULL;
>         // FIXME: also copy wfx_rates and wfx_2ghz_chantable
>         memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
>                sizeof(wfx_band_2ghz));
> --
>=20

Good catch! However, I think you should call ieee80211_free_hw(hw)
before to return.

While reviewing your code, I have noticed that all the error handlers
of this function return without calling ieee80211_free_hw(hw).

--=20
J=E9r=F4me Pouiller


