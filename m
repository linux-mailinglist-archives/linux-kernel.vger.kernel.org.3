Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE054BD2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiBUAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiBUAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:47:54 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4B5FF5;
        Sun, 20 Feb 2022 16:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGR/TnN9jBem+otH9InPaS/rLXIdH6wsnhbd9oXOIPTnmuQPY4kjLzxR4nyl/U9LmcWiPqS/b4p58sjD+aqvSvaPOwzEp7zNHSJurP/8ahOGwO4GRqN+uBaoN1MM7kilXAVMyeCm+fRnpPldNCcUugX1/qY2b5djvOA8JPYfGgKJCZTtnelreFzGMw+6gA9Th3+o7sk3IsKGSAdtOdj6SZ49AXVKaBxaeCiViYf8vpWr2qmRLetknhJQmjvEbEA/4PU3ZyKemg/2KocKMzLPRKVbctr05UYgdg1cmZiocKK93EO8Vp/F/Rj9EK3ybvX6uW80G+JSMgpaigjQtMQJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVlMQLYAqBh70H9l25ZyR/p5nQdTDuj4NAClUKxxmpk=;
 b=nUcbxbueCZilLfXDXoS+xKDkgtlTsnVaSBIv71AzGLlfnwdQBwS4bWkxn8CdoBockffOMWJKcncrYPohh7bzheOGCNgczdpnIzUzF9xffpCiglo9fU/W7aQWrKgChgmwZ68Qkmm58oyAmyUA1QY93MruWjDPLBqLXHKrQX0UdsdnGgmPGCmlwCquY/kM41WmMU7yisuAzjWOoDg3Yni/qLLxMTrq+KcwnXg7ux0cz5J7h/gpLhjb+ju10gE5we8tXJCWNcL4HX0AAC0Xm8mfR1hrYhNMZPG/hIn3l9lFuojSgFFJGjkl5JA4qTTqwFoHkE5BYb+SKcrPdvZTGIsAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVlMQLYAqBh70H9l25ZyR/p5nQdTDuj4NAClUKxxmpk=;
 b=Y8wdsNShOuLuU9EyHSgO4FhZHJ3bJRXRjUWzp7/ItKSNPTcSGxeIMWiQ7sZBfhwQvRdhxNLlkfdpuHFbLqjnIPVemw7RbH9EScCd3w+zpOVJoyPksRFC0NfNrGsuB7F8XE9TF8hL77Tn0f+ImnTRIlyrbP0p2uj+eo4Dky8UkdIfbBuAj9WGrxGnmpRIWi+4sWAwf7VHHB9A8VBlZ7reMo+jQpdJgrr5U8skuZFCw+20FJx1qskxc5NPOmKwbwZBKGgxLwZGzVyRM4ie0vcJMBvNEOHK4qsaLJTMLtEzT7UVLtIy0WWlUTLVDhV5QUcOVmCA8hilr/PrFsoyhQlc9Q==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by TY2PR06MB2782.apcprd06.prod.outlook.com (2603:1096:404:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 00:47:15 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9576:433c:3460:2e8a]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9576:433c:3460:2e8a%6]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 00:47:15 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: Re: [PATCH] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
Thread-Topic: [PATCH] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
Thread-Index: AQHYJKVxjDaUYL7Z3kOU/yC++HY6YqybCjYAgAKrv4A=
Date:   Mon, 21 Feb 2022 00:47:15 +0000
Message-ID: <E53FFC04-41C9-446C-8D11-7A1937D8674D@aspeedtech.com>
References: <20220218085708.8194-1-billy_tsai@aspeedtech.com>
 <20220219160002.46e301b8@jic23-huawei>
