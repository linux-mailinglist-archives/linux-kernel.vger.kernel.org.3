Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E44F1397
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359172AbiDDLJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiDDLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:09:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FF3D1D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0+1pj6u5sSDT/JVKHJjUODz0m0OQ1hldYTX+3wUeEgyio3CGhpVRfM7W6Nja3yiadkENmPVyif/SHKP0ve8CDlxvFdkcEO6oKKGuVXie/VMLVuTNWlOcVXg/PXmo+6+XzoUnPQ5fyCym3X0LUwrcct9udwOY1ABjM86fhrOkYVtd2d2AqBC6+kpG7u9RlrIe125lRgg148ZkcUqkWW7SF5ewpwo8BPuQR8Ju09VHluspCb2pPZ+n0RYI4GxCCYdr06H4qvXcBrsPXRofHyy2RDq1z4BCyc5bCb/KD/EYZZ1TnX8xt/NW4Pb+gR34hDHyVhHVjp4BNlP5KPrwpSKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8B4c/Q1rQfrlILeRsdx6FPyCfBtO/Sgp4JpCl0mFmw=;
 b=byStMsCYqv4NVfEWGiG8Ao5+OtOZbnLV97bOqLdWBD8dytVudN4SQZ8D7ad/I56VAtI6oTK+/ENx8764YvNAp6nXOt5mcv4ZYvCBF30J6FgbGtuBcvQCNLrFDZfTFDeqt3nZc337LURd8iPcXlJIvKSZodjM/tyqFFCHqNCxx0BCAOlzzkBbT9fF1h+TxZ3EXKUN5ESyDy89C2Xx8aNm8F8FqALYz64K+e9bvMFMH1pwdO88UOlDQeeNc69sOlejGfotj1IqPu5vixjqXIjReG6vZTj0b0/WBy8f00DOp3Sb1MW2vMWFLGZkR7ydPOaGtN+HaE0enyvBE0lubV7xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8B4c/Q1rQfrlILeRsdx6FPyCfBtO/Sgp4JpCl0mFmw=;
 b=hfxVnlSc8b9HJzsy5rkLnXUiU0flgmHCUL4XBTHI7XjmRh+bav57sWlxIuUs9R7MWXIEvr3Cjeo97KNukn3nWByYBg+wDeLZhVXsps+t2iZSkX27jC06lMQvyfovrQ6hnm7Adewww+eqfvEcmwRP8taDmqNpEu5audNVsRfmeAj6NHWzcTYU9oYhx+zNTqBffBr3jOJSuQl/YEVz+Ml+pCPNArqkt0DorvKp7qY7A1oyW6HHM9Zl1TSX8Lvjwy/zH3WM7ODwC0zgE+GwmgsRuPrLjuDQujo0UMkp/BI1dMtMyGIx01obj9RVAj/NVniVVp0nBDC+4EJuBQl6s1IyQg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 11:07:36 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::f0ca:466a:6886:bb42%9]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 11:07:36 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Topic: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Index: AQHYQyR2vaeMng1qcUOLm0jf3VFxu6zfmOGAgAAI0tA=
Date:   Mon, 4 Apr 2022 11:07:36 +0000
Message-ID: <DM8PR12MB5400ED1195FE612BBC67CB62ABE59@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220329042109.4029-1-jasowang@redhat.com>
 <20220329042109.4029-3-jasowang@redhat.com>
 <20220404063241-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220404063241-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f071ed-1bfa-4e09-2cb1-08da162b535b
