Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7295A2111
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiHZGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiHZGpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:45:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEFDBC80D;
        Thu, 25 Aug 2022 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661496353; x=1693032353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sd6PfDywk6lvq4YebIHAwSmPfr/Ved0dd68tbshK9Sc=;
  b=pxnVr1mHzrCiu840SExLwk5vlorNfTkEXhEIOJMmU+XpXN/nVrPYhz90
   2nyP610oSBZNZd8M/lDi6GTOqfeQ20htBrKyNpt4GPnAS5gfLUXkABV+1
   d+BKaJ2qRJXb8/lPkGn8TET81Ibm3LgKvfUGNN8tdWA9ZWqfFpH5QuHWF
   N2GT5dfROjADuVHNsT8qNwvpSkLA3L5coFJVsR2IxVWVP2vj9uT2byVQY
   Bt+scSW/7YgCQqFIs92WqsrkPv032lhvNpH/KMQFtDER/ioKdguv3CAsB
   xFz2SE3VKplhhag7FICb+V2obrWVebRTMpsEOd2GJTkriFaYriPnJXfEy
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="174267705"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 23:45:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 23:45:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 25 Aug 2022 23:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEdm792XqP3/7GId6L/CvoI01Rs8K5Xngdj8oc93VH/FpZRbn9MEsRt8ckLEvRMYa6H3gj2pXq1uLif5yjBkU7QStC2ZKdRKYSrd0DvdJfu2mIwU20qnn5Wse0ZXZ1qwM4LROLMNHwT3wIMp2/PhqiyUMjaWoxbJtPeaJDxMN6ZBnQqwibpJdYtgD8iiZXOXNf+v9+P0BL/oU9NNnZIzEgTn93hCcwrVlZBX/iFU5yrLF/jTQ1J12k6PrVQdh0N+tY+wzWheCew5L3FchEk7ex1sH7w9YQ6i06gdJmDfZ0HPDLcp1dZfl/7Z2MVKFgJhcif46ESADczkVphH/B4i6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd6PfDywk6lvq4YebIHAwSmPfr/Ved0dd68tbshK9Sc=;
 b=n2T3EKDtydIXv8uKzo/mQfYZl1/34UI5D6TZI8THUs6S3N+3QTWjlwQnnKtqDlXrc/x/JLG+P4gFkLGo88jglfABmfQLNec5o0A3g9XOcnVrRnH0H1Op0xOc9XtO8fxcHnFewRCnO5iRk+Z6jgWH1at9HpE9W8ZDzWWJDxpvd361pGRTscjbm9DO2dYr9vum0H+vV+efOQXFPdVl4w46Aob3eKenzf/fOmJ41WkaMkw0pZSSXK6YyZdNSmafwiaj8reNVgJ4wk2aGUGdH+Sk79ntRhlqFeK9Oiw0UluNZEO/0hcKc7sxLt0EoGKsoQI+fo244T7mFXpHJ67r3B4EMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd6PfDywk6lvq4YebIHAwSmPfr/Ved0dd68tbshK9Sc=;
 b=lLcZEobmidPn3MaLX5RtkFxQljaRYozpT5Q8ew3QvQ3MOpUciBRm2P9g0qB05KXoBTZqsLe4zW+9kkCSBl33rufFKJjei421no8giyWiQlzC4L/fn/4yoI9MKDtNEl58V9Gr49hWJ2dYi8ORd0WKQF58N9zF6LmFHeoeWpCsXak=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 06:45:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 06:45:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>, <Hugh.Breslin@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/5] clk: microchip: add PolarFire SoC fabric clock
 support
Thread-Topic: [PATCH v3 4/5] clk: microchip: add PolarFire SoC fabric clock
 support
Thread-Index: AQHYt5zPMZ6mCAaqX0KQWgTJq6Bcaq3AvrcAgAAA6gA=
Date:   Fri, 26 Aug 2022 06:45:45 +0000
Message-ID: <9d41350f-2558-36fc-9863-2d55ecd48b06@microchip.com>
References: <20220824093342.187844-1-conor.dooley@microchip.com>
 <20220824093342.187844-5-conor.dooley@microchip.com>
 <6764b456-2e06-54da-2bbb-1efda2dbf52e@microchip.com>
