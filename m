Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819A49F6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347743AbiA1JyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:54:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46904 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbiA1JyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:54:04 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20S5IJup002682;
        Fri, 28 Jan 2022 01:54:00 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebm7fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 01:54:00 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20S9r98L019248;
        Fri, 28 Jan 2022 01:54:00 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebm7fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 01:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4G/UB8QHuOUr4CZIxoZYp9bzeOwKFy1Ppn4D4ZOnfhEciSUpoC8dHdp5AHac+20q/p/jJsgNekoXHfv4b1SeCO+plEd5AYVCxkw71HndFx9o+pnneGDPpj3CK6IdnrYtgm8b5sWUp39W/pryWUQnaONKa6sgLgaD8rm20PFsq0K+xiVJm/CVzbbwjxI3Db2/MuvTH56AgC5aG0XNnpOR/sFnHoWVjD8jp9Xogo2VQsDdFCTtNeYEMqkLKRqHcaU+2WEXAZLoORPKempmG4+x4jt1IGa/ZYvdOZioEwUjC3EyoGP+0eJhOH8+0OoaJ0Qws6Ll6OGLW2+5K+cfjIQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZXdcTJyTohWtY+wOsvGzjLh4KLisMd67TeS/cJni3E=;
 b=eBvHfnwyK0FKGikR/uA9cK+7f0H/tlGkhm2Rlv/ktrmbA2gYTCARBhHKNqOmguPeGqDck8zHhKArjor8OyBbXaksLNWe2TruZEegI1d0gcTm1HhmZsbLzrZwMRls6SeYX28uRhYwCDlOrywJzbTF2ILhiMylf7o4hqitNhZUo6+V/27DVIUECDKgHvWeWvWmIR16b0hIgqgYrJMuRzsaonDBqQnxdPnfw2PsqLU/xgQnFwilzG+I6JwSbIwx6nvdW7C08Tvn23SFWYrZ0f/FrLJ9j3PtxN5HSfqiFaKWDmr1RmZRswuz01oT6pGbr3l4n1/Ld9vVIp1O8yqr27OYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZXdcTJyTohWtY+wOsvGzjLh4KLisMd67TeS/cJni3E=;
 b=Ul4kbZyQWav/kpDS6J6BYanRG63PwgnzyVi2+qkpC67bsncL94sbtHHYpQyquwquUyPLVuhkIeAnVK4MYpk4RovBKh/ZI/csHDvx96xNxCvf6o1+Zjb+hv2FEMguXeNKkKPSdrYfCOkCr4WR5zCre+eK2Al5BqGVk0f5n0dOk2M=
