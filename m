Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074D44901DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiAQGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:15:09 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19258 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234488AbiAQGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:15:08 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20GLG2rA015434;
        Sun, 16 Jan 2022 22:15:06 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dkxnq3xdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jan 2022 22:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Fx/8R1jDclXBElzUQjbzq/deUOqqBUSdlH1IHI+zNLXCMLWoo7M7b7x9R75rq1Au2LZAMWsn2RCLvXfkOlHrutg6PeKZM0mpxiVNF4Gj2awNLRk2TSqObH9VPheR/5J3lHFfa/1Z5+cWQ8NdYrTGJ++mUTKVFqsvr6uTJPLOVr/OkTsfMLsapfyv54TCW6l2VfbPsQSmpC1CeaJEmD2IgcrhPOvsBLEJuMJJo54dFOhQ1zGEvLdS2UFhYoZrv8lnJ7lMuhCCQeAbbB2GV2Nu3ObogQ6RMRZT/shbG135igqVTeXwf6J5/cYbz5NLHVc8sro7O3lK068arlRv2Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjMmZywJ0mCvTgoEu1aZ2Mm3cZ/PYYD0xM7+ZzdHFmY=;
 b=iGxpZh8ncPYHrTjS6MY7AohWeglqyu0ILh29mhCayQEnlFGu4m9cYt12lnq3sg9kVlzJR2UE4n7MQiMQIqqDm6YAG36jkg1t0ILuH76CY8c0Z48sE6P9EaL6aGte4TLoPgio6IzXquzd2Qw+9OocyrfnNVwVlqwoTv8FQn0gzdKEU0iW+OUFZNBN6fR0UMtRuE0ph+6z3I2wGli7M3vzBLJ765ILPgYJSNR1xv2PVGVdZRE6P74wlaFhBzzF/lSXaFOHP5gseaweUvH2hXc5d06xbDZrAh5SNV/EfyWI/Zs8XePG1iYwnNDmbSv/G2OtVxO/f7ywxDFM3/s/k6s6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjMmZywJ0mCvTgoEu1aZ2Mm3cZ/PYYD0xM7+ZzdHFmY=;
 b=U490i4RoB6HTdj6g4m+9HaXMQcn+jG6WmsNOOg/8R22oK8DsO0Gl++XJOHyhw9GOo9lMcveskP5KNDmhFeI/2IK9jnzUHka+MfzTTsnyF4wpZltwrU/7MENSMhTlufrucM6z45654qgXeE1DNzsj7d9zcpyO0UbPtxBrS/UPW6k=
Received: from DM6PR18MB3034.namprd18.prod.outlook.com (2603:10b6:5:18c::32)
 by DM4PR18MB4159.namprd18.prod.outlook.com (2603:10b6:5:38a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 06:15:04 +0000
Received: from DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c]) by DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c%5]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 06:15:04 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     John Meneghini <jmeneghi@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "mlombard@redhat.com" <mlombard@redhat.com>
Subject: RE: [EXT] [PATCH V2] scsi: bnx2fc: flush destroy_work queue before
 calling bnx2fc_interface_put
Thread-Topic: [EXT] [PATCH V2] scsi: bnx2fc: flush destroy_work queue before
 calling bnx2fc_interface_put