In-Reply-To: <20220219160002.46e301b8@jic23-huawei>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe7be9e-02c2-4c3a-5529-08d9f4d3b4da
x-ms-traffictypediagnostic: TY2PR06MB2782:EE_
x-microsoft-antispam-prvs: <TY2PR06MB278210694D453EF635E89D138B3A9@TY2PR06MB2782.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w57doIIlYMl8lgH1KesLe3jnhmZqtgcxAcD9AW5WtIeSVbX/aWadGVv9YlzO9irThbqFLg0GkPMsXdxEO5SOe3Z5zG+lvkQ+Mh2RilEm+bkORyubyKIGlKucmUk3OKnP7o4tNWIUYnCgLumejxdI6fghbbzjh6ZaIe03iH3GqbDroRF261PHLmD3U+5om07MnVJfSBJrYQiOmk97eFLUafs28quBqIhE4oCpTHrB8P0ActKMNgQGHehLRxbTpNAf1RmOLWFTHwa1UETf537bXV8YGQDpLqiQJwpxAoz+bDOEB8TGHcGUrcRilLOnU2f+Z6ToLHuPSbqs+e3v0zoHWPgLV5BEtEjGeFOu6HCQvgGO/4J8hs/9S+WH+Ou75fhcEG9LFPn4sEyxxeNjUB1b/2N1b18oFOBsVBM4/4AZ16V+zMwIp54KB9hC+cm3YwoTthk7pMVLpmXgMEEGWWY5ro6LOBAZNV1FbHpGswn42F7LOHk8/TuSl/yfdeIwT1MyjohqliFY7GCaK6fA61fkVyiaMayUKOPk94/trpP98hGGZKFxbe0msELK+5gi7J1hXQyfTvlIo1c9M/L+NCRozzJIJ4CYNuryn8Jnu7ZZCfM8CsVo3PMVwdcaN47+8fyYOk0Jzvvb+37ImS63QpXLZT4IN8BfEiKRF2Ey+/TKUTJ6Ttibv0T+C4c2kjVtGyVtDiRBXDSwvtmJrYrQ0007MsAzgrLsp2tja0Iw5Ya291AxxNs0WzE+RvF5r6hkf/mH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39830400003)(396003)(366004)(136003)(376002)(54906003)(6916009)(8936002)(26005)(7416002)(5660300002)(186003)(76116006)(83380400001)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(66946007)(316002)(122000001)(86362001)(508600001)(38070700005)(6486002)(6506007)(36756003)(71200400001)(2906002)(38100700002)(53546011)(6512007)(2616005)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RPL2J6VmJLUW05ZGNpeFZCMnZ4eHFEOGhEcTRyajMwMzZUKzJ0Y2VjUkZN?=
 =?utf-8?B?VjNLR2QvZFVYekpyTUo1dVlmeHZZalY4NG5YdXYyR1pUS3ovWnJ0RE9NeHR1?=
 =?utf-8?B?NVd2Rzg2VzVIUE5ZK3Z4L1B3Mit2QXNuREVsR0JlZ1Vya21xNU1mWi9tUXd6?=
 =?utf-8?B?RjhmSnROK0dNTFFZS3UxRlUxQzdaN1dqMk9NVk5YWHJxaXdQdXJFOG9waE92?=
 =?utf-8?B?NDkxSUY1SmQxWCt6V3k0c2lzb3p5amZDS0xTRW1lL0xnWEtLMlY1TDZBOHB1?=
 =?utf-8?B?Tm9WMllGeG8yM0dqNnRVQXEzV2F2VmV3YW5lMVMxRThIc0MyVzdHSTdoRHBh?=
 =?utf-8?B?ZTJlV2Z6b2FnT1V6N09teFpPbG83V2pCT01IME00T3BDV1g0ZGpmM1JFQ2Z1?=
 =?utf-8?B?M1VMWm5IbDRKK21paUErdGNUMXZXRE1TS2l5QlhrOGluMTI0K1BiaDZXQURZ?=
 =?utf-8?B?R3M3eVZXZHl6RXV5SGZ2b2dWelFpUjh0ZGU4OXhSaStHMURLWHRJTVR2Ry9j?=
 =?utf-8?B?aVUwelZBeVhrRXRVL3U4b1BCWlRkYS9jcnY2YVZQc1ZEOUFYclJFOCt5eVlD?=
 =?utf-8?B?TUxsZFFtQktnZWlsd2FhekFxMkxBMmxwOGt1SkZpaW9sdkpGMDV6MThMVmZ6?=
 =?utf-8?B?czd5WFZVbE41QjgrbnZMdEVFWTEyc2ltdmxINi9veVVWbktTNWlCOVBCRlRk?=
 =?utf-8?B?WVFobEgyOTlHb3Frb0F2YWVKTW5NNlZLQ0gwV2sxS1ljbnI3d2llT2I1MkUr?=
 =?utf-8?B?VHBGbkc1SVV1RzBrZ1J2d3NYVHpFNmliTmQ2bjE0M3RIRkd5QldCV1VNZE5L?=
 =?utf-8?B?T2dkclYweTNCcm42UlBUbFZjN2hZL244NTF5aVpxNG1GVjRyWFdtTG92Zmto?=
 =?utf-8?B?cWFFL0h6Qy9SclBTZmlmTmxWU0o1UzNhaXUzc0prMHp0amFSa2kvRzJ2NU5K?=
 =?utf-8?B?Rkc5Um9LNGZveFJMRmFQUnBWK2pqN21IWHk0OVhtTy90VTQ4M1BDNlJZdVNH?=
 =?utf-8?B?NDN6UzJDTUNMVW00VVFKUUJ6TW9oVmhmenkydDQrUkVzdnh5d2RhSHhSMDMr?=
 =?utf-8?B?RDAxbng1dW0xRlVpNnJwUDltWERMRENPY0EvVEVna0ZOeVl3VnhYd2paeXZY?=
 =?utf-8?B?Z0dBd005REI4YWpkTTJid0N2YTJtZXlkcStTclRCVFJLUEhOa3h1RW9CdUJy?=
 =?utf-8?B?L25FVnM2RENrQ1g1OW1tL0FuTm1yTk1ua2hjTDRUN3l0WHh4RGhvQjNZQWRt?=
 =?utf-8?B?UFRqaDNGTHRGdTE0ODJSbGk1Q0VMcW5xMDVSK1p1MVZ0c2NhU0VTUTBGU1pG?=
 =?utf-8?B?M1Q5cnRoRncycjlzNUJSV1AzdXo0SWNqRVRKWEU2dGx3dS8ybU5yQ29iZVk3?=
 =?utf-8?B?NFMxaVFkeGQyWFJzUkF4d213T3QwejhWWU1YN3I2UVZBcEJWa0VKZXR2bFNC?=
 =?utf-8?B?UTM3U1ZCeHpnemZYVE05V3RxNjd1Wm12amlSWEpHTlR1V281aWVTWkduNG1r?=
 =?utf-8?B?aVU3TlY4S0dSWGQvNE5vZy9XYTlHc09nbW1KWS83SUlLdE9yTFhsTnNsRFl0?=
 =?utf-8?B?OXlMNTFzUlhVbVBZaGFlUmJuejhqZkJDSklGeTJRRUJuSmZteWNibEFCbDg5?=
 =?utf-8?B?NStSS2VreVAwRmIyOFkveVpndE9sYjBTdTRLOFhBb2RpQzZGa2lHL2djTi81?=
 =?utf-8?B?MFNSclV3N1RRU2diKzZyOGVOYXUyQ0xFdU45eXBnUUVNUEZWN0dpaEQ3UnFa?=
 =?utf-8?B?cUd4TS84ZDlOTmNoU3RFRXZEQmJkWlZTejhyQXN3cWtDZVNUV0JZUXlWRHJ6?=
 =?utf-8?B?SEVhQ2tQRTVMbVZCckZWYUdLVDlUZmw0R1pSTXdFRkd1MVA4Y1ZPWjROckVS?=
 =?utf-8?B?bkNSSGg5QWR6V0lXemZQaUFBRm1qcC91bjFkK1hKVU40NVRLM0VlZzlNOHYx?=
 =?utf-8?B?dVIzVG0xSFQ4eFVkZVA5d2IvOW5ENmtTSlZlTVU4S0oxVlA1OWJmc1NqTUw3?=
 =?utf-8?B?cXFFWVdpVVBaaGwza0hHYVArWFl1S2xjUmczajFnMEVnWm8vcDV4alNWRXQ1?=
 =?utf-8?B?L21JQVhWQldhWVpneVQwdHozT3p5V25oMEgzV0ZMZVBBaVNiWHEzNjBpWkZB?=
 =?utf-8?B?cFRvZ0tnNFQ3cXJMQVdEcld4ZExTYUZ2U2xPZXl0ZUVQODd4a0ZKanBZM3Rn?=
 =?utf-8?B?M2hXL2M5eS9EK0YzRUlqUmEzUmN0cURpNW1NTWR0VWtob3ZucmVLcnVWMlVk?=
 =?utf-8?Q?7jqb8PKY5S9TP+hG4gCKFn/r+G05L5QclzOPrKLyIs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50ECE10B143EBC43A67370ABEEFD7D50@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe7be9e-02c2-4c3a-5529-08d9f4d3b4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 00:47:15.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL0p1sL7FGsIiKCNClZizrsJkDFyJxpPRa6/sazp53DJlJZodIQPkT8BjSOIwy7Ea5HtnzBACOMigbun+U0sKhuheiEcKnkJyrhpI4GZvkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2782
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIDIwMjIvMi8xOSwgMTE6NTMgUE0sICJKb25hdGhhbiBDYW1lcm9u
IiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBGcmksIDE4IEZlYiAyMDIyIDE2
OjU3OjA4ICswODAwDQogICAgQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4g
d3JvdGU6DQoNCiAgICA+ICAgPiBUaGUgZm9ybXVsYSBmb3IgdGhlIEFEQyBzYW1wbGluZyBwZXJp
b2QgaW4gYXN0MjQwMC9hc3QyNTAwIGlzOg0KICAgID4gICA+IEFEQyBjbG9jayBwZXJpb2QgPSBQ
Q0xLICogMiAqIChBREMwQ1szMToxN10gKyAxKSAqIChBREMwQ1s5OjBdKQ0KICAgID4gICA+IFdo
ZW4gQURDMENbOTowXSBpcyBzZXQgdG8gMCB0aGUgc2FtcGxpbmcgdm9sdGFnZSB3aWxsIGJlIGxv
d2VyIHRoYW4NCiAgICA+ICAgPiBleHBlY3RlZCwgYmVjYXVzZSB0aGUgaGFyZHdhcmUgbWF5IG5v
dCBoYXZlIGVub3VnaCB0aW1lIHRvDQogICAgPiAgID4gY2hhcmdlL2Rpc2NoYXJnZSB0byBhIHN0
YWJsZSB2b2x0YWdlLg0KICAgID4gICA+IA0KICAgID4gICA+IFJlcG9ydGVkLWJ5OiBLb25zdGFu
dGluIEtsdWJuaWNoa2luIDxraXRzb2tAeWFuZGV4LXRlYW0ucnU+DQogICAgPiAgID4gU2lnbmVk
LW9mZi1ieTogQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAgICA+ICAg
SGkgQmlsbHksDQogICANCiAgICA+ICAgRml4ZXMgdGFnPw0KICAgDQogICAgPiAgIEFsc28sIHdv
dWxkIGJlIGdvb2QgdG8gY2FsbCBvdXQgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHRoYXQNCiAg
ICA+ICAgQ0xLX0RJVklERVJfT05FX0JBU0VEIHJ1bGVzIGF0IDAgYXMgYSB2YWxpZCB2YWx1ZSBh
bmQgaGVuY2UNCiAgICA+ICAgYXZvaWRzIHRoZSBBREMwQ1s5OjBdIHZhbHVlIG9mIDAgdGhhdCBp
cyBjYXVzaW5nIHByb2JsZW1zLg0KICAgDQogICAgPiAgIFRoYXQgbWF5IGJlIG9idmlvdXMgdG8g
cGVvcGxlIHdobyBtYWtlIGZyZXF1ZW50IHVzZSBvZiBjbGsgZGl2aWRlcnMNCiAgICA+ICAgYnV0
IGl0J3Mgbm90IGxvY2FsbHkgb2J2aW91cyB3aGVuIGxvb2tpbmcgYXQgdGhpcyBwYXRjaC4NCiAg
IA0KICAgID4gICBPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4NCiAgIA0KICAgID4gICBUaGFu
a3MsDQogICANCiAgICA+ICAgSm9uYXRoYW4NCg0KSSB3aWxsIGFkZCBmaXhlcyB0YWcgYW5kIGFk
ZCBtb3JlIGRlc2NyaXB0aW9uIGFib3V0IHRoZSBDTEtfRElWSURFUl9PTkVfQkFTRUQgZmxhZyBp
biB2Mi4NCg0KVGhhbmtzLA0KDQpCaWxseQ0KDQogICAgPiAgID4gLS0tDQogICAgPiAgID4gIGRy
aXZlcnMvaWlvL2FkYy9hc3BlZWRfYWRjLmMgfCA0ICsrKy0NCiAgICA+ICAgPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KICAgID4gICA+IA0KICAgID4g
ICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXNwZWVkX2FkYy5jIGIvZHJpdmVycy9p
aW8vYWRjL2FzcGVlZF9hZGMuYw0KICAgID4gICA+IGluZGV4IGE5NTdjYWQxYmZhYi4uZmZhZTY0
ZjM5MjIxIDEwMDY0NA0KICAgID4gICA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hc3BlZWRfYWRj
LmMNCiAgICA+ICAgPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXNwZWVkX2FkYy5jDQogICAgPiAg
ID4gQEAgLTUzOSw3ICs1MzksOSBAQCBzdGF0aWMgaW50IGFzcGVlZF9hZGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAgICA+ICAgPiAgCWRhdGEtPmNsa19zY2FsZXIgPSBk
ZXZtX2Nsa19od19yZWdpc3Rlcl9kaXZpZGVyKA0KICAgID4gICA+ICAJCSZwZGV2LT5kZXYsIGNs
a19uYW1lLCBjbGtfcGFyZW50X25hbWUsIHNjYWxlcl9mbGFncywNCiAgICA+ICAgPiAgCQlkYXRh
LT5iYXNlICsgQVNQRUVEX1JFR19DTE9DS19DT05UUk9MLCAwLA0KICAgID4gICA+IC0JCWRhdGEt
Pm1vZGVsX2RhdGEtPnNjYWxlcl9iaXRfd2lkdGgsIDAsICZkYXRhLT5jbGtfbG9jayk7DQogICAg
PiAgID4gKwkJZGF0YS0+bW9kZWxfZGF0YS0+c2NhbGVyX2JpdF93aWR0aCwNCiAgICA+ICAgPiAr
CQlkYXRhLT5tb2RlbF9kYXRhLT5uZWVkX3ByZXNjYWxlciA/IENMS19ESVZJREVSX09ORV9CQVNF
RCA6IDAsDQogICAgPiAgID4gKwkJJmRhdGEtPmNsa19sb2NrKTsNCiAgICA+ICAgPiAgCWlmIChJ
U19FUlIoZGF0YS0+Y2xrX3NjYWxlcikpDQogICAgPiAgID4gIAkJcmV0dXJuIFBUUl9FUlIoZGF0
YS0+Y2xrX3NjYWxlcik7DQogICAgPiAgID4gIA0KDQoNCg==
