Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB901460F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhK2H2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:28:05 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:51456
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236485AbhK2H0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:26:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQRwXPGPq8fKGoRjHfHxuriZY9FIm+Xp9R2YEzdyy1F9NMRwKtiTswLZ6SEuB4dzCrz79pSkFnsw+vw1cMHO2txp6AuDpt+X3nfNBj/2AIqAq60RFVD9wtdZJ1yNCPi6kIYbMf9p895ZIQiDdkJr4EdTosVrvOQDC6r4owSbogNaz6NXEiE54eOEGcMFZ+uj/18DBSWmBTBqVjRUHzdTi8ytMrAG5/vQEbDgdk+//HwVRW+n1i0YZLjjTjJ8VcJuzAU0DSvodT8cibBLOzByvSzB8/QSfbUJcbUXlS77umgO2T+ZUVfRcDsaLBS+R7bWp50ohYJnpENV62IrbK9pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niIeq+HGw9zVMYr+C1jJzJMyiOqxJdyp0NqePIHky7E=;
 b=LZlJKVGuaDqP8nONUzfrt/CtOBBuyaLqAjVBuGjZazAkSUyOTDln8ARzQn2ItVfBNjfbiAQtTnBbKLj3XZigxECRqP4atjiYreJGQiNci8nYwrOYrfOrn82ced9uHmhCSUsE6/9ZTpgCbtiGmvf/NYQXaiBVwSiARuEfES0NKkMBy9GvR5ejoHssB3zz37+g5EAAcgmxnmgY8pSCdF1/9U140MVQ1YMJWjA0m9TDw6MDZ+MeCj8ZqsCpIy4tpPuqstuSOkIyrF46XBZyTqbVV25J2rxHEHkN9jv5YXNpRnWQZqg3qq55I1JoDE9mWqpMkwKErHQrxPmCdwGOJn5QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niIeq+HGw9zVMYr+C1jJzJMyiOqxJdyp0NqePIHky7E=;
 b=uiC/3zO0tc1xr6mRj6JAtPY1w/juh+gA+l+DRBdN20apYB9zyIjZwSg6iVgOD+RW/1NjHmDsW4/GKYbvxwB0FCDBgr38r5kVdseK30ooHeXURjjGw+6BPLvbS8NGZat+Ajl6GDzVSmqz/IWftI3kuM5SsZvwUupFwwtA9RZCMCeJEDEefj+BCXZSu4Q9RAx1SflLbTW1IgofjUA39om/olnpmg9z0pIo9URrL/EqdkJQa44FH32vlHTec+ozEj8WxS1KFjKCPyuQnGmzdU0sFQSma2AUf21T1GYp/Cro6DVHbuHd6uWK/sAULTIUc+TvfAMjTHyeSgyYuM6IwnCZJA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 07:22:45 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:22:45 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Eli Cohen <elic@nvidia.com>
CC:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        mst <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: RE: [PATCH] vdpa: Consider device id larger than 31
Thread-Topic: [PATCH] vdpa: Consider device id larger than 31
Thread-Index: AQHX4iei4AN/DYjfJ06NNm/PSUxsSawVG8sAgANvF4CAAY3pAIAABevA
Date:   Mon, 29 Nov 2021 07:22:45 +0000
Message-ID: <PH0PR12MB54813A22AA1240EE5EBEE48ADC669@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211125180915.649652-1-parav@nvidia.com>
 <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
 <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
 <20211129065846.GN18178@kadam>
