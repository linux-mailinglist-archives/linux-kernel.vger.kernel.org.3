Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13A57DF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiGVJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiGVJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:45:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D72B5CBF;
        Fri, 22 Jul 2022 02:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHlRP9cGS5dpv+ZrgZjmjIyJ2BlXaPDccnFq8oZ2s4z8HbcYi7e0cU4rnQRq/x+CQeB4cJIp3tqERs+QnwsP/VlEOMBGl7Sv8POokySGFHwiDdIcRMhx/t5JdIq5hXzAjEi0cNHSsIXVbxlaUpE814ccqWkl5gPZQU0IJ7+tPDyOv2Rmwo+J6iuwNQfcvH582HqQm2t+3InnA+jhSowomCOQ0m8gRfDEqamrZDCekDB6vRMvus624J5nPSszu9ej+sE2EO/45upM/78tiiBLr34m8HAhchYOveIyDlrZieW2vh/kFpXN/3bRRHMJV2jKxDDa4lVnuCy/N13SQXorZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f/kJvQgpgWk3ONDq1dSvvqiWwuhv8rC99LcioHPGxU=;
 b=XfMvC8noUaGN8emuNXGwPVrQdjtFvkx/q0qt8jcITwgNpJWQKm081W/uRHF4PuJyS9DsZWcLApr9ZgCsWu/P7QIqhhiRU9nJn2nQ5nbkuZlsA2+yPFMwNTb/vKQUC5xNaQ98A4oe23z3TOH9917klMwDXoTJTWDcmwYNiCMENzhadom2XpzOWGNdkvX2vKmxSbeDuyltR3V46geXoqgwgjeZRz1exvm6bpISBfklmxdSAheDv5YfXMFRpfbtZNVGIlj/zdVtbsL404Hqbzz6pDGUrtldWEmnt80oX/G22AeKyHarllIPIo3qAbI1AGQrXBWVRL7vbjbbhiVjWGR9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f/kJvQgpgWk3ONDq1dSvvqiWwuhv8rC99LcioHPGxU=;
 b=ra/z9uZ2QK8QWNujxjeN/SBV2gKIwsIQgPIFmmrjFICbQIPpyxYSNkPJDKFx7A/j85rX3rJDNxbrauvgIAzQtGPqgkhb5+Lt/tb6rSIZvMMu+JCkmuL+N8cbeRqkpPPzboUDQUwbzhmFGRfMlkIZSbFDAee6du37k5YQ3p2jooQ=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 09:41:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::4c81:58fd:464d:3160]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::4c81:58fd:464d:3160%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 09:41:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>, Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
Thread-Index: AQHYl/cqr4tzMlicFUS5QAVEdKaVoa1+/W8AgAAE7pCAAAp2gIAAEHKQgAA1fYCABGXngIAGcv+w
Date:   Fri, 22 Jul 2022 09:41:08 +0000
Message-ID: <AS8PR04MB8404736D9C87D7C590C34A6692909@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
 <509669b26b5899088e9b77ed94d103ee@walle.cc>
 <AS8PR04MB840448675E64E4FCDEEF91A1928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <e2560f01fd1731ea2422d82c97efcc6f@walle.cc>
 <AS8PR04MB8404B8E3EB0FFCEE8ADDA283928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <61c525fc87d6586c024cd6e42fcf876d@walle.cc>
 <d75d1339-4539-330a-680b-2d940e603a72@kernel.org>
