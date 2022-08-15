Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DA59442C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiHOW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350871AbiHOWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:18:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31065674;
        Mon, 15 Aug 2022 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660592576; x=1692128576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=usNUddUUWfRW5fxZ/YvPTTVtcqbBCceUIBBBTXLlnJU=;
  b=Uj2aTg5zZPXs6qXDJC6PPEIjslNntEdtpCzZBxjtzaZL6ESsb0L7AOGX
   OSrb6nQfDXAP7GPc1bcpsvK1r4Bw/Afx/mjKYrk6Ed/f+J9ZQ7Z0tks00
   TsNpvlICrHCymNIwIhQIN2E3Lim/w8I606nbu+NCZmlF5Q5ea9hE8+OnR
   EuKo1MgZpgRw4T+TA3j8K9RbllKNLdhFAkYgAXZogjPyk9DUUL2PsrjQJ
   jFdJchq7eFuvhKAcZrsuzfGY2wnbiJ+sz2O4p9TtGPz/gqMIY2ASw5SN7
   kwc6q7VL43p/vZ+1mZf0G4BGQXBYMejf19YV26w1eOzob7tRAV+KcLAA8
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="109131845"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:42:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:42:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 15 Aug 2022 12:42:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB/SQrps76X09kMEKlaKckLve4rLPPwDIHf+dwFXaUWw4B7uJpbSzar6QVqCmCVFcvLe2WeyEi7X6YpZZLBjPFAmGql74yL017hLOdaT89lKJ74dFA+xamVJe2mZTDByniDQsPWJa7TKX12pxWJ9gP+LAw6WUz9mluw0QRpqjPcg3qyhMAzHdMl6ObfG3i+bFoAJW6FitW6ej30My+allywpTWgosoPk9pm7D2sVaPuDfNbe+pRaVIjuv0euas4N43dN8GXJW8Sv6fLythEHKuoo8RskwGiEty9JHk60FOR6fJK7/CP5SmR0t8HTfqldIxlr5Kg6fNcrUZXvNv0uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usNUddUUWfRW5fxZ/YvPTTVtcqbBCceUIBBBTXLlnJU=;
 b=ROIgJ3mXXPas2IfX7FlF0rtOnJ02d8v9Cwv0tYXph6fC+p3tOjpupDLgTY7FJI6V6HFVx83qcv/1KoGsf2KMUed5YKMTQEehgOZDAvftpbbjsZp+jUK8XppfO2ZMTlpYQee5LOx/Dpdk/GgBqh4Do153ASrF0MYKgfAKSSlGOLtB/dfpMMQ7vRq20LdzVr/GlGPKJ6uXcenm4+29rjo0gFfsA3b/pFoo45zRvc59TfTfvKF8vOYIGn18hdZsx69qhUF+Jjx1qH17csQ3m7M/PD/ga4D3YSs1SiiW3gD8+ofCN/oiDh8Mda8nWk+VEnj5ke5Tbrxz03XpvMLFICzfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usNUddUUWfRW5fxZ/YvPTTVtcqbBCceUIBBBTXLlnJU=;
 b=ZWLsr5PEBYYa2qeR9508tfT4edaYtnWoUsOi1hsXZu4ga8T6b6wxDq5GexBUxiQnEvybksN/pCXBas+w4uudOiZxZE5GE7whCr4A0v9+yvBAIcx57m2W7kIczBhQMN8OGhzjcgtMYqdNxzZq4JWkBWtqXjgPAvQwCoCo2YCJxu4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6286.namprd11.prod.outlook.com (2603:10b6:8:a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.28; Mon, 15 Aug 2022 19:42:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:42:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <Conor.Dooley@microchip.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
Thread-Topic: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
Thread-Index: AQHYsLn3v99KeFhKkECk1bkoK2HiZq2wVRAAgAAHPACAAACmgA==
Date:   Mon, 15 Aug 2022 19:42:49 +0000
Message-ID: <ad39d430-2d11-e74f-e0a6-20ec08d13b0b@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <57e17d1e-e809-065e-831f-cdd3a8602e0a@microchip.com>
 <CA+V-a8vDP8k9c8VM++68uKjQLGURC=pe571+QrmPb+tBo0j7Jw@mail.gmail.com>
In-Reply-To: <CA+V-a8vDP8k9c8VM++68uKjQLGURC=pe571+QrmPb+tBo0j7Jw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6345ead3-9b57-40cf-8e4f-08da7ef6562f
x-ms-traffictypediagnostic: DM4PR11MB6286:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVmR7vEPIC+BR8byPbTIDLCbGAGtr9ObBccKU2ivk2Y6MHvAptL47BUImCpqFx2WjXVsFA/P57P94O0FyaAFeZ2Pe54ZIlvBigemv+aXjCkMP0HbMenNmfJjTOx1WHC2iAadxhWuf4iIacdGdOdoUSrjD9bLddTWd3QOGgxL+AzyPbC/s2CuT+lGeWlw0Z2X7eTPoifn4pYzRblms2WPKK73Avm5pdHgF20RX6eZwMTgRoC4XmoNBYIln8Gb2qR5m9nH5dA/UIdIYADiYZV8cDm6XiODeu/XgVSuHXs9wmPVRndwqzkBo1SNk9RgrP4Pkg8uTMGjNL+27qN6cBQYUo6+hSvXFBS3KAIXq0g7+YgcQ+5jsCsxbJQM/fse8mgd8JOxzhquvzWi+nW6Ug6J5KbitH8NBYT1OV/hNcNfDOAvv/i76fweiRP9TT9445tLxmFPGTH6I/z7vlCjYiVmFYl5HEBYkpm+ISvHni1SIJYAsvc1mZ/P4FIiyf24YH7ROFJNc52CXYBCKkEBOcTrjJC5Cy78ocFebyFX2nVMvLuC1WPdCsC50WnHY65hoICGz0Ly6UnioE4oYDC6auKT4HmSovj5vZ3vXhvmlmc5zMslLIstrYGNEkgsKciMBcRmRhxE3fhwefJAkBku+kxCgZpEGka5kyvF1tFp1qEJHhFVhZVEPVtqs+pxxBjU6hMASxaetTTGO1zuRN4+Gh9pOBwTCMcuosHolMtCiThPsH51SLwT5VGtYzK8RdCp7wrbjA21JJBVoH49/SpQ4+2IZPbtmOE57PbTlZBkz3kB6DT7RaxyxV31VJyENqH7lABQPZUn51h3mBgKTOvES42ioqFaZCc8Vw+VWuAxpRoSs9G6DLqFyA4EVxS6f2F2G/FVOYG5f7LCRtmU42ZRsY1mHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(396003)(136003)(66946007)(38100700002)(122000001)(38070700005)(5660300002)(66446008)(64756008)(76116006)(26005)(66556008)(66476007)(91956017)(186003)(478600001)(71200400001)(53546011)(2616005)(41300700001)(8676002)(6512007)(966005)(6486002)(6506007)(4326008)(83380400001)(54906003)(316002)(110136005)(31686004)(7416002)(36756003)(8936002)(31696002)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjNRRUs4ZzVpWXJsUzJ2cEF2WkZUNVRBVDcwVmM1d3loaE9acGI3Zkc4bG4y?=
 =?utf-8?B?b1NZa1FLOVZybm9VRlh4QXRRWmtJK1JDY2NpTXREVnh1TnkwSFVmWGo3eDBz?=
 =?utf-8?B?TFFmb0VSeHR0K3JFYjExbmV1aTFFbnVLR0tFbnBiZ00wZXJreFQwN3hFQ2FX?=
 =?utf-8?B?a2x4Qk5hbUVNb0FUODhaY0VHK3BUUDZHaDFUQWRGeURNSURVMmNyNzlVNUwz?=
 =?utf-8?B?OE9YQnB0Y3QrZFFxZUxneWhEVkVHa1IvZDFtSXVNTnVSREttWnVmK2hlRmJv?=
 =?utf-8?B?RXBVb29GaWJTMFZ4MEptaHZTMFo5Q0RQMlozYXd2WGEyQkpsNmFMNlEwei9B?=
 =?utf-8?B?MDdhcUl2WHFteGV5SkpHbFlWVmR6TDBBVjBJeVRmb2tMTzg0ajU2VENCRENu?=
 =?utf-8?B?R1hjSUVndllXM0ZpRzBZcHZWMTJta1hHUG5YTENETEpOSzZXNlJ2cC9IT3B0?=
 =?utf-8?B?NHhnWjNXSWlFSzRVSEltclg3bWlqc2NQcytXeDJST2k4QnJocjJxOCtFZkJ0?=
 =?utf-8?B?L0kyTUdWbm90aitMbHF2UEUvNnVXZTE1djEyTTFUSlBzRUphMis5NjZBTDc4?=
 =?utf-8?B?bmVpUGhoTUtXNUVBQ3FHVmlSVnVWaFYwMzQ4VlRvK0VDSUFCWUxERmNDQkFw?=
 =?utf-8?B?dkdtOUNxWGZEV1llQTFmQ3J2OG9zNVdBMDJBTkN2NS84SUNDREc5SGJsWk5i?=
 =?utf-8?B?aUxrOUFhVW9Ib2VneFRRWmM1NmZVQ3BLR1k0WVIrU0ZpRE80aGlXUTVYV29T?=
 =?utf-8?B?ZWdWbkxBRzd1K0RPY2liZlkvS3hzTzVDOWFieFpMNHBIMVFMNUgyQU1heGxV?=
 =?utf-8?B?WEU0WFh2M1UxbGFFNzRyc2QxeUV0Nmdha3pBR3pmMWZYeUQ1WkdLL0Zoa1hD?=
 =?utf-8?B?dFJ0RHdtaklEVnBJamNIbkM3VnJNam92OWpKY253emQrNGtRdzhQZFJ2Y0RG?=
 =?utf-8?B?K2xscnFzaDVTVHFmNEt5WWJYeHRJU1dCejJPVDV1YkM3YTR6TDFScnZ1NW1S?=
 =?utf-8?B?WVd2eUJDN3o4Q1RNaVNlcmdJSER4elFBWE53dXJQYWtOTWErOC9vc3VOZno4?=
 =?utf-8?B?MDZGM2plV1R4UXRTY3lqdXV0RjJwckJYS1VCQ2R0T09NY3k0U1RSUUZPcXlt?=
 =?utf-8?B?c0RBMXV0Tm56dE55elE1MjA3M2pXRllrWmJsWHFta3pvbVZhcktBSEI5QlZB?=
 =?utf-8?B?YUdqTG5LSE1MTVRYSS96QjhrYnZRL3hWN0tyUGRzcjl6OCtYWEJBTCtIOFhQ?=
 =?utf-8?B?QVFlWnF6S2JQS3NDVzVtWDFpNzBnVGtTY0tnN2lLbUlaTzErQWxObXpoSElr?=
 =?utf-8?B?b0RPRGdJZS9lL20vT2grbzNmRWdSWVdjQUY3WGEzemd3UGlMWXRMUU5ucGlS?=
 =?utf-8?B?WG1mMDMzSmVFOHpJYUZMd1ZpRWl4SFRrUjFMT1NtVDVZc1l4Qk9PbFlFK2Vr?=
 =?utf-8?B?TlBsSERUeTRLNGpOb056cVNpNzltMG5iTnFEaXkvZW00dlVnMEtMMFFES2xX?=
 =?utf-8?B?UzIrZEp5MUNqZk9xV2liTzZjZzhYRGlvZUFWYi9veEdmRXJVbzkwbDlKaE1i?=
 =?utf-8?B?OU9rUVhHM0hldlVsckF5WEFjOUExK1dVeWZ2MHRKd1ZON0R5TG1Cd212dm5a?=
 =?utf-8?B?MDRLZTVmcDQxeTFOSEI0Y0g0WXNLYm1wYVZ3bVZHWXpHeUNXSU5USjBFWkNT?=
 =?utf-8?B?RE10cHBDa1lkWXltSGYrMU83cWs3NnU1UlY5RUtmUE1qQnFscnAwM1VtWHk1?=
 =?utf-8?B?K2NxVVFCYlNqZmdEbXZ4cE9kam9BOTJKOWg3WlJpa3ZYRHhvenJheVhSNFB3?=
 =?utf-8?B?bUJOSm1jLzJkbkNEeTNGTUpqakhScDh4cm40NHVBbWlTeUVMeHc1VjN4cW0r?=
 =?utf-8?B?ZkJlalBMamxXcFJKNmNOWHFFWmUyaHZkNlQ0a2xJSWxFRzBEMGFQM1FnaEdr?=
 =?utf-8?B?YkdiZjVxNnVEY1I5YkxmWTQrR0tTU2dQSnZEQjl2VEZwMzljSnhRZnI4cWRP?=
 =?utf-8?B?ZUFWTjRPNDN6Nk9rclBjOVVNUGVnMVZpQm4vRnNpWXRGTC9LS0R3SDc3ZEtV?=
 =?utf-8?B?amdjMEdjTmNpL0NGTDJ6bWFCWENqYlNORzhxVzB3ZHRtQURMNWVrRXlnVGM3?=
 =?utf-8?Q?bX2587dWrhCsb1jz5El8TW8iE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6CF77038D40614AA59CCE45E02E05FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6345ead3-9b57-40cf-8e4f-08da7ef6562f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:42:49.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LDLX1nsd8aAGWCT9cP2bJJiWnOfWeSDiux80SgWTEGydjVDoGFfWHg1SxE/1xKmZ+t340cXDb8yY4gUfZsQOrjtFJ6aZuWWEBifLHqx/Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6286
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAyMDo0MCwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEhpIENvbm9yLA0K
PiANCj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gT24gTW9uLCBBdWcgMTUsIDIw
MjIgYXQgODoxNCBQTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4NCj4+
IE9uIDE1LzA4LzIwMjIgMTY6MTQsIExhZCBQcmFiaGFrYXIgd3JvdGU6DQo+Pj4gZHQtYmluZGlu
Z3M6IHNvYzogcmVuZXNhczogcmVuZXNhcy55YW1sOiBEb2N1bWVudCBSZW5lc2FzIFJaL0ZpdmUg
U29DDQo+Pg0KPj4gSGV5IExhZCwNCj4+DQo+PiBNYXliZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5n
IG9uIHRoZSBhcm0gc2lkZSwgYnV0ICJzb2MiPw0KPj4gV2FzIHRoZSBpbnRlbnQgdG8gbW92ZSB0
aGlzIHRvIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MNCj4+IGJ1dCB5b3Ug
bW92ZWQgaXQgYmFjayB0byBhcm0gYnkgYWNjaWRlbnQ/DQo+Pg0KPiBPdWNoIEkgc2VudCBvdXQg
dGhlIG9sZGVyIHZlcnNpb24gb2YgbXkgcGF0Y2ggZm9yIHRoaXMuIEkgZGlkIGFjdHVhbGx5DQo+
IHNlbmQgb3V0IGEgcGF0Y2ggd2hpY2ggbW92ZXMgYXJtIHJlbmVzYXMueWFtbCB0byB0aGUgc29j
IGZvbGRlci4NCg0KQ29vbCB0aG91Z2h0IEkgc2F3IG9uZSBvZiB0aG9zZSB0aGlzIG1vcm5pbmcu
DQoNCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0KPj4gVGhhbmtzLA0KPj4gQ29ub3Iu
DQo+Pg0KPj4NCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+
IERvY3VtZW50IFJlbmVzYXMgUlovRml2ZSAoUjlBMDdHMDQzKSBTb0MuDQo+Pj4NCj4+PiBNb3Jl
IGluZm8gYWJvdXQgUlovRml2ZSBTb0M6DQo+Pj4gaHR0cHM6Ly93d3cucmVuZXNhcy5jb20vdXMv
ZW4vcHJvZHVjdHMvbWljcm9jb250cm9sbGVycy1taWNyb3Byb2Nlc3NvcnMvcnotbXB1cy9yemZp
dmUtcmlzYy12LWdlbmVyYWwtcHVycG9zZS1taWNyb3Byb2Nlc3NvcnMtcmlzYy12LWNwdS1jb3Jl
LWFuZGVzLWF4NDVtcC1zaW5nbGUtMTAtZ2h6LTJjaC1naWdhYml0LWV0aGVybmV0DQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpA
YnAucmVuZXNhcy5jb20+DQo+Pj4gLS0tDQo+Pj4gdjEtPnYyDQo+Pj4gKiBOZXcgcGF0Y2gNCj4+
PiAtLS0NCj4+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZW5lc2Fz
LnlhbWwgfCAzICsrLQ0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9yZW5lc2FzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL3JlbmVzYXMueWFtbA0KPj4+IGluZGV4IGZmODAxNTJmMDkyZi4uMjMzODQ3ZWIy
M2ZkIDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vcmVuZXNhcy55YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9yZW5lc2FzLnlhbWwNCj4+PiBAQCAtNDE1LDExICs0MTUsMTIgQEAgcHJvcGVydGll
czoNCj4+PiAgICAgICAgICAgICAgICAtIHJlbmVzYXMscnpuMWQ0MDAtZGIgIyBSWk4xRC1EQiAo
UlovTjFEIERlbW8gQm9hcmQgZm9yIHRoZSBSWi9OMUQgNDAwIHBpbnMgcGFja2FnZSkNCj4+PiAg
ICAgICAgICAgIC0gY29uc3Q6IHJlbmVzYXMscjlhMDZnMDMyDQo+Pj4NCj4+PiAtICAgICAgLSBk
ZXNjcmlwdGlvbjogUlovRzJVTCAoUjlBMDdHMDQzKQ0KPj4+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBSWi9GaXZlIGFuZCBSWi9HMlVMIChSOUEwN0cwNDMpDQo+Pj4gICAgICAgICAgaXRlbXM6DQo+
Pj4gICAgICAgICAgICAtIGVudW06DQo+Pj4gICAgICAgICAgICAgICAgLSByZW5lc2FzLHNtYXJj
LWV2ayAjIFNNQVJDIEVWSw0KPj4+ICAgICAgICAgICAgLSBlbnVtOg0KPj4+ICsgICAgICAgICAg
ICAgIC0gcmVuZXNhcyxyOWEwN2cwNDNmMDEgIyBSWi9GaXZlIChSSVNDLVYgY29yZSkNCj4+PiAg
ICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDQzdTExICMgUlovRzJVTCBUeXBlLTENCj4+
PiAgICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDQzdTEyICMgUlovRzJVTCBUeXBlLTIN
Cj4+PiAgICAgICAgICAgIC0gY29uc3Q6IHJlbmVzYXMscjlhMDdnMDQzDQo+Pj4gLS0NCj4+PiAy
LjI1LjENCj4+Pg0KPj4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcmlzY3YNCg==