In-Reply-To: <20211129065846.GN18178@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1191c90a-f63a-4904-9861-08d9b30909ee
x-ms-traffictypediagnostic: PH0PR12MB5499:
x-microsoft-antispam-prvs: <PH0PR12MB5499CEE865DE3E6D920B423DDC669@PH0PR12MB5499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUUyb1MPvVPWFtKoIgbuHFB5FwynsCpscpMA5hml8keaO78jx6n10DqO/gJm5gx8tk7WDuzY+FPucNyJWWTC/FgNP8pyTH+fOlFusADNck4ZuXNXfPrD5WMOQMeey2SC8fdAn6Nk/15sVazTV/XwlgSOJO6h13ynYP977nABwN+MqOWRDaWxGUpus2k3uAPy1VoMeadjfbBbsHSKqyvWT1mWeip/+eS+3hUjij40KUxOmJhgfWzEnEiuk9m1E/5vEgURc2MFdosWFf3F1Y1r8ZuKfD86CcbQ0lLo7FAsCXm7h239CspEb1lNudS/hunyHyHA3m6XIrGtRuf0admh6koL4OOiQg9g5fVVGpSqxxUaBAEvEJHzurWUKyKbtg+ZNCq+GAjC1nb9hcQ4VVag8teEZfRO2Pu4pLYqHj9sVnExcTsygwSww4AAOVlcCdz3IfElTeYOEggkeXKUp8V5Gu3EoTHxV0GYnEzDdi+/N3K5GocCXPTqc+x8nEauCQvvVxCf1W7rzDMgFkWuYU0+FUOavx2nv40gbvwWoZ4kY2p7m+0hUXG5x3AQ9puXNVNmqe+ovy+2NBP8L9Pb/SGzS3k3NWaNWnpqiHzFWj3DQxYDq4zHMXSLxU252TeOx8F5jJKGCAtot96jqcNdhoQHfYD3RXbC7Ds87gUEKWyBPYAIHRnfXvNDvVb0TWRz0gdelUypP56ZId4c5Ujtewkszg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(8936002)(86362001)(5660300002)(52536014)(110136005)(33656002)(53546011)(6506007)(38070700005)(38100700002)(71200400001)(8676002)(55016003)(508600001)(122000001)(6636002)(186003)(316002)(66476007)(64756008)(66556008)(9686003)(66446008)(83380400001)(2906002)(4326008)(26005)(54906003)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0BSVg95a/FO/zqEm/Z3sTRaXbKEG5izqMMxO+QRi1V0swQYcVlIzhNpGLMS1?=
 =?us-ascii?Q?6Mptf+qzZOwbbWZ5sJ6vVcHcWyentnmf99xjqYHND8riZa/34TsaeqInc9sW?=
 =?us-ascii?Q?DxpoKHTj+foyCatQSUdHm0TZf35Tvhi56wk28ZqN9zlObL1Nm3CwG1F/kLf1?=
 =?us-ascii?Q?6KcVGvyMbDZtMZhPKYPLefLH6LxS5wP+Bt5qJZQhKTzMhS2y290hB8yHhOro?=
 =?us-ascii?Q?7vdV3MFJINHUXMqF8w6A9tnvYVBv/fkliYMn8aETgPw60zc9UWtIidJF0tvk?=
 =?us-ascii?Q?kmO6DDahta5DE5rwvQlDNhyOygTsYZn2aKahzY376u8I2OyzwAhxPvFH1f/Q?=
 =?us-ascii?Q?Vyx1BaW5FEeJhwumSZD3pqJAutRRPnxQPM1kKwJ5CeZQonZqb2oQtpRr1kfW?=
 =?us-ascii?Q?CH3foungw7Vjz3NrT8esQ437kf5TpWydoFVyvVmQkk84DMFbdMIBKT5qkPMA?=
 =?us-ascii?Q?MRrhf3n35UfNri7cVVM/UUBcSIGCs3yAmpfsf8lJflv0uvj2amPpgkUtl3TK?=
 =?us-ascii?Q?e6LmdrRaps3vFLFXrZ5gE1gCeNdbS3yzqNTy1IT3rjrmux88ZtYJF7+RX86X?=
 =?us-ascii?Q?tRcEHgsyztM1sBYYXKAxKjLh9D+MnGhuPXYiMX21/xRdh1+gfJnAAGaWecGR?=
 =?us-ascii?Q?RDqi4jlAG+P68M8z1KSEhllD5T0m9zkI/E3qHygxr/ouNsoVfTWhxTyIh54A?=
 =?us-ascii?Q?BLOwI6Hwny5fGp2tzT2LtfHwdfWuI+AtTG0Th1K01iCbD/rKYIty2hLuVv4u?=
 =?us-ascii?Q?GtR4yAL1dskprwG/i/x6/5RfG1LesQ1e2vK2mLIZn5zJKlb0S5FSiVRXYe/N?=
 =?us-ascii?Q?OqWryA1ApdkawgcCz5s1bz1+F7XjvkpgjzSabP2KBFfU9JZVuXyEBWVY4ZHM?=
 =?us-ascii?Q?Ndu9p6qMVlab8jcFE8JhXQtXxp6hHx8XaHk+t3XRdMgEm6oZtJICEfiy2K7A?=
 =?us-ascii?Q?Krnn08L1zZkeSUlu49JF94Ibm/uaE/R7dCqEKfwFDwzCVq9bczHGZTp/Cqsb?=
 =?us-ascii?Q?eQ6hUjl/9EtVJtP9Z0gjizF8nmzYNg0/rw7oPtvACch1jBk7QCkgF0frC483?=
 =?us-ascii?Q?YIVqJkGVIH3smyBmLgNLE/yKSy7nrvRiOSD10i4Ga03qJkxQis1uSD2RuwrW?=
 =?us-ascii?Q?/0zht1QbnEQ04U2zdn+wim6aWZMOJsV0DkBy+HnJ+Rgd1bpGBSUlLxC4Kz75?=
 =?us-ascii?Q?77daCdbYY/zVimaA3eiKzc2pUakenYNiQ0dNGp0pyZoAI4xBU+2WWwux5scn?=
 =?us-ascii?Q?6UyD7ZubPfD2UJFrJQ+Z2NKhXjHgmpFFLz7O18zI/Wu3vH7s5AxJ+83apW86?=
 =?us-ascii?Q?ClkHlJpZpBHltrVHxq+kftwsnbGGrp5F/IrKEUtBu02deQ2N1oEMcyYerP//?=
 =?us-ascii?Q?hBVdPYfR+XochcAQP6wytQPrQC879JLNov8yKxWo/1BXEBK1Pe74VvkkMEKT?=
 =?us-ascii?Q?xNFvYm9uCdyGNraYUmrAB8qwVZXQe/zYn/DP/6ByOXhcblVgNqxfut8f630r?=
 =?us-ascii?Q?2fP2aFYPVKNyOXdoQrqSRENjA60Bvhqc1NzbrpUpNuT+ysyJvpzEUeawT3Z+?=
 =?us-ascii?Q?ogpzO5SHLPMl7rqTal3mEA2Y1pAE/a+Xx+nUW5tYFQVCray8zg+3t5z14gNW?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1191c90a-f63a-4904-9861-08d9b30909ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 07:22:45.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRqZJ560FiYjHG6iFBhX3EeBFdY3QsJvJXShaTG3A7XgD/wK7VSugbcXHm29ZiEdUW8cyKAcgN3RWLL2pjkmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, November 29, 2021 12:29 PM
