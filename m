Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8022A5978E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiHQVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiHQVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:24:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A7606B9;
        Wed, 17 Aug 2022 14:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNQq0X8liHdvPgGMUnYiCELE0rjZo1dnMWclWjgc4jeOk5PRmLrhDHZd756/JTQpGgNJvF5t9CcQWWOBIcXwgfFie5GJnn7M3AlInW6ueM0ohLfKtcwSykOgAA3jIMMHbA2M7CFxeB1SdQxeKVByIIDNlh7HAEoTUAN1bEpGdiarqxIgUFz6GXDAihflHMZbb8KmkcW4L9+uRkCRHpPCezEkU6eW5pKIjsmhzdwd0wu2EjqE3tFiDg+WBfNZt67tlFkLz87ysSS6CvH5NRK8kiNwxL7BLovJEzXUm3/rhJ9W/ROJ+Q0k2p3YFcVEO7J9HxQMC2qJepSDh4jftN72SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ri04zVLJ/96vi8XyPvfVqsE4g4845XK8ih8b/yd52M=;
 b=SVrWDDH5o8NqbNJNbR5V76FIm7sJEG0o2DJ/Jfp3dmQXEhlukrtTW7xRBDKScKk34Bsq1nYv6Xuvt+ZK1vua/fnmWKuq2+ObunFd/H33GVlvgugfVHqp0D3fmwKb/su8HvnZ2VjARremcN8kaRHeF/34u9JEBw1pus3le3sGtJ/vF3fuUtETqSNNqmbGCQLMgluixoryGq8Koz7FO6d4IDGVLkkyGubm2667NETVFEwpINyLNjyEl8yys12vpnVVfRMp8J+PUyPPdOQaJsdxAn0Be0JAbAkcDwhzW3jkP32+sx709vAHjDl9EyCOJhijTd8GjtGDNWpU68rBHDkUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ri04zVLJ/96vi8XyPvfVqsE4g4845XK8ih8b/yd52M=;
 b=jNO+OjRvDX4ZZyO6IEfiObm45hMR8DztWV2g/7xP1ciQw6P28bXOB5umUcz7Hjx8eF7cgZw3ufIqRnuCXw0VeYu1f3fA3CdvvMvP1oMn6WolvcBQZ2x+R7MvCp1jtLBQwzOx25oggPWtcq/YpiahqoF1wlg3cUv7zU/Ij+QQ7W0=
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DB6PR0401MB2373.eurprd04.prod.outlook.com (2603:10a6:4:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 21:24:52 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::4c93:c881:970:4315]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::4c93:c881:970:4315%3]) with mapi id 15.20.5546.016; Wed, 17 Aug 2022
 21:24:52 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        Ming Qian <ming.qian@nxp.com>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] media: imx-jpeg: Disable useless interrupt to avoid
 kernel panic
Thread-Topic: [PATCH] media: imx-jpeg: Disable useless interrupt to avoid
 kernel panic
