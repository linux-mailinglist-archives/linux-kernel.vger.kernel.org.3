Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B525B150A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIHGr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIHGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9ED275F;
        Wed,  7 Sep 2022 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619654; x=1694155654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0ydbOcAwU4eDlQQZkg+qVO6vkBn1EM16z55WihYS61M=;
  b=sJ0meuT7Qc67e04o01pDJXiKoTF9uI9G+HZDIIaVy6yz1QcpgsSMaXKB
   ru3l/T3qJKXY7it/mBLlkoXN4StIPKW7vDvhZVOWITZxRon/ImxcMD9qM
   u3utcC/dgi8LQC8DdlfmS0YaJU2YA3eNXUJ2QRh2AMRA8mfo9HVoOmMQ1
   oyX7O2ZyzNhuY+qRoct5gLU0XFlllXXqToC6XDTsG4bMifDne+DtABCNO
   PhExpNpCI3rNuFPZ+A2/UXzpZeaIcDDHMAk4MadIwaCZNe/rtCSjdGc3x
   R6XpT/r+j8LkIvwYyu75Qgff9M5NwJbbC1YbiuJTFiZsU6eEQPlWZcXsN
   g==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="112686688"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:47:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:47:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 23:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpuR//T9a7zMrCd7goZzBD+l67Tr/QuYNYgqODp5+B1YaIdAbH4UKK+eBd5nKIqyRfvHyRFkTyULAQbV+5BG+teSJP7DPnY2YTFKTYVW0RqgNg26V/bKCf93Ktc9keLjpGTb33AWDirPm67/Bi+iKg6ysAazCUoguCaHbpeKvc+37KsD9NauB+pn1+4p3jeZ3bdnBOwkV3+Lo+PAf+t3rDBHvJCJGZltY6cMQgS/5dTm8PfYzVebmK3TEA9YtVebJQMMFEDi4nmfAVnXEQLpE38c8GU0+rx+J2AQKHpSscZi1VaQGWdx+GFHXylfs7VnCY3j9hjNyIlVeuZXKR7gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ydbOcAwU4eDlQQZkg+qVO6vkBn1EM16z55WihYS61M=;
 b=M3QemjilSKreonXVtJYrwjaKhd339XAbHURXOHg8sD8jVoS8g/b6K1gbPE7oAj2Kr/yxW/k3nt/69H9wIBCMSPhRUSP55hpE3al1SF3rpncRsjb4K6yG70YZIVPfIeAiTMPmnzO/U5KqFJBgXPfea+hSBIt+NfpCjEWGKIR8tknMB3pY7LqRrJzIXooZqzStjisDvAhe1lmZXcBD/yZV4+GJTSZMSr1X6lHsg5astLt6ZLtEL2swsPYa2lw+lgu8pwauMMlHCblGlkpaf+J31vvimiFGFnngW3RuTmJQzWLgS1toLaydJAdgUiyKYmQixnSv5R3tZtiHUmEwEqQrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ydbOcAwU4eDlQQZkg+qVO6vkBn1EM16z55WihYS61M=;
 b=kndZrEnlOV8V0lATF3PTNxDtq64rudtlKTgF0WumuFmNuUO+L5GRKIcBG8LvUc0CAhByqmd0B8XY/klDu9EJOE9saDPkcRowp+kIRhvb7zP+/NQhcRyfXeb2jHImBLLfiA8tjnprV+6mKrtj/TXU3KwaRnf94Ww4emprCwykWX8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:47:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:47:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 12/13] clk: microchip: mpfs: convert periph_clk to
 clk_gate
Thread-Topic: [PATCH v4 12/13] clk: microchip: mpfs: convert periph_clk to
 clk_gate
