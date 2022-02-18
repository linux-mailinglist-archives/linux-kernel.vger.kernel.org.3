Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FE4BBA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiBROKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiBROKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:10:15 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE51AF07C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z26FYiNCIr4W2JtOV8wyhyodzb9YMbRQ5IORU8vyNXaSeKhTNIf9lJ13BF++8RBaM1xOIZRX+uN2XGwZAFDdme2sCj1o3KGdubPsTC2vWYBMC4AWquosXgZUZ3egELreEwNqhPm6a2mqnKBzCVv5c0Kxd/Qt78z79CRFW/HXYM8PpYP9y1Eje6dB0XSgNnVr96qxF0+6d10DhPkfh+9mcVW3kj6nxdIrdL8raG7nPe4OAIhnWsVFzb+bDpblTZKItYHou+17uyU72+esk2SZgjEW3w7cZPIKOjoI0iYud4zCF1Pjqu/S8RWb0S5llYAABMrBeRDwXKAzOJAu3n1qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXWrQ1wQTyu7ba9ClnJyZOOdVNf3nys/iygpXWFV0Bk=;
 b=VyJC65VVf8Oosrf2qKDTzZYSM8/LknSe9KgZ+Psl4M6gKh+9mgNFirBBrJ7g1pYhMpRIP6TNfUwZtTbL7JS6UYWr0+LlIQ8TpZL9g9DThUaVnJay0arpG18SHEI61YFA22xV4RmJe9G5cTMoO4m7OBnmIolOdekyDWCz4AK5fUvVgTkjiPWg+2rsqDGKnXVw+XDUvoqOgVmdiSaAY3C+HQyWgA90IhE/xauHy0SSCOmc6TxrLm9btqov6ATQfS5km4oj69CjpEwzZTW6OJuNo2Sk43Mqf0afXE1T5TaRBnSG/liznlVzebirEZfz88pVKHh3RRwzXO2GXqn1JNGIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXWrQ1wQTyu7ba9ClnJyZOOdVNf3nys/iygpXWFV0Bk=;
 b=Y/gabrJHFbHm99AsR/9r/RZ9NFcp0VCKKztAb2gHDgiT9brzJLam1Rcy8QSMY4y4EnbrATNKSbjjfoSI8yAtrgNJ/eenmFkJyxHlPG7lAOKtV35iu7uupm3Qx6Hdga0Ou1ivTT8CHAtNQxzyd+r65gpfMvT0sYNVETJ4vDXMGVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 14:09:57 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::1b3:e483:7396:1f98]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::1b3:e483:7396:1f98%3]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 14:09:57 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        xkernel.wang@foxmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH v2 1/2] staging: wfx: fix an error handling in wfx_init_common()
