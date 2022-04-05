Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E04F4C96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578977AbiDEXZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457374AbiDEQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F8635F;
        Tue,  5 Apr 2022 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649173151; x=1680709151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bMJMBdcJ2Ed+W2Kh/EK5B4FpX6HXSgJZkfo8mrBu/m8=;
  b=EPVOXTxf4jSlSREYo46PYEPkHI/FoQ2j32W9k/kKgVzxOC/hAOVUXwqp
   WyaCr5feJavcK5snyfCJobPyiNKAsrSRP3ouZ6yRJen2JUBBdZBXLb+jK
   bPvCSl/ZWq1tFe86nmYY6pEU4nRkWkBuE+mmzlttxHvI6WahJf8Owh42l
   7S2tS/W8yothMMLHoZNH+3TTjCRm3qSUcl6jLg2Ka36cOH4YBC6Qjy7Pu
   1BcpIoSXZmYsEJWD+uR8JeBdLGguUEj4NdABDNe8BEvX3ygVWflRo7soJ
   3yMp6du4GZsV7liqTZ++bLri+fcJIcBI/ABg3aPPuYQ60+Aro2BIgLQOX
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="158959730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 08:39:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 08:39:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Apr 2022 08:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr8120N5Kz/1yr/VZGGal8C4WPDmEBF3U2wMDAC/eNoVMMqbSXkF67WR3+cf3tvq8wPj+AzYiCSFBs4CUGIOK5FulwjjuticsDSDqwe4JJ3xECaMv5DleYpFuqhtxI+0BJ1awMv7Nce9kEf3oUR/3fMaUpP0/8axweZ6Lg4LWBAChvVz3E+dnCmtxSH7QCOs33wZQ0gtKgNgRjMJZhkalbPG2yqpz1JgUNv0dorQ4SMdMSIVPS8cj+8slKa/F/4Z1+jjjUqISMkTtC62EFmFqcbCwffYUGu5tgebjWuRBxQ/c9SaPmokoNF1E1ee2Kww555sh3F0ar4k3U02WoyJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMJMBdcJ2Ed+W2Kh/EK5B4FpX6HXSgJZkfo8mrBu/m8=;
 b=nR+jopfaQCxZKiP/apTomALqEcIV8Fjqw5tXsRbQVHWADpNgOaRsKDzO/PKWvUa1m82owUntxOE7zgDwvua75TjJT86aUQFnm9dYnnjzqXCFgcshW7T0DZzBehnxtsrI0GKE9w02G706h80aoPgvrmSz6McuAFA1275+L/69uoryDw56VKX0JQAnKJPKynj5VUIW1X4hlNT2oOJVNQMD8Ju1+bqLsXWn0fwpMxMmtGrXsvPKcjziJT+5IAXaJs6qHOsmGpHQINfLmUmrums6hd4glYIcKW65ugAdftiXEVnJ0nPBLIqEi+4UCWUAGirvRv8RpSqk5Gq3gguHBPOxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMJMBdcJ2Ed+W2Kh/EK5B4FpX6HXSgJZkfo8mrBu/m8=;
 b=RsnTHYKawB4IEqbdoB9FeilAWs7Sv9pLiolK9AisrN8kC2txzpfzaSO1oIpxWizbt03v9mVpONAzOvsG4hlwEQldXdtfpIFzT7Zuo1z2Jd1rMVKvMMfcLVXY6ha2LcdLYCBO+w7v/q8iskv2YUnyhh9lxpyj0/hWFYE2cjxyUBE=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:39:05 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:39:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: reset: add sama7g5 definitions
Thread-Topic: [PATCH 4/8] dt-bindings: reset: add sama7g5 definitions
Thread-Index: AQHYSQNIIH/uqGgGF06vh4JJVlot/g==
Date:   Tue, 5 Apr 2022 15:39:05 +0000
Message-ID: <1696dca4-c700-adcb-727c-7bdf9833bff6@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-5-claudiu.beznea@microchip.com>
 <ac31aebdd194fc559c43b08419a649ca32167e6d.camel@pengutronix.de>
