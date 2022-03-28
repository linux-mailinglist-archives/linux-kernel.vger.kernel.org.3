Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB84E906C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiC1ItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiC1ItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:49:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1B53B49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:47:26 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S6F1AI023166;
        Mon, 28 Mar 2022 04:46:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vkac69v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 04:46:35 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22S8Lonr007760;
        Mon, 28 Mar 2022 04:46:34 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vkac69t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 04:46:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLBKhlUloJpzZBRVbkhFcLJRB4A1UDxlkwK81gyX+3hEYeaj6Sv+e3m2NofAc6DTVgfIuceuiXP3NxlARNwmMlgJw5Sb5mqbsAvpdlSlzNMp/zP6LharvKYkQ9wIy4YtC/19KLdp7VwuYZRr7B8pghyOWqQcPjVG+8kQHzokHva0xxLlHBENVY5pcnyI5iMk/oFXGttDpJeahGiJqEqF+FuxVcBXtmtY1Pa8Mt+Nu+qegL8q4COrb234SVKSXwSFlCfviVvDmsi3ih94OFA13EDsM2n9kQcRIdSkObRA1tu/w7h5Cu1+nkr9y3ACFNGaCAJJbwg1Zi6F9S+/D2Df0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsFbyRnqd95aJm2NHtQ4waKj/FIdqo6oWwGOi7Zy2Ho=;
 b=Ta12lqafEUKuaJH2wOmxQgnLH3f01eJ76ajXuJ5KM9cPE5b3S4UGhRgR5jqoFBlgxTzUSHBL8TYMv/yz5rUuTfn4brJ/r/y9SnZhmTFbhpDr54bhQnLPduLVijrA3h+hIyYMsJh4o4yZPzWC4RGmrArUYMsB7vFXQ2ai9z4H/TXKX+Mh1xgef9EHO4jq/s1A6afJj0NWI32O+QzTGxr7YJgBVtDPJGRIzL0S6U7m5C3fUe9AVpWOhNYJa1JUhAu0FdjTxr2tOwXXzYm7QJuEj5QLOaX+RYKN7TMmJ2HHZsKgEJVWcLXhpFXVgDzqTgxT1i1+HIgOEpnlgiR/gjF7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsFbyRnqd95aJm2NHtQ4waKj/FIdqo6oWwGOi7Zy2Ho=;
 b=I4WKk89SH5P7tKtC7wJ8hKdzHrYL2/BlQdREoD/RzB/EQpiIinawDGc2v8DtVdE+mBUjwtmJhoTZwfxjo1nb50g5rP0b5Gw68QviZcXn7Vtc9qRLxWWUyeCHFFfLa20gx/CUcp+4x/LMt4l7YV94mi1hpY9krdtWfw9/UwwHSms=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by SN2PR03MB2221.namprd03.prod.outlook.com (2603:10b6:804:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 08:46:32 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:46:32 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Steve Lee <steve.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ryans.lee@maximintegrated.com" <ryans.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [V3 1/2] ASoC: max98390: Add reset gpio control
Thread-Topic: [V3 1/2] ASoC: max98390: Add reset gpio control
Thread-Index: AQHYQkk6ZcDoheE4OE68GiZS/SX6S6zUe4Dw
Date:   Mon, 28 Mar 2022 08:46:32 +0000
Message-ID: <PH0PR03MB6786EB43BFAD3B711096F69B991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220328021139.8700-1-steve.lee.analog@gmail.com>
In-Reply-To: <20220328021139.8700-1-steve.lee.analog@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOGZhZmZmZmUtYWU3My0xMWVjLThiZDMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDhmYjAwMDAwLWFlNzMtMTFlYy04YmQzLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTY1NyIgdD0iMTMyOTI5MzA3OT?=
 =?iso-8859-1?Q?A2OTM2NDMwIiBoPSJPQzlRdGFTV3lTOUdoblpiSUg4OUtoRHJZMmM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJ1RGdoU2dFTFlBYTRJTUFOMFEzNmRyZ2d3QTNSRGZwMERBQUFB?=
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
x-ms-office365-filtering-correlation-id: a8aefd78-5691-4615-ddaa-08da109775a1
x-ms-traffictypediagnostic: SN2PR03MB2221:EE_
x-microsoft-antispam-prvs: <SN2PR03MB22214C80C1D05DA0AE30E703991D9@SN2PR03MB2221.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZz67xpkaaQJRTG8gWWlTL1Zf5HoBXPiOFmCmwiUsOUtmqKJBawcWx6on/Iu0vdxd5G3Rb7/Cq41C1YV/EHo3riK/5WT+iDh0OcrNDzyxEjC5I9Tp7+2RYqoRWuukMxBHeMZ0fa0Z2IYdLzKFDT73Z5waoAm8G1vlw7al4AMNFm3OzllJHWoWh32Mfxl18C42X7cCgo6VTMPu6tC9N0/dqi4rNBescO1B+LPwEIWHPtR2CduwBQqUoEAwHbGSAZvIIvzRrR1sTZ1Q3+gfKy5mkNYR/ptDIHxPniTCM0mzZhGlBNh6JOEAmdlYO89C40XlmF8bP7Q9qUlsdTvNruIrAP8d9nsmjvhZwGpU94Ne03hX60qytvcpW1fKvkN7iMRSzQJjTJwoiWVIQLvRaZF3YM+D3ArnwOALJIp8HysvcI43CkSu3Cdj3IC4u5BifsOHkVAesnkM9PJ3mKkxxTXYVhaF/vwd9Cgp5LuJ7loynQ1H3ew7CmVFrSItVqQEKUGgIWKm1Ztb0CZafZePi2YiTQuTN/TJTKlhKgNj3gsKBdO/XJ9EyEIgPqWgR5zZKSPSM7nG9BQUiykuqmBoTK+NRWZLaYgvLDVxQJUm+ZeHRhqgGKF8UQ2oQBE2djqk9r/WYmBoQokBOWMR0Unb42UGMON1VcusWE5w/iLWPhr+sy/FwL/CGDirRmmJJ8RRqNjwK0uxa/qfelRsucmKtNNew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(7696005)(76116006)(2906002)(38070700005)(9686003)(83380400001)(6506007)(4326008)(66556008)(8676002)(66476007)(64756008)(316002)(110136005)(122000001)(8936002)(508600001)(66446008)(38100700002)(66946007)(71200400001)(5660300002)(52536014)(33656002)(186003)(26005)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A0Xo3xTpPS8vTWJnrGXKNDQ/NKkMThN29GOhK1XH4RyCZ9Zkqcv4Dy7+7G?=
 =?iso-8859-1?Q?mI1xIweAuAw7mW3//vTdc5SoeF9CWoWvqLjxXlTOkYhN/QBYK8q7EEQvma?=
 =?iso-8859-1?Q?TvJ+tOOpDHozKMaeuqrerjiMqCRdblpBcF1Za5DxRmSbDfh5jcTKjCK1Dj?=
 =?iso-8859-1?Q?B5VeeZeO8quSWfuInaEbiJGQl1xukBtJilp2e40Y8YCZB1YXh26fZJxhXa?=
 =?iso-8859-1?Q?KmW0zgALts+lx32rpgKl5jdR9IvlqTJOyPZyo4z+ElZw+AaXOC+9lankD+?=
 =?iso-8859-1?Q?noQGOOefUUfhhBR/9FqhhuTPFroM70O0eBvqJl72QQ2xdxj2TwiY3Korof?=
 =?iso-8859-1?Q?LtDTtdrri/7pa1UoV/4nevPNpeHosygfi7nNYlXuOd7yG36Tt2L80M/mgy?=
 =?iso-8859-1?Q?FqISge2u1ETAtTiE24M+vkj12/SyN/5nkWy9ayzlQkg/nlpSaNsn+9jeNK?=
 =?iso-8859-1?Q?K/voX9ofnFflaYevpYc4yiLc5WAT7l8BZbvQqDQbPrlfZqS3HCCuV2FLsz?=
 =?iso-8859-1?Q?zlaMa7Rq5MA0Et2oyS6jCTYjIw41AF2D3iKRQ7GUJSKFjqHhSgbgvnbB0m?=
 =?iso-8859-1?Q?ENnDVo4eUp8QUNXtwBSxyCZgv0a5N2IrQpSJZqv+iPtEoLzdTc2/M1gtew?=
 =?iso-8859-1?Q?SF0wYgGvAduP5uTMz8dkO4y3Gec5I47jcqVf+FESB2OB3eN9U9KHCPFc7/?=
 =?iso-8859-1?Q?ADfuNFYIjGpIRC1RHsXVGCLR2Z0bpBnsr9omtC6m4y48BuC1GtSuo1knFD?=
 =?iso-8859-1?Q?muDkAG1+/8gRNZvOeRoSMOr2pnLm+3SGqcy6a4ZQbV1t6JXLr0ruNgamJL?=
 =?iso-8859-1?Q?zbsEeedZNA6MQJZGgjBX0Q8KWtMxUNIbHmczu03jfXZIs/HvhdH/ncsE3n?=
 =?iso-8859-1?Q?0kQpURo0CRDtcvkS53PkSUgh3C988pkceKnS7A+EduodsWGQwAe5FyxQUj?=
 =?iso-8859-1?Q?LdZ1UcachnxicspzWxa9RdnqptWlINTbTaRqClD75vJObGwiKvNtRfASrz?=
 =?iso-8859-1?Q?HqwP22CmTwOIpC+qqEv86p5QQwTMD3g99/WKYx+IlReESZWuBI9ueLzHwl?=
 =?iso-8859-1?Q?4mQ3Zi6CkoLevDS8AowohFx+7TnRJa3zelYNow3YGHLYXfKS5hI+pBkEef?=
 =?iso-8859-1?Q?B3nJDyt2tcGSxZVPrpJNC89HOQFFYrMGDcSahCOrlbLPswOvVDf4dOfgKn?=
 =?iso-8859-1?Q?Mx0k3p3/A2W/H7CGYOMmkEwjFGWZtdBdXVk7SibsPX+COwfkptRzfQATlx?=
 =?iso-8859-1?Q?K8D/kXeOeVmUTrzHlhdsT+JQ4/W8J+S1nJ/w81UXIj8ikEwNO48JbVjWhD?=
 =?iso-8859-1?Q?O16O7krOxfMqVs1/ivbmkcxSvK9Yn8Gq+paYVc3vq2fVdwOM8vvk0Kc/CO?=
 =?iso-8859-1?Q?CVCetnkoPn1NBqBvS/U+x8NtOqapCKuutUtZfZgeC0YWj9QUZUcF10ifgN?=
 =?iso-8859-1?Q?EwAbfLFaPPuhYGzidrXrMED/KHRaJ3Mlfc3KLMyjUpiQHEur6m3B7olq/9?=
 =?iso-8859-1?Q?fo3SwUkXsfmZmBFkSd462WlZXIe6Z3qi68me6/zioFvoRQRgTxABtjtZEs?=
 =?iso-8859-1?Q?8MPMiSlDZfaWdcb6qDHw2g3NfV6t1kxeDfQiYn7DthTGOQePuZ5JAUk+13?=
 =?iso-8859-1?Q?t6s+VOvR5nnKu+x9DXJwnoskt92lyIgVR6x+drXIgHG0SUAkVLkkb5pz41?=
 =?iso-8859-1?Q?bsl0WwP6e9EmTKlJmdEM2hcym9/xFPW1W+wWQDaT7YnQDqLGOnlJRCjHp6?=
 =?iso-8859-1?Q?DtylYzp6NAX4t8ow7740twamSvJ1PRzPbY70d1TY7CW09ZOPXmmXgjXnw8?=
 =?iso-8859-1?Q?x3qFpCR+oA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aefd78-5691-4615-ddaa-08da109775a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:46:32.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ngl3iIMpg5gpr845wuzq1gGjI9rvGbb4x/8HLRMKKLFmRILODR1d4tu7186KsYEKhEWKgWIiN4eLudfwJ3By4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2221
X-Proofpoint-ORIG-GUID: aXQjMbgka1lzYkhzYZnui8feBYxYTqT1
X-Proofpoint-GUID: HIrguFTq8UN6EA-IJmmWq1KHTY1EPeQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280050
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steve Lee <steve.lee.analog@gmail.com>
> Sent: Monday, March 28, 2022 4:12 AM
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; ryans.lee@maximintegrated.com; linux-
> kernel@vger.kernel.org; alsa-devel@alsa-project.org
> Cc: krzk@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Steve Lee
> <steve.lee.analog@gmail.com>
> Subject: [V3 1/2] ASoC: max98390: Add reset gpio control
>=20
> [External]
>=20
>  Add reset gpio control to support RESET PIN connected to gpio.
>=20
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  sound/soc/codecs/max98390.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/sound/soc/codecs/max98390.c
> b/sound/soc/codecs/max98390.c
> index 40fd6f363f35..05df9b85d9b0 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>=20
>  	struct max98390_priv *max98390 =3D NULL;
>  	struct i2c_adapter *adapter =3D i2c->adapter;
> +	struct gpio_desc *reset_gpio;
>=20
>  	ret =3D i2c_check_functionality(adapter,
>  		I2C_FUNC_SMBUS_BYTE
> @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> +					     "reset", GPIOD_OUT_LOW);

Forgot to mention,

As you stated in the bindings the gpio is active low, this should also be
GPIOD_OUT_HIGH, if we want to have the device in reset after this call.

- Nuno S=E1

