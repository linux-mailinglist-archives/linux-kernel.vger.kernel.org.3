Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E41537909
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiE3KLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiE3KLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:11:47 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517D65DF;
        Mon, 30 May 2022 03:11:47 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U8oqmn005241;
        Mon, 30 May 2022 06:11:43 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gbdk54upn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 06:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR4ePtfYYT2lVNRfkZ6c5zKCSv8SovcXZIEed7EMOJ+0XLODFB2MylquPUtoe2ER6hLIxHBUn3pnU86LcNjeZ0CR2Z6aVkYrfbuJNcThIfRoO+ICHp4BFWEpXv3zacS+Ycy0GR8pwykKMypEzJtTRgoDa2mUaasZ4w0nYOAupzEyA3chjAvU3lZ0Tmt6dc3uX41wnnrsLrsSLEz9jLbHOb3pmcHpfQMs1ZQb5B/GSpyA3413nuzl4rIadzeVvPApinQkflkctW1KmPnPMPcUgwC3gQ5hauJapneY1z/kz+ElX8YC7qvO71pWrPaUd84CYMtwVZXA6GEAk2nGUmlnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLI9BVR5+DMEZm+tZn2Juhp1L2uE7AB0jYMaejlssCA=;
 b=HCkGe0/a0ar1k60yYgOHXTvWBYbq6mu8K9HPafm/DpfbQGqyAEW2T6MQkGhnPHdtG8VQMoUvCHQoTbYQSjS4XEiHa1fUvRQJDoWY0tX8tkbWHVaJxzjP42QfS6eFP9nMEoKOnic4uvSJLH4AgSUfFXjbEj7x/uI1ddcgUJndHrIt5BMrjpoNM5ThfbfTeTQ0pmqcLPQPUmXsL23YcVFozseMFZE9JuqTim63naegQ5CAZx3uv2W0UqN2+82/NsvYzJ2VLResJUS6Nx/Yf66J26ppeyL9kQ4roGCks0E8VOOCGk60vSzshWu5quUfMmO+0iEwFau0s2Qii/4AT3kRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLI9BVR5+DMEZm+tZn2Juhp1L2uE7AB0jYMaejlssCA=;
 b=dE+o3WP70fQEgqa2YOTje8iVfGnUb5DLUjwWlIFxKlqXyMy4QJRupNLrUkq7Ieo0xWeqqvrLkWNO+Jjj0ME8D7dUuODoVPt+aX3ZpqDUdBGqxhLxsMWpULduG3WhXF2Pgi0TukFq3oTUDa/QkuBKBCpIF0aQfmBaMp+0ahQwttE=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by CY4PR03MB2920.namprd03.prod.outlook.com (2603:10b6:903:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Mon, 30 May
 2022 10:11:40 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 10:11:40 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] Input: adp5588-keys - do not explicitly set device as
 wakeup source
Thread-Topic: [PATCH 4/4] Input: adp5588-keys - do not explicitly set device
 as wakeup source
Thread-Index: AQHYck9UeYaGFflcA0CXsbBmXOprFq03NpJw
Date:   Mon, 30 May 2022 10:11:40 +0000
Message-ID: <SJ0PR03MB6253063976AAAB80769049918EDD9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
 <20220528045631.289821-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20220528045631.289821-4-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1lNDEwZjc3My1lMDAwLTExZWMtOTJhMS?=
 =?iso-8859-1?Q?00ODg5ZTc3Y2RkZWZcYW1lLXRlc3RcZTQxMGY3NzUtZTAwMC0xMWVjLTky?=
 =?iso-8859-1?Q?YTEtNDg4OWU3N2NkZGVmYm9keS50eHQiIHN6PSIyMTE3IiB0PSIxMzI5OD?=
 =?iso-8859-1?Q?M3OTA5ODMwNDcxMTkiIGg9IkRVVGFlQ3FIRGJmUHl5em5USkF0dmxwL1Vp?=
 =?iso-8859-1?Q?az0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBRFA1MjJtRFhUWUFUYm92YjVZNXorak51aTl2bGpuUDZN?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 711d6f15-b987-47ea-a7eb-08da4224ca37
