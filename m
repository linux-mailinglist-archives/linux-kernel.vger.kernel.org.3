Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36294E634A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350125AbiCXMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbiCXMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:25:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9A89CE4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpR2SqGtdZZj5g3wEChyxMr2MfjnQFg3xM+TgUjk5WOzdDuGimEGXSgnn145S33Qet6QG2gwiYJ99JDl9lHbqUOHTx+sAbEwmNcaucSTowZw2tmr0cIb/aW1Z7Hy9UObIaDijSoz8UX79xTBHbzriW+0uVME16FhbB8MtRA4+0zoVlHILsH8ynW5J76NqFzOtXkUdWoz8jLMkSsTxyHn100fVyqBaXUuKD3iGmY3eomDLR+XsAhWeiLPoLB6nfdxpqEP35+p8UmrZ5LyiT0LSXmV4mhfCfwqSCvAGeIw1zcA6oUc2wqXKaLyXBVqKzn+J93TsJmPxlqeHTg4VnLoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWCltD9Ui2Q9mjplPGVNKhoZBcpQf/ePOuEClkwTIYU=;
 b=nbqfACmPISvV7LOvclzvgN2Owe0mTJ3TPrzLxhfJ76iNyPuuyAkR/8pqmNFddHuTZY9Z6FOzMElMCgQywllTa1qXTqO1bQNtQ5rCgc1W5WYvkZaucoRv9MoZMzqHefu3maGxHS6QqvZPrpodTvpKXU8h/QdrxsIf0ZaFDCJ64BSSElbfLzmt5nejPa/wGdo4MRAYHeHd+vHDyJnaRHMI9fwcmnd2Z2oSfyACE+Rm4foYXX3dy55S7Cn/dN/qzGytYoBh9r7VnszTWBMk65zBKImYAXPPWPDHpItHu+bSsNTZac+gOCa7Twu+42fOSRA7GTuLRavC03vf8NlIQN3bAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWCltD9Ui2Q9mjplPGVNKhoZBcpQf/ePOuEClkwTIYU=;
 b=Ze7MxUpp7FndQ415XrM73yJ8qEd3cFODjuzSAlojU5Sv6DPqs5bhGCacJpoQ6XMo+DkDZrqrLVqdeP+JXtAUMasso954bn3a9UHIoe+RttNG8d6oNkHPifdIVzaZdMIIlApDtv5BqYorShb5lBlr3YAT0Zd/MCik8Rcyb1C15W9RLESB0PdsBXfuVh5xg8nQFiLcIbREnFCCiMYZ8zu9/+loZ9wJ5prniizgjGOhxWzC7/pXIUYcsRcrg21WaL/RLcNCdGDKoNkTuBTVYdcdpZpEws1hH/ph4TA+lFzKCkYLvoqqmy+QT+doJFDBmUWoEXW/fUJnfnf420GQxFUNRA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Thu, 24 Mar 2022 12:24:19 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c53a:18b3:d87f:f627%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 12:24:19 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Hillf Danton <hdanton@sina.com>, Jason Wang <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Thread-Topic: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Thread-Index: AQHYPOmOAGfLcKLGQkKqa8QJSXdItazJiGOAgAABoACAAABLgIAAO9gAgADg4wCAAxJegIAAHA2AgAA6uICAAAOSAIAAIn8AgAA984CAAAVsoA==
Date:   Thu, 24 Mar 2022 12:24:19 +0000
Message-ID: <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
 <20220324120217.3746-1-hdanton@sina.com>
