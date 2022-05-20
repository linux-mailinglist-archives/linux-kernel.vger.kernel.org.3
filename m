Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AC52E1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbiETBZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiETBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:25:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009822AC7B;
        Thu, 19 May 2022 18:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htTgJe9mj8OUof9HUlzzMZws3a87IS+rEf5jiGSY4hKrzoD8SYtKd6DONqZAkFQwg3tsjIYr+8wLtx/PJmjvY6+KFl7UQU8/JaQmzU0jn+Z4MA4TC3GvbJsKQ87RpNY1c8xflGph0bLVb7ReWQstGcUHP98DWaMb7IBpHtWj80v+FRcYcm2Lc4RWFZzC0nufBjUtCxTBXLzkRQR9EH41ehgJUMfHBRdprImVvhhk7hGKRUwQ/VWOLolKmbE9SbMhC9AJE6IPAHrclXeQ39dW0bs/+0cyXv1pRNXVysNi1FxBuBIi99tG0gXeUv6tRiJbhE3yL9mbg0+0R0J1GfcH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZy3GfrwaJj+v1XfsFyX0E8wbC6GPdPC7HIizEQMRpU=;
 b=cMx71nbeI8Zgyl19q5qm2JAy7Dlh6MpQt+fmjPHaddlW680oicW1F4gJm5vwZW32BiusZ4pCN00YutxgImieR+7I9Anp8o7zAVP/kmnvXTCYTxOJvQJq6437ptPtCqN8jUdOrrLyKBnDRHrK90JuFRF2BJKtaPHeDsEbUZfki007k1VNONbzsWnbLU8CqxKUjUsm12n34K3m48mjjnan3w5YJ25hsDTFW9dsTd6atvYr9/JBAFsS0P1mSQbDqIcxHNMPSe6V4pSMNXUVfcrjB6ZYWn4K0a6BPZ2FEcS1/y0VGekcFV50FLpVuGG0H2mEodLR5VIkq400+eHYD2Ko/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZy3GfrwaJj+v1XfsFyX0E8wbC6GPdPC7HIizEQMRpU=;
 b=m+ed2FUZlDIBLr7tTRJ5GimKzU4nj/fO9eJa4YxERpoGgADc2M1HczQfyW1uvvzAseRuox2QcYD8QnTGO0GseXoAvr1I0BI3v6a+1ywUBSKpGOUHJFrsCuo0wvfjBYEPd2xX4SAKSQ0DVhOT8bbtMIUSQtP7S/LrVYpDs6HjZjk=
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6798.eurprd04.prod.outlook.com (2603:10a6:803:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 01:25:31 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::55:de91:1970:385e]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::55:de91:1970:385e%6]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 01:25:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
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
Subject: RE: [EXT] Re: [PATCH] media: amphion: return error if format is
 unsupported by vpu
Thread-Topic: [EXT] Re: [PATCH] media: amphion: return error if format is
 unsupported by vpu
Thread-Index: AQHYa1IjNpIg22tPvUuo55ULLbP5Xq0mgWIAgAB2L0A=
Date:   Fri, 20 May 2022 01:25:31 +0000
Message-ID: <DB8PR04MB634682E34667F804608E3018E7D39@DB8PR04MB6346.eurprd04.prod.outlook.com>
References: <20220519072844.31792-1-ming.qian@nxp.com>
 <e03669333c20c07d40d0b1ce05eb771f5dbd4139.camel@ndufresne.ca>
