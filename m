Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F6B50C651
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiDWCHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiDWCHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:07:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327D9D063;
        Fri, 22 Apr 2022 19:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMcdQcjh3NryzUJ/JElTea7NnxNV4p02fNtXL/errrYeJjekFOwAS5jxvCm/Rgr80mhag9SU+P99tQGMQSfxfY9SV5AIia97cV0aHq/R1AZWj2EotTCeAUz69Xidwj15zdd0MURk8EZqX2P0QKIk3iLBoJtH9R65+Qhn7M94Mp8I3GxqcQPmT+xjsKLGcQWKKiDolfgelEn9WStMly/EvDfCEqat+1ZagGn+/NSfJTwP2pXBtASNhARFJkBnblD1Pj0KlYjHYVrbwWuYyL3+szco9j+Ug51S3Yy3RFovphH2s6B/noN5pX4+xH7wZmrYEZb/V29/MOATW8YVhgA5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOGaxqVI2jQjQ9dLQZWP9L+BnhQTlmQOE92aPMdXEgA=;
 b=mpC5C6wdlouAHDkZlQLcQbG+fypwqGQ9nRLYXnc1UOlyZBVnfZgjjot4AYSjrwyV0t8pLdZGYws3dN4J5ltlqK1c+bixQeEjbgbJf+tLDp3AZx7KG5ugXRLzwIZiIHgle1Vw1xyZ+N3IR+6SjrK7051FNjC9clKyMMVkiRihA1CaJaDA2IcQFDWPZI/UVLl+HA1wvpM6rzRAmQGQEjC5dn0z90Cu6vFr3uS+iZzHOFc1d+sVU6rAKMnkbDb/xvn6b+GgEZYqUyEiTqFqOQGK3kdHveakZDgzqM6gJsnt9FUzKivhVmltI920dD8O7EhSAeqz306Rj8CMJfFTg8yAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOGaxqVI2jQjQ9dLQZWP9L+BnhQTlmQOE92aPMdXEgA=;
 b=CDnrY52oCbKrOKqTjpkd2iAk4X4gPAjglU+BrCpTsRzkS7NfGzHG0cWafCmKIL3raBIhiuBZmprE1vHHxrghELEXmecgbFRKRlqbzTcqpBQYb3u9BNwOfj4GCu7xe61tUoN9nrlrVdEqwD+LPo/BiDp0vLBDzICfwpUvsOa2N9k=
