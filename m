Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C361C581E84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiG0EH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiG0EHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:07:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2053.outbound.protection.outlook.com [40.107.113.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0712CDF8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfzRVMPpVhTm8IK2iZm0A5ECp4JpyG3juR+kaEF/OY4QjzxOd0qn0wZ9UNaMeLVx3VqbWKBejSJ6bkvnh++tmrCWapB0+GHOiHpMIxpfNu+CqM5XhH72/i7DTFbVEjO01xQjpgf5F5mH+4yHJrSMocfBYII2XSQvKFfMGnEH4di/WkgETZ6UIcUfL+yQtAI2Wnxq7uXmfv2bf3V1QDz/oqyD4dRbRITbvMeL69GjYjnRofC2WU77Xd3/DQxf2i7TTP3vpieRPAuG07GCZR1cW2Ofk3K2v1LXA7bvxtu6sj875SaAynC4Zhf/dCUp/pzL2SV56+4rrUj7b64M+Z1P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chx2Am9kmS+KHZm4sBCN38/R4EPEvLTqOZxPlxLt1QA=;
 b=TJvJUxqEb9s1X0wkVoYzIEnPGCyd9Sjciquc4GFvM0022ZJtKJgESQayr5wK3k5qAnitHkEcJUjint0dZqXB9Tt+glBz4ZbWSE94rAwrSh0qFcAwbH9OgWL4O/CwJI7AjPVoSYExvYmYdDzOI/W7oC5AzIWFlbm6GDurlq26PPB0KZDmetyUuHL5kFAoPq3+Wu+3kc4hSMOP7Llsq+m1ypvQD8GlXKQNVOI5hSupcy+5CPRhJfCx0v+m1+z+EOYk99Mq2RtNs4A1pmLjw/a1G0KxqhVwbdpmdetbmZsJHBoQtQ/gwuF5Uy6oRnmSfhBUenlTG9/ZFn8suMFHv+3BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chx2Am9kmS+KHZm4sBCN38/R4EPEvLTqOZxPlxLt1QA=;
 b=nPvxlaEqqw312DHdUfqMv14qGkQKoOU+HDscRnOtHzV795WwyI8cPMI0ri9NmgR5cxBYQwKPeu+o+wVAtx3vcgv2dP4HrA+Fgrgbnz3FZdh79h6b71dHby82LBgTPbYx0K6xaHMtLhRelYUY3N8R0EOgSYquEWJnjkhUdKyMCno=
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com (2603:1096:604:19d::6)
 by TYAPR01MB2064.jpnprd01.prod.outlook.com (2603:1096:404:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 04:07:17 +0000
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00]) by OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 04:07:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memory-failure: convert to pr_fmt()
Thread-Topic: [PATCH v2] mm: memory-failure: convert to pr_fmt()
Thread-Index: AQHYoWeLLjSS9v9GhEKXQ4Vve5cSZK2RmeUA
Date:   Wed, 27 Jul 2022 04:07:17 +0000
Message-ID: <20220727040714.GA3354482@hori.linux.bs1.fc.nec.co.jp>
References: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb8b4d1-83ab-4dbf-ff14-08da6f857ee0
x-ms-traffictypediagnostic: TYAPR01MB2064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQZvuiTByllB8RMvVTtUGQT2MHWvZlLFB9Lkq0EG+xa1DcIcBDJ0FLJht2hNK11J0ngMscyM/a54kT8qe6GFiZGXF9o5ON05naKwAcMv7N7UcI2ZNZC3k17eqWLEdcNPakLZyhrwFgYaUjKGd9UIE/AizRRep766WE9Jgjjc+WmJjpQHFtk54MHBYSnPOEmjGar465gb19KntqSsTe6Gzo06Z0mr172gSgdfAPo4U/W5xMO3tP3OoBGwbI/nyi1eTdhy7or4fMvLTa1q2ethO8wCOxWf72z6eygRFEjJD9+b2wAdo0DeSLUmZ9H2bjwd7A4LdGrct13YfAPuXJR0rkwjvAN0ue1j0//gQZlC0J2+7u5/Przvf0wij0IRvn+9CqR3Ll+OQhgGX7L4CcoIvmgtAj398wDV1BD/dG3ofDXJJcbrzXQUcP/rKZuW5uAFy7VqdbWqwjDY7h/b8KyeJDGP4rcMks6arfqLI+XF6GtdTjCFKshW8tGAFt/Owj8OL35XIXtyohoH2GvBMYi6zuHULwxU0i97302+QJwIj9TFUcGrgz0J65go8BxZoUDnLNuy0cVfMJ4zHALFyZLuRPch+D58bNJ0bkTIzOPjptYpCKfe/AZQcX6M4QA1f2Ozm3hP7YuWWKK/OhBxYdhKZlnnipQVh8yPEgJ7z+pl455Ci0VYfWjlqubcGJybxV3XPEk/UIDjJQv65YPOUY6UVRvex/yPbsh0eecXi8FhLAzMedMm4TRD09Fvw6Ka5Um4IQIJ/Z8cmQRDu4gi4E8sUcFbxK8kXWX6g4nHjE933VKuSc7OfsMgv7H3FInbl5uJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8586.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(5660300002)(6486002)(38070700005)(71200400001)(8936002)(4744005)(54906003)(4326008)(478600001)(2906002)(6916009)(33656002)(76116006)(66556008)(66446008)(91956017)(66476007)(86362001)(316002)(38100700002)(186003)(122000001)(6506007)(85182001)(55236004)(9686003)(26005)(82960400001)(6512007)(41300700001)(1076003)(8676002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBxYW1uWGpkUXUxekx5TWpUbE42Tm12Y0NaTmEyNnNyVGh4VHpEakRXZnpC?=
 =?utf-8?B?TCtpSkRmSFY0NkViQ1U4UGI0bi9uYURtSlkyUWllNFh1U1IvNzdrblFMaTNK?=
 =?utf-8?B?WUhodnZ3Z1BTVzRNTEVraWZqdFV2YWpVWnZ5QjIvWlpPZ00wRkJhSWt0NE41?=
 =?utf-8?B?Vi9HSGp4cW5zR2hIbUVxNVJZV0U0M25wWmYrYk0xU1MwV3IzQkRLSVFvU3Zu?=
 =?utf-8?B?R2Jaa0tJOUkwMEEvNVVkT1kyY3dlQTNIUHJMVWp3Q3cyUFoxYS9QVFBMam0y?=
 =?utf-8?B?czlsT0pEcUEwbS9QMXNUdElKcmRBelY2V0lGalIyMEtjVmZ3RzM5V2xaQ1lP?=
 =?utf-8?B?Y3VlQlUydlp0eTFEYWtadysyV21wZ21aYVh5RW9aR014RVZSdkRTell4REJH?=
 =?utf-8?B?bzRxWG9xQ2xJM0JWa0VMVlhET29RK1JGOEE5Nm9Jc2NBYzdXQUF2MjRLTzN1?=
 =?utf-8?B?eXJCT2tTWThwd0dsWTRLbnNjekk2VU9BekdYTVpnT0dFWk8vZjBORGRJT0V1?=
 =?utf-8?B?dkFkcXhlTmRQbGRRaTViMDFReWlmS3hTaXZNSUFyTkdSV1BXQWtrR2xkeFVk?=
 =?utf-8?B?SDA5SWgwcXFabDFwbmw4Q3MyZzQrZXNrWkV1QklZSW1oSDBXMzVMdGVLenJR?=
 =?utf-8?B?eHJqWnArTmVQR1pOWXkrSWV6WWpxR0hKZ25RVm93UFRWV1NOaTVCMFNsN0J5?=
 =?utf-8?B?dDY2dXdlMmtwVlQ1Ky9XSlNDMlZQYXRGM0x3SEdCSlc4amErSGxnS1V3RE5M?=
 =?utf-8?B?em1MYUxrUkNMb1ZVbnUza0J6UWRydTA5RnRnU0lyOU1JVC9YU3RNQTZDT00z?=
 =?utf-8?B?bkRhZDk1VEg0TFZpdDNVbU0xcm81WHQ2VEZWcDhtMXJoZ08xYWJidHVhaG1L?=
 =?utf-8?B?TnRnUm5uNlFrbEdWZDVPYzR1OTM5eWFQTHVQanU5akFoTHVDZnFlZUhhYlpw?=
 =?utf-8?B?aGxmVGVXVHVaU0c2WVFPdENSemlnMzZOTGQxT2pqbFJET3N3SmYwNEhweTd3?=
 =?utf-8?B?aFpMeHZBMEUxUDZEQXdseTY0MkZzTER4OVhmNkwydzBaZmVzNmMrQ2I1SXlh?=
 =?utf-8?B?V000TWJGOFdITkdOekp3R3Q1Qk9kcmZZcGM5RzYya2dTRmpNVEFZOGxpM3Y3?=
 =?utf-8?B?RDFzU3VaTUxZMXlKcG1jdXFYWllNVVduckJuUHJyNXdJdG5iZ3BqdG5lV3M2?=
 =?utf-8?B?bFc3eVdodXRwYXJUYzMrV2dZUi9VbVl4TEVTQzNsdDNBeUJpZ3IxSUFDMHpV?=
 =?utf-8?B?V1B2dkVzMURDbnQzZ0tvSlhacmw3Q1Jhc0E3TjZKNWo2TWo4eWhROUtZY3l1?=
 =?utf-8?B?ZjRtTzVBZGV6T1Z4SjBlQ1U2UFhRTjdVL3RtbXkxcVROdlVPcEt0QVdtajBX?=
 =?utf-8?B?b2UzZVcvT0dMaTN2WEdFS3dIWHNMZkhteVVvS1BydnY0eWwxeHlQdFFEVlAz?=
 =?utf-8?B?VlEyZnlYMjg5eDJMN0F1MzNiN0pGV3VsT2NCY0JGUTZab2k2enJubGtkb3dr?=
 =?utf-8?B?YlplNVZ6SVBnRzFwMklwbTM0ektyTWdzSThHQllrWWM4eHF2akxua3lEWDBW?=
 =?utf-8?B?bHFhR0Q5VjExUE00SXZvNVE4bnJFL3NsOHF0U3VCV1p1eE9EcjR1M2pKSmdW?=
 =?utf-8?B?YTJ5YzRRWFJWbDhJaEgzOUYxV1FyRkw0TXFFa0xUVXhYZXVYSGI2WEhYV1JK?=
 =?utf-8?B?RWFoMVl3MGhYaTZ3Y3F0Z1NxZnNDRW9FSWwybXpwMGhOQlA3RzM4bGUzVDN6?=
 =?utf-8?B?ZVVxcU1PWDQveDFhaEVZNEs2NDRRcWlRNk1nYVJnOFQ4OWRYTTRreEhxbkIz?=
 =?utf-8?B?ZWFXc1FRUzhqdDQ1VHRONXVCakRVejNmdVR2a2JRd0x4RWdRU3EvbS9kTE00?=
 =?utf-8?B?OUYvMTZZY1hMRTVLL2MwZWJ0ZFQ0QjJkUlR0Y04rMHNvTFlIb0ZkaHFXTGxz?=
 =?utf-8?B?SlZaVGgzOUdnUEdKOFRpNXhzY3VQSTJJVHlQN292SzNXY014SEcxRURReEUz?=
 =?utf-8?B?S00ydEk5SXlhYU9PWUkwRFJYRjMxZzhlcVl0cnNUSTN1Vjlqck94eXEyWWVL?=
 =?utf-8?B?UG9IUVBOTWE2TmdBTXBtZjRiNHpjUWVzTGlWNmFVVjM0aWlWZ1UrZHBJZ1dY?=
 =?utf-8?B?aXdvN01hUk1qYjltaUt2N0NZNnNjWkFNOVkzd0NEYjVkRGx1dGZLRFcrS3Qz?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E4BB7567382DF4EB72ED43A5886ED28@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8586.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb8b4d1-83ab-4dbf-ff14-08da6f857ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 04:07:17.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/qgVIAKFy9QPZX92bJhE7u856M64jxLFPAfjviGeP5KTT117jA/QRrGnV7X113mZ9C3XSfFQkdPbuJnOTmVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTE6MjU6MTFBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFVzZSBwcl9mbXQgdG8gcHJlZml4IGFsbCBwcl88bGV2ZWw+IG91dHB1dCwgYnV0IHVu
cG9pc29uX21lbW9yeSgpDQo+IGFuZCBzb2Z0X29mZmxpbmVfcGFnZSgpIGFyZSB1c2VkIGJ5IGVy
cm9yIGluamVjdGlvbiwgd2hpY2ggaGF2ZQ0KPiBvd24gcHJlZml4ZXMgbGlrZSAiVW5wb2lzb246
IiBhbmQgInNvZnQgb2ZmbGluZToiLCBtZWFud2hpbGUsDQo+IHNvZnRfb2ZmbGluZV9wYWdlKCkg
Y291bGQgYmUgdXNlZCBieSBtZW1vcnkgaG90cmVtb3ZlLCBzbyB1bmRlZg0KPiBwcl9mbXQgYmVm
b3JlIHVucG9pc29uX3ByX2luZm8gZGVmaW5pdGlvbiB0byBrZWVwIHRoZSBvcmlnaW5hbA0KPiBv
dXRwdXQgZm9yIHRoZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWZlbmcgV2FuZyA8d2FuZ2tl
ZmVuZy53YW5nQGh1YXdlaS5jb20+DQoNClRoYW5rIHlvdSBmb3IgdXBkYXRpbmcuDQoNCkFja2Vk
LWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==
