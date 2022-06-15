Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9054C352
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiFOIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiFOIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:15:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DE2C125
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo7nh/35aEjbTSqZBhivsSZTC4mrd+M7eWJuTeWDYMIq0Uge8lMBcAu2t9j7xuTzfO0/+R6o49BRK88xW1VVIxBeufdnq3zmNH3Ywiz6GutmDxToc44qMFACqZ4usD4cFjwIMSaejDccy4yQa5zvhLrAb5jr8na8Jwhwuqy5yYiEq0Uiq3Lzy8qcvG05jgY47WDeObIO5LYvwH6DMbyJthvjT9SWqShWW8vYNrTTMRh9NUsx8SzPOjbTlW0FO/a9mKHCe1bIBXcSqCllRA8cU8vQuMEUAMrtMLsqdzt8QhfqidndW7+h0ymDvLO7b4YVdNEGIyCavnry+oO0FFu73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8BSRVQv+CxX+nA1Cf6UJkOvsYoUxvaTX91nZu+sOE=;
 b=JohBagPA/PhVTbqkaoZCDz9OLqFg8L0Bfztw4Rqw+7+cls1mfmdM7ov4DC9l9njQsUUFsdwRmQI8U1VGK1NujutyGd6LhSGOxGMyb6Xek5F7pSajWzwh8375Fh2dY8POHSg1ikwX4pqc/KYP7A4VUMs7oRIV5AqBoPlNW/V7PVu7tEzuDie+nyzJ+oe6w95neMMOsd1LEcJUaKHy5Ula1/96upXQZ5ylTq1KJroOuLm2nXl/m3QtgCWRjzXHr/tACcbgjgREUOoyXqeepuqO+zv9p2rzi0pjvG8Yva40bslzQg1yXKEh0zXdVLv5grE7nGh+nykcHRlD48QZxNvieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8BSRVQv+CxX+nA1Cf6UJkOvsYoUxvaTX91nZu+sOE=;
 b=BDL7soQnBiB4C1oVzf9iwmO+/CwozN6XhjqeKabL+Cs8Vqypiem0jXkRVpwD6LnDdR03dVpH+/mAH8rJBSJFO4dNKzT0q/jWMClY2v0GqCa0I0t2m4n9OBnhldzucg9rD49xJ3b9juk+Z699xT3WZ2BBgLjSsGX9tddqxfknHEU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB3646.jpnprd01.prod.outlook.com (2603:1096:404:cc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 08:15:22 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 08:15:22 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Topic: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Index: AQHYgFxZplLfJ1ijo0OLciOaJo4Kla1QH2OA
Date:   Wed, 15 Jun 2022 08:15:22 +0000
Message-ID: <20220615081521.GB1663556@hori.linux.bs1.fc.nec.co.jp>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
In-Reply-To: <20220615020005.246295-2-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a05e354-0839-4757-d39d-08da4ea731a9
x-ms-traffictypediagnostic: TYAPR01MB3646:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3646F175246D9A56A53CB44AE7AD9@TYAPR01MB3646.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3svIhpXRY1p78GUkpynp4iuhofRFtWRyXOcat6dbjyutwzcOuUhGIqLJVJt8XkymdYADNRU8FSK41321OlDy93z0XQvVwxdKvMi5XYmVsS4BxRh5roJWgZXQArNidepdQuKN+4BffBILVSOyuEnB2mMSjH5YGUuPYs7JWGyDwxKEt4/knc+g6Zfi2y+hnH4NRoczXJynZeM+6cOcT4u29+P8LPFai9N3xuxICpfM6jGyIJhILsosnkXkJVJrKi7TlPzXwWcEKTb1tj/WBWLA0ZdiFSEiOBFnJbWCaf9cGEu7mR+Q5ezoQ/iaMQyDv+DhAeIYKkdoMQ/h6V/TXxypB5tvlGPLL8fX/M46ecbKc2JYPOfw01Z+84BTXG5QTkKnyaBz55XeBK8qAD3+X/1BKPYXrg8ow11IFblUdJromUm9C1EnT2Cwl7QJTaUq8YcfmczpOgamlvO68UHn4+6mIQewRJuppi5Gw/MnxwatL+iWPvJqbLYH0sjnhXAgvbhasL4UMCllkO/VAYOzUq8c1TOhEANdAARGEd/TTMqrYsE1q+GlkOiXCGF67Y6sPPCpSxpivoPMRGSafUF8fUqM2aWVAkRRbYDfDZgmFqTUgzl45M9inVcgvLn7nfE2p8pSxxG7hYBPTNqpPb9mS/H48bjKKh24f3lzGfyCPCnUIEu7GjRCgTZp65W7KxVYBbGs1qDzvNflAAyKQQphqNyIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(33656002)(6506007)(9686003)(86362001)(316002)(6916009)(55236004)(2906002)(1076003)(38100700002)(6512007)(186003)(83380400001)(76116006)(8936002)(8676002)(66476007)(66946007)(54906003)(38070700005)(64756008)(4326008)(66446008)(82960400001)(66556008)(6486002)(71200400001)(85182001)(508600001)(122000001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3lKdnJYU2dnNmhDWUtCeU9OSmlienVWRTE0SCtCUEQzeEwrN0JWdnZYZzdm?=
 =?utf-8?B?NitoOTk5dU1YNjg2TmZGWWhlem9rTXNienVlS0FTMDRmTnE0R1h1eXh3UmN5?=
 =?utf-8?B?SS85ZmZ0TjRIczBYeGxjYmp3VWlTVzUyMnNSOXFZWlluemxyZlFQUmQvRDVx?=
 =?utf-8?B?ZU1CSHZhM29nMGJDLzdaTlRDV1FycWFaMHBmSzI3eDRFZFF5VkFnbm1pd2g5?=
 =?utf-8?B?V25vbTdOeUV2REkvUmJWRWw5djFsUkI5My9PQndGanJaVFBYaGVnUUQrL3JY?=
 =?utf-8?B?V3UzRWVpRmx4cWtpMnhiU09rSDR2ZExJT1RmVjZEcUVMbFYwbFh5clJ6ODBs?=
 =?utf-8?B?UzJVRXUwK3czK0EwbjJjRC9BbnFYc2Z2c1gvN2thKzc5MXhNUFdUUEdZaEdn?=
 =?utf-8?B?WmhmV3h1bTFOQmx0clB0U1oyWXV4blBndXhLYTJwc3ByN0FOZERiZ2R4YXc4?=
 =?utf-8?B?VlRUTVE1ZGl0YkNjMEVKOXNFMXVPU2tHNHMzaGZQMDNSenRlN0hDZDVJdmFl?=
 =?utf-8?B?Tlk0TkhvcTRkQ3laakZ4bDZjbjNXNzdFQ0FBVUxYMk9VTTJXODkrSjJKMEN4?=
 =?utf-8?B?ZUdJYTU0MncreVdnR2kycUhMR3Y0bVgwRnN6Tnc4eFpPSVpjaFJyQXQxSExL?=
 =?utf-8?B?YmJIOTVHK2k3ZGEwVjhsd1RYUE5CTUUrRy9XUEZxTmpCNHNkOE55UDFkTjc4?=
 =?utf-8?B?SWE5ckUrUVBtKzJhTUR4R0V6VjU4V2QwdjUvNCtDWTVnUWg4cVRhNHNzaFVn?=
 =?utf-8?B?ZHh4MUVHNVFyblpRdXBZWG41RlNzdlpVRFhocVZadjYyN0Exbm9sdzZlYTJq?=
 =?utf-8?B?eXBhajhZYnpCbWtnemQ5b3h6WFhmN1Z3STVqV0JiSGlHUTU5WGhvcllKa2dD?=
 =?utf-8?B?cmlHeWNZUFZBRFFROUloYW05bnF1UEpBeDN0bkViYXEyMWtMeEVTM0k3K2Ev?=
 =?utf-8?B?MElycmVIalUvdVBld2pFR09oZmxHdzdOY013eElLenhXOUV1VTdVK3lURzBD?=
 =?utf-8?B?ekFXdDRhWGFFQWdrKy9vd1VaQnA4TkI5WERFTXJUN01EUHd4eG9VaXFNVjhr?=
 =?utf-8?B?SmQ2THo3bHU4SUVQcUIrRmNiaUVkRERYOTlWV1hFYU1Pd3lHeXZZNlZZcnBW?=
 =?utf-8?B?MWZ0NVloeUIvMEhQVEVhdDAxSHNtQzh6ME1aYmpsZnczdmg0cHQvNERPWmxh?=
 =?utf-8?B?b25UQW9lSkVFQzJZcktNYUExdjdUbVpwaG1tRmRhdFFNYWtEb0wyK1N3WHdo?=
 =?utf-8?B?Y1VZVmVQdjVYUzZOdDhEQUZHckpFZnVLRzZsQmtlcUJJbk9nRFdXZlQ1TEUz?=
 =?utf-8?B?ODlILzRkVklIdXJ2c3QwNi9qcDVVT0ttd1RyaWlWT2tKQXVPWTVzcjdHMGFR?=
 =?utf-8?B?RkRXRGJFSUNIdXA2RnRRWTVUUnNXbjU5NXRVV1pFVWpaWVMrYkFrNjlMK0l0?=
 =?utf-8?B?aW5tdjNLbGdwL2JhSmRoVTM2Tnp2NnNDWGs3cmJCK0xrbXZuMzh1RU5FLzBt?=
 =?utf-8?B?V2hJK0Z6LzhvSm1ZTmF0T1hUVVBHTVJoNmY4SytuVUtMSmIrcWMrTkZmMFQ1?=
 =?utf-8?B?dGpscDJvNEJrVTZDN1RFbUw3OXkzSGdzTlRBN2xsZnFxYzFxazdHOFFJbTVM?=
 =?utf-8?B?MEJ5NmM4b1FuUzBoOFlRSXFzVjF4bUhBZ0VjbnlaNjBacjNpcCtYUmFCcnBS?=
 =?utf-8?B?YWluOFBwcmd2aGlMZWFVR25mVERTd0t6NUJMY0FmK0x5N1EwQ1pUMmhCOHdq?=
 =?utf-8?B?YzQzWTBCVkZYMk9rVEh4blJacGQvdXFXMC9OMERtOHJhT2xmVDNHWThJcUJM?=
 =?utf-8?B?b29NcFpEL1dEMXFGeFhuUzJUQ0xUcHhYZURxTFpSOWpFbWtVSHdkY2VWNHc0?=
 =?utf-8?B?STR2aEJYSWU0RUtHd1ZQM3NoRmNQYUV5MHgwOU0rTDMyNTk4OFN5T2xZYjlD?=
 =?utf-8?B?K0U3ZlhuN0w4Q0NPQzFRR2h3dTVYOEJtR09xMHYxOXhRU3h0ZVgxdmRDdmhq?=
 =?utf-8?B?QTRjM3lQZ1VmNW1peXRTaUEzMDM5NFlFMktHQ0FaYW9hdFM3YVc4eG44ZytY?=
 =?utf-8?B?a0kwRTAxL0xySFVxTzU1bUdDWmFPZ2lXOE1mMmRMdmV3UFVBZ1l5OTFITCs2?=
 =?utf-8?B?cHpzcWJ0ME9sN0JlUk5LYldpcHpvTmpEcC9HYUd3ZThqSnhoUzdTQUFleXBW?=
 =?utf-8?B?TW14SFhDdUh1RDFQT0t5QzlvQXUwU2ZHbUk1YlR5TTY2RTIrYzFFUFNZUGJV?=
 =?utf-8?B?MDNMRUNsWFNKby9abWYvUnBKbFRWYkl2bFFZOVRlTkR5Y3FBd2ZtOEtlOERM?=
 =?utf-8?B?WGk3NE5nWGRnSHc5QituZjJEUkFtaUpZdlA1dXhRbzFicjVXWEt0bTQ0eWxP?=
 =?utf-8?Q?Nn4OM4Rs4PNduHXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8D242290175A48825B84369CF54446@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a05e354-0839-4757-d39d-08da4ea731a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 08:15:22.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0gb+U2nxgQtE/aLN3t60ECRm6TQx5PLICj3No0Ylo9IfGFWwYKh+G9HBrz3Ozpf6zmgC9gk00UeD4PxyYDfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3646
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMTA6MDA6MDVBTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gQ3VycmVudGx5IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikgaXMgZGVz
aWduZWQgZm9yIHNvZnQNCj4gcG9pc29uKGh3cG9pc29uLWluamVjdCkgb25seS4gU2luY2UgMTdm
YWUxMjk0YWQ5ZCwgdGhlIEtQVEUgZ2V0cw0KPiBjbGVhcmVkIG9uIGEgeDg2IHBsYXRmb3JtIG9u
Y2UgaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRzLg0KPiANCj4gVW5wb2lzb25pbmcgYSBoYXJkd2Fy
ZSBjb3JydXB0ZWQgcGFnZSBwdXRzIHBhZ2UgYmFjayBidWRkeSBvbmx5LA0KPiB0aGUga2VybmVs
IGhhcyBhIGNoYW5jZSB0byBhY2Nlc3MgdGhlIHBhZ2Ugd2l0aCAqTk9UIFBSRVNFTlQqIEtQVEUu
DQo+IFRoaXMgbGVhZHMgQlVHIGR1cmluZyBhY2Nlc3Npbmcgb24gdGhlIGNvcnJ1cHRlZCBLUFRF
Lg0KPiANCj4gU3VnZ2VzdGVkIGJ5IERhdmlkJk5hb3lhLCBkaXNhYmxlIHVucG9pc29uIG1lY2hh
bmlzbSB3aGVuIGEgcmVhbCBIVyBlcnJvcg0KPiBoYXBwZW5zIHRvIGF2b2lkIEJVRyBsaWtlIHRo
aXM6DQouLi4NCg0KPiANCj4gRml4ZXM6IDg0N2NlNDAxZGYzOTIgKCJIV1BPSVNPTjogQWRkIHVu
cG9pc29uaW5nIHN1cHBvcnQiKQ0KPiBGaXhlczogMTdmYWUxMjk0YWQ5ZCAoIng4Ni97bWNlLG1t
fTogVW5tYXAgdGhlIGVudGlyZSBwYWdlIGlmIHRoZSB3aG9sZSBwYWdlIGlzIGFmZmVjdGVkIGFu
ZCBwb2lzb25lZCIpDQo+IENjOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMu
Y29tPg0KPiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPg0KDQpDYyB0byBz
dGFibGU/DQpJIHRoaW5rIHRoYXQgdGhlIGN1cnJlbnQgYXBwcm9hY2ggc2VlbXMgcHJlZGljdGFi
bGUgdG8gbWUgdGhhbiBlYXJsaWVyIHZlcnNpb25zLA0Kc28gSSBjYW4gYWdyZWUgd2l0aCBzZW5k
aW5nIHRoaXMgdG8gc3RhYmxlIGEgbGl0dGxlIG1vcmUgY29uZmlkZW50bHkuDQoNCj4gLS0tDQo+
ICBEb2N1bWVudGF0aW9uL3ZtL2h3cG9pc29uLnJzdCB8ICAzICsrLQ0KPiAgZHJpdmVycy9iYXNl
L21lbW9yeS5jICAgICAgICAgfCAgMiArLQ0KPiAgaW5jbHVkZS9saW51eC9tbS5oICAgICAgICAg
ICAgfCAgMSArDQo+ICBtbS9od3BvaXNvbi1pbmplY3QuYyAgICAgICAgICB8ICAyICstDQo+ICBt
bS9tYWR2aXNlLmMgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBtbS9tZW1vcnktZmFpbHVy
ZS5jICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg0KLi4uDQoNCj4gZGlmZiAtLWdpdCBh
L21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IGI4NTY2
MWNiZGM0YS4uMzg1YjVlOTliZmMxIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTY5LDYgKzY5LDggQEAgaW50IHN5
c2N0bF9tZW1vcnlfZmFpbHVyZV9yZWNvdmVyeSBfX3JlYWRfbW9zdGx5ID0gMTsNCj4gIA0KPiAg
YXRvbWljX2xvbmdfdCBudW1fcG9pc29uZWRfcGFnZXMgX19yZWFkX21vc3RseSA9IEFUT01JQ19M
T05HX0lOSVQoMCk7DQo+ICANCj4gK3N0YXRpYyBib29sIGh3X21lbW9yeV9mYWlsdXJlOw0KDQpD
b3VsZCB5b3Ugc2V0IHRoZSBpbml0aWFsIHZhbHVlIGV4cGxpY2l0bHk/ICBVc2luZyBhIGRlZmF1
bHQgdmFsdWUgaXMgZ29vZCwNCmJ1dCBkb2luZyBhcyB0aGUgc3Vycm91bmRpbmcgY29kZSBkbyBp
cyBiZXR0ZXIgZm9yIGNvbnNpc3RlbmN5LiAgQW5kIHRoaXMNCnZhcmlhYmxlIGNhbiBiZSB1cGRh
dGVkIG9ubHkgb25jZSwgc28gYWRkaW5nIF9fcmVhZF9tb3N0bHkgbWFjcm8gaXMgYWxzbyBmaW5l
Lg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