>=20
> On Sun, Nov 28, 2021 at 09:14:35AM +0200, Eli Cohen wrote:
> > On Fri, Nov 26, 2021 at 10:48:12AM +0800, Jason Wang wrote:
> > > On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote=
:
> > > >
> > > > virtio device id value can be more than 31. Hence, use BIT_ULL in
> > > > assignment.
> > > >
> > > > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a
> > > > netlink interface")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > > ---
> > > >  drivers/vdpa/vdpa.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > > > 7332a74a4b00..e91c71aeeddf 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct
> vdpa_mgmt_dev *mdev, struct sk_buff *m
> > > >                 goto msg_err;
> > > >
> > > >         while (mdev->id_table[i].device) {
> > > > -               supported_classes |=3D BIT(mdev->id_table[i].device=
);
> > > > +               supported_classes |=3D
> > > > + BIT_ULL(mdev->id_table[i].device);
> > > >                 i++;
> > > >         }
> > > >
> >
> > type of mdev->id_table[i].device is __u32 so in theory you're limited
> > to device ID's up to 63.
>=20
> A u32 can fit numbers up to 4 million?  These .device numbers are normall=
y
> hardcoded defines listed in usr/include/linux/virtio_ids.h
>=20
> But sometimes they're not like in vp_modern_probe() which does:
>=20
> 	mdev->id.device =3D pci_dev->device - 0x1040;
>=20
> I don't know if an assert is really worth it, considering how almost all =
of them
> are hardcoded.  Also if we do want an assert maybe there is a better plac=
e to
> put it?
I am changing above fix to report device id only upto 63.
Others higher values (which are not part of the current spec) will be ignor=
ed.
There is no need for assert for any undefined value anyway.
