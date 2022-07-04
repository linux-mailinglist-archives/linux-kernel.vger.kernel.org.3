Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF456577B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiGDNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiGDNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:34:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B313CC9;
        Mon,  4 Jul 2022 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656941544; x=1688477544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BnP++AQdaRBEq07St6hTGvOG4xURBYROWcHl2iDu97Y=;
  b=Hj+FY3dSfAWWurJta3nr2PdsMQLo3Uo+VgR1moFkkZpj75FgnlVnzWA9
   MO8pnhrMf6fEGPhbrUwSzhbeNROlXtl9povDWVEzcAZb0vle/qdk5YhbL
   KR9vQ5UOt1jdTOzEQ4XRRWg+jcei92IFRb5b+ti4amMRbPXty3joGI6+1
   RJ9wUP2TNyqgFhbbnpnGFWz27LVTDgWCCLhy0zyVwP4EQP0D77xM1h28c
   XFzpeLoxYuvRtGu+06FCLp0AetGSas31gXVA2ue6yQgXDtNtA6vmOx6y+
   pYWaPbvwcJHGHu6UaO0bOrgCTxLj4b2UbFkFN/azTbfKPssJGsha/yJbQ
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="163218834"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 06:32:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 06:32:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 06:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBDZayHEQLzpoN1rliMjL7d6RSTXy6Kiy0nZoeAqE9DYLA8boZBfi/APkmFAoDWGL8AjvvXy8FogYsRavU1wxlade0Rh/LBN2FEuIM/kJZYqM249lPYx+5iDXBYTr5vWBhQ55wuzYYOBqUAB3ChEd0CAgii3n2MxlyrIm0cG5W+XFmCsGv2oZPubJ7/ZJ+OtytEPbqCAyZ4Y8saMSQvusOKemhPmMf9dhNoH/wBiBnhT2k8EBVJxcGr3Vaplnu0qz9265H4CQr6A3qLRa220pywbEc9aAPw435N+vxpUGqzuqcCso2jX6Ag/B4Cyhy/TZ44pshecuXALBjmnRgnkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnP++AQdaRBEq07St6hTGvOG4xURBYROWcHl2iDu97Y=;
 b=GbY4nQwOBze6P7kgTPyEi17YkpZnHHq/UbkWRXCpsdiPIdLLQcFdccLLL3yUzOQmt46jTx5CjZ+vpHmtchVpKXxvBCYsG7fnhe6klGfxIn43AYibbF2X8sN5swMx8L7wxgiINki1ClEJ/qe+f3W6K46htAjm6XBVW9jqf4GmlrYkFeyy4ol9Gozb3zB42x+k7di2fJyGqmY+WSNAKF2UE8pmt6hM7Fvsp4ct6tkV4uIFe8YL2AWVppQFdsyWGkQ9ydXR9m6qtcY1DbwKxu3wP5R0u4+sp1gtublkOXU8pCkXSkBiv24VpcVDxvuvCShHUshVuczgU/qXx44U7O6GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnP++AQdaRBEq07St6hTGvOG4xURBYROWcHl2iDu97Y=;
 b=F6un0urtvh+3tPv4fwQZthdoUUS/QanYxfMHqXc3On4gRJKlQlMyvPXP8CWrr7qfUnmf8YEGtx6MkoDSub1VGNOSuwyi/GEYlbkksuNUDGzzMEXYlicVG9eeZ6WAMPl/I5zacl/Z2QyC0bqppN17jRFRA/xv0vyq26LO+JO4Vrg=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CO6PR11MB5652.namprd11.prod.outlook.com (2603:10b6:5:35e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:32:14 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496%4]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:32:14 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Topic: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Index: AQHYj4CfedzfoYGMHUy+BWB6zblg2a1uKtKAgAALHgA=
Date:   Mon, 4 Jul 2022 13:32:13 +0000
Message-ID: <8afa9243-b216-ac6c-66d1-2509845de17c@microchip.com>
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
 <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
