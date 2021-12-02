Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDED465C69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhLBDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:08:17 -0500
Received: from mail-psaapc01on2115.outbound.protection.outlook.com ([40.107.255.115]:21248
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344901AbhLBDG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:06:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf2rhpDtmYQypUoyNEunC67GMpCyb+ROJAEryw3FGx0kZGZlgNC+imSfG6IDvszIFxoUfccdh6fIZ2vUfKQLOWBsnJsoD6gcQyWXcQ/itutS+pTDwYdMuHI4Ml8RIpSzGOtf5ze3snqD4nMb3Z0xnA0E/z+wupR3pah4FGdFuSkWzenoneAcznkoYvV0vEe40T91MffGkMj/7cBLa6lMMhzfSbNRS6xJe65uoq8yNXxdUj7AtEybumk+NzOTfH9Id6IN5cQAgMZ7TxZUm40JVDnmmyOfdeuu41vTV3OxGF7Y4JLwHjmvUyvdOyKCDAGLiHbqVwTxTh9NtI2ACMUrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fRWm75v8q5PTTdVJBVWZTd47xdBXlbN7j7gLo+F9Y4=;
 b=AssvdVqyLE3c27UFcTC7f8njzHaa5+BKyYCdehKdVHhOR8Gy2we4VJviREwG13NjjluRPaB93hKGYLwHZdBwx4A3CEk7ok9phFvU0/cU/KzINWMwCtxJfCTGIfGnyweMEkcrQQ7D8ZG1BdK0uZNKodwycR4/yI30WS4hRTU7r/lNDbfzJrxyzSBmDq8pzuhWXhk1fqb73KFajAAiLxmUwUu4ECszZ++FDL1mEKEERUDeSSaP4hYoFKqCUg3BtVhjYyIWZqqs1CxGyfoMg2fI8b4DsPfy/tEZMpVvmtsDqpdx6VKgwFY5xCc/T/da+waNUSV5x1UMcM2NcE0ija7nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fRWm75v8q5PTTdVJBVWZTd47xdBXlbN7j7gLo+F9Y4=;
 b=YVldis8zon0CHFK9bTTQEBuX1BdtQjc1O6Oj1uZpH79M8p/PH0Im5N+7rCgPASAHnc1UTkccM3QJzqMOYCa/Q8D7VBtioIVkPJVIdhJq/ufV02gLNeNKZALn8eBGftpggO8Vw2+RBZYKtf+HzOeEv3BNozf7mkSAqq8Qsqye/7ZK2hi4ByKl8ndxjcSSZ2IaQ4q0Sf5Xydp3Ylmbva2+HIiuaXq5pBf3LPvHxyRIf4XPfG+6NiNzOLKY8ZnDbNdUXNKT3keCBTTpiCEwDo7ft00kiZXRpxw3MwVArVT0y71cjKEnwqPnewdK09Oz2beoqxBXvKK+vgTIwm/XJBY1sw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2177.apcprd06.prod.outlook.com (2603:1096:203:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 03:03:27 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 03:03:27 +0000
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
Thread-Index: AQHX4rYwtTnSWbEdCEahHL8/1MfMn6wbMQYAgACjh+CAAOyZAIABuaVA
Date:   Thu, 2 Dec 2021 03:03:27 +0000
Message-ID: <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-3-neal_liu@aspeedtech.com>
         <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
         <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
In-Reply-To: <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e53edf1-0bf6-45c8-d6a4-08d9b5404fec
x-ms-traffictypediagnostic: HK0PR06MB2177:
x-microsoft-antispam-prvs: <HK0PR06MB2177A733703A0856CE9EB15980699@HK0PR06MB2177.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/LnAwa7rGKJXh1iNKA+n2KuHgwbkJGEgrZVAyR5UAk1WdrdFJ2jzmec2bPXx05/KhktimAkl/xqNgXwPH2Rx7Z1M0385hwD5fiowQGj2SagLMTcdFvwPfGQno1ZcKiK4ePuVOJvzEMQkod9oq5ernOn25pagUXZKe5sK8tF0RGp5DwWeI7sMkG22tdOBolEE9LpqrTbT1ZsghhdwEe8WEL1Xg7R3+/ABpm9SFvbhEYi2bWHoLLLjhbfMNrp8f0tY8ykitpksMVdAy+bA0SffqkUCCIHBkstLPft16usHUphO0E0DIX6DQzy0eZSrnur9mnWju1d5FhIu+o0IF3dblzypi4ChHE6XIxhOwPygyOufZMaOOdtNQYBVo54WRsm5b2pdEiLikkjjxZMWiO3BlPUhSEXmry/viYCNhEI0eo4qLZHnGnGiX7eyXoqXXYvkbJnSXqcy7DdxCV9wD5RdBQzppHxQOcXvr4sAqZ7+2mT90MUgVFDbX2Y69xcSXbj4T+oQ9KojZod+R3affVOKWNHff0gaLFkMzATMKocXN6CqQS5uNV2EQ7pIaCWL8rI8zZPBnH9qbcKVXurYpfWH++IViuw+CTz9OuJLbaNkyIJFiMec6AbqsZh+T/SIHmmRkzRIqjlD02hckCXM5sT5wd85lDFeqp1yEtk1Uo42ruqWqBdbWda/EX6S3BpuMbdHdXCgAWoOuISLZK1ZwBx1EiO6Y+jayB7MZkgb5OYPLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(366004)(376002)(346002)(26005)(66946007)(66556008)(2906002)(55016003)(9686003)(66476007)(64756008)(76116006)(7696005)(7416002)(508600001)(86362001)(83380400001)(53546011)(107886003)(52536014)(186003)(4326008)(316002)(4001150100001)(66446008)(6506007)(5660300002)(33656002)(921005)(8676002)(38070700005)(8936002)(110136005)(71200400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkd2aHh0dDcyNjZYQjFRN04xaDVWYkxWcWhGYmxvZ3FTejg0dUZBOElPV1lN?=
 =?utf-8?B?TTdnOHptaHcvRHVpd0t6M2ZsYjlFQ0FHL3h0MElFcExlZVFHbWlVQmk4TG1a?=
 =?utf-8?B?dmY4SExoQ3NkNHpFUlRRQWdoYXBsZ2svRFA2TDdXWmhKS3g0ZkhBQ0oyNklx?=
 =?utf-8?B?UlEzYVlDakZabG96b0JLdzRHaitBSkF6TndFejl0NXV6ME9MR1RidjZYb2lD?=
 =?utf-8?B?T3R0OXFwU08zQk5QeXU4RmtXWXBmY2hib3F0K3ZKSG9oTWZpTUgxR09UR29E?=
 =?utf-8?B?TjB0Qk5CWExOM0dEdWJubll5eGp6Z0V0bjlqVzJjSDFEUVBkMlI4WEdyVjVF?=
 =?utf-8?B?VjJGc0tnWWM3TXJSWEswT0h4YnA2ZDZXTnFGbW9kZVZ1cUtJN3BGc3l4UzBF?=
 =?utf-8?B?SnowaGtES2xJdSt6K3NWUnVuaGJ1U1lvVGg2Rk4yMXNTSGlBQ1BkZTZYQjBW?=
 =?utf-8?B?a2tvNmRpdFQrSFBZeGx5VnpTTjlBazk2c1NhV29XeW5vVTUzT2NDbTZmVTZW?=
 =?utf-8?B?MjM2VEhmRU11ZGdKKzVnV1dUVTg4VU5jRWJZVzBjbHQxaGY3UzhrRXJveWI5?=
 =?utf-8?B?SGZNY1pCMnFLUXo1T3BPZkVDemtBUjRtUy9IVEtSQmJtRVRNR0RadXNNemNX?=
 =?utf-8?B?dUk3T2dZOEtVeFRxM05RTTBvQVhYV1hoMUhwMjVMVUNYRTlOSmEwK2V5Z3ph?=
 =?utf-8?B?cTl5T0VEdnRXVkhXa2Y2RnFacUFQZSsyQ1dkR3EvQWwxMklFZEhjKzVLV0o1?=
 =?utf-8?B?RkFCSUZzbGxwVU0ybHJZYlh5Z3JnZkdRWXUxV0ZQN1JQY3ZiY1Q0cFhoekor?=
 =?utf-8?B?TDk2UkltL2hBTytCUzNycCtZME5qeGxJMDQxRFVTVzQwRElESnUxOGtnZnNZ?=
 =?utf-8?B?b2tIY3JHVHk5R1FjSG5wR0M2cGdFOGZGTGUwQ2xES3JwYk9hYVB4Y3FvY2JC?=
 =?utf-8?B?TmIycUVlVmlGZSs5UkJISjEzN1RIcDZUZkkyNEJ3MDhKNlhiUHZ5bVp3bUZ5?=
 =?utf-8?B?aGV3aE9oK2pkeGpsRlpCMTAweUt3ZlJjVjM0ZHBDa1VGdG5Yald5a0w4enJr?=
 =?utf-8?B?Z1hOeWNmUG9palJ6WmNYVXJOSHJiVmhXK1ZLbHZTYkl0YW5GTW9weEZtREFS?=
 =?utf-8?B?dTRLdlkyM3hYc0NRc21BU3Q5QzA2dkwyVG91aHhzc1JINnI3QmVlNkdZYlVN?=
 =?utf-8?B?T2E1Wk1Yc3JCUUU4eGt2SHA1OUVZZjRLRk00SHlJYllGaC94cFFpdHVBejVq?=
 =?utf-8?B?TG91SWxJcXFmOCs1NHBla3gzOTY2TGg4SlBtSTg2ajVjVnFweERQbnRlanBw?=
 =?utf-8?B?SDVvczhKOUFQNXpjZUphTzdXL2poZnZObWw1b2Y3TS9PQ1EzMFZtUHAwTis4?=
 =?utf-8?B?K1FzdkdmUzBxZTlKdnZ1VjdzUW1oODc5aFNOSFNjbUlNblNuQXJhZ2hXdjBn?=
 =?utf-8?B?dTJlWjFYSjhhdmRXTGxJNzRKYkRFT0tuRERxZlE3TWNjTFNWMTZ4QWZ4SkM1?=
 =?utf-8?B?eDIyWEVEZklNUTJISHNkbWJ3ZzhLTndzMUcxNUVkWFBNemdIRDhVcnV1TGR1?=
 =?utf-8?B?STNLaVFtdHJoUkJKeFVZMEFlTHVCS1JSTFVkOHE1WDYzeXRDNzhPQ2lNa1N2?=
 =?utf-8?B?QW80VDNHeXZiMkpCRWdsU3ovQ0Nha0hOMXRVZ1pERFM5SnZ3YWlQZU1Pek4w?=
 =?utf-8?B?Y05Oam1hUWpEUVhLaUNPdEJ5M3EvSWxzbS9BUnF3MWcwRUpwSGJHMXQ3amlu?=
 =?utf-8?B?aHZLZDgwZGpRL0dhM05tUXA3dU4ycHBvZ1BFYndXcFFKWTYvTUwyRzZHaUtz?=
 =?utf-8?B?ZmJDdkhOZTdhTHNsZUl4WU1neUsxcWY4aStOczBrbXNFZW8ybS9RRTNsTDJZ?=
 =?utf-8?B?Vm1MNjk1V0k2bXNZajkyV2JLK1VBMWVnWjZnNWdaL1kxcGt0N0lHcEdLQVMz?=
 =?utf-8?B?bWo1eW1vQVF6SXdzbURZUWpoQVRDTHhaQ3J4NkZDaTFqVEgrdzRlRnp6enY5?=
 =?utf-8?B?OUlRS1ZoVjlGZmMyUFhvUXlGK1pPWWpKQzBROHhpQ3dEeEk1VHVURFhDQjZv?=
 =?utf-8?B?RkNFOExlTUFDRHBKQStiUG1BWkxoQjJ2Und4bEVOeFFTbUllb0ZkMThNb1Fz?=
 =?utf-8?B?d1JlN1QwMXBFbmdwcmRPbnFKVlJHQWRLOE5KaEliU1JiYTFDS2xJQWxUb2R1?=
 =?utf-8?Q?80XRsp/79Hft+4A4NKzwuiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e53edf1-0bf6-45c8-d6a4-08d9b5404fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 03:03:27.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCc8lKQlCK38aPSEUA8rH5VqP/9tg/MngjjPCqa39AMT92+UsNH13t91iUSZS63pV5tWTDzSF1EvrX6q6Wnm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1i
ZXIgMSwgMjAyMSA3OjM4IEFNDQo+IFRvOiBOZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5j
b20+OyBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+Ow0KPiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGpt
cy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBDYWkgSHVvcWluZw0K
PiA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+OyBUYW8gUmVuIDxyZW50YW8uYnVwdEBnbWFpbC5jb20+
OyBKdWxpYSBMYXdhbGwNCj4gPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPjsgU2FzaGEgTGV2aW4NCj4gPHNhc2hhbEBrZXJuZWwub3JnPjsg
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlz
dHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gdXNiOiBhc3BlZWQtdmh1
Yjogc3VwcG9ydCByZW1vdGUgd2FrZXVwIGZlYXR1cmUNCj4gDQo+IE9uIFR1ZSwgMjAyMS0xMS0z
MCBhdCAwOTo0NyArMDAwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiBTaG91bGQgdGhpcyAgYmUg
Y29udHJvbGxlZCBieSBkLT53YWtldXBfZW4gPyBJRSwgd2UgaGF2ZSBhIGZlYXR1cmUNCj4gPiA+
IGZvciB0aGUgaG9zdCB0byBlbmFibGUvZGlzYWJsZSByZW1vdGUgd2FrZXVwLCBzaG91bGQgd2Ug
aG9ub3IgaXQgPw0KPiA+DQo+ID4gRm9yIEtWTSB1c2FnZSwgcmVtb3RlIGtleWJvYXJkIHBhY2tl
dCB3b3VsZCBiZSBzZW50IGlmIHVzZXIgd2FudHMgdG8gZG8NCj4gcmVtb3RlIHdha2V1cC4NCj4g
PiBJbiB0aGlzIGNhc2UsIGQtPndha2V1cF9lbiBpcyBub3QgdXNlZC4NCj4gPiBTZXQgVkhVQl9D
VFJMX0FVVE9fUkVNT1RFX1dBS0VVUCB0byBlbmFibGUgSFcgYXV0b21hdGljYWxseQ0KPiBzaWdu
YWxpbmcNCj4gPiB3YWtldXAgaWYgYW55IHBhY2tldCB3b3VsZCBiZSB0cmFuc2ZlcnJlZC4NCj4g
DQo+IFNvcnJ5LCBJIGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQgeW91ciBleHBsYW5hdGlvbiBoZXJl
Lg0KPiANCj4gTm9ybWFsbHksIGEgVVNCIGRldmljZSB3aWxsIGRvIHJlbW90ZSB3YWtldXAgaWYg
aXQncyBpbnN0cnVjdGVkIHRvIGRvIHNvIHZpYSB0aGUNCj4gYXBwcm9wcmlhdGUgZmVhdHVyZSBi
ZWluZyBzZXQsIHdoaWNoIGlzIHdoYXQgd2FrZXVwX2VuIHJlZmxlY3RzLiBJIGhhZG4ndA0KPiBv
cmlnaW5hbGx5IHBsdW1iZWQgaXQgaW4sIEkgZm9yZ290IHdoeSwgSSB0aGluayBzb21ldGhpbmcg
d2FzIGVpdGhlciBub3QgcHJvcGVybHkNCj4gZG9jdW1lbnRlZCBvciBub3Qgd29ya2luZyB3aGVu
IEkgd3JvdGUgdGhhdCBkcml2ZXIuDQo+IA0KPiBZb3Ugc2VlbSB0byB3YW50IHRvIG92ZXJyaWRl
IHRoZSBiZWhhdmlvdXIgYW5kIGFsd2F5cyBzZW5kIGEgcmVtb3RlIHdha2V1cA0KPiBwYWNrZXQg
bm8gbWF0dGVyIHdoYXQuIEkgYW0gbm90IHN1cmUgdGhpcyBpcyBkZXNpcmFibGUgZm9yIGFsbCB1
c2UgY2FzZXMsIGFuZA0KPiBtaWdodCBiZSBzb21ldGhpbmcgd2Ugd2FudCB0byBtYWtlIGNvbmZp
Z3VyYWJsZSwgbm8gPw0KPiANCj4gSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIHlvdXIgc2VudGVu
Y2UsIHlvdSBzZWVtIHRvIGltcGx5IHRoYXQgdGhlIG9ubHkgdXNlDQo+IGNhc2UgaGVyZSBpcyAi
S1ZNIiAoYXMgaW4gcmVtb3RlIFVTQiBvbiBhIHNlcnZlciBzeXN0ZW0pIHdoaWNoIEkgY2FuIHBy
b2JhYmx5DQo+IGFncmVlIHdpdGguLi4gbW9zdGx5Lg0KPiANCj4gQW5kIHlvdSBzYXkgaW4gdGhh
dCBjYXNlLCB3ZSBzaG91bGQgYWx3YXlzIGRvIHJlbW90ZSB3YWtldXAgd2hlbmV2ZXIgYW4NCj4g
ZW11bGF0ZWQgVVNCIGRldmljZSBoYXMgYW55IGFjdGl2aXR5IChrZXlib2FyZCBvciBvdGhlcndp
c2UpLCByZWdhcmRsZXNzIG9mDQo+IHdoZXRoZXIgdGhlIHNlcnZlciBoYXMgZW5hYmxlZCB0aGUg
ZmVhdHVyZSBvciBub3QuDQo+IA0KPiBBbSBJIGNvcnJlY3QgPyBXaGF0J3MgdGhlIHJhdGlvbmFs
ZSBoZXJlID8NCj4gDQo+IENoZWVycywNCj4gQmVuLg0KPiANCg0KTGV0J3MgbWUgZGVzY3JpYmUg
bW9yZSBkZXRhaWxzIGZvciBvdXIgaGFyZHdhcmUgYmVoYXZpb3IgYW5kIGhvcGUgeW91IHVuZGVy
c3RhbmQuDQoNCkhVQjAwWzNdOiBNQU5VQUxfUkVNT1RFX1dBS0VVUA0KSFVCMDBbNF06IEFVVE9f
UkVNT1RFX1dBS0VVUA0KDQpTZXQgSFVCMDBbM10gaW1wbGllcyBVU0IgZGV2aWNlIHdpbGwgZG8g
cmVtb3RlIHdha2V1cCBpZiBhbnkgd3JpdGUgY29tbWFuZCB0byB2aHViIHJlZ2lzdGVyLg0KU2V0
IEhVQjAwWzRdIGltcGxpZXMgVVNCIGRldmljZSB3aWxsIGRvIHJlbW90ZSB3YWtldXAuIEl0IGNh
biBvbmx5IGJlIHNldCBpbiBzdXNwZW5kIHN0YXRlLg0KDQpGb3IgY3VycmVudCBkZXNpZ24sIGQt
Pndha2V1cF9lbiBvbmx5IGNvbnRyb2xzIHdoZXRoZXIgSFVCMDBbNF0gY2FuIGJlIHNldCB0aHJv
dWdoIHVzYl9nYWRnZXRfb3BzLndha2V1cCgpLg0KSWYgc29tZSBhcHBsaWNhdGlvbnMgKHRha2Ug
S1ZNIGFzIGV4YW1wbGUpIHdhbnQgdG8gd2FrZXVwIGhvc3QgYnkgc2VuZGluZyBhIHBhY2tldCwg
aXQgd29uJ3QgZ28gdGhyb3VnaCBzYl9nYWRnZXRfb3BzLndha2V1cCgpLg0KV2UgZW5hYmxlIEhV
QjAwWzNdIHRvIGZpeCB0aGlzIHByb2JsZW0uIEl0IHdvbid0IG92ZXJyaWRlIGFib3ZlIG1lbnRp
b25lZCBiZWhhdmlvci4NCklmIGhvc3QgaGFzIGVuYWJsZWQgdGhlIFVTQl9ERVZJQ0VfUkVNT1RF
X1dBS0VVUCBmZWF0dXJlLCBpdCBoYXMgMiB3YXlzIHRvIHdha2V1cCBob3N0Lg0KMS4gc2V0IHNy
cCAxICgvc3lzL2RldmljZS9wbGF0Zm9ybS94eHh4eHh4eHgvdWRjL3h4eHh4eC9zcnApDQoyLiBl
bXVsYXRlZCBkZXZpY2UgaGFzIGFjdGl2aXR5DQpJZiBob3N0IGhhcyBkaXNhYmxlZCB0aGUgVVNC
X0RFVklDRV9SRU1PVEVfV0FLRVVQIGZlYXR1cmUsIHRoZXNlIDIgd2F5cyBzdGlsbCBjYW5ub3Qg
d2FrZXVwIGhvc3QgZXZlbiBpZiBVU0IgYnVzIGlzIGluIHJlc3VtZSBzdGF0ZS4NClRoYW5rcw0K
DQotTmVhbA0KDQo=
