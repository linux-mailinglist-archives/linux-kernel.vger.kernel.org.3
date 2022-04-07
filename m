Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876F4F7EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiDGM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiDGM2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:28:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BA636E22;
        Thu,  7 Apr 2022 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649334374; x=1680870374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iTZzYUc3DKHNmdGcZSnyOy4wKMQaLzWyd9bsE0CeL1A=;
  b=EjDhWoPoo/oX3dkUdD+7xD1s5PyFIK9bGeSaxj2+yk7eSWfsgyimieCa
   qkIZk3XQJNM5wVIAGSwIV0JXUfwDvnAT1ZdwgBuq9igiD+4VKuJgLo/zO
   UIoK4jNQrsL1thtFsTTphGCqFXYakOJXfS2pG7pKmo5z7Y9BlxXrgCFFl
   +EEMsLzGaubEc5Ys2EIXKPIGgh04P1i+s/D66D95G9GRYIDCBLDR5LbPA
   KLQt9x/unpE1x4VPOnqDEApeK2MeCMGiZ+7D0lP63R3a5a9thk76XYAhW
   b7OjHHu9sVZRGFK3EYuDfFAbHByCoHSipVjnjlLJA5pwLm98qp9HjPpnB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643698800"; 
   d="scan'208";a="159281847"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 05:26:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 05:26:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Apr 2022 05:26:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKURowuBs1aEMU7Nj60GVqn7y1jACDGHe3MIA8Fa0MI5AQO3mSeD3+vXn0zHnsrJMY7DFbxrzPqvjH9JrGM2QzA9il5gt0EmncdBnOH2kkDa1FBO0HHSPivEP8f2YEIDHt0Z5h5ncKIYiieEFJpoQ4QgJalOAPbvqYmc0+E6myOmhrc4/aNTwvhzh4xTiykNDIef6jXudAXAdtZSi3QuIM0FVjPGMO5wOaDvkAY+hq5RgC+d3yRGf/GkHrw6KN52ipmQeqXnmu0Hyps3ZZ13yFFDtfGD9qRgl7WFjrewcz5xXsoAskd02+San3Nj1lxtijI5EodoYAJSvh4kLeSZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTZzYUc3DKHNmdGcZSnyOy4wKMQaLzWyd9bsE0CeL1A=;
 b=acySxtl9VCXpxT4veivRtB1RMmrSAT4gtgWaExKiSnd5UyvWxHDqvpu53cah/XC5eXq1BNArcAbB33YgJg56ctTBl9DY3C6lUANqBrG0HNvFhQqPz3hMb/KtDZgB4Yuhfbs3iU1ZAAYsWzS7he6TAr2epqZXTPdxFWY2TE19HP9l5gICcADfybsf8LBDly3YrJxXwx+wJoVisyLoSc87HzstoiuAzHullPqk5+NbvaeJOsxqnxpcL+QseaTCd4tL51EFbtjZlt8iDahtBvEAXxcTLZtPPWrGP4hV+egwz0EzmBCy+sRPTU3qgzve85WAfC2cnQheAnKRgtQgNZ+c8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTZzYUc3DKHNmdGcZSnyOy4wKMQaLzWyd9bsE0CeL1A=;
 b=X4LwLhaktd1zyfbFJ+YwjiGMiE7MfnzRQgc8W0p0hyOkgArCQdpjq9AoB7DuGlV4m6/lKy17XP+EHjY67BcYoA9EogMuKR54djOg13657ONnb23fw6YbBB10R6t65ZgVxrKyKPuSdN6roQmgmA4iOkue9mfxi4b4RfH7Y2wdca0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 12:26:08 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 12:26:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <olof@lixom.net>,
        <soc@kernel.org>, <Nicolas.Ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Manohar.Puri@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: lan966x-pcb8291: Add QSPI0 and SPI NOR
 memory nodes
Thread-Topic: [PATCH 2/2] ARM: dts: lan966x-pcb8291: Add QSPI0 and SPI NOR
 memory nodes
Thread-Index: AQHYSnqnYtcLxIsM/ES5CAIgG5IE5g==
Date:   Thu, 7 Apr 2022 12:26:08 +0000
Message-ID: <42c1968a-c966-2104-9e39-f46b491462ca@microchip.com>
References: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
 <20220407105835.10962-3-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220407105835.10962-3-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2812fcd-394d-471c-6a0f-08da1891cb1f
