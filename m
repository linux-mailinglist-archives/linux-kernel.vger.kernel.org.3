Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7356D682
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGKHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:15:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E9F5F49;
        Mon, 11 Jul 2022 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657523720; x=1689059720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bRFb1MB7yA+M2NuYQHywesm8w3o0LqRrEJct7qufTbA=;
  b=2IjeDTka8jSayVigREYgf1/m9TlhLg7bojZNkTShZmCAQo2OETKyU1PM
   0RJsKOsSFJ5n55+wtrpzR9UJ43OXNJRUTjFXSgmMWnWCC+R//9rlIjYMf
   hzeFKYmLtTBTUsFcqnDCXV7QAYkr2eO7DfM27NJmcm443QJHpDiFsZ8tN
   xN0ZzporAe/VAJKlhmPFJ+UI1nbo3KDEHBcLB4jBtYw8VQL9vGrkd+osp
   hWCQpEbGKuaBMrg4nm4s7vYJrUfcaErUZ1ax80d7v8dsvg0eChEacWFgf
   Ij14SaRGOesY4xkivMFZJ0P23IzrLdo5jp5uOth7K9Hj+CUVoLdEnMICc
   g==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="103872483"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 00:15:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 00:15:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 00:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df8g7pHTaCyhzjbNkbT1Wr5/pKzMDq8X4j8p84mZhHQM1dJagQxOHNJ7IYgZ8kW2K2yfDSx9lLDZVj2klf9CesQtGriMI3GvihKWtX1kAKlYU2WPBb0/I1owKcDvickQp/IFQLlWSwygNIWmPdwtG1b/3Dey9SeWAloHClff4BaYYxxP8TDJDTdcTVxF3nJYk0Ds8PMeMjfLyOercjvyqh4oWaV42Un48aKewJODeY6W2GdW/8klFyTkaTOtOPMIl18LI1S2Sz5A3Wt8pWro88Z1MDJLxZJGTgvwWH8iBx8ZRD2z/hUvK3IMlqJ8iLTiiatVFjbzkL/VFxSbn58VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRFb1MB7yA+M2NuYQHywesm8w3o0LqRrEJct7qufTbA=;
 b=MNjjnz99jLz9G9H2it40mZuz4ZnVk6dP+Hu3HO6R8cZr9D1d4L6S8D5SIpeMlWACh6y5oYVPiHLXquJtx0ugPtCgGl/bpEysBazUBMLczYJDNZsiKeTC8+arLyFLHefrk1sPEc2C2rYdU1iUDWOEeKZmDvbBs56UUeSbuy3WiQi/dacccUsap5T6OlOQ8J6ZpGrSbcbTgGvwt+9CAlj3w6SFMNHSDBv9voevNpveWS0yw2jnCe3ZeRNkf5rUoQ6JV94sNSMIt0+dItp82Rznj+jlJEyD6auWLG2KGuhH9kk9IqrHs8DEnFq1AoYS7dUDzYCG+zY0SykojiJicaR0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRFb1MB7yA+M2NuYQHywesm8w3o0LqRrEJct7qufTbA=;
 b=mnp7MMvf5nXwhmmJk9S6IIaRX2fPg7dJinM+UEee5JExXbmKTZMkXpOUehGbsiEx0M7IxnbuHwFgF/m4OlSNUItXOAhz1tGKn+jhp4tZSYsQMdoh/9sXDh8lyMc1/Ei2z5DqfqmwgXOpB02pC68iV3KSkv9vaKQaek8dgJwu9EQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR11MB0057.namprd11.prod.outlook.com (2603:10b6:4:6b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 07:15:11 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 07:15:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Topic: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Index: AQHYlPX1nrnmxLeOAUSFrDL+ar5dnQ==
Date:   Mon, 11 Jul 2022 07:15:11 +0000
Message-ID: <7ee463db-3cb5-c340-ac1d-1dfcd2b87dcd@microchip.com>
References: <20220707132500.1708020-1-michael@walle.cc>
In-Reply-To: <20220707132500.1708020-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1dbeba4-6968-4a54-6c5f-08da630d17f0
x-ms-traffictypediagnostic: DM5PR11MB0057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGLujYPcpTlI6nP7CnYVsTvlMxehzT5U7nxv8cPPQrEJ42Kzkli4YQCjhPsgzb8UAf/erZRAYFKvdzeqIjWxhh0vnIFYDaIJzjJzE2u4isV/yhA7LaigLqcQF5y1IqRWy24/q6Lf3ljja0urCWMJwQ0cNJHUWLBJIQvJ8bV2Ri0lHlQPKor+LdKsM/iFo/p3s3pBijMEpQtg53kHz5VAVOh5lhNigO+yhRELD8IkJM/E8BazweMGC3cmH2XWKaXNlpuNonc8Y0TsmweX+qkUvyPKfvrNHsJb+ktwP+mqzoMaRWTVLnIWeyBjn3FwrESdG4l3cA/C5kJzWt/HrjSUH2MT8fjBK78isom/Y2LjgN94LRN67b9/pMru/sONiFTswr+NMLBsctE+/zuZdVtewksZeEDh3OxlXSaaK9bQnyaaI/GVB/qLDcF9KlrgnZDEWQgE7KRS7ZUSckhczYWmUKWPD7Z5+MC4InIq7EMD08sEDchXZve0DKonrgJS6XcQPAYFjI8TAA3k4G+NtMCg1xWZdhuypduErguNHFRrTx1/ZeQQEXFFZ+lfiPKqiAIjRd+JUoee45j/W060U9c9rBcBLfQ4LbuoDJHfiTyuTwLaQo4HsQoPhGQr9+NZFWe/i/OmzH4TM3aHocKQX8ORvUX1rAVVtTCbuBVDQ4NFfvVH0kVhJyhkXh1lF3JWqorxKrTVEZ1XiOZ04x07FiX3tts7IjIAvrxNiQ2shqZCXq+MTPz3X08gQnVmrAAF+tsoxwry25z8e53PJeQMenSviLWMcRNBejEHJaKEFOgqgqzOH9N+LEkamY1walpeJcCXAJWNWFICdaN/eKxSEonsocNgBL6UmXrCRA3BaaFOBWtovSpblGcOD27Dov/XG6jmTgwq9rvI8QTov9mnpBqEJPCUr5HRMuNZuMoScBhlNAA7o5/9+y9XPksG7yiKApY/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(26005)(6512007)(53546011)(478600001)(122000001)(2616005)(5660300002)(4744005)(8936002)(6506007)(2906002)(41300700001)(38070700005)(186003)(31696002)(83380400001)(86362001)(38100700002)(54906003)(36756003)(71200400001)(110136005)(316002)(6486002)(64756008)(66446008)(66476007)(66556008)(66946007)(31686004)(4326008)(8676002)(91956017)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aCt0NEJ6M1RtTTZsbmtYanlrVWY2S05sZGV1VXQxc2VuYm4rNEc2dG1GZk5a?=
 =?utf-8?B?SVZBa3JkZWRZbGkxWTRpQXpVdVNsZUlBRE9rREtlUWRQRHVjOHRwcXZKL0N4?=
 =?utf-8?B?cUkvNEJVdnFGWTkvQWFWVFo0REx1RlRtNDRhcGhaZ3dscFFUUFFGb25zRlZp?=
 =?utf-8?B?QlJ0Y3diclpBYWlyRVVyU2x6Tk45ZldocDh0ZXFwd1c5eEcxaGVaZnNPeE42?=
 =?utf-8?B?SGZlbGhzSzJUZTQ0UnVRM08rS3Bwa1BoM2RBc1NTUEM2YVMwaG9BYkw1NW5H?=
 =?utf-8?B?Zzh1RUNJUUgzaEtSNVY5Vy9yR3FyTTJPazBSS3Q2Z2ZNdndjLzJ2SzJVT2ti?=
 =?utf-8?B?UGtTSGtLNVVVODB3czVlMU9TSzBYRkx2UFBFMnU4VStCbElxWndSKzdqbGNx?=
 =?utf-8?B?OVQybUpRMmZGa0xkbC9CL0lGL3I4LzRucUpWN0ZkZXVtNkJIcWhjdW1kNjQ3?=
 =?utf-8?B?ejg3N2tLWVRlUEhNRHBGcDUyT1ZpK25VNVdzd2JJQUdkUFdlZHI1cVVKN3Fy?=
 =?utf-8?B?WEFsb045NUtFdWJEQnJtdTFEZVRKMW80QVM5NGRFRjN4VTgvRWduNGpLdUxN?=
 =?utf-8?B?VmI5QlNOKzNnWHZOa1JYTHUwYjYrL2tkWld4endKOVZVRlRTWm9JUDRPdVAy?=
 =?utf-8?B?cnBBYkJOcVNXeXAydml3ekR2NW92UTNkaFp3SVN4aVA1TXp0RDQ4aGkvRUNH?=
 =?utf-8?B?YnFxdFJFNnpxN1VaTGcxNU5qRm96QWRzZVhBUU5UVUFDNVFqcVgzSHpXY3Ez?=
 =?utf-8?B?WXlhSjZJUkJJbGM4SmVuK1BLK0haRlF2cjlldEk5Ylp3QUhPelJJSFMrTHFm?=
 =?utf-8?B?ZVAwZzk4L0ZjS2RoaC9pZ3N0dmt5SGltdWVEMUpGZUpVczZqUzlXbEgvd2or?=
 =?utf-8?B?NUZhV3o5ZThpeTBCSEY4RXp1YXIrVS9tekJZYXB4WnVjVXF6QVgySi95YVU3?=
 =?utf-8?B?Y1M0WG0xd2ZSYnZCMnNPUmJqNTBSVGVTclVlUjNHNG9uNU5sckNtT2xCSE5m?=
 =?utf-8?B?MEd0NzdxTERNV2JiVjRhQjdlTituOEJIdzlhS1g0aDNpdGJpLzJIUC9yK0dn?=
 =?utf-8?B?MDFFRUppOWpTVFdJZjdacE56eU5RVWF1MVVlL2dVeVJjdVV3bnNXSE9TbDk4?=
 =?utf-8?B?WTBYUnR2aFMxeFQwWnN3OVNnM2tpSjdhVUsvcmtHWEdUNVoyemlIVXAvYzRh?=
 =?utf-8?B?cmt6SjhucFdHYmN5dzhjNEd6UWJrd2ZVZ2wyR3RuTFRJUXI1L0RkSW5ySnhF?=
 =?utf-8?B?bTVZeEJQZ2tOR2VOMGN4OFlLSklNNms0KzZ3Mlp5MHZYRmhqV1l3RG9PQ3Zt?=
 =?utf-8?B?TWFiTHJnUzc0bFlRNW9kZitQcDNoN1h0S2ZBSEdDQm15VDJYNHcwaUI1WXBR?=
 =?utf-8?B?Smpla05xRXAyaXdnSEhrVmJYUWdkOWR4ck5HdWoxSVpYaWJJS3lkam1EOWww?=
 =?utf-8?B?OUFkSkNHM0JnR3ZvTzI4YWVxaWhNL013L2VKQS8rdTFLNFFSL0k3REZ6amg0?=
 =?utf-8?B?dkNtUmRCeHVrNGRLSnMybkN5MHhwUWsrSThwY0lrR0xyRGF0VnRXOXM5aUkx?=
 =?utf-8?B?VnVFRVh6VFZxZEcwWU9Cd0ZGZXFFM09jTWlXNUxHalV4a2wrU1JmbSs3RkJp?=
 =?utf-8?B?VmxtUDRYOWhCUmZPRmgwM2lIUGlEbXE2bU13VnZ4NktEMnNrSTZydXNWeEhI?=
 =?utf-8?B?RU52YThBL1JES0ZrYlc3emNqV1gwN2FFMXRvK2pHQmZsYmlUMUVZVmRTRGpH?=
 =?utf-8?B?dHJlQlNxNzk4R2l4WWxxdThTSitGTDZJUERqbEVvZGh6Ykxkc2hKNy9kNFRB?=
 =?utf-8?B?aWsrdXpuL1k5K0xodzAycDU3UEhpc1lNeEVGT3BYL1RNdGpMbU1STUUveDdR?=
 =?utf-8?B?T2F1ZUNUNmR4YW9MT243UTBTWk9PRUF3LzAxSDA1Y3V3RkVOdlV1NWNxbVVi?=
 =?utf-8?B?aDN6cGx6TkR1NCtmZkt5U1pzcFBXZGk3dTZyemh1cUVwcmRpOTJmS1NIL1ho?=
 =?utf-8?B?a0RocUdPRWlQSm9qU05ka05hZm0wd0xqS2hoRzRCb3oxdkV6Z1E4NjZtbDBX?=
 =?utf-8?B?V1IvR3NIUFMrbnBldjlsRzZLeVdkbG1jc1pHSDFlVHA3NFR5REMvU1dKNHBn?=
 =?utf-8?B?ZVFQd2NHMk0zN2dyaksweVhSUmFKOWdoYWVHSlRZSDBydFJrOVpPYkRWV0Vt?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAEFA080BFBA0540AE328A258C348157@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dbeba4-6968-4a54-6c5f-08da630d17f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 07:15:11.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G10v4fVNnN2Dq+cQDypNBO+ti1eGubg6NdhVV+cPZsW9/DY9Gp1SEWFDqp+JAAUMLkCXl9BMFIc/WjW4sV2GMABBHgJPdtzUdnlJ8OG0Z4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0057
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDcuMjAyMiAxNjoyNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgY2xvY2sgY29udHJvbGxlciBzdXBwb3J0
cyBhbiBvcHRpb25hbCBjbG9jayBnYXRpbmcgcmVnaXN0ZXIuIFRoaXMgaXMNCj4gbmVjZXNzYXJ5
IHRvIGV4cG9zZSB0aGUgVVNCIGRldmljZSBjbG9jaywgZm9yIGV4YW1wbGUuIEFkZCBpdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNCkFw
cGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiBjaGFuZ2VzIHNpbmNlIHYxOg0K
PiAgLSBub25lDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9v
dC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDU3Y2I2N2ExODBlYy4uYmMxMDI2NzdmZjkxIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC02NSw3ICs2NSw3IEBAIGNsa3M6IGNs
b2NrLWNvbnRyb2xsZXJAZTAwYzAwYTggew0KPiAgICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxz
ID0gPDE+Ow0KPiAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjcHVfY2xrPiwgPCZkZHJfY2xr
PiwgPCZzeXNfY2xrPjsNCj4gICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImNwdSIsICJk
ZHIiLCAic3lzIjsNCj4gLSAgICAgICAgICAgICAgIHJlZyA9IDwweGUwMGMwMGE4IDB4Mzg+Ow0K
PiArICAgICAgICAgICAgICAgcmVnID0gPDB4ZTAwYzAwYTggMHgzOD4sIDwweGUwMGMwMmNjIDB4
ND47DQo+ICAgICAgICAgfTsNCj4gDQo+ICAgICAgICAgdGltZXIgew0KPiAtLQ0KPiAyLjMwLjIN
Cj4gDQoNCg==
