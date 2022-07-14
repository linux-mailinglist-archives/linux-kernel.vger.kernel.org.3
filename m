Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C43574CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiGNMFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiGNMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:05:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225745C379;
        Thu, 14 Jul 2022 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657800311; x=1689336311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SepcEVx75aArn6+4bP7qOFMeNsSLMc4O7jPoyMk5dBw=;
  b=mM/BorIt8WQdTqTIzkK56VNscN7N+VxhGX9fuDSa8e1lVWwH6lw5Cp/O
   QBNQPPf6s8IWk4QaS1u3dtY6VNC9b9nL3MMaxp/TkWXjrsHGbfr2zOakb
   +DUmkB+htl/sDt4zQ0jDo/D2qLtdl+hdJdEvlGKvgk/hsV7Bs027MG2kj
   p9QGSy0FSxLZG4n4HeLGZ1FWD2TcqhO+2ZAM4w2VCcmiTWyzdG/VarQJa
   PxIcFU4yUfFlZXKemdON4hb410cKgD6TQBlqd44D/KTzB+iyamW9P93vQ
   vwzepLbp7DFuJJqoYV6vqEh+6LSlDlnDCt+qzhD3y9Ygd2ZzsWOKQcccI
   w==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="172104985"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 05:05:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 05:05:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 05:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXcMD1qZOvDJmQaxnVqiniwokZDzWI/gqHPK8ytk/al1itQxQvBy7CZpeVLz/uYTau3hqJE4jegv4zJ1Ll4c1EmufJ52GEHKNaJle+tBOl9ppGESFO2hGg9zaYj7Hu40xyDMQdRd/jb+41dze+JFm+UlslStrqk7JlwbSQ+jh0Jd4/xlHmhit58a4LM61G5+QxMVWEHZG4MWmG91MIwMMIUVUE8LsmJoeNH6qSuAltvmFl077TOCLWODvRrqJJ/8X/PNoU/uVneisM7MH0LL424fLW3MSlceJblH/2cwYMtAAm1xvYkb9qCRyEbS3eUy2od5d7r3n1QtHKJp78YYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SepcEVx75aArn6+4bP7qOFMeNsSLMc4O7jPoyMk5dBw=;
 b=jqZTu8Tc5M0MVYCEJbOaA8F0L20tpuQdvoUq/kRAKm0IiNiYDMaCEG7SZ4j8C1gFRXuF6ZrLClEwbFWSKLMU/QkASNaupzG2WCOLoqruJsHq2JKSzEqcVzSR4YH3Sq2BR14X8ibRXcmNh6YSa87BaPRjDj5isxOG+9Qgo6KdL0bbOJu9yRbK6X5CqSukRdUkn9SVYv31DKFNCPcN0zRtLLZpdTrtUPGa4ayGXXTIVKV5fshqStFLMEA5Oz58Ns0GFtwewPEWrxf2yet2eh89S/yvLRiUkQNACgxzvY/vVXvBDXepn4QbMzqVZLHvxHajjmSYR5BeNHSQA9oB2ZKajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SepcEVx75aArn6+4bP7qOFMeNsSLMc4O7jPoyMk5dBw=;
 b=CHdC2PhRA9HGG7QlM8HtVuFlTT1NQ1x8IOwL+d1pUNL52uqHlfiLvZrT3oqqZNDNsG3hgPiblwOkxpApj2MwGEHQh0U9XuhukNYrkuwE0dhFzRJaHX2fhuq2fj6rSdze/9zIa61PGy4n2PYtK4AHnyKNL6jTbpd3qutPMEDvKUU=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 14 Jul
 2022 12:05:04 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 12:05:04 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <Eugen.Hristev@microchip.com>
CC:     <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: dt-bindings: atmel,at91sam9-wdt: convert to
 json-schema
Thread-Topic: [PATCH] watchdog: dt-bindings: atmel,at91sam9-wdt: convert to
 json-schema
Thread-Index: AQHYl2t2nAb4q6S2iECK+sJovFKi8a19rZUAgAAXewA=
Date:   Thu, 14 Jul 2022 12:05:04 +0000
Message-ID: <c678bc8d-abb3-782d-875c-a91ab44b2cc6@microchip.com>
References: <20220714101242.103521-1-sergiu.moga@microchip.com>
 <df017bc8-3aa3-18e6-9632-94eb071afe68@linaro.org>
