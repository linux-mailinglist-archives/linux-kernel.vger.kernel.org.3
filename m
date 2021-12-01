Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BE4645D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhLAEXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:23:49 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60924 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229590AbhLAEXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:23:42 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B134XYu011152;
        Tue, 30 Nov 2021 20:20:20 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cp0tyg7n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 20:20:19 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1B14Cj80030435;
        Tue, 30 Nov 2021 20:20:19 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cp0tyg7mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 20:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6TkR5SGWFyZoFMSJTuFxKCXbkyFO5mpdci3qYjja0qNgieNV3IUr6Dl1iASNW2d4nHCj2X7B0RgazH//1rJ16rLs0OGpZhRypBAv1rY3ysfi8suLwBZScY7i08DeHc0mFXVbehykbEsKxT3KMKDYImgkNUpm3FR9kEf1+ukaBwb8uxAIqn/IwxqcERKIRTyISSb9iiz5cWQbwf/elMWSClElmqmLyORU0AaIy53XP6JX2/MdukvFMVVM4TPI7qP1gweLfFi3Z9Qoug848Yy/NwU5lrGFvfFnnURmBR519LlCm14qFju+fwqsDXrerfnFtOG3Cfz75PpEHvQ4cdT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsD/MqIQYHUBG1KKCYWfr3VhV8fHCd4dA1S+cA3K3Pw=;
 b=BsIZsy3hi+pKruxCJPV8ZFvMU/eIA5nScaK6LDuD1l4s1SaOLuIJTqGmvPoUuXwnnZkUEt2X5BvchSQSvNI6mr8bqKMy/G02QrllwXwQVhu8J4uSxVOoCa/oScZSNl/PuEGou4cUt9fUdX9LMx6EtSbvFz338Qs+vfSzrxFvrfCCK54rPgPk1BO/dC40FNxxqS5dJPLT6rpaCGV+PJROcFCz4vBNF4stzg6wUGPCGIt7gT9wkiILVcACCIdwLqxmXJopYvrRGvaWVqrxZ2tSIA8nhKQOGz0SJXHMMDS/rRWvPJl6Q5SK/l237PHLqM7sB+StqD9QXKoT6/HQ4stbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsD/MqIQYHUBG1KKCYWfr3VhV8fHCd4dA1S+cA3K3Pw=;
 b=n+vtWjVSWZ4v3MI2AGEavECHorJbzYIAn83FUK1D3cc/H1HWC5wsv+R4jE0ZDNgrLcjUHg3wijbNFihbF0Az8mzNeiz9Rd/ll54XYdbv0H7QpoeN43wZJo5nOrsrwiU70u/UPVxscrehfsf//KclutYU4kLFWaOJFS8VqyCel2A=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by CO1PR18MB4620.namprd18.prod.outlook.com (2603:10b6:303:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 04:20:18 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::f960:c2cb:8ca4:e0cf]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::f960:c2cb:8ca4:e0cf%4]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 04:20:18 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 0/2] SYSFS_FLAG_FW_SEL_BOOT formatting fixes
