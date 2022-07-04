Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFF564DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiGDGrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGDGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:47:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BA5F87;
        Sun,  3 Jul 2022 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656917236; x=1688453236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lq3fPlXafifR037zo0Aw4O94Ujgeu6yC355tzAWlKhI=;
  b=kFT0cTvTJtISfXurIpLT+aVXQriBTSHJGmVNfuf55vMolTcrbcey3WlE
   oNJAzt15/vrpHGFtEPxZtnIuVMlG/xeisVGOhq69N1xnYELWie2qjtlh/
   +zfhi4LaUKlBZEz+w1bPForErprvNOjy4qHeo1xIYd3cv48xfQn5AmsTs
   Q7cyIzk1DmTUs8QHv+V2cs87MC1RBuFieRzCfcXl6/12bSeuk+rkoigTt
   MVEY+Z2kZ0QV8/3Hf0COudjGoThDnTa4FG+/muuKKlGeIOwztAJ4IXnlO
   DJ3RM372Z5LUW5ajDCzxMb23SDMojwYhrVmwFgA15ASFcwHMRxeevME4p
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="166226377"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 23:47:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 23:47:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 3 Jul 2022 23:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZGhF4X53y2GhppAa8mVkfPngfxJzNgPfiIzMXSRyNTMygtzlDhOPwRKOn76oOGv1f/3KiV4xYHXWhqj75ST2uYzZydNCCFe0YSeRhAlLf/0uH8cH+6lgfHzetCKvZVxyQ70ZqYooX/kdfN27NIvuDUEPs1IhZj4n33uhCu+3SO0R610P2mHixH3wRRT3xo0myaAGE714n+BJAip+U7+H8mnPUFy9eKIxgrojvqCKS6/ojSIOncq07gVhTMOH/7QS8vNrIsjFgRvrbCKmCTWMY0RvGkeQklx3KHPut1nd1Noc3zg5Zx/iqJIZt8UxGn74aEVa4CVzeKDZYCNCvaurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq3fPlXafifR037zo0Aw4O94Ujgeu6yC355tzAWlKhI=;
 b=iI1rTBvUMcFQyHcCtvMfED82CHlejEtR4J5PgzHNh5kxsB6JuHO5ULEC7auK6vWG8FqQtC5P2hjRV+RRe5GzQ+cHrvSFMq2XFZn7U36SSWYOf1NDzNYraMrVTCnKwM4uW65H2PxKSpcVkNWDHOPPos3VdvwEtuHn36pmA5a4sA3Cudx5bhZM4TQsZIby/PpBrnvQCBgVWMFjoXTnGqQmarIGDEGD+KpMLT+ffnMWf0dhPxOfFkyBvG1fI7Uvw3V3b0qEnA2uHD3CuyQzXD3EWMQIswc/qi7+NR/ORyBWOWTEaChdWM0MGOJUd5g+FNagVJ2lZyyGf5vO35RKuxTbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq3fPlXafifR037zo0Aw4O94Ujgeu6yC355tzAWlKhI=;
 b=scr8FfX9k26qBv0gpyOJSliFWfJNlNbKcaJUscR03NV1C/VT/7W2L2Rfl1U8LoNKxlMQrNP3ow9gX3cLM9GRLRMdeHrq+l1sn+k8ok6mj1ExnlzfIZQHV9NbP8ARb1s5mXIrru/vDD1AJ0doEHTFI/GJFaCGaVj7NqfKTcEMO20=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB3497.namprd11.prod.outlook.com (2603:10b6:5:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:47:09 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:47:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/9] ARM: dts: at91: use generic name for reset
 controller
Thread-Topic: [PATCH v5 1/9] ARM: dts: at91: use generic name for reset
 controller
Thread-Index: AQHYj3Hi0x4qbCajE0WJm4x3Py4V+A==
Date:   Mon, 4 Jul 2022 06:47:09 +0000
Message-ID: <9744d821-ce6f-0b74-9779-ad95322074cf@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
 <20220610092414.1816571-2-claudiu.beznea@microchip.com>
