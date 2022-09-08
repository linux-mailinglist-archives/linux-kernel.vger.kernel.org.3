Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF985B1516
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiIHGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiIHGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:49:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4EAD347E;
        Wed,  7 Sep 2022 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619740; x=1694155740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6bkL2eq0fz5ivVvDc/2+nNeu3/W5d9jig+NCAVETu5Q=;
  b=UTFQ7GdiYoV4qojkLudvWAZQltzVKgpxHwScfyTyXhgk6dwovr6hF7Yk
   nE7obUvRLtb5G1Jk7fnf9FuoDZD6D8cgFjJaAjjvOFbog5uWgIERsmBla
   +uajJb65aNd+PNI19X6K3aNr9jxkEoMgkiRGc0Pq5cLbP1Eo5dFK0vL0o
   TF73aoXCoD0NtkAvz65gyVpFD+05NPeAx3tH+f5Sed+oxBB3T8+s42EEh
   mJw4pZRwKHVFhPfy2b08tj7E6S62t63NEF1nQZqme85tBPIlR8xlTPVig
   Rjl7gI5xPw5I8GTBEUowD9iYqO4n4iRABqfXXflOEbRen8Vdg4Toj8CyS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179642403"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:48:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:48:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+ozLrT6OB8zqpQ+Jo3+3TeRxI/wajzCeuVmbIu+Q7WkniKZcaJhXVcUihsbyepzi3lL7gRc6pjh9u31oO9cHUzyCHrYpiG+0uADM4FOCVT/vqeJTmgu8JFNSDR8G2CrqSxjCKA0X6pCvrwtC5cWGS7ar8uWo3/PdDur7Wcma4JsTuq1LmLG9xR+DHiv8bB1IPVB02EhXaJ0q+ieCYE7bF0H8LviFeR4EQrurVoQVWva4skRe6SdsgsPx/pP171cn14ZA7WwXvjvALwztczJ6Pq4rhOxsvOyUk/wJIlbJnxjdan8NiYXiN91avGRi9mLlzJ9Rfwd335Ha/kXHBFlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bkL2eq0fz5ivVvDc/2+nNeu3/W5d9jig+NCAVETu5Q=;
 b=cAheA8vxMRgLFCephxWJfIs3a6Q1LKh2d997BFhIyFgTaP740cqmM/rRCsBuDn4z2T52JXSyAWtMhblRcPXG0XovuHKQ/Rcxd2LeNUS4lGbg1ELqyAz0m0/5Wo48eCIADOKZc30xh6R43Dkhh2cO4dGf/5UqNfNyq5us3t9JBhRUigsJzD2eZ3NkvosJVSl9Dv47jTjOaKm/9ppCy2wJjGQiVCngCaTH0CwdyGLIgzcbU/hz5Z2hW1o2zq6U4tLakTDu32+8DI3gK7PUuUQ+jYmY51JS41CFWyNf5S8SDGW/eSsOtGdFQz9QWS8Miq8daNum/SP4uZWHIBN30FGQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bkL2eq0fz5ivVvDc/2+nNeu3/W5d9jig+NCAVETu5Q=;
 b=maclx7QxglMchO5i+4YKGILqJmqTeTmU0GgiyHw1CIkhezRwqDaL4APBsYhpkgre5TsK6LWsHJDGIdoby5t9lf1yT4td+ZWCJYvZLY2phUnb5kDgeOZDf0RWt3RUilGiVOrUTvUZxg5SyT3DgWXHseWu/tZjv3FogarI8fguFzY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 06:48:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 06:48:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <nathan@kernel.org>
Subject: Re: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Topic: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Index: AQHYvG98o22tTG+7mU6lxnNYP43gca3VJAaAgAABIAA=
Date:   Thu, 8 Sep 2022 06:48:50 +0000
Message-ID: <9ffd5028-6639-9c3c-e09b-c9b7602a2ec1@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-1-conor.dooley@microchip.com>
 <119b58b7-7757-7f76-1472-8047961c9dd1@microchip.com>
