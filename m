Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEA573E71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiGMVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGMVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:01:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708A326EF;
        Wed, 13 Jul 2022 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657746110; x=1689282110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZmxxFoVkYGqzpsEpNtr1jHCheBRTu1N3S2zZO5drZrU=;
  b=Ht3N9j2xcW4KJbXIJiG/DzSQXWmnoeXrm2QEgIE3U2X4P6qAFga6+976
   f1FIo9q/yY66iJzYZnYkJ4ywAynAE0z20+6bfHsY7uNe2BL2oUjn6JFQi
   JSsqs+nNWSHwCohsFBdDxe/+3hBub0sL+3Yh3cOhZFGq0x6NQbcVUwmYN
   EwXb+fp2uuhXP8Pm3F4AvP9StWtFGXd+Xdj4Gghz3m6Cfy9P4WhR62IBp
   mwqNBCMRJtQsj41RRYAUhtpKRe8sMWh5EZJwu576lOkO2+Jq58iWLJrJx
   zKsM09i+JngeSfWKDZVtv0ZL7ZeMCnE6JrgciyxHhPIJ5tDMjebXB7+WZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="164629369"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 14:01:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 14:00:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 14:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA7aGs+tLYXFbM30OMzOGxdPE1CL2vuvbtUkNTH+AbOZKLlUo4ulbqBYnvoX3/sXZ9Jz2oq7fkMVhaZDL6Ig6k4rPHohs2hEP8NohCuiWFTHKr1tjqtvTvMde+M31iK9z5JvgsVHarDg22fHNc8vHDkV+Jyf/H1YG9kVk42mocb8PACsJGPjSMRUTX9y20P9GB+ahgLjBItTJSzHtsckXlFdwoFwJL92W+ROu74RAQy+YzJf4pVpdB9w9Z7TtJWcUCC3hrVJZbmkpa2Hy/OsY2Vq/i1Ou6ylA9im/IakooUQBBK9d3/Hr/uGJv0Gjw2RuMEH2CE5h6tKzVVWFjPmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmxxFoVkYGqzpsEpNtr1jHCheBRTu1N3S2zZO5drZrU=;
 b=EDsZF6GtLZS3sgAvpXlSwKUQjVAjcKnbMaCZZvCHK3aY5YmnbQwZzWJHll8ix06JAj43QHnfz3U6kMrcUSPPzqt03y2TiUe5EcwKgGxaP24zfljK9nzTIxZRS/96o+0MBSmVZSNhO9siVHCqmPtlEgKimrA2KBb3LlaAerarUvkR+tp1jk2teBgkZQEB+IJlNHd7qN9uQgDRitYSOY3DQeIzuNdqwp1mQIHzuhPJ05/q/3roKTg788cgQ3MM1jebfk3siM4uElpG6W7kITfhvPW7/CRC7Z1Yj+HAO/6uGIORj1c0HcYQWNJ6ZxxO4po6TjErKlaS8pwTPKrUYWb71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmxxFoVkYGqzpsEpNtr1jHCheBRTu1N3S2zZO5drZrU=;
 b=ovAE01Z5U+oxjIkHeB2A/7x81wVOknUEAIfebhCeoTqyPGkUyA/R1tWU+UY/1qfNV8qNfYsbHFeb+rliXF9wsFD40VB81gFdgROMxAWhREu0zpdMnbg7IOvtj6MisabOnyg/Ibn7PZUgGupKryQsxOUzvxk/iy0SHZwCwfu6Jck=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 21:00:46 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 21:00:45 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYlqemr2KX1URl4Eaxdmj5tFzD4a18KWyAgACggAA=
Date:   Wed, 13 Jul 2022 21:00:45 +0000
Message-ID: <9e00e2cca641b735fe56988ca1eec1aef183f481.camel@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
         <20220713105910.931983-2-lewis.hanly@microchip.com>
         <776164f4-21cf-7720-3cf3-3b30b72b8b29@microchip.com>