In-Reply-To: <20220610092414.1816571-2-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ef3bc9e-e17f-4ef6-a4a7-08da5d8904b7
x-ms-traffictypediagnostic: DM6PR11MB3497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cb0Mq8opd3V2SlPABfspqL6byHm8Zy0xIbc+4ow9qEOYTUrYzenS1zlXl7NBGEZhfFakd9Mz1cV7f6HoJZbc8tNSDiZlEjlcd15WA2CvEalaslJMUJpk0+oJyIdLOml5y5+yHU0ZozUfPH+0LCpo/woqSKfWgrg1M1fDSera1GGLhCbAN009DZcc0R8q1hdZ+6hpDa03cFtVjSYpQNDtlZGB5Pt83+r5BQWtZnmpfMNHLpKaI2Ipr6Q1YNEYSkmc8A6uzORqm2ngjttuWSOpwyN+WPZGT15BTJQbsEG7uF0TmiXkyVqg2d6nd96XZzXZCgmz9Yz1UGs1vN3BDyFMCw0QuqF0ZySH+s5enFdcgZlims7ncqrrnvmWAEce4Ov8JZuRlm+jfMx83oRUVzqdjCq2/dMIbZVFxUQnlOATk3ST/H8xPQR3pTsuYQwEStWds36X2i1Tu3MJF+4vaFecmxPEiZj8p98k0CNNeW7faFRNYVJ8s1sRxOOdBcNkatHVqr6sOAhs+xV81KiiRZxonO9PQXtR1Vyl79Mx/B+knSdt0u6GTqYGjTMOcV8bn9YhKxWHkTPJTbb5UeIAojWl9iKabdxdNxJZIowe937bL8EHs1vuJNcCYyu826VkQhjWogMZ/SPNrinMpwWGuWMsOIyPeMbjABRCy5gQe+PLuBed/ZFyd2ba7lzT+3hALzS8D3h/kpA6oNb+bz7c45sK9d89/oaNCF4CGfWPIKbkqVRW+xjbdnDetVF3VigddCWMAVwf5J5s/mSaBMYkS0Y9FwLntGwyCqiogpQ6/8KESGAbTHsBkgzxZFaiOfS6TXQvzUO5UoJTskZUeKszW5BkOh7lvNkPdEdCcS8zFPl8kMjElHl4sF4h0VlauoEthzrnN/NmpTr184p1cHxShMhhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(4326008)(76116006)(8936002)(31686004)(26005)(31696002)(53546011)(6506007)(7416002)(91956017)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(83380400001)(2616005)(186003)(38100700002)(54906003)(110136005)(2906002)(478600001)(6512007)(86362001)(38070700005)(41300700001)(316002)(6486002)(122000001)(71200400001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1dQTE8rQm5IZmg0WGN3M3c1d2hvanlwQ0h0Qm94TXNiQVdxN1UraElLK091?=
 =?utf-8?B?N1FPNkJkQUNQS3RweEVveHN3V29BV0IyaHNHZU9tRFVhYkQvOEp4eVl0VXY1?=
 =?utf-8?B?aVNKdnV2ZUZCOVRTNzI1UnlGTHBxOFJ4MVM5Y2IrbVFkZHV0NmRoclZlVzNS?=
 =?utf-8?B?WFJPdDVqYkp5MkhvaVRyNW0zcFZZSTlZTmdlbjFoemlyaXdiN3hhTXdrejA0?=
 =?utf-8?B?bWhOWCt0QUJVbzJGWEZycjUyY2Z2aXQyQzNRa0FWSUlyc3dzVzJQRVdKMFdT?=
 =?utf-8?B?S3p6WEs5aW9Dc29kc1Y5dENUdW1TRzFYTnBwdVlKZXMwYi9vYm5xTmxOczRF?=
 =?utf-8?B?bDBGQ1d1Ui9rK01oZEplb3pJV1JLUmhWckY1SWNneXBPb2o2QXlGUDdRSlR6?=
 =?utf-8?B?dFE1eGlOK3hxcUEzazc2R1llb3VkQjhzbllkM2tlYmJKVmRzYU5VQytYMVRC?=
 =?utf-8?B?U3d5cVMrcjNaRUhoMm1NYXowWFdlbTd1WFhVK1FlNmJDTnZpWTZ2ZWc0MHdV?=
 =?utf-8?B?dVRWVnlmRmM0di9KRnVuZWxHbjRaZU1mcDIxeXlKUjJHcUQ4NU1oTzJJdm5u?=
 =?utf-8?B?dmJsL2hnSkswQldnS0s3czdhcTh6a3ViR3c2NlZZeENDRDQvOU1COWZOYmxk?=
 =?utf-8?B?Z1M3QTVJSTVwL3BGMStNUmR2Y3Q2MHFCSmYxUG5oLzZWTXBteWRpZFY5WWcw?=
 =?utf-8?B?aG9nVWtOZDFrQzM0R3VLaHJkeEZxOVdXdjRwZnNtSG9rbDY2Vjd4YVhwcTJN?=
 =?utf-8?B?alFnV3E4SEFHTnhVdkFxOEd0TTZlUmVNVXI2dFhMVzVZYnZBaE00TGlnamdC?=
 =?utf-8?B?d0RESjdTcVhDVE80U25ybzA3ZnZwUmhHaE9UUlNSTGM1SUJlenNQSG40VFc3?=
 =?utf-8?B?TEMzR1JLZnhsQkVvaVVnbFI2TUlLNitMekRTTkRsOEZCcGFCSDBNRzYvM1d5?=
 =?utf-8?B?UEZUck5EVGhuMnA3dnJDVGFaYUl4Ky83N1Z4QkI4NDI1cHo0VzVXN2o0ekFG?=
 =?utf-8?B?Vm5lMWUyUHRKVTA1NklSUytjd0dJKzkzQU9nMHhmQS8wQnlqOHBFSEk2eVdy?=
 =?utf-8?B?NzFJYmlteWQ0clgzdXBKWXJ1U0o2OGxMRmtZZVBvOTJMUFZMRElBNFZRNFRr?=
 =?utf-8?B?RlVkWjJtZHJWWkhocnJxUWpXRUZwSWlWejJqQWh6MXFLRS9EanZOZ2l1Qnlk?=
 =?utf-8?B?d0hJMWJwK21ITm1tVlNOS3VUOXhZOTRvUS8xVHZOR1kxOWpoNUovbDgzZFV0?=
 =?utf-8?B?dGx2dGNvR0dMaGFPR3YxRWFRUEVtcHQ4dC83R05hL0VVOUNWR2hTdEJqOEVD?=
 =?utf-8?B?Qk1IZVltTE5YK09oemRhNDJKU0d0c0RTVllucjU4Z2lZQWdJZk8zRC9YY2Y1?=
 =?utf-8?B?SEhRc0xkbFpsdC9mVGt4c3AyYWZEc1Jma2ZKZmV6L1ZmZVFlUGRxKzVsNERl?=
 =?utf-8?B?L3VRa2hrMHZoTXhsWmRSbFdlR2o3V1hzQ25TZFhqZGVtdjFJOXpZczNMZ1ZI?=
 =?utf-8?B?SzBlNXhZd2wwTit3cVNXV1pXNVBmVnJRVklNQ3NjcDF0d25MNDBHeWg4d2tH?=
 =?utf-8?B?bkZwSmxIS25rOXRLcEJMbllFQkFSd0VaWE8rLzF3Z1RxU3FxQS9ya0x5a1N5?=
 =?utf-8?B?VzA0WW9oSmJLNTFwaEpib01UOUttYTZuU3l0dkdXckhER3poWnRTTWQ0aG8x?=
 =?utf-8?B?NG5IK3dKNmg1a0dJL0xyVTVFNFlvemdNSTZWYU5jY2o3RWF2Q2JydkpYNFIw?=
 =?utf-8?B?U0hQTzJMSnp2RFM4VXQ2SURuZ1lESXZFQ01IWjgxdlpDM0p2SDgzb3BQUVdI?=
 =?utf-8?B?LzBoZldmbm9TcWQ5MWFDUkxlV2RHbDdvblJheFVhTkVJTHA2b1Y3aFlBd2ds?=
 =?utf-8?B?NzRHKzBONmRURHRVdEQzVFVkMC81Ky9oRElUbmJYSUdTeFI5ZEVNc2pwUE5D?=
 =?utf-8?B?cDQ2ZFVPRjJ6VGUvaDhhQmlXNUJDTEFLTVY5eWlWTm9HYmtnWjFvbndBYkhZ?=
 =?utf-8?B?SnllbFZWcjI5Q3lwMjhzSkNsMHVEMURqZytubzN2M3dSUDIvN2M4RU4ybTVI?=
 =?utf-8?B?YUQwZ2FmMFljM1QwM0ViWlA0Q1Y3RmFSSzQ5T3RHK0hHK2dkdnAvT0QvblhI?=
 =?utf-8?B?bTFqL25uMGdFVldiQ0xNSTkyQm1ndFZGa3lyYU10ZTlZN2QyNTRiMzloQXM2?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B2F4EA8E016F4FB754826E4F518743@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef3bc9e-e17f-4ef6-a4a7-08da5d8904b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:47:09.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDIR1b1hG7iXYKpHmxnL43EqXkaN0/CUeNOvxwggyyEv4gbmaew/mGy4U12Y4bSGjjEMwsDqRXML4C3KG2fW4TIueR0PiiOkGTNEUPZZO7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3497
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDYuMjAyMiAxMjoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFVzZSBnZW5lcmlj
IG5hbWUgZm9yIHJlc2V0IGNvbnRyb2xsZXIgb2YgQVQ5MSBkZXZpY2VzIHRvIGNvbXBseSB3aXRo
DQo+IERUIHNwZWNpZmljYXRpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+IFJldmlld2VkLWJ5OiBQaGlsaXBw
IFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KDQpBcHBsaWVkIHRv
IGF0OTEtZHQsIHRoYW5rcyENCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05
MjYwLmR0c2kgfCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MS5kdHNpIHwg
MiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTkyNjMuZHRzaSB8IDIgKy0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05ZzQ1LmR0c2kgfCAyICstDQo+ICBhcmNoL2FybS9ib290
L2R0cy9hdDkxc2FtOW4xMi5kdHNpIHwgMiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNh
bTlybC5kdHNpICB8IDIgKy0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05eDUuZHRzaSAg
fCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kgICAgIHwgMiArLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpICAgICB8IDIgKy0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3NhbWE1ZDMuZHRzaSAgICAgfCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW1h
NWQ0LmR0c2kgICAgIHwgMiArLQ0KPiAgMTEgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXQ5MXNhbTkyNjAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYwLmR0c2kNCj4g
aW5kZXggNzM2ODM0N2M5MzU3Li45ZDk4MjBkYjk0ODIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTFzYW05MjYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MXNhbTkyNjAuZHRzaQ0KPiBAQCAtMTIzLDcgKzEyMyw3IEBAIHBtYzogcG1jQGZmZmZmYzAwIHsN
Cj4gIAkJCQljbG9jay1uYW1lcyA9ICJzbG93X3h0YWwiLCAibWFpbl94dGFsIjsNCj4gIAkJCX07
DQo+ICANCj4gLQkJCXJzdGNAZmZmZmZkMDAgew0KPiArCQkJcmVzZXQtY29udHJvbGxlckBmZmZm
ZmQwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1yc3RjIjsNCj4g
IAkJCQlyZWcgPSA8MHhmZmZmZmQwMCAweDEwPjsNCj4gIAkJCQljbG9ja3MgPSA8JnBtYyBQTUNf
VFlQRV9DT1JFIFBNQ19TTE9XPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0
OTFzYW05MjYxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MS5kdHNpDQo+IGlu
ZGV4IDdhZGMzNmNhOGE0Ni4uMjU5YWNhNTY1MzA1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9hdDkxc2FtOTI2MS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05MjYxLmR0c2kNCj4gQEAgLTYwMyw3ICs2MDMsNyBAQCBwbWM6IHBtY0BmZmZmZmMwMCB7DQo+
ICAJCQkJY2xvY2stbmFtZXMgPSAic2xvd194dGFsIiwgIm1haW5feHRhbCI7DQo+ICAJCQl9Ow0K
PiAgDQo+IC0JCQlyc3RjQGZmZmZmZDAwIHsNCj4gKwkJCXJlc2V0LWNvbnRyb2xsZXJAZmZmZmZk
MDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtcnN0YyI7DQo+ICAJ
CQkJcmVnID0gPDB4ZmZmZmZkMDAgMHgxMD47DQo+ICAJCQkJY2xvY2tzID0gPCZzbG93X3h0YWw+
Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTkyNjMuZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYzLmR0c2kNCj4gaW5kZXggZmU0NWQ5NjIzOWM5Li5j
MDgwZGY4YzIzMTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYz
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTkyNjMuZHRzaQ0KPiBAQCAt
MTUxLDcgKzE1MSw3IEBAIHRjYjA6IHRpbWVyQGZmZjdjMDAwIHsNCj4gIAkJCQljbG9jay1uYW1l
cyA9ICJ0MF9jbGsiLCAic2xvd19jbGsiOw0KPiAgCQkJfTsNCj4gIA0KPiAtCQkJcnN0Y0BmZmZm
ZmQwMCB7DQo+ICsJCQlyZXNldC1jb250cm9sbGVyQGZmZmZmZDAwIHsNCj4gIAkJCQljb21wYXRp
YmxlID0gImF0bWVsLGF0OTFzYW05MjYwLXJzdGMiOw0KPiAgCQkJCXJlZyA9IDwweGZmZmZmZDAw
IDB4MTA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmc2xvd194dGFsPjsNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05ZzQ1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hdDkx
c2FtOWc0NS5kdHNpDQo+IGluZGV4IDJhYjczMGZkNjQ3Mi4uMDk3OTQ1NjFjN2NlIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOWc0NS5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTFzYW05ZzQ1LmR0c2kNCj4gQEAgLTEzNyw3ICsxMzcsNyBAQCBwbWM6
IHBtY0BmZmZmZmMwMCB7DQo+ICAJCQkJY2xvY2stbmFtZXMgPSAic2xvd19jbGsiLCAibWFpbl94
dGFsIjsNCj4gIAkJCX07DQo+ICANCj4gLQkJCXJzdGNAZmZmZmZkMDAgew0KPiArCQkJcmVzZXQt
Y29udHJvbGxlckBmZmZmZmQwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2Ft
OWc0NS1yc3RjIjsNCj4gIAkJCQlyZWcgPSA8MHhmZmZmZmQwMCAweDEwPjsNCj4gIAkJCQljbG9j
a3MgPSA8JmNsazMyaz47DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2Ft
OW4xMi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTluMTIuZHRzaQ0KPiBpbmRleCAw
Nzg1Mzg5ZjU1MDcuLjU1NmYzNWNlNDllMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MXNhbTluMTIuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOW4x
Mi5kdHNpDQo+IEBAIC0xMjYsNyArMTI2LDcgQEAgcG1jOiBwbWNAZmZmZmZjMDAgew0KPiAgCQkJ
CWludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkJfTsNCj4gIA0K
PiAtCQkJcnN0Y0BmZmZmZmUwMCB7DQo+ICsJCQlyZXNldC1jb250cm9sbGVyQGZmZmZmZTAwIHsN
Cj4gIAkJCQljb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05ZzQ1LXJzdGMiOw0KPiAgCQkJCXJl
ZyA9IDwweGZmZmZmZTAwIDB4MTA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmY2xrMzJrPjsNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05cmwuZHRzaSBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2F0OTFzYW05cmwuZHRzaQ0KPiBpbmRleCA3MzBkMTE4MmM3M2UuLjEyYzYzNDgxMTgy
MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlybC5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05cmwuZHRzaQ0KPiBAQCAtNzY2LDcgKzc2Niw3
IEBAIHBtYzogcG1jQGZmZmZmYzAwIHsNCj4gIAkJCQljbG9jay1uYW1lcyA9ICJzbG93X2NsayIs
ICJtYWluX3h0YWwiOw0KPiAgCQkJfTsNCj4gIA0KPiAtCQkJcnN0Y0BmZmZmZmQwMCB7DQo+ICsJ
CQlyZXNldC1jb250cm9sbGVyQGZmZmZmZDAwIHsNCj4gIAkJCQljb21wYXRpYmxlID0gImF0bWVs
LGF0OTFzYW05MjYwLXJzdGMiOw0KPiAgCQkJCXJlZyA9IDwweGZmZmZmZDAwIDB4MTA+Ow0KPiAg
CQkJCWNsb2NrcyA9IDwmY2xrMzJrPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTFzYW05eDUuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05eDUuZHRzaQ0KPiBp
bmRleCAzOTVlODgzNjQ0Y2QuLmVhM2IxMTMzNmM3OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MXNhbTl4NS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05eDUuZHRzaQ0KPiBAQCAtMTM0LDcgKzEzNCw3IEBAIHBtYzogcG1jQGZmZmZmYzAwIHsNCj4g
IAkJCQljbG9jay1uYW1lcyA9ICJzbG93X2NsayIsICJtYWluX3h0YWwiOw0KPiAgCQkJfTsNCj4g
IA0KPiAtCQkJcmVzZXRfY29udHJvbGxlcjogcnN0Y0BmZmZmZmUwMCB7DQo+ICsJCQlyZXNldF9j
b250cm9sbGVyOiByZXNldC1jb250cm9sbGVyQGZmZmZmZTAwIHsNCj4gIAkJCQljb21wYXRpYmxl
ID0gImF0bWVsLGF0OTFzYW05ZzQ1LXJzdGMiOw0KPiAgCQkJCXJlZyA9IDwweGZmZmZmZTAwIDB4
MTA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmY2xrMzJrPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0K
PiBpbmRleCBjMzI4YjY3YmVhMGMuLjZiMWQ0NDkyNDQ0YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4
NjAuZHRzaQ0KPiBAQCAtNjY3LDcgKzY2Nyw3IEBAIHBtYzogcG1jQGZmZmZmYzAwIHsNCj4gIAkJ
CQljbG9jay1uYW1lcyA9ICJ0ZF9zbGNrIiwgIm1kX3NsY2siLCAibWFpbl94dGFsIjsNCj4gIAkJ
CX07DQo+ICANCj4gLQkJCXJlc2V0X2NvbnRyb2xsZXI6IHJzdGNAZmZmZmZlMDAgew0KPiArCQkJ
cmVzZXRfY29udHJvbGxlcjogcmVzZXQtY29udHJvbGxlckBmZmZmZmUwMCB7DQo+ICAJCQkJY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1yc3RjIjsNCj4gIAkJCQlyZWcgPSA8MHhmZmZm
ZmUwMCAweDEwPjsNCj4gIAkJCQljbG9ja3MgPSA8JmNsazMyayAwPjsNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1
ZDIuZHRzaQ0KPiBpbmRleCA4OWM3MWQ0MTlmODIuLjYwOTc3YmZkODU2MyAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3NhbWE1ZDIuZHRzaQ0KPiBAQCAtNjYwLDcgKzY2MCw3IEBAIHNlY3VyYW06IHNyYW1AZjgw
NDQwMDAgew0KPiAgCQkJCXJhbmdlcyA9IDwwIDB4ZjgwNDQwMDAgMHgxNDIwPjsNCj4gIAkJCX07
DQo+ICANCj4gLQkJCXJlc2V0X2NvbnRyb2xsZXI6IHJzdGNAZjgwNDgwMDAgew0KPiArCQkJcmVz
ZXRfY29udHJvbGxlcjogcmVzZXQtY29udHJvbGxlckBmODA0ODAwMCB7DQo+ICAJCQkJY29tcGF0
aWJsZSA9ICJhdG1lbCxzYW1hNWQzLXJzdGMiOw0KPiAgCQkJCXJlZyA9IDwweGY4MDQ4MDAwIDB4
MTA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmY2xrMzJrPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL3NhbWE1ZDMuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDMuZHRzaQ0K
PiBpbmRleCA4ZmE0MjNjNTI1OTIuLjJkMDkzNWFkMjIyNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtYTVkMy5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1
ZDMuZHRzaQ0KPiBAQCAtMTAwMyw3ICsxMDAzLDcgQEAgcG1jOiBwbWNAZmZmZmZjMDAgew0KPiAg
CQkJCWNsb2NrLW5hbWVzID0gInNsb3dfY2xrIiwgIm1haW5feHRhbCI7DQo+ICAJCQl9Ow0KPiAg
DQo+IC0JCQlyZXNldF9jb250cm9sbGVyOiByc3RjQGZmZmZmZTAwIHsNCj4gKwkJCXJlc2V0X2Nv
bnRyb2xsZXI6IHJlc2V0LWNvbnRyb2xsZXJAZmZmZmZlMDAgew0KPiAgCQkJCWNvbXBhdGlibGUg
PSAiYXRtZWwsc2FtYTVkMy1yc3RjIiwgImF0bWVsLGF0OTFzYW05ZzQ1LXJzdGMiOw0KPiAgCQkJ
CXJlZyA9IDwweGZmZmZmZTAwIDB4MTA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmY2xrMzJrPjsNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDQuZHRzaSBiL2FyY2gvYXJtL2Jv
b3QvZHRzL3NhbWE1ZDQuZHRzaQ0KPiBpbmRleCA3YjkyNDI2NjQ4NzUuLjFlNWMwMTg5OGNjZiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkNC5kdHNpDQo+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDQuZHRzaQ0KPiBAQCAtNzI2LDcgKzcyNiw3IEBAIHBtZWNj
OiBlY2MtZW5naW5lQGZmZmZjMDcwIHsNCj4gIAkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAtCQkJ
cmVzZXRfY29udHJvbGxlcjogcnN0Y0BmYzA2ODYwMCB7DQo+ICsJCQlyZXNldF9jb250cm9sbGVy
OiByZXNldC1jb250cm9sbGVyQGZjMDY4NjAwIHsNCj4gIAkJCQljb21wYXRpYmxlID0gImF0bWVs
LHNhbWE1ZDMtcnN0YyIsICJhdG1lbCxhdDkxc2FtOWc0NS1yc3RjIjsNCj4gIAkJCQlyZWcgPSA8
MHhmYzA2ODYwMCAweDEwPjsNCj4gIAkJCQljbG9ja3MgPSA8JmNsazMyaz47DQoNCg==
