Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC84E8BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiC1CCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:02:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAC50079;
        Sun, 27 Mar 2022 19:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UllOAHNXh8cp5EN4SReO4g6+rN7TPGCzbc6UxQ2UQkHIO+GsWTU9VmaRED5BOuASD0hZ8Ac3jJ2z48LV300VjNXUYNk4v0/dP5/YO18BLAcA62SSy0ofaCqxvx34RPiFroBB8dA0sD4IaO7Vv/PnFNdb/tQ6rhwocjPK1pvejXa6vItrhKl/hPT/ueEiscHJOl9ts1Jo/GNDz7PTnxrfxmYlvnzJWFs8wvMyOSC1S3VJ4IYA+n+dQH2zAPe3RkXayQk0JhaLmUZAUAJ3sYJ9MBhTS1Y0MK3WYJLvoqJHisGuwM3auTHShSaLBop1hWXPAdR6SQOtkz4BqnHzVcZovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAziCvgS1lu0P4XrvZbwQxrZhSB5RM9UFC/scaj5oKI=;
 b=gfxgmoW66YVfSo2/t3adS+BFlZ5t6ZsOXtw6NV+9xUIj1ywMlb7n250o+psShloMCmIjed7l7Aou78VJ+PHdnFV/rzp+aPsfsec2mMx2qTS6Er0D3V/JuhNCWjs7I9j4oD7WXpNurNyxL11mDADJHEmjGcImnSaHSTxCeLRE/12MlA9CDT+12V59BGISTSPDRDNcqBWpGcZFcxr/yZhVUxEM2XcRZQmVzlYe2GIbWOCnMp8iyJ+1RKElio+l7mTK+EB4zgnwxlVPuRNB/curZ7hY6wv/5Rr0/0/r+98YaysPmGSD6LhEietNp1P61TB4Npjv028uFgJdTYA8MbbFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAziCvgS1lu0P4XrvZbwQxrZhSB5RM9UFC/scaj5oKI=;
 b=LSXFY0vDx8DGodh8mItxyz7PO7k5XquUKbF0I8OKF5hUcyD6mG73NDKrR7QeUyfO7GPoLhV6t0k4nUPP4AZb1T9MLFhsb9VjTK4u5RqWloLTOMD29N55v7HVpI5RMS3aJjYpnspPDhhw9LRhRhDipXKbQrx8XToxiaUpV4evoWE=
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22)
 by DB7PR04MB4954.eurprd04.prod.outlook.com (2603:10a6:10:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 02:00:30 +0000
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb]) by PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb%8]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 02:00:30 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove state checking before changing
 state
Thread-Topic: [PATCH] remoteproc: core: Remove state checking before changing
 state
