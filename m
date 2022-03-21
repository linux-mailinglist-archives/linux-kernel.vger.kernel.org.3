Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F4E20CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbiCUG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbiCUG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:57:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB810CF13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke8yiR/WjcfM66HEH7ebcnnntaWWET8zGsoD7mTrfGdNylPeT1N6vYbquL3uRRe/zTSmNTBGtoaNazJYsMplGmFG4/h6U2dmcyYtwbqwkaNMi6fZXe1OfHPpPZEyu+oICDPz+UvfaK6/5yCzDFWAPHjMZ6e7olSJIea35/3czhaFASvlhDIWZQkOBrMOiWbJdDP0rrdEBhUy30JqKNLuBg0Cq5KncfT+Ryy0IBIvJiSZ4Ztr768qHSx7kvyaz05mxtqXRKBB1BMXCL0wfOx6P924AymWOAdS92eFlUKrwZNs+x78KxMVbdFfaiKZzwXETL3Jynbfn8LsaTSb6Dm93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpRRNa4OU4t9hFJzEGGkGv2g7njz7cTr2A7hU+j7b8I=;
 b=KUXgPwlEM2Bp5Rmj3ja7qiBntv2i7cBEtOJSFkNst+YUIYoctt0ufhHCTYzsjiTLAr+k8MhNW9yaYiCIFL+q0HDmBzpIlmKcfr1HeYQBtJRl6XvND6fsmxFau7jngseyiZr+qgXv5yP5XWms1UB21UYLH+UTcHMgZgxfnDZq1BKlsBlvbSmlEKlNk7DBUe2/hYZYMFAg1pYUZrO5NuNpk1SBa+1XqCgnUoPjPA1g7UECkHz+X4/0Wafc+TOB6fzrwN4jjpfyxXlI1n/xIALXQVe04eIpD5eRiOeVZDv1YSAV+7qJv23OWb8BAsU+lO1OWkDiQyCcsO8Dw3MuEMqYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpRRNa4OU4t9hFJzEGGkGv2g7njz7cTr2A7hU+j7b8I=;
 b=G2MfpcN/37RJ+hUyHNG0gdz7ZUmKJ/eCMxrOj2Qz2wjZiBvrZ0XNJee6z+jjdDqopdKsuNSB8bX6nHfy8K8AgVnvIIPtAF4KStVAs3wyst3SSekeBCDFAoUYFwb08E9CHJrSgfRZ9UBsRVJdGk2pODFoRo3/YPUvMPyqRWCn3qabN1KDFln0eHk99JKdorlODX26zj5k+Kj6njs1QojVkOiFzH/P5FC3uhWm0z0rjBaGu/YPtxS71Rxk6t7hrQGTu9lO6idMa2Bgqi/BED/8dr2bGK/JlTIODGb5xiQJ3gtRD0xSkEWMqUdGUKBMuzM4szLlSrevh5SSPhu7QPMf/Q==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Mon, 21 Mar 2022 06:56:25 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 06:56:24 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