In-Reply-To: <d75d1339-4539-330a-680b-2d940e603a72@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d54983-eee2-4223-9c69-08da6bc64e74
x-ms-traffictypediagnostic: PR3PR04MB7210:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMVFGFSzsoRKR+1uR/yToDRjFuabibuN5IFqlz0QF3ST6eJS50wlrTqm/8ZtTjWajynXrH1n/1oJItnw2iSjCwT6xMwQNQ25GVZKr9vAR5nOREglmzDgiI/n66F6v8lQyPFv7f8hMhYPhTk9EbXu4hcl0zMpG5bgWspwThupBV7qfKSkJRwR1pcmPUR3fAs6vdXXJrRcvNCBXFH6J22WfZUirLrLq4skww5DeSGDnukMvEtVJsJsJKtVPj//sNj9WV1BQ/X6ZiTss0QhjwQ8UkYExuv9AQtBKAysqFkMDr4zhgncojiaKXwIYXyGfFifqwELyInbBKwI0HupesGuZ8OfaA0+XkLFzZ2tKrW2dO2W7ZLouQzQnIqwwhA4YYhydKwrTPlF3CGW+8Kh9kuMRlN2U5FOE9cfVxOJ+Yb6aka/DCbE2YM+bdhEr3cujyQOSCGIOqSVdoiLCROJ7Qp0+UvyWEatsWVG89EdB9xB9efdOH24H0VpCAkiEE/QUitoNlMTNb9rilCqos2luyERsdpr6V0GkidXO9tF/v7W9gqWJ3+vM4upY5wnA8U73fwn451RdMd9/6rp+yZ+EMDBQaMyHtnHmuNoPe2u4eBGyJbpCyPl5TsseMBGKLWVfpyhgP971Z/w43YFpqs//chou7p99iJ0M8FxopgZG08Ddt4d2jv4wOPHFDYjhiyLW7WmpHkaGbHFzroIll4UQwc7fNaT0/lLQ6wvTrz2eSSe6LvXrseplXlPYQFyiLvC3Cpzv97Ij+KVarvXlNNEV98r7uSdQvNYZV+/tRMUI599zDDTZkc9cynzdSqnk8LyPxCu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(52536014)(44832011)(38070700005)(5660300002)(8936002)(122000001)(38100700002)(110136005)(54906003)(9686003)(7696005)(71200400001)(26005)(316002)(41300700001)(55016003)(6506007)(66556008)(66946007)(66446008)(83380400001)(76116006)(66476007)(186003)(64756008)(33656002)(2906002)(8676002)(86362001)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZ6eHpMNFhtWnI0ajV3VzBPc05BZWkyd1h2aEp3ZDFjNlcxTjlUSVhhS05a?=
 =?utf-8?B?cGVOOXVpOTFXSVpsRERqK2ZrbDhCeDBndG5JRDJ5UFl1VlE4SGJYNG5Wb0pS?=
 =?utf-8?B?WHQ1Skg1ZnJGQ3JwdjBVZ3JaeU1TR0t6ZkRxNHV2Z1pPeHR6N05BWk9jUjh3?=
 =?utf-8?B?dTRsb3RyRkl5eExGaEtydi9uVnBqVUpqSjJqb0FycW54Mm01cXBKVC9pVDFp?=
 =?utf-8?B?R0ZHYXlGY2dHam9TZmwvUW9SaG5KbEFOdldJZEZkSys4VkZTL09oUWk3NitN?=
 =?utf-8?B?SlNqSkZHeVBBRFk2bG01akRGTnRYUGNqVW96VVcxdlBRNnJGR25YNktud3hN?=
 =?utf-8?B?b1ZkRERsVURzT2ZyeTdVNFQwM2lvSWNxUWdXcXlVZ25nYStzamI3ZStsNHhH?=
 =?utf-8?B?U2RZOWRrbngxQmtWUVBHNDRqaGh5QVRMZG5oVmQvRGNrU3FiUmpRSWIzVzBi?=
 =?utf-8?B?R1g2NFFGSFUzbm5rZ3VuM0hKNHFWcjFaMHV1Umx4NGxJall1NWdpTEdTRjYv?=
 =?utf-8?B?RlFpaVowcWdBbzA4ZEhKYURyb2ZJWWJGVzRqUlpaYlFkNG1HUllJZzJ5Y2RZ?=
 =?utf-8?B?blVEUmV4ekRzcmUxRUx3VmxQdkhPWEg1UGd6M1BQemxtc1RLazcvQVBZNmNJ?=
 =?utf-8?B?VFF1a0JSMDcyWk0yRWVIbXE2TW8zNWtWTnhmVExpUDdOcWo3eVVvYjQ4dVFP?=
 =?utf-8?B?M3FNaHVXd2ZENDNlZzk5YmVlcjdEZEhJOERCV2NBNGNXemZRTUtnc3JmazBM?=
 =?utf-8?B?ZFpleFFYUGRYaERQZ2JTSTdKZjZhN1ROeFFPSTNVdTBsN0srZ0srdG4vNTlp?=
 =?utf-8?B?WjYvNENGWmpFTERkREFlL0thQUV3eVhJakl3NjBWUTJZMmJFczQ0ZHJxM0RM?=
 =?utf-8?B?dEowMVNnb1Q1Nys3Q0FST0V5cnFwdlZaZlFtSVd4Y21PLzdDZnFpVlBiWHVV?=
 =?utf-8?B?dVp5U2ZpTFU1NzcrbCtkeWdQTDFTaFJBY3dXL0E0YlM4RmJ4Y1BxZlNEZzAx?=
 =?utf-8?B?U2E0MGk1UlZWRHdzMVlLeDJBWVl1RnVZQ04vdm9rREpnZjQ5ZXlBWm1wL2RU?=
 =?utf-8?B?YmRRQjBDajcyUEdsNjh3Qko3L05MMjFJQUNqZU9PUFJlYXZQVzZvUXlzd0JE?=
 =?utf-8?B?VHVWS0paVXEzOG5xYVA3dXBVcjc5bm9UdWV2N2NWL0x1Umw4d05tbXdsclEr?=
 =?utf-8?B?RnJpZ3JYSnQyOVc3RWtzNTRObWV3R0dBYW03SHp0RkJ1MjBJTlN3VWJXRnBh?=
 =?utf-8?B?VnNwczNQZjJERnRKSnlMc0ljOEVRdElISkcvVzZKV2NwL0lOQm1OQ21SV1Rw?=
 =?utf-8?B?WE1BdEZ4WUdZWWEvRGsrejdUaHZzOUd0RW81MVRzN21YS3NPUUtIZzhrWHdK?=
 =?utf-8?B?ODhjNFowUXlJUTVZVXF4cndFNW5sSkRybzdUaWxQZ213amZaUWhnNEdSTjQv?=
 =?utf-8?B?dHQvQldNSmhZNlZob2dRdm1iM1ZuZ210empWR2FQT3FsMG0ySlBaaWdWL1J2?=
 =?utf-8?B?UmhmeE40MEJQNmRCdytnaE5jRlFYUnRYMHgwWXA1eWtoWjQ4QjVpN0h3RkRv?=
 =?utf-8?B?TDVWYTRHQ204V281Qm5iV3ZrRnNjdUV1K01RMGRZcjliemkzTzFDcjVtOTVa?=
 =?utf-8?B?VWpMN2dFejhyTjBDUk92dzBhalAwWmxKWUJGOVV3dXNCNXN0U3FGcVV1Ymk4?=
 =?utf-8?B?UitIR0tXcHhwdmVQQm1XYkxIZ0N3MXZHdmNQTEw2VytUN002d0grelhaUHJ2?=
 =?utf-8?B?ZWZQWlBjRXNWeHRlQnpySktQU0JDOTRJZG1DYllXWmxxVm50RDBZdll3OWxR?=
 =?utf-8?B?UUJvNmNEamhWWHNHTGw0VGVFV0JBY0VpL3NkMWx4d1RBNXBiQ2o0RXl3aHpB?=
 =?utf-8?B?U29wbTN4cVo0V0JtU0FwWFBWU0FheDdSWE1iZVZqNEZ4UmZQOW5SNUZ0VFov?=
 =?utf-8?B?MjExRmNxS3N3SkkxbmdOSUdySUQrblZOWWVSQ2tWY01KUGh5M0hKbzRZdVl1?=
 =?utf-8?B?T0hFRVcwcGFDR2JENmdsaVFCbFJZWk85SVV2Rit6MEpUU0hyaEEvRzEvUE4r?=
 =?utf-8?B?eFQ1SUYvdVhEODNIRE9HaklwV0RCTUFaTEZOdlFvMVdUTzRjeTBGQ1dOb3RD?=
 =?utf-8?Q?pbtHSl1FbpiF9q+4eLAcHX1V8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d54983-eee2-4223-9c69-08da6bc64e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 09:41:09.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPro4ur1ii05DGqOMkcMqbsI5KEgGxdOVO5dEQaPBPQj/CHjwpTe/GUF7yOukP4UI8502D3qbiQK3tEkS5O8Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxNS4gMDcuIDIyLCAxMzo1MiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gPj4gU2VlbXMg
