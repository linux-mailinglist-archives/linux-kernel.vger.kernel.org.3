Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D645775F3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiGQL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:28:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B469215708;
        Sun, 17 Jul 2022 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658057291; x=1689593291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Ozo+aECynEsx1dEYhKgc8LSpIDCoEoIOiZXsMP8f44=;
  b=eEZjZNCIztkiD2tWbRvawvgvAG08mkoxcto04wrL2/Wjo1Sk9AMRCY+O
   gO5AHBwQplE1RudqFLuQkGZOju9c40Lp4D0BVS7bxvt1V3l+IdPMfrmj+
   vMNf18ZVwwKwYDXO9K2TQSdOVKGiXWV+7y1fukZTwJnK27eKz55sLYZph
   mvB8+JoKsHQAOnw8TbOP/EYlT+fLpxjyXUECPDwQzDX5fQe4rpqzuT4Ru
   ZyvlPVwiUrVoF7F7P10daHJhJf0+qPIhlAO9y9arKSGUgaFdoZ9JbdOhm
   WgQiPWDdgr5yjab5+OH6FgPnwO5heB6FbiV93htfksj3Gun05qxfgzIog
   g==;
X-IronPort-AV: E=Sophos;i="5.92,279,1650902400"; 
   d="scan'208";a="206634075"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2022 19:28:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnCd0nlcXh8abxGLWCZLTLjugctpc+qzg9Iuw3TJEfASJ/85YL2TO9TwWH3gOE2Jj6zAO/lYXmWSql4bYUgyRv4DbUMqsVgSxuEFyGFQuY0Smwe3Gap3zUNyeWrphYGX6Y5FkxIz9vndGt8m+EnkhhF0rG1IsRvzC4eg75394qagsumHYyzBEpSiE6M1/ZR0snNgk48pff/8Lh8uchyhJY0lI/54CoeBc481m5l+QPbBiWelq0QVDxBc0RwuaPIA89hiT2uUt98T8KySLcnegikk1hT4JNvdi5S1Zrk2f7gf5zjbVUaoqOOAELCjUGixjx4OclqBmxruk3KAFkyS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDVxtsBzCmFDzXEb62qR+H12l0fwc1rTkic2bZaeH4k=;
 b=LBMjLOGlEfOl3dkrJlC1ltoO7nzwFyWdqdlE5jh1YmEA4OCceE1m7r2OWP5Jrdtjx4zu19TZktj117oBduZnRJj04l+6nGbhC0/KwcAlamC6k0iKDg+P4FBsaB5zmHWFYJaTuA2vpWoAp+udd+2IIp3E8YogJo49lI37aC05ujgSHJNRJiQ+0Hasjce/Zelj0j/KKeU9IDQuv235YYaumYY4iKvCR5RC3Wj3fmW6zfUEWyIGqP/Ew+MUirAvr6HvAfuod7KBJMeHviBNkjXL0Hi+Ozpj/IOIxX3ZWdvQHKe1sjIRjihOXGKPeo0NcGm7Fh3gV/dKqyiCY7TqGl41Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDVxtsBzCmFDzXEb62qR+H12l0fwc1rTkic2bZaeH4k=;
 b=GLFY1Z86LUTpBBqVd3LYVkFUhLmq7g3u9lgRysMuebnmqSzViyMlZBB8KputhzfiPGS6CSJHSnX9Z7JmUTGVGFm76VKJ3NV2ezlDVHkYuUZVpBWFdtWF4hZEmJti0nIt5ICc8a5GeUTPpjiMJWDoAVOBDFvp/eqWGeMgTk6aDww=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SN2PR04MB2334.namprd04.prod.outlook.com (2603:10b6:804:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 11:28:07 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::c5bf:1046:2bad:5e75]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::c5bf:1046:2bad:5e75%6]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 11:28:07 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq2Clh+w
