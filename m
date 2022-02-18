Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE14BBAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiBROsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:48:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBROsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:48:30 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673C21E0F;
        Fri, 18 Feb 2022 06:48:13 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IEPuMa031135;
        Fri, 18 Feb 2022 09:48:05 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e9fu17b04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 09:48:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TflB7ZUomaxZylcRt5RVa6u0CjRP7qLZR2w1fM0bVDssdCHewxsZnCUQABIMXe5OhRV7nMAPWNnD1MLpRENM+kiQ/RY+hck9uYsLK+/LIPRNlw8NWxU2ILMfZw9lWNFzSGfwEccyzCWbPQAnr+iaBejV+LlayPIMyHokOubwGPt/1IA+EvV6tyvEowzinu8uqLun4ED8hFfIPBI4JQ+D+nRaKwKULm3hUZ6i8DtTNf2xw7RHJxrnlxvgeVRkYo+K3l6T4kvusD3N9Bz/yCnlWSXUV9XIEG/+fSGrLQqvy+qJorgTtSyIXsUwmP5xRBHtI8/9068P1ybQFuZjgJymkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAYoSbikfOgwr1jaQ6MUSgJxrzxb7Xo00pZGy4gcCdU=;
 b=G79axK7RiA8QSDIFu7/p3QXD8bZhdeX3p/WfsUSxZlqGwbtIPEihtLe/AQM3maAqT4ZDLl8rpJCJpXz0t2uuMmwLQLQ5v1bt71VAtMbmnA6lemNdZrJWmtBbXMI1B2im88zQtEZy4+kM1eUjAVJ7/fCKwjMhIkEA7lw9qiVo+5447tK2qNHq5pfE8Ntq6PlqVtAdsqbXAW6dS4YU3hieRTswRTvxLTBP1f69xwwT5w5I73Yjt3Hu5SwIGiS0UIGkGU2lX/W9AEDO4S6UDCr8C3SweUC7MHjAlLq3U507BbWO33SBeW+9L/NQB1AaoUnBE1RFyUGkGgwWrgSnW48zbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAYoSbikfOgwr1jaQ6MUSgJxrzxb7Xo00pZGy4gcCdU=;
 b=IDkXTAWPt30Zwx1lMrrhz7NQs8nHHU+HcTspicm5MYNkBbwp6hvhtmoVYT0Z1ek+jidAm4uYZjc/F1xVi+RMOKhJMmjsGK/FlBKjagFdUSsV9iPhVEyBA6uAZ3Pi+8BYTjLYc/VfvlSmIZf04OuBEiKZIqTYeDP4qE2xZIKQH0E=