x-ms-traffictypediagnostic: PH7PR11MB5959:EE_
x-microsoft-antispam-prvs: <PH7PR11MB595942D8FFBE2F9DF954ACF2F0E69@PH7PR11MB5959.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qE8/GvOrFPM6vqPWvWzmZZJv0EvPISTdwqoj8Fm5GefrJj1k/ZxLlr3avxI+u1SiulpBxHOz47BNulKN/CqPYNiALR4jE+1k5XO5XKC4lDAF3BoYk0mrZ0FJn9xSp3SCZVorHztStHJOhe652hG9E0EOAScLPWOQ2m14h/zi8icmk+MLi7ewcSxd4vTTMYf7c4H6P7SnqOIvVf+mAJmOdJLuNIZTsBYUwhAxMr5277GLbYw+9bW+4dDwjkSq7KwenEfb/5s5nr+O83tUrMs8gcUeaSaYamKpXZVF9ssD79+rsMU04nP/D0pK7ABiNCOcA5u+fdEX4CPgHYFZTMdyqg4gQGuzbPhVsMXfSxMrXM4fQA1UqE+3K9p8KcBAoaValsMgnb3QrpmluKRosTilXAwu2T0r0AqKk1cnodxBJFkT2dbOJQYbijsnHTtTYISxrNMbK5q44EKoC7H95UZiYilj7jqg7Nba1Itgn6hbe6waim0BGQd+yIeFA9KZWO3Az1RXCQ0IS4I1q4fLdzKhmAnAaKmShZ8ktG7jvTmuvKtr13BohLe9sMrxjxdYkF2Ou3CE18uSJwbZkFHI+j1f9b9J9uyOZBtbUaJxW6Vo5LZ+YxgErwwwORXspI5gUv3/P5mYlth3O482AUHirbtPWfgkG1IdVXwfZkmLnHigZI4Hhx8JNueIK1fAWDemSGl2gY1iILosQAE9YZ8y5BEZVyvSWqAhQIAvk0lK9xn71fveY7/5loUdTl4/QpdfGTsstW9heOc/aM2coKzipgpq7QhKUn1E+CH3jHYYqMeIF/knno4rdKgpa43n0HJSKD0iK2JcurNaFmMckRqy0rbCNV61Ui/xyGqSqvK7e2CNTyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(31686004)(5660300002)(86362001)(8936002)(316002)(2906002)(6636002)(110136005)(54906003)(38100700002)(6506007)(6486002)(53546011)(38070700005)(83380400001)(966005)(508600001)(66556008)(4326008)(31696002)(66446008)(91956017)(107886003)(6512007)(36756003)(76116006)(2616005)(64756008)(8676002)(66946007)(66476007)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JjOTN6VGRYUW82YytrM0tZQm40Z0VkMFJWcG8xVkZPTHoxU1Zvc0VwaFRR?=
 =?utf-8?B?WnNoOVNYR3RkdnVFR1Y0SFZ2aDdISmliOUIwaVIveklCVHlWNWd1Y1VkSkYr?=
 =?utf-8?B?ZCs2dVZTNTM4YlVYNWZYUlJYOVQzSzRqRFArWDlaM1ByMXhBTHY1YUtkaWl5?=
 =?utf-8?B?V3N1TTU1VHUrbnZrTGVnOXlydjFUT05CMGtibnkxMmV0bWkvQkVKZXVDWmt4?=
 =?utf-8?B?dm12N1pVMG1CMmc1Q1VKVTdwTUJvVW14WTlLTjFFYlNscmFvNGVMb2pOTUxW?=
 =?utf-8?B?QXY0UkxmWkNBQ3NXbGhKSDU4TjE0OWs3ZXFoRWRjRVI2ZUx3VmRlMm9mWGtz?=
 =?utf-8?B?UVhHMk5rVnpYOUkvYUd5aUxBdmw5KzJ4OEFtbTEyMWFmMmlHMDJCMjhvUmNM?=
 =?utf-8?B?VDdOSkhTV1pwNFd1ZVIveHlnNmpDanJFYW9CU1dXbStuSXJ5a1ZwelBuemZs?=
 =?utf-8?B?MjNiUDI2MnV1OWpNOGh3ek01Ymk5Vk9tT1laSlVDTDBWYWlqZ1YwU2pxQTB4?=
 =?utf-8?B?NmY3Rm5Cdmp1N1d2K2h5VUVHcmRZenZKTy9lbFJUWHl1Q3lDKzlBNGhMMmwz?=
 =?utf-8?B?dERKaTlrczU3bGxmdEF5ZGR4Y2o5V2JQZmtSbkFGa1VYT2tkdnlNNXVlQmc2?=
 =?utf-8?B?R3Y1dS9aSmRXakJjT0s1TTFuYVJZOFNJRS9kTWtNMDBlNXpacnNEY216MnJM?=
 =?utf-8?B?bmVZeUlzelhhRGl6OGo0cnlvZXk1SUVSamx0NXd0b3ZGRCttd3NjNkp4d0Z2?=
 =?utf-8?B?WDMxMFl1V0p2bHd0b3ZHNTNkUUp3QVBxYlVHYlBWNzRPQ09jcDEzc2gvd0Rw?=
 =?utf-8?B?cEFVWElIMTE2QllWbVFkcnNsVXEzcEt5TkF5NzdYVXRtLzJCcW9QZEVFdDIz?=
 =?utf-8?B?a3VqZDZNOWZlak5TS3NEWUNHV0xNRFNvcytvOEpmY3I5Y3BHYzBmSURsSzZX?=
 =?utf-8?B?TzlZc3E2bzVqM1BKR2xiUU1RTHc3ajJ5M2lxZ0VvQTdUY3R3S0IvdEJxNXU2?=
 =?utf-8?B?eElpczNhdE9zRjQ1cVdKUGdqOExDYkVRdlh3V0RCeXVtZFIySjJRUFQ0cUda?=
 =?utf-8?B?bXdqWTRrYWZPZlg4eUxNSmM0TlFTdW1qTS9Rdnl6QXdpYVA4b1ZFOTZQdnlD?=
 =?utf-8?B?RTFOS3VOTWdtNmRlVlloNmhBWk11eC83bUd0UHJ1Q3ZYWm5tME5pcWMvUDFk?=
 =?utf-8?B?Z2VoL2FWT002VzBnMm42c2dxUjZaaG9CdTFFZVl6VjhmbkZpQ3cvcy9uamRF?=
 =?utf-8?B?cittTk04VmEwc3ovWXR5RzZ1WkJjM2k1WDBrajE4cmZhNU9MbUtzZkZCbFJa?=
 =?utf-8?B?V1c4dzNlZnYxbXFKZkxMeGh0OHJjbzI4c0VwMUh4L1h2NDBJL0tWcG5XSjJS?=
 =?utf-8?B?SG9DOXFCandkRkRzbkhNZ1RzNXRxY1dCUW1JYlRJcXdSTkl1NmZRVUtVK3pD?=
 =?utf-8?B?dUlKeU9WL3RVQWVjU2FpZFEwNFhMR3JoMmNueURsOXN3MFJpOGVwRlFKVVZB?=
 =?utf-8?B?bUFFRW1GVmZydm5uUEJyeTJNZFdYdFJSMWhycUNLMlhOejJwRy9vdDZaYjlT?=
 =?utf-8?B?SWpYTnIxeWErajdQSStlZVR0SVhPcnBDZjFnbTBmcDFHV3FDMDk1N0d3WDM5?=
 =?utf-8?B?TlhZWjBMdXVMZ0dVS20vamI3MVdPQ2kxdm9IVmNVMWxpMmlIK2VKd1hoNUxu?=
 =?utf-8?B?bFI1SFFYMEtmVjZIVmdwNE42aHJ4YUhkL3VKSWRNaEdUUmxXT3AyUXNpZTZV?=
 =?utf-8?B?ejlvc2xTckpVdnpMSExTcldyY0JxUThlT2tWV09jZGw4b09nT2Z4VGVCUysr?=
 =?utf-8?B?djV4citObmRRVXcwSFZpNnFLU2ZTdjhIYTViYzJlOE80ZnE3bFVGTS9TZmlZ?=
 =?utf-8?B?UGJHeVBoOTFRWk0zZnBJQUdVbWU2NzN1ejFxbXNDZHVmcEExVUdLb0dHbjlI?=
 =?utf-8?B?bEFpbDRueWF6RGZVak13MHhrdHdpcmVZVm9tWGNHVEZ6QlBoREFpS2hUZzgz?=
 =?utf-8?B?WDV4Z0JPbEVOakJuZlpIVmp2WlYrTCt1YlNBNzJ1bkY1VTVJYzR4dEdEYU4v?=
 =?utf-8?B?V0lndzV0Zk1MRW5lYjl2c3ZMQ1ZrSFFLVGFBQUkza3JwZjV4L2JlME1oYkhm?=
 =?utf-8?B?VFVTMTBmWTZkd0hZTDZ3TW5wU3RYV043TUt4Qm15Uk1mM0tRYS96OUlBbUpD?=
 =?utf-8?B?bXY5Z2F4K1RPeEtFWHozWHVXZmxYOUMrb09ROGw1U2pjMHBqMUtRNGNmb1p0?=
 =?utf-8?B?L3JQMVNhMHdxaFlBTSt6N1c1WlhGS2hTV0dxZllqdVRPbEIyR3NxRHYxbG82?=
 =?utf-8?B?ZHVTeGFXT05ScUs5UXZNVnFJeGJ2VWJ2aVFIa2lOQWxHQ2lPYisvTmdsNm5R?=
 =?utf-8?Q?ewVaJWTb3zZXOsF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ACDD16A79A90241A149CAA0CBFC947A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2812fcd-394d-471c-6a0f-08da1891cb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 12:26:08.2098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjTcYGRDrESOSD6/WZwkGol3gD6nY2r31Wa3TDaUS6wB6wruuTrPW4CP33h9BkPw9lQNYUp905pCHd2+VVCNq6DPprCHAAXQ4eGG5NOAdOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIyIDEzOjU4LCBLYXZ5YXNyZWUgS290YWdpcmkgd3JvdGU6DQo+IEVuYWJsZSBRU1BJ