In-Reply-To: <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1849f613-feeb-4f27-7557-08da5dc19b1f
x-ms-traffictypediagnostic: CO6PR11MB5652:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9VoPF4dDzFPwGj/rE1DsD+WHHZ3Lr5sv/9KR8gvvKkQG88+FAkJ5TbqIur/jogUmArpGCzUNhKRC2iZLOti56TQXGiiyWjkuCOCJ8AVkofEOYuwO+setP/5a8lJU68m22KMZb/95De49Q6QS4oTxG8US6iwHlyrkVVhgCHTuwr1QVp4oG0BKnzDno8NP31ft/tPtluT+6+gEW18TUhvxtxKMLulluibQ85jqr6b+jJxDUZDTdJcvSxDmmY1gZ4nYXLTgqXocKnUnVLzbXTGSiP/EQqp3cGaaW1j16TWfbgEFAS03mz4CvSlybwDBJHMaWAhzDoZfhUzCOpoEB9HY97OqRAzB3TvLln9CQ/nPY8cPeflN8bvp2iIWY1Ud4USmDKOSzwtI/wm9pxOei1cFuYMOSbBxeWX95u2a+HYwViXz5f6RhQ27s0f1TiX1H0UpQNmIE10+cidE6zSHbBkAsW819mCm0lwvP7Gb0jkIThkNC+KwPZXhTwYzxOkRwY7K2MP5lD9UN1cFhWSEJ5lokHegE67BXepzIOVzSXipHAWdrRSunf+bJPzK9FFZj7+9OtmjlfPGEiLjT8Ey3hY3FluRD7avhn9eEqYJitJS62AhKlkLYcf67v7PAxcT8udgtTTA4/tRcgtMJoIXwKZj4qinvJV+VGkzbH3rd4TX4jkMfijt56MugaXnquMXGXv8dKMc0k95f/kosjNusgfm49MTaV+AsgvqHNoOVGBlOMG9ed6V3FJqCSDTp9mFBsaH3z4HzuK3Ip07heXAN48l5Lx9ISfNZB11UNslQEStG9YE9DHgRnMcrIEB+nb1p5JC7lGVdz4U6qUCuoscVfhsr9nmZzAf2DUFTwl2gStcKSpIINAykVmIsDqb3YqbF3/WMvbqARG0EjNCy+shiIw/hqYQQ6TEtVCWWeW6WSEPnH8URsDCPZnuD6KQgunpLG1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(346002)(39860400002)(2906002)(38070700005)(38100700002)(86362001)(31696002)(5660300002)(122000001)(41300700001)(966005)(76116006)(66946007)(26005)(8676002)(53546011)(36756003)(6506007)(71200400001)(478600001)(110136005)(54906003)(6486002)(316002)(6512007)(6636002)(91956017)(4326008)(83380400001)(31686004)(8936002)(107886003)(66476007)(66556008)(66446008)(2616005)(186003)(64756008)(87944003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0xzNktBdUpTME1MUWlRRk8ra3VKemxBRmJhRWUrK09XVEtLVDRNT3lUTTdI?=
 =?utf-8?B?bER1by9hV3l4VDBMcytSUDYvbUZqTk11WGtUbEgxTUR4bVpLY21rdmdDaVk1?=
 =?utf-8?B?YXJWVmlRTDBKVVo2cnRkZWhRejFJQlRIR2ZXNCtmd0N6RysybmlSMFdpNzBn?=
 =?utf-8?B?RFYxaWdpbTA0T09kem95cVhYOE1aaTBsN0w0b3lBR1ZSa21ZYUxFblZldkkr?=
 =?utf-8?B?N3pKUzZtOUJOKzZuNEdobWFnd0Q5dnFaa3dRYkpvdXBqc3ZKdlIzQ3Q5QkEz?=
 =?utf-8?B?NlpJMGF0aW5VYzBVWUFyeHhJVFRXQVE2NExiaFJYYTV4T0ppOE96ekFoZjR1?=
 =?utf-8?B?ZUhpSFlEZTJwVHhyRjZ2dnhZKzEzSVlTck9TZ2daeGFZK2t4dWV4RitkWFNF?=
 =?utf-8?B?K0xnbzJXOVMrMXU5c2lyQzV2LzdNUFNGTElteGw4YmgvUHF3bGpUaGVySjBS?=
 =?utf-8?B?N2o5QlBLa3RiUXN5STQzVHhNZi8rSlVOa0x3SU40RTdyakxveHd3NmlQYzl1?=
 =?utf-8?B?bXEwZmtTMWk1Y0ZtUWZQTkNIUEJvV21UZ2dvSzFNUzJRWVIxYmEveVZsamdN?=
 =?utf-8?B?WGFiY1VJc1cwbFRXZTJCTFRuVjR2bWh0RktkQ0hkbUcxL0haU212NFNBeWMv?=
 =?utf-8?B?d3FybnRaUnBXa1BDRnNRSWtrWHMycXo0Z3oxZUhRWmVQSnFFdlhCczJDRXRu?=
 =?utf-8?B?M3FBRTh2Tk1RZ3lGOUVEaXhVZzlyODcrSEduemVjOFY2cDg2M0JLVW1aSEVX?=
 =?utf-8?B?U3JSYXhlcWxFYTdWYnExM1hzajhxTWpJTlZTUmJZcVBYUGVqNmVCMWJrT2xP?=
 =?utf-8?B?azhaRy82MzQ1clY2eVdMbXpJY2tTekdWU0dCV0lTeWt6QU9hdjUyd2hzKy93?=
 =?utf-8?B?NGpyaTRQZjRmQXNOQUtodU9NTXVoSTh6TEx4Q3FqMkY5OEhycTZ4b0dRdjln?=
 =?utf-8?B?TmhrbDVzcFcxTUNuOWFySjlEbkZiQ0lVL1FpYitRSkFNRy9DdjA2UkJ4d3VJ?=
 =?utf-8?B?N3B3QlpDL0p1N2lOYThCVy9Ucno4c09aWVFVdFdyL1kxOER4cURWUDB4WXND?=
 =?utf-8?B?K1dnVTNMekFEQ3lmQktCQTBlT3dVaXFicllFNUZpZC9vaEtlcU1SOWpoTWpt?=
 =?utf-8?B?dHNuRkUvL2RHTDBTNUord05BTlZzdEdoWWRVb0F2VVM0SkNKQ0c0Wnc1dTJJ?=
 =?utf-8?B?THJuN3BlN3k4WnVWMDJBZC9tR1ZNZnFpNlV1dS9IQ0I0Wk5DZDNsV2NKdGNS?=
 =?utf-8?B?WCtSTjdnaHlJSGNGLzR2OGJPNnhNa0FKVS91dmkyOW1vOXExR3RiTUdBWlRn?=
 =?utf-8?B?Tnc4bW80UnQzUmdhRVhmOGtoeFVIcXJoQWJQekpJblp0ZmtUMjZrd3IvTGxs?=
 =?utf-8?B?MCtFR0FBRnp4YVI3aFhnUFpBbHpPY3dmZDAzTStDZ1Q5a004SE5WT1hkMWhT?=
 =?utf-8?B?aFNMS1c1d3AwWFF6MGlXTWZXd3JYbFFWZHNIK2lER3E4c3ZJSnJKWXEwS0Jo?=
 =?utf-8?B?bC9senhoQ1k5dzErQTBnSGpQcGQ0eElBRkdNa2dXc2REa0JUMWNLUDdBZXcw?=
 =?utf-8?B?YWdqVHl2SHVyRGpSNzRBZzY1VXJRLzNtMUptdUhMc2Z1L0tRNWcwSnM5S25G?=
 =?utf-8?B?K0psVkZGOFV3S2VESXE3WEVJL3o0dHgyYjdlODJCMVBubFVVVDlRR0VLZ05N?=
 =?utf-8?B?UXd6a0Q4YVFkclpDdW15VlUyOGNXRnpGV2VzeEQ0TFM1aGRZSWJEbjFjWURI?=
 =?utf-8?B?VHprb3JqSU1Fc2lDQUVSN290QWNvbzNDQzBhNS9xTmdmR09iU1ZzcWt5ZDhy?=
 =?utf-8?B?VGcrcHVKZWU0MjNvd3h0Q1JXMXo4L3VGdVorblZUdG42WmM2em8vdFVtQnRI?=
 =?utf-8?B?aUwzRFpKZ2t0YmJXK3l0Unlnb0tZYVpldE5oZzY4NndQSldPdlJpSnlaRkkw?=
 =?utf-8?B?T084SkJCcnZRMWx2MG1LNHZjSGNHYW10RHhjZFVwenZWUkhUdlRvUk82QW9W?=
 =?utf-8?B?OWI0UU1pZGlpR0doSERrQ25PejJjMTd0bzNkc2JWdkNFRUlIWDFlajc4MHJx?=
 =?utf-8?B?UTRQQ0Jzb2NMdjBUWTAyc1hXWVkwVjFzcklFUU1PSC9MamQ0cy9uVTBlUzY5?=
 =?utf-8?Q?/Qla+h+1Xer+aSlM4oSUdKJMB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F7FC98F67B0954C84529079EECE518E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1849f613-feeb-4f27-7557-08da5dc19b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:32:13.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txpURXDLg+H1E5zODyLf305wvEG6r2Mb/PEHOmCgqcdE1Yp4D8a5JFLF6tEb7O/mKM3jnrh++X/ujySwCI6TFV0UHQm+5WhReXDMohxrngc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5652
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxNTo1MiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDQv
MDcvMjAyMiAxMDozMSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IFNQSSBEVCBiaW5k
aW5nIGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBZQU1MIHNjaGVtYS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IC0t
LQ0KPj4NCj4+IHYxIC0+IHYyOg0KPj4gLSBjaGFuZ2Ugc3ViamVjdCBoZWFkbGluZSBwcmVmaXgg
ZnJvbSAiZHQtYmluZGluZ3M6IHNwaSIgdG8gInNwaTogYXRtZWwiDQo+IFNob3VsZCBiZToNCj4g
c3BpOiBkdC1iaW5kaW5nczogYXRtZWwsc3BpOiBjb252ZXJ0IHRvIGpzb24tc2NoZW1hDQo+IChv
ciB0byBEVCBzY2hlbWEpDQo+DQpOb3RlZC4NCj4+IC0gY2hhbmdlIG1haW50YWluZXINCj4+IC0g
a2VwdCB0aGUgY29tcGF0YmlsZSBhcyBpdGVtcyAoaW5zdGVhZCBvZiBzd2l0Y2hpbmcgdG8gZW51
bXMpIGFuZCBhdDkxcm05MjAwDQo+PiBhcyBmYWxsYmFjayBmb3Igc2FtOXg2MCwgc2luY2UgdGhl
IGV2b2x1dGlvbiBvZiBJUCdzIGlzIGluY3JlbWVudGFsLg0KPj4gLSByZW1vdmVkIHVubmVjZXNz
YXkgImNzLWdwaW9zIiBwcm9wZXJ0eSBhbmQgZGVzY3JpcHRpb25zDQo+PiAtIGFkZGVkIG1pbi9t
YXggZm9yIGZpZm8tc2l6ZSBwcm9wZXJ0eS4NCj4+DQo+Pg0KPj4gICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9zcGkvYXRtZWwsc3BpLnlhbWwgICAgfCA3NyArKysrKysrKysrKysrKysrKysrDQo+
PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGlfYXRtZWwudHh0ICAgICB8IDM2IC0t
LS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKyksIDM2IGRlbGV0
aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbA0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGlfYXRtZWwudHh0DQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWws
c3BpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLHNw
aS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5k
NjI3ZmM5MzE1YmMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsc3BpLnlhbWwNCj4+IEBAIC0wLDAgKzEsNzcgQEAN
Cj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9neSwgSW5j
LiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc3BpL2F0bWVsLHNwaS55YW1sIw0KPj4gKyRz
Y2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4g
Kw0KPj4gK3RpdGxlOiBBdG1lbCBTUEkgZGV2aWNlDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+
PiArICAtIFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+ICsN
Cj4+ICthbGxPZjoNCj4+ICsgIC0gJHJlZjogc3BpLWNvbnRyb2xsZXIueWFtbCMNCj4+ICsNCj4+
ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiArICAg
ICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXJtOTIwMC1zcGkN
Cj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2Ft
OXg2MC1zcGkNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXJtOTIwMC1zcGkNCj4+
ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVw
dHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+ICsg
ICAgY29udGFpbnM6DQo+PiArICAgICAgY29uc3Q6IHNwaV9jbGsNCj4+ICsNCj4+ICsgIGNsb2Nr
czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGF0bWVsLGZpZm8tc2l6ZToNCj4+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+PiAr
ICAgIGRlc2NyaXB0aW9uOiB8DQo+PiArICAgICAgTWF4aW11bSBudW1iZXIgb2YgZGF0YSB0aGUg
UlggYW5kIFRYIEZJRk9zIGNhbiBzdG9yZSBmb3IgRklGTw0KPj4gKyAgICAgIGNhcGFibGUgU1BJ
IGNvbnRyb2xsZXJzLg0KPj4gKyAgICBtaW5pbXVtOiAxNg0KPj4gKyAgICBtYXhpbXVtOiAzMg0K
Pj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4g
KyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+PiArICAtIGNsb2Nrcw0KPiBJ
biBwcm9wZXJ0aWVzIGl0J3MgY2xvY2stbmFtZXMgZm9sbG93ZWQgYnkgY2xvY2tzLCBzbyBiZXR0
ZXIgdG8ga2VlcA0KPiBzYW1lIG9yZGVyIGhlcmUuDQpJIGFtIHNvcnJ5LCBidXQgSSBkb24ndCBx
dWl0ZSB1bmRlcnN0YW5kLiBJc24ndCBpdCB0aGUgc2FtZSBhbHJlYWR5ICh0aGUgDQpvcmRlciBp
biBwcm9wZXJ0aWVzIGFuZCB0aGUgb3JkZXIgaW4gcmVxdWlyZWQpPw0KPj4gKw0KPj4gK3VuZXZh
bHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4NCj4NCj4gUmV2aWV3ZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4NCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJkcywNCg0KIMKgwqDCoCBTZXJnaXUNCg0K