Thread-Index: AQHYw07aDGSKR8/N+0mpk6vSMUaEFg==
Date:   Thu, 8 Sep 2022 06:47:24 +0000
Message-ID: <bd7ab590-744b-f780-df61-a0113876d26c@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-12-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-12-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c5ced1c-909e-4345-ea0d-08da9165fcde
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ADSeA/ghi0t0fQmDVwPkfPDgiUPSBKKIvxuoxdsn+aExc8/dfXkU8wFf0nAPzQ8buyDPkvr1Yr56CYpx7gYUjgINEBp7cELsYYMzVW/wGzShmS456VRAgxN0PeHh0wRCpB5sLlG6TGzgpOJyG591r+cLR+o3815Rky0wMnBkGc9SSWgna07Ym9zR5Bh2bYva/nwgzCbwxdnSb2E0uALi8uPira/KkMACVoqJbT3if6Vm0BPxlzdB6Sn4h4YlC/JMtimkP9374TTINYM1To3SYoXFLX4wVwiIjcjgVxb7EOoVXjfzLKOx5F5IlQiAMAmV1Aonv1qAAs9+bXkcnRfZgwmpMYkIcD/JbKEp1VsGgkQvK+DkeTuo/z1X8KrAIvCFGAgffNsQ1nFa9LpPfBu01Hqiyuh/Wj3hLMz8qY8p4G7bigsQExphldgDN05lbZG9PZ3tjCChV/WV841p57hRwvN+okFTSPsvgri5nfn8RuLZuJeU+NHx5TG4yGaqRA/JJL6oqJ2/vRHvzmhe9Xz+VD7TnZgYe4CsSUmucPWFubrZKGJKPxWeIRpw7i6vqmP1hqmgYcUhvZ58BtwNvfAEavFUdkRzhy99LxuoIlNXuPg0nsivAeu58rGrvvRPcAZEmrcyPqGMH5tvuMBIlbAv/fLPZYY06JFoD1JzrlVkFef1WIPKedgLlQD74B/HArH2WEYzd6DPMVGcmsuTx+mPk5wxvFxNi4YO9neyOooIBNnMwLrsGKTxXF4pukTUJlU1iGf7AFjD9p4dTs+pe0W4ZqrFRCYObEA3oOXVkb4RWAXzUqjslzwdLzNqN2BIjH7cEygegmHDlJOZmoEfvnXqcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkw1UG9heS9YUFE3a1NJTEpOamVZTHE4a0w1RkRwc0ZoVkt1ajdIdHJLM3gw?=
 =?utf-8?B?bWN0Z0FYTjYxemhtQnp3VkNWTkZhY0xodm11cUhUbmZ0dTJoRG12MHJNZWsy?=
 =?utf-8?B?NkxXZHNzZkhBL0JIcHpHb3dKWFRndmJhWE1GL0VPWlVPUGFJOGx0akg3b3hh?=
 =?utf-8?B?aVZQekxNN1F5bVpIVUJ3MlF5UjcyYjYxTTQ2bzdMelpzUkFMM0JnVkovUE13?=
 =?utf-8?B?UC9kN2c0b1pUVW5HRzNjQnp5V0tqcGhCOEJUaEExR3lHNmRtVjVxUnhSbStL?=
 =?utf-8?B?dVNTNjQ1VENwbSsxdVBqZUoxZTdsS1crWTM3YzR1L21KckhTQUlnMll1UzI5?=
 =?utf-8?B?N2VObnlua2I5eURmNWlIMHJzdW1ZWWJHcURUakVHbjhVS3VZZXFURFFGbW5m?=
 =?utf-8?B?QVB5WXVsQlR4ODJFOTB1OWEzT0hBRFNyRUtEa0J6TFNmQ2VCY3VnM0ZrRXlQ?=
 =?utf-8?B?ek5jMEp2d2Ntak1KTStPZlgzVXdiNUFSU04wVVdDakdLdDgyQ1ZEczlzV3Y2?=
 =?utf-8?B?RUZsWWdEUmMyR3VCbTZHOVR0VVdJYzhleFkzRWllNldzcXJRR05kaXdFUWcr?=
 =?utf-8?B?cnJWeXRuQVh1bnNZTGd4cEFDNjZiN01wYVlRTW0rMXJ4ZjJwRXJZQ3ZRZ3ho?=
 =?utf-8?B?bk1LcDJaTnFzRXB6TGs4NVAzTVpkbEY5NHJJYVJGa1ExOENVTnlNcHUwY2tV?=
 =?utf-8?B?RmRBNFltWGlkMVRkZTgzTkJoV2dpaG1Iejl3NEhLOG1IdS8wTXY4K0RWVXVW?=
 =?utf-8?B?QWVSVDczdVZnWGxmRXlKZ05UZjE5QmVLRmEwY3VhVjcxZFRlR3l3UnkwK0kr?=
 =?utf-8?B?RDdkZmF0OER5SlUwQTRuTUcwK3dDUVd2T3J0OWZZbm1SSDN6MktNeDV6RUhF?=
 =?utf-8?B?NDF5YUNjcGpOenRER21qcHdodCtvRXlBOTd1a0xiRG9nZnRHcTNlanNyWUFz?=
 =?utf-8?B?MWVwTnZyWUhHSDNFQVc2MEtMYlFmVW5XRnNaWVBXSXVURlltUVdkWU44QXdZ?=
 =?utf-8?B?c1FrSGtIaklNbXpuZUVtdVVGbTJWYWUvdGxwaUpOUkZ5TVBxQkxVNmZNQkw0?=
 =?utf-8?B?SzFCeGJlRXpxd1duMEh0N1ZVUkg0d2pZMUlKeFV3T1lBaUdBdHg2eUdGQ0R1?=
 =?utf-8?B?RUpuMjl6WGRYLy9FRzI0bWJPaXgyUDJzandaMVlLREFPTmVVSGFnZUo5SG5m?=
 =?utf-8?B?V29MV25SWUNqOUVnKzJVWUJiRUVNYW83ODIvWHV6RmhrM3g5VWMrdENqbHBs?=
 =?utf-8?B?ZVNpendXd0NyRU5JM1B1cHNQdzVJTDdDQ3FXeDFmRnVtMXFZaU1YM0hBM2pX?=
 =?utf-8?B?LzR1dUJnSnRzZmlDM2pyRjkrWjF1YjRIbXRVdjJsRnM1bkI2VURuR0VtR3l6?=
 =?utf-8?B?bEYxRHRSL09TQXBacmlxRVMwNGtJTGNpaFRhemhwSGhoU1Q3RjN3YnZOUWtp?=
 =?utf-8?B?L29obnQvTFM1WFJzbkl1MG1CL01xV0xxUmFDbE9SVHltV0M5WFI5NldhcC9q?=
 =?utf-8?B?OERYV0VONEhUS2pJTnhvYkZhUHFaTWlaYm42cmFEdHhmMXhWU2JEcFlmLzF1?=
 =?utf-8?B?RkhzVjhIUzRyTFg1eVBBZjBaR0drSkFLWEs3andjbDJyN3hoeU84VzZZalc2?=
 =?utf-8?B?WjRVWkwybktqcDlvWG1GUmlTamdoQzdwVHJuenhCK2x4RjVsS0ZpYVpodlg5?=
 =?utf-8?B?VFdTZmxBTVlMdVgraW1ubE5tRk1Zb0hxeS9mT1RIRWh2akJsZ3lsZE50YXpn?=
 =?utf-8?B?cWJCWHJtSnVhMzA5d2R0VEU3RWp0clhVeVByLzZuZ1gwZGxRUUZFNXl5OUY4?=
 =?utf-8?B?bWpPcCsySnZhaVNKNDdkRUEyTEViNGRvaURMQ1JRMjNHekZLYTdqZXVjTjVu?=
 =?utf-8?B?N3B6aElnRHZkZk5XeXFnVjNITmU1cituQTJEdzYraXZhL3pISUY3c09SVkxU?=
 =?utf-8?B?V3ZlMmFCOWp3bXVjVUtXTDNINHh5VjNDRHMzeGxOTCtVSUlXTmZLL3c2WlB6?=
 =?utf-8?B?SVlWMXJEbHQzUGMzZmI1NmtQdC9xQm5aak9xQlRaUUJnSGhYeDhmOUNyeXlu?=
 =?utf-8?B?UU9KZC9CTk5wSWxXdkorV3Y2Q0VhU011b1VucHJsaU92NHJpeUluRUVzb3ln?=
 =?utf-8?B?Wk5uQklFM0FSci9QZGE1dUhYdWNUVXYvQ25Ydjl6MGF0UGpzeDdjKzhSeVpu?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <288B27A671B1304EAB9153ED6EF0B9F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ced1c-909e-4345-ea0d-08da9165fcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:47:24.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEP21V8+ggWYmLcrvcsmEGjj14EAZIAIeKcfEnhFF3zdJOncTcUpYMd3PBw1ew9gKMgQByN8o7hQLQWqvQRm/ogDOascK5361vxXC9O+6Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBXaXRoIHRoZSByZXNl
