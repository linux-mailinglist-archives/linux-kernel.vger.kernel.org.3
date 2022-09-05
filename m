Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B395AD650
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiIEPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiIEPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:23:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E65808A;
        Mon,  5 Sep 2022 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662391412; x=1693927412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zroIBL9GeEvnlovstKGG5x0SL5dH67ZQcdGMW8RnZsM=;
  b=tTRcBvATcrNYXi+wvkwCUPRpg4guiWHeRLBQ3zxIxswFNZOHfZ150e53
   Mo/PLxq9qUU1bBDHQaUvjUhtKF5IcvB4rYWb4dJBA1KkU2y7NR8a2kGnW
   LHOyOLsW8L0tcTPESN5vFtWZnZMhSrLJgV+IDjNKKdNVsTHrIIi1Sv7aq
   Vv/OlrJVK6NgsInBEDOFeEaTH90cWY7mFya0oNSIP4rWZgrT94yiO6bAP
   kaiq4mBg3qfRfImodWuPM2kEX3zhcWHDA47NGsca3YamfB4bomFDEo+OM
   2oBJLoyZgS1ar+Ub/rE7A+775Fwa0k3RINTJ+DDPEzfZVCVjBrZDLzCrg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="172445324"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 08:23:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 08:23:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 08:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PH+mQYUrRRgVhUiNWTjn2evOel4MPBr2apwNmgwkH1RPT3jlXkz8oG5HceSbsYYNHSuhVSIXmqSijtPb932v32MCJ6iGc9uZs91/4MVgB6nz/wzwlNjMSXrGhBGdKJ4n3bZXCOW345cNwbQzpocFC96YahwdsQuXtCpt/MgWGy9VqEqbntyI4K+X6QSe7wTZyEBMNx3j7mnfGi3I16rOpJuVP+WD1Kl8zIjvwSkJ7ckYsophVGDNyzJnscJ0ja5dOtYVGvxrAVk2H+5FntlT78ELVw+8uiTrmTUvNOjMBhVHKU2QUfKh7mIiVuoOyvBK8q+unPi1H4WkWBOzFtmzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zroIBL9GeEvnlovstKGG5x0SL5dH67ZQcdGMW8RnZsM=;
 b=KmyLCTo7WySaRiWPZIl9KvlOBlsNtOSCeaxDSNS52chUyDGJf8JpC3L0cReg4wPAS31oUbZoDhT0gHxG85PWTm3gwR0Pwkki+esVTcNGwTFVhbiZGHDWyhKV0dxlTPTzfW/+mmXH7MdKXKYqo73QfkRg/kbDheS3dTX7mSc+7Ghd016S5fBzRA3XFxzenkYsR0GLAfQHaaqUeEB/RtPsiNsxmNWxI3BxPJauI/JbH9Usfb18bno3hio59nNq7BwgS/ac5O8KMgHEyI7foeG+A7Vd5PmKw3CNbBH/NkrDH22jduYqQvamdkWPg+/TP60ICdwBF6nCb4utCUtZQZjdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zroIBL9GeEvnlovstKGG5x0SL5dH67ZQcdGMW8RnZsM=;
 b=vbpyFaC7CoGUbLZwqgf343e58+LRaQmgxgmSnLuY4iTP5QobD4jdhrC+3zkScOGMk5r555LdXpc6ylxhOWzCQ6ftRy7hdY6L3lBeu3vX0dho3uaVNQiTtQsD/wvDheDfUVnUBjLjI1KUrTLOvAHCqKIK6rCZLpBltoqhYCTxpAU=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 15:22:56 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Mon, 5 Sep 2022
 15:22:55 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <lee@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYsg/cwUZrhBU4AEegbceOuhne8K20V+AAgAGSGICAGxv+gIAADKwA