In-Reply-To: <776164f4-21cf-7720-3cf3-3b30b72b8b29@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deb59b53-a72b-4fba-6933-08da6512c1a0
x-ms-traffictypediagnostic: SJ1PR11MB6250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QtMpC5hbRWE7bee4Y2lntJX5wZj37VsrToGpNqMBjKZifB1vlt0fVhOuPDMd0yRWefgc7P8vyAMlcdIH96fvPZL1pLoLxIp5HPa30Ju7GFdu5/JmjdK47sDW/aerEm+V27rj9gQr2WEMU84TRyGq9xKQASxmeuBm1sQKZ4upSB/swls7tUjmBtGNiFPIku1yOm6fYz6k7b60XyY5owo9VLqgw+KSqoHmfHE1CuLekMXbkNCYT7e2Dndd9IvBB1bb4h5pbUZXIxBj79fRHsV72RYQH1wghrU1YQQuxM1y/v6twJH1I44sPT1PEUPMit9wTZa5TMivoHdnY1Uuu+Q3JklL7pF39aMoki5C1aX1qSfYscjzLv67+/m54WV5U9iam+lF/VH6hy0j2i+oULKGmYs3RWBpe8wZ2a3PtpRhlz/if5t0OgmAdnOry6OxyCjwljPlBwa6n/MzjPdpFUEXqRNA3+QaSaZcxyfXpELP8rtXr5VJ6EcFlQhMahqyQsfFu2v0XteUGJixXlol3eHgRfR+HynF50MUWfvPgT7u7OobVjbUt9rTyYRSBXl0OsVa6LypKln57n8wY/nYuyTH5Oe3+E0dqvhIOdcHRrUpJ4SDOSfv6kaXZFU/BUvgjDn1PbefgiM16DP9itjIGoVSZKirDihp4Y7HHCNDSK5/ehkjeYeXwa1QdZbESXduCxUUUHVSdwjNvtzKKnO1VTXonJ02nOpt1zXbGK6XqfV6c2Hl+0AUjdBAiS+lhTip+//Tj+k0F5/jMUwR7ImZf4eLntYcjljYdtBGO+6gVvKopnw3ORA6GrlMQpVLZoYVHkJj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(136003)(376002)(346002)(6486002)(86362001)(26005)(91956017)(53546011)(6506007)(6512007)(2906002)(41300700001)(478600001)(76116006)(38100700002)(2616005)(8936002)(107886003)(5660300002)(36756003)(66476007)(186003)(122000001)(4326008)(66556008)(66946007)(83380400001)(38070700005)(54906003)(110136005)(71200400001)(64756008)(316002)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0xla2xwdEJzWGl0cHZEemZwcTNHeHIyTC9Qb2puQjZuUXVJZHVVb2FyeElv?=
 =?utf-8?B?aEJueGJQVUN0NnpEUW83RTRDSnNOeDN3dkpDUlUzVjlZbk9lck51K2p5U1Jz?=
 =?utf-8?B?S1VxMDJlclNQK1ZKSkxLOU1tYTg2VGNhYmZYUFFlTklkaFRvSmJmUG1vamlD?=
 =?utf-8?B?c0NESngxcytnaWJpRTRVRlVUd2k1WXROSGFnVXA1bXhxY2xKbmxoMG5MYXhJ?=
 =?utf-8?B?cGc0NzVxS2NQUEc5ZHJ3UWVmdk9RMi90QVM5Z3JNT25IcWx0b3JUK0pPQWJN?=
 =?utf-8?B?R0hibkZXS0M4RHVBcEFPRzUyMGtvZ3ZGQ3lKcDdrZ2RhbE1iMDZsMXF4Z1d4?=
 =?utf-8?B?VmwvRkNpMS9rSkd6SDFYTFNPWStuUWR5TXNkSE1jeGpKbzhKZ0V2MUFUT3dK?=
 =?utf-8?B?OG4vb2oyajJVWUpaaFJuTjNQdFFnUjBrQTd0TnpLMzJnbkhsSERYNkN3OGFl?=
 =?utf-8?B?L2tsVU00SWk1M3NlU1p5NjBXakVSSXA5SFJ6S3RRVGRoZ09jRllMcTF5eW5x?=
 =?utf-8?B?cmw1ak5ydDZJWlEvZGV2WDVjTWFxU0Qwc2VZQjF2SHAxc3ZqZkR4UEV6TmE2?=
 =?utf-8?B?ZVBmQUgvZ3N3eGl4SmMwMVZuQXUvVllJM3c0UUovbEJxM3FGT2xJVElsSitY?=
 =?utf-8?B?MkdNUEQ0REptRTFpT0ZQRmdZcDJLY0NQelBFR2JpTFFPblliN2I3VTZkQWNP?=
 =?utf-8?B?WGRIbUZEK3pHL1ltNlFIY1I5Wk5BcUxrVEFsMEdxYzFCUXQyTWlFT1lNNDc1?=
 =?utf-8?B?bWxnQW01RFUwYXBuNklrUnBZT2g5K0ZIVmhBSzhINzNzWjNoQXdRRkJxM0NU?=
 =?utf-8?B?bGQveXl6ODZLdmJRU2s2L3RkYmx4aHpGa29teTl6cFlzK3c0bjVOYkYxRjNv?=
 =?utf-8?B?YWhyOU9LZkhSMThBUW5qT3d1bmQ3QTFJUGkvay9HNmVIVjdmd2x3cVp0eE0z?=
 =?utf-8?B?YUJBRHpvM3l2QzBCbzZEL3RKWUFsRXRkdVk0ZHRUY3diblJ4ZzJiMk8xRW4z?=
 =?utf-8?B?TFV4bExqTkJjTjdaM0xWMmFwVmNpb1htUXg1TFI4V1l2KytxWCtTYmZHcHBS?=
 =?utf-8?B?alg3czFIMkxKSWlsTUtCbzVVOHVvVDAveHZCTk1NejQ4TVNGMTdoMm52NjVD?=
 =?utf-8?B?MHVmNnlxTW00WkVKdG9kWlBrdG5QbFRseUt1bjFwTHRrZG5PY1NneU9QVkNj?=
 =?utf-8?B?d2NwRmc2NTdLejYvRE9rOGhQZHVoUldCNzNxVi85NnI5OVVNZlVYQ2xXbGNN?=
 =?utf-8?B?Q2xPSnBCUFFGVnBpcDZ3TENVWEFVVTIvM0tJZ2RUTW1pNlFlV1VTeVFLTVY0?=
 =?utf-8?B?N3BkQzF6aFJDUUs4dDBzN2w2OElvUlFXMk5lK1FhMHpkNXlHOXlhcVRVcGRr?=
 =?utf-8?B?d0lXV3lWNjJrZDdyc1RueUFqSXp1c3BVaXJVVDcwTjRUUUxGTCtNTC83TTd0?=
 =?utf-8?B?NlZEcmNDQjBIdEZCMjVram9Zb0NSMmZkbGFmRVozSytOMGNlSUEycU5rRUNT?=
 =?utf-8?B?Vi9PbWtTUnEzNW9adzZnTk01OVJ0VlErSTF2VVBYYkxSRXpIL0w4NWlsdmJp?=
 =?utf-8?B?NTc4dFNPMnR5cVFmaU52MTdtZ2gvTTNFWlNQdUpDUWQreEFBMHF2cVdOQ29r?=
 =?utf-8?B?NkRXZXJOVUZKTmJ6RXhrd1JrY3BMTGhxd1V1Q21odTZsTW1jZlZaMDBLTDhk?=
 =?utf-8?B?YTNuWUowY0crbFJuVDlvUERHL1JST0R6WkhnRHNkNDVFWFhLMnc3ZXZZQTdR?=
 =?utf-8?B?SVAxWkUyckJLN2hnTDFiS2VyWHE3UlRKdGl6TVdlckZIQjZoVTZwdlphbVZ1?=
 =?utf-8?B?ZHpNQnlaaDkrTWhnRktBQlRFVFVrR2trTjRGRTJpdjB4NnlFMjhLSWRQOWh6?=
 =?utf-8?B?NVgrdm1DbWV1c2ZlM3dtaE5MbWxvRlI0dUdiK21NemhNWFpBaUJ3bmRJTi9P?=
 =?utf-8?B?R3RGODV3bnJ3Z291aFhQallJZ0JrYk1TbzBDUmFjdGVEMDRwUktGTVFLekhv?=
 =?utf-8?B?ZWlYSERoS3pzbGw1SkV4bm1QNTQwaGdPUU44NDlENnlVWEQveGEwdUt2bjRq?=
 =?utf-8?B?SDFjSDN0UExLSDluSlFwaWhjODNZOVl2RW9HcjIvQWh3UU50RXNYVDR6Mks1?=
 =?utf-8?B?RkV0Um5tcFVQMFdIbVU4VkZGU0psSzhKU01DTzNKYjUvU0YyV1Z3NnJCU1Vr?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF1D83A40BCF248B0606C429F08B46F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb59b53-a72b-4fba-6933-08da6512c1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 21:00:45.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gvzC6nUqLcFCkIWo9MELoBRqkVKIpqZ5VwOjNNs1XQ2xiv5H2IxKTxB6DN2lkyH0xAMOvmaRIB4zXygHkqcC9JhI4x4OaM9ssk1+y3S8lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIENvbm9yLg0KDQpPbiBXZWQsIDIwMjItMDctMTMgYXQgMTE6MjYgKzAwMDAsIENvbm9y