In-Reply-To: <ac31aebdd194fc559c43b08419a649ca32167e6d.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89d680b0-4e1f-476a-4196-08da171a6af7
x-ms-traffictypediagnostic: BYAPR11MB2789:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2789E4CA82A38BBAA965B03687E49@BYAPR11MB2789.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjYC7NzQsdBP3enVogHeF1UGtaCqL9q/oe6lKS2rkyjEYzdOYkIq8XrltZqtgHkFHxHEsd0yZx0VAAHs0xnsmYKVpfCL6ZHdsDw5SXyCQ9kgWVS4tRJeG7I32bQpvX8UePD867axc1OUQhXNIMFikVB6VtsndHsL98LCNmNyJ+St8PF97IJfqSGuKhLq1qczkdGlrQ7ulOPS5X+VcKEN2pG7rFxTgQJQ/dWsQqJXVYc6lAtrq7NUvh7pztgA4LOne/LI82SfDf1kAuRO4UEpgUrwkteJxQW9L04u82WVzWeCCBwDo7cvTGmt6V88wvlYq6V54zfys37CW4K2lJYvXd3Dz4xRhm2z0kRFetVD9KrC6FYNjwyfEAWFnoLYZbIjLpcjqD6nyFh2RJKziqX/cQUQcOXcx1fsa0AtQuNPrHaTiD/1dZChrO5s+MUX1rkJju3FxgBf5aLAu9QndY3DM98h4yWZZ2smi+2rKSHfwY/MjIhKEuRsYyZLqUYMGTKiTPBxIgAImOtPVrl59rt1eYHWO5BeVrnLqvXPXz6RV1NiGo1GNW1X66AGvQiwKa/xllo8hvkF+RFSrt9SFPvSdo/STYjoHbHwwuD/1UAzXT9Bx1gQkLA9PcagWfOt+EJnGqePHIdCLc4PcXpwaaSh782vqPenbgiSwzZTHmp0zyWDbJa9MnNkzsfDQjg0gErt6Ai4NroJWCrbYRM3T5jl0wM7mojZDN+sPpvsLKm2JMmnY/ZwFw8vBZpFMcM76cplq7K5i8+L/s4PAXS4gSRhKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(4326008)(6512007)(66446008)(64756008)(38100700002)(38070700005)(86362001)(31696002)(71200400001)(2906002)(5660300002)(53546011)(8936002)(4744005)(8676002)(66556008)(66476007)(91956017)(122000001)(6506007)(186003)(508600001)(31686004)(36756003)(54906003)(6486002)(316002)(110136005)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjNIMjZjbzg2anNnS3pqN0RpTmIvaS9NMXB5YWRlVWh4c1dzejQxWk5nakta?=
 =?utf-8?B?M3g3SXE1anBPZkxSaitZak1YdmtRTUYvaG5BUjlWY3BycWZ1Y3JPbnpyRVVo?=
 =?utf-8?B?VXNkb2Y0LzVwMGp0RDIxTzBHZVAzTmltZTlERFl3N2FlMDd6b1FqRkxJNlh0?=
 =?utf-8?B?WERqelpkVWh3OTFDbHJIdEk0b0NFTlJoRWI3cEZZRzBXRlFtVTUrRHRkYlRQ?=
 =?utf-8?B?VldTOHRjS2wreTBHWjJ1aElvcHI5SWZqKzRpS1JxNVg3Ny81WVYzQjFJcGsw?=
 =?utf-8?B?cm56bzh2S3VIZkMxUnJVejZsRm0wSnkrT0I5Yk14bGJOOCtqbHFSeGhsb1lD?=
 =?utf-8?B?MmN1U2JPSTFrTVF3Q3N0N0NXSTJVUExHdkxTczI5K0pxVk9FQS80YlNsTXZS?=
 =?utf-8?B?b2tqK2V4bWxRNHI5SVA5OW9DSTRUQVdZT0NYemk4WmRaWGdRVXV1d2d3ZXMz?=
 =?utf-8?B?QUpQQmE4V2w3RVdmRE1zRlRsRXhKWE5HMVdYcVVUeGpIOGNITFZYaExjbmIv?=
 =?utf-8?B?VTZidkRNcG82Z1dYbGJZNVZUS1BzSHZjRWNJZXkvZFZXM0ZXdmxCejhKamN5?=
 =?utf-8?B?UlVJYzVxbS9jOUJxa1ROanc0ZWZ1TjUwSFVqTTlITEJsZGw0Lzgxem0wS2JF?=
 =?utf-8?B?YUhxOWxYcnJPZXdNczd3RExFMTE0Rm1pL0ZzdmlPZzgreUM0V29xeDlPaEhN?=
 =?utf-8?B?b2U4YkE5Q1Y4N25wZ1dCa2VKVzIreTVSbG8xd3ZIei9zMGJOOCt3djdNbUFY?=
 =?utf-8?B?aHBISFV3MFEzTzZ5SUhaL0c2WTZ2ekxsc20za3NRZ0svOVRoYjR6S3loZkRY?=
 =?utf-8?B?c291SXBPRTB3QkxJMmRwZXdXN1hHUmZwZ1R4YjIya1NJeExRSFVaMFo4OEdk?=
 =?utf-8?B?TXNuWmxpNzJYZkhJY08rUklvcVBZcEE5VEwwejY2SkViZVBYWVdXTFo5UGRn?=
 =?utf-8?B?Rnh5djUyWW9HSm00Wjh6YnFHOXBGVHYyOGJPalVsbnJXNHA1ZnUzVVY3WFVO?=
 =?utf-8?B?T1ZvaVc4b3dFY25XSGNVRnN2eGFib3pmb3lrS1dEVUtodkRnR0FYNm1Jdklm?=
 =?utf-8?B?VFphbXM3ZUFtQlZ5S3NiQ011NlFmN2laQm5YMFdtakd1V0E2a2xLRkdiZ0d1?=
 =?utf-8?B?aVc3RUl2cUh1NHBOYlk2cEVUeUVkemZabitSVlo5OTE4YVdGMUswcVNjSTEw?=
 =?utf-8?B?L2x6QmJaV1RLTktTNUJLSDBETTVOT2MyY082SW55L3dFYXV3YWpodE5WUnN0?=
 =?utf-8?B?MDBMbzNYdjZIcWVENWtzK0lpSEN3WlZjNDZrV0l6cjBubXMzb0gwdGFDNkQy?=
 =?utf-8?B?ZVlORlZEMkJGVUdpYU1rWTBGUnh6dHpTOUZ5TEZKZ1VqNG1nMWpWazdiL1pS?=
 =?utf-8?B?WlVPeTRIZis2RUVtN2hBYnZiQlZyS3kwcm5vKzVvZXo0MTN1bmMyZkdtVDBy?=
 =?utf-8?B?WGY4WXJqSGtsZG9wVDhpaG51V0VkemtSYUJqMWo4NDlLU1dncFVwSDU0RURH?=
 =?utf-8?B?cWFIZmltT0Z1R3crekwrbG93V0FGc1BCYjNyNmJkYlpsaGxPUE00LzJnQklR?=
 =?utf-8?B?d29RZkIrMWozbEdEM1VkRkdsOGU4T0R6T2hNYXY1bjMxVlRmaHduS2dzV0do?=
 =?utf-8?B?ZkZNMUx3QUZqS1VyVG9OODkrQ2t1cndmcVdOaDJHTzE0aTVEL1h4dzhkUUJI?=
 =?utf-8?B?d2J5Vy9MN1FFeVpsNHJPMFowOHJlK2VzZThQUFdXdWZmcWs1WWpPemtGTzV1?=
 =?utf-8?B?Vmg0eFNNZlIvOUp5OTUxUHR5c09tcTcycHhIVTBuM1NVc2JiQjVLYUJGY0Z6?=
 =?utf-8?B?TytXZGJtTFpHczhLazVFMk9ma1Z5Vm5may80SW5CbWpFNTh5K2ZpSm42Ym05?=
 =?utf-8?B?NFhlUjg2WTNyanYxUThTT1F4YW9LQldqUktra1d5OXZQWlhqTFkxcW56NlJn?=
 =?utf-8?B?UXZHSXh1SjdzVjhOMHVCUUthRTdQODhqdHZwRDlySTlsazhOY1Y5TDBIN1Nl?=
 =?utf-8?B?b0pUbk9DOCtNRWNVd1dpUzA3Z1hEWnZabHhnSThNaFZwQWdqMG1yU3ltTkE5?=
 =?utf-8?B?b28vaFEwcUZkVnlFYlkrK2R6ZmgzWDY2a2xCUU9nZ3JwdURZRUNjbnhMQU5L?=
 =?utf-8?B?VmFrQmZQV09sVkt1R2htamNSVVB0dW9DdFNwQnEyWlJkdEhWQkd1SFRkOW8y?=
 =?utf-8?B?cmJHSU5LU0tSYlFsU2tsRXo1Sml0M3dzWGdEa1RxbG5BSDlqb3lQdW1Kd0Zs?=
 =?utf-8?B?T3hHZVh5VzcxczBkRys5VWZqbzY5YlNpdjc3dmhBdnZkUEpkMG1LeWV3cHBK?=
 =?utf-8?B?eWRRaVQrTTNQcklYNVdkVFVnQ3Jqd0Iya01yVnNxc3c2L0JKVDdnckw0cEIy?=
 =?utf-8?Q?/Gs9dD1WZ5qVBzi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C30AC58E93A644EA8AE2D0FE266DB60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d680b0-4e1f-476a-4196-08da171a6af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:39:05.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkQc2Nx+Gd82QM6N47c6uCpBY9h4UfeuTRRmiVsTKFpMYNfTIOEKsc14zlIgpbRfe3WRJ9is0zpZB3EijCNZUog98wcm2ppDd5ifoPIqj54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDQuMjAyMiAxODowOSwgUGhpbGlwcCBaYWJlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBEaSwgMjAyMi0wNC0wNSBhdCAxNDoyNyAr
MDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBBZGQgcmVzZXQgYmluZGluZ3MgZm9yIFNB
TUE3RzUuIEF0IHRoZSBtb21lbnQgb25seSBVU0IgUEhZcyBhcmUNCj4+IGluY2x1ZGVkLg0KPiAN
Cj4gV2hhdCBkbyB5b3UgbWVhbiBieSAiYXQgdGhlIG1vbWVudCBvbmx5IFVTQiBQSFlzIGFyZSBp
bmNsdWRlZCI/IEFyZQ0KPiB0aG9zZSB0aGUgb25seSByZXNldCBjb250cm9scyBvbiBzYW1hN2c1
IGFuZCBsYXRlciBoYXJkd2FyZSBtaWdodCBoYXZlDQo+IG1vcmU/DQoNClRoZXJlIGFyZSAyIG1v
cmUgcmVzZXRzIG9uZSBmb3IgRERSIGNvbnRyb2xsZXIgYW5kIG9uZSBmb3IgRERSIFBIWQ0KY29u
dHJvbGxlci4gVGhvc2UgMiBjb250cm9sbGVycyBoYXZlIG5vIGRyaXZlcnMgaW4gTGludXggYXQg
dGhlIG1vbWVudCAoYW5kDQpwcm9iYWJseSB3aWxsIG5ldmVyIGhhdmUpLiBUaGVzZSAyIGV4dHJh
IHJlc2V0cyBhcmUgY29udHJvbGxlZCBpbiB0aGUgUkFNDQppbml0aWFsaXphdGlvbiBwaGFzZSBi
eSBib290bG9hZGVycy4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gcmVn
YXJkcw0KPiBQaGlsaXBwDQoNCg==
