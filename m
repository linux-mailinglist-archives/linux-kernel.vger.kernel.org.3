Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8436D509D26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388087AbiDUKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354947AbiDUKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:09:12 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20050.outbound.protection.outlook.com [40.107.2.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC25286E2;
        Thu, 21 Apr 2022 03:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuAWZdzL1B3PVB+Nzb4tcu29W9A1F9wuod2algQ8FX6vu7V/JdCdunJHxUOp7ABrrjLvYsXKEEDfAfYCUIt6kWA6pkQCL5ubS7MeITdQKhAxxWwWW51U2odwbUSR45kShyqrs5v8o7JB3IV3rL1dueixMNtfN6aL8NyOQz5Ypua/oiqbWgc7gZklhOyHVWCfFzysC1XYYU0r3S4vxMnvOWzLBpG0NpvcexXJ4xE4qLRAQcqNQM2i5xdmZd0MtTpnJIDW/g/3p8RozXCiBw5k2JMNRvAefnkPT218KsVLyxPzythz3FUtkdYU7BNejB8vkcZmEssTEfciLNewx5dQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nzac2tSMIdrQJwpvwc63qSuHLwL/EPOaIaPklC0MOk=;
 b=FkS2yJmXMI3cZRIWg34xmVBsKRgGmBwymVUh5LiASbtIk9JFelggEkoSYssnMuXjA28ECKkAsaY7rVyXkUOmcjkMXOGhYbAcw8avAnvUEgIJzuYAHNGSNX7lS33vaThRtKna7VkTKqaQM7UuXqs8LgFEq7tt7XSOBEQoYms4JBGw8UoIVuL9IrGXx4wygpA7XHZxvTudz1Z6pUFWslmEN8ZBYNGhIV0j12CrHww6KKx78j4rJveElAKRflbApYpG8uJvz3aYWsdxYq/vTtkHDyJS9zumMaetJwaPQnFfgb47qY8QeJ3ja9PMwyo/XLEgI7yYJNd9rjIxg1m++ADt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nzac2tSMIdrQJwpvwc63qSuHLwL/EPOaIaPklC0MOk=;
 b=PSNqPVQfcgfhh+CWnHUYP1x+rQUdWktIek82zaexGHOb2jSaEArRMMGBI/dVX+okWhuNd2f+MiBs59snUQvg8W2hfquUE60dnZ5E+AlYA5f/Hsqk97cDDye4EGxF+dpuXztE1/sqePJdHOvddtG239EmSl03ti/ycI42Ygmj280=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM0PR04MB6689.eurprd04.prod.outlook.com (2603:10a6:208:172::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 10:06:17 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 10:06:17 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: RE: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Topic: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Index: AQHYVIiygEZn3a5TtE+wxprjnFe3kqz4tPoAgAFfCfCAAARPAIAAB12AgAADECA=
Date:   Thu, 21 Apr 2022 10:06:17 +0000
Message-ID: <VE1PR04MB6477AC00BF08A787EBF433F3FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
In-Reply-To: <20220421094421.288672-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 584855ac-fb5d-4568-7636-08da237e9398
x-ms-traffictypediagnostic: AM0PR04MB6689:EE_
x-microsoft-antispam-prvs: <AM0PR04MB668988CC6AC0FFF2AF54D807FEF49@AM0PR04MB6689.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8J1SwT4Wz3j0gHPRtUOcLunYQu7q6tGll3xKAw8++98xZngRLOvvodSzyABBrOw3N6oSR4y61xp+kh2wsDS7JJ7u5E1lZMfK9FutqwOrjfeJYuyqir2UFihw06fh/ak2lyhpzc3exxPpfNSaK3lzJzfjwDd0MTJlxfHZ9ve/kT/WCMCdcFnMOS6+QplnRGqB7GsGpn0ucOWGxaAM6M84fbLgfGiPjtCO7E4RMN6CQzMXtxn8Ei5PfyTKaN9gwRGuWUJQ/8lolzHyW++UDRrXdtnZTBNml+gkn21hrUQ1P+soOM14pPlUxxmb6yMirCWDu6zjj/CDo0XENlAUwiCmEEMZDIkgb/ylrzzrxKUUG+pstGCyVca6O2UQiapyG3/ByEIrNOWLtwvpAzI3/hMfB8oCI4ktuxES1+eQcuiIn39yD8JQrDHuOWYeOudHiR5l/AWvWUojeg1YS7GUQ8g2KUcAhTf3B6et0Jp+zaDzsBjIKY88e8rASCf9m95HAitqNiOcVY9e+tLqHP4Z4D2pnadOmiZIjIQY9sIzGXd+vnA81DLeT4MUjzs5kROzIRWGx9vMWPOOhMM6hAUgOPDZ6qLw2IhGxlD424NdwKV/PLvfG2KLbn04swWC9BPOxyYQOPn7jbAK/0NNe7LnFlZKlopIEfX9Ov6ZLq8VW7DebvzqlRoHt+w9Odnh4yz6z32W/kmWkDfuo06ZV2Na/ZIwzNgIxoOr3zFPz+0uf0F7WVw7emikJUaxKHTTSXs0OHihXNRDdJU9inT2WAsbRcAz1LlT/kdo5a0w9tDy6ulloOshsaOaHuxjXL7jPUzDjHwCwDJ8bLREsM1bCJ2nTIPuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7416002)(83380400001)(8676002)(54906003)(186003)(26005)(110136005)(38070700005)(316002)(5660300002)(38100700002)(4326008)(45080400002)(52536014)(66946007)(55016003)(71200400001)(53546011)(508600001)(9686003)(6506007)(76116006)(7696005)(2906002)(44832011)(122000001)(66476007)(966005)(8936002)(33656002)(66556008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?STNkUjRGckxjMFFVTEpVUWMvY2I5MjJVajVndWdYeTZpenUyM3BDRlJqZzNV?=
 =?gb2312?B?ZjBLQWtaWUZXcWtLVmZRR2RRU0Q4V1hCU0NPSlpHbnpqWmVVTkwrNXBIYUxx?=
 =?gb2312?B?bFVLOUFqY3diSzZ1cnVyeXlvZGt5Q25qRGN6NGlVT3U1bHpSekFqcFFjbTRQ?=
 =?gb2312?B?cXp1U2dKenBGMkhXdXc4c0VNNStVWm55ZUtRQUdXWXd3SUl0eXFpVjRpMjdG?=
 =?gb2312?B?VDgzWkROaGY1eVg3Y0ljVjJkM1ROOGU2MHFXSTZhN05NamtvRW5JUlNZT3Zp?=
 =?gb2312?B?TkNVZ2JJVUdScUZSN2JPTG1GbVo2Zk5TS3RrMnRPOCtJb2NOb1YrRnNLVkdw?=
 =?gb2312?B?c2gxQ0s1aHczaEJpR2Q3R0lNWEtySURtcXY0ZmNwUW9oNndNRjM3QWliVGhs?=
 =?gb2312?B?bzNPQTZHSzdld3ZTc3BQSVl6eVY3M3Y2N3R0S1JFdTlwRlFycTN5K2I4WDIy?=
 =?gb2312?B?RHFwaDlxMzNOeTZVNUJXVVpDc0ZER0tRWk5VWjJYUE5DZHVaQmgzQUhyQVhr?=
 =?gb2312?B?UTFPbXRVcTBEaFF2U3JWT0FHS2pRREFpYjU5Q05rRHlrS2tjRkxIN3FvQTBN?=
 =?gb2312?B?VXgwM0tzNXcra1VQOHB5eDJHZWNmVCtpRmNCRlJBN1dleEhJWjFXaEJWTERx?=
 =?gb2312?B?dDdiY2VvdXo3dEVwOTRzRklGMlk3N3U1eVYxTmdTOU1ndytGMC9VWTFWSzEy?=
 =?gb2312?B?V3ZjOUNOb21qclFIdjdxblpLZWFOM2o3YTU2ZWI1S2swRlY4OG54YmNBSlVN?=
 =?gb2312?B?d1Fsai9jM2Z4K1lGYWtsV0FYMFUvWTlHUDFES0tLMC9jZFMzNWVvWm5od0tG?=
 =?gb2312?B?aFJGTWhWTHRWT0trcjJnVTQrcFU5Rk9QVXJQRGN3VkZVTTFpQTRjUGxQNU9H?=
 =?gb2312?B?cUhubmRKV1RpeFg5Y2RrUjlNZXREZTBlb0VmVmJvOGpCb2ljL1luRTVES2pC?=
 =?gb2312?B?TWdSaTZEV0JvWXJCa085UXlLeFpsK0RhdXUwZVFVK3ZBSmpYS0lmbGx4d1ZH?=
 =?gb2312?B?UmRYakFUY1FIWDlWdFlRcU9VZ0YwanI5dmV3TXQ0MkNpTzBrYWQ4bkdBalNs?=
 =?gb2312?B?WlFEQnExSDVlaXZySEsxMWdRTXpjU0pmV2RwVmh2OFdSRGdVb0QwUitjNEts?=
 =?gb2312?B?dWlvclZ2ZmJueUQ5bGtzMUNIMkZHY1cwYldFN0pmOTF2WjVjeGZPVXptTGNi?=
 =?gb2312?B?VlBGK3NheWtTdFJJMzhCeFlnb2tjZVNKUHR1U3h1RnZBVzdYRlN1WjUzT21i?=
 =?gb2312?B?dWZUL1l0V3VoZDZJRCtHeldrSUlFTlNYWTlrNmhCZS9QM2R4UWdhVnBjdDBT?=
 =?gb2312?B?YVQzUFF0NnR4WlQvODRnR0FXN2swMnVTQlN2VzVKOTIwaHhtQ2JmNThQZktu?=
 =?gb2312?B?bWhkanllQ3hKYVlNRXZRbkE5WXVmU0RHOTNqQWRRd1p3KzFPaFYzbUc3SFlN?=
 =?gb2312?B?eFVDNTBPUUhteG5hbHVWVkJLVXBnNnJsZStIdzduY3BEVDdXUzhUemFlMzNG?=
 =?gb2312?B?T3FzNkQ0ak5KK2FtTFRpMk42cVdQNjZvRGEzZnViWEFEYjRqY0x6bzZnTFEw?=
 =?gb2312?B?bGQ5UkVFT0ZDQzBGbWNZZWIrL3JudVlCNEpqdFJaNVVOaVVKUGdudVBkSXBl?=
 =?gb2312?B?SDcrUlRXME1KZkNqUEdIdUp5ZVNCT3ZQRUxhQVVNYXRIVjQxQU92N1FHa2ZB?=
 =?gb2312?B?R1JXeE5VOXhSWnZQUDEwQXpSVlM4a0xpa3M1dzZoMlJTK0UwYWRGdGJXNlVv?=
 =?gb2312?B?YjNuSzJuTjNpOFowNEZJeW5zQitwZlZjejJLM3hRRW5VV0pqcTVESUVrNU5G?=
 =?gb2312?B?d0dnbThNRjh3dkxxa1lPL2ZvNGRRY2pSTnJBaCtNZE1vdlFSSXBWcHZxWUd1?=
 =?gb2312?B?cHdiUW9jSUJmSis3czdZMm1zMWVQeTd1UFNtS3lzV3JQYkxYWjhjR3lxb0x6?=
 =?gb2312?B?OU1WL2J6L3hmN1JEVjdyUTdoRDdHb1liUmM0bXd5SWxPeERJM2U0Wm9iSGc4?=
 =?gb2312?B?aS9NRTROa0MrbDJlZFI5ZG9LVVYvVzE1NW5jd29VeDFFdkNJbUJTVmJ3MkpM?=
 =?gb2312?B?SXlzNHVlWFFhY0dwdXZ3cjViejZBeGFuYUN3WitVWjYzRXFkQTRmTDVFSnZu?=
 =?gb2312?B?a2JkQ1JCejd1eXhEMFBHcGlaTExld0p4MC9YcFdxZ0RvQlVDa0d4Nmh3bU00?=
 =?gb2312?B?bHFscGJjUndHczZ0SERtaFcwNFE2cm1xZlFWa2l4a2xITmhsSWFqcjgrbUN4?=
 =?gb2312?B?alRsUGlsSFcrcGdWcTJGM2dnbis1Yk4xRUlvRk84N3NnSFczOExqVUIzY3JY?=
 =?gb2312?B?YTg5M040cGh3SE5PdHExSHM0NkVFaEdqL3ZTOTlMaVZDRG55VEFvUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584855ac-fb5d-4568-7636-08da237e9398
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 10:06:17.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdXaGOusIhvvHHeaqZcK2oRVkzIro5LtGpTzu36d2dIlTrM4uqElqBZGYqfIR3xQPyuD6ng5Gre1kEfyOr5MFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4gDQpTZW50OiAyMDIy
xOo01MIyMcjVIDE3OjQ0DQpUbzoga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnDQpDYzog
YnJvb25pZUBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSmVycnkgSHVh
bmcgPGplcnJ5Lmh1YW5nQG54cC5jb20+OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zcGlAdmdl
ci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IFZs
YWRpbWlyIE9sdGVhbiA8b2x0ZWFudkBnbWFpbC5jb20+OyBNaWNoYWVsIFdhbGxlIDxtaWNoYWVs
QHdhbGxlLmNjPg0KU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggMS8yIHY0XSBkdC1iaW5k
aW5nczogZHNwaTogYWRkZWQgZm9yIHNlbXRlY2ggc3gxMzAxDQoNCkNhdXRpb246IEVYVCBFbWFp
bA0KDQpPbiAyMS8wNC8yMDIyIDExOjExLCBKZXJyeSBIdWFuZyB3cm90ZToNCj4+IFBsZWFzZSBh
bHNvIGFuc3dlciBNaWNoYWVsJ3MgY29tbWVudHMuDQo+Pg0KPj4gW0plcnJ5IEh1YW5nXSBJIGRv
dWJsZSBjaGVja2VkIHRoZSBNaWtyb0J1cyBkZXZpY2VzLCB3ZSB1c2VkIHR3byBNaWtjcm9CdXMg
ZGV2aWNlczoNCj4+IEJMRSBQIGNsaWNrOiANCj4+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dw0KPj4gLm1pa3JvZS5j
b20lMkZibGUtcC1jbGljayZhbXA7ZGF0YT0wNSU3QzAxJTdDamVycnkuaHVhbmclNDBueHAuY29t
JTdDDQo+PiAzOTEwNmMwMzVjMzc0YjVlYzYwNjA4ZGEyMzdiODgzZiU3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTcNCj4+IEMwJTdDMSU3QzYzNzg2MTMxMDczODY4NDQ3OSU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TQ0KPj4gREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAlN0MlN0MlN0MmYW1wDQo+
PiA7c2RhdGE9cnNFVHpsRmhmZTJoeVJBaVFPTDRLSEFRNHZ3aCUyRkZyWXpyb1olMkIwY2NTTXcl
M0QmYW1wO3Jlc2VydmUNCj4+IGQ9MCBCRUUgY2xpY2s6IA0KPj4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3d3DQo+PiAu
bWlrcm9lLmNvbSUyRmJlZS1jbGljayZhbXA7ZGF0YT0wNSU3QzAxJTdDamVycnkuaHVhbmclNDBu
eHAuY29tJTdDMzkNCj4+IDEwNmMwMzVjMzc0YjVlYzYwNjA4ZGEyMzdiODgzZiU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPj4gJTdDMSU3QzYzNzg2MTMxMDczODY4NDQ3
OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBDQo+PiBpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAlN0MlN0MlN0Mm
YW1wO3MNCj4+IGRhdGE9TEVtd0Y0NkI5R1lEJTJCY3BHb3hwaUdUbk1ndlRiTEhQNElVaXJHUjc4
QTVVJTNEJmFtcDtyZXNlcnZlZD0wDQo+PiBCb3RoIG9mIHRoZW0gYXJlIFNQSSBpbnRlcmZhY2Ug
Y29ubmVjdCB0byBsczEwMjhhcmRiIHRocm91Z2ggTWlLY3JvQnVzIGludGVyZmFjZS4NCj4+IFNv
IHRoZSBuYW1lICJzZW10ZWNoIHN4MTMwMSIgaXMgbm90IGNvcnJlY3QgZm9yIHRoaXMgbm9kZS4N
Cj4NCj4gSSBhc2tlZCB0byByZW1vdmUgdGhlIHdvcmRzICJEZXZpY2V0cmVlIGJpbmRpbmdzIiBh
bmQgdGhpcyB3YXMgbm90IGZpbmlzaGVkLg0KPg0KPiBOb3cgeW91IG1lbnRpb24gdGhhdCBlbnRp
cmUgbmFtZSBvZiBkZXZpY2UgaXMgd3JvbmcuLi4gSXQncyBjb25mdXNpbmcuIA0KPiBJIGRvbid0
IGtub3cgd2hhdCBkZXZpY2UgeW91IGFyZSBkZXNjcmliaW5nIGhlcmUuIEkgZXhwZWN0IHlvdSBr
bm93LiANCj4gOikNCj4NCj4gV2hhdCBpcyB0aGlzIGJpbmRpbmcgYWJvdXQgZXhhY3RseT8NCg0K
SSAqdGhpbmsqIGl0J3MganVzdCBleHBvc2luZyB0aGUgbWlrcm9idXMgY29ubmVjdG9yIGFzIGFu
IHNwaWRldiBkZXZpY2UuDQpUaGVyZSB3YXMgYSBmb3JtZXIgYXR0ZW1wdCBieSBWbGFkaW1pciBo
ZXJlIFsxXS4gTm93IGFzIGl0IHRoZSBuYXR1cmUgb2Ygc3VjaCBhIGNvbm5lY3RvciB0aGF0IHlv
dSBjYW4gY29ubmVjdCBhIG15cmlhZCBvZiBkZXZpY2VzIHRoZXJlLCBpdCBkb2Vzbid0IHJlYWxs
eSBtYWtlIHNlbnNlIHRvIGhhdmUgYSBqdXN0IHBhcnRpY3VsYXIgb25lIGRlc2NyaWJlZC4gV2hh
dCBoYXBwZW5zIGlmIHRoYXQgb25lIHdpbGwgc3dpdGNoIGZyb20gc3BpZGV2IHRvIGEgcmVhbCBk
cml2ZXIgaW4gdGhlIGtlcm5lbD8gU28gdXNpbmcgInNwaWRldiIgZm9yIHRoZSBjb21wYXRpYmxl
IHdvdWxkIGJlIHRoZSBmaXJzdCByZWZsZXguDQpCdXQgYXMgZGVzY3JpYmVkIGluIHRoZSBzcGlk
ZXYgZHJpdmVyIHRoaXMgaXMgcGxhaW4gd3JvbmcgKGFuZCBhbHNvIGNhdXNlcyBhIHdhcm5pbmcv
aW5mbyBtZXNzYWdlIGl0KSBiZWNhdXNlIGl0IHNob3VsZCBkZXNjcmliZSB0aGUgYWN0dWFsIGhh
cmR3YXJlLg0KDQpUaHVzIEkgcHJvcG9zZWQgdG8gdXNlIERUIG92ZXJsYXlzIHdoaWNoIGFyZSBs
b2FkZWQgYWNjb3JkaW5nIHRvIHdoYXQgaXMgYWN0dWFsbHkgYXR0YWNoZWQgdG8gdGhlIGhlYWRl
ciwgc28gYSByZWFsIGRyaXZlciBjb3VsZCBiZSBsb2FkZWQuDQoNCkJ1dCB0aGVyZSAqY291bGQq
IGJlIGEgc2FuZSBkZWZhdWx0IHdoaWNoIHRoZW4gY291bGQgYmUgcmVwbGFjZWQgaW4gYW4gRFQg
b3ZlcmxheS4gTGlrZSAibWlya29idXMtc29ja2V0IiBvciBzaW1pbGFyLCB3aGljaCBtaWdodCBl
eHBvc2Ugc3BpZGV2LiBBY3R1YWxseSBpdCBpcyBtb3JlIHRoYW4ganVzdCBTUEksIHRoZXJlIGlz
IEdQSU8gYW5kIHJlc2V0cyBhbmQgSTJDLiBNYXliZSBpdCBzaG91bGQgYmUgYW4gTUZEPyBJIGRv
bid0IGtub3cuIEJ1dCB0aGF0IGlzIHNvbWV0aGluZyBmb3IgdGhlIERUIG1haW50YWluZXJzIHRv
IGRlY2lkZSBpZiB0aGV5J2xsIGFsbG93IHN1Y2ggImdlbmVyaWMiIGRldmljZXMuDQoNCi1taWNo
YWVsDQoNCltKZXJyeSBIdWFuZ10gDQpUaGFuayBhIGxvdCwgTWljaGFlbC4NClllcywgdGhlcmUg
YXJlIEkyQywgVWFydCAob3IgR1BJTykgYW5kIFNQSSBpbnRlcmZhY2UgaW4gTWlrY3JvQnVzIHNv
Y2tldC4gDQoNCktyenlzenRvZiwNCkhvdyBhYm91dCANCmNvbXBhdGlibGUgPSAibWlrY3JvZSxt
aWtjcm9lLXNvY2tldCI/DQpvciBob3cgYWJvdXQgVmxhZGltaXIncyBwYXRjaD8NCg0KDQoNClsx
XSBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsaW51eC1kZXZpY2V0cmVlJTJGMjAyMDAzMTgw
MDE2MDMuOTY1MC0xMy1vbHRlYW52JTQwZ21haWwuY29tJTJGJmFtcDtkYXRhPTA1JTdDMDElN0Nq
ZXJyeS5odWFuZyU0MG54cC5jb20lN0MzOTEwNmMwMzVjMzc0YjVlYzYwNjA4ZGEyMzdiODgzZiU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElN0M2Mzc4NjEzMTA3Mzg2
ODQ0NzklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMjAwMCU3QyU3QyU3QyZh
bXA7c2RhdGE9WTE2NllER1NwRVgwd3RVUUU4VjdxbDhhdGtiNzlCbUc5WTVtWGI4S1dKTSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0K