In-Reply-To: <df017bc8-3aa3-18e6-9632-94eb071afe68@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19c8a198-898f-4a9d-ec22-08da65911646
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AceqQpJySNPTdfGq0nRnJQ3GJ/jWz3BKu+wQ4V7uG2nwTIBLQLS6mj/iTFDVl51M6rILfkiAYIRBF2jKJkOXvVoqxwwOESzfNTVO8zTI7sPdpxbUBMGhPlYOWF3M88o1foZC9WZ4Es6s78NeZ4/nTfAbhNMzNYjvEk4aK7k3KhzbXruCanj/ER693/h9YHeLyiML5NUzi2sgnp6wpvwgIbyS60Fr9kRvnm+kWZDgF5o258C4JaeLvuAJ6VLqAWprpGTUPJiUkMOywFm1tePqOc9WlIpdYlh1zN9QYgHhkYDUakAm1/shh6+ze50+yIYailg9/q3cwZzTQEmBgdzVpk6662ge4X3wf2PYZIiFeuqYyOCJCJj0MWOW3K05sSmCznst6PTVHS86fERF6OfNyEPl7VIItDLtjt9TI734w7QQjHZ1onc85cYcVJdnsdoGFnA/v7mtzswMYrSMySbn7vkG7KjgXUdF5+dRxLVsIjh7WOnBWKgl5Uo6DsZJ5yPmhiPse7sOTrl74Yrzo94UBHfWQX1ns0Eg9SMWQeno/7tovkLNpjvNwh2AJLbvqfHmMroZjJUxMU3/zlHyqsZqXM7EwTiEuHNWifQteNNQMTT6H4tX4HtbKQ5z7dTLEVlsl+i/ZWYf43NGuotVVzWMA4lb1tnU2qGRN3JHPjtKkz2P99Q+1a0vt03A5aJ4BIZUfRIiOO2l1obE3kC13xzc6IIVEXJE8xxEoUshOS4H6+k/Y3Q3hT+W6t8C8Ohw7hGWZ2PC1f4o36oWRnhzG2TYDMRdhAWpO5nL5EoQe0OWk/9IooUfpqVqSLDLTWZI1ob4AimKTcDEPLtOfgrKF485uC/xutKWqojos3ZOHZeDrC4YyJjO9xl4YMzchJ53+hVlYuMegyuWzgQbkjCnOdgQvqAlVhbFRumPrA6Xpdva5GU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(86362001)(54906003)(6636002)(41300700001)(6512007)(66446008)(110136005)(6506007)(26005)(66946007)(66556008)(53546011)(64756008)(91956017)(478600001)(122000001)(71200400001)(76116006)(6486002)(36756003)(38100700002)(316002)(66476007)(966005)(31696002)(38070700005)(83380400001)(31686004)(8676002)(2616005)(8936002)(2906002)(5660300002)(186003)(4326008)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWdqNkF4MGN5RjdVY0ZMczlnaC9SalREYk01R29GT2dsM0dEeFZLSlpQQVhj?=
 =?utf-8?B?ZEVETlA0THNMVk5QYTFINDFseTkySEhSam04YUdyL1dHZE82d2xtUWd0MXc2?=
 =?utf-8?B?UUEzanVVMkVZRElqck9OS1ZYMkNUdTB3U3hHRk84dG5xcGc5V1kzc0YyUXQ0?=
 =?utf-8?B?dFFVL1o2UEVRaTljSGgyQkZzNmY1dXdXRFd0amxZNTgzMXkwZE1nazZSdDBO?=
 =?utf-8?B?VUh6TXFPQTduZWtzN0RCOVdhU3JMZE5sT0FLUFRjUTVwQTdVQ2RBK2hZY1pj?=
 =?utf-8?B?bVNISkRneldXYTZueXFJd0Vpa212WC85SWhqemtoMmoxTlFFbHZwUkcwdHNx?=
 =?utf-8?B?VUp3Q0xXTTRpa0hXYU4zZjI4dEZpOFRteHk3aVpGQTl4bHV4UGMxdzYxbStW?=
 =?utf-8?B?OXlyakg0WlZoeDlxbVI4UnFYeHRUTnZhVmpIT2czQmdoY2h6Sy9sSEdtN0VN?=
 =?utf-8?B?U3I5cVRuWmZjSWdRaUNMNTN5M1lpRGVueGhqeGhrKzBpQVRrWGZrQk9vMkQr?=
 =?utf-8?B?djBQcWlMbXU1Q1hwaVJLZC9LR1p0V2dGTm5UZnVSOEU0dmxjQXFhb1dDbURZ?=
 =?utf-8?B?RG4vZmdlVmozd2hMczJOWEZBYWo0TGhiTmI1dlV6UFppS01mcGppNXJleVpG?=
 =?utf-8?B?a2Y4Z3JwS1hRTWlUckNRazhKMUs5REgrRXk5WWFIa05udW11TkVOVzN1WTV5?=
 =?utf-8?B?M2t2RW13TUl6SXdkbkhZenlRdTk0NXE1ZENxeUFkYzlyQWhhZGNFRnRTK2h3?=
 =?utf-8?B?ZkhzYjFLbWFpT3E4c01ublZUZklOUHFnZmJtNUtYZXdSZm9uUmQ5QUtydnZN?=
 =?utf-8?B?RFRMNlpmVDlhb2JWRnNHdjNkajNjVU1pTEVSbkhsRXlRMVlCTVhoaXAvajBZ?=
 =?utf-8?B?WlNVeXVqZlY5UTRST3FKSndKQ1lwYUo2QjV5V0VvUmx1UjVPQ1lKMzNTYVh2?=
 =?utf-8?B?TFVOOG8ySGF2aE5iUFJIdmpLRVRWQUdkOEtWNXVJZmFwY0NqWE9wNm9wN1NE?=
 =?utf-8?B?a25hMzNuM2J4Z3prbEFkdTJ3OW9ZOEh2WUxVdVEwL1Vob3ZlOGRReDArKzEx?=
 =?utf-8?B?RkFWa1YxZjlaQkFRbXk5WEhOSGFyL0RBZm5QdVlFZ2Nodys3VjFaQnhCRWo5?=
 =?utf-8?B?ZWRqOXNod3hEUE45V2R0K045SUNiU3d5YVJYNjhXY1RCckZmRkgzZSt5RitU?=
 =?utf-8?B?RFhhMmtkSUVwYWhFMjgrbmc5WmEyZFBMT3pyOHRGVUpzaUxGM1JhVmM5NFpa?=
 =?utf-8?B?VXFLUitFUHd1WWZNOTFSV3dlR0dKdHdCZ0gwaWc4cENLNW84YWtLSTRhd0g4?=
 =?utf-8?B?SkttTTk1ZDY2M3NtRit3NDJhREw1T2dOVTV5UDlPUzhNMHU5TFB2TWJ6QTc4?=
 =?utf-8?B?dVlPK1h2b1d1ZWhaR0RFYjY5bjY1QTJIWGJCTlA3ZkNsZGlEODFtcHFtaCtN?=
 =?utf-8?B?V0VUSW5hWnRkRlUxNUcwMmlQdjVFbkRPUXFlT0tJZk00RzZZSlRDMzRxd1pF?=
 =?utf-8?B?d25WSWN2bitZcmlHb0M0OWtlaGVsQUE3REpRaklqM1JSRWFPUXdLZDVyZW1C?=
 =?utf-8?B?ejJkSjV6dkMxS3FFTFdNTFJZbURNWC9PcnpZc0sxVEVXWlVOQXNkTmlha2ly?=
 =?utf-8?B?ekg1MWRNV21Id1ZGMWM5NVV4T2l4bU1LakFSSWxyT2w4YkVQOWUxcnhGRHNo?=
 =?utf-8?B?aVYzZHpISVZNMWd5TnFVWjRDSnhrMlNhZ1c0VWx3R1VycmJkQi9lb29sbHFq?=
 =?utf-8?B?Wkc5V3lrUFpsbC91N2pTb2NMUUtpQmk5MVg5QmxJT2gvUDc1T3llbnhyYk5p?=
 =?utf-8?B?NTNZclRsNjB0SzNEQzlkcEloa0VJaU1ncGtlTzRkUjMzcHZ3UnYzcUhyZFRZ?=
 =?utf-8?B?U0RpOFJBYWYrQUgvL1FLckNaeDJHLzhtcVl2WWJmTWVoUktKSFBybnBRNlBH?=
 =?utf-8?B?Tzk0UUJ5Uk9uYThwTFFzbi9IakpoNVRHZHJRNXN6K29xRStKd2V0RWFWeGd1?=
 =?utf-8?B?b0RCcWZudDhhMUtzMnFlRTh2MHR5ZmJXY1FrbnhaNDc2dHF4T3dMaEhkL0pQ?=
 =?utf-8?B?QmpXdTFPMTh4V1ErdjROME0yUWttS1p5NzVzSWZPV204SUxISm9TOVdRaE1n?=
 =?utf-8?Q?UMgxwqVYqF7nOEwcC4UwOQMIB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B48E7EA1A9D74EA81FEA7C329A61D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8a198-898f-4a9d-ec22-08da65911646
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 12:05:04.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8drRSarrq/QCoh5x0ZKkSeocQXDk8CzFTDyuAjt0Ionoq+xHXrxsntdLSQvuUKQ6H85Ew8OhRTrzT2/LnhsqXtdDxbMoLIza8hHc6fNhH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDcuMjAyMiAxMzo0MSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTQv
MDcvMjAyMiAxMjoxMiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IGF0OTFzYW05IFdE
VCBiaW5kaW5nIGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBEZXZpY2UgVHJlZQ0KPj4gU2No
ZW1hIGZvcm1hdC4NCkkgc29tZWhvdyB3cm90ZSAiRGV2aWNlIFRyZWUgU2NoZW1hIiBoZXJlIGlu
c3RlYWQgb2YgImpzb24tc2NoZW1hIi4gV2lsbCANCmNvcnJlY3QgdGhlIGNvbW1pdCBtZXNzYWdl
IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2Eg
PHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL3dh
dGNoZG9nL2F0bWVsLGF0OTFzYW05LXdkdC55YW1sIHwgMTI3ICsrKysrKysrKysrKysrKysrKw0K
Pj4gICAuLi4vYmluZGluZ3Mvd2F0Y2hkb2cvYXRtZWwtd2R0LnR4dCAgICAgICAgICAgfCAgNTEg
LS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspLCA1MSBkZWxl
dGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy93YXRjaGRvZy9hdG1lbCxhdDkxc2FtOS13ZHQueWFtbA0KPj4gICBkZWxldGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL2F0
bWVsLXdkdC50eHQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dhdGNoZG9nL2F0bWVsLGF0OTFzYW05LXdkdC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL2F0bWVsLGF0OTFzYW05LXdkdC55YW1sDQo+
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iM2Y3Y2JlOTEz
YTUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy93YXRjaGRvZy9hdG1lbCxhdDkxc2FtOS13ZHQueWFtbA0KPj4gQEAgLTAsMCArMSwx
MjcgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9n
eSwgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4g
KyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvd2F0Y2hkb2cvYXRtZWwsYXQ5MXNh
bTktd2R0LnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIFdhdGNoZG9nIFRpbWVycw0K
Pj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlz
dGV2QG1pY3JvY2hpcC5jb20+DQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6IHdhdGNo
ZG9nLnlhbWwjDQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAg
ICBhdG1lbCxyZXNldC10eXBlOg0KPj4gKyAgICAgICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAg
IC0gYWxsDQo+PiArICAgICAgICAgICAgLSBwcm9jDQo+PiArICAgIHRoZW46DQo+PiArICAgICAg
cHJvcGVydGllczoNCj4+ICsgICAgICAgIGF0bWVsLHdhdGNoZG9nLXR5cGU6DQo+PiArICAgICAg
ICAgIGNvbnN0OiBoYXJkd2FyZQ0KPiBFbnRpcmUgYWxsT2YgaW4gc3VjaCBjYXNlIGdvZXMgYWZ0
ZXIgInJlcXVpcmVkOiIuDQpOb3RlZC4gVGhhbmsgeW91Lg0KPiBSZXZpZXdlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNCg==