In-Reply-To: <6764b456-2e06-54da-2bbb-1efda2dbf52e@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399534c6-627f-4cf6-caf6-08da872e9a38
x-ms-traffictypediagnostic: MW3PR11MB4732:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgadjTGs4EYKAL44OYd0kctq6JlaQEn0puhQ6ZAqFI6W+n4KUw8IqpObf2wav9KgUpEkasrikXSbCVJU8kCS4E5Mh+dkbrucD0VGpOcJ4NaUCMwRXrnzNoGN14Pj+TIfs0B4S8Q89UTXVw5Myx5/uNn6rlY2TpYq9f2g8WnAv4rSX4WCD/FqdL5izehDdSDXZppPfuUUZa5DabyM4ZBIK7APdpTfKAfyPUa7SK4G3sC46paEdAzRy2G+4+E1hXj/sa8OJYf/fo41lPaVLjeBR5gJvpEGeU1a8Psx3xogMIvYC/nkXa1hoz8k6wGLzgg8dT2QePeRXuAe7yZtGEao1iXvw1l37w2RcjDDsns8hii4nsgEk5KUtzikT9xAcFix1AuE16GMd9EKhCsllxPOXp1wq9OYHs/PIA8bi+SkftQ6j++1XVrJR5//CTOmwl2QlgiTN19MDDOcsiEN1qhT6J6+2U/BUgN4VFP2t77FaikWd356wDIlay8I9iEDx7ftQrCFNhyRjBZzvwZgQmdPb8piOHfI3lGZgvf1x9eQiotf+u9nHNPDE+1X1bD4tnFoNvNfKg+Dm8v+uD/cTxor2RlsCqMaC2Bvb1BS8QzqD0Tek/redH2IAbtWmEIDaSXNzKuX1t75JYUn9PpJ1cWw463x28n9fscSZ3Y+qtjFClR5xItpqOFe10dzn/U0Zwz91rwAJ/YBKVD1nzZoOVuVkEXP912uh3rgsIGwHNvQx3GNV71iEiisjmP/6A7CjAkJ2wK23evAQUUKlV9ncMuwK3fYOAM/fwxmwntlOrGQb8mfiVirfuyw7aZa6R2puDqonkXgEdc0yWdIz1e5ewRWPhYoNMVdtnIcocy6vpAIYOA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(376002)(396003)(83380400001)(6512007)(53546011)(26005)(2906002)(186003)(2616005)(31696002)(86362001)(6506007)(38070700005)(38100700002)(66556008)(66446008)(122000001)(478600001)(4326008)(966005)(6486002)(64756008)(66946007)(76116006)(66476007)(31686004)(91956017)(7416002)(8676002)(5660300002)(8936002)(110136005)(54906003)(6636002)(316002)(71200400001)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFwNTZOZG55aTZ0Q09DQXZsdzZWcFhEaUhpZ1ZtdU5WeDdkRWM5bVJaWGhj?=
 =?utf-8?B?amx2dVk3dC9ZbXF6em9UUUFiNGdMTVIzOUxQd1B0UGJVZmtkM2NDeFhFUDJU?=
 =?utf-8?B?QTZoNk1nRFJET2J3R2xma2tZa3hLOXpZVmpoZmJKdW9RSnpFTUlWUUtJcHBB?=
 =?utf-8?B?S1JUTnhKZUJkMzlUMXh4L3BmR1U0cENlOUdZNTdzNXFabVozUmlwdllnVzBT?=
 =?utf-8?B?RE5EWVcxNUNPOFo3bi9UYjBYTFhLYkpLQnpwend6SjFLRCtZOWVQdE1BbzRs?=
 =?utf-8?B?Y3NnQW9jMUZ0aGlHYkl1bk9XV1d3enpzM0NFVzh4aEtUVWRmSjNMbU5EWWVw?=
 =?utf-8?B?S3RrWURyWVQrRWtvN3dJdkkzS2IrVXlodGN3Ynd5L3pBYzNtMlluV3J0TlJP?=
 =?utf-8?B?Q1BrMHRQd3g1RlhKMnMrclRpMjdYK3M0V2JUOHNVMmVmTGNOY1dYZk5VU2lj?=
 =?utf-8?B?N0o2d2pJd0Y0RXc3YlUxYUh4Y3ZuU04rUEcxSDIxajRNcVMwMGszQTY2NVFo?=
 =?utf-8?B?Qms2SWwxUVZqUEtCNEtxbERpV3RYb2ozT1dOOEV1dDZTak8xYkhqV296N2lK?=
 =?utf-8?B?V0ZodkRoMDhwSk5xY2tZNDlhMlZwZ1JRSGl3UExzSDJZUzFHdEJBTWxvbjRH?=
 =?utf-8?B?OVhOVG9kZUhMenVQM0Q1YXpLYzQ1c0hkdGdjekpKNG5hRDJ5UTZWS210bE9v?=
 =?utf-8?B?NjVMVnhkODd0ZjZCdjRpeGFGUTdZcEZRL3haNEk5ZjhxejRwNm9YTmp6amVL?=
 =?utf-8?B?N3VrOTg2WEtoTFROQ280QnZ4R2k1WU1RaHQ3bEZkMnNpRmpDRjlJNjNhWVo2?=
 =?utf-8?B?a3RlZFhsUytRVSs3ZXZwMzNoUllZN0ZQTnFGcXExaXdUUk1MWGlKQXZvUVRx?=
 =?utf-8?B?SFJUNnBQSjVyM21HTXpFdGVUd0lsQ3cvWk5ueEtxNHdTT3BHcGZqKytPcElX?=
 =?utf-8?B?cy9vbEROdW4vamRUcXRIL3hpV25wSGtGM2FHRGYycHF6ZzgwOTJEcy96SHFx?=
 =?utf-8?B?aTcvQ3VZS3grUy9BR2dta1hkd2ZmMko5NlpadkZhaGdMS3ZUOGVlVjZDcDJZ?=
 =?utf-8?B?cExUbVpHbnRqL3IyZWxRZWNueWphWnA4eTZRNDFGWktBaEUxdytKOGsyN0ZD?=
 =?utf-8?B?YW9yZ3hLRlNGcTZJejNLVWF2NnY1U2g1SXFQWWxpc01sU2VyZHdLMFMxaDJi?=
 =?utf-8?B?dUM4MWVxdjVRalA1bHRQQTVQKzNRbmxZM3J4N25QdGJZQWx5V2dzN0lFd2oz?=
 =?utf-8?B?Vlk1YzdnWDlBL2ZCcFF2c1hZb2RHai9RcTd5UHcvWUtKckhRUlpZYUJJQVI0?=
 =?utf-8?B?NGxueGl6RlV3NnFyelR4Y2twN0V4a0x4dW5vN0M3cUVRU0g2cWVYNzVvNzU1?=
 =?utf-8?B?OVdrelB0RnRYeEdjeEFVTVd4eURzSS9OOThxYnBkN1JCZkN0aHoxek1pS21s?=
 =?utf-8?B?MDFoWUVIMkNIS3pabTJYNGdxYWI4MU1IRXRKeXlIL0h6VjhjMHIveERwa2d3?=
 =?utf-8?B?L2E0a0RuTWsvUUlpVDAzdVJTRDlEWmsvbXZ4VkExSXM5S1JyVXFKNUw1QTBR?=
 =?utf-8?B?bTBGdGtkMzV4L1krK1BIeVUybHhLbUZKT2ZLblNYNXdSVkRIZSt1T0dPMUxK?=
 =?utf-8?B?blU5a0prODhUdWxVQnM3NDMwbWpSK3FIdzVzangzMkZPYU1Rd0xod0xySyt6?=
 =?utf-8?B?eFZWcGVJLzFqUzV5L2pqdmMwTmFyTjVxeDUzOWVHTXRteEFHcFhyODZvKzZ5?=
 =?utf-8?B?c3VJQmEySUJTdW1PRlpscWZhWFA4OWQrSHlxcVhmZ1BuMjNtT0xPK05rMnN0?=
 =?utf-8?B?NzJwZEhuRm9XZnNOcWtlcm1WM2ZYazBTWTUyczl1STlIYzZ5T0tzWE85aWZZ?=
 =?utf-8?B?SVg4KzB2dUk4aS9CRmRJME54SFZvdEJmaDFrOHB2dnprekN5UFByYmd3aitx?=
 =?utf-8?B?UEFPc052THM2R0hMTlJkYjVZem5ObWRWaG1WR1RjVi81Wkxyb1U2bGhscTdr?=
 =?utf-8?B?Y0VzUFJCVFpIZXIzZXBIayszTmVGV091anEzZ3RPTU44MTVHQlVLeTNOTmlR?=
 =?utf-8?B?M1dCYXlKcFdzbWxrVnRNSVllL0ppTlphU09OeDAvbmo1N21Fc1VNZzEzVXpa?=
 =?utf-8?Q?vsh6jDcD8JF+YXjpEwx1QVDRk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D2927EDF3FD594DAFF6AB7BCB315F0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399534c6-627f-4cf6-caf6-08da872e9a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:45:45.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXmIcR+f5nlGVxUSc9Nbz61mKO2PRds8T+VKM6nC3IEo8oyy8tI2WyOpwQ7RniZzC8oLIlqsXvmdj/iaEcJhVGb5A1CRW+nZsRAcmGLqwnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDgvMjAyMiAwNzo0MiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDI0LjA4LjIwMjIgMTI6MzMsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IEFkZCBhIGRyaXZlciB0byBzdXBwb3J0IHRoZSBQ