d2UgaGF2ZSB0aGUgZGlmZmVyZW50IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGJyZWFrX2N0bChwb3J0
LGN0bCkNCj4gPj4gY2FsbGJhY2suIFRoZSBvcmlnaW5hbCBicmVha19jdGwodHR5LC0xKSBpbiBs
cHVhcnQgd2lsbCBub3Qgc2VuZCB0aGUNCj4gPj4gYnJlYWsgc2lnbmFsIHVudGlsIHdlIGNhbGwg
YnJlYWtfY3RsKHR0eSwwKS4NCj4gPg0KPiA+IFRoYXQgaXMgbm90IGNvcnJlY3QuIFRoZSBUWCBs
aW51ZSBnb2VzIGxvdyBhcyBzb29uIGFzIHRoZSBTQksgYml0IGlzDQo+ID4gc2V0LiBTZWUgYmVs
b3cuDQo+IA0KPiBJbiB0aGF0IGNhc2XigKYNCj4gDQo+ID4+IFBlciBteSB1bmRlcnN0YW5kaW5n
IG9mDQo+ID4+ICJJZiBjdGwgaXMgbm9uemVybywgdGhlIGJyZWFrIHNpZ25hbCBzaG91bGQgYmUg
dHJhbnNtaXR0ZWQiLCBjYWxsDQo+ID4+IGJyZWFrX2N0bCh0dHksLTEpIGlzIGVub3VnaCB0aGUg
c2VuZCBvbmUgYnJlYWsgc2lnbmFsLCBub3cgbXkgcGF0Y2gNCj4gPj4gbWFrZXMgdGhlIGJlaGF2
aW9yIGFsaWduIHdpdGggbXkgdW5kZXJzdGFuZGluZy4NCj4gPg0KPiA+IEFzIEkgc2FpZCwgR3Jl
ZyBzaG91bGQgY2xhcmlmeSBoZXJlLg0KPiA+DQo+ID4gSW4gYW55IGNhc2UsIEkndmUgY2hlY2tl
ZCB0aGUgaGFyZHdhcmUgKExTMTAyOEEpIGFuZCBhcyBzb29uIGFzIHlvdQ0KPiA+IHNldCB0aGUg
U0JLIGJpdCwgdGhlIFRYIGxpbmUgZ29lcyBsb3cgKFRUTCBsZXZlbHMpIGFzIGV4cGVjdGVkLiBJ
dA0KPiA+IHdpbGwgZ28gdG8gaGlnaCBhZ2FpbiBhcyBzb29uIGFzIHlvdSBjbGVhciB0aGUgYml0
IGFnYWluLg0KPiA+DQo+ID4gU28gdG8gbWUgaXQgc2VlbXMgdGhlcmUgaXMgbm90aGluZyB3cm9u
ZyBoZXJlLiBBbHNvIGhhdmUgYSBsb29rIGF0IG1hbg0KPiA+IGlvY3RsX3R0eToNCj4gPg0KPiA+
ICDCoMKgwqDCoMKgwqAgVElPQ1NCUksNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
VHVybiBicmVhayBvbiwgdGhhdCBpcywgc3RhcnQgc2VuZGluZyB6ZXJvIGJpdHMuDQo+ID4NCj4g
PiAgwqDCoMKgwqDCoMKgIFRJT0NDQlJLDQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFR1cm4gYnJlYWsgb2ZmLCB0aGF0IGlzLCBzdG9wIHNlbmRpbmcgemVybyBiaXRzLg0KPiA+DQo+
ID4gU28gdG8gc2VuZCBvbmUgYnJlYWsgImNoYXJhY3RlciIsIHlvdSBuZWVkIHRvIGRvIGlvY3Rs
KFRJT0NTQlJLKQ0KPiA+IGZvbGxvd2VkIGJ5IGFuIGlvY3RsKFRJT0NDQlJLKS4NCj4gDQo+IOKA
piB5b3UncmUgcmlnaHQuDQoNCkhpIEppcmkgYW5kIE1pY2hhZWwsDQoNClBlciB0aGUgdW5kZXJz
dGFuZGluZyBvZiB0aGUgaW9jdGwgYmVoYXZpb3IgaGVyZSwgZG9lcyB0aGF0IG1lYW4gdGhlIHVh
cnQgb3BzIGJyZWFrX2N0bChwb3J0LGN0bCkgYWxzbyBwZXJmb3JtIHRoZSBzYW1lIGJlaGF2aW9y
IHdpdGggaW9jdGxfdHR5Pw0KYnJlYWtfY3RsKHBvcnQsLTEpIHdpbGwgdHVybiB0aGUgYnJlYWsg
b24sIHdoaWNoIG1heSBrZWVwIFRYIGxpbmUgbG93IHVudGlsIHdlIGNhbGwgYnJlYWtfY3RsKHBv
cnQsMCkgdG8gdHVybiBicmVhayBvZmYsIHdoaWNoIG1heSByYWlzZSB0aGUgVFggbGluZSwgcmln
aHQ/DQoNCklmIHRoaXMgaXMgdGhlIGNvcnJlY3QgdW5kZXJzdGFuZGluZyBvZiBicmVha19jdGwo
cG9ydCxjdGwpLCB0aGVuIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2gsIHNpbmNlIG15IHBhdGNoIGhl
cmUgY2F1c2UgdGhlIFRYIGxpbmUgb25seSBzZW5kIG9uZSBicmVhayBzaWduYWwoOSB0byAxMyBi
aXRzLCBvciAxMiB0byAxNSBiaXRzIGlmIFNUQVRbQlJLMTNdIGlzIHNldCkuIFRoYW5rcyENCg0K
QmVzdCByZWdhcmRzDQpTaGVycnkNCj4gDQo+IHJlZ2FyZHMsDQo+IC0tDQo+IGpzDQo=
