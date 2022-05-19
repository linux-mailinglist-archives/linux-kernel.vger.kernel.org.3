Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB56652CC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiESGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiESGny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:43:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFB4D9F3;
        Wed, 18 May 2022 23:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2Us3Jad6aTWV0Hqka/klrLKxpiz42fZy8S0irqz8Rq39t7SXxSaZIjJs4/PjOH/J+W4JSv92OoRIkChgipSB1cBtahDq2GEdE8gvl1EqLbNenQnABD0mtfPbMNvo+1urRfEa4O+k2GVGNSo1It11zxd8tFGgx6XWiFC9+qFpbAJRujsOp6Lis2HXB/Yh6A4+xE4/ifPEplM/xYSESbqOwoVPKyjcuI8fFnv+8XV2N7eVrXf5jShXQ4LpynguKQnxPX4vymraD3B6rYgVhY+zbNWnHIEZ276hMXolxBCamZ+Kb6YmO9Bv3cGjuoJQf6NAw0Gri/sEdfWyzFWr1e9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArzbIVq9N6XrO38/C8rAgpSG+5dPnvdPL2rRok1Ir4M=;
 b=CrzDP+dw/+5aXliSfztijW9qAtdJvUcqpN9W3i4mX2/XeqmvutD3TuR9GYtJDAdp9AwtkVxZr4ADNAB7GJIASQFyBsmWWuFfepv0H4jDaYQhqUfAqtCLvrFCNcURgxYDtkxmEZzgCk9iSJbomTo7VvoEjn6Ptj1ga2dc+z93wAWC15icq9/AUyJjj/+mhELVa/xuulbkqyUiJ5tGfHrLBA8LSqAhALw4zvtZ6NzAfjj3tOAu5zrJk4XfhzOxY7F+0CZOG5quL/+2plLYq9s1/sNjlsAqV+F/bKL07vebQNXszjxnctMc6K/Z2pz0LI/7RB6/3cgA9y2Bw/K5vRVYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quectel.com; dmarc=pass action=none header.from=quectel.com;
 dkim=pass header.d=quectel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quectel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArzbIVq9N6XrO38/C8rAgpSG+5dPnvdPL2rRok1Ir4M=;
 b=DShKf0Roaud9gv9CWt5R7MqRdWUNNb9aD/3H1soUE9I1GyXPHxdYXPPYC2EWFAtOuYEhrXHXhZvJyxaxIp/xmY0rAC8J7JDiNyVKqZ3IJicYcpHRPjXRAzmOqvR+ABp5fux4y4/2LYolbMGPyDG+xhuBxKFFekSHENmoBdoGC8c=
