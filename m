Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C659A5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350844AbiHSSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349802AbiHSSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:40:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E9D9D69;
        Fri, 19 Aug 2022 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660934420; x=1692470420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sWLXFA05EdczTksO0zzldlD2G9whpYW97DnTwF9NqfM=;
  b=hWbZsX1Q7jz68sO4aJTwbj/+WxIQpPLjoaf/TlEyVh59Qsmrz5hSKAYP
   oVLc2uY/OR8D/lPn9jgU8XHYL7n9TeToyvmxk1RIGwHMLKHQ3AX+bmVJA
   q/PqcouF9t+dbWyfFYwls+eZvrwKlctEZAG+s42kjKfou/diev9UVHZ1f
   ixlrUXpD2ABGWuUEDApJOP/0FNsJQukVtziYTmf2TSAqkI50hygKeX6rj
   3/hL4u3LfGP9tv5v4VsAP70bJf0mLh8lx8luaoV5wYYeUafhitC6EgXz9
   BrCOvopO8U5Zd9vEydIlsb732vIUNWpgaRCG+VcdlMxMyhUpMN1Ek/mwY
   g==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="177114447"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 11:40:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 11:40:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 19 Aug 2022 11:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHm52eALpT3yv5LVyjQmVlpQFAeMLX8FmGRZnN140ziXKDL27ATwjDb+8VnaY9G/8g7pohzf7SzXCsKfxPsQcO6yu5XCaIzPJkK6qYYEr1EsbGuDw1Qb0XwIE75RSBMs3Pq+dnFa2oQScVNZp4R0UPUQQfBWPYBwRqXvwYvxvLVzcEm+EewbEJ1c63fQ51tuzqhIhLfyv5Irjyl4SN4LSOIoepMwwHS/UoK0gF1RXbd+zkqrtQX4R2sVo1HCmkFKiBSKcxjFQsxHVu6ndpnWpGdfqARGs4nqxebbH23uGUIeFTseyQF0pKwT/NiBubINjAQuc9dvvzIaaKijQStLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWLXFA05EdczTksO0zzldlD2G9whpYW97DnTwF9NqfM=;
 b=VG82CxA7byEeZwL93c18j6Qu2v28Lo641bpRjgZsSo6oArKzT7i2jLzNXnzHFmonfUDM/iHyhl4GatspTxY837CY8NbN9ZwYKfpbnLaMuN9zRkpD7XWaU9RDnSoyMTuBQlkGkVQm+hLb4INMfuOJ5PusdKRB3pOR2ErxCe6NSu0s/W9VPalbzPGqmJhu2rVudl4/VuByQA7CNgc6tjwFVvb1WDPW4F7vgLRufgWv4YElqHBDDWBKce+gKuPXd3zhDdb9sFQ0O7qnimYLOrZtcabCY9NvLTB1eS4sQ3IsoFEPNWZvxsnzCqO9KJHPiZea3+5e/+MV23DB6uAi5neK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWLXFA05EdczTksO0zzldlD2G9whpYW97DnTwF9NqfM=;
 b=VeL4Ihcpr84G5oucwc7fuRiSk2ipe8pKA94Nv+vNuibnN9lTnTY/qJKt/ceTcJ1Y973gHX4216sC8JUp/3WftY4T0m2ZHzaQaCXzTWQkw/cYDX3mRhAaifD+/lB/hS5qU6zxs1EZ/YdNlRYBC1EB+UzDc1UopK83WEJeQOSclzw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 18:40:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:40:13 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>