Thread-Topic: [EXT] [PATCH v2 0/2] SYSFS_FLAG_FW_SEL_BOOT formatting fixes
Thread-Index: AQHX5iozmCOCYHYf40eKWprt2kfoeqwdCLxA
Date:   Wed, 1 Dec 2021 04:20:17 +0000
Message-ID: <CO6PR18MB4419DDB643393E5DF959ACDDD8689@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20211130203813.12138-1-f.fainelli@gmail.com>
In-Reply-To: <20211130203813.12138-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16dd166-4a49-47d1-35f8-08d9b481e1b3
x-ms-traffictypediagnostic: CO1PR18MB4620:
x-microsoft-antispam-prvs: <CO1PR18MB46205387EC23D2390FD9CCFFD8689@CO1PR18MB4620.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HByiuvuEv/OfQZsu0MiLEn2XJuycB3iODFQ4/zr4ZapICZ5LpXuesDkNWuM8PwijDy8BmZC6xsYuQL3+TQGL9Jp7poSTeUkNyqlauTk4ojBpSIBbi5M5Xb/jqEys1vJGxOjHHIdIBGvmmG5c/6XmVI6Mopwhjt8O22uzCn3Rsclg5i68Ho0ac5PnmKAZTlGFdVXXeInbiQG3wgi1+WC4nVZUDDDpY7H3BS+TR+TkbWeR0i6oFXJkwyKhHAabd9JAmSA/1Hvy42y3tqriXCr7qfLh/J6otQ3rwkXqZJ9a5lJYKBv9ouLWVAAGOhkiEc+eO0bSwe2pBHnp/4GNdTNMSfnNr+pm06kjL5T+wQKYPMkF/U5gnoc4FGa1sTQzsrYFXPDSLxoYa90QU592Df+sPNTl+If0xwo+ixyYfFprHZ9RG9Z0y6d9PduAqkn6CVy/iYPK3NwLtBGlc0555DzE+puRi9jEq23K7BmZckkJNJe2kASO9NFI3MHSDZVnpcfsyWe4pDGe/5KF6ho+O1XsQ+NztpApAH9DQwNUdRPKoQpL9ktvwhKp0wG2Wiu8E6Q4j2YKtG0oLy2j64fqWuDjPEiRk9NkvfnCVCmsL1ANo6I+eUkVS+dgUOEf6+XpAEp4yV9jSwUo0yLIdLZU+LQYAXc48lGdUyjoMhrperDp3w6bFaF9MkohnRDNzKdgygWsKXfoLO7Bts1wuuka0nBMnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(71200400001)(53546011)(38070700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(186003)(4744005)(508600001)(83380400001)(316002)(54906003)(7696005)(86362001)(76116006)(66946007)(38100700002)(9686003)(52536014)(55016003)(33656002)(66446008)(110136005)(66556008)(64756008)(66476007)(26005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7X/bKS3JaRMaWzbeZeQg/2NwWB5qBip172Wr2yQ84XLMfYyfeJhSQkRfIMMz?=
 =?us-ascii?Q?tcdqCasbdA/BxmjnSVrfLiOin3In2WkyPWtG0BsbmYAUoGrAjXHObT+qyHR3?=
 =?us-ascii?Q?QP473keaZg9zWF9L8clT3ICUfh2ganIyXNq+HoFUR/Ryn8IguJePtx08SxvX?=
 =?us-ascii?Q?rer2Dx5WhzL6ceB9YZAMwzxVt31NkQENo9Sf0M1Fo4eh7HcTXaN+aDSnwtC6?=
 =?us-ascii?Q?fL5PS6dOQGMgIssZpnxClvExn0z56ZTmw0BWDbRsgxTTCr69pj0NoRRWcV9j?=
 =?us-ascii?Q?VpoWIi25kR6KRcBWefS9dBCT0Qd+2iEUCzI6+DACqfBctFgUyxC2MVDUllsW?=
 =?us-ascii?Q?EqKQ3+dtrLvuaywQNI1bEeq1dd3FO8qNdi7Wll5VC0PZ4yfNWD2stmexavIt?=
 =?us-ascii?Q?H2fdIRRMzQFcjLvhlIGWcTZp/ZQeloQ9hwVEHYaDfaO5SAZvsO+eSk6AT2k9?=
 =?us-ascii?Q?+H0jd1d/jp6vNm1z37WW5vSpCgXE82QFQTq+3X38KxcC9MlRUoweeWiGT2RM?=
 =?us-ascii?Q?dJ/MmQSBdGBHhDoyjPetITYGMzdvz42DT8qKcGDZ0of5nvXpW+03n9foBgp7?=
 =?us-ascii?Q?IzwKf5WC0JLmI0wxhky5BDv/Tb62qt/M6rGzwZqz7My3arr7htem3iczjtBa?=
 =?us-ascii?Q?dj48jV5j96GlxvZ8jYaE2b8uu52l5GtqPfIDjYDjeTr5TZ7dYyOQ7q7j+CAn?=
 =?us-ascii?Q?oYI8WONlJ4LX5/zt0EMTB+ztyAe54HHY8EASQvP4piSPTADRtvpqMR+fL6k2?=
 =?us-ascii?Q?n12RzlT3kiWvY2XvNs8VcHMKGeZWUcBmvYie3C62uMbhxbJx00qL4EArESQ7?=
 =?us-ascii?Q?iFEhQuq6UcdS2lF0XXQuUJQEW9UWNlWP6U2IBrmIaMPen6XZfowQmuMxLlB/?=
 =?us-ascii?Q?A9+jlUZbVbqMQZbsm0SB6Nvruq8Ch+ozPFHTtHUpLeKjuf7A/5smfw/VsUrz?=
 =?us-ascii?Q?t4WjKlpVG0a1GyVC/hh1DvYNd/iXAXPmLBMeCBkGy0NcQKJ2KclO2fTc/ko2?=
 =?us-ascii?Q?7mqGpBkUs886eZdq6957zzO3vlVJp+ApyyODhzR0WnwZaM0ZD6VN4tm2ccjk?=
 =?us-ascii?Q?TvvY4apdsL+LRvzHwnGEC6xQIhZn0ocGqcAQXWgt2A46kppii43HSfqi7ej6?=
 =?us-ascii?Q?jROneMeeWdjMGNwhHDlwV+gxTufhyP6Cqp+G0qKHInujaVkOUmVn2WMCZhOn?=
 =?us-ascii?Q?PtfIbHuxrodCpdfKGMFimchafCgqjiWEbNHg1cA2wMjz2PLZymY/AdgzWYax?=
 =?us-ascii?Q?b1pGXhgc2L1BnwH8IKlFistOFdV4Qvqp9cX5918mVxOBWP9Y79+hWwzuUjXe?=
 =?us-ascii?Q?9jfy8ByyGF15ZeX66z5PN2/h3bMxfbrg+Wn5A2Z6vwn96/jS1dtBbG3/+6eN?=
 =?us-ascii?Q?ErfUe7hM6UsF6HzcZIv6HPk7ehjQbCsROuFbf91c/j4PsNWg/ex0Fnm4c9/w?=
 =?us-ascii?Q?IZyNCtV5VQssfNMLWMRrmsmHl/Ifv+1PWMrqqLisKO2sJPWw1tBhBu9rENoY?=
 =?us-ascii?Q?Lg/1cBWEs6pw30SKjYj88SIodIAQZH5pgmP6XH3dHAbF5QEVf/axAP1ayepJ?=
 =?us-ascii?Q?uL8a7r9axcILU8g73KVf6hvN8pXvDCnRhIFwTH4jkbPOGQ85M3oDakiVWnUH?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16dd166-4a49-47d1-35f8-08d9b481e1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 04:20:17.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrdfAil8RixIfEA1PFbUnX0K6kie1fQueXwCIzDwLZLd3mcvZBN1cqT2T002M8CS0ew/GTMGAhbAr6Q2gAVIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4620
X-Proofpoint-ORIG-GUID: AhACi901AqTSENOd0e8MxWY3k19uG_Ej
X-Proofpoint-GUID: bylJF-l4xLule15pAPu2PamRLeAOZk7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Florian Fainelli <f.fainelli@gmail.com>
> Sent: Wednesday, December 1, 2021 2:08 AM
> To: linux-kernel@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>; Nilesh Javali <njavali@marve=
ll.com>;
> Manish Rangankar <mrangankar@marvell.com>; GR-QLogic-Storage-Upstream
> <GR-QLogic-Storage-Upstream@marvell.com>; James E.J. Bottomley
> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
> open list:QLOGIC QL41xxx ISCSI DRIVER <linux-scsi@vger.kernel.org>
> Subject: [EXT] [PATCH v2 0/2] SYSFS_FLAG_FW_SEL_BOOT formatting fixes
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Martin, Manish,
>=20
> This patch series aligns the formatting of SYSFS_FLAG_FW_SEL_BOOT between
> qedi and qla4xxx.
>=20
> Changes in v2:
>=20
> - fixed incorrect format in second hunk of qla4xxx
>=20
> Florian Fainelli (2):
>   scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
>   scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
>=20
>  drivers/scsi/qedi/qedi_main.c | 5 ++---  drivers/scsi/qla4xxx/ql4_os.c |=
 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> --
> 2.25.1

Thanks,

Acked-by: Manish Rangankar <mrangankar@marvell.com>
