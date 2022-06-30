Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6BF561656
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiF3JbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiF3JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:31:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596B42A33;
        Thu, 30 Jun 2022 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656581467; x=1688117467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TSADhyDNrUMxaLccrDPXKc7YX1hwRNE+O2ABLgCj188=;
  b=xKn42/4FM67xd4OSMtQiBSFjEv94R8uDYlb7miJ41B13Whon2/Dbozoq
   wsRs2PCiUaHILDnZLPQVXmsuyDygCKWSHN3YlNTCQISdH9gbUFF2xM8ew
   qI/+g78aF+k6LqyvIPBMzI+DWi/5KCd0wqy9OLh41VCgrH4ots7wfHlLY
   HaAsyE8EePif4RuI0jkqVrO65ai2m4sd6tctFcKGcJHSrUSPcHwTEsZsN
   5N2rL7ly5BUlTpXjQPfdSmCSdSuTh+rxjPREKj2nP9yN8+an6TTy5m3z0
   Kn4Mxbyj0ism/GJDDvLVOJFl8v6mT9C+fPhwz4ZjdxUK5kwRNOGkQjlY6
   g==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="102443719"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 02:31:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 02:31:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 02:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoLQwvuQemORCNxQOdXVFD9Xc3gvh/bLE9d5n0LA4X618W6tdO9ZzRj6Uj67hC5FzGE+BB2MFODKIKusyx+3tAe3bfy+o19AyB2jxT57mOPFQK+FPYt9TsUXSeWIyd7aieqgEZVDyOuwdXH9dItVaKQ6kIzRan8LoTgpNZD8WWv7qpFKnpyJZc4oy5E9R7rHxMx1DJucwpYDyLZxnO3Vcpdtek7Z8/JemvKFSABllPr2UP6Uy3QQvzogh0eeqB+sZveI95+nHzT2xfXIYykPpIapaKbf0Vkn0J2dXvFE6GdRBA2BS/JYRAXgi7apqJSeOp8kqHeBUMMhVSrUgOxrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSADhyDNrUMxaLccrDPXKc7YX1hwRNE+O2ABLgCj188=;
 b=PB4YFYz42aqCEf4124wOBWpWi8zutR8hTMGHsl2QsnPyyuSUxuXO3g7pIsoz8rcD/CELMMp96IrFx5eTg1Bch3esfKEqDBhtATLM3qg3rY6YFPJp51GY+I9vamxAonZDP7Q0fPsNfFqEyFfG5kKkLNJX65mb995W95fcEGmadrtZ5A3DqwbgUxB67gE0TTcr9cJVVi87LdoNZoR+0LIdtl3hB2YQkSYNgnTqb3GltNxGPiqZIiLxnRdctYtHOGOGw6dJ6lF/Lq2y11JAfC86+XNL5kvPKa2q23QvkRy7MYb1XnHQrZue6/4ZJQG2hAg7RYqF5v8Mw4AcGB0iQOoLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSADhyDNrUMxaLccrDPXKc7YX1hwRNE+O2ABLgCj188=;
 b=GK8AI1XKZzWGnkOg+miR/cXTO6XESlB3e6nmeILzMNIW7Rq1xeDT2FCwZtbji0eiGuraC32tr14ZgM8qO6Nl7/xLyD7UUZE6HkPjlq0keAhOiG2QIpYNuGdKLmygU1viy4xgil0+UWwwyt++D/kpPjAlQBXOVjV5pRthN/+LIvU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR1101MB2346.namprd11.prod.outlook.com (2603:10b6:3:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 09:31:01 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 09:31:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH v3 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYjGQczvHUBB3ZSUK+kufNmUYamw==
Date:   Thu, 30 Jun 2022 09:31:00 +0000
Message-ID: <f4f14941-6839-5691-b2d1-adb049118a4d@microchip.com>
References: <20220525071036.223396-1-herve.codina@bootlin.com>
 <20220525071036.223396-4-herve.codina@bootlin.com>
In-Reply-To: <20220525071036.223396-4-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07c506aa-6677-451a-10a6-08da5a7b3ee8
x-ms-traffictypediagnostic: DM5PR1101MB2346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJ36z1pVggoJBrohak1Are9JRW5rd4Rz+ZxjguxIfbnOLAtbte163S7umf59tfthQi6vo9hQ3I1ithWyVO54dTBmwTVax21/25GRHZ9pj9bzUceIR/UocMLTXM5BfYvHAdeH4l+cqrEJw8TFegQmGXUhTF7FQdhxKVIHhcuZEm8fS36t7IVTbh4P775CGnHf9C+d1GSu06Qbre2PL0akg7x+uMz4jkjKylytRlZIrZpIQHvkfOtoJpotIHGNwWZBxfGQonByd42EcLyoPQINt9ZB8jt1Rohbp3/mrafQz3lzvFoqkKXTMTaFrXRNg1SUYuGGyXccW5Y7GVCdLnl3neI/K+srS6oUK5hw2aVGpZ7OT3LYoHS2q1FHJMhdi551ArAiPjns2u0XKBT5vnmLwt/dbn4hVwjTlEznxdcw3E/QvtUdIxpM912tyg+nGVCkZMva0/zYeQOK3D2WpW95Q611ZmrHnzmX0RFKlV1YPTNrXzlRQv/1ZdHWxmwOoXIzjQmCi2GywzH3ZXpw/DTtPZXSzFhUmLPkrAYd/S/jLbOIQksi3lYakWPkPV2+/obCANWuyY0kxHLUJN60rVU28Svkxk9vyUriCIe/D/+jgCEOAo4Pe0UvS9cbmu3k/VUZqR2FrB08jOHFwS8udNH7PThy/4xsYfbe7PD6OxuhPFXDXnmEj0VZmW7NcMjYEuEse+hkdA0WU3FzTwM6jswx1rcjxuF+WHRNhxBJGS942G32pQT6HgACZ178NohAKZNT7OWrLw4/UIiB/4HpcpKby51RNX0vZ/0z64P6mi194m7RTWCk9wuLU2WnMjt6Olm//5gSU4R+UcHpZneRXaWEnvBNHfXulxI1FSaO5ngbP0qtLlGCFxJPNqGFdiKyMPu3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(4326008)(66556008)(54906003)(38070700005)(5660300002)(38100700002)(64756008)(66946007)(66446008)(316002)(31696002)(122000001)(8676002)(2906002)(6636002)(66476007)(76116006)(83380400001)(53546011)(7416002)(91956017)(26005)(6506007)(6512007)(8936002)(110136005)(36756003)(71200400001)(478600001)(6486002)(31686004)(2616005)(86362001)(41300700001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWtOL2pEVWViNHlmcXJkczVjWnE2aG9DVGVHOWhPOEE4cG9PdFA2RHJQZ0dq?=
 =?utf-8?B?WEovdklmZ0wzckJtNWxjMGsyRWx5Qi9BNDBEUTd0QWxNY05iVGlBMUhnSFhR?=
 =?utf-8?B?clpsOFgybG0yZElMSHZMbmxLVnZVZWlacGxFQVd0OTJQeGVPZmxsWWt1cXEw?=
 =?utf-8?B?NGVLNDNFN2hCNDJNZkhGbEdhK1RscW1qTjhYN3hUTk5CbE43NkJvcW5leVZr?=
 =?utf-8?B?Z053OVJGSUR0UElxQXI1M3cybDJ2YjdZS1RMblNxU09JZWxYeE5sUmVUTVpo?=
 =?utf-8?B?Y1o0eFp1aXp5WEVIeHo5WVR5Y2J1RWxlTFI3dTJiQVQ4cVVNZVVyb09pdjND?=
 =?utf-8?B?eG5XamhmSmNOZGFoUU45UVU0YmhESVhVRmM4RTFCbzg2T3VzUzlRaWlCN3dY?=
 =?utf-8?B?aElpN0ZodnVkamxPbGZuVStYWDFWMjlYUXZydlZUTzZjZG5wT1paeGFncWtr?=
 =?utf-8?B?dFFFS3hJeGNzZmFRRHRtbHFKT3d0ejZrRFNYNHZ3U0xqcVQ1bU9aWE9lNi9p?=
 =?utf-8?B?RTloaDBZRll4bUNmZ1JKcDdManphYWVNTDViYUlVYkNRSEZXWkJOTmc3MUlk?=
 =?utf-8?B?TmlVdnlrOWxNYk5SRm9WRUk3d3NFQW52MzFKWDR6M2M4UEkrRDJmK3AxcmhV?=
 =?utf-8?B?MHNucjVaU0R2aVVhUTBocVVXdkNFMW9XTFU3dkxYS2ppK2JneHpPZ0VrWDJ0?=
 =?utf-8?B?M1hjM1ZTVy9nK3ltY2VUWVVmZDFNd2t4RC9HNjh5UitJZUo0VUY3VDdlTjFj?=
 =?utf-8?B?c2t1THliaXpma01WOWtXS0hCSHllUGo2YU1FTVdJYU1yTEFSYU1mckdtNEw3?=
 =?utf-8?B?YXc5blRSeWRZNDNZQ1ZOVndRc1c4S0tCODNaR0o2VDh6c1JYRHI4cVdlemJJ?=
 =?utf-8?B?Ky9MQ291eDdmZVlsMGdva1k1TkRLaDZielUxYUMxT1FFVUJGUStRbzRmSDcw?=
 =?utf-8?B?a2lGWlhOMkpxdk5aTndSSzZteC9vZ2VpSUFGVUFyN0p5K1I3UkFxOUJyOXl1?=
 =?utf-8?B?cWlCQ2VkVWhFQ0lPdEFidGhTWS9tYll4dVFyblcvemNxblpVYjZzZ21oVmFD?=
 =?utf-8?B?QzFHU2t1ODIvdzRNaDMya3NLVTBRRTIxcklRRVNlVmN6YXE5aC9yZ3VDSXZH?=
 =?utf-8?B?TGt4cy9sa2NpbUlwVjVMQW50RUF4M3ZmbWIzWW1QTzA3bU9qTDNVV3NNdi81?=
 =?utf-8?B?RG9uaGVPSlJsU09QQW5UOVk4RnRJclhOSm4rZkZmOWdzQ25USFphRjE0Zytr?=
 =?utf-8?B?V2h6ZHlhZmpxOU1jbVoyMUx4bGNYUXRhZXM4Mk02aVppVTUvZE9hazJUc2N1?=
 =?utf-8?B?SkxlUWU4VzMxRy9WQWVkVkw1SFd4MEZvT3BhUVVvTTJMYWRRQXBxWmJRTlpO?=
 =?utf-8?B?dEE0RlM1WHcrR3VuTUtCc1c0U2VLMWMvU0xLSlZ3TXc5dHdmQVk0M3RCaEw5?=
 =?utf-8?B?S3NNWkRacEVNWmxWU3VkcjhsRjhpVVZDNFNtU1hXbGF1dUNWeUo2ajdZdUJl?=
 =?utf-8?B?cmJ5d1d6ZE1wa1lDUkVkLytJNWZWbS9YdU1HeFJLaGVaNWhiSXNGcCsvWXc2?=
 =?utf-8?B?elVrV1BvaGU2a2xpZ1o4a3pobXh0QUhWUTR0SkdwbXpMaFU4OHhXdlQvSUlP?=
 =?utf-8?B?QWl6MVJPWnJvdW9ycDB0SHovMzVoWlg3YytiaHhLWjJPbjV3MExqMDRIOUpY?=
 =?utf-8?B?TGtJU3JlS3dzSEVLSWN3UndzZjJodjNIZktVUVlLZk00VmdhUHA3RmdHUWFu?=
 =?utf-8?B?SXNUQjViWEE0eEhFN1Z1T1VvL0hha1RKanhwL05UMEtjWmNjTVZBZ3hpNDNS?=
 =?utf-8?B?QjhZeUQ4RU15ZlVHdVExUG01dFZSVmZpRlpWT1pVQUxVZlVCNFU3bWNmUGJD?=
 =?utf-8?B?ZnRkRkhrT3JRa01GRlEvbUowSXVUVHNiNExqQzVSb1BmN3dmUCswa2lDU3Z0?=
 =?utf-8?B?Z0Nxa2d4NHJPdkpUTVd6NW5TSGRDeDF2ajdHYjgyYllYc0NoWjN0SHRnMUVC?=
 =?utf-8?B?MHQ5M2pDazc2N2hBT0xtSWQ5YnVRbDZyVC8raGRibW9VWFBlY0ZyOWVRVVI4?=
 =?utf-8?B?YXVyUXBGK1QyK3Q2MXp4bXBjU3NtWlc0OHliUTNaZGYzRldXR0V5OHRXMVha?=
 =?utf-8?B?eW1xYTZNZ3hOdnRnaWhzZmgrSlArYjZ6ZTFxWmNyUVYvN1dIZ29ZdlkrRVNB?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8465ACFDB5DABA458F7FC8127A1E78FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c506aa-6677-451a-10a6-08da5a7b3ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 09:31:00.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZ1O7yUU3ROZeEYa9WlTrl4a0P1GWXT08UwqIBUFOhtG8UrUYQES79IsZ5Cw5vQqVkqoacHrZtXSLcvGRIVBQKR4TI1TmTUrVU2TdIhv0VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2346
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDUuMjAyMiAxMDoxMCwgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBVRFBIUyAodGhlIFVTQiBIaWdoIFNwZWVk
IERldmljZSBQb3J0IGNvbnRyb2xsZXIpIHN1cHBvcnQuDQo+IA0KPiBUaGUgYm90aCBsYW45NjZ4
IFNPQ3MgKExBTjk2NjIgYW5kIExBTjk2NjgpIGhhdmUgdGhlIHNhbWUgVURQSFMNCj4gSVAuIFRo
aXMgSVAgaXMgYWxzbyB0aGUgc2FtZSBhcyB0aGUgb25lIHByZXNlbnQgaW4gdGhlIFNBTUE1RDMN
Cj4gU09DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwg
MTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDdkMjg2OTY0ODA1MC4uZTA4NmRmNzQxZjk5
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC0xOTYsNiArMTk2LDE3IEBAIHdh
dGNoZG9nOiB3YXRjaGRvZ0BlMDA5MDAwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAgICAg
ICAgICAgIHVkYzogdXNiQGUwODA4MDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2Mi11ZGMiLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtdWRjIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MDAyMDAwMDAgMHg4MDAwMD4sDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweGUwODA4MDAwIDB4NDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDc2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa3MgR0NLX0dBVEVfVURQSFM+LCA8Jm5p
Y19jbGs+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJwY2xrIiwg
ImhjbGsiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArICAgICAgICAgICAgICAgfTsNCj4gKw0KDQpUaGlzIGRvZXNuJ3QgYXBwbHkgY2xlYW4gb24g
dG9wIG9mIHY1LjE5LXJjMS4gQ2FuIHlvdSBjaGVjayBhbmQgcmVzZW5kPw0KDQo+ICAgICAgICAg
ICAgICAgICBjYW4wOiBjYW5AZTA4MWMwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImJvc2NoLG1fY2FuIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmVn
ID0gPDB4ZTA4MWMwMDAgMHhmYz4sIDwweDAwMTAwMDAwIDB4NDAwMD47DQo+IC0tDQo+IDIuMzUu
Mw0KPiANCg0K
