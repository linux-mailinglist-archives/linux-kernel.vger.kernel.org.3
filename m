Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ECF5814E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGZONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiGZONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:13:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B782AC7B;
        Tue, 26 Jul 2022 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658844813; x=1690380813;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+eBThhQ+1aYdYTeZdDETVPmcrYNVt4uY/a2pbMJ5eVA=;
  b=IXRo1aD3e0xJ17ZarZ5bSiLQZUp93rfMZRY0ZNyc7QXQnR7einOLzw/h
   8oJOkvIQCo5ddwILzi24cHmIQ/1sQTHRhFWbuG4NYwaDEg2Py40l1rO38
   oUSKJ0mnEXFe1EO3eT5desRYyZtX4Xjq9Pvcw1Da1EHGDcPuqRV7NMk3A
   HhyNiP5Iu7GCOCzSI12p7RXkVMTwPp1ZIPjJwkwXL6F2ViX2Q4kz2j5oJ
   e0T708paTZI8AZLDJ6U/I1h+Jm0/0j0qp0Co3aOnMfEPAKAQa4piIzLZs
   AlYenQu0VX30dY+Bd3DwaKEzS6ObIvNfJEDL/C4hbauUHHHvVkzrYg4jt
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="173850958"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 07:13:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 07:13:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 07:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRghZwq8QI+43KqZUJoWyAelaYRjE/ugwtA0SsVOx43xy0yaT57ddymQ1VyPTopTIFAjIVT2vnmzZfcIvNxnXBEHF+jX0wMcHmbHm3uc1sZiP8FsvDvD1XXWc8Nzvau/vCpaogPXmyrQ3iCbFvedqs8hfwn4wa6JJHB7GQOlG5Mi65zJ2adOBr3bv+xICmpfFuHLoNi52ui3GtnwcS36+gVzBibvThwlqmDwKxlQkIoGZMYcGvgAyFMLF2iu9S96fbW8LQz4SpyoD3MUNdOygVpvV48ykEh7rv+mxa+wgMQh/Vo9M6RsTSO1lGBaXzsGHKLhFe/oPD0IHd9NR+bOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eBThhQ+1aYdYTeZdDETVPmcrYNVt4uY/a2pbMJ5eVA=;
 b=RS40cprHcrimVYLaIMY2keEb/S1M1+VYX34b6+iAoZsQObg7BCVBm0SEnwTsIcqErx032vRFL2mTvOiW7J35ETJW1aHHzd2cTsOsZxXZPdyyUlYiZCCOCM7OhbAerV455lHoVFTdDJ3Hl7eM1XGCbWrDJjiuIc5tNW46Vd3d9fVBBthlJHT6oh6ZjfF1WUAAD3uGT5UP0pak5It/k7/YtZ6E82cEIcJJFzw0Po7UGky8vJA7bd7Gh6VW90olvbDatjJ4VHq7yVcFwzvQ81V/KNSFRu3QeZEumiinRAv97mS80cRRn16p58lkyJRyvn0Pb7aBG60Rq7XsMJcbNSF0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eBThhQ+1aYdYTeZdDETVPmcrYNVt4uY/a2pbMJ5eVA=;
 b=ox4L5uC5bx5hq1GJVI4S1INOq/eTXb+Nmivl1DQOSr1uNA96NSlgkoqQJ2iHIjB+ogUwvHXoez3p7OzA+yzk/N+rBAosz8jiVPl4QtYNXAU/QpTBV2/ObQd2e9reBSQuw9WiNxPSGgOoavka0seHkyvcceRQFEsgXB+CsNYWr90=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 14:13:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:13:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <nsaenz@kernel.org>, <Conor.Dooley@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Topic: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Index: AQHYoPnfq1pijnAHw0SCV6iarEQwfA==