IERvb2xleSAtIE01MjY5MSB3cm90ZToNCj4gSGV5IExld2lzLA0KPiBDb3VwbGUgY29tbWVudHMu
DQo+IA0KPiBPbiAxMy8wNy8yMDIyIDExOjU5LCBsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPiA+IEZyb206IExld2lzIEhhbmx5IDxsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPg0K
PiA+IA0KPiA+IEFkZCBhIGRyaXZlciB0byBzdXBwb3J0IHRoZSBQb2xhcmZpcmUgU29DIGdwaW8g
Y29udHJvbGxlci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZXdpcyBIYW5seSA8bGV3aXMu
aGFubHlAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3Bpby9LY29uZmln
ICAgICB8ICAgOSArDQo+ID4gICBkcml2ZXJzL2dwaW8vTWFrZWZpbGUgICAgfCAgIDEgKw0KPiA+
ICAgZHJpdmVycy9ncGlvL2dwaW8tbXBmcy5jIHwgMzc5DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDM4OSBpbnNlcnRp
b25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncGlvL2dwaW8tbXBmcy5j
DQo+ID4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG1wZnNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY2xrICpjbGs7DQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IGRldmljZV9u
b2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUg
KmlycV9wYXJlbnQ7DQo+ID4gKwlzdHJ1Y3QgZ3Bpb19pcnFfY2hpcCAqZ2lycTsNCj4gPiArCXN0
cnVjdCBpcnFfZG9tYWluICpwYXJlbnQ7DQo+ID4gKwlzdHJ1Y3QgbXBmc19ncGlvX2NoaXAgKm1w
ZnNfZ3BpbzsNCj4gPiArCWludCBpLCByZXQsIG5ncGlvOw0KPiA+ICsNCj4gPiArCW1wZnNfZ3Bp
byA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqbXBmc19ncGlvKSwgR0ZQX0tFUk5FTCk7DQo+
ID4gKwlpZiAoIW1wZnNfZ3BpbykNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4g
KwltcGZzX2dwaW8tPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MCk7DQo+ID4gKwlpZiAoSVNfRVJSKG1wZnNfZ3Bpby0+YmFzZSkpDQo+ID4gKwkJcmV0dXJuIFBU
Ul9FUlIobXBmc19ncGlvLT5iYXNlKTsNCj4gPiArDQo+ID4gKwljbGsgPSBkZXZtX2Nsa19nZXQo
JnBkZXYtPmRldiwgTlVMTCk7DQo+ID4gKwlpZiAoSVNfRVJSKGNsaykpIHsNCj4gPiArCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJkZXZtX2Nsa19nZXQgZmFpbGVkXG4iKTsNCj4gPiArCQlyZXR1cm4g
UFRSX0VSUihjbGspOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShjbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwg
ImZhaWxlZCB0byBlbmFibGUgY2xvY2tcbiIpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJbXBmc19ncGlvLT5jbGsgPSBjbGs7DQo+ID4gKw0KPiA+ICsJbmdwaW8g
PSBvZl9pcnFfY291bnQobm9kZSk7DQo+ID4gKwlpZiAobmdwaW8gPiBOVU1fR1BJTykgew0KPiA+
ICsJCWRldl9lcnIoZGV2LCAiVG9vIG1hbnkgR1BJTyBpbnRlcnJ1cHRzIChtYXg9JWQpXG4iLA0K
PiA+ICsJCQlOVU1fR1BJTyk7DQo+IA0KPiBUaGlzIHNob3VsZCBmaXQgb24gb25lIGxpbmUNCkNh
biBkby4NCj4gDQo+ID4gKwkJcmV0ID0gLUVOWElPOw0KPiA+ICsJCWdvdG8gY2xlYW51cF9jbG9j
azsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpcnFfcGFyZW50ID0gb2ZfaXJxX2ZpbmRfcGFyZW50
KG5vZGUpOw0KPiA+ICsJaWYgKCFpcnFfcGFyZW50KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJu
byBJUlEgcGFyZW50IG5vZGVcbiIpOw0KPiA+ICsJCXJldCA9IC1FTk9ERVY7DQo+ID4gKwkJZ290
byBjbGVhbnVwX2Nsb2NrOw0KPiA+ICsJfQ0KPiA+ICsJcGFyZW50ID0gaXJxX2ZpbmRfaG9zdChp
cnFfcGFyZW50KTsNCj4gPiArCWlmICghcGFyZW50KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJu
byBJUlEgcGFyZW50IGRvbWFpblxuIik7DQo+ID4gKwkJcmV0ID0gLUVOT0RFVjsNCj4gPiArCQln
b3RvIGNsZWFudXBfY2xvY2s7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogR2V0IHRoZSBpbnRl
cnJ1cHQgbnVtYmVycy4NCj4gDQo+IG5ldGRldiBzdHlsZSBjb21tZW50DQo+IA0KPiA+ICsJICog
Q2xlYXIvRGlzYWJsZSBBbGwgaW50ZXJydXB0cyBiZWZvcmUgZW5hYmxpbmcgcGFyZW50DQo+ID4g
aW50ZXJydXB0cy4NCj4gPiArCSAqLw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IG5ncGlvOyBpKysp
IHsNCj4gPiArCQltcGZzX2dwaW8tPmlycV9udW1iZXJbaV0gPSBwbGF0Zm9ybV9nZXRfaXJxKHBk
ZXYsIGkpOw0KPiANCj4gWW91IG5lZWQgdG8gaGFuZGxlIHRoZSBjYXNlIHdoZXJlIHBsYXRmb3Jt
X2dldF9pcnEgcmV0dXJucyBhbiBlcnJvcg0KPiByaWdodD8NCldhcyBub3QgZ29pbmcgdG8gYXMg
SSBkb24ndCB0aGluayBpdCBicmVha3MgaWYgZXJyb3IuIEkgd2lsbCBkbyBhDQpsaXR0bGUgbW9y
ZSBjaGVja2luZyBpZiByZXF1aXJlZC4NCj4gDQo+ID4gKwkJbXBmc19ncGlvX2Fzc2lnbl9iaXQo
bXBmc19ncGlvLT5iYXNlICsgTVBGU19JUlFfUkVHLCBpLA0KPiA+IDEpOw0KPiA+ICsJCW1wZnNf
Z3Bpb19hc3NpZ25fYml0KG1wZnNfZ3Bpby0+YmFzZSArIChpICoNCj4gPiBCWVRFX0JPVU5EQVJZ
KSwNCj4gPiArCQkJCSAgICAgTVBGU19HUElPX0VOX0lOVCwgMCk7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmF3X3NwaW5fbG9ja19pbml0KCZtcGZzX2dwaW8tPmxvY2spOw0KPiA+ICsNCj4gPiAr
CW1wZnNfZ3Bpby0+Z2MuZGlyZWN0aW9uX2lucHV0ID0gbXBmc19ncGlvX2RpcmVjdGlvbl9pbnB1
dDsNCj4gPiArCW1wZnNfZ3Bpby0+Z2MuZGlyZWN0aW9uX291dHB1dCA9IG1wZnNfZ3Bpb19kaXJl
Y3Rpb25fb3V0cHV0Ow0KPiA+ICsJbXBmc19ncGlvLT5nYy5nZXRfZGlyZWN0aW9uID0gbXBmc19n
cGlvX2dldF9kaXJlY3Rpb247DQo+ID4gKwltcGZzX2dwaW8tPmdjLmdldCA9IG1wZnNfZ3Bpb19n
ZXQ7DQo+ID4gKwltcGZzX2dwaW8tPmdjLnNldCA9IG1wZnNfZ3Bpb19zZXQ7DQo+ID4gKwltcGZz
X2dwaW8tPmdjLmJhc2UgPSAtMTsNCj4gPiArCW1wZnNfZ3Bpby0+Z2MubmdwaW8gPSBuZ3BpbzsN
Cj4gPiArCW1wZnNfZ3Bpby0+Z2MubGFiZWwgPSBkZXZfbmFtZShkZXYpOw0KPiA+ICsJbXBmc19n
cGlvLT5nYy5wYXJlbnQgPSBkZXY7DQo+ID4gKwltcGZzX2dwaW8tPmdjLm93bmVyID0gVEhJU19N
T0RVTEU7DQo+ID4gKw0KPiA+ICsJLyogR2V0IGEgcG9pbnRlciB0byB0aGUgZ3Bpb19pcnFfY2hp
cCAqLw0KPiANCj4gSSBkb3VidCB0aGlzIGNvbW1lbnQgaXMgbmVlZGVkDQpPSy4NCj4gDQo+ID4g
KwlnaXJxID0gJm1wZnNfZ3Bpby0+Z2MuaXJxOw0KPiA+ICsJZ3Bpb19pcnFfY2hpcF9zZXRfY2hp
cChnaXJxLCAmbXBmc19ncGlvX2lycWNoaXApOw0KPiA+ICsJZ2lycS0+Zndub2RlID0gb2Zfbm9k
ZV90b19md25vZGUobm9kZSk7DQo+ID4gKwlnaXJxLT5wYXJlbnRfZG9tYWluID0gcGFyZW50Ow0K
PiA+ICsJZ2lycS0+Y2hpbGRfdG9fcGFyZW50X2h3aXJxID0gbXBmc19ncGlvX2NoaWxkX3RvX3Bh
cmVudF9od2lycTsNCj4gPiArCWdpcnEtPmhhbmRsZXIgPSBoYW5kbGVfYmFkX2lycTsNCj4gPiAr
CWdpcnEtPmRlZmF1bHRfdHlwZSA9IElSUV9UWVBFX05PTkU7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
Z3Bpb2NoaXBfYWRkX2RhdGEoJm1wZnNfZ3Bpby0+Z2MsIG1wZnNfZ3Bpbyk7DQo+IA0KPiBDYW4g
d2UgdXNlIGEgZGV2bV8gdmFyaWFudCBpbnN0ZWFkIGhlcmUuLi4NCk1heWJlLCB3aWxsIGNoZWNr
Lg0KPiANCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZ290byBjbGVhbnVwX2Nsb2NrOw0KPiA+ICsN
Cj4gPiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1wZnNfZ3Bpbyk7DQo+ID4gKwlkZXZf
aW5mbyhkZXYsICJNaWNyb2NoaXAgTVBGUyBHUElPIHJlZ2lzdGVyZWQsIG5ncGlvPSVkXG4iLA0K
PiA+IG5ncGlvKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2NsZWFudXBf
Y2xvY2s6DQo+ID4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUobXBmc19ncGlvLT5jbGspOw0KPiA+
ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtcGZzX2dwaW9f
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBtcGZzX2dwaW9fY2hpcCAqbXBmc19ncGlvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7
DQo+ID4gKw0KPiA+ICsJZ3Bpb2NoaXBfcmVtb3ZlKCZtcGZzX2dwaW8tPmdjKTsNCj4gDQo+IC4u
LiBhbmQgZHJvcCB0aGlzPw0KZWgsIE9LLg0KPiANCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShtcGZzX2dwaW8tPmNsayk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG1wZnNfZ3Bpb19tYXRjaFtd
ID0gew0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBmcy1ncGlvIiwgfSwNCj4g
PiArCXsgLyogZW5kIG9mIGxpc3QgKi8gfSwNCj4gDQo+IERvbid0IG5lZWQgYSBjb21tYSBhZnRl
ciB0aGUgc2VudGluZWwNCk9LLg0KPiANCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIG1wZnNfZ3Bpb19kcml2ZXIgPSB7DQo+ID4gKwkucHJvYmUgPSBt
cGZzX2dwaW9fcHJvYmUsDQo+ID4gKwkuZHJpdmVyID0gew0KPiA+ICsJCS5uYW1lID0gIm1pY3Jv
Y2hpcCxtcGZzLWdwaW8iLA0KPiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0ciht
cGZzX2dwaW9fbWF0Y2gpLA0KPiA+ICsJfSwNCj4gPiArCS5yZW1vdmUgPSBtcGZzX2dwaW9fcmVt
b3ZlLA0KPiA+ICt9Ow0KPiA+ICtidWlsdGluX3BsYXRmb3JtX2RyaXZlcihtcGZzX2dwaW9fZHJp
dmVyKQ0KPiANCj4gTWlzaW5nIHNlbWljb2xvbj8NCkNhbiBhZGQuLg0KPiANCj4gVGhhbmtzLA0K
PiBDb25vci4NCg==