Thread-Index: AQHYp+YIZQuPM54Zmka+l+SxAcLKd62zr8WA
Date:   Wed, 17 Aug 2022 21:24:52 +0000
Message-ID: <a231331f2b78b907e7f1fd678828ad64fe48e17b.camel@nxp.com>
References: <20220804093841.31337-1-ming.qian@nxp.com>
In-Reply-To: <20220804093841.31337-1-ming.qian@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563ea4ed-a7f4-42cb-1111-08da8096ec74
x-ms-traffictypediagnostic: DB6PR0401MB2373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIzpeusMRvL07YpZN1RECn5OkV3x8uE1Ou73dwngSy+Kaq/cHuHNbZ+DqejP4yxn+xmSrrUz13xjdwzPuGMmr/S1+SMRZpWM3OP6j3Y0zOOLMauCYyaRcsdaePAauz2TElDGOB54T3enIHG6QT1g3B8jBx4zxOBkguPkr56BDYEW5RgCmPYXuC+DFkA0ME9fjso3I+u3+uvR4GWs8a+PrRoLEVKCxdshvP5Lpkokgf8l+aKxmQP1kM3CrU9QN0bezBuWkA+uW5L8qU2HN3o75BzON5qroWm0dMQj2iNMKJi7fa0f4YqAETEOLNPk9FosVXV/jfJ1Ean1Qii7rW+5f6q5L8wEOoI8yS16IgGXazEb8b4ASOyEmxwxJQaLwGEp2f0y9nyWX8Q7GeOS1uWnGbuPC6zi/Jvf/cXrb1dMkXmy8CaHIHoykS4gBOOCYpbMal7mfygnoRubD8xGHGf/tyBdj520KjL5pVRNZuR+ud/WA3HasiGqtTAbfdnbQUainuv66rjrqmwO0mnldb2zhjuJ/7dEzEKalC60m8587SnQrKfm0LZRhNZ0Vjvcw1qXiTcDLQJpOJ/f528oD9hX/yKtUe8+x5z3tTHQIBELKqbTjw9ReMbegqKoMyIY//fq1hOzqOryIJagwT5nG2XPy25d2ccbqKB0cz2ZA2FPadVgiaRoTc1ZVLZg8IpygVw/TTuSyVlzgpxxsZHbPA/1hJXD9xS/ZLCGkgLs0s6sjccxy2JvL8QfCGfrBrzdJEH8DY7o/Ov53yMr8hkjc0WBVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(66556008)(66446008)(66476007)(66946007)(91956017)(8676002)(4326008)(6512007)(83380400001)(64756008)(26005)(41300700001)(76116006)(8936002)(5660300002)(7416002)(86362001)(44832011)(6506007)(478600001)(2906002)(38100700002)(186003)(6486002)(110136005)(54906003)(122000001)(2616005)(36756003)(38070700005)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUcxTU9ENDVwdjR1enhFMlppaFB4QlQzMVFZdmRzcm1DOEpFODRwVDZ0Rkpr?=
 =?utf-8?B?T21XQUgvaHRRMlg4Q1VOdEltMHp3OHZXRStRV3lwM3FoMUJpeUxUREtwOHRK?=
 =?utf-8?B?ZFdJM2ZUUjFYc1EvS29ienJQcXF3b2JRMHd4T0NJRkJpaDlBRngrZTNPOXFW?=
 =?utf-8?B?R3pueCtiVXA1RFArcEJ2SDhtbmZ5K1ZTVjhMZDRZL3ZjUHdmVXI2V2xTRWly?=
 =?utf-8?B?SWUwa2NFMVVUUzVYV09SMnRjYWNNWjhIRDV1MWxFQ0lJUFVsWUZwQ2YrOUdW?=
 =?utf-8?B?ak42anBMdTQ3VWVMUGYwV1Jmd1FIc2ZiZnp1d2w3YTh0NGdJT0d1R3hhTzVh?=
 =?utf-8?B?VGcvSVJZdTFZd0MvTGpWQm5TUjNwTWJqNlQ0QVAzMElUeURwYjYvbjNud3J0?=
 =?utf-8?B?Y0RTc2E0QmJGaE12NUpJZG5HZlE3MVBURWc4K1RhNFJ3VDl0NElHbDJ4SjlK?=
 =?utf-8?B?d0x5Wmdzbm0zQW5jR0lFbVJGUHl5VjllUUZudUFrWDdTdEJadnJmU1hxQ210?=
 =?utf-8?B?V0ZQVHczblJ2emcyQlVWM2RtdmltTWJhRENmd25JRXM5M2FDSkFwcHdUc3Qr?=
 =?utf-8?B?QXZheUduR0FXNlRCNUs1TThRQm1WdjZ0a1V4ZW84R1pBZWtuU2NhV0xuWlRy?=
 =?utf-8?B?dGsrMnBkTWU5bld4ZzNqUTdldnAwTVFKV1pIcEZFd0Q5STE1MWkwWnJkVXRX?=
 =?utf-8?B?VVRDbjBLcUhRZW9tSmk2TWVDamcrby9US2F5MWJQQTM2Vi9lQmlnekVUc2Jp?=
 =?utf-8?B?d2RvQXUzVlgzdVNkSDFGbktQVENDOXcwRk53aGpONmZHTGRBNlBrUXVxTDI0?=
 =?utf-8?B?U0Urd3IxVCtLbFlmN0xpdEd6NkVkTkxqbFdOUVY1dUVvbHlsaVRjcVFhanZD?=
 =?utf-8?B?RWM3cE9jUi9Lay96ZWpMRXRPcWR5S3krWkxXLzRaSnp4QldTQzEveU93eUJq?=
 =?utf-8?B?MHlva0lBYlZrTHpzWlE2Y3dtMXpwcHpwL2R3SllDYzcxUHY0S282aXFNQjY2?=
 =?utf-8?B?dHJkaXBIeUh6ZkEveWs1VFNhL3djTmNKaXpyRXl4Yk1XU3B2YWZZUnJ1RnJt?=
 =?utf-8?B?SU14c3R0dk16QU9YTi94elpUemhpR05HQnVGc2xJMkMra3E0VktnMEhIRFhB?=
 =?utf-8?B?OHBhNWtvcktFdC9JdStGY2Uwck9VSW5TRnUvVW5uaG5HKzdPcW0rYnFWaThS?=
 =?utf-8?B?UllUZkl2Ni9PbjhFaUJTOVVSY0hwTjZSMUIrOE5wUHZFczdIeFg3eEkrK3gy?=
 =?utf-8?B?R0RyMjlTMmw5TG9VQmFZSExEVHpTRzE2UFpMbkJDbkxoK21qVlFlTkZFTGVh?=
 =?utf-8?B?L0tadUFHQWlwRkVOM25DT1ZZUmh1Mm13bmp6THJFdlZFRFk5Y0ZpOE5BSkdH?=
 =?utf-8?B?RzZHTWVHUHp6MWVxWmxBeXBsTzlMSmg0YzFKQU5qbTdTUXVVZGlCS1pPTFFK?=
 =?utf-8?B?K1c4cUcvbklrOGFYWG5qMCt3NVNOcms1SXhIQjREeGZ5YURYa0NMZ2FZeDVs?=
 =?utf-8?B?bEVpZ1VEdC9tOTNKa24xdXdvUHhsa0M3NnU3K0hoaDgrTTNzbEhWb3Z4aE1v?=
 =?utf-8?B?Y1FmT05PYlVra1pDaXJnekg5UDdjNUZiM0ZhbjZ0SDJyaEx3ZC9aWDVnWTJ5?=
 =?utf-8?B?R2w0YlM0QjhBMXZ2WFpCZ3pWQmtmSHFRc2lSbXRnUjZXVzBIZ3phRi9XYzJP?=
 =?utf-8?B?L3Y1eDFCdjRVVXZ1OTJGbnQybHowMWx2bGlQMWJSelFJUVJ1Vm5yZ2tFNSt1?=
 =?utf-8?B?ZTFrL1RqMDJWK2RwckQ0S2hwNjFUMlpCTTFlckVvQWlPYThhcy8xOHYrVUg1?=
 =?utf-8?B?R3lob0RUY3pINW9SMWd5dG5Wc2VKdkVEV3BrQ3dXU3dZbmNBeGxhZDlDRFlm?=
 =?utf-8?B?cFVzUTlORFJLWDdtRUNjNlB3ZW5rVE51d0M3RWloLzNtZmtpWkptQUVXQ0ZE?=
 =?utf-8?B?YWF2SG9KT2JpZEpKNU1Bamlmd3lkSVJMZ1hkSmRJbTFtaFJ6R1BCczBlaEQv?=
 =?utf-8?B?WEp0NkxLc1N2VXd4c0JpSnA1SHJxSGRBSkQ4YlBJeWtYQXFveXp6eDRBbHlq?=
 =?utf-8?B?MkNEV0JCVnV0OWpCSEVKa3pOK1JTbE5HelhJdDV2R1NjVmphS3JwRWJFOTlk?=
 =?utf-8?B?RzNZT0U0QVU3NE1aZGprTFd5c3BwZ3luemlQUmZzZ1J5UmxXL05qd1JaRVFQ?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75825C36A2B9DF41B1C1173E6B4868E5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563ea4ed-a7f4-42cb-1111-08da8096ec74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 21:24:52.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aF7Xe7wHR6KO2SaReKXnVB98AKXkZ57ZO/ag1jg6xDPDnuvYc81+7BIAt9hSg9ns0jMjrPRXD+58VEre8/TQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTA0IGF0IDE3OjM4ICswODAwLCBNaW5nIFFpYW4gd3JvdGU6DQo+IFRo