Received: from TYZPR06MB4270.apcprd06.prod.outlook.com (2603:1096:400:88::6)
 by HK0PR06MB3059.apcprd06.prod.outlook.com (2603:1096:203:8f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 06:43:48 +0000
Received: from TYZPR06MB4270.apcprd06.prod.outlook.com
 ([fe80::c0e6:3fb5:f84f:244c]) by TYZPR06MB4270.apcprd06.prod.outlook.com
 ([fe80::c0e6:3fb5:f84f:244c%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 06:43:48 +0000
From:   =?utf-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>
To:     "rspmn@arcor.de" <rspmn@arcor.de>, Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Torres Liu" <torres.liu@quectel.com>
Subject: Re:[PATCH v3] USB: serial: option: add Quectel BG95 modem
Thread-Topic: [PATCH v3] USB: serial: option: add Quectel BG95 modem
Thread-Index: AdhrS8S5+T4dcEZQTCupcY23LDK7xA==
Date:   Thu, 19 May 2022 06:43:48 +0000
Message-ID: <TYZPR06MB42704009F4A7CD16AAF0EDBD86D09@TYZPR06MB4270.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quectel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69031cfc-48f7-4560-0650-08da3962ede7
x-ms-traffictypediagnostic: HK0PR06MB3059:EE_
x-microsoft-antispam-prvs: <HK0PR06MB30590BD7F398C8729A5BDC4486D09@HK0PR06MB3059.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+e6NGPbhn6+l7DutzjhcXenSR5yofIsKFYYgflJOSgIFDaMwBaPkwcOGA7eplBhbHvFq42gu31TYBEiL2BhO8Zp9K36muJ+Y3vzTKL3+QAigRo+LwLrrTxDle0VKuL5tTYptI8mddVhveI47EwUByQPkPvHSosLDMimh+YEOPOxUAkT5oBwCfDqe/3OrPLtU52utrAKduzwenObkSpgnpwykBfTE8ec+zRZuD6trSblLK8K/ciALiiAFUNk7vIOMzGtzssHXgbcoBTkUQxavi5ibGBF/yQkxBfweYobw0xGmUMrl8nnoiaFAQ7aEjBBluumkX+3jpcrsh5rNjefdd0Nz8VK2nUol6Spz9//SaY9vNi5QP0sAbzbBuZ46jHTrUgPcpp924Pmv2H2nKZuJjXzcUBEP5RAnRf2zRMzLQW1yq7OiMQ0omHX7hCL0B+NCSXz91lyivpXDfR7vOHUzxPMYH9PEdkuOqPrHuLYCrbkZecpovdacX3POp71UzFzPuSUcsILlbi4UQ9E0xFPhLzG2AY/DUmVY8sRroS6GFox0u1jLR/96Y+Zkd5tIAj7oR3BA8feY3+u/SpiVb2h28X3TPKe1SbCrUZRgF1ptl/DHfCmHrOLVVKD72cUExYZd2+hiXIirNA+nQHtoyRHBvWDiKDmxciooluPmKmIoR+QawAR14J23gbPj3xAXcIWfiUYloweznquLyWUoJJmlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4270.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66446008)(8676002)(64756008)(4326008)(66946007)(107886003)(316002)(7696005)(83380400001)(6506007)(53546011)(71200400001)(110136005)(186003)(76116006)(54906003)(85182001)(86362001)(2906002)(38100700002)(38070700005)(8936002)(52536014)(508600001)(55016003)(122000001)(33656002)(4744005)(5660300002)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajVUZEk5cUtFaHRwdklaNEliWFJzMEtLZTNaWjZsWTJWc0JGVkpmOCt3ZXVG?=
 =?utf-8?B?RjZjZDlDdWdPcFNUV0xTN2tHTTFFaTk2OWxpQUZ1dW5IR2JMcHNCaStDc0x6?=
 =?utf-8?B?ZGthVHFYODBlYkJUQkpYZ2txYUxOVDFIaDRveGlrOXJNbFZqdGMrYnB5TEM3?=
 =?utf-8?B?a09aSnNONG5qaE9CdDNidkhNeGJmRE9PMUJkTlpZODMzSFJOZ3dsZEJVL2Mz?=
 =?utf-8?B?cFFOWHYyemtveVpETlMwQkRpNlpKYjIrdTVxUSt5NlJHVHZGMTFQc3dnUUxE?=
 =?utf-8?B?WlFMS25xcXY1VXZQMTFMSUx4VXdzdHB6ZmJ4dUlSUHprSGxiMEc2cWJheVBD?=
 =?utf-8?B?bkxjaGxuODN1SVE1NmhUVk5sNUVBYWNReC9mYlM5SzlJR3k5em1CTS9KZ2xV?=
 =?utf-8?B?UnBYYnVtcmJOMThGeWJtVU1XWFBuVERCT24xblNGZTRGTTc5SnF3UHlhNmJB?=
 =?utf-8?B?MWJQYWc0TXgzYStJTGZBVzB1TTlSYkhQRGlTdlk5ay9uMmt0MXpyY2MxMVVP?=
 =?utf-8?B?Ni9raTM2OXdWUDdQb1VJVStlaGFYTnhPWTRaaGRrcXBLNmJDRWg1alRxTW45?=
 =?utf-8?B?d0hWT2hSRnB6amdyOE5FZWExMTB1QWxMM3lNcyt0NUR5aXBKeStrOEtrTDF3?=
 =?utf-8?B?bXFNOTNyMnc1cE91WERVNkh0c3k1WEcvSTY1TXUvQ3Q5cjRQanVvZldKWXAw?=
 =?utf-8?B?UW94OVVFSWJoL054OHZXOXVzZjFSLzY0RkErZUl0dnJpWnVzMnBXdmdiYlFn?=
 =?utf-8?B?cHBpaldCOVhnd2tKNGUzcVV1bEpJaGdxRFFCSnlrbmEyem9SRFJxRzZlM2RH?=
 =?utf-8?B?ZnRjVkw1ajVldFRVVW9GQ1FUTk5ic2JDUXNpMU5NVWprVTlVb2doY3ZHOG12?=
 =?utf-8?B?M2xjOEJtZ0ZucVFiQVRKK29qQThFcTA5SENPTEpCVkRIMlhGVzJwRUl2NXZ0?=
 =?utf-8?B?UHFLdTRDQWZUSncrMXhlNmg1ZVRzVU9yMmgxRUtWNUovWjlKMDhkbDJyaDAx?=
 =?utf-8?B?WkxYbi81RFhlWmtHK1VkbXNwaXlmK1V3a3hOM0cxb1ovTStqd0tQcHBJZ0Jz?=
 =?utf-8?B?ZFc1Z2tNWkMyMmVEcGRZYmE1TWtBdmFjdHNGcDNIWnB1MGExQ0YrS3ZGSEhT?=
 =?utf-8?B?MHlObzdDaHc5a3VINFkzN09OeENKd3hDeURNUEpOVjdyNUI4YUM2bFNldmxM?=
 =?utf-8?B?Wm5NZkNKenl4K1VQK0kwdVVqZW5jUGtOUWE4UmVVZjVPeUdzWWtVd09DQTJJ?=
 =?utf-8?B?UnBLb2MvTUNIcU1FMnlwZ1BzdmhRcGZIZjRTUWUwZkdpVUJIcStxc1BHZ2N2?=
 =?utf-8?B?OWxDNXNUdVRJUlAvRTlTMHZUNmpMTHlsQ20yR2Y4d0xNTlRVZ25hc1g3ak5I?=
 =?utf-8?B?RHk4em9IdEE0UkpHSkxvMnhmSHhvWHgwVG5KeWtrMlZmVFdveDc3ck1CaXla?=
 =?utf-8?B?c2VWRmZFTjgxWEpNd2MzL1BEVnRxRUxMOU9HUjJZa1JPV21KSHZPaVo3K0ts?=
 =?utf-8?B?cHQ2Q1RtYk5MaVVCTWJyVzg2U0ZDMk5XcTM3alI1UzQ3UnJtd09NdUhXejds?=
 =?utf-8?B?WGhvSU56djl5SEMrSnRoQVpHd0lBeTZDbkcvVmpCVHllWXE2OXRldzZ5WFp1?=
 =?utf-8?B?Z0NOVnZ5RlNwVjFqMm12QzBqMGJnMWRvMWNUTGJEWUl6VjFudHVGSUlJdlE0?=
 =?utf-8?B?MnZYdHRVK3IyckRLL1FoRXVCclVMNVdaQm5paVJsRmcxQTYrMTc0THhCb1E5?=
 =?utf-8?B?R1hZUFFyNzBOUmsveEpCbExwS0VxaUZTV3NkWms2UXBPb3krUzlRaHZpYjY5?=
 =?utf-8?B?STg3Mm5DMkhYalVyQ1VJVXVYTmUwRm93RUNtQXhiSlVjUVh0YWNQc0UwRmhs?=
 =?utf-8?B?eXhTQWljbjFDVTUvWEtjMlYvbXo1YkdaVElYS1Z5QmJFZzNCTFEyTnRTb3h6?=
 =?utf-8?B?TFo2OExid2FEcElXNmQzUGNNU3Zod1RjUld3aDltNmJiYlprajlGVzNHNWdY?=
 =?utf-8?B?U3dBa2NISGkwZytwRzZibndBWk5KTWZIU2ZNRXhVSEpzNXJSdnB0bmorZ3E4?=
 =?utf-8?B?NXZJSlg3VTU2SUVMWHgvRm8zSWNQQVpoTXRiVkJIbWxWL0FCU0FmNURzcUF5?=
 =?utf-8?B?OVNtaHBNbC9YOEZPRUpmWkNVb0piZ0h3NDBEUVRVVDcvOFVxbUl5K09aaDJw?=
 =?utf-8?B?WXVqN2VXTEVJM2lMNVN6cWlxbDhReFlxbU9yMnFNbTNhSVZzUFBEbmFSdTAw?=
 =?utf-8?B?V2V1WkorQ3BZVHBjdFhUbmF4aVUxdGQ4bVF5T2pUWURmSlhBY3paelNDNldk?=
 =?utf-8?B?cWdUekl5ckp1VzRQQk9SS2dIMXU2WFVhVDhNZ3piUUZrTDV3UXQvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quectel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4270.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69031cfc-48f7-4560-0650-08da3962ede7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 06:43:48.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7730d043-e129-480c-b1ba-e5b6a9f476aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5PC8V24HWXYFMq/Lb7RvMBYY6s+O6RHJsx0jeAsZhni+ANbQyvsO4VhQTFUZJyxPYv7nYrA+IB01iLbfTY88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnNwbW4gYW5kIEpvaGFuOg0KCVRoYW5rIHZlcnkgbXVjaA0KDQpPbiBUaHUsIE1heSAxOSwg
MjAyMiBhdCAxNDowNiwgSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPiB3cm90ZToNCg0K
PiBPbiBUaHUsIE1heSAxOSwgMjAyMiBhdCAwMjozNDo0M0FNICswMDAwLCBDYXJsIFlpbijmrrfl
vKDmiJApIHdyb3RlOg0KPiA+IFRoZSBCRzk1IG1vZGVtIGhhcyAzIFVTQiBjb25maWd1cmF0aW9u
cyB0aGF0IGFyZSBjb25maWd1cmFibGUgdmlhIHRoZQ0KPiA+IEFUIGNvbW1hbmQgQVQrUUNGR0VY
VD0idXNibmV0IixbImVjbSJ8Im1vZGVtInwicm1uZXQiXSB3aGljaCBtYWtlDQo+IHRoZQ0KPiA+
IG1vZGVtIGVudW1lcmF0ZSB3aXRoIHRoZSBmb2xsb3dpbmcgaW50ZXJmYWNlcywgcmVzcGVjdGl2
ZWx5Og0KPiA+DQo+ID4gIm1vZGVtIjogRGlhZyArIEdOU1MgKyBNb2RlbSArIE1vZGVtDQo+ID4g
ImVjbSIgIDogRGlhZyArIEdOU1MgKyBNb2RlbSArIEVDTQ0KPiA+ICJybW5ldCI6IERpYWcgKyBH
TlNTICsgTW9kZW0gKyBRTUkNCj4gPiAgICAgICAgICBEb24ndCBzdXBwb3J0IEZ1bGwgUU1JIG1l
c3NhZ2VzIChlLmcNCj4gPiBXRFNfU1RBUlRfTkVUV09SS19JTlRFUkZBQ0UpDQo+ID4NCj4gPiBB
IGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRoZSBVU0IgY29uZmlndXJhdGlvbiBmb3IgZWFjaCBt
b2RlIGZvbGxvd3M6DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENhcmwgWWluIDxjYXJsLnlpbkBx
dWVjdGVsLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IHYzOg0KPiA+IDEuIHVzZSBVU0JfREVWSUNF
X0lOVEVSRkFDRV9DTEFTUyBpbnN0ZWFkIG9mDQo+ID4gVVNCX0RFVklDRV9BTkRfSU5URVJGQUNF
X0lORk8gMi4gaW50cm9kdWNlIGxpbWl0YXRpb25zIG9mIFFNSSBpbg0KPiA+IGNvbW1pdCBtZXNz
YWdlDQo+ID4NCj4gPiB2MjoNCj4gPiBhZGQgYXQrcWNmZ2V4dD0idXNibmV0Iiwicm1uZXQiIGFu
ZCBSU1ZEKDMpDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUuIE5vdyBhcHBsaWVkLg0KPiAN
Cj4gSm9oYW4NCg==
