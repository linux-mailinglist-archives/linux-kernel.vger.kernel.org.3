Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1685A6256
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiH3LpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiH3Loy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:44:54 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398BB7;
        Tue, 30 Aug 2022 04:44:47 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U8FuEY015056;
        Tue, 30 Aug 2022 07:44:30 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d48bfmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMKB6NBhuQ7/EYIvJGDDTwf/RNHrDLqdHe1rbSAihG4C6K3uzJuMreidc8ZYMJze2ICe9tuKci2xIHAHtb4DAEEMWqTw6gylUNXny4VaBgieOIKxMPHlSpqIKNkJJLdthSuWkqtnF1FLc3dnyvR8zQEgcIBe4t13ADL6VVDJg7hnuqcg7B3fo3m/Cq+8oCt4zFb2uDO7VcJctsuk6GRl1lnjmvjvbN3W1UbQnqPrQsaj8SoZgKb3k0gFdwHmNMuGe7VRivwhEMGU1PuS6xGldP2y4U+5jkw8ZUpvYbaXKK5pw1iYMAMKxoOb4maHk99LbVX0Ch6EzBxvDR3MSJkT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4SWfTJ5jjqSPZAWetNEyaivRO/An9uRtxl0xmQMZ/M=;
 b=UUGy733VMIMoS99j7+bWB3k7zH79F4c/AiK3376wSx5vajXF+pR8mn1H03XjS3FJGsiNVb8KR/rQIXfMI9w4J51sRzL/5kCTVWbJo9Kwe/0gu+5IFLt+WzNLAxESXSFmbefridePa0052Si9zn4u1hX5jIdNBtEQBZ/HZyJEeFkaob5TjqEoYgQtmEwzzPXLkt4Suhxclcv+DOgPbIlU9N74yODSK+ZSa2IZ8OF+Uw6F3gqKqRiDjGyiasNkRhv8WU/3BmrCqy0XBLCt2oGD4P2whzgIkVzRf8QHe5yQHX3KZcFMU4Te6flwdFGTgfwCJPL35EQukelj/JywRgrpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4SWfTJ5jjqSPZAWetNEyaivRO/An9uRtxl0xmQMZ/M=;
 b=cYV21ram+pnZPpXvdc8z9y1ChmOAuLHBm6fiy31s/xS9B2YZKW+20YS6Nx6dNHwR3nl0v21RUJFWOYd/O2HHriEaozqttvU4rGIOQqPGwasdIvOa22RyDn619F2xfRkIpt/P0fM3DOuLTDPNcx3it5VUYowIQl8DLKDowiNn0NE=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by PH7PR03MB7001.namprd03.prod.outlook.com (2603:10b6:510:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 11:44:28 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 11:44:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 10/14] iio: ad7476: simplify using
 devm_regulator_get_enable()
Thread-Topic: [PATCH v3 10/14] iio: ad7476: simplify using
 devm_regulator_get_enable()