In-Reply-To: <20220324120217.3746-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff809c53-62c4-4db0-dd14-08da0d913874
x-ms-traffictypediagnostic: BN8PR12MB3108:EE_
x-microsoft-antispam-prvs: <BN8PR12MB31086DA8BAFE1E3847B7C06DAB199@BN8PR12MB3108.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Vc/E1FguJdoDfj2IPtQG4SaMw7T440AMwqwqaMS5Geouasw80Rc06c3apERC6490F5nU9OA4GNJZ1Vc4hUGAQ1pf80aNFmFPNYmjlYUv9Oh0CyGRkfaan/NUt+LvPQwdSWYq4AUdIcboDsLs1J0SDRtMz1/AWURqUEbBJhNpJhHej4piz8j2e5fA5vgmCvxrmQZoNyoNo/wi9GCrNEYjPSnh9BSUjeQCo9pRkSKvfBnufm9xktNIp83x5uFHSF5t8OcwAkPX3IWuAPc/mj4wipy6vlWBqsxVEy8eEDBEL/REwVc2aMYi/N9Wz9aJXd0vg58b/95mGgIq5h0IvuSfWrGLxFjZJSOHz3loU1dvXmZ7FbH/b3HAMTCRu9DZMBKEW/dm0YJ1yEswU9m4ni/Qev09H+mYcGf+NU9Gc5nD/SxkI4k3kGvSO5bkpypC8/unR7fFkJ6NvCXpiqA4rTzzwMZy0QVemQS9Z7o7iv5p4x4IkKxU9kQNVb9lmrXNzI+9GocQOyyRIJIRzdYjUkGIHK7bkVQk8fMefrgEW0rVM3qr7dL9lJ2kvSU18MRDpl15rdsT51KUvSaTvkHd6RJL3TZANLcnLVRskBRWkM/mqd5kLKZcIjpcE7S9So0kJDpLPDhM+pAKsLuStj+atn6/IC0ennATRzOGR+rnfKOabViF+RaBs+nnASpvcvAF/gfZhA6RBELOdSuIAXgnN/3Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(38100700002)(71200400001)(64756008)(66446008)(8676002)(86362001)(66476007)(66556008)(76116006)(66946007)(54906003)(110136005)(316002)(4326008)(53546011)(9686003)(6506007)(7696005)(122000001)(186003)(83380400001)(26005)(8936002)(33656002)(2906002)(55016003)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bmYmb2xstSD7/LbVp7dIuIZzKqUiezD/DPaCPD6EHrFGvdBY2R0qy7ediMH+?=
 =?us-ascii?Q?kXpIyzcPzR3QATdnn3vFTvLYleJWB1FE70gG90S+DjtWjQSo88b2lu9baVXC?=
 =?us-ascii?Q?EpQank4eZrUGXg5yoYUO8BEB28cWolr6mjL8IYOYTZJ1ybp77/zpso0LYBa3?=
 =?us-ascii?Q?vKvgNBCa/DnTXzrr/mryBlJWzQsK3cPv1KD7MHpWXckcCF5CcLVLEKfcKxII?=
 =?us-ascii?Q?bQDU5DtxglGQLFeRPZuORYN+ikNi7N09a6rHpd7Y4wDjnG8KImisFArD3+AH?=
 =?us-ascii?Q?egDidsDl/z8rGz66Qf/oYD3WjoM2cwC/NR6yL+sltqfBJjEgiGSl2lDr+qMw?=
 =?us-ascii?Q?PGE1IRvo3LjEMtDH5OAeQmHcj4KLdNxeRAZBIIXqb9PbgGoiij2VBG5Nk/yh?=
 =?us-ascii?Q?Vd6fRIYByG237tHnZ36vfi4QBBm5F1ucGLM2dZiY8UzVZZgd6qjGFSYSMpv6?=
 =?us-ascii?Q?kRLYxg4ybimg3GgZ12BYH+woVSnQMRuKVOsukkOLOl6TIbi1lndU3RBNXGQM?=
 =?us-ascii?Q?HJMjU3WG1Xn0uTJoYvFwKJq8MZrm7zjk0H0+9BoM3G+UK01f57GqqjGRbLYC?=
 =?us-ascii?Q?Mm/ogrNLjfQOdYZtmdXpWOK931bDbpTdgmzu9VaLT7Ein/BHFAE12HkNmpzD?=
 =?us-ascii?Q?UKSODUbrfUMhZPbeGPZSTvyM1NHp1GT9Zs1Thjv/QbsmjjJdDGoZAYpDQGPi?=
 =?us-ascii?Q?eD4VEClB3PRAriXo/0j7McUG0BdwxOBIvexkTaIPVGOlxzkiPA9cX4IOy0Av?=
 =?us-ascii?Q?PFwjazyoEY2FrtGjIgWM7Gjt3LeiR/Ebap4eG6RTFHZzem21KfGAubzlSIo6?=
 =?us-ascii?Q?3KLQiYQ2XSPDh9F289W3kHBIOcyw1zboB7xGoCtQoptUmRsa/Dmcqz3uD0uE?=
 =?us-ascii?Q?Ue317e7StM0htTti6WFljI8yAdNlWxvlg0OM5Ie0T5umT0eTXwFHXCtAuBSq?=
 =?us-ascii?Q?SWftur2SFRNmtdkvIJpFSiIkKb6yJ9dA6mjM21S9qobcnC6O5vJ3KRCkcUja?=
 =?us-ascii?Q?S1zyMOtc97dRE6HWvIN+kSLYhbIvbKzXVvSn+YSGtEbmZJ28Uf710Q4jU7yO?=
 =?us-ascii?Q?ATu24osJyyiWD5QGzLgAxsHulJXVOygyE2jFtatUh49Cj+qYWtJl4cgaCj4b?=
 =?us-ascii?Q?tKHLVp+8ijWjlW/6yHuAkSdcvx4VC+QjO7cD8clrGsPkYk5a49IeceTUNwAs?=
 =?us-ascii?Q?ICHzZ2hJzgmNyVb5gks0PsI1YCfBU56KFbr7TS4tVuJxp266ZkZgopPeXnyo?=
 =?us-ascii?Q?4KPNZv3jGKa+ou9g1nBee26STCb7NOCrlmIBehORwaN05tiYhDArvki3M47s?=
 =?us-ascii?Q?mX9VIcC4YX/wz/sgqHLzzAmnkFA527YGSmH+Y1oI4LdhQKFanO5gNwBnDfHo?=
 =?us-ascii?Q?UiPUaoz3VOgeX+UBDerkqeGGTEjRFZJuNFhGmYGG9MA5RoNELWcvCF7iGZD6?=
 =?us-ascii?Q?uLZTlEShQ3Udr6HJxi0af0sUL/P93aFK5UmbTXM2bZJ341iCzrBy09i6uo22?=
 =?us-ascii?Q?QXcSr/VQLih8M2jSw3Q94EaX4RHLrqm000ZkchMmEEZcWFZLz+qu+yqA0add?=
 =?us-ascii?Q?UeJhSMZ/TkvZkGskL+akQepHqejF1+VhlzvzroYM2MpYp3h5c4jCk5XwyGqB?=
 =?us-ascii?Q?YgVCobE3VxBxRFGYCbqUovvveG/NfQBdQxfd+GbNBSzJuSayEMMXWzhvc09g?=
 =?us-ascii?Q?GSI5Fh4w8D9qYRWgvlTEicZiwthxcBMak51HSHo8HGwvR3Bh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff809c53-62c4-4db0-dd14-08da0d913874
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 12:24:19.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXr+aV4sq53n0Ioyce42zcWPywoAzTrGIYMvK2BMoNHxqNyEIldBVLOlF6RUlhIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Thursday, March 24, 2022 2:02 PM
> To: Jason Wang <jasowang@redhat.com>
> Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; vir=
tualization <virtualization@lists.linux-foundation.org>; linux-
> kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
>=20
> On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> w=
rote:
> > > > > >
> > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > >
> > > > > > > Yes, there will be no "infinite" loop, but since the loop is =
triggered
> > > > > > > by userspace. It looks to me it will delay the flush/drain of=
 the
