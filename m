Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5306F47A39F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhLTCXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:23:07 -0500
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:50185
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230024AbhLTCXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:23:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu0JMIUeQNLMK5nG9ms9YVe1Sn+geiD3vrdbD4y2M32LrqODIid5o60gmQzABe2n65dEgE929i5kz13r8GgaDQEE+O3ncKzvq/N3+XBZ9ecSwYosDndvXEf6kxygupr7hVmHSXfA/g2gh5CvajpKObA7zYd6IDScklJZZKSH8Y6sdwLVqPoar6aA/U73dUOv192x9xSQaa7N14GzCpyjNFfbfq+0y76VnOYayS/RVPMPvUaY5+Xnw/CrlOvkQWY6UkWck7BtZj7J9aIQnzhflTQNcU5h7G72HdylZ3du3HFzNDU2D4wOyzE4PKnRhDRcS074SZN5rIrwAPs+fSRNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEE7IPjuN338r4JRiRt5sCd2AmEJ7aW4Q4ACK0xC/FA=;
 b=chzT/+qKtUoKtsNtqTqEIh6VB0Q2T9sAMjhfoMYh9Qu1NjrGqoK7T/GC1lwP/6iebQO+sTGTud2YYeLZqYqCON86hp6wLylnNbfXN6pKRfip1fjsMhsWQQz0ts/feYyXYk+rFgrIMdrmhcSbUpapA5TE/0Lt7izy8qq5E+ZAYu7vMt5getsXMx+kGjwzhprOWLJciBhMdN8rrExCg91KhbUQXv9v44jVJ4GNqre1Y7du1oxpYjcnVAqAA6eQV+pFVgu6oMmEj8CKUPx/4jBBDjXSRdRIdbGskc3hQEZSe6rct37xwn7fkKEUh2uxVSuSIIy0+N3dwRL5BOkfIJR0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEE7IPjuN338r4JRiRt5sCd2AmEJ7aW4Q4ACK0xC/FA=;
 b=DKgNMaQL/X8n4JjtClOuYUo1qxjCm47OESCGMOpIhqqFoHf829NT44hu/oEpbMhd1lZdH1ayYJbsvB/bYAId94YAIh/O2WX1ADJyTVIOcfNLpVwOJoNcIMbrbX6+VBGtlFFrzh6t91rjdciTHNC4rfY5JX9U6nJR+iDYPboutd225q2kxa/mn08X/7/eRzuWUX9UPy8Rl002Bym6FZV+0cCpMEpG/7wDRUNBcZMm3FTeXWY6plYlVCbLm50m9a+cfSDmquP9pEshutZjI0bbBZiI6h4lo5oRW8bKVatUd1zUyknA/JLBdEdhdF2CB5WYlSM2gjqeHbkjRCKH5Jl1FQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK2PR06MB3475.apcprd06.prod.outlook.com (2603:1096:202:32::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 02:22:50 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 02:22:50 +0000
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
Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Topic: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Index: AQHX7BszI/63d6+3yEiIx/+xfvXqSKwpSLsAgAAkTICAB+FNgIAJaO9g
Date:   Mon, 20 Dec 2021 02:22:50 +0000
Message-ID: <HK0PR06MB3202051E7C15E84006DF55C0807B9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-3-neal_liu@aspeedtech.com>
         <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
         <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
In-Reply-To: <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 309f5d13-2c8c-445c-330e-08d9c35f9f11
x-ms-traffictypediagnostic: HK2PR06MB3475:EE_
x-microsoft-antispam-prvs: <HK2PR06MB34751DD0D6ECC9BE69B48694807B9@HK2PR06MB3475.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CzKSmqHBfvWbP/Z97LJ2SSpnVfBWgu+M7Ii46i9ZOoiwRC7XgY8AXTptc6wF0zmWCbh8CQtZ/ENdajDfaHZjLXPKjW8yeaA0KNMb+hwn/shzzLY+yrohVVWbuKS7qPCsYwOC99Byikj8gVHG1PP91ceOxlZIymoum5UB/kze70MHflMbr/qs10eSK8d33XD05thHdElGwQfaf6ea8giP3L+tuEWCB0d8582SHAxJcExdpDF/4UObuHux/DDbDYrzjB5FxB885qcgVum+Mr4SYJxYQm6M03tJ9V0npTa179HFe7cPDsOFR/pn5Dq7MsjK3XkQOk7tVYMD4aykAFlFRamUZ8A9dgvSvCnUkx1SVbKBSivGeXCM5QZIPbLxcbSIA5FPalvFz067J7RQqRC8o9qkaugZoTwvlpH9Wg/6dmHrVe6DJ5nNcOPyS+JWUOqNQxS4rTQc4/5+VI2wphtV5Y5Vxho+WObUmom5qCzyayktA+E8r+aqj/KMLzVH2r0wZCqkLnrEbR1cvttpYpQkQ7L68BdvPuaqpHvbUiBekiczIJWmh9jzTfJRhBSilXe8oVf4Z+N9uGSzDMRFs25jvhrj7hFnv8ZP+u7tvoecHhFbOaVkYHTFc9htVaPkCGVpm8ADdPP4dNR4unN5LeG/1yN5JtCHmhIT9qTfEETlDP2MuOMbKt7GL9eY6a3Hx23Kyjdx+rH9Mvp1P5Uo+xEIbv26edan+MAxdHOCFdhYdU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39840400004)(346002)(33656002)(122000001)(38100700002)(38070700005)(83380400001)(76116006)(921005)(55016003)(66556008)(64756008)(66946007)(66476007)(66446008)(86362001)(316002)(107886003)(9686003)(508600001)(6506007)(26005)(53546011)(52536014)(186003)(4326008)(7416002)(8676002)(5660300002)(8936002)(71200400001)(7696005)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5qUzlDYUZRbUdkOGtzUFB6VlFTcmRETVMxOUR3aGQ3RkcwSjdqSmZEcDQ5?=
 =?utf-8?B?L0JneU9jZHBraGR5UTM3NFRiYVFoMlBtRjh0d1REdm91VkgrYTdGQlNPVVQ0?=
 =?utf-8?B?TUlLdzRrb3puMytNWm5hYk9nMXQ1K1cva1NJZ2pUME1qWGpvVkxJY0l2T3dE?=
 =?utf-8?B?MDR6M2t1ZnhjU1NZNlJaMThZckx5YmRrZVVoTm5iaFB0aU5TS0VZY01EaGd4?=
 =?utf-8?B?c2JZbXlJbVdURnpJaWdFS2FXZlJlQURPeW5wdmZkWFYwVlV4bCs2SGFORVFO?=
 =?utf-8?B?Zm0zdW1iK2FHZ053OEora1M4cGVrNllZSTUyenBTVXhHOVdRTitoenFhVkdI?=
 =?utf-8?B?ZWRGZUlDemEzbXpKaTBuWWNFMEVxTkoyMzdXZzlPRmtVaGlFeWw4b3k5Nk1P?=
 =?utf-8?B?UDB4cTA5ckR2aW9xZStrRDBZYk9maGV2QkpScXRnWVNieElhRmRKRUQ5UERW?=
 =?utf-8?B?ZytTYWp1MGxZbCtCOXIwaW1JYXYyS2E1cUkvRUk1OExUWWpxSDdIT0RvMGdL?=
 =?utf-8?B?eHJlbHZzVmd0LzZtb2VkV0JvR25icGRJSmpxL2MwMFlFT29qSWV2eUFaT1Ux?=
 =?utf-8?B?eGMyeDVQMDFaSnBlVWdHSUxWTEdxM2hwZnFJWmtVaE9qMHVUTmhpUnZKSStF?=
 =?utf-8?B?Snc3RDdlbUxRb3ZPUHZ5OHE4T3FTeW5uNHArTnQzRlV3WjZ2Mjh6OWYrUlJj?=
 =?utf-8?B?QkNmQTV1MUI5TWVuNzIyR0JhN2liaE1FQzZnZUM3QmlKNjVVNkcwakM4NVJV?=
 =?utf-8?B?R3ZqcHJjNTc1cC9Sc2JyYndROFhQbmp5blJoVjNjQkJhVUZWZ1Z5YnpKKzhW?=
 =?utf-8?B?MU5VbllpbmJQT0l2bG5nb1RkeWZ0ajRaVzQwV1JlcGo4eXh4UkovbzJUU3lZ?=
 =?utf-8?B?VzZ5YzJUSFl3bGt5Vzg0eDhIT1pGdjh4M090aXUrMFluZVoxdXFobW1nWGFD?=
 =?utf-8?B?YnlRSytVdmJHREQ5VUttWDFIVUNVcXkwdTl2QnAvU1dwcU8wWFZ3azgvZnFp?=
 =?utf-8?B?NlcvSzdHMGZPWmNGVUV4MjRta1pmSWR1SXV5a3llRXFnMUVWSWtrY3NwY0hL?=
 =?utf-8?B?alZIN2FHemRqOXdiSFI4V3BmSW4zRmt2czJMc09zd0dITWdGeEFvSGdyalYy?=
 =?utf-8?B?Nnk5TU9GbVFkZGNqU1lOT0wzb3VmOHBQRER5Q25MN2VYNjkrUC8venRYNGJO?=
 =?utf-8?B?bVJpMFFUbnFRS1lqL3Jhd3R2L1M2dGR4SDd0aGxkYzZ3T0pWTUExVlVodWZy?=
 =?utf-8?B?TlY5eEthZW80QU1uWHZyUE56V1Flak1BdDVyM05mZi9IZ3dSOTR1QTJ4R0VU?=
 =?utf-8?B?YXlBOFplaWhpYTUxeU5mbWVCbUk1bDJLdmkrTUhXRUpKWFdBKzFhTXc0UFd4?=
 =?utf-8?B?aTRjZDVYbFR0NVcybnJBaktMQWRzbGRoTk1IUHZMbm1kNDY4REdVZTdFYWNu?=
 =?utf-8?B?NmFLT1hQclNkcGNoZ2YvQ2VQdFFTRkZOc1VxcGF6cWI2SW9qNmNUdkVyZmF0?=
 =?utf-8?B?dmRGTTZ3V3dwdjZXV0xnM0gySk5JdkpiRnRLdllOUTF5SU9lZ21kY1VrWWMv?=
 =?utf-8?B?YVYyTUd2Rm5HRHcrcnJBbHFCdHhOZWZWNCswVlVaTnU5MElhM0x5RlhrQU9H?=
 =?utf-8?B?bHUrVHFERkVEcW8vaG8vN3owSE5hL0hVU2dUMFB0MlhpeUY1Y1hucytqWkw5?=
 =?utf-8?B?SmpxbWJYY043bVNmcTVndnFBM2trcUtzTzE3Z0F2SUkrOTZyMkI0dXI5NERP?=
 =?utf-8?B?cEdaS0dEUW8xblJKN1h1VldPd0xVM0l6clJPVnFsM2xyVmFtVkg5Sml5V3NP?=
 =?utf-8?B?d09KRkFGS1JhN2pncUtNU2svRWRpM0ZTbnFBNG5yUVZiNkd2ZnhpOURqZ2cx?=
 =?utf-8?B?YldQSTRCNjZPMGFva1NCOWwvZktNd0hTbVBxbGFvdUk2VGwxSTNFUmRWUXpj?=
 =?utf-8?B?OStpSm56Z2NRbk5HWjN6b21XZTB0bkx5dFNLT0h3cDZJSkZGK2NheWttcFpj?=
 =?utf-8?B?ZzRCVHBaMDdSdUlyQlV1aTFsWjNkSFFwZS9SaFptaUNOazN2aDZVOUxQYkpF?=
 =?utf-8?B?T2s2NHpaZnhzSW5SQnJwYkNWMUxKNFJCR2dRbEdxUTZNd3ZmSHBQTmNSMVp6?=
 =?utf-8?B?WGdoL2NrS0Uzd2dob0cyVmJpV21DVEJRbmRIcVR4WGZiVDl1dkV4MUkwbkpO?=
 =?utf-8?Q?gvg8upJoj9SS+hpYJode7Qk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309f5d13-2c8c-445c-330e-08d9c35f9f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 02:22:50.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vdhRb4c9D3Vherh2IDxJGTcYh24Y6rppdD5agfu7VTLSD26Ywmaj3PQm8PoAcISN4NR0k5/p4ePger12SZCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDE0LCAyMDIxIDEwOjM2IEFNDQo+IFRvOiBOZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5j
