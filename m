Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B64EBB10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiC3Gts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiC3Gtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:49:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD289330
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0CPPyG76nYpj2mOAB6c/rD5JW3VVl2j7DR3psXMF+d85Ko3K2YCdB8pv/I+pS8zmBPRLgAkvDbXE9MpgiuIhtW42HtOCtyAAVeQRJcQxF/6wtxVEVw/kJgWStQndpKkl5Nk4FT6m1rnlRGYTYG1p/J+39qwA33LVOwKBw0zsC7VS7f9AZoWJXsSmkH0YVquWuInj1PEAYxLMWHiVlB2hq3zlMRnAQ+2vyI19Fyo1uSrTiDK1HuMmhw/QuwE5ahX8fHWi21VFrGcfv9D9QWyjCw/0HENPdBlE77Y7XqzPzjiedP0i0vNbxy7pgOTjsj3ujllZBEZIT7JpwhcEyrT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpgdmWrszw9zXD3q7Aymte/cwLFpSAlU0rv58CRzb1Y=;
 b=g0/OhzJ9ic/OGQbP99id+7q9ZZFFO2ArpM7SKH5PceXdamYNvKs7AizefcSdTfNKny0HdzKjknHriW44gS8zAXqRhH6GFFG20dUUAO8eB0+aZKM8N/3kmGgkhE5sgypnmyel4+PPztxLxf7SybA8oWgusXYV8td9k/bIU8HwXspDTn1x9X60npMfsLWjNA/URNRqGpEPall/6H+kscRldOmeoRgVqnTAPB1Gdshjr27qBRr0Of2ESnjrq/PtVwpoVHEmxS9NIZQnFhCOcmv2NjrFm5Mm8tt76Kj81WwDbxJSDAwrxC+O7QfIP/ll6x97PDNi332k1qqtmodwJTwmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpgdmWrszw9zXD3q7Aymte/cwLFpSAlU0rv58CRzb1Y=;
 b=YfKLj+9XKOl2OU9L7qCgK5nlln7TM4SL5GfAWw/trSw/GETswGUQfwKaGR/sW8U/851yYCWM/TCdDke6b7hMUCtlZ+f+QN+rUnTH7gI+61F1lNc2G9A2tptzjUJfIIrePZ8172jgrl2YbzrA4K1HUPjWWEMxvVJCR2tGT3TIvnZhiMlAVND8CRtPWHvPAg/iBZ4x9SH9KZHVW+jsWiEyyZFOdf90a0YVLyOoLdZY6MK/mBvbd+R1+j6cpdffJaZVJPYp0Ic19b1fOeqS8Ez+nQpjtNgvgzraD8ZSEU6QowT/V73eDxMR74zm80jwUO82e7QXOiZ+zXlzL5dosgWeYg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN2PR12MB4029.namprd12.prod.outlook.com (2603:10b6:208:167::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 06:47:49 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42%7]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 06:47:49 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND V2 1/3] vdpa: mlx5: prevent cvq work from hogging
 CPU
Thread-Topic: [PATCH RESEND V2 1/3] vdpa: mlx5: prevent cvq work from hogging
 CPU
