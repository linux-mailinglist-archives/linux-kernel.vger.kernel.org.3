Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F316C4D7B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiCNHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiCNHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:23:42 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140053.outbound.protection.outlook.com [40.107.14.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923140A19;
        Mon, 14 Mar 2022 00:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hszfeKvM3NiqNhh4sNIDw9aC0Icz+zJWkOIGnIhxRKuVl1EleEvVfEfku2olq2G/WFRVityZHMqzw+J6bz4e9OoLHB5+1+IbuBy2qARYzCqKNCbPBtshkOkfsd7QoBXGDQgk3luww3p2FBBu7OU0ETtUSEbyO0N9PjzdvlgfutQULLuC4hVV84IbXDxc3+lpTTpMuELCwRjA20Flfk3DTBRHD1cjaQQ7POVykYdDTWn4NsI/D5QyUjVagf8ZdRrcJRl+8ZH3go0x80Oao6ydVT9lzUCaNQVZ7R5CjEzTEofCosybN/sd/sd6s1iNx1UM3ggL4YoVpk3RBV/JdWJOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBQP2MmE4zLC6uYJwImphwCLNW4mFWOGPChqqFzq/VM=;
 b=FqDvaOzKwp0J/bdgZYFHIn3wo467dS4Sl2Vrd0i0rKSM7WMKw6vO8nCcy8oWxcbCZIU68veO4tbjs6EyJx5WGn7WqitL6rKTd3qkyJ+X2kI1Oe+eq3jAILhtPoq9Ox4I9ypp+6QYRLKqRvnK4vcV2BeuUOAYnbIOwGKybhTn6R8oeeYvYlq8KvmKYo9dPhVwV0sfKexpOM+iNmZzFLQ4DsDKk2TNr8RshQaZVLIHtpoGgyz4rPPfDvfNPHH17h72PTE4lN7CExSJJgNCUTYj8a/lDKD1DtIip/3WWq/ousQUhKmRlvL9CbQAY9WI0Knk4lujKt1oh2/SRq3cheQMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBQP2MmE4zLC6uYJwImphwCLNW4mFWOGPChqqFzq/VM=;
 b=ZMiNlhw5oOGthwSq2pAKGA88gOlaJSBM8MU7Ii4LYgXGo8wNCsmycwf+GtP3uwMWUDTeaeytQb25q3OxRtOFyjjVCXXAm64zgXnc7qivyeKU8q1WB0+0T4zcI8sHHNxyztu/SvduLyf1MKkn1VESiJwE+y72ygZpKOIgSTi7+us=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6191.eurprd04.prod.outlook.com (2603:10a6:803:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 07:22:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 07:22:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Lijun Fang <fanglijun3@huawei.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shijie Qin <shijie.qin@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "xuqiang36@huawei.com" <xuqiang36@huawei.com>
Subject: RE: [PATCH] media: amphion: Add missing of_node_put() in
 vpu_core_parse_dt
Thread-Topic: [PATCH] media: amphion: Add missing of_node_put() in
 vpu_core_parse_dt
Thread-Index: AQHYN2qDmrXoQOWOAE6bqCxhuuKd8ay+eVPQ
Date:   Mon, 14 Mar 2022 07:22:30 +0000
Message-ID: <AM6PR04MB63411E778D7D0F0495A415B0E70F9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220314060952.66762-1-fanglijun3@huawei.com>
In-Reply-To: <20220314060952.66762-1-fanglijun3@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee51c570-b373-4d08-6d6b-08da058b669d
x-ms-traffictypediagnostic: VI1PR04MB6191:EE_
x-microsoft-antispam-prvs: <VI1PR04MB61915A738072C07747AB1494E70F9@VI1PR04MB6191.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6/QJu1Qphn/EdkrXTi7nUSP8jk8GbwWX8o5L6xWXsq4ot3Ltd6qqdmot1nWmeCu7XUrTCKpzjLC+AMzylRZMQ9CxG+TBd0qSsHy+xsarqKuhvrUBbVwhVP3hG0Axnrer32G/E5b1VVI8j0I/nkK4XsIn3R736vvbdg0xqYCusAcBw0eAeKnkong6vmxciJ1NQh6IGrY6PoLanWTVGMHOPqR5L0al8wUi3ModsqMWzkJIijpOg9z98Ej7/GQ+wX44i6WRhJbAn+Iya/fznkDDNnVYHRXFhD7QvJtIRWc8LKjDcQ/t3ndPacHvt1+nj8vjHbsgpqFEQSncgfZXCph9bke5IuHcS1K3ejm/u4pUotLWVBfdsv4GD0BC17y9mkM2+ke+kD5NtcyA8pXL//x23crnbxQN2iBZK+1mIMizZRsY51ialVD1GDDVh2Bfa0xInwIaBKxZkFCa+x56cw1tfToo9YYhlJxzdsCXgr20fWlw+eK7Dii8Udb2tDjQNK8VAqnXQV0dAod2K1reSM+aBQjc04NSHggzigUOXkKxBdh2t4yADPNXuK90AwY7nxrrgxNflUoZKvImVposPFHrs02CEAXT3j44CNziuxaL5TrvAJXD5AAEx7tkgolllManDx5ZbsWyyBordo1INXd0CwvwczQvR8Zl/nAvvd+QNUoyWQe/bASVpAK2v66i4/k/pYUjaCz/0lEufjpbcgPQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(55016003)(110136005)(54906003)(52536014)(26005)(186003)(498600001)(5660300002)(2906002)(38070700005)(8936002)(86362001)(76116006)(33656002)(9686003)(6506007)(7696005)(8676002)(53546011)(71200400001)(44832011)(122000001)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ziDtPMag8ivCayZnWP38gK23L4Kt3itBZaeWuzjBzvaEDhxdAsxLIF5DKuik?=
 =?us-ascii?Q?yGSs+SDnWc/JDYSf8w9asjRQ+mWTRsjZzGk18Jc8oX8rRinZYH1YLZdKwr4q?=
 =?us-ascii?Q?GMDYZA41SxgrJUsaKzJPWF1QGzEj0Hxuy9cgAPAGpAPDetK7xS2Qqk4SE3I8?=
 =?us-ascii?Q?AbYDny9Iepxp5WMOTObwm660n0R6wcfywYcMy2J3kv36qSNp3V+BImH8Ge+3?=
 =?us-ascii?Q?A9PRk3z/4MkBjVCveWxrArdCJxG/E4hCz4DoB6b1IxRe41FZYvckJDkUJTB8?=
 =?us-ascii?Q?iUsxKXKII+sLMO/72jQX3+chb11FDSWKJGjCuwKbtvvyOpHLUGgvviPyNuwG?=
 =?us-ascii?Q?d/A06FJKvE+0LHfHp1IJAW7jHcZOBcWTDrdFvOjnEfV/kYbo3G2jQxfMp7Xc?=
 =?us-ascii?Q?/wdCgMv6+H93tuS8EwNfZCHDY/BFwwf3sHLX91n6vXHt5E1jS5A+38GRQw8N?=
 =?us-ascii?Q?AGAcnBw02otmTIgnd25JCJlA3TFrtsMCCjmI42i+K/stpX+k2uE9EKDWHUjj?=
 =?us-ascii?Q?rg3aaDnSq90iZjKJMva/JgCnBw6oRTTql8zNTGunIwoOlRS48klyUpQH7a8u?=
 =?us-ascii?Q?fYvrome2rEscdNMI8FCCLVKSxRc5uOgvb2O9+BDesEV70IO8MVBJm/2JOrUo?=
 =?us-ascii?Q?XgnKf2TD/ejGiN/gml3F4kUeo/oFiIBnxVdQr4q4ZDPW27xBA2x5XFNLHnCv?=
 =?us-ascii?Q?FMrrhbQvPf0gAR1+mjfqmLLyIefrB6SkqdAe3mW7Xr5ynUGn0bgrfo04JIbu?=
 =?us-ascii?Q?3AAxx0XS0JSu3jghhtsKraoZ1sf00oLphLE/zgsPHAAFs/LAhw3Vyb0YNvVN?=
 =?us-ascii?Q?jkWSiFG7qFtjmxf4Utcu1RRGFl1RsGxag8/mMO1hurDz9uXsiuwf/YvmllMs?=
 =?us-ascii?Q?xzvgr0YH2zrxS/kKHMm2r0ycvQbiT32q6yY04FCO9SLxrEz3h6tMnkEzByVV?=
 =?us-ascii?Q?FmXUQwRJOpGKX3gcoWTp8eU9pCwDgr9M0x3l+HQQD8pY0Tfzqkxqn1I9uQ6D?=
 =?us-ascii?Q?+OCr8TYaxayUFso/qfcD8AdDxZF8h0k+hyX/EspA5yfkJyQ1ooPeyuGUzjf9?=
 =?us-ascii?Q?dgZWZqYOYKNK1//g+HJ1P0tiPVYHohJ3Rbv1X4lJXxdYtoxgo48prhBBijz7?=
 =?us-ascii?Q?e6slO43DRDYmMv4plNxSILYwWIrSfdInHlCrcyCfscnCNsbNSQmEGn/+TAud?=
 =?us-ascii?Q?54XeqRzv0jf2urN+8AbFo8/IsYBGM6vMNyjE5gZPg5o4LOp43mDLt8qZlsuJ?=
 =?us-ascii?Q?7RH1NFuA0EZkvQtX8MDGXPLg+HZJMrJXr0goQEMnZKnstAjwVCmbgTTs2hih?=
 =?us-ascii?Q?+uT7F248V9CH4fC29CFDgU5F25+2+RDPuxWfjp+Sqp7Sw2jFHgE5xJwbJj22?=
 =?us-ascii?Q?BoQcIls0GxBJGNkUnolF7F2aspzhSKzTVOqZaLB2tydJ+tYm+bi8gcJSiQJm?=
 =?us-ascii?Q?aWF37+JjVcI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee51c570-b373-4d08-6d6b-08da058b669d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 07:22:30.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iW3yjDeYe8OuQgWJO4og2AMwpqrzmb75BQ2JF+UrGsiblvwT5xUPmoW3bd88kkPbSiLDLYI2Mtt8hMUY3s1TFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lijun Fang [mailto:fanglijun3@huawei.com]
> Sent: Monday, March 14, 2022 2:10 PM
> To: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Ming Qian <ming.qian@nxp.com>; Shijie Qin <shijie.qin@nxp.com>; Eagle
> Zhou <eagle.zhou@nxp.com>; mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> xuqiang36@huawei.com
> Subject: [PATCH] media: amphion: Add missing of_node_put() in
> vpu_core_parse_dt
>=20
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
>=20
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Signed-off-by: Lijun Fang <fanglijun3@huawei.com>

Reviewed-by: Ming Qian <ming.qian@nxp.com>

> ---
>  drivers/media/platform/amphion/vpu_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/media/platform/amphion/vpu_core.c
> b/drivers/media/platform/amphion/vpu_core.c
> index 016554387f3f..74edc4abbdaa 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -529,10 +529,12 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	}
>  	if (of_address_to_resource(node, 0, &res)) {
>  		dev_err(core->dev, "boot-region of_address_to_resource error\n");
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>  	core->fw.phys =3D res.start;
>  	core->fw.length =3D resource_size(&res);
> +	of_node_put(node);
>=20
>  	node =3D of_parse_phandle(np, "memory-region", 1);
>  	if (!node) {
> @@ -541,10 +543,12 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	}
>  	if (of_address_to_resource(node, 0, &res)) {
>  		dev_err(core->dev, "rpc-region of_address_to_resource error\n");
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>  	core->rpc.phys =3D res.start;
>  	core->rpc.length =3D resource_size(&res);
> +	of_node_put(node);
>=20
>  	if (core->rpc.length < core->res->rpc_size + core->res->fwlog_size) {
>  		dev_err(core->dev, "the rpc-region <%pad, 0x%x> is not enough\n",
> --
> 2.17.1