Received: from DM6PR03MB3866.namprd03.prod.outlook.com (2603:10b6:5:44::10) by
 DM5PR03MB3145.namprd03.prod.outlook.com (2603:10b6:4:44::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Fri, 18 Feb 2022 14:48:01 +0000
Received: from DM6PR03MB3866.namprd03.prod.outlook.com
 ([fe80::9d71:f960:65fc:68ee]) by DM6PR03MB3866.namprd03.prod.outlook.com
 ([fe80::9d71:f960:65fc:68ee%3]) with mapi id 15.20.4975.017; Fri, 18 Feb 2022
 14:48:01 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Thread-Topic: [PATCH v4 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Thread-Index: AQHYJKuGBC8orEy7d0+Yjvi6QunEM6yZNd2AgAAglCA=
Date:   Fri, 18 Feb 2022 14:48:01 +0000
Message-ID: <DM6PR03MB386657B1B6A6D21D5026A257E7379@DM6PR03MB3866.namprd03.prod.outlook.com>
References: <20220218095048.86826-1-cristian.pop@analog.com>
 <20220218120355.4b7c33e1@jic23-huawei>
In-Reply-To: <20220218120355.4b7c33e1@jic23-huawei>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0zYTFhNGQwMy05MGM5LTExZWMtOWE4ZS00MTU2NDUw?=
 =?us-ascii?Q?MDAwMzBcYW1lLXRlc3RcM2ExYTRkMDUtOTBjOS0xMWVjLTlhOGUtNDE1NjQ1?=
 =?us-ascii?Q?MDAwMDMwYm9keS50eHQiIHN6PSIzNjg4IiB0PSIxMzI4OTY2OTA0ODk1NDAz?=
 =?us-ascii?Q?MTciIGg9InQ2T0tqRlBiVFAzTG94ZGtXekhZWkFxblU4UT0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FBRGRQ?=
 =?us-ascii?Q?blQ4MVNUWUFYU2s4ZVA2K01RRWRLVHg0L3I0eEFRREFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJm?=
 =?us-ascii?Q?QUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFa?=
 =?us-ascii?Q?Z0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlB?=
 =?us-ascii?Q?R1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFH?=
 =?us-ascii?Q?b0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32d477e-60b1-42a6-b037-08d9f2eda957
x-ms-traffictypediagnostic: DM5PR03MB3145:EE_
x-microsoft-antispam-prvs: <DM5PR03MB3145F879BB16A21C447B481CE7379@DM5PR03MB3145.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNuycXhNc/XB0fCzpmHkgk27yHBiHibemQIq9Knh48koYYNo6mOMwC2d3tKkHVoJMnFpoLQOzdA4kjfy7U1OlxPOPLbCeXsc+Gmvqiyz0X4US0in54HapiqlZjoxMObZ+bPByENUITLME28fs55ggy+QqB3e1VcBBFWuBPLrV20XQJjIcghrNapF5ekGFzuxoJ0rcHr8axZyBI6+ns7Szus1naBicyY2h6j1Gt/A3W89ZOvJQWorjo/zO3FjBNoZ0xPa4RjeJqnm/Lw1/2fxCR4vafdQO9xdsgAfsiusPER9tCQBUsmHpTDZ81aJJ3FSYmlLFK/Cyykit3EBgCNHoQOuCRquRfp75kUa5woc1492riiOP4m9zSWZrO2iePCYH3bpRvQZguQabXLwzInfMIVwi5Hjaxqsh5wsRrw12606XmEpjVK+WqshpOQISG9BDv+tPehS+X9Hxy9EoaTZblxrElcOxUHjWQc1Hi0WmgzU2Tox+UeM3xIZrTdRqF1ET1kd7sZVhSL3cQNLQy4gARoNdE3STjmtLxSC5A/3N0PUcVvLrUyjl6qHxk8MHAWV05o7JBvQ7W1V18g3Qk21huSWYTWnm1l95DbNEowaK04kTwv+f6qHAlMVR2OWbuxI8PNYfEghCTjExoPKpji/talex0HRtkFflYOxUQkRo7doy6vX4ChoBs4IA30w2A9s2gfdR+LAcv+5whaVgEjgLyShho0XO7i5JPSIfQh6BbPDs/241/HHoXJF+PimVlhjNiIxS/ey3hGUulUm0d9wnuk3rClYV1VW3licjTq9WRb/ZzTrgLo6vBNupZZaxEQm4rpw+RmP2LinbdrOMqjDlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3866.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(9686003)(64756008)(66446008)(71200400001)(8676002)(83380400001)(66476007)(122000001)(8936002)(508600001)(316002)(86362001)(66946007)(19627235002)(53546011)(52536014)(26005)(38070700005)(55016003)(5660300002)(6506007)(7696005)(54906003)(186003)(33656002)(38100700002)(2906002)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oKpv6/GcQfbUUxHwf1C5h0I0YodKZU/MvX/7q/9MwB2yLIQd3RSp20AQhMp?=
 =?us-ascii?Q?9yX8Ns4YVWlcIx+4XW29+gVCiL08s3VnKOsGBvOHqn10PqOIDEB5SxZGocm4?=
 =?us-ascii?Q?b2cw8gVa7mgkreF7toqw1FUHrA8fsv9I5gmVe8Z8MFZIWUNXrX6sgrytnxHa?=
 =?us-ascii?Q?FftMOudTozzCmL5R/2pCiJNavmPEr1B1SJE7EWvlrqoqwUjqWbb7uF6uNa1W?=
 =?us-ascii?Q?4U2KAEJJ5OkVbCYY0sFXWhpiXRZrxkbKw6KgWNr171BY9scpggeLwdlSUDh3?=
 =?us-ascii?Q?Zi5pCBZqICG9LEAfg3t+oI1Ibu5ty+3T/pNCEsSHpv0VPJMraHZXgrdgJ7mu?=
 =?us-ascii?Q?rcVwIxPDbJemVTOiccbRSqEO4RMrqA1bMwJXmxoc4oHhzqIDhWepMPwzyc+w?=
 =?us-ascii?Q?Npn76krzLcxklMaZObZG0gGUzSW9wJN4c2AOHkNVCx01OLPLyH3ego+9tCip?=
 =?us-ascii?Q?EMcrt9iOYtn02R6Qqgn/++/EJzgYEQsrPjVQwf0zb2T0/3zUg2O4IdQAd8KR?=
 =?us-ascii?Q?o7juE4cMayMDVaOfppUi4U86/MFHCz93EhBMUx96h9WN4HeEhCy+B8EjY4Ps?=
 =?us-ascii?Q?LCODmawC3ETz0hVOFYrptMSy9/67bvtjVm2fLTYY0IoqRinHvbAqTtDflhgt?=
 =?us-ascii?Q?72qzg5s8F6Pwkqpzo02yphR0TjOi8gB5XceGdwA8P9VpJO7/RWUfALVEfX3p?=
 =?us-ascii?Q?JoIreMQLEveCjsCjjdIjsn/pzXOHCK8jT1TgV5TWwQZs741Vpc4RbhW260Qs?=
 =?us-ascii?Q?jU8XnZlpDU7GPIilnhF2sOy0oaSOhwDX6hAJF3Z3ZG7eJ6aKEQnHCiASLk1F?=
 =?us-ascii?Q?DMA2E64v0orAAViAbXvI+az0LMBpbp2Djb+E3+kRJn2pDpJTCsfWZa6Lj3z8?=
 =?us-ascii?Q?ZYnc4YT1oaMSMmMp8KxTFDE2w1lSc2jEDH5igCmmhHFoHzazf0KnoBppkl50?=
 =?us-ascii?Q?Vr7lGp3ZhpfmwCFRGjDPPrk037A8nKbGHWLGFnXWGOkQd0E7NFEkjTxx0rxZ?=
 =?us-ascii?Q?gzC53QK/KKeCpq+/e8EQndpRAaaK2llYa4c8ZskwJN4gefL3ZNKPgBNKv+4I?=
 =?us-ascii?Q?SWv8Odp04soR79HC9dkmktlJK+QaDlubKQzX1Wc41PNoaEgQU2O4Pfyf96Ok?=
 =?us-ascii?Q?NYY4In/9e5v9uEEbw2ukC67G5LAor69dZvFf0N+pnwqNjes4df+S4Y0CAG08?=
 =?us-ascii?Q?24ZtOe/Cb0iP+zrJzohdC22FUHLmFHHK2EFEoLYAywgdxMcEoHciPcFqQUdP?=
 =?us-ascii?Q?Pp4JfYotL7XH+CmzuQ+XXQwEuW/vi33cI4zNKB1tVVuPXvHkM5kYVEfj7T7K?=
 =?us-ascii?Q?jgHCsEmneZ1RnWLyPJuzsQq5yiCctEEOUU9WDeGUgkQE00b04nYeikqZme4H?=
 =?us-ascii?Q?s1wJWtO/IPbuTrVpIYGi4W404dkd1693GIsdAzDYxTFg+lHqr6f96d89IWFq?=
 =?us-ascii?Q?LW617lluStA4RZfkQ/EAcuDkLGCOGkkFKNteTU9wwTWeyxvBCjaSq9da21Bp?=
 =?us-ascii?Q?6B+JlIHm8gD5Qy/J7LBytNFFSWeZxXn4KmvKxZkcFA0sVQ76MSKLNfG0hHQe?=
 =?us-ascii?Q?9q7byEh9Ie7ZdsC8D1uB4gxpM2TMwTbjOSWcIsavUm02CXt18IXoj/3Cytus?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3866.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32d477e-60b1-42a6-b037-08d9f2eda957
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:48:01.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4v2/ompzwVYD1yWU7vU8InnNnLL2VQI64oYO/XJib6j6JDQedXDl74jy9mWqxZGX36ohSMQM+CGZLSogwcjXOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3145
X-Proofpoint-ORIG-GUID: mp3We9ZzLZ0zJJ4j--1PV2yCpQC9MnqL
X-Proofpoint-GUID: mp3We9ZzLZ0zJJ4j--1PV2yCpQC9MnqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_05,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180095
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Friday, February 18, 2022 2:04 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: Re: [PATCH v4 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
>=20
> [External]
>=20
> On Fri, 18 Feb 2022 11:50:47 +0200
> Cristian Pop <cristian.pop@analog.com> wrote:
>=20
> > Add device tree bindings for the ADMV4420 K band downconverter.
> >
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
>=20
> Change log?  Also, looks like this crossed with a question from Rob on v3=
.
>=20
In v3 there was a small change only, which I forgot to mention:
 - Add '$ref: /schemas/types.yaml#/definitions/uint32', for 'adi,lo-freq-kh=
z'
Robs question on v3: '-khz is not a documented unit suffix. Does neither hz=
 nor mhz not give enough resolution and range?'
The 32bit values in case we use ' -hz' property suffix, wont accommodate 17=
.5GHz for example.
For '-mhz' suffix, resolution is not good enough.=20
I propose adding reference type '$ref: /schemas/types.yaml#/definitions/uin=
t32' for '-khz' suffix.

> Thanks,
>=20
> Jonathan
>=20
>=20
> >  .../bindings/iio/frequency/adi,admv4420.yaml  | 55
> > +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> > b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> > new file mode 100644
> > index 000000000000..35a3fb3fd339
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yam
> > +++ l
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/frequen
> > +cy/adi,admv4420.yaml*__;Iw!!A3Ni8CS0y2Y!p1wBxz-
> QqJYCDNk3gYSMGaJoHbPGC
> > +RWOE04vh6kN2kHC84mPrBdIq_Pf1CgD3Z8knw$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.y
> > +aml*__;Iw!!A3Ni8CS0y2Y!p1wBxz-
> QqJYCDNk3gYSMGaJoHbPGCRWOE04vh6kN2kHC84
> > +mPrBdIq_Pf1CiGygmUGw$
> > +
> > +title: ADMV4420 K Band Downconverter
> > +
> > +maintainers:
> > +  - Cristian Pop <cristian.pop@analog.com>
> > +
> > +description:
> > +  The ADMV4420 is a highly integrated, double balanced, active
> > +  mixer with an integrated fractional-N synthesizer, ideally suited
> > +  for next generation K band satellite communications
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,admv4420
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 1000000
> > +
> > +  adi,lo-freq-khz:
> > +    description: LO Frequency
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  adi,ref-ext-single-ended-en:
> > +    description: External reference selected.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      admv4420@0 {
> > +        compatible =3D "adi,admv4420";
> > +        reg =3D <0>;
> > +        spi-max-frequency =3D <1000000>;
> > +        adi,lo-freq-khz =3D <16750000>;
> > +        adi,ref-ext-single-ended-en;
> > +      };
> > +    };
> > +...

