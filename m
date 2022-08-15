Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A1592AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiHOIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiHOID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:03:59 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7331E3EA;
        Mon, 15 Aug 2022 01:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBTORYVcChZ0BeCn0dRNtXbnVQASNbiqMhZjwXXZLtrATXYCUsIJFuQaeGpmyzjMS/X2QBnsSTw9weqK5FOBYmbGgwoSctnW6NCM8dyteTxJ4vvnr7M35709wa0sbZlve4w/zZPg5wvbw9Fgq8yCnOp3jf+90QSyr3nk/di9oxAhe8bVdaMvKmLa2HILMaQsl7uVLVWyVQDLI1OVrQLEvfLdxmxnaEE+J0+xDtYdl0fOqEDD8L02O3VEY2JdJEASTUyeF09fb284dDcgI6KLeAmIpXDyvuX3PrzScf72k52vKs2b5xPbDZwx44LCMB3bgNORrmkmW0FD5ouXiHhFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r5NFPe7rWBsMLN/CpyXmjG0Zj0dzb8HZ2mn+9e5L+o=;
 b=VFur1hPyQoEkI4oJOYnXXFA6dRmC69loQ70uU4c08gItdCH51eNTLLQkbxW1cA1FnDkAqVfJ0HuwPWmtN/lU+PNjQmIk8wGwZtoFznwA1HTN4WZ/5VQl2rJQtQO9LWWHvjxvQfnViMnhroAgwyo6lB4DQ8KDAxwoJrANuxE256u+wuhS0CENCy/ue1igiLzc3qaFHrMzvJ9jGGxbFoTnzfZ42Zc4q4hsKCiQpMyJ9QPYC+uGHSQBPgEc3V8rW4+/tabnr+EYMjJcWQgmbG5SifwKGIJPiQrYlDOFtDoOQSb3e8yeiJG+0qZfyaAGXjF1F2suNnSKNkzx+fPaIH4dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r5NFPe7rWBsMLN/CpyXmjG0Zj0dzb8HZ2mn+9e5L+o=;
 b=J261RgIGILYV/neZ3InpHHzjYfiIji2YfPk2oHbEaHGERhUQsd8mKe4n6/Py9bHXyrnOAb82MMVXyz3VdXodxwXucFYXbroeXoOPT9hJRvEe20X4wDQTyaSu5GXpL/cpZXs2Zm84jL7H6d839BSVrqh7i7nsNd02j4pl4aEyMYc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8248.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 08:03:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::655b:f2cb:9c62:de0]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::655b:f2cb:9c62:de0%7]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 08:03:55 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "J.D. Yue" <jindong.yue@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE
 config dependency
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: adjust
 SERIAL_FSL_LPUART_CONSOLE config dependency
