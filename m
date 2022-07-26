Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91895819F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbiGZStZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiGZStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:49:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828633A1E;
        Tue, 26 Jul 2022 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658861362; x=1690397362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SgNxpSqYn6bVbz0j1g3oBNcEchIVa0ctw5xnmXyIQjk=;
  b=d6dDP1dqVR7NTwfTcp3XvXgi4TC2IZq/Ognd+h5rtjBmj0aYAHoqB6yQ
   AP80ItqI6Ke+Y5QlycNDfYXVUL4gW/odOlfrmnSpkvIv6RERnpnzNUeSh
   k97x8KCyfLxQ2RFcU+CjEwT17CrqKKqof7Ti0r4Fe/3d55Lsm8DaCq1YE
   FBwSxCOPlxknESwPuNVVepR0xcEy6DSyQ++YKNl6GqtmetIovRAZI3BzW
   BN2fEpURorR5S7FDtk+SvAJ9riW0ISbiF+9nt4R5udA4E5x8U3lP9fYUK
   +iY3yPSmTbJTpMBDiqPUsT3sn7EdFcKzMfzeboWba+dRjBUMasqV1y8Zo
   g==;
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="183845416"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 11:49:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 11:49:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 11:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+JqcXZytM9SGUsab23qPlwJYJeeQt+zgvgLR+5bDt+NsSolZxo28rJqBXOWZaX96n7cl/I5/spX2CJvCJD0s2d7q5rbCj/PPMpDYPf7K/xc18Arb1Qk2QYYoUsVuZiVOIakLdnCggyQAHUUc9eqf2/oEj7q5gG2IRB46DSW/NyF9bqYbRpQE5P54h/5fJXLOXU44+6GLv/Oqvrdbz8tNQ1TOQJuyEB3PNEBXXrBMS0tNQw9jgcuVcqmIUbYozqO+UfRGA/cO5uOd5gzk/PQGbVMBC3JpM8wOPZUenhoc2p9qzgOb1pSZSmnVi8mMbnUg3FAXsEHucywokGXLcuv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgNxpSqYn6bVbz0j1g3oBNcEchIVa0ctw5xnmXyIQjk=;
 b=C1YsWtyQ6Xp4zTw1N5JVZcU+OByaPbid6ygR4VAgCJ3h229v+p8SU3k5fmegCfQ0D/QK8BJXQ4+MwxsqengG3b0WRw+6bmLQR6HoKuilF9VaY6FSI+El5e1+dPfsiBuLFdQw5P0BYQhS7ll6RWSsxon+Ahyz87BHEGz/VdsJubabqADQKaQWmFzwiLGg3oLxyQyDlbDAN5GMLQInN9hpNOM6Um3WL6lfIgsbqDNe/j0Kg/OAwOUeWKQ+38fNXjllh3rj9iMeGU2I0FSMZQmbqXg/4RvZDMOsHc+hg0zx0wudNhCh5DAsZzwcZJbT/Iq4EDpgBdQjEn3wWzdjWlX5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgNxpSqYn6bVbz0j1g3oBNcEchIVa0ctw5xnmXyIQjk=;
 b=QsvpE7qMfGYs7D8ICEkIwYqj610esnmKqMffArLrhCQLRGf6Bi7DGdmAEeM46Zi+mk1ID+EQ8zlKVdgQmUWLS4EXItwwvpxUFaohgor2dQXAWlOs2JIM2NbbRNQcIZMPTY7Kf73EP98Wumyp4w5Cw6o7fgsnwR0KfHhYIfjAczY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2533.namprd11.prod.outlook.com (2603:10b6:a02:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Tue, 26 Jul
 2022 18:49:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 18:49:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5/6] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig
 option