Received: from BN8PR05MB6611.namprd05.prod.outlook.com (2603:10b6:408:57::15)
 by BYAPR05MB4104.namprd05.prod.outlook.com (2603:10b6:a02:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Sat, 23 Apr
 2022 02:04:07 +0000
Received: from BN8PR05MB6611.namprd05.prod.outlook.com
 ([fe80::2cee:3759:958:cf21]) by BN8PR05MB6611.namprd05.prod.outlook.com
 ([fe80::2cee:3759:958:cf21%7]) with mapi id 15.20.5206.006; Sat, 23 Apr 2022
 02:04:06 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IOWbnuWkjTogW1JFU0VORCBQQVRDSF0gaW5wdXQvdm1tb3VzZTogQWRk?=
 =?utf-8?B?IHZtbW91c2VfcmVzZXQoKSBmdW5jdGlvbiB0byBkaXNhYmxlIHZtbW91c2Ug?=
 =?utf-8?Q?before_entering_suspend_mode?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUkVTRU5EIFBBVENIXSBpbnB1dC92bW1vdXNlOiBBZGQgdm1t?=
 =?utf-8?B?b3VzZV9yZXNldCgpIGZ1bmN0aW9uIHRvIGRpc2FibGUgdm1tb3VzZSBiZWZv?=
 =?utf-8?Q?re_entering_suspend_mode?=
Thread-Index: AQHYVJik6ZiXy84TZE21dkr6CSpL9az8w6CA
Date:   Sat, 23 Apr 2022 02:04:06 +0000
Message-ID: <fbdf9855630074d2fd452e276c2d85486c3e39a1.camel@vmware.com>
References: 20220406100838.610519-1-zhouzongmin@kylinos.cn
 <3bctfczwmz-3be3d6eygs@nsmail6.0>
In-Reply-To: <3bctfczwmz-3be3d6eygs@nsmail6.0>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4-1ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0363f2-bd16-4308-915f-08da24cd8c59
x-ms-traffictypediagnostic: BYAPR05MB4104:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR05MB41046B4E4F48941F0F80BC26CEF69@BYAPR05MB4104.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHfpOz1LThmtTs09HgvAyV05xcPPcYSM4V8WS8bsQDfGiVkumdOZnNomN6DCrdeuzS6Hm7sBmH5ehnehTtp2Xi4W3+20UsCelHb1zNRSFoyG/esM3hQqiQzqRPEbw8xaj6DOJ3p35PCIV8daCC4CQHuTY7adBJShVYOxFq7JTmX/srjL3MdhwDwmk+K0HBXZEdiiJxssb+jJogc54YWqQV0IuxhNNczLmgE5FHteGbq/ZLSIhP9uGJ5Gl80WpdErfk4k0niRai5xgW55R/04uapAAEQnVxSf8JT5uOiJrqWc+EZL/dOY+fPjQzVjP2l3/H6ra8gz7dM0AxEzdBX3Cg/WmoTIsfE12FFnftdqWbUsFxNXevYRT4DcdOnxOCcnqLhlaDdp4YXc0c4dEps6KeHnPInge6O95X1V+YIJq8x4ZhZvVhGI9TFOvz4Zjf7Pg6QMC8WNBKsVf78n6sa/tJH4UyjFhZ+ZpaShcG29ECjNG9aQ9gO74bFWWjggKQ/T2385wEWf5aY9n5dF9e/6EHE2k0b5Qkaf/EqqZPdP2IKAjb+SWWzq3f9YaughL7hpoH9N/lHFr5cvC4MPz801Ugyph3LxQa0Yve6GwJzjVsHGrJ+UO2CC6BEkb6/MOKgT+gisrU9h19OfkhAqXw+lisH77OTpsQTxCkHMk0K+WD/bP763ZFlXjzL8MC+/TcU+eT6qtpt7/p9pvKcZSIQImFsp/gZf/voo32x51f9ja9zepQZXhyAWsPDACcAIhUE6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR05MB6611.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(122000001)(5660300002)(110136005)(71200400001)(316002)(54906003)(6636002)(508600001)(6486002)(38070700005)(91956017)(64756008)(66476007)(66946007)(38100700002)(66556008)(76116006)(66446008)(186003)(8936002)(86362001)(4326008)(2616005)(26005)(6512007)(15650500001)(224303003)(2906002)(83380400001)(4744005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWE2bHh1K2VlWnBGb2VTUTZFQ2J3RktNbkF4U1JwSXVxRWF3K04ySTdaL2tR?=
 =?utf-8?B?SHBlTUtCTXZPQ1phaDhhZy81Zk9JcDQydW9zeXRRcUdhSUxnOFo5QUJWWkc0?=
 =?utf-8?B?NWhGN1RicjBYZEFaOEVUZTFzZ25CbkgrUThGTGZKYXdZQ0J5YTNWYnBaTlBZ?=
 =?utf-8?B?MzJVaHpIU2hwVlNidDgrWE9lNkNxSUFvQkdreE9CeEJNY2dqOUFkZWNUNEFB?=
 =?utf-8?B?RG1PMCtVdU84SE9zSUQ4Zmd5dW1HbkhGRlMzc3pQeWV4Z0w2RE9JcFpmNUNo?=
 =?utf-8?B?dW92NVV2UEgzNkw1Ulh5UTl0TlV6a1hXdUExRU5XS29aNGdkNWhlZHJaRWlu?=
 =?utf-8?B?TXhFMjNFZFBVM1M4MlZDMlNvYmFrRDdIN3hlbE5lVXNDWkVtZzExWkVRWEc0?=
 =?utf-8?B?ZnQrUXpYR2lJT1BFZldrSUdXZ05qTHVjVEpIQ2hpR0pBODRyaXYrdE5RNENo?=
 =?utf-8?B?Nms5d3p6TFhxemJ4azQvUEpPeEt5QWU1emhYa1hKWmtIRlBjS05MWmpkMWVT?=
 =?utf-8?B?U0UzbmQ0THhGdU55L2JSTWtLSVc5ekZmd0hBbTRWc0pqSzRVdEFTdXUrR3Jq?=
 =?utf-8?B?ZDN2TUpDVERTWUx3Sk1QTUdwVy9xVkh2Qm9TN2pxQ1l5RFU3UFk2YTFGek9Z?=
 =?utf-8?B?WTVFb1VYWnQxZzdNb0RiTG9rUDBuTXEzTjRla1lxUHJCUVQ3NHNwZmtEaUls?=
 =?utf-8?B?aGxuTEZhWnJnYUR2T1d2dVRXUDNKNEl4d2xTdHNXVnMxaENPc1ZlckpZelZy?=
 =?utf-8?B?QnZZSVRUcDN1Y0pkckVadXVvNVFwckVsbXptTmFoUmVGV1lRbFV2WG5PUW1Y?=
 =?utf-8?B?a1NxWmtRQ3pvR0lVWWNkYkVOZUNuNHcvVUtmUmlSaHZCRlR0ckpZZTFkS3Vr?=
 =?utf-8?B?SUdPVlVERWEvVCttWkJNeWtuSStCMzN4UnI2Z0U5L0wrUkk5a1B2cS8wSU94?=
 =?utf-8?B?WXFyaWZnTTRTQitGenl0RnJORVVXS2JGMmlHRTNYQjhmTEhnbnJEbVFOTEJJ?=
 =?utf-8?B?SnB3ei9veVdoQmszNmJiNFh5ekphWnlpVFJoWi9GR1h1WEplUlI1a1hNSGNF?=
 =?utf-8?B?QnMxQm5lZVM1a3NXV05vaGJmckJXQTBTUEJraVVOV3M0bnFwcEwzeFdKSUgz?=
 =?utf-8?B?NlFVSEIwREZaNGExZDhVb2c2aC83SG5WWnJKSGdhcEJCTUpuZTArOXR6L1pB?=
 =?utf-8?B?UkxIbzdtUXJKZ2xiQ1czUE9MakM5MUNVYkdicDRIeFJwaTEvSjYyUEQ2RVRI?=
 =?utf-8?B?a1ZDalBmblJNR1diR1pKamhPWkI1bWhOTWdPd2trWHFNRVcwR1lueDg0UERF?=
 =?utf-8?B?U0FENEhJUkc2M3FrMVp2TGdpY2NFUzBMUG5zVjYxWnhjTC9nVlprSldETzUw?=
 =?utf-8?B?NEVYcEdxR21zOGljODU4MVpRQlBGWTFoTTZKU21BeGVPUFdYbGZvTy9XT1ZF?=
 =?utf-8?B?c1dqZzIydk1OQmtCQmo4Vk9MRlQzdVhFSThPaXRpVFZFbll2KzlmQVFiN213?=
 =?utf-8?B?cCtzS2VyakFiS3BsTGRmaHNhdHc0TmExbG9XR3ZKL3orNXZsS0RPbm1xMWlJ?=
 =?utf-8?B?ODNyRXdmdHZ5MTZMZVllSUQ0UEN6Zks0SHR3ZXdPeEZNQWwzci95VXJ4UzBs?=
 =?utf-8?B?RDMva25CdlhHbmRKNVdBa3E2ckRKcDBWcFhSaHlqWTNyeG5UOGZ6dkdUN0VN?=
 =?utf-8?B?L25mNzlsc0ZZbzFXQ1VTc1pqK1J5ci9KUU1MWTVIZ1NENkFyUDBVMzBHSWJa?=
 =?utf-8?B?UUsxdjdsVndyaDlGWXFURW12Z04xOU1tbmpSZWo1MCthTlJVZkJNQmIzVVpt?=
 =?utf-8?B?R2ZpWUhDK2drTkozOWFsM0VvSXpSSk5EZnZaTXZrdHc0NllDc2VBQVJoY1lZ?=
 =?utf-8?B?ZGNLZTROMjlIVnlUcE9kcUxIbXZtWnV1a1NMaU9POGIxWUVqNFNQR1ZlR0ZT?=
 =?utf-8?B?bmw0U1dJT3RBRUsyOFcxWHczK3RnT3pTK3JiRk9vYTBGRWlEaWJ1bzJocG5D?=
 =?utf-8?B?RFJXU2dBUDN6Z05oU0Q5WUIxZzlRbjNQRXNtbExzczczamNsRHZKeENLMnQv?=
 =?utf-8?B?TmFLdkJ5UkdMMVQzN2tJaU9BQjk3REdNTVdVZWpNZkI3cEZwNlNjUVFCRWFP?=
 =?utf-8?B?ZFBjNGxLUjI2NklsQmx0ZnkwNVp4eHhzMU0xUzZhT2NEd1IzeDN3RVp0S00w?=
 =?utf-8?B?ZG9HVFZrVGpONkwwN1BCWVpMZE44SEJMMGc4ejh6QXk4eDNBaEFyYzVwNFZH?=
 =?utf-8?B?d2hBS3ZWMVFyTXlrK1lYVUIwL0k1OTZEWjNmeHVHbXVGazhMUm9DYVVOdXhw?=
 =?utf-8?B?Q25LbjdQZUZhMTN6ditVNlAvS3FIMFNscTlKSitWaXNxS2gzdllwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DE981C617BA8D43B311BD2C3B5A250C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR05MB6611.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0363f2-bd16-4308-915f-08da24cd8c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2022 02:04:06.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PSDSMmNdrLjJ+NPN2qY7HsVEcJlEQIhDBal4+hTkPg+vX6jEWyxWYKDelZ5oXe0nLuIUJMxvN+MNDdxkVBkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4104
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTIwIGF0IDE3OjI1ICswODAwLCDlkajlrpfmlY8gd3JvdGU6DQo+IMKg
IMKgRGVhciB6YWNrcjoNCj4gDQo+IFJlY2VudGx5LEkgb2JzZXJ2ZWQgYW4gZXJyb3IgbWVzc2Fn
ZSBvY2N1cnJlZCB3aGVuIHVzaW5nIFZNd2FyZSBtb3VzZQ0KPiBpbiBhIHZpcnR1YWwgbWFjaGlu
ZSwgQW5kIHRoZW4gdHJpZWQgdG8gZml4IGl0Lg0KPiBJIGhhdmUgc2VudCBhIHBhdGNoIHRvIHlv
dSB0d28gd2Vla3MgYWdvLCBhbmQgSSdtIExvb2tpbmcgZm9yd2FyZCB0bw0KPiB5b3VyIHJlcGx5
IGFuZCBzdWdnZXN0aW9ucy4NCg0KSGksIHRoYW5rcyBmb3IgdGhlIHBhdGNoLiBJIGhhdmVuJ3Qg
aGFkIHRoZSB0aW1lIHRvIHNldHVwIHFlbXUgdG8gdGVzdA0KaXQsIGJ1dCBnaXZlbiB0aGF0IHdl
IGRvbid0IGltcGxlbWVudCBmYXN0X3JlY29ubmVjdCBjYW4geW91IHJlbWluZCBtZQ0KaG93IHRo
ZSBtb3VzZSBpcyByZWVuYWJsZWQgb24gcmVzdW1lPw0KDQp6DQoNCg==