Received: from DM6PR18MB3034.namprd18.prod.outlook.com (2603:10b6:5:18c::32)
 by BN6PR18MB1524.namprd18.prod.outlook.com (2603:10b6:404:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:53:55 +0000
Received: from DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c]) by DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:53:55 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
CC:     Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] scsi: bnx2fc: Fix typo in comments
Thread-Topic: [EXT] [PATCH] scsi: bnx2fc: Fix typo in comments
Thread-Index: AQHYFBCzfBOZoh7C7kmTS7uNqlwzlqx4MaGg
Date:   Fri, 28 Jan 2022 09:53:55 +0000
Message-ID: <DM6PR18MB3034488BB32D01EDF3C4303ED2229@DM6PR18MB3034.namprd18.prod.outlook.com>
References: <20220128063101.6953-1-cai.huoqing@linux.dev>
In-Reply-To: <20220128063101.6953-1-cai.huoqing@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a837fa-2851-4586-314d-08d9e24418d2
x-ms-traffictypediagnostic: BN6PR18MB1524:EE_
x-microsoft-antispam-prvs: <BN6PR18MB15247D47269704974B7598AED2229@BN6PR18MB1524.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLNwqV8SwqmKAEFw8a5C5xNJuDDmbqAs+aF8rC2Ru+G7VGYmbeiZT6i4alg++0fuS1HYF/e+KR97pzpINszukx5dMuIALUlyYO22s/QzKyB2fS7ZWuq3gJOuluLReyTeywAmCWx01u3BFkOOjQPJpcDL/SfvHwamC8ahh50bOgRYvAvmhugci9T52spVWqgO8/9IDW93d9N8cWKxFwiw/bV4npsVXAGrfAxa7dqTi45N/i6R4zqrooFrw4APy/coiCcEgNhdArKTxhmO6kIMHESV/oVY+bIGjRyrHl1gxakT5Zr0m6Dbh+eZGa22DMgm7gtoHLF70msacsC7wmqJHpBU3FcTgawR+fyYR71H+PLpIri01cfS1tmfRmQz29pOxGyvJQ6VY424o13tzg98yfpD+Cjg1TLIhFpO1d+FzG+EWH5wrzBW16eOHTEjoOMHZhV1cyXzk6iu7Lhtvx6Qp8zl4kxwEmxU0O+f6CZG90wV87Ao9uC/E5/lbCJoKLBYSUi7iWnYM6H0h3aIS8Nj0WsXKzmCc9OT/Q3zrZGhUmpikeS0UcEmrSbomxO8G7mtFlMJt7alBjG7m3IfJtBNnlSBhuvY9JbTYGZ2ndwXJ07SlUhBhPNSTCxfuHX+Y6juR6HArkx4uREaBIfZ8WMvYPgxUr4wkh3eZM7VRF2k4nNq1d6JSj2fef5yE5ozcIUjw1G0pjvfDE8oOc9nkhXZSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3034.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(122000001)(26005)(33656002)(508600001)(2906002)(6506007)(9686003)(55016003)(7696005)(64756008)(5660300002)(38070700005)(8936002)(8676002)(52536014)(54906003)(6916009)(316002)(86362001)(38100700002)(71200400001)(66476007)(66946007)(53546011)(66446008)(76116006)(66556008)(4326008)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KRPTpC4Sjnv4/GFIeEiPbxhbqqdLptzx1ZbRNuWD09kvfmeykR8lXDu0Vk0u?=
 =?us-ascii?Q?P+Oubmfypu5SRu//RqAEvXfmNxyVCmiAd+Bgg+7NPpPvpDiy5VzyVLU/umZV?=
 =?us-ascii?Q?vArK710Freuxa+FAai2MOQWwaJgtwFJ0mrVTaY+bPdfR9UiTOGduTkWzBlgK?=
 =?us-ascii?Q?ALZLigANuk2xfaLYSLK/EyqcGGEr7g7RFE/lkc2KrwfUQQn0k0XDnDAe0p8q?=
 =?us-ascii?Q?1F10vPAnQtdfSapDZEkv+AMZHqMtlwfOl9Cc2FUD2y6s04E4DvYUcwbI85cm?=
 =?us-ascii?Q?39aCOp4EaMsqEBUjpAEReljtica0sMo//L8CbqQNbFwavMwQ4WjO1uF0+fvt?=
 =?us-ascii?Q?dvPxjHFQuk5IyKZ1CxFDqsqFz6dc3XllbH49m5QomvekguRq4Itau2pXWspW?=
 =?us-ascii?Q?NoX/q2dgBElhNt28VgpOwL0MF3Vu+6KfWNtxe40AANJpAfaq+E+i4BpKVxHV?=
 =?us-ascii?Q?oWjIvGeU/7mY9F0L7e3dQwpuiLGNRB/Nj2si/rd3T4SB04XEISs1QBKOkAJL?=
 =?us-ascii?Q?5HM8CrejbLMCr3jJ38kJfUDyBoHP/5W1kqQit8+zEh5pvFrPZ0/PIl3eAm/2?=
 =?us-ascii?Q?dnDTJYSfU5LI5hhhpc283lxs/OwoSJy3wBEqiAerursCP9jRtIPHg8uJqYrH?=
 =?us-ascii?Q?JALEX/suqWQMv7aXMJG+mvTP0Ld0u6S2+ZaNKVfEM9IeDxcdbYUktXbI26NJ?=
 =?us-ascii?Q?Q4whCX2QTRGsggooB6jZib3gAg1rjjAXmgnVVr4YWyr2K8tae71dJJBjc9qO?=
 =?us-ascii?Q?UIbJUvyNndqh9TZmjm888oXxVnOlLv0LXCSuNJCLJoCVY6RGiHLQybS9t6nd?=
 =?us-ascii?Q?7rR0sBslZPui2FR9wXwP0vHFS6mL6v/R0ts/05atwryE+NsE505JwN+0sRk2?=
 =?us-ascii?Q?l2K7pSSqu8oBk15DQ26TLk9bAQ4Zw4Z2fUuvIkxyPfw24VCzsK11hBQhqCba?=
 =?us-ascii?Q?GA/smGo0MjMCGrLzLAyTmTaESH5+3U+CYU7nqfS/gYH9X/mz1wdvTPftfUpk?=
 =?us-ascii?Q?DNFQxJ+f9QjJ15H6rdpWFrfOCkyT1PpbDgRpCejta76CMCZcjDKiFLeFh+Tn?=
 =?us-ascii?Q?dAtH8b0mkCYD9o0J8b+x+0g0++fuh/T3U6ivdRu/XNO7pe2DF07ZypIbwqCS?=
 =?us-ascii?Q?7VRQhATwD7ECgpKo35WG2eGZSY6jVwnI600DMKFN/wKndJg+eNL77x9eIQkA?=
 =?us-ascii?Q?d8uIqQ/Z3OxGTrmBA4cjs6BmBR7EsON8N9ZmtXtxl0DOzj4xbaNeElgg0lhP?=
 =?us-ascii?Q?GY8P8NJaYQ7c1OGJ1+de0rbBXsr8a6ZlErfNID3rr7DwezQKnmYyjUBavgGE?=
 =?us-ascii?Q?TWRcTvgJ4j5BFU86QBJRzAkd2ek7mio1xZiIJcHqAIp54QesVweyD/T2pU3t?=
 =?us-ascii?Q?1li20N3zloLXMWlFt/zdBRBxTRyFH/2JlIXXY8piDA3N0qst06+Ca0Zr9xTw?=
 =?us-ascii?Q?eyA9uhHQWrmhlEcqqNHPH54wyCtwYRdafISh0W758hnrDvS9crM99iSn+Ka6?=
 =?us-ascii?Q?I1QtEdosFqqSO/u22WXdZhAYkT6CQOxUh9pw8K+YG0f2k/jXBeGpGj4KPBwX?=
 =?us-ascii?Q?XIeGM89bVp0ng3pVTKFQlHBj/o4A0zBpVC1jopogC9aPrGSbnr+UpK5PgJ70?=
 =?us-ascii?Q?yZ4hRE5FjisAAclA1lwLhc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a837fa-2851-4586-314d-08d9e24418d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:53:55.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+HIIkpduTj8QsSqDphtFZPvJeAHVvX/PQrK6BPZVPpoz64aOCPGDlj6+PY0pDnxSyiyOF4rhZdxKs5SbYt+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR18MB1524
