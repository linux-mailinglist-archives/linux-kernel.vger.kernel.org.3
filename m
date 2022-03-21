Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3314E209F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiCUGc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbiCUGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:32:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558AEBA32C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5C6xNOjEzK2dQBClVvYcNwH0mzizeLFhHf0onHyLdxovTME6KomDBkH7keaMRGdzHvCtv2vneltoNddco87bS5/eoVnvdPoKdv1LT/o2Od8ySN0hynYHrBJD9zR1rmZ9/KX7amYuDOQfdYhLuGQ58Yra8cTtdW303kzikV+zVgythzINAQxA38Xt7FHz2xCxKSiH/M8KJoFN3EkH0IM7dgf1YnH521WcoS8bwCp3keDGYkiOV/1sBKj8dFxSpnS2SS6/+O+I6D8arZuIuEzkjV5P9jb78qB4N1hd5j8I1MN0RjXoJFJY354HmjfmkIp3of4i5w7vcrSI66AuZTHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FLy0zdz/y4v8e5o/vM03MeZ4YsB/38uXJkGaxBPQjE=;
 b=F3omgRwqg+BHsWDK765HbdjsaGxDS/fe2npjDlVd8V3ohIdEVTn8giUBnUzq8NkI9h8GQobYH361Yz3hq7U3L1WJCgbRG6J/F+qBZ02Jwxsap+jnjKDC/n8yLU5iP5rn9c6h/AaEoYVQgitm7Vv6/UhJ4uTwp0LIGSuVtjZtpN0AXj4wywYlgELj4tnXRUPjWZzSlfWZ5zirVZEFbANVyRgX8j5jwdfMYILhpuyDkGwjTekfyyJlrTE4lIuDdmHNwGPBh2gAxz6KqXpsKbBS5HZnipfy1ryNiT+fRNpQrcpGvaFVg6pN/wxe2Rb4QiraCE5dZgu7i3x8SbrBekhfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FLy0zdz/y4v8e5o/vM03MeZ4YsB/38uXJkGaxBPQjE=;
 b=MjD93zBEvo1HFay5sSRu+7WJMoYvcPXcYx32DVIXNJMdPhZxBc7Pcw+NEkf4ONvBFo7eGqj7/FW0id2oEU/Q3HVCiEXZOAPGU7pk9SBuhXdsGPd8cZrxvN3WVzC1AfP9ORUrzBECu5t05o8FUE5Z6q7Zkp29QO/TKDl5RxowZjhu4+o6P95HzIX4HCT1LPAlHwnJsUdHEvmGxaYWmg95K1vhQQkNd/O0uatVHp/g48IjHm+7PF9Q9hQMYLs2wq5ItyeMfwIG/IlailuHlfAycyoW3v1kW0oL+bk/eyRK0AEV4UZQCbtmMDgdBDQ6a+mMuqpU+Dn7cUDwbUIdvlAx8w==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Mon, 21 Mar 2022 06:31:18 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 06:31:18 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Thread-Topic: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Thread-Index: AQHYPOmOAGfLcKLGQkKqa8QJSXdItazJX8ag
