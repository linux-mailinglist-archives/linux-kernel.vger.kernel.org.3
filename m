Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFE577E76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiGRJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiGRJOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:14:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B21F586;
        Mon, 18 Jul 2022 02:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSIRdoBiXKsCsjsgMTSAQgROBoWzqtTd4pKlLRO1XvNu1hfoX/Cu41kRmm6rxoOMNa/SdpX78zMtXINZNbA4lZ1JddP8oNfg/AsobCwuTGuhSF11z2CxkLpW/vBOmA/rQzTrTLufyiKiw9mpzPHRqYX6RNitf/TMTUll9wF3ch6q/CSw1z5LV8yrGvqsY1vj1dldxZ6WtG2MwjU2+2GcXBaQi92vHf1Y2PRR6zxWZ6Qdl6TDRubstzX1K9xKVUEqH8wVC1HHiNfvix12EyNQqqKbkqm56RNTchEzJr880XOX0Vki+PrTAHOkUQQEh95HT/WxO0jQhFtFa5ViK1qUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBbB/JF8FLBQJ0FRRqWBWCbA/yNfT16mqbL1lG2Dffw=;
 b=JF2yoyjtPc00Sakx0ZFwF0XfOuEUIVNFSxQlNNM8Xn5Kwh8euLlPg+P4ieJ1WIZywTHshr6wH/F4HWQt+tPXWtkK7YFSiRzP873EdJPSmIvQ9l3+6SBPbMEIee4R5PeVguN1MaqDL95wr3X3WMDPizL0GocFcEolEPipmpdnsc9cOzXyK92/fSvMypl8phdoeCFle+U1vYwVuZAgznaqFQN3XKDsKQMtcGxGA5jFqGY60PoWD86CbP4n6va9i/pUIpWBJKSg4pF3mYiEx4/FOZEq8MQ9n4S6s+xtXg3JWWT/a/aaCfy9eo8TuAjuKHsM1EoRvTGqwBGNENSs59to1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBbB/JF8FLBQJ0FRRqWBWCbA/yNfT16mqbL1lG2Dffw=;
 b=oZ1aj2qM8zib+raffGmWEbSmz9CXpJpQqGIYu1vo0UeJWl4Pnd4WrupPwLtBkD/cE9nAC/6tDHQvOsvkaoWiyeB//ls3yloEDVKJyn2DmCEoF9PHDjZEroLlzOXzIyPyYketuFn0v7Iy2b3mit0jLfy0J6gEnUGFnPNG5Tr6B8sA+Dl2CKVY33WbllkI9r0mNWZEKPSV6qqqUkcOMt0s62Y2nY5kxfA76mxX1yOiggxGPbBtg6h0Rcwpxyq8OGTUEY4nQzbEAAvhwmo8YCPlMwOrdrVeZcv3weuNQbtKcLO3XhVlacQRYyEHLxX5zRfNX7+WI+LfE8fhycPjLViUaA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SEZPR06MB5573.apcprd06.prod.outlook.com (2603:1096:101:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 09:14:28 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::25c5:8c5a:3c63:8aa8]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::25c5:8c5a:3c63:8aa8%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 09:14:28 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYkBRQiwIxkNvUdUWZRYIhxCRKx61707WAgAfdoxCAADnq8A==
Date:   Mon, 18 Jul 2022 09:14:28 +0000
Message-ID: <HK0PR06MB32024393BC4D8B2D677056D0808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-2-neal_liu@aspeedtech.com>
 <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
 <HK0PR06MB32027F003F07000E9F97A166808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB32027F003F07000E9F97A166808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 900857fd-282d-4041-0d83-08da689deabf
