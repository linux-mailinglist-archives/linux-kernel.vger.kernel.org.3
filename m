Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A85A8601
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiHaSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHaSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:45:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE024952;
        Wed, 31 Aug 2022 11:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSlNyD/O8Ri+F2vZ69hkOnCveV7BcW9Ihlp0wpltAwByMY+FYDkzPAQg/05JRfnoz1pD8FvQ9PvhXd/rGTnrBbEpPTZgb5gFhdcnE/Y4ZdDZsXhae/LTWQcVWyS8CvqYhCQUeFD1QMttSVeKs0YQh2jwoc1F0z3dF9wInKDyXaotnQsJipgC+ZCzdLi2KVgKQNPphVtIiGo5EkDXPp2PuMRYG75Quqrv0QRskPJgaHR0I4At+qAKHjfMw8vfiTwI4EUvvsEtqDtpiowNPQWRo1IaHO3SHF7klBEtzGf9uGH5NFqSYlt21quR0ESMJYYqBgwLGSjIhOwxAIe5r64WVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6AwjToQQM7Lu5kHcYpHno7XSvW2F75Sxak8pcuVcEM=;
 b=D7i36GASNw51hyg0oKS8+wklqEe4J6/4s1cBcK2HjATZ8fWP/x3kALH7a+oNMUOCr0Kylvyy97zOLFfSg63vd73WUGMFCkapuxNX6fTca6wNDfVIWL+/rfN5sIKB5dCEGIP84NmsAQ0mLeBuWBiHpv6kIUlZUW2xzzTatP8CzPNuk3gAanAI4Uu2tBOJ6eNJMh2XJtTC9k+X7459fq6KfDGyP605eypX/naTvIXz2A/xrtf4kI/vrymjywrP5KTM6r4KqVuCi+PL35yF3oYSKw38tGTQEtRxyq9j+jL2w5eI7iDNWEfjCb9S0v3ck/f/sgbBlPS4QRCRUmAsOj+UbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6AwjToQQM7Lu5kHcYpHno7XSvW2F75Sxak8pcuVcEM=;
 b=a1QF0Iog0lGViTHJJM0FngnOV9SJsKjoWfzmRkhZVxI64norsx+NieNDMunj14K5YG4840GD7LqeAlqTOMnjDHi2tXS9fxkTtcOu5dZJrP9gbAas3XwCSEyruo6m/vHdquKqcyTV/4HS5gsHd0qnorOhNkzipVIvO1f6r4/xP2c=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 18:45:09 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:45:09 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Topic: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Index: AQHYtM841nPgSBs2aEa7V9yGUi8o5a27PdGAgA4sJgA=
Date:   Wed, 31 Aug 2022 18:45:09 +0000
Message-ID: <f415bae4-6fc3-1197-ba74-21192f29d02f@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
 <ff2e2037-b1c6-8c0c-a0b1-41986522a2c8@linaro.org>
