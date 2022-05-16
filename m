Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF4527F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiEPIR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiEPIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:17:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525B36E23
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQRUEbDalQPbERmd31GAwXTRxxNFSsJYspYdjgsmCrjQrOjXiUDdMBM8zCza90wDonDi+kEK2pwxQWD9XGujjicvgPDHFlWnCN38JsvgVd8t5pY4svwBbNKhtliv42cr/wjl6ZkMEwlhtv+SzlWEO5k3AQvsKg0Ik/slUMriyYTgcQwlPoYoFbMAsNFxXxhUz1DkPnGbD23HPvG3jstwGwEJld4LeDVUe0Qfs5kPfMRj+JJmZcLb3MQTFDCS3coP37I+2bdseDzqWEbBaOQmflNvtxgFMPZIdvAdEEzPfDOnioEhVAR8jgdD4J3zhjhJ4IfCmG/cu8OVcdNFCzXDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWbs4Jf0BUyE8uzrWGuld7kvozsD22V+yjIJx0dqf9w=;
 b=Mw5Wg/mktR2VSc/wEWMaoD4ZQm6JPF5UbDar97Qb2fwlQp9X5n8WRcicMk/F2KeDW9930D5vgykKo67npehK2DvS/D1O8vUcDhcAKdQDKhkJ4MP9X8THaaBHPCotgNhME4HDMdVBD4R2MycXB3sMzKBJb36x4S11gxsRFoh844cwjBRoYbxtEMzGwVKuUgZoEyrZCWh9xk+hW0w2EDsRDkeGfHXJ6ULMLh14uvlolNHo6kRnEFv89irbL0cnIfKL7A8yMajOj6YN/6Ik4nKIJDGFWIkq03e10O8iTmU6R1XnWuGrQh4mRR8PCoNDit1mMt5VgUo1SPxM7paoQylNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWbs4Jf0BUyE8uzrWGuld7kvozsD22V+yjIJx0dqf9w=;
 b=ANe7sTV8+cayUj2t7TT1AeIRXDfRBxPlmbVD8+AkZ7YNGpYv4YWk2lmeSzeKSzW9rZFB1/rhJRigRViLhhyZi+CmVsxwCloZa13Ao/nUqecz3HjVX+CoeVPFq5DQAesKmfK6jZGpoOcMMmpdfEPhgNmgr1DWxVAEwuUF3hcNKH5kiEzCdkMxP7+stDXop3MStzATnqhP0xXqnqCKNHQ3dXHVznA2dtT6FMSGZ5go2NSzVdmj5kjJi/VkzfwRjDJm8OnT/QyI2YM8CsOnuDH2UdUoQqOL0YkpgXddNSKVZoXxTRVLQSEG2xRwhZ6JiTOnreLUGqYau6o0cffqWQ+WbQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM6PR12MB3979.namprd12.prod.outlook.com (2603:10b6:5:1cd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 08:17:18 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:17:18 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Cindy Lu <lulu@redhat.com>
CC:     "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Topic: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Index: AQHYSZPR4kA5EJOyOU2XnIy2K7YWIa0hZobg
Date:   Mon, 16 May 2022 08:17:18 +0000
Message-ID: <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220406085325.87644-1-elic@nvidia.com>
In-Reply-To: <20220406085325.87644-1-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4956bd36-f0c0-469c-4c60-08da37147e45
x-ms-traffictypediagnostic: DM6PR12MB3979:EE_
x-microsoft-antispam-prvs: <DM6PR12MB39792ABB8B3F07EAE85C1136ABCF9@DM6PR12MB3979.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qit9Y3sgIBnMANg1CnFr7g8NV9UzIAebZjy810nC3K338IXm7vaeEDiwUCTNDM+jhFrfGtfVX9nUb3vhNJom1Z6eSXkMexaL5y43lNR35kIZ6/fBk+A4+sm8JoneDxPy4RzW/EPzli8W3FRt5WUtEQGl0rm3N7vWU92yWfGk2eBSXzQGutrEuzzHuMic7PwOd3bJZtEp7e7Oue9GA1kTwErPZkjMpXJOaYFHR+Tef3jhyftPYRMK35Kc8iZRqe20I+iCe9tXycEJsr/s89idoyzIburS12G1LdMg0iqJ2/omfoYlJa+IRbkYQf1BUuemG354u5NTwCAVLzofxX+ZHHH8JaXnKgX+JULr0xZcH8QCCMdWF2vGcKKiHwzMiSldFjpXE6bnwOFG0utytiiLukPqS1bEZGrb4+fUZilQgnQqFId9X4eXySQe/8JTtP9t1PWpaOQNy9AIpire09s/qbBACAj8cZKVXC6X3L1wqBjKGNnVhvNYSdsfU7MJ9c3s/yJzn7bklAwW4dhO+kri5MHZERrYFMkNYU6hHoRXThqEWBQj1e8BdijHPSQAF/5jGUXGGJaY1NYLEEUIS2PAgScVUNzv3P7vsG+6uKkw8Gv6porWVRhCo4iv7eQ8WSDmbiAcUGqc+zhiSzO1zoJAFuXc2+K11fELU8S1VAcMha1X0G22B2Q1JramE3Nz5Kxv8pvFCOSNA+8BkKVwpz4EAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(186003)(38070700005)(26005)(33656002)(9686003)(316002)(66476007)(8676002)(71200400001)(52536014)(5660300002)(8936002)(508600001)(2906002)(122000001)(66946007)(6506007)(53546011)(66556008)(55016003)(4326008)(86362001)(76116006)(54906003)(64756008)(66446008)(83380400001)(38100700002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiveBw3h3j3ERGx808GPIHNzJMYIrDWWqcsgVtrr6L26hNTqpThFfYDflpuD?=
 =?us-ascii?Q?OXnyOpBjV/YCRxWq9TCkie2+GXARDu/gRCVetk4HCBckxE5BgznNl4DTS3pY?=
 =?us-ascii?Q?6OwDGTlgjbc5GWPz/vrqXIC2HmiTSpzzE0SCObffuSWjxPR2FTxZAVYZQb9W?=
 =?us-ascii?Q?alBT6H3TzYYXMTTMWAPjjR2WPJUGN+gGyK+dXQwPYYZ/FnMocf3cAeLleDve?=
 =?us-ascii?Q?CFwnGBq4gJR5sFGYmZ/c860e83D3dm1ZdCjcukyMosuTU/p4IO6pECG/hCHD?=
 =?us-ascii?Q?eB7+9WXoEYP6t08APxrcujpAlgxJc3z8yXp51bCpiyJ+V765Kg0p6ce+Knoh?=
 =?us-ascii?Q?zyONhi4Yt2rcj9iXdVW5+b6LeXoylIqHLWi9wXySPz971JbO9nAFWE83pOX2?=
 =?us-ascii?Q?ktyNr2TYyOOwiHBQrKeZoHRo8cJ6J7pva5NenqfTb55Ulw+0kzjSgZykTsnw?=
 =?us-ascii?Q?wxNBHTG0uDB3tb2S/yZr439Gn4QpLcFCi480zrGUwm8cCchg6fqyUz1Ak5Ig?=
 =?us-ascii?Q?Zde3zeCAUkDL0C8y1owYTO0hCakhACIi1K6pEk4tZOFx9JIo88BT4/0p4lH4?=
 =?us-ascii?Q?sV2fo1pikyAFjZw7AROaJrQ1TFXgCzMOypg0tHz05b+Xfme/6H3WpAfmV81M?=
 =?us-ascii?Q?RfdW/YTPCkse717YEWmeTyNPgVC94Rs5hPX83mqgDX20qX3p+70IyUdJU6jn?=
 =?us-ascii?Q?jRo++zeoHWPt8ftiBUaAOibEuHZxKKTq+5ffJZPB2wa/BZV0DvtIfVVCJ1TI?=
 =?us-ascii?Q?5NiHIsVs8WyH1LjnN1SFe153Us3glUDyAnFansvbFAWjYTQnzEZiJxLK55pM?=
 =?us-ascii?Q?WQ30YJEbbKgBgfefZgVkTiaP5sC6mLK39AeR00fUD/yTrUZfNr7/4s/byM+V?=
 =?us-ascii?Q?SOBBbYeBeOL9JOz+KUguIwag/J6Y9udP9O8Xnb0VOGGfi7Zqnt1RuJSs2RjO?=
 =?us-ascii?Q?FPrh5lbQZFPPVf3yxzF1SoIWQeRMst6xvOlCG0p+xHlcB58COCIhjl4sHLMT?=
 =?us-ascii?Q?7Re9CO/t9t55WE2pdU2jQbOiVmaD0OwAGWnmENXnHIV11IkJ+4iFIHCzgR7t?=
 =?us-ascii?Q?Q7D2Q1jYt9Bm11EhGyjUC0ok2AH7qPJKNJ+YC0G3BvABTq98PfKQFd3vhvgR?=
 =?us-ascii?Q?o0ikTa6SmgVhXy5atV21CUKz6F/yB2wZZs0x8qbnu0gY0HeGKRkwBWOKEnyp?=
 =?us-ascii?Q?ZmIHo2ZMCwhVlPSk7jfmlSC7YkBphgMSdant93Bshk/DvDL6MS3ProXbo/nA?=
 =?us-ascii?Q?8gFwu2MjPISvX7XskZI4AP4R84eVT3CacrJTE8gPxGf7hGcClO8p80/C1rfg?=
 =?us-ascii?Q?89Mv5CU44kFPftr7l+mwnyvd66BN9EBer+Z5d8kzyn3m2FwB+21c+Ue5bEbN?=
 =?us-ascii?Q?/+Jo/WmdZKLR5WHgtXnVfRXuWUL5enWoWziRnEAQpekK4oqZ3haqCTS+ymIH?=
 =?us-ascii?Q?kHva/l+DFq17DmQfK5xm9bpmoXQFR4XvtdnhSuGymVaCnNEqWHBeOdu2vfvf?=
 =?us-ascii?Q?Aq0gOQ+S5Ufa23yVKLwsYZlek50m9mI2qmvyk1W/ecmrHyha22R9BY/YjRj1?=
 =?us-ascii?Q?D+atam0kUeH5fC1Itv5KfH89GFaHyhS30226CANDStGFbsnfAN+h3gnMR/Wy?=
 =?us-ascii?Q?Er8xj9R7Qv/6D3r6S9ca4llX31F1hRhFmS+C48moaUw1pm0qdWd9kQLyNQyl?=
 =?us-ascii?Q?j7XKx518n+9XDcuADW21t6dOq0SGq6z+x72HMRgSdofEkEf6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4956bd36-f0c0-469c-4c60-08da37147e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 08:17:18.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkjvp8sa5EhBRY6sF7oXJtfftySy3eG8EQJnvPcd2cpnon84jrKlszY3TxjRspal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

When are you going to pull this fix?
It fixes a real problem and was reviewed and acked.

> -----Original Message-----
> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, April 6, 2022 11:53 AM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: hdanton@sina.com; virtualization@lists.linux-foundation.org; linux-ke=
rnel@vger.kernel.org; Eli Cohen <elic@nvidia.com>
> Subject: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
>=20
> The current code evaluates RQT size based on the configured number of
> virtqueues. This can raise an issue in the following scenario:
>=20
> Assume MQ was negotiated.
> 1. mlx5_vdpa_set_map() gets called.
> 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
>    than the configured max VQs.
> 3. A second set_map gets called, but now a smaller number of VQs is used
>    to evaluate the size of the RQT.
> 4. handle_ctrl_mq() is called with a value larger than what the RQT can
>    hold. This will emit errors and the driver state is compromised.
>=20
> To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> required number of entries in the RQT. This value is evaluated in
> mlx5_vdpa_set_driver_features() where we have the negotiated features
> all set up.
>=20
> In addition to that, we take into consideration the max capability of RQT
> entries early when the device is added so we don't need to take consider
> it when creating the RQT.
>=20
> Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> max_vas / 2 and make the code clearer.
>=20
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V2 -> V3:
> Fix typo in change log
> Add acked-by Jason
>=20
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 79001301b383..e0de44000d92 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
>  	struct mlx5_flow_handle *rx_rule_mcast;
>  	bool setup;
>  	u32 cur_num_vqs;
> +	u32 rqt_size;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
>  	struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdp=
a_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>=20
> -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> -{
> -	return max_vqs / 2;
> -}
> -
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>  		return 2;
>=20
> -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> +	return mvdev->max_vqs;
>  }
>=20
>  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtqueue *
>  static int create_rqt(struct mlx5_vdpa_net *ndev)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
> -	int num;
> -
> -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> -		num =3D 1;
> -	else
> -		num =3D ndev->cur_num_vqs / 2;
>=20
> -	max_rqt =3D min_t(int, roundup_pow_of_two(num),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(=
rq_num);
> +	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ=
_BYTES(rq_num);
>  	in =3D kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  	rqtc =3D MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>=20
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
>  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> -		list[i] =3D cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
> +		list[i] =3D cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>=20
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err =3D mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
>=20
> -	max_rqt =3D min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(=
rq_num);
> +	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ=
_BYTES(rq_num);
>  	in =3D kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev,=
 int num)
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>=20
>  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
>  		list[i] =3D cpu_to_be32(ndev->vqs[j % num].virtq_id);
>=20
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err =3D mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct ml=
x5_vdpa_dev *mvdev, u8 cmd)
>=20
>  		newqps =3D mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
>  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> +		    newqps > ndev->rqt_size)
>  			break;
>=20
>  		if (ndev->cur_num_vqs =3D=3D 2 * newqps) {
> @@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *m=
vdev)
>  	int err;
>  	int i;
>=20
> -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> +	for (i =3D 0; i < mvdev->max_vqs; i++) {
>  		err =3D setup_vq(ndev, &ndev->vqs[i]);
>  		if (err)
>  			goto err_vq;
> @@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struct vd=
pa_device *vdev, u64 features)
>=20
>  	ndev->mvdev.actual_features =3D features & ndev->mvdev.mlx_features;
>  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> -		ndev->cur_num_vqs =3D 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_vi=
rtqueue_pairs);
> +		ndev->rqt_size =3D mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue=
_pairs);
>  	else
> -		ndev->cur_num_vqs =3D 2;
> +		ndev->rqt_size =3D 1;
> +
> +	ndev->cur_num_vqs =3D 2 * ndev->rqt_size;
>=20
>  	update_cvq_info(mvdev);
>  	return err;
> @@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>  	struct mlx5_vdpa_virtqueue *mvq;
>  	int i;
>=20
> -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> +	for (i =3D 0; i < ndev->mvdev.max_vqs; ++i) {
>  		mvq =3D &ndev->vqs[i];
>  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
>  		mvq->index =3D i;
> @@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  		return -EOPNOTSUPP;
>  	}
>=20
> -	max_vqs =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> +	max_vqs =3D min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio=
_queues),
> +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
>  	if (max_vqs < 2) {
>  		dev_warn(mdev->device,
>  			 "%d virtqueues are supported. At least 2 are required\n",
> @@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  		ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
>  	}
>=20
> -	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_=
qps(max_vqs));
> +	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
>  	mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
>  	err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
>  	if (err)
> @@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  	ndev->nb.notifier_call =3D event_handler;
>  	mlx5_notifier_register(mdev, &ndev->nb);
>  	mvdev->vdev.mdev =3D &mgtdev->mgtdev;
> -	err =3D _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_v=
qs) + 1);
> +	err =3D _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>  	if (err)
>  		goto err_reg;
>=20
> --
> 2.35.1

