Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6D5119B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiD0Not (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiD0Nor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:44:47 -0400
X-Greylist: delayed 4591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 06:41:28 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850C170E3C;
        Wed, 27 Apr 2022 06:41:27 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R8TlNf017601;
        Wed, 27 Apr 2022 05:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Blv9kZ5NeLzZUGlTZ+36j/sme5TJRI+GJd1HWpUITXk=;
 b=LI+FDSI9Yi2imI3hw7JvvGV6XctWCUt3yUY1uf/uEfenFC6Q5woErO2YPyCTmKwxXZ6b
 lVnUqhrvQ0XibNRA+ujsyfrmVGrLAkAKP0GlvQlmke2QymtbiUgMACfvI2FkbK1+hs4k
 FCueJ+YXJ94gPIr23hvxxUZMDDKViyEHWnq1OAK5V57Zpu6egQhsgnVTvSnnwQteotsp
 qoKqG+WPyaqhsWQPS8RgDssBhBZUTx6WD0FT5n9r/y+FU4xgnhfzSSCXNZm21Sqz0ouH
 FAbAOUn4IjkI8v9uowqKbSoFpjPCeI6qJRfCIACNXSPgHnaL7yOJ4DkGkmDAFsisbS3k cQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3fprrhtgqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV8FnKJ8pIZ86GMNMT1j6uu+v/VXiqrlsXI7lMkZnokvyxnOQmHz0WsSS6ycOBqbLlhJzTfLMwWBZCUSD3fGNUIIn3ofmpQF50G8x78/nZ/+31H1KlcM3RNQULFKRPW6yJV9A24vRScXUtyFKCb4HwqZF0SFhumqLh6/zHJKIrtJeintnvg1YPy5zMDzmrB5rSCDzReLtOLBuLIDbBpQ+nFreEVVrI+7tyNq26ud/3lhru34GJQAao9qK6CV/hcBhutxvKKDO7Pa+xhRK4/GV5V/dTjHekVuxHUfeVhTAyvvyVYTm7/H8K3Rgetmve/aRLh7MG+D23pPYG42nUWw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blv9kZ5NeLzZUGlTZ+36j/sme5TJRI+GJd1HWpUITXk=;
 b=lMigt/UkX/V5uFJlkkZ+mhjCY2DjCstDxzzLIczGJdRr2FredpfMw76KSqtCVKHNFJ9ePwFc4owgUS/IG1F2TB2eHIGkDRjr2kXawcEpDbipsC33FiA4HIwU1vVZDeqW/GZVdEooqNKu1bYGb9z+X7IdFqswzrVDx6nwTEmFyaOPlKOsEcacjLRbJMi0WZjvYdEJDLiyRGKCcyt1QGFR/RDkl044V0bkhyKXc+P2ccVvkFXnzlDaMPCAzBRdbh5BToONcoKGq5WVTJ4Y27wYzuI+AIEnTCFD5ISJ2cRjKWn86M9+yM8h9CBsq+4yfzmpSs8gOtqZjSZ67p8Q6bTPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blv9kZ5NeLzZUGlTZ+36j/sme5TJRI+GJd1HWpUITXk=;
 b=cgYmqcT3b6ThH0PWiMB7gB+x8HPrmGT54WzS2+77umxgKMHkPC77+7Dj8rX27Q8gEerjWX1nar1VQy8hP30D9+NyF2QEYY0ByyRQFcP4khM3A39b/ZrGMoBYfUNJZpr4qcsev6WO2gETOfZuD23A62zUFTNvZo1mptATY+O7XNw=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB7112.namprd07.prod.outlook.com (2603:10b6:a03:1e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 12:24:34 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9d2:322:b5b8:e549]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9d2:322:b5b8:e549%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 12:24:33 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Frank Li <Frank.Li@nxp.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Thread-Topic: [PATCH 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Thread-Index: AQHYWYVX8x97u0WG6EGdE8pUoXt/f60DrfbQ
Date:   Wed, 27 Apr 2022 12:24:33 +0000
Message-ID: <BYAPR07MB5381EF16396CE172E724AE05DDFA9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20220426154954.994747-1-Frank.Li@nxp.com>
In-Reply-To: <20220426154954.994747-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZmNiMmM0OTEtYzYyNC0xMWVjLTg3YWUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGZjYjJjNDkyLWM2MjQtMTFlYy04N2FlLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iNTQ4NSIgdD0iMTMyOTU1MzU4NzEyODA5NTA2IiBoPSJPOHFKM2NFMUMvUkc2ZzA4K1Q5QmRCa2NOZkE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9f1040b-a5bf-46da-1c41-08da2848e315
x-ms-traffictypediagnostic: BY5PR07MB7112:EE_
x-microsoft-antispam-prvs: <BY5PR07MB7112A52F36C5D8CC2FB167DEDDFA9@BY5PR07MB7112.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fABvzhDiKaSIJzo7lfSoVS0x1PYZwevZ3G7sq8lcDoFszQHxEoJ/ZLVcrCb9Q/TwkO9xUykUo0HVg3k2ItUKnfujj38Z5nDzkR/ZWErQmuzMftXFgE2m8YnubX4ZGrE41HzkCCGm3km1E7zgge8UpH/5PRYD3TArqocijQ1n4mb0aulo6ImXJAXrE/F3Vyj3/AiMPffdn5BoKFqwYJ0ZvX6XagJozm1ik6XFpEhA4R7+Y7ri7x+AWzgno/5bRXHByHUcWnqtd1L102IcBKPTHVS3VlpWzStv5KhiUmld+bQFjUEM6+CYTKKHtSKJDMJjSIIT9t/Gt601n3m4bTlx3/uof0raxT4UakwGqpIjOp7oxyvFbIkHGbO8BRDATdEVvgvEOrZMSfCvQJ3ja6+d74FeFPg16+x6FgoNjqHLUzL3C9EwH5m0csjVUoC/+LCf95SmZCQrdDKO8WQLkE6gSEWZUmSpPNQSJFRUGsUTTlzyjP3Fsnh87eInqmb7eVz4AM7PSmelkdC6tqsmzbw+boPav9tfFwK8a8mq1KLWFNe/vA5gq0h0wf2++VjqanSKRTrpvO61RxfY6gwP1wdtYQOSogbB1yNQrAcaxzqZL+idX8WG7D1+XqeT5uk84CyW5xCblwfgEd+qUdaDyYHJ8rmEzRxhxr2B2k4EbIPL/B9SF6pK7huyOn/Jwu1TNqzccqJ/lUlHtWwpNkgQ/WaNLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36092001)(7696005)(6506007)(26005)(186003)(71200400001)(54906003)(110136005)(66446008)(66946007)(66556008)(76116006)(8936002)(4326008)(9686003)(55016003)(33656002)(508600001)(8676002)(38070700005)(66476007)(86362001)(5660300002)(316002)(38100700002)(83380400001)(2906002)(122000001)(52536014)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5Ua/ZfuypKWHbfJmUVrvLgbKZOEpXK0/GvGNuiDX0Rf9V+nGiX0X4tkgAC+?=
 =?us-ascii?Q?x9xOv5+qhWUtXlZw5spANbhT/jRaDtLlKiBQjkmurzY0RbkQEIdEKwO8GD08?=
 =?us-ascii?Q?ZZ8EUX5gWrH1QgLjyvhoQLfrypj1rlC2R4g2iGfmxTiuBCq0Hy6Qll5O9dnA?=
 =?us-ascii?Q?ocRWn9BipbR6UYCmljevjnAktgc4B0Aw7k49cgdfbKnduU1SRbl0l7IVCKBY?=
 =?us-ascii?Q?0dnPSrO8M9WozbwH9z6yFA/U7HZ0WZdinGm5qZkfL7sKTRDkQfsJhuWiRJq1?=
 =?us-ascii?Q?+c56dO/7PAqVqJNfe4hSx899tASs5hTdxS5EKw+HqhcJq99NkAU/kHvbNO3t?=
 =?us-ascii?Q?+Sn4fQ7StUhQRTgZkfaDKshfaqQ66IyW/sXdoKwxujQL4vI4L9jHKvJJBPCD?=
 =?us-ascii?Q?N9bqY01LlUEkS8ZniJTN1ES3jmiJB+iK+8EGQCrpFfqi70wyVb2U3kdy55+e?=
 =?us-ascii?Q?y/KVbcP9dhD9IdtD40gO3x/D2jEM2jVWPbpV3M8laxHTX16RcqKAVIis05cI?=
 =?us-ascii?Q?rsHjA59DyjEnaMqQ5fv9RqlDXStedWgFgC2+hRA0w500s3dIJvbi2ulp6ngF?=
 =?us-ascii?Q?1R0+0LalwxDU7lzv3crlJjLilIdOAanHd+h2k5V590bF8SR+hT9COK0LGYgN?=
 =?us-ascii?Q?bxPq/cbvy1yxSyVHJMIn2e389KEV+CZ5oo5aWwu+OtF6gTptn5y3N1rwO/Hl?=
 =?us-ascii?Q?mEd0iFJLn9F11RshUlxjoI3zuoixpsR1MvokQlA5ho1r3xZDQYd9yZJdRc0K?=
 =?us-ascii?Q?ylx6F1h9c1MeMcFOyKe5YqGm3mUfi0tZYs79DKKEstqPtxeVVJFPKMwmCZu7?=
 =?us-ascii?Q?xIzeb4yiECJlA0Sa2uddc62y+/XL4FbZnMttvySeoh1NebK8t3xkgzW6WV8+?=
 =?us-ascii?Q?ZvSjZAsKBTf8ZmNbw/evhWtIdvY60zftw2qsuWwjteM73BSUSQHbfCN6wChN?=
 =?us-ascii?Q?UmckeaV6V4D8VitmVtpjBImgYbE1qwLZvsUNWDGZJ0Dw4IJ6N7zGZDecLMKC?=
 =?us-ascii?Q?WWbdn6DmUgw5Vk+ADWNBBJKyoLLYewLui5TfKGDM4M1ve31ss/rZsuoSj/1c?=
 =?us-ascii?Q?sW4biiivTXSlPczKMTesTFlyX9D/QGuuFR6OWurUgL23srcPLWa+vlLvo9M/?=
 =?us-ascii?Q?qnK1qCx99Rp60OHHkd+hcLrjL5PECB+Fgpjo6TqdEZCKKt5Z6SJM+Jo1XYsJ?=
 =?us-ascii?Q?xDcKbuQBPryOgOFL28es78ay9Qc7zXt+vnioGbiKfDJat29pfWlJ+2UbiFLw?=
 =?us-ascii?Q?JvNdEwwAzgMISPs8N0vcMC2RlfhV+NBnMEAFdGd2bjHoBefFCNRvPJsyXYeH?=
 =?us-ascii?Q?SPNJVNTr1tIXkqaNbiN+J1Utm1QZAqE106/3myeC0tAPfDgvNnMI4nxKgnBV?=
 =?us-ascii?Q?UQLvqmRfPH0UGkvKsNluDwYoZ+IGHhBrLEPHNXYj2UtGGFj0Zak8fb86LiEg?=
 =?us-ascii?Q?2Xwe6TnF/GZ/SO3WPK/P/ebOW21aJ60ebZHQ1PaWQTejmXmLqeEEvJOLJChk?=
 =?us-ascii?Q?K04MZfOSEMqA5mluz06wmsvY9/npJP+flaQhULRED5PdYGIR2qiKgID+fmF6?=
 =?us-ascii?Q?d3kHH6R610cqjmutdVF0k0h9PbEVjWRuGKcmuZ7hqA19eBVgRXKMeOKOs510?=
 =?us-ascii?Q?GmeEs7+L0iWkM3o1joI6gz/Q+/8Of90jJ/6/7gDrKxV4k1+NfKXDuZ+7LB/t?=
 =?us-ascii?Q?9RodlIwZgEaMkTbOaSMvo9084ZcN6iIssim9q0GHt7U/6EGIpP1sebuyVzAg?=
 =?us-ascii?Q?/2Rz2SJuHnxIV+DkwxGLTabO3vXsxfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f1040b-a5bf-46da-1c41-08da2848e315
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 12:24:33.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJxBmcRQZQaOFUwI8afvEceUVq4V1hrZhBls/yVsY96IJA2x31BwdhcIiV8X24dKV3GsuyBwTbi7FAvJKK5n7w2PWI22Eu6IDnNytI7FAI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7112
X-Proofpoint-ORIG-GUID: DwWbwJ2nDE4GVhEFS7wPxYU95PbswuiT
X-Proofpoint-GUID: DwWbwJ2nDE4GVhEFS7wPxYU95PbswuiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

>
>Some devices have USB compositions which may require multiple endpoints.
>To get better performance, need bigger CDNS3_EP_BUF_SIZE.
>
>But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
>multiple endpoints.
>
>By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
>
>Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
>Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
>ecnds3_device:ep_iso_burst
>
>Using a simple algorithm to calculate ep_buf_size.
>ep_buf_size =3D ep_iso_burst =3D (onchip_buffers - 2k) / (number of IN EP =
+
>1).
>
>Test at 8qxp:
>
>	Gadget			ep_buf_size
>
>	RNDIS:				5
>	RNDIS+ACM:			3
>	Mass Storage + NCM + ACM	2
>
>Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
>exceed FIFO memory.
>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
> drivers/usb/cdns3/cdns3-gadget.c | 46 +++++++++++++++++++++++++++++---
> drivers/usb/cdns3/cdns3-gadget.h |  6 ++---
> 2 files changed, 45 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-ga=
dget.c
>index 1f3b4a1422126..62ea1bd773386 100644
>--- a/drivers/usb/cdns3/cdns3-gadget.c
>+++ b/drivers/usb/cdns3/cdns3-gadget.c
>@@ -2050,7 +2050,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, =
bool enable)
> 	u8 mult =3D 0;
> 	int ret;
>
>-	buffering =3D CDNS3_EP_BUF_SIZE - 1;
>+	buffering =3D priv_dev->ep_buf_size - 1;
>
> 	cdns3_configure_dmult(priv_dev, priv_ep);
>
>@@ -2069,7 +2069,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, =
bool enable)
> 		break;
> 	default:
> 		ep_cfg =3D EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
>-		mult =3D CDNS3_EP_ISO_HS_MULT - 1;
>+		mult =3D priv_dev->ep_iso_burst - 1;
> 		buffering =3D mult + 1;
> 	}
>
>@@ -2085,14 +2085,14 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep=
, bool enable)
> 		mult =3D 0;
> 		max_packet_size =3D 1024;
> 		if (priv_ep->type =3D=3D USB_ENDPOINT_XFER_ISOC) {
>-			maxburst =3D CDNS3_EP_ISO_SS_BURST - 1;
>+			maxburst =3D priv_dev->ep_iso_burst - 1;
> 			buffering =3D (mult + 1) *
> 				    (maxburst + 1);
>
> 			if (priv_ep->interval > 1)
> 				buffering++;
> 		} else {
>-			maxburst =3D CDNS3_EP_BUF_SIZE - 1;
>+			maxburst =3D priv_dev->ep_buf_size - 1;
> 		}
> 		break;
> 	default:
>@@ -2970,6 +2970,43 @@ static int cdns3_gadget_udc_stop(struct usb_gadget =
*gadget)
> 	return 0;
> }
>
>+/**
>+ * cdns3_gadget_check_config - ensure cdns3 can support the USB configura=
tion
>+ * @gadget: pointer to the USB gadget
>+ *
>+ * Used to record the maximum number of endpoints being used in a USB com=
posite
>+ * device. (across all configurations)  This is to be used in the calcula=
tion
>+ * of the TXFIFO sizes when resizing internal memory for individual endpo=
ints.
>+ * It will help ensured that the resizing logic reserves enough space for=
 at
>+ * least one max packet.
>+ */
>+static int cdns3_gadget_check_config(struct usb_gadget *gadget)
>+{
>+	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>+	struct usb_ep *ep;
>+	int n_in =3D 0;
>+	int total;
>+
>+	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
>+		if (ep->claimed && (ep->address & USB_DIR_IN))
>+			n_in++;
>+	}
>+
>+	priv_dev->ep_buf_size =3D 1;
>+	priv_dev->ep_iso_burst =3D 1;
>+
>+	/* 2KB are reserved for EP0, 1KB for out*/
>+	total =3D 2 + n_in + 1;
>+
>+	if (total > priv_dev->onchip_buffers)
>+		return -ENOMEM;
>+
>+	priv_dev->ep_buf_size =3D priv_dev->ep_iso_burst =3D
>+			(priv_dev->onchip_buffers - 2) / (n_in + 1);
>+