In-Reply-To: <e03669333c20c07d40d0b1ce05eb771f5dbd4139.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9b3010e-0d03-4512-6075-08da39ffa187
x-ms-traffictypediagnostic: VI1PR04MB6798:EE_
x-microsoft-antispam-prvs: <VI1PR04MB679824CD8045A2F75F002705E7D39@VI1PR04MB6798.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ci+zvqv0y3j9SnebdKsy5pm1aTb3SOtxhmHpyLCU9BLC9TX08QQB0+qquyxFBHyCYsfGxiCoHNjUubAJWQNosPz14qw9pHCac5kfEIBBNWZvCBGPHmi1YRHLHzJEt+LLB/uf40nyW3Qy/Vx3fwiRrawLdcEi3irLa2cdxYi2/IkR0yKHgelG6nUerGLzaGYxP/IKD/bHOnusFX0ZNLosPjF89INmLptEPKdtZYvfUxinHBWH/nVL7ShdjGhWyE2DyCSunSxXfK8PmE92Rz0+FpB8UAD3Lgde8Hqgialnt/tJ1wrepx3+1+9BG/pmsITcWQ4L7QiF1MpfrZjvGkw29lC/ozChW3eXo0eIWpma7o/C+zk3LoxJvz6RCkcXRW8bjalyIZUhBsl/pUw/amS7sj8ipOTyzxdepcNsqAKAa0/MhMvelwp/5kIxpmQ34GTUhmNnNw07Zo1/gLCHb6oyrr16lzb4dQ2vikHJJXbaNbTOYb5Z3bmDhZTw2IpMH+qy9czC7kPGJZqG2E8trSFcaCALMpmtitBGV0wqlN8GajnJ5JSB5/J/QwF/yAZXw4fHqvz9MWFmfgb5GgmwR9BmHDaY3f4Q9Q2nmB7zNCYWSOmMilwott4dxO/cUM2bnIc+qJQ4SZrFhq86v0Qrt8RvVQr7zPQ+vNkIqpVEKCunvrUtakrz8mk9ot1Lw5sppBaKvouq3aXKzfIzhw81txOK/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(2906002)(33656002)(316002)(508600001)(71200400001)(38100700002)(86362001)(55016003)(83380400001)(64756008)(186003)(38070700005)(9686003)(26005)(7696005)(6506007)(53546011)(122000001)(66946007)(66556008)(66476007)(66446008)(76116006)(8936002)(8676002)(4326008)(7416002)(44832011)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTBMdzZZRjh5M240RUtmRjRvR0RNSkZrOXdQWXlFSmpsaU9NTjYrNlI2Zkt3?=
 =?utf-8?B?VWt2YjhWZVA1MGY5NlcwdDl3OWs2VXRFWFhzYVBoZUpFQ05oVDl5SExFNnZR?=
 =?utf-8?B?ZERCRis3cllkTzh0RlFwSDdPVzJXUW52YTB6d1MybUZSN3NPRHhQc3VOOTFT?=
 =?utf-8?B?cnFMUU15TDFNc1VLOVpRSUlHaFNyZWx5VHlrN0tpVTFQdC90VGNBanR5V0tx?=
 =?utf-8?B?c3pGZitORytHNUlEMXlnc2U1anF1NEJ5alZSeEpZZkdvV0VuRzBXL05kOWIv?=
 =?utf-8?B?SnR6cGRpbDQwTlhZRFV3VHVmcGdlSnV0dS9YQWdLNzYyejRYb0lyMDN4Tnh4?=
 =?utf-8?B?NkJKUDB4c0lYU2VjbEVJWTNZd1ZYSWk1NW1oRGoyb1VtZnVxbm0rSXRJUXJ5?=
 =?utf-8?B?bEM0WVZiN1VHK3BZNGVuNmcrK3VEMXFTVlZENGY4UCsvZXJDbmdVZTVYcEJF?=
 =?utf-8?B?c0ZyaWZka2g1aklKcXlnWlNMUkFPRC8wbkg0NlEyTWtGNzZTRDJoNmdCbVlw?=
 =?utf-8?B?WEFVRHpCT3hDS2dwZFpidE1ybTBKUGpubVplYzhsTm9iWnppUEI0dzhtaGha?=
 =?utf-8?B?Z0Y5dzY5dDBYcDdZTlJqVDBrSE4rNDlJMGNXOUk4bEovNjJGYXVzODBWRG1h?=
 =?utf-8?B?L1dtb1Y0MzdaSGpINFZHTjhJcCtuRElIWHk0SUhPTXV1b2xXVmxHeERMMFlC?=
 =?utf-8?B?bzVtZDNTaUl6ZTVpUXJ6TnlENERzc0tsNDc0Z0c5OFl3ZGhMMDFNR3A3blZp?=
 =?utf-8?B?bHpCektIYW1jS1Rqc1JURi84L2J1eDdMS3ZhOEtHVWRCLzB2ZnZQUThyRlo2?=
 =?utf-8?B?T3JPRXhOQXgxcEV3QjVSaTNQb3BHeFlNWXh4QjZXRW9yUDZ2bkJaMGFDa3FW?=
 =?utf-8?B?UnQ2eVBhcjZDSHE4aEI0VitCdXVkV2Vhcm5GYkZ3UUNORmRGNG04djlkdFdt?=
 =?utf-8?B?SEl5Z2xaQVl1VE4zMW94VDFUVWlwNmlOMS9HNzIwcWE4WGZVbUxEYzBZQzVC?=
 =?utf-8?B?YTY3Sk91ZFA4ejJhU2FDVUcxdVcybUEwWVJ5QStkRExYQnYzTTJrWWgzbVp4?=
 =?utf-8?B?V2lUbUFpUlRqRXNlOXVORTdTaTdhaUg0ZEl4QThYZGpuQ0dTMDVjZlJEdEZB?=
 =?utf-8?B?clpaRnNCS29ISHhBZjJUNWRiVkpUMnc2bUtsR0lCWklYT211dVlDOUhNbFZY?=
 =?utf-8?B?MmZQSXdmMS9MSnhjdXcyL1Zhd3pCeGJlbTkyWWo1alY3UEVtblVrOFdta29F?=
 =?utf-8?B?QlVBQ0pvTEVNSDB5MjFncDNpaUJSbDE2dHF5SmpiellkL0RlaTFGeFhRdUdn?=
 =?utf-8?B?QldFSWxMT1E5cmZaRHVsYVJERDFkVU4zYTFyZ1VNQnk2VWE1b25EZDNyZ094?=
 =?utf-8?B?dzRYRDhTUjM4QmRQcTJJVVV4QUtNSStNTFI5cEJZV2hFRnp4a0tHaVlzdnhB?=
 =?utf-8?B?MHE0Y2txcXNMZTlacGZhR2NSMzduNFhHVHpDc3MyNFFQNCsrQUEvV3dTRUdh?=
 =?utf-8?B?Y1NGQWcwY3d2TGVuSmdqcGZHam5PY3dyY3IxaklqZG5WS052RmRUREpyS0Rh?=
 =?utf-8?B?dEZOREtQZm5ZVjAyaWhZQUZSNE1JVkdUbjh2bjhaYU4zRm5uaUY0M0V4a3JL?=
 =?utf-8?B?R2ZiY0R0cFJnVFJZVmVGb21UMGxzb2hYKy9oQkhmcHRiVEZhMnhUNVZMckdJ?=
 =?utf-8?B?R00rMkVIVDViZksvTEx2WmJwOVZQNXE1aFdHL2N3c1JPY3I4dElyZmpzbW9R?=
 =?utf-8?B?enFOdzR3NzltT0JpbkVEdlBHLzhCcVpjOEs1dXd6a3ZjNm5VMitrMnJRMjRr?=
 =?utf-8?B?UnN5bkxmU3ZJR1UyWklvNFZQQWN4cXBnWmhVcUdkNjljMGprRFZXczFwa3lt?=
 =?utf-8?B?VVJsMUZWdkl3dU9XbTRoOE1YTDJDNTk2SWR6cDBmcDRlakM1ZmU2cUFva2RD?=
 =?utf-8?B?K0RLR21rNWt6UjJFMHpnOFVhdXNQNEI2UElVcjJTRDdmN09Kei9RZngyUUE4?=
 =?utf-8?B?akFzRHVDRW1VK0NaQ3pSV0FtQkIrNlZVMXNHRWRvODNaQWdQTFZOcEdLMWEv?=
 =?utf-8?B?bVpGdmtkeCtCL1c0eWtWQWFoV2F5YVNYY2owaEtINnprOWdYcnU2QmJXS29y?=
 =?utf-8?B?VzUxMUx4YU4zbnNEYXUvRXJLM1V4ZHlUVUgvVGFJMXdETXI2L2svM0YzZHhp?=
 =?utf-8?B?UDFVREJvWlNZa1prdzErMlBZdm9qekdiVXRDSjhKbUFzaWxxSkxrMWxsN1RS?=
 =?utf-8?B?bUhyT3JsSlNnSkVEZnI5bmROR1pNRlBHQUplYU5LMTgxLzhsQTlwdGo4ZmFt?=
 =?utf-8?B?ZEgwNWNEcWJaZ043L3p6V0Y4VXl3am9zMUJFczN3UGs0R2oyMER5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3010e-0d03-4512-6075-08da39ffa187
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 01:25:31.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Tc9c47vni7TAsl8cIsu47YfCfEtA+YMIPOp8sBxcZAhyhyKUUN5mVTj/1uDcTY33H9N19jQzzZFAGNyaoUihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIFttYWlsdG86bmljb2xhc0BuZHVmcmVzbmUuY2FdDQo+
IFNlbnQ6IEZyaWRheSwgTWF5IDIwLCAyMDIyIDI6MTMgQU0NCj4gVG86IE1pbmcgUWlhbiA8bWlu
Zy5xaWFuQG54cC5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+IGh2ZXJrdWlsLWNpc2NvQHhz
NGFsbC5ubA0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1l
ZGlhQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0hdIG1lZGlhOiBhbXBoaW9uOiByZXR1cm4gZXJyb3IgaWYgZm9ybWF0IGlzDQo+IHVuc3Vw
cG9ydGVkIGJ5IHZwdQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBIaSBNaW5nIFFp
YW4sDQo+IA0KPiBMZSBqZXVkaSAxOSBtYWkgMjAyMiDDoCAxNToyOCArMDgwMCwgTWluZyBRaWFu
IGEgw6ljcml0IDoNCj4gPiByZXR1cm4gZXJyb3IgaWYgZm9ybWF0IGlzIHVuc3VwcG9ydGVkIGJ5
IHZwdSwgb3RoZXJ3aXNlIHRoZSB2cHUgd2lsbA0KPiA+IGJlIHN0YWxsZWQgYXQgZGVjb2RpbmcN
Cj4gDQo+IEkgaGF2ZSBhIHJlYXNvbmFibGUgZG91YnQgYWJvdXQgdGhpcyBwYXRjaC4gSSBkb24n
dCB0aGluayBzdWNoIGEgY2FzZSBzaG91bGQgYmUNCj4gcmVhY2hhYmxlIGJ5IHVzZXJzLiBOb3Jt
YWxseSwgY2FsbHMgdG8gU19GTVQgc2hvdWxkIGVuc3VyZSB0aGUgZHJpdmVyIGZvcm1hdA0KPiBz
dGF0ZSBpcyB2YWxpZCBvbiBib3RoIGVuZHMgYnV0IG1vZGlmeWluZyB0aGUgcmVsZXZhbnQgc3Ry
dWN0dXJlcy4gQXMgYW4NCj4gZXhhbXBsZSwgZm9yIGRlY29kZXJzLCBzZXR0aW5nIHRoZSBDT0RF
QyAoT1VUUFVUIHF1ZXVlKSBmb3JtYXQsIG1heQ0KPiBjaGFuZ2UgdGhlIHJhdyBmb3JtYXQgKENB
UFRVUkUgcXVldWUpIGltcGxpY2l0bHkgdG8gcHJldmVudCB0aGlzIHNpdHVhdGlvbi4NCj4gQXJl
IHdlIGNlcnRhaW4gdGhpcyBjaGFuZ2UgaXNuJ3QgcGFwZXJpbmcgYXJvdW5kIHNvbWUgbWlzc2lu
ZyBmb3JtYXQNCj4gcHJvcGFnYXRpb24gPw0KPiANCj4gcmVnYXJkcywNCj4gTmljb2xhcw0KPiAN
Cg0KSGkgTmljb2xhcywNCiAgICBZb3UncmUgcmlnaHQsIGl0J3Mgbm90IHJlYWNoYWJsZSBjdXJy
ZW50bHkuDQogICAgQW5kIHRoZXJlIGFyZSBzb21lIGZvcm1hdHMgc3VwcG9ydGVkIGJ5IFZQVSwg
YnV0IEkgZGlkbid0IGFkZCBzdXBwb3J0IGluIGRyaXZlciwgYXMgdGhleSBhcmUgbm90IGRlZmlu
ZWQgaW4ga2VybmVsIHlldC4NClNvIGlmIHNvbWVvbmUgd2FudHMgdG8gZW5hYmxlIHRoZW0gaW4g
ZnV0dXJlLCBhbmQgaWYgaGUgb25seSBhZGRzIGEgZm9ybWF0IGludG8gdmRlY19mb3JtYXRzW10g
d2l0aG91dCBtb2RpZnlpbmcgdGhlIHZwdV9tYWxvbmUgcGFydCAsIHRoZW4gaGUgY2FuIGVudW1f
Zm10IGFuZCBzZXRfZm10IHN1Y2Nlc3NmdWxseSwgYnV0IG1lZXQgdnB1IGhhbmcgd2l0aG91dCBh
bnkgZXJyb3IgbWVzc2FnZS4NCglJIHRoaW5rIGRyaXZlciBzaG91bGQgcmVwb3J0IGFuIGVycm9y
IGluIGNhc2Ugb2YgdGhlIG5ldyBmb3JtYXQgaXMgbm90IGltcGxlbWVudGVkIGZ1bGx5Lg0KDQpN
aW5nDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFs
b25lLmMgfCAyICsrDQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfdjRs
Mi5jICAgfCA0ICsrLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9tYWxvbmUuYw0KPiA+IGluZGV4IGYyOWMyMjNlZWZjZS4uMDkzMGI2YmE4YzQyIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25l
LmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5j
DQo+ID4gQEAgLTYxMCw2ICs2MTAsOCBAQCBzdGF0aWMgaW50IHZwdV9tYWxvbmVfc2V0X3BhcmFt
cyhzdHJ1Y3QNCj4gdnB1X3NoYXJlZF9hZGRyICpzaGFyZWQsDQo+ID4gICAgICAgZW51bSB2cHVf
bWFsb25lX2Zvcm1hdCBtYWxvbmVfZm9ybWF0Ow0KPiA+DQo+ID4gICAgICAgbWFsb25lX2Zvcm1h
dCA9DQo+IHZwdV9tYWxvbmVfZm9ybWF0X3JlbWFwKHBhcmFtcy0+Y29kZWNfZm9ybWF0KTsNCj4g
PiArICAgICBpZiAobWFsb25lX2Zvcm1hdCA9PSBNQUxPTkVfRk1UX05VTEwpDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgICAgICBpZmFjZS0+dWRhdGFfYnVmZmVyW2lu
c3RhbmNlXS5iYXNlID0gcGFyYW1zLT51ZGF0YS5iYXNlOw0KPiA+ICAgICAgIGlmYWNlLT51ZGF0
YV9idWZmZXJbaW5zdGFuY2VdLnNsb3Rfc2l6ZSA9IHBhcmFtcy0+dWRhdGEuc2l6ZTsNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Y0bDIu
Yw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92NGwyLmMNCj4gPiBp
bmRleCA0NDZmMDdkMDlkMGIuLjg5Yjg4ZTA2M2U0NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Y0bDIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92cHVfdjRsMi5jDQo+ID4gQEAgLTUwMCwxMCArNTAwLDEwIEBA
IHN0YXRpYyBpbnQgdnB1X3ZiMl9zdGFydF9zdHJlYW1pbmcoc3RydWN0DQo+IHZiMl9xdWV1ZSAq
cSwgdW5zaWduZWQgaW50IGNvdW50KQ0KPiA+ICAgICAgICAgICAgICAgICBmbXQtPnNpemVpbWFn
ZVsxXSwgZm10LT5ieXRlc3BlcmxpbmVbMV0sDQo+ID4gICAgICAgICAgICAgICAgIGZtdC0+c2l6
ZWltYWdlWzJdLCBmbXQtPmJ5dGVzcGVybGluZVsyXSwNCj4gPiAgICAgICAgICAgICAgICAgcS0+
bnVtX2J1ZmZlcnMpOw0KPiA+IC0gICAgIGNhbGxfdm9pZF92b3AoaW5zdCwgc3RhcnQsIHEtPnR5
cGUpOw0KPiA+ICsgICAgIHJldCA9IGNhbGxfdm9wKGluc3QsIHN0YXJ0LCBxLT50eXBlKTsNCj4g
PiAgICAgICB2YjJfY2xlYXJfbGFzdF9idWZmZXJfZGVxdWV1ZWQocSk7DQo+ID4NCj4gPiAtICAg
ICByZXR1cm4gMDsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3Rh
dGljIHZvaWQgdnB1X3ZiMl9zdG9wX3N0cmVhbWluZyhzdHJ1Y3QgdmIyX3F1ZXVlICpxKQ0KDQo=