X-Proofpoint-ORIG-GUID: 1zumJIscjZnYF4cLKYoHDVptAkSYTSiJ
X-Proofpoint-GUID: nrH8lYeUgOddtdVwHi9rsG2idXxJhPvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_01,2022-01-27_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai Huoqing,

> -----Original Message-----
> From: Cai Huoqing <cai.huoqing@linux.dev>
> Sent: Friday, January 28, 2022 12:01 PM
> To: cai.huoqing@linux.dev
> Cc: Saurav Kashyap <skashyap@marvell.com>; Javed Hasan
> <jhasan@marvell.com>; GR-QLogic-Storage-Upstream <GR-QLogic-Storage-
> Upstream@marvell.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin
> K. Petersen <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH] scsi: bnx2fc: Fix typo in comments
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Replace 'Offlaod' with 'Offload'.
>=20
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/scsi/bnx2fc/bnx2fc_tgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2f=
c_tgt.c
> index 9200b718085c..2c246e80c1c4 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
> @@ -482,7 +482,7 @@ void bnx2fc_rport_event_handler(struct fc_lport
> *lport,
>  		}
>=20
>  		/*
> -		 * Offlaod process is protected with hba mutex.
> +		 * Offload process is protected with hba mutex.
>  		 * Use the same mutex_lock for upload process too
>  		 */
>  		mutex_lock(&hba->hba_mutex);
> --

Acked-by: Saurav Kashyap <skashyap@marvell.com>


> 2.25.1