MCBjb250cm9sbGVyIGFuZCBzc3QyNnZmMDE2YiBTUEktTk9SIGZsYXNoIHByZXNlbnQgb24gaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkgPGthdnlhc3JlZS5rb3Rh
Z2lyaUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngt
cGNiODI5MS5kdHMgfCAxNSArKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC1wY2I4MjkxLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4g
aW5kZXggMzI4MWFmOTBhYzZkLi45OWQ5NmQ0NjY2MWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
bGFuOTY2eC1wY2I4MjkxLmR0cw0KPiBAQCAtNjIsMyArNjIsMTggQEANCj4gICZ3YXRjaGRvZyB7
DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gKw0KPiArJnFzcGkwIHsNCj4gKwlzdGF0
dXMgPSAib2theSI7DQo+ICsNCj4gKwlzcGktZmxhc2hAMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAi
amVkZWMsc3BpLW5vciI7DQo+ICsJCXJlZyA9IDwwPjsNCj4gKwkJc3BpLW1heC1mcmVxdWVuY3kg
PSA8MjAwMDAwMDA+Ow0KDQpZb3Ugc2hvdWxkIGRlc2NyaWJlIHRoZSBmbGFzaCdzIG1heGltdW0g
ZnJlcXVlbmN5Og0K4oCiIEhpZ2gtU3BlZWQgQ2xvY2sgRnJlcXVlbmN5Og0KLSAyLjdWLTMuNlY6
IDEwNCBNSHogbWF4aW11bQ0KLSAyLjNWLTMuNlY6IDgwIE1IeiBtYXhpbXVtDQoNCmh0dHBzOi8v
d3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvTVBEL1By
b2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9TU1QyNlZGMDE2Qi0yLjVWLTMuMFYtMTYtTWJpdC1T
ZXJpYWwtUXVhZC1JTy0lMjhTUUklMjktRmxhc2gtTWVtb3J5LTIwMDA1MjYyRy5wZGYNCg0KPiAr
CQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCXNw
aS10eC1idXMtd2lkdGggPSA8ND47DQo+ICsJCXNwaS1yeC1idXMtd2lkdGggPSA8ND47DQo+ICsJ
CW0yNXAsZmFzdC1yZWFkOw0KPiArCX07DQo+ICt9Ow0KDQo=
