Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A02482E86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 07:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiACGro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 01:47:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:65118 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229995AbiACGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:47:43 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 202NWmZm005657;
        Sun, 2 Jan 2022 22:47:40 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dbmvsphq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jan 2022 22:47:40 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2036jqE1017807;
        Sun, 2 Jan 2022 22:47:39 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dbmvsphpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jan 2022 22:47:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhCK2a66B4YF/arjiFmM/WP2l3pkx8l2WMq9Iym1lH6H1Z2C9JoJLEjv55Q4BhrPYQtgyaeHDS8nJDnfO3ySaKlnxgEsHoeym/lTyxH+a6dA2dHm3kgLsLl2LIm7fvZTSGYUdcylzFldXMBP0O6hr91pOzQp9EDwAVqavsdgmevLvoybnrO1rx5w/Drq0frHb+iwFfB3y7WKn145I3+G8H/5kOkTOBdy25X7QTPDVCDZacVSv+ewl+Nxtum1DsZyT5sJNsTkyVO2HDKZ/SqOeAYEW6i68NJuDYECVAGcW4dQfFa/4d7/lBLBwyCUx3+w1hHfjXp2WxhAUsdawovWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3FW1VFy3YqO2HtZMdVvub+NeluMv+vNNPhT77MMOpU=;
 b=FaRoFfCbrJTf4fOjPxQrfxOCYwkksLSJspv5RocfeAOGjDaZSU08fYKAQZZW9KhI0A2UBMnpfPa+nCe+3GKet8PHXjCTwvY92NqD0az87bhkxslNDCUt43NYVOBk9Vgb03+JUdFq9wCXLWg3StnRuMQod+KJt0PzIawWASajusy/dt2qt7ZUVBz3YNoyW6Xsrf8fvtJNy1B30Uam4ss0ZPdrXNy+g8+/o4e80ca2Pm41f56eJAnmAODVwPgMZG2lRslqJ++RfVil8Y2gzxBRzZNZO8BbNnHWNbedSPISb3S5urc1BVBt5RD8NbijD3cSkumwHYglWc4rfGEAUzrZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3FW1VFy3YqO2HtZMdVvub+NeluMv+vNNPhT77MMOpU=;
 b=Osw8pKKt9TSOxwqnTBJj3QsuuJjhhx63yrnoI8JH20v/ytZmptw4CgXgnUGftQf6j71FYO/V1wAOR5QMYX4uNwBHQnSYTfksuUiRbVQm+sQRRpaqVWCZ1RRaWempa4JA8VSPULG3yyPZ3Nuqmx3CW80DRQBw5hSyCtu7Y/gcjUA=
