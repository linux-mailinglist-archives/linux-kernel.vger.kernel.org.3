Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81DB5AE580
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiIFKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiIFKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:39:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F357541;
        Tue,  6 Sep 2022 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662460751; x=1693996751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BSfomfDChoqAThO5tYRfX4MwjaIpCXBCp960YeCNVjQ=;
  b=0qup7cV6s2Ys8+ck2kGB36bh3VRjxw0tM80qI6/hf7RgR13ViJQm7mSo
   Gt5UXt6tI5fJyhoj5SCfYn6jdjpb+KnBUg5NnL1b2TYv/hpjkiEppjknf
   hGuxQlz2SI23R66jCLKWuZzuD1lskVptEKaYEUM0Tq7on7PjAil7rW8eT
   nuwLeb1ItGo2bHBqZFjmRjpILIeZttOsXrdQggdnq6qJtiMd1TvJGewGy
   GFG63XMmG2WMrztd2nkeNc1rTTxDDpoVgCHDIA0foeMl3GiQZobl/c7rd
   pcLZqJOC6WRY1Z4QGAZffcRm+C6qWCmsCTRG5ssrmmS7JQED2UMmGaipk
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="189577318"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 03:39:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 03:39:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 03:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/LCZKBlvPcRhSdbILu0IqtmFef78aCuobA5SCRWn5yA6NE7t1/TpQkI/d+QumrIuN6qe71hwAwry1EuKQtzSVqKpX/lYvD/WGtvisKmiwwRJBGIK4yF1OUe5D927s408kgL77UQ01HSyLHGOr1mkDNLQvuwUNBlHEK66mvD61hveNwYMWtyIhpxJ4Hu5k5gXxEkauQ1UBXBR6VR/+siKzttX4gYOUMZsJsqH/0Dj4zoJFPtbWn3HvwNZ8Nmx/7NxC6+0jkZR4NtnumjkMPCfia+TTJ8qScXVBxRwcQXfGNtzuVLHGKeZ5jY4NeVjAeBPfmiIuIGUHihBSuHDOjFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSfomfDChoqAThO5tYRfX4MwjaIpCXBCp960YeCNVjQ=;
 b=RAK71wShx1DCfiYMNDCAJSrJWrqvRoDiwI/EchM7NyUE8ULz7g9bqJCe4+DYb5FfC77H4UxWwJ+emYcNbdP0+VPvdv7eSBoyKR92NvDndD6loGQfvLeUZi/NZA8cKD8OTumbpJBVdlgk2K42hqMlDjSlA2oJ8VlpNFWj5hQrihPUVKvrM0jcQjHJ+mE5T8mYEDhVVhh8ARouP2CM8UttixGg80g5P3dmf3uLOzjQBKGoBAl9VUektm2aN5Snpu9RYmiSHpyh6dVz+vXFRoG0N8tNGrfhpNsBM9orMy/kTWTW9XWwSppWrFXiffFDVv/efA0TVgl1PximctuT9qkWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSfomfDChoqAThO5tYRfX4MwjaIpCXBCp960YeCNVjQ=;
 b=p8y4wh6Cdj8lY5VX/dFPNS4XclD+R6F2k9RF4JhBvZ4B1vm5vyulNiOis7Z7SWUufwJ1G1GjZYC9TX2m5JcXTVaD3ttaXW76XdFGe5MjWbavzy7jSqMQ/q21WfHRLYukhWwZDUaT96YdWp9aJRbywMeBtspIfhCgMz/h4YzkpPs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1980.namprd11.prod.outlook.com (2603:10b6:3:10c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 10:39:03 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 10:39:03 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <atishp@rivosinc.com>, <apatel@ventanamicro.com>,
        <geert+renesas@glider.be>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqljaYH7D6050aAz/t+qDALqK3SNfiA
Date:   Tue, 6 Sep 2022 10:39:03 +0000
Message-ID: <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08d63a59-d912-4436-85d9-08da8ff4042c
x-ms-traffictypediagnostic: DM5PR11MB1980:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/rrT6MujvMuP8sKg6W3r4qt/2Q1o36JFdWd9oo3+QSYUwwkedvLEyaO2c+CF1d7OMd/Do7VcJgog707hUOTgTdq4BDlc8SY2FZpj6+A2OaFCq62UqkSV0kapBD6AIm+DyYKo00Hs20IMfnnNPW1Dkb7Ruulj8HiUxBGuUxhzB31k0dDpYD6z9vA8U+6DI+6RBpmlP0aycYROPxSFQGdxUeQbGreVpgN5Mic9G4SbYmuPZ2N9iR+Vr22lZ/m1YzokeuujI2L7TzO4u8eXGUguQCa4MNqYdNi9hy+y9aQH1P3A1Wp/7pS6Q+VBhxbAr2dd+ddfwUDd/hz0bIfmdoL5ITr3jfDBgSB7afKtJwXIzchX2A9idTr3MgZTTAzkJzubunWT/5SsXp+WqrIX2BoC5L93HOmudD1K+eCXQmr7QOReWwT2C8Ew9HCVDE7wGomNxo+q46RI+KHg+8zIiJH64gzW5YrCYefeuTSr0AgUnqcDshPrgWQKR4NSi3OqzWB85Ei5yxs9wzvjE1UNMBUf2hsX4uj6YziKi1nOciIiBMOYwJyCc1zY0kkn+zWzIv78a6rTDWy5UyLOmWOpAJL5BGFM2bRf86tO7thywN6HoAsU6/DwmVEZHjt1IzizmAi2Uy/hhLuOZipS+Dfvq2Vumj31Iipkz+P7XlBVh9n49ntoN6StqPjqANVfLSrhQcEe2mou9h8h/IDI6QVxrOEa/gHf1A1cqM8bY9jvVUJnNq/lM9OIjVFXvbHo6wIQnAxBmH6MMkZpygN2uiwx2sZf2f2IMMmym9SXKGecaVM6BPmOCAPywm/clM9LTTe4AKsQGFRBgHdHrOGXwUhxmkKENEY/DCUF9BbpeRlTAfQwFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(396003)(39860400002)(6486002)(91956017)(966005)(41300700001)(38070700005)(478600001)(316002)(110136005)(71200400001)(186003)(2616005)(38100700002)(83380400001)(122000001)(54906003)(6506007)(53546011)(26005)(6512007)(2906002)(36756003)(7416002)(8936002)(5660300002)(31686004)(76116006)(86362001)(8676002)(66946007)(66476007)(31696002)(64756008)(4326008)(66556008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xBRHFidDZVajJUU1ZrQS9EbUZoR21sbUdhdC9MMk9oR0NLZWhmWW80UHFE?=
 =?utf-8?B?dSsxT1UrMkV1bXNMNm5LZkt6V2tnTFZreFlxN1lxS0pGYVBDemE4UEgwNWhE?=
 =?utf-8?B?K1BVNlpTS2tuN0ZPNXM4a054Sk9ma2wrMzFHQzNadU5qUWVzZ21Mby9xL3Np?=
 =?utf-8?B?UGgwc2ozaDFTY0Fsb3BCajNJODlmcGtQV1N4SnBITmlzK2pwZ2hCSklOZndq?=
 =?utf-8?B?MjRVR2dTTXNrbDFVYUxJKzdMcCsyWEJXVVp2MnZ5VnZ3bW1nUnNyUHdTR28z?=
 =?utf-8?B?RTFUMHZCUzJ2aEI2cHFKTFhIRFc2cXRzVUFVZHBhQ0tOOTlvakQ1RnVkb29L?=
 =?utf-8?B?ZFhkSVBQeUJaaXhQak1TNlpRUVBRenhvaE03VnMrT0NEOWR6SmJRVnFqcFZR?=
 =?utf-8?B?TkswQi9aSVVtRVorYW1ZWjE4c25IVEZWYzNOVXpXQXd4YzlxYU4rV3I5Sk81?=
 =?utf-8?B?YW1oeWxVUWRWQ2lncmszTStCMmtaeVE4WDd5WGVYN2JPSHJDcWhWWHorMlRJ?=
 =?utf-8?B?OFBxNkU1YWZJdWpuMFRKeFBVcDNucnhvOC9keTlINDlCcWxGTHZJeXk2WjJ1?=
 =?utf-8?B?cHJoeXZ0MldVckVZcEhvZkNIWUs4cmczZHE5VmtGY29Eb3pTczlaeWtTbFJH?=
 =?utf-8?B?dXBQN3hlYWtoemcxcnEwSXp0YWZtNlpBVlJmejFKUWh0K1lwTUp6MU9tcHE5?=
 =?utf-8?B?bXBONzhGcXcyRTcwWmJKR0J0VDZYZFBJV0RNLzVRcE96UkllWG8yM0liWGZT?=
 =?utf-8?B?bEoxUS80TW9ITFF3OVEwMUFRSG9QLzRUVWJjVm01SnhreDdHUkFIb1cvTzBP?=
 =?utf-8?B?OEJ4SDgvWmdoUlF1cGZjaEpUSDJFUHVaYnZZbVFOYkdDT1ZYZmUvYnZwZmk4?=
 =?utf-8?B?TEtZVmtsNis2UTVmaWVFWWJvc2RkRG43Zm9ERGpmay9pbG80d1RNa3ptSHhj?=
 =?utf-8?B?N2FrUlhmS0FBU2VjZ2VJcERoODVUbkxMcGlqeEN3WEg1M1BwNXlyeXNVSWZX?=
 =?utf-8?B?Mm5Cd1BkTGVKa3BSVVBLemJmZ0hNK2VuZE91Sjl5M3pKMVU4T1lBM1BaeEg3?=
 =?utf-8?B?TjkyZ2k3QWZWTmxkMkd1Y29GYTVsbWZTdktRRnN6UmtNZDIyOU9HK0R0U056?=
 =?utf-8?B?UDB2ajR0UnExYnlra3g1L3lRd3Z2eTI1bW9JNDR1eGZlK2tZSTFzZ1M2a0tn?=
 =?utf-8?B?UXdGcERnTzFHOXNRQUxHcW9TU1pVMnVBZG15emhEaHdlRXBzalpTWWgzUVhR?=
 =?utf-8?B?TkZYMmFGQmUyL1lvR1pLV0g2TzR0QURtaUpoYk52WlFlR1RlSXBmcHkrS1c4?=
 =?utf-8?B?TnZCOWsxSmlRUWovODRrampOclRNemxESmpJM0lDMmVucmhzeHZZUU5UaWc2?=
 =?utf-8?B?UzJUOGJ0citRLzhRSlBIS2FxcXpsa0hNM01KWER2NFdFMFYzR2dSWmNxQk1v?=
 =?utf-8?B?U3JBRlRRd2Y3b0RscG04QW56NjRPS3QycGJlVlcrdlRCdlpVa3htUm9WdTRi?=
 =?utf-8?B?bTl1N2h1UXBJNlg4MkdyWWt2Sk5FcjhtWFFtbHRGOHVYcmUyNlVaMUc0Ykxv?=
 =?utf-8?B?ZHY4QmdqdGJtczdWekRZVDdGNmdyb2l4Vk1ZWTJ6TkljRFl3eXJPeGt5VGEy?=
 =?utf-8?B?U29VUzM0Vko0US9Tby9wZThjc2lmRzZZR1pod1FsSHNjK1NpRVpPbUxVNTlo?=
 =?utf-8?B?WERGWGxrc3NGY0piOHBrbnZJeFZMRUNlekxYMjhGVmxqZy8rOUR6YUZ0b2pC?=
 =?utf-8?B?M3dvRktqblBXRnhDcnc2TW9CVjNQWi9ibkR3TmUrVG80b2xrb0JGcm1ocW5O?=
 =?utf-8?B?UWNURytnMFpPZk9NYjVyWHpycU9KTHFQaGhDOVUrRlBCMmFXZjN3amZJZjMx?=
 =?utf-8?B?d1ZiTXpic1lHMTR1VUh5VEFkVFBSdnE4UXl5eUFsNU85UC83dHpqNGJzQThP?=
 =?utf-8?B?RHZRZjI3aTRZemtQZ0twQVZrTlpaWjFnRjBlL2x6SlN4K3F5RjZUNHdVUTg4?=
 =?utf-8?B?M0JQczFCMlJQWjlEeGVrYnhtSDI2dys2Tm8yaUNZY3k0N29tR1lCZ0pTL0g2?=
 =?utf-8?B?M2tJWGhWc0E5QmRzVjdVOEFVVEJ0WXVvdlVsTTBtTU14VWk2RVJQc09MNitD?=
 =?utf-8?Q?8NIe5/ggkWGwvEEVvoKk3lcQ2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47DD2DE5330C4346BF550BEEDA95FE1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d63a59-d912-4436-85d9-08da8ff4042c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 10:39:03.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMHiWJ9exijv6Rr/rI4VmJM/RdV1VW2Z1ffMTiAN49ApL49Zpful4OFiU9QGY2qphexHjollwD9jz+4nbb0bUTzgYs1lIVU7UBGIWh/W0CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1980
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAxMToyMSwgTGFkIFByYWJoYWthciB3cm90ZToNCg0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zYmkuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
c2JpLmgNCj4gaW5kZXggMmEwZWY3Mzg2OTVlLi4xMGE3Yzg1NWQxMjUgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2JpLmgNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9zYmkuaA0KPiBAQCAtMzcsNiArMzcsNyBAQCBlbnVtIHNiaV9leHRfaWQgew0KPiANCj4g
ICAgICAgICAgLyogVmVuZG9yIGV4dGVuc2lvbnMgbXVzdCBsaWUgd2l0aGluIHRoaXMgcmFuZ2Ug
Ki8NCj4gICAgICAgICAgU0JJX0VYVF9WRU5ET1JfU1RBUlQgPSAweDA5MDAwMDAwLA0KPiArICAg
ICAgIFNCSV9FWFRfQU5ERVMgPSAweDA5MDAwMzFFLA0KPiAgICAgICAgICBTQklfRVhUX1ZFTkRP
Ul9FTkQgPSAweDA5RkZGRkZGLA0KPiAgIH07DQoNCkV2ZXJ5dGhpbmcgZWxzZSBhc2lkZSwgSSBh
bSB2ZXJ5IGludGVyZXN0ZWQgaW4gd2hhdCdzIGhhcHBlbmluZw0KaGVyZS4gSSdsbCB0YWtlIGEg
cHJvcGVyIGxvb2sgdGhyb3VnaCB0aGluZ3MgbGF0ZXIsIGJ1dCBmb3Igbm93Og0KDQpGb3IgUG9s
YXJGaXJlIFNvQyB3ZSBoYXZlIGFuIEludGVySGFydCBDb21tdW5pY2F0aW9uIFNCSSBFWFQgdGhh
dA0Kd291bGQgd291bGQgbGlrZSB0byB1cHN0cmVhbSBzdXBwb3J0IGZvci4gV2UgYXJlIG5vdCBh
aW1pbmcgdG8gcHV0DQp0aGUgZHJpdmVyIGl0c2VsZiBpbiBhcmNoL3Jpc2N2IC0gaXQncyBqdXN0
IGEgbWFpbGJveCBkcml2ZXIsIGJ1dA0KSSB3b3VsZCBsaWtlIHRvIHVzZSBzYmkuaCBmb3IgZGVm
aW5pbmcgdGhlIHZlbmRvciBpZCBldGMuDQoNCkkgYW0gbm90IHN1cmUgaG93IHRoaXMgYWxsIGFs
aWducyB3aXRoOg0KPiBXZeKAmWxsIG9ubHkgYWNjZXB0IHBhdGNoZXMgZm9yIG5ldyBtb2R1bGVz
IG9yIGV4dGVuc2lvbnMgaWYgdGhlDQo+IHNwZWNpZmljYXRpb25zIGZvciB0aG9zZSBtb2R1bGVz
IG9yIGV4dGVuc2lvbnMgYXJlIGxpc3RlZCBhcyBiZWluZw0KPiDigJxGcm96ZW7igJ0gb3Ig4oCc
UmF0aWZpZWTigJ0gYnkgdGhlIFJJU0MtViBGb3VuZGF0aW9uLiAoRGV2ZWxvcGVycyBtYXksIG9m
DQo+IGNvdXJzZSwgbWFpbnRhaW4gdGhlaXIgb3duIExpbnV4IGtlcm5lbCB0cmVlcyB0aGF0IGNv
bnRhaW4gY29kZSBmb3INCj4gYW55IGRyYWZ0IGV4dGVuc2lvbnMgdGhhdCB0aGV5IHdpc2guKQ0K
PiANCj4gQWRkaXRpb25hbGx5LCB0aGUgUklTQy1WIHNwZWNpZmljYXRpb24gYWxsb3dzIGltcGxl
bWVudG9ycyB0byBjcmVhdGUNCj4gdGhlaXIgb3duIGN1c3RvbSBleHRlbnNpb25zLiBUaGVzZSBj
dXN0b20gZXh0ZW5zaW9ucyBhcmVu4oCZdCByZXF1aXJlZA0KPiB0byBnbyB0aHJvdWdoIGFueSBy
ZXZpZXcgb3IgcmF0aWZpY2F0aW9uIHByb2Nlc3MgYnkgdGhlIFJJU0MtVg0KPiBGb3VuZGF0aW9u
LiBUbyBhdm9pZCB0aGUgbWFpbnRlbmFuY2UgY29tcGxleGl0eSBhbmQgcG90ZW50aWFsDQo+IHBl
cmZvcm1hbmNlIGltcGFjdCBvZiBhZGRpbmcga2VybmVsIGNvZGUgZm9yIGltcGxlbWVudG9yLXNw
ZWNpZmljDQo+IFJJU0MtViBleHRlbnNpb25zLCB3ZeKAmWxsIG9ubHkgdG8gYWNjZXB0IHBhdGNo
ZXMgZm9yIGV4dGVuc2lvbnMgdGhhdA0KPiBoYXZlIGJlZW4gb2ZmaWNpYWxseSBmcm96ZW4gb3Ig
cmF0aWZpZWQgYnkgdGhlIFJJU0MtViBGb3VuZGF0aW9uLg0KPiAoSW1wbGVtZW50b3JzLCBtYXks
IG9mIGNvdXJzZSwgbWFpbnRhaW4gdGhlaXIgb3duIExpbnV4IGtlcm5lbCB0cmVlcw0KPiBjb250
YWluaW5nIGNvZGUgZm9yIGFueSBjdXN0b20gZXh0ZW5zaW9ucyB0aGF0IHRoZXkgd2lzaC4pDQoN
CldoaWNoIGlzIGluOiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9yaXNjdi9wYXRjaC1hY2NlcHRh
bmNlLmh0bWwNCg0KSXQgaXMgdW5jbGVhciB0byBtZSB3aGV0aGVyIHRoYXQgaXMganVzdCBmb3Ig
SVNBIGV4dGVuc2lvbnMgb3IgaWYgdGhhdA0KY292ZXJzIFNCSSBleHRlbnNpb25zIHRvby4gQXQg
bGVhc3QgZm9yIHVzLCBzaW5jZSB3ZSBkb24ndCB0b3VjaCBhcmNoDQpjb2RlIHRoZXJlIGlzIHJl
bGF0aXZlbHkgbGl0dGxlIGZyaWN0aW9uICYgdGhlcmUncyBubyBjb25jZXJucyBhYm91dA0KcmVk
dWNpbmcgdGhlIHBvcnRhYmlsaXR5IG9mIGEga2VybmVsIHNpbmNlIGl0IGlzIGp1c3QgYSByZWd1
bGFyIG9sZA0KZHJpdmVyLg0KDQpJIHdhcyBwbGFubmluZyBvbiBjb3JuZXJpbmcgc29tZSBwZW9w
bGUgKmNvdWdoKiBQYWxtZXIgKmNvdWdoKiBhdA0KTFBDIGFuZCBhc2tpbmcgaGltIHdoYXQgaGlz
IHRob3VnaHRzIHdlcmUgdGhlcmUuDQoNCkZXSVcgdGhpcyBpcyB3aGF0IHdlIGhhdmUgYmVlbiBk
b2luZzoNCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eDRtaWNyb2NoaXAvbGludXgvYmxvYi9saW51
eC01LjE1LW1jaHAvZHJpdmVycy9tYWlsYm94L21haWxib3gtbWl2LWloYy5jI0wyNw0KDQpUaGUg
SVAgaXRzZWxmIGhhcyBub3Qgc3RhYmlsaXNlZCB5ZXQsIHNvIHdlIGhhdmUgbm90IHNlbnQgYW55
IHBhdGNoZXMNCnlldCwgYnV0IHdlIGRvIGludGVuZCBkb2luZyBzby4uLg0KDQpCdXQgeWVhLCBJ
J2xsIHRha2UgYSBwcm9wZXJseSBsb29rIGF0IHdoYXQgeW91J3JlIGRvaW5nIGhlcmUgc29vblRN
LA0KYWx0aG91Z2ggYXQgdGhpcyBwb2ludCBpdCBtYXkgYmUgdGhlIG90aGVyIHNpZGUgb2YgTFBD
Lg0KDQpidHcsIHdoZXJlIGNhbiBJIGdldCBteSBoYW5kcyBvbiB5b3VyIGhhcmR3YXJlPw0KDQpU
aGFua3MsDQpDb25vci4NCg0KDQo=