Date:   Tue, 26 Jul 2022 14:13:26 +0000
Message-ID: <27caba7a-fa5b-1a89-1204-577dd84ecc4b@microchip.com>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f9211b3-2de0-473c-ff01-08da6f11022c
x-ms-traffictypediagnostic: PH7PR11MB5944:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?eWxFTlFmWXNmZUJITk54MlJlRy84Y3p1SzFVdnQ2Mmc5clZoUVk2RDJmcEgr?=
 =?utf-8?B?My9iWUM5TTAwZ1ZBd09LUW9uaDZRcWZGeHdoWlhkZTltWmhVenpzS09RV2o0?=
 =?utf-8?B?bUJ0UVY2MTVNWXk5S0dFcGR6MVplMUxCd1BTL1VyRHExeThtK0lMbWNZY0x2?=
 =?utf-8?B?L0lUWDMwRjQzc3IrMFB2NDhFYWtNT1R3NUhrQnJ0SUoyUnpEQUkzbjR2ckFI?=
 =?utf-8?B?OFBGcS9ESjR0YUdUYjQ4YTJTbFVqZ0QxR2UyVms5RCtmeTZCT1czQnc3TVRQ?=
 =?utf-8?B?aGZqWDh0M0grUVJMZ2tOeFowZ0srV215L0hKbDFLOWVPMnN5NGJiazVSNllL?=
 =?utf-8?B?Rk4xakQ3U24vcEJrWUR5K1lxQkk5WmZXeTEzeUtqSXVodWdNODB6WHNqcXJ5?=
 =?utf-8?B?WE05U1dxMXU3L3ZsWnE0Ly9CRTVNdWhlVWU1WHRtdm1meDFZK212NWZLb1Nm?=
 =?utf-8?B?M1BPRFlNUE9adjBuUW1oNW5yNlJ3MUNEZUhEZlVpK1diUDB2SUZxTExzUGZY?=
 =?utf-8?B?eEJLT3pYYzc2SVp4U0ljWmxmNnorSHNOS3Vpc2dRRVdJQXNLZG5JdXBhRTJu?=
 =?utf-8?B?OWQ4OUZzMk1OdzJuVzNMZkNMRXRNdzBwbk5BTTYxNkVhVWUzclByVG5oSnFQ?=
 =?utf-8?B?Zld6SHZsZndYZDh0anh3d3JGa3RNOXdWYlpNeGl6NmM1RThYYi9KcnFUN1dO?=
 =?utf-8?B?WFRzd0VEQmk2dzNxTEI5SFlqV1RjNER0YkRlbUsvdHNOR2k4VHcwNWNETWp6?=
 =?utf-8?B?RzY3d0tsazNMNUhySVU0V2MzM2JUQndDcDRDUnV1U0ZxN2tyUThuUi95d2RI?=
 =?utf-8?B?ZDdBUHZ3N3BQMHh2K2xkeEQvUFZicC8xSkYya0RYc1BZczlIckhjMk4vWU9k?=
 =?utf-8?B?YzhnWm8wYTVNK2RnT2EvOTY0c1ZOYnJYby81Y2IxSjhad3dMSkhoTXQ1Q2RH?=
 =?utf-8?B?UTcwSkFISUg1dS9hTmxYUThiVHovNDJ5VTEwcVlvRW5tS2kyTXdnZGgvbUlE?=
 =?utf-8?B?dkdUbFlZMStMclVPcGFrOG1uNFpTQUtialVGU2NCYlR1dFN6ODBzTmJsNlht?=
 =?utf-8?B?bk9PcDIzZzlIbnh5Vy9ubEl6TzVHaVZCZW15NWVlVmlsT3oreWk2L3BLTHkv?=
 =?utf-8?B?MkI5eWJKczhaQUxaWVhsVXFHZVpQN1g0MnBGWm5GOG9neVF1Z1hYWkNXaUZU?=
 =?utf-8?B?OHVrS3d6MFViWlV2MlFaaWVKdTF4SmdLaW9uTVhkSnBISGhhTVpUcG9sZzJT?=
 =?utf-8?B?T0R2QjEveXgxMmhhbGY0cFoyenZIbFhXZ2MwMzltelV4b25tQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(921005)(91956017)(83380400001)(66446008)(122000001)(186003)(6506007)(38070700005)(110136005)(76116006)(66476007)(6512007)(64756008)(36756003)(8676002)(66556008)(38100700002)(31686004)(316002)(66946007)(2616005)(2906002)(478600001)(5660300002)(7416002)(53546011)(8936002)(31696002)(966005)(41300700001)(26005)(6486002)(86362001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ZxajY0cUpCcWpjOVh6NVVpV3pGcW5ITDVmOGwrS0ZFbi92L0VtUk9RdDBl?=
 =?utf-8?B?UW9haUxOTXRKN0IvTW9XMlV5Wmx3Zk1sWWcwNWtJTmNENzdwKzEzUXRBbStt?=
 =?utf-8?B?c0RVY2dyclZjeGx4U2ZmQS9yWlNBOWpvQm1YOFJnb3ZSY2tRbnNCWUtEcjQ1?=
 =?utf-8?B?Z0tjZkpMUjNXTTZwVnpNWko0ejBnb2RrUURpWGhnVjJLMmFpeHh2UUF0V0Zv?=
 =?utf-8?B?Y0VsczNaUVVwOWN3UWZ1T1FrZkt4dVdPZXBIUWtCSExtWmlLQVdPTTNhSkJw?=
 =?utf-8?B?SXpEazcwY2FYNjRFQk9GUWxVQU9HeXdVSHhPa3BjYnZqNm1mZXNnTkZBWWxH?=
 =?utf-8?B?LzB2WDl4cGVRSkFLNFAzV2NkK3ZDS3BJS2JaV2lsUVQzMHFiOW03bGFXZFov?=
 =?utf-8?B?RUY4RzNVbU00VklmV0F5S2VzZTdDRU5jd2hzUXZ1U1JpU3luR3V0anhqTE9t?=
 =?utf-8?B?Wk93TmhnaXNpV2o0WkwyRVpHZGJJVHdmbHFTN0FlMGdSc21uUmtjR1JSU0xC?=
 =?utf-8?B?MWN2b29CSk5zbmdWSHFweGtZNmxjeVkwdXByVGJ6SGhJZjdxNm1mVlovektV?=
 =?utf-8?B?QWdRNHdERTEwSmJMUC9KZ0lCaUhOWjhzNXprdzd1aU0yd0xqUy8zR2IySElY?=
 =?utf-8?B?Zkd2bWJPYnRQUkxOaTdVYUhDc0U2QXpTRFR4Y1R0VldjTk5vdGFybGtRT0RM?=
 =?utf-8?B?eWJiTW5hZ3Q2bTI0QzBCL1ZTMTluMm9MK3ZKSmFwTjhlSUVnbTFZTHpDQmVq?=
 =?utf-8?B?WkFpUStYUjRwSTJ3alh3bUxqekpJUWZJVVFGeDMvanh5NlNnYzArUThmeFpj?=
 =?utf-8?B?ZGhManNnaEpHODNIK2RRVGY2dTlJTWU2OVdodXhDMGJHdHhpRGJHNUJnajV2?=
 =?utf-8?B?RWhyTkRaWFBJUER6cTNHL2tLaHpQSytFWk5ESXVIdnV5SnhHdW50Nnc0UXk0?=
 =?utf-8?B?TDZiMHg0NmNQNDJidU1zSFgrRVh6WWdjZzZuNHJnN2pWa2kyd0lrajlJT1NB?=
 =?utf-8?B?UWZpVGozcVJCVE9DeXRDcDRFQVMxQ2ZIM2NNelpBVEx6NUFsSVdjUFdWM0Rj?=
 =?utf-8?B?cmppYUtqbzVwVnh3THlBMzE1VXkwdVozWmduZllKdG1Lbm1peWFMZ1llbGtC?=
 =?utf-8?B?U3JSZU9tZGZrV05tVkZ4YzFBT2p3Rkh4aVc2KzM0cHl5OE93OE9DZDJ0T01o?=
 =?utf-8?B?VjRyV3dTRkFZY21XbVFUM3I5TnJEa3lTbUZxaE13S1BwZWl4ZHdNT1lIRnNC?=
 =?utf-8?B?MTgxejJVWlNYV1hwRjJXQ2RQeGwyM3hzbXB1ckZXcGMzMi8xUERlNVZCcWx0?=
 =?utf-8?B?cjZhTGNlenpTaEcrOUFDYXdFVmExWTlqUkJIK05ZdUNRYlVYdWVnVG92MmpC?=
 =?utf-8?B?Z3Bqb2JNYmh0bE40N2R4WnNLK1VGMzdpeFFkWStkY29SK2o1eTREUllNOE5R?=
 =?utf-8?B?ZTNOU3NWS3dzVXF0VGtHTkJ0WmE2T0dUTTQ3citlNmo1ZnJrSW9LbUxuSmxY?=
 =?utf-8?B?SjJDUXVvSEt5cktqNFZ1RkpsZFcxbURzcXArYUpJK3BsYThQQUhnRmJtVnI2?=
 =?utf-8?B?OUpKYmtBemR1U3h4Z1Aya3FCVUFxZDVXYXNxalJndGRYQ20yR0ppOFY2eTVF?=
 =?utf-8?B?cmxVQ0dONHUvMlFYRmtEdWNLbUNNMnMvVTdKYTg2N3R6bGVtU2VRZFNzYU5h?=
 =?utf-8?B?M3o0d01LWElyMXBGSGY2WTNUc3lkeEZxck5YS1FNZHFNa0JWd1N5WGsrZW0v?=
 =?utf-8?B?dlJ6dmhmWHZ2OGh0b0w4SjFqTHNxMGdhdGdKTVhoSWdrRVpZNVhtcTFhN3JF?=
 =?utf-8?B?a21RTkZwNGVBTjc3eVQyMk5PVU5pUkwydzRKNnc2dGJFT01ZQVo2d0ZDcmQw?=
 =?utf-8?B?SGRVTDU3V0t4ZVBZdlN3THd4aFdkR3dVZFpJeWJRSVBQUmd2Y21qSEhzSDE4?=
 =?utf-8?B?KzBxN3JNdDdnazl2NmorZ3VheGc0dEYrUHZIZlduNDQyNnY4dC92VGx4UWFZ?=
 =?utf-8?B?dE9rK050RXkwa2t0VHIyK1dxY1VhNkt5dll1UHFOc2NmNVhLQlhtTDNoL0w0?=
 =?utf-8?B?OEpYOC9LYmtUem9QKzY2dE9jV2VMbkVoWHdDaGZyRWpXNDJGK0hTZTdhZTY3?=
 =?utf-8?B?L0I0dFIwejQ0eDRPL29pYjA4QkNwQTd5bENqTTY4eTZrTkRNSHB0SE44Vm02?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8959999E51AB40449C3C0AAF03E1B764@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9211b3-2de0-473c-ff01-08da6f11022c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 14:13:26.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaSfvnnzPcR58KJQu+ZG6UG/KM1z53YgQ2eRtWUg2hTj2ki4lhjp3ZQs3E0YbIYuWIrctJnwwJMZXiOKpmCjpeFICItpAGGHcv9Au6Njbqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMjAyMiAxNDo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJZCBhbmQgc2NoZW1hIGZpZWxkcyBk
byBub3QgbmVlZCBxdW90ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAg
Li4uL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbCAgICAg
ICAgICB8IDQgKystLQ0KPiAgLi4uL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1w
ZnMtc3lzLWNvbnRyb2xsZXIueWFtbCB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10
Y2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlw
L2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gaW5kZXggNTk3ZDY3ZmJhOTJmLi4yZjhjZjYx
OTE4MTIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10
Y2IueWFtbA0KPiBAQCAtMSw4ICsxLDggQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gICVZQU1MIDEuMg0KPiAgLS0tDQo+IC0kaWQ6
ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFy
bTkyMDAtdGNiLnlhbWwjIg0KPiAtJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIyINCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55YW1sIw0KPiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+IA0KPiAgdGl0
bGU6IEF0bWVsIFRpbWVyIENvdW50ZXIgQmxvY2sNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9taWNyb2NoaXAsbXBmcy1z
eXMtY29udHJvbGxlci55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbA0KPiBpbmRleCBi
MGRhZTUxZTFkNDIuLjA0ZmZlZTNhN2M1OSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRy
b2xsZXIueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21pY3JvY2hpcC9taWNyb2NoaXAsbXBmcy1zeXMtY29udHJvbGxlci55YW1sDQo+IEBAIC0xLDgg
KzEsOCBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBC
U0QtMi1DbGF1c2UpDQo+ICAlWUFNTCAxLjINCj4gIC0tLQ0KPiAtJGlkOiAiaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvc29jL21pY3JvY2hpcC9taWNyb2NoaXAsbXBmcy1zeXMtY29udHJv
bGxlci55YW1sIyINCj4gLSRzY2hlbWE6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCMiDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Nv
Yy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbCMNCj4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiANCj4g
IHRpdGxlOiBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQyAoTVBGUykgTVNTIChtaWNyb3Byb2Nlc3Nv
ciBzdWJzeXN0ZW0pIHN5c3RlbSBjb250cm9sbGVyDQo+IA0KPiAtLQ0KPiAyLjM0LjENCj4gDQoN
Cg==