Date:   Mon, 21 Mar 2022 06:31:18 +0000
Message-ID: <DM8PR12MB54000AA4A7C05D57006C5920AB169@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220321060429.10457-1-jasowang@redhat.com>
In-Reply-To: <20220321060429.10457-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201c1b30-caa6-4a18-588f-08da0b046889
x-ms-traffictypediagnostic: MN2PR12MB2989:EE_
x-microsoft-antispam-prvs: <MN2PR12MB2989CE003B3273134530AEF5AB169@MN2PR12MB2989.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCuSATEboPGFRkTOn4BOCnLHCWeH2+9JnyoKGiA/hSKrFs4cZ8XHVB154Xu7JIyrS2YyeX4RegkUCZ51hQ7LVChbGP2MZGf70FyYGsjyi+Sz5Nj9WssRwY9lZaCUonOBCpt6pZY4IHD6av6EOqIhpIKbELqy7mT3DwXC3Hre+oePHf6xDbsr1XO1JLV1aS9Ns/PQsGhpXVCSXjFjoXtOHGCaVbXuITGjC1+DV6MNDLFGWV9n6SKQ8r2fGVP2i2kxWktH1NECxoYYJ+6LGXVxRFUMbop8buI6vbgHYgUWKxEfu+1ZKVQW8GFTiS/fbznBnTvi+MHVh6iYJ3UfDDJdlCKFdPY9YC+uwnTRuTmEZbxA4RE1c1fNatyDa/e9cdCHD6bUtgcaDuwv8Fst1Q7wWC9A9g4EUyM7wIsF7vJ3FgRgHBpXqIThJ/M/tRpE5ahUb6u5HsGB9sExC/dqoL2+oNfJ1p9pB03UckBObD2AX7ToF4lJyNxO3qT8OzFzihTxQ6NFVrJWKzb+75BnnGTg20i/gDFI1X6v7xteSaZnpX6i484Mg07EBXo8rmmVuAj+WbJL8rZpzMNFVa9m6eQ75fjQuxAxNjtrzZ75rWOAYKlwcdRbI3e/mPH59eyhQE5OjtTXuZ5KXErhKEvM/FkxjO4zbYDwecr0xldjbpxfRGn5l9N12neVDHCiGB1wtmFr/6kFIvEyRlOeST0i/TxLgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(52536014)(26005)(186003)(54906003)(9686003)(110136005)(33656002)(71200400001)(55016003)(66476007)(66446008)(64756008)(8676002)(53546011)(4326008)(66946007)(76116006)(66556008)(508600001)(7696005)(38070700005)(5660300002)(86362001)(8936002)(83380400001)(316002)(38100700002)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9B06LPBvLs7nBNqtNdg18weFdUlyUo9vNAZ4Thh72YrMnAiaxitcOK3NYeKN?=
 =?us-ascii?Q?OOLHhKVhz6TQg0RzCFkBYZS87gY3lJAs8p0HoCS6CHxlD7Wa5l9Yuf+9G9Bm?=
 =?us-ascii?Q?QpEJHzNk8qpN9ZfXk9yRsoHkxc1rMwM6oqZZ1wNepEFsNpZaDr59pSSiqmyW?=
 =?us-ascii?Q?IqZK3y/3g8IWI0R86emquQ2BTbHWhIi4QW5EHey37relkjM90XSr36swOOkS?=
 =?us-ascii?Q?4b5X4YQs68J2hwwZfIZrIKMqdTUJ5W/NbY+3qFLoPRHDhPFZY1mEVdRpwz2D?=
 =?us-ascii?Q?Zx3sgMx1kjOJDTOQY9ZnUMob1h9lRPYhdtc86DJxE7DKf2rd+KVFX1TyV0pW?=
 =?us-ascii?Q?hdQ3CuEOCitBq04JgesjYg9XFswWikgQSMr7sq0k52cd2D4PMGwOvdWCRVUO?=
 =?us-ascii?Q?Ae/LWqV09idMShmzTcAuoa/tyCKSgUu1VhF9hezLqzieL/Ps8hA2nnDNSM2g?=
 =?us-ascii?Q?TZz2UHatJOv0fOENW2Bozt3dVILbZQN/pl6R6v7gqiRcdLNY9X8P5N1UXEQN?=
 =?us-ascii?Q?uFJtguOFFsDTPBoY4vDXW/fQeWVpRt5yUqMQqD2FcdRdqWlUCLG9DhtgBzyY?=
 =?us-ascii?Q?iYXwHbdlYUWn31E6RxKJI7kfr4acTdJlF2oyhHAQjjSvzDS1EMYD/eWSPZ8q?=
 =?us-ascii?Q?+mfWl6WdpvrcgKM5KfJzQDPFDASwmPHVOvr2ZEY3JrF2+L6cmzGLG+/lDoWg?=
 =?us-ascii?Q?1iOhaEcs4DXY9cbk9hCiLVEtX433LgmumINJb3x06aYkQBK46TKItuARcb3v?=
 =?us-ascii?Q?gD7idCKsANP6cGoPnaqxbOAQ/e0W/eXHgSfsrdD5jf4vTskJejUY04QbuRyc?=
 =?us-ascii?Q?Dz1Qc9EvQ3HlI9u0/SC6TVJRF/ZU5KaiIfmvN9sf2o5XT8We6sCNehIlS1i1?=
 =?us-ascii?Q?F4vNgSMlfoWfl9UYbxuR2Py33mklFTjRWilpm3FiDwbwDVLcXIMwd+ag9p3b?=
 =?us-ascii?Q?vQmQMwms8R1tVfEjjIwzGIGUX6kkNpAunGCcZfpCqonmtpjcRUl15Ktqgk8e?=
 =?us-ascii?Q?9OJbwx6wCn1t0nsry5AIaaEv+lzGtoeP+WGl6KC2u/az2sJiPA4RVS9iMcZ3?=
 =?us-ascii?Q?GpkwT7yG0kPhwC4LdUiySFAmaZjyRI7/ef62o8U2skCuYh5KtdSdze74RBRY?=
 =?us-ascii?Q?a2JtbpXOMgaRcP/Ss0dfknRiIKXmlGgNOkATrnmfmB7SfyXxJezAJvXiq4kA?=
 =?us-ascii?Q?JsZXfVxEPZdlu1ylk4ESHpH5cq2EpQIFBfGCDaORK+2X/nGWluVo5mSwPfdg?=
 =?us-ascii?Q?NDSS6PSQw703+jDDEkmwvOR+S9SP+JzfwYTQpPE6U8fQdHAgLxEnfHhIXcHg?=
 =?us-ascii?Q?VbxksW3GEUH6cpptP70QuoCJyDmk7figNeItoAoT2xqw8qgISGUR1NKXfo1j?=
 =?us-ascii?Q?zqMLy74w2Cs90E1kPCxjfzN1nAieSfTq2yD4u5DrqffjCXiOJosCK76F/zpo?=
 =?us-ascii?Q?uwvAHaBBPZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201c1b30-caa6-4a18-588f-08da0b046889
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 06:31:18.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3h5l+5SbyWaibnyzyxgwb7P7zoueVlClrgzLaJqwInoEMNrG76MJIUI1RK1GPl8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, March 21, 2022 8:04 AM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: Eli Cohen <elic@nvidia.com>; virtualization@lists.linux-foundation.or=
g; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
>=20
> A userspace triggerable infinite loop could happen in
> mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> cvq requests.
>=20
> Fixing this by introducing a quota and re-queue the work if we're out
not requeuing the work ...
> of the budget. While at it, using a per device workqueue to avoid on
using per device work. The workqueue is already per device.
> demand memory allocation for cvq.
>=20
> Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC sett=
ing")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d0f91078600e..d5a6fb3f9c41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
>  	u32 cur_num_vqs;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
> +	struct mlx5_vdpa_wq_ent cvq_ent;
>  };
>=20
>  static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct ml=
x5_vdpa_dev *mvdev, u8 cmd)
>  	return status;
>  }
>=20
> +#define MLX5_CVQ_BUDGET 16
> +
>  static void mlx5_cvq_kick_handler(struct work_struct *work)
>  {
>  	virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
> @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_str=
uct *work)
>  	struct mlx5_control_vq *cvq;
>  	struct mlx5_vdpa_net *ndev;
>  	size_t read, write;
> -	int err;
> +	int err, n =3D 0;
>=20
>  	wqent =3D container_of(work, struct mlx5_vdpa_wq_ent, work);
>  	mvdev =3D wqent->mvdev;
>  	ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	cvq =3D &mvdev->cvq;
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		goto out;
> +		return;
>=20
>  	if (!cvq->ready)
> -		goto out;
> +		return;
>=20
>  	while (true) {
>  		err =3D vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq=
->head,
> @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_stru=
ct *work)
>=20
>  		if (vringh_need_notify_iotlb(&cvq->vring))
>  			vringh_notify(&cvq->vring);
> +
> +		n++;
> +		if (n > MLX5_CVQ_BUDGET) {
> +			queue_work(mvdev->wq, &wqent->work);
> +			break;
> +		}
>  	}
> -out:
> -	kfree(wqent);
>  }
>=20
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *v=
dev, u16 idx)
>  	struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	struct mlx5_vdpa_virtqueue *mvq;
> -	struct mlx5_vdpa_wq_ent *wqent;
>=20
>  	if (!is_index_valid(mvdev, idx))
>  		return;
> @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *=
vdev, u16 idx)
>  		if (!mvdev->cvq.ready)
>  			return;
>=20
> -		wqent =3D kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -		if (!wqent)
> -			return;
> -
> -		wqent->mvdev =3D mvdev;
> -		INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> -		queue_work(mvdev->wq, &wqent->work);
> +		queue_work(mvdev->wq, &ndev->cvq_ent.work);
>  		return;
>  	}
>=20
> @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  	if (err)
>  		goto err_mr;
>=20
> +	ndev->cvq_ent.mvdev =3D mvdev;
> +	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
>  	mvdev->wq =3D create_singlethread_workqueue("mlx5_vdpa_wq");
>  	if (!mvdev->wq) {
>  		err =3D -ENOMEM;
> --
> 2.18.1

