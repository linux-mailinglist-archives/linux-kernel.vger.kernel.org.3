Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DD4F5FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiDFNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiDFNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:24:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171464B51BC;
        Wed,  6 Apr 2022 03:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyjFK3LX3kCxWBB9JUTZx9cq9R1TltDJ+HUOf/2kxg6uygNMbkTBgA/ixeUq8/lOgcz6zKdVXTWSsTnLN0v+E0rC6fGqC9Jftri+VtoWcVThYPC5JG+BysJdXR9gSjYTPF8HJxZ0FvAu8H6ZWLvd6W3GyWHqEtEvnJdOhH8oExYW8SWm5W0GJrWDpmL6DdRipUiOgMO3rkfA2sB0HXBrWB4gUJ/6ofUwdM6aDU7gf9jyHS+VuKcw26CBgCSZemhvn3vu1VvtNpMjsxuI4VPBis2cgNp9rhkV23Ji4rKlZkAhptZYO65jCP2p0nDcFASYHOzPhXO4W/C4sUveaHZXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei+eXuVp+AnXYrZkPK/jJT0FBtnfmqEEmFKs+L2PFK0=;
 b=OajWbjrU4rGlWsg6khuyA6Fiu1oraT+5NE9LRc+nvfjOHc1BSrMme2A0cA7U9EhcAekjplgWpnIOKFDorJqF9JIhIMEeNc2F9oQ7MBxQA5gAxihlgscwA46CKg1K798b7M8CRKTH3zWD8RrE+EX40kIc3SnZ44PUKskLyyam+ZlzCSCob8cXbMBkF0pDIXmsk9MdNxtq5KVP7sYxftCYUM+myV0mfv01J6sGjLERHLepya/larXj8LTdqN6fQqqG6L8/hObDIIsLx/Jp75ummgxJKZJ+9YvxkKwJ9P/Q6MNpykTzXUszkak/dDYq/Nmfa3mOVkxDgIYFRlbjzrtuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei+eXuVp+AnXYrZkPK/jJT0FBtnfmqEEmFKs+L2PFK0=;
 b=cFcjNpqbPzqg2QrRGqFZ5j1lhdAez4akuahisfBrE12tnGOh4bUwCHLYbhukV1wBpG17VfYqVvI5PLElDaN57uqfe/25BZc2QwccILdBGFmCdS+1JaB6wSi3ZJ8hE3qBCzP+iKml5n5dN92XNZv+Oju395A9Y1nQVr/YKhH2PAs=
