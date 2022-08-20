Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049459ACBA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiHTIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbiHTItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:49:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7C97538;
        Sat, 20 Aug 2022 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660985359; x=1692521359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3v7yDDo++E80tSLplaPrsOKoKsp8iDNFHZ86pUKVPeQ=;
  b=immzphOMvs8jlkcm15xW0r+HP1vSG75SxgIljoQEKejYdwnu2qLs8Xa4
   9zHGcTZMsgki2y8DYEryjLtIspUN4lL1AWPyXlQrVDY3NtHaeeI0C4J73
   rGU9GaZQsWvWSf3bKi8Tpp3UcmhTwtLNvhj5FxHajtp2NW9Rir7LYMkot
   +B60nWFigyZcPTWi/092iK7TIuLw0pHniJwgxYOneor4UoTLZ6fLr2Has
   O9FDuQhtA0CL3lX6x0deIWsBSzUlMWt9GFdEVyJszNw2d/OZuGwg7iBBD
   tYunqHkh92LJ1rWql8E0QJOEdvH10yD71I1qHmzTXzVRxJc9bri7vcKWX
   g==;
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="177170143"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 01:49:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 01:49:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 01:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0IiJ1RN5Uz8QkL1pby68nkIceHyBYwUZI2dA1sgoS6M2Raba5xzpFZ7RHS/oQ2d1rQpS0DOcsyF7MkHCWJBm5Jh9QAv2wh6Xi0HKY/7+A5SFnmA2s81NCdRfdI1aE17OwY9aP7CF5JwDCcLY8hLn17ULi0Dj4Ha7zpwmIguYtP5W9VDQbmBvM2hDUruc/iMbqyBjllGh7YyYfUHe9qC66ERkYqfo7DZrmBNH3LVfRuKjrS98l7NfV/ywl8+TxiOmtbMZUm900N/r8krFFq6TTv35xBs/FtdUwQk+LlJZKx2aAIhOEG6Nng5yIPHK0smGXsKLhOka/WAV+Wl2VTHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v7yDDo++E80tSLplaPrsOKoKsp8iDNFHZ86pUKVPeQ=;
 b=JtC38/xK1S8rWLyRBlmL+CFfULC68mfV97/5eTM+fj6ZP3jotoq3fzNebU8M406oyjo4hDFAtvncsfsIFG7j7DE4HrcllqcAkaGDX2aPrGhvO5TUieRtHIlHDZg2uxx/NFAqNhKA6fLNQ6IE46kWd8TFYaP9uJ6S/MqmQ/PN50DzLUpW2iK27xsF8tkuMmjDGr7xmN5m0s7OLi8y4koXHwTV7D74AAWOnSW5wRErTUAeX/3QxqXQpGIoBlNelbIPemFd5oexNBafGibiqFcfT49myhs1QqIOs+GDYkEgo0pC4hBfXYZx8U4+n3MsFr09+fbCW1FrW9sGQIDFh794cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v7yDDo++E80tSLplaPrsOKoKsp8iDNFHZ86pUKVPeQ=;
 b=JvxftCyP0b04BLSDqLQSOryw8CHcInOck/8L0vZWL1tT4mxGrz6P4zNCSU7WLLXskYhVLHJX/h4Qnpl/zabV1kuMnwmZ0qrSDw6TGpfMW+u9gq+LzniSVt6gmLPsx6UYHOr+XwNGWA8Dkh+ofK8Ukh4hdvazOxZLErqlWfi6pi8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Sat, 20 Aug 2022 08:49:12 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Sat, 20 Aug 2022
 08:49:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert@linux-m68k.org>, <Conor.Dooley@microchip.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <prabhakar.csengg@gmail.com>, <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
Thread-Topic: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
Thread-Index: AQHYsLouMPh7rdo3sEeVwwyr+jl3hq22lMeAgADsSwCAAADogA==
Date:   Sat, 20 Aug 2022 08:49:11 +0000
Message-ID: <47cec683-dc17-7aa2-3511-b0244020d571@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <e9b00bb5-bb78-091f-9c10-96c156690469@microchip.com>
 <CAMuHMdUGttswcSGeOdrJLeoZLmoeKhm7R82L-3wLJnagmZ4dBA@mail.gmail.com>