Thread-Topic: [PATCH 5/6] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYoRqLRmDL1ub3Rky98Bwpdbu+sa2Q/pMA
Date:   Tue, 26 Jul 2022 18:49:10 +0000
Message-ID: <08083c49-68a3-6b0d-4a12-d9c9f7994281@microchip.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220726180623.1668-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0de5452b-4b21-4e2e-612d-08da6f378727
x-ms-traffictypediagnostic: BYAPR11MB2533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lWJeZoN0vg8z68n8ICJMuY0hUWH3qddYdn+TLD4bILNkUzbbEoMb3zeyVaSCM0WcEJDPKYLLvXCrREz9vuTQS//pwOv9D2w/ZQoPPhrT0E8dLYJ5yGy8k/nNL+9EbUs4e0WmLIKs/B7r2qPWAi6BETIyyczZYSWXfq0z6ZfCzzs7Mi9ONXJ2GU/y6QDJob021MgWzPIHvx0Y3mp19zDj4oIwgWxlZhQyliceE3KcFFI2MXWYX6BZH5pZUkeHeumtkNq/K9foGi1X2kssR/K7jZF27/q43rcqsmYDBf8KRjSafThAt1r9xiiXZ3Ns5UC1HI0p80F1VOCa/aTIZtDjMcL2fqHTODfh51iXji9GuK+bRx4fR41CPy9fSTUI75mSTTquJhZuXKdqFfgCPzM+oMDwHbtbrx3eSjWQtoKHqMFVgPTWAcXa8uiCRee/+vieKI8CvXvNp4WUb9FXDnchLzkhQnoYfeuw4UbGMOpAX+fO87CkZ+HgzriPZYo3lQXGWh98LGuZxXW9wd23PVY6R8uG1yjqy4sm1zevrUocPR2huztwW2eK072u5it7c+0yxZfq5yD4FJnTjSouFg2lqr3xK+VZ1gwAmkbIAMyJVOuIHSEJDzB1yQMwmFJglAsw6yEYVUb6lOY5W9jzEMRSUnwdPR+x92SuCTvjUvmWCQaF6dbGFddW8dKdMHTDkIkPunhjNK9g8zkOFDe4C7dKlkb65SQ5LcS6Xiz/igjJ0HAh7O+vu2e5z2PoK4KZ455ZHqQVsPYU+Wdtfl4kfSsPXb2lIxMAyQnnevzr38O1M6swNCcUTVjWxOrO6vEb/bsk5DREhjlLd/juBVbE11BCcS7RhlVUjNISbhZf0HSGrVuqD7ev2OmG3KnYjClKkt2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(39860400002)(396003)(346002)(31696002)(41300700001)(2906002)(53546011)(26005)(6486002)(86362001)(6506007)(71200400001)(8936002)(7416002)(91956017)(2616005)(6512007)(5660300002)(478600001)(186003)(38100700002)(122000001)(4326008)(38070700005)(31686004)(36756003)(54906003)(66946007)(110136005)(76116006)(66476007)(8676002)(66446008)(316002)(64756008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2xxbHY1KzY1dklDMUFKVTdzVEFkaWNScjRvMjBmY0pOdDJ0RDE2MS9odGh6?=
 =?utf-8?B?d1dzTWxuRHh5UDRWaGgrUnVRbllmWW05dEJOcXBnOU9uckFBeTRYdkQzZmg1?=
 =?utf-8?B?QnBFVFNMZ3VHdzUzKzQ1UDBpQVo0cElIZTh3QzFxd1pOSDFCZ2dLcjhkQnZW?=
 =?utf-8?B?dlloeUwzRnBJckNyRVEyM2lQclhvdnpTbUc4bm53T3VZVHVYUzdnT1AyazFw?=
 =?utf-8?B?eTM1QnNDK3dtUm5GVWpHOVJVTU5yUFcyMERVQUR6U3RwSVgzYVlibWtXdk1u?=
 =?utf-8?B?cHdpY0U3OU9lN3lQbnFuaTFxdDF4dytVTzkxN1BqRnE4UUZ3TU1iT3c4TzZx?=
 =?utf-8?B?NTl2SDZYdG0wSW9TbUwraHZHbGp6cmJXZlNJRUljSEhnVnlHUk1hNDRmYnlU?=
 =?utf-8?B?a1hMTSt6cnJDdE5nZm5xbnowTTR4d1E0Qnd4RGJtWHdFb05zbjlEU3hwWVVX?=
 =?utf-8?B?MVk0WFBvdis1NEU3bmVINUVRK2lKQXN3WGRLU3ljcno5VzlUYlJ0WVRuTTVa?=
 =?utf-8?B?OWRXZjRkTlplNHR4RTNnaWpwd0pKQ0diSXZKM3h3MytsSTRSOER4b25xV2o0?=
 =?utf-8?B?aEtwTFc1T3dsTnV6VXdpYnFGenQxU2FjN1MrVWxzaU5ZSGtmU2ZGTE8vdkFB?=
 =?utf-8?B?a1BsVlhtUUQ0MlYxeUdjeG43bUhnamloSkc2emN6K2pYUDlNZlNaeTFmUDRv?=
 =?utf-8?B?VDdidTV3U1hmUVd1VG5ZL29sdXI4V1FiMDdqOURNQ2xVSXd1dHhqaG1rbGFQ?=
 =?utf-8?B?UUNGcEhwUUR3Umx6ejNJZHV0eGhMb3ZnM3drWFpCZHA4ODJDSTdSNkc4REtZ?=
 =?utf-8?B?enQxYWxLaDNWZVg5d3B1MS9IRXYrNlZ4aGdNWWE0aFpxeEhDNlZ3eGg0RHk3?=
 =?utf-8?B?emdUQ2h6TGpHd3BhRjFjVnlzTUp5SG1lREVPMllRanFGMFp2Q0lHOGdyVjEy?=
 =?utf-8?B?NC9ETmxyKzZrUUlNaDQvVTBrVTZpdFNWdnJISXNDZ1JKa3RPOFlNT21tRVJO?=
 =?utf-8?B?S3NYblprbnJDMW1xMU9TS3Q0dmpXbURYbzRZNG0wTyszb2dBS3hEZTFxbVFX?=
 =?utf-8?B?N1pwbElldWVleFlNRHV1cWlHRDBqMGZiWmFHRnpucE1udkZob3lieVl4cHps?=
 =?utf-8?B?OGtNbU9sOEZSZHJkTDhEMmdzdjVGMkJJblQyb0NIWmM4WUpnMEE5blVJL01i?=
 =?utf-8?B?YWFvOUhBWjUrNi91NjRTN2tNWEJacnR1cUlVK1hLZjllcHFkcG1mbk9tbmF3?=
 =?utf-8?B?UVFXOUZPVXYremRnM3F5M2VaeUpJWmlHNmtnRk0ySHFpdXhOcU84b0FiNmMr?=
 =?utf-8?B?RFZWbVpjSS9lbEU2ZHU4WHkxaXdpMDVqZkpPRjhVdDJaeWhlUFM2VWNEZWUr?=
 =?utf-8?B?UGRhdzk5c3RVdGt5RFBIL1ljSmd5RHZkNmxTL042Z01CU2xYSTZUbGJyd2hI?=
 =?utf-8?B?c2t5RncyZUVqaW5nekovOEFPQllhRy93TVFBM2E1WXBmcUtHUU4zbXUzNVdm?=
 =?utf-8?B?NllVbXA0ZDM1azQwV3BFSWwvVUhLWFNNK0d2Qmh0UFBtcjJ5OWRBdi84NjJG?=
 =?utf-8?B?T1h4OGpZeXlETFdNTldpZEl4Zm5JMUV5VEFTWjRlVHErOGVCeEUzbDlVdEdP?=
 =?utf-8?B?T2Q4bnEvbjNpTHhJaVp0cm1yakZ6Q1ovZ2Y3SHZnazc0YTFyakx2RGl3aXg4?=
 =?utf-8?B?d2tVT2hYWHhPOWxPMWZ0ZVVHNzRqSXhvS2tmY2ptWHc0ODhjUUtwbWdvSVZI?=
 =?utf-8?B?VFNmWS83Vkh3YmpGU2VHRDF0b2FuekNmUzBCK1JnS2xORm5maWdaQ1BldG5o?=
 =?utf-8?B?L1ZMU3JLbVJkckgwTS90dkptK3JjbkZzMUJWblNkWFZmNUZhTHpEQ1ZYTmxz?=
 =?utf-8?B?K3lRSmcybWlLb1BHblM2QjV1bW0xQm5iMURxM0NhK2MyV0NKZzFjOVdrZ2VN?=
 =?utf-8?B?YndpYXZHU0s5cjl6SlRudWcxR3dWT1ZPR2NCclI5QWVuKzdpTUhRRUQ4S29O?=
 =?utf-8?B?TllyRHN0Q0haamthYjNZTXZhWFhvZkJhTXhtQW8ySHYwb0ZaMGFGR2FvOWtG?=
 =?utf-8?B?MU05MllXVSs5MVgraktHY1BwL0tXUjBncWYzQk5wZGkvUWZScmJqK3pyWEdK?=
 =?utf-8?B?VWpwOWk0dEdteUxLSHowSDV1Vno1Ui8rY1Z0WDBKakN1UzlXTHVSalFoeEx0?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26EF4EAE7B302947ADF240916F626AB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de5452b-4b21-4e2e-612d-08da6f378727
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 18:49:10.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0WDdZ7sYKbIvQk6h/TCTrVyskBSQ0UoaQUR0yzOILYbTRl8VpRShBJHfjxyK0h7cyXd/f7iqfZYA+KB+F7FqL1Fp0nzIiYhcW/E8yPwYKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2533
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDcvMjAyMiAxOTowNiwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gSW50cm9kdWNlIFNP
Q19SRU5FU0FTX1JaRklWRSBjb25maWcgb3B0aW9uIHRvIGVuYWJsZSBSZW5lc2FzIFJaL0ZpdmUN
Cj4gKFI5QTA3RzA0MykgU29DLCBhbG9uZyBzaWRlIGFsc28gYWRkIEFSQ0hfUkVORVNBUyBjb25m
aWcgb3B0aW9uIGFzIG1vc3QNCj4gb2YgdGhlIFJlbmVzYXMgZHJpdmVycyBkZXBlbmQgb24gdGhp
cyBjb25maWcgb3B0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gIGFyY2gvcmlz
Y3YvS2NvbmZpZy5zb2NzIHwgMTQgKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnLnNv
Y3MgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPiBpbmRleCA2OTc3NGJiMzYyZDYuLjkxYjdm
MzhiNzdhOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4gKysrIGIv
YXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4gQEAgLTgwLDQgKzgwLDE4IEBAIGNvbmZpZyBTT0Nf
Q0FOQUFOX0syMTBfRFRCX1NPVVJDRQ0KPiAgDQo+ICBlbmRpZiAjIFNPQ19DQU5BQU4NCj4gIA0K
PiArY29uZmlnIEFSQ0hfUkVORVNBUw0KDQpIbW0sIEkgZ3Vlc3Mgc2luY2UgaXQgaXMgdmVyeSBs
YXRlIGluIHRoZSBkYXkgZm9yIHY1LjIwIGFuZCB0aGVyZQ0KYXBwZWFyIHRvIGJlIHNvbWUgaXNz
dWVzIHdpdGggdGhlIFNPQ18gc3ltYm9sIGJyZWFraW5nIHRoZSBkdHMgYnVpbGQNCmFueXdheSwg
dGhpcyBpcyBsaWtlbHkgdG8gYmUgdjUuMjEgY29udGVudCBhbnl3YXkuLi4NCg0KLi4uYnV0IEkg
d291bGQgYmUgd2FyeSBvZiBhZGRpbmcgQVJDSF8gc3ltYm9scyBmcm9tIEFSTSBhcmNocyBwcmlv
cg0KdG8gZmlndXJpbmcgb3V0IHdoYXQgd2UgYWN0dWFsbHkgd2FudCBzeW1ib2xzIGluIEtjb25m
aWcuc29jcyB0bw0KYWN0dWFsbHkgIGF0IExQQyBvciB3L2UuIFBhbG1lcj8NCg0KPiArCWJvb2wN
Cj4gKwlzZWxlY3QgR1BJT0xJQg0KPiArCXNlbGVjdCBQSU5DVFJMDQo+ICsJc2VsZWN0IFNPQ19C
VVMNCj4gKw0KPiArY29uZmlnIFNPQ19SRU5FU0FTX1JaRklWRQ0KDQpJIHdvdWxkIGxpa2UgdG8g
c2VlIHRoaXMgYWRkZWQgdG8gdGhlIGRlZmF1bHQgZGVmY29uZmlnIHNvIHRoYXQNCml0IGhhcyBk
dGJzX2NoZWNrIGNvdmVyYWdlIGJ5IGRlZmF1bHQuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+ICsJ
Ym9vbCAiUmVuZXNhcyBSWi9GaXZlIFNvQyINCj4gKwlzZWxlY3QgQVJDSF9SOUEwN0cwNDMNCj4g
KwlzZWxlY3QgQVJDSF9SRU5FU0FTDQo+ICsJc2VsZWN0IFJFU0VUX0NPTlRST0xMRVINCj4gKwlo
ZWxwDQo+ICsJICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9GaXZlIFNvQy4N
Cj4gKw0KPiAgZW5kbWVudSAjICJTb0Mgc2VsZWN0aW9uIg0K