Thread-Index: AdhCR5iiww5OTsKBQo2cZWS0KqdY4Q==
Date:   Mon, 28 Mar 2022 02:00:30 +0000
Message-ID: <PAXPR04MB908967BF3EE535F7F5C6377EE31D9@PAXPR04MB9089.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed9ef0c2-f639-45c2-0149-08da105ebcd3
x-ms-traffictypediagnostic: DB7PR04MB4954:EE_
x-microsoft-antispam-prvs: <DB7PR04MB49544148BE76273745789EADE31D9@DB7PR04MB4954.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ltJdYpoQaxt783oEQXrY3hEaXW05iwX8ObqS+6m+k6yYO0v9osIKnOxXTx2ySGkZMC/8Rohia2mrqdTshIth2zTqzgMDbYGrdKMGyLkbWw00EBoXtiDX4i35kis6TyggJBTh68z8367eyEF1WHJ+DAmFtRn0BKOxJzyh6b/rka8ohgkRuevIlsn8oADB3jLOpPSKfikxXh4rhTI7tCH0FROtRG1an14Bb1DIJsrVlq/uUtoLnRdAmwAEIboxtSvZY31UTvJTiInPK2KhM/aVOTHEYB9StzpczYlkuYiGAMvPWzU1B6DFwXOFLfJQArRRTScngIpECZBu0xcUpJlWj7xRJ+KSqAdx1raY06LnUSE2Stt7Fn2WGYt9ymFFXsCKK4XE3HKjJcx0LIFmv0lL0yEQxpbJ+q6rbQkrRa6JCHmtDTYoeeVkSf/EEjZhIIoBvbtNs5YcWFV4Wlw5iL/jT4x6/JnwzY5KYEIuR4GasRBfwkn5Qb5jfL4qUFDb6JO4BseyUmzStJHlBtsltgzjDVEYI6oLR1TrPv2ddg2SiyMDIE9s5XP4C9viTK3FKEowjFBTi1U66FE9bcFyfL0xgVkumVpDamrceRrIamDUzqpySDnsRDMNquyRk+aFMwsjEbrsi5Q4xHtWldddslS27Ry/DrILO3n5kNMly5MnCYKP0Djd0bDatyWp0k6S5xKK86PVY6+RKyGrAAA5hUP8EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(52536014)(8676002)(2906002)(66556008)(64756008)(76116006)(66476007)(66946007)(4326008)(71200400001)(8936002)(7696005)(186003)(26005)(55016003)(66446008)(6506007)(38100700002)(38070700005)(9686003)(86362001)(5660300002)(33656002)(6916009)(54906003)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6zo9QKPQkWClWVJEuN6UTv7xe/wqsLoWEDaEGuNGj/8uxqLZ9673Ei6vSZTn?=
 =?us-ascii?Q?MIiPYOg03XPH4RJK0uKyFZmjhL/lkIiFTRVSuBWrMmZZrnRWzoR63m8RMoGa?=
 =?us-ascii?Q?TskgVRw3krUAAL0xjkSfnnxsJr7s5XQgcr3H7dWdDF1SiwcfS8gXsRsDDChi?=
 =?us-ascii?Q?ZX3QlblWr3pbxFIY/RP1hSzkhfoVjKyLPvumGEBVcX5bcH8WPh3FZ9yG8Gbw?=
 =?us-ascii?Q?3HIiuYQ6Eb7xBv/QdJ29CZaDH2fwqWvLWiebx7neLrONhBh2xklJKRcxY+/K?=
 =?us-ascii?Q?YpT8ej3q2vYZ9TCF7fNYPU62eWsh47K9RApRbR+SYLr0cPlgHe1EpOZzePig?=
 =?us-ascii?Q?m0oD15HWLesEUIjpOkwTtz+2s774dSQKDIC8/uQ5GnBlGbFx+yIUfjw5BhID?=
 =?us-ascii?Q?+E6qrcI6XZF/BXhN4Zq5LMjSrLY5kvjdTkUTfkVN1BAeOzfF6VOENzcVQKTp?=
 =?us-ascii?Q?gQJscn5OGe0xafML1bkgQIyqe2OyIBNDPmPdDAZSTpusl/1XqjmCxkL0Gwrh?=
 =?us-ascii?Q?n7uoSZ3mAVJM06HzF9KLTDqoI3qC5HuUrsaU8fQSbTLBZ/qucDjRtwlCZSol?=
 =?us-ascii?Q?1vSSsB5BzZPmSycyluuuRLSvPE1NrCZti/JFJamDr9dyjdthkF9lcu38VCPb?=
 =?us-ascii?Q?MiwTr6TVFOPRkWYg6R6Jea5p9Zpmrq6lDMuV4Rp1CJ5pCyJO14fSbDPFcL4M?=
 =?us-ascii?Q?Y36XsNagK1X8rDS/qmbYMI9XHDlDG46TJKLMXncDihVZp6ZZVyQTNmW+Rdhq?=
 =?us-ascii?Q?YXScnTu7n4CXRW6/JrqzpfxZ/oz7dOA+nU0TkGKMr2pZtdgJYVM/C71GEXvx?=
 =?us-ascii?Q?yYz8BpZ95rzUJzO5t2D7ykHPCrL5/0cSu42552ktzImVSGVB7aT07GYL5d5z?=
 =?us-ascii?Q?CftPwix9/XRcz0Rr0s3M/HXRf1kPhtH5rmaRucgcDzy9yuYbDb5FTOw0f/29?=
 =?us-ascii?Q?R7e81aM/V8P7Tf4nKcftxFNPicSVUyBN4pJrQVJfOTQSFBSKCLXgoBurBkmM?=
 =?us-ascii?Q?GT2lfsDiN81yWvwtj+1EAG9IUk/IoBJvfdQmHkz4DLv7FzHzJcwLma8ZWw2y?=
 =?us-ascii?Q?5/kYEAvKu3a0Gh3l9ApU4UkMC8smq5/2x8h82kk74MwIwETavpDS4zrPX/VR?=
 =?us-ascii?Q?MtdmrnApS5VUbF3qjBi+mw915V38fI5HYBcaFQLTrgBSITQjzANtgvIrCQES?=
 =?us-ascii?Q?2eLSycz6RGCwdix5JMY15R9L0zf72iOcXEExBneC0ctNCQXsuvd2d6c2qoq9?=
 =?us-ascii?Q?D8xPNS8kbZjP/nw092k8mrgVzC4VQdGRoXkxmwVTwvFAY4O5CROrErGZYI0a?=
 =?us-ascii?Q?1s3QHnJB7khvGDBf9+3p6Gv9Q+0Tq/LHs9zj8Gzq2/AswQH4p8F8aYcSiOLj?=
 =?us-ascii?Q?dLhwkDgbQn1UQxTrtkkMtgCFa7ItreGYpFLxqDcDNgFtuqmb2yXWZAYDwkHh?=
 =?us-ascii?Q?R3RcPUY4+pv5+evko5a2OL2AbbNYWyNgbOCwPVt3zc20qI6jQJXiKggh3Enz?=
 =?us-ascii?Q?7oBrfgNg2yqGWlMAcst5jxd8ddpiFfc1v3aUbqF+pi096h0wYitj4FyTmBYC?=
 =?us-ascii?Q?4MSdlavIIpWqyrpxcj++Qf7Ns8HA1YGLIH5afaAtMF0YQJEBQJsf5hiQunKg?=
 =?us-ascii?Q?FAqH2jLGos9uUIkGFdhAv/K0q6NKdlCu4J7i+g2FEZ36WCFrbnDY2JZa4wzi?=
 =?us-ascii?Q?NcT5+UdQcEL+s1hoJwgQVBziHw0+g3tj+er73s0vQ+CccGlTcoX35UQ+R//n?=
 =?us-ascii?Q?p776ZjRmqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9ef0c2-f639-45c2-0149-08da105ebcd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 02:00:30.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVzL2drKGM7AyQbgI6kTbTxPdBjbY3XCj7eCm1mQjr24lse5MNIkjx1CTsCTMFSsHY95PYLPiP34bYx0MBCRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > > >
