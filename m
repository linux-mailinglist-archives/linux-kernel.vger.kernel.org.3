Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D682527FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiEPIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiEPIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:39:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3FE0D6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm3/ExvbQxaT8x/Agj3Tvwqo/YwKyqFG3V9doJNM67WSaoFl9+nJGgnP+bAfNBWnO4w5BraOwmfPGcPkvjuiiQa9DOXaDR3LE8jzchuq2H5p0XJAdRhi8Z0WurIyKuiPtCAy52iX0MiRW1vzWnqGf8oo5YMfI8FwOgxO8SXk15rbyzbjWux/+lDSMS602Ql+DrYROpKOm432Fpc5L9OcCyDPlvJ0TO3DM8G14EfQunJHIflT5g1dgeIAV8Z5wZ6eobyOuj8EzELKFE3oOsdbx0/WKTC6pc2PNn2DxqlgH4q5ZvKDKiLj1bWIJ9CFCAaM94POMEyyKzBi+Uz5Vmm/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gVvujE9r7NSNPusYnTLGUJwgRXKzHmMKL9qqhDTOeo=;
 b=JBd04xUOpLribFxnCBWpEyL6FJ2jJUhSmMeYCauwIh1+rgo8bBjxHJI7TJait+2DGdp6NDtN7W38oAqsKWDnvh6NAPuf8Hq0eN2OPABfXZ9buGShjEuoxR16MtkMV9oRVkFD9mPGhZWTvhUWf//RkgWSgaGRbjm6jW4kI3bAa/Fqb9CUdqQLw++zTpLhRctqLPp9hTkKRwy/UiWoQ63uL1K3gu/7L2QZrTzJply5CZ7DJK6F7CNnY9d5T0esvbdSCLxF1YSj0544C045GYfne420Ethq2IqObN77w/SgvI3tJ9XqHJ2kr33NcZME3CfZEGYhfn2U0hCy5Htmtgnw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gVvujE9r7NSNPusYnTLGUJwgRXKzHmMKL9qqhDTOeo=;
 b=FGHJmpFbA0q9OnzTpiFOluK7kmdTMmBlen9MVXEp7C6dQi3Kdc9wVr7eYEDoHwOnuc3w3+/H1kvgjEELOA0nM+eni/lYtSkMxQl/xvkdjzvbWBxllDJVnqoRz5ISkm+olOPyn99mfeBF2FlEuG07GzIp0Mpbazh9H5ksZiIDQ3GS1joZsc98lWTxBe1HXns5oaxzP48io3+lnIdvwELECDYyPz0JqbjLC2p7kbRJR8zx5Rrk3iQgp2llAeZN0Ma+j0A8T082BAstzRFXagYSrMfZ/aqIzQtsn5Tp1m99beu70dYdC+i74E6tNlsoecsnvYwnrgTAYyLOjAYmJjjPRQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BN8PR12MB3348.namprd12.prod.outlook.com (2603:10b6:408:47::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 08:39:10 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:39:10 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Topic: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Thread-Index: AQHYSZPR4kA5EJOyOU2XnIy2K7YWIa0hZobggAACjICAAARzQA==
Date:   Mon, 16 May 2022 08:39:10 +0000
Message-ID: <DM8PR12MB5400D5CBE21E293A101D5A5DABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220406085325.87644-1-elic@nvidia.com>
 <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220516041917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220516041917-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37fe73a4-a2bf-418a-f95f-08da37178c2a
x-ms-traffictypediagnostic: BN8PR12MB3348:EE_
x-microsoft-antispam-prvs: <BN8PR12MB33486FD6FE8C46CE82652C97ABCF9@BN8PR12MB3348.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrEYvpKZUz3rU50TEwzgWDN+oK8vKLe0ebIita3KcF6ALGe4X2P3DeikRTouhqS2yPkaQ16w3whJA9OHpLkg+Pz+99pcPllFV365PQ5lm19ggdVoQx+GRBimX90NApjS3LcqgIWr2Ue/kiqy3rgGSKq2+ZrsCLqkPbsG9y6nH4ACi8cA7PrAZ0MkV7VzVk1oRrDr+Ih4SvlHKWb7s2cAxTLp4Zx/qRfC0Joiwxm2VPlHbYL/3X2+gAz4p+uvvl6riH7R9lexB7IOf2iSHYslK/m66zcpJUIm3YfF4WbAVRb9J5kZDwfyLrkHf3qVQ2cn9g52A06sqw/X8hhMGouoE3B/5RsW/f65aBwWvCm+DHyqOursKdAKfKyvozCTSO9PUjdDcr7VBS1e8QkF3jZXRd21hi5I8R3OSDsQZSDITVoPm0ExtmE/euwkhd4M4z2WGnIy2fny19B62H/6TDSBDEEanAKo6dktivo/WDmd+J/v4i8fxJM1e89t9+/EEso2hKVW9t38RuLd6rxM8aLrCLmnCOfoMl/Dq71+JgS09hbreteuDIGbylf5NMpOlm/vbcO2+42TuAXiQZxENS5LFySAMJ7QoexloBIpybesTG3M1UDgZ1s5Bz7t7ts8F6o4q1E5mXZICnP7RZ+x8HR74+IUDFUDUTuk2fMjpYt4jgXNdFFxVjiyVJq2h6Od8a4TLqlkroLZx6OAmvwy4WeRVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(54906003)(38100700002)(66556008)(55016003)(4326008)(86362001)(66446008)(6916009)(83380400001)(64756008)(5660300002)(8676002)(33656002)(9686003)(26005)(7696005)(186003)(38070700005)(508600001)(8936002)(2906002)(30864003)(71200400001)(66476007)(122000001)(316002)(52536014)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ZtZ4/fq0ZWf5JuQ7FKha9S2v/4duYu+KdTOQROgFkEz2gyt4/jvE32m2NxB?=
 =?us-ascii?Q?ZOBMZSdEFBKnbn+Fv0NpOdUIogW+6A1Y9jsetfVrmkigBw548ocaa/pRqX1f?=
 =?us-ascii?Q?7K62TWG4Sx6Q7v/IXflxa6YGPtcCS98EVSpXxGGcCNRD7atNfvrYzVgWlM+7?=
 =?us-ascii?Q?0WS8/YPERdfcJDsr4EhZIPpKL7aVVYTVD7h18XNfhxsuo8zpaJYt0xoe88ZM?=
 =?us-ascii?Q?/DNQntf0EdXU3ljXWzevCUdY6XHVXoDbfw4SRT7tiQwVLvmAc2tdeJl4+Mxo?=
 =?us-ascii?Q?ekf7F68xDGpI4tL54izxVucHDmsfeWb2YvT3In4apxI5hL/NvWVFqIbPN6Eo?=
 =?us-ascii?Q?gyuZ6tkV3dwWjExWJRwe8NMeIsx2XY6f8aL7pYVe5OrXfaiepE0BoqVRQd5E?=
 =?us-ascii?Q?3IFUyyXg1k7bCAoJfjIpk9B/W5QeZ7bb2vIwV+7YfxDQ2W1EKuPf5lb7tW+a?=
 =?us-ascii?Q?YFd+74PiqCf5ndFEOOA1lCfgXr6lR69HdiuYyhynJ/zS2gR/4tYkeK1EcLVl?=
 =?us-ascii?Q?aRaCJjCjdq7umHgQS1XXg950Egv6AXp5q7lYMSsa6g01/IvegQAfOTF9lRUs?=
 =?us-ascii?Q?sXbreh32uVLMUopzE/wM4jc0ydFzGXlYiPeb3E/nYd7B6WNRm75xBZ4R7y/l?=
 =?us-ascii?Q?evBGp/1mjNCo4BDrDBzDDekjvuv9a7M7ZZMaMnHSF3LZSQ+VMZRytB3HFHvA?=
 =?us-ascii?Q?RYQbAyFGKRl1aI3Lz7Pk8GLQDCT/jkqmfjkOJS/EhlDOKWdFTtX5s7hMjW1h?=
 =?us-ascii?Q?VKZ9+y6j4OPzNZJtcMyLE+RSywWemnjlYKRVcd2CEk6JYaoS4zYPj0dOh1oU?=
 =?us-ascii?Q?vVQTT55qqRR0Fr/xAi7zu3eIspez5D6iLWYGkuvyvp4Gtx73nfXSlg19x7RL?=
 =?us-ascii?Q?AP6yNJAjgBzJex+W1Asss8+febka2INJCdNvqBADTq29R2mNI+qi1k+K2zf6?=
 =?us-ascii?Q?sARBnnA2gzu9KWOGad53cFonopJ6WKA6VNOc5vXh48t4DPUeaOhimW698Nbt?=
 =?us-ascii?Q?F76oIzzH5CLGxwqFCiTJnBKZWLf3ijlVU9r9zR39SgVlm1HaN0KgEPNHC+Zd?=
 =?us-ascii?Q?YL6rNgPjH1H8MUEe9IiMZU4sKz7WHdXwX5PRIasGPR4oYaYFUf45LAfhnG22?=
 =?us-ascii?Q?tdB+ZGcImjurM8RxbKUmSdJ1wUL7nh4nAIvsDbXJt9nFv9pmrBhvq80myGzw?=
 =?us-ascii?Q?Uck0Zq+TsOFRTBEiRkgrGohzfHNOAfklJFIST1ogaThO8i0X3PidI8yqh53M?=
 =?us-ascii?Q?Zg8UC3gPV4V/2UPbEuoqRgVoW8Jz12M91XfjkQZ8lCqDIPbruRr6YAlhFykj?=
 =?us-ascii?Q?tQUytFUz5jOPc5UDjX8w9v8fqYhv44jrS+QkSwmXbzkubbVXyrUW7fQeOXNl?=
 =?us-ascii?Q?zLndwrnqYPI6JKD3SN+SwjsuHfTCJ3WyTdeVYrrwHvdbJ+DZDS/0QV4zbm0N?=
 =?us-ascii?Q?OakT2h/IfcOW2y8P6Jb+7yYJS3sgUwL0bbtLz9LN+jVz9cQwJw8AlLxQlA4x?=
 =?us-ascii?Q?aP5E9EzLOHinqBDU2Wog6E/L4F/msAos/0UeBlOWIgjMXGp8pRb4GhfhneyS?=
 =?us-ascii?Q?wimvhNUyBiz0AiCHEMK2trvjwa8NE4SbGKMhA3n1ZV9MBrRJNuEpitlY8uJw?=
 =?us-ascii?Q?LEgoy3Ib3E1l1sJX6u1gkK9uYv0yVn/dBzhXrYok+qnuyD6Dt5oQsb+0NX0o?=
 =?us-ascii?Q?C+eJVlroTKcZUbCpB4ksvYO5a7RXOMp/VJfHepwT83/oYAbX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fe73a4-a2bf-418a-f95f-08da37178c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 08:39:10.1279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eerP2iSVYXFPQmRnUpzczVEQT7OcyZu+2OBaaX9t6ZJuVCl6lSZhUDbexIrJ2M/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3348
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 16, 2022 11:23 AM
> To: Eli Cohen <elic@nvidia.com>
> Cc: jasowang@redhat.com; Cindy Lu <lulu@redhat.com>; hdanton@sina.com; vi=
rtualization@lists.linux-foundation.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
>=20
> On Mon, May 16, 2022 at 08:17:18AM +0000, Eli Cohen wrote:
> > Hi Michael,
> >
> > When are you going to pull this fix?
> > It fixes a real problem and was reviewed and acked.
>=20
> Do I understand it correctly that this is a stand-alone patch?
> Sorry, my process have been thrown off by it being labeled 3/3 but not
> being part of a thread. Do not do this for single patches please.
> And I suspect 0-day machinery didn't process it either.
> Can you repost as a stand-along patch please?
> I will then process ASAP.

Sure.

>=20
> Thanks!
>=20
> > > -----Original Message-----
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Wednesday, April 6, 2022 11:53 AM
> > > To: mst@redhat.com; jasowang@redhat.com
> > > Cc: hdanton@sina.com; virtualization@lists.linux-foundation.org; linu=
x-kernel@vger.kernel.org; Eli Cohen <elic@nvidia.com>
> > > Subject: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
> > >
> > > The current code evaluates RQT size based on the configured number of
> > > virtqueues. This can raise an issue in the following scenario:
> > >
> > > Assume MQ was negotiated.
> > > 1. mlx5_vdpa_set_map() gets called.
> > > 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lowe=
r
> > >    than the configured max VQs.
> > > 3. A second set_map gets called, but now a smaller number of VQs is u=
sed
> > >    to evaluate the size of the RQT.
> > > 4. handle_ctrl_mq() is called with a value larger than what the RQT c=
an
> > >    hold. This will emit errors and the driver state is compromised.
> > >
> > > To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> > > required number of entries in the RQT. This value is evaluated in
> > > mlx5_vdpa_set_driver_features() where we have the negotiated features
> > > all set up.
> > >
> > > In addition to that, we take into consideration the max capability of=
 RQT
> > > entries early when the device is added so we don't need to take consi=
der
> > > it when creating the RQT.
> > >
> > > Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> > > max_vas / 2 and make the code clearer.
> > >
> > > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > > V2 -> V3:
> > > Fix typo in change log
> > > Add acked-by Jason
> > >
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++------------------=
--
> > >  1 file changed, 21 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index 79001301b383..e0de44000d92 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
> > >  	struct mlx5_flow_handle *rx_rule_mcast;
> > >  	bool setup;
> > >  	u32 cur_num_vqs;
> > > +	u32 rqt_size;
> > >  	struct notifier_block nb;
> > >  	struct vdpa_callback config_cb;
> > >  	struct mlx5_vdpa_wq_ent cvq_ent;
> > > @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5=
_vdpa_dev *mvdev, u16 val)
> > >  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> > >  }
> > >
> > > -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> > > -{
> > > -	return max_vqs / 2;
> > > -}
> > > -
> > >  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> > >  {
> > >  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > >  		return 2;
> > >
> > > -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> > > +	return mvdev->max_vqs;
> > >  }
> > >
> > >  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > > @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net =
*ndev, struct mlx5_vdpa_virtqueue *
> > >  static int create_rqt(struct mlx5_vdpa_net *ndev)
> > >  {
> > >  	__be32 *list;
> > > -	int max_rqt;
> > >  	void *rqtc;
> > >  	int inlen;
> > >  	void *in;
> > >  	int i, j;
> > >  	int err;
> > > -	int num;
> > > -
> > > -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > > -		num =3D 1;
> > > -	else
> > > -		num =3D ndev->cur_num_vqs / 2;
> > >
> > > -	max_rqt =3D min_t(int, roundup_pow_of_two(num),
> > > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > > -	if (max_rqt < 1)
> > > -		return -EOPNOTSUPP;
> > > -
> > > -	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BY=
TES(rq_num);
> > > +	inlen =3D MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_S=
T_SZ_BYTES(rq_num);
> > >  	in =3D kzalloc(inlen, GFP_KERNEL);
> > >  	if (!in)
> > >  		return -ENOMEM;
> > > @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *n=
dev)
> > >  	rqtc =3D MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
> > >
> > >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_=
Q);
> > > -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> > >  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > > -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> > > -		list[i] =3D cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > > +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
> > > +		list[i] =3D cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id)=
;
> > >
> > > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> > >  	err =3D mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rq=
tn);
> > >  	kfree(in);
> > >  	if (err)
> > > @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *n=
dev)
> > >  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> > >  {
> > >  	__be32 *list;
> > > -	int max_rqt;
> > >  	void *rqtc;
> > >  	int inlen;
> > >  	void *in;
> > >  	int i, j;
> > >  	int err;
> > >
> > > -	max_rqt =3D min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> > > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > > -	if (max_rqt < 1)
> > > -		return -EOPNOTSUPP;
> > > -
> > > -	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BY=
TES(rq_num);
> > > +	inlen =3D MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_S=
T_SZ_BYTES(rq_num);
> > >  	in =3D kzalloc(inlen, GFP_KERNEL);
> > >  	if (!in)
> > >  		return -ENOMEM;
> > > @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *n=
dev, int num)
> > >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_=
Q);
> > >
> > >  	list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > > -	for (i =3D 0, j =3D 0; i < max_rqt; i++, j +=3D 2)
> > > +	for (i =3D 0, j =3D 0; i < ndev->rqt_size; i++, j +=3D 2)
> > >  		list[i] =3D cpu_to_be32(ndev->vqs[j % num].virtq_id);
> > >
> > > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> > >  	err =3D mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqt=
n);
> > >  	kfree(in);
> > >  	if (err)
> > > @@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struc=
t mlx5_vdpa_dev *mvdev, u8 cmd)
> > >
> > >  		newqps =3D mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> > >  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > > -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> > > +		    newqps > ndev->rqt_size)
> > >  			break;
> > >
> > >  		if (ndev->cur_num_vqs =3D=3D 2 * newqps) {
> > > @@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_de=
v *mvdev)
> > >  	int err;
> > >  	int i;
> > >
> > > -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> > > +	for (i =3D 0; i < mvdev->max_vqs; i++) {
> > >  		err =3D setup_vq(ndev, &ndev->vqs[i]);
> > >  		if (err)
> > >  			goto err_vq;
> > > @@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struc=
t vdpa_device *vdev, u64 features)
> > >
> > >  	ndev->mvdev.actual_features =3D features & ndev->mvdev.mlx_features=
;
> > >  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > -		ndev->cur_num_vqs =3D 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.ma=
x_virtqueue_pairs);
> > > +		ndev->rqt_size =3D mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtq=
ueue_pairs);
> > >  	else
> > > -		ndev->cur_num_vqs =3D 2;
> > > +		ndev->rqt_size =3D 1;
> > > +
> > > +	ndev->cur_num_vqs =3D 2 * ndev->rqt_size;
> > >
> > >  	update_cvq_info(mvdev);
> > >  	return err;
> > > @@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *nde=
v)
> > >  	struct mlx5_vdpa_virtqueue *mvq;
> > >  	int i;
> > >
> > > -	for (i =3D 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) =
{
> > > +	for (i =3D 0; i < ndev->mvdev.max_vqs; ++i) {
> > >  		mvq =3D &ndev->vqs[i];
> > >  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> > >  		mvq->index =3D i;
> > > @@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev *v_mdev, const char *name,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >
> > > -	max_vqs =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues=
);
> > > +	max_vqs =3D min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_vi=
rtio_queues),
> > > +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
> > >  	if (max_vqs < 2) {
> > >  		dev_warn(mdev->device,
> > >  			 "%d virtqueues are supported. At least 2 are required\n",
> > > @@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev *v_mdev, const char *name,
> > >  		ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> > >  	}
> > >
> > > -	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_=
max_qps(max_vqs));
> > > +	config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, max_vqs / =
2);
> > >  	mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
> > >  	err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > >  	if (err)
> > > @@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev *v_mdev, const char *name,
> > >  	ndev->nb.notifier_call =3D event_handler;
> > >  	mlx5_notifier_register(mdev, &ndev->nb);
> > >  	mvdev->vdev.mdev =3D &mgtdev->mgtdev;
> > > -	err =3D _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(m=
ax_vqs) + 1);
> > > +	err =3D _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> > >  	if (err)
> > >  		goto err_reg;
> > >
> > > --
> > > 2.35.1

