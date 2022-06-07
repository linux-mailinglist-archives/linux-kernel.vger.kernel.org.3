Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5061D53F386
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiFGBt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiFGBtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83068325;
        Mon,  6 Jun 2022 18:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfbC1ytudzgywDSUnlPizJz0CYIGR6EXOsxssSLOY75wCeMjKWq5gWpb/w/6fJM/xFO+hLPYbrh0LR+4PUNZl8a5szkSEju/lbgDghZ5H4C9YXsskRH771CmpI12Vj61MrMqP7989ROKjkHzTPrFXKZdAMOEqwFPRl7egz4MovLovqaFVq8Yfmcx9f1cX6DP0j6xhbguqdRbN9Z9+PQ85COHwBOj6P9g6HP/sCRnbYR9m31KX0O17AbL5fyJERD5vOp3lmrYy2mddVBevIRGUC/bWPwFw8v0qHj6ajBs5XtYG+Xm1yMPBy0pGc0fjxF3nrEqLgVYfBJWZ7oCAIXM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSnqnZCwBwms90+Fx4N2a3m7C56GgdZjf2SoeZL34fQ=;
 b=f3H3SA79QpTEhk8YdLm4YdEynKe2KZLziEvaY0pDrOIsv8TjT1xTVwkYbRaPTK0KeYLG/cUQpdmTCwkCSopcStb2tPMQJsFtTkTb+7hQXPeLTb3QMqlMHVExXbZRE5jLHgUALq6l+ZYWt2z7Dy4EC3kpuv9LIjySA9bLk2zEzqLswE1TxYEEFDbmjk6PI9+48lSoXrgBheq/bOFVbxrU9Ct70FMHvtBwE58UU6tDuuUa//egRNcUcMSzvghYwBDvjAeiywvvKJyMMvdknQYYm+BvueXJBHpdKls00QswoFNEDHg2zyu3OjgEGClxDkvuksx/J9xexSlSyRW+ljn0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSnqnZCwBwms90+Fx4N2a3m7C56GgdZjf2SoeZL34fQ=;
 b=Fq3/Q58jtf/qJcdSLcNKV8bUxwHcLyVvKgQvw8SQzE9wGIxBAhg5AxAOf7ksybL05iGej70ec2CsXHmacj1y2VDXezFId4eFzYhaWkXruKcr6Z8qIh4nKERTEO2sa8g+Rl5Y9PK/5W4CaNstSYldMxvve3Hj7zZhN0FpsSBxvMM=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by HE1PR0402MB3388.eurprd04.prod.outlook.com (2603:10a6:7:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 01:49:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 01:49:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Thread-Topic: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Thread-Index: AQHYc/mclVqKJ6jFKUC3eH0lZl8KFq1BDqAAgACkeoCAAHgdgIABDidw
Date:   Tue, 7 Jun 2022 01:49:15 +0000
Message-ID: <AM6PR04MB63411FDF5208C591AC9D010BE7A59@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220530074756.14585-1-ming.qian@nxp.com>
 <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
 <AM6PR04MB63411F7904814E87116A5BEAE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <9b2acc8d-9755-9853-1dcb-cc9971a6ee1a@oss.nxp.com>
In-Reply-To: <9b2acc8d-9755-9853-1dcb-cc9971a6ee1a@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ff5dc71-008b-4dc8-5537-08da4827ed77
x-ms-traffictypediagnostic: HE1PR0402MB3388:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB3388E58F1D9668D3E9C6D29FE7A59@HE1PR0402MB3388.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLiRStVyXs+5iu1fTX90lpxQfc/Pw09jzgGZuOAElz6zb/3R6v9G+CWXD6cP9VuBwmOQNNe3rsTcnyVUzH3m0yGsNPnFYyVj9dnfn8DPpyRqhOdWG1wZObFNEa4RhagZeUI8yZgMd6cg95ljK7ZRD2kUhXOACOTNR5RtjViyA5GUJNgXCan0j3ON2BZ7XJEj0V5e4fnl1AhNhXzdEooOR63H/1KyUnGakaPGJ9HYwky9D2ztq1ruLEUkuefwRLOGk0t2hGOdNo8OPhomTAnVnsY9sXyAgGbJzpLohGYXmfMXFYKYJ/hVS/u5ksH1L3YKlqE6iP4dnq31H6cvLAqb295ISZ8mKcyaE47Ft5MG+5j+Qxsx1npIk8yqkhmBxc4+aQAmtCCr+5h3DjoVlHl8H8oCRyO+N5MT3AtNhqAdjrTTNy83lhWB6kgANiKxPk2z3JdlGKOsPvAyhlx0s0jluqdqTtZ5j384tvlHoPWAUUrA5BNYV+fN0D80Xu/FZuemuWG2X8JvC/xDG0aJV4EU+QSwAbhBguffmLNLB4vxaL+F1tXeb5Ov9kHtYIL8qH5rk80AxriApT9/K3GoWTfvXS3rakFaNHZSeBniT54k/WEEBrzWF0NWzKZc/vmzcHJ/spvNA3u48ApCKfFD3hrjDtebLX0Sj7g42zh0MwwLfAYINu4sqbn719iuD1XW1yz2pN/hiA0JSYgs16ZfSqh8ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(71200400001)(508600001)(316002)(86362001)(122000001)(7416002)(83380400001)(33656002)(38100700002)(44832011)(8936002)(64756008)(53546011)(54906003)(2906002)(110136005)(66556008)(66476007)(66446008)(4326008)(26005)(6506007)(7696005)(9686003)(52536014)(8676002)(38070700005)(76116006)(66946007)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lRSHN6blI3UnUrem12VkM5S25NVnN1S05DT3VBQWo1cjVvMTVYY29SS2ZY?=
 =?utf-8?B?ZVNqNWR6by9wWThLTXh1cmpLcE55aVJHOE9NcWJ3YXh3bmtaTUR3bnNQcEVs?=
 =?utf-8?B?eFozODVHcmlRcEV1SmRJemQ5ZWpNSjg0Z1ROcDB5Y2NLSEwvMVBkR1BBd3dW?=
 =?utf-8?B?TkRHSGFpOFJYcDBDaW9wQVNxV2hQbUVCSjZlM2ppYXlYR1ZwK2IwekNocGR2?=
 =?utf-8?B?NnRYcFlPQll5akthVEhJS0o3aTZTRHFOcWZnZC9CeCtER09tL2hWeUtIY2F1?=
 =?utf-8?B?NlQ3R2tmRHFsSDlVTWJyTjBJbGJ6dWl2bzZpdnRVSytDdHIzejdGODd1bDJr?=
 =?utf-8?B?YVF1bysyay9rZ1llTkZVbWdSK0JjVFJyejFGRElzTkZKbUh3elZhR1ZDSmlo?=
 =?utf-8?B?YW02blp3OGZMK3JKRDhoSzBGUktpRWdJTGxHWWVWWkRORjVjSWp1a3ZSclpW?=
 =?utf-8?B?VDdiNWNJSkVoVGZjRXBHRHdKVzNGMVVGN0NlMTJ1Zm1DV3FrSG16ODBXdTFE?=
 =?utf-8?B?R25XUFFZUTVQb1Jic1NiV0NJZWFxMWxEUE16Q1pyY092ODNEVzUyN2xCRDFX?=
 =?utf-8?B?QnFCZEhMam9qUlU5eWJyalVZcFppMW1uRnBja1BkYnZaS0ZFV2ZZd2MzaWIw?=
 =?utf-8?B?RFdBZDdXVUYxeitMUW92aE9Zc3drYThoZDJPMkpHbUFmR0l3WmYySW9mNWtZ?=
 =?utf-8?B?c0syS0xEbTJKb0pIVWFvaW1KaFMxdUtWdEdYdm50TCtsbXhmTGhYR0FxZlhI?=
 =?utf-8?B?ZW52dFBJZndmRWFIQmZ2Sy9FYkFJNFBFRzhnejZYRUpnS09hSEZYd0daRW83?=
 =?utf-8?B?RlIyMUZteHFFZ0lPd21McFc0VnJMd09JenJaZTFZZ2pPS0VxRm51YmJRczFv?=
 =?utf-8?B?WVlGelEwcTd0WlNQdFYwSVRIWnZVWHpQd0lRcm00WkNkcVkwYURKcHVvejhi?=
 =?utf-8?B?R29YUzBYSUNkQWlMREh6SWpuMUtCTkRnNVhlL3ViZUhVdjA4M1JNZUxJVmxy?=
 =?utf-8?B?c2gyc2o0YjlXZkV1MUxMdVdDd21NSkdsM0tMeFd6RnIvMTRGckQxbFc0Mytp?=
 =?utf-8?B?Z3hmSzR4ZEZCVnhSMDVTSHI1QzlaSUdtbzZtZUV4aVdnbXpPMlNFQW5aSERo?=
 =?utf-8?B?VmNyckJBVUVaVTllaXFmZHBYOTlQVWN5dmYwb1E5R0F4OVdrMnBkMDJrZlN6?=
 =?utf-8?B?V2pTVGJrdFA5M2s2V2FFSldQS1VQQzhqRmN4djg4ZFhJT201RTEyWDh1ay9B?=
 =?utf-8?B?UjZxZncxQS9CWkVOY3ZzSi9xamlaWE5lcWIxaGhRNjVVOFV6NFoyTXc4eCt1?=
 =?utf-8?B?ZXN2UjJaZHo1OGxpL08wK0Uwd1BnTFpNZVEwREpZVUZtdDc4YTZySjF2T0JJ?=
 =?utf-8?B?SkZiRk9mL3JlSEdqQXp0c0QwU1lCLzVNWk1JcmtlSklIbm1FcVJjZDl4WlZ6?=
 =?utf-8?B?N044VDdvYnh6UkZPT0ZMTjMyTGJUb1RRTkpwV3ozaE9MZDAwSkp4L2V5MS9E?=
 =?utf-8?B?RTFaVmE4YXNZTWRIZzNtVSttaEROWkhnSkhFK1J0QTB2S1RETWVCcWxveWNr?=
 =?utf-8?B?ZmgxN3ErTHNyZlFxcHh2YTA3bC9uOEc3T29VTFE3NW9QdUphZU81WW5VbVA3?=
 =?utf-8?B?WE9neFpKUEkvenltR01ETUFFYlVKRXNUa21wTVZuOWtVa3NFWVJHNGxwSXhS?=
 =?utf-8?B?aStmNExQazBGZnphK0crUVFlTUphVXVoRll6czNsUG80bG5lVkJXUkFZK1lC?=
 =?utf-8?B?THFCSnJqdFFGUlRyZnJ3WlhGSlMwYmRXckNtVVQxbWRTV3ZvL0NaNGt4WUs5?=
 =?utf-8?B?cWMra3hHT0p3d3k4Y1VzK0dyZ1htR2JJTXVKUmVQcng4VStTczZFbU95cVk3?=
 =?utf-8?B?RkNEVVVoUjV4L3pwYVd5ZlcwcEthL3A1dDIwVC9tZTVtbFRYMHJaSzNWbE03?=
 =?utf-8?B?MExtelF5UU5SSTgveGVva2hadXltczYzcHo2bjB1ZzBtWkxocEhJLzZLajVq?=
 =?utf-8?B?VEYySjdkaFpIT2grRzJHVm45UFhoVmFQZXdpdFVxbnd6YVJ6MEptTy85eDVs?=
 =?utf-8?B?RFMva3psUUp4dlJwVVVBWWQvSklCYmxEQy82bSt1enhaQStaMi9XZnpEb09R?=
 =?utf-8?B?YUkySEtlUi9obTdIQzZWY2RTd1ozZjZoeDNRUFVjMTFZWnZSa01rbHU5cENG?=
 =?utf-8?B?cG1QS3RYNnlNTjM5NkpzRHV6K1V3UHVnVk9ieFU5N3N1ZjZmL21KNmhhdE5l?=
 =?utf-8?B?cllzQmlqYVYzR01DRWo1Unp5dHdaZTkzUzFKQTM0NW1DTE1EY3cwNFZ1R2tr?=
 =?utf-8?Q?AFtlBfGeyFkchnePvT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5dc71-008b-4dc8-5537-08da4827ed77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 01:49:15.0823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUrxG0Xc3QIyRhYKNTrtHuxqQRwb9KaXiFCTWjJfONlrwmNwuFrQB7EzzghWoRdeOAGLwWE+i0LF5KTpUoYM3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaXJlbGEgUmFidWxlYSAoT1NTKSA8bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+
DQo+IFNlbnQ6IDIwMjLlubQ25pyINuaXpSAxNzo0MQ0KPiBUbzogTWluZyBRaWFuIDxtaW5nLnFp
YW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gaHZlcmt1aWwtY2lzY29AeHM0YWxs
Lm5sDQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSBtZWRpYTogaW14LWpwZWc6IERpc2FibGUgc29tZSB1bnVzZWQgaW50ZXJydXB0DQo+
IA0KPiANCj4gDQo+IE9uIDA2LjA2LjIwMjIgMDU6MzMsIE1pbmcgUWlhbiB3cm90ZToNCj4gPj4g
RnJvbTogTWlyZWxhIFJhYnVsZWEgKE9TUykgPG1pcmVsYS5yYWJ1bGVhQG9zcy5ueHAuY29tPg0K
PiA+PiBTZW50OiAyMDIy5bm0NuaciDbml6UgMDo0Mw0KPiA+PiBUbzogTWluZyBRaWFuIDxtaW5n
LnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gPj4gaHZlcmt1aWwtY2lzY29A
eHM0YWxsLm5sDQo+ID4+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiA+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsg
ZGwtbGludXgtaW14DQo+ID4+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIu
a2VybmVsLm9yZzsNCj4gPj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtZWRpYTogaW14LWpwZWc6IERpc2Fi
bGUgc29tZSB1bnVzZWQNCj4gPj4gaW50ZXJydXB0DQo+ID4+DQo+ID4+IEhpIE1pbmcsDQo+ID4+
DQo+ID4+IE9uIDMwLjA1LjIwMjIgMTA6NDcsIE1pbmcgUWlhbiB3cm90ZToNCj4gPj4+IFRoZSBp
bnRlcnJ1cHQgU1RNQlVGX0hBTEYgbWF5IGJlIHRyaWdnZXJlZCBhZnRlciBmcmFtZSBkb25lLg0K
PiA+Pj4gSXQgbWF5IGxlZCB0byBzeXN0ZW0gaGFuZyBpZiBkcml2ZXIgdHJ5IHRvIGFjY2VzcyB0
aGUgcmVnaXN0ZXIgYWZ0ZXINCj4gPj4+IHBvd2VyIG9mZi4NCj4gPj4+IEFuZCBpbnRlcnJ1cHQg
U1RNQlVGX0hBTEYgYW5kIFNUTUJVRl9SVE5EIGhhdmUgbm8gb3RoZXIgZWZmZWN0Lg0KPiA+Pj4g
U28gZGlzYWJsZSB0aGVtIGFuZCB0aGUgdW51c2VkIGludGVycnVwdHMuDQo+ID4+Pg0KPiA+Pj4g
Rml4ZXM6IDJkYjE2YzZlZDcyY2UgKCJtZWRpYTogaW14LWpwZWc6IEFkZCBWNEwyIGRyaXZlciBm
b3IgaS5NWDgNCj4gPj4+IEpQRUcNCj4gPj4+IEVuY29kZXIvRGVjb2RlciIpDQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiB2Mg0KPiA+Pj4gLSBhZGQgRml4ZXMgdGFnDQo+ID4+PiAgICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL254cC9pbXgtanBlZy9teGMtanBlZy1ody5jIHwgMiArLQ0KPiA+Pj4gICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLWh3LmMN
Cj4gPj4+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcu
Yw0KPiA+Pj4gaW5kZXggYzQ4MjIyODI2MmEzLi4yNThmYmVlN2FiNjYgMTAwNjQ0DQo+ID4+PiAt
LS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy1ody5jDQo+
ID4+PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy1o
dy5jDQo+ID4+PiBAQCAtNzYsNyArNzYsNyBAQCB2b2lkIHByaW50X3dyYXBwZXJfaW5mbyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHZvaWQNCj4gPj4+IF9faW9tZW0gKnJlZykNCj4gPj4+DQo+ID4+PiAg
ICB2b2lkIG14Y19qcGVnX2VuYWJsZV9pcnEodm9pZCBfX2lvbWVtICpyZWcsIGludCBzbG90KQ0K
PiA+Pj4gICAgew0KPiA+Pj4gLQl3cml0ZWwoMHhGRkZGRkZGRiwgcmVnICsgTVhDX1NMT1RfT0ZG
U0VUKHNsb3QsIFNMT1RfSVJRX0VOKSk7DQo+ID4+PiArCXdyaXRlbCgweEYwQywgcmVnICsgTVhD
X1NMT1RfT0ZGU0VUKHNsb3QsIFNMT1RfSVJRX0VOKSk7DQo+ID4+DQo+ID4+IFRoZXJlIGlzIGFu
b3RoZXIgd2F5LCBsZXNzIGFnZ3Jlc3NpdmUsIHRvIGdvIGFyb3VuZCB0aGlzLCBkaXNhYmxlIGFs
bA0KPiA+PiB0aGUgaW50ZXJydXB0cyBvbmNlIEZSTURPTkUgaXMgcmVjZWl2ZWQgKG9yIHNvbWUg
b3RoZXIgZXJyb3INCj4gPj4gY29uZGl0aW9uKSwgaW50ZXJydXB0cyB3aWxsIGdldCByZS1lbmFi
bGVkIGF0IHRoZSBuZXh0IGRldmljZV9ydW4uIEkNCj4gPj4gY2hlY2tlZCB0aGlzIHdvcmtzLCBp
bg0KPiA+PiBteGNfanBlZ19kZWNfaXJxOg0KPiA+PiBidWZmZXJzX2RvbmU6DQo+ID4+IAl3cml0
ZWwoMHgwLCByZWcgKyBNWENfU0xPVF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFfRU4pKTsNCj4gPj4N
Cj4gPg0KPiA+IEhpIE1pcmVsYSwNCj4gPg0KPiA+IFllcywgSSB0aGluayBpdCBzaG91bGQgd29y
ayBpZiB3ZSBkaXNhYmxlIHNsb3QgaW50ZXJydXB0IHdoZW4gZnJhbWUgZG9uZS4NCj4gPiBBbmQg
d2hpY2ggc29sdXRpb24gZG8geW91IHByZWZlcj8NCj4gDQo+IEhpIE1pbmcsIEkgZG9uJ3QgaGF2
ZSBhIHN0cm9uZyBwcmVmZXJlbmNlLCBidXQganVzdCBpbiBjYXNlIHdlIGRlY2lkZSB0byBsYXRl
cg0KPiB1c2Ugc29tZSBvZiB0aGVzZSBpbnRlcnJ1cHRzLCBJIHdvdWxkIHN1Z2dlc3QgdG8gZ28g
d2l0aCB0aGUgZGlzYWJsaW5nIGFmdGVyDQo+IEZSTURPTkUuDQo+IA0KPiBQbGVhc2UgZG8gbm90
IGZvcmdldCB0byBjbGVhbiB0aGUgb3RoZXIgY29kZSByZWxhdGVkIHRvICJJbnN0YW5jZSByZWxl
YXNlZA0KPiBiZWZvcmUgdGhlIGVuZCBvZiB0cmFuc2FjdGlvbiIuDQo+IA0KPiBUaGFua3MsDQo+
IE1pcmVsYQ0KPiANCg0KT0ssIEknbGwgbWFrZSBhbm90aGVyIHBhdGNoIHRoYXQgZGlzYWJsZSBz
bG90IGludGVycnVwdCB3aGVuIGZyYW1lIGRvbmUsIGFuZCBjbGVhbiB0aGUgY29kZS4NCg0KPiA+
DQo+ID4gTWluZw0KPiA+DQo+ID4+IEVpdGhlciB3YXksIEkgd291bGQgYWxzbyByZXBsYWNlIHRo
aXM6DQo+ID4+IAlpZiAoIWN0eCkgew0KPiA+PiAJCWRldl9lcnIoZGV2LA0KPiA+PiAJCQkiSW5z
dGFuY2UgcmVsZWFzZWQgYmVmb3JlIHRoZSBlbmQgb2YgdHJhbnNhY3Rpb24uXG4iKTsNCj4gPj4g
CQkvKiBzb2Z0IHJlc2V0IG9ubHkgcmVzZXRzIGludGVybmFsIHN0YXRlLCBub3QgcmVnaXN0ZXJz
ICovDQo+ID4+IAkJbXhjX2pwZWdfc3dfcmVzZXQocmVnKTsNCj4gPj4gCQkvKiBjbGVhciBhbGwg
aW50ZXJydXB0cyAqLw0KPiA+PiAJCXdyaXRlbCgweEZGRkZGRkZGLCByZWcgKyBNWENfU0xPVF9P
RkZTRVQoc2xvdCwgU0xPVF9TVEFUVVMpKTsNCj4gPj4gCQlnb3RvIGpvYl91bmxvY2s7DQo+ID4+
IAl9DQo+ID4+DQo+ID4+IFdpdGggc29tZXRoaW5nIGxpa2U6DQo+ID4+IEJVR19PTighY3R4KQ0K
PiA+Pg0KPiA+PiBUaGUgaW5pdGlhbCBpbnRlbnQgb2YgdGhpcyBjb2RlIHdhcyB0byBjb3BlIHdp
dGggdGhlIHNhbWUgcHJvYmxlbSwNCj4gPj4gU1RNQlVGX0hBTEYgaW50ZXJydXB0IHJlY2VpdmVk
IGFmdGVyIEZSTURPTkUsIHdoaWNoIGNvdWxkIG5vdCBiZQ0KPiA+PiBjbGVhcmVkLCBidXQgaXQg
d2FzIG5vdCBkb25lIHJpZ2h0LCBJIGNhbiBzZWUgdGhlIGhhbmcgaW4gc29tZSByYXJlDQo+ID4+
IGNhc2VzLiBXZSBzaG91bGQgbm90IHJ1biBpbnRvIGl0IGFueW1vcmUsIHdpdGggaW50ZXJydXB0
cyBkaXNhYmxlZCwNCj4gPj4gZWl0aGVyIHRoZSB3YXkgeW91IHByb3Bvc2VkLCBvciBtaW5lLg0K
PiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBNaXJlbGENCj4gPj4NCj4gPj4+ICAgIH0NCj4gPj4+
DQo+ID4+PiAgICB2b2lkIG14Y19qcGVnX3N3X3Jlc2V0KHZvaWQgX19pb21lbSAqcmVnKQ0K