In-Reply-To: <119b58b7-7757-7f76-1472-8047961c9dd1@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SJ0PR11MB4879:EE_
x-ms-office365-filtering-correlation-id: b19060d0-5037-4f11-d132-08da9166300e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pP2BlyIBHDLYyHHJjT9U693oEfmQJEyWnybx5jZRpUQ63kkeMN30pRuidU4H40AHU3PS7EWEzFIZrUOIhQhkVPCSKa13ShmFEdfrSKmmPhCDFK++2d9P9eGcMPIqrqF8BGhUvog2TEvtLSrkbjvUWSy2Et6Sagv6Lyk3sE86vP7QOyOhgheZrhjwlTnaE+kVy2UEghtVDOjUHTBQn3SjSzbx+PmAdGWlR9vB7aHtWO/Xm0wM49NKfepMvauX/XSzmyJ8Xtm44TeFnKTe9CcVZ1h3z9bcI1jFY/DGYj8hxuhEbSHIPJWZle9GEiTFy3XED3nLIrMDeZ5wFVYTmdCe0Bl1mjwb64R/vGf5U/ORev3ZRxK0dJjULY7Zp8D55NrtukiPgvOry7UCVea0+lEhtMH954YJp8acWELFrBm/2NDckloSEI1vwlGek0cElhE9X/RJPCXRNSfd/kY/X4NzfXzqWVsrF6/6XGig13MzWQ4LqjJZflVGHJirLqdN71ewaNSisbTUokh4p4tHSShXU3IBb2Z9kUCjXK46la4Ok1HNSBz8W8oiwH3uOE7k1bPalTsb27r4F1gnEENUO08O1VYE8YeRmCju4mXXth865h91Rh/XeaN4cSiU0mzPxJKIRi9KDCfAhHgJqWH6tZq5BYNsubY29Voz1gHCaM/zNfeZMOp/vaRX8KWBBkUFznuRqBSf62QC3OD0wXi0/0z/aE0T8kRfwni2Y/AWC5a4ZMQbuJoJ+yEKS/u3aRk9Q4JpHIeMtTeAs9fuPUql/eAlpjng4Bzjjyac0HDlHHP5sILTkFlzTCaEgrHgVuwTLv14IUdVnxRBcFd2RaneuuG0zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(39860400002)(376002)(31696002)(26005)(5660300002)(8936002)(53546011)(86362001)(110136005)(6512007)(6486002)(7416002)(2906002)(6506007)(71200400001)(2616005)(41300700001)(186003)(478600001)(31686004)(36756003)(38070700005)(45080400002)(8676002)(6636002)(316002)(66946007)(66446008)(76116006)(83380400001)(38100700002)(4326008)(66476007)(54906003)(64756008)(66556008)(91956017)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NxcEZueEpWblQ3YjJrbWUxejN5RkJFVkptbDVNcjlTdkJscXVhR1ZRSE1u?=
 =?utf-8?B?L0NXaTk0aU9oU0VQZGlkaC8vMStKV0llVUYyeGo2dkh5N0RKKzVTYlF0eHdj?=
 =?utf-8?B?YURldWR4N2IrSjZUN2hra1JMaWg4Um9aRVlMR2lKUExCVnBKN2U1clNsM0lY?=
 =?utf-8?B?NVcrZ1AxQk9QTWl2bXZPYldmbFNudHlMaTd1TURWbWswcUlYWDJMWUU3c0FS?=
 =?utf-8?B?RFUyYzlFbzE2UjQ5YUY3dlVVQnhGdUNPcVhkZ2F2cm4rcmR5K29hdTBqOEhj?=
 =?utf-8?B?cWNuRUZKKytzR1NnVnJpYjlHNVhYWk9Rb2ViSUsvMnJYRC9iaEVYT1JTQ3Vy?=
 =?utf-8?B?MUEzbno0eE92WkhxOUlmVVRuVlI3Q3RoWWhMM0R5YkZpZVI3MzRpeGZOU2FM?=
 =?utf-8?B?Ry9nU29VN0dXNm90bWFWYjMzV0UvdEhySkNtNkpVQUpxTUgzRXQxVkFaZW16?=
 =?utf-8?B?Yml6UU1CN3hKRC9MQlpyOU5WL01MSDJoNkJRaVoxeTFGbllMQVIrWnc2dCtl?=
 =?utf-8?B?czdMUXQ4U3g4TlhHOHorbXV5UnB2d2tMZFZ3VFRrZXNndGtXcGhNWXNNcUJk?=
 =?utf-8?B?Y3Z0WktYbG5IbkFoejFPMkc4YWhnWXBLWTdkbi9zb2lLMlcydXpNMDYxYUdj?=
 =?utf-8?B?K2tpbUlpMUV4bWlBamlDUU9CQzdpc21wODl1V0JMdStEcklOeDhvQTZSdkxv?=
 =?utf-8?B?VGtPNXZPRm05K254bHU1SFhickRrVHdVeHBtczZTRnFjRUUzUzBxUEpYWGRn?=
 =?utf-8?B?c1R4TmVuNTNPcG5FUTkveFNJM01Bd2plUjRzblNkS0hpZGxJMzJNbDN1Slli?=
 =?utf-8?B?YWJMUFdWT0JwRG1KcDRia2ZvMmJ2bU1ONDM4QktVbUl6Tm93eE8rMGFNbXhV?=
 =?utf-8?B?R2hkbFdMempOeTJNWTNFcEhCdWo3dU1lWHUyWThTUXJqbmxJa1JJS0wwTWpS?=
 =?utf-8?B?bElNOTZFcmJmZnpKVTd3Zm5ndnFCaS82Q2ZsSEFad1BnQVp0UFVudlN3RGRF?=
 =?utf-8?B?RitReldISk1UeGE0VE84QWJTNlJIZzMrN0VSY1hGdmlsOEdia2JRY0FRY3Vy?=
 =?utf-8?B?L0NqN0pWR1Jnc09ScjZma1pLcUVUcmtTcmsxQldrdFkvZWRQSk4yREorU01Z?=
 =?utf-8?B?UnZqdVlwVGlFeGVmM3U1cFlxM2hQNmkwY2NDWEhCL01XcFZleFpMeXlwQzQy?=
 =?utf-8?B?bi9MblM3QkpUMThUSEZhWjFtbzdIZktZSE9TUkRucGVBZklrZUluYUFFWTdJ?=
 =?utf-8?B?Q2NTekJmT0YwR3hHNWkvbzhFTEVJejRNaDBwY1E1NHE1Uzh3RmZSRXhTNmQ0?=
 =?utf-8?B?RXNWYWx3WU9zeGk4QW5xbXhoWkZBTlZPUmFEdVhZMkRNV1FBMlpscmhMZE8v?=
 =?utf-8?B?RGlnNGQvM0ZUTFZVa3hJV1BDNHFoWWtieDNoSkZsQzRkQ3pxYm9NZkhtdzB5?=
 =?utf-8?B?cWV6UVM0clM3T1NjNDhvanJhbmlMN1VnbXpoeEhUNFdrUEp1b0JZYUNTd3Vy?=
 =?utf-8?B?SlNDR0dYaGEvd2h4ek9YWlJNbzZNdHdHM3JiUzMwWXk4YWZSQkovTzFHK2Jj?=
 =?utf-8?B?UHhMdDh5aTVESDJtM3QyTGdCT3Fuc0tTT1VPSFZsRmowcEVqNHJrUzI1N2g2?=
 =?utf-8?B?ckQ3YjlOY1Y3Sndsd1BBclJmSG9xb1pIVGY0R0luU1d0K0kyR3MyRzJXcUdB?=
 =?utf-8?B?YmtONTV4MllSNkRLcmIvaVJzMXpZTm1WQ25wZ21OekdUYVNMb0FTSE5zNVRF?=
 =?utf-8?B?NWIwNHQycUNvQThzbFZvRW44SlhXVnNiWHQ4T2JoajFvL3gxR0dQUWhzSjZZ?=
 =?utf-8?B?amVuWkdJMkhNbVNNQlZhdGlzajlxYnNxSHNBcHp3b05mSTNjblpEWlZ2Njhq?=
 =?utf-8?B?c0F6Yk0wVEhvRXNOeEFsbGVHdHN1WE9WMGhOT21nUXlKT0FrdFNyQ1htclBW?=
 =?utf-8?B?bHlDOXowbE9nYUlYNGlGdmpBWW9ldjczT1Vac1R6M2dkUmpWNm1sc2JZREVl?=
 =?utf-8?B?bEY2eC9TdXVUNjZzaXFVekhlYXV5RHpDdnJsUW9jbTBHa2dYQmtESWtjZVRT?=
 =?utf-8?B?eEs1V2NPb3d3dklDL0w5Vm5mOHdvQU9lTnBwM0VXblBCYjR5d01ORUs0alBJ?=
 =?utf-8?Q?XJv1iTW5zHU+/9b9Ch6hzaePf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82956AFA45923A4EA38CCA81141061F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19060d0-5037-4f11-d132-08da9166300e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:48:50.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noXgTQATizCxJQfArCvAkTpS5WqgFgfdc5hG55vXn2Rv9pQuaU/qF1bWZATTSib5AcDUp5QZb1Z/La5NApfwvxmFBE5WJYept2XQgppPIK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAwNzo0NCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDMwLjA4LjIwMjIgMTU6NTIsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IFVubm90aWNlZCBpbiBj
