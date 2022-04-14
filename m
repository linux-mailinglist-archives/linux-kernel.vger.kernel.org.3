Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7635009B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiDNJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiDNJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:28:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC7549937
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649928345; x=1681464345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R8jV0d4DSOmXpDNdQUCpkBsf5bGk2lvRy0SFC04yO4I=;
  b=mmjd2BVmp8mcZjOONa2CkoEjr9BYJahXJvlOl1q2g6Tp2P/L3qwz0vcD
   lnrUaB7ByiBAJp/xQLKwBq8jH5+0/aw9JLgHKsOq7Le4TEWRA80iE6ZVv
   JN4F+qeMsTHxqCr2QLmRtY/K1N7FbZySLKg6tM2ow4ZcN076T8QvmkPqF
   A3wGTVtMiu2oaUGSqRFAwKWiSU8Mq1UVaY4L1/2YknzqwAR6wzvD1s6bD
   5Q6/+Z9Q59XblsX+4QvuR7/bW8y2AseVpTGM79k3HsbR6jiuKIif+R5qs
   buVhyo/5yXkQImU0OuroZ7sMFKr7Z9CnFFuyr86zTW3y0vYCF+xBXKNt4
   g==;
X-IronPort-AV: E=Sophos;i="5.90,259,1643698800"; 
   d="scan'208";a="155549472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2022 02:25:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Apr 2022 02:25:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Apr 2022 02:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0G8MPMUNcZleseQnpfXKs3zofZIeI9F7nUcSJZIt/SL1PON9q2jepWQUOjcZbCZCtmJOPFftV10EI7ZedVZvSvIdXoRMrGvcLn9+9JwWq2L6NRGCU+mXbfnSnmqYG7xT6KS8vTs3BjXzEyoWkDPJ+w/h2Vd+GGn+PobI6NpYEOVjW6u30zffwxM0yfY6nPr7OPXUnr09rTeqFFAcabz184P+lDT4X0lZ50aA1uzXPs1WjkGQC17p/JzCgHuFvRrPzpyPdwG/bGD42UMoaM1PEIk9HsYcCyHhyxz4ki9AX1FXIec4try4VtLbzOwNWtKTiRSeLf3ssDY9ZXnDo+23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8jV0d4DSOmXpDNdQUCpkBsf5bGk2lvRy0SFC04yO4I=;
 b=N/PMPIWGBFJsGQHOI1EU6kCZRX2dfPYio6u4ovNhw2OmFoL2OlfFYb/7JSEremigRd+aoOEsTEvHfen6UtKT3PtS4m5ahgjs59jSXQWHNMps+AOMNmY9oc9J0c6OBkib3Rq2EUujOnmsINbCARQtmtlxEauxi624pJlpmGPwrvYf7+h1GD1Ot0T3FuIzEUDgsbS7wvig7frvMGiZEeWGg8SAL14S5a5ic6II2PyWIbWzW+Z8bmy5oR/1hjHLcqIKwnQqUiWTgvqFS4hQJkF9wQd3ncXsLl08xoDCNYRaRkO3LCK3TDroDswP/2l+oXJ5cVn8UYlpcHm+EHeVmgC7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8jV0d4DSOmXpDNdQUCpkBsf5bGk2lvRy0SFC04yO4I=;
 b=IG4G0Oys2z3+xv6Z0Y8VxsItUQdfJt9CDWEDW6kwqemmtYYlJENMlCaGzEFgG7bYpFVcXJRJh2MYohj6GaLO71/T7y1r/yZRM5P34wUJW6H2/SfKfxM0FaAuCLX1q1DkM4BDQ/9L3Z9LCC/sk5jld7cQ8OTuFBdDquvoUAHoIis=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 09:25:39 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 09:25:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
Thread-Topic: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
Thread-Index: AQHYT+Gad2GQpwhg0EOQ+Omlnxp13A==
Date:   Thu, 14 Apr 2022 09:25:39 +0000
Message-ID: <78aa1754-2f04-9f0b-72ef-f06535a413b0@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-2-tudor.ambarus@microchip.com>
 <63b485a1e48d3116f8f49cc427049f81@walle.cc>