Date:   Mon, 5 Sep 2022 15:22:55 +0000
Message-ID: <d6a498e7-838b-addf-bc7f-81e6805806d3@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <YxYI8/bprIV2wd1c@google.com>
In-Reply-To: <YxYI8/bprIV2wd1c@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc26628-cb01-4040-a964-08da8f5281f8
x-ms-traffictypediagnostic: SJ0PR11MB5167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFYEN8wpm0p6k6BQnvP63Ck5syUke2Xt+/CQqSwWNtruVc6iQ5WZ43RrjXUmQYIuchR1CMyfvIP8rTCS/HE06AVlGGa5Nbprl1cZtp74QL8vnUQe7RKKFI479TenUQp69awNGgxkGfKcn0XCp8Pe+goM220BKM+o6ccaY3u6H2nULIs0MuaJaHs6Cs9//PiDy52vpG0D6oK5lk73LinTbBR50i8KhIhU4D37KR+xa1qfyM5VU5GA5uzzwtFQmvrdsmlKVIDr4JVexV2mYzTe7MiR0kOqEtCdJ/enUtj9GMex6nHynmRYJqXgyEaipjiEOxJ22uALo8M0I8lql+ZPDieVVDOoyB4WnDu0J+ZiEOrcugkanPb2nIJabzYAAsI/joq8pL6mCF1fNqTUWKlHqXwgy8g5VJuPh/H4vItEQcKSllA3feUXgm7kir3+i6PjoKlBSTHFRVvQQjnJzE+z5+mPkvk527RGJdJc3xC2whaceiIEeHeUeEDbnHL3lrAnEIZt/5YlzVKmV9rgaMz6bOzGEM7A6J5C2ArY6ee5p6VZsiOkCez6uYvUXhFahzQnNHy5ihZjelqW5zte888unZCyWBrpdO2IBZjSB9vZk6tFJr8FK/5SooG8RsXlgymq18gp0WyYCWOiGAcWguDe3YQ9/qX+ouF9GAujBdag7KFmhUZp4wJBzFiFSNxZcGE4xgZ2RyeWfOZ9zeDGUXev/gMeSTcnt32YdXMSh2Rldprkii1KmacIHF5LSSj12hMb6M9zzwh+Sp/h8hloGv5/sXcyU0Y4JjQMbdRRPbe8UKRSK/4qoCSh/vNhUxqcV/5tkRzOEFNins4wqMnl2xxD6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(396003)(376002)(64756008)(8676002)(66946007)(8936002)(31686004)(76116006)(54906003)(5660300002)(36756003)(4326008)(66556008)(2906002)(66476007)(91956017)(316002)(6916009)(478600001)(7416002)(66446008)(71200400001)(966005)(83380400001)(2616005)(186003)(26005)(38100700002)(38070700005)(41300700001)(6486002)(6506007)(86362001)(31696002)(122000001)(53546011)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpyZTNuTHdGL0FKTVI4Z2lQb3BCYnhhRGhtRzdDRUgrL2t3c1dKVE5SbTFW?=
 =?utf-8?B?aDRnSmFPRzM2eG5vWFlXSWFzNzFKWnJvODNuckc1VktJUHVDRHZUcHNxYzZv?=
 =?utf-8?B?eVo3TDl4MXVyTzZSQ1I1MHBpZ3pmVjRHOFZZeVdpRlMyMGlsM3pNWmdYUDlM?=
 =?utf-8?B?VVo0eHlqN0Z0VGJVT00zRktjcjFLWFR3TVFsMmZMaUFJaW9jNGpoWTZVZ0pS?=
 =?utf-8?B?L0dSdjlncUREVEk3UkxSY1JMNmw0d253MDB3MG5JMXo2Z2tSbUJHYysxOWU0?=
 =?utf-8?B?a2pTSWZ3TUsxOGhRR2pOUG9PaDdCZmFhK0FER21pK2RmZkZ3TUdFQ0xNTlho?=
 =?utf-8?B?amoreFdEaSthUzZkUUVrdXJTSGd2djZIZ01zcituM0JzVUtDWWVVMzlXU2NK?=
 =?utf-8?B?ZHNXaGlvZEExNWxFVmx4M2dSa2RpUTUxeFlwZ1dIcnU2Wm96elRyclZIWlBB?=
 =?utf-8?B?bzNJbjE4cHIzSDhTaFdZd2U4a1U2RXdjdmVzaE9HSVRtdndvbjhqRDZjS3dG?=
 =?utf-8?B?M0Fla3dBdDZJMjZJZ0NRM1BmTm5CTC9kUHl5NFNRT3NEWjcvK0RGMSs5NnJl?=
 =?utf-8?B?WGd4M2ZWamJhbGJqSzhoUWUwZDFRMG9ueXI2bG0yZkVHUHBzRGNkc1RMVHpQ?=
 =?utf-8?B?OXhRYVhuUzdoS1A3VEw5Y2tBZkFTNmNzdFIrYWlFUkhrV2w5K3hEWTUvNFdJ?=
 =?utf-8?B?WGwxaGh4SEF5M21mbXVUN2Jnb1NyK0ZCUE5LL1MwKzhEV0pMR3FwR1VRWWVO?=
 =?utf-8?B?Qk5vUXArL0NEanA0RFJid1FUMStia0VrWC9FSk1WTUxKQmJDeVNxRDRkK0ht?=
 =?utf-8?B?QUNWNmhERE1jNGcyQjBITC9SNmxJcHZCcG1IZkFJeFhHS0piRkFOS3FrVitz?=
 =?utf-8?B?NmJ5bFlCWFN1S0ozV0swd28ra2lDRk52YmdTU1gwcHdnejVtQ0RMajdiMTAz?=
 =?utf-8?B?SDFrRGpxSVdycTM5U25xbXN2SXpsYjdlTm11bGVGd3UxTEgrZmttNi9EMUtQ?=
 =?utf-8?B?N0F4UkRGbkpiVHYxQklDQ2VpckhyWmZZN2ZGbWQwaDhST2dJWHlSVlFLdkRG?=
 =?utf-8?B?aTY4VzZKekdEUUlMMkFmVWtaeFNOUHNlclg3S0hUWFpLbit2bTZyQmV0dEQ3?=
 =?utf-8?B?cXBBSXVHTmpJUENYR3J0ajVLZk5zK0lmSllid3VPYVlZN1NMZm9zbHpHQW10?=
 =?utf-8?B?UzJ5ODRRODJBbG1MbVJmOFR3THlzb3BEOEI5Z1ZrMnhzbmRtbGxPcUkzaFdG?=
 =?utf-8?B?OElHNmlxNDc3Y3Nid0NFdTYyZEJudFRCOWhOQTZMSFMxMXNJdXIwNGNRc2Ex?=
 =?utf-8?B?eE94dkQ2QjlERFpDSmtHbW1rYjh1MzdDSk1yQUZJdm1ZSENLbWxBYTU3MUxC?=
 =?utf-8?B?cFA5Vkp2dUtqQVIvY1R3SDVnaGVSZ1lwNDNkZStPS0VuVmtFdFR5aDRqY0xU?=
 =?utf-8?B?NHFNQ3R3bTEya2lJZDR1YmlMY2dFQS93djdNNGIxZkNIK0hiTEZCOFdFYnF6?=
 =?utf-8?B?MWdFNFZwUDVhUnFlS2k2Ulh1Q1hmcGFVWno2bHcrUEZIc0lmYWZiU3ZqcDFK?=
 =?utf-8?B?QzkrY2dVSFladTRYVm9mQkVCcjhUazZOMWZzVkQwMnJyandGWmpGcHJFbnYr?=
 =?utf-8?B?c21JaDFmcU0rZUUxNk1yZzlPY1lCbUpudTFqbVhMZzgrK2pQa2YzbjBUN05C?=
 =?utf-8?B?RzlySkt2cXlkai9IY1ZRSElzT2dXWGRpcXdXY1pqcTR0Y2tvZHJkTHBlWDQ4?=
 =?utf-8?B?TEIyeHdkYTdnNFhQZTd3M0Z4bzYyVEVEL1A5cGxzN2tNWnZ5N2RDWTJmWDly?=
 =?utf-8?B?ZUo1WTBaSUN4YTFlK2tMUzBDa2d4QkJLTUNxL0gxYW5vbTRLSEtqUDdJR1hF?=
 =?utf-8?B?Vnc1aCtrMEhXOE5EcmJxNSsxNy9LblE5a016ZG1rcmI1VUNaQ0p6NEFOVGts?=
 =?utf-8?B?ckRmUHJZclgxZ3Iya2ZsWWJmck9kcy85SUpoMjU5VTIvYk1QekZUcVd6MVdT?=
 =?utf-8?B?UksxcXg3Q3hGSFNHNlFqZllDQ1ozcVdYdHlrdU9WNnY1b3laVEpCT0FGbDM1?=
 =?utf-8?B?MFJtU3hWN092V1NSYUR4bkFkQ0JiMGhVaE5hMml2ZzRHcEpWZEc3eVFjNzFU?=
 =?utf-8?Q?r0zvz/PuSZ/jPiQENORXnVMxn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6FC1FC6FEBA7842873E7A18A9063317@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc26628-cb01-4040-a964-08da8f5281f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 15:22:55.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGY1Kzniu1x5ghaqOrIswjnsXnd8L9AN1JVW/jDNlpu0Pr+GKwEm4VfNz2XWTimCeRQpARoWlgyXY5LSnZK9sfQGegRrC3uPCe/xYZWjUQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDkuMjAyMiAxNzozNywgTGVlIEpvbmVzIHdyb3RlOg0KPiANCj4gT24gRnJpLCAxOSBB
dWcgMjAyMiwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gDQo+PiBPbiAxOC4w
OC4yMDIyIDExOjM5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMTcvMDgvMjAyMiAxMDo1NSwgU2Vy
Z2l1IE1vZ2Egd3JvdGU6DQo+Pj4+IENvbnZlcnQgYXQ5MSBVU0FSVCBEVCBCaW5kaW5nIGZvciBB
dG1lbC9NaWNyb2NoaXAgU29DcyB0bw0KPj4+PiBqc29uLXNjaGVtYSBmb3JtYXQuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0Lnlh
bWwgICAgICAgIHwgMTkwICsrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0ICAgfCAgOTggLS0tLS0tLS0tDQo+Pj4+ICAg
IDIgZmlsZXMgY2hhbmdlZCwgMTkwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KPj4+
PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+Pj4gICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L2F0bWVsLGF0OTEtdXNhcnQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZmQvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uY2YxNWQ3M2ZhMWU4DQo+Pj4+IC0tLSAvZGV2L251bGwN
Cj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxh
dDkxLXVzYXJ0LnlhbWwNCj4+PiBPbmUgbW9yZSB0aGluZyAtIEkgdGhpbmsgdGhpcyBzaG91bGQg
YmUgaW4gc2VyaWFsIGRpcmVjdG9yeSwgbm90IG1mZCwNCj4+PiBldmVuIHRob3VnaCBpdCBpbmNs
dWRlcyBTUEkuIE1GRCBpcyBqdXN0IGEgTGludXggbmFtaW5nL3dyYXBwZXIgZGV2aWNlLg0KPj4+
DQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IEtyenlzenRvZg0KPj4NCj4+IEkgd291bGQgcmF0aGVy
IGtlZXAgaXQgaW4gdGhpcyBkaXJlY3RvcnksIHNpbmNlIGl0cyBjb3JyZXNwb25kaW5nIGRyaXZl
cg0KPj4gaXMgYWxzbyBpbiB0aGUgbWZkIGRpcmVjdG9yeS4NCj4gDQo+IExvb2tzIGxpa2UgYSBV
QVJUIGRyaXZlciB0byBtZS4NCj4gDQo+IFdoaWNoIE1GRCBkcml2ZXIgZG9lcyB0aGlzIHBlcnRh
aW4gdG8/DQo+IA0KPiAtLQ0KPiBMZWUgSm9uZXMgW+adjueQvOaWr10NCg0KSGksDQoNCkl0J3Mg
dGhpcyBvbmU6IGRyaXZlcnMvbWZkL2F0OTEtdXNhcnQuY1sxXQ0KDQoNClsxXSANCmh0dHBzOi8v
ZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjAtcmM0L3NvdXJjZS9kcml2ZXJzL21mZC9hdDkx
LXVzYXJ0LmMNCg0KDQoNClJlZ2FyZHMsDQoJU2VyZ2l1DQo=
