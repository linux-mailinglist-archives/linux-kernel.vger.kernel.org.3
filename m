Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362BE4FF086
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiDMH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDMH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:29:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAEC38BCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuE3C5k7HvEn486LoQWRTmlcIPD0M2qVnengjPKEqXkYILYxXj6xv0JmTmguNfAnKngY/hFEbAGmuTZa15ICmjjbHvfGWxooJeCfvhHsTM2IbfAZxkn9vRI3/knDF8/g73lRArYY79pKMHtVCyTCj6LWLHugeam/r1idDJ9nziDsqR07dnwdwE2ZQJXf16SbHnib5sDw89JxrePtOcKScAfStO+shjR8uSadSQJ/SyhkLwtPM3cZeflB+5hJydAFn4iMDr9XhrSUhOxmA34C92K/MoYo8f0EwDiGeGL2BGZrLBeqMdmVzr02P8qT1yrxOElFEADXM0g/fp6LapDuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sl4MBSYoXL459dEMB3iDAIqMWGxJfHf82oXqUAD2Y4=;
 b=gyrVeC2l7DTynQ8n+0TDmQHrl3rjuoiZsJkjePCcuSlVJWYqf+TkcAX1VABsSN2mywQVfJlme7l7feU2l3W/ttvUluIZBne3L+rl3T8iPpAVwWltgVbFYfyLJCXTTAEGXnpCsqEm8tiYpD5ThwSCHECaGKJvdq4KXl843GFVishiLncjjd+Epy/qlNzoPfURycZR0IO+ZFbqAwIC7zYw2o4X3LTW5/JrAxNZM1CHOmKL7Tcg3BdLsfGtKXvdu6p7vsC4lKzxyoZ5WGbVfLNjSEJQiQlgE1sSxZVBynh/06av3ady+LEgPBEU712prC+UmFbbOfl7rYSx6Y3jvmsYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Sl4MBSYoXL459dEMB3iDAIqMWGxJfHf82oXqUAD2Y4=;
 b=Mdg01R2RrKjE4sEGOlseoYGZoQGwsR3I66N8Qht33a80uqxGdoJi9gEX+ayu/rUYxJM6Mi/Dyw7FuSqJf7iq02TUNjKDaGAU7f3xDFL+v5iCkuYFdkxMYLJaJs/eor1AxG6kZ12ouifF64yQq7xJet2gl43Lq98iC+erW8Z7vKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:26:51 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 07:26:51 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Jaehee Park <jhpark1013@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH V3] wfx: use container_of() to get vif
