Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE74EBB26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiC3GyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiC3GyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:54:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC1B2463
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMOptLhZERyND42ZavEOAtSMH/Gl2mMMsxctHLxeTDwzborFVdi4an+V9QcMdVSE3z+dbFbcDtGXupaNPYzmOfGZBFmJT9m46tzyyalsu8QDpyiqgWkWxqVsK+v338dJjYXHfrG/7VMNEtIbfzUEOf7Ua78wUWQLN5yCoTFBE4ekVQwnOAY/FCXR1/GUjO155kzXZvR3s1gWbxFKiT9+l/Os2MUJRF7/8ihPzKihPR9aUK28egOhIiiTxioGK2ok7EPGBzbJp9DqgCFBK6JrBTjIcHYkdWz/yrmZXBHd3ccmUI00Bj24hVp6IyypO3plugB0i8JeK+zcZn9jwuOiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWLdO0xScF9kASCt76Ry54r40vcPsHj663uZUBBcx/E=;
 b=WSk6A4OVjurGTmyUCT3tvLUFqEpVnCpt1qUuWjQ+vHSx+5X11CRWQSx8ypdlWVA+dicEJgDc2RJxgBY7NXPqUyhtO0sRe5dQ3F6QLFuLV7u7Ybpv83XJjyMkXHBiI3Ox/5WhnvyjDs9jX82PQLtcz5pdv7KuENViXF49RCha9M4hoSPoY6VWhu7KXcu3FV+jE+uWCQKQpcpVBjLveSOvPyarmlmCU++6dR6EiP6F0CoVL0FZtxm2bFZ8GS8gGZHlTxdwdfqgTD2V/BY5ChWWQBh2eA2QFxG6t/8EIR62B3L7ht2t66Tgq7jR5WAazhgfcVOuUZk89/C44NCv136M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWLdO0xScF9kASCt76Ry54r40vcPsHj663uZUBBcx/E=;
 b=qjhTVaO7I87nxKaDbK9SS9V1aju49js7AYFsCplHG8AvMMjo3agg6Eqd6GH1xUm5Mk6myypYVWjx2ARnfSX0jwoxA6nEJCwjfJHE4xbz0duXAYzoJ8I5cJ9PhnGRuv73p74TJTNWVK9B39kWZ3KRDEEoPY9RI/N+pzHuSIFzFwks+YpSNfu7o+I/WhLkegvdjLSxtvWk6KOvHnpOy23pZShkS2szWOGt7NFm+A/tgXT6+I3h3OOukGdC7RNpWzbvsvewbROctpC4mb/WPjBOf6nAzYot5NYEXyKo6yPI8jKbZ4MSN1G4c5zcG6lNmJ5fHuSoD8c9Ybl+Eqspzvuj9w==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BN6PR1201MB0035.namprd12.prod.outlook.com (2603:10b6:405:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 06:52:12 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42%7]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 06:52:12 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND V2 2/3] vdpa: mlx5: synchronize driver status with
 CVQ
Thread-Topic: [PATCH RESEND V2 2/3] vdpa: mlx5: synchronize driver status with
 CVQ
Thread-Index: AQHYQyR0zKsgbTiUe0iTU8OkeFJURqzXfu3g
Date:   Wed, 30 Mar 2022 06:52:12 +0000
Message-ID: <DM8PR12MB54001E9C39450E33CE7CAFACAB1F9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220329042109.4029-1-jasowang@redhat.com>
 <20220329042109.4029-2-jasowang@redhat.com>
