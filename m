Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86246FE19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhLJJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:50:50 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9748 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhLJJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:50:49 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BA8NJ9h020846;
        Fri, 10 Dec 2021 01:46:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=mW/7sPYXGeFszvygM8dQHJmFzEONA8jx+50Dg+jBlL0=;
 b=OV5oy+WnVHHGy+z7nYCpF4RfoDbTZ1YL3iGknmO4zCfLBPsJ4T3/cQQe+FAcmjhjOC2m
 F6F5bR/MVTIUoEvFE039EMiEMiZemELU8iy3BdQsnYv4hvrIbIRLqB+Fyf6jKbnijXX9
 qw9PyLqRyleFkSDslEo7zov65+QxJRy1n3/GaLvObI2lq9Rxtv9s00kLYe8zwtieJ6Si
 kKCzRad/mGn0YPKWgUcmopwVY6t5NwoIWSlMccS0fHn4WyVAkHlLahteMUtVcKbaThTG
 N+wKqAy8rQa8DeMJCJce7okPr3Nm+5YLuRYZ6T5rM/affflOJmEj7FcpI9D8eBqxsGc4 OA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3cv3bc0cht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 01:46:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkoeAUkoaigK74fbcJVFiJgCdGEmLGuwh6QHLtMIZGLbsd7ZauAbBWuyaNfMbiOjXmQw5FjWJDPiFcVUZSljBUU5Q1PE6wR/YjGFAFnM2ZuK8PVU54l5n2WKJtxub7N28u2S8RvSnh3JYtkQtzIYoHFXwqTwAAQYOlAfbYool2CRrkQhwglIdv2EjjShv4FP7cYnkyjqlphxWlVmaqvz4t9IhrW797gxLGGIuKzGz3a1qhIzNcsceUNYQ2U8q+E0GqSrR+yakt4r4qXLMMrTJ1hxH740371GGzQBq13eBU9160gXATAMRb0oMb8wdfF+RXJQPl0eex0Y0cc2KBBv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW/7sPYXGeFszvygM8dQHJmFzEONA8jx+50Dg+jBlL0=;
 b=kCfoFECAJyK5nOdUPmpjaHczX7M5br/zoBo1dwjjnbRLTajv+8ZD6qQfydwz7FnjvROxLS94N5By6RSVc4azVXXxZdcbWQ5Qnzq/vqU8Hk7spgPAA0fGdb/2JFPyGOdGaiLb6wXe/gUTpAVP2gWyzs2oL8CBJA6Dkh9vYL8Sa/8BSzFVIZ7VnchBr8p/DWSbQheIK69S8mP/OeQAsuZp7c0AijXk/U/TCsWfqeoZd6otyLnjq2vsjldvWbUDtHFOecQIXwDjr+Wmr96H8e0i4J5Kyh7ScngVC1VKwHhCKUA3d+HeIoQKvSxSTdtaRbcJUg/WSPntKlz00WpeMrbLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW/7sPYXGeFszvygM8dQHJmFzEONA8jx+50Dg+jBlL0=;
 b=wIge6JRo4xTRodlasPaW/y5l2BxgJ1XUOP4tVNquCu0RfKGhnyoleVpeSKHanXlaDDq3qFk9vo5BALx9rd3MR2IbstyJB8MyA9CiCvdUDcnC43fYp7OqCB1P/q0GtuLa5u2WOgunmHf6KR50HVHY/m1W0GGPOuZ0VSkHCf1nE8E=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM5PR07MB2873.namprd07.prod.outlook.com (2603:10b6:3:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Fri, 10 Dec 2021 09:46:46 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017%7]) with mapi id 15.20.4778.012; Fri, 10 Dec 2021
 09:46:46 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: RE: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Topic: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Index: AQHXx2bHmQutwPZ9l0Sv3BSHrxD/16wQu9eAgAG6aaCAAXB/AIALkHAQgArg6oCAAWeOIA==
Date:   Fri, 10 Dec 2021 09:46:46 +0000
Message-ID: <DM6PR07MB6154AF51437C535362EC4059C5719@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com> <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YZ8aygJQoxie+Ddn@matsya>
 <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YbHuV/LpcZqOTuLV@matsya>