Received: from DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10)
 by DBBPR04MB6330.eurprd04.prod.outlook.com (2603:10a6:10:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:18:49 +0000
Received: from DU2PR04MB9082.eurprd04.prod.outlook.com
 ([fe80::31d4:4644:d8b8:2b74]) by DU2PR04MB9082.eurprd04.prod.outlook.com
 ([fe80::31d4:4644:d8b8:2b74%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 10:18:49 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] remoteproc: imx_dsp_rproc: Make rsc_table optional
Thread-Topic: [PATCH] remoteproc: imx_dsp_rproc: Make rsc_table optional
Thread-Index: AQHYROqwwU4P4PKJAku1tOtg7L4orqzitRgw
Date:   Wed, 6 Apr 2022 10:18:49 +0000
Message-ID: <DU2PR04MB90822E836A7415C43BBF7C0FE3E79@DU2PR04MB9082.eurprd04.prod.outlook.com>
References: <20220331103237.340796-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20220331103237.340796-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33142ea9-0876-448b-a947-08da17b6d789
x-ms-traffictypediagnostic: DBBPR04MB6330:EE_
x-microsoft-antispam-prvs: <DBBPR04MB633009EAE083AD4EE9F24A5EE3E79@DBBPR04MB6330.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUbVc3cxR16ZCJvr7h8x2xjJk2sE024NBTrAL+C0P1owQN9hWrZghdhS4LuAjI75OXx9Ijj05qdi0c5utW+28ZubIGg1tRal+/nNdbpdoFQusOKLqvU/Du8Mb/AqnLqWuawRohEU2dE77XgPcKrB13QVcRT4JMyrTR32DV5fG7hboYqim2eBUblRe3j0f12KYxvu3ZAq2hcwOFczBb4KkWo+GpTNT/EKsp3BAjwZ8AEUqf8xuLPT03eU1/HYNwXOxW717LnVzNzYvww0N9qscZwW1KGBRqiMvJ02gBp0c4aZkEH6h+6voHNa+FKDUjwZhZCyZSJ2EMKGyYfIzJvfMKQyGi61ibPlgNxjkRA/pWDltqxQlvmqVTF8XSndYaSmG2GUv0rxpLqww3byioQwtd5bKvL4OWZ02XrwU6FAe+uuXKHadbdlNq+g10c5CYkHoJ+yzn2IxU3SsRXvOvMn7GCVA7i42zlBeiyubz602bxVI0rd9EiiQU2DaRpbsg0M9r8Zi7WohSdWOlnVOfpzTFNG1OMz4SjwrCLw2MT2OoxKotk+wD5Iz8dgUSMpGDDbdZ+hqQs/SomxDgJmceAX6BPUlvzdKQozFzLOmVcQY+BJIXqj+rIKs/+UNM8uhrekPCJITixbCujnWWoAQrjrH1mcYYLeNyNHX+dNJlw9KJY+0gNHPLxrZOH6BCSkIxGRaGyVOACzqGegiM6JGtleGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9082.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(5660300002)(186003)(9686003)(55016003)(2906002)(316002)(122000001)(38100700002)(76116006)(8676002)(66476007)(66446008)(64756008)(83380400001)(4326008)(33656002)(6506007)(508600001)(54906003)(66946007)(71200400001)(7696005)(52536014)(86362001)(110136005)(66556008)(8936002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KGjI8Kh+Rb+ikQsLoAyNhspM8YZSF27KTXQYtwQa8xWlr28PBz+6Q2dWW41W?=
 =?us-ascii?Q?uvsJ2ow8Izy9tpmsOiEMSE9J8nB8ol9l6Bb1CYzwfSFcLYiYCaflHGXHtGkR?=
 =?us-ascii?Q?6jUY76PhzCJs81A8XBELxnwG8IdwJlBJEfBPNbCOPMqsFC0kwT+NYqtJcdoF?=
 =?us-ascii?Q?9pBR88AyusIuPGHbu5i/RkGAW8BT3qeByUXPQ5eHUJc/H1BJULbCxMRjNHa+?=
 =?us-ascii?Q?ppXszq0Uu9yoNx53oPWDoPLl7pLtyIdY0ePHQKFqniAhol7BPOEWf3GgeUD7?=
 =?us-ascii?Q?eIPkvdJFlLfX0BpRKHLZay0pUSVE67xZHO1q8mjB5LgGePE2W5KDCJoD5e6g?=
 =?us-ascii?Q?LZkKzxUJFjbzQwPGY6VViy0On+/uOmsbzy3L/PA8jdm45ZBuMv5hmy7OLfYY?=
 =?us-ascii?Q?jvjvTDJGwVJra6fk3XmgvyQewmzaOAC1b4HZnB6MknlsrLPLRZ+B3anKS3yG?=
 =?us-ascii?Q?wx6UNnlmFsrq/NN6RjPeXYt4+WaMaXauWyjQCSgM9rx+FBS3EfQuAVjT1onl?=
 =?us-ascii?Q?TgG1Fh930oE5a/e1+nOh7NAJPxMKLMAqXGgFfWgI5UNPxn+A913waVyyX9VW?=
 =?us-ascii?Q?OXmQwUeAJaSwIzmwODSebzkXXAiUCWiM9xfJLxQosh7qJH7fTvSCZmSvHfOg?=
 =?us-ascii?Q?+j8la+ceq5BtyjI/HlUd/63CNqpS3+vyMklLG9lHHf4Vwj7s9zOIQ0VKntcg?=
 =?us-ascii?Q?xkJrcGVih+aWHcCjmulTNTHU40pOmEYFEfxC4TNcyjavx6ESi3EVMRnivRlT?=
 =?us-ascii?Q?UvLOWrb+dI94Qg/gjqQBjRjpvXHuJBfxFWhtw4vUg8+Qc9EfKAwMTcfNhFuP?=
 =?us-ascii?Q?DcrZRlskeATCN7gggThzjlcNfmuyPidX0GuVxIeHd6fFETXNW2Dqqj8x7cTa?=
 =?us-ascii?Q?rh17EQDlIVKdd3dZ/4vZbkVPpalMwlidbGRhcl6Ev908gXaBOpLg0+U63rgX?=
 =?us-ascii?Q?KPVQ/wkSAlBEHp22N4SDpgGwflt4ijj5qFCU5ivJb9e5hSs+orqOhvF/41RY?=
 =?us-ascii?Q?s8TxA5nzxh4S0oX5Da4X8yyu2tvo0duFKBE+Dcvx6WmGskspuu7dg9xVTwme?=
 =?us-ascii?Q?TGNgAm23puJTqhGQ/2At88SWbLlLJe0k06WUoPxLftRTzVPPoDYhcX+yrRFa?=
 =?us-ascii?Q?sArVIqm+2eWYkZ6768GcuPSyw5uO3FzlDO17EMgMO08nyK2r7kszBhwQ+0Lv?=
 =?us-ascii?Q?6Eu2TjDPDiMcGmapA7Amj+I5oCl/SMwea3SYxPzcU1wZchB+qvtGe1GY5A0Z?=
 =?us-ascii?Q?0JiXKscYpQvw5a5YZ0Xi8IqdLYgpbBD24eScXwiVR5xO6wATkGG+7GvWdTOD?=
 =?us-ascii?Q?BI6b0eIMrrDYhEAftaZsum4Otl/Xdt6HZCTjN/OTtvgkFmFwXXwkuth4XmYZ?=
 =?us-ascii?Q?YBp943kqq08sNyrNuKPJDYZESNpTMH2QuXbSY3WaBxTQJOssUwnJ3BWgEqjT?=
 =?us-ascii?Q?eNf1FpO82kLckEOmVcLrjTxRB8DUUqkSpvQoiobtb4xgS1y5iR+mYX0LP4yt?=
 =?us-ascii?Q?sH0aU2hOX7jv1ZCzjHND4vH2vG18IuanvcSf3sB/kUgRmIhy2HVNVBEO9kfn?=
 =?us-ascii?Q?MGMbS0PN0UBRP1ZTa/z8paDZgsr9Tv90oG5Oqd9RGoDJ+LyhSxlvKMajvs6J?=
 =?us-ascii?Q?Q0Xsl9ib8TaptYf3AkqAtejDoY+umC10r9HqDsOr55Tk9KPpVRmqbobe2iyk?=
 =?us-ascii?Q?+cQUrarWU8+Y+JxV25pQT8SIyxj0Cr0XvOccyb3A0CIl4yMIECjBrF9Bxksy?=
 =?us-ascii?Q?yY2R52vKvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9082.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33142ea9-0876-448b-a947-08da17b6d789
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:18:49.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIXZ/D3lNGxKw3cDejsTwFzvg52w/DfcnHkuHgpBqH8EgT5RgXA8wXAKfLu9FLtGYRCYM82h/1zZOhiihmUoHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>=20
> There are cases when we want to test a simple "hello world"
> app on the DSP and we do not need a resource table.
>=20
> remoteproc core allows us having an optional rsc_table.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu

> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
> b/drivers/remoteproc/imx_dsp_rproc.c
> index 2abee78df96e..987ab1add761 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -802,6 +802,14 @@ static void imx_dsp_rproc_kick(struct rproc *rproc,
> int vqid)
>  		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid,
> err);  }
>=20
> +static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct
> +firmware *fw) {
> +	if (rproc_elf_load_rsc_table(rproc, fw))
> +		dev_warn(&rproc->dev, "no resource table found for this
> firmware\n");
> +
> +	return 0;
> +}
> +
>  static const struct rproc_ops imx_dsp_rproc_ops =3D {
>  	.prepare	=3D imx_dsp_rproc_prepare,
>  	.unprepare	=3D imx_dsp_rproc_unprepare,
> @@ -809,7 +817,7 @@ static const struct rproc_ops imx_dsp_rproc_ops =3D {
>  	.stop		=3D imx_dsp_rproc_stop,
>  	.kick		=3D imx_dsp_rproc_kick,
>  	.load		=3D imx_dsp_rproc_elf_load_segments,
> -	.parse_fw	=3D rproc_elf_load_rsc_table,
> +	.parse_fw	=3D imx_dsp_rproc_parse_fw,
>  	.sanity_check	=3D rproc_elf_sanity_check,
>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
>  };
> --
> 2.27.0

