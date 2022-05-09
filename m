Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1F51F4A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiEIGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiEIGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:31:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217BB149129;
        Sun,  8 May 2022 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077638; x=1683613638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zg8Z3zEDsrt8BgfHAUrUbhwExQSBwtCmBFsnfQcRV0M=;
  b=QGf3qBTh7sTuDk2iKykXXCpy5nVMhKRez1t1sOn0dZoO2sjAghtOXH3c
   857Kdp/uRG+kQ+U6iifxJffDjZUVsr4xxoUlhml1JaS2ovj8b3L2mvHcv
   aCHi3OUOj1uUiJ0D28uIP2zZckSeg8ugYMq+27TJ0i0es5inMhaDnJyNe
   qPLXh3ZbwmzTuyMzO6myrgBGzqlac+HIAJlKGYmUgRBl4+aBCKqTrAKy3
   HmGZ0SPF7xrO+vnyQA6SFOvfHxzCHuaNKoj6y4OXG9qNiTZEribChD9H0
   WyIfFrROsde28N3rNSzpmDoq6mzpdLjpcT1SQHVkbT65EsLuARDbDcvlE
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="155245179"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:27:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:27:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 8 May 2022 23:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGNXGbfZRtSyH3VKJXoycY3g/tM00w7BweTteDF42CqW8wrZPM1e7fnYkjOKx6NYTdH5IecAAfzNZtx1DVoBAHIWh1WUwOCURNYIL+K+HHxqRbZ2AiumErJTwYgC0E74YynkF32iSlKULkZPuDdCq1WvG7a8wWy5UjJ8KPxhLB3Y4OEN9v9naXX9JB+7Lw/42obYiwJX3DnCB3W8ETx6fsMx39b2jV1CchW5BqB8m/h22NjlmP+y3I6DyNmO0SxGPDoDtM2m9RXNAhgybqZMawtdsI8IMAXghtTh9MiAC8iBerI0eRUpm5ddvv4MVP0B0OdB4dPdqiDXhpXf5gwjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg8Z3zEDsrt8BgfHAUrUbhwExQSBwtCmBFsnfQcRV0M=;
 b=PU13rNoKGA4paS9C4F46qOvyie66idMwBZBL22Sp43KPVnotZT7cOXqg21y9059GRYf2ernzAtQRHT/a3b44nClQrz0Glcjsd8OfdPzMT7ZISyPbnHmn1KecstLSxA6QCmZl6gVbvxpjUe8UEWEwE7FqSrBAgD8tyLJqlKV0jVP1FYY5Jt3JBlUpCcuodNIDMt48mcjJELjt+sImXChhrQ9E/9Vw0sKklhwZ6BlH9EYyweNSN0dOf2lzkqP/ELDOcyk2am5rY3jLO03xCp7Bq1k5TSW39qGmxENvStgpqDjkSPYWD8eUKUN8XH8eUu11rBys3qaoFd0KgNErG9TS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg8Z3zEDsrt8BgfHAUrUbhwExQSBwtCmBFsnfQcRV0M=;
 b=lk1vxDmSfFwVLD0wt4+4jlTjqh+iTrKyvq9u2IR2gqdsGg5dGZz0cXa57B5XT02OZbfMRBCu+b0+F5XtgtLQ/imBIbV0wNPE74S4NKBR4+bw5L+4zNghNAoG8nt39zxGHBt6ovVnjdx2yyvyWDxgemt0MwFrbE61a/eQrtMmPV4=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 06:27:00 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:27:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 12/13] ARM: dts: lan966x: add switch node
