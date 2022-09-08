Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33C45B2135
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiIHOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiIHOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:51:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661ED99E9;
        Thu,  8 Sep 2022 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662648665; x=1694184665;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DS4bBASgDOqZ8kaE5tDt2yIApY69tqyCSHqvYSM98VE=;
  b=UQRPR29PUaazkSthr8lLSmTwDzNQUUx14yMbz8kQpvLWuVZSEm45/gI/
   K1nvLUvio2tERmT4yLghdd8sSEY5+y4hPxl1L5uT4PBRRPIIDPy8qj49p
   QtoHxiKqhEaWXqpDkXL3hBVW63a4a1E9dzkqOTVuRGut6q3e59Nh5t1E9
   85wkEtYJjL068isq9FfryyxGQzc1SwOHnXPxwjEKYpwEfdtu2axjPgh8y
   +voN2uH5lLyytS7U2eaDIdU81uD9Pu/zodyvZBZZY5LycmzHjN2SgzFjY
   ZIaHryvn2Eo5icv/+CvSVsrNxu/HugQZUDvfbRxJbDoBQFbxbV2KZFQn1
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179584950"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 07:51:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 07:51:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 07:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3OdXfAWxz2gdKjF7b39diR8/kD+6MTTg4jPfb5MS+bH/4ZjrJ2ckCbZdxXPh4JN1For57I0W4EQxHxfT4pr7iYzOSyhx4cT4Nx3BjjNNaabOlu4wvHN1pOCArrU4vVCNsgpZKbymxcL1ZoSsN3uiXXo4xrBSdDaVDaPf63s0Ts7/+sLF2xACwG4JWE6OxhrQEJiZASkQpzKa44K54BgJF0PdpjHtSTqctmlU4iMZ8UXDNM4PxkToC7VryI7UG74mchaqk9OVgW4/BWCbcF4tKGCq10tjCWavVrhooPpE7KWWuoX8Ex7/oeohbqWSFdp7IDn4VgUSP5EbKFH0BRVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS4bBASgDOqZ8kaE5tDt2yIApY69tqyCSHqvYSM98VE=;
 b=iezkR9lGOYV4UY4dkthNqks1SBjX4KtG1OdiiKBnzVaHbuTtEzZhvTGb5p6wJg2TsHBYYAFYlW/OS+T+I0WkNOn+/9TIYvD0H5ehr9CfuIYF43slIum1O0ra2OqXznWPEjWR+sK+w6tkraH7Q4xjIEGtRkrddcrMF3iK206aHtIsrifSBJ+bh2Ka0tI/MIJVgufTTDkBdqhqlMnyW2qKJ+Wdlpag3JZFE7RnSdsuvFr7hiwXz25Y9Z8pgAoTbMdXM8lowJkDz2LlPKICBFFTlOQqZeU9zEBY5d00dkeTLPYehAs3XfQRWBWX6A4CrvnW+POfZoi7ZD590IA01dmkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS4bBASgDOqZ8kaE5tDt2yIApY69tqyCSHqvYSM98VE=;
 b=ecVZOw2lOPZhGSaEEHm3aPOlnN07s3DEYGFSgF9s7Y6vcdx6RVUoALQJESa87vxkCkNdZreSOu5k8SA6eLffAYD4xQr12LrDiLMubI5wGdutyrsoFymbCx2qrrudsHPPWAOH0eKJEnIIfAD+LT34wt9l2kGbYL5AS2d6HGJXVgQ=
Received: from MWHPR11MB1693.namprd11.prod.outlook.com (2603:10b6:300:2b::21)
 by DM5PR11MB1306.namprd11.prod.outlook.com (2603:10b6:3:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 8 Sep 2022 14:50:59 +0000
Received: from MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535]) by MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 14:50:59 +0000
From:   <Jerry.Ray@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Topic: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Index: AQHYvwFp8Od1EQWLAkC3vC8jcHRCTq3VcuSAgAAlItCAAAYMAIAACJvQ
Date:   Thu, 8 Sep 2022 14:50:58 +0000
Message-ID: <MWHPR11MB1693A5AF16E14FFA06D80653EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
 <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
 <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
 <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