dCBjb2RlIG1vdmVkIHRvIHRoZSByZWNlbnRseSBhZGRlZCByZXNldCBjb250cm9sbGVyLCB0aGVy
ZQ0KPiBpcyBubyBuZWVkIGZvciBjdXN0b20gb3BzIGFueSBsb25nZXIuIFJlbW92ZSB0aGUgY3Vz
dG9tIG9wcyBhbmQgdGhlDQo+IGN1c3RvbSBzdHJ1Y3QgYnkgY29udmVydGluZyB0byBhIGNsa19n
YXRlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBt
aWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL21pY3JvY2hp
cC9jbGstbXBmcy5jIHwgNzIgKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDY2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jIGIvZHJpdmVycy9jbGsv
bWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gaW5kZXggODhhMjAwZTg4ZTU0Li5mYTQ2MTc2ZWI5Y2Eg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+ICsrKyBi
L2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IEBAIC01OCwxOSArNTgsMTEgQEAg
c3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2NrIHsNCj4gIAl1MzIgcmVnX29mZnNldDsNCj4gIH07DQo+
ICANCj4gLXN0cnVjdCBtcGZzX3BlcmlwaF9jbG9jayB7DQo+IC0Jdm9pZCBfX2lvbWVtICpyZWc7
DQo+IC0JdTggc2hpZnQ7DQo+IC19Ow0KPiAtDQo+ICBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xv
Y2sgew0KPiAtCXN0cnVjdCBtcGZzX3BlcmlwaF9jbG9jayBwZXJpcGg7DQo+IC0Jc3RydWN0IGNs
a19odyBodzsNCj4gKwlzdHJ1Y3QgY2xrX2dhdGUgcGVyaXBoOw0KPiAgCXVuc2lnbmVkIGludCBp
ZDsNCj4gIH07DQo+ICANCj4gLSNkZWZpbmUgdG9fbXBmc19wZXJpcGhfY2xrKF9odykgY29udGFp
bmVyX29mKF9odywgc3RydWN0IG1wZnNfcGVyaXBoX2h3X2Nsb2NrLCBodykNCj4gLQ0KPiAgLyoN
Cj4gICAqIG1wZnNfY2xrX2xvY2sgcHJldmVudHMgYW55dGhpbmcgZWxzZSBmcm9tIHdyaXRpbmcg
dG8gdGhlDQo+ICAgKiBtcGZzIGNsayBibG9jayB3aGlsZSBhIHNvZnR3YXJlIGxvY2tlZCByZWdp
c3RlciBpcyBiZWluZyB3cml0dGVuLg0KPiBAQCAtMjczLDY0ICsyNjUsMTIgQEAgc3RhdGljIGlu
dCBtcGZzX2Nsa19yZWdpc3Rlcl9jZmdzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNf
Y2ZnX2h3X2Nsb2NrICoNCj4gICAqIHBlcmlwaGVyYWwgY2xvY2tzIC0gZGV2aWNlcyBjb25uZWN0
ZWQgdG8gYXhpIG9yIGFoYiBidXNlcy4NCj4gICAqLw0KPiAgDQo+IC1zdGF0aWMgaW50IG1wZnNf
cGVyaXBoX2Nsa19lbmFibGUoc3RydWN0IGNsa19odyAqaHcpDQo+IC17DQo+IC0Jc3RydWN0IG1w
ZnNfcGVyaXBoX2h3X2Nsb2NrICpwZXJpcGhfaHcgPSB0b19tcGZzX3BlcmlwaF9jbGsoaHcpOw0K
PiAtCXN0cnVjdCBtcGZzX3BlcmlwaF9jbG9jayAqcGVyaXBoID0gJnBlcmlwaF9ody0+cGVyaXBo
Ow0KPiAtCXUzMiByZWcsIHZhbDsNCj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAtDQo+IC0J
c3Bpbl9sb2NrX2lycXNhdmUoJm1wZnNfY2xrX2xvY2ssIGZsYWdzKTsNCj4gLQ0KPiAtCXJlZyA9
IHJlYWRsX3JlbGF4ZWQocGVyaXBoLT5yZWcpOw0KPiAtCXZhbCA9IHJlZyB8ICgxdSA8PCBwZXJp
cGgtPnNoaWZ0KTsNCj4gLQl3cml0ZWxfcmVsYXhlZCh2YWwsIHBlcmlwaC0+cmVnKTsNCj4gLQ0K
PiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm1wZnNfY2xrX2xvY2ssIGZsYWdzKTsNCj4gLQ0K
PiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9pZCBtcGZzX3BlcmlwaF9jbGtf
ZGlzYWJsZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gLXsNCj4gLQlzdHJ1Y3QgbXBmc19wZXJpcGhf
aHdfY2xvY2sgKnBlcmlwaF9odyA9IHRvX21wZnNfcGVyaXBoX2Nsayhodyk7DQo+IC0Jc3RydWN0
IG1wZnNfcGVyaXBoX2Nsb2NrICpwZXJpcGggPSAmcGVyaXBoX2h3LT5wZXJpcGg7DQo+IC0JdTMy
IHJlZywgdmFsOw0KPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IC0NCj4gLQlzcGluX2xvY2tf
aXJxc2F2ZSgmbXBmc19jbGtfbG9jaywgZmxhZ3MpOw0KPiAtDQo+IC0JcmVnID0gcmVhZGxfcmVs
YXhlZChwZXJpcGgtPnJlZyk7DQo+IC0JdmFsID0gcmVnICYgfigxdSA8PCBwZXJpcGgtPnNoaWZ0
KTsNCj4gLQl3cml0ZWxfcmVsYXhlZCh2YWwsIHBlcmlwaC0+cmVnKTsNCj4gLQ0KPiAtCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJm1wZnNfY2xrX2xvY2ssIGZsYWdzKTsNCj4gLX0NCj4gLQ0KPiAt
c3RhdGljIGludCBtcGZzX3BlcmlwaF9jbGtfaXNfZW5hYmxlZChzdHJ1Y3QgY2xrX2h3ICpodykN
Cj4gLXsNCj4gLQlzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sgKnBlcmlwaF9odyA9IHRvX21w
ZnNfcGVyaXBoX2Nsayhodyk7DQo+IC0Jc3RydWN0IG1wZnNfcGVyaXBoX2Nsb2NrICpwZXJpcGgg
PSAmcGVyaXBoX2h3LT5wZXJpcGg7DQo+IC0JdTMyIHJlZzsNCj4gLQ0KPiAtCXJlZyA9IHJlYWRs
X3JlbGF4ZWQocGVyaXBoLT5yZWcpOw0KPiAtCWlmIChyZWcgJiAoMXUgPDwgcGVyaXBoLT5zaGlm
dCkpDQo+IC0JCXJldHVybiAxOw0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLXN0
YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX29wcyBtcGZzX3BlcmlwaF9jbGtfb3BzID0gew0KPiAtCS5l
bmFibGUgPSBtcGZzX3BlcmlwaF9jbGtfZW5hYmxlLA0KPiAtCS5kaXNhYmxlID0gbXBmc19wZXJp
cGhfY2xrX2Rpc2FibGUsDQo+IC0JLmlzX2VuYWJsZWQgPSBtcGZzX3BlcmlwaF9jbGtfaXNfZW5h
YmxlZCwNCj4gLX07DQo+IC0NCj4gICNkZWZpbmUgQ0xLX1BFUklQSChfaWQsIF9uYW1lLCBfcGFy
ZW50LCBfc2hpZnQsIF9mbGFncykgewkJCVwNCj4gIAkuaWQgPSBfaWQsCQkJCQkJCQlcDQo+IC0J
LnBlcmlwaC5zaGlmdCA9IF9zaGlmdCwJCQkJCQkJXA0KPiAtCS5ody5pbml0ID0gQ0xLX0hXX0lO
SVRfSFcoX25hbWUsIF9wYXJlbnQsICZtcGZzX3BlcmlwaF9jbGtfb3BzLAkJXA0KPiArCS5wZXJp
cGguYml0X2lkeCA9IF9zaGlmdCwJCQkJCQlcDQo+ICsJLnBlcmlwaC5ody5pbml0ID0gQ0xLX0hX
X0lOSVRfSFcoX25hbWUsIF9wYXJlbnQsICZjbGtfZ2F0ZV9vcHMsCQlcDQo+ICAJCQkJICBfZmxh
Z3MpLAkJCQkJXA0KPiArCS5wZXJpcGgubG9jayA9ICZtcGZzX2Nsa19sb2NrLAkJCQkJCVwNCj4g
IH0NCj4gIA0KPiAgI2RlZmluZSBQQVJFTlRfQ0xLKFBBUkVOVCkgKCZtcGZzX2NmZ19jbGtzW0NM
S18jI1BBUkVOVF0uY2ZnLmh3KQ0KPiBAQCAtMzkwLDEzICszMzAsMTMgQEAgc3RhdGljIGludCBt
cGZzX2Nsa19yZWdpc3Rlcl9wZXJpcGhzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNf
cGVyaXBoX2h3X2MNCj4gIAkJc3RydWN0IG1wZnNfcGVyaXBoX2h3X2Nsb2NrICpwZXJpcGhfaHcg
PSAmcGVyaXBoX2h3c1tpXTsNCj4gIA0KPiAgCQlwZXJpcGhfaHctPnBlcmlwaC5yZWcgPSBkYXRh
LT5iYXNlICsgUkVHX1NVQkJMS19DTE9DS19DUjsNCj4gLQkJcmV0ID0gZGV2bV9jbGtfaHdfcmVn
aXN0ZXIoZGV2LCAmcGVyaXBoX2h3LT5odyk7DQo+ICsJCXJldCA9IGRldm1fY2xrX2h3X3JlZ2lz
dGVyKGRldiwgJnBlcmlwaF9ody0+cGVyaXBoLmh3KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNsb2NrIGlk
OiAlZFxuIiwNCj4gIAkJCQkJICAgICBwZXJpcGhfaHctPmlkKTsNCj4gIA0KPiAgCQlpZCA9IHBl
cmlwaF9od3NbaV0uaWQ7DQo+IC0JCWRhdGEtPmh3X2RhdGEuaHdzW2lkXSA9ICZwZXJpcGhfaHct
Pmh3Ow0KPiArCQlkYXRhLT5od19kYXRhLmh3c1tpZF0gPSAmcGVyaXBoX2h3LT5wZXJpcGguaHc7
DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQoNCg==