In-Reply-To: <20220329042109.4029-2-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2afa9f-8d95-49e6-73a8-08da1219d178
x-ms-traffictypediagnostic: BN6PR1201MB0035:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0035CDC6AB2CFDCE167BB937AB1F9@BN6PR1201MB0035.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EeT+cw7HBx8s6EsXFC92tgpEF8qLLqOg5yHIWo8JRiU0siAnkxJeLOCLNLqOO3otkIVt+qG1iKjjubF98rDjlHw1tvMZQXqdzvGRMdEEMaLUkvfbfCMFeQ6qCeMgaNaV41Ha8uFKooT1Z9LK+GChxcdfuY6Ve/i77LlQokeXwZAPq5bTKUxVsC8WFs/WgPoUKMOPmN9k/pTOGoA3uGguP+xh23sO2APp64wtElVVaTECwEG+TIGID8yt0cIzbvxZDGfe6Y8rlShvLI1crz6VH+f40ojv5ne0p9GJB3ADsLxFqUFAjY3ZzhrLRADTCsM08iJGLnUlJ12aoy0uF3dN3VcJoSdIdh3O9ZzkzyrYRGrNeYB2c1MLQNLYQNnebsil4iPdQwAwTHabCOlGTIQEfEv24GAhXe/zcqkBZnxrOLFX8j5SwOPSNJq2XZ4kTB+2OOyDNjCiMi94eQe+pEkZy0n71BsreWAl9RbBbZ7slRx56H5aZLnxSAUCfgxv9j+q0Flr5LwP3CmbG0r0h3Ak6Br7xUGVsSk58u24w3LEbkOMb2rKvdx7ZbVkf1quuIaJEWmWuhFRcN+j+WnTtXmr/pjyCXqgSkz5zbPG9a1dYq1WX67LlQvxUMUoJjpEKl+EAYfAcF5aYisGwCt9UH1GcLajkTgF5GPJxflyzwYuxXYaJu706kY9BxuyZYnt4OBKzWVVLjGzjdEEzJY0CIo1MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(86362001)(38100700002)(9686003)(38070700005)(186003)(26005)(7696005)(6506007)(122000001)(83380400001)(52536014)(316002)(508600001)(64756008)(4326008)(8676002)(66476007)(66556008)(55016003)(2906002)(66946007)(8936002)(54906003)(33656002)(5660300002)(76116006)(66446008)(110136005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rtzuO6QMG/C9I2MmujPxkkGx+RGl+FO39h/GSdltbizqv2pEhvtjdge11N+v?=
 =?us-ascii?Q?a+DdpjLYj/kR1SbEhwVhDEZn93GKAfO1bK7NJe5sFUwcIx7TVg0MMiycjtyn?=
 =?us-ascii?Q?BSTVVehurD+wudb09aLPidU3d8TtfeuQoXN1oQYZJPABjaoYUOV/w0L4QoIO?=
 =?us-ascii?Q?av7zl3xRXSZ509+iyaZV9bXbvJVwRs620A5/kw6O64zEeuSxpVkYAtrfA2Yh?=
 =?us-ascii?Q?yTpcz92YfhvdB61u5J3bqCp4ApTpsYgaE4ACfM7ydvNDl/k0xNKH2MCVw9/X?=
 =?us-ascii?Q?cE0nCa1VHJig+sdYPlbHmbekEtxekds4WSF5WZsfc8/gJqvwwW/EnBD86G/3?=
 =?us-ascii?Q?DzquYy0HywTY+0Nzje84ERCwTj0IX0YlCM0hUGap+PKLlIDOl7svoIJX42IF?=
 =?us-ascii?Q?FDPZY2jkU1G4Nex+M5haPZwgR8tX9GhW2Cez61RTwsr5tjEnJA1ffNm93oFs?=
 =?us-ascii?Q?kBIwAtC0F1SOKJN2jBOfFLQR2Aqz2TUckdwexCIde7FYFH+NURFO1xY+QHmO?=
 =?us-ascii?Q?Opk6owoHdLYgvfKAaEybgAbxYnE7nxgcWiQthz0K4edYAsyNxhG1s2AOdH1a?=
 =?us-ascii?Q?JDqLE15xRyX+z4c+siAdx72JHrLA97KqyIl8qBdGMX0zeBGOEftvVnQq/8Ml?=
 =?us-ascii?Q?2TxYxjDY3DxNypTkmrll5XcSld4u2K21nftuRxRGhh3upkCPiBr7iDNmwzWb?=
 =?us-ascii?Q?gNy+waUkswbLUNFzMMbHL9e9IXYKumTZMSNQHuOecocQ4ZBDx5mBR4vv7CRx?=
 =?us-ascii?Q?WiKa1MuA4WOuKTP8V+AXOF348MeXj+T92G1FUshNSz7cIlR6pHxWjFc5SNGE?=
 =?us-ascii?Q?WBSrjhmStJq7UhoNfawPPbHRgOOBCK4aGVf0H2UghTYKFZw5jwm1uuabdub9?=
 =?us-ascii?Q?+L4k/9uxyb+rrodIVwk8nPZIudH5qyM5O5RGMfWrL10m3B5l88p0vssN3fMC?=
 =?us-ascii?Q?IMxAQtp1h/fQClx0ZXDM5k/A2qPu7n2CqAjjsm5fd5V9B9lfXlLz15+ZQMMG?=
 =?us-ascii?Q?23DGT3m6bUf1iGlIV1cFK/MxFbkuVPHBeXXOVcQiCn7Bsm4xtFZVp16k+DIZ?=
 =?us-ascii?Q?0gBp4+E3zKjaBpjnrsw3vyzBpUwo6rGZGFlMZvEfEeiqRyTiCuiRdNMQfOAz?=
 =?us-ascii?Q?XfENz+046xB6+l9uGZCs0foaPimqmdYNGlcm/XCN5Sqen0To6Noou9J/eVMl?=
 =?us-ascii?Q?OW334/ufZLz2Xvwc5Urhbo5T4o8x7ost3RNAsrkXhBHzTGTXSQJdB/OMezFx?=
 =?us-ascii?Q?zJOftBAwQBX7u7zj9fFpi+FbJaRV0fCsJPCAiYCcfOcj05MwF0nOr+hfCv+q?=
 =?us-ascii?Q?KePvqbPW1EptELBwcjjUH0/uvHSv9f/OO2o7YOsprxyHjQ1bcNqdkB6/y5OI?=
 =?us-ascii?Q?af23KZZmopI7857uWtQacnTnrR/MXbJqNTj2Pep8+RTzXOZWsqI4U4Ke0P/f?=
 =?us-ascii?Q?tJ++s3otxQGxN19Mq8FLMZtzdg+V+2/kND5rRA6fUaLqzrbCNF5JiHXKYsNj?=
 =?us-ascii?Q?Dx0Cj3IAJllJkkMmDWD40sEekc7rgQK0BnBrphEZcVS0WgKWb9ilfY6TGcRl?=
 =?us-ascii?Q?VWPaCBS7LbBuEG7ittU2nWuajc7ZLXhANlK+omPyqwCKXS5fYznAoTQgaN17?=
 =?us-ascii?Q?weEdqarvdTi84MY7CC/HJdL5JLGNwt0p/EoFMaPxeoUb1RcrfuGL6/hO6+lT?=
 =?us-ascii?Q?mSFj1iOuU2qi11/QJ9Lwb+1N9jkbO5AnyU2O/UZ8KLLm1KeA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2afa9f-8d95-49e6-73a8-08da1219d178
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:52:12.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y949ky/vy5LX0LtqC4uDRIREkYyj1ZIla+tHmlLrmp0cpWK+vsiNrt46YROEz/n7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0035
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, March 29, 2022 7:21 AM
> To: jasowang@redhat.com; mst@redhat.com
> Cc: Eli Cohen <elic@nvidia.com>; hdanton@sina.com; virtualization@lists.l=
inux-foundation.org; linux-kernel@vger.kernel.org
> Subject: [PATCH RESEND V2 2/3] vdpa: mlx5: synchronize driver status with=
 CVQ
>=20
> Currently, CVQ doesn't have any synchronization with the driver
> status. Then CVQ emulation code run in the middle of:
>=20
> 1) device reset
> 2) device status changed
> 3) map updating
>=20
> The will lead several unexpected issue like trying to execute CVQ
> command after the driver has been teared down.
>=20
> Fixing this by using reslock to synchronize CVQ emulation code with
> the driver status changing:
>=20
> - protect the whole device reset, status changing and set_map()
>   updating with reslock
> - protect the CVQ handler with the reslock and check
>   VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler
>=20
> This will guarantee that:
>=20
> 1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
> 2) CVQ handler will see a consistent state of the driver instead of
>    the partial one when it is running in the middle of the
>    teardown_driver() or setup_driver().
>=20
> Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting=
")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eli Cohen <elic@nvidia.com>