Thread-Index: AQHYplkdUtXdCCERREqYE3q4uMc8E62vrkxA
Date:   Mon, 15 Aug 2022 08:03:55 +0000
Message-ID: <AS8PR04MB8404508CDE3446CDF690107092689@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220802101613.30879-1-sherry.sun@nxp.com>
In-Reply-To: <20220802101613.30879-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee922a5c-9524-4176-7dfa-08da7e94b372
x-ms-traffictypediagnostic: AS8PR04MB8248:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3QK8RtEzhReLoFud9qXBhdtbpSsve6h10uJOGHY1Wkc+FGd9nIZ9UWacnhEYgWI9hwQybjtt1ZtgiQYp7k9QBR6qWlMx9pi/cz53U6yf/zspqSvwf9CxbRP5XBwYOVW7ZW30zwQCn8weyHmuN9Db4Qx2EIxuM7meidGqueJGtBPVqAKfe8fUUxTdb8n64kBQfGOppT/0Rrp5DPwDH1NoLinZdAOvLzWhGay+pT1EyoRjry0PeVLnpTSzFcKYOnImS3SO8i91BpXb4QphSaBFHkoE8ug3w2ZTsktpVwMCgnEfRCN7Z9a8oMqUuq6nWlL5dVhMBEGmmHN7Z94OM4egnbXEUDvacOb32bGS3jDojL7kc3VDixVa1ws3NbDP/Fypob/OCHtkejeu8TiHGCCmuFwPwqIFskuw0OTbJ7GXUeEKZLNekJ6C+U7QIjqFvnveiaFI3PjeVsxMX+ficLE7d9xEKQQjNHOzoRldNlwehOadBLP4MOLQwX66bEaw4xYUfa9PmzTqeIrH2k0SmgO6IYDI0l5O0/uCnjJ3BasGK1oh8kW5WJJ3UG2A+2nH7cFzn2wI8OtCCKzU67de4+IDYZZElfeH/EuvW4KmENlVK1bJFrAs6Mzg9K8EJKtAVFB81gJJ283PvaqcnNxKJRzVShwwM+N/tDxqm5/gaaT5Llhy3eEzFA5kWRs4eQtE8cs7RZ5adGd/3zcK9hI5MQ8kzrCCTvXOkVSaI5GdTUaMRbN1n/69S93RrImxfSR1oeJ96zfnhKu+HsXe0YcWJfN6k0dxyQ3Q2nTDc7TSTuvcWb1o/rVpd+B4GxkS9q8YbcW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(86362001)(38100700002)(186003)(76116006)(83380400001)(8676002)(38070700005)(122000001)(5660300002)(66946007)(64756008)(66556008)(66476007)(66446008)(4326008)(316002)(8936002)(44832011)(52536014)(7696005)(9686003)(6506007)(41300700001)(26005)(53546011)(54906003)(71200400001)(110136005)(478600001)(55016003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q1l4NnUxS2NDNEJJRER0MGpwSkFoZXNFSm5pNmlnRU1ucUd6NEd5TmY5Zis2?=
 =?gb2312?B?V1RCVk5QTlRQdk9SdW5uMDRjYVMrU1ByK3EwSG5JZU1yY3FCU25KSTdDbWRV?=
 =?gb2312?B?TzlYek55dnF2aXJ3c01KaGduWnJHMWtLQ0VHVm8zZTJIYTV6TzFsZWxxbDdQ?=
 =?gb2312?B?NUc2S3JUSHBlSW90dVRqelJwMVQ4eGRDRXFsQ3hBM3VFVGoxU1pDK1VIeVhv?=
 =?gb2312?B?YisvUS9MZ0JDdUwzTG1EWHc0OWZyaG5NbGhWazFBWjcrVTBnVzJWRVdPdFVV?=
 =?gb2312?B?Ym01VnFmenBoQkFkSGlGQTlvL0orN1pNVXFwVjZQa0cybkRzQytiN0pEUytO?=
 =?gb2312?B?c3ViNDFNK3lVbUZLVHR3dFd4Z3p2MlM2Um9iSGJ5aXRzWEdERnpYTUVOeHF4?=
 =?gb2312?B?M09UQWVWOGx5L21OMkllWjJnUVRXYzhJSkppc3QrSFZKL0FSK3V0dEYxVDE5?=
 =?gb2312?B?OHlRaHJrcjNrVm5Yc1pxTk1FeTJ6eE5lQU9PRzBGV3dMbVVQeEhFdFByVXdw?=
 =?gb2312?B?OTRHMEhFZWpDZmlOQldCMU16Ry9OdmpaQ0pYN2NoeFd6cGRqdVhyd1VsTWwx?=
 =?gb2312?B?OU5HQktuTk9NMlkwcVgxZXJQY2poVGZZb09mcXYrUG9qNndDbG14T25JVzlF?=
 =?gb2312?B?bWxCdEpMOUFJcHNHbGs5aFJ1NDA1NE9IUUNZWjNNMEFqWmFTZC81b1kzOXFI?=
 =?gb2312?B?NkRYc0hIVFk5WEhLU3ZrZVRXbWREbzNxS3FhQmdzN1FDbkpnV0JoWGRNOXFs?=
 =?gb2312?B?UzhRZmNQQm9waVlVM0E5ZkEyblRTd2ZXdm5obFhxa2pUeVE4OXRmVGhiV3JS?=
 =?gb2312?B?N1pMM1RKK2tHYnZMT0w5cFZCS1RFNFhnVUtxQ25HcldjcVVLMjBTZ0s2MUpt?=
 =?gb2312?B?ZU9LbXpGMUdmUGhLWUd6RGxiTjgrQSt0K3l5NDd2V3V3NWxKajRXaVBkbXFO?=
 =?gb2312?B?a0pmSVZhK1RtbEdyVXdOUTA2N1FWTHlodGJvL2xiSGIxazJlb1d0YW1LcHIx?=
 =?gb2312?B?aGp6KzlOWjhSZ0dDMDJIeW5wQmUxM2hsZHc1ZmttVFZ1T2dwYlhBYjM5Q1ky?=
 =?gb2312?B?blpFdEpJOUN2TkdDd3poc1ZpdW54cWx2RzlOcnN4QnlKbXJkOEtOc0FveTRi?=
 =?gb2312?B?b3pHY1VXbnVzUXhhOHhITjRzNkxqanFObktNT1VvRHFWMW03WU10c2xwMSt4?=
 =?gb2312?B?bkhlM0RDUEloOFhDZEFNWDFqOHhEMkVQdC9ZRnlESGEwTXRtd09USmVpdzNt?=
 =?gb2312?B?MlNyVTQ2NWdBVGpzalMyMS8zbU85SEI2SmlYay9XZzRnd20rWVlEYk1lZkty?=
 =?gb2312?B?anNXb0ZBMU5ucXlzUDRyYjBtTTlWaWFGOXh5a05xdHBjNWZaWVhDdTdLTmRJ?=
 =?gb2312?B?aEtmNWlxSWcya0FCMi9vaThSdVRjaTFubk9rcmpSVlB3SGZud2QxNkpXVUlK?=
 =?gb2312?B?UnBpVVEvSVhGbDV1V1ZKeGF2VnE2MnFnczAvMlVMQW0yajFaUkVmRjgvdEtY?=
 =?gb2312?B?MzhIWGp4cUc0MnU1dVlRd1pYS3oyMXVHOWZnVnVBZ1A3dXVjYWROd2tpb0xo?=
 =?gb2312?B?em9GajdYVk5YZlJOMWd2MXo5a1FEclBzQ3JnNCtvNllPUS9Kb3JoSUs2Zk9E?=
 =?gb2312?B?Ry9lSUxzNEJZcUZFSXJISWFiM2craVRkd3dJQkNEamdCMHl2WkhCVVFsS1FJ?=
 =?gb2312?B?bEwzSUxSWXB5TWVwWjg0MlU1QTFOWkd3TnhDZmJYSlBUbmNEaE5GY3h4MC9v?=
 =?gb2312?B?OXF3bVJwZzJFcDI0OUdqN0xOekNWRXlKWThzT002bSszNHY1dkEzWTYzTjAz?=
 =?gb2312?B?SU8yZnB3NnJtcEo4ZXhTdUpiTzFKYk1iVENwbHVJa1R5YlBSd2NiT3J4T3g1?=
 =?gb2312?B?ZFRyUEYveVcwbDlkdHhsa2VWTFJVMWZ6YXlRazdTYjFNMVZzWmRCV2JTaGxM?=
 =?gb2312?B?ZGdnaGl1bVptcUlXMGVBNWY1SCtXajNHeHVGRWtGcVdPcDZsVUlsUlNXem1K?=
 =?gb2312?B?U0ppYXFmLzV3Y0hvd3Y3ZFVMODRQM3FMZCtQWmhncjVYdE1RUmxaNytMcEs3?=
 =?gb2312?B?a2cvei9vcCtzbkFiMis1dW5pYmsxaWtReG1tYS9TOWhnU25CU1lJZUVRUk9W?=
 =?gb2312?Q?D2AjASUJHy7w3rWMsNH9LJJWT?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee922a5c-9524-4176-7dfa-08da7e94b372
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:03:55.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUnSq6kAy4AiV7kV2K6Glj0wNEQQkajgkfBUWA63SsCWBPk+X87H4kounBYeAXDeW4eoD7AZZXLJ+3DI0s1/Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jjUwjLI1SAx
ODoxOA0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGppcmlzbGFieUBrZXJuZWwu
b3JnDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsgSi5ELiBZ
dWUgPGppbmRvbmcueXVlQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gdHR5OiBzZXJpYWw6
IGZzbF9scHVhcnQ6IGFkanVzdCBTRVJJQUxfRlNMX0xQVUFSVF9DT05TT0xFDQo+IGNvbmZpZyBk
ZXBlbmRlbmN5DQo+IA0KPiBGcm9tOiBKaW5kb25nIFl1ZSA8amluZG9uZy55dWVAbnhwLmNvbT4N
Cj4gDQo+IFJlbW92ZSB0aGUgbGltaXRhdGlvbiBvZiBTRVJJQUxfRlNMX0xQVUFSVD15LCBhcyB3
ZSBtYXkgbmVlZCBlbmFibGUgdGhpcw0KPiBjb25zb2xlIHdoaWxlIFNFUklBTF9GU0xfTFBVQVJU
PW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW5kb25nIFl1ZSA8amluZG9uZy55dWVAbnhwLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL0tjb25maWcgYi9kcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZyBpbmRl
eA0KPiA4NzcxNzM5MDdjNTMuLmExOGRkNTI1ZTQyYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL0tjb25maWcNCj4g
QEAgLTEzMjUsNyArMTMyNSw3IEBAIGNvbmZpZyBTRVJJQUxfRlNMX0xQVUFSVA0KPiANCj4gIGNv
bmZpZyBTRVJJQUxfRlNMX0xQVUFSVF9DT05TT0xFDQo+ICAJYm9vbCAiQ29uc29sZSBvbiBGcmVl
c2NhbGUgbHB1YXJ0IHNlcmlhbCBwb3J0Ig0KPiAtCWRlcGVuZHMgb24gU0VSSUFMX0ZTTF9MUFVB
UlQ9eQ0KPiArCWRlcGVuZHMgb24gU0VSSUFMX0ZTTF9MUFVBUlQNCj4gIAlzZWxlY3QgU0VSSUFM
X0NPUkVfQ09OU09MRQ0KPiAgCXNlbGVjdCBTRVJJQUxfRUFSTFlDT04NCj4gIAloZWxwDQo+IC0t
DQo+IDIuMTcuMQ0KDQo=
