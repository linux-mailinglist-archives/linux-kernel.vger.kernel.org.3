Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A5560C77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiF2Wp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2Wp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:45:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497E2495D;
        Wed, 29 Jun 2022 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656542726; x=1688078726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GBYGUlXLO31uJF64XQvYoKdqFQXzCQLiH2F8cShKrtE=;
  b=FOTbpsxDwRNlxn7fGsWSafXZvnKYot1d1XlnUcbJLKUxzAON5W0LXgEj
   /+J2xmjAuG7Wt1pXzvlrHo6E6aEWKj0ZG/ymV1UupYIb31GChKR+t9p0p
   u1DE3cbUWU49JNXC21eGbV6706AEmem3J5Iq5OlMuMbuk733kZbxpE2Bg
   uHVgbqm8i1N7v8CVTqmYIAsC538ZweApBwFQyoerm0f76DLlXwO5onqEL
   PTYD8PKucBXM7k0BehVH8KmB2HgSi260K+mCwadgIm9/SSac3f9qq1UXJ
   /dBh6u7mwwEewfQAu3/1lMrQuQ2q7YU1CvxCbvsd5NARZfRkLe2KdCO/G
   A==;
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="170164214"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 15:45:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 15:45:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 15:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM4X4vtF4T3dU/08aflFhjqVn810cvOz2J1zE4z5U5xlu5RJkMWEDPyVfW3fkFKl0p5MwBKcE2jqionoeUQUr0seq+jNzQBsz4AqcN21q1gEkD6ADwxVh7QlE1iYYOSBkDe2qJF70Ife9z+PV6+k42a6Ehabe2UodYkpfj2KtDQ9PEFT+/m55mqHWF0i53AW73rpVvYCFenuTTJgQTOUXn1FQKLK4hO6W+5rX2w6naFSPwNdwTeWBugX6sQHl+pcZypJT7X6wmY4mdPV1amQ6VhyYrfezkIpMEOd/L8li+a3pyBLZVhjHSZDmqpM9pwUe5U8DzwldraS1wnz7Hiimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBYGUlXLO31uJF64XQvYoKdqFQXzCQLiH2F8cShKrtE=;
 b=SWNboiOffmpYsheoIchVxLZ9kWzj2PwSgMQezr8nPxQTN39LqoQljDaPiBtu+lFNKKKQgKZFO2klJRzHLlXGKTkKQ/OIVqPzjH2KeLFELGW7ntrJ0D8w6WcQpfsyFPm8iNZrXcMSZ8iiGB/nhG6gHvB+F3+6eVACAPozewuaH425R+sADh7u7H0/8pTWJxEbha2F089StnkD9H1+X1Np6/bDFIlydmVy4T8EtBwa6gmgs+OQYkDCopwNf9Z94JiKABhTYnv74ztFTLTpw41K1jHLKOWUfxQRAqWb78y54ofN7XNBn6Tz7tnQ/9C316QqzmB7b+3M58IxxWs7/FajQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBYGUlXLO31uJF64XQvYoKdqFQXzCQLiH2F8cShKrtE=;
 b=Qjp9UJjtyw+rlqhEQkHGPDXAq8WizhzMl1cmV8GR526SmK7QE6EEn82L6Aj35GXK/iY20kJVtf+wooQhn1NzhcIYNU+Pfm7Te2dTU0+J5hE7gs0HiNnLrrgWaB3HzSInDWpRe7EOD9HvChFQyy13DMSp8oxDSaTnggxDdktkxzE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1870.namprd11.prod.outlook.com (2603:10b6:300:10f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 22:45:21 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 22:45:21 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <Sergiu.Moga@microchip.com>
CC:     <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <UNGLinuxDriver@microchip.com>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYjAnpJ9RPijNCmEOYEPo+O29OJg==
Date:   Wed, 29 Jun 2022 22:45:20 +0000
Message-ID: <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
In-Reply-To: <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a075112-28fa-4ce9-78ab-08da5a210c1c
x-ms-traffictypediagnostic: MWHPR11MB1870:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taUlqvg5Gl2NW6Tg8pCFX9ABiFsw/oqCJI5kqt7D/4E4AKWwBcyyhRoZkyeuEpVCWEuSIh9k+Pam7MAO5oZ2fFO7j3I4AdHiab7U/a1d82lsK6KFxIhS9jBrGx6LDovXjU33sfynSed/kHw3s6z7O3fAzZmIXj6g+LZVnvffS6US1lDzLQ56PmAWsQ9SSVpwiECJrVKaveMnya+TD/4UEYaBg7/YXYU6zX7vnAycJ1RmQH5dinA5OUb24mG3X6P1fUgVsNbcnvTtOwE705RPo2LuWtbKGFHsYeQilzlF6CwnYalYZzq5Cq2O+z2BvOui3gX7UZaO/h/TDX0GGcLrvbVNTJdUx+mMVYpsre4anudeZUxWZ3Ga0msjnojqDvErZPMcgoQUqHtMLpjRHAhGDSr/h0eW7HPd7OEKatsBaQFkFVHdd8DBoKqnTdrILDeTu9oOZ7d/BcZhzkRxAURCW+BBKSYki6B8n0D/OMY2Uc+IM+tpkCa1HtusQWx0g0Cf8Ng3jQZEJ8fU8V+vF4wbbYidh1Cyq0WW2EYKZC56abCkm32pUmgclFkMNJCKwydddZ4qQ6llWyNwcFf14WWK+k+E5Rs0I/VFT8eUsAFdzhSWdVeVfDt4nq0o04ASq/A7F7zh+fG2LInYQOTH6/jP+1wCoVApCgjfGNbPRQ1pXJVUFnpt4v5+iF7utC73YtU3M/vC6PDArgIK0395fghVCf+6ta/EExB8JHWRUGmUOQe2M3pXkUOehc0BV7/qawYV4KR6TlEVhT8Zhtunj2pnXGjMAvLlTCYsL7Cxf31yONH+aEmbv10jb1zJ374bqsPFqJO+e600cgrIDP4gi3KZ/V6AF/gfu8pGTJkpLSwRe2fLwWAAg7J7ERqfz2qLnS3sOpNhP42M6Xae65sN/iF2kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(122000001)(6636002)(316002)(54906003)(71200400001)(2616005)(83380400001)(86362001)(38100700002)(5660300002)(186003)(31696002)(38070700005)(8936002)(110136005)(4326008)(41300700001)(478600001)(6486002)(966005)(66446008)(64756008)(36756003)(26005)(53546011)(8676002)(91956017)(76116006)(31686004)(66946007)(66556008)(6506007)(6512007)(2906002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3FWM042MnA0b2pkS3hFZy9FMUJyOWd1K1pwZS8wR0lWdzA0WWsxZVk4MUpv?=
 =?utf-8?B?MkRWZDNQUmU3RFdIWVpremFKVythazk0OHN0bmd0U29wL2gxSStGSG9RbW82?=
 =?utf-8?B?OHU3czdKMnB3K2RGa1Bxd3cvU2pvYXpiVXZUMDBxWllCQXlOY0NzSU15NHho?=
 =?utf-8?B?MEtZaC9HSHlIS3U2U3hoMklsNFRRREFZczJBd1FCR2FidW52eW5mOXhTbVpi?=
 =?utf-8?B?QnJjY1k1SmE3Sm1lYzRodG5zZFd0UTBmWVdNNmNrblFKS3pBMTFib1ZaZjFF?=
 =?utf-8?B?VlZha3ViNkdsSHpIZHlRYVI4QVVZeHUwSGMxT1lVMnNyS1VQRHh0aytVK0cy?=
 =?utf-8?B?akZzWG8wVlp6a0RVeVFPNVhGNWVTV2VIaVVBb2R2K2tUajlTRm5CdnZjMy9U?=
 =?utf-8?B?aFAwOTM4OGp0WUR0MEg5Nmx4SFZtNFc0dkhlUGtoWE1WK3lWaklHV1dqUG5G?=
 =?utf-8?B?RkdwbnJIa2NiTmdOTFFucU1mYnlxdlhZZjZsLzg2QUx5d29xMG1XdUNZc2hL?=
 =?utf-8?B?M0JUN1MweVJxaVRVdmxvalFoVDl4c2gyOE5mUXNDSDg2N1hqd2VWaElmbXE4?=
 =?utf-8?B?eTZaaEdCZDVsa2Y0cWpCeFJMN25URjgzbk91dXpYaGpJWmpFVWVFc1FUMnMv?=
 =?utf-8?B?bm5CTFVEQ1U4Z3o5dVIyWW9LN205bWE4V1J0ZHZtb0xScXJhSjZseWtzb1ZK?=
 =?utf-8?B?aUtaRUZHcXJpbUxwY3g1WnZjWlhDL3N0M2RiSlNDKzNod0FmOTR0b0k1VHo5?=
 =?utf-8?B?WVFCdndFelF3K1RQemhoWnloUHl6KzlITVBROEJXUGZOMm9PK3BFS2VNU2dw?=
 =?utf-8?B?UjhzVFZhdysyMjJ5NTMvdU5sSisrOStWb0VST3UyQmJXNEgvVXR5RXZmLzQ2?=
 =?utf-8?B?bW43RW05Mi96RlBONlRuYmtkZ01nUXRTWFJBejlWRlNHbTVpcU04cTVyeE9J?=
 =?utf-8?B?WkdkV0RoUTBKa2hQc1JSa2U2bURLZlExOFNxWnI1SFFzZGhDWVZCYVU1NmM5?=
 =?utf-8?B?YTZRelU3aEtTdCs0R212bzkwbmI4Z1dyVzJpNHVoL0UwcW1jSURndURiazhV?=
 =?utf-8?B?ZjlNTVZ3bWkzQzlQSDlHU29HTVZNcmFxRHp3bEh2SXFqWHBjK0hIUnJxU1dQ?=
 =?utf-8?B?VmRDTXFWK0lSNzZuL1BoSG5PMzZaWkV3Uk5Kc0ppS3RscS90bGVQZ2VGT3Fu?=
 =?utf-8?B?VGl2K3piQ3lieWhleDFjeEVaVmdTUHBRNU5vcnVtV09xZTkzZkVuUmZ1RG16?=
 =?utf-8?B?UGkwVzI4dWhoUEdDY3hwWUYzV1puMmM1N3FLTXhCUjNMRWpFMzlieTVvenNH?=
 =?utf-8?B?Y2xzMDZuQkhRUlhqcENNTmJYYlVCaU1mR040R1BGYWV6RlAxOERYVGpocmFa?=
 =?utf-8?B?V2tFd2xMbll6eDZYY1dmUnhvNkw3N2NsWTBsSkE2TEV6Umx5Z1I5UHZ5cWg2?=
 =?utf-8?B?Q01kcjZ3OU1OOXRlSkovcFZZMzRoVmRmOWtvYmw2ZHBYR2dGbHZuNGY0SHhS?=
 =?utf-8?B?dHdVcEEybmJrUmJHbVdPRlhJZG43aWNQUGhQeXpTM0xNelcyYU8xNkxZaTh2?=
 =?utf-8?B?Z0xISEpOZGdQUEZYaTEySHoyNExhZlhwMHVnNnRyeFh2Q0RDeFZXOW94Zkdm?=
 =?utf-8?B?WS9CbzlyZVBsMzYxK2xVb0ZXdFJoZndaVkNvUHg0L0tDaEN1TmpPV3d3M0cy?=
 =?utf-8?B?eDRJdDVtL3VKNmpTalJJMUpsQ21wcmw0NGdwUlBvRmVDUWYxc21JTEE5ZkFt?=
 =?utf-8?B?VTIyelhsWElFbjR4cTc5UUx6QW1mMkxwUEdTOHhHK0tPT2h6Y2h4VWxpWTJs?=
 =?utf-8?B?VW9ySXhRM0pxUWZFTHJULytQK2FhcEROdWtQc0pSUThEL1lSd0NBa1Fvdm9E?=
 =?utf-8?B?MG5BbWFtamEyZDVVSDArcWxvb3RVMnlvR0doR0U5UytWeVhSdDR2Q3JiNlZx?=
 =?utf-8?B?RHV0VnZ0K2Iwd0h4RGFzNnZ2bWlIMDF4eWdDMzJYMG9xUEY3RG02VDFSVTlT?=
 =?utf-8?B?ajBFRGxndzVmZ25yeitkTlBsbzhZMjBiZUplMHRjZm1IVUlDYzRqRVE4V3Nm?=
 =?utf-8?B?QTUreEpNM1llT0lLdUdPOFd2YVZKR3VOdkRoaTEySHYyaFR4ODE2dzk1MFBu?=
 =?utf-8?B?RTdtWXc0a2RDMGozaFlscW0xZTF4U3R6T2hEUVZpYWN1M3JwamZKbEdiZkIw?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45D8179A75F94F4A983FAABD7A7A8BA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a075112-28fa-4ce9-78ab-08da5a210c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 22:45:20.9490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeyGxuIzSh21LBB/aN+xw1+rRe12NUujIK1oNDTYfsEDLDo/7xxwh60BdVQ7aZxFBXKFM4Y1lbyvtvQE67iun6pYxPntmcK++Z8EVMR8VBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1870
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAyMzozNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgMjkgSnVu
IDIwMjIgMTU6NTg6MDQgKzAzMDAsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4gQ29udmVydCBTUEkg
YmluZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8gRGV2aWNlIFRyZWUgU2NoZW1hDQo+
PiBmb3JtYXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dh
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
YXRtZWwsc3BpLnlhbWwgICAgfCA4MiArKysrKysrKysrKysrKysrKysrDQo+PiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1lbC50eHQgICAgIHwgMzYgLS0tLS0tLS0NCj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0
bWVsLHNwaS55YW1sDQo+PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvc3BpX2F0bWVsLnR4dA0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBl
cnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2sn
DQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4g
DQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5n
cy9lcnJvcnM6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWws
c3BpLmV4YW1wbGUuZHRiOjA6MDogL2V4YW1wbGUtMC9zcGlAZmZmY2MwMDAvbW1jQDA6IGZhaWxl
ZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydtbWMtc3BpLXNsb3QnXQ0K
DQpNeSBjb252ZXJzaW9uIG9mIHRoaXMgc2hvdWxkIGJlIGluIC1uZXh0IHJpZ2h0Pw0KSXMgdGhp
cyBqdXN0IGFuIGluY29ycmVjdCBiYXNlIGZvciB0aGUgYm90LCBvciBhbSBJIG1pc3NpbmcNCnNv
bWV0aGluZz8NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAo
bWFrZSByZWZjaGVja2RvY3MpOg0KPiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcGF0Y2gvDQo+IA0KPiBUaGlzIGNoZWNrIGNhbiBmYWlsIGlmIHRoZXJlIGFyZSBhbnkgZGVw
ZW5kZW5jaWVzLiBUaGUgYmFzZSBmb3IgYSBwYXRjaA0KPiBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRo
ZSBtb3N0IHJlY2VudCByYzEuDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmlu
ZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1h
a2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+
IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVh
c2UgY2hlY2sgYW5kIHJlLXN1Ym1pdC4NCj4gDQo=