Thread-Topic: [PATCH v4 12/13] ARM: dts: lan966x: add switch node
Thread-Index: AQHYY23Kf2+vGvbFJkmfKhwu1M9V7g==
Date:   Mon, 9 May 2022 06:27:00 +0000
Message-ID: <02aa403f-d445-5e22-d169-13180288f049@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-13-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-13-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd5fb9b8-ee1f-4bf9-7987-08da3184ecbd
x-ms-traffictypediagnostic: BL0PR11MB3299:EE_
x-microsoft-antispam-prvs: <BL0PR11MB3299E84AEF7CD200739699FC87C69@BL0PR11MB3299.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHt9uwDgaN9rnHS9JaWnl+PYTTH3g6f5607DBL9C5+7aUJBceGYo58D3z0czQK8Ud9CT2rrv528UmUz8taa4EN0J0QxggIeHJNzIe4qCObKIQxV74ZjMO/koVhU3V8gifbV7fCJryCS2Qrr3oVC3Qkgg691aYxnvDSRlibdZbSQ34aKS/zA3X+SvdIAvQj50V52sdcHu5DpRX+6aRI4IvuWdVQKGgt16Qd5A9NuV/V7MpNBsGWnIDZhYBo24AAy1kiuslmVgtdD9Ivf88WnHMU48LGjNKGtWc0p6atJxR55AVKfMONNqk4Q0SNb4MWmoNpM1LaVlxXS7ny5qDpHe8dj4T0QFfYoPJ9N09RAhzpOfm8frjRkblsviUIS48j2SJu0rtTwPNRHSlhNxYeYQnlXOy2vXARw2STkRgjzAU0jMG49detnt6LcOZQtsgCpy7mKGcXUr8ZkrYwPiJWh688hsztELporxP8WVwZ5sK0H5uzFxOR6KmWAAhP0kbVpDadOrVZKy/wEIgx21OF1v+leIil+xJuOTfzFj0QLcpaXDlVaZ91mz/rGXdm3yDhtilv2e/05r1VYq+9d/dX4eioFnlvlgzb//49tmhINOFOcEkdf9y8c0RLgPWx5ME2hsUeHNb4ji210WOPZJlimKF3Ha2cA5zDBjFNLS9RZl8SBrZKTSHJTFxidwzVpn4GVM9fYseuEV782XQxhwzr80FMhep5RQ/SxODvxWm1coN6cfxPavm9JzrftvhBhaF7ZQHWScWNgtNcuNWJktByNEcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2906002)(76116006)(91956017)(4326008)(64756008)(66446008)(36756003)(8676002)(8936002)(71200400001)(86362001)(5660300002)(66556008)(66476007)(53546011)(26005)(2616005)(31686004)(31696002)(66946007)(107886003)(6486002)(508600001)(38100700002)(38070700005)(54906003)(122000001)(110136005)(186003)(316002)(6636002)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFdyVzlxL3BkQzFyUGxZamVsbm5yK0ZNamJMVldiVEVmTTNaYnpxd0wvbmh6?=
 =?utf-8?B?djdWU1FwS3JLdkkvTU1TZnMwdmhNb1ZSTi93eXZtTnI4aHpyd3FWMldLVGo0?=
 =?utf-8?B?QSsrNWlhOG9JeXhrZ1dMQXdmMkVmU21UOHRQVldJL240ay80ZlpHQ3J6eHBw?=
 =?utf-8?B?NXdTdmVJUVVSbFJKcDA0RXZ5YkFBM3YvUU02REZuMTVEUUlvaFJ0TWdTQmx3?=
 =?utf-8?B?Z1RJbU9waXNKbzIvVWJSMXd2RjNiNGVralRNUzk5VnNBSmEzcllWYkJOREhV?=
 =?utf-8?B?UzFxWWphbDRBMDlCSXcvbFBTbjRyOHdQRy9hSjR5cGErazFyRU1lRmljbFV1?=
 =?utf-8?B?OGNvZitybkYyOUdWQlVSeDVSTm90ZXA5V2ljTlk4Y1ZsbkNwZlA3dkRKTjNk?=
 =?utf-8?B?NFBjYStQRVNRdnl1aUpZZ0xjaDZ3TW5SVkRQSFgvdVpybWhlRWtMMzYvVlRO?=
 =?utf-8?B?aGtPNkdUZHVINUZ0UU1heW9UeXpiNERpMUZPdldJM2FKNDZtaFBkZXJFMjlH?=
 =?utf-8?B?WHp4Z2IwRnh6Z041cWZzSVlFM1FWVUFrc1BpSE9wQ0RURGlZWjZQSlpMc1Y1?=
 =?utf-8?B?TmJmY0tpazI0dVd4Q0YxY2lGY3RQemVERVFnK1pEeHpGbCtRU0NiN2ZXWTZQ?=
 =?utf-8?B?S3lxZnN6UTFwV1E0cGlxUmw5S1ozMTE3ZlJ6SGJUY25rL0ZHTEgwK1VKZW1D?=
 =?utf-8?B?QVZKd2ZYUWlDbUppd2dkVXBiMXpObHg3bTZqaTdqdVlacUk2c21DdUhFYU9m?=
 =?utf-8?B?alVOVi9HSWk4Z1h0dmVpWFEzRGRUMWNDalZMeVk5THhaSWZhM0VTaGtUVC9q?=
 =?utf-8?B?aHJhM0JHV1JESDdpSmJhdEx1SURrWkhCR3RQV3VxWmlYZEJ3M0lHdHRQRGNx?=
 =?utf-8?B?VDduVXZ1MXZvQzFsMWwwY0tRdVZoditQcythdFNKc0hwalIrY3BnRzNodjNz?=
 =?utf-8?B?UHZ2UXR3Q0UxMDMrcVRDYzNFWmF3eTViREV1ajM1WW9DVXg2V0V3OGljUS9U?=
 =?utf-8?B?cHpYdTNac01QUjA4bm5vaExiTnpHNHJjaHNuRDZoZXNtd2FnRG50OWptQ0x0?=
 =?utf-8?B?cC9UVmE3dER4MG94eWNoMHVmTmhGNUN6YVZRajVJd1k3N3VFWkJjd3F3N2dR?=
 =?utf-8?B?UVJjUkpjTTdtU0xHenA3UWNpWVBCNU02dGowc01OczlNNmFYekZaUjhzd1By?=
 =?utf-8?B?UDZjSGo1by90ckJKUFNJalUwUWYzNmluSDRlWXRKZTBGUHBmbi9QbW5xUG9O?=
 =?utf-8?B?OGZiajFUZjg1clJnblp6R0k5RXk2Tm9rWlFCZDZWbXF6YzV0WFE5aHdrZklI?=
 =?utf-8?B?WUMxZEIyYnYvQ3JHNEtBTWhURzdseDhxaDdqVFJCbm1yaDFlYitQZElsd1FL?=
 =?utf-8?B?R2RXNXdXVktHNzV3bGcvV2dvTStaQjBLSVBPWGY2ZUt2VEE5YTZsWjdDS01B?=
 =?utf-8?B?V20wQld6c2NWdWdIWDdZUHdPYWM5MTlrUGVrWlBzS1RkNC8xTVBQUEQxTzA2?=
 =?utf-8?B?ZnhQY2ZQU290Y1NmdGJ4UWlkc0tpK25NcDZwRHNVa2g0N1ZheTN4YXpPUG5O?=
 =?utf-8?B?OE55R1ZsbHVhd0p5Nmh4QzRRdi83WVVvQ2JTL0gxa0J1S0c1Smt2OXIzZEJn?=
 =?utf-8?B?QVBtcUVVRFpxOW41bU1SSlVFRGR2WXdGTTZxQVlpVkJKRUZCZjhYck1CQ3ha?=
 =?utf-8?B?N3FvUEZEL2RPS3VuOTN3ejZsSS9iVU14S0FvVlZYRkJKbGpvTjJmZ0trUXZt?=
 =?utf-8?B?OExvaytZZGJGT1NWdEhwMXpaK05WQ05yVExJR1V3NTR6UUVlWHZQSFMzYi9D?=
 =?utf-8?B?bWNOYkV2UmNtNUR2UVF3dWpxSVNYdlhQcnFLMlYrSUNOWFRncG1XUWg1bHhp?=
 =?utf-8?B?YnlpNExmTU50VDlLeitva00vQStYR0JxcllzYTBaUW1UREVDTnJ2cDVjWVZl?=
 =?utf-8?B?UnZFL1pQbzZ4cTRKQXdneXBQWS8wN2ZzbVN2M0NKOGNYZlFnbUcrUWtpQVQ0?=
 =?utf-8?B?MGphMXVDVmkzMWp2RUNmaFN4TE5uN2p5ZWVraHFoRFpSM2k2eVFtUmY4elYz?=
 =?utf-8?B?ejZLWFFTUFpSMlk1RFNYczROMnBPQk5wVEY1THRaWjhPZEhkei9yWmwxMFdJ?=
 =?utf-8?B?VXhKTDZoMG5VbE13NHZNY2grN0dHT2NOL040OCtlWTJOS21IU05TaW9PZnZE?=
 =?utf-8?B?ZytmaVJraW1PSXh3azFWNDRxTHRiUXVZY2M2bDBoR01jTXVvc0l6VDVpTU01?=
 =?utf-8?B?dm1CakV6QzRDcmlyUUFXM3h4N3dpNkVmdE5ubWtqTWFVNVNWYTNWbUxVVmlu?=
 =?utf-8?B?NzYzMUFlREd4NGRyRThGSVJYRGJMbmU3bkRlWGlKN3JKdXZJeVdYVjNLVk43?=
 =?utf-8?Q?Jn8J/gu6bAwKjzsI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D56092B99C031543A1A15F00ECBAD9F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5fb9b8-ee1f-4bf9-7987-08da3184ecbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:27:00.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toi3+X0+hpyT0UcyWaUmFb3ZTPEy8MC5KwTcwZ7neS/LQNIC53JJWW8KQVFXxW2TPF1aE96SCuvse+g1NYZJj0c9ag2rqtlcX+ZwXclYYVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3299
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIHN3aXRjaCBub2RlIGFuZCBpdHMg
OCBjaGlsZHJlbiBwb3J0cy4gQWxsIGFyZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCg0KUmV2aWV3ZWQt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCA2MiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBpbmRleCBkODE4NWY1YzdiZmMuLjM4ZTkw
YTMxZDJkZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBAQCAtODQsNiArODQsNjgg
QEAgc29jIHsNCj4gICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiAgICAgICAg
ICAgICAgICAgcmFuZ2VzOw0KPiANCj4gKyAgICAgICAgICAgICAgIHN3aXRjaDogc3dpdGNoQGUw
MDAwMDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsbGFuOTY2eC1zd2l0Y2giOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhl
MDAwMDAwMCAweDAxMDAwMDA+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHhl
MjAwMDAwMCAweDA4MDAwMDA+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMg
PSAiY3B1IiwgImdjYiI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8
R0lDX1NQSSAxMiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgOSBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJ
IDExIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPEdJQ19TUEkgMTAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGludGVycnVwdC1uYW1lcyA9ICJ4dHIiLCAiZmRtYSIsICJhbmEiLCAicHRw
IiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInB0cC1leHQi
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXNldHMgPSA8JnJlc2V0IDA+Ow0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJzd2l0Y2giOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGV0aGVybmV0LXBvcnRzIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBvcnQwOiBwb3J0QDAgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDA+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9ydDE6IHBv
cnRAMSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MT47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0MjogcG9ydEAyIHsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwyPjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gKw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBvcnQzOiBwb3J0QDMgew0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnID0gPDM+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cG9ydDQ6IHBvcnRANCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8ND47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0NTogcG9ydEA1IHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDw1PjsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHBvcnQ2OiBwb3J0QDYgew0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDY+Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcG9ydDc6IHBvcnRANyB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZWcgPSA8Nz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAgICAg
ICB9Ow0KPiArDQo+ICAgICAgICAgICAgICAgICBmbHgwOiBmbGV4Y29tQGUwMDQwMDAwIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhj
b20iOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMDA0MDAwMCAweDEwMD47
DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