In-Reply-To: <63b485a1e48d3116f8f49cc427049f81@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e7a876-514d-4e08-92ff-08da1df8bd52
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_
x-microsoft-antispam-prvs: <CO6PR11MB5602EBA95BD0E404EED7B4B1F0EF9@CO6PR11MB5602.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTQhEml2PMacUhu3qmzMtAsj4pZy6iq3LHOBaXAI2AnWcrHviaGPrZDnPGRUH9+7sTqEb0zd0EvAauJyAldxI/CsIWQyr63q+nJwKjDWbaAbqGFUJRuk4/uqUw3ADcRx8Rk6h/uNAFXMCQddB1HH3/pLvm1yi9uvIsJKPE6XQnh76kQ7B1pLmXekt1EJMmZoeCMB3kxb07UpxvGmtkdCKJG+95oQqlJUANpdGpTAo2n7VWQ5kxdC4NVARsf6S7Tl+jtiBFnkjkVhasvQDZ9nXwtS06owAKxfod/gIpftOvP9jSzBrpjOOm6Lt1lT7lD+FjLy2IHBTAMb3rF/iqvZx3muvQc9UFuzUPXbXwON3+sQBOTfVEG8eEWQvEF3bGQ513iuBFxip+26OcoZZ5iJEjFIKicOfICCwRMXms02Q7Bemrx4QdT2+zSARv0NsKcfc6dh6xzO8rV6qEg/1bgbvRJNWUEU9XdNJuoHygLK/xTCieQMgLbRn9nCh3vMYAj3NjyyO5KL8o32+hMONCpFc1Zj2eawso6lKd8RlmlYaMcw/rHZbMgR3kq33Oqk0O8wVbgzZntSh4WR9yw7PQ3lgLtGxyJuKfFp4yTES4l0FZYpCu7P+FmHGioV/oYuWAMbLbYcIZPHxTHi8pWtQ5/UX+QQKx0iVkRc7d4OO6bpPJUeZv2JQzOKYG2MKTm4WCEcw+5abws6fWthBa36Y8wmDXk8/MupwNzl57y+bKtLOWHghtbVfzqxIzFzhCvUt8mX2zhHykDrUukg69YZYQcN3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6486002)(6512007)(8936002)(6916009)(6506007)(508600001)(107886003)(122000001)(54906003)(26005)(53546011)(2616005)(186003)(31696002)(86362001)(71200400001)(2906002)(31686004)(5660300002)(36756003)(91956017)(8676002)(76116006)(4326008)(38100700002)(38070700005)(66556008)(66476007)(64756008)(66446008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JNMmdWdFRyaGRoaHM5dk1FdUk4VXNIYWpSM1R5T0Q4OWdhUXJJQjVsV055?=
 =?utf-8?B?Mkh3bWdvVExXL2ROV1NJZUpxbUVuR1BFdVRCMC9IYmpOU3I5Wk81K2EvZHd5?=
 =?utf-8?B?REJ2a1hhZlNOdmZSeWduQjNrK0FlbjloYndSNDdEWHJFRFg3aGhaZy85QUVJ?=
 =?utf-8?B?OEpkajZNRnpxQXVtUzBjMHpGVk5TUXZnS3ZlMzZwVzVRZUlHalNTWWQ3SGZE?=
 =?utf-8?B?Y0p1VlQrRDBoNUlFNGppZndvMjAyUnBKOTNyV0ZDWEY0ZGJET3NUQ1d6dFll?=
 =?utf-8?B?b3hhN2dhazg2NjZXR3dsdDJ4aVZYOTgvSGVRMTF5QzhwcGhsYW1CU1kvKytK?=
 =?utf-8?B?dlNycnhISm1rQmNiREZrdThwLzVObDhaTS8vcEhoSWY2Zy84ck41SllXTkEw?=
 =?utf-8?B?MUFjK1lIYW9uMmRna1gxRCttZFRRRHBFZmdlRFNWdnZqSDMzS3krNnZWTkg5?=
 =?utf-8?B?SkY0ekVXMWszcVIyWUxySW4rMEMvaTQ4Y0pxREUwL3Y1bFFOUEE0RXRSK1A3?=
 =?utf-8?B?cEpBWnNTK2NVOFU5UXlFN3ZFd2tpREtnYkNIV3dMc2ZudnF0Snh4elBheFR3?=
 =?utf-8?B?U0kzbERJNVZvWGpadndZbmlwTlF5RWxnbTdnSklKcjV5RDVNS2JFTkg5U3Nt?=
 =?utf-8?B?WWxEbGhVT1pRTTJ3REcxQWVJVzVWVkpZV3BNSmNDQ3gxeHJsWFFubWxVYXhX?=
 =?utf-8?B?OUxWSnRxM2lIRVpzVm1MSjdSRnpreGZUOUQvRDU0YnRIYnAzVVN2YlE4YlAx?=
 =?utf-8?B?UytiMkhvenJvOHpTM0sxNDA0STNkR2J2ZzF2U2RPamNiaUJSS2ZpMkI2aXFX?=
 =?utf-8?B?N290UmhuUXU4NzNadU1xcGtuak9LeWhZWEd0K2h0REQyRXozbzMvVFIraGJu?=
 =?utf-8?B?dGZPc0htSnYybTVyY3orUkVJb0g1clBLUHZpTkVROGNhSmQ5SjFWdnVpQ0Q2?=
 =?utf-8?B?QWlRZnB3cHh5eHZZWmhucWx5US80eEZnY0pJdG1taTNYVThXeWlnRmxiUWlx?=
 =?utf-8?B?VTIxNmgrZ2JvOTk2aXA3UG9pdGwvb2IybHBvNC83SDI1encybWpabnNySUlV?=
 =?utf-8?B?eU5pOHllQ0d2b1dZb3BGZU1ESHdyQnJNalVnQmhFWUxBUVZiVUhwMzFjQzdt?=
 =?utf-8?B?OGtQdkxQL0NvUVpkZVNTSlJxZThKVVBpM0VSdHlsb2VKQzl5MHZSVkNYelQ0?=
 =?utf-8?B?OTEvOTBoNGtDZHJpUFJ3b2JIVlpjSVJZU0x6b0QxM2U2c0FPR3hCTHRDZDJ0?=
 =?utf-8?B?RnJBajVtQXRDdWYra2t5a0tzN2pTNlBLTGlHaGIzL2R4WkhqMHdoaHB0NmVI?=
 =?utf-8?B?aDlZcW5EVVJhd1BrbFpVUi94Y3hGa0FaNDZrVFVteWpyWmR4WHBkR3FhYkxl?=
 =?utf-8?B?MUkwQm1oUGVNYnMxd25kWjZqcnY5ZURsVjNDdmtySUxySUxmd0trNEFHeGRo?=
 =?utf-8?B?TW5SVmJjVERZRnBqQnZLNlB4N29SMzJTWlc3WWovQUtCNDZ2Wkp2MGtQSVB6?=
 =?utf-8?B?cW5YdnZZWmJhcXRlMmhVeU9ER1FuVE0wSnNhZGJHSm9DdlNCZm5XK0xJWHlM?=
 =?utf-8?B?ejhSamRtdW5XcFlvYUg3dDdJaUxyK3RqMXBETUFNR3V4QUxZSUcvaWpROE9G?=
 =?utf-8?B?SFRVT2VBMGN0ZVJCSTlyUXVYeDZ0T2loU0lPaUUrSW5BaDhSS1pXZk1Ed3E0?=
 =?utf-8?B?YXh3cmZVdmN4Q1NQbS96RDl3ZFUxZDlHOTNHSGN1UlBPcFhYQlVIeUdBRVNQ?=
 =?utf-8?B?ektDY3JVV0l0Wnl3dEVQZEhQUFArV3VsVVNzTTZORDFyN2lRU3BPOTE2SVdj?=
 =?utf-8?B?QjlNUU1IdkF2K211WHZ5OTdqWHUrNzZZczV4clRJdzAzbDQ5TDRzZzR2K0pF?=
 =?utf-8?B?Zll6ejQyS1M0T1o2VTB3YUNPcWVBSkFoOTA1RVlIYkVuWnhtR1plNWM5ZVc4?=
 =?utf-8?B?S0RWUFhsUkptRGdaU0xWdG1JTWxnVHBjdGZNQmc3aVlKQ2w5S1h0cElVK1Rq?=
 =?utf-8?B?M21kS0lnT1QwelYrbStqSmszWHNiTGxNYS9NdUdPbUZBWDFxVnduQnRtVzFo?=
 =?utf-8?B?UHlET3dqSy9wQ1l2UUE0K1dFU2E5SzV5ZEVZbDdCb2hYTDBzUDMvQVNmL3hq?=
 =?utf-8?B?YWhRZUM3ZExoVVFhOUhzd2UxVndtd2J6UHY4TVRWZ1dscExzbU82Tk8yU1hH?=
 =?utf-8?B?QTljODhTVEswcWR0NFh0eldtV3dHQ2o3ei93d29zc3gvTC9kc1d6MzN6MmhI?=
 =?utf-8?B?djRoa3BqalNuVkdYMi9yeHJkdHZkUXQwdXZBS0c2eWNpM2pvYVVXYjNqZ2Jk?=
 =?utf-8?B?RFVYNjJlc3RpeWVCcWdrZFRERC9lSjFEcXQyWGd5a1YvRjFXOFF6bW1HTStW?=
 =?utf-8?Q?xU9GhRt7uEXKwEAk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D92DC424771BE448E9DE2C5EC8281DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e7a876-514d-4e08-92ff-08da1df8bd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 09:25:39.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+SmEDA1J4xlfHpp5J4nUngNhmkyD2aewcLzNblN1gaujobgpKGkQ6lt9w77x2mxaOES0S6UyKki+Qt9v3n6JW1RK7pEcZJN1bE4UDh66fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMiAxMjowMywgTWljaGFlbCBXYWxsZSB3cm90ZToNCg0KSGkhDQoNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc2ZkcC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+IGluZGV4
IGE1MjExNTQzZDMwZC4uMmU0MGViYTM3NDRkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9zZmRwLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+PiBA
QCAtNDAxLDYgKzQwMSw5MyBAQCBzdGF0aWMgdm9pZA0KPj4gc3BpX25vcl9yZWdpb25zX3NvcnRf
ZXJhc2VfdHlwZXMoc3RydWN0IHNwaV9ub3JfZXJhc2VfbWFwICptYXApDQo+PiDCoMKgwqDCoMKg
IH0NCj4+IMKgfQ0KPj4NCj4+ICsvKioNCj4+ICsgKiBzcGFuc2lvbl9zZXRfNGJ5dGVfYWRkcl9t
b2RlKCkgLSBTZXQgNC1ieXRlIGFkZHJlc3MgbW9kZSBmb3INCj4+IFNwYW5zaW9uDQo+PiArICog
Zmxhc2hlcy4NCj4+ICsgKiBAbm9yOsKgwqDCoMKgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9y
Jy4NCj4+ICsgKiBAZW5hYmxlOsKgIHRydWUgdG8gZW50ZXIgdGhlIDQtYnl0ZSBhZGRyZXNzIG1v
ZGUsIGZhbHNlIHRvIGV4aXQgdGhlDQo+PiA0LWJ5dGUNCj4+ICsgKsKgwqDCoMKgwqDCoMKgwqDC
oMKgIGFkZHJlc3MgbW9kZS4NCj4+ICsgKg0KPj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAt
ZXJybm8gb3RoZXJ3aXNlLg0KPj4gKyAqLw0KPj4gK2ludCBzcGFuc2lvbl9zZXRfNGJ5dGVfYWRk
cl9tb2RlKHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiANCj4gTWgsIHNvIG5v
dyBzb21lIGNhbGxiYWNrIGZ1bmN0aW9ucyBhcmUgaW4gdGhlIGNvcmUgbGlrZSB0aGUgcXVhZCBl
bmFibGUNCj4gbWV0aG9kcyBhbmQgc29tZSBhcmUgaW4gc2ZkcC5jLiBJIHRoaW5rIHRoZXJlIHNo
b3VsZCBiZSBvbmx5IHRoZSBwYXJzaW5nDQo+IGluIHNmZHAuYyBhbmQgYWxsIHRoZSBjYWxsYmFj
ayBtZXRob2RzIHNob3VsZCBiZSBpbiBjb3JlLmM7IGFzIHRoZXkgYXJlDQo+IHBvdGVudGlhbGx5
IHVzZWQgYnkgdGhlIHZlbmRvciBtb2R1bGVzLg0KDQpBbGwgc2V0XzRieXRlX2FkZHJfbW9kZSBt
ZXRob2RzIGFyZSBkZWZpbmVkIGluIHNmZHAuYyBhbmQgZGVjbGFyZWQgaW4gc2ZkcC5oLg0KSSBr
ZXB0IHRoZSBtZXRob2RzIGRlZmluZWQgaW4gc2ZkcC5jIGJlY2F1c2UgU0ZEUCBkZWZpbmVzIHRo
ZWlyIGJlaGF2aW9yL2hvdw0KdGhleSB3b3JrLiBWZW5kb3JzIGFscmVhZHkgaGF2ZSBhY2Nlc3Mg
dG8gYWxsIHRoZXNlIG1ldGhvZHMgd2hlbiBpbmNsdWRpbmcNCmNvcmUuaCAod2hpY2ggaW5jbHVk
ZXMgc2ZkcC5oKS4gTm8gbmVlZCB0byBtb3ZlIHRoZW0gdG8gY29yZSwgYXMgdGhleSBhcmUNClNG
RFAgc3BlY2lmaWMuDQoNCj4gDQo+PiBAQCAtNjA2LDYgKzY5MywyNCBAQCBzdGF0aWMgaW50IHNw
aV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7DQo+PiDCoMKgwqDCoMKgIH0NCj4+DQo+PiArwqDCoMKgwqAgc3dp
dGNoIChiZnB0LmR3b3Jkc1tCRlBUX0RXT1JEKDE2KV0gJiBCRlBUX0RXT1JEMTZfNEJfQUREUl9N
T0RFX01BU0spDQo+PiB7DQo+IA0KPiBJIHdhcyB3b25kZXJpbmcgd2h5IHRoaXMgaXMgZW5jb2Rl
ZCBhcyBzaW5nbGUgYml0cyBhbmQgbm90IGFzIGFuDQo+IGVudW1lcmF0aW9uLiBUbyBtZSBpdCBs
b29rcyBsaWtlIGl0IGlzIGludGVuZGVkIHRvIHN1cHBvcnQNCg0KYmVjYXVzZSBJIHBhcnNlIDIg
Yml0cyBhbmQgY2hlY2sgaWYgYm90aCB0aGUgZW50ZXIgYW5kIHRoZSBleGl0IG1ldGhvZHMgb2YN
CnRoZSA0YiBhZGRyIG1vZGUgYXJlIHNwZWNpZmllZC4NCg0KPiBkaWZmZXJlbnQgbWV0aG9kcyBh
dCB0aGUgc2FtZSB0aW1lLiBUaHVzIEkgdGhpbmsgdGhlcmUgbWlnaHQgYmUNCj4gbXVsdGlwbGUg
Yml0cyBzZXQgaW4gZWFjaCBlbnRyeSBhbmQgZXhpdCBtYXNrIGF0IG9uY2UuIFRoZSBzcGVjDQo+
IGxpc3RzIGFsbCB0aGUgZW50cmllcyBhcyB4X3h4eDEsIHhfeHgxeCwgLi4NCj4gDQo+PiArwqDC
oMKgwqAgY2FzZSBCRlBUX0RXT1JEMTZfNEJfQUREUl9NT0RFX0JSV1I6DQo+IC4uIHRoZW4gdGhp
cyB3aWxsIG9ubHkgbWF0Y2ggaWYgZXhhY3RseSB0aGVzZSB0d28gYml0cyBhcmUgc2V0Lg0KPiAN
Cg0KdGhlc2UgMiBiaXRzIGFyZToNCmRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5oOiNkZWZpbmUg
QkZQVF9EV09SRDE2XzRCX0FERFJfTU9ERV9CUldSICAgICAgICAgICAgICAgICAgICAgICBcDQpk
cml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaC0gICAgIChCRlBUX0RXT1JEMTZfRU40Ql9CUldSIHwg
QkZQVF9EV09SRDE2X0VYNEJfQlJXUikNCg0KV2hlbiBib3RoIHNwZWNpZmllZCwgSSBzZXQgdGhl
IG1ldGhvZC4NCg0KQ2hlZXJzLA0KdGENCg==