In-Reply-To: <YbHuV/LpcZqOTuLV@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNTFlMzUyMi01OTllLTExZWMtODU4ZS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcMTUxZTM1MjMtNTk5ZS0xMWVjLTg1OGUtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI0NjE3IiB0PSIxMzI4MzYwMzIwNDYwNzg1NzQiIGg9InRkSUdPVkpHS29GTEpFWjczVzY3ZHFiWXAzND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 197eb809-0fcd-490b-78a7-08d9bbc1fb1b
x-ms-traffictypediagnostic: DM5PR07MB2873:EE_
x-microsoft-antispam-prvs: <DM5PR07MB28738D1756BB85655631B5D8C5719@DM5PR07MB2873.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzR4On9x7u2sKvAXji+2U2GUBLTRS2EpQZLvBn6FqcY0qTNA92phhJmXsikRkiRnB8evg5X4ACA0tyJGVHH7FD8VWaiH9eQJNq/55JFdvXaCXD81eCr4d+U+7skEAFEkiSeaDiL0Cmu8PooCgdjaFiUCKVXYwHHppcyJQGsBRUlmHhp60QR2GX/iKW6GGndQTSOoydpFFfqe9ag+K7crZMPOvjvFoUUFDdaIJ9RcolsLWYv4vI4IDtxgZT5BS3EswBYVVDbpwnpOGejKybmiO38rH2CrhOJgQUStW+OjercqOnE6POwHBk59rdp4SJYW/JPQxg+6k+WYy+IA45tEWBySi9VgI519uF4W+iSoO9jYKEhCoeF3MpYS+hfFeg3L7RjHclhsNnxji4W8hhbkywdgWHWfs3Gmp+NMs93eJO9PSB6trBMx+ofAqdhJIQWXzWXDnyLw76vZXxmUZEoL5wF+gFRAkhmZNbc37wcrhq1VZOWre57A6xYsbOiXbPr60ZHBN6CkHxAd40Go2q9inSmcnNCY+r+9xQ6YUGjscIHzUNE7CNMKvt1BwAxHb3Tu0BpaVScOhBOPZnUV8p68IeqMe+0ypMn1o3eEvgvqXI4AKQ/PEY47DCwaG+PpoOm+6jyQHZBH6Rh3Hur680xbco7DMtDEjncbicBNPc53//gknS/Zy1kx+wln8JmVe7FYQ5o9vn9/lUomcpVclvpQHO9pO+CklVeyc6Di8kLMYRCb2KwkNA8pGRjL89k6r737
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(316002)(38070700005)(33656002)(122000001)(26005)(76116006)(2906002)(52536014)(55016003)(508600001)(54906003)(6916009)(6506007)(9686003)(4326008)(53546011)(71200400001)(66446008)(66556008)(64756008)(5660300002)(38100700002)(66476007)(7696005)(186003)(83380400001)(8936002)(86362001)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uUrvPSp0iPMwe01S9u7iQLpsfuBxdSbA7XCbFtzsfYwOTfifVQzdhMHDrFWt?=
 =?us-ascii?Q?JtGjZHTfjGR0oxFnWMvsaxSUxfKi6orCgz/ViXDKhmB0Twxuv2GdGbObBXXG?=
 =?us-ascii?Q?/xQEkAd4pz3f+jC1MK+b3QFk45WnoSPyUvoi01ByW0uZgEr+0kunv0ru5EW+?=
 =?us-ascii?Q?8wFoVtuQCp6IejI9Asq8W1MorNVE4x9iZX3HieTxBXAGlmC9lU8JfKcmDNpp?=
 =?us-ascii?Q?GBvIUDnWKiI411hpK5iXN7JOx/R/HYN0vBg/P2HxK41LlxFncQpnHG9fyBbO?=
 =?us-ascii?Q?2DeVBVFahYyveRsjWHKg23e29um1WCEAi6EzX1HEPWhFVucwy5obhyyTi7kh?=
 =?us-ascii?Q?CH3WmkIdMOCw3odiNQJcuy5oowCxL6iq8XkKXnQpioGDBYti8+sM+X7eqOb3?=
 =?us-ascii?Q?p+PS/43ixk/JZrKx3yqJ4oKhS8IzAvCWTr99lJfVleOASJlvua8iE4q1b4Vh?=
 =?us-ascii?Q?7Nm9CEyXprqrFe/Aqc395zwJPlwNmXraMFe8RsU9HBwnT5QeT23HotaHjHm5?=
 =?us-ascii?Q?4TttrYndrRsdALHmBTFtwlyiC2KYIn0Cueh7Ol6qOyKHSF6O/NmbsHioyr+Q?=
 =?us-ascii?Q?q8D7n137f9EQ88CtNIZMoR4XcqM0BJhyLLNEMJjpKSuoZvIQkehFEd2h1gzs?=
 =?us-ascii?Q?xuhr8l2ssPkLkrcQQc1A0fPTr1ZN0gh8C8gbnsC59oD0HJ3Rt/njXaJcQlKD?=
 =?us-ascii?Q?OAqEYN8bPMsxv5bpkLIf1l9QGD21b6m0Bg+ovrhI/qndd3EBSYQOl2N9cK6r?=
 =?us-ascii?Q?n60vZx3uZfEES/QWQux2OAkJn1kbeKxEeKszbrlhxNK+4WLvYFsvNlPtclE7?=
 =?us-ascii?Q?lJiPHQSWlojH0Zb2VK2IhUYCAq+TfuU4WYxfVBRI/QoNJXVFWa4XV6FL5tRg?=
 =?us-ascii?Q?q1hps+qvwuNHb/FYjzZRXU4qPrNWpNVTf13E3HZtTVINd8ORB/ZnSyTMiFol?=
 =?us-ascii?Q?1T2ch6Q2LcyLJXa4OCn/1aub5/jrluel/gx1afSEMRjIuGqQp+s5zYERDGc8?=
 =?us-ascii?Q?3rRNuLRbYM9r85SSnRL4vf5d98mUgdHEVckSw3t8pwR4DFXXHU/B9brYdmAo?=
 =?us-ascii?Q?SwL45WLvonOIsNI8Ulgr0igwbX3taRysx/+0OwLt1hf5Ns3bWTMiwlskxeAT?=
 =?us-ascii?Q?Y+eqteppFd0Ituped5UQfYFr7JNkVnA5LFZveYoJlWmHlsUpZxHNhzZKnQoL?=
 =?us-ascii?Q?04iAec51geVHG0BGS4+UfmnDklUQTAd3LfMOKF9BZGCX1uvrxdFdnPl3Dg43?=
 =?us-ascii?Q?YtXgKBDdkDPxyLstRQE6qmGejEYa9YlXlrqLDClygDXWhPLhWOVpYUuzMF1e?=
 =?us-ascii?Q?5jKCW0+zITA6D60UXTDpjNJBrdHk4trPzFQvCYDL1gZomM7l99AZeqicfbYt?=
 =?us-ascii?Q?K+sBo1ss3LTxK2Bz4QZA3zDA/NwXhwzh5mR2hNCaxBwyiClFA/XOs5jVoo4b?=
 =?us-ascii?Q?HWeNMTNv8r+04pyL3Q/BR4zBGKkFI+tQOsGJnbeqretzfi6NSWITs+bJOHei?=
 =?us-ascii?Q?MHgmOIhAdhb1Xml/pH3WjCSfrxyBmF46Q3eCvSojp5an6W1VYmAQPHXmynm1?=
 =?us-ascii?Q?nlNT2W1Nj/Ps1YYHsrNrqcYrJbty3odgmdcBOD340RvuZtoYeBUq+FcX5q7u?=
 =?us-ascii?Q?Seo4+2utWD5HMBqt+MG7MetZp1FWsWTUgWwSJNGU/a25LIg99+a8KHPDbtHc?=
 =?us-ascii?Q?o1Yymg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197eb809-0fcd-490b-78a7-08d9bbc1fb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:46:46.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymlmV+/ZpRE6CqpXk0fTyV012VYlv6JYYEAr6Ph9/0Nff1jnH2fRE9yw3jEvE07H2RTGqLVgoI6i4w0bJ0AAG/ZA0c+hLUCw52FRLPHG2Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2873