I think you should put here or in cdns3_ep_config  some=20
Limitation for ep_buf_size and ep_iso_burst.=20
What in case e.g. UVC (1 OUT + 1 IN)  when onchip_buffers is 52 ?
As I remember you have 18KB onchip memory, so in your case it will
work fine.

Description of  EP_CFG. BUFFERING:
Max number of buffered packets The maximum number of packets the device
can buffer in the on-chip memory for specified endpoint. Valid values are f=
rom 0
to 15 ....

Thanks and Regards
Pawel

>+	return 0;
>+}
>+
> static const struct usb_gadget_ops cdns3_gadget_ops =3D {
> 	.get_frame =3D cdns3_gadget_get_frame,
> 	.wakeup =3D cdns3_gadget_wakeup,
>@@ -2978,6 +3015,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops =
=3D {
> 	.udc_start =3D cdns3_gadget_udc_start,
> 	.udc_stop =3D cdns3_gadget_udc_stop,
> 	.match_ep =3D cdns3_gadget_match_ep,
>+	.check_config =3D cdns3_gadget_check_config,
> };
>
> static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
>diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-ga=
dget.h
>index c5660f2c4293f..f333c34b93ffb 100644
>--- a/drivers/usb/cdns3/cdns3-gadget.h
>+++ b/drivers/usb/cdns3/cdns3-gadget.h
>@@ -1094,9 +1094,6 @@ struct cdns3_trb {
> #define CDNS3_ENDPOINTS_MAX_COUNT	32
> #define CDNS3_EP_ZLP_BUF_SIZE		1024
>
>-#define CDNS3_EP_BUF_SIZE		4	/* KB */
>-#define CDNS3_EP_ISO_HS_MULT		3
>-#define CDNS3_EP_ISO_SS_BURST		3
> #define CDNS3_MAX_NUM_DESCMISS_BUF	32
> #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
> #define CDNS3_WA2_NUM_BUFFERS		128
>@@ -1333,6 +1330,9 @@ struct cdns3_device {
> 	/*in KB */
> 	u16				onchip_buffers;
> 	u16				onchip_used_size;
>+
>+	u16				ep_buf_size;
>+	u16				ep_iso_burst;
> };
>
> void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
>--
>2.35.1