> ---
> Changes since V1:
> - document the lock requirement
> - protect the whole .set_map()
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b2afd2b6fbca..53b8c1a68f90 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1616,11 +1616,17 @@ static void mlx5_cvq_kick_handler(struct work_str=
uct *work)
>  	mvdev =3D wqent->mvdev;
>  	ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	cvq =3D &mvdev->cvq;
> +
> +	mutex_lock(&ndev->reslock);
> +
> +	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto out;
> +
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return;
> +		goto out;
>=20
>  	if (!cvq->ready)
> -		return;
> +		goto out;
>=20
>  	while (true) {
>  		err =3D vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq=
->head,
> @@ -1658,6 +1664,9 @@ static void mlx5_cvq_kick_handler(struct work_struc=
t *work)
>  		queue_work(mvdev->wq, &wqent->work);
>  		break;
>  	}
> +
> +out:
> +	mutex_unlock(&ndev->reslock);
>  }
>=20
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -2132,7 +2141,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev, struct vhost_iotlb
>  		goto err_mr;
>=20
>  	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		return 0;
> +		goto err_mr;
>=20
>  	restore_channels_info(ndev);
>  	err =3D setup_driver(mvdev);
> @@ -2147,12 +2156,14 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_=
dev *mvdev, struct vhost_iotlb
>  	return err;
>  }
>=20
> +/* reslock must be held for this function */
>  static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  {
>  	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>=20
> -	mutex_lock(&ndev->reslock);
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (ndev->setup) {
>  		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n"=
);
>  		err =3D 0;
> @@ -2182,7 +2193,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
>  		goto err_fwd;
>  	}
>  	ndev->setup =3D true;
> -	mutex_unlock(&ndev->reslock);
>=20
>  	return 0;
>=20
> @@ -2193,23 +2203,23 @@ static int setup_driver(struct mlx5_vdpa_dev *mvd=
ev)
>  err_rqt:
>  	teardown_virtqueues(ndev);
>  out:
> -	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>=20
> +/* reslock must be held for this function */
>  static void teardown_driver(struct mlx5_vdpa_net *ndev)
>  {
> -	mutex_lock(&ndev->reslock);
> +
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (!ndev->setup)
> -		goto out;
> +		return;
>=20
>  	remove_fwd_to_tir(ndev);
>  	destroy_tir(ndev);
>  	destroy_rqt(ndev);
>  	teardown_virtqueues(ndev);
>  	ndev->setup =3D false;
> -out:
> -	mutex_unlock(&ndev->reslock);
>  }
>=20
>  static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> @@ -2230,6 +2240,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>=20
>  	print_status(mvdev, status, true);
>=20
> +	mutex_lock(&ndev->reslock);
> +
>  	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>  		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>  			err =3D setup_driver(mvdev);
> @@ -2239,16 +2251,19 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
ce *vdev, u8 status)
>  			}
>  		} else {
>  			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> -			return;
> +			goto err_clear;
>  		}
>  	}
>=20
>  	ndev->mvdev.status =3D status;
> +	mutex_unlock(&ndev->reslock);
>  	return;
>=20
>  err_setup:
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>  	ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
> +err_clear:
> +	mutex_unlock(&ndev->reslock);
>  }
>=20
>  static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> @@ -2258,6 +2273,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>=20
>  	print_status(mvdev, 0, true);
>  	mlx5_vdpa_info(mvdev, "performing device reset\n");
> +
> +	mutex_lock(&ndev->reslock);
>  	teardown_driver(ndev);
>  	clear_vqs_ready(ndev);
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2270,6 +2287,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>  		if (mlx5_vdpa_create_mr(mvdev, NULL))
>  			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>  	}
> +	mutex_unlock(&ndev->reslock);
>=20
>  	return 0;
>  }
> @@ -2305,19 +2323,24 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_d=
evice *vdev)
>  static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotl=
b *iotlb)
>  {
>  	struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	bool change_map;
>  	int err;
>=20
> +	mutex_lock(&ndev->reslock);
> +
>  	err =3D mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
>  	if (err) {
>  		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
> -		return err;
> +		goto err;
>  	}
>=20
>  	if (change_map)
> -		return mlx5_vdpa_change_map(mvdev, iotlb);
> +		err =3D mlx5_vdpa_change_map(mvdev, iotlb);
>=20
> -	return 0;
> +err:
> +	mutex_unlock(&ndev->reslock);
> +	return err;
>  }
>=20
>  static void mlx5_vdpa_free(struct vdpa_device *vdev)
> --
> 2.18.1