> > > > There is no mutex protecting of these state checking, which can't
> > > > garantee there is no another instance is trying to do same operatio=
n.
> > > >
> > > > The reference counter rproc->power is used to manage state
> > > > changing and there is mutex protection in each operation function
> > > > for multi instance case.
> > > >
> > > > So remove this state checking in rproc_cdev_write() and
> > > > state_store(), just let reference counter rproc->power to manage th=
e
> behaviors.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  drivers/remoteproc/remoteproc_cdev.c  | 11 -----------
> > > > drivers/remoteproc/remoteproc_sysfs.c | 11 -----------
> > > >  2 files changed, 22 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_cdev.c
> > > > b/drivers/remoteproc/remoteproc_cdev.c
> > > > index 906ff3c4dfdd..687f205fd70a 100644
> > > > --- a/drivers/remoteproc/remoteproc_cdev.c
> > > > +++ b/drivers/remoteproc/remoteproc_cdev.c
> > > > @@ -32,21 +32,10 @@ static ssize_t rproc_cdev_write(struct file
> > > > *filp,
> > > const char __user *buf, size_
> > > >                 return -EFAULT;
> > > >
> > > >         if (!strncmp(cmd, "start", len)) {
> > > > -               if (rproc->state =3D=3D RPROC_RUNNING ||
> > > > -                   rproc->state =3D=3D RPROC_ATTACHED)
> > > > -                       return -EBUSY;
> > > > -
> > > >                 ret =3D rproc_boot(rproc);
> > > >         } else if (!strncmp(cmd, "stop", len)) {
> > > > -               if (rproc->state !=3D RPROC_RUNNING &&
> > > > -                   rproc->state !=3D RPROC_ATTACHED)
> > > > -                       return -EINVAL;
> > > > -
> > > >                 ret =3D rproc_shutdown(rproc);
> > > >         } else if (!strncmp(cmd, "detach", len)) {
> > > > -               if (rproc->state !=3D RPROC_ATTACHED)
> > > > -                       return -EINVAL;
> > > > -
> > > >                 ret =3D rproc_detach(rproc);
> > > >         } else {
> > > >                 dev_err(&rproc->dev, "Unrecognized option\n");
> > > > diff --git a/drivers/remoteproc/remoteproc_sysfs.c
> > > > b/drivers/remoteproc/remoteproc_sysfs.c
> > > > index 51a04bc6ba7a..8c7ea8922638 100644
> > > > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > > > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > > > @@ -194,23 +194,12 @@ static ssize_t state_store(struct device *dev=
,
> > > >         int ret =3D 0;
> > > >
> > > >         if (sysfs_streq(buf, "start")) {
> > > > -               if (rproc->state =3D=3D RPROC_RUNNING ||
> > > > -                   rproc->state =3D=3D RPROC_ATTACHED)
> > > > -                       return -EBUSY;
> > > > -
> > >
> > > As per my previous comment the above conditions need to be moved
> > > into rproc_boot().
> > >
> > > >                 ret =3D rproc_boot(rproc);
> > > >                 if (ret)
> > > >                         dev_err(&rproc->dev, "Boot failed: %d\n", r=
et);
> > > >         } else if (sysfs_streq(buf, "stop")) {
> > > > -               if (rproc->state !=3D RPROC_RUNNING &&
> > > > -                   rproc->state !=3D RPROC_ATTACHED)
> > > > -                       return -EINVAL;
> > > > -
> > > >                 ret =3D rproc_shutdown(rproc);
> > > >         } else if (sysfs_streq(buf, "detach")) {
> > > > -               if (rproc->state !=3D RPROC_ATTACHED)
> > > > -                       return -EINVAL;
> > > > -
> > >
> > > This patch should have been part of a patch series with your other
> > > work sent on March 18th[1].
> > >
> > > Thanks,
> > > Mathieu
> > >
> > > [1]. [PATCH] remoteproc: core: check rproc->power value before
> > > decreasing it
> > >
> >
> > Thanks for the comments.
> > I still have one question, if there are two instances independently to =
'start'
> > 'stop' remoteproc, for example:
> >
> > Instance1: echo start > /sys/class/remoteproc/remoteproc0/state
> > Instance2: echo start > /sys/class/remoteproc/remoteproc0/state
> >
> > ...
> >
> > Instance2: echo stop > /sys/class/remoteproc/remoteproc0/state
> > ...
> > Instance1: echo stop > /sys/class/remoteproc/remoteproc0/state
> >
> > When instance2 'stop' the remoteproc, then instance1 will be impacted
> > for It still needs the service from remoteproc.
> >
> > That's why I just removed of the checking state, didn't move them to
> > rproc_boot()/rproc_shutdown()/rproc_detach(). And in order to utilize
> > the reference counter (rproc->power) to handle the multi-instance case.
>=20
> Thanks for the exta information, now I understand the problem.  The above
> should be part of the changelog.
>=20
> There are two problems here:
>=20
> 1) Dealing with race conditions when checking the state of a remote
> processor.
> 2) Properly dealing with the remote processor's reference count.
>=20
> For the first one, state checks control the remote processor state machin=
e
> and can't simply be removed.  They have to be brought inside the mutex lo=
ck
> in order to avoid race conditions when multiple users interact with the
> remote processor.
>=20
> For the second one, moving the rproc->state checks inside the mutex lock =
in
> rproc_shutdown() and rproc_detach() will work with the rproc->power check=
.
>=20
> The problem is with rproc_boot().  For (at least) two years now we have l=
ost
> the capability to increase the rproc->power reference count from sysfs an=
d
> the cdev interface due to the rproc-state checks in state_store() and
> rproc_cdev_write().  I think that should be corrected but it will introdu=
ce a
> user space visible change, which needs to be treated carefully.
>=20
> With the above in mind, please send a patchset that includes one patch th=
at
> removes the rproc->state checks from the "start" command in state_store()
> and rproc_cdev_write().  The other patch should move the rproc->state
> checks for the "stop" and "detach" command inside rproc_shutdown() and
> rproc_detach().
>=20
> With that we can start a discussion on the best way to proceed.
>=20

Ok, thanks,  will send the patches.

Best regards
Wang Shengjiu