x-ms-traffictypediagnostic: MW5PR12MB5683:EE_
x-microsoft-antispam-prvs: <MW5PR12MB56836756071C03189EA0EC0FABE59@MW5PR12MB5683.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGsW7YTQ13GKlGoc/CC03Zaoc2NF1i1EuNC5Fi+24+uhDPViilrV9URmeEBp+NWiL14wMP114FiAiC8awuN9CHOqLH3jg9DVQIPjwPDaAyOE51qwZcAiXyVx8q9PYg82F/Vo4KOHw4y46DcGfO9fCE9z4ZL1spKnh9/BorkiS3wD2xr2PGuIlRUaqMHhCtyYlr6ykndRlStPUZ9Oob87nJaBDn2LmD7mD00OM0GdwkMQk0V5hJl8zIlY4XDhkWdiECUyNz/900A9qzEaQmomIGF8K+wSEhacNgjCZdAcGEKRyqVm8AHMWAitHaV2I9UZ6evvaPsOeLbUFNpOrUDjt+BInmU231/GJVXb5F2qUYP4Fqz4H97i7sjco/EXjSJLLckWzcB8SUXfDM7tIA+qN1vQpo4A9pMgvVDXoZ6QlVVlnFZIfWNNR8eubMOzYsROOu1xV3oQlJHFRe1ayEwJCGFqhmn7JPi2w+qjZG+9HNz56S3d9TeKhGrNY/adhpKRaa9Q4iRvQcX19B4XBBEhhjdURnxsrHlFVfZz2LiynH+jNvO5QTb3VTql3OwPO3uz8D0xEMrqbmOAwl73VP2Rd4e7nMv4mkywAaLt/T2E7mEJ5Hh1pF1Tc7d3SPwZy29i/AXnqK+XqKJ2wdJS6kRK7yxhKrrxlDoyh9+ydR0jLHOSYq7X/U+XVR0t9bfczBOKMJX6M1ZA/mB1byWHoKYPHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(316002)(9686003)(86362001)(110136005)(71200400001)(38070700005)(54906003)(66476007)(66446008)(66946007)(66556008)(64756008)(4326008)(76116006)(8676002)(122000001)(55016003)(5660300002)(53546011)(33656002)(2906002)(8936002)(6506007)(7696005)(83380400001)(52536014)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OiFOwgNabSJVm+YxxhZR8UqJFZMhMqlwblUQr+/9R1buMKFgOXk0Wtl8mL9c?=
 =?us-ascii?Q?PlxLstc6x/gdTL7zF+naTctgHMsIT4No979SsOeTz62DjaMNZRIlzioLIm4l?=
 =?us-ascii?Q?KzAyAq0ie5vzH+RhxgHHNrJ5ZP4wHkE0cSLrpsk6Ju3WBr++enMgELW/TSWL?=
 =?us-ascii?Q?7n5+zl1uWVMtit6dRDq8o+w5WP3klPCZ4XqfInwLQJNejMrPjZ5m2md3PjXx?=
 =?us-ascii?Q?FHtMeDrnI0tWdcsAo3veefkYn6acTLgUui754jK3Uleizkf/1BW8QAq5eTI2?=
 =?us-ascii?Q?nJZvkV0hqWcNQp6kPN6XL7onIoN755GgU8hYHzVW4l/vz7hImjLVO9s65n8V?=
 =?us-ascii?Q?NnQSqU5hk7I+Ot3CVZCLTCPTsGxto/MxUvDsuRrE1ESQg/zQm+jjA3YGl1vU?=
 =?us-ascii?Q?dAH9JAk+jeXwZgBocVMBcjJD2po1uxaiA9NeVeMETMWFoh6Kk3XnsMqgOgiJ?=
 =?us-ascii?Q?Hv0phWIQ9MqM75QwPelUx0Q+xw4txBOpahjFhF+SrwrRy7F49Jf3HIA+Q+el?=
 =?us-ascii?Q?tdcmhz0hxIk4w5osDhSuDsRbSnFBAzkaF8IagP855MGGG5uy6mHXlNtAaiT3?=
 =?us-ascii?Q?DfWFC/AokJXvpAIBcc95pc9vFfJn31XqJRPpM7HPFWSdXddZg4MY0o6hBcM9?=
 =?us-ascii?Q?TJg7lJWJk4kWmk8m7t5cBY4VjZnBtbX3dVgXUKi43btaMuJdT16NXTl8u9HW?=
 =?us-ascii?Q?rPRbC+/ely9QjTHciVVgQCiyVPiikHVl9Rqljue287hKSyERL1pByhUYlx8q?=
 =?us-ascii?Q?LpM67qhNlXOlMIqYzP3pXpkkGBTFki86QtaWj+O1z31Bs20aB9DNdXRbvaJT?=
 =?us-ascii?Q?bwPUyKhwVIz5e0df3QUBO2j4MSbZRpnNv1S33ISgUTGSx3JjW24Lio+BuWXi?=
 =?us-ascii?Q?f5B6RaNLHN4rMor9OIgIwB54K/6eygk0zIB+yQhU79fTghUaqRXNSVNaA/qb?=
 =?us-ascii?Q?cB+57kA1dQp7SuWyQGb8RFLn1VYKOgri4f9RR9KlfQ1oMeVs7h3KobDjA7zh?=
 =?us-ascii?Q?cM6D2kQMcNuLMqqV8Zi0AFPWgzPl3mh/eVfANCwV/7iWz+aDk2W3J1k4JV/W?=
 =?us-ascii?Q?psecYvyUGDJcJwCtmD/HzJaSqE7y+zqeYWf4xeLbI5bFrX1n5U+i/I4ghDkt?=
 =?us-ascii?Q?n3UtYVSVKtyhIN6J2jLy3ooWqMjfLrYUSfginmK4MZraHmuWAuQ6JbyA3MNe?=
 =?us-ascii?Q?cDE8ifVJXqfY6rPnMxOd/kZHCaOK4IF4qV5+ycuTii623rglCu1vCK7l6ZA5?=
 =?us-ascii?Q?CUH+qZ120B4SMuxuDWRi+9s9Aal33xdv4o4lpNHjB4nT3dhcK5Kr8a1U2uHd?=
 =?us-ascii?Q?dwR1nS1MKQH0yTqv4Ku0g69RCrAScJMeHUIhNmHLh8PlwQ0Gc0FcJApRa4fY?=
 =?us-ascii?Q?eGQPxzEBEB8Bm0kPBS8rWAGFksygEQ34qvTT+euYXnAy4q3zC0L+CylxPmLn?=
 =?us-ascii?Q?piZTt30tTnezUDKt/izDdhtI2wlw03gnRAc/5FmfnaK82+eaUg7drXbIqtfK?=
 =?us-ascii?Q?3YPq7SFLPpZuGWMoa43XmvyrJs8qxIosyxx23OWs2Q9yoNTXBxZ+KmytT4hV?=
 =?us-ascii?Q?BwOQvftorn6hoT7CyQcfpBkekAp1RjslPLGO9RHNdnAmQPTiG1R0X6aVIL3S?=
 =?us-ascii?Q?SutP26r0kNJE1SR/6FCD8wY3CAlutiB7Rm+5nQ+V+5RBEtTJ4TGDLK3sX/7d?=
 =?us-ascii?Q?3XZybcUpbgIGRQELWsOzPmV2UmjKJzQxkcB6/0Q6jkhRIPGD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f071ed-1bfa-4e09-2cb1-08da162b535b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 11:07:36.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMFdHiqzmCTBhLCm8mBNA/rzO2I831CfiCq4z/qA3zoRltBOouNpP0q8jMCcZRVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 4, 2022 1:35 PM
