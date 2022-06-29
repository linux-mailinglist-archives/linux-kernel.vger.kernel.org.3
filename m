Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4B560084
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiF2MxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF2MxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:53:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78012AEB;
        Wed, 29 Jun 2022 05:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCxP2Zpu4j8qnHWJX9/fRGAubYpJtMsOuXlvksJ+9I4RagPmqS9mkRJ2rxQkhhYx5nJRLPXOb3wr6SsovTG16fyiMAwsG4kkfBoicNQZ5KPKwRwOuTI9da1QzJZdprWlSvCKoknzyfzdIlBwFGjtcEwCSK/w8b16hUL5HFr18QXbc5neXG3dDOnkC84d6TmOps78e58LuqO6Ntj/Peanbpfhgm4PAO2VsqWtyqNOZ7+vq3thUrjNT1n/k/PNRkj4PbvtPREoncDIHXBM/+R9LinOL4ohBjSV0DoXCt0gn5HGa9ZQQNt+ADJQRgSgcFWUUuAv6gHA6NGx7sbqZ7JLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNJjgHdNdJMi8vDcBE6VO0y7c6oZiT+auZkn42DwX0U=;
 b=LXBCnyYgS6wof/iTnrDrjsB2/A5oJ0Sn1iX8/UoJ0byIrmAW5Tb6pPabiUzIJPz6zgy0acWCrPgz7YhuuK6WMdTO0dbtw9glDU507ZbhjwfmCtfRl2QRGVApz76qKMpOzL0m085KvDdqLxFjInONuCZTyZhS6MZIbRxwpaW9xmBrc+eIL6Dzqy89kX7j0cT2rnci1sq2213HF5dw8TZ12eay5+GjbQnCXYbSjJLADpwHGwjzaXkP7AersQkTLoheKcLtUQlLKdBpkgMfQopNqNuubBBsr3BcW6yRedMeLIZPOODqRTNhO4zjBYZT6GvHXHdTTc1svaTgeIgi85Q+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNJjgHdNdJMi8vDcBE6VO0y7c6oZiT+auZkn42DwX0U=;
 b=NRVlITwbFUg0MS3+SsVjsyig3d8twjmSk8n00nQhWOGuvgvxLW7MFBJDNH0+n+2NkJY7vDqU+f00NDEpLk2ZOK/lLu4lm0tbX28ccadQuFc7WWKuXGyJfNgz+88yYshM6iipmnaWwSULrQmUjUmtuxNGslvvd6c46/S6HnWnyo4=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB4244.eurprd04.prod.outlook.com (2603:10a6:208:5d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:53:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 12:53:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Topic: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Index: AQHYiq7J1t29u6ewlE+hUMTTkjT24K1mTPsAgAAKsKA=
Date:   Wed, 29 Jun 2022 12:53:07 +0000
Message-ID: <AM6PR04MB6341531BD31885A7BA3126BBE7BB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
 <26a83f6a-05a1-f67b-2de5-bd67ea50843d@xs4all.nl>
In-Reply-To: <26a83f6a-05a1-f67b-2de5-bd67ea50843d@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a719a3b3-35d5-47dd-ace2-08da59ce5083
x-ms-traffictypediagnostic: AM0PR04MB4244:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZkiPSLTzpavM8TNl1wavP1FNM371Tjo/uxV0JK1hZGlhHqKcBQPjBUkz/FQaEGU5oVCMXpkLhhOohXj+VqtLq2Kf3FxYRKj3WhYjn0xnTO4AvmcfSyvQficooxiolR4wobqBuA/jvOe/bGDnts95NM+EnCBjuaUFPfUgpnkTArNOTG4lTEUDj3OHI7/9rk1LxmU830hr1q5M0DI7Ife4EWdYzPRP8v4B00S9gfFzrltHI9UdY15HMuAMZyAYwA4WPblzP/5O8OoRrOjIW5IKU31HkYIaLseAjYrjOj2qrYiZ8GxO7wCVXQ/2dTSSrmd0IdMsUmOa/5ZnYK/azyC1bHa/aM+B6oeuyZr4QqKwGq89KayrJaqaGI+dc2u+/a/BRvpWaIaRNrV+P2y6V3db+kaGq2PFJxK/3e9s4L9gYzIKnKwScEQ5kEK44jv5zvw/oeRGnHz3vsOF4c2Nf1aJwdAO73TKyM8MLaFlMBPX80Cm0J6d4a1mu69jfvLp5gOaccXAbbCzz+ai1NAQDOYEyUFif1YenHfIC4M6AEo3D1sWJmFgU9lN/5eWInz5ageWVIt5GVIWywPiDSou/pdSCViO0vMBHB7Bv6ce/5KLCCXbByZgYUZfcMoWGcHyMLtVFXDLDF9SRjk54a4RQcloYr9plr6vOZGvkb6bDISsVCJkmXC504+ftGjYTtkGrQ+Ej4pmuurY6dLQthE32N9KEmGyW8+TpeGsbRX9T21oRpRy/763lCHVPlGq3Z8BOBZomkC2SRydItvolshSVdRlaQg3z9YPyfbePlu/7hEwl+lSjyQaUiHOnfP4lpsCaI5Tfug+CJUFwJQ86lPSZUFaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(122000001)(33656002)(38070700005)(86362001)(110136005)(54906003)(2906002)(316002)(8936002)(71200400001)(38100700002)(52536014)(5660300002)(66946007)(64756008)(44832011)(76116006)(66446008)(4326008)(7416002)(186003)(41300700001)(55016003)(83380400001)(6506007)(9686003)(7696005)(66476007)(26005)(53546011)(478600001)(66556008)(8676002)(32563001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGxwU0N3cHJXcEh3YTJXZFA3SlgxZHQzNllwdXppeFhITXdSdys3SHRvZ1ZT?=
 =?utf-8?B?eVlHdGs0cndSWjc1N3QyM2Z0Q0V5OXBzTy9MbXNqNHhZb1VYeXdHQlJaTFFZ?=
 =?utf-8?B?c3dmNW1ETzFQOUdFRGhhZ0UyWk4zUXB6eHAzK3hLeXBObnNta2ZrYnlIa0Zy?=
 =?utf-8?B?UkpZeG14dnlYUmVFREVlWmNueE5OSzlwYmNGemtGSUU4VG5VMDJWWWcycFF0?=
 =?utf-8?B?Sm1yR3Z0VXFMeHhwNWU1ckttbkdEa0RldjFnNEtrbFV2N0ZKK3Y0Ti9kNFRp?=
 =?utf-8?B?bEhpRUtqRVRxaENvZ2FKQndOVlNIWS9Hc25JcitpbUhXUlM0aUdZdEYrMXJB?=
 =?utf-8?B?d2YvTzJ4NGlTUmhodStYMCsrcitUbmhwOFQrbzZIdHQzdlo3VWNTdWlpeGpm?=
 =?utf-8?B?ZWpYVHdoa2R1TkFsU3dZMEs4Sk5ZalhBNlltZ1BDVFZqSlV5U3pIMWRRT1JR?=
 =?utf-8?B?ckNoN0pxWVhNU24rKzh4c2VmUWRnMVNHb3k4LzRYM1FNQjVpL29VWERVenhP?=
 =?utf-8?B?S3F4cHlUMzI3R2RUQVVUUDNQZUlLbXhlejlnS3dPUC84VDdUcVo5VnRVMnlK?=
 =?utf-8?B?ZTF5UTdodXlJMUhOSmpLSHpjbE5Wcms1MmpQSG12aGxlUDVsTmlJN3BlaWNH?=
 =?utf-8?B?OWhVR0xGZk9hOEcyUVpUMDBrQjhoS1VhN05BU25UT3M4ZEhvY3Y5Q3VNN0ZX?=
 =?utf-8?B?aG1hUU1Wd0NoSmRuRVhLYmVzaXlxSGxCMW94MFl5d1FIWFJOQU55RVBGNUZv?=
 =?utf-8?B?NzZGcklIVjVTb0MyUUp2WTI1NnJSYkNZU2hWekFscnlNUjlSY2hoUTBwQnFZ?=
 =?utf-8?B?UlEvcnFtVm40OGZYcGJ1Mnd2dFZpZmtvQ3EwdWZObjRWclIvNWtkRUZ6V2Na?=
 =?utf-8?B?OGlOL0E0UDR4N3dNMFdnRTZuaGlOaktUektCQ0F4S1RSR2ZXUjdpeHEybE1l?=
 =?utf-8?B?VEpUWDdGWmNKSFg0QjdXNTNxSFpuK1duRytQTFJqQkpNSTc2d1MyejJWeS96?=
 =?utf-8?B?bW9oR1ZSQU45N3VjM1V1akpjM2g2R29JK2R5MldrNXl1dUduK0YrbTZlenF0?=
 =?utf-8?B?bHRDbE5qMTcvQ1l4QUJPMHM3bC9EZnV6SFlrdk9zQ3F0TXlNKzJUVm5INVFD?=
 =?utf-8?B?NFc3TWJ4Y2lvWFNOWGhNMXJ1WHM3NG9SV2RYS2RRSEYvRmx5RCt5MjRXY3J6?=
 =?utf-8?B?RmNlUkpZYklKNVdGTFk1emp5MFlxT3YySUNtcnRETGVWbDVaN0pua3ZhK1l6?=
 =?utf-8?B?REIzRXdnekZJMmNJWWZ4Q3RZb1o3Wm5oNUFhTWhNZVh3WFBLK1QzQ21rOG9C?=
 =?utf-8?B?akFKdWhWeEY2R2I0cEtTb2RmL0FJb0UrUmEzdGlkTEcxRU1GaVE5K3RFY3Jl?=
 =?utf-8?B?bUNUM2lDbDZMVEF2YmwxMXhvVGFydElHK3dKdUZlVTQzSnV3eUZVVXVnZitv?=
 =?utf-8?B?SmRUTmNBc0FrRW90L2Q4cHNIUGRnSXNZVlFOcmpESnZHKzU5Z1o4RnBZUnc3?=
 =?utf-8?B?Z3ViQnNBaUhnbHFRN0o3eWRZUHd5OXdiY3FmbjVQN2JMNFJHZU5yenN0TVZy?=
 =?utf-8?B?NkJ0ekNUdEtPZHZWYmlscWppVk8vc1BtV1NwVHBQYlpsTTZoaERsajFxK0Uv?=
 =?utf-8?B?UnM5QjZBbHFiZHZHejgza2tISG4yamM5Z1hBSnF0czBrRjFNUGpCYms0VHMx?=
 =?utf-8?B?NnlLL09hNWU0bnU1RzVJcjBhZkppQi95UjgwWnFXZzBSSWlJT09zaWdOYUtz?=
 =?utf-8?B?a2FVNXdJM2RyRDgwaHIvQTFjQ0dFNlUzaUlEVjZTL2NIaDVxRlh0S3ovMFFa?=
 =?utf-8?B?VWw4bFBaeXo4bWFyTFd0K0RRTEE3TTZObkswY3FDRWRMb1R6Ump4TXRZSHR2?=
 =?utf-8?B?T2xpMHpBZ01hSHpmanVkWGc4bDgwUTNLc1gvbVA0OEsvOXRLTnpMeDNzdVFq?=
 =?utf-8?B?TkZTTnU4Rk5sb1lMeXd3eklrMkZkVDYwa3I2bjhneUdvaFJNTThjSEJNV3R3?=
 =?utf-8?B?ZzNZZnptMzdJbElYRDArZkpzc0xDVEZ5aWc1Yk4zQWR6UTVIUHlrKy9zU1N2?=
 =?utf-8?B?eGYvblpiNGVDZ3JUSDhpVjk2Z2VKRzlDSHB6U3JKWVVEM0FPbFhuRTZUeXlT?=
 =?utf-8?Q?EPLA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a719a3b3-35d5-47dd-ace2-08da59ce5083
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 12:53:07.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlV/JQEKli44L75zfvVHaS8wMcyAF4OfBcR5/dibyNEraAcuYrxNJ9K0oNq3LZMrvF3GhdxFCu33Mk4Ob4Kw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4NCj4gU2VudDog
V2VkbmVzZGF5LCBKdW5lIDI5LCAyMDIyIDg6MTAgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmcNCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgt
DQo+IGlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IGFtcGhpb246IG9ubHkgaW5z
ZXJ0IHRoZSBmaXJzdCBzZXF1ZW5jZQ0KPiBzdGFydGNvZGUgZm9yIHZjMWwgZm9ybWF0DQo+IA0K
PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDI4LzA2LzIwMjIgMDc6MjAsIE1pbmcgUWlh
biB3cm90ZToNCj4gPiBGb3Igc29tZSBmb3JtYXRzLCB0aGUgYW1waGlvbiB2cHUgcmVxdWlyZXMg
c3RhcnRjb2RlIGJlZm9yZSBzZXF1ZW5jZQ0KPiA+IGFuZCBmcmFtZSwgc3VjaCBhcyB2YzEsIHZw
OC4NCj4gPg0KPiA+IEJ1dCBmb3IgVjRMMl9QSVhfRk1UX1ZDMV9BTk5FWF9MLCBvbmx5IHRoZSBm
aXJzdCBzZXF1ZW5jZSBzdGFydGNvZGUgaXMNCj4gPiBuZWVkZWQsIHRoZSBleHRyYSBzdGFydGNv
ZGUgd2lsbCBjYXVzZSBkZWNvZGluZyBlcnJvci4NCj4gPiBTbyBhZnRlciBzZWVrLCB3ZSBkb24n
dCBuZWVkIHRvIGluc2VydCB0aGUgc2VxdWVuY2Ugc3RhcnRjb2RlLg0KPiA+DQo+ID4gSW4gb3Ro
ZXIgd29yZHMsIGZvciBWNEwyX1BJWF9GTVRfVkMxX0FOTkVYX0wsIHRoZSB2cHUgZG9lc24ndA0K
PiBzdXBwb3J0DQo+ID4gZHluYW1pYyByZXNvbHV0aW9uIGNoYW5nZS4NCj4gDQo+IFNob3VsZG4n
dCBWNEwyX0ZNVF9GTEFHX0RZTl9SRVNPTFVUSU9OIGJlIHJlbW92ZWQgZnJvbSB0aGF0IGZvcm1h
dA0KPiBzaW5jZSBpdCBkb2Vzbid0IHN1cHBvcnQgdGhpcyBmZWF0dXJlPw0KPiANCj4gUmVnYXJk
cywNCj4gDQo+ICAgICAgICAgSGFucw0KPiANCg0KSSBoYXZlIGEgcXVlc3Rpb24sIGZvciBmb3Jt
YXQgVkMxTCwgIHRoZSBWNEwyX0VWRU5UX1NPVVJDRV9DSEFOR0UgZXZlbnQgc3RpbGwgbWF5IGJl
IHNlbnQgYXQgdGhlIGJlZ2lubmluZywNCklmIHRoZSBwYXJhbWV0ZXJzIHBhcnNlZCBmcm9tIHRo
ZSBmaXJzdCBzZXF1ZW5jZSBoZWFkZXIgYXJlIGRpZmZlcmVudCBmcm9tIHRob3NlIHByZXZpb3Vz
bHkgZXN0YWJsaXNoZWQuDQoNClNvIHNob3VsZCBJIHJlbW92ZSB0aGUgVjRMMl9GTVRfRkxBR19E
WU5fUkVTT0xVVElPTiBmbGFnIG9yIG5vdD8NCg0KTWluZw0KDQo+ID4NCj4gPiBGaXhlczogMTQ1
ZTkzNjM4MGVkYiAoIm1lZGlhOiBhbXBoaW9uOiBpbXBsZW1lbnQgbWFsb25lIGRlY29kZXIgcnBj
DQo+ID4gaW50ZXJmYWNlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlh
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24v
dmRlYy5jICAgICAgIHwgMSArDQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHUuaCAgICAgICAgfCAxICsNCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dV9tYWxvbmUuYyB8IDIgKysNCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dV9ycGMuaCAgICB8IDcgKysrKysrLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdmRlYy5jDQo+ID4gaW5kZXggMDlkNGYyNzk3MGVjLi41MTIxOGE0MWE1YWMgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMNCj4gPiBAQCAtNzMxLDYg
KzczMSw3IEBAIHN0YXRpYyB2b2lkIHZkZWNfc3RvcF9kb25lKHN0cnVjdCB2cHVfaW5zdCAqaW5z
dCkNCj4gPiAgICAgICB2ZGVjLT5lb3NfcmVjZWl2ZWQgPSAwOw0KPiA+ICAgICAgIHZkZWMtPmlz
X3NvdXJjZV9jaGFuZ2VkID0gZmFsc2U7DQo+ID4gICAgICAgdmRlYy0+c291cmNlX2NoYW5nZSA9
IDA7DQo+ID4gKyAgICAgaW5zdC0+dG90YWxfaW5wdXRfY291bnQgPSAwOw0KPiA+ICAgICAgIHZw
dV9pbnN0X3VubG9jayhpbnN0KTsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHUuaA0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+ID4gaW5kZXggZTU2Yjk2YTdlNWQzLi5mOTE0ZGU2ZWQ4MWUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+
ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+ID4gQEAgLTI1
OCw2ICsyNTgsNyBAQCBzdHJ1Y3QgdnB1X2luc3Qgew0KPiA+ICAgICAgIHN0cnVjdCB2cHVfZm9y
bWF0IGNhcF9mb3JtYXQ7DQo+ID4gICAgICAgdTMyIG1pbl9idWZmZXJfY2FwOw0KPiA+ICAgICAg
IHUzMiBtaW5fYnVmZmVyX291dDsNCj4gPiArICAgICB1MzIgdG90YWxfaW5wdXRfY291bnQ7DQo+
ID4NCj4gPiAgICAgICBzdHJ1Y3QgdjRsMl9yZWN0IGNyb3A7DQo+ID4gICAgICAgdTMyIGNvbG9y
c3BhY2U7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHVfbWFsb25lLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFs
b25lLmMNCj4gPiBpbmRleCBjNjJiNDllODUwNjAuLmY0YTQ4OGJmOTg4MCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPiA+IEBAIC0x
MzE0LDYgKzEzMTQsOCBAQCBzdGF0aWMgaW50DQo+IHZwdV9tYWxvbmVfaW5zZXJ0X3Njb2RlX3Zj
MV9sX3NlcShzdHJ1Y3QgbWFsb25lX3Njb2RlX3QgKnNjb2RlKQ0KPiA+ICAgICAgIGludCBzaXpl
ID0gMDsNCj4gPiAgICAgICB1OCByY3Zfc2VxaGRyW01BTE9ORV9WQzFfUkNWX1NFUV9IRUFERVJf
TEVOXTsNCj4gPg0KPiA+ICsgICAgIGlmIChzY29kZS0+aW5zdC0+dG90YWxfaW5wdXRfY291bnQp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICBzY29kZS0+bmVlZF9kYXRh
ID0gMDsNCj4gPg0KPiA+ICAgICAgIHJldCA9IHZwdV9tYWxvbmVfaW5zZXJ0X3Njb2RlX3NlcShz
Y29kZSwNCj4gPiBNQUxPTkVfQ09ERUNfSURfVkMxX1NJTVBMRSwgc2l6ZW9mKHJjdl9zZXFoZHIp
KTsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9y
cGMuaA0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuaA0KPiA+
IGluZGV4IDI1MTE5ZTVlODA3ZS4uN2ViNmYwMWU2YWI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4gPiArKysgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5oDQo+ID4gQEAgLTMxMiwxMSArMzEyLDE2IEBA
IHN0YXRpYyBpbmxpbmUgaW50IHZwdV9pZmFjZV9pbnB1dF9mcmFtZShzdHJ1Y3QNCj4gdnB1X2lu
c3QgKmluc3QsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgdmIyX2J1ZmZlciAqdmIpICB7DQo+ID4gICAgICAgc3RydWN0IHZwdV9pZmFjZV9vcHMgKm9w
cyA9IHZwdV9jb3JlX2dldF9pZmFjZShpbnN0LT5jb3JlKTsNCj4gPiArICAgICBpbnQgcmV0Ow0K
PiA+DQo+ID4gICAgICAgaWYgKCFvcHMgfHwgIW9wcy0+aW5wdXRfZnJhbWUpDQo+ID4gICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IC0gICAgIHJldHVybiBvcHMtPmlucHV0
X2ZyYW1lKGluc3QtPmNvcmUtPmlmYWNlLCBpbnN0LCB2Yik7DQo+ID4gKyAgICAgcmV0ID0gb3Bz
LT5pbnB1dF9mcmFtZShpbnN0LT5jb3JlLT5pZmFjZSwgaW5zdCwgdmIpOw0KPiA+ICsgICAgIGlm
IChyZXQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICBpbnN0
LT50b3RhbF9pbnB1dF9jb3VudCsrOw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4g
Pg0KPiA+ICBzdGF0aWMgaW5saW5lIGludCB2cHVfaWZhY2VfY29uZmlnX21lbW9yeV9yZXNvdXJj
ZShzdHJ1Y3QgdnB1X2luc3QgKmluc3QsDQoNCg==