In-Reply-To: <CAMuHMdUGttswcSGeOdrJLeoZLmoeKhm7R82L-3wLJnagmZ4dBA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 692da858-4824-44d8-1773-08da8288da76
x-ms-traffictypediagnostic: DM4PR11MB6216:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghx7rtZq/VxXYFWxuzDJRZIzONTjOBPyZaXwRJgfaFK/jgyoQhWo5w9+rFXBCenktgRntBlcN30fTGun+JjynjPPVNhc+KDlCF9Txsq1RFMNs9eBGDZbbhjaMeV67b/OdmArcbngBclDUWRWQnbeXFB7zIQtcmhE7oLVTor0fDEmKjN1vV3wgd+u57+ov49q1cdAcSYc42ZhE+INrAn0v3G46cow2PhEOPU6QkozLGbcSazPrKMruoBPfHBXqZzNaLwtZmJo6MiEcHDLdMYKHzgtYdxmJfjX94aDXJXmr4J1GzPa5wipqvrND6eE9CXxsbOOFmnhpcILugSq+Bldwu+3yuxT+VO7bPeqbPcwT9JtSEoRn47kU9Bv4rmKZJG4hGn+XmT8ts4d7r3eqTOeWsWtRIbztfC4KrOE67jbZCLkVJawchxKy9d6fGODvLXMk2pFIpXxTkefpSv7dSPG9oFp0NZkfLDdyVuku66+GqS8VFoH9jgmuVHtIIo2bCF/W2Vs0CzrKqbONQd9O2oXjhzioj4l3/aCXeqepGdteYyA52QIpSeQ9+AnkokRkOnYySx6K+Rm3GyAByvs4yzuztw78lumsriOTTgVz710ie1tMrat3+4ma9IEycpEHmkiRQtfwfxlhx2pCes1G1HEomIJznpVmflDMQlF38JXFkzpLouxXQXmcrd5Rdr+705zNT6T18MYeirFRyLs+8xoD6HFELqWXXujTarOqikAwLUPJe/yq1rmkDDcXkYQcXeMMN595RKtMzYWvkEajrLexSEmk5pLpdfnIwSeOePV7UQytvtTYXXeIJEEJLufVjGybyeGqo1nRAdw7vbdtgSu9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(136003)(366004)(396003)(2616005)(38100700002)(38070700005)(83380400001)(122000001)(186003)(5660300002)(8936002)(7416002)(91956017)(76116006)(4326008)(66946007)(66476007)(66446008)(66556008)(8676002)(2906002)(6486002)(86362001)(53546011)(6506007)(26005)(6512007)(316002)(478600001)(41300700001)(110136005)(71200400001)(36756003)(54906003)(64756008)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1FtTUtHSWdva1BTTjRuNUM4NkhXSW5TODR3L0tlSkdocVgyUWxyS2lERHFs?=
 =?utf-8?B?QUhrQk5Sc1VpKzk5SmVRdEt0Tng3RlJaYUZDRXFmaVk3eWM1TUxQZjBmOTVy?=
 =?utf-8?B?ZzJJR2h1c2tvWG9NczFMNkJSYWt5dWZUejhhUy9ZdTlBYVpoNkpzZ1U5WG11?=
 =?utf-8?B?Z0o4SitaWTJEY1VKdWgvSGhNNlRzOUNiMlJ3MFBHUUJtczhCSTduWTY0bVFV?=
 =?utf-8?B?akp1L2F4cVdoK1E0N2RvOWxkSzBodysrU040bytIUGp5bzFYelhGY3k3YVRn?=
 =?utf-8?B?T0RtRmtnQWZpZTVqS2k3VGN2b0RjMnlicCtybk1VWHBlL1lPdStRTjM1cDg1?=
 =?utf-8?B?U0pXc2VaYzFDam1rNlFXeUlYR3RLd0ZveHlnT3RZZUVRVjZLaCtVVml2cE1r?=
 =?utf-8?B?bWcxQ09TdGJHenVwTElENVZDZTlIU3BsaVJ0OE80OE8xRUZ1WWw4eFdYR3N1?=
 =?utf-8?B?TlNtMWNiOGhQTkJtWmFjbUtNTmJRNlR1V3UyWmhHeVRGbUtmZElqcm0zNElH?=
 =?utf-8?B?eFA3aC9jc1ZqTXZIYi8wU3FGNktmSXlEcGhTT3g5MFBqWHF3ZUdXR3NXSHNo?=
 =?utf-8?B?dVpnSWhJT1BLTWROa0ZvdFJndFMvTVBnYlBIbFBUNEZHZmRQeERpU2IxVXhz?=
 =?utf-8?B?OXpFaWpvSmFqb084MWZoK01OeG0xSHQ4UmMrandaVSt6RlFRYjhtSVgrZjhP?=
 =?utf-8?B?azJaQ25UUTNNaDczY015bzBlOTJqclIzbUdQVUViN0hCZkR2Sit5SWM1N3g4?=
 =?utf-8?B?UnZXOEV0YUJOMnpjQ2hQbjFaTjRvb0RnaEQ1UFVuSTlEMTY0VWxQTFd5S2lY?=
 =?utf-8?B?Q3FlTCt1bzNJRE9sVnlYalhGZXAzSUxQMHJYZG5PTmlNQ2dkY3FTOXdHb0Q1?=
 =?utf-8?B?dlVVbm03MU1pUzJPOVZqWVExSWdFNXVyRE5wV2lHTmFjWThYeHlOY3IxcTh0?=
 =?utf-8?B?dTgwRDlSampJWTdvVGFYQmZqQzFidU95OGI0NUY1YjdJNmJ1YnYwRVhDRnA1?=
 =?utf-8?B?b0dTV3EzRHg3NkpNaTZ2TDNNbVZaU0w5c0lMbEN5U2h2ME5vTTlNSCsrVWxI?=
 =?utf-8?B?MUlzdVRvejU0dkRCUm96dENoa2dMTW8xOEVjOXlKQjVBbGlFaS9NcU15YnN2?=
 =?utf-8?B?NWE4Q1FuckhWdU1CaFF2UkFrOVBIRGxYeG5RVXU4TmdNdlFmVHp6QXIvalZU?=
 =?utf-8?B?b1FMT3Z5bkt4RmtjQVpFV09TN01jOXhTaG43NGpQU016U3M4VVRzY2pVU3Bv?=
 =?utf-8?B?UzIxcElVWG16T3FCVU0vaERNNnJUNExoZFRtZHVDNlVlbFBMLzc5cWRYTFY2?=
 =?utf-8?B?TjJ3aXRnWlcrUC93Vlg5TDQ0elphcmFlQzgwS095b0YxQkFsYzNPeUVpSUdO?=
 =?utf-8?B?b09iSk4zblp1cE9ja2hCQ3ZQYWxlN3M1REswUzhnM0lPbFBnMGppWVkzRzg0?=
 =?utf-8?B?Q25iUFRFV3JObEErUlJuS3VjUnI5VzFES2YrbDV6Z1l4SUZZWVVVRUZZMGNz?=
 =?utf-8?B?UzhrWlFDSjREVnYrT21nUHRsRkF1WlhlcWcvZVhheldkWlFHN1BMMisxOWxW?=
 =?utf-8?B?ZFlQb0NZNmFTNW1TZ1QyMDAzNFZNOEpnaGRWK2R5MFBpWVNMeldNRFdEVnFI?=
 =?utf-8?B?S0xNYVJJd1hrMjF5TlRaMjRlSU5PS3pFT3RLYzR3a1gxWnBFbkluMzk2ZUVs?=
 =?utf-8?B?MnZYYXdMaDQ4OHlaWWdTeVo2Rzduem4vdXNTeHZCVy9ZR1pHOGkyOEpBOWRh?=
 =?utf-8?B?YURseVg3YWoycm5xV09BLzA0RW5XVXhEazFBVjRUOU5lRmtKSEorK2dlY0U1?=
 =?utf-8?B?ajhKU0d0ZWJPdmljNmhPNnhEWnQyc1plZitLVjBHOHU5eEZqNi8xNXNEOWVq?=
 =?utf-8?B?RkNEeE1GU3NhM0xCK2h5N3VGN2VrTlJHSlhDSGpPLy9vM0RWU3VYMVIyNXBD?=
 =?utf-8?B?S09PcUVmVUVzY2xBTjFYd2cvTHB3TTJsaTVzd3hGMTU0ZVJjbnNGQzd6Sngv?=
 =?utf-8?B?NHRjUTNwTHh2Y20xZ2tWcE4rRGZ2V09ySHRmUi9iV1h0VVJtMTFyZXZqVG5U?=
 =?utf-8?B?dVNhUEU0NEVKTlNuWld6MjJrWjFHZXJodEFaUW42L0crbnN2Nm54WURoT1hS?=
 =?utf-8?Q?uwsyQ4IyQA1uztD/nn/1P5Tac?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C7ADF21D94C6A45A3B995BA0C64284D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692da858-4824-44d8-1773-08da8288da76
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 08:49:11.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZH3J5VfzjNl5zeFztyK/z8gqx95dzy/b5A0OV3vgQY0g3+U802Qc4lUBjBAfsWjgiFA4xDJXy6GqvwVoln5noyZaLMJrqw/oK9P3BPiEhwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDgvMjAyMiAwOTo0NSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBDb25v
ciwNCj4gDQo+IE9uIEZyaSwgQXVnIDE5LCAyMDIyIGF0IDg6NDAgUE0gPENvbm9yLkRvb2xleUBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4+IE9uIDE1LzA4LzIwMjIgMTY6MTQsIExhZCBQcmFiaGFr
YXIgd3JvdGU6DQo+Pj4gQWRkIGluaXRpYWwgZGV2aWNlIHRyZWUgZm9yIFJlbmVzYXMgUlovRml2
ZSBSSVNDLVYgQ1BVIENvcmUgKEFYNDVNUA0KPj4+IFNpbmdsZSkuDQo+Pj4NCj4+PiBCZWxvdyBp
cyB0aGUgbGlzdCBvZiBJUCBibG9ja3MgYWRkZWQgaW4gdGhlIGluaXRpYWwgU29DIERUU0kgd2hp
Y2ggY2FuIGJlDQo+Pj4gdXNlZCB0byBib290IHZpYSBpbml0cmFtZnMgb24gUlovRml2ZSBTTUFS
QyBFVks6DQo+Pj4gLSBBWDQ1TVAgQ1BVDQo+Pj4gLSBDUEcNCj4+PiAtIFBJTkNUUkwNCj4+PiAt
IFBMSUMNCj4+PiAtIFNDSUYwDQo+Pj4gLSBTWVNDDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBM
YWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+
Pj4gLS0tDQo+Pj4gdjEtPnYyDQo+Pj4gKiBEcm9wcGVkIGluY2x1ZGluZyBtYWtlZmlsZSBjaGFu
Z2UNCj4+PiAqIFVwZGF0ZWQgbmRldiBjb3VudA0KPj4+IC0tLQ0KPj4+ICBhcmNoL3Jpc2N2L2Jv
b3QvZHRzL3JlbmVzYXMvcjlhMDdnMDQzLmR0c2kgfCAxMjEgKysrKysrKysrKysrKysrKysrKysr
DQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKQ0KPj4+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpDQo+Pj4N
Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5k
dHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0My5kdHNpDQo+Pj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmIyODhkMjYwNzc5Ng0K
Pj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMv
cjlhMDdnMDQzLmR0c2kNCj4+PiBAQCAtMCwwICsxLDEyMSBAQA0KPj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+Pj4gKy8qDQo+
Pj4gKyAqIERldmljZSBUcmVlIFNvdXJjZSBmb3IgdGhlIFJaL0ZpdmUgU29DDQo+Pj4gKyAqDQo+
Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyMiBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnAuDQo+Pj4g
KyAqLw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2lycS5oPg0KPj4+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svcjlhMDdnMDQzLWNw
Zy5oPg0KPj4+ICsNCj4+PiArLyB7DQo+Pj4gKyAgICAgY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5
YTA3ZzA0MyI7DQo+Pj4gKyAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+Pj4gKyAgICAgI3Np
emUtY2VsbHMgPSA8Mj47DQo+Pj4gKw0KPj4+ICsgICAgIC8qIGNsb2NrIGNhbiBiZSBlaXRoZXIg
ZnJvbSBleGNsayBvciBjcnlzdGFsIG9zY2lsbGF0b3IgKFhJTi9YT1VUKSAqLw0KPj4+ICsgICAg
IGV4dGFsX2NsazogZXh0YWwtY2xrIHsNCj4+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
Zml4ZWQtY2xvY2siOw0KPj4+ICsgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPj4+
ICsgICAgICAgICAgICAgLyogVGhpcyB2YWx1ZSBtdXN0IGJlIG92ZXJyaWRkZW4gYnkgdGhlIGJv
YXJkICovDQo+Pj4gKyAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MD47DQo+Pg0KPj4g
V2hhdCdzIHRoZSB2YWx1ZSBpbiBoYXZpbmcgdGhlIGNsb2NrLWZyZXF1ZW5jeSBoZXJlIGlmIHRo
ZSBib2FyZCAuZHRzaQ0KPj4gb3ZlcndyaXRlcyBpdD8gZHRic19jaGVjayB3aWxsIGNvbXBsYWlu
IGlmIHNvbWVvbmUgZm9yZ2V0cyB0byBmaWxsIGl0DQo+PiBJSVVDICYgd2hhdCB0aGUgbWlzc2lu
ZyBmcmVxdWVuY3kgbWVhbnMgaXMgYWxzbyBraW5kYSBvYnZpb3VzLCBubz8NCj4gDQo+IFNvbWUg
ZXh0ZXJuYWwgY2xvY2tzIG1heSBiZSBvcHRpb25hbC4gSGVuY2UgImR0YnNfY2hlY2siIHdpbGwg
Y29tcGxhaW4NCj4gaWYgbm8gImNsb2NrLWZyZXF1ZW5jeSIgaXMgbWlzc2luZy4NCg0KUmlnaHQs
IHNlZW1zIHJlYXNvbmFibGUgZW5vdWdoLg0KDQo+IA0KPj4NCj4+IFRoYXQgYXNpZGUsIGJ5IGNv
bnZlbnRpb24gc28gZmFyIHdlIGhhdmUgcHV0IHRoaW5ncyBsaWtlIGV4dGFscyBvcg0KPj4gcmVm
ZXJlbmNlIGNsb2NrcyBiZWxvdyB0aGUgL2NwdXMgbm9kZS4gQ291bGQgeW91IGRvIHRoZSBzYW1l
IGhlcmUgdG9vDQo+PiBwbGVhc2U/DQo+IA0KPiBSZWFsbHk/IFdlJ3ZlIGJlZW4gcHV0dGluZyB0
aGVtIGF0IHRoZSByb290IG5vZGUgZm9yIGEgbG9uZyB0aW1lLA0KPiBzaW5jZSB0aGUgc2VwYXJh
dGUgImNsb2NrcyIgZ3JvdXBpbmcgc3Vibm9kZSB3YXMgZGVwcmVjYXRlZC4NCj4gVGhlIGV4dGFs
LWNsayBpcyBub3QgZXZlbiBwYXJ0IG9mIHRoZSBTb0MsIHNvIGl0IHNob3VsZCBkZWZpbml0ZWx5
DQo+IG5vdCBiZSB1bmRlciB0aGUgL2NwdXMgbm9kZS4NCg0KVW5kZXIgbWF5IGhhdmUgYmVlbiBh
IGNvbmZ1c2luZyBjaG9pY2Ugb2Ygd29yZHMsIEkgbWVhbnQgInBoeXNpY2FsbHkiDQp1bmRlciBp
dCBpbiB0aGUgZmlsZS4gTWF5YmUgYWZ0ZXIgd291bGQgaGF2ZSBiZWVuIGEgYmV0dGVyIGNob2lj
ZSBvZg0Kd29yZHM/IEkgd2Fzbid0IHN1Z2dlc3RpbmcgeW91IHB1dCBpdCBpbnNpZGUgdGhlIENQ
VXMgbm9kZS4NCkRvZXMgdGhhdCBtYWtlIG1vcmUgc2Vuc2U/DQpDb25vci4NCg0K
