Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94137460F58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhK2Hep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:34:45 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25484 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231923AbhK2Hco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:32:44 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ASNK702013202;
        Sun, 28 Nov 2021 23:29:23 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ckn2scppq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 23:29:23 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1AT7TMEM030905;
        Sun, 28 Nov 2021 23:29:22 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ckn2scppj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 23:29:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiI9BMYBNK532oWBTzG3KR6CkVpNv5YITiFUK8M486DqaTli8Ix0srNB5ej1CbsDyiLxABlNjR/f+d2X9uT3Un6uIWG4Ca/1NZ4hLR5wHWaDLkD7p/hknVr3SIQ6YzBreuuDLz1Q8BHtvAdrHosMPhTkF6wiaXNtUm5dYhxJH9RYnfwIhGJooGYunP4a+0Wpe9v2rtFQmMfNtRW3bU5+EJdQUa3thAnldZVJCAFZ+ZZRa/BQTaGQ2UpT+eMVC1xT2PqHI+ak+9+qB1rKp1tBBKFatWnr/ADOdF+79zmYvGBIvHa2EZjlBYlstHVlU4NeXcQEc+F+t1wOpW6ISSQ6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U798Fc1HMheOMe2vwXHXdoTkrRKTxpszUCmKaafqRs4=;
 b=j/SBH/fpdplnDGmxdXkAdx53xZU7Ya18H89CumgHsBwp+G2nGRsminWdoV1vbtpRVSA5f9B3tAxyVe9T7UUT6/KNlpDvmfk4P0tQGhWiQLXsIz5QD0ZzQkBJ14Ltdol5E0BogM2P82prBKg1bd2SmfkWgetVNnZdbXepEyLDPUaWT2VB1Y2RAkbvZzZYCNySCDXy2oRmfrzezBwd+W5Amju5fDhU802WWoh+3trRrH4eULLrCEIAFvzcci/ECQo8tsjaNvelJULTg0+lGy97t7c2+SYMCSqiLuVb79qGI6IpMh4Ug0mD7PW2UxCgWFqYknfyrolepHF3hGd/qCfs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U798Fc1HMheOMe2vwXHXdoTkrRKTxpszUCmKaafqRs4=;
 b=UQdlhcgPMDMnwXsaBy+5Cn6l2v4eEF71Mb7G1nWuFqoePQ+G4dEbYFr0/NoQHV2zY7yFmajXAe+AkWTbD3ypbaXbp2F3QyT+UzdqRThwLRmfelXI/cH4rxrN3n2Th9TvVhGZgLLKs5SG+ixe79BUidqPjAlpVBdmwH0rGVlNYww=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by CO6PR18MB4481.namprd18.prod.outlook.com (2603:10b6:303:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 07:29:19 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::f960:c2cb:8ca4:e0cf]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::f960:c2cb:8ca4:e0cf%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:29:19 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT
 formatting