Thread-Index: AQHYCWjkXoJfgQq5J0eWhe/T27LLwaxmwBUQ
Date:   Mon, 17 Jan 2022 06:15:04 +0000
Message-ID: <DM6PR18MB303405DAE8725D3F42A4476AD2579@DM6PR18MB3034.namprd18.prod.outlook.com>
References: <20220114170424.871391-1-jmeneghi@redhat.com>
In-Reply-To: <20220114170424.871391-1-jmeneghi@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cc0c29e-b7cc-470b-3f87-08d9d980b3f1
x-ms-traffictypediagnostic: DM4PR18MB4159:EE_
x-microsoft-antispam-prvs: <DM4PR18MB4159B293C67289C937767E59D2579@DM4PR18MB4159.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMhGirJgpfVzgMhFq8cj322NXgVGnIXqA4ZEHsnP/Y8JE2u5E9GNdgcG9KFIIbG+Hf+/51ysGQJsIiOzS5MO6MXU7YCbcTx4a2p0XPU1bcrmPG91VIzV+x/Fyg8YPN/RDShCxXcsbgJpiIQCcoGXBmi4vz/G+uUPAnL33cmFnAJUxKSlJjbMa6kYXtWK/HHUF12vStRapYj8nO68RkifUL2yKeYIcEEPoVzj0Y5wPVVfOU15DND3k8aZc88cDjrpm+RFtRwCLHZjnLlTnH+xrXzTYLiBva75AdBjWGzPH3dCfMfrWyAEcX1pnPewKBD/g06vmggAQwisyf1BT2SVLNnRSI60MGMxViSQnz9BPIZi31vYr5trkLCphxlPKrEQWz7DgBtB+8ZYeHSz1QAZ/t3HCfTbEWhb0BXK38ao+d4J4D2O98Pc/TuY08TR1QTaLss+nc4GOGIdyYjVRhST6ekfgIcjw9uhEMS1i95vZ20+Tn/irZLXbyxItic7wr0hsSZwI0YK70XzH1tHZPanivRtRf5TUJ6I+5Ub0uEoD7mf0tThrDVEpBI9JwdLWrvAxdRJXTSFaxzR7AsFV8qTciFb21Zi9ei50bJDL6FjexQWl4T2gH1OjS3gLjz2qMmIE7SYpLQ5uArFs2yRsGyipJ4+ZMA4ERTh3Cg+dyq+pJQTPMG+h2LfIGjMi5jRSk5/OgxDRs3N6L0OhTpYQ7fLzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3034.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(86362001)(186003)(76116006)(7696005)(45080400002)(64756008)(66446008)(52536014)(66476007)(66556008)(4326008)(8936002)(508600001)(6506007)(8676002)(26005)(316002)(5660300002)(54906003)(110136005)(55016003)(9686003)(83380400001)(71200400001)(53546011)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZpbvnvSOlGS9MoAYtmATJV9rtuWPHgQXvdZXagZ03ZzCxs1k9iOmNTu1NS98?=
 =?us-ascii?Q?iLg7H/nufhjbanUXoH49YPfM1VoBThU5BMimiBM1KNXGdcreisFqd7C45EDL?=
 =?us-ascii?Q?x2AX4QrD7zZgUspBYmQBrDI+iwfHrLVzwgOs4eAcgtXgJ64n4sI3Hz4S1MA2?=
 =?us-ascii?Q?RCaV04FLDxk9nzC8UKNEaitCC+4MoWf6Mnwn1YVW7G+SHVt9X/JYHM08EUMQ?=
 =?us-ascii?Q?eEYmeyTKxsKK6weMrfFM9kI+uUQn9LWqKWPaYmShJpKLX2DiXrk3goyZwexh?=
 =?us-ascii?Q?WZ+BQZGWysWjKwcB1GxFyJPwgxN91Klz3Uuv2bCnMeFJTT7Yr5xeClyruXZs?=
 =?us-ascii?Q?GzfvEDxRDBefHZOlha0P9dkjrYnHMaAmvlnidawRKOTACFAC4fPxMxo3EVBH?=
 =?us-ascii?Q?mxkbMusV3Ms6COXiHIXwaSnjvhPlW1EtsTpoDQ0VSNSXrRkEiuDXtzs+m1H9?=
 =?us-ascii?Q?mrQTvGYSdlYCKx2v+vz54AMAY6WuymxT34gbv2Z8ZK/eJQNPYXarSne/fwn+?=
 =?us-ascii?Q?UOTXuLVpyiaWrry7R0wZwd9T8n5fu8KGeCW+/3+aZi8n3kKvwbbBexcsklZX?=
 =?us-ascii?Q?xhVHNtzwhek572nOuyQH/XvaupTaulupOI1yFzZJGr32rDthyeCrVT0rvvd/?=
 =?us-ascii?Q?1wAKFLmcWF5VLsjpjMZCbdtbFJ/L25aRj1RaNbySN3NqCkfZAUgf8EiX/OST?=
 =?us-ascii?Q?b6k/fJKaiYIBlKcPTl1+Prfl52ryRx7AHvEfttzLzfK9O8i1TISyqUPumPzu?=
 =?us-ascii?Q?pg9M2Vf7RQP2ccSzAnu03ePT2iSjeQ3yiV9m5BgnhNEbCumYbRnxMnMRTyia?=
 =?us-ascii?Q?RCLtvUgXFrcrNMkPEzSi6pL/l7M97Iu8C0+bWAYwRReLweM0Wi+i39kAe3EG?=
 =?us-ascii?Q?RRJ14a+NllY5NtvB/t1INVRVL4yM/VY41YCha2brxAX6EEVn0biYPeA5B0lT?=
 =?us-ascii?Q?Gi62oXC0CCECIHEoy72e+SDxNDzdV9zIWAYjEzGcj45pDQPQMUGKJet9knrg?=
 =?us-ascii?Q?WWsuqE3ToE1LekTpAnc0Ir7SM0wC5KlfjafUq2WGqL5u98+y3yVA7RKtjWGj?=
 =?us-ascii?Q?cYSmu7dgqfAAAmawSOuW56GseD/oN1Djz3COq893sNvQZLlq7Cvq1rWkR72g?=
 =?us-ascii?Q?fu5PHL59xZwMF68XOkE34aEjmTTO6lep/JSGEjGneNHICZhrrCELCvO5ilPT?=
 =?us-ascii?Q?gihAAweSR9X0FOn4GG2q4Yl23tUfJXUjT33vMfptINI9thyTuVpoo56SdDLT?=
 =?us-ascii?Q?pMJmJYImX59Jr6JsRat1d2BMsVDzv/RdPi9ngdkghACYidZ/cUMUCgstYhqQ?=
 =?us-ascii?Q?/Rkja4XngP6eqGklXEiwcDOc8lPUBEcE5IPD0/6NKRdDvQOOzwZ6WyrbYNde?=
 =?us-ascii?Q?9ql6NTv7WHtUc8GqNkftRILMZsa+WO3IwLSWjNYiG1nObQmgpNQDB7LhyCKW?=
 =?us-ascii?Q?gMymcUwGOCtoX90PICE6g7w0ndGkmjZHMzMEE2RLPzjHGET5NBNeSF+rxyqB?=
 =?us-ascii?Q?wkws7k6V+9y/5gBFAn/mSzI7FLCMBeuBi/l7AmgU7OUgNyK5bY8T/qWX7RFe?=
 =?us-ascii?Q?lTXAXUoFljM7QReGgF8vjRevF1D7knnqghn5be1YNOObnG2drKqwfKG3Zely?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc0c29e-b7cc-470b-3f87-08d9d980b3f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 06:15:04.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5yhdl9Br8HJFMJLCtiJwvkynB6Be4XLSinepN/qTVWKQVo9H6qd4szVQsYHm5F1xF3etYcPMAucmKyGOLaOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4159