ZXJlIGlzIGEgaGFyZHdhcmUgYnVnIHRoYXQgdGhlIGludGVycnVwdCBTVE1CVUZfSEFMRiBtYXkg
YmUNCj4gdHJpZ2dlcmVkDQo+IGFmdGVyIG9yIHdoZW4gZGlzYWJsZSBpbnRlcnJ1cHQuDQo+IEl0
IG1heSBsZWQgdG8gdW5leHBlY3RlZCBrZXJuZWwgcGFuaWMuDQo+IEFuZCBpbnRlcnJ1cHQgU1RN
QlVGX0hBTEYgYW5kIFNUTUJVRl9SVE5EIGhhdmUgbm8gb3RoZXIgZWZmZWN0Lg0KPiBTbyBkaXNh
YmxlIHRoZW0gYW5kIHRoZSB1bnVzZWQgaW50ZXJydXB0cy4NCj4gDQo+IG1lYW53aGlsZSBjbGVh
ciB0aGUgaW50ZXJydXB0IHN0YXR1cyB3aGVuIGRpc2FibGUgaW50ZXJydXB0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IE1pcmVsYSBSYWJ1bGVhIDxtaXJlbGEucmFidWxlYUBueHAuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuYyB8IDQgKysrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVn
LWh3LmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy1o
dy5jDQo+IGluZGV4IDk0MThmY2Y3NDBhOC4uZWYyODEyMmE1ZWQ0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy1ody5jDQo+ICsrKyBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gQEAg
LTc2LDEyICs3NiwxNCBAQCB2b2lkIHByaW50X3dyYXBwZXJfaW5mbyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHZvaWQNCj4gX19pb21lbSAqcmVnKQ0KPiAgDQo+ICB2b2lkIG14Y19qcGVnX2VuYWJsZV9p
cnEodm9pZCBfX2lvbWVtICpyZWcsIGludCBzbG90KQ0KPiAgew0KPiAtCXdyaXRlbCgweEZGRkZG
RkZGLCByZWcgKyBNWENfU0xPVF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFfRU4pKTsNCj4gKwl3cml0
ZWwoMHhGRkZGRkZGRiwgcmVnICsgTVhDX1NMT1RfT0ZGU0VUKHNsb3QsIFNMT1RfU1RBVFVTKSk7
DQo+ICsJd3JpdGVsKDB4RjBDLCByZWcgKyBNWENfU0xPVF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFf
RU4pKTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBteGNfanBlZ19kaXNhYmxlX2lycSh2b2lkIF9faW9t
ZW0gKnJlZywgaW50IHNsb3QpDQo+ICB7DQo+ICAJd3JpdGVsKDB4MCwgcmVnICsgTVhDX1NMT1Rf
T0ZGU0VUKHNsb3QsIFNMT1RfSVJRX0VOKSk7DQo+ICsJd3JpdGVsKDB4RkZGRkZGRkYsIHJlZyAr
IE1YQ19TTE9UX09GRlNFVChzbG90LCBTTE9UX1NUQVRVUykpOw0KPiAgfQ0KPiAgDQo+ICB2b2lk
IG14Y19qcGVnX3N3X3Jlc2V0KHZvaWQgX19pb21lbSAqcmVnKQ0K