Thread-Index: AQHYQyR05cemLHoMCUa7Cyn+wIZsgqzXfaJQ
Date:   Wed, 30 Mar 2022 06:47:48 +0000
Message-ID: <DM8PR12MB5400B1559C1A4254B6531328AB1F9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220329042109.4029-1-jasowang@redhat.com>
In-Reply-To: <20220329042109.4029-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dc6e3fc-a2eb-4201-d2bc-08da12193476
x-ms-traffictypediagnostic: MN2PR12MB4029:EE_
x-microsoft-antispam-prvs: <MN2PR12MB402935307D1179447EA82FF0AB1F9@MN2PR12MB4029.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPiKjK6+r0UMT8wpY/Cgg+MNnLHrwPoosk3lr5rc1iGc5imYhlEkfhi2OkZkA2584R5+rm0ebifYlSJJnryVGIDlq3+3rD+Ykjj4NVU9ancLf6U4mv6lIZl2enxbR8ebScb2SBEolx+rhX0nwSNQc6wkt/31V0ox3RtTVEGgYYZCgYRFsOE46ZQhKtUtuxTsL2drsY33KDxjgl/CT0dm4CnVAVnr25eGrqoa4Pubao/GYhxbJBNK04LmkKIalDUY6RedN2DC9pA4HcVmUxewzwqPeDp4snEGUN5siUWy4pwrugka+724eBTxNchfXcuZY+5sVIwyM3S6Q6JmouyzNakxZakIiz37y4HzC3Me9TjbhQvilS4WxwLY1CO2fmrO+3P5uF0wwjs82MfzsgVJU74594PKjHkfuhVU6GdBr5lVFI+F1OOTPVOAMx5Iw5rfEBWPsSMcHoJWvLSSUhid4JWmCMjCrZVotFVfCdaqXhqI/dPzxHuAP5oj1sEAV1nwTTit5tga/BWvC5Uwc6Lwq52FExdpGV+khtu3rF5GZeHo6Zhj68Jb2/8ZxCvHPoXsTj6fR1LwN7qL7mdkjfHDxLaGQ4nCK4dkcRpaKKoEEb1a3QsZ2EKtE97z6pa9P7Srx2+OcLMBLM8fFjrc/4L7RHgR5rVUaiw8yftC1IASG3BEb2asK4w/Mcf2aqCeI/fmHXLLg2ytvW9PoEIvK5vwgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(186003)(5660300002)(26005)(83380400001)(8936002)(52536014)(33656002)(55016003)(86362001)(2906002)(8676002)(66446008)(53546011)(66946007)(71200400001)(9686003)(7696005)(316002)(54906003)(66556008)(38070700005)(66476007)(6506007)(64756008)(76116006)(110136005)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P67PxML80qOOzfQnh3YvRFJV/cL6BknXs+W6vjPNj97da9nMmBxSY7sUj3OR?=
 =?us-ascii?Q?5ZDwlY5n9AwX3ZW7383bzj6RSzaTu0oSpGlujsGeo8PtZrk6pzN9runfBkCv?=
 =?us-ascii?Q?MLCZszIKZIJpZeWwOD9ubYfwTW9vGoCOKxNa5hPDMSK1b3nR3hRLbBF8qcfr?=
 =?us-ascii?Q?nTnjtBWbM6Dq5U/35Ea345MwDUwcFMlGKTyx9V9CweZ1SH/eeYXrRzDPcmvE?=
 =?us-ascii?Q?1HnjzshPjNEJZwGb8jCTzV8NVWCdK9xoVtcsINywLeGKyLVGtWKMEINt3oiH?=
 =?us-ascii?Q?8w6HZH3eJ6lbCmMU4w6oZModJjcRFI8tZBUKz9UDEBzp7XU6Gu+JiBa/WS79?=
 =?us-ascii?Q?gs0d79qfHgL+dO1LXyayB/jWiwU4bU6rgvwgmDDslmo804wpt2XjtjB5n1cZ?=
 =?us-ascii?Q?nqayb8/TNHo4+MP2fzrGOEOSVrxv5vZI4Fz019MOzM34ymzRqQFXqz8nwRhE?=
 =?us-ascii?Q?hW2Lcl61yxdtzSoEuhVsUSpB6zADZ5PIdDQ73eZhLsIRaMqo8SOphISvWFKN?=
 =?us-ascii?Q?SaEvUX6mfi9V2uJEveLjDIzXQFBmefkiQuUWJE9/sJt949GUu6ONiqtjPCVU?=
 =?us-ascii?Q?vtzF2RKX5dUYfVK6ZQlLaRj9cybAkanvw12xidSIVIf43uXoA6k8EudLRmYh?=
 =?us-ascii?Q?MKzBHIxtFrBOe8N83XEuJbYGtRps6caPbRmCVbwlge3qav0r245idQJEbZcZ?=
 =?us-ascii?Q?Oky+vz9n1oifjONIoodn9m9NTplNis4xvK9t4UCfFjaFbVBl8znKBlqR2+Hy?=
 =?us-ascii?Q?r6PxvVTVEgFp2dFVxaypX+vDmhyMkMU/pSwQZC+MyHTEwNTh5BP7mhJFBsG4?=
 =?us-ascii?Q?u1Fx/xf1IuC+f+rXKtJwHajHFyM8K34zRiK6mmLBRfiCP0vuoxZLUXqmyYnQ?=
 =?us-ascii?Q?1jSPv2jZRD52nSF8apDW6z0fdv5qTlQeYdPabMeKMzbh1+3GNANazXcFroqo?=
 =?us-ascii?Q?IEF5UINqkItVqyIodW0uAGxsmwULXnejpkqKGs8XGrckV6W7Lw7VX+lmGlFT?=
 =?us-ascii?Q?YVZpZ+oCsBRPZxJDN0rFKuqlGzNUUK+YgjnXzl8Dstu8TtxnpMasM6LenH0P?=
 =?us-ascii?Q?PfpcHAgb3Oc1nFu2kR1c6/3GmSpCtzPWozAiQ+tWlB5SwtDLm5LbX3pQRow1?=
 =?us-ascii?Q?IJfqQcTYqlqJIWrbRlIX0ukoHmAWCV+MV4ncY0KPHnE0UiOLK0h6HsPGk88/?=
 =?us-ascii?Q?1FxqJiHUlSQ5RTJKH+pULm39X/bBvUdyPJHg6L+kqlkORnMDsR4a31JOFahb?=
 =?us-ascii?Q?yS7zau0SmIH5LZWUZ2hqLbkRqioCEx8Ulo3hh+msT3KoHY3IO105o1ugdZR6?=
 =?us-ascii?Q?S1WERn/k5jsx0rOi+KM/wJnzoV8//VHDmi4AeDzEeJga4swnYGam+Az056hW?=
 =?us-ascii?Q?zuBrb+Sn7eIH68oTpvwI67PwR8cWEn9jCK/gUXZ0FemhmcFl2vKkTXp8ZGon?=
 =?us-ascii?Q?9SflGz+bwgApbl0M1Yvi5KtInb0lvk7npNW4nGqnYyOtPa6UOux1PZehnlgg?=
 =?us-ascii?Q?HJI73tt8M4b1kxP+uSnsh+lId0+FFkhcw8n6Me4s7qIrD9n9SAoE5i6W6Ev4?=
 =?us-ascii?Q?eIQX642jly7JimhVXF0SZXKAYtRQ4zor/6VV7ZYI07nSXtDENYgTnmVZJpmL?=
 =?us-ascii?Q?T7axsRcA7NHi7HK6ftBW1cYSwMoMyJCaxF1P8SZhIPk0OpYQYSOyIYvTAHhn?=
 =?us-ascii?Q?sVANP3sFwH6EOofzZGqLId4SUKycysuPyp1rXYYFX3iDKLWQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc6e3fc-a2eb-4201-d2bc-08da12193476
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:47:48.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSAoou7XyTN8wwkWHaRYOgJV1/J8yXA/vDISY8++V5XdbxFUKcCriUqKcGmfB6b7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
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
> Subject: [PATCH RESEND V2 1/3] vdpa: mlx5: prevent cvq work from hogging =
CPU
>=20
> A userspace triggerable infinite loop could happen in
> mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> cvq requests.
>=20
> Fixing this by introducing a quota and re-queue the work if we're out
> of the budget (currently the implicit budget is one) . While at it,
> using a per device work struct to avoid on demand memory allocation
> for cvq.
>=20
> Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC sett=
ing")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eli Cohen <elic@nvidia.com>

> ---
> Changes since V1:
> - Using 1 as the budget
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d0f91078600e..b2afd2b6fbca 100644
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
> @@ -1616,10 +1617,10 @@ static void mlx5_cvq_kick_handler(struct work_str=
uct *work)
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
> @@ -1653,9 +1654,10 @@ static void mlx5_cvq_kick_handler(struct work_stru=
ct *work)
>=20
>  		if (vringh_need_notify_iotlb(&cvq->vring))
>  			vringh_notify(&cvq->vring);
> +
> +		queue_work(mvdev->wq, &wqent->work);
> +		break;
>  	}
> -out:
> -	kfree(wqent);
>  }
>=20
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -1663,7 +1665,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *v=
dev, u16 idx)
>  	struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>  	struct mlx5_vdpa_virtqueue *mvq;
> -	struct mlx5_vdpa_wq_ent *wqent;
>=20
>  	if (!is_index_valid(mvdev, idx))
>  		return;
> @@ -1672,13 +1673,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *=
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
> @@ -2668,6 +2663,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
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

