Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B274D47398E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbhLNAb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:31:28 -0500
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com ([104.47.51.41]:6244
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240612AbhLNAb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:31:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjXtuLhEAKTDLL71U8BqAVgm8zTAscAFBEXzHqf8+gMx8caRg601GO719OEvS/j4Qc4IhjXvgVJQ1tcpFVP2F895jxzVHp0Wb3zIowJWXDzIvlWN0qyxTD9CW5H+JGMmb/xfVc9W+HVX3p/GXoLkATN+fQAObW4bz+U/JdlFTShXD0t0yLh7clB7pYhbgw1sVFwBFWa++IKr/8nKqO5WjLOS92iG+jwDM+4gUc8O2s/YvtV25zqBESGSlIgr+CMM1H297zPJiu1lD+6VEHi3DPL5Z/nyapLzPUxr2DN0i3ZxoSS9XJSHyMu5q1or8RRnhD7o2QbqwnwQXAQxl14Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgVpWXDY3ibO9Uo4GdgBKAAZ8Q3CGefvZby/grprUAk=;
 b=Of7cgMuhSgrhiDbAEKNrhzVdbpJvCtDoqFAjX6vHGMqQTAkZCDwR6TgiElmNV2m00Gsqo2Mvd1pByfVccwlE87kk6y4iC+iqj+po0x0sOcjN2MxeLBZWSw9FvxTCd2HeU3NU3eEtvqQjzd0bNNesCPGpmsazS7iqfZdl7HlxmCSdZQysaiLdTrRl4SeOAWncC6icM2MTfrJ+TcJRJMMO9RAZVL1MGIS5f6Ex8HGsy6qx5Rp007W7s9cYt5GrfM1whrccmSG7e0RxJy7p3SYNhfq1t3Gn1430PvOVJshX1YtvqEzCyLmhHoGLTwz6BO+CwBlAQo+mm/KZCz7qBUB0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgVpWXDY3ibO9Uo4GdgBKAAZ8Q3CGefvZby/grprUAk=;
 b=HFklkwueUBy1pyysz/CcCJmrqn+EPfFs2hI4MecpIvQiRaXvE/lzYyPc6LAUKghvN6KEXK+1v4h+bSP9oAxnxMEWfHsfx5HDShmRD/gKh72IMtYJqolJtDGRp2BISf2Mh0sJQpArxldoE3xi4cYyQXongiOn4y7eUXUAjreCY/A=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by SJ0PR21MB2015.namprd21.prod.outlook.com (2603:10b6:a03:2aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.6; Tue, 14 Dec
 2021 00:31:23 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Tue, 14 Dec 2021
 00:31:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, 'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TAAAIttYAAAhJ/YABlPzcAAAFj94AAB4PEgAAi6P2w
Date:   Tue, 14 Dec 2021 00:31:23 +0000
Message-ID: <BYAPR21MB12706DCD5ED9FC7AB3EE2EEABF759@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Yba8nL4x9R6rmTYL@T590>
 <BYAPR21MB127006555030F7BFA47FDAABBF749@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Ybb4X00rfsjRgHj7@T590>
In-Reply-To: <Ybb4X00rfsjRgHj7@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fcf8be3e-e42d-4052-ac2c-878bc830bd6b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-14T00:17:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c260d96-1968-48c3-d917-08d9be990e91
x-ms-traffictypediagnostic: SJ0PR21MB2015:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB20159CB4F7C07F920DC06E26BF759@SJ0PR21MB2015.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ye9CT1NtIyF8vSlqkHmi7QJw+aVgHI1xGOe/cuBUtyVEK1VtGAKbxanaGa9RQwKqIn1CACepJm0A94D8snvLSYY7kGqtycjh5yGTU9KqZPqM15zCcZdklPwukzO/MNnaLw5fms9tQpB9xN+Hs4tpz58TAzyOKp2JPibI8++FYZhyCDZaMSRW01hvCg9MFGdjfhaut+dpPAtLZwiuIoIbJLAyOxJBL17L3Xq21g78jdcs+mUOc1u0AkpkrttvKlg5FzAZDzt3gY1lKysKbXqbaIw0R4x3MtZySQ5JyLB41OD7Rllb+Pg+etRRfFsoX0LmkwOl3nm/COGjJV/nrF7Q1WH0Tz8RVQGywZcHJFPitevgRMRobX4QLoAxycKjmEgdSdoQ0zKCMnpv2kNf5yQbZFm1Ii2dOVaHuh2fZktTlEl53huocSAqS+pDGJkCVaGV0MfoBJwALCDNOh/dP8A9kW1cT1l/if8O3PhzENmCMummVLzwVYRvSDVAC+Jjs5FlYroPJ7Ye3ktECr7gK2SG3cVr59262rdI2MFZhs+zAAnoJdUbNKT9KAtonCB/prZiJNcuViIIJeT/n71eF+q7dwE2HJ+RNn8/2E7QldjUPT9c6jZut8yU/5dJ/VK0pgn8iz6u87CV4H3SBtio0MP99FvcLSgQJVzua0Hnqd5dFgRUDIZ9p8/psuzCmR/1npIbWibY0i4xOlStRn2X8HmoC9Ba7QJh5fFUJ2cwJr5vtwc/lcMV3fGR63PWGnxkPRC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(186003)(6506007)(71200400001)(26005)(8676002)(9686003)(66946007)(54906003)(66476007)(4326008)(66556008)(64756008)(6916009)(66446008)(316002)(83380400001)(8936002)(55016003)(82950400001)(38070700005)(2906002)(52536014)(82960400001)(10290500003)(508600001)(5660300002)(8990500004)(33656002)(86362001)(76116006)(122000001)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l5auoUF5AO6Emi16iw5LHmmYkKXCyktpfz8MmWD6xyA/hSGc8XGeofMG+4X9?=
 =?us-ascii?Q?kERnmij9bWNH6bdWCkkKEIemgoJmhNI0XIuk3sBolnevZqZuhCH0AlBkjCqa?=
 =?us-ascii?Q?br63q0tmpXSfQRdhd6s5ZtGZ1UYDlBZ2aa/Xhv8oQms4lXkmBDRONNDJywto?=
 =?us-ascii?Q?ZSAYyqo9rhzudHcOuJFXOYUMS4poJjO9AKZQpVqTU+AaFykTUOuLCkPtflpI?=
 =?us-ascii?Q?AMg60tQnyme1lHtb/+VaYgs9+RyX8I2wMgaSH0vyuKxh2yuLMWVBthF4FWnZ?=
 =?us-ascii?Q?wBQ4f6r6N/Yk8yldrClWzmqZHYm+c42226hXRdqIPcaMsRjrBn+Oz0K8ioBD?=
 =?us-ascii?Q?hMJqM0j6vyV0h7F0s9AL0nkJfgm1WxFGYeF2G7rKYFfc70lTmMvw2SwAapPY?=
 =?us-ascii?Q?pyyBPlt0UeeDgDDus/hn25sy3GP3f32owIMFq0xH56JHs7dfLY0c9nEM7OrP?=
 =?us-ascii?Q?QEL2cp/k7HXEaLaHEOnE9JZ+ii/5wIDc8xQu3XFhoaayr9Xkt8zZ5amnyD81?=
 =?us-ascii?Q?7xWL9wcOotmPyAoZeuhTSaBEYAHZ2QFo1K/vAcA20k5MRv1UxZEc/QEa27Bl?=
 =?us-ascii?Q?ha9SZ5dmFkYVGZ3K8clM9CWlfd5LZhusZ64CFIkLZpPEJDB/vLJLsXvYCgZ7?=
 =?us-ascii?Q?OkOkSBMtGuYOuJ4P+SyBICNnnyz1q/0crnOK6EfhhEd5XnwZ88qYJLHWsVc4?=
 =?us-ascii?Q?VDxExpbzW28z78J7FtQKX9ZmThw2UIlNKR8joXQwKD114zffDICEZXsqr/b+?=
 =?us-ascii?Q?fSaBEXsbjsoRSAJMkk+WYolg2N7+d1rU0QUdGmUsBm9kFpIv+Inr9M3aUfnW?=
 =?us-ascii?Q?gLU3FMC99yziE616xzBUQ1sQFhK+/RH0bCWg97SdBEGMOFfneACiPDhM9bg4?=
 =?us-ascii?Q?9TQYqJg3o18ZyYUIpXn5lr5XNz+pK689A9+M7Z3wMbh+zfomxVg5jpf01FYV?=
 =?us-ascii?Q?cesi83cwunnXHk/257B8QJCLk/YEFTaISZAYJ13Rxo21fSpCflNMwPA6F7rA?=
 =?us-ascii?Q?PmvtN+ninNPy8b18GYt8S+Zu9tU/v+RS/SofJo+Ptxn9SdML+kv+0VmPURUj?=
 =?us-ascii?Q?FAJpG/C/kVqSW3c9Tc6jV2p0V74gDGm3P6brZSuXJgRtSXp6ONFu9Xw8YrjD?=
 =?us-ascii?Q?2kXWsAtzU+fXMVWyJ0DeEVTdFzY/KmcOIAnNU+1BbIKUmRvxLeIZYSAUyBU0?=
 =?us-ascii?Q?JjBxMoQDARLeVM4uJA9H5CBM3y/fmW8rqcV6TAsl2HTDhHuSpix0825mAZW1?=
 =?us-ascii?Q?dIchKdgX43UwWwdjLe3w4QRWJvZbitr8dufO3xdtmIy6ZQz3tJYnrx4EhoWb?=
 =?us-ascii?Q?s/EL80q2Hshg5O6MLNx7bPkA+RXPUvo8reLjxjczHZxKpYWhrxflsEuk70+s?=
 =?us-ascii?Q?CIddQOd7QaPKUS9Egx1jj466V7C0Is6IHEkh9C0rlqNYz246EuYtN+wAdYSD?=
 =?us-ascii?Q?cxLBWT28WTT8otF/QCLOjFFFa6Ow0AgCcuJuV6K9dNW8+88FrgGj6r5R0tSP?=
 =?us-ascii?Q?zejPB4SUaBWp8kG9z5WcXVIxyZKeGhVr5maxI9zZr9BKqJil2tRTfEI2kTBc?=
 =?us-ascii?Q?y4DrsYK2sO+6CLzDoOwcnjA8culT/1Jd6/zRHbAHacZWPByAf2dIdZR8f2V8?=
 =?us-ascii?Q?mbpT5eqdPjiW6iJbX8N6TCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c260d96-1968-48c3-d917-08d9be990e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 00:31:23.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qjrs/lbIHRGZ6drY9A1zGzNKrZraJZttHkyTidCgKUDIwgz+bHESN60aTkYzdggf8zDNOJ24ti3dmtreB2YQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Sunday, December 12, 2021 11:38 PM

Ming, thanks so much for the detailed analysis!

> From the log:
>=20
> 1) dm-mpath:
> - queue depth: 2048
> - busy: 848, and 62 of them are in sw queue, so run queue is often
>   caused
> - nr_hw_queues: 1
> - dm-2 is in use, and dm-1/dm-3 is idle
> - dm-2's dispatch busy is 8, that should be the reason why excessive CPU
> usage is observed when flushing plug list without commit dc5fc361d891 in
> which hctx->dispatch_busy is just bypassed
>=20
> 2) iscsi
> - dispatch_busy is 0
> - nr_hw_queues: 1
> - queue depth: 113
> - busy=3D~33, active_queues is 3, so each LUN/iscsi host is saturated
> - 23 active LUNs, 23 * 33 =3D 759 in-flight commands
>=20
> The high CPU utilization may be caused by:
>=20
> 1) big queue depth of dm mpath, the situation may be improved much if it
> is reduced to 1024 or 800. The max allowed inflight commands from iscsi
> hosts can be figured out, if dm's queue depth is much more than this numb=
er,
> the extra commands need to dispatch, and run queue can be scheduled
> immediately, so high CPU utilization is caused.

I think you're correct:
with dm_mod.dm_mq_queue_depth=3D256, the max CPU utilization is 8%.
with dm_mod.dm_mq_queue_depth=3D400, the max CPU utilization is 12%.=20
with dm_mod.dm_mq_queue_depth=3D800, the max CPU utilization is 88%.

The performance with queue_depth=3D800 is poor.
The performance with queue_depth=3D400 is good.
The performance with queue_depth=3D256 is also good, and there is only a=20
small drop comared with the 400 case.

> 2) single hw queue, so contention should be big, which should be avoided
> in big machine, nvme-tcp might be better than iscsi here
>=20
> 3) iscsi io latency is a bit big
>=20
> Even CPU utilization is reduced by commit dc5fc361d891, io performance
> can't be good too with v5.16-rc, I guess.
>=20
> Thanks,
> Ming

Actually the I/O performance of v5.16-rc4 (commit dc5fc361d891 is included)
is good -- it's about the same as the case where v5.16-rc4 + reverting
dc5fc361d891 + dm_mod.dm_mq_queue_depth=3D400 (or 256).

Thanks,
Dexuan

