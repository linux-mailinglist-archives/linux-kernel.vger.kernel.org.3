Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895CD502010
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiDOBV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiDOBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:21:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2076.outbound.protection.outlook.com [40.107.114.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00791570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu/4fwY4G6HFg6UDuz/He2auSZJacQX4e5uf9C/86rSqI6SoIus9X6zoKlAkfWj4CdRWm2jWWPBdGAPP8uCIaid7yTXAYzWy/DBe6Ke4YRJ7cG7WNJipu0YZbzFaiih6dcKW6mB3EWRG47D37fiUhA3DMsstStwUAu6zagjvQTiUXUo71Oniq6zgNjYaqUjDBvrrbbnh2yHVo1qGjzMQOQuqZf455qnJZSJaQYOFA88FqIhEAEEeGwPzStVsiPn5tMVaxfh3U/pDT/ZFMgGB1/sPUbfopjA5qCZmIRTWzq/8wjpFT4XXuwYVpA7ThGrtGQl1iv0/BOnjNiqM4bd9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hpm0m81TUclhiYkuMllUPzzYJ/fz/wBXe7iv2aI+aAg=;
 b=UnSdfw8NBStYeF5TZotyngpCxywhuGv6JcFY9Pxmg1baYWIQ/GloOThL33B/W9oWQ1xF4xYs19A6DuB9jD7POFjswo0cvvmc+JAkoApoU/8AiOGGrTQhN2cGmhSPrxD4qjUTboiLbhFnqRx9rHg098RcDf5a9IS4row62PC1GKCLfzZa9kJQSDiqmkef1JsAAoSEDt6fJA4oXbz7gdY6qdW1JZkAx083Y5T9myHEpCnkVpkge8EDyIExrBTEznYAmm3A4JPXYnhrh0ZBWPB8vMN9RPtcsQR6EbniW3tcPHUpr4sgMOTuTLamSe2roOF8Jyo+y7vxrye99WRV18lsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hpm0m81TUclhiYkuMllUPzzYJ/fz/wBXe7iv2aI+aAg=;
 b=E2DuIQMeeWSngnRMj2HKebogMQNK0huXN/G4WrhtBmKQ5ncpy+RdjfBzjgBazN1R5YKlUKjfvlFhRmMeTy5cGw0oTO8GvD1OmJNgBwFXBGwwPWMpAJdIoAUY0lCuice5Um0i+Iz2cAlkEuIeRl9RiqgXzGoCvKQxjCNZiXQGbwA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB8673.jpnprd01.prod.outlook.com (2603:1096:400:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 01:18:55 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 01:18:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: dissolve truncated hugetlb
 page
Thread-Topic: [PATCH v2 2/2] mm/memory-failure.c: dissolve truncated hugetlb
 page
Thread-Index: AQHYT/ZjQaXuCEyvokikoGc0iC0zK6zwLZ4A
Date:   Fri, 15 Apr 2022 01:18:55 +0000
Message-ID: <20220415011854.GA3355774@hori.linux.bs1.fc.nec.co.jp>
References: <20220414114941.11223-1-linmiaohe@huawei.com>
 <20220414114941.11223-3-linmiaohe@huawei.com>
In-Reply-To: <20220414114941.11223-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6466ff34-a072-4e72-5fe4-08da1e7de926
x-ms-traffictypediagnostic: TYWPR01MB8673:EE_
x-microsoft-antispam-prvs: <TYWPR01MB86738A5CCED6F3D0374C791CE7EE9@TYWPR01MB8673.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGuKLbMpw81mgfcm0cR/GUeGwdwpZVJdyukuWIA91MMw3De90yJM9PiY8mNguomeDQcJbMZY9sskqB97dhDV9Ao7QZQgKKngyQfdT6S8+mlGBnu5WTR2AcA+L92SpyyfJHDzKmUwC6NfIM8sHRYB660rLRCrNjS28nphzgHnqjWDWzwFzwYDO9tXI2yZe5Zp5lpwajzWGTeRshAmXQeNkPu9tJbpxOzdpkrWdTeZGbHFKRV1DMBwurqpl4/25/nU1mOqg0ytT/RyUoCNMcglMfkxOUAbz2/YKvEH7CgYds8fLeqSGtw6p8rRkhBCz0LKBkZeCA8ylEL4SYKQzs4pK1mJxQetXZLAfYfyHrhe2ZxH4cB8G4uad4slehQ582WHRBzttxWLQD8od6C7qNRxyCPUGmfLdS+nW/8ScQ1PSSnqWN2Glr8WcSi4Y+pMuI9GLgWVXubJB1N7KhZrIP4zVKJ45iv/psgTox233tbhUoWOVSC20Wj/YipVX0UVJVBjz2lHPgs2Jadg/8BLHPFkT5LiPYCzFHND2vQrbrmgRmEjxV+dyqMqkiTzmunN15nwQAsIWMwHJ8yklqv0PvTZzXX+EJil80ZNZiSC6kwryGZ1fus9cBzx1C0YLTVsFGa9PxZtGezDBvMS6hjFGWdOVjRlKfCYKrNheYOaCCISOVM3pBs2y4Ef7mRQase3JIzLt/tIWvDxsTiYnhe0VKMi0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(76116006)(66556008)(8676002)(4326008)(66476007)(64756008)(66946007)(6512007)(9686003)(122000001)(55236004)(6486002)(33656002)(83380400001)(6506007)(186003)(508600001)(85182001)(1076003)(316002)(26005)(6916009)(8936002)(5660300002)(71200400001)(54906003)(4744005)(82960400001)(38100700002)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXoreGFQOFJOZENsaHN4NEtCdWt2dXZCWG55TjhTNmRydE04MEI3NUxnQzIw?=
 =?utf-8?B?Ri94WUMxcVpyY2tVcXVUbDAxcVdLWkdud1ZybDUwbGFsbThlWUl2dzNVNlp1?=
 =?utf-8?B?TEJ1Sjlwem9tODJ4UTBzNElMdG1IM2xiMDNydXZmejZhOFErdks3ZmdEdXd3?=
 =?utf-8?B?Um5YRkR4Y1RVUWlMOEpYWFNlTm4yZEVhVHR1TElLTmVZeDlIdlljbmxjeDgy?=
 =?utf-8?B?ejIvY2FnTC90VWM4MGJGdzNWNDA1SnVOcUhIa2FpZ3JBQXFZczlZaWp6MGZj?=
 =?utf-8?B?SFM5Q1IwRG9ZQUdjd0QwcVJSVnNsbnZSUFpubkE4RGNmSW9maTVDMUhlV3hK?=
 =?utf-8?B?SmJrOW0xKzhSNndUWTYvNHk0eHhsZHErN3pvZHdzK1ZjWlNvT2lXVjh4MHlz?=
 =?utf-8?B?eXV3S3FnSE16eDJwaVpoSGQrN3I0dFVYNlo0bGRsdWJSTXlSYi9jR3VGRlVu?=
 =?utf-8?B?ek9LK1pxbFhZNjVPaUhudDBvZmsyRWZSbTFBam9DenBiRkVCbTBYQk04aGNh?=
 =?utf-8?B?NFVPcEpNNEVEcTBpVUVCVllmMFFwc1krYWQxRzM3MlVFNUY5R1A1V1FjbmEz?=
 =?utf-8?B?UHR2MCtvdnRtdTNNelh2aTFVQnBadEpPdjF2MTEyNDdMUG5wb0F6S1E0b3lQ?=
 =?utf-8?B?S3JDcDZTWjByRlBKYjlsUk04OHNLdVlxc0xDTWFnYWxFUjYvSHVzRWxSNW1E?=
 =?utf-8?B?NENDYWdYelRiWG00eVU5akxXUTE3L2xTNlU2OWxnbEZpQ1c1RUlSQ25XdXBM?=
 =?utf-8?B?YmFzT0U0NjB4aW5YQU5BVi9ISHZPR2tvVnNINklxa1BOclh3WkVyekp4bVNM?=
 =?utf-8?B?SC9YTy9tUGkwcGZUVDhRS3ViN3lUeXpxRnpZUkVOT3pUdTZaNDNPUCtMa1B6?=
 =?utf-8?B?blpya3pqcU9zbEZ6TjdSbHR3Wkc4c2NoWVJmOVc5aGdKN1QvdTNPSE05RzZS?=
 =?utf-8?B?Z0g3YjBEQUpvYi9VVExBVjREbE5xeCtQUFlMQ09PUTBDRmdTTHY1QlRzTlZi?=
 =?utf-8?B?RW9WSDNnNVBIQnZVMkFYa1lOQndzTWlRcmw5WFhoM3c1VEJXT3YvdlBxbHJO?=
 =?utf-8?B?d2k3QjhkY3dST1E0UUpXNXRnZ0lMYjRreGhkYnJYZVFQWFRmdnEyN21vdERr?=
 =?utf-8?B?YTlScEVSUHIyaG5yWVIxaXVUMDJ4SXBwbExCTTgyTlBkWkZzUmVCM2Fla0JD?=
 =?utf-8?B?SEFuMjlpMkEyY2RPRUNmME1mZHljVXZ3bkFrclZWcUgrMkI0TUxxSFJUWk1z?=
 =?utf-8?B?QmxUUU51c0tBRzBzUWlNSE91NWttdG13a0llc3JZZ2xOclVjd09wSFFEcXE5?=
 =?utf-8?B?SVVQclNZbGFvRkhIdG15Umg1Z1d5blorSEV1akhxWUpCbFRscUJXVWo2c2NN?=
 =?utf-8?B?V1VSbkZvK3NtOUNFRW1BVEtXMUtiUWVQdDdFc0F4cERzQ0c2cXlsejg0Vlpk?=
 =?utf-8?B?aTl5NU1YRUNJSXB1RStCckNCaDIvM1BjREdmWTBQS1d5QmhrcFFJQjZTZXlz?=
 =?utf-8?B?Snk4NXRubFVDbTIzR1c5VEtTZE5kanYwNkg0YTJlZHF2MVFJUnVCTFp4bjFt?=
 =?utf-8?B?aXhVY1JnNVpKejlKbGZkcUUxY1Jvbk0xbWFIZnFNM3lOeWZtdlBiZEVJWW1q?=
 =?utf-8?B?OTZyVm1pNWVEVG5KMDRaMXVjSjF0ci9TQ01JUmc0UlpMSVpMNlY0TlhQc1da?=
 =?utf-8?B?c3NlUW9lU3B0OGJUek8vL2JXZEpBUWV1RjJCRXM1Z2RlY2NQMmpXS0ZHWER3?=
 =?utf-8?B?c0h5bFprTE1jRk5iZUVDeE5NdVpoZXRPeHBNbm9mRlAzVHhzN2dqS2FPSnp5?=
 =?utf-8?B?UGI2TmNkbkFGRndhTkpBUkZrNUxFek1vMk9Oenkxb3R5ZXYrNW1HYjJWKzZi?=
 =?utf-8?B?K3JuclZEeWZ5QmZ2L3lLZmJQUXVLWERjSnZtQktldHhsb3FCL0p1UDdaeDBi?=
 =?utf-8?B?LzlFVXM1SkJQZ00wTjMvakJ0NkFKUjM1bkhRZit3bGtRR1ZvT0FrQk9BTTNF?=
 =?utf-8?B?aEtqbzR4Q1QyZkFiUCtSTGlwWlY3SENhRmtHckZTN00yNjFZbzFkMkxzdjFt?=
 =?utf-8?B?RTV2aEZWMGZvU0JZQ21rVkRZNWVuTFkxV0NRaDhZSE5MQTQ3Y2FzUzRES1V0?=
 =?utf-8?B?OGNySCt1dERSMkZrWndrNWdZRXVGUnBBS05uOXF0VnVwODl4TFNncWlSdG1R?=
 =?utf-8?B?MlI1NjJNanQ1NkhmYTNTVkpJTmFhaEtHbFMraklzVlkya3B6Mk1BbVBveWxL?=
 =?utf-8?B?QlZrV3p1VE5HUzNsRkdwd0dXNmozU2trTlg2RjF6bllCQllJVVFpUGRibU9V?=
 =?utf-8?B?UERtMTJOS1BESzF2VER0OVNkWmJ5eXdhZmtTc1FYMUVBc0dIaTlYN24zQlZk?=
 =?utf-8?Q?dpfihjGBFXrUq6LY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F86F2ED55A8E44A4F6F4A277A47342@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6466ff34-a072-4e72-5fe4-08da1e7de926
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 01:18:55.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNQLnYfDPi2l+p8ay4Glveo3Tfdg6Uh05T4uaEBBk8FEXoXVRxGKlih46j/oHlwEbUYwo4WIJ/bn6HfHyZV5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDc6NDk6NDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSWYgbWVfaHVnZV9wYWdlIG1lZXRzIGEgdHJ1bmNhdGVkIGJ1dCBub3QgeWV0IGZyZWVk
IGh1Z2VwYWdlLCBpdCB3b24ndCBiZQ0KPiBkaXNzb2x2ZWQgZXZlbiBpZiB3ZSBob2xkIHRoZSBs
YXN0IHJlZmNudC4gSXQncyBiZWNhdXNlIHRoZSBodWdlcGFnZSBoYXMNCj4gTlVMTCBwYWdlX21h
cHBpbmcgd2hpbGUgaXQncyBub3QgYW5vbnltb3VzIGh1Z2VwYWdlIHRvby4gVGh1cyB3ZSBsb3Nl
IHRoZQ0KPiBsYXN0IGNoYW5jZSB0byBkaXNzb2x2ZSBpdCBpbnRvIGJ1ZGR5IHRvIHNhdmUgaGVh
bHRoeSBzdWJwYWdlcy4gUmVtb3ZlDQo+IFBhZ2VBbm9uIGNoZWNrIHRvIGhhbmRsZSB0aGVzZSBo
dWdlcGFnZXMgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hl
QGh1YXdlaS5jb20+DQoNClRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4NCg0KQWNrZWQtYnk6IE5h
b3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
