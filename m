Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3E48A913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348799AbiAKIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:06:47 -0500
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com ([40.107.21.65]:8041
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235115AbiAKIGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:06:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+dw6MvOFYZq9eYrTYvTm7EpY3Oj/rDDh+uPO0HnDwHZg8VfYm2e2K1wmcBn9VMwTRF4Rj2N/yqKleY/ndXIoXVLXVR/zpSyHJWk3t39bTRfhA8cbvMv9yQvD3bzLfiIKpHyoLdbq3tWXLAv6ByGFCb9SRPbdASObuW536FcV7dH76aERq5y2GKJTzp+7yDNabch+ncQjqhUCwO8HIC3EZgCB9Fgi58g6lr+N+GwqgqW8/VB2xBHe7yweMGO0yWRv0lg1BtFRQyT6O2GwnPMN4UMRHj+Hfydvn0WEU+4kV3vAE9tijFA4+f/0Lw8FDGJ+ZBhvztxqPkOITB6L2vnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqxvE257vCNz8hl43LM07C355x/q+8vbo+2kK3yKNyI=;
 b=kstob6m1cvQxn1d3Z4gBsJDpPvb+THOqC8mdDgovKsQXjgFO0/RKPzWSeD7i2nnzVy6vXffXJFnvJ7TNgf1LELLmhm5MxQjdGDEHAcZKgazVwCmw3toudO0gSi8IwBqNmsBoOTfc0d4QaPy+rCsPW9WcHojnT1ZMvPmmNYyT521+Lb50ptfArlLc2oI2+LCpGppC6HC4KqDmBgAjtg2+iebdCFcHxemU7ZjGFd+BvP47MX8XdjbJdbq54ZoniwTouyz6uggbS0KIxS1dU5aXayWRUUGoGVnBgRS4NPxWI2/1tFnPnQCBe7PdAosNFg4+HajrbASCoAjXPJ+irq++8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqxvE257vCNz8hl43LM07C355x/q+8vbo+2kK3yKNyI=;
 b=YNBte9aY46xIGLHipnhyQ/aknRtYcLSsSPvAnFgaQx/VWJxdybOnuK2F+1OvqDn5L1bj/gVqLXkKJKAfyajtsnnxOHeeHOr5dsjQ9/n/XQQVQdFKBnk2eLvvXlvZsF7wrfHEhLQDTMgxsoCPMgyjpMfi0kNVyArcs7gAVdlLbwk=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB5847.eurprd04.prod.outlook.com (2603:10a6:20b:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:06:44 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:06:44 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: count tty buffer overruns
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: count tty buffer overruns
Thread-Index: AQHYBrI6anwXjwJa3E6WdFeuUzUorqxdZs8AgAAPrQA=
Date:   Tue, 11 Jan 2022 08:06:44 +0000
Message-ID: <AS8PR04MB8404CED84D435E191D42257292519@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220111061036.12638-1-sherry.sun@nxp.com>
 <e6315e6b-78a6-0a8b-c693-9797a4519bd4@kernel.org>
In-Reply-To: <e6315e6b-78a6-0a8b-c693-9797a4519bd4@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7332de5-889a-4b07-8233-08d9d4d94eac
x-ms-traffictypediagnostic: AM6PR04MB5847:EE_
x-microsoft-antispam-prvs: <AM6PR04MB584752F4BF482A2A09A8C38092519@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NqSxnJSWhMfQSVhGqWoR68pJc8HIdUiGdnc6Z/NBqge65upbL/RN2EjcTxf15UxXneK5sOITZsJkeUPP4e3u5XANgQFZ5bbNKBjkztTMI0mOo30f3R2novU06sgwdodCHO0fO9JKwDquZyeQcfWjBYJn9S95PqjmW7HM0sHTN4u/3cra4jlUPdMsiSe5VjCfUbrkpsN6LGsVVtsQHyBV2KCw+SVHMafFtEyozTXGW5UrsqJAQ6Ut91gfF6F0eUAYVGpTyln2nEkGZ9NhRF4HRozEuchJOvxZQCgAoKkU5HOZeGFWyGLFhEBPt78BQmFkDGOixEGKuuDMh1iMDgwa+cQhITLhtmmn6MvTsSsLXbDUEFKcSJPlq94c2ggUmQHrW7QipZVVZrHEakx4ArW5GOqKnJjMS/T+qFIIXs/wFdWlAS+MJTkqk3gbWzxHCnRri0Y3PMt8Q1kpt+Byvc56Jk+6ZGgW1fr+BlF9u7WNcf8+cfXg8sP6+HoLLzvwXhTNQ5qVwDlQb90GFOEpqXbNcxdwMapqZAP2tZaRs1Mh8cO400UyL/McSYxX+iJ5xttv6WrTvG2/To4CVHcpEkUneKoaS6n0DE7mcK5I+fPpCkbXOHweWR/5QrUT4uFRqaQgckyq6msxVh0lK8Wgic655hfB1t2sK/f/jNn7lLSfGygJ9r3ffyiTJVlrUF3N0N4XTNjyMerCdrbBqQ3unT8swQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(66946007)(8936002)(316002)(76116006)(508600001)(44832011)(86362001)(54906003)(71200400001)(38100700002)(55016003)(66476007)(66446008)(64756008)(66556008)(5660300002)(4326008)(8676002)(122000001)(110136005)(9686003)(33656002)(38070700005)(2906002)(83380400001)(52536014)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejJmdFlFQ0Nic2xGaTJXSHJTRjZSMU90ZXZScm05OFp4eXdLWkZWcWlnL0lk?=
 =?utf-8?B?MWYwZmtpdTd3eUhqU3JFU0lGYjg5TEd3cnpRZUVER2dvTG5EY2YzTE1JSTcr?=
 =?utf-8?B?WUx5R1VUS0tqWkVXL0hUZnlHN29RTThqTWZDdnVPcFJwY1orM2s0eXdlWlhG?=
 =?utf-8?B?bGVoSVREVFI2VUdxeVppQXFVdTYyWW1MV1cwTDc0WEpyMHRQWWpSTmxhYWZo?=
 =?utf-8?B?dUpCUjhVdUxCK2pNMnRrRTFtdlBpMVJkSkNNcEM3Zk5LN1R5VWFsd3I1ZTkr?=
 =?utf-8?B?OXdWdDJ0RmpsN1ZXUFFOR1R0WE5hSitxYWNJSUZqOG9XcHhrL2NVNmJEaFFx?=
 =?utf-8?B?V1lCdWZ4Q3RsTm93UVNxOXhWREFWa0Y2aWdETEl3b0ZucXJBQjBRL2FZNXdr?=
 =?utf-8?B?MUF6SU5vbnZpVjlYSGF0RjUxeWtlT0tEVWVvVjRNL3c4RmpJUU9vZEdFdmNY?=
 =?utf-8?B?NzFSTUxKaXZUSWROcktWZ0hHVEdhQkR6UmtCKzVBeVNZaFQrb21TY0cvd1FG?=
 =?utf-8?B?RXhzbDVvblBFNFZtWGRzRE5RdnV4ZmROOVdGUkhxZUhZWE9qVlJXR0pZbEta?=
 =?utf-8?B?bXRQK0J2T1FoQUQyU1BFclRLcmFGMFFPd0xYbFNFd0xmRzRaenFrVThlYmZk?=
 =?utf-8?B?ZEhZUHZlZGJOTW1pVUJFZlVsSzk4Y3FPeFBVOFptOVNzNGxyWkVZRzBlK0g2?=
 =?utf-8?B?REFJcEoxYUowQXhaUzAzbDRMdTE3QlQ2K2RLTXhZNDQydDVHbGtEZTBtOWJC?=
 =?utf-8?B?eUhkRHFRdFRTRWxMT285OG5ScTBGNzYzYVUydTFXcEZFdmpGUnNkRTdRUkZH?=
 =?utf-8?B?ZjdjMUFIRFFHRlkrWTVQYUk0bmVzQ2FJOGE0dmFMZU95ZlJtZzFmdVBMcDZo?=
 =?utf-8?B?V2poUXdrWCtpTnlxZklTT0pUY09MSW9qME5rcE1pa1Q2RXc1T3Y5Si8xdWxv?=
 =?utf-8?B?bDREb1p2L012VGV0R0FDUnBsMkhFSkJJblpDaVVRa242K2NSRDNEWVdtZTB6?=
 =?utf-8?B?N0pHcWNCMEFWWHhVL3NnUldZVTl5V0tvZ3I4dDBqV1BIWnJzRFcxQmhQT21W?=
 =?utf-8?B?SlNkdENId2tSRDRxeENxR3puQnlMUWpWenFCK1RlRHNaRHhaMEZFTmVxYWFJ?=
 =?utf-8?B?VHR6RWdHZFhjR3J5MkFuNk96RGRRRXhFS1ByYmx6VXU5ZjVScHlVRHR4a0Y4?=
 =?utf-8?B?QUtnK2phUDZYTnRGQ3RkM2NaaUtCSTRuelMwRkxTZ1RxeXhrVGZRSjltOXQ2?=
 =?utf-8?B?eFQ3SCs1YzYyRTQrRnVZdnlTSjl3dlU4ZnVmNjgzNHpyVW8vVWcxbzd1Q1Mx?=
 =?utf-8?B?SkVYK0ZkdGxXMGYweFRoZTVwT0g2UjREZys2c1BkTDl0YlowdTFGZ0IrWE1K?=
 =?utf-8?B?QVkyU0YvdG1GQ0pDdkRQdFJSbXJoc1YxU1BjT2U0UHRxTkluNnpWVThRYUwv?=
 =?utf-8?B?NGo5Z1k5Z2Zvd0c0V3JhbC9SQWVzMXlQZ1h1eUdmL015NHo2MEMvTVNLN2N4?=
 =?utf-8?B?Y2dBRldSd0dYY0cyQTVjMTZHQllHTEZ6ODJIYnduUHp5am51Y0FRckVuTW05?=
 =?utf-8?B?dU9BbGtCVlVYUERtSUZQNlJqSFQ4dnhZYTEzNXlxbUZzakVmbmlkN1BmbFlD?=
 =?utf-8?B?SmNwRy9hWUFJYVI1cUtReFhNcSt6MlB1T3RpUFZseFhQUU9LT0xiZHlzNVVQ?=
 =?utf-8?B?N0M0Z0tlWVMrN0hGTjFEa0FRYng4Slc1cC9uOTZxaTVEWmNHbERxaCs5S1pR?=
 =?utf-8?B?MThCY1Z1bStrT3FYcW1zcUoySW42bXd4SXJDMDgzWndXd1BrQXphUFB1c3V3?=
 =?utf-8?B?RnFtZFlUZmF0TlFrcnNwMVFJNTF3NGljSHZQYWZFbHA2UE9iK3FINjJRVGQx?=
 =?utf-8?B?aHI5RnQzSHZuWk5EanlvVXViU29RaUt0ZFBjblhtcUZkY3JpVVppU0V2b1lR?=
 =?utf-8?B?dXJHNzJUbDkvcTVqWGhBL0YwbkN5cXZQcnBKNGhIeXRFRWtDSThBUjAyMER3?=
 =?utf-8?B?M2cwOGNCZlJVcXRtSTF4TkRQZGJTbkFMTjdyY094dEoyVElvcU1mWHhJQVhu?=
 =?utf-8?B?QStvSDhEUGdwb2J5aktzUnhxNWZKRWJKTzl0b3M3NTg5amhHRHZPclp6WU4r?=
 =?utf-8?B?YWZGSGVzcyt3UnRxZEV6NWM4czZZZ0F1NHRteFV5Ui95MUhVMFhkckJWOFZS?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7332de5-889a-4b07-8233-08d9d4d94eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 08:06:44.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoYh/lYVasBxKJFGQILM9GMFDM/Acjkf+2+jMomEc32oHLFUBuDKIC/F28/lw42X0oWGiH9KwH80OZdfXV+WhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlyaSwNCg0KDQo+ID4gQWRkZWQgc3VwcG9ydCBmb3IgY291bnRpbmcgdGhlIHR0eSBidWZm
ZXIgb3ZlcnJ1bnMgaW4gZnNsX2xwdWFydA0KPiA+IGRyaXZlciBsaWtlIG90aGVyIHVhcnQgZHJp
dmVycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5Abnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCAx
OSArKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5j
IGluZGV4IGNlM2UyNjE0NDY4OS4uMWU2ZjkyNGQ4NTA3DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9mc2xfbHB1YXJ0LmMNCj4gLi4uDQo+ID4gQEAgLTExMTcsNiArMTExOSw3IEBAIHN0YXRp
YyB2b2lkIGxwdWFydF9jb3B5X3J4X3RvX3R0eShzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNwb3J0
KQ0KPiA+ICAgCXN0cnVjdCBjaXJjX2J1ZiAqcmluZyA9ICZzcG9ydC0+cnhfcmluZzsNCj4gPiAg
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAgCWludCBjb3VudCA9IDA7DQo+ID4gKwl1bnNp
Z25lZCBpbnQgY29waWVkID0gMDsNCj4gPg0KPiA+ICAgCWlmIChscHVhcnRfaXNfMzIoc3BvcnQp
KSB7DQo+ID4gICAJCXVuc2lnbmVkIGxvbmcgc3IgPSBscHVhcnQzMl9yZWFkKCZzcG9ydC0+cG9y
dCwgVUFSVFNUQVQpOw0KPiBAQA0KPiA+IC0xMjE4LDIwICsxMjIxLDI0IEBAIHN0YXRpYyB2b2lk
IGxwdWFydF9jb3B5X3J4X3RvX3R0eShzdHJ1Y3QgbHB1YXJ0X3BvcnQNCj4gKnNwb3J0KQ0KPiA+
ICAgCWlmIChyaW5nLT5oZWFkIDwgcmluZy0+dGFpbCkgew0KPiA+ICAgCQljb3VudCA9IHNwb3J0
LT5yeF9zZ2wubGVuZ3RoIC0gcmluZy0+dGFpbDsNCj4gPg0KPiA+IC0JCXR0eV9pbnNlcnRfZmxp
cF9zdHJpbmcocG9ydCwgcmluZy0+YnVmICsgcmluZy0+dGFpbCwgY291bnQpOw0KPiA+ICsJCWNv
cGllZCA9IHR0eV9pbnNlcnRfZmxpcF9zdHJpbmcocG9ydCwgcmluZy0+YnVmICsgcmluZy0+dGFp
bCwNCj4gY291bnQpOw0KPiA+ICsJCWlmIChjb3BpZWQgIT0gY291bnQpDQo+IA0KPiBPdmVyYWxs
IGxvb2tzIGdvb2QsIGV4Y2VwdCB0dHlfaW5zZXJ0X2ZsaXBfc3RyaW5nIHJldHVybnMgYW4gaW50
IGFuZCBjb3VudCBpcw0KPiBhbHNvIGFuIGludC4gV291bGRuJ3QgaXQgYmUgbW9yZSBjb25zaXN0
ZW50IHRvIGRlY2xhcmUgY29waWVkIGFzIGludCB0b28/IFRoaXMNCj4gY29tcGFyaXNvbiB3b3Vs
ZCBiZSB3aXRob3V0IGltcGxpY2l0IGNvbnZlcnNpb24gdGhlbi4NCg0KU3VyZSwgdGhhdCdzIHJl
YXNvbmFibGUsIEkgd2lsbCBjaGFuZ2UgaXQgdG8gaW50IHR5cGUgaW4gdGhlIFYyIHBhdGNoLiBU
aGFua3MhDQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQo=