Thread-Topic: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
Thread-Index: AQHYPOmSgJrktw2RQ0+8QJjCeuRXoazJZ5DA
Date:   Mon, 21 Mar 2022 06:56:24 +0000
Message-ID: <DM8PR12MB5400B6489C7FEF8B950AF1C2AB169@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321060429.10457-2-jasowang@redhat.com>
In-Reply-To: <20220321060429.10457-2-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96a5b456-0c34-42d2-fc38-08da0b07ea4b
x-ms-traffictypediagnostic: DM5PR1201MB0123:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01233695A5547F7AEA8FCAF5AB169@DM5PR1201MB0123.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bF/86LNxYZMhxTYypsAXAYrjibZ6s3hGSBWra2n+k+SS347tvUBWgqLV3qEXU/2kWdbPUSNSzsjaw4DFyHdmshLJQMbgfeV54EIq4IPxSph+Ltiw3JfIFgv8QrXbODFLBLEQ8cBtehmu5fG8OlYj66bPDtiDXJvH4zF1ICOT6kVGK6B3Rk/6kKOxiIxSr5ffAr7v7o2BDZW2RoRDQ0hU4wawO+pDE/3KoMCV3rRnr0COGVexv7Y6pEviQ5pQ/vZr0cHqtnqcEV2gzdCIq9tH2CODSypqDXZHARpf6itzSqsWwdHd0CcuTZPG+LEeQWAG6Emws3cYpNVU/fVXL9OMawEwRv0YWfbz0x8QRMkTMS4LW8RZI1ayiuwty7KHvgas8Qy/oSBL/E+Y1R5dbiRebEZZw/dF8NeFMgU0TrvslBNyrHagynPtQVNSrbEFy9RzvZRW/w4BQr+sOQ48yWFYE10MkrXsIxPtJDhkiBXumJLrxA3vNfLqAmpwoAmqmJsNaGlapyXTIRlCWWZinhz/UFOEJaLueN7hYf5zGj27wUhEtZRKrlHfXSjnVK/XcCficuEsTZ/sp7ntQ36a2nhWbbjs/fPxWLWsTF92E4Hjdr19rgBnOWYJ/4riVlt7Bc61FLCZPvWQNxVALzr4JHUyndqOh76ybcrWp3uUnzgLyc3hYD/x0OQ5WdXe8lpzf/RyInnkKCfrhALim0B90qjFkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(33656002)(26005)(186003)(83380400001)(2906002)(7696005)(6506007)(38100700002)(53546011)(38070700005)(8936002)(52536014)(5660300002)(76116006)(66946007)(122000001)(54906003)(316002)(9686003)(4326008)(508600001)(71200400001)(66556008)(86362001)(64756008)(66446008)(8676002)(66476007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92s59Vv6D43mDp74QHUEl+7+tsc0fr8ep+DkU6d3gMYUTtdLz81dUSy68a+v?=
 =?us-ascii?Q?lrpj/L1FC5hjrF8ldeTmhDMhKks5F50dnJQkBXmHcHBrl6t950z4LxBnjKoU?=
 =?us-ascii?Q?5RhR0znKykEbJbW/wIdmlkhFjVH+Jge5ee11C7AbWlPMnpiSlOx+cgjITGoL?=
 =?us-ascii?Q?EO01cEZd3xDw0W+R6z4C18eHHGHX2SAPLslBanYoLnMusQ9YZyTAdv1JIjFX?=
 =?us-ascii?Q?gp9hl/MP2miwICUTNnJhRLUGeW021QUBXypwr3wlFQ/4l1S9n4BzzSKdaRE6?=
 =?us-ascii?Q?R4+a7vs8f/wCHBkm806gkzKz6zLvxCU2Ga2/KFADZ6zriytFQQblEF0maK2l?=
 =?us-ascii?Q?eYR22BiBaCIg+44Xb9A6phQkr9vLDjRsBNx6DxzsQmcJRlGX5Xh4a0+v/F6f?=
 =?us-ascii?Q?Oe1FJE9g21RFDUzpZ26kQUIIVN/s1Eo7SN4aXFIjO75PGdBjW9jsWZmFTIIQ?=
 =?us-ascii?Q?uuHHvvWrFyYeuusx7eFCGJi44lVjpRb3BECf3NOQlPmRT60SRj7RxVYg9B5V?=
 =?us-ascii?Q?f9u4JV2G+rlv/ZKjhL12LmX6xwCUxepIdKAm4qJyAz1LevyoxVZhqQbhE9O0?=
 =?us-ascii?Q?92NRcZoqCLnXrwvMP5KqQy7JSRNscgkgoZFl3Gg0e0Vf6lrPD95hJ2QFYwUe?=
 =?us-ascii?Q?+8cmYFVtDHRbeClX8SRaFTyud4gCVE+fvBXnA2cEBQAuDNY9WyUhMlv7CGPC?=
 =?us-ascii?Q?CT/+Zs9S6cnReE7nULH8C5VaKJmPHCHL49i/EQ4DrJ0ajoUYA7llbcXBGHDu?=
 =?us-ascii?Q?ED+U+kmIna5JGF+4MFSE93h1Vxss/Hw2K5SdqoAECMmChpBd/6MU9TXHD9BR?=
 =?us-ascii?Q?5FU83wgrwdwis8UugS100oeTyNYpWjAuLM1UTP9hl88qmu6J5JLFwXhpXyFN?=
 =?us-ascii?Q?Mu5y3R9RLEq60B152g8UhkyRjSVmo5zoOue+1epLuTn4mVRYLjPINQRusYVo?=
 =?us-ascii?Q?gA+6KvEn0hzUJXgHn7ys7q76LZOP0fnm4iTQddVN3m81Egjd/tdDC5dO3Qvu?=
 =?us-ascii?Q?j7+LomufPtA7pb9awwfZ+7buj4mG79h0e9b6kRyzqtV9Zvt1i/bCGnTRbJzu?=
 =?us-ascii?Q?2SxgOHmZsuA5VtFSMvBQRwHeJ6xvmx/96qEvIgUL5BQHwcrtvt066LIG+Pph?=
 =?us-ascii?Q?dokJzf0bGfrrPDl7qEaYcpE50tr39zKs0a/0qT3THP0qm0Ydw1zr0Idtvd19?=
 =?us-ascii?Q?Vgj1Gwr507xcQzOWfuRLc9cixOFu9BKpHC+5kRAOQBB5f+Xp3U+jtmACM4ux?=
 =?us-ascii?Q?D6KEJBCboRDl8/QFeNp4xlKKaW+EoLV9x8gqXrUvcM+6PVwxMk8dmdCpvA+l?=
 =?us-ascii?Q?zF9gttKDM7OCINNd69Uqbbh1akRp941Hz71rlxBqaY81wV2yIIF/w4zLGoGy?=
 =?us-ascii?Q?imBNB+drgrfTifkvJmPQs14OHvRi8IGn4398agf3qnXxaEZZkMcwIESlP4gQ?=
 =?us-ascii?Q?VEVz0wvUn4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a5b456-0c34-42d2-fc38-08da0b07ea4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 06:56:24.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxvhwerbeN59e/VJgB/JrZ6UzwswpQtBTrHGQZflRfFu5do1GUGuGVxwdJxjcJQd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, March 21, 2022 8:04 AM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: Eli Cohen <elic@nvidia.com>; virtualization@lists.linux-foundation.or=
g; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
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
> - protect the whole device reset, status changing and map updating
>   with reslock
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
> ---

Reviewed-by: Eli Cohen <elic@nvidia.com>

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d5a6fb3f9c41..524240f55c1c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_str=
uct *work)
>  	mvdev =3D wqent->mvdev;
>  	ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	cvq =3D &mvdev->cvq;
> +
> +	mutex_lock(&ndev->reslock);
> +
> +	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto done;
> +
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return;
> +		goto done;
>=20
>  	if (!cvq->ready)
> -		return;
> +		goto done;
>=20
>  	while (true) {
>  		err =3D vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq=
->head,
> @@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struc=
t *work)
>  			break;
>  		}
>  	}
> +
> +done:
> +	mutex_unlock(&ndev->reslock);
>  }
>=20
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev, struct vhost_iotlb
>  	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>=20
> +	mutex_lock(&ndev->reslock);
> +
>  	suspend_vqs(ndev);
>  	err =3D save_channels_info(ndev);
>  	if (err)
> @@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_=
dev *mvdev, struct vhost_iotlb
>  		goto err_mr;
>=20
>  	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		return 0;
> +		goto err_mr;
>=20
>  	restore_channels_info(ndev);
>  	err =3D setup_driver(mvdev);
>  	if (err)
>  		goto err_setup;
>=20
> +	mutex_unlock(&ndev->reslock);
>  	return 0;
>=20
>  err_setup:
>  	mlx5_vdpa_destroy_mr(mvdev);
>  err_mr:
> +	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>=20
> @@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
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
> @@ -2187,7 +2201,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
>  		goto err_fwd;
>  	}
>  	ndev->setup =3D true;
> -	mutex_unlock(&ndev->reslock);
>=20
>  	return 0;
>=20
> @@ -2198,23 +2211,22 @@ static int setup_driver(struct mlx5_vdpa_dev *mvd=
ev)
>  err_rqt:
>  	teardown_virtqueues(ndev);
>  out:
> -	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>=20
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
> @@ -2235,6 +2247,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>=20
>  	print_status(mvdev, status, true);
>=20
> +	mutex_lock(&ndev->reslock);
> +
>  	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>  		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>  			err =3D setup_driver(mvdev);
> @@ -2244,16 +2258,19 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
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
> @@ -2263,6 +2280,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>=20
>  	print_status(mvdev, 0, true);
>  	mlx5_vdpa_info(mvdev, "performing device reset\n");
> +
> +	mutex_lock(&ndev->reslock);
>  	teardown_driver(ndev);
>  	clear_vqs_ready(ndev);
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2275,6 +2294,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>  		if (mlx5_vdpa_create_mr(mvdev, NULL))
>  			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>  	}
> +	mutex_unlock(&ndev->reslock);
>=20
>  	return 0;
>  }
> --
> 2.18.1