Date:   Wed, 13 Apr 2022 09:26:45 +0200
Message-ID: <2778504.mvXUDI8C0e@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220412041218.GA2859599@jaehee-ThinkPad-X1-Extreme>
References: <20220412041218.GA2859599@jaehee-ThinkPad-X1-Extreme>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::23) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0416c88-ac53-4ef1-ea8d-08da1d1efa78
X-MS-TrafficTypeDiagnostic: BYAPR11MB3029:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3029E8310B3796254256433993EC9@BYAPR11MB3029.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I4lzHqxlovoFwG80SsckrEoQDXE1uVwl3qIzn3/N28pAf2aAybvmaRoDSI8XM/IirVbKBwSw4kHnK6uKbn+R3Mk8ShMVfrtyM7MyPaRjtIvhGlAIUrfU5Nr9S8RT15H6ZNyDUkYlwjaSk1FdmXyjUS6M9pxAQzGEpyvkqm0QEHrigUz+NrMQwlifFai12QWOaCnbMb/GSO4WO2F4rhsvvpeBcWYrSByJIHkyMqqy26BFt36NIr4NDygdTEtIaZcU9OZwQZW+/wxGmL38xyO3WOeMzGdgtYapDhWonIPvU74M+86KowzdlPJV4ksnVduHAOsr/4EQsahq7Kwfmz535vDQbCaxgJb7CoU8D957l2f97bGvV+IJ9HEM3y8uryJKDC8Wuo1y3MpbGgNyOxCCuCwxobXS2RFQcTEvbBL/MqtrzA/9qsN7gO0O4KJYIu787RP6vvblWP1oQttLDd5Ud50tRYsPoMKGr2XYG5tJYcVLUvOLjIUn90xcKhYXMKALB305bln5k2Gy3kWvoHjzLKFSoecfZX0fQQAK30VGP8cusFRcED0kdLeMFR/VDISLWkPOjdtEJSdJKth88RAZCmmVGY3n5Vvod02p7yF8Nj6EMW+XSAprCljKW8V/6SGXofKudmYgzQBNnZHGPwnvRTMb75mbJrARqYZ+dHDHC7CCEvIEOkBpZn9eCfrdOmk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(5660300002)(33716001)(66946007)(2906002)(36916002)(6666004)(508600001)(9686003)(52116002)(6512007)(66476007)(66556008)(110136005)(66574015)(8676002)(8936002)(83380400001)(6486002)(38100700002)(316002)(6506007)(86362001)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OxJX1m73fdqlWQSTaN5Y5A+2MO/TIsx/wWjrrIn5bswSXHn1Mj6X7zYjym?=
 =?iso-8859-1?Q?9g1mbNYl6/q4udNhka8dDpykLFkBVzMDnqUzmnyz/hEnw6dY6RMmvdaZPA?=
 =?iso-8859-1?Q?L/Nx6i+6CZ4KVqzE258oJ6tf3U0fG7AtMUgZPhO9tAHewLIuQYz9ypzYs0?=
 =?iso-8859-1?Q?nRfS2PqnehPV8fPL4cNx1gj1TPmfEtyTJ1zmCOiAp0iPhQeO2YHtu2xCkC?=
 =?iso-8859-1?Q?2blptGakpzFVtuVcwI9YloaW6sQEw5RP42X9tGC8qmwdJY4ePjMhtceq/C?=
 =?iso-8859-1?Q?X7PYoiEMakFnkoT7f6kCpQ6FZsQMp3FrxZKR0iwUw6bJnwQnZYyc5yJJE8?=
 =?iso-8859-1?Q?hA4yyPHqCtki96Kw9F9MAXKN/b5EBR1c/x1slnKY5Ea606Swc9lWllUJ1Y?=
 =?iso-8859-1?Q?YrKtWWZPCbyQi8KnDPxDmTyA2qATootx20nph5siOZYt09ID6DcupLe68q?=
 =?iso-8859-1?Q?OF9I3vRShi04/Tk/V7uqRrXTLZNrz4IE3g2NHzCJmPp+fHzUULd+ySVcmN?=
 =?iso-8859-1?Q?5iVlj7hRJMWYHrX9cP0PDaPtVw+Ape0TfD/ZymCMgglE9E2nmHdasWCZ7X?=
 =?iso-8859-1?Q?jmuC5xP+TMksTH7Vz+uRTRYlwfb/60g24xpQMpCaVDSJWz3QDK7d1svoDU?=
 =?iso-8859-1?Q?BE51P4rLgVL2Ed0+dS8TRp6PAzSFCn5p7gEoCVpYAsqDYF0smy4fXc1Uvp?=
 =?iso-8859-1?Q?BFFtnqn+UEodsYPO+voDaL/LRet0sxytJbNSkwpqCP2TaN4GNMjllyVVYJ?=
 =?iso-8859-1?Q?LPT9DXs131si6Kaijpyi/5vVMUCI/mwavDedsksVXeRZDX+FFNmFrrpAe0?=
 =?iso-8859-1?Q?dVdzWgbakFVHuNWpU72ERxMRqR2Cye0TVR9nDBW+O8yk6G+uwmcfBEXT1y?=
 =?iso-8859-1?Q?zRcUeX0xJFbg285i372CkJkKt+dHoo50O1XztDievnSOf7+DYXzlcrrC/B?=
 =?iso-8859-1?Q?d60j7FJf9GqwiLNw6MPl/EgDYvlNZyB+IExcIyO7GL76jI+KjaCg92816V?=
 =?iso-8859-1?Q?hgJY/BuvCOnUY1y/2ftA1sWU2OWTs0GFJLKTRFrb26+0HqS7zKUrPNuXTe?=
 =?iso-8859-1?Q?wC4T9ujJcQo5v+wDkYK97RzmRfHeVflj51lILE6Ah3+PXuo7/JRAdg09Ir?=
 =?iso-8859-1?Q?Oy4U5vNi8t6CYYKTXKnRkVS+h5NlJUhu9Y+sTcQmA86pjcM9yr4+0iHp8t?=
 =?iso-8859-1?Q?8/fqkLzCfEHgbg5PQb8vNP2Pmeb3EzQNfQgO1fk9hYxLw+0W7peaMW6X1h?=
 =?iso-8859-1?Q?sJ/5h0wIXTvMAhIuTllrxpD+YEPiKscdPlIB6mVNmSwOEyATaeKJsJHllf?=
 =?iso-8859-1?Q?sLlTZfBSzDDUb/qA0e2CLNfyPjQH88OZxYuqlw8bdu3y4Vq1bKJ2Gg/qIv?=
 =?iso-8859-1?Q?GAu/mkdJSMvamzSPWt2wZ9GPSxITq5RYahVX+fgSR9oCm11OPjex4wvG4U?=
 =?iso-8859-1?Q?twrxQNpj0aLgtEzIqQ7dKQ7fl3Uk6DycXitLbRy2c/UXvtpB/QqwZ96wte?=
 =?iso-8859-1?Q?4RC3nuKHUcMhR7vhBDGbMf1KL7kHUGyj/jFkSZqvrg296ICcp7gRdDFNkH?=
 =?iso-8859-1?Q?wqPL/MoRLhA5O3Wot9Ogk+AY+/3CoJTSD20qHxmXODVdI0Yg6pngc/fERa?=
 =?iso-8859-1?Q?Oqal6G8q2z0YvwtfYsctAP9m5p+HUGKLTV8QwN0JULTP8vwhkMm3n8sJ/C?=
 =?iso-8859-1?Q?92KO6qrgdtCIG98+RIHEr2n3joBXg430G+YlhHzr+hBy4rXu8SE+LU+0yd?=
 =?iso-8859-1?Q?opJL9sputWSLoC6/kzmcasKym71jj9Xko3YDFBI9cVVIkm6JySBLVgc+uB?=
 =?iso-8859-1?Q?WonerRz8nHxif4MsrsXsBoIebZLqCiykXW6YWWRQJpSyUI5R64TtltvPQA?=
 =?iso-8859-1?Q?s2?=