Date:   Sun, 17 Jul 2022 11:28:07 +0000
Message-ID: <BY5PR04MB632776263A4B37AEB7373DE4ED8D9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
In-Reply-To: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7b8389d-d348-4d51-4186-08da67e76bfb
x-ms-traffictypediagnostic: SN2PR04MB2334:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mNKALFgzyOjSZenYc/gv3wKT2YOKvkRbjonhhUIGbJeMIKwY5/JjPjup5acJpWtcMjHyusldhua1UHPMg2+HJFPMl+xm5+8+q9wSgFeYr7wsquJezNlKlH89X+lcbqJZJCm8RaD7McYApRpvZtyr24F6f/orXRj/2aDRc5r5JEo0QrAK6Uh07991xi3GiFFGrbdzOS/o+etaz/zsB/K21Zj+3UL/3QDoNspfbPFNZYSV66lUwd+xJkqSV3n50a5WPiO/ddlYAp2xzFcdRuT0V0XjArRmNnd3My6iHshgMUzRm70lPgRdVJHFG9hYzL2dEv9wgyH9ssFP9z+YDtH27ZQJf9kRKdw7/C64mUjJ6CIPvAIZCFx+3e/Dmf1/FZ0ZeXC3TnWumNkQw6v0Wge/IOGeNg/Nvdm+KtTtYjyoP7t4SONTs28OwWbyreq8bMdlDitpVeDRUQaDDZWtSGh5kmQfUgXADBa2XZFrNzUtc8TV+j+0P9vmcgik86UWCqfLWUZQ5RpCahDfg1C/dwvdEMzi87/+urVIFzdG0jxKh1URsNQiCBQXuC+V5CAnV7CJ8A/C8eXRKvzMfZoMdI09RL1ffevmX05iMMAZKKqWm+MEHIGoL7YCcPU1q5/+Vh3sehmKRPS9muStIfPK3SG5GtBDJYcLd4q+0wwyBXp3640c+dfxcAVtMvUWCqFRY1ADJOHp39Kb4NQBTAIlXqTkSSWYTvDyUfsBlu4PuGupA+AKdvDReXwfrCzSDgN08/NkeJXWqJeX3gTT6//QwvyuRodiULSK2/HAM+G8nFatTabQ7mRicMhrtAYvGs2XPqo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(9686003)(8936002)(86362001)(5660300002)(2906002)(64756008)(7696005)(6506007)(54906003)(110136005)(316002)(66476007)(8676002)(66946007)(66556008)(33656002)(4326008)(66446008)(76116006)(55016003)(52536014)(478600001)(122000001)(38100700002)(41300700001)(82960400001)(71200400001)(26005)(53546011)(83380400001)(38070700005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bbDvEYYgte0m7W0dHSyTKXONLT7253off+g8F0+Eh8zYUokxNcDOdXIuT76h?=
 =?us-ascii?Q?9O9W4mv1bSID5zMtxrUJp12o4ctXo/CNaX15zg6DUkDCdJaYzG8T8dLNoi62?=
 =?us-ascii?Q?1CYnWdCcmPINlOmx0ATuMUc8U5/zAzzzl4Xy2f2GDz+Y0lv9dcl9KG0xvpBA?=
 =?us-ascii?Q?AE+kSE+Q7f5KjQ/lo4DOXoYRCHaAhgYTdhtFnnt+U1FbDGxpBIsdDD0qQr3Q?=
 =?us-ascii?Q?BDmZx8ZgHH51Q3++NcXPHa+UqY4pCxNdiTy4mng2Nj5u4YeEuWykMT0cSVNF?=
 =?us-ascii?Q?X40oRo4fXpG7eTJEySxHaSKBLWS0hyIRCrYUDznodboEqIXdRDTQIDYIHc3H?=
 =?us-ascii?Q?8LbDQX4/YaFdiA7mJrH1nA7VYrGQHV0ZjI/1pcHA9Q+HDyjY7k+Y7mDOKkHK?=
 =?us-ascii?Q?hCViNiXZV9Tm3GOOtPW0N3a1PFVJAl5putBqnW8pPmlLqK3XPtiQp9LHJ+22?=
 =?us-ascii?Q?QqkAfghtvqQg/dnyKWEk8dMlk+ujD/Bc5lBGx1+MneQXSsyZs4UnnYdvcPV7?=
 =?us-ascii?Q?arRSPzc69pglYL51AeYwGu+gxK8Szwv0pper4z65RrJI/e5chH2ZhI+bDWm/?=
 =?us-ascii?Q?cYhCPvbaRgJR1Cw/Whifs9Q2jVanQ9jAJQQHiQHRXERJ7rXW9eHpan7qL2xN?=
 =?us-ascii?Q?LKEQ8Tus67JWuAHWmBvRTlpy5JfuOBzG9iPmJQ5RA+xnj3b6dKQQAIQZyW9A?=
 =?us-ascii?Q?CiwoIRzCdTiQZGikS89W8N92LR9hKYlxCNpsAs9g/qVIBJdMWn1FdXfr78ef?=
 =?us-ascii?Q?V3IUsc3IsRL/5cQpt+vL79L8mk4nhnDrcBBheBzJAR8swYiR38DIEZhOhVVC?=
 =?us-ascii?Q?QknE7o8DzcTMhnV3ewHdTlulAhhbkINSf9ME4a+bJwQv2qhGfJFwliHS3aMg?=
 =?us-ascii?Q?iULHF2xjkmE98jUX7F5mzyxCintxbW94ycbYO7iNLX+12MOIj8NNlRhVJE1h?=
 =?us-ascii?Q?j+xUs37CM8w7KghZBYNVAd0qql9EXxJcp5tKDmodbJsEIewez22ltK1SUb9s?=
 =?us-ascii?Q?ofqg3AnGe2JvGrXTd0pnlLfQx5bUzOT4qz7DgM01oO2q9HOXACmB2vi4Cvue?=
 =?us-ascii?Q?3f84FI+gG4RONket4Nn90gU93lIIXZvSfwuauKLx+rAAcoruh+ez3+2op3GR?=
 =?us-ascii?Q?Ov4sK5YQ4F+wPZJ0j9Nw+9EvWqqAyASMyvKJKn6SG3jl1RIVYz+V95FC7Hs2?=
 =?us-ascii?Q?TKrcBMhJF2r8lyj0oQU7NgwIUeYvKwJWeQq540D2ACR0/lfLvXYZnsOaIcGo?=
 =?us-ascii?Q?VDA2U4EDOrQxPfqdDdusfdKfXPgjn5C3nsB2ORf+J+IFmgFdi/BbNIUC8DwD?=
 =?us-ascii?Q?zCN1mUjmrR+ozj0KOs6/G9MfYPk+sueR9Drr0sZ1yCih/VZja/L/zdi2Upbf?=
 =?us-ascii?Q?dsvX92MaQ2jw7084wSdl/HJ9iM1QYMPVxF4kYxJ+ftEXP/AtZTifcpZxgzqE?=
 =?us-ascii?Q?bEoYqzcF+rD9VnPpLWOZjGPhz1Ab9m/0iEoEihoKSx5vR4eH3R73Rv3owDg3?=
 =?us-ascii?Q?Cw/5dO3MJRbAZsmAW0zko1iim+gEPg64ybChTiZa4USaEIWgrR30tacCcTXL?=
 =?us-ascii?Q?8U3K19/wHFXPaKRSTx9q9BEcOp6YrYG59lA8dCPk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8389d-d348-4d51-4186-08da67e76bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 11:28:07.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CW41O05pMSnODn2CZFnp7q1zoZAveb9Y7AiyLCXxdPyX3014vvu1Bu+0jAZFPiF7FBW5CAY9DQvLgIFMXralQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2334
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