Thread-Topic: [EXT] [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT
 formatting
Thread-Index: AQHX47WhTJf6rPyyKkmX/c4q85h7zKwaHiHQ
Date:   Mon, 29 Nov 2021 07:29:19 +0000
Message-ID: <CO6PR18MB4419B4245BB9ED3387105444D8669@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
 <20211126201708.27140-3-f.fainelli@gmail.com>
In-Reply-To: <20211126201708.27140-3-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 691e95ff-affc-4876-4624-08d9b309f4e0
x-ms-traffictypediagnostic: CO6PR18MB4481:
x-microsoft-antispam-prvs: <CO6PR18MB44816D2F7627A17B4B65F480D8669@CO6PR18MB4481.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUGSZXFkUWfRx01GlHSK2MKkhhwNg4Ryyo/7/2HGBMDWj1BSHvlfXrCyr1Y0KsllN0Ugq7rJfKhOOLaHrN5mDz+cPXL83nwmRVW7y2UmUZ6FW8oiRAGbZABqvplnbSuNWK3UZbRxKeoC5h9O50vb9xEsn6afATFj/IzpzuoeHvDDBnL3e3R9FjegJb55DBofM3CDV5GP+dShmobCCRrGFvRvnBgpdSHxjbAUWAHYM+Q5CQ0zhggQtLYHcZ1JHluEw1fRd3muZdg8wDAF2O3GA85l1ntnUjdIkIkEfLexcKGWkagBe8Ml9lhbvijIPn+qpvBhOhwkNCwVFhMxaJ6DRAjWdEsx8e6qx0h0zw3i8oN7OTJa/IteGaVafVAqyBME3ZsOr9ivvgBq86TPuaKNfCW9+Q1W8qtbZzKkj4kX/RYNuTeRiVnk9IqtC5wrJNkQShTZRzyQIyPjL3CkNcgtVx9QPATdLsyDAG6zOfjSMdEwpx/HK//lmOAl9qUi41BteJWNpWVOE/rLdzDHUKQmZ1m3VTNKikXdaI781SzvlzClqPLTDSdvtr+BHmzvOpXMioCCOCz2oKQMYFitqjc/tklLKP/uZOZXGmQRihnU3bG9DFGQe5boylJ3+UvU3LdWyy8Xvm/GQw5UzpFNjDc+n+GRTqdLS16hlFaTv9bIWcFwGNmFp8mg6RoeVHPzdFd0PG6YNPsijOUjZvQqvAYavw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(2906002)(9686003)(7696005)(186003)(33656002)(38070700005)(53546011)(122000001)(508600001)(5660300002)(52536014)(4326008)(8676002)(55016003)(86362001)(83380400001)(26005)(316002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(8936002)(38100700002)(54906003)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gllw/GrMu0FROYLWrlGnaFw2dFSgeGFFMF9L8on1ASuZl9qi5YS92ZGg6WQL?=
 =?us-ascii?Q?eVSydpIDqVo+ThEQB9USBOCFsjPxWmNElBdyOYtpFdxV3PzDKxObNFfKogr0?=
 =?us-ascii?Q?ZWcMcotJtJHYD8lkZpLRQb24X0E5JPlanbBc2iaOfIoXvj0HI/Uoh59qtI6F?=
 =?us-ascii?Q?1PkJtv2dKmVX3s4mVFq1gU+a+sSqnNvBfr2r/NSujqCYIMSSlmQPIRNuMRuC?=
 =?us-ascii?Q?/5AgaADONMy0Peluw5bVP/usHaeFTnzkcPD8E4z/TbWt0GwCMEMUnJz68qHV?=
 =?us-ascii?Q?iRklIY5Of2CFa/SO6Zur+miqkIQqq3ASr34M7C0sav6pXeGqdeqHQADKjGGj?=
 =?us-ascii?Q?2e0iaju0YWCcPhCoqCc2kblBjXh4YZ6uYckuHeEwIsy07aMQciXyCXlbwaul?=
 =?us-ascii?Q?nnB2Wl8AXurvXLFuVdK2zrHzjlh9SKRqWW3Js8t1NsOcsN2n5U65hDTxsPb6?=
 =?us-ascii?Q?gYoOalO5FELoO7C/BxzJ4YgyBgOT7lcdQNVgCEGQG3tThh2/A5u+nYnnlCfV?=
 =?us-ascii?Q?Luxz2m3N7Hz7YWnjuIA4WVA0FmPEuT+jgx8G1Cb26o5VBYwdfbGRgTKBkfiN?=
 =?us-ascii?Q?vMeDJEz+pzk0GzBk+eJPZ5ATjqXWUJOfkd9Iv/ZA8uoE0r6Qmb2BLoVTNAoB?=
 =?us-ascii?Q?BMLmpK28nzOc0tMtiFnPWpwX9VLyjrGUNhyyH/o94HDLjW0fPEGa3yDStLCD?=
 =?us-ascii?Q?K8hFgynjhXy3WPrwFY9eEjU+46xTIROO+4N8UGQYK0c5FLhu8EwRbO+leXyT?=
 =?us-ascii?Q?m70we5TMaM3BqJMjwb5AFGw7oQGqDMXQk8dqWNwd948rUM8Wy18jHR/rexkn?=
 =?us-ascii?Q?qzVCVCRqu0db0NqdtzxXe+ynDRFweip0zgObsPeI/C0jWhR0VoCwOCJrM0cL?=
 =?us-ascii?Q?S3WZ1MgO5JZgvvlXbGL5Tt6lgQDQsuD/fib0KaqRnQMQWKOrxahZQHKVEFml?=
 =?us-ascii?Q?k2S67rEsHLNl9FtEs+UFhXNgJGPTgpPPI00wAshke4bOutef59zpgGBAEdHo?=
 =?us-ascii?Q?/r5DmHqUuVp7XTqyy5uFs7zQfRZKXo5xx+lkgBJS/ScQLUK69s6C8otq64tg?=
 =?us-ascii?Q?aNjEUON7HYfo2EQI18UkzndNk3+zfyYYQeca6ryBq8r0m/4EI73G6hShlPHM?=
 =?us-ascii?Q?vDYhW6pM0MUkzKYgBzjgcYO6Pgcp4eSh7nG6KdNKEZ2vt4oQKSnqBaehByp2?=
 =?us-ascii?Q?OBMD0ys8e9ehvwsqhVf1s3NuZi9o6+GkSApp6702vbrimbHa63493EzO/L6a?=
 =?us-ascii?Q?lz4nt74B1mTl4C3wWNcOKqfr8bULRo5e6+1oiygbNtvJjA8u2yS+B1AG35h0?=
 =?us-ascii?Q?HT3t+VT610DG0XUgw5USlNdZVPYxpJn5Nq4aAttH/FokqUbkZeqU4wUrBpZU?=
 =?us-ascii?Q?Krl2zRdbtrdU7/yhX59Vaj5+Iug4LzR3MfcKDVa1D1sSLkHvtGtSaKfrcEgw?=
 =?us-ascii?Q?p8KeXAg2es84+npUXF3GUWguuUV0ObkOPPVsJSyqknh17qszBAdMG9eoU7qa?=
 =?us-ascii?Q?/Ev6a1mBJhRplJ9nkHzy/PJUkbe2I1LWhkTU3MKHlfKRPcglHvsiQ++OI+cu?=
 =?us-ascii?Q?3ESR22JjANHTWMGn/dQijdJZFIW/lHAKerfFzYfjyNRkj1AvwPBqOvfyNIZA?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e95ff-affc-4876-4624-08d9b309f4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 07:29:19.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8jCUdZK8o095ywvM6nl3axk+T1xdIfgqKtwgeD/iGbFcRS+f83Wf+kAJA7NKuOveOmilI15xr3nH0j5CT5bKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4481
X-Proofpoint-GUID: e3zbXYqiaOYWkCjzmV2SczNhadenvYCy
X-Proofpoint-ORIG-GUID: ynpIrGkz0qT91ofg_rTCAvSGBE5Wov0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_02,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Florian Fainelli <f.fainelli@gmail.com>
> Sent: Saturday, November 27, 2021 1:47 AM
> To: linux-kernel@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>; kernel test robot <lkp@intel=
.com>;
> Nilesh Javali <njavali@marvell.com>; Manish Rangankar
> <mrangankar@marvell.com>; GR-QLogic-Storage-Upstream <GR-QLogic-
> Storage-Upstream@marvell.com>; James E.J. Bottomley <jejb@linux.ibm.com>;
> Martin K. Petersen <martin.petersen@oracle.com>; open list:QLOGIC QL41xxx
> ISCSI DRIVER <linux-scsi@vger.kernel.org>
> Subject: [EXT] [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT
> formatting
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> The format used for formatting SYSFS_FLAG_FW_SEL_BOOT creates the
> following warning:
>=20
> drivers/scsi/qedi/qedi_main.c:2259:35: warning: format specifies type 'ch=
ar' but
> the argument has type 'int' [-Wformat]
>                    rc =3D snprintf(buf, 3, "%hhd\n", SYSFS_FLAG_FW_SEL_BO=
OT);
>=20
> Fix this to cast the constant as an u8 since the intention is to print it=
 via sysfs as a
> byte.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/scsi/qedi/qedi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qedi/qedi.h b/drivers/scsi/qedi/qedi.h index
> ce199a7a16b8..421b3a69fd37 100644
> --- a/drivers/scsi/qedi/qedi.h
> +++ b/drivers/scsi/qedi/qedi.h
> @@ -358,7 +358,7 @@ struct qedi_ctx {
>  	bool use_fast_sge;
>=20
>  	atomic_t num_offloads;
> -#define SYSFS_FLAG_FW_SEL_BOOT 2
> +#define SYSFS_FLAG_FW_SEL_BOOT (u8)2
>  #define IPV6_LEN	41
>  #define IPV4_LEN	17
>  	struct iscsi_boot_kset *boot_kset;
> --
> 2.25.1

Acked-by: Manish Rangankar <mrangankar@marvell.com>
