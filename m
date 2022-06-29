Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5055FAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiF2Ik6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF2Iky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:40:54 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5953CA6F;
        Wed, 29 Jun 2022 01:40:53 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T7F9c1013376;
        Wed, 29 Jun 2022 04:40:50 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gwv77j79n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 04:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvwvEYuoDoxNmWhOf/hfboddjyeQL7svWluUJRc2bNEAG+PXCSUpi/kgZrP6LNp4H55PUCi4eH5ZjpzTx0DkJGL/k8ZDmF6/Bq8ZUHSM6KfaUsi2tGx6jP9zUgfsTxXotefWHlbU7m0KpqP2HswM6Izo8uzn4RKlyVD/0L6m5+YlwCQSFJCcJ+N/zQgZrz6X0w3rmhkb0E7VcBJSCuDOGxc7qr5l1pZ4HfUbJ7ZxSZaOmzxJQdrdBxwS4TQJ13yeuTNiaueOHdWZtA8HuXTcigkak0m1cz9sOrClS0D+J3phjQUXWiMo3CD8g/cyS+RHR9gDUfsSSWUsUU4kg1llzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kgwWZhXhR2It1JQTqMK8Qh0UNYUt1Bk0p8LxJ4B13Q=;
 b=cS8AA2DyIHmJBy3S6CfB+ySQiw5Z0pQBNeE9nj6Lzhu6dg7QTWVhN3Gz7m+vHSnVc/0DGJagWqc7Dkufj6hbpD4leuLa5YF9UyuVKqZrCyD+6R+Xn6FzT7HSbS0BheNtREjVtmB0DSWlqbIyRNt+b6ZdIWPeiXAYT3RmTSFnjBoalVPzX1+E6IxaXT3PoxGrZ1/ZJ8zVtMyUXIzElnj4nsYX6eivh1rXj/sd8UNaTQKjIQY18PmPU9wYQIBFRyuEOdW10d2drfdqnGH418sdV4h7Oy1wR0Ea2d+q3KPV3nztL1M8o8+f5mQHPsGyzVzI+Q/5QcZosG5Rn3hVzxBdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kgwWZhXhR2It1JQTqMK8Qh0UNYUt1Bk0p8LxJ4B13Q=;
 b=2fLbYLUn9ywZWAOxZd2TYNkICLeI3/1pLMUhf3DdaKgE+hyc293K+iVadrll3liHBOK4E4VBQxNTRy5cwC0PhX4R6VyCjxa9ZQTbZqyPHEFlOdt2/ABUNnXTGk7HsTWt8lpdd/kQX1X0r8YOkgaT9S40nBJuJlEbPnhcK3MEEkQ=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by SA2PR03MB5692.namprd03.prod.outlook.com (2603:10b6:806:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 08:40:47 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::a89d:d0f0:5188:2f55]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::a89d:d0f0:5188:2f55%9]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 08:40:47 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: RE: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Topic: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Index: AQHYiya7Gmk/GcosSkmil/FSbhBbb61mD/pw
Date:   Wed, 29 Jun 2022 08:40:47 +0000
Message-ID: <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0yYTUwNGEzMS1mNzg3LTExZWMtOTJiMi00ODg5?=
 =?us-ascii?Q?ZTc3Y2RkZWZcYW1lLXRlc3RcMmE1MDRhMzMtZjc4Ny0xMWVjLTkyYjItNDg4?=
 =?us-ascii?Q?OWU3N2NkZGVmYm9keS50eHQiIHN6PSIxODE5IiB0PSIxMzMwMDk2NTY0NTQ1?=
 =?us-ascii?Q?OTE3MTQiIGg9ImJoWFBhV0swTzljT2dWL2FvbktJS09ZRUwvST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RGlOS3pzazR2WUFVYllUalNoZkJscFJ0aE9OS0Y4R1drREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec59ae83-b766-4ae4-f19e-08da59ab102b