x-ms-traffictypediagnostic: CY4PR03MB2920:EE_
x-microsoft-antispam-prvs: <CY4PR03MB29207E6B224156EAB84A54808EDD9@CY4PR03MB2920.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tA0Ok5ZSd3mA6EIIUwkDmfaIJ3xm0IaKLyhgK6nM4uChN2ujN/RiSoEa95H2Hyno5MhD8Xbg2xwkUDRK9Kvlhw3y4xuiTlC6E+3FtDE0CduniiQ8NEfkAY5azon22+qYStk7kOkf+WXOZDHJwVZsIe+XpGHSAvT3w8iQLxfSvmFoZnYaHtYlEhTBLPv70okqqdwqJQ+8HqsleqJxfNe7GaZRcSldvd1cv1TqzZ8nNRPrfNW8L1q1yTnKr3jOXsyVD0o2BfKmJf17s5DWZfxMBNwTksn1MswojouUCaDGgxBf+1C6z7/GAJZ3FK+QOnBAJ+lS3tfL+Hy0+C0dkuejdN3oAnDn0RcAFDw68n3rmqswSI5lqZFtpECI/rWHmKJlO2+tjExnOE9WF6iEJ02OyKxXA5uvfsZene90wR40eES2Dz7ePkT0kNwB/9JRG31inUCoRrIVyuuJoeYguoAW8+hP6kpYHRCSLR5Nn9q6RhnXTqJoVPzZhhv+q1ftJdoPoKUGGaL5ASYTd8QG+yRLLQ99fVPxgDsEezfgU8uaMOiULUvBzwGqcT4YRRa+aZ7O8zXRnYv5mN7zIqa7H90PpthJpU307Sfv4VgSm2K6mt0YPbKXsELFPsQpbc/jZBa5yQ5b/nDfbQxb8u8iFDkR4J96c3j4BrwaRdtJPq6hEYcRDYfrMs3nCgg3/RREZebTioATHdJfE184wnEHEff88A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(2906002)(71200400001)(64756008)(66476007)(66446008)(66556008)(4326008)(8676002)(316002)(76116006)(83380400001)(33656002)(5660300002)(53546011)(508600001)(38070700005)(122000001)(6506007)(55016003)(186003)(26005)(7696005)(86362001)(9686003)(8936002)(52536014)(54906003)(66574015)(6916009)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6iM5rlvg5CbzI1Ggsq2+LihU+w8aaiODO8i5cINEC10vttvK5FIDAY6owB?=
 =?iso-8859-1?Q?WxORHhw0/VVArt15sOhh1UghAGbGKWV3ZwmI0xJ8yBlqF75dkfEMT/GwK/?=
 =?iso-8859-1?Q?ZcShMOL0rAjYNM3ukPzxkJsftj5DUkrv9xJG4YOz0I28B2oD+NZZW5JVTl?=
 =?iso-8859-1?Q?kOHNTIdaTtXqgn5C5e2ohcSRGB9BF3ohqyfI2U0kcIKCqBh+McXJf1xJC7?=
 =?iso-8859-1?Q?/SOJZlGp1e+g8hS2oYgGLOs9+4asprZUBez/HShA00jBD3rzvCUdkcUTOL?=
 =?iso-8859-1?Q?rd6uSXEI3/VlfpMtQSz+ylE4rKgxPl4JwV1sx5IWxAvemkrPGy1p3vPhDL?=
 =?iso-8859-1?Q?QtlkhEbDjLHo+Hd5Q9VyRA07owrcXYgZ+QQFMs0qxYuJcg/GwygnKeo72B?=
 =?iso-8859-1?Q?h70UDss1dkW2nQJAjAJlxqah598q+/LrVamCfsY4M6a+Wo/IiNK5tRiX5g?=
 =?iso-8859-1?Q?BzbHfFjojGJs1DyaRuMxCumGoybW+16KrUCCkj7bjYjyZpexffQhC8aGLJ?=
 =?iso-8859-1?Q?CzIoD/d5Hkxf/mw+Sq0OhT7vvFLdLpaJYAvE4P/MjlJjfOB7rvWx26kg38?=
 =?iso-8859-1?Q?yp2himcommb40D0SGxhFPIZk6+RsNW7QVVC5Fs8VNrS8VRsrFx+6xr/Cwe?=
 =?iso-8859-1?Q?qsf/UGn6PuCdl5vRm70YXdUeO+agilcOxvZ0YDbcqmEWSQMTkqUA/GTvZv?=
 =?iso-8859-1?Q?2/KOTZFWg9NzRn1soQDK2hPUdlt1AAA9wD5z94X4ktUT/n1/nQjgoWeims?=
 =?iso-8859-1?Q?pY4TAKsUeaINu2IpytDDkjCuisEJyJrOq9WWUiwwhkyTYxQ6QGBGyKbYz2?=
 =?iso-8859-1?Q?pP3+DHYlXatctFlbsf5PL2QorjSfbDO6hEla+oy79jh48Eptxbgmb066sQ?=
 =?iso-8859-1?Q?r36HctuNWV7jQtKADPrU2gaIOPQYcH/EiubtX+eUxH0H3dDYGI2EOMI3aH?=
 =?iso-8859-1?Q?mCJIT7Pde8P0TPyBEEQfDFXr5u+BbBG8267dSNdLEXonWvQFMMnvWDyL/j?=
 =?iso-8859-1?Q?arbsYd/OqKRwK1MGKwV8C59u1W8ZLCW98o4vYW8w54pMvhMd6OAC6Tux0g?=
 =?iso-8859-1?Q?S5FKRbmMS+Z5wZ5xFjTvpSxzE5wfobpr9sGGbp4lPZF94X+gSGL5Tbp/al?=
 =?iso-8859-1?Q?WKuDObxHRfY41hX8GL+stgtyl9k7kI7EW37REzTf/qQKF+brDP5iBqmkNU?=
 =?iso-8859-1?Q?wu5/FFtCifDzj1epbEX1w/ZGGXntJ2a2GT2pxIq1khPEsnIX3CuSTZj/x8?=
 =?iso-8859-1?Q?JkFZHtcV562+0AfGyZclKxnjdn4KyPUZj5fst5sS4nkUln1k7aqmELHql9?=
 =?iso-8859-1?Q?+KZgKTYHa6qjqIOrn8hoVYXSDcqpLZDXVefPHZcq2+tJ42iOca6aEHi9Mf?=
 =?iso-8859-1?Q?V/UhV/s+Sv4XyMGad5nAjrJkdXvI36W4qMxNAXjrBK1KD3tlJkxPCcA63J?=
 =?iso-8859-1?Q?Ep/qOAhI1LRECuUdQxFq7gyM00ND3mtpgNOhpKqVtt+FOIaTPl9wOECl76?=
 =?iso-8859-1?Q?liq0TjF1tmjgzggkByOzP1VGBX768GGIVjCtQ3Kuj1zasOqTeTYLJs+hQY?=
 =?iso-8859-1?Q?gB0btduzAK9pu9QRyQRduddoG4oaDSiqQPl44/pZFPDiry/Uww7L9s0WmG?=
 =?iso-8859-1?Q?gi0gJy0yGJIe3y/axz+i110+Pp/yQjUGdEJs57tnrGGUXWYfYUp6X6vsvF?=
 =?iso-8859-1?Q?zEIsyUbMF19wWwYtbre+2R3zAjKv4Hdl1pqUmWjdyg6yuMApBFMr+uOQwZ?=
 =?iso-8859-1?Q?wz2k8Mai9bnOKafVJ2K5xno9U/uYV5+bnE3fS61pxAgfW9RCYqsH183DC2?=
 =?iso-8859-1?Q?/vUpclm0WEEh4HVJf/cakzYM682s6NU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d6f15-b987-47ea-a7eb-08da4224ca37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 10:11:40.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQbQ9/bCOXnxu1+3eZtGOi1+zrbUd6juEPBE2LcLQMLtAws+sz57kCvrnStCEHtgnDPvqFwZTKy52MUe1wb68Nhfr838uZCNZGDRf7rv1f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2920