TExzIGluIFBvbGFyRmlyZSBTb0MncyBDbG9jayBDb25kaXRpb25pbmcNCj4+IENpcmN1aXRyeSwg
YW4gaW5zdGFuY2Ugb2Ygd2hpY2ggaXMgbG9jYXRlZCBpbiBlYWNoIG9yZGluYWwgY29ybmVyIG9m
DQo+PiB0aGUgRlBHQS4gT25seSBnZXRfcmF0ZSgpIGlzIHN1cHBvcnRlZCBhcyB0aGVzZSBjbG9j
a3MgYXJlIGludGVuZGVkIHRvDQo+PiBiZSBzdGF0aWNhbGx5IGNvbmZpZ3VyZWQgYnkgdGhlIEZQ
R0EgZGVzaWduLiBDdXJyZW50bHksIHRoZSBETExzIGFyZQ0KPj4gbm90IHN1cHBvcnRlZCBieSB0
aGlzIGRyaXZlci4gRm9yIG1vcmUgaW5mb3JtYXRpb24gb24gdGhlIGhhcmR3YXJlLCBzZWUNCj4+
ICJQb2xhckZpcmUgU29DIEZQR0EgQ2xvY2tpbmcgUmVzb3VyY2VzIiBpbiB0aGUgbGluayBiZWxv
dy4NCj4+DQo+PiBMaW5rOiBodHRwczovL29ubGluZWRvY3MubWljcm9jaGlwLmNvbS9wci9HVUlE
LThGMENDNEMwLTAzMTctNDI2Mi04OUNBLUNFNzc3M0VEMTkzMS1lbi1VUy0xL2luZGV4Lmh0bWwN
Cj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5j
b20+DQo+PiAtLS0NCg0KPj4gK3N0YXRpYyBpbnQgbXBmc19jY2NfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBtcGZzX2NjY19kYXRh
ICpjbGtfZGF0YTsNCj4+ICsgICAgICAgdm9pZCBfX2lvbWVtICpwbGxfYmFzZVtBUlJBWV9TSVpF
KG1wZnNfY2NjX3BsbF9jbGtzKV07DQo+PiArICAgICAgIHVuc2lnbmVkIGludCBudW1fY2xrczsN
Cj4+ICsgICAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgICAgbnVtX2Nsa3MgPSBBUlJBWV9T
SVpFKG1wZnNfY2NjX3BsbF9jbGtzKSArIEFSUkFZX1NJWkUobXBmc19jY2NfcGxsMG91dF9jbGtz
KQ0KPj4gKyAgICAgICAgICAgICAgICsgQVJSQVlfU0laRShtcGZzX2NjY19wbGwxb3V0X2Nsa3Mp
Ow0KPj4gKw0KPj4gKyAgICAgICBjbGtfZGF0YSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBz
dHJ1Y3Rfc2l6ZShjbGtfZGF0YSwgaHdfZGF0YS5od3MsIG51bV9jbGtzKSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+PiArICAgICAgIGlmICghY2xr
X2RhdGEpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArICAg
ICAgIHBsbF9iYXNlWzBdID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAp
Ow0KPj4gKyAgICAgICBpZiAoSVNfRVJSKHBsbF9iYXNlWzBdKSkNCj4+ICsgICAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihwbGxfYmFzZVswXSk7DQo+PiArDQo+PiArICAgICAgIHBsbF9iYXNl
WzFdID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEpOw0KPj4gKyAgICAg
ICBpZiAoSVNfRVJSKHBsbF9iYXNlWzFdKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRS
X0VSUihwbGxfYmFzZVsxXSk7DQo+PiArDQo+PiArICAgICAgIGNsa19kYXRhLT5wbGxfYmFzZSA9
IHBsbF9iYXNlOw0KPj4gKyAgICAgICBjbGtfZGF0YS0+ZGV2ID0gJnBkZXYtPmRldjsNCj4+ICsN
Cj4+ICsgICAgICAgcmV0ID0gbXBmc19jY2NfcmVnaXN0ZXJfcGxscyhjbGtfZGF0YS0+ZGV2LCBt
cGZzX2NjY19wbGxfY2xrcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBUlJBWV9TSVpFKG1wZnNfY2NjX3BsbF9jbGtzKSwgY2xrX2RhdGEpOw0KPj4gKyAgICAgICBp
ZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICAg
IHJldCA9IGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcihjbGtfZGF0YS0+ZGV2LCBvZl9jbGtf
aHdfb25lY2VsbF9nZXQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmY2xrX2RhdGEtPmh3X2RhdGEpOw0KPj4gKyAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBZb3UgY2FuIHNraXAgdGhpcyBvciBldmVuIGRp
cmVjdGx5Og0KPiAJcmV0dXJuIGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlciguLi4pOw0KDQpU
aGF0J3MgYSBsZWZ0IG92ZXIgZnJvbSBjb3B5L3Bhc3Rpbmcgb3VyIG90aGVyIGNsb2NrIGRyaXZl
cidzDQpwcm9iZSBmdW5jdGlvbi4uIFdpbGwgc2ltcGxpZnkgaW4gdjQgLSB0aGFua3MsDQpDb25v
ci4NCg0KPiANCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQoNCg==