x-ms-traffictypediagnostic: SA2PR03MB5692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LU4zroKKvdnLLMK9GxLO3FDhJZL9lUMiEnZpzY0Jo99PjHdvE2gFdEHlZRQK79N1p1VjrtgNXJwEoLMUFlorSQPxbERaVxicJPVQPP+40dYazJ7JqCeOyZv9hfpnmhQManS6XvLKpGJIRPRRXUkCIxmNlZ8HafytodzamGdBB2iLd9Zf0CrHOErqbAy74LiM58sYQZDir6HSkprXUOXDF/mShaqTgupVNpNhuvuShYxlJpyb3qsOC3NAdzeae/+E1+02/yilqVywCH3xiTeY9XM9435tGNAejkttgcDl0Ucz7X0woOgdMWXOVQ7ajTdwKtlsOLa2CkmQ+GSSnwHgFIWwAKcOazwrcdEPC0NuF23Wl7HNUT6IASd0su9X8O8d9U2OpxqvpuB097bsblR7jI1jnOq/Wzp1IH01UyXMXzLlcayjf0nuaSzOJwWXbIUdNGlik9OvYidHQQGTKlRyGo7zULj6Zf3FwCeTYaa2VZbp+sYA8cH/StpukPF7i61YwJ/vWlYvnAqdNbSDvUCg1zMHmRa/92EXMZnZcedyZzmJICIsp9JSRurUTRJdhpOTGGXNUDKO2gKMbIpgRBN0oqzUsUmECQiD3IdEy2JQAVfePdOfGmHYGEh/CCrXTiXrghasGXgNMyDjRdfRmLV533+BA8ghHDnm2eqmdLDKoL5Qf0oaSWU9cdy2KCktgLfo9jR+dwDBQJchaQQ+qHEttsnx5XRFMsoglty1hAFDbytW7K0C5zC6MlzQ890gL4RQq8eiwTqbyoBTFdurudS3WetKgZCJPeceolzFgz2kk6cPiCNrmqNat1RqjKE1sTx/6X8KH+gDxqSGuKI1zf0QIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(71200400001)(26005)(2906002)(83380400001)(64756008)(122000001)(66446008)(966005)(41300700001)(66476007)(76116006)(6506007)(8936002)(66556008)(52536014)(66946007)(9686003)(186003)(5660300002)(478600001)(33656002)(86362001)(8676002)(7696005)(55016003)(4326008)(110136005)(6636002)(54906003)(316002)(38100700002)(38070700005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7MRpU8TymC4CcTmudCGwAZE+P/oqja56DMk2fQgcO0XfC+8RQpBsl+vFH2Nz?=
 =?us-ascii?Q?dLyx6K93i7LFpOCysGe6C1VtBJkv1GNFj+Kp5ABP6+r6/UiR4B86fxOOr7p6?=
 =?us-ascii?Q?etmXoKxJXAlYHE0b48DRahOIALQkdgJQ9vlh99vIuEmylElAMWwKOnvQ+YHk?=
 =?us-ascii?Q?hRLHrON8bvGdXFdsKWGDQqrYOdjmPKwizsTRwDfhKEdR3yqQiu3GdghEMZU+?=
 =?us-ascii?Q?bL2edp4t58Ux2MXzVnM0gYX2xIQg2TpoSqYTZiCIrnA9ql/C8EIVeNyxBTqa?=
 =?us-ascii?Q?7h2B9HFKBq+1kjEyhNjFtxF4Netrb3zanpO9vX+Ee5WeIAA/h3vCLLG7LL0O?=
 =?us-ascii?Q?6oiUm+ieVHswZlJ3SPXHTlVzbh8fNrTNI3jWJoB4JD5dSW+wF0ba4zQDO1DN?=
 =?us-ascii?Q?l1ltkfEUqT48ulRiJIb8jVBHtAdD9RmlmgOFVXdUR9rENY1AlnC84jDvRAHZ?=
 =?us-ascii?Q?quROVRRJvlmjOM6kLQG+K8c9Ob5k5Ust/v7+dqBt7QaliewJdcukVtxemHce?=
 =?us-ascii?Q?uiOEBgriKEcOaYtbV48AckIZ5xzCdWn/lU5tmt6rc5cob9nTn47r9shYbI+c?=
 =?us-ascii?Q?0g06PwYm/O4cLh9JPKIpeA4CfIFSgbk1HsUgcEpIZIGNmJbX86sHPWxJL192?=
 =?us-ascii?Q?uzyC63xru8ZGM2KwX8RbG1GxFf2HWIccRFKVhLsnNNBO7JJLP5QqhNT27tqz?=
 =?us-ascii?Q?xlo8adqiQMb3WpdCXctDCb7YqqdlGQkL7BVVTqSUVQKJewTYgNFcLptHRjZy?=
 =?us-ascii?Q?7nZ1M7HOGlXDs5iqnXXbU7m0xOyWiOQeJCaKlcqz2iYDsvWnbemN+ASP2z3k?=
 =?us-ascii?Q?mqm571ED+YvertvkWv/jphiuZHC2bHMpG/qpAtI+A8gDOnpAAbEezK6RCAYy?=
 =?us-ascii?Q?FalVDrzs5fa/6jW/1yl+1SXo3jCUJ2/ISAYdAi86cac69DuFCHCB+kvQu2RB?=
 =?us-ascii?Q?d7E+LaK4vyfN0CpwJTGfHSBvnOH0gdI0RQaZcNi9CUtYhMO24KvxlbrtGxJg?=
 =?us-ascii?Q?4/8ROax3qNPD0LvR5AzLheIqppb8otOB9IMNxJA88ZCXxSk9T3bPqdmjSOhc?=
 =?us-ascii?Q?cG81wv1b9kjK8TEai/MuGgozz1QzpWCdUuFEEoUYbGMqHDjkWxw/VLysMRIo?=
 =?us-ascii?Q?R6QLgwKwOBF6fL+iPCgD+Df9PLT3JRg8sKZliFkeBtWl3WAdJVmGn5y4Tqa5?=
 =?us-ascii?Q?09cPcWvrrFMY8VJZzwhNejiwnRAxdfZHyQY1b/j8EqtdYhaUofGriPkLAKZx?=
 =?us-ascii?Q?adSpHpNonaPnzOkp8Xd8NMFXIYFDonYSi8gxPgsRAvJy3tw7yLIykBrIOQEN?=
 =?us-ascii?Q?A2j/E0GHRRuo/I0uVSK4EAhi69t/wmCstfgc8RnGJ0Y7MHLPM+BiCY5v1H+Z?=
 =?us-ascii?Q?rTbchnXEc2Pc/neeJfbTCCmcCwFvCufUspv7JZLt/iQEzTyx22ojQ6snyomv?=
 =?us-ascii?Q?+LSX9OYDW0o4kEHT0U+1VmRj+z6GmQwYjydGauO32xI4TTUEFj7HOhMG5XGj?=
 =?us-ascii?Q?JDgen1uQVp74xTeihm1gsssbm5Glq/I9UvMCS9Pqepkf/L73iNFqyySGBzuN?=
 =?us-ascii?Q?2j+LBq9s+ezcPQAvVNMSUg/OFzP2/pzS+w45Xhb0tNphB9Wl2SVDIE2aSGhF?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec59ae83-b766-4ae4-f19e-08da59ab102b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 08:40:47.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48jNGGhYidLxegGMJD+v+wAphcgt5l5FFNd1kxdu3n/AGUQ465K47nTzgN819WlDQmi3kmOA+hVsK5/vqZPa8A1oR0l8LNw05cDxL8fRCg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5692
X-Proofpoint-GUID: -_ddugVnzWbEJ_8qawtIi0_PimLLvFnX
X-Proofpoint-ORIG-GUID: -_ddugVnzWbEJ_8qawtIi0_PimLLvFnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=905
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290031
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Dienstag, 28. Juni 2022 21:39
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> gpio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Linus Walleij
> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> Subject: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetical=
ly
>=20
>=20
> Sort header inclusion alphabetically.

Hi Andy,

Thanks for the patches, they look good.
However, Nuno is currently working on getting the irqchip support into the
adp5588 input driver. In his patch series this driver is going away.

https://lore.kernel.org/linux-input/YpMCh1Xje+jsny8j@google.com/

Michael=20

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-adp5588.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c in=
dex
> d6a229a67044..d49f12560cde 100644
> --- a/drivers/gpio/gpio-adp5588.c
> +++ b/drivers/gpio/gpio-adp5588.c
> @@ -6,15 +6,15 @@
>   * Copyright 2009-2010 Analog Devices Inc.
>   */
>=20
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/i2c.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
>=20
>  #include <linux/platform_data/adp5588.h>
>=20
> --
> 2.35.1