CC:     <Conor.Dooley@microchip.com>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <prabhakar.csengg@gmail.com>, <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
Thread-Topic: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
Thread-Index: AQHYsLouMPh7rdo3sEeVwwyr+jl3hq22lMeA
Date:   Fri, 19 Aug 2022 18:40:13 +0000
Message-ID: <e9b00bb5-bb78-091f-9c10-96c156690469@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cfc8428-ca4d-4e5b-dcd7-08da82124113
x-ms-traffictypediagnostic: SJ0PR11MB5940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+jycG90yJ6X8tvecnxzh7GvBeweXEOS77nT6A5eToZTnS05wGtTS45w+gcmxN5iqGqZssvvPIJNQtZgBql13zWKObicEIYqopvgrIyUfAVf1FX+VTdGFPFQ9VKl7XzBJLPw4c3pziqbyfIkdMCuqhmSQmwtCXwRbVvxPIRzs8AmovwV5ycWv/rMOJIaFUrNVrj3iOoSYcB8su1I1y7rPA3DwTUAelN9EidD8043By8GKyoIuZsvdtEdNRl+PUfRhlR33TmS/lusuTrp2tCVt1Of6JeiDSnF/T1lBgMDFZ7pitG0Fp6ZzVj+33nlq5eL8feeTLjKayaeHu4rbTaNcJZ1zycIlgo17TKZHsHq2ilDwC0KcfkXmSDfOQ01TNWcsT71XoNxn5mGdiCuoA7a2Wi4D0EnGefZ5XrCVGy10jWtaoTi+p/tWarquXXbm3rVlg0EW69SZ4gTBfPrF83D3YxWvZTvOvJKA/ncbUq8y4VmKSYU2FLcnTtRlUArR6QSZ7iLXatHNKlnY4+1ESUAMRCW619bmUpZYajpJvm3oZ/qNKG/UxEcs23fMUw5iO6dt/bZsAzJH61woUopWtHGldY66+DicThQV7U5+ioTuf98wcVy1+QOARkRVHf3ExTro5gqevaUbkOAWAJ/LZ/Wp7Z4iVEEhRapQ8Sd0Nl90uTX1PN7Vec/3VCJC1eMzkoI8FMa8qPk5RKY19dnQoqldsb2/6leuMiW9TiW1eOmTnQjruyl+whydAc4Mz4z7QPUqTyf5dD7Lpm3xR+295s+JbIkZLxK1rScKjszpciugF3OlHCkWRGYoV8v/y30IcM48d/d9AKerBFPVFMMAVT44g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39860400002)(6486002)(54906003)(36756003)(110136005)(66476007)(76116006)(4326008)(31686004)(64756008)(66946007)(66556008)(71200400001)(66446008)(91956017)(478600001)(8676002)(38070700005)(8936002)(41300700001)(5660300002)(2616005)(7416002)(31696002)(316002)(86362001)(53546011)(6506007)(2906002)(26005)(38100700002)(6512007)(122000001)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdHQ0h4RGZ1ZiswR1ZxMDlIU3NNSzBGOFhQZGtnKzNVNzNPTWQrMnAwcUJD?=
 =?utf-8?B?WTV2czN1WE1MSlBDd2lSNVhjZlY2SWRzMzZPVnN1NmNrUXVrcHNxR2xWV3dX?=
 =?utf-8?B?Q0ViZ0FtRnpWVnZocWdGTlNEQ1lxOWNXb2xENjEyRkRVMzE3SGFYWlZLdHhp?=
 =?utf-8?B?N3BWME5aTGxzTUY5SEx0RzRJQVV3cDc3RnVTNXdSM0xWQk5UT0NkOVd2N25L?=
 =?utf-8?B?OFJaY1haeHhBcitiazNSbGZBN1RaYWlab3BQYmZvc2syelJ2VzBGWjQrdENk?=
 =?utf-8?B?YUV5aWVBeHNkQisrR1NjcEpkK3FuMGFiczBLNXRnMmxjMnhOeEdRNURwQ0pX?=
 =?utf-8?B?bnczRnhCLzZnRnU0UVZNbGh3Ty9WdnZEZ3cyYzhoZXVkMit5QjlyeXN3MSs1?=
 =?utf-8?B?RjJFTmN6QWN0YWlmRk5DNzNrTWZDcmRuYndaci8xL3RDSHpwYlVYOXQ5bzJ5?=
 =?utf-8?B?N25ubUx2UkJjbHdkSmN4NUg0bzRvTVl5ekFPMHJuZkxuWHczUnhxdzl5b3du?=
 =?utf-8?B?YmlnT21aZ081amRQN1pCZkhGT1llOXRoc3JCQXprdlQrSUYzZEpMY2h1elJa?=
 =?utf-8?B?SS9uaTZ1RVNWNW81MHJLNitoU251TTdsSkxwL21HRllTWkw1S0Z6NGNybk5n?=
 =?utf-8?B?RVJoM0tDS2w2R2dqRHE1azVITjcyWFVxcGs0NEoram5zRExSeWl6NHM0QllO?=
 =?utf-8?B?b2U1dStEWXh6Z05ycjEvZjlqcHpJTC81SG5LVFVSZUZOMFBvb3pIakpRQml5?=
 =?utf-8?B?WXF4VnJ5UXU2ZURWQTJCTkFld2dZK0tiaXJmWVNld3JlWm1qSWwvSk90ZHQ4?=
 =?utf-8?B?WUsxN2JrWVNVLzVZdjEwekZwTE8zMG9VS2craGt1VHVZWkg5TjN5ZjRjZnFR?=
 =?utf-8?B?NjYyMFVUS3FnOTh3Z29VS2VRMEg2NGQ2dnFyc0xkblptTU53d0t0NjJFUUtV?=
 =?utf-8?B?TncwV2VtSHhRQnZCZXpwdjQvRHNleWNlZTc2K3krTkJiU09JQTV2T0VITjZP?=
 =?utf-8?B?SHV2TUpHUVNPVllRZzRCTUx3TXlhdWVibnlXb0pENTk0UkJtK09vSWhKeTU4?=
 =?utf-8?B?UGRtUjM4UnlqTi8yVFRuVjV6dk9vNXkrbnVFWUkrTDlHbWR1Y0wyYmI2WXlx?=
 =?utf-8?B?ZXNlUGxTaGROM3pIVWVrc0QwRGx3MTRJczYzN0IzRTFPa2ZRZFhmNHYvRjlk?=
 =?utf-8?B?RnJFZGFjd2NwWXpoaCsvaHh5anc4dUpJUTdmU1R0bHFKb1daN1JPeVJGOTVV?=
 =?utf-8?B?bkdOSzRaQ1dFK2l0NGZ6aWU4VkJVc1cxS2xLMGZlK01JVFYrc1YvV3Jjakpl?=
 =?utf-8?B?VGV0YjVTODhSand0cWpIN3NQYnEzV1ZUV2RGWkRHV1V5SVRHRXc4MVU2K1Yy?=
 =?utf-8?B?dk9LVWt3YXY1RHpGcTRuMVBuSlhvMkVDaEhEeXQrdGFwa0FzWWFVNGorZXBO?=
 =?utf-8?B?R1FSbU1NUlVYdUtjcjRVbUZMRVoxSjNiNjczNU1hdDBDM3hEczcrYmk1NElv?=
 =?utf-8?B?ZUNBc282dlpJVlgrQWtBOFlSTElQbURWdVBnS0NPS0czVFNsbE5XK3Q2TGFQ?=
 =?utf-8?B?bnhRbWRObCtzbFd0Qm1WbDQzeS9hZlYxRCtkQXRFbHR2aE5CQitDemZYd2t1?=
 =?utf-8?B?NGcrU0QyM0I1NG4xOWlZeDVqYnJXcHM3WU84bEpQdUZlM3IrYkRtMjZ6M2JY?=
 =?utf-8?B?ZkloMU5hMTcyVmJET0QyNWx4dkdUOVhVREQ3cW9vRTdlTXV3OEczaGM5djBF?=
 =?utf-8?B?SWxPdnJJMWxiQkFSa2FvekRQcURHNkhNait4eFBmM0xUT0dZQVZvb1ZHYzVn?=
 =?utf-8?B?WmpEcmpnK3UxTHk0MUFQQ0NrZ0NxQUx4a0RBODNiVEhWbE9oUlNkT2ZuQ1Vt?=
 =?utf-8?B?QUd6UUVGdE9ER3liZHlTNW1zNm9hMjhzdVlGNFpvSzI2TmVMRitCRWNUejdz?=
 =?utf-8?B?bGpNbnRkUWZZRVdkaHZ4UGhLQ1RuVDU2dnA5Q2Z2TFBndmJ2Wi9LWW9PZDB3?=
 =?utf-8?B?dTdlS1dPRDdmalpFVnllVTBCU2JQR3dnNWNWVjhHZGhpeEI2TmdSb0ltblpX?=
 =?utf-8?B?aTk3bG5kQjE4MHNlYWpvYWwvbnNaMWR5MTBJZitnTmFrbVJzeXJiR3lZNFl3?=
 =?utf-8?Q?Loj0vFgkMiqgGNEvXZ2W6G4V9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBE8BB20E51E6C40AAB55AF8547280FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc8428-ca4d-4e5b-dcd7-08da82124113
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 18:40:13.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biQkpO3KJ77MY279bORdy0gdAtXV5VeKPdyZsQg9xsbUNfEQBiBdfxtoOxJvQyRoiJaQ5hI+puHHbYVnbL3SmAOq+a922PyRtTuVcHob0u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFByYWJoYWthciwNCihidHcgc2hvdWxkIEkgdXNlIExhZCBvciBQcmFiaGFrYXI/KQ0KDQpP
biAxNS8wOC8yMDIyIDE2OjE0LCBMYWQgUHJhYmhha2FyIHdyb3RlOg0KPiBBZGQgaW5pdGlhbCBk
ZXZpY2UgdHJlZSBmb3IgUmVuZXNhcyBSWi9GaXZlIFJJU0MtViBDUFUgQ29yZSAoQVg0NU1QDQo+
IFNpbmdsZSkuDQo+IA0KPiBCZWxvdyBpcyB0aGUgbGlzdCBvZiBJUCBibG9ja3MgYWRkZWQgaW4g
dGhlIGluaXRpYWwgU29DIERUU0kgd2hpY2ggY2FuIGJlDQo+IHVzZWQgdG8gYm9vdCB2aWEgaW5p
dHJhbWZzIG9uIFJaL0ZpdmUgU01BUkMgRVZLOg0KPiAtIEFYNDVNUCBDUFUNCj4gLSBDUEcNCj4g
LSBQSU5DVFJMDQo+IC0gUExJQw0KPiAtIFNDSUYwDQo+IC0gU1lTQw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPg0KPiAtLS0NCj4gdjEtPnYyDQo+ICogRHJvcHBlZCBpbmNsdWRpbmcgbWFrZWZpbGUgY2hh
bmdlDQo+ICogVXBkYXRlZCBuZGV2IGNvdW50DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0
cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpIHwgMTIxICsrKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpIGIvYXJjaC9y
aXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uYjI4OGQyNjA3Nzk2DQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpDQo+IEBA
IC0wLDAgKzEsMTIxIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICsvKg0KPiArICogRGV2aWNlIFRyZWUgU291cmNlIGZv
ciB0aGUgUlovRml2ZSBTb0MNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgUmVuZXNh
cyBFbGVjdHJvbmljcyBDb3JwLg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9j
bG9jay9yOWEwN2cwNDMtY3BnLmg+DQo+ICsNCj4gKy8gew0KPiArCWNvbXBhdGlibGUgPSAicmVu
ZXNhcyxyOWEwN2cwNDMiOw0KPiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiArCSNzaXplLWNl
bGxzID0gPDI+Ow0KPiArDQo+ICsJLyogY2xvY2sgY2FuIGJlIGVpdGhlciBmcm9tIGV4Y2xrIG9y
IGNyeXN0YWwgb3NjaWxsYXRvciAoWElOL1hPVVQpICovDQo+ICsJZXh0YWxfY2xrOiBleHRhbC1j
bGsgew0KPiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gKwkJI2Nsb2NrLWNlbGxz
ID0gPDA+Ow0KPiArCQkvKiBUaGlzIHZhbHVlIG11c3QgYmUgb3ZlcnJpZGRlbiBieSB0aGUgYm9h
cmQgKi8NCj4gKwkJY2xvY2stZnJlcXVlbmN5ID0gPDA+Ow0KDQpXaGF0J3MgdGhlIHZhbHVlIGlu
IGhhdmluZyB0aGUgY2xvY2stZnJlcXVlbmN5IGhlcmUgaWYgdGhlIGJvYXJkIC5kdHNpDQpvdmVy
d3JpdGVzIGl0PyBkdGJzX2NoZWNrIHdpbGwgY29tcGxhaW4gaWYgc29tZW9uZSBmb3JnZXRzIHRv
IGZpbGwgaXQNCklJVUMgJiB3aGF0IHRoZSBtaXNzaW5nIGZyZXF1ZW5jeSBtZWFucyBpcyBhbHNv
IGtpbmRhIG9idmlvdXMsIG5vPw0KDQpUaGF0IGFzaWRlLCBieSBjb252ZW50aW9uIHNvIGZhciB3
ZSBoYXZlIHB1dCB0aGluZ3MgbGlrZSBleHRhbHMgb3INCnJlZmVyZW5jZSBjbG9ja3MgYmVsb3cg
dGhlIC9jcHVzIG5vZGUuIENvdWxkIHlvdSBkbyB0aGUgc2FtZSBoZXJlIHRvbw0KcGxlYXNlPw0K
DQo+ICsJfTsNCj4gKw0KPiArCWNwdXMgew0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
KwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCXRpbWViYXNlLWZyZXF1ZW5jeSA9IDwyNDAwMDAw
MD47DQo+ICsNCj4gKwkJYXg0NW1wOiBjcHVAMCB7DQo+ICsJCQljb21wYXRpYmxlID0gImFuZGVz
dGVjaCxheDQ1bXAiLCAicmlzY3YiOw0KPiArCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gKwkJ
CXJlZyA9IDwweDA+Ow0KPiArCQkJc3RhdHVzID0gIm9rYXkiOw0KPiArCQkJcmlzY3YsaXNhID0g
InJ2NjRpbWFmZGMiOw0KPiArCQkJbW11LXR5cGUgPSAicmlzY3Ysc3YzOSI7DQo+ICsJCQlpLWNh
Y2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gKwkJCWktY2FjaGUtbGluZS1zaXplID0gPDB4NDA+Ow0K
PiArCQkJZC1jYWNoZS1zaXplID0gPDB4ODAwMD47DQo+ICsJCQlkLWNhY2hlLWxpbmUtc2l6ZSA9
IDwweDQwPjsNCj4gKwkJCWNsb2NrcyA9IDwmY3BnIENQR19DT1JFIFI5QTA3RzA0M19BWDQ1TVBf
Q09SRTBfQ0xLPiwNCj4gKwkJCQkgPCZjcGcgQ1BHX0NPUkUgUjlBMDdHMDQzX0FYNDVNUF9BQ0xL
PjsNCg0KSSd2ZSBiZWVuIG9uIGEgYml0IG9mIGEgdG9wb2xvZ3ktZml4aW5nIGJpbmdlIGxhdGVs
eSwgc28gSSBub3RpY2VkDQp0aGF0IHlvdSBhcmUgbWlzc2luZyBhIGxpbmsgdG8gdGhlIGwyIGNh
Y2hlIGhlcmUuIEZXSVcgdGhpcyBkb2VzIHNob3cNCnVwIGluIHVzZXJzcGFjZSB3aXRoIHRoaW5n
cyBsaWtlICJsc3RvcG8iIHNvIGl0IG1pZ2h0IGJlIG5pY2UgdG8gYWRkDQp0aGF0IGluIGZyb20g
dGhlIHN0YXJ0LiBZb3UgZG9uJ3QgbmVlZCB0byBoYXZlIGEgZHJpdmVyIGZvciBpdCBhdCBhbGws
DQpqdXN0IHRoZSBlbnRyeSBpdHNlbGYgJiBhICJuZXh0LWxldmVsLWNhY2hlIiBlbnRyeSBmb3Ig
dGhlIENQVS4NCg0KT3RoZXIgdGhhbiB0aG9zZSB0d28gdGhpbmdzLCBhbmQgdGhpcyBsMiBvbmUg
aXMgaW4gdGhlICJuaWNlIHRvIGhhdmUiDQpjYXRlZ29yeToNClJldmlld2VkLWJ5OiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+ICsNCj4gKwkJCWNwdTBfaW50
YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiArCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47
DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7DQo+ICsJCQkJaW50ZXJydXB0
LWNvbnRyb2xsZXI7DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArCX07DQo+ICsNCj4gKwlzb2M6IHNv
YyB7DQo+ICsJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ICsJCWludGVycnVwdC1wYXJl
bnQgPSA8JnBsaWM+Ow0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gKwkJI3NpemUtY2Vs
bHMgPSA8Mj47DQo+ICsJCXJhbmdlczsNCj4gKw0KPiArCQlzY2lmMDogc2VyaWFsQDEwMDRiODAw
IHsNCj4gKwkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxzY2lmLXI5YTA3ZzA0MyIsDQo+ICsJCQkJ
ICAgICAicmVuZXNhcyxzY2lmLXI5YTA3ZzA0NCI7DQo+ICsJCQlyZWcgPSA8MCAweDEwMDRiODAw
IDAgMHg0MDA+Ow0KPiArCQkJaW50ZXJydXB0cyA9IDw0MTIgSVJRX1RZUEVfTEVWRUxfSElHSD4s
DQo+ICsJCQkJICAgICA8NDE0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiArCQkJCSAgICAgPDQx
NSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDw0MTMgSVJRX1RZUEVfTEVWRUxf
SElHSD4sDQo+ICsJCQkJICAgICA8NDE2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiArCQkJCSAg
ICAgPDQxNiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKwkJCWludGVycnVwdC1uYW1lcyA9ICJl
cmkiLCAicnhpIiwgInR4aSIsDQo+ICsJCQkJCSAgImJyaSIsICJkcmkiLCAidGVpIjsNCj4gKwkJ
CWNsb2NrcyA9IDwmY3BnIENQR19NT0QgUjlBMDdHMDQzX1NDSUYwX0NMS19QQ0s+Ow0KPiArCQkJ
Y2xvY2stbmFtZXMgPSAiZmNrIjsNCj4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JmNwZz47DQo+ICsJ
CQlyZXNldHMgPSA8JmNwZyBSOUEwN0cwNDNfU0NJRjBfUlNUX1NZU1RFTV9OPjsNCj4gKwkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCX07DQo+ICsNCj4gKwkJY3BnOiBjbG9jay1jb250cm9s
bGVyQDExMDEwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEwN2cwNDMtY3Bn
IjsNCj4gKwkJCXJlZyA9IDwwIDB4MTEwMTAwMDAgMCAweDEwMDAwPjsNCj4gKwkJCWNsb2NrcyA9
IDwmZXh0YWxfY2xrPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gImV4dGFsIjsNCj4gKwkJCSNjbG9j
ay1jZWxscyA9IDwyPjsNCj4gKwkJCSNyZXNldC1jZWxscyA9IDwxPjsNCj4gKwkJCSNwb3dlci1k
b21haW4tY2VsbHMgPSA8MD47DQo+ICsJCX07DQo+ICsNCj4gKwkJc3lzYzogc3lzdGVtLWNvbnRy
b2xsZXJAMTEwMjAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA3ZzA0My1z
eXNjIjsNCj4gKwkJCXJlZyA9IDwwIDB4MTEwMjAwMDAgMCAweDEwMDAwPjsNCj4gKwkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICsJCX07DQo+ICsNCj4gKwkJcGluY3RybDogcGluY3RybEAxMTAz
MDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gInJlbmVzYXMscjlhMDdnMDQzLXBpbmN0cmwiOw0K
PiArCQkJcmVnID0gPDAgMHgxMTAzMDAwMCAwIDB4MTAwMDA+Ow0KPiArCQkJZ3Bpby1jb250cm9s
bGVyOw0KPiArCQkJI2dwaW8tY2VsbHMgPSA8Mj47DQo+ICsJCQkjaW50ZXJydXB0LWNlbGxzID0g
PDI+Ow0KPiArCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ICsJCQlncGlvLXJhbmdlcyA9IDwm
cGluY3RybCAwIDAgMTUyPjsNCj4gKwkJCWNsb2NrcyA9IDwmY3BnIENQR19NT0QgUjlBMDdHMDQz
X0dQSU9fSENMSz47DQo+ICsJCQlwb3dlci1kb21haW5zID0gPCZjcGc+Ow0KPiArCQkJcmVzZXRz
ID0gPCZjcGcgUjlBMDdHMDQzX0dQSU9fUlNUTj4sDQo+ICsJCQkJIDwmY3BnIFI5QTA3RzA0M19H
UElPX1BPUlRfUkVTRVROPiwNCj4gKwkJCQkgPCZjcGcgUjlBMDdHMDQzX0dQSU9fU1BBUkVfUkVT
RVROPjsNCj4gKwkJfTsNCj4gKw0KPiArCQlwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMmMw
MDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gInJlbmVzYXMscjlhMDdnMDQzLXBsaWMiLCAiYW5k
ZXN0ZWNoLG5jZXBsaWMxMDAiOw0KPiArCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4gKwkJ
CSNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KPiArCQkJcmlzY3YsbmRldiA9IDw1MTI+Ow0KPiArCQkJ
aW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ICsJCQlyZWcgPSA8MHgwIDB4MTJjMDAwMDAgMCAweDQw
MDAwMD47DQo+ICsJCQljbG9ja3MgPSA8JmNwZyBDUEdfTU9EIFI5QTA3RzA0M19OQ0VQTElDX0FD
TEs+Ow0KPiArCQkJcG93ZXItZG9tYWlucyA9IDwmY3BnPjsNCj4gKwkJCXJlc2V0cyA9IDwmY3Bn
IFI5QTA3RzA0M19OQ0VQTElDX0FSRVNFVE4+Ow0KPiArCQkJaW50ZXJydXB0cy1leHRlbmRlZCA9
IDwmY3B1MF9pbnRjIDExICZjcHUwX2ludGMgOT47DQo+ICsJCX07DQo+ICsJfTsNCj4gK307DQo=
