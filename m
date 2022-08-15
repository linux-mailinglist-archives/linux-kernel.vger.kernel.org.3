Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99535593D95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiHOUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbiHOUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:16:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849E96771;
        Mon, 15 Aug 2022 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660590014; x=1692126014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uu79OLNHqQulrvwkP9vqWUMRkepNMv0P+uDaZRm+IzA=;
  b=Fll0x+eJt3petA+y3P1vwE8PvGoBtquqDd/F1NyVorXbCc5NEDj46GTv
   Qj3lRbGAJQLyn/dXilNjD0+gDzH5dKuV1dQZ80caNCnevhcYG3w6em+SU
   ajLhv2FZORIZ5bf7I50EFCcVXZIAE/FmJECX87rimJe4zHvNIFGs6Vfns
   rFsPkkK14TDWJpBbmr4xwQBo/nr8dTlHvYBYOEJ3k5q0p67qrIE+8m+yu
   yh4RFMFPLCrn5p6a6qODJl02CeHI3JqUi92eLK7kQqlRnZE6xdW3XXxV3
   qRixEck1nd5LG8tz5qjmxxOYQYCX5YlxP7NCaANNZwzFphrSQsJ/zl+kg
   A==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="186541876"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:00:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:00:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 15 Aug 2022 12:00:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkSOCvM82kh4r0yhqlS2/fOtE5AmduE4Wh/O9hN17h2Hg+Z1Yvn1obuPjJqqBNnKaRkJwrEeuEl8v4Z6uHDboezYEA85plbMgsR9XcvfA+/n4Yuov4fRnAZYfrONW0K4NhZnsCBQbKKFQE4Hb0AR718m4s3hRgin4BZU0P0ZXoP1P//kZE4hRq6H4oFMDX3M4CPCDGuOdbzF6+1gvLaHggUX68oU+p5JLz0YaqdwETszA+JkvB2/UkhGHElNJlFUawD/hZViRuq/vJJInaVcxtWqnWF3DxZ4xBFfJMlxGYI9GZdehZN9qImXPWE5Ot2sVCMXIkMp1JW5Q9mFJJakow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu79OLNHqQulrvwkP9vqWUMRkepNMv0P+uDaZRm+IzA=;
 b=LDWm04RBS9cIcJZmuC5i/Ou6AEnYysqiV2ZHYcxbWmdRF/nEJZRvEdhWVaaQmRdc7cXbbHwUUn5/hAFjChXbiZMdrASYyTetAkOK7VotaFfOygiHe0x+GXOhbkJQeOZkIsoTT2sbQfEIJpyXqbjbzUNvytmIKPPzwFHcBq9+ZR9qxD5GszTKcye9kL6wo6fzFeVe1gh4OS207+sho7+FAj4WeiL5t1A5CuqRHlHS0xJRkotH5+8Tzmix31V3jG14ndJxMaurlJJQLGASgRQKo001jY7LbT2htemVYftl56dNIIFb4mTW4fQTPFVOj/kpLn1/CgAHk5Lm+Np8VStAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu79OLNHqQulrvwkP9vqWUMRkepNMv0P+uDaZRm+IzA=;
 b=VS3INe7UpqX+LQsNks/7YKSabpfdq26hFbmuJzNbvr6OrHbhqKawdVDI9Pqg9ZDMzwP8KrkBwpV9Esz/ba1pUMSBKjp/1+8/pXCe2w/KuAIzzCO69xhzKmrZo2cHsR1tZKghR77hPOIG17Df6Aj8sdB66hBr0vomSrYx97/ibW4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1457.namprd11.prod.outlook.com (2603:10b6:405:8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 19:00:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:00:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>
CC:     <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Topic: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Index: AQHYsLovHvp8srW8EUKH5nn4yyg3dq2wUQGA
Date:   Mon, 15 Aug 2022 19:00:05 +0000
Message-ID: <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad885c45-039d-4f11-5ef9-08da7ef05ddd
x-ms-traffictypediagnostic: BN6PR11MB1457:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCy4FNPfZU+ToL/aU7IiEtR8J3BMAtAHxL/raMj2lgpubWlVxFkgO9s880Cmmy/HY/r91xnH2y4b8o39vSAL2aOj9H7HvSjWRpiUr8R+s8VQYTiiT6hlssWLjnAG9HWS2fYCdEvkk0M9j6lO38CEPs7iuFaRtPrmaj+EGebMDVPAJBTN3ZSiPrdhHntGFMbzNng0OtmcayHv2W2IWjrfxUUV7Q5m+Fz7ae/Q9iKvZ0QfBBzoA3JszOPiAO0cN6b0Iarzg2u7Lqi/m3zaSVFjMCzxxcPrCsIBcC0Se04VH6EvdHoZ/2Bs2RF9fvjvHCtRFcaDZN7vH8M/lcGpUAhRlXamKYbodxaMiYqR1hUv3ihNMIVy6wXY85RYZPnj+fpT4CarJVO9DJQ/OY2ll0CdWEB69vMcic4Lem8RbXyFKi/y829FmxxQSuluySX2BH+KSN1atwAioo6S75DtaNHjsqVGo3ZPTLmpZfsImdJHOxa2zV2lR5GHm07Om5HXWdyfvBGh5IRwnnzabHD4ubm/SvmzPj8xiTucutpL+F46DFKmgdTd+GOG+rxFa70LXgvlTv5CFnGq+Ts/2qWKk0uKIwTcYuy63T9uaQXR6V66s61VJITjOrbCzuoiW/DKZmXypKVNN5xdZ9LwBLfubZFIL89dC8vsdcgwtHG9VK5PacFubyW2xaP2roa3Z+/I70kYJx/Ru3o6poTAozZZC+3RLVWlimnfZxyATP6oJEKpBPkmbnA6X1Cpxq/YZYInCsDCs4g4g8yY8Vu0Du74Swsq/pQfHDPbeaKLbUqXe8shIQGKmpvpXXmv+3m6vBRYNbDfzeNVvI6hZweQu1CcQ0tAaSEwz1YIKQTGxt3si/MjD/gjeyZ49UU4TTXxGNLHUeK++E5iUMu/LZi5/ijm0K3F3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(7416002)(38070700005)(54906003)(5660300002)(91956017)(316002)(66556008)(41300700001)(76116006)(110136005)(64756008)(31696002)(4326008)(66476007)(86362001)(6506007)(53546011)(8676002)(6512007)(36756003)(122000001)(31686004)(2906002)(66946007)(26005)(8936002)(66446008)(83380400001)(186003)(2616005)(478600001)(38100700002)(966005)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZDMGxOZUVoK01uWFNZZmZEWkoybXJBL0JMQzFkc2FnRmIvdFNkRE5ObXpD?=
 =?utf-8?B?THFaeTM5M0pPVU1OVVpRNWQvSmM5YlNTam9ocWZEUDR3bjlWUkFKaTZpWUNp?=
 =?utf-8?B?RFRlQ2tkbVhIVEJJOXh5ejJKTENVTGVmajIzNEROQmxDTVhzTUhnbk9BaEJG?=
 =?utf-8?B?ZDdXVzJUQ3VKb1orNUVnSTlQdXJjNGFZY2ZxYXpwamhXcTJpQ1IwUk9IalY4?=
 =?utf-8?B?K0dyRGRnekFsamhmME1HcjUwdVdldHJRSUt5NFhpRFowbUk1OENWMjBQcERl?=
 =?utf-8?B?bTBNUzd6ZU9ubHllRFIvbHJHOGMwS2YwSytmY0JpNStSdWROOUl5eHM0Sis2?=
 =?utf-8?B?U3l1Zk5kMEI0VGVBaEJ0R3U3TUlaVkJVdEVPSGw5cWV6Z3ZXcXY3cGJVMFdK?=
 =?utf-8?B?cGUxcDlERTJiazVxSnVmVmlJSEYrNWRaR2pFaU1xUDVJcE11MG4zNmRkUTZr?=
 =?utf-8?B?NFljZ3pUeTBQWTRyTXBzeTVpM2J0NDhHTmkzNlBWRDBicHp3ZFB3SFNtdWVp?=
 =?utf-8?B?cDEyRjVZWmdURkZRR3VBZzNFM0tDdE9hV3dPd0V4T2hER1MwTzhqZm5YOG1B?=
 =?utf-8?B?QzBCRzVNYkJobytsRUN3eFRSZlBPRGdpVHkzTWZYeWkyS0Y5SkJVTlB6eUdR?=
 =?utf-8?B?djNsUUNNWlpsK0EyKzlaL0NZOHFDbWE1RlZZRm5kRnFxYkpKZDUvM2RUMEV5?=
 =?utf-8?B?VlMzazNSRnFqSmxtZmlGNmZOb0EzM0NrUTlodEhYa3V6QlNlT2p5V04rUDhp?=
 =?utf-8?B?K0o4bUxFdXhkVEJWUnVkbjNqM3dueXRQRXdhaTdKYUlBaUZEV045TWN2RUZx?=
 =?utf-8?B?M0FiQThkYmJNOGtaVFh2T1hkbmsrZnYvTm9kVE1vS1JhdXh3Z05SZVdyUnp2?=
 =?utf-8?B?K05KRk8wMGF1WUh4aDhHMUdYWkhYYTZhckJyK1RsWFJLWGw5amY0Z2hFSFFT?=
 =?utf-8?B?aW1LUkdydTg2Z2FXWUY4eWZGSGh0RU1TNkxDZjFNUG1SaE1Xc01oRFdLTXVu?=
 =?utf-8?B?OE02Nlk0TGF6Z3NhVDRQRkNXVXp0MWJtWGxGV1gvWVl3VkFWU1B0K3ViR0dB?=
 =?utf-8?B?NWNrTnE1N0ttMWNFZGxIaStOdlJBNVRxUTFhd1J1eHhqNGpTc0hWV2dqWGtS?=
 =?utf-8?B?a0hnOFQ2V2t4dnhQL0xDU0ZDREJuZytVUEl2bXdHMFBBVzh4SDlZVGRqMi9n?=
 =?utf-8?B?NzVsZnVIdGJJbUVCYnI2aGRpQko0ejAvaS9ZNng2RitON29Gd3dKdjNPWEZ1?=
 =?utf-8?B?OUduTk9qM090NGltc0IySTJwQXhKVjBkRFl3Sy9Mc0tmUUR5NlMvQ3Z2YU1j?=
 =?utf-8?B?bnZkSkRoN3FVZXJaU3FEK3pJR0cxZERxZ2ZPOE12L1JYZDZuNE1qRXNqMHBv?=
 =?utf-8?B?eFFJQnlrOGJDdjFlRDV3YnBuZ3dqK3pRNUFVRkhFYXJmdlVFNnlWa285eVlZ?=
 =?utf-8?B?ZzlpZWVQalU3ZklPSzBmZi95OFNTdEs2eEVtR28rbS81L1RuUUhnWm0vRERO?=
 =?utf-8?B?MTkxR0UxQStLcVJQMUd1NjUvRXJicVpjWmR0VVhIaDZYcDBydlpiTGFMa05h?=
 =?utf-8?B?UHZWaFk0MHNBSjlITS9SUk0rUlFzYVhIODkvK2tTUnYzZVdpbmhOQVVTbEFB?=
 =?utf-8?B?NEVOSXEvWlpJb2FpSnlOOS9XQ1Q2Z1BjWlpJTVM0WnFSVDQ2N3ZySEdTU2J5?=
 =?utf-8?B?RHVsY3hneWJDL2x5NGtCRmtQdWxqc3pzODA0ZGFSZWZkNlM0Q052bUt4aGl6?=
 =?utf-8?B?WU5HY2JQSjRyZ2QwcWVEYTV2SmMyWnZ2KzVYY3RzUXU0bS91aDRpZW9QNmlH?=
 =?utf-8?B?d3JuNXE5OEZFWCtrRTVWbmU5NTVLU0FRT3lYSVNyMzRMYWh4VWkxbTR6RzVp?=
 =?utf-8?B?SkNoVXVIdmtEdnVSeHVBRFNOTlNzSEhEWGM2eWR3YzJmTFB2SEZtcjF3NlEz?=
 =?utf-8?B?am9ib0ZiaVZvWmJ4UjdLblBzN0dLN1VRektUQzRsTUR2VXd6a0NFWmY4OTk3?=
 =?utf-8?B?QTNqUXNWb3d3di9CaFpMa01YaVEzYU9lOHRpREt4dG8rQ0JiWExTVWVHajhi?=
 =?utf-8?B?bnBuK0l6QlB4dVJrQ3RIMFRoZmhBYndNWEo3RTM3ejVPUnVDSUtUamhLS29j?=
 =?utf-8?Q?M9HF8DH6coR08HXd9rkvAeaaU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <560E9390560B2C4FA7EE54F459634C47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad885c45-039d-4f11-5ef9-08da7ef05ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:00:05.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+DWGFKme2Gno1egycAS62Q0hJdQQFyddfrvuNuCb8euCocCzvPMUqkDPmf+jKm3oQJnaQpUGCqce2x66eAPX3A3slZ4blkK8R68ZWbOqBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1457
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAxNjoxNCwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFbmFibGUgdGhlIG1pbmltYWwgYmxvY2tzIHJl
cXVpcmVkIGZvciBib290aW5nIHRoZSBSZW5lc2FzIFJaL0ZpdmUNCj4gU01BUkMgRVZLIHdpdGgg
aW5pdHJhbWZzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2Fy
Lm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gdjEtPnYyDQo+ICogTmV3
IHBhdGNoDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgIHwgIDEgKw0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL01ha2VmaWxlICAg
ICAgICAgIHwgIDIgKysNCj4gIC4uLi9ib290L2R0cy9yZW5lc2FzL3I5YTA3ZzA0M2YwMS1zbWFy
Yy5kdHMgICB8IDE2ICsrKysrKysrKysNCj4gIC4uLi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1z
bWFyYy1zb20uZHRzaSAgICB8IDIyICsrKysrKysrKysrKysNCj4gIGFyY2gvcmlzY3YvYm9vdC9k
dHMvcmVuZXNhcy9yemZpdmUtc21hcmMuZHRzaSB8IDMyICsrKysrKysrKysrKysrKysrKysNCj4g
IDUgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9NYWtlZmlsZQ0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzDQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1z
bWFyYy1zb20uZHRzaQ0KDQpKdXN0IHRvIHNvcnQgb3V0IHNvbWUgb2YgbXkgb3duIGNvbmZ1c2lv
biBoZXJlIC0gaXMgdGhlIHNtYXJjIEVWSw0Kc2hhcmVkIGJldHdlZW4geW91ciBhcm0gYm9hcmRz
IGFuZCB0aGUgcmlzY3Ygb25lcz8gT3IganVzdCB0aGUNCnBlcmlwaGVyYWxzIGV0YyBvbiB0aGUg
c29jPw0KDQpJZiBpdCBpcyB0aGUgZm9ydmVyLCBkb2VzIHRoZSBhcHByb2FjaCBzdWdnZXN0ZWQg
aGVyZSBmb3IgdGhlDQphbGx3aW5uZXIgc3R1ZmYgbWFrZSBzZW5zZSB0byBhbHNvIHVzZSBmb3Ig
cmlzYy12IHN0dWZmIHdpdGgNCnNoYXJlZCBwYXJ0cyBvZiBkZXZpY2V0cmVlcz8NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzNjZDllZDViLTgzNDgtMzhhYy1mZWIxLTlhN2Rh
ODU4Y2ViY0BtaWNyb2NoaXAuY29tLw0KDQpXb3VsZCBhdCBsZWFzdCBiZSBpbnRlcmVzdGluZyBp
biBoZWFyaW5nIG1vcmUgb3BpbmlvbnMgZnJvbSB0aGUgZHQNCnBlb3BsZSwgR2VlcnQgJiBQYWxt
ZXIuIFdlIGhhdmUgc29tZSBTT00gYmFzZWQgc3R1ZmYgdG9vIHdpdGggY2FycmllcnMNCnNvIEkg
YW0gaW50ZXJlc3RlZCBpbiBzZWVpbmcgaG93IHRoZSBjcm9zcyBwbGF0Zm9ybSBwYXJ0IG9mIHRo
YXQgd29ya3MNCm91dC4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvcnpmaXZlLXNtYXJjLmR0c2kNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9ib290
L2R0cy9NYWtlZmlsZQ0KPiBpbmRleCBmZjE3NDk5NmNkZmQuLmIwZmY1ZmJhYmIwYyAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL3Jpc2N2
L2Jvb3QvZHRzL01ha2VmaWxlDQo+IEBAIC0zLDUgKzMsNiBAQCBzdWJkaXIteSArPSBzaWZpdmUN
Cj4gIHN1YmRpci15ICs9IHN0YXJmaXZlDQo+ICBzdWJkaXItJChDT05GSUdfU09DX0NBTkFBTl9L
MjEwX0RUQl9CVUlMVElOKSArPSBjYW5hYW4NCj4gIHN1YmRpci15ICs9IG1pY3JvY2hpcA0KPiAr
c3ViZGlyLXkgKz0gcmVuZXNhcw0KPiANCj4gIG9iai0kKENPTkZJR19CVUlMVElOX0RUQikgOj0g
JChhZGRzdWZmaXggLywgJChzdWJkaXIteSkpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL3JlbmVzYXMvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvTWFr
ZWZpbGUNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yZDNm
NTc1MWE2NDkNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3Jl
bmVzYXMvTWFrZWZpbGUNCj4gQEAgLTAsMCArMSwyIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wDQo+ICtkdGItJChDT05GSUdfQVJDSF9SOUEwN0cwNDMpICs9IHI5YTA3
ZzA0M2YwMS1zbWFyYy5kdGINCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvcmVu
ZXNhcy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2Fz
L3I5YTA3ZzA0M2YwMS1zbWFyYy5kdHMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi43NDI4ZjY0M2E5YjMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDdnMDQzZjAxLXNtYXJjLmR0cw0KPiBAQCAtMCww
ICsxLDE2IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBP
UiBCU0QtMi1DbGF1c2UpDQo+ICsvKg0KPiArICogRGV2aWNlIFRyZWUgU291cmNlIGZvciB0aGUg
UlovRml2ZSBTTUFSQyBFVksNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgUmVuZXNh
cyBFbGVjdHJvbmljcyBDb3JwLg0KPiArICovDQo+ICsNCj4gKy9kdHMtdjEvOw0KPiArDQo+ICsj
aW5jbHVkZSAicjlhMDdnMDQzLmR0c2kiDQo+ICsjaW5jbHVkZSAicnpmaXZlLXNtYXJjLmR0c2ki
DQo+ICsNCj4gKy8gew0KPiArICAgICAgIG1vZGVsID0gIlJlbmVzYXMgU01BUkMgRVZLIGJhc2Vk
IG9uIHI5YTA3ZzA0M2YwMSI7DQo+ICsgICAgICAgY29tcGF0aWJsZSA9ICJyZW5lc2FzLHNtYXJj
LWV2ayIsICJyZW5lc2FzLHI5YTA3ZzA0M2YwMSIsICJyZW5lc2FzLHI5YTA3ZzA0MyI7DQo+ICt9
Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1zbWFy
Yy1zb20uZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yemZpdmUtc21hcmMtc29t
LmR0c2kNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi40YTRh
Y2RlNmEyYTcNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3Jl
bmVzYXMvcnpmaXZlLXNtYXJjLXNvbS5kdHNpDQo+IEBAIC0wLDAgKzEsMjIgQEANCj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4g
Ky8qDQo+ICsgKiBEZXZpY2UgVHJlZSBTb3VyY2UgZm9yIHRoZSBSWi9GaXZlIFNNQVJDIEVWSyBT
T00NCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgUmVuZXNhcyBFbGVjdHJvbmljcyBD
b3JwLg0KPiArICovDQo+ICsNCj4gKy8gew0KPiArICAgICAgIGNob3NlbiB7DQo+ICsgICAgICAg
ICAgICAgICBib290YXJncyA9ICJpZ25vcmVfbG9nbGV2ZWwiOw0KPiArICAgICAgIH07DQo+ICsN
Cj4gKyAgICAgICBtZW1vcnlANDgwMDAwMDAgew0KPiArICAgICAgICAgICAgICAgZGV2aWNlX3R5
cGUgPSAibWVtb3J5IjsNCj4gKyAgICAgICAgICAgICAgIC8qIGZpcnN0IDEyOE1CIGlzIHJlc2Vy
dmVkIGZvciBzZWN1cmUgYXJlYS4gKi8NCj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg0
ODAwMDAwMCAweDAgMHgzODAwMDAwMD47DQo+ICsgICAgICAgfTsNCj4gK307DQo+ICsNCj4gKyZl
eHRhbF9jbGsgew0KPiArICAgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47DQo+ICt9
Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1zbWFy
Yy5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1zbWFyYy5kdHNpDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNDg2NGEyYTYyZDZi
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6
Zml2ZS1zbWFyYy5kdHNpDQo+IEBAIC0wLDAgKzEsMzIgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKy8qDQo+ICsgKiBE
ZXZpY2UgVHJlZSBTb3VyY2UgZm9yIHRoZSBSWi9GaXZlIFNNQVJDIEVWSyBjYXJyaWVyIGJvYXJk
DQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDIyIFJlbmVzYXMgRWxlY3Ryb25pY3MgQ29y
cC4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGluY3RybC9yemcybC1w
aW5jdHJsLmg+DQo+ICsjaW5jbHVkZSAicnpmaXZlLXNtYXJjLXNvbS5kdHNpIg0KPiArDQo+ICsv
IHsNCj4gKyAgICAgICBhbGlhc2VzIHsNCj4gKyAgICAgICAgICAgICAgIHNlcmlhbDAgPSAmc2Np
ZjA7DQo+ICsgICAgICAgfTsNCj4gKw0KPiArICAgICAgIGNob3NlbiB7DQo+ICsgICAgICAgICAg
ICAgICBzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsNCj4gKyAgICAgICB9Ow0KPiAr
fTsNCj4gKw0KPiArJnBpbmN0cmwgew0KPiArICAgICAgIHNjaWYwX3BpbnM6IHNjaWYwIHsNCj4g
KyAgICAgICAgICAgICAgIHBpbm11eCA9IDxSWkcyTF9QT1JUX1BJTk1VWCg2LCA0LCA2KT4sIC8q
IFR4RCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgPFJaRzJMX1BPUlRfUElOTVVYKDYs
IDMsIDYpPjsgLyogUnhEICovDQo+ICsgICAgICAgfTsNCj4gK307DQo+ICsNCj4gKyZzY2lmMCB7
DQo+ICsgICAgICAgcGluY3RybC0wID0gPCZzY2lmMF9waW5zPjsNCj4gKyAgICAgICBwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+
IC0tDQo+IDIuMjUuMQ0KPiANCg0K
