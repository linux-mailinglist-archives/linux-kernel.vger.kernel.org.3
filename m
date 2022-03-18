Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD34DD9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiCRMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:35:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5553B16F052
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647606880; x=1679142880;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=X/fvrrg/0w7gs9o+zDcHkWFOygaHnakL1spMDQ4svWM=;
  b=uWlQxX+9BzuBq9TZmW27dwE1pu6q7plWx9wKXLBqkj/PAMAOBRl4aO2/
   aGfvC3pfBQLfy6ahwXk7TU8eHFXrwo5n9K6CipJ+ijq9odJnBTtEJIa6F
   ZNv8IjbZXIGz5bPYDoBE6SR/04FnHSZh9kAB2+Y09lFmne94lWBJsejsp
   DLb2t3RIN27f4rjAXHdK6QZowauf9QddVfqb+wvsR1OALdFGPnvLmLjFc
   z7AyN8w/x0OphPEbXFf2kZTqdAnb2juG2NmMaNih2XEbYyal4CStv0WM+
   qRYoqKCIc4EpoulHDvDqIi5SQeDigiLym5LM5fQcdu7lzTXLPbCGLlITm
   A==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643698800"; 
   d="scan'208";a="166292411"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Mar 2022 05:34:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Mar 2022 05:34:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 18 Mar 2022 05:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfJlEHAhfxvMttSjcooMDvAq+yTiqE9mgY0iR4hJi4wR104X99J6NqM2Cs7ImMNyj47e9ZPIQjqqGRg6lv3oDMUfUBSM+FqEn93qSqdvscI1ZpL4ycKKCWv0DZWnq5hyoLCoFog1RFueqOwtx5eE52xbm3/LHB99FHSk28z+wgDNeMPF5z/etrSWJmLBe15SLelJdRcw7kwJdeQBW4DwVap63xg/B4fhiqybB4Aju293UH6QPol7cBuws4WrcsyUZFWGvuXHPsJVJlDI+j9ntu7FIgG+9fOdeDxxAxRq5t1P7GlooV1rZ/ZvuEky36YbGRYtHHpn18f1DQsyDRWgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/fvrrg/0w7gs9o+zDcHkWFOygaHnakL1spMDQ4svWM=;
 b=FWn5w94riZI3mdBtANAS4wYPJSayd4PEIYgEvdhsQp8AdJoSxzBSAbBf8NNICa793UZDQmNuzBlTEqxJJB9II6O173L4VIRPnECE/6YP+0W4WdY/dbnFVNfOpYGiY7qIjy4H+NlZw7wfXQkUNndNKj2ZWOZmYQi8g2flOiMub1c5ZLcCkj+KfXdN7c9CtJKwy2UGZNPVXh2ca6Ovf/UAYH0Thmomy2x5rBY23fh5eeroKzCJ+YryzVJhiu1kunNRLOhoeahDJ84tJHC2lWNLYXzYd4mrz4e+EZFWwixfIXYWVjTBnAqHjAd2oUbNqEd0rsdmMbhSr3bjpyEF/GIfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/fvrrg/0w7gs9o+zDcHkWFOygaHnakL1spMDQ4svWM=;
 b=lN7j5UUej2Ezx/woTNWi88bHqNT97fS5NiNdHGwIYjl4rok9q2UdprGcXwL0ept8DQqHUJwQeZvdIL4JFarcr4UFVUwNCdPDwo75NZeKavErMifMVe1dSZHd1XC7kBtaziEVu8zr5Ur4DQPbXg2AUsd8W0v12W2jLLmhkJUSjLU=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by DM6PR11MB4217.namprd11.prod.outlook.com (2603:10b6:5:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 12:34:29 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 12:34:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linmq006@gmail.com>, <krzysztof.kozlowski@canonical.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] memory: atmel-ebi: Fix missing of_node_put in
 atmel_ebi_probe
Thread-Topic: [PATCH] memory: atmel-ebi: Fix missing of_node_put in
 atmel_ebi_probe