b20+OyBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+Ow0KPiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGpt
cy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBDYWkgSHVvcWluZw0K
PiA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+OyBUYW8gUmVuIDxyZW50YW8uYnVwdEBnbWFpbC5jb20+
OyBKdWxpYSBMYXdhbGwNCj4gPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPjsgU2FzaGEgTGV2aW4NCj4gPHNhc2hhbEBrZXJuZWwub3JnPjsg
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlz
dHMub3psYWJzLm9yZw0KPiBDYzogQk1DLVNXIDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi80XSB1c2I6IGFzcGVlZC12aHViOiBmaXggcmVtb3RlIHdh
a2V1cCBmYWlsdXJlIGluDQo+IGlLVk0gdXNlIGNhc2UNCj4gDQo+IE9uIFRodSwgMjAyMS0xMi0w
OSBhdCAwMjozNyArMDAwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gSSdtIGNvbmZ1c2VkLiBTaWdu
YWxpbmcgV2FrZXVwIHdoZW4gd2FrZXVwX2VuIGlzIHNldCBpZiBpdCBoYXMgYW55IGVwDQo+ID4g
YWN0aXZpdGllcyBpcyBub3QgZXhhY3RseSB3aGF0IHlvdSBzYWlkPw0KPiA+DQo+ID4gd2FrZXVw
X2VuIGlzIHNldCBvbmx5IGlmIGhvc3QgYWxsb3dzIHRoaXMgZGV2aWNlIGhhdmUgd2FrZXVwDQo+
ID4gY2FwYWJpbGl0eSBhbmQgYnVzIGJlaW5nIHN1c3BlbmRlZC4NCj4gPg0KPiA+IE5vcm1hbCBl
cCBhY3Rpdml0aWVzIHdvdWxkIG5vdCB3cml0ZSB0aGUgTU1JTyBiZWNhdXNlIHdha2V1cF9lbiBp
cyBub3QNCj4gPiBzZXQuDQo+IA0KPiBIcm0uLi4gSSBkaWRuJ3QgdGhpbmsgd2FrZXVwX2VuIHdh
cyBsaW1pdGVkIHRvIHRoZSBidXMgYmVpbmcgc3VzcGVuZGVkLCBidXQNCj4gbWF5YmUgSSBtaXNy
ZW1lbWJlciwgaXQncyBiZWVuIGEgd2hpbGUuDQo+IA0KPiBDaGVlcnMsDQo+IEJlbi4NCj4gDQoN
Cndha2V1cF9lbiBpcyBvbmx5IHNldCBpbiB0aGUgY2FzZSBvZiBob3N0IHNldCBVU0JfREVWSUNF
X1JFTU9URV9XQUtFVVAgZmVhdHVyZSB0byB2aHViIGRldmljZXMuDQpJIHRoaW5rIHRoaXMgYmVo
YXZpb3Igb25seSBvY2N1cnMgZHVyaW5nIGhvc3QgaXMgZ29pbmcgdG8gc3VzcGVuZCwgYW5kIHNl
dCB0aGlzIGZlYXR1cmUgdG8gYW55IGRldmljZSB3aGljaCBjYW4gd2FrZXVwIGl0c2VsZiBiZWZv
cmUgc2xlZXAuDQpUaGFua3MNCg0KLU5lYWwNCg0KDQo=