X-Proofpoint-ORIG-GUID: W5yaYxrIjiEhEZDKRfry7WlWTMKxBDx2
X-Proofpoint-GUID: W5yaYxrIjiEhEZDKRfry7WlWTMKxBDx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_02,2022-01-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


> -----Original Message-----
> From: John Meneghini <jmeneghi@redhat.com>
> Sent: Friday, January 14, 2022 10:34 PM
> To: linux-scsi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; GR-QLogic-Storage-Upstream <GR-QLogic-
> Storage-Upstream@marvell.com>; mlombard@redhat.com; Saurav Kashyap
> <skashyap@marvell.com>
> Subject: [EXT] [PATCH V2] scsi: bnx2fc: flush destroy_work queue before c=
alling
> bnx2fc_interface_put
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>   The bnx2fc_destroy functions are removing the interface before calling
>   destroy_work. This results multiple WARNings from sysfs_remove_group
>   as the controller rport device attributes are removed to early.
>=20
>   Replace the fcoe_port's destroy_work queue.  It's not needed.
>=20
>   The problem is easily reproducible with the following steps.
>=20
>   Example:
>=20
>     $ dmesg -w &
>     $ systemctl enable --now fcoe
>     $ fipvlan -s -c ens2f1
>     $ fcoeadm -d ens2f1.802
>     [  583.464488] host2: libfc: Link down on port (7500a1)
>     [  583.472651] bnx2fc: 7500a1 - rport not created Yet!!
>     [  583.490468] ------------[ cut here ]------------
>     [  583.538725] sysfs group 'power' not found for kobject 'rport-2:0-0=
'
>     [  583.568814] WARNING: CPU: 3 PID: 192 at fs/sysfs/group.c:279
> sysfs_remove_group+0x6f/0x80
>     [  583.607130] Modules linked in: dm_service_time 8021q garp mrp stp =
llc
> bnx2fc cnic uio rpcsec_gss_krb5 auth_rpcgss nfsv4 ...
>     [  583.942994] CPU: 3 PID: 192 Comm: kworker/3:2 Kdump: loaded Not
> tainted 5.14.0-39.el9.x86_64 #1
>     [  583.984105] Hardware name: HP ProLiant DL120 G7, BIOS J01 07/01/20=
13
>     [  584.016535] Workqueue: fc_wq_2 fc_rport_final_delete
> [scsi_transport_fc]
>     [  584.050691] RIP: 0010:sysfs_remove_group+0x6f/0x80
>     [  584.074725] Code: ff 5b 48 89 ef 5d 41 5c e9 ee c0 ff ff 48 89 ef =
e8 f6 b8 ff
> ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 ...
>     [  584.162586] RSP: 0018:ffffb567c15afdc0 EFLAGS: 00010282
>     [  584.188225] RAX: 0000000000000000 RBX: ffffffff8eec4220 RCX:
> 0000000000000000
>     [  584.221053] RDX: ffff8c1586ce84c0 RSI: ffff8c1586cd7cc0 RDI:
> ffff8c1586cd7cc0
>     [  584.255089] RBP: 0000000000000000 R08: 0000000000000000 R09:
> ffffb567c15afc00
>     [  584.287954] R10: ffffb567c15afbf8 R11: ffffffff8fbe7f28 R12:
> ffff8c1486326400
>     [  584.322356] R13: ffff8c1486326480 R14: ffff8c1483a4a000 R15:
> 0000000000000004
>     [  584.355379] FS:  0000000000000000(0000) GS:ffff8c1586cc0000(0000)
> knlGS:0000000000000000
>     [  584.394419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  584.421123] CR2: 00007fe95a6f7840 CR3: 0000000107674002 CR4:
> 00000000000606e0
>     [  584.454888] Call Trace:
>     [  584.466108]  device_del+0xb2/0x3e0
>     [  584.481701]  device_unregister+0x13/0x60
>     [  584.501306]  bsg_unregister_queue+0x5b/0x80
>     [  584.522029]  bsg_remove_queue+0x1c/0x40
>     [  584.541884]  fc_rport_final_delete+0xf3/0x1d0 [scsi_transport_fc]
>     [  584.573823]  process_one_work+0x1e3/0x3b0
>     [  584.592396]  worker_thread+0x50/0x3b0
>     [  584.609256]  ? rescuer_thread+0x370/0x370
>     [  584.628877]  kthread+0x149/0x170
>     [  584.643673]  ? set_kthread_struct+0x40/0x40
>     [  584.662909]  ret_from_fork+0x22/0x30
>     [  584.680002] ---[ end trace 53575ecefa942ece ]---
>=20
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> index 71fa62bd3083..9be273c320e2 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> @@ -82,7 +82,7 @@ static int bnx2fc_bind_pcidev(struct bnx2fc_hba *hba);
>  static void bnx2fc_unbind_pcidev(struct bnx2fc_hba *hba);
>  static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interf=
ace,
>  				  struct device *parent, int npiv);
> -static void bnx2fc_destroy_work(struct work_struct *work);
> +static void bnx2fc_port_destroy(struct fcoe_port *port);
>=20
>  static struct bnx2fc_hba *bnx2fc_hba_lookup(struct net_device *phys_dev)=
;
>  static struct bnx2fc_interface *bnx2fc_interface_lookup(struct net_devic=
e
> @@ -907,9 +907,6 @@ static void bnx2fc_indicate_netevent(void *context,
> unsigned long event,
>  				__bnx2fc_destroy(interface);
>  		}
>  		mutex_unlock(&bnx2fc_dev_lock);
> -
> -		/* Ensure ALL destroy work has been completed before return
> */
> -		flush_workqueue(bnx2fc_wq);
>  		return;
>=20
>  	default:
> @@ -1215,8 +1212,8 @@ static int bnx2fc_vport_destroy(struct fc_vport
> *vport)
>  	mutex_unlock(&n_port->lp_mutex);
>  	bnx2fc_free_vport(interface->hba, port->lport);
>  	bnx2fc_port_shutdown(port->lport);
> +	bnx2fc_port_destroy(port);
>  	bnx2fc_interface_put(interface);
> -	queue_work(bnx2fc_wq, &port->destroy_work);
>  	return 0;
>  }
>=20
> @@ -1525,7 +1522,6 @@ static struct fc_lport *bnx2fc_if_create(struct
> bnx2fc_interface *interface,
>  	port->lport =3D lport;
>  	port->priv =3D interface;
>  	port->get_netdev =3D bnx2fc_netdev;
> -	INIT_WORK(&port->destroy_work, bnx2fc_destroy_work);
>=20
>  	/* Configure fcoe_port */
>  	rc =3D bnx2fc_lport_config(lport);
> @@ -1653,8 +1649,8 @@ static void __bnx2fc_destroy(struct bnx2fc_interfac=
e
> *interface)
>  	bnx2fc_interface_cleanup(interface);
>  	bnx2fc_stop(interface);
>  	list_del(&interface->list);
> +	bnx2fc_port_destroy(port);
>  	bnx2fc_interface_put(interface);
> -	queue_work(bnx2fc_wq, &port->destroy_work);
>  }
>=20
>  /**
> @@ -1694,15 +1690,12 @@ static int bnx2fc_destroy(struct net_device
> *netdev)
>  	return rc;
>  }
>=20
> -static void bnx2fc_destroy_work(struct work_struct *work)
> +static void bnx2fc_port_destroy(struct fcoe_port *port)
>  {
> -	struct fcoe_port *port;
>  	struct fc_lport *lport;
>=20
> -	port =3D container_of(work, struct fcoe_port, destroy_work);
>  	lport =3D port->lport;
> -
> -	BNX2FC_HBA_DBG(lport, "Entered bnx2fc_destroy_work\n");
> +	BNX2FC_HBA_DBG(lport, "Entered %s, destroying lport %p\n",
> __func__, lport);
>=20
>  	bnx2fc_if_destroy(lport);
>  }
> @@ -2556,9 +2549,6 @@ static void bnx2fc_ulp_exit(struct cnic_dev *dev)
>  			__bnx2fc_destroy(interface);
>  	mutex_unlock(&bnx2fc_dev_lock);
>=20
> -	/* Ensure ALL destroy work has been completed before return */
> -	flush_workqueue(bnx2fc_wq);
> -
>  	bnx2fc_ulp_stop(hba);
>  	/* unregister cnic device */
>  	if (test_and_clear_bit(BNX2FC_CNIC_REGISTERED, &hba-
> >reg_with_cnic))
> --

Thanks for the patch.
Acked-by: Saurav Kashyap <skashyap@marvell.com>

Thanks,
~Saurav
> 2.27.0