x-ms-traffictypediagnostic: SEZPR06MB5573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQBF23xxBEK8QXV+WtDX75f9gO7Ka/tz6VHmz4FLB9O/eRLb/Ebiv7vpIb0L2GI2EfpNB9zugJy1H8V+ZXZei9ZyuvzjDU/UZhF3e2KZcETU7pKhN7qzmlBeFIQOhTnJxuTilDd6U0IkRucSCw41lYbq6Da+dVIppEXzXqNJ+CQXJZUUL9cNTNmYbGPiIYMuYDpFb92kY0acGxIH8pebi3kf9/12GtJvSAHUOyWLaxyP+pcad0SCNfbIfA3EF1Cfy+Al0qr1l4xyryusMHqwbaZpaRWcth4J9BwsXU8DPQ6m/C64rFNa1hkXb4oaP50xwQHiX1u2aBFhKcKOTtXmfRZVW5eiXiODuISFiJWYG0yBtyL3O5krx06JdnCUtYZnJzhNrlWo/C2BiCv/TxUqLg4iUQ7WS1C0t/2yPnZPjHxjDdKEyxG2kn3Tmx0kjEyz2/wwrON5NkPHeOUrGIa/mF4itOU8MP9Z2tYSQWmfT3Qv0VZeHmZHgqMDNbl41RBFRXMHD8bBLgOV22FZ74hxnTKGqi1vMtl276hJ6LcdDtju95Eu9K435gX2j3k8ZljKyK+Jpo7fiOZn5WYjZ3Rewar5/G/uHz3hX6WJv7uBnOQvNq/sKWLM1PW1vd7XbDll9xKA8Lot6kYpzjA8Wx1zUKqGtr/LRd+zKl9R3T89q/qHXNOWgvaUdK3j+0r+vYAki3mDaFqBQHa2sf2pHc9eL+NAZS0DFHxoRK0XyVy1/EOfUOTQF9ux1LGhijbWIBNcQdgIPTPfJMtjz8wqp/ZVFSQVNXwvnirFYmW2L8Eeqgyn65wrlWoyfrdXYUPZhzcmHUNDSt4wW1u4FGnrjQ4vXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39850400004)(366004)(396003)(33656002)(8936002)(38100700002)(52536014)(66446008)(4326008)(8676002)(66556008)(64756008)(66946007)(66476007)(76116006)(110136005)(38070700005)(6636002)(921005)(54906003)(53546011)(7696005)(6506007)(316002)(26005)(83380400001)(55016003)(41300700001)(107886003)(186003)(2940100002)(9686003)(122000001)(71200400001)(5660300002)(7416002)(86362001)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NXU1JSY01OUXNYT0dqUDB4N2Q3MWhTUjk0Zm5Xa1dQcVUycDNDeXF3Uytl?=
 =?utf-8?B?UjNFd2U4NjJSR0JRbGw4SHZQc3hwZHNqVSthY1A3L2JUWVNranZURHM0c2Rn?=
 =?utf-8?B?dGdEazVGUVJSa1dwSVUyRG1sWis2a3dTWVFTaGhweWdrUlk1UmtnektVRHhH?=
 =?utf-8?B?L1ppVGJ4b2kwVk9WYmtrTnFORm1JNlhvQWhtR2wxa0hkL3R5eTBVbkUyMmNp?=
 =?utf-8?B?Y3VrSVk0dzlWQitKYXlBa1NSaGdtckN0Z3BFYVloZE14Zlk0TWVTSWh5NEtj?=
 =?utf-8?B?cUY2K0tiV01WUmQ3QlpZQm90RXdjWnhnTEx3ZWlxV0VSczV0eVA2WlBucWgx?=
 =?utf-8?B?TzBqd1Y1QmpVRHgzWXJNbWdML0J1WkFwQ0xBRWhuOURLMXJOVmFsSjlmckQy?=
 =?utf-8?B?RDFBbGNKMXlxdlFyMnBodTNmODlOVGJsWk9lb3M1Wm5mNWpZVEZtalVpUk96?=
 =?utf-8?B?QzQwMzJtWEUyRFAzUDNHUS83d0p2cU5sdGlRNkZWdHBNek5rUTIyaVhkRkNS?=
 =?utf-8?B?U3VoUXpubXIyenVKdUNtS0Z0MWJkZDhoT1VRTmg0TEYxeDNkYUhyMVFIRWk4?=
 =?utf-8?B?ZXNGWWk2cHROQ2FXNXhIZUFsZHV5N0pOeDlnNjFlM1FPOUhScFRsSUpFdjdZ?=
 =?utf-8?B?TU4zSjZBRVZDUzNiUHEyWWlkekNsTk55U0pWZGkyRjFQZ3R5aGVpcFN2cjdr?=
 =?utf-8?B?ZFl0UTZpM2FRVngzQnVwRW05RlM2L04wdHpVTlJ1YWNnSTFreGdhaGxqNXd1?=
 =?utf-8?B?WVRHMzZrRlROMXlUZDJ0S3VpblRRTHQ5MFV6YXUwVS82RUQyNWNMejJoRkxH?=
 =?utf-8?B?NmNoSFdjZUVFRDh5STl0TVlJTTlwYWwxbVR5aVBDekZvUXlmT291RDZFZEdV?=
 =?utf-8?B?b1NpZVFtWXl6cGtIakxMNlo4d3VIZWY2SG1hSVE0T2lRTmIyR1NpMFR4ZEV5?=
 =?utf-8?B?THZLL0VzVlpCK2tkaWZwdkc0enRPb0RQRnlhaWFlNVRLWFV6VHVSQ2VZUDFD?=
 =?utf-8?B?N0xPYnUxdjFDYWw0NnV0dmFROTVNViszb241d0pQdTVJTktrNk1sSjhub1pu?=
 =?utf-8?B?N0lJN24zV0RtbGVGa0lseVorN0JlTTBSVXp6blBmUkxqRUo4SXRlWitqRW5N?=
 =?utf-8?B?SEVvT0N6QXN3cHMyc2g5OVl6WVQvYnlOOVFxMmhNeTdESXNWdytqOVRxRzlX?=
 =?utf-8?B?d0dhS0FPUk1JaFNrd3FPYUsyd1JoWnB2b2NOTEpmdzJyM0loYnJabXJQZ2FX?=
 =?utf-8?B?dHZTRi9JZnk0b1dQTGEyaTJVU3o5NHVnN2M4QUhMd3BqMnh2SU9CbUJGUFJk?=
 =?utf-8?B?OVVCK2l2SklMVVJKaUh3T09uTGxVdThPMHFpREFBWTRuSG80M2N3SWhEZjBm?=
 =?utf-8?B?cDZ4ZS94c2ozRUtFSmtVaUUrWXhzRXhxTmZzUjNRSms3OUFQRjFlUW00cEdj?=
 =?utf-8?B?aGE0SGE3TTZsODF5dEhwQlo1NVZQcjFxN1B6OS9lNzgwcDRXV0ExUE5hKzZ5?=
 =?utf-8?B?QmpRalpzMmthWFBhenBHWWVqQ3R1cFNGWXpGRjluajFEbC93QlZrdXAxYW0r?=
 =?utf-8?B?bG1IODByYlZmQklvVHpTc2FnWDRoVVJwaTdPWkdXVEk0aWh4VGNSeEFocks4?=
 =?utf-8?B?VXVyUS9jazdhakRkOWhBYXc0RTlkNGJtTlA0TkNYU1Bqb3pYV0lSeXZhSkIz?=
 =?utf-8?B?Zmdza1JYbjRzSXJoMkZGd1lFa1VTemZ3ZURsUjhXQjg2ZjNvdVYrLy9HQzVD?=
 =?utf-8?B?akVZUmdXU2R1ZHc0TTBoejVXQS83STR4ZHN3aW9ybTN5V1RtQStmN212S3Qr?=
 =?utf-8?B?WXJlckYrTEpEaXdkcTFCMWNod2ttTmZ5NWRDaUF0ZlFlMVAxL0RBOWxWRGJp?=
 =?utf-8?B?N00xeTd3TTV3OHJFL1JmMFpBWEt4MHlwYjVaVFB4cnVXc2FDRGVBL282b3kz?=
 =?utf-8?B?QkN2UTZPNXpPWnJ6bVRIZHFtZ2JPYXpteHpBMUtQcWRNR3NHT09HbFJjeFdy?=
 =?utf-8?B?RHc2SWZqVjFDaFR3SXVQTWdxQWc2OHhsWEtidWtlSndNd0d4MndUdnYyMDd3?=
 =?utf-8?B?S0lVUW5oUnVrRHdFYktoNCsvZHIyKzZJNHpmQjNHbWVmaU9YMTUvQ3lvVVo4?=
 =?utf-8?Q?O7aKVEi+hCGsY5AyU5heveFeQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900857fd-282d-4041-0d83-08da689deabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 09:14:28.3265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lp0Y/gtw/p3OHT6m/7yZRnZEW2z9XeptVz5sT5ly+mQqEQfIdpgcIIh7UGFY2JFbq/hHpbjPnq7an0N3JC93zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGhhbmFuamF5IFBoYWRr