Date:   Fri, 18 Feb 2022 15:09:49 +0100
Message-ID: <1989597.O86Mz80lD7@pc-42>
Organization: Silicon Labs
In-Reply-To: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
References: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PAZP264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::19) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6e7cbb-429f-4d18-86c7-08d9f2e857de
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5939:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5939C870DDDC76730EF9BD0A93379@SJ0PR11MB5939.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET10Ri96R1hg9Xvw1yfLi5c9PE+g1Cap+T8y9GU7s8pSyjgBHc5ozP6kYI8Sus9kiVnk7MJ5jAKDcTr44nSux7OAT0FF2B7DOLZPQ7K05F0zLhkRwzFxNopxplVFRTkzTp91wtL+iQ7nZ8iGSXFukfaLo/qqYmQC2MevFnQC1T3sLMOuxo+FpkVbZA2NYgszS9612//Pijnk2ZHLNqnlZ+saBqD7qXCek4eWzU/xFsFUz5QXRCou3jshR+yXMaDFKyf3FOtm2vSo/R/PNrKdIngEMliNMoyrutJ93KcbvqxVNbAz2XhXFx0/0OZOlRqzBBSq0A9DqvFiMKJEz6wYcHQ524h9ft/WBy1iVUXHKflap6ZBwdsYGfXPLeZc1kgsuzW/dJTWLpaBRDW36gbcJlXeu3R9mV6hyDNKGuUov6ZC/eR2N2lYaOvlG309LJym1CBh2oiMOXPH4+9jnR2A7MMHWjDKqq4400fzDZRzDjXlhu6Ng/YanDsf12UP1wSngtu0VyttXGz4EnfesqXNSm//EK8O54QG+b8FYhqrZ++6fKD6kLFFl1sRYCkh2J/VPo1c7XSMc171di5fI1+MJgezU+/v5+PRupbtOmmTcoCQE0T1pvbJyymSdeZBmZ58N9UyEtBym4CTvbyrNVPndElh6cwaO7GnyraK5+12tkDtVA2KZOPTTHFc7CTHGpCz/nzQUcEbF8mCo3gfFV6TR4Ia3WkNY+1LSE79NlQhjXb4g0XZPHg2+wOvPLfDRhriBnCuGC2s2340PuHGR98O3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6506007)(4326008)(2906002)(33716001)(66574015)(186003)(52116002)(8936002)(5660300002)(6666004)(6512007)(8676002)(26005)(86362001)(6486002)(36916002)(83380400001)(38100700002)(66556008)(66946007)(38350700002)(508600001)(9686003)(316002)(39026012)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aTTIxJ8YwMaIy7gE4UlyaVXVakQ3+GgzzHhf33Uy48Ad6HoUo5QrAvoqhR?=
 =?iso-8859-1?Q?zinjQwqKOUGKcs4HSbcT+AEN7987I3sj0WioCDnSJZf9rxYlqkjHFFZPcR?=
 =?iso-8859-1?Q?tbNYhbZLP8Ct6yDB9+TZdiG03Su1Oo5V2t76VfFjt6RlIkKKiWo3cP62Ry?=
 =?iso-8859-1?Q?IgfIWTqbHvNd0pwgYVGT2Tw8WbzKfTp+ZE1k/z8dpewFI8aj8OiNDQFeAF?=
 =?iso-8859-1?Q?TFdwD+WgQoTl71O/nKRllnDL231K0DJQGBEx6r8grXa/L5c5HoqlsJ+2Ku?=
 =?iso-8859-1?Q?+8r8uioZLnB0hF06Fp3CUNFdmTy3JPlI2b1oN4rBXqfqh/CPlmyibrVN2T?=
 =?iso-8859-1?Q?vS33h9csR/FxW1EgoTsRJwdsW+/CeGsPAD/aaGn1W4bGGEjUZq2CTZo4N1?=
 =?iso-8859-1?Q?zNOiDrSEdu/CHaIbMPACX7x3dwKAmGgu+gLxCotZREo9enMmLgydPOjsea?=
 =?iso-8859-1?Q?mOam45jbGhLBtYZ8YpqKA+zkEeHK/SXB/+gEAr5mvbBhROCSeGAXVvVq1g?=
 =?iso-8859-1?Q?ZNCGsw2Hv5Faofe7Hfg4n1lxE3pMzh1qSQA8x71nnavqNiQGAHx/YUCILa?=
 =?iso-8859-1?Q?OFbrQVagwuaicNJMzEtc6cSF46yCbCMfyGpIiKp3vWgjc1AZNpGCXF3hd+?=
 =?iso-8859-1?Q?WweD4Q0150i4pgQFP4bSKiW33G6yWqXGnjPi5Qs2pLKj+/4bn0ObkWP2mh?=
 =?iso-8859-1?Q?0rl+G+IkXiKMQ02dve/E1ZvreNcXcJXY3xGg/ZePYVGYlDngJKhGrfUbRw?=
 =?iso-8859-1?Q?NnuIVoiURRizN2T5+X2biG19pIC0sCSIFz5LwgWpP54Ely7ACs6QakC3Q6?=
 =?iso-8859-1?Q?2khf4OkaxTVCh2O/vSTgpN690BSJXOI4/fxt5YLxXPg8puk7RyijuvqO1T?=
 =?iso-8859-1?Q?pxKaQjxz1HoyiCumzZBJmUnRlOfsyC3yrlSY6he/l7FQJxQp12O1vRAy2w?=
 =?iso-8859-1?Q?nJmrr2JYgX+HHOGPkOMBNnv57894Rw1EsE1RzeXEb4WoCI3QV3Xwcp1ULJ?=
 =?iso-8859-1?Q?Xc+cLTuBs/DQcFcZciVRLMYElBXy8sAz5AdJaY03RkxV4vXSil3wrzYn0g?=
 =?iso-8859-1?Q?vxYaoCRdOD+jvo3yBn6rc9FSHChBTopNiDQaEOl/YuFBO9LzVQgrGeH3JK?=
 =?iso-8859-1?Q?39q8SKIgsNombIJi9t+44+mvdJ0tsj7nZwdBmzr+qKG+w0Hk+ClkxsACGK?=
 =?iso-8859-1?Q?XvDUxeR2Ef+P1XqejuhiMMOlYHwB0iQmFuXEZ+z+wavJ3pkmOnioqrq+HB?=
 =?iso-8859-1?Q?ww5K75T0y+uX7UteQCWdJLouj7I4P0MXUNUjCHHl7Y7hXP6Yaeh5aJY66t?=
 =?iso-8859-1?Q?RRC1x9hyWochIeGkmJpoUeTlOYLOZMvPWy/pT3sRyOChhBKKU5zCtz00E4?=
 =?iso-8859-1?Q?hYPEjqUDPe/rWK4V4/3VnxvKyaXWH413xODH3Om9CZJgIuvtx4nCYkrXGu?=
 =?iso-8859-1?Q?t+U/9tf9QkaEsKWo7unOJb3jIHz4IDSN4jUkXp9DetbXSW5tGzdgqhqHu1?=
 =?iso-8859-1?Q?hDnZ7B/yUBp3Zsrr+ddOObdM+oQf+oXEx5Aq8920FtduSK37hWlhcT5JIJ?=
 =?iso-8859-1?Q?jivky+ilIz4PSJD171rJ00iCk3yjWKeiVTjQY7e+CT5t6hS7MXR/ITZV4D?=
 =?iso-8859-1?Q?NAFdCtk7ivJVLgD3EGZw7jBsPeQTj8HFBxXWOJ+MfDaSV8X4Cx7H6RjtRn?=
 =?iso-8859-1?Q?VYsQorJG4Hg8yNJmzpU=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e7cbb-429f-4d18-86c7-08d9f2e857de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 14:09:57.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMRHDXH1vhcz72WYU0beybW18VzZnhMh9yXYcyzsyskQjqDI7eoD9AZXIx64RrEUcB8aC3qUAdtAlDR5Qcnsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2022 14:59:45 CET xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> One error handler of wfx_init_common() return without calling
> ieee80211_free_hw(hw), which may result in memory leak. And I add
> one err label to unify the error handler, which is useful for the
> subsequent changes.
>=20
> Suggested-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> Changelog
> v1->v2 restore the wrong modification of a return statement.
>  drivers/staging/wfx/main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 4b9fdf9..9ff69c5 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>         wdev->pdata.gpio_wakeup =3D devm_gpiod_get_optional(dev, "wakeup"=
,
>                                                           GPIOD_OUT_LOW);
>         if (IS_ERR(wdev->pdata.gpio_wakeup))
> -               return NULL;
> +               goto err;
> +
>         if (wdev->pdata.gpio_wakeup)
>                 gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wak=
eup");
>=20
> @@ -328,6 +329,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>                 return NULL;
>=20
>         return wdev;
> +
> +err:
> +       ieee80211_free_hw(hw);
> +       return NULL;
>  }
>=20
>  int wfx_probe(struct wfx_dev *wdev)
> --
>=20

Looks right.

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>



--=20
J=E9r=F4me Pouiller