X-MS-Exchange-AntiSpam-MessageData-1: BjJTWQHbJDDinw==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0416c88-ac53-4ef1-ea8d-08da1d1efa78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 07:26:51.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzWyWykPM344+jw+adF/NJf8lNnpmI6H70XuOeIATJZ3hIvm4HVZ/CKeb2Czjek/kkgRT7HG6yN2ppYHUL0SYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jaehee,

On Tuesday 12 April 2022 06:12:18 CEST Jaehee Park wrote:
>=20
> Currently, upon virtual interface creation, wfx_add_interface() stores
> a reference to the corresponding struct ieee80211_vif in private data,
> for later usage. This is not needed when using the container_of
> construct. This construct already has all the info it needs to retrieve
> the reference to the corresponding struct from the offset that is
> already available, inherent in container_of(), between its type and
> member inputs (struct ieee80211_vif and drv_priv, respectively).
> Remove vif (which was previously storing the reference to the struct
> ieee80211_vif) from the struct wfx_vif, define a macro
> wvif_to_vif(wvif) for container_of(), and replace all wvif->vif with
> the newly defined container_of construct.
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>=20
> Changes in v3:
> - Made edits to the commit message.
> - Shortened the macro name from wvif_to_vif to to_vif.

hmm... wvif_to_vif() was fine for me (while to_vif() is a bit too
generic).

> - For functions that had more than one instance of vif, defined one
> reference vif at the beginning of the function and used that instead.

I suggest to declare a new variable even if there is only one instance
of vif. So:
  - the code is unified
  - it avoids the syntax foo(var)->bar

> - Broke the if-statements that ran long into two lines.
> (There are 3 lines that exceed 80 by less than 4 characters. Two of
> those lines of code could be shorted but it involved defining two more
> variables, and could potentially make the code less readable.)
>=20
> Note: I will mail this patch to the wireless-next tree after testing.
>=20
>=20
>  drivers/staging/wfx/wfx.h     |  2 +-
>  drivers/staging/wfx/data_rx.c |  5 ++--
>  drivers/staging/wfx/data_tx.c |  2 +-
>  drivers/staging/wfx/key.c     |  2 +-
>  drivers/staging/wfx/queue.c   |  2 +-
>  drivers/staging/wfx/scan.c    | 10 +++++---
>  drivers/staging/wfx/sta.c     | 46 +++++++++++++++++++----------------
>  7 files changed, 38 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> index 78f2a416fe4f..a07baadc5e70 100644
> --- a/drivers/staging/wfx/wfx.h
> +++ b/drivers/staging/wfx/wfx.h
> @@ -25,7 +25,7 @@
>  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
>  #define USEC_PER_TU 1024
>=20
> -#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif,=
 drv_priv))
> +#define to_vif(wvif)container_of((void *)wvif, struct ieee80211_vif, drv=
_priv)

It seems you have stacked up this v3 on your v2. So this v3 does not apply
on any public tree. You have to merge your v2 and your v3.

>=20
>  struct wfx_hwbus_ops;
>=20
> diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.=
c
> index 98c2223089b8..3677b3431467 100644
> --- a/drivers/staging/wfx/data_rx.c
> +++ b/drivers/staging/wfx/data_rx.c

The wfx driver has moved, you have to rebase your work.

[...]

--=20
J=E9r=F4me Pouiller



