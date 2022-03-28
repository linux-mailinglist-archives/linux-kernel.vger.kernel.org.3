Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5BF4E8F47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiC1HvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiC1HvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:51:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7252E2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:49:24 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S3vwu0013293;
        Mon, 28 Mar 2022 03:49:01 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vp6cdaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 03:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLSdl7RjMbitXF4lOmqFW+8eSmVZp1YRY0BdksqZSenebjxYzSIbq+MYzRFw0fN1KaZxk4Z8orTaBgKYMfu6i/Nm+UKpG+E/Mmryisr0j+YjKR0zHx94iO9qqNENnuit5JRnQVjTWJYqpbsyuQzI0dJ6qiV3RAVmiwyNw4r94cGEwJn30kelC82k0uN3V4jF2WISVxIOIxNxfp3u8Ptj9HYq2Obw2lcQOodPx6feLQuu2zIrGvuoIpe3GNRjzwV5aOX7SxKUwm4xj1tSQitD0UjJhKFUpPUWE7URas+kunoPygAaiatWquE1v2on2dadeX/KUfxJKuYVfVOeg9x1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6NvK333tyI2WWWKyBV50NNKgLuXrvzdB+wQx6/v9x8=;
 b=AdLBGc/LDN0CMyomI6HTa0k/hRI+35on2XmWgctp4ozIJz8Cs0UhavD7hBWPyy5hZUYeyyqO3n9YqKvLslxQBRpuRMeQLKW49HPcxoroWNmDlJ4rPprmCkB3kWQNGidzgIZPXaIw3dUSOQzWzexBuMKh2qLYdLSXEzwLxPSSKjl3rnvzdJSCSCAV2NwuXM2DXIPBY9qi5ACzYyNXAh3uUTE3DmV5J2l7hkRc8n3Ma8eQ96oHbXWu95jSq3hkmVYfrsmo+8Bi4wpObDTeSIJP28ZJR0I2WtpYLx9vIMxCywhjsg0PX9GmyUoQ1UsYjz+U+TaJDTvq1YeEXRBey5bzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6NvK333tyI2WWWKyBV50NNKgLuXrvzdB+wQx6/v9x8=;
 b=Z/4FUMYrFP3oTEXM2oEGnpvZ6WhXzozU+xLXs+IjsVWOoi/xZdlU0dtW0inXKmsYH+upgZZ8xNbFJeErKSryWRUt5bAywhB3S3yaWknsjvbX6Umnqa1BvNVQQ4W3qPCm2ww4MQGV1dukNJpu5Bz4qocHKelksS3tpYVjiQrJ/c4=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB5210.namprd03.prod.outlook.com (2603:10b6:5:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 07:48:59 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:48:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Stephen Kitt <steve@sk2.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c
 probe
Thread-Topic: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c
 probe
Thread-Index: AQHYQGkcH5RfJWwew0eL88arhhYAHqzUbtfQ
Date:   Mon, 28 Mar 2022 07:48:58 +0000
Message-ID: <PH0PR03MB6786E94CB17A696BEF236B8A991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220325165452.1212975-1-steve@sk2.org>
In-Reply-To: <20220325165452.1212975-1-steve@sk2.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctODRlOWU1MTUtYWU2Yi0xMWVjLThiZDMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDg0ZTllNTE3LWFlNmItMTFlYy04YmQzLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iODk2IiB0PSIxMzI5MjkyNzMzNj?=
 =?iso-8859-1?Q?Y0NzkzMjYiIGg9IlBSbWZwOVhEWlh0T3FJZEtGWG54UmlSYnQrMD0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBRGVnVUpIZUVMWUFiUVR2WEVnbm5BK3RCTzljU0NlY0Q0REFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe0c039-02ed-4aa5-c3db-08da108f6b14
x-ms-traffictypediagnostic: DM6PR03MB5210:EE_
x-microsoft-antispam-prvs: <DM6PR03MB52105C3C700332A8220F2397991D9@DM6PR03MB5210.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ugMTKncS3Kw2VDfEDJbEoWAKi+iyPREGvu/Sdx0MQLE5Zeba+3uB8hPVRIchZcrvcVV5UYcaBOaIlxq32ARcano+FqF64BQko7acHxeCTFwioxSK3dj1mm+avCoSilX/1eupbi/ZzDwTl8t5+ekr2keW1EyRXQ7WQy/UX5lkXR8YskcUH/Nvc9JixcM/f1MJYL7UfVxscajSM100keCHifpjAYa55qYEKGJUV97AAY1FLMhocOWF18ASMbvnKzTmQBx3U+w3L5cLumPQV2nhVlHYDk1OvQgtemfy+nL46tktZhLJvi+CgYLODKVoOTC4ba6Q2O/5cZx1GQmuh1TRS+A0tQVfNJxr/Q1Y410CyPupZ3PdMYA3Ion37U/3zvatUosn89hKVs185VVX/JaZy0GG1h1GvaWzskMdJZS6+UydSb4GAQeFWyy99sWdU5JQWG/foIdKT09n/uUAftXIe0xdLYgjU2h7pCY9xvKeczZjarM6VCgMy71qwTZ0Nix3M9wJ0JnFq3ea/Fn07AUi3YaZcANTuSOu6LfxcKhr8Tv2my9sA3G/Xj25k1/FwWpDEwLTpsGUGCDUuo3zZdAQpiLwt9WstqFHmdcv429PMSYC7X9Dd47SsOKcMY5P7aUZqZVQvg1LEJnMKQjGvDOImoixtAqFKxckXeg9aosIsOQN1qR4/x0ISFbyzJzodwDLNjueX2osAwdx7Xbmziz6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(186003)(52536014)(5660300002)(66556008)(66946007)(66476007)(64756008)(86362001)(4744005)(6506007)(7696005)(2906002)(26005)(8936002)(9686003)(33656002)(316002)(54906003)(110136005)(76116006)(122000001)(38070700005)(71200400001)(8676002)(508600001)(55016003)(4326008)(38100700002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LluiRXPS2uXhC/2qiJS9Q1baOmNnTv4w0bhnOeuK7dvz0tkTZNvPu9oEM4?=
 =?iso-8859-1?Q?h2uWib6uqtaa6NX6YXFjv24QaxxBeiZrsqVa2pTLn5rkv0RPW+x/QO5R1R?=
 =?iso-8859-1?Q?OmKM8biSWVTXbCJhwSX0Lj8DHRAiN2HkakdQ3sv1m6wdWGsonWWtL1dTbl?=
 =?iso-8859-1?Q?mZe329RadhSGzjNkC2vERauetRfZtJeAKwQp7r1sAr3lYZjScXHLqt11ST?=
 =?iso-8859-1?Q?U3nlqSr5gShgKqfHAHocinXW834OeqSjXZIHK/9lCxKglH46wPx/DByMok?=
 =?iso-8859-1?Q?7Cu+Krh4K04MLpStjuhRa0n4Atl4WuGg6WWR+SKSQNEaR5p16jOniVuGtq?=
 =?iso-8859-1?Q?RjY6BLaZb1GFLrQiqXi4Oj9KxVNbja3Fd2RhH1Oe/N3AQPIlaH1y9ycRGx?=
 =?iso-8859-1?Q?vN1UvkF6mbY+HvXhkqwK1bRLLh7JyqnnAMI5cRC+VADNBjAY7mgTOJ1sXH?=
 =?iso-8859-1?Q?0aGxwVw2Yq1NTAu9igYuL1v4ToD1K+67AiHl0UbvgV/H8O/xkmqxXGG9oE?=
 =?iso-8859-1?Q?08JYFVV/cLmxQXfPZTsH7xTodaDk2sCWfQnzJppF/wIumMIT0BW1ZNBDDP?=
 =?iso-8859-1?Q?9HD/VBnHwIo4zg1VCI4ceKRczz8kqBuhziHlHeZNQesabg1P3eeP4W01wQ?=
 =?iso-8859-1?Q?hFXz++HyMbF/9pIYDrKZrnJtG4Q/yWztWVzZVcAq8VJGe/RqQw0BnkywOH?=
 =?iso-8859-1?Q?fXTyI9wmpJ71Ik5dsocl140rJfhPYSepRjJezvOov/SYckdXSnw0rU0wr4?=
 =?iso-8859-1?Q?dtP1EZU9UtKqmGotXWZX93aNQE9gLrrSdPo1VcMK9vBYfYxJtC6Xvpn6ut?=
 =?iso-8859-1?Q?SkCIO7FaSIolHeCVAzp56ZxVF6DJr6aFt3SYTObnN1DwfKvxkwuWXukytD?=
 =?iso-8859-1?Q?S6q8KO2B5VvuDNCWyfdgSLVIPRuSaj07L5kXmv4tUJvRHxbIHJoBG3aK+i?=
 =?iso-8859-1?Q?tOHN2Dlb3rq8LtubYjDlNOLk8Mk0xYDiS8lOYKMXocZ+bANPo7ieSBZZ6r?=
 =?iso-8859-1?Q?6Xn/PyOzK1uuEziP6Pc4Ia+WJp1gxgdcBiLOx747b6JJH4ym687FBM+Zy7?=
 =?iso-8859-1?Q?olmmzlid0g5e0W9tJvBw//8NYhlAGD7xrYatN3gVbfEhT1NDQbpRZ3LhFK?=
 =?iso-8859-1?Q?DaKXVrCDci0rOfWxoFHgFQeG9XfhxE7BX2pZCZRIpvRcc2G4s/KNQ6HdSf?=
 =?iso-8859-1?Q?WmTTxMbJGnCzzxEG4tMooibvfV2N/sijcgrZXyn0EZFtiL5bUqQJRyiLrB?=
 =?iso-8859-1?Q?ygVkxDY5MrrcmvdTo7QuPBfUULjH7DK/mFz5955qSKlvTHnij2s6hOrt8U?=
 =?iso-8859-1?Q?5jaFzP+6ewpR4YKEl1v0/3Omny7qjpCTJslco3inY1hzk4eHn8Q9NJTAyj?=
 =?iso-8859-1?Q?/MxLOX2h13E2EZfsTToMF9gapQhKXF1pP+OBV3PGSDDzB0+DfrNbYODvKO?=
 =?iso-8859-1?Q?lXfgVLS2Sz569S2j5Egotd3N0FJjimBmFDvYUChAFJ7ZB7R+mpFu3Yg/VG?=
 =?iso-8859-1?Q?z4WOjK+WBtm8k7imtIvRA0VfpchoJzYzv9QJUhX3AgojhJzKVOPow2UCY8?=
 =?iso-8859-1?Q?qcLH3chU5U90xPqch8LMOx2+SZYa4XTXpkRac0YH+kzs0FFkaPv8gKAy7i?=
 =?iso-8859-1?Q?3pM+DuM6auCL7yGvNQxSS6LfVjYXpCiC4rcEFQvc9dTjk1fv59hInT1mLN?=
 =?iso-8859-1?Q?02Z+GfIXfrVxXAGDsdPfOPiP+2Tk4EN2+Jm3f2MtY+5iqcuOBDGWe4B/Ei?=
 =?iso-8859-1?Q?YK5g43sLo3A7iUrYILWS79B/zmG2zLOWuTD4os5ir6HODLLX2pFxRFxnX4?=
 =?iso-8859-1?Q?S91m5iDLnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe0c039-02ed-4aa5-c3db-08da108f6b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 07:48:58.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JPO0xVo4v1L1bBKmv0bc/38Pq4hIPVOTf8UgC8xF4P2zTZ87/N+1td2pK3DbrG0YhdhYrMdsNgfhQbka+yCpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5210
X-Proofpoint-GUID: x_g02FiaRGYgty3duHx69bKMYoaFhIqA
X-Proofpoint-ORIG-GUID: x_g02FiaRGYgty3duHx69bKMYoaFhIqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=839 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280044
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Kitt <steve@sk2.org>
> Sent: Friday, March 25, 2022 5:55 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Sa, Nuno
> <Nuno.Sa@analog.com>; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>
> Cc: Wolfram Sang <wsa@kernel.org>; linux-kernel@vger.kernel.org;
> Stephen Kitt <steve@sk2.org>
> Subject: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and
> simple i2c probe
>=20
> [External]
>=20
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

