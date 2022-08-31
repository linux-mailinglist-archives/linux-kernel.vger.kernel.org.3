Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21215A8092
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHaOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:47:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55503CD795;
        Wed, 31 Aug 2022 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661957263; x=1693493263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TIpmTITWyHFc7hn4imi1nr2QNklbPRsARfYS+UeCvHI=;
  b=H2z9C0M54UyX5hsssb25qgKPv4G+EADHE/KivXDp3o1T5t18DEKmGy5H
   4ybGQvytBGLUAVwSb0lEE2NMFGYJYwbsBonNU/OeXNUFC1thtU/hVF6en
   wc4u9Qn0jYds2lQ6ZoRKTCOQCRMTpkpb8xNuzD3Kmr8q0UrVj44ZPq4zt
   CuhpoqNNfDUKN30oqpHNbFcQYTmOHzCpoo74//MnR+Arrb3MvvsslSBxU
   dcWDAl86KFTI9zdJEd0o8M7cd5LmfiaH+R/T9j7ZgjQPybtJEwF/NQ3Wu
   ZvW47JsZ6PRGVNbjhnLddiCfxKs9fqEnoHJlxEuGPndNP6+kJRUgbplMZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="111583048"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 07:47:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 07:47:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 07:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWMFN4YXZxsKxxnsAQ13poYinNQ33pQ6W4jxrBdxcR3GtjLt7YMb21S3TWfALK3xSpgS4p4MV8qOsFkdaVnvWIZXT9YaLjbti2R+tlMR0NITT5E2Rf9lRWUauTUHH1vwtRV+xlAlBnO/5ZYpHpd90UGi7WJo68RfO/zq+bVeAhALLVN+a7hzoSmhHAcwq4kBuc6zU3gZecZIJ4mGp/Zv/6LdsseS38MpeaqcB0XowA361PDqncMTaU+CU7TA3qVcts7dKCubl7CT4lt/Zpw5maqXPIkYpE4LhNlTYrvIHG2TfUHkjIaLm0BLZQWzT3nXwhM93MU6l/F0JJsaA42VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIpmTITWyHFc7hn4imi1nr2QNklbPRsARfYS+UeCvHI=;
 b=eKnTNgpenVEaUqnQDlZKCtO/fqGP+K+Q3PpT/Q8ipewXsuDGzNMhcYhTc29xxbfgLPXnQYQtJgm0/AgTkLMH0JZj4i3u+3SHQUQDiYtyhFg/X8OILYbTHmIbuFMmOcElroWpPHwuAkRzLUiqTQzuVr7DB8tBKAA/1WUjNwEodCNTLeUrAm/K44AKfNFcUbWhKU/hNgWY8vHpa6ss5I/6aohndW4ZGYRVam4IUE4F9buo0LhNLvKb2BgQkCeaYd/Bg3pD0Tc2ybQnOy1yPnCz4Wo2auWjITZ1sJMaSMCZl2LbGeOeyd5LTz6vVM4lx0R74s989k1D5/PvOc6+KqZ77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIpmTITWyHFc7hn4imi1nr2QNklbPRsARfYS+UeCvHI=;
 b=iLpsFBEbNsWbyBZq7V/o6r7LIMhdpKc1DFB8dKF0qYHPvFnlY05e8KALq7P0lkie0/jJLWP7/vji5EmdC5jcgYEh+lLCHMsUIlqu/YLS9ctECmQV1aWpJZYxNCTJ6R60ArhFtNmd/PGQkxvyx9NAfHwz85AvniojbS3Ymdmo9wk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR11MB1770.namprd11.prod.outlook.com (2603:10b6:3:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 14:47:40 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.021; Wed, 31 Aug
 2022 14:47:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <Sergiu.Moga@microchip.com>,
        <admin@hifiphile.com>, <alexandre.belloni@bootlin.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <Nicolas.Ferre@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for UART/USART
Thread-Topic: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for
 UART/USART
Thread-Index: AQHYvUidRBygRngUz0eRmHWaLEAKGQ==
Date:   Wed, 31 Aug 2022 14:47:40 +0000
Message-ID: <79af0b30-83df-f9c8-6d55-d8ba3d0554a9@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-5-sergiu.moga@microchip.com>
 <20220830222305.B4218C433D6@smtp.kernel.org>
In-Reply-To: <20220830222305.B4218C433D6@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b904860-4db8-491d-853c-08da8b5fc120
x-ms-traffictypediagnostic: DM5PR11MB1770:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+jqYco65Ykd60ohb3UlxqEmTBr1EBebieU7kDxtuvFJh6m9k8xrnJfY+b6mhZLMlRWyh9oGZgSsu3hlFolWfS3rcIOOvOafdbEDGiHOZ2AUHCyHEMNQDRWzIYPsz4e7BmhJ0gZ6Iah0ucxLub9xJDFL8GQ4NvyZh/sC3nIJiVnnnSDFchET//frNDvgH/YibxVcjgiGPmCyKEVDtcz+XEGXk4QtfKnCiTZ4sV8vlJSWw2HnAqKXyk6T4z/S9wAtsBX66yvOBsDO8hslBgMeO3gS69UswnWolj3BL+yzOzBx6TgQ+1LcxOW0qF4cn1NtmOymr/Fh4KASLWL2fZbIgMiYq4F1Mo3PbzZObdh0OAd9jUPc2KthOhUUJLEwTk20E/0ipbDhn7NGPji+vW+qD1QwoK1LJBrdvU/3xY9/FzUrO4UHnUMgqtGHJKYTO1+heQ0FC1d6Mae7fi2CggB1+JHPhxjUN6NWvKYLI99da4Mzul1k5TAEpnnBpuotPT2D6w2OYFnea8LtZk6djBkNaEEzfdK03iIG0wK97taCqfrMK7jXcThxrJH4lf2zqaTwaE5tz2EykvP3XLGKjhwMHEtIWyCJsvcgHdlMj/O7Nz/x+fSt/ej2b6bbiMB7d5ml2ikEBA0FNuVW5V236vPtrpMwcKyPNiTvtkLd6cCNqmU/mbVQGd2I75ptEEkhAx+EqYCv4+a2J6b0xz5jbRgxzFZiM1qzFmPNc+cxGcdKEGLfStxXAFEXNgjX4shcXYgQh3X6ncm21TQH2pnd/E0eG+R1UHaXu1F2bHUg1ejxTV5aNfFKRlbt8LD5fHhDjFNRQJlNnfnxsUjHWW0buPTTdWRUQiChuWA4VHidwla3J+wM7whWUVGhxSgpB4kuSCeR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(7416002)(5660300002)(8936002)(41300700001)(2906002)(186003)(2616005)(86362001)(31696002)(4744005)(6506007)(53546011)(26005)(6512007)(83380400001)(71200400001)(122000001)(36756003)(110136005)(478600001)(54906003)(31686004)(91956017)(38070700005)(4326008)(316002)(8676002)(6486002)(921005)(64756008)(66476007)(66946007)(38100700002)(66556008)(66446008)(76116006)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmY1S205VENxbFI5TTBPWjFzS1dWRitDNjN0Yk9SUE95M2dsYkt5c0RDcXFW?=
 =?utf-8?B?VFUyZXB4OGh6aWZDbWNBU2hERVMwcExRUXR4OVVoc3RXZXJJMjlnZ1NsL09x?=
 =?utf-8?B?aTE4cXIraWhtd2JPbzREOXcxZEsyU3lYL3g3TEREMmFHczFyVUNwZjhQRGlB?=
 =?utf-8?B?anBDY2Q0N1BDcUdPcW40ZjhmandVRjI1eEptemJJVTlqM3JxVlFxUGtzNFdx?=
 =?utf-8?B?UVNOYlB4MWE5bnI2dkRWcWlscDRKVGM2L3o4MGt1Qm4yU25VUDd2RjMwRDVy?=
 =?utf-8?B?cW5pQ09pWUpYQkxkdCtIZHU3c1dOR2x1Y2Q2UFlKYUZoVWUrQmdlU0kveTg5?=
 =?utf-8?B?NGUzV1N4SUpncjBnWFdvVk1XbG5mN0dhWEg0M0VhdmNRMlg4c0ZuTDc5SDJ4?=
 =?utf-8?B?K09nOUFDWGNJMjg5aDlhNHNDSHNoMnFtcFV5RWNZeTJiSjk5Vy9WaWNsUDJ5?=
 =?utf-8?B?Wmx6dGVjREFzdHJpNFZUOGlGTk1CNTJpa204bVZtajF3ajhOU1l3TDU3Vlho?=
 =?utf-8?B?Q3BLMVB6S1IzL215MTlHR1JHaHRyR1FWZ3NPWktvdG1PS3J2UkhWaFRBMFB5?=
 =?utf-8?B?L0RsY2ppODhlZFY0eXV5OVFlMlNFK3VvcVkwMkdxaVdUSk1qV1JrZVpoeWxJ?=
 =?utf-8?B?dWxhb25pYmd4QzFsWXc4Y0lDbGFGbFRDdWxFQW9ZaWtvM2hYUU52aFpCMXMx?=
 =?utf-8?B?WUZLUTE1Vk41WkZCOGtvZjdBeTNHaWhOMnZ5a09UOFdDTUpDS0JXbXpVanoy?=
 =?utf-8?B?eEVGakgvdEt3bHhwSDhyTXc5NEpCaUxxMUV0YnVrOTROVUFkZW5tcEw2L1Vj?=
 =?utf-8?B?UC8xUXBRa3RONjVmRjhMS0xnTWd5bUpPRG5kWnYxR3d4T21CbWpsVExpSmZK?=
 =?utf-8?B?R3pkVmFMc21Lb0I3TjVra1hrbnIyK2hvb2h1Q1RBUlQxaHR3bGx1d3o3b0pZ?=
 =?utf-8?B?U1BVUURRVy9CcEVLbEhJS281WEgzeWxlZjRpWkNldkNSdEpYY1NXdUtJYzQy?=
 =?utf-8?B?QzNaQThVSXJHSS9COTl3ZFBsWlEzaUprRnRkajJOeVdhbVBucURjZzBKYkhH?=
 =?utf-8?B?QUdaakthR1Q1dFZDS2hRYVlpTUtUb2tUcXV5Y0ZXTkFBbXhUM29DZUk0QVo1?=
 =?utf-8?B?ZGpFYnJGV2o0ajkwTW95WE9CR05PM0pGRzVYMUFQYXg2bk94cDRXSDRJbk15?=
 =?utf-8?B?ZytwS2xwbTg5WnFsM3lHMWpCNngyMHlMa1laanM2QVgwbzYxQ2Y1c0UrZzg5?=
 =?utf-8?B?Ym9EYks1L2g1RytnRGNMZmoxVVIwUURqLy9UcC9UMHdYUXo0S2UrL2FPdHdh?=
 =?utf-8?B?dEt4S0k4NTBpL2JLbVRra0JuWVhrRWVEZzFuYWo1SURQYmJuMS9pQUpYNTBa?=
 =?utf-8?B?RkJKa0IxalV0clFlZ2JDRnNEK3YwVzVBR09RTUhDalBCUmtObUV0clZFSk81?=
 =?utf-8?B?dk81YlArM3JtUGNaWWZQVGNyMUR6N0x1SHBIM0ZiR2c5MGk1YzhLNUd0Zk1p?=
 =?utf-8?B?OE5YbGd0bC84NDdTcEpmaVhNMC85cmJRUDdMU0l6a2hubXArVWJiSC9sRWla?=
 =?utf-8?B?NGpkZFUzaW5QZ1REQU05ck5xVXRGSklLdUFsRWROaXVxdjVBdWVkMExiUTk4?=
 =?utf-8?B?cGdHakEwUGFoL3lBTnVhTEo4UXM0eUw2d1JSWDlHWFRSSXN4Z2JnUzluSW5v?=
 =?utf-8?B?ZWZvRE53SHFIL0RiZXhOQkkxZFBWU2ozcTZ4MGVrcUpSdzd2RVF5dlAwZ1BG?=
 =?utf-8?B?ZStHczdFTWRob3dhRDZjeXhPZWhpYVlLM29QY0xmRXdJREdKdEwrUDVTRmNN?=
 =?utf-8?B?bGZlZjBZNktyb3JzRm9VNGthQW9mU29uS3VjVmpUMUM0ZHhieFdORC9MYmtH?=
 =?utf-8?B?RDViNjEvMHIzME45eEZWYUQxWGZjSTdFdmVnUDVESm9IeDlhbml0SXdta0Fa?=
 =?utf-8?B?UXZlT0RSeVlCMFlWQm91M0lEaUc1MXJIZU1OMko2NHdBNTIwd2lNUmxNR1VF?=
 =?utf-8?B?UlF3dUEzTnBwMXRaRUcvY242SEc1ekpERDlxNUVsSnFrSzRzTFUyazE5dVlG?=
 =?utf-8?B?Rm55UXpIb0tSZGtZMmRXNXFtZVcxS1RSdDlZazczRDR5UjAzR01sbUQvc2VB?=
 =?utf-8?B?bExlUkdkUkVmYUZaUUwrdFBUYzEydVhEYVJNalFkTGdLY2VTV2J6Q1pNZTFi?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2913053171413D43875BA3BA1BCBCA79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b904860-4db8-491d-853c-08da8b5fc120
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 14:47:40.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2R4uuEt2cvSiG4UmEozTceq+Gd1yfDXj30P+zunbUbJGSSMbL8IgmLoXS2EAkQfwnYV8MCXpkEbT7uEhae26D5S8oSp0kE9LaQR2PhW033s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1770
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDguMjAyMiAwMToyMywgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgU2VyZ2l1IE1vZ2EgKDIwMjItMDgt
MTcgMDA6NTU6MTcpDQo+PiBBZGQgdGhlIGdlbmVyaWMgY2xvY2tzIGZvciBVQVJUL1VTQVJUIGlu
IHRoZSBzYW1hNWQyIGRyaXZlciB0byBhbGxvdyB0aGVtDQo+PiB0byBiZSByZWdpc3RlcmVkIGlu
IHRoZSBDb21tb24gQ2xvY2sgRnJhbWV3b3JrLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdp
dSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+IA0KPiBTaG91bGQg
SSBwaWNrIHRoaXMgdXAgdG8gY2xrLW5leHQgb3IgZGlkIHlvdSB3YW50IHRvIHRha2UgaXQgdmlh
IGFub3RoZXINCj4gdHJlZT8NCg0KRm9yIG1lIGl0J3MgT0sgaWYgaXQgZ29lcyB0aG91Z2ggY2xr
LW5leHQuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQo=