Thread-Index: AQHYOsSCbpPsI9V2eky3AN3/cJLilQ==
Date:   Fri, 18 Mar 2022 12:34:29 +0000
Message-ID: <22c57600-a9ab-8d3b-e481-1087a6867446@microchip.com>
References: <20220309110144.22412-1-linmq006@gmail.com>
In-Reply-To: <20220309110144.22412-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e50c120-86c5-4eb9-4db4-08da08dba561
x-ms-traffictypediagnostic: DM6PR11MB4217:EE_
x-microsoft-antispam-prvs: <DM6PR11MB421737902AA210072E6ED27B87139@DM6PR11MB4217.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0AD4OawX4hvG4vzVE0Ohuva195fEgaTw9CaB7sHxV4ZWlY24Y7xN76AWHT0ifP9fnb0h3P0CMwQL6/s4D7gRlgkbGmPsn+gPvGHXkZnt1ty4uKb9JdOX0kFtnmc9Mf9O62iuPnzqQeiY8AFfaWmY1Lp4arNpQo9BmY14D6XD9ZOXRebNhHVs7ZIe8W/XwLbe7kkouh5kELw+f919CjWvlNXr+7dgeRN0ReNdyA8pgHs6TIuZbnzilLGmGSgA5p31cnPDLRu4s8Ws22ZfXQgtI5R7Czw0AHNVZFEOo+SAWUfVGjhS/3I/26TRyHO7LlsoFz0smWqyGVNpbVzpZMYBhG5CwlRk23AB/1Idwq8U1cTI9MpYzEbUH/ktR9vGCiVVrqkGXhOMDjlJwOrv4rmLFU13SIeuQe6t3zvq2DqafWEivr0Uy6jempCz3ZtFoodjOoFQv3NKBarLjU3kqaHXLhHCzloSWDeMYRoM9J/bLw9LmfXL7/nmVcdU6/J3TLJFpop18bN3obJCLHUdGQ3OgQeshZN96Mq6PxmRGg4bL1sBiGCRw4yU4l5EHUMGDcFnkCUl46/DAVfq+lFGsie5sBXwr3WJFS6XutBndkEgPY02XCZnXeaREFphTCdNfEL5X7cDrnI+GbkpyUkvD7GWYNByjHeo2Iyp+ZsIPKSz5Hngwm+5H0auCYgbOSgOttBTQiZCrEWph7RDqNoypk1eqVs8b5yq4cGtTqrf8SXYSnKQDeW2zJcGA5M26Q7aj2BDt8tNeF7dJe+TxM5CqvrUGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66446008)(66476007)(6486002)(66946007)(76116006)(66556008)(91956017)(53546011)(6506007)(6512007)(2906002)(8936002)(86362001)(186003)(26005)(508600001)(122000001)(71200400001)(5660300002)(38070700005)(2616005)(38100700002)(31696002)(31686004)(36756003)(8676002)(110136005)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTNQN0VUUjlMVVB0cDNOaWk2b1BPbGllb240Vm14OFdmV0NPN0hzemFnSWM2?=
 =?utf-8?B?OC94TWVDK1pkVmV6clFQdjJCN1FGNG5DM0FXMjByazhFR0dOejl6eU85M1JC?=
 =?utf-8?B?SkJGM0JVMzVZR2lPK2RTcVpWNjBTSmJtbFFxVnJLbWw4T2xWL0oxT3lQSG5E?=
 =?utf-8?B?Si9aMEQwd2FjMkFKRlJKUVlPUkxDcVpEdmNHOUl0RXJGU09SOXphK1piNnB5?=
 =?utf-8?B?dWh1bVJ4a3N5S0xPQlVlRm1BeHQ5ZUllT09NUXd2NDlPNDY0TjRmd0hReGZv?=
 =?utf-8?B?dzJWRUtTVnBIRWlwemxEclV4Vm8xNXcvMnpKRldHb3I5aXJDRTErV0xQblBp?=
 =?utf-8?B?RGUvME4wTlYvY3M4Z09vR1NzblliY2M0V3VFelQxZGFzWlZ5Z0duWXhSa0VN?=
 =?utf-8?B?M0tYdkFJM0ozZjQyYUJRWld5SUxjMytsZjBlZldrWkYvdEhxWXZqQlBlcmZk?=
 =?utf-8?B?UkMwcjhJQ2FMdFplSnhlaXVzcmZ0SGd2VEduUFlDMEgrMmFnUDN3S1BxS3ly?=
 =?utf-8?B?R1RhWjl0K0lkczQ4bXUyajFTVnJFcm5SMytRZTdxTi83L2pWMzZ0alpwTWtp?=
 =?utf-8?B?dFF6WUg2OUVCeVZ3a2pFMlhJVWJYVEhJdTlObkFrMklZVkxKTEdDMXVnMkpr?=
 =?utf-8?B?Q0UrcGxaVStDTDQ2T3VDa1pvV2xSWUFMWDlDS3hMWktpem1ac1p5VXZDY1ho?=
 =?utf-8?B?YmVyeG9naW1MRVNEekwyYzRTS1FHc1U4VWNPMnppUjlaelFtQVJlWXRuY1gv?=
 =?utf-8?B?QjNYVnUzVHlpVTVJclR1TGRDOXo4Z2piOW9GV1FGWGIyTE91Z3pnMGwyRnlO?=
 =?utf-8?B?Ny8wY243Z1h6Q3FZYlM1ZU94S050dkxxNEx2SnNnelZpeGNXOEdXelhWRFpE?=
 =?utf-8?B?RDkzdnJXSWJFRDI2VXl1akNOQjYrZGVnZDRIVkdoY3Exck81K1BQQVdHMG5M?=
 =?utf-8?B?K29PQ0UrU1NTUVkrVHJXSHY4UTFjTlhXTHV4OWxvR0dOK1pZTG50cFNFN3N3?=
 =?utf-8?B?MXljdVlhbzMweTdWV3ZOMlJIRjFCdmpxMW0xbFNuRUpzekpGUldWZGp6RTBG?=
 =?utf-8?B?QnFuVitpd2dHdUFucytGTVBMTUxxek1lMkNqRm5PTDhpRXl5MHlLWmRCYVFX?=
 =?utf-8?B?YnZNMllRYUhPZTc0Q29kdjhyRXorcHMzOVR0SVJPSFFJbnBwUkhWM1I3dkFY?=
 =?utf-8?B?ZVQrU2VzQWl5OFp3dlJFT2ZvM1lJK1R2ZXRGUUZobnAvcGZXaE1xckpJYUN3?=
 =?utf-8?B?cVJTOXdIeE5RRnRNU0hScWJPUEJlMW1VRHA2b0xNc01ZenB4RGZVU1k3d3BV?=
 =?utf-8?B?Njd6MWpYRWFURE9zV01sMjFKWm1NRHJXREdFWE1BNjZ5MGN1aDJYWkZDQ01r?=
 =?utf-8?B?SExOOGpFNElFQkhxMEl0dDY5UTN4YWhSaEJhYXJvRnZvMjJ6b0tRQUJDWDJa?=
 =?utf-8?B?SjVnZUV6VnZkLzNPWXEwL09DOEdKZUdML3N2a0wrdkdpcEZrV2owbjhldVBl?=
 =?utf-8?B?R2dUbjlvckpUODN3ay9rbFhsV291cEVHY1ZkOWtHOUtobEdJMk43N1RqZFRX?=
 =?utf-8?B?SjlrQ3VySWlWb1NaK2Y0Ykd0Y1kvd2o3S2MrdnY0RXBuR3MrT1huRUxtblFB?=
 =?utf-8?B?Mlo3YmsxZTBUWkMvVWgzN1hHRE5nam1zSTBPL1dGdi8vMC84WmJ0cnJycVhO?=
 =?utf-8?B?NVB3SW1mcGY5MHRxNUM0OHVjeTg5dk1XZUIxRi85Qk11Uzl3eHgxMGdIZHBa?=
 =?utf-8?B?MUE2RHhRWmJkN0pPRkhaczRMeE03RTd1WTRkNk1yTVlFR0lGNmxOaE91Z015?=
 =?utf-8?B?UG1RZWV5ak5rZmNqSG12dmU1bGpEaGtuaUZGRWZEWTNoUC81YUU2VXZnRnM5?=
 =?utf-8?B?TGsxbFp2dktpL3ZYekpzcXFEZk9aMzJwM0ozSUZ2ZXNubEhSeWJzeTNDWGxY?=
 =?utf-8?B?TGZLcWdxcTZBQndtaWJIMU9IR2U2MWd2Q25NVVZ0UmtwVWg0VEM4Z2dzTlZr?=
 =?utf-8?B?TmE2VEFRODd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0CBC66241A19541B04C5FDFEB2F928E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e50c120-86c5-4eb9-4db4-08da08dba561
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 12:34:29.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEXtZ7KRBT37SjTKlxln3m3sLVcR8frj+b7uziPHOwNFcIqbZfp49DLpFfsS3TFpomXSXAGjx+uGnb4PilZXJvHwGtyjMtSCmOdvUMJaFbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4217
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDMuMjAyMiAxMzowMSwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBkZXZpY2Vfbm9kZSBwb2ludGVyIGlzIHJl
dHVybmVkIGJ5IG9mX3BhcnNlX3BoYW5kbGUoKSB3aXRoIHJlZmNvdW50DQo+IGluY3JlbWVudGVk
LiBXZSBzaG91bGQgdXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lLg0KPiANCj4gRml4
ZXM6IDg3MTA4ZGM3OGViOCAoIm1lbW9yeTogYXRtZWwtZWJpOiBFbmFibGUgdGhlIFNNQyBjbG9j
ayBpZiBzcGVjaWZpZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvcWlhbiBMaW4gPGxpbm1xMDA2
QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9tZW1vcnkvYXRtZWwtZWJpLmMg
fCAyMyArKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1v
cnkvYXRtZWwtZWJpLmMgYi9kcml2ZXJzL21lbW9yeS9hdG1lbC1lYmkuYw0KPiBpbmRleCBjMjY3
MjgzYjAxZmQuLmU3NDlkY2IzZGRlYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZW1vcnkvYXRt
ZWwtZWJpLmMNCj4gKysrIGIvZHJpdmVycy9tZW1vcnkvYXRtZWwtZWJpLmMNCj4gQEAgLTU0NCwy
MCArNTQ0LDI3IEBAIHN0YXRpYyBpbnQgYXRtZWxfZWJpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgc21jX25wID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9m
X25vZGUsICJhdG1lbCxzbWMiLCAwKTsNCj4gDQo+ICAgICAgICAgZWJpLT5zbWMucmVnbWFwID0g
c3lzY29uX25vZGVfdG9fcmVnbWFwKHNtY19ucCk7DQo+IC0gICAgICAgaWYgKElTX0VSUihlYmkt
PnNtYy5yZWdtYXApKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZWJpLT5zbWMu
cmVnbWFwKTsNCj4gKyAgICAgICBpZiAoSVNfRVJSKGViaS0+c21jLnJlZ21hcCkpIHsNCj4gKyAg
ICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoZWJpLT5zbWMucmVnbWFwKTsNCj4gKyAgICAgICAg
ICAgICAgIGdvdG8gcHV0X25vZGU7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAgICBlYmktPnNt
Yy5sYXlvdXQgPSBhdG1lbF9oc21jX2dldF9yZWdfbGF5b3V0KHNtY19ucCk7DQo+IC0gICAgICAg
aWYgKElTX0VSUihlYmktPnNtYy5sYXlvdXQpKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBU
Ul9FUlIoZWJpLT5zbWMubGF5b3V0KTsNCj4gKyAgICAgICBpZiAoSVNfRVJSKGViaS0+c21jLmxh
eW91dCkpIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoZWJpLT5zbWMubGF5b3V0
KTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gcHV0X25vZGU7DQo+ICsgICAgICAgfQ0KPiANCj4g
ICAgICAgICBlYmktPnNtYy5jbGsgPSBvZl9jbGtfZ2V0KHNtY19ucCwgMCk7DQo+ICAgICAgICAg
aWYgKElTX0VSUihlYmktPnNtYy5jbGspKSB7DQo+IC0gICAgICAgICAgICAgICBpZiAoUFRSX0VS
UihlYmktPnNtYy5jbGspICE9IC1FTk9FTlQpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBQVFJfRVJSKGViaS0+c21jLmNsayk7DQo+ICsgICAgICAgICAgICAgICBpZiAoUFRSX0VS
UihlYmktPnNtYy5jbGspICE9IC1FTk9FTlQpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gUFRSX0VSUihlYmktPnNtYy5jbGspOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIHB1dF9ub2RlOw0KPiArICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAg
IGViaS0+c21jLmNsayA9IE5VTEw7DQo+ICAgICAgICAgfQ0KPiArICAgICAgIG9mX25vZGVfcHV0
KHNtY19ucCk7DQo+ICAgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGViaS0+c21jLmNs
ayk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
IEBAIC02MDgsNiArNjE1LDEwIEBAIHN0YXRpYyBpbnQgYXRtZWxfZWJpX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICByZXR1cm4g
b2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7DQo+ICsNCj4gK3B1dF9u
b2RlOg0KPiArICAgICAgIG9mX25vZGVfcHV0KHNtY19ucCk7DQo+ICsgICAgICAgcmV0dXJuIHJl
dDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgX19tYXliZV91bnVzZWQgaW50IGF0bWVsX2ViaV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