Thread-Index: AQHYtADIP8iuk76tkkeZIve4PPusfK3HY5jw
Date:   Tue, 30 Aug 2022 11:44:28 +0000
Message-ID: <SN4PR03MB6784256C4BFB84607498376799799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <33070d66b9b976acac1cee5570facef9278b6b61.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <33070d66b9b976acac1cee5570facef9278b6b61.1660934107.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTk1OWQ1YzYtMjg1OS0xMWVkLThiZmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDE5NTlkNWM4LTI4NTktMTFlZC04YmZiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTIzIiB0PSIxMzMwNjMzMzQ2Nz?=
 =?iso-8859-1?Q?E0MDAzMjkiIGg9Ii9TNWZpWko2a290UHdSbXFSNDhqMTRTdGJKST0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQ0p2YmZiWmJ6WUFaQkhMd0VZVkFlRWtFY3ZBUmhVQjRRREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFBQUFBSjRB?=
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
x-ms-office365-filtering-correlation-id: c5d8c8cd-005e-435c-8b47-08da8a7cff10
x-ms-traffictypediagnostic: PH7PR03MB7001:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+azgQ3VX+xAxKEqKZbaUj1p0VPsRQROxIu2Roz6ughbVjW2Espy+y01gVD13A3LdLJ78PvWb/O5mC/wtY1jXTLBS4y88fBbU/+HaK+g0g6jS7NWoZnklnYuayZObaEqgy4latzIw+zqE+BWqe0fiSEsmTvvFxQuDz+p4/HXp+c+wySWc7pfRLDRN5cnleUwTmKUHCGUXomFKWOp9FO7gJS8BGYyaPcLCiINgew9t+A5Q5FSj2hbYqR965LoUrcOQeLY9A+D0OXQ9qhID8kJsjCsemicPu//nYLf4uO9jP37mm7P0wFdqy2Po2T/0P4xj4b4jg+eqNuNSG1Z4MbbJcSWO5UIYVArSkcVYix+m4gsr/FAUCP77ikfm9sfY5ebXpVkKr7ePNczGIdJiwEpooG77e2anr2azML1qe2GQ0lvT1GdFg0S5zTFrDllozxaw6qosyMdbhdB7X+7wIW9Eh5X4oDU9oK4nbVYQ+HiJBgbYfix3F3zChITD+33A6Y7VkvVuXtLoMQpVBQtTG2cdLtWXKd8EVdLR3L5ZrXZl8vfiBv3C1yh7esB/FHgfJ2Fn7opfalFscEeGuPWCI0ERFitYadJcj9H+PnuNY3o386d8VmOL7NbbP3JYSrRCFhmA5mCovR1koZEmzE6P67a6YqxJg9ktEMTJCHq08jKjHwh0MAwx3czgWk3fRJdxj4Sc2U/c+eAw59oidWcyCWs7bH2crU7TCuMGhIzvR7ISI6aMRp+MY+fq5xHUHpAFScI0iqH0sXzj5eYAMGtDOUS6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(8676002)(316002)(83380400001)(76116006)(66946007)(5660300002)(38100700002)(122000001)(52536014)(54906003)(66446008)(64756008)(110136005)(4744005)(8936002)(66556008)(38070700005)(66476007)(4326008)(186003)(41300700001)(2906002)(478600001)(7696005)(6506007)(86362001)(71200400001)(9686003)(55016003)(53546011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W+bHNZK34OE1TNxa12PxADJPr6D5Jx4lewvzWTwTb5JjT/balBKONI46u9?=
 =?iso-8859-1?Q?TfAxVk+Peadx8LFmbX+myWZJHBV8VZpFrIt3cKYl1Bu7HAd+xNJZ73r3Jm?=
 =?iso-8859-1?Q?y+ZJ95tk4hi00PhJCTw4D1ixODoJcLXoIzIVbJa9tWurolZLRp4vc1msHJ?=
 =?iso-8859-1?Q?uqArieLBJsIPgUAvCocRcVDcTIkUHMm8x3wMkfNOnxUttx3LKH9xSiwdVs?=
 =?iso-8859-1?Q?1RF9VeXLxJBQ2XFi6LlnWuEJS7CzJokPoVcJefnih4nFda2AysYy5k3ywI?=
 =?iso-8859-1?Q?yESxYtmvZWpGJPLHjFCBKYBJPQ2cXuUnK/wRAjBzCW7aMncEjMenq3rpQ5?=
 =?iso-8859-1?Q?DM0EAUSW0JDjpI4fS7bh2H/Yw/ulym57iruzvu3HBvyj4FiTxo+zjs0cnp?=
 =?iso-8859-1?Q?db5byAlVZ3qMuXzCLVTEW+MMP2c+Y8Vm0tPXYkklHm3EVWApxy9cp5l8Ey?=
 =?iso-8859-1?Q?Y+8NUqU20F8uKmEtg0u5dznqHFPD4Ebhy9jqvFGH+cOBCJ6BO5u65waH6h?=
 =?iso-8859-1?Q?WYNJ7DyPV/8Vr3imfoYQiAmURtGa+aXjZGiBhoyXgf7BJVgmP8NMpp01ab?=
 =?iso-8859-1?Q?Nr5uzlWcCc3/KTiBORMJ2J2l7KNF2aC+KzHjRNDZxepgBKUULgvmf4Mgvz?=
 =?iso-8859-1?Q?O99cLz9p+4r6e5Z9OhqjIGBzRvO77tx766tGRtHAq3fCEbRZfzLmNGzSs7?=
 =?iso-8859-1?Q?ZSZid42bAd9aqA9Ja/p5nnYIVrO1LFZ2oa555ocQLLHt9xDbBPoP+46T8A?=
 =?iso-8859-1?Q?A7I2ie25h6iP8XRr16uEkeRZ3/aoK6ARpHgmsrhHnhxoPeUFKOG0k72EVX?=
 =?iso-8859-1?Q?Qz8uix6FTZBfx++9CVuZPQE++ozk9oUhXA+vnLSr8Sp1k6fTQc1zWpc3hi?=
 =?iso-8859-1?Q?nSGX7KLLtUEpPbqNbAKRW2W0UqvZThEWjj/sUnvodEMg1IxgRWz7jQ+F1A?=
 =?iso-8859-1?Q?4dDPpK3HmPTFhHTJsgJfVjzVd8tcbmmqp8xz0fFmEmIH8yvJ4kk2wcBMiR?=
 =?iso-8859-1?Q?nwmexrla5GZ7urw9Ui3VyS5XIhNiBg2OYP4PoOlhsUfi/+jOuYNH6BFAko?=
 =?iso-8859-1?Q?FA3alpeybR/hGRE6BG+JD/DcyyhNk1f4oVbs7hs8GI/ze+Xqj7FPcDA/lK?=
 =?iso-8859-1?Q?yYx2+OdXbmoQZ2GE0SrRiCatEnLRoOIjCoFgZwrAPgM6ccN4/XzpyuGxpv?=
 =?iso-8859-1?Q?CZfxCpUewGHEbsOjs5+eKWt1NWJACG1pOJH780Da8K2TOtwYfmRj8HnMRy?=
 =?iso-8859-1?Q?NurQZQUo2ZNuO7p2zs8emy+VuDDrUU4hXslzp/W7bAD7TgjecgRic7vKz3?=
 =?iso-8859-1?Q?Zevnzdz38UPngFYh2uk4e2EKJoV6vcCaHXmIMS4p1KpM9tPqVXy0HNU0nQ?=
 =?iso-8859-1?Q?tScnYvAwTtGkl+67D8m3/CnLsGC/WzDssnVu+QvBnwiDHxo0H4P0Sciyb+?=
 =?iso-8859-1?Q?wmNFGWY+5lFAlCOqM3NtNAfZVPSrq2TZLehnagXsxxp6jH4ziDAaF/zLVf?=
 =?iso-8859-1?Q?43Iyht8JscZ3ReCt+WYmC8g01Id55EpukbFvEg0jE/gKuT3u6cbzxhqE9P?=
 =?iso-8859-1?Q?5FLwm8LdWg72IZYMGEciCnY49JGg/L4kmt9n+FXPpABgQ2XLQRcBTaIeli?=
 =?iso-8859-1?Q?i497LM1XJyUsBF0WsLJ4GcwttmlidU1uv20mIERJO0thZleKCCN94WdEbw?=
 =?iso-8859-1?Q?ch7euK5rNeoN2SDlRYGImWC8W5baDDQGch3zKqAi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d8c8cd-005e-435c-8b47-08da8a7cff10
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:44:28.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgUw0doEpIpRXdiVdnWVESrpU96e/wrEqjf75vI2eFsbNZEY3+wT26RjL2u/sAxy4MNMXW/eGFGyqBO+oycuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7001
X-Proofpoint-GUID: idXsjmvpsrBZoiT75S5xf4BkbeO9PjlB
X-Proofpoint-ORIG-GUID: idXsjmvpsrBZoiT75S5xf4BkbeO9PjlB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_06,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=797 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300058
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Sent: Friday, August 19, 2022 9:20 PM
> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3 10/14] iio: ad7476: simplify using
> devm_regulator_get_enable()
>=20
> [External]
>=20
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable()
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