ZSA8ZHBoYWRrZUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAxMywgMjAyMiAxOjMyIFBNDQo+ID4gVG86IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNo
LmNvbT47IENvcmVudGluIExhYmJlDQo+ID4gPGNsYWJiZS5tb250am9pZUBnbWFpbC5jb20+OyBD
aHJpc3RvcGhlIEpBSUxMRVQNCj4gPiA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBS
YW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47DQo+ID4gSGVyYmVydCBYdSA8aGVy
YmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA+IDxkYXZlbUBk
YXZlbWxvZnQubmV0PjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRv
Zg0KPiA+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgSm9l
bCBTdGFubGV5DQo+ID4gPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bh
ai5pZC5hdT47IERoYW5hbmpheSBQaGFka2UNCj4gPiA8ZGhwaGFka2VAbWljcm9zb2Z0LmNvbT47
IEpvaG5ueSBIdWFuZw0KPiA8am9obm55X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+IENjOiBs
aW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJNQy1T
VyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMS81
XSBjcnlwdG86IGFzcGVlZDogQWRkIEhBQ0UgaGFzaCBkcml2ZXINCj4gPg0KPiBbLi4uXQ0KPiAN
Cj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFtX2NyYV9pbml0X2FsZyhzdHJ1Y3QgY3J5cHRv
X3RmbSAqdGZtLA0KPiA+ID4gKwkJCQkgICAgY29uc3QgY2hhciAqYWxnX2Jhc2UpDQo+ID4gPiAr
ew0KPiA+ID4gKwlzdHJ1Y3QgYWhhc2hfYWxnICphbGcgPSBfX2NyeXB0b19haGFzaF9hbGcodGZt
LT5fX2NydF9hbGcpOw0KPiA+ID4gKwlzdHJ1Y3QgYXNwZWVkX3NoYW1fY3R4ICp0Y3R4ID0gY3J5
cHRvX3RmbV9jdHgodGZtKTsNCj4gPiA+ICsJc3RydWN0IGFzcGVlZF9oYWNlX2RldiAqaGFjZV9k
ZXYgPSB0Y3R4LT5oYWNlX2RldjsNCj4gPiA+ICsJc3RydWN0IGFzcGVlZF9oYWNlX2FsZyAqYXN0
X2FsZzsNCj4gPiA+ICsNCj4gPiA+ICsJYXN0X2FsZyA9IGNvbnRhaW5lcl9vZihhbGcsIHN0cnVj
dCBhc3BlZWRfaGFjZV9hbGcsIGFsZy5haGFzaCk7DQo+ID4gPiArCXRjdHgtPmhhY2VfZGV2ID0g
YXN0X2FsZy0+aGFjZV9kZXY7DQo+ID4gPiArCXRjdHgtPmZsYWdzID0gMDsNCj4gPiA+ICsNCj4g
PiA+ICsJY3J5cHRvX2FoYXNoX3NldF9yZXFzaXplKF9fY3J5cHRvX2FoYXNoX2Nhc3QodGZtKSwN
Cj4gPiA+ICsJCQkJIHNpemVvZihzdHJ1Y3QgYXNwZWVkX3NoYW1fcmVxY3R4KSk7DQo+ID4gPiAr
DQo+ID4gPiArCWlmIChhbGdfYmFzZSkgew0KPiA+ID4gKwkJc3RydWN0IGFzcGVlZF9zaGFfaG1h
Y19jdHggKmJjdHggPSB0Y3R4LT5iYXNlOw0KPiA+ID4gKw0KPiA+ID4gKwkJdGN0eC0+ZmxhZ3Mg
fD0gU0hBX0ZMQUdTX0hNQUM7DQo+ID4gPiArCQliY3R4LT5zaGFzaCA9IGNyeXB0b19hbGxvY19z
aGFzaChhbGdfYmFzZSwgMCwNCj4gPiA+ICsJCQkJCQkgQ1JZUFRPX0FMR19ORUVEX0ZBTExCQUNL
KTsNCj4gPiA+ICsJCWlmIChJU19FUlIoYmN0eC0+c2hhc2gpKSB7DQo+ID4gPiArCQkJZGV2X3dh
cm4oaGFjZV9kZXYtPmRldiwNCj4gPiA+ICsJCQkJICJiYXNlIGRyaXZlciAnJXMnIGNvdWxkIG5v
dCBiZSBsb2FkZWQuXG4iLA0KPiA+ID4gKwkJCQkgYWxnX2Jhc2UpOw0KPiA+ID4gKwkJCXJldHVy
biBQVFJfRVJSKGJjdHgtPnNoYXNoKTsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJfQ0KPiA+ID4gKw0K
PiA+ID4gKwl0Y3R4LT5lbmdpbmVjdHgub3AuZG9fb25lX3JlcXVlc3QgPSBhc3BlZWRfYWhhc2hf
ZG9fcmVxdWVzdDsNCj4gPiA+ICsJdGN0eC0+ZW5naW5lY3R4Lm9wLnByZXBhcmVfcmVxdWVzdCA9
DQo+IGFzcGVlZF9haGFzaF9wcmVwYXJlX3JlcXVlc3Q7DQo+ID4gPiArCXRjdHgtPmVuZ2luZWN0
eC5vcC51bnByZXBhcmVfcmVxdWVzdCA9IE5VTEw7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAw
Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFtX2NyYV9p
bml0KHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0pIHsNCj4gPiA+ICsJcmV0dXJuIGFzcGVlZF9zaGFt
X2NyYV9pbml0X2FsZyh0Zm0sIE5VTEwpOyB9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBh
c3BlZWRfc2hhbV9jcmFfc2hhMV9pbml0KHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0pIHsNCj4gPiA+
ICsJcmV0dXJuIGFzcGVlZF9zaGFtX2NyYV9pbml0X2FsZyh0Zm0sICJzaGExIik7IH0NCj4gPiA+
ICsNCj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFtX2NyYV9zaGEyMjRfaW5pdChzdHJ1Y3Qg
Y3J5cHRvX3RmbSAqdGZtKSB7DQo+ID4gPiArCXJldHVybiBhc3BlZWRfc2hhbV9jcmFfaW5pdF9h
bGcodGZtLCAic2hhMjI0Iik7IH0NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9z
aGFtX2NyYV9zaGEyNTZfaW5pdChzdHJ1Y3QgY3J5cHRvX3RmbSAqdGZtKSB7DQo+ID4gPiArCXJl
dHVybiBhc3BlZWRfc2hhbV9jcmFfaW5pdF9hbGcodGZtLCAic2hhMjU2Iik7IH0NCj4gPiA+ICsN
Cj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFtX2NyYV9zaGEzODRfaW5pdChzdHJ1Y3QgY3J5
cHRvX3RmbSAqdGZtKSB7DQo+ID4gPiArCXJldHVybiBhc3BlZWRfc2hhbV9jcmFfaW5pdF9hbGco
dGZtLCAic2hhMzg0Iik7IH0NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFt
X2NyYV9zaGE1MTJfaW5pdChzdHJ1Y3QgY3J5cHRvX3RmbSAqdGZtKSB7DQo+ID4gPiArCXJldHVy
biBhc3BlZWRfc2hhbV9jcmFfaW5pdF9hbGcodGZtLCAic2hhNTEyIik7IH0NCj4gPiA+ICsNCj4g
PiA+ICtzdGF0aWMgaW50IGFzcGVlZF9zaGFtX2NyYV9zaGE1MTJfMjI0X2luaXQoc3RydWN0IGNy
eXB0b190Zm0gKnRmbSkNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiBhc3BlZWRfc2hhbV9jcmFf
aW5pdF9hbGcodGZtLCAic2hhNTEyXzIyNCIpOyB9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGlu
dCBhc3BlZWRfc2hhbV9jcmFfc2hhNTEyXzI1Nl9pbml0KHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0p
DQo+ID4gPiArew0KPiA+ID4gKwlyZXR1cm4gYXNwZWVkX3NoYW1fY3JhX2luaXRfYWxnKHRmbSwg
InNoYTUxMl8yNTYiKTsgfQ0KPiA+DQo+ID4gTG9va3MgbGlrZSBtb3N0IG9mIHRoZXNlIGNyYV9p
bml0IGNhbGxiYWNrIGZ1bmN0aW9ucyBhcmUgdHJ5aW5nIHRvDQo+ID4gZGlzdGluZ3Vpc2ggaG1h
YyBmcm9tIHNoYSBhbGdzIGJ5IHBhc3NpbmcgImFsZ19iYXNlIiBhcmcuIENhbiBjb2xsYXBzZQ0K
PiA+IHRoZSBsb2dpYyBpbiBhc3BlZWRfc2hhbV9jcmFfaW5pdF9hbGcoKSBpdHNlbGYgYW5kIHN0
b3JpbmcgYWxnX2Jhc2UgaW4NCj4gPiBpbnN0YW5jZXMgb2YgYXNwZWVkX2hhY2VfYWxnLg0KPiA+
DQo+ID4gCWlmIChhc3RfYWxnLT5haGFzaC5zZXRrZXkoKSkgew0KPiA+IAkJLyogaG1hYyByZWxh
dGVkIGxvZ2ljICovDQo+ID4gCQliY3R4LT5zaGFzaCA9IGNyeXB0b19hbGxvY19zaGFzaChhc3Rf
YWxnLT5hbGdfYmFzZSwgMCwNCj4gPiAJCQlDUllQVE9fQUxHX05FRURfRkFMTEJBQ0spOw0KPiA+
IAkJLi4uDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiEgSXQgd2lsbCBzaW1wbGlm
eSB0aGVzZSBjcmFfaW5pdCgpIGZ1bmN0aW9ucy4NCj4gSSdsbCByZXZpc2UgaXQgZm9yIG5leHQg
cGF0Y2guDQoNClNvcnJ5LCBJIHdhcyBtaXN1bmRlcnN0YW5kaW5nLiBUaGUgcmVhc29uIGJ5IHBh
c3NpbmcgImFsZ19iYXNlIiBpcyBiZWNhdXNlIEhNQUMga2V5IGlzIGRlZmluZWQgYXMgdGhlIGZv
bGxvd2luZyBzdGF0ZW1lbnQuDQotPiBLJyBpcyBhIGJsb2NrLXNpemVkIGtleSBkZXJpdmVkIGZy
b20gdGhlIHNlY3JldCBrZXksIEs7IGVpdGhlciBieSBwYWRkaW5nIHRvIHRoZSByaWdodCB3aXRo
IDBzIHVwIHRvIHRoZSBibG9jayBzaXplLCBvciBieSBoYXNoaW5nIGRvd24gdG8gbGVzcyB0aGFu
IG9yIGVxdWFsIHRvIHRoZSBibG9jayBzaXplIGZpcnN0IGFuZCB0aGVuIHBhZGRpbmcgdG8gdGhl
IHJpZ2h0IHdpdGggemVyb3MNCg0KU28gYmFzaWNhbGx5LCBhbGxvY2F0ZSBhIGdlbmVyaWMgc2hh
c2ggYWxnbyB0byBkbyBoYXNoIG9uZSB0aW1lIGlmIGlucHV0IGtleSBzaXplIGlzIGxhcmdlciB0
aGFuIHRoZSBibG9jayBzaXplLg0KSGVyZSB3ZSBwcmVmZXIgdG8gdXNlIHRoZSBnZW5lcmljIG5h
bWUgaW5zdGVhZCBvZiBBc3BlZWQgcmVnaXN0ZXJlZCBhbGdvIHNpbmNlIGlucHV0IGtleSBzaXpl
IGlzIHVzdWFsbHkgc21hbGwuDQpUaGFua3MNCg0KLU5lYWwNCg==