X-Proofpoint-GUID: AVy4UM2HyUdBJXalsnuhCS2qKGlwcVPE
X-Proofpoint-ORIG-GUID: AVy4UM2HyUdBJXalsnuhCS2qKGlwcVPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 28. Mai 2022 06:57
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 4/4] Input: adp5588-keys - do not explicitly set device a=
s
> wakeup source
>=20
> [External]
>=20
> I2C core will set up device as a wakeup source and will configure interru=
pt as a
> wakeup interrupt if client is created with I2C_CLIENT_WAKE flag. Let's re=
ly on
> this facility and to not unconditionally set up the device as wakeup devi=
ce in the
> driver.
>=20


Looks good! Thanks for the cleanup!

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>


> ---
>  drivers/input/keyboard/adp5588-keys.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index df84a2998ed2..2a274240facb 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -589,8 +589,6 @@ static int adp5588_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>=20
> -	device_init_wakeup(&client->dev, 1);
> -
>  	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
>  	return 0;
>  }
> @@ -609,9 +607,6 @@ static int __maybe_unused adp5588_suspend(struct
> device *dev)
>=20
>  	disable_irq(client->irq);
>=20
> -	if (device_may_wakeup(&client->dev))
> -		enable_irq_wake(client->irq);
> -
>  	return 0;
>  }
>=20
> @@ -619,9 +614,6 @@ static int __maybe_unused adp5588_resume(struct
> device *dev)  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>=20
> -	if (device_may_wakeup(&client->dev))
> -		disable_irq_wake(client->irq);
> -
>  	enable_irq(client->irq);
>=20
>  	return 0;
> --
> 2.36.1.124.g0e6072fb45-goog