Received: from DM6PR18MB3034.namprd18.prod.outlook.com (2603:10b6:5:18c::32)
 by DM5PR18MB0985.namprd18.prod.outlook.com (2603:10b6:3:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.22; Mon, 3 Jan
 2022 06:47:37 +0000
Received: from DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c]) by DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 06:47:37 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Letu Ren <fantasquex@gmail.com>, Javed Hasan <jhasan@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zheyu Ma <zheyuma97@gmail.com>, Wende Tan <twd2.me@gmail.com>
Subject: RE: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
Thread-Topic: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
Thread-Index: AQHX173JoyzXmxer+Uu3rvvmwZsxL6xRK+DQ
Date:   Mon, 3 Jan 2022 06:47:36 +0000
Message-ID: <DM6PR18MB303406C9CF97E2B42CEC63ACD2499@DM6PR18MB3034.namprd18.prod.outlook.com>
References: <20211112120641.16073-1-fantasquex@gmail.com>
In-Reply-To: <20211112120641.16073-1-fantasquex@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca52395e-063e-4de9-3395-08d9ce84edca
x-ms-traffictypediagnostic: DM5PR18MB0985:EE_
x-microsoft-antispam-prvs: <DM5PR18MB0985D3B7E890F0380FC880A7D2499@DM5PR18MB0985.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpZGPH/WAOYGL3b2e2vGswLzHEah+W1XNM2LhZbSNiLYRkn/37YjFWj54bt/CaR3oqORoPXVcAwbZEQyr0NXrkDlCJ8xd2NkhtQxqNRzapoAWFGP8oHo1RZr2F+Bc042hBWL9zYJq1hc8onwzp1PJM2ce/90Q9hVnRhJU9nbwnHR+mSilDctKk+ruumxDVkHVNYrEtnky2rQqwBBOa0SmYQNyYWC01/VKK0xLHDRn4viv/ZnCRS/VNrASuWGfYgR5WPyHdIGY2yV0VcNG8yEx1pmVHkfmKXBL9nEsKjwbj81VC2R3R2i73BTyuq0xPkVRHw2KkXZA7TYrRsrZwGDneoNbRc8hJmGws9GxrWaP399yOcgSQtjgcvzLpR/iI52O2GDQJsiztzz6N1KgD/N3YMoFUaGx+fidBg7mUBrxIgUZ+VGpG5UfY4LT+z9h9qId4tyaWcDqEmaZX6F7V4CWqdYVPhG4skVCAyd30tXiy6ZzlokP1XZw7FUY2sTfnspaRXHe0VQN7YYDu284efHR2jaE37Wd4kQBpPbPRDgzrgBV5HvUsBeYAO+HCgrpsroi25YNQqhyy3jwlUjT1YyDHpA9ceJWX4wJUHe380MewKVYDhQhnGcrj90AM67MJuBrPW4jheS0gr3zoFv+B5fJSw9WYe3xy16CVadGFI6jV3xAHzANjWchf2IkUGZ08rzJzjAf9bX7yS3hUJdT3R8WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3034.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(86362001)(83380400001)(54906003)(110136005)(33656002)(38100700002)(55016003)(2906002)(8936002)(76116006)(5660300002)(7696005)(8676002)(508600001)(4326008)(66946007)(66556008)(66446008)(316002)(55236004)(186003)(122000001)(52536014)(38070700005)(71200400001)(53546011)(9686003)(66476007)(64756008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZVwrn8y3VHdJnRTE7HwJid9QvG8SEcDa+ZPKo9uOQQhyHCpb1/EXNvpbeNu?=
 =?us-ascii?Q?+qHhfTZYxH5YZRDZVt3JaSRVTrh/F9VzoLLJmtKHZXBYWuj0dat6qLNZszd+?=
 =?us-ascii?Q?FuLmg5tWqnrDYvisR552s2Cebu9srbRW+lJzv1JyhubuZNRFGQQOUNWPJLJr?=
 =?us-ascii?Q?LHO5UkdGMBiBmJt7Eu4PZUiP/W/FInrIglCVqDxiRcaOZGfmtshg+i7r7UpR?=
 =?us-ascii?Q?zgZr2Mp5Ru6LfIUZ2m/+yldVSLYahsaTNheeEijFhFkqFbRpSlM4R9nzc7gw?=
 =?us-ascii?Q?Uh9ecrHyPnMTZbbBZ6mNXtIRHEwKjVPpNYi3iMzkd9eYpp9VVxSFKZGhEN0h?=
 =?us-ascii?Q?ufrLM1TweKq3GnPnZJVeAztvwCP58tPouwuO9Sav0zcSIM+3W8rReINv49Qt?=
 =?us-ascii?Q?PqUyqm7ZWewfZ8/IB3ZCCi7SmywUIcSJVw/V+uSjasGATZtioJhdIorZPeh/?=
 =?us-ascii?Q?u/xcv4il3Re4F69EnJ/oMqvidBIoLF7R9O9CR4dJJs8OEVLHpMh7PGNg95Sy?=
 =?us-ascii?Q?8AM9l0Q4GW6jsKobZgGeL0ykU64IQ7wI/mKd14zWyhTOMR3p7WGu55u3yJXW?=
 =?us-ascii?Q?aaZy6SQmuFc/xt0Q3k+1O5ZxzyFiBrO4eWd03p1iIwXaMikTr38hRT7xayO7?=
 =?us-ascii?Q?ag8yFWL5iqvXnE40GHY0RoWrpgBgXmoo7T6PURGHoFjNaSFBhbzcdsD9BXiO?=
 =?us-ascii?Q?+dZgFU1c6IZrSrkkA0cIvcxZF8VHT6yHKdnyBHcbLquyrswAPaM6IIH8HYPE?=
 =?us-ascii?Q?BR1mwwGDr9voDENRz7yF5Y2SorLA+ORkTCsajHtQfHPqg/dJr7cMuOsrWTbS?=
 =?us-ascii?Q?yJkRo3gTwjZJWxbdF7lOR0pI3NwZ8e5gxqk1TT6t3dRyGk1h4PlwO27UA5PZ?=
 =?us-ascii?Q?lMRot5Tyvb7PDxjSWkAxAab9a5l4djX6V5k4TWhsLcdyFJBA/U3OQCYqNHSO?=
 =?us-ascii?Q?s/TkGmlq1suwYYgzxG4eH2v6emvrOeIVjPy6dprjPrLBrxxluQl9fBdvasVc?=
 =?us-ascii?Q?CBYrjkDGQB+OkWihk7vFJdwkfK2zEjl4XNZGdtUguq2WU8ZgFo5EKteUyGBy?=
 =?us-ascii?Q?qbqGbEgX3XPCb/JRLg0uDq8FXDJbIWxnEmuE3bghaxINlawaUyvZhWq/1e3E?=
 =?us-ascii?Q?di659pDaspwxqRWqC64GfiLBaN/W7pK4w4NdRlZjUyHBvhngajVPsNCW/J/K?=
 =?us-ascii?Q?EthjLo8ncsnI8T7qJaELkyn4ljSNBYjBdSnbwsExs5rD93jWsfbTtOaJbScY?=
 =?us-ascii?Q?ruUaIYkE/u7NbsHEIiucQ3c9fHkfStTvVVq7h4KlDU1r6dkYHkgjTR9cOgfv?=
 =?us-ascii?Q?hnDBfTv3J4UV4E07Pb4P6Sn31eFGDpPb1vNNX8+JR7NlbpfG+gYpkjg+ZfBl?=
 =?us-ascii?Q?k1hdfoMTtF5vtvlVQlNNe0bqSDaqOCMD6CoDOKUGAj0J6HiD4CcvEb5txNNU?=
 =?us-ascii?Q?sE7cFE033fnIoAfrjNLWNSk8QgFlrpxaCNwduUa7418FxsotK7gqExdE2Jix?=
 =?us-ascii?Q?sS3Q8ED++zc6XQStpb0ZoHtxNBW1Qt/bFg46eJDACmkNnnuhCnjnOJQ6kZhN?=
 =?us-ascii?Q?lP47gmuMH1faWvORqisSuGdXV5RwBMbzKpyt+UVXoeHlzCRxBwa3iLbpkGEV?=
 =?us-ascii?Q?Y82Xwxp6GH6McmiIhBRlSo0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca52395e-063e-4de9-3395-08d9ce84edca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 06:47:36.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4gxLqzCv4mdaYqQ/m2DHhQInd8ft6FImR2293sJ8WgJo792lOcbzdE3YhqZSbFdiQJSbygOYY56D3K51+XEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB0985
X-Proofpoint-ORIG-GUID: klblMEdFiKHh-qX49bqMGDCOUnrncRcl
X-Proofpoint-GUID: fpcjH2vIgwYnrcFhSFe7rL6KfXQS67Di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_02,2022-01-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Letu Ren,

> -----Original Message-----
> From: Letu Ren <fantasquex@gmail.com>
> Sent: Friday, November 12, 2021 5:37 PM
> To: Saurav Kashyap <skashyap@marvell.com>; Javed Hasan
> <jhasan@marvell.com>; jejb@linux.ibm.com; martin.petersen@oracle.com
> Cc: GR-QLogic-Storage-Upstream <GR-QLogic-Storage-
> Upstream@marvell.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Letu Ren <fantasquex@gmail.com>; Zheyu Ma
> <zheyuma97@gmail.com>; Wende Tan <twd2.me@gmail.com>
> Subject: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> In __qedf_probe, if `qedf->cdev` is NULL which means
> qed_ops->common->probe() failed, then the program will goto label err1,
> scsi_host_put() will free `lport->host` pointer. Because the memory `qedf=
`
> points to is allocated by libfc_host_alloc(), it will be freed by
> scsi_host_put(). However, the if statement below label err0 only checks
> whether qedf is NULL but doesn't check whether the memory has been freed.
> So a UAF bug occurred.
>=20
> There are two ways to get to the statements below err0. the first one is
> described as before. `qedf` should be set to NULL. The second way is goto
> `err0` directly. In this way `qedf` hasn't been changed and it has the
> initial value `NULL`. So the program wont't go to the if statement in any
> situation.
>=20
> The KASAN logs are as follows:
>=20
> [    2.312969] BUG: KASAN: use-after-free in __qedf_probe+0x5dcf/0x6bc0
> [    2.312969]
> [    2.312969] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [    2.312969] Call Trace:
> [    2.312969]  dump_stack_lvl+0x59/0x7b
> [    2.312969]  print_address_description+0x7c/0x3b0
> [    2.312969]  ? __qedf_probe+0x5dcf/0x6bc0
> [    2.312969]  __kasan_report+0x160/0x1c0
> [    2.312969]  ? __qedf_probe+0x5dcf/0x6bc0
> [    2.312969]  kasan_report+0x4b/0x70
> [    2.312969]  ? kobject_put+0x25d/0x290
> [    2.312969]  kasan_check_range+0x2ca/0x310
> [    2.312969]  __qedf_probe+0x5dcf/0x6bc0
> [    2.312969]  ? selinux_kernfs_init_security+0xdc/0x5f0
> [    2.312969]  ? trace_rpm_return_int_rcuidle+0x18/0x120
> [    2.312969]  ? rpm_resume+0xa5c/0x16e0
> [    2.312969]  ? qedf_get_generic_tlv_data+0x160/0x160
> [    2.312969]  local_pci_probe+0x13c/0x1f0
> [    2.312969]  pci_device_probe+0x37e/0x6c0
>=20
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Letu Ren <fantasquex@gmail.com>
> Co-developed-by: Wende Tan <twd2.me@gmail.com>
> Signed-off-by: Wende Tan <twd2.me@gmail.com>
> ---
>  drivers/scsi/qedf/qedf_main.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.=
c
> index 42d0d941dba5..3ea552acd82a 100644
> --- a/drivers/scsi/qedf/qedf_main.c
> +++ b/drivers/scsi/qedf/qedf_main.c
> @@ -3683,11 +3683,6 @@ static int __qedf_probe(struct pci_dev *pdev, int
> mode)
>  err1:
>  	scsi_host_put(lport->host);
>  err0:
> -	if (qedf) {
> -		QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_DISC, "Probe
> done.\n");
> -
> -		clear_bit(QEDF_PROBING, &qedf->flags);
> -	}
>  	return rc;
>  }

Thanks for the patch.

Acked-by: Saurav Kashyap <skashyap@marvell.com>

Thanks,
~Saurav
>=20
> --
> 2.33.1