> > > > > > > workqueue forever which is still suboptimal.
> > > > > >
> > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > >
> > > > > > Given the "forever", I am inclined to not running faster, hehe,=
 though
> > > > > > another cobble is to add another line in the loop checking if m=
vdev is
> > > > > > unregistered, and for example make mvdev->cvq unready before de=
stroying
> > > > > > workqueue.
> > > > > >
> > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, str=
uct vdpa_device *dev)
> > > > > > {
> > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev =3D container_of(v_mde=
v, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > >         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(dev);
> > > > > >         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev)=
;
> > > > > >
> > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > >         destroy_workqueue(mvdev->wq);
> > > > > >         _vdpa_unregister_device(dev);
> > > > > >         mgtdev->ndev =3D NULL;
> > > > > > }
> > > > > >
> > > > >
> > > > > Yes, so we had
> > > > >
> > > > > 1) using a quota for re-requeue
> > > > > 2) using something like
> > > > >
> > > > > while (READ_ONCE(cvq->ready)) {
> > > > >         ...
> > > > >         cond_resched();
> > > > > }
> > > > >
> > > > > There should not be too much difference except we need to use
> > > > > cancel_work_sync() instead of flush_work for 1).
> > > > >
> > > > > I would keep the code as is but if you stick I can change.
> > > >
> > > > No Sir I would not - I am simply not a fan of work requeue.
> > > >
> > > > Hillf
> > >
> > > I think I agree - requeue adds latency spikes under heavy load -
> > > unfortunately, not measured by netperf but still important
> > > for latency sensitive workloads. Checking a flag is cheaper.
> >
> > Just spot another possible issue.
> >
> > The workqueue will be used by another work to update the carrier
> > (event_handler()). Using cond_resched() may still have unfair issue
> > which blocks the carrier update for infinite time,
>=20
> Then would you please specify the reason why mvdev->wq is single
> threaded? Given requeue, the serialization of the two works is not
> strong. Otherwise unbound WQ that can process works in parallel is
> a cure to the unfairness above.
>=20

I think the proposed patch can still be used with quota equal to one.
That would guarantee fairness.
This is not performance critical and a single workqueue should be enough.

> Thanks
> Hillf