X-Proofpoint-GUID: VAe_x1-BOSHvNWs2mIaFpDxRomWq0H75
X-Proofpoint-ORIG-GUID: VAe_x1-BOSHvNWs2mIaFpDxRomWq0H75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, December 9, 2021 5:24 PM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> govindraju@ti.com
> Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
> multilink configuration
>=20
> EXTERNAL MAIL
>=20
>=20
> On 02-12-21, 14:12, Swapnil Kashinath Jakhade wrote:
> > Hi Vinod,
> >
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: Thursday, November 25, 2021 10:41 AM
> > > To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> > > Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de;
> > > linux- phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> > > govindraju@ti.com
> > > Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe +
> > > QSGMII PHY multilink configuration
> > >
> > > EXTERNAL MAIL
> > >
> > >
> > > On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:
> > >
> > > > > so this is pcie->qsgmii ->ssc/external/internal ... ok
> > > > >
> > > > > > +				[NO_SSC] =3D
> > > > > &pcie_100_no_ssc_plllc_cmn_vals,
> > > > > > +				[EXTERNAL_SSC] =3D
> > > > > &pcie_100_ext_ssc_plllc_cmn_vals,
> > > > > > +				[INTERNAL_SSC] =3D
> > > > > &pcie_100_int_ssc_plllc_cmn_vals,
> > > > > > +			},
> > > > > >  		},
> > > > > >  		[TYPE_USB] =3D {
> > > > > >  			[TYPE_NONE] =3D {
> > > > > >  				[EXTERNAL_SSC] =3D
> > > > > &usb_100_ext_ssc_cmn_vals,
> > > > > >  			},
> > > > > >  		},
> > > > > > +		[TYPE_QSGMII] =3D {
> > > > > > +			[TYPE_PCIE] =3D {
> > > > >
> > > > > now it is reverse! qsgmii -> pcie -> ... why?
> > > > >
> > > > > what is meant by pcie->qsgmii and qsgmii-> pcie?
> > > > >
> > > >
> > > > Multi-protocol configuration is done in 2 phases, each for one prot=
ocol.
> > > > e.g. for PCIe + QSGMII case,
> > > > [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers
> > > > for PCIe and [TYPE_QSGMII][TYPE_PCIE] will configure common and
> > > > lane
> > > registers for QSGMII.
> > >
> > > Then it should be always common + protocol or protocol + common, not
> > > both please! Pls make an order and stick to it everywhere... If that
> > > is not possible, I would like to understand why
> >
> > Could you please elaborate what do you mean by " common + protocol or
> > protocol + common, not both please!"?
> > The order is same everywhere which is common + lane configuration for
> > protocol 1 and then for protocol 2. For multiprotocol case, PHY
> > configuration is based on which protocols are operating simultaneously.=
 So
> e.g.
> > [TYPE_QSGMII][TYPE_PCIE] -> QSGMII configuration when other protocol
> > is PCIe Which might be different than [TYPE_QSGMII][TYPE_*] -> QSGMII
> > configuration with other protocol.
>=20
> As I said I would like to understand what is the difference b/w
> [TYPE_QSGMII][TYPE_PCIE] & [TYPE_PCIE][TYPE_QSGMII] and why?
>=20

This logic is for implementing multi-link PHY configuration.
Consider a case for a 4 lane PHY with PCIe using 2 lanes and QSGMII other 2=
 lanes.
Sierra PHY has 2 PLLs, viz. PLLLC and PLLLC1.
So in this case, PLLLC is used for PCIe and PLLLC1 is used for QSGMII and
PHY will be configured in two steps as described below.
1. For first step, phy_t1 =3D TYPE_PCIE and phy_t2 =3D TYPE_QSGMII
     So we select registers as
     [TYPE_PCIE][TYPE_QSGMII][ssc]:=20
              This will configure PHY registers associated for *PCIe* (i.e.=
 first protocol)
              involving PLLLC registers and registers for first 2 lanes of =
PHY.
2. In second step, the variables phy_t1 and phy_t2 are swapped. So now,
    phy_t1 =3D TYPE_QSGMII and phy_t2 =3D TYPE_PCIE. And we select register=
s as:
    [TYPE_QSGMII][TYPE_PCIE][ssc]:
             This will configure PHY registers associated for *QSGMII* (i.e=
. second protocol)
             involving PLLLC1 registers and registers for other 2 lanes of =
PHY.

This completes the PHY configuration for multilink operation.
Above approach enables dividing the large number of PHY register configurat=
ions
into protocol specific smaller groups.

Please let me know if it answers your question.

Thanks & regards,
Swapnil

> --
> ~Vinod