dXJyZW50IGNvZGUsIHRoZXJlIGlzIGFuIGFycmF5IGJvdW5kcyB2aW9sYXRpb24gcHJlc2VudA0K
Pj4gZHVyaW5nIGNsb2NrIHJlZ2lzdHJhdGlvbi4gVGhpcyBzZWVtcyB0byBmYWlsIGdyYWNlZnVs
bHkgaW4gdjYuMC1yYzEsDQo+PiBhbmQgbGlmZSBjYXJyeXMgb24uIFdoaWxlIGNvbnZlcnRpbmcg
dGhlIGRyaXZlciB0byB1c2Ugc3RhbmRhcmQgY2xvY2sNCj4+IHN0cnVjdHMvb3BzLCBrZXJuZWwg
cGFuaWNzIHdlcmUgc2VlbiBkdXJpbmcgYm9vdCB3aGVuIGJ1aWx0IHdpdGggY2xhbmc6DQo+Pg0K
Pj4gWyAgICAwLjU4MTc1NF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMGIxDQo+PiBbICAgIDAu
NTkxNTIwXSBPb3BzIFsjMV0NCj4+IFsgICAgMC41OTQwNDVdIE1vZHVsZXMgbGlua2VkIGluOg0K
Pj4gWyAgICAwLjU5NzQzNV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50
ZWQgNi4wLjAtcmMxLTAwMDExLWc4ZTE0NTljZjRlY2EgIzENCj4+IFsgICAgMC42MDYxODhdIEhh
cmR3YXJlIG5hbWU6IE1pY3JvY2hpcCBQb2xhckZpcmUtU29DIEljaWNsZSBLaXQgKERUKQ0KPj4g
WyAgICAwLjYxMzAxMl0gZXBjIDogX19jbGtfcmVnaXN0ZXIrMHg0YTYvMHg4NWMNCj4+IFsgICAg
MC42MTc3NTldICByYSA6IF9fY2xrX3JlZ2lzdGVyKzB4NDllLzB4ODVjDQo+PiBbICAgIDAuNjIy
NDg5XSBlcGMgOiBmZmZmZmZmZjgwM2ZhZjdjIHJhIDogZmZmZmZmZmY4MDNmYWY3NCBzcCA6IGZm
ZmZmZmM4MDQwMGI3MjANCj4+IFsgICAgMC42MzA0NjZdICBncCA6IGZmZmZmZmZmODEwZTkzZjgg
dHAgOiBmZmZmZmZlNzdmZTYwMDAwIHQwIDogZmZmZmZmZTc3ZmZiMzgwMA0KPj4gWyAgICAwLjYz
ODQ0M10gIHQxIDogMDAwMDAwMDAwMDAwMDAwYSB0MiA6IGZmZmZmZmZmZmZmZmZmZmYgczAgOiBm
ZmZmZmZjODA0MDBiN2MwDQo+PiBbICAgIDAuNjQ2NDIwXSAgczEgOiAwMDAwMDAwMDAwMDAwMDAx
IGEwIDogMDAwMDAwMDAwMDAwMDAwMSBhMSA6IDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgICAgMC42
NTQzOTZdICBhMiA6IDAwMDAwMDAwMDAwMDAwMDEgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0IDog
MDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAgICAwLjY2MjM3M10gIGE1IDogZmZmZmZmZmY4MDNhNTgx
MCBhNiA6IDAwMDAwMDAyMDAwMDAwMjIgYTcgOiAwMDAwMDAwMDAwMDAwMDA2DQo+PiBbICAgIDAu
NjcwMzUwXSAgczIgOiBmZmZmZmZmZjgxMDk5ZDQ4IHMzIDogZmZmZmZmZmY4MGQ2ZTI4ZSBzNCA6
IDAwMDAwMDAwMDAwMDAwMjgNCj4+IFsgICAgMC42NzgzMjddICBzNSA6IGZmZmZmZmZmODEwZWQz
YzggczYgOiBmZmZmZmZmZjgxMGVkM2QwIHM3IDogZmZmZmZmZTc3ZmZiYzEwMA0KPj4gWyAgICAw
LjY4NjMwNF0gIHM4IDogZmZmZmZmZTc3ZmZiMTU0MCBzOSA6IGZmZmZmZmU3N2ZmYjE1NDAgczEw
OiAwMDAwMDAwMDAwMDAwMDA4DQo+PiBbICAgIDAuNjk0MjgxXSAgczExOiAwMDAwMDAwMDAwMDAw
MDAwIHQzIDogMDAwMDAwMDAwMDAwMDBjNiB0NCA6IDAwMDAwMDAwMDAwMDAwMDcNCj4+IFsgICAg
MC43MDIyNThdICB0NSA6IGZmZmZmZmZmODEwYzc4YzAgdDYgOiBmZmZmZmZlNzdmZjg4Y2QwDQo+
PiBbICAgIDAuNzA4MTI1XSBzdGF0dXM6IDAwMDAwMDAyMDAwMDAxMjAgYmFkYWRkcjogMDAwMDAw
MDAwMDAwMDBiMSBjYXVzZTogMDAwMDAwMDAwMDAwMDAwZA0KPj4gWyAgICAwLjcxNjg2OV0gWzxm
ZmZmZmZmZjgwM2ZiODkyPl0gZGV2bV9jbGtfaHdfcmVnaXN0ZXIrMHg2Mi8weGFhDQo+PiBbICAg
IDAuNzIzNDIwXSBbPGZmZmZmZmZmODA0MDM0MTI+XSBtcGZzX2Nsa19wcm9iZSsweDFlMC8weDI0
NA0KPj4NCj4+IEl0IGZhaWxzIG9uICJjbGtfcGVyaXBoX3RpbWVyIiAtIHdoaWNoIHVzZXMgYSBk
aWZmZXJlbnQgcGFyZW50LCB0aGF0IGl0DQo+PiB0cmllcyB0byBmaW5kIHVzaW5nIHRoZSBtYWNy
bzoNCj4+IFwjZGVmaW5lIFBBUkVOVF9DTEsoUEFSRU5UKSAoJm1wZnNfY2ZnX2Nsa3NbQ0xLXyMj
UEFSRU5UXS5jZmcuaHcpDQo+Pg0KPj4gSWYgcGFyZW50IGlzIFJUQ1JFRiwgc28gdGhlIG1hY3Jv
IGJlY29tZXM6ICZtcGZzX2NmZ19jbGtzWzMzXS5jZmcuaHcNCj4+IHdoaWNoIGlzIHdlbGwgYmV5
b25kIHRoZSBlbmQgb2YgdGhlIGFycmF5LiBBbWF6aW5nbHksIGJ1aWxkcyB3aXRoIEdDQw0KPj4g
MTEuMSBzZWUgbm8gcHJvYmxlbSBoZXJlLCBib290aW5nIGNvcnJlY3RseSBhbmQgaG9va2luZyB0
aGUgcGFyZW50IHVwDQo+PiBldGMuIEJ1aWxkcyB3aXRoIGNsYW5nLTE1IGRvIG5vdCwgd2l0aCB0
aGUgYWJvdmUgcGFuaWMuDQo+Pg0KPj4gRHJvcCB0aGUgbWFjcm8gZm9yIHRoZSBSVENSRUYgYW5k
IHVzZSB0aGUgYXJyYXkgZGlyZWN0bHkgdG8gYXZvaWQgdGhlDQo+PiBwYW5pYywgdXNpbmcgYSBu
ZXdseSBhZGRlZCBkZWZpbmUgdGhhdCBicmluZ3MgdGhlIGluZGV4IGludG8gdGhlIHZhbGlkDQo+
PiByYW5nZS4NCj4+DQo+PiBGaXhlczogMWM2YTdlYTMyYjhjICgiY2xrOiBtaWNyb2NoaXA6IG1w
ZnM6IGFkZCBSVENSRUYgY2xvY2sgY29udHJvbCIpDQo+PiBDQzogTmF0aGFuIENoYW5jZWxsb3Ig
PG5hdGhhbkBrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Nsay9taWNyb2No
aXAvY2xrLW1wZnMuYyB8IDUgKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNy
b2NoaXAvY2xrLW1wZnMuYyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+PiBp
bmRleCAwNzBjM2I4OTY1NTkuLjllNDFmMDdiM2ZhNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
Y2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAv
Y2xrLW1wZnMuYw0KPj4gQEAgLTI3LDYgKzI3LDggQEANCj4+ICAgI2RlZmluZSBNU1NQTExfUE9T
VERJVl9XSURUSAkweDA3dQ0KPj4gICAjZGVmaW5lIE1TU1BMTF9GSVhFRF9ESVYJNHUNCj4+ICAg
DQo+PiArI2RlZmluZSBSVENSRUZfT0ZGU0VUCQkoQ0xLX1JUQ1JFRiAtIENMS19FTlZNKQ0KPj4g
Kw0KPj4gICBzdHJ1Y3QgbXBmc19jbG9ja19kYXRhIHsNCj4+ICAgCXZvaWQgX19pb21lbSAqYmFz
ZTsNCj4+ICAgCXZvaWQgX19pb21lbSAqbXNzcGxsX2Jhc2U7DQo+PiBAQCAtMzgxLDcgKzM4Myw4
IEBAIHN0YXRpYyBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sgbXBmc19wZXJpcGhfY2xrc1td
ID0gew0KPj4gICAJQ0xLX1BFUklQSChDTEtfTUFDMCwgImNsa19wZXJpcGhfbWFjMCIsIFBBUkVO
VF9DTEsoQUhCKSwgMSwgMCksDQo+PiAgIAlDTEtfUEVSSVBIKENMS19NQUMxLCAiY2xrX3Blcmlw
aF9tYWMxIiwgUEFSRU5UX0NMSyhBSEIpLCAyLCAwKSwNCj4+ICAgCUNMS19QRVJJUEgoQ0xLX01N
QywgImNsa19wZXJpcGhfbW1jIiwgUEFSRU5UX0NMSyhBSEIpLCAzLCAwKSwNCj4+IC0JQ0xLX1BF
UklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3RpbWVyIiwgUEFSRU5UX0NMSyhSVENSRUYpLCA0
LCAwKSwNCj4+ICsJQ0xLX1BFUklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3RpbWVyIiwNCj4+
ICsJCSAgICZtcGZzX2NmZ19jbGtzW0NMS19SVENSRUYgLSBSVENSRUZfT0ZGU0VUXS5odywgNCwg
MCksDQo+IA0KPiBBIHBlcnNvbmFsIHRhc3RlOiBhcyBjbGsgSURzIGFuZCBjbGsgaW5kZXhlcyBp
biBtcGZzX2NmZ19jbGtzW10gYXJyYXkgYXJlDQo+IGRpZmZlcmVudCB0aGluZyAoSUQgZm9yIGNs
a19wZXJpcGhfdGltZXIgaXMgYWxyZWFkeSBkaWZmZXJlbnQpIGFuZCB0aGUNCj4gQ0xLX1JUQ1JF
RiAtIFJUQ1JFRl9PRkZTRVQgaGVyZSBpcyBpbiB0aGUgZW5kIENMS19FTlZNID0gMyBtYXliZSBl
YXNpZXIgdG8NCj4gZm9sbG93IHRoZSBjb2RlIHdvdWxkIGJlIHRvIGFkZCBuZXcgbWFjcm9zIGxp
a2U6DQo+IA0KPiAjZGVmaW5lIENMS19DUFVfT0ZGIDANCj4gI2RlZmluZSBDTEtfQVhJX09GRiAx
DQo+ICNkZWZpbmUgQ0xLX0FIQl9PRkYgMg0KPiAjZGVmaW5lIENMS19SVENSRUZfT0ZGIDMNCj4g
DQo+IGFuZCBjaGFuZ2UgdGhlIENMS19QQVJFTlQoKSBtYWNybyBzb21ldGhpbmcgYXMgZm9sbG93
czoNCj4gDQo+ICNkZWZpbmUgUEFSRU5UX0NMSyhQQVJFTlQpICgmbXBmc19jZmdfY2xrc1tDTEtf
IyNQQVJFTlQjI19PRkZdLmh3KQ0KDQpTdXJlLCBidXQgdGhhdCBpcyBvdXQtb2Ytc2NvcGUgZm9y
IHRoaXMgZml4IHdoaWNoIG5lZWRzIGJhY2twb3J0aW5nLg0KDQo+IA0KPj4gICAJQ0xLX1BFUklQ
SChDTEtfTU1VQVJUMCwgImNsa19wZXJpcGhfbW11YXJ0MCIsIFBBUkVOVF9DTEsoQUhCKSwgNSwg
Q0xLX0lTX0NSSVRJQ0FMKSwNCj4+ICAgCUNMS19QRVJJUEgoQ0xLX01NVUFSVDEsICJjbGtfcGVy
aXBoX21tdWFydDEiLCBQQVJFTlRfQ0xLKEFIQiksIDYsIDApLA0KPj4gICAJQ0xLX1BFUklQSChD
TEtfTU1VQVJUMiwgImNsa19wZXJpcGhfbW11YXJ0MiIsIFBBUkVOVF9DTEsoQUhCKSwgNywgMCks
DQo+IA0KDQo=
