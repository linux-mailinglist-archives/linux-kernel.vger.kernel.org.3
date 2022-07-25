Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF6580715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiGYWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiGYWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:07:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2100.outbound.protection.outlook.com [40.92.47.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472D24947
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g26/HbszGkOMViyuam33siuABPkJtnE7z5d3EmG9HpRMF5am07vtsh+4ka6MRisa+4fgxK63v5pURthazfvetbIntW0hJEtyXg3wVqf1DX2XwDRj58qM9sJU++mgoJtPevNJzGpZe1aadO/XR8mAFiUb0CxBUUq3aigE0lfV25iY9yYwtA3VLwnxMUySFuxSR87g+lsbuXt6CAUP/ujs50L+/BfrU23JkvQr70hbGmWj8nP3YSnOBl2rtV4qhRzmqgP8Zu1QdTsy23hmWtYmfIyzaxWMrniPvk8xjCJ/QQNH5FN7Hq/AllyRO2KCXI2W4o/IRKKdc4qmey5IxgsHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpdf9koVOGk1iHf12k2AINYXJh6WRzvVGNkjnM9hS9E=;
 b=UMu7qASdVTrXctvCnkNeNDheUpNj7QQW+nb0E+oA58ZmhXQ33TEVjjdSKxZjPNy1da7DjnlE2FR9dfqr4rTGvY6TLa2llHFLawsjUDhyhW/+0GcHToUw2ujQq20hGvAfQPgy/FBpOG9vV3V7v6EUj7gaNcSqN4666905h+9eQtyPJykzuSO6LO8Hjc8fY2XDqBbot2KHgiVW42/2qeegVxHfnG2Q5y4qq40q84adwnJGMDM76kj00EI2Uxnkfz47cHiGGVPxePVlpY8pO9o9RvqMUKAt5qPBLjzEc6PuVJqTFb4DYgbSFFLP0mdMUAjPZ2jGbYa33CNZuJfxVU33qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpdf9koVOGk1iHf12k2AINYXJh6WRzvVGNkjnM9hS9E=;
 b=Sql9CYgSBCX9UNfo1SWna4E6xMNXfsgPjIn6lQcPkSzwyV82/dAo+FKiOWTEOw7NgaGVu2suS6ys8VNoA7A1J2oRFSRNWJiBO/uw+5TmcHHg1f3VbzhKtxnlKSH8UQc9tuoZS1KlSx6xWWeIcR/RuIiODOuLwFg7dqIMSyoU+bWuprn/k6rmoOzV9bVllDfVuHDIu5wK3wnC9PBuCQzrT8bmy9iocY94FRqy90rH8flOSsifDCt6ShU6n6efHjpQQeg0yVph52VbamI0LkqiWaoAnpTHZa7xYpGSCjpNt4naDbPAdmKB23mVKmbZ1lUl3SuMWSCF7ILSfEEFsUtiqA==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by BLAPR17MB4180.namprd17.prod.outlook.com (2603:10b6:208:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Mon, 25 Jul
 2022 22:07:25 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 22:07:25 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>
Subject: Re: [PATCH] mtd: rawnand: arasan: stop using 0 as NULL pointer
Thread-Topic: [PATCH] mtd: rawnand: arasan: stop using 0 as NULL pointer
Thread-Index: AQHYoBjwrgb3QDZZqk2l3gKc/X6vea2Pm+f5gAAJv+o=
Date:   Mon, 25 Jul 2022 22:07:25 +0000
Message-ID: <MN2PR17MB337508661E6AA12D1B3E8F78B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725112108.686347-1-gongruiqi1@huawei.com>
 <MN2PR17MB3375A61331BC4E0E5BA6F9C4B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB3375A61331BC4E0E5BA6F9C4B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [N2efh5dF8jGCYJQA1bvgDetRA4Vf8us3PzK+2V01KaoXyJf/pPSw6xLnzLyHZAhF]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6905e2a7-6b98-41de-ab0a-08da6e8a0ebd
x-ms-traffictypediagnostic: BLAPR17MB4180:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlLo2EidZZCqmIFW+QTPCiH4cZxmsQmqySQjY0op+zkNcBUI7ddZpvjbf3KgKUcF0lAHQMklGVlsxwcuHjjVTQLTtQq6R7ys4q25H5S3PmETslPka22HOSX31eT5SnKyk0WAz8noLpAwqCyPnhXHoRco+AbY/qJsW/KwNuxiBqihKVV5u+d+4jBQXqIfb0yd2L+oclms2aZ/YIGfjWmcfAh76Z0IIqCjTDA2/b/gDra1w12tZUae+1CFMc64gZMJPjchfgVMd2hb5ixEs5gjpwLk6DFKbx+fPhRQd0utmUeP8SvTimcgsy/hHjlF/XQLfKwgPbNPSw/UK+eGOzMrGhZpIi3le9EgolMRF9ecwoMOlLtOBA967NmKwIU4dJzmI4TRKF5Lh8iWteCl/pE7+T9h9il9IEslcew3xQmOV04PQICWtlKj5LRWPf7N+wrpcdWA5A+qD2Hz13ZBRUuhM3rlVspKU8oGJrPxjxp16OhZogWgc+8Ws5ztQwFIx558xGSOBnWnEQX90/LfIVLKjWAPyP6W9W1jK7o+CPeAzCoQicLNhc9L4W2/R6eFy7r710Da83L0IB7/7Zlr0KEVnXIFY9j6FqRvMR/Ch0YKquCiZgoEqdpopLIFt6Msw44LSeiBBhvpF+lHQKc9fn6XaGLjB546t+HZIGG5XVipkb32/LdZm8GHFncdqfmIbN8q
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpzWjBIYlB6VFpCcHRxM1lBWSt2SEFJN2pzbC85MGo3RCt6TG5zMllUdnpq?=
 =?utf-8?B?Y2Q5S2VURDNseXc3NHlCNzJ5SVppU3JENXdqVnc0WXRwUk5kUzlEMWdpNWJO?=
 =?utf-8?B?WWtyaU5rdlhTc0Z4emFqODM1c3JuWDAySU12ei9pQlZyZFFySUVYcCtWR2tY?=
 =?utf-8?B?NmxvNW80SDBoenNOQjNIYm1ZYkQ5M2l4UHU0S0hvZkVQTWVFdXlLeG1tYmxP?=
 =?utf-8?B?SUVYYzJxNCtTWnIzdkNMT0hYR21ZNWFnMUhXZUZISTd1NkFzeTE2TzlSbi9p?=
 =?utf-8?B?bDY3Q3ZxSFU4bVo4UG9zb0ViU3Y1bkV6MUk3Ujdaa3F1dDVLQUlzcW84RElh?=
 =?utf-8?B?RXE3c1hpV2pQT3B1azhBWTBUMDFYTmlidlBUTUYwSXVBdENpK2RhUlhWdjJU?=
 =?utf-8?B?NDV0dnVRb1IzV2duOWk4TDU1aGFQczBmejVQSzZTQ2FNV1Z5WXcrTmtZb2Fk?=
 =?utf-8?B?a2lYTEtFR2Y5cURmZEN1OUpPekgrZXRUWURmQ20zSC85cGJmbFNpK1hFZ2ti?=
 =?utf-8?B?SDdsYmRpODA3N3pFK2V3SXJZRDExcGcxTVAwRzFocmRoMlRNd3pjcjJ3aUk1?=
 =?utf-8?B?STUyVmkzdXhrakRDc3puMXR1MGlKVnBYSjVTVVI4TzBGeWlSQ1drYjdITXMx?=
 =?utf-8?B?S1JnQWJlZXBkWWJjVWdyTk5NY3d3bk1vS3kxT0pMbnRXeEdRZ3VJRmpmN252?=
 =?utf-8?B?SE1Ud01aM3FXQkozRldiN3BORFlTMWZxczVEQXYveXVjVk9jKy84U3lodC95?=
 =?utf-8?B?NnVadnZ4dnRVbGNGMHEyWkxrdDIxVERWNXJOQXB0WVhsVi91WGYyN2QybDJ5?=
 =?utf-8?B?U0VFc25HT1VvWmMrK01Jd3RzZHltcU1xRnh3eGxzbWpodWlvdFBNMWJNendH?=
 =?utf-8?B?OTBlanlBWHN6dU1RaGN5bG0wZ25kZmZsTEs3V0VNeHM4MjZPNWtkZWFIS1NN?=
 =?utf-8?B?cFNBSVJaMzlpbnJwSjZyRVJUUG5BT0VQb1lPK21XYVNnamMyZUdhUlJzcmtp?=
 =?utf-8?B?SDM0akJKeUhCTDRDK0tzZWVGL1AzOSttai9QTFhTRmtjYk5DZ3hEeEtySWla?=
 =?utf-8?B?QnIvY29kbldGdlNpZFhEb0VISXNxR0xHeTNzbmJwQ3hYQzI3RDMzQUE2eVYx?=
 =?utf-8?B?bG0yWmZMQk1ZcHkwbHBERFlJRFhlZWdaQ3EvbXVGMkNJcklraHpUZDRRbUVi?=
 =?utf-8?B?TjVpeVdmUkU4V3loWitXclIrQXUramFrNFp0UzQ5OXJNZnN3YnZVODFpcHJZ?=
 =?utf-8?B?cDhLNi9Vb3BFdHUzWSt5NVBoLzVObHUwSXB5dWsyTW9EeUhaZytrZjNpM3dM?=
 =?utf-8?B?dlpnTi9ydGUrdllnREtwUCtrUCtFbEZrT0VCaEpDRkdIbkRWK2p2T1E5aWo5?=
 =?utf-8?B?TTZuSFQ1amFVL2JoSzZZeEk0TG1GN1k2eEd6ZW93MHlzdzZHRVJtYjN5b3J4?=
 =?utf-8?B?ODZNOFRIOC9zalVJOWkvd2JQdDRoQXVUQ09XQzBlU3E0aWlHOHJLOEZLQUZi?=
 =?utf-8?B?dkw0WWlhT0lOUEVldFoycFI0S0dlUVo5bndESmI4YVJPMGNMWklhSDViMURS?=
 =?utf-8?B?UStSZm8raVhvUzhFdmFMWDgrSG95UnRnVUwxMExmR2thR3VVOWZhU2toM1U2?=
 =?utf-8?B?NmEzMTM0dFpxWTVIa2VibTExNWVwQ1ZtUndiSzNXL2MzOWV3dEJXKzc3YjAv?=
 =?utf-8?B?MU5rOUFjTTV0L2ZNWmxBalc2aTBQS2oxL0xJL203R3NRZ1VTV2VBTkZneDVp?=
 =?utf-8?B?MzRCcEIxakdZbkdGREZiOHd1bkxENm5VZDZQbUZUdjZzZTVtYU9uWkQrOFYx?=
 =?utf-8?B?TDJsYnYvU1FmbDBReTlDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6905e2a7-6b98-41de-ab0a-08da6e8a0ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 22:07:25.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR17MB4180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S29vcPCfmILwn5iC8J+YkfCfmJHwn5iR8J+YjvCfmITwn5iE8J+YtPCfmLTwn5GA8J+RgPCfkoHw
n5mI8J+ZiPCfmYjwn5mI8J+SgfCfkYDwn5GA8J+YkfCfkoHwn5iB8J+Ys/CfmI7wn5i08J+YkfCf
kYDwn5iR8J+YhPCfpKPwn6Sj8J+YgPCfmIPwn5iR8J+YtPCfmITwn6Sl8J+kq/CfmKXwn5iw8J+l
tfCfpbXwn5ih8J+YofCfpKzwn6Sv8J+YrfCfmK3wn5if8J+Yn/CfpbPwn6Sp8J+luPCfpbjwn6W4
8J+ZgfCfmKnwn6W64pi577iP8J+Yo/CfmJTwn5iU8J+YlPCfmJbwn5ij8J+YovCfmKHwn6W28J+Y
sPCfmLDwn5il8J+YpfCfmLbigI3wn4yr77iP8J+krPCfpKzwn6Ss8J+kr/CfmLbigI3wn4yr77iP
8J+ltvCfmLDwn5iw8J+kq/CfpKvwn5iT8J+kr/CfpK/wn6SvDQpPb2lnZ3ZrbHBvdXJl8J+krPCf
pKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+k
r/CfpK/wn6Sv8J+kr/CfpKvwn5iT8J+krPCfpK/wn6Sv8J+krPCfpKzwn5mB8J+YkvCfmI3wn5iS
8J+YkvCfmI7wn6W48J+kqfCfpbPwn5if8J+YlvCfpbrwn5ip8J+YqfCfpKnwn6Wz8J+ls/CfmJ/w
n5iW8J+Yo/CfmYHwn5ip4pi577iP8J+Yn/CfmKvwn5ik8J+YrfCfpKzwn6Sp8J+kqfCfpbjwn5iO
8J+ZgfCfmKnwn5ih8J+YtfCfmKrwn5in8J+kpfCfpKXwn5iv8J+YtfCfpK7wn5is8J+kpfCfmJPw
n6SX8J+kl/CfmLbwn5iy8J+kpPCfpJDwn6SS8J+klfCfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i1
4oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKA
jfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn6SR8J+YvPCfmL3imKDvuI/w
n5KA8J+SgPCfkbvwn5G78J+Ru/Cfkbnwn5G58J+RuvCfkb3wn5G98J+SgPCfkoDwn5G78J+SgPCf
koDwn5KA4pig77iP4pig77iP4pig77iP4pig77iPDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0K
PiBPbiBKdWwgMjUsIDIwMjIsIGF0IDU6MzUgUE0sIFZhbmVzc2EgUGFnZSA8VmVicGVAb3V0bG9v
ay5jb20+IHdyb3RlOg0KPiANCj4g77u/U3RvcCBmdWNraW5nIGVtYWlsaW5nIG1lIHlvdSBwYXRo
ZXRpYyBsb3Nlcg0KPiANCj4gU2VudCBmcm9tIG15IGlQaG9uZQ0KPiANCj4+IE9uIEp1bCAyNSwg
MjAyMiwgYXQgNzoyMyBBTSwgR09ORywgUnVpcWkgPGdvbmdydWlxaTFAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+PiANCj4+IO+7v0ZpeCB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nczoNCj4+IA0K
Pj4gZHJpdmVycy9tdGQvbmFuZC9yYXcvYXJhc2FuLW5hbmQtY29udHJvbGxlci5jOjkxODo3MDog
d2FybmluZzogVXNpbmcgcGxhaW4gaW50ZWdlciBhcyBOVUxMIHBvaW50ZXINCj4+IGRyaXZlcnMv
bXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYzo5MTg6NzM6IHdhcm5pbmc6IFVz
aW5nIHBsYWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IEdPTkcsIFJ1aXFpIDxnb25ncnVpcWkxQGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMv
bXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYyB8IDIgKy0NCj4+IDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXJhc2FuLW5hbmQtY29udHJvbGxlci5jIGIvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvYXJhc2FuLW5hbmQtY29udHJvbGxlci5jDQo+PiBpbmRleCAyOTZmYjE2
YzhkYzMuLmVjN2U2ZWVhYzU1ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3
L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcv
YXJhc2FuLW5hbmQtY29udHJvbGxlci5jDQo+PiBAQCAtOTE1LDcgKzkxNSw3IEBAIHN0YXRpYyBp
bnQgYW5mY19jaGVja19vcChzdHJ1Y3QgbmFuZF9jaGlwICpjaGlwLA0KPj4gICAgICAgICAgIGlm
IChpbnN0ci0+Y3R4LmRhdGEubGVuID4gQU5GQ19NQVhfQ0hVTktfU0laRSkNCj4+ICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4+IA0KPj4gLSAgICAgICAgICAgIGlmIChhbmZjX3Br
dF9sZW5fY29uZmlnKGluc3RyLT5jdHguZGF0YS5sZW4sIDAsIDApKQ0KPj4gKyAgICAgICAgICAg
IGlmIChhbmZjX3BrdF9sZW5fY29uZmlnKGluc3RyLT5jdHguZGF0YS5sZW4sIE5VTEwsIE5VTEwp
KQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gLUVOT1RTVVBQOw0KPj4gDQo+PiAgICAgICAgICAg
YnJlYWs7DQo+PiAtLSANCj4+IDIuMjUuMQ0KPj4gDQo+PiANCj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gTGludXggTVREIGRpc2N1
c3Npb24gbWFpbGluZyBsaXN0DQo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW10ZC8NCg==
