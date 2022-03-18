Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B264DD663
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiCRIrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiCRIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:47:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4317C412;
        Fri, 18 Mar 2022 01:45:45 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I5K0qN002535;
        Fri, 18 Mar 2022 04:45:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3evfqpahpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 04:45:36 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22I8jao1020529;
        Fri, 18 Mar 2022 04:45:36 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3evfqpahp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 04:45:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXq9QnIz0AR5aU2FDR7MP6vOnNR2MhWfQaxvPR+mnSDYUqFELX9y4ZEWjoE3X3/Qe8QAlz9ewghGzfz3lOUOewGGDt5jey5rx3bLrSfpmxS25yWh35NvGkSv7cgAX4Qd33xwQlS//melx+EDFXHD2JyVA+wd/vbbaok1OO5qpMN1u8Exo/COk8NbZwZfzAQ0tGP8Tf+APgWPOpRlNvMDH+NTa6Z/ATJievI5HK2AuTuYfM8+JqoCbiu1Qq+s5OvvG6oJMHTyaN9mtmg/kiIxzraL/uWrwlf3xtp0Sz7gAKNxribPwJbhQ8vJHkjOGFq5eqhnY30HuXQSW0Y3qsQknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeTJf+24FglM7pNW0PTb/Ikjo/MhuCEvVSWEITbSaHo=;
 b=lz5W0HvRgIilc0L51ad13Wez+/qA/ZMCsKh6VyK3xbyRZopVunn6b9o27GmMcCdXHQzPxivb5okdFLcMZ+oVQzzbDCzOXUWWCDgMG7hR0meRrgL2C1yPQe3xH8FlW6HivDC+TQywMrtmVlU/u/O9TvvbU41P4cvo3WFT/mGVc0CtW9Dxz/ILo3h7KylJQ2iilgfq4YFwAzj8tY/F118NAvkMYZGVQR2oxwPKdEaaML667o8D0Rpl5eUjjDuoCeIJt7pP5p77dCt7jsWwJ45qFcYfHGl2efgm1b8MrsuG8iB2VNp+/d73Ll1m20PK/ijqC2rpgK4MXPu+O6BbH4RlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeTJf+24FglM7pNW0PTb/Ikjo/MhuCEvVSWEITbSaHo=;
 b=oaoKpxg1Vlq62xjX/eq7diKFUuUZJ2+hoQj9Gmh+cWVGDGM4I/nNJGe6W/SCKbyWeZvC9RL8U3ALPjp5ZHGfomhRIBgTf8N8kaU+b5AL0ZyyH8nb5vxdXxwLZHV7Dp8DWD+6jtQOAEGqNzF+4zngA68jbUC9oS87+B8F32VwzR4=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN3PR03MB2228.namprd03.prod.outlook.com (2a01:111:e400:7bb9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 08:45:34 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:45:33 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
Thread-Topic: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
Thread-Index: AQHYOnLUWKUWx9O5c0SULrznBschF6zE0w5Q
Date:   Fri, 18 Mar 2022 08:45:33 +0000
Message-ID: <PH0PR03MB678617206D33B41868D565B499139@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
 <20220318025914.2614812-2-bobo.shaobowang@huawei.com>
In-Reply-To: <20220318025914.2614812-2-bobo.shaobowang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYzQwMGM3ZGEtYTY5Ny0xMWVjLThiY2UtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FiXGFtZS10ZXN0XGM0MDBjN2RjLWE2OTctMTFlYy04YmNlLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhYmJvZHkudHh0IiBzej0iMTY5NCIgdD0iMTMyOTIwNjY3Mz?=
 =?iso-8859-1?Q?EwNDQxMjk0IiBoPSJXQk1lOHZZaVlIQ0F4czNrMFcwMTNZcFRndkE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJPdzFpR3BEcllBV2c0OFEyejB4cFdhRGp4RGJQVEdsWURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff0b160-762d-4576-7351-08da08bbaa78
x-ms-traffictypediagnostic: BN3PR03MB2228:EE_
x-microsoft-antispam-prvs: <BN3PR03MB22287E75F655FA2A772B8FF499139@BN3PR03MB2228.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNWn5dsgecjTY8Qj0vDmsidGP7+B4JCXCFirgyFnwlBogWoU/IwHQho5D1HAlDtPIrKwwKopNEFJWAY0qa0Aoj7Z17CLb9S35ccq2WxaCzlA9mlj0Axd2TX8YuSotG10ZCvGyd4r5Wvh3HnxJXxf6a8D/5+jqrfm0ou9GxsLEjY/j948lD1cS8XEBJ0f4ubJ+yu+L3vCNLv2i4jEjGs3Ae9l+gPtftIw10Pxb7GuV/zvePfUnq+k9eleAGpd5E67JTQix30Z5bfSOZIy+V+MPIDwO5oDrQFzc4eEBlIGtsZbXC1gwU5qh9aekePwDiGB5dIIjS4m7Z/UM4dp7rK+6hLs7n+8HLLX0ZJw2GsM3J/ZxRDUDvQwmufEGumi8TnEkT1yvXRLHJTDLIqnsdStWp74iDpWlOFCGnR17L0+L5CTloBhUj4nnsbv5PueTLCM0cGPFBDi2+h4RU8axmQ9YIQbbx6+rNTiuN3E58ES5VK9oSjYzPKzpyvGzhbGEpASANQcMr33/I/QNxxy/p5nMi0A8eIL4/Lx3y+0nfPWmorDmoDTFyeMjh0AnMlBj2j1QcvYsxpvknImc0WDjkK2Uev6oV4yWumNEf16Mm8VeqmDI3efQW9S9stknU+xH1q8pTrVydq42p7s/4BW41oHaCrr6ho1c4W1ZbVdRCcGNZEKCT+7c4v0G1rnHjz7q5RhLek7/uMrVGjcQe4U+76EWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(508600001)(6916009)(86362001)(76116006)(66556008)(9686003)(316002)(4326008)(38100700002)(26005)(66946007)(64756008)(8676002)(66476007)(66446008)(54906003)(71200400001)(186003)(6506007)(7696005)(55016003)(52536014)(8936002)(33656002)(122000001)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/lBXWJMmWVrsZwlO4cG2u5RcGbQOcfkHJ1tCPqXXbdWpNkG4VsTz4FuepX?=
 =?iso-8859-1?Q?S/2vCnvebL0Fa1ktRvHGHOX2+5ATrpVkdehoxWMovb+95Srf7cEOMA6TJ9?=
 =?iso-8859-1?Q?nklP/3sy3DuuGwJ8XTXkUa4lJgE85V0Ob+1Orw8mztHhjz6UB4Qptf/QrQ?=
 =?iso-8859-1?Q?b6HLNqfZEFhHiCkgKTR/bEQ/23A248GS1U+xDRbFCKHHgJzJolSNA2pEa8?=
 =?iso-8859-1?Q?S/yOqmnRj9oBEpHtbFDAOzpIRzx54/15ePsWLF6BTc5RnCByJuzgF+Hj4N?=
 =?iso-8859-1?Q?zTUc0en5zR5IXpFBzmYkANAvnOyOU3QSWjnijYBTJdGoKd6AQDmIwhkGRH?=
 =?iso-8859-1?Q?YbzlYVmKKsU3ZLDSzAjSqbzeuydU8KSOcK27ay7ylHw+g0KIKka6tipvCo?=
 =?iso-8859-1?Q?Z4P0ZLX4J9WLiSmytbptCH5btzzKksSTJ9yJVa2KxNBaUaQxR+1RfJhOeI?=
 =?iso-8859-1?Q?cTKtkP1+LzyhpyoDk00dZZSK1U1aFeBAPox86YTcl38649qDrm06l4n9Z7?=
 =?iso-8859-1?Q?Lj7jpu2RxT51C456EN6IRbttZafXHxScPEpOmIfPPMXzlX1+pe+YiPg/9r?=
 =?iso-8859-1?Q?hGvN0DsPPEoanHQwqTGsroIzl5D98rVIiet/7txDS2yR4HQKF6KUvr7BD3?=
 =?iso-8859-1?Q?qy2KOvfNshGgEdtLOvrnfmw2WioOMSfNDoynw072KjII3xJ2EYQljKkiYD?=
 =?iso-8859-1?Q?uQnaOplGRRLqj4Y3k1x+H2R4TNyZjaSmDxYybgk8wiYJcHxl9CqBlKpqVO?=
 =?iso-8859-1?Q?sTc6ASkV6ulVreH2zrJM63Vjpq5Sp9qc/YL774bo6e2kSa9LvY43U15pb7?=
 =?iso-8859-1?Q?ZUrJ7CIw0nWnXlJJhISDJn7ky3mA2RCVr6ieYr5G445lLBLpI4VqO0fbbC?=
 =?iso-8859-1?Q?pWz5KF884QS7GD2DZp+XOU14ffWv9cb6Y3WCfXUFJiIAJE15gOYnLsVDql?=
 =?iso-8859-1?Q?EkPLejoGTjXX4VzYYWnAi/lYR8SxkERMgpdYK53BW8/nZZojx71TEtDdDx?=
 =?iso-8859-1?Q?37bgah9gx5u+gwCVRzwjM2NWgCD1LdrecLwy/aP9pQOrcAdJ0jxnmqjt8E?=
 =?iso-8859-1?Q?xmvFkjAX1bdUPvSoAuy+sugw5kGc0aAMxWYjxJK0hHnor03seJoWw3Oxqw?=
 =?iso-8859-1?Q?GtnoEe6toR+zdxB4lv0lmbchAzKCD5AFW4nE2cS1ReJqJrFvAwxYUTYt5z?=
 =?iso-8859-1?Q?Hag3C5ytoOvHNRTYljFEjXduk0Hq+KXz7rjLbocgjpVZPV7C/cg/N745Ha?=
 =?iso-8859-1?Q?tumDUZGDY0IdwJ7nU0QjOPok5FGcpquaN+cfzrjVfqokbsKgfTWaUS+U5d?=
 =?iso-8859-1?Q?EWmtZQhxkI90GIM7Bh/+nFfYK3BGbXmaZhvePQOhjtPCRqJQuzjz9AjwxW?=
 =?iso-8859-1?Q?aHZvoaxmPPmhXx3kbgwEqWE5r2a1d1iUVV64WSPckgyzqD2lLpD3zmLGfC?=
 =?iso-8859-1?Q?xVvV2N3Og1TupFaKR4PkfqwCCrTz8Jf1x2RCu8Q/G+AdS3kTFrdowQqMLc?=
 =?iso-8859-1?Q?3PMYG2hOs2WVNn7vAOQQ5O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff0b160-762d-4576-7351-08da08bbaa78
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 08:45:33.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbPcqzN0+bAEFHNmb64okWU7T8Wl96ODZkJLMNauHxOoIHepEIo3JoW3oQBS7VIaPqnIbYkWhPd4koXzjJLfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2228
X-Proofpoint-GUID: _U470MhC9pVhvhAKsflxnZLPc3KpcBWB
X-Proofpoint-ORIG-GUID: y8K4SrzpqJ5hj2QvTqloLzBT31DfNLsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180047
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

Thanks for the patch

> -----Original Message-----
> From: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Sent: Friday, March 18, 2022 3:59 AM
> Cc: cj.chengjian@huawei.com; liwei391@huawei.com;
> bobo.shaobowang@huawei.com; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; jic23@kernel.org;
> Jonathan.Cameron@huawei.com
> Subject: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
>=20
> [External]
>=20
> Add "depends on REGMAP" to CONFIG_ADMV8818, because
> admv8818 driver
> uses structure/symbols such as 'struct regmap_config' which are
> defined
> only when CONFIG_REGMAP is set.
>=20
> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/iio/filter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> index 3ae35817ad82..4bbf10f8692c 100644
> --- a/drivers/iio/filter/Kconfig
> +++ b/drivers/iio/filter/Kconfig
> @@ -7,7 +7,7 @@ menu "Filters"
>=20
>  config ADMV8818
>  	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass
> Filter"
> -	depends on SPI && COMMON_CLK && 64BIT
> +	depends on REGMAP && SPI && COMMON_CLK && 64BIT

I think the best way is to have select REGMAP_SPI. Hence:

    depends on SPI && COMMON_CLK && 64BIT
    select REGMAP_SPI

This will automatically default CONFIG_REGMAP to y. with your
patch, I guess we can still have issues with ' __devm_regmap_init_spi()'

- Nuno S=E1