In-Reply-To: <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1693:EE_|DM5PR11MB1306:EE_
x-ms-office365-filtering-correlation-id: d2d47b60-689e-43c9-c76c-08da91a98ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9HHrswMIfi4rlm9qx1UspNi5ZTDhUM1mhLnEYkKcOgXyldWFK48Txwo7D9QnALsijeS8sCmAXBrAIQUEqyCx/SBnh+oghFY9f2bilEuaUzM5WzogjY6kupOMUIfWlRbIxyjGIml3haglpixpRayX/wYLqZyOHjqQPPmwe7yIgvM+5IxVFl7JNaAu2IHjKIcUJLzFaAlMeMV0avMoE5pmsmlSN3rdaDJ7v38zWZuUBXY7ZagHbZQC5tMT6TC2Pfda9BpJ4eIeHV786GNMXajVGfwysZ3Ilyi2JfDgROtxrYAwqJtD3TlGrvyIyXSgpTelfXunk9csIg0GDSmVzE5H0buu39ywdlDLohbtLWrpACphpIOYCKLFRJ7VygT2tlnzhD0iqOrWD0+0ebFkrVcIq9j4g7elc8T24mBUQ3lZsXQr3jbb4TSlKhlanco23Shkid/mHc03TVmU/09r/TvNZ87kiokIkLGMONQsISQ0qPSagPRH0Om1jDsAC2q33plEhIF9BjQe7mEVRJfX5niO4I3A0jpGyZGm6wvfmcgjSWgwhJMg9hi2mHo2ds9p1Jm3phzLARoJX6rA6iZSqUMETnT+AZ4IEzCfXWSbPOQ7itttUlQpPz7gkze7KDvGitRJV+ofy42Fn9RInh+CnCvlGnbqUOmlt2Ld81RH86JmSHCHq0OKUDHQ3UdiUhExjWUeL+mPimUkqPU9GOftxXxkmtAPhFpcVwN0PoXZPtMeUn0cW7Jj+bNcpJYHYOQ5wAlRUKDf56wt3JXT4KkXwbMTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1693.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(396003)(346002)(366004)(2906002)(33656002)(5660300002)(38070700005)(186003)(83380400001)(64756008)(8676002)(66446008)(76116006)(66556008)(66476007)(66946007)(55016003)(8936002)(52536014)(316002)(110136005)(86362001)(71200400001)(478600001)(9686003)(26005)(41300700001)(7696005)(6506007)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkFOZUlpekNRV0pselJ4WFJHSmdNYUtwdXRmRFJ4eTRhd2hZbHNIak1BRHh2?=
 =?utf-8?B?UUtqcjU2bkkzR3R5akwxVU5GdHNhS0pRb0NwZUN1VVk4Nm5rUGxFcXVtanNa?=
 =?utf-8?B?VC91TUFlQXIvRXYwMUZ6MnVFRnlvT1VZZFludUhxc0xmN3o3NzNmRG9vZTdl?=
 =?utf-8?B?cEUyRDF0RG1CTnBWb2Q5YWVidVpLU0pCVldNQ1R1QWVOdXUxUSswKzFsKzVz?=
 =?utf-8?B?SE1hZDI4allxTEFNY3BNNjNpc1pMWTc2a1AzSGdFV3U5NW5TTnkrak9DWWxN?=
 =?utf-8?B?YzVYOTdGUTE2Ry9xR3ZhTE1xUDNZRjBSaTI1b01mbGdoY0FtV2VEcjhHcVlJ?=
 =?utf-8?B?bTNWTXZSWjJjSk8vVldzK2xQZ2hLMUZVVWtKa0taRStXNG5XdmUwRXB0a0Zp?=
 =?utf-8?B?U0xvdk9wSTdVdTdXRyt3QjFjZm0wTjR2eEVGZ21kYVdzalc5OWk2anN1VmIz?=
 =?utf-8?B?eHdwVnRoZGNFVzZQMjR1TGpQRHN0VGdzVSsrei92b2d2NU5iMzd5eWx2VCsv?=
 =?utf-8?B?QXFWbE9pVy8yeXptRFE0REE3WDMvMVYzZFJBd3NTelAvMkM1ZlhWdEVRL25Y?=
 =?utf-8?B?SGZxbzUyd2k1bFlYU2xBS0JyQjY0YTBVOGcyY2RqSUJpanhYNlBadlpINHJv?=
 =?utf-8?B?ZGhRdlE4eFE3aTMyNHZJM2F3VmNkWHowNDZmVkIxWHhLRUJTOTdZeDB6UTlM?=
 =?utf-8?B?SWZ5c3hLNlJDY0w0clk0STJsWUkzYXhsVno4c2ZhNDFkK1FkRVl6STN0b3RW?=
 =?utf-8?B?UXdyWXJtcmNSNCsvTE9zTDVubXJrSlhBWkRIVTM0RDB2Q1l4cTZoRlluZ21E?=
 =?utf-8?B?RjNocmNlYnNBOGxtTVVreGtqTWRQMHdYY0hCVTlldFRKdzBtS3VkdGY1QXM2?=
 =?utf-8?B?NlJRQnRaSUZmalp2aTF3a3ExTU5iSlNMbDV5endPby9XUStDRkQ0QUhJQmZ2?=
 =?utf-8?B?L3l0cGFGbWtSS1VOR0x2cU9Ec1NhcWIvakx5L3hsZHE3dmVWMm4rTkdmWU00?=
 =?utf-8?B?WS9TTW5xZkZWU3N0cm1takpUY3gwdmRRZndWT3QxVzRta1dXdE5HdWJueUhm?=
 =?utf-8?B?K29UNXltQlp2MGg4WmpGTlByalJyMVBUSVozVStVWGloUk02ZTJ4WHZRcjRI?=
 =?utf-8?B?QlZvTE9oU2NTeHc4NU5QOThVTkNoN3QrRUU1ZnBzNFVsRVJsTmN0VEdUYWsr?=
 =?utf-8?B?YlBXMUlyL2lLRXRVb1JiU0piN0xGc0N4enZXMzVjdFFOYytVVTdCYXlhVFB2?=
 =?utf-8?B?MWl2cmIzQzIxaGZsV3FWdnQyV2N2TUxUTnRhRGxINGQ0akw3UWhROGNQYzVI?=
 =?utf-8?B?OFRhczFRYktWZnV4c1BRd0FDTWpCSEFRWlJ1UXVvMW9pUkhxaVFLcTN5bTdy?=
 =?utf-8?B?MTgvc3ZKR3JlZnVuQlFtWlJldGxtZ3ovSndtYzlqSmpyLzFFa29ScWFRclNV?=
 =?utf-8?B?RExOd1h6YzBwMDllc0ZHaWFSOEJ0OHFQaHVCbFMvT3BwcStreUwxblI0S1V2?=
 =?utf-8?B?OUdSUTlYMHlSTTJ0YjVJMlFVMVhoS0dxYklVeWY1K0lpVmFMSkEzd24zMVZD?=
 =?utf-8?B?a2RPTUdoNEM0bG13bGVreHR3RnRmYVFWQzZpZU9aVEpEb2RxZm85MW1xM3NE?=
 =?utf-8?B?OGhCelNHWkVZQUowbnpXa2tGU2g5cjV0YS9HNFNNRXpVd1R6NmVsU1kvZmtM?=
 =?utf-8?B?MzcxREdHS0RxZlQrL0RtYnFMTU45Y3UyUU9MRDE2c3M5bUtCd1k2QjE2aTdU?=
 =?utf-8?B?bmJzZlorQlVsd1M4UUJXSlNSRFNyY2JYQnc3MDRkZit4Zjh1QjA2dG9xZEhI?=
 =?utf-8?B?aDQySkRGcDkrSWk4Q2hVVElsV3Noak9PNk5MRW1SaU1WN0VnelgrSmRtVmEv?=
 =?utf-8?B?YllJNkxOSGdTMjVjbDhBSXJiZVZPTjBKNS8vdGphVUE0MGlrcUR5WllBUzVR?=
 =?utf-8?B?QW8wRG1YdDhzVHhnNFNCcVpaVWEwQXVEMlRmWUtxaHNSR2htZ09CRmI1RGp4?=
 =?utf-8?B?ZklhZmEvUVA1T2Z2cngxN3pwOVZDTHlpTFA2WHN4aTJwV2w5UEVQczhMQkQy?=
 =?utf-8?B?MU44TjdrbW9GS1JzRGpGOVJtekQ5MkhRTE1mb3M2RGs5eGYwQStIalhybTJt?=
 =?utf-8?Q?5j4in8m981wGTkWNG0ApcThdR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1693.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d47b60-689e-43c9-c76c-08da91a98ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 14:50:59.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6g7E5hCNVvzDT+DPYuzKBhCw91aAdLRxwYVfq1iTM6G8yIHZlf6JREic+GHzve2TVyhntvRy1kZsAHWa9/wW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1306
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+PiBUaGUgU0FNQTVEMy1FRFMgYm9hcmQgaXMgYW4gRXRoZXJuZXQgRGV2ZWxvcG1lbnQgUGxh
dGZvcm0gYWxsb3dpbmcgDQo+Pj4+IGZvciBldmFsdWF0aW5nIG1hbnkgTWljcm9jaGlwIGV0aGVy
bmV0IHN3aXRjaCBhbmQgUEhZIHByb2R1Y3RzLiAgDQo+Pj4+IFZhcmlvdXMgZGF1Z2h0ZXIgY2Fy
ZHMgY2FuIGNvbm5lY3QgdXAgdmlhIGFuIFJHTUlJIGNvbm5lY3RvciBvciBhbiBSTUlJIGNvbm5l
Y3Rvci4NCj4+Pj4NCj4+Pj4gVGhlIEVEUyBib2FyZCBpcyBub3QgaW50ZW5kZWQgZm9yIHN0YW5k
LWFsb25lIHVzZSBhbmQgaGFzIG5vIA0KPj4+PiBldGhlcm5ldCBjYXBhYmlsaXRpZXMgd2hlbiBu
byBkYXVnaHRlciBib2FyZCBpcyBjb25uZWN0ZWQuICBBcyBzdWNoLCANCj4+Pj4gdGhpcyBkZXZp
Y2UgdHJlZSBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHdpdGggYSBEVCBvdmVybGF5IGRlZmluaW5n
IHRoZSBhZGQtb24gYm9hcmQuDQo+Pj4+IFRvIGJldHRlciBlbnN1cmUgY29uc2lzdGVuY3ksIHNv
bWUgaXRlbXMgYXJlIGRlZmluZWQgaGVyZSBhcyBhIGZvcm0gDQo+Pj4+IG9mIGRvY3VtZW50YXRp
b24gc28gdGhhdCBhbGwgYWRkLW9uIG92ZXJsYXlzIHdpbGwgdXNlIHRoZSBzYW1lIHRlcm1zLg0K
Pj4+Pg0KPj4+PiBHb29nbGUgc2VhcmNoIGtleXdvcmRzOiAiTWljcm9jaGlwIFNBTUE1RDMtRURT
Ig0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKZXJyeSBSYXkgPGplcnJ5LnJheUBtaWNyb2No
aXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gdjUtPnY2Og0KPj4+PiAgLSBSZXBsYWNlZCB1bmRlcnNj
b3JlcyBpbiBuYW1lcyB3aGVyZSBJIGNhbiwgaW1wcm92aW5nIG5hbWluZy4NCj4+Pj4gdjQtPnY1
Og0KPj4+PiAgLSBwYXRjaCBub3cgYXBwbGllcyB0byB2Ni4wLXJjMg0KPj4+PiB2My0+djQ6DQo+
Pj4+ICAtIEZpeGVkIHJlZ3VsYXRvcnMgYXMgbmVjZXNzYXJ5IHRvIGdldCB0aGUgYm9hcmQgdG8g
Ym9vdCBmcm9tIFNEIENhcmQuDQo+Pj4+IHYyLT52MzoNCj4+Pj4gIC0gQWxwaGFiZXRpemVkIHBp
bmN0cmwgZW50cmllcy4NCj4+Pj4gIC0gY2xlYW5lZCB1cCBhIHdhcm5pbmcgaW4gdGhlIHJlZ3Vs
YXRvcnMgc2VjdGlvbi4NCj4+Pj4gIC0gTGljZW5zZSB0d2Vha2VkIHRvICdPUiBNSVQnDQo+Pj4+
ICAtIEluY2x1ZGVkIE1ha2VmaWxlIGNoYW5nZQ0KPj4+PiB2MS0+djI6DQo+Pj4+ICAtIE1vZGlm
aWVkIHRoZSBjb21wYXRpYmxlIGZpZWxkIGluIHRoZSBkZXZpY2UgdHJlZSB0byByZWZsZWN0IE1p
Y3JvY2hpcA0KPj4+PiAgICBFdGhlcm5ldCBEZXZlbG9wbWVudCBTeXN0ZW0gQm9hcmQuDQo+Pj4+
IC0tLQ0KPj4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDEg
Kw0KPj4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQzX2Vkcy5kdHMgfCAzMDkNCj4+
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAzMTAg
aW5zZXJ0aW9ucygrKQ0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEtc2FtYTVkM19lZHMuZHRzDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIA0KPj4+PiBpbmRl
eCAwNWQ4YWVmNmU1ZDIuLmU5MmU2MzlhMmRjMyAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvTWFrZWZpbGUNCj4+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUN
Cj4+Pj4gQEAgLTYxLDYgKzYxLDcgQEAgZHRiLSQoQ09ORklHX1NPQ19TQU1fVjcpICs9IFwNCj4+
Pj4gICAgICAgYXQ5MS1zYW1hNWQyX2ljcC5kdGIgXA0KPj4+PiAgICAgICBhdDkxLXNhbWE1ZDJf
cHRjX2VrLmR0YiBcDQo+Pj4+ICAgICAgIGF0OTEtc2FtYTVkMl94cGxhaW5lZC5kdGIgXA0KPj4+
PiArICAgICBhdDkxLXNhbWE1ZDNfZWRzLmR0YiBcDQo+Pj4+ICAgICAgIGF0OTEtc2FtYTVkM19r
c3o5NDc3X2V2Yi5kdGIgXA0KPj4+PiAgICAgICBhdDkxLXNhbWE1ZDNfeHBsYWluZWQuZHRiIFwN
Cj4+Pj4gICAgICAgYXQ5MS1kdmtfc29tNjAuZHRiIFwNCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkM19lZHMuZHRzDQo+Pj4+IGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS1zYW1hNWQzX2Vkcy5kdHMNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5iNGZlMWM1ZjI5OTcNCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDNfZWRzLmR0cw0KPj4+PiBAQCAt
MCwwICsxLDMwOSBAQA0KPj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAr
IE9SIE1JVA0KPj4+PiArLyoNCj4+Pj4gKyAqIGF0OTEtc2FtYTVkM19lZHMuZHRzIC0gRGV2aWNl
IFRyZWUgZmlsZSBmb3IgdGhlIFNBTUE1RDMgRXRoZXJuZXQNCj4+Pj4gKyAqICAgIERldmVsb3Bt
ZW50IFN5c3RlbSBib2FyZC4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIg
TWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIA0KPj4+PiArc3Vic2lkaWFyaWVzDQo+
Pj4+ICsgKg0KPj4+PiArICogQXV0aG9yOiBKZXJyeSBSYXkgPGplcnJ5LnJheUBtaWNyb2NoaXAu
Y29tPiAgKi8gL2R0cy12MS87IA0KPj4+PiArI2luY2x1ZGUgInNhbWE1ZDM2LmR0c2kiDQo+Pj4+
ICsNCj4+Pj4gKy8gew0KPj4+PiArICAgICBtb2RlbCA9ICJTQU1BNUQzIEV0aGVybmV0IERldmVs
b3BtZW50IFN5c3RlbSI7DQo+Pj4+ICsgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE1
ZDMtZWRzIiwgImF0bWVsLHNhbWE1ZDM2IiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICJhdG1l
bCxzYW1hNWQzIiwgImF0bWVsLHNhbWE1IjsNCj4+Pj4gKw0KPj4+PiArICAgICBjaG9zZW4gew0K
Pj4+PiArICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgiOw0KPj4+
PiArICAgICB9Ow0KPj4+PiArDQo+Pj4+ICsgICAgIGNsb2NrcyB7DQo+Pj4+ICsgICAgICAgICAg
ICAgc2xvd194dGFsIHsNCj4+Pg0KPj4+IE5vIHVuZGVyc2NvcmVzIGluIG5vZGUgbmFtZXMuIE92
ZXJyaWRlIGJ5IGxhYmVsLg0KPj4+DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBjbG9jay1m
cmVxdWVuY3kgPSA8MzI3Njg+Ow0KPj4+PiArICAgICAgICAgICAgIH07DQo+Pj4+ICsNCj4+Pj4g
KyAgICAgICAgICAgICBtYWluX3h0YWwgew0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgY2xv
Y2stZnJlcXVlbmN5ID0gPDEyMDAwMDAwPjsNCj4+Pj4gKyAgICAgICAgICAgICB9Ow0KPj4+PiAr
ICAgICB9Ow0KPj4+PiArDQo+Pj4+ICsgICAgIGdwaW8gew0KPj4+PiArICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4+Pj4gKw0KPj4+PiArICAgICAgICAgICAgIHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4+ICsgICAgICAgICAgICAgcGluY3RybC0wID0gPCZw
aW5jdHJsX2tleV9ncGlvPjsNCj4+Pj4gKw0KPj4+PiArICAgICAgICAgICAgIGJ1dHRvbi0zIHsN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gIlBCX1VTRVIiOw0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JnBpb0UgMjkgR1BJT19BQ1RJVkVfTE9XPjsNCj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGNvZGUgPSA8MHgxMDQ+Ow0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgd2FrZXVwLXNvdXJjZTsNCj4+Pj4gKyAgICAgICAgICAgICB9Ow0K
Pj4+PiArICAgICB9Ow0KPj4+PiArDQo+Pj4+ICsgICAgIG1lbW9yeUAyMDAwMDAwMCB7DQo+Pj4+
ICsgICAgICAgICAgICAgcmVnID0gPDB4MjAwMDAwMDAgMHgxMDAwMDAwMD47DQo+Pj4+ICsgICAg
IH07DQo+Pj4+ICsNCj4+Pj4gKyAgICAgdmNjXzN2M19yZWc6IGJ1Y2stcmVndWxhdG9yLTEgew0K
Pj4+DQo+Pj4gS2VlcCBjb25zaXN0ZW50IHByZWZpeCBvciBzdWZmaXgsIHNvOg0KPj4+IHJlZ3Vs
YXRvci1idWNrLTENCj4+Pg0KPj4+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxh
dG9yLWZpeGVkIjsNCj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJWQ0NfM1Yz
IjsNCj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAw
PjsNCj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAw
PjsNCj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItYWx3YXlzLW9uOw0KPj4+PiArICAgICB9
Ow0KPj4+PiArDQo+Pj4+ICsgICAgIHZjY18ydjVfcmVnOiBsZG8tcmVndWxhdG9yLTIgew0KPj4+
DQo+Pj4gcmVndWxhdG9yLWxkby0xDQo+Pj4gKHdoeSBudW1iZXJpbmcgb2YgTERPIHJlZ3VsYXRv
cnMgc3RhcnRzIGZyb20gMj8ga2VlcCBzb21lIHNlbnNlIGluIA0KPj4+IHRoaXMpDQo+Pj4NCj4+
Pg0KPj4NCj4+IFRoZXJlIGFyZSBOIHJlZ3VsYXRvcnMgb24gdGhlIGJvYXJkLCBzbyB0aGV5IGFy
ZSBudW1iZXJlZCAxIHRocnUgTi4NCj4+IFJlZ3VsYXRvciAyIGlzIHJlZ3VsYXRvciAyIHdoZXRo
ZXIgaXQncyBhIGJ1Y2sgb3IgTERPLg0KPg0KPlNvIGlmIHRoaXMgaXMgc3VwcG9zZWQgdG8gbWF0
Y2ggYm9hcmQgc2NoZW1hdGljcyAod2hpY2ggaXMgZ29vZCBpZGVhKSwgdGhlbiBtYXliZSBqdXN0
ICJyZWd1bGF0b3ItMiI/IFRoZSBwb2ludCBpcyB0byBoYXZlIHNhbWUgZ2VuZXJpYyBuYW1lIGFu
ZCBjdXN0b21pemUgZWl0aGVyIHByZWZpeCBvciBzdWZmaXgsIGJ1dCBub3QgYm90aC4NCj4NCj5C
ZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQo+DQoNCkkgcHJlZmVyIG5hbWVzIHRvIGJlIGRlc2Ny
aXB0aXZlLCBidXQgSSBzdXBwb3NlIEkgY2FuIGhhdmUgdGhlIG5hbWUgZ2VuZXJpYyBhbmQgYWRk
IGEgY29tbWVudCBpbnRvIHRoZSBkdHMgZmlsZS4NCkhvd2V2ZXIsIHRoZSBjb21tZW50IGRvZXNu
J3QgbWFrZSBpdCBpbnRvIHRoZSBsb2FkZWQgZGV2aWNlIHRyZWUuICBXb3VsZCB5b3UgYmUgb2th
eSB3aXRoICJyZWd1bGF0b3ItMi1sZG8iPw0KDQpSZWdhcmRzLA0KSmVycnkuDQo=
