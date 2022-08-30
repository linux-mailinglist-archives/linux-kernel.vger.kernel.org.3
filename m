Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD65A626A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH3Lti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiH3Ltc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:49:32 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521DE8315;
        Tue, 30 Aug 2022 04:49:28 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UAquuq028119;
        Tue, 30 Aug 2022 07:49:09 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3j7fw88926-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UamNKcmWj3s9YEidAoPqz8Kv4FI3Fb9u8j563TNcolw9Tp8ba+sb0pcqJr/VtFAAE2n4qrGU9R0yZt+R5WwvgRRotK/ldybwUj0hOONFnysj27TNziLv9X9c2vYtJnZb6Qc9iursilOLSb/Vxjkt03vb8vxwukcUbSnuEj2giM4A0rxpIk72nVUoafUBN6Od5gKgsEaxLXYWDE2SGC+TxsFRgPJDU1cGaohwksMivjv6MxO62dAQOpRckVT/xGOBNUzpdqf5ZpFOMEZzfcG2E23zQn+omEO0dE2BPj+nFCOEvRYiMMQnNVlEES0WAdQ3lc1EqtLasduYq72qPpjM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSHOgtdEAWkQHbFYxw45xqPvRs7Rd8jjAlf96FtTdc4=;
 b=DAWgV8/xh0DKHxxuTKEXcgAIthb4VyzKmNywB7ofmrWlwGI5oviUicqWd9HxqJcNTByrYD+kuDl9gG1fHj/UYBbmBYU+mqbWk5Pi64w2uxwCQRVndzit3QmJXp/68UEM8fPaSxdNW1Q2uN4Vog57aAMzjGnay5+W6VI7NASi0KqmAPgr+kQtbZz54gGpOZIGKE39wzu5/INJLbJLkmbdNM97T/l9x4+d9E8eOnItJ9araFTI5UTJW/3AC1CLMhOWVeAOdj+T7Ibgg4CfyFV9L7XGjbjFaE6JVW7Cyq6swiEYnSMm3aFhbJJrXZ9JQk+vKvn5zEtpTljf/zp5sT5tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSHOgtdEAWkQHbFYxw45xqPvRs7Rd8jjAlf96FtTdc4=;
 b=eM1bDJO/FVKKTyZWhMWCN6aH62vYOeq8kHw0mHBrBMsf98qa1kudNm5jBip92xH+y08e783TNEk/u2SBg8ofV8VF65a+hYTafATGTAn7TScSw6bDPxn2z1pAgUqFWHHRSwEERTEl7rqcKjJ9NXof8iJySpFieULc2f10WbMiQUM=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by BN8PR03MB5139.namprd03.prod.outlook.com (2603:10b6:408:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:49:07 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 11:49:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Thread-Topic: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Thread-Index: AQHYtAEA9W3+BCv32EieMGPzk+WDc63HZFsQ
Date:   Tue, 30 Aug 2022 11:49:07 +0000
Message-ID: <SN4PR03MB678420C67AA8988CF706198399799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYmZiZTUxMzMtMjg1OS0xMWVkLThiZmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGJmYmU1MTM1LTI4NTktMTFlZC04YmZiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTIwOCIgdD0iMTMzMDYzMzM3ND?=
 =?iso-8859-1?Q?YyNjg3NTcxIiBoPSJCMUx1YkI1ZExYWS9RRytHcmM1ejdZcGlZV0E9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJUWnhlQ1pyellBVFFoQktnY0pER3dOQ0VFcUJ3a01iQURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUpyakpJUUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-office365-filtering-correlation-id: 5d971729-2301-4f7c-de5a-08da8a7da535
x-ms-traffictypediagnostic: BN8PR03MB5139:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VN877ODRe6E/RRm1GZa4A9q+axuCWIFoNd/wsM4V77zjx3tnz2GK/xG5UXnvMSIfcprpm9833f3S/qM4dH+0BMdjV1FRT0iKySQ2lNLDuOPie48w6LokUDI6SFVbV7c/f8BNrQ1UKrIflzPXnFdMB54dGgciqg6ci2xmUtB6kc58xsLLwDDuJvw28X+PkouOU+mooIa9JM0sLcN4FAYlzYDCCF+9GoQuNC7gV3x95snigymFcHpi4d5XeiCxP1l+DqxYnGUYgSS6Pv0H/40e/cEscgPoH/slJI8ITGuv3RSrEc5mFOS9vqCA+5ol9mMBaZnQ0mvw0SHl3AUvxpahq8h2fggM/yjXmyUt7MrKAuvzAYSLPreBElo8llMpLg6MCFNSUGaEBju666ZgiS4JDSi56qpjMpPLqcMP7tYSdA9i93ZNtvA6CRwKweh3DJQQWUv1cyDjmFgmuHhz8NfAVNwbZx9xryEiNz4nQvBNVy/QkxklP28o8ha1PTH7js6PnMDczBg+XB2s3xq2RIcBSKcy3MfTemmZ3uH5P365StIrSQV0L8pzHNMkXADcTg+ubzYdJOxjNWot8kOdbdZ64kdU9ua1Dq5xrJwP5kh7kTHdv0le8C/VS8Mz4Fj1FemMnxfBaAz0eSbZWpGPhQMu1nZS9E4KeGYeRV78EZtsB3oNUUSz6PM2OafB1ujCqe9qgTJKnRHUx+4Vu+1m/W4YRCVKPJcTgjzSy0cmK6MXBUf9hkU9dILNd9QuA0Raxr7smMC6Mf81jVM2AQRz7tzETA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(7696005)(122000001)(53546011)(6506007)(2906002)(4744005)(55016003)(33656002)(186003)(9686003)(316002)(66946007)(54906003)(8676002)(86362001)(66476007)(66556008)(66446008)(64756008)(76116006)(4326008)(110136005)(38070700005)(71200400001)(41300700001)(52536014)(8936002)(5660300002)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d2BPRi8zRANe9CnlPryclAcec7ytC6v8UfcucqIf93DmQiHD88A8aYOBr7?=
 =?iso-8859-1?Q?xPj6w7gV9dy199xQEqa13/Q7Sg/gqhXQuJNrxR2kdRkatH9gBGYgTU/jt9?=
 =?iso-8859-1?Q?mIit9kliN/LCt1vCZuS2/3/VkayzvGer8YKc5BwinJKSFQJYPO62RuLpjK?=
 =?iso-8859-1?Q?fJdpcpdNiuYRxSvHtvf8toNpgOITSQbmt0EsXR4YX0RQFaFRkQOq0PB768?=
 =?iso-8859-1?Q?ZPURGgF1iiJc1Q1UFR/dDXz3HW3U2mrW1SLGexvNZwSYY4pJTm6ECmtr8k?=
 =?iso-8859-1?Q?dG2XYDX8mle1u4KA8MLJoSCkrc3Wt9eHltNSE0sNl15P7COpgXdBq0vpc2?=
 =?iso-8859-1?Q?Tjx7MueXXp/8JsX+fpqNBdq53IqmUHctD4DxOmLy5uvx7TAVYJjEEMW22d?=
 =?iso-8859-1?Q?rMVb4j1QZIlYdpDDNdTynMaAZ1J5QTppH8m1Yb8aMID5pgGg1cumCS+k5Y?=
 =?iso-8859-1?Q?78GxA408gauJkOD2I0fO4k5eyXkzNs7V2JShHCCPKwnL2tDc9rDZuFENEI?=
 =?iso-8859-1?Q?ZqAp965kJ+Jak9NZi2+JcLmWoGNHfBodIJrQnsR3i1+ei5I9UPLxJZiz1D?=
 =?iso-8859-1?Q?uPnNeh7YU7tXbnIQiSfOXIxhUBkzzTXan0bu+T8xeHB6DqIHQ4I7YTg3fo?=
 =?iso-8859-1?Q?/i4ATYNh2ClUC1C6r9PmoOwJOdYt9FbvbNkLesoiVz6J2QvkcqeeRRDFSm?=
 =?iso-8859-1?Q?EpI1vY9h29MzDwK0vDDVC2HAwqQjVxpVcKuLHPfWuWm5bRt9PGW7FVsUB2?=
 =?iso-8859-1?Q?mIXGTKj9VWQvAANoMGoF4ze2SP+wNwsKI+ngzYBYmGHDQvgH+MntTuOxQE?=
 =?iso-8859-1?Q?ss6JZXqWYx3DBNo9PQOoLchicjWp9Vu+LEfzs5HPIAA3IvOPyofRFDO+ol?=
 =?iso-8859-1?Q?YIERhm6jjMjpYHcKM9d5eST5xssrMpmpKf4luxp8BxJEc5PygAkV9QpZBg?=
 =?iso-8859-1?Q?RVM1lKHDibAxfjLR7EtVxUml2H+jhfXtfs4PETvW9MEKyGOAYe9xlkpI/H?=
 =?iso-8859-1?Q?dN4R06yM/AHqM8dH0uWsdPdZuV+tuFWLywpGz9eONMWO6+WGop7Vi7LFtt?=
 =?iso-8859-1?Q?fkCKPsZyVQNvexNuRjid4GVYvgg62ErH+x0AEFVY5A+EHesCeozw6dgsXB?=
 =?iso-8859-1?Q?2xX9mxmeGixpb/ohvGQR6pF44mVu3HdZrRljOiuWavJK3PKebTI7Q+1LNu?=
 =?iso-8859-1?Q?vERuU8Ihk+0ROY0oVIP2KOyNUdSGHirc5d1p9+6m20zCp9N7cnD6SHkaTt?=
 =?iso-8859-1?Q?cqaItSfptLmCTVUwMc60d0ilzptvKrgIwmxeuKpnqmcobBY1k5eFarzQ3X?=
 =?iso-8859-1?Q?g7DZMTRUGfy1bon6WUaor3nT/ke1h3s/3VbjsYUVMZv3SLnL3u857Qn2qG?=
 =?iso-8859-1?Q?eDUb+lwfo16tQXD9N6lr1ItlIJQSIsvXgiOzA5jV83TQQIiQ+czHYZg2PF?=
 =?iso-8859-1?Q?pX0BI4TtEI2aV/jraN2IaI6mABOBzGP22GcbBjwTHkV0YiUlHb9jwQBUK3?=
 =?iso-8859-1?Q?xh/1ZqLzv38CnmUAgXocgEx32n0j5QYJbGZy8NzzKC+zwo+FcMjjVxmoBn?=
 =?iso-8859-1?Q?ErGqkolHu2gW3B7GmtI51jCXB09xcv0ZcgQ2eN8dY9bpYxTpOTxIzrp560?=
 =?iso-8859-1?Q?ZsMP9mi1QY9ZU7qrPWYbOmR03T1hvWQYM7pbM8seMVqWef70kIg8zSWfTf?=
 =?iso-8859-1?Q?Y3ymAGVxyg+V+8I7fzOi+ojIfNFQkZzVuTVIiYN4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d971729-2301-4f7c-de5a-08da8a7da535
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:49:07.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+iNrO1um7AjFHTkpmAu4tnKLZtijKrXFaoe49JgPTsw7zNBgfM3u7s6aGIyVCPUdSHXJWxiBd03mz4t5JM8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5139
X-Proofpoint-ORIG-GUID: wmqod9lXlfK0ADE_vCoxrgFu6dJxOK55
X-Proofpoint-GUID: wmqod9lXlfK0ADE_vCoxrgFu6dJxOK55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_06,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=781 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300058
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Sent: Friday, August 19, 2022 9:21 PM
> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3 14/14] iio: hmc425a: simplify using
> devm_regulator_get_enable()
>=20
> [External]
>=20
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

(I see that in this patch you are not using dev_err_probe(). Maybe some
consistency in the series and where applicable would be appropriate :))