In-Reply-To: <ff2e2037-b1c6-8c0c-a0b1-41986522a2c8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc0745b2-2b01-467a-4e35-08da8b80ee39
x-ms-traffictypediagnostic: SJ0PR12MB6686:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+6DKwGGpZATxvGKTJj8xjrLLqrl5/0jVMHyvHRmqib5MoDo556EZvwH7wwlT8YIRpEumj9xIDt3QqR4Fd+JlSispJ/Ui6uwwsIWIucM5Kr5jSN0PRuNCeYa9OKJyw7gFtU7YRJSgImoR8AhhaMcpUcN9VL10RLu0v1nnFtDxbmi6mp592GGRoaUsis8A3vNAw5+LVoWdaaPZvNirfzgMmVuy1rcwuUtw/WMyRGcY182Lx1GYYklvuNqOS4iGQWpGvHdwpWitpjpQDVqIE+/wqZVrRgO4drOgiLtep1gML7z8l1jD7fXGHr6R/5cOHBfwXocp6XfzKKSiUdWLL+QbPlkhfsO7h5Bxsf5lV5Y4MRoOe4HTmQlEOgoIk4Mr7+jO9lCoXah8LfRldZqbrHUewiriQqhUKZ3tDeX01mLGOGpkO+Nt9iEP3F5m9K9Zu2w1fXWkil5Yk1qytrPCyaK5rw3pv/KLhcXhm6ORO0xGnQEGT9cU7XAKc5pe6s77svDeDG0bLuFud4RVjKiUP05xgK1eZYrWhMEI8F82PVhllC3uC+pliaSOfZNUpwo9cApsNVkwjfLL+b4rXOdxCA2Z8L2o6xVUXOA7ZTZBd41ppqm9fWVv4ZGJe2lIJ4d8DcZEWw8DLz4/CRVPODcJjbb4UlQ9nRUoNsrzj/5Tbep6wlPKpsr5ru61oHcgXkmtF4GxYnxsx/wHbksW5IkX8A/k5/5/ZOnjNlc7Nniw9oy2qzU/whPRBQuDWUDijGmLV8DZkkS+uUDP2LUkEp26rjIc505D5KhB8LXjT46b2cUrFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(54906003)(6512007)(110136005)(71200400001)(26005)(83380400001)(478600001)(64756008)(31696002)(316002)(66476007)(2906002)(91956017)(66946007)(6486002)(86362001)(8676002)(66446008)(4326008)(66556008)(76116006)(38100700002)(8936002)(38070700005)(122000001)(31686004)(7416002)(5660300002)(2616005)(41300700001)(186003)(36756003)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDdmOERaN3M4UElyNzM0UmRTVUpnUHJrcStCWWVZQk9Nb1QvMXEzZGFJMjhT?=
 =?utf-8?B?QTI5U0pwSHowd2hOMFkrUHVnNURhZ0IwOVoybDFkUDMxS2NSYkp2WGx2dTYy?=
 =?utf-8?B?RkpqeVFPL1FFU1dHU0tsOWZoaHZFQWx1UmVqN0twNXVFbDc0dkU5QjM2eUhm?=
 =?utf-8?B?MkFOQXk1bUs2V3hhbVI1UmJ1WDBNSWpwVktnUlBQTTQwb0h4bUJTWnJyTVN2?=
 =?utf-8?B?MVZlZXl5amR4OFZyeTZXMnVJNUNsQzRnZVFlaVFCdk5RN3RKMnlQRFJqakl2?=
 =?utf-8?B?VjYxczFERHhjK3lzbGRCYldLR2lOR1MwSE9LN0NhdjROYUFWN29jY1hHeHg0?=
 =?utf-8?B?RzNQRWJFakR0b0R1L3RKUVA1YWlrNUtIRnBoNFBwYkpCdjlTOVdaWmpGdWdl?=
 =?utf-8?B?V2QvZmVBZm9oc1lkclpPNWhzWWoxNm0rUHM1Y041ZjNVTncrckwrL0NGNkM1?=
 =?utf-8?B?SWUrNytUcStSZWp0TGhNYkM0VnhCUXhjTnorSkFMRzVlOUpjSDIrOVFCVUZN?=
 =?utf-8?B?YU1qNFhjc3RNUldiZnhNbmZNNHdUWlVZdnhwOFBpSDJqVTY1UGZCc1FZakNE?=
 =?utf-8?B?UHNCc0g1YTlMMjZqdm50WUFmelVwTWRxdlY2MUl0REJvcWlSYmpsS2pjdkR6?=
 =?utf-8?B?bno1eHA1M3NsSXIzd3k4alJLUFBuSWg5K3YvUUx1dkJrTG5QVXJ1SG5ZdTZX?=
 =?utf-8?B?L2lyNWNGMC9PQUljSmZhZGRvd21MakhlVlFOa1VSZmIvRHNiYzd4SjZQekV0?=
 =?utf-8?B?UVAydmRUaW9laHpFcHdTV3lvamtKY1ZNZWtEbzJXV1hNL3NwYlUxOVo5SHVv?=
 =?utf-8?B?MVZ0VTlESi91eUFITHhXbk1ueENBN3oxa29wZGtnWVhWL0h1UXZORkFLSjcr?=
 =?utf-8?B?SnRhalVrYVNzUENiZG1zcnVZNjV1U1ZRWHlNWk14WS9EZkplYVpLa1VJYzZv?=
 =?utf-8?B?OTlkbHdWTVVDelZWTU05TVY0VGpEN3RHYkVsVDhxNEZhUTBDaG5OQXcvR0Ju?=
 =?utf-8?B?OW1Ick5vTzhlcmhCcVJKTFdxU2t5a0lYQUp6djR3aUFuMEI0VGQzNnBBd3dF?=
 =?utf-8?B?Q1Nzd29FeTh0N1dncldhdW9BZUp3WnpVeERSbTNsRHBzUTJqZElzMlEvQmdk?=
 =?utf-8?B?Y1MycWlmcWd4eW1ab2I2QnhBMDJnelZFaXNscjkxSzVQTWszVUxPZjZBckpF?=
 =?utf-8?B?d3llNHJMbnhjdlJTSytkYjVTUVg4ZVdjQUFFM3VkRlZRZ2tzTXpKTVdKQy9U?=
 =?utf-8?B?SXhRWHhKd0pjRVlmYmhMd00xeVU0WFlWc1BQOGtPTzkzSVFyb1lxNHp0VXJN?=
 =?utf-8?B?dG1PZml5NCtrNW93TW05TVUzT0N0QXVMMW5nZVZ5U294UC8xWmRkVkxqOVU3?=
 =?utf-8?B?OElabU5BSlpzWm9WUEQ3ZVpqQStWSTY5NVhSUGNHYStOcWtFbVZNc3RyWUYz?=
 =?utf-8?B?WHJ3SGt4ZXp0T2FGdFRZMDNCKzJRNnpSTGtEdW1Td2lxK1dQdG93WnJNRFg4?=
 =?utf-8?B?cFp5THJyOU1uVWgvaWh5S280NCtER3l1MkViK0RpSG9GNWUyeDJNN1RWbHJI?=
 =?utf-8?B?VUw0S3FWZTVIWXF3MmZZeGFFWGZNc0gyZzdaVVQ2N1FQU1RzWXVSY3NKeTVn?=
 =?utf-8?B?VW1XREgxbXBQOG1yRzRrT3NLOG83dTZSMXRKRjlRUzdQa0tMZ1hLb3ViQjB6?=
 =?utf-8?B?RHZET2NFTFdkWVR0cUI0NTN3eFJscXdUQUowWUt0czM4blZqTDZHYy9ENVVE?=
 =?utf-8?B?d3pCSDRqOTJBM1F0ekt0TFYwVEZ3ZjlmSHJHKzJyWEUzTXJDWGF6QURrUUZj?=
 =?utf-8?B?VGJmR2hCN0lWaUFCZmN1bm0zOEhFQ3N3VE5BTTRQWk8rYXNhNjEzeVBaYTZM?=
 =?utf-8?B?UE1MRE1CT1JOcVhnbGtvcERUbkhYSGx6TVMrN3JoOWJUNUNsTDRCZ2ZLaVYv?=
 =?utf-8?B?OHhMRjRlSFVaQTNaZDRIa2dSODk4YjRvZThXNENHM3p2K0xkcGVWVEg2RkRa?=
 =?utf-8?B?dndkNlZYS3haTFpWUEtJREZMczgxMmV0NTZ6cnlqWkFkbXlOaCt0Y205b1pZ?=
 =?utf-8?B?eUNXNEdXZEgyUVFzc09LQ0pha2VSdjc0Z25qUG5nNXpGRWFUbVdoY1hyZzFE?=
 =?utf-8?Q?UeNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC706DE31141474BB3D41F99260BBB6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0745b2-2b01-467a-4e35-08da8b80ee39
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 18:45:09.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: catrMoFsaOhrjoQm9Ja6b3R4NXjrih/MkGr+tFZbn9bL6r5LKh6kpil9MGF4fxD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAxMToxOSBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjAv
MDgvMjAyMiAyMjo1NywgQnJhZCBMYXJzb24gd3JvdGU6DQo+PiBGcm9tOiBCcmFkIExhcnNvbiA8
YmxhcnNvbkBhbWQuY29tPg0KPj4NCj4+IFRoZSBBTUQgUGVuc2FuZG8gRWxiYSBTb0MgaGFzIGlu
dGVncmF0ZWQgdGhlIERXIEFQQiBTUEkgQ29udHJvbGxlcg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNzaS55YW1sICAgICAgfCAxMSArKysrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNz
aS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zbnBzLGR3LWFw
Yi1zc2kueWFtbA0KPj4gaW5kZXggMzdjM2MyNzI0MDdkLi40MDNkNjQxNmY3YWMgMTAwNjQ0DQo+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBi
LXNzaS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3NucHMsZHctYXBiLXNzaS55YW1sDQo+PiBAQCAtMzcsNiArMzcsMTUgQEAgYWxsT2Y6DQo+PiAg
ICAgICBlbHNlOg0KPj4gICAgICAgICByZXF1aXJlZDoNCj4+ICAgICAgICAgICAtIGludGVycnVw
dHMNCj4+ICsgIC0gaWY6DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBh
dGlibGU6DQo+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4gKyAgICAgICAgICAgIGVudW06DQo+
PiArICAgICAgICAgICAgICAtIGFtZCxwZW5zYW5kby1lbGJhLXNwaQ0KPj4gKyAgICB0aGVuOg0K
Pj4gKyAgICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAgLSBhbWQscGVuc2FuZG8tZWxiYS1zeXNj
b24NCj4gVGhlcmUgaXMgbm8gc3VjaCBwcm9wZXJ0eS4gWW91IGNhbm5vdCBtYWtlIGl0IHJlcXVp
cmVkIHdpdGhvdXQgZmlyc3QNCj4gZGVmaW5pbmcgaXQuDQoNCkFkZGVkIHRoZSBkZWZpbml0aW9u
IG9mICdhbWQscGVuc2FuZG8tZWxiYS1zeXNjb24nIHRvIHNucHMsZHctYXBiLXNzaS55YW1sDQoN
Cj4+ICAgcHJvcGVydGllczoNCj4+ICAgICBjb21wYXRpYmxlOg0KPj4gQEAgLTc1LDYgKzg0LDgg
QEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDZnMDMyLXNw
aSAjIFJaL04xRA0KPj4gICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwNmcwMzMtc3BpICMg
UlovTjFTDQo+PiAgICAgICAgICAgICAtIGNvbnN0OiByZW5lc2FzLHJ6bjEtc3BpICAgIyBSWi9O
MQ0KPj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFNRCBQZW5zYW5kbyBFbGJhIFNvQyBTUEkgQ29u
dHJvbGxlcg0KPj4gKyAgICAgICAgY29uc3Q6IGFtZCxwZW5zYW5kby1lbGJhLXNwaQ0KPiBEb24n
dCBhZGQgc3R1ZmYgYXQgdGhlIGVuZCwgYnV0IGluIHNvbWUgbG9naWNhbCAodXN1YWxseSBhbHBo
YWJldGljYWwpDQo+IHBsYWNlLiBUaGUgb3JkZXIgaXMgYWxyZWFkeSBicm9rZW4gYXMgZXZlcnlv
bmUgbGlrZXMgdG8gYWRkIHN0dWZmIGluDQo+IGNvbmZsaWN0LXN0eWxlLCBzbyBqdXN0IGFkZCBp
dCBiZWZvcmUgYmFpa2FsLCBmb3IgZXhhbXBsZS4NCg0KWWVzLCB0cmllZCB0byBmb2xsb3cgZXhp
c3Rpbmcgc3R5bGUuwqAgV2lsbCBhZGQgaXQgYmVmb3JlIGJhaWthbC4NCg0KUmVnYXJkcywNCkJy
YWQNCg==