> To: Jason Wang <jasowang@redhat.com>
> Cc: Eli Cohen <elic@nvidia.com>; hdanton@sina.com; virtualization@lists.l=
inux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
>=20
> On Tue, Mar 29, 2022 at 12:21:09PM +0800, Jason Wang wrote:
> > From: Eli Cohen <elic@nvidia.com>
> >
> > The current code evaluates RQT size based on the configured number of
> > virtqueues. This can raise an issue in the following scenario:
> >
> > Assume MQ was negotiated.
> > 1. mlx5_vdpa_set_map() gets called.
> > 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
> >    than the configured max VQs.
> > 3. A second set_map gets called, but now a smaller number of VQs is use=
d
> >    to evaluate the size of the RQT.
> > 4. handle_ctrl_mq() is called with a value larger than what the RQT can
> >    hold. This will emit errors and the driver state is compromised.
> >
> > To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> > required number of entries in the RQT. This value is evaluated in
> > mlx5_vdpa_set_driver_features() where we have the negotiated features
> > all set up.
> >
> > In addtion
>=20
> addition?

Do you need me to send another version?
If so, let's wait for Jason's reply.

>=20
> > to that, we take into consideration the max capability of RQT
> > entries early when the device is added so we don't need to take conside=
r
> > it when creating the RQT.
> >
> > Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> > max_vas / 2 and make the code clearer.
> >
> > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
>=20
> Jason I don't have your ack or S.O.B on this one.
>=20
>=20
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
> >  1 file changed, 21 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 53b8c1a68f90..61bec1ed0bc9 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
> >  	struct mlx5_flow_handle *rx_rule_mcast;
> >  	bool setup;
> >  	u32 cur_num_vqs;
> > +	u32 rqt_size;
> >  	struct notifier_block nb;
> >  	struct vdpa_callback config_cb;
> >  	struct mlx5_vdpa_wq_ent cvq_ent;
> > @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_v=
dpa_dev *mvdev, u16 val)
> >  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> >  }
> >
> > -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> > -{
> > -	return max_vqs / 2;
> > -}
> > -
> >  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> >  {
> >  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >  		return 2;
> >
> > -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> > +	return mvdev->max_vqs;
> >  }
> >
> >  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtqueue *
> >  static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> > -	int num;
> > -
> > -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > -		num =3D 1;
> > -	else
> > -		num =3D ndev->cur_num_vqs / 2;
> >
> > -	max_rqt =3D min_t(int, roundup_pow_of_two(num),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTE=
S(rq_num);
> > +	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_=
SZ_BYTES(rq_num);
> >  	in =3D kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *nde=
v)
> >  	rqtc =3D MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
> >
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q)=
;
> > -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> >  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> > -		list[i] =3D cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
> > +		list[i] =3D cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
> >
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err =3D mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn=
);
> >  	kfree(in);
> >  	if (err)
> > @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *nde=
v)
> >  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> >
> > -	max_rqt =3D min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTE=
S(rq_num);
> > +	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_=
SZ_BYTES(rq_num);
> >  	in =3D kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *nde=
v, int num)
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q)=
;
> >
> >  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> > +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
> >  		list[i] =3D cpu_to_be32(ndev->vqs[j % num].virtq_id);
> >
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err =3D mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn)=
;
> >  	kfree(in);
> >  	if (err)
> > @@ -1582,7 +1560,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct =
mlx5_vdpa_dev *mvdev, u8 cmd)
> >
> >  		newqps =3D mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> >  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> > +		    newqps > ndev->rqt_size)
> >  			break;
> >
> >  		if (ndev->cur_num_vqs =3D=3D 2 * newqps) {
> > @@ -1946,7 +1924,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev =
*mvdev)
> >  	int err;
> >  	int i;
> >
> > -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> > +	for (i =3D 0; i < mvdev->max_vqs; i++) {
> >  		err =3D setup_vq(ndev, &ndev->vqs[i]);
> >  		if (err)
> >  			goto err_vq;
> > @@ -2017,9 +1995,11 @@ static int mlx5_vdpa_set_driver_features(struct =
vdpa_device *vdev, u64 features)
> >
> >  	ndev->mvdev.actual_features =3D features & ndev->mvdev.mlx_features;
> >  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > -		ndev->cur_num_vqs =3D 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_=
virtqueue_pairs);
> > +		ndev->rqt_size =3D mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtque=
ue_pairs);
> >  	else
> > -		ndev->cur_num_vqs =3D 2;
> > +		ndev->rqt_size =3D 1;
> > +
> > +	ndev->cur_num_vqs =3D 2 * ndev->rqt_size;
> >
> >  	update_cvq_info(mvdev);
> >  	return err;
> > @@ -2486,7 +2466,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> >  	struct mlx5_vdpa_virtqueue *mvq;
> >  	int i;
> >
> > -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> > +	for (i =3D 0; i < ndev->mvdev.max_vqs; ++i) {
> >  		mvq =3D &ndev->vqs[i];
> >  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> >  		mvq->index =3D i;
> > @@ -2606,7 +2586,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
> >  		return -EOPNOTSUPP;
> >  	}
> >
> > -	max_vqs =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> > +	max_vqs =3D min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virt=
io_queues),
> > +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
> >  	if (max_vqs < 2) {
> >  		dev_warn(mdev->device,
> >  			 "%d virtqueues are supported. At least 2 are required\n",
> > @@ -2670,7 +2651,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
> >  		ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> >  	}
> >
> > -	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_ma=
x_qps(max_vqs));
> > +	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, max_vqs / 2)=
;
> >  	mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
> >  	err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> >  	if (err)
> > @@ -2697,7 +2678,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
> >  	ndev->nb.notifier_call =3D event_handler;
> >  	mlx5_notifier_register(mdev, &ndev->nb);
> >  	mvdev->vdev.mdev =3D &mgtdev->mgtdev;
> > -	err =3D _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max=
_vqs) + 1);
> > +	err =3D _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> >  	if (err)
> >  		goto err_reg;
> >
> > --
> > 2.18.1

