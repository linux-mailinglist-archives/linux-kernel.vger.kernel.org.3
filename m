Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE7465DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355510AbhLBFiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:38:10 -0500
Received: from mail-psaapc01on2095.outbound.protection.outlook.com ([40.107.255.95]:61920
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355397AbhLBFiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:38:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGiOhgT0sws7ncPO6bdTZqYksTG7ayd6TCJKewegfOiePm+7xO9Oq51iadmjR3SMThDQjPeBjyIw947qr5hTQtg9QgQfM1ru+ORvkIjsaSzuk2x0apLPcGmUPPDV4/AnAumWqz31AFKMKiIBzghcy2+UKv/5Y7/5YrTYMRcOFvBb81zFUK3GVNZdfd/2QoEXTHxCj4mppYlMxaR7xzSdP2pqMizuHvLiNZCHsXrFHK5FlsynR9hJTT3k9VahKMP/KocifzO82G36kNjxAHacIeNCmm+Au/U3hNTIgzsYXyjUp7SlIghtyj7hGwc9TdiQ2hH1ec4nldkbYfJQtLgmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut5PGV6ceXwoWan5ZcmLgTFfgMa4cCHMblINLvWF7lM=;
 b=dPeyPgTzwJtLNtdW5ddjdc9Rj43AOUCMVtE0SudzVaJJCu1Yq6YE6eN90ujAEnLmCLt/pNmoiTLO1dFE1Uv6WUZn6xslNARVqFc4mZ4QyDsVdyLRJ+SX0cZC5zu8GEhczYo3rh2+rfUSFSwRauX6mfBwM87mu+6oEIg/y1liNO3+IEdgEMUK2jsNc2JE61d7x77Evp+YHNO0HwhrdZkbOageNGwqpcj0bmsDvG0+GHnBgZn/IeHI7PLTbuJdmJrXPuR77mPm4EbQR2zFSMI8JIaHSLzXTD9IkfBuCMPJSkXovyb1KVHvUrNQwjDLOP/Uq8Uf+jaVItwUlPOMXHKw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut5PGV6ceXwoWan5ZcmLgTFfgMa4cCHMblINLvWF7lM=;
 b=Lib2Qd6GpfHBPUVojpkgcRr4+rYcSunVZRgtJ50a6WhJvksNa8tG180QSsVqlM1tqTd8DHWNp+6tDDDkWlzJ4Kz1Cj/Voj/73UKfLJ6e5RsJ3dK0Sq8n4HDawyFklkfBC9EAtXHyD254YDas3veLW+zQucULIXtMhI3j6e6QshSYEo7tACbzJJVtZ+bp/kmQRLWUnY9cGFfnRD7wG9nZnWZCYKlOzdJPyzgJT1ulHX6Cqxg9gOE1kg1k4mSEc+9+ejPL3NdJMCHLicFVF7w4P6FxAeyZgbNyJ3lysf1qxPCSbe6szD3nfDShsVRk8uC1/sitjB3lsAHl4vaydy0POw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (20.177.162.17) by
 HK0PR06MB3682.apcprd06.prod.outlook.com (52.132.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Thu, 2 Dec 2021 05:34:32 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 05:34:32 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
Thread-Topic: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
Thread-Index: AQHX4rYwtTnSWbEdCEahHL8/1MfMn6wbMQYAgACjh+CAAOyZAIABuaVAgAA6gCA=
Date:   Thu, 2 Dec 2021 05:34:32 +0000
Message-ID: <HK0PR06MB3202FCE686296F1D5A8AE44C80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-3-neal_liu@aspeedtech.com>
         <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
         <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
 <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a53e022d-b63b-422c-f8e6-08d9b5556b5a
x-ms-traffictypediagnostic: HK0PR06MB3682:
x-microsoft-antispam-prvs: <HK0PR06MB36824F3D54014136812F8A7480699@HK0PR06MB3682.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPgua4Ul/1eiqyCQ33GOMA3HMR0FL9LtDz5c/SFIujysbCt6Ljlly4OtUY9U/cjd1tjyZwBTgZy3mEITVTqFHcY4l3oIVs7V2BTLDPGfgjdK6FikZrN9lb1qhNcPztynUSfIscqp0xTqYwEV6g12P7Vp1nKqij35AJU3+1ICvcJkKr0hZAjqSsX707OWSwzMy8l6dwzgrC6yX2cvmz6iqmGuq+H4xzTjZxWPXE1O+DC/NKS7iWZFuwZLrNTtHFtJYCcJc9LNP4DwT56TOl2vKm7t0LFoIQnZDScdPRs0OzYpz9btl+4wT3E0M3Zialc8lP54pXPTNPe22ugzf6qqpIBtPOovoJJCylWkeKDCcJtsNpPaaF2Yu7ISlQsaze7SPSDwb1EaNnbjTROl5ksW21aKta3+BWjS/wn7brKT+vs6hdxAI0rrmBhPlwFZHZVmG7kW9RGvMftlyav+StPlI5W7yJmo3D+88qcCtGAWnaYHxHHhLm0REjvJK0UxSMBHvT6Ih+MKqZrq5gJvN5ffzkFdKD/40LCXijAkQA/3RJBzFQJQSa0PtBtCEtJqzHncCeEWi4WLa6trTVlZu4CtmF1wjEH2edp5FgKFGD1nquX68hb6EXLI+PuAojcx6mDguIYR3pd9G3PPFfm8UwueJ/yJztb/GvYhl8xriXEQEKLQLyI6JAJ/iiEohocqE6uWrdLwP1zZGFlT90a9J495J9nRjLpUUk5F5igazpkOqQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39840400004)(86362001)(110136005)(316002)(107886003)(7416002)(921005)(8936002)(38070700005)(71200400001)(4001150100001)(7696005)(66946007)(66446008)(64756008)(8676002)(4326008)(5660300002)(66476007)(52536014)(76116006)(83380400001)(2940100002)(26005)(66556008)(9686003)(508600001)(122000001)(186003)(55016003)(33656002)(53546011)(6506007)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVaZGg3OXVKR3kram15MklWcGFHRSsvNU5zcUtxR0c4eFRoWU9nNnJ1NUNP?=
 =?utf-8?B?b2twT2VGcS8vUzE3QlFJYVh1S0I3T2FpOGZnYStxb2tuVVV5Rk5DYlJvUXRk?=
 =?utf-8?B?ODJ4NDIzODV5WEZPWUVjTkliQmd4L0R4L3lwZ3B3T2dLZ01ZYXFYV1ZyZHFU?=
 =?utf-8?B?cXV0OFo5Q29OcnE4dXFRS3JIRCtOQTFleWJTMFFTdVBTVmZsMlZIL2Z3eDNt?=
 =?utf-8?B?TVc2Q2MvMW8rNm02SEJOSXQwc1cwYnMwd2ppbnpCRS9UbCtWRm9MYUFhM2Q1?=
 =?utf-8?B?UXcyeEttV1lQWTJNYXJCWGd5d3ZGa01tK1lPQzl4dERUTzlhRGZYaGwyRG93?=
 =?utf-8?B?eEorRUFKbGx0Qm9hTEZGTXZYU2EvWmZycjFURHhBRlVuaHdnaTd0RlhUSEZF?=
 =?utf-8?B?ZEl3cHhLS21GTENkbFdoOEVoY1R5aGZaK2dNVER3L3ZobUZIeUZGWENscmtk?=
 =?utf-8?B?eE0yNE5udnY3enZNM0tHRkRwWU8yZ2pYVDdwVEZvREN6enR2QkkyWWtsVVhQ?=
 =?utf-8?B?SWllVDRhckYxTFdoS0xwSmJjTUhIcFNGdFNXNTdTZEpBby9JMHYzYXFWbkV1?=
 =?utf-8?B?SWlRZmNkTGJnQmw4bXE3Y1hRNUNXUG54L0FBMW16ZGh5d2xleHFjcUNMWG1T?=
 =?utf-8?B?Qkw1SWk3T0NmN2ZDZUh4QUpTV2JjUjdXbjNZUk90L2pVajNqeDQ3OEEwYkNj?=
 =?utf-8?B?c01DRTdzMzB0ZSs2WWhVWmlxWGJocC9idjhwY3VSOGxtWktmOS8rMFRnOWVt?=
 =?utf-8?B?RXBrRGV5SXVpQkR1OE9hU3JCV3U2RThnaFBOV2NiL3Jhc2F5dVQ2ekFPTjhU?=
 =?utf-8?B?OTQ0dStKWFVDai93R0RwbXhCL05xT09tMk9CS2NaUXF3czNXdnkwZDNpQVRM?=
 =?utf-8?B?emwwWXlkeG5jTFZGRTVodFNBWVZTclo0OGJmSG04c2F0U2Z5K3VMeHB2VlRK?=
 =?utf-8?B?OEErWmJoZm50TGlmdlFzdVZCaERDclQwL1dXZ0F4NWUvbUo3alh4MFFDU1Rw?=
 =?utf-8?B?Uzhhb0Z0c0hnRlVsYkZqY1lBN1hzUkRLck10SjR5UmR1UnozWlVIOU9OV3Zj?=
 =?utf-8?B?VERqMUhRLzdWWUwzckZmWFdlTWxhTi9LSHdQOStYa0w2SVpsRFRyV1NjZm9J?=
 =?utf-8?B?cjUrbER4UXQ4VlJSMStRaC9sMEVOUkg4TGUrVmJLTjgvNDNPVktDNlg3d09G?=
 =?utf-8?B?R0d6MmRWejA3cVVvTFpSaWRYT3RuaDNra2c1aHRuQXhDQnJVTEtaL0hndmM0?=
 =?utf-8?B?TkRwMHE3STQrM21xUTZOS29LSzFRa01wanhpZlUzTzB0RFVhaHFRNWZzaTEv?=
 =?utf-8?B?Y1FPUWVVcWpMZHFZN2EvZ0dUd0x0K2FyUXdlQ0VIZXloZXliNFFoL2R0bUox?=
 =?utf-8?B?N1VWSnc5L0JNZ0NIZjdBeVYyOHlPVjBmOUZIMno2TXl3c0pSVWhBdGlmWTFG?=
 =?utf-8?B?R0tZVDBFT2Fmdk42Wmhja1kxMk9jZWRBRHAwSkRyT3hPbW9WYWd4a3pGOVlQ?=
 =?utf-8?B?WE1nVE9peHJwR1QyWHA3MEZEZnRtZ2wya1RoV1BtanhLcWFaMWlQdDlGdGto?=
 =?utf-8?B?SnBKTUhBM00wRUl5V2J4MC9UQmRvbW43bnVEbXJxVmY5eUhWRzZxZ0FTYWVv?=
 =?utf-8?B?MmdFZ0RacEcyQXBZSFRRR1hYRVZoazZDSDl0MWZzZk53NEJpei9ObmMxNzlM?=
 =?utf-8?B?bzdHS0puby9rMndBM0l1N0JGcnIvbjJ4NGpmR1MzOVBjMTNNTlRLTlBleVdI?=
 =?utf-8?B?d1dyNklqQmxiUDZEeGNOTk1mTWszVjIxU1dUa1A2VXZFS01VRU5ndWNkNGFC?=
 =?utf-8?B?U0tDT2h2aENlQWllczRHVTFvbmM2VldpZStoVVIxRnpZMGpsVGR0L1RZOUph?=
 =?utf-8?B?bUthS0Q4cVRtL3pWWUplRU5BVHUzVVFlT1Y2UnA5SXdUOUlvTXg5MHZOaytW?=
 =?utf-8?B?ZC95ZkRRZzlnWENuUndQUjVUNDBsSlFQbmg1NHZRZkZNTUVkemhiSmIvZ2Jk?=
 =?utf-8?B?WmZGVHhRajloMk9zUk1OWTA4Q2ZqTml0ektVZVJCUG1vbWJseU4xMUY2S21C?=
 =?utf-8?B?amo4U2dvWGRvd28weFV1TXZlTFk4WDlnT2JiUldpelRibGtoQlB5c2pRRlZP?=
 =?utf-8?B?WU1UZUw1eklJRHkvNWlncUF2Q2FBR3NpMVZEYnUrR2dFWW44R0pTem9VWkRY?=
 =?utf-8?Q?7CCvntsvTP1aIxSwMjwRGbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53e022d-b63b-422c-f8e6-08d9b5556b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 05:34:32.6488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ahbwx3f9dQK4pGC59QrG8hW3PAFdMJKrFlHZoSNWYV7+dSwKzPCN8kA6+UF84vSJ6w4oYor51vjG2FBnp84SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIExpdQ0KPiBTZW50OiBU
aHVyc2RheSwgRGVjZW1iZXIgMiwgMjAyMSAxMTowMyBBTQ0KPiBUbzogQmVuamFtaW4gSGVycmVu
c2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPjsgRmVsaXBlIEJhbGJpDQo+IDxiYWxi
aUBrZXJuZWwub3JnPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz47IEpvZWwNCj4gU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8
YW5kcmV3QGFqLmlkLmF1PjsgQ2FpIEh1b3FpbmcNCj4gPGNhaWh1b3FpbmdAYmFpZHUuY29tPjsg
VGFvIFJlbiA8cmVudGFvLmJ1cHRAZ21haWwuY29tPjsgSnVsaWEgTGF3YWxsDQo+IDxqdWxpYS5s
YXdhbGxAaW5yaWEuZnI+OyBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT47IFNhc2hh
IExldmluDQo+IDxzYXNoYWxAa2VybmVsLm9yZz47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IEJNQy1T
VyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvM10gdXNi
OiBhc3BlZWQtdmh1Yjogc3VwcG9ydCByZW1vdGUgd2FrZXVwIGZlYXR1cmUNCj4gDQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0
IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJl
ciAxLCAyMDIxIDc6MzggQU0NCj4gPiBUbzogTmVhbCBMaXUgPG5lYWxfbGl1QGFzcGVlZHRlY2gu
Y29tPjsgRmVsaXBlIEJhbGJpDQo+ID4gPGJhbGJpQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gPiBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaQ0KPiA+
IEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29tPjsgVGFvIFJlbiA8cmVudGFvLmJ1cHRAZ21h
aWwuY29tPjsgSnVsaWENCj4gPiBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj47IGtlcm5l
bCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPjsNCj4gPiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
PiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
Mi8zXSB1c2I6IGFzcGVlZC12aHViOiBzdXBwb3J0IHJlbW90ZSB3YWtldXANCj4gPiBmZWF0dXJl
DQo+ID4NCj4gPiBPbiBUdWUsIDIwMjEtMTEtMzAgYXQgMDk6NDcgKzAwMDAsIE5lYWwgTGl1IHdy
b3RlOg0KPiA+ID4gPiBTaG91bGQgdGhpcyAgYmUgY29udHJvbGxlZCBieSBkLT53YWtldXBfZW4g
PyBJRSwgd2UgaGF2ZSBhIGZlYXR1cmUNCj4gPiA+ID4gZm9yIHRoZSBob3N0IHRvIGVuYWJsZS9k
aXNhYmxlIHJlbW90ZSB3YWtldXAsIHNob3VsZCB3ZSBob25vciBpdCA/DQo+ID4gPg0KPiA+ID4g
Rm9yIEtWTSB1c2FnZSwgcmVtb3RlIGtleWJvYXJkIHBhY2tldCB3b3VsZCBiZSBzZW50IGlmIHVz
ZXIgd2FudHMgdG8NCj4gPiA+IGRvDQo+ID4gcmVtb3RlIHdha2V1cC4NCj4gPiA+IEluIHRoaXMg
Y2FzZSwgZC0+d2FrZXVwX2VuIGlzIG5vdCB1c2VkLg0KPiA+ID4gU2V0IFZIVUJfQ1RSTF9BVVRP
X1JFTU9URV9XQUtFVVAgdG8gZW5hYmxlIEhXIGF1dG9tYXRpY2FsbHkNCj4gPiBzaWduYWxpbmcN
Cj4gPiA+IHdha2V1cCBpZiBhbnkgcGFja2V0IHdvdWxkIGJlIHRyYW5zZmVycmVkLg0KPiA+DQo+
ID4gU29ycnksIEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB5b3VyIGV4cGxhbmF0aW9uIGhlcmUu
DQo+ID4NCj4gPiBOb3JtYWxseSwgYSBVU0IgZGV2aWNlIHdpbGwgZG8gcmVtb3RlIHdha2V1cCBp
ZiBpdCdzIGluc3RydWN0ZWQgdG8gZG8NCj4gPiBzbyB2aWEgdGhlIGFwcHJvcHJpYXRlIGZlYXR1
cmUgYmVpbmcgc2V0LCB3aGljaCBpcyB3aGF0IHdha2V1cF9lbg0KPiA+IHJlZmxlY3RzLiBJIGhh
ZG4ndCBvcmlnaW5hbGx5IHBsdW1iZWQgaXQgaW4sIEkgZm9yZ290IHdoeSwgSSB0aGluaw0KPiA+
IHNvbWV0aGluZyB3YXMgZWl0aGVyIG5vdCBwcm9wZXJseSBkb2N1bWVudGVkIG9yIG5vdCB3b3Jr
aW5nIHdoZW4gSSB3cm90ZQ0KPiB0aGF0IGRyaXZlci4NCj4gPg0KPiA+IFlvdSBzZWVtIHRvIHdh
bnQgdG8gb3ZlcnJpZGUgdGhlIGJlaGF2aW91ciBhbmQgYWx3YXlzIHNlbmQgYSByZW1vdGUNCj4g
PiB3YWtldXAgcGFja2V0IG5vIG1hdHRlciB3aGF0LiBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgZGVz
aXJhYmxlIGZvciBhbGwNCj4gPiB1c2UgY2FzZXMsIGFuZCBtaWdodCBiZSBzb21ldGhpbmcgd2Ug
d2FudCB0byBtYWtlIGNvbmZpZ3VyYWJsZSwgbm8gPw0KPiA+DQo+ID4gSSdtIHRyeWluZyB0byB1
bmRlcnN0YW5kIHlvdXIgc2VudGVuY2UsIHlvdSBzZWVtIHRvIGltcGx5IHRoYXQgdGhlDQo+ID4g
b25seSB1c2UgY2FzZSBoZXJlIGlzICJLVk0iIChhcyBpbiByZW1vdGUgVVNCIG9uIGEgc2VydmVy
IHN5c3RlbSkNCj4gPiB3aGljaCBJIGNhbiBwcm9iYWJseSBhZ3JlZSB3aXRoLi4uIG1vc3RseS4N
Cj4gPg0KPiA+IEFuZCB5b3Ugc2F5IGluIHRoYXQgY2FzZSwgd2Ugc2hvdWxkIGFsd2F5cyBkbyBy
ZW1vdGUgd2FrZXVwIHdoZW5ldmVyDQo+ID4gYW4gZW11bGF0ZWQgVVNCIGRldmljZSBoYXMgYW55
IGFjdGl2aXR5IChrZXlib2FyZCBvciBvdGhlcndpc2UpLA0KPiA+IHJlZ2FyZGxlc3Mgb2Ygd2hl
dGhlciB0aGUgc2VydmVyIGhhcyBlbmFibGVkIHRoZSBmZWF0dXJlIG9yIG5vdC4NCj4gPg0KPiA+
IEFtIEkgY29ycmVjdCA/IFdoYXQncyB0aGUgcmF0aW9uYWxlIGhlcmUgPw0KPiA+DQo+ID4gQ2hl
ZXJzLA0KPiA+IEJlbi4NCj4gPg0KPiANCj4gTGV0J3MgbWUgZGVzY3JpYmUgbW9yZSBkZXRhaWxz
IGZvciBvdXIgaGFyZHdhcmUgYmVoYXZpb3IgYW5kIGhvcGUgeW91DQo+IHVuZGVyc3RhbmQuDQo+
IA0KPiBIVUIwMFs0XTogTUFOVUFMX1JFTU9URV9XQUtFVVANCj4gSFVCMDBbM106IEFVVE9fUkVN
T1RFX1dBS0VVUA0KDQpDb3JyZWN0IGJpdCBudW1iZXIuDQoNCj4gDQo+IFNldCBIVUIwMFszXSBp
bXBsaWVzIFVTQiBkZXZpY2Ugd2lsbCBkbyByZW1vdGUgd2FrZXVwIGlmIGFueSB3cml0ZSBjb21t
YW5kDQo+IHRvIHZodWIgcmVnaXN0ZXIuDQo+IFNldCBIVUIwMFs0XSBpbXBsaWVzIFVTQiBkZXZp
Y2Ugd2lsbCBkbyByZW1vdGUgd2FrZXVwLiBJdCBjYW4gb25seSBiZSBzZXQgaW4NCj4gc3VzcGVu
ZCBzdGF0ZS4NCj4gDQo+IEZvciBjdXJyZW50IGRlc2lnbiwgZC0+d2FrZXVwX2VuIG9ubHkgY29u
dHJvbHMgd2hldGhlciBIVUIwMFs0XSBjYW4gYmUgc2V0DQo+IHRocm91Z2ggdXNiX2dhZGdldF9v
cHMud2FrZXVwKCkuDQo+IElmIHNvbWUgYXBwbGljYXRpb25zICh0YWtlIEtWTSBhcyBleGFtcGxl
KSB3YW50IHRvIHdha2V1cCBob3N0IGJ5IHNlbmRpbmcgYQ0KPiBwYWNrZXQsIGl0IHdvbid0IGdv
IHRocm91Z2ggc2JfZ2FkZ2V0X29wcy53YWtldXAoKS4NCj4gV2UgZW5hYmxlIEhVQjAwWzNdIHRv
IGZpeCB0aGlzIHByb2JsZW0uIEl0IHdvbid0IG92ZXJyaWRlIGFib3ZlIG1lbnRpb25lZA0KPiBi
ZWhhdmlvci4NCj4gSWYgaG9zdCBoYXMgZW5hYmxlZCB0aGUgVVNCX0RFVklDRV9SRU1PVEVfV0FL
RVVQIGZlYXR1cmUsIGl0IGhhcyAyIHdheXMNCj4gdG8gd2FrZXVwIGhvc3QuDQo+IDEuIHNldCBz
cnAgMSAoL3N5cy9kZXZpY2UvcGxhdGZvcm0veHh4eHh4eHh4L3VkYy94eHh4eHgvc3JwKQ0KPiAy
LiBlbXVsYXRlZCBkZXZpY2UgaGFzIGFjdGl2aXR5DQo+IElmIGhvc3QgaGFzIGRpc2FibGVkIHRo
ZSBVU0JfREVWSUNFX1JFTU9URV9XQUtFVVAgZmVhdHVyZSwgdGhlc2UgMiB3YXlzDQo+IHN0aWxs
IGNhbm5vdCB3YWtldXAgaG9zdCBldmVuIGlmIFVTQiBidXMgaXMgaW4gcmVzdW1lIHN0YXRlLg0K
PiBUaGFua3MNCj4gDQo+IC1OZWFsDQoNCkkgYWxzbyBoYXZlIGFub3RoZXIgc29sdXRpb24gd2hp
Y2ggeW91IG1pZ2h0IGJlIG1vcmUgYWNjZXB0YWJsZSB3aXRob3V0IGVuYWJsaW5nIEhVQjAwWzNd
Lg0KSSB0aGluayBJIHdpbGwgcmVzZW50IHRoaXMgcGF0Y2ggaWYgeW91IHByZWZlcnJlZC4NCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkLXZodWIvZXBuLmMgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2FzcGVlZC12aHViL2Vwbi5jDQppbmRleCA5OWIwYTEyZDRk
YzAuLjFlMGFjNzQyYzI5YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNw
ZWVkLXZodWIvZXBuLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkLXZodWIv
ZXBuLmMNCkBAIC00MDAsNiArNDAwLDExIEBAIHN0YXRpYyBpbnQgYXN0X3ZodWJfZXBuX3F1ZXVl
KHN0cnVjdCB1c2JfZXAqIHVfZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqdV9yZXEsDQogICAgICAg
IH0gZWxzZQ0KICAgICAgICAgICAgICAgIHVfcmVxLT5kbWEgPSAwOw0KDQorICAgICAgIGlmIChl
cC0+ZGV2LT53YWtldXBfZW4pIHsNCisgICAgICAgICAgICAgICBFUFZEQkcoZXAsICJXYWtldXAg
aG9zdCBmaXJzdFxuIik7DQorICAgICAgICAgICAgICAgYXN0X3ZodWJfaHViX3dha2VfYWxsKHZo
dWIpOw0KKyAgICAgICB9DQorDQogICAgICAgIEVQVkRCRyhlcCwgImVucXVldWUgcmVxIEAlcFxu
IiwgcmVxKTsNCiAgICAgICAgRVBWREJHKGVwLCAiIGw9JWQgZG1hPTB4JXggemVybz0lZCBub3No
b3J0PSVkIG5vaXJxPSVkIGlzX2luPSVkXG4iLA0KICAgICAgICAgICAgICAgdV9yZXEtPmxlbmd0
aCwgKHUzMil1X3JlcS0+ZG1hLCB1X3JlcS0+emVybywNCg0KVGhhbmtzDQoNCi1OZWFsDQo=