The bsg driver allows user space to send device management commands.
As such, it is often used by field application engineers to debug various p=
roblems, and as a test bed for new features as well.

Let's not bound ourself to hard coded descriptor sizes, as the new Descript=
ors that supports new features are not defined yet.

Please consider this patch series for kernel v5.20

Regards
Arthur

> -----Original Message-----
> From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Sent: Monday, June 20, 2022 3:26 PM
> To: James; E.J.Bottomley; jejb@linux.vnet.ibm.com; Martin; K.Petersen;
> martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Bean; Huo;
> beanhuo@micron.com; Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Subject: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size functi=
on
>=20
> The bsg driver allows user space to send device management commands.
> As such, it is often used by field application engineers to debug various
> problems,
> and as a test bed for new features as well.
>=20
> Let's not bound ourself to hard coded descriptor sizes, as the new
> Descriptors that supports new features are not defined yet.
>=20
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
>  drivers/scsi/ufs/ufs_bsg.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
> index 39bf204..7c56eba 100644
> --- a/drivers/scsi/ufs/ufs_bsg.c
> +++ b/drivers/scsi/ufs/ufs_bsg.c
> @@ -6,24 +6,6 @@
>   */
>  #include "ufs_bsg.h"
>=20
> -static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_le=
n,
> -				       struct utp_upiu_query *qr)
> -{
> -	int desc_size =3D be16_to_cpu(qr->length);
> -	int desc_id =3D qr->idn;
> -
> -	if (desc_size <=3D 0)
> -		return -EINVAL;
> -
> -	ufshcd_map_desc_id_to_length(hba, desc_id, desc_len);
> -	if (!*desc_len)
> -		return -EINVAL;
> -
> -	*desc_len =3D min_t(int, *desc_len, desc_size);
> -
> -	return 0;
> -}
> -
>  static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
>  				     unsigned int request_len,
>  				     unsigned int reply_len)
> @@ -52,13 +34,11 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba
> *hba, struct bsg_job *job,
>  		goto out;
>=20
>  	qr =3D &bsg_request->upiu_req.qr;
> -	if (ufs_bsg_get_query_desc_size(hba, desc_len, qr)) {
> -		dev_err(hba->dev, "Illegal desc size\n");
> -		return -EINVAL;
> -	}
> +	*desc_len =3D be16_to_cpu(qr->length);
>=20
> -	if (*desc_len > job->request_payload.payload_len) {
> -		dev_err(hba->dev, "Illegal desc size\n");
> +	if (*desc_len <=3D 0 || *desc_len > QUERY_DESC_MAX_SIZE ||
> +	    *desc_len > job->request_payload.payload_len) {
> +		dev_err(hba->dev, "Illegal desc size %d\n", *desc_len);
>  		return -EINVAL;
>  	}
>=20
> --
> 2.7.4

