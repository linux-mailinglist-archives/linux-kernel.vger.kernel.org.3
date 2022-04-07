Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8B4F7FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiDGM5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbiDGM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:56:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061025A4A5;
        Thu,  7 Apr 2022 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649336095; x=1680872095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7D/CbMCIGfH8nk6gcLmaeG4pdTyIRvg9WkMT9K1NzUw=;
  b=YPMpoqTy4pAnmc9p80fW+a4uxwzyGqtvbvdDJWSiTbYKBHCBGR+AnY0A
   Qfq/jUXNmD2MzlWWKN4NBhP5LHQ4e/5bVDn4FVk3l5hqqoK0EE3S81Im8
   a6yRYePzfNl+Vzx58K68Yg2rfWJn4C84hd5QROU8XRFVjrHmKOHlVJqxE
   QS61iB2E6/KlqcXlPpjsmsm1fiqoQ8ZEJcV+Q9kLsxQovoX5nama3Rqa0
   9KoLiQWZw19Tqti4o42IvrGAIGgb5gvPRuRHuBNaVmmCRcVRcCvPXjbVa
   Q5TDQOrXvp1vliJynAOEvrUELfxNck4Dv3eGOYR9PL2xLZ2Qdxkw4R9ak
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643698800"; 
   d="scan'208";a="91624692"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 05:54:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 05:54:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Apr 2022 05:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEjQbF9r4j2aWxUatcQuIKvGaN/mUvxlDfkVYTLx8vU35zHVnBML3IHO7Fjm1XOM6Zh3TD/oF0Yj3Lt3uYVwz6VEcYyccsR3UrWYPfrJjRbLixYdTYSCuATc6Vfv2yjgo562HGqYuODFzZDUwFxJEPtIK/w3PM+eG+MHDIXBTlTdsCDoGsY3NSDyKx9Xh2kAAi18qF74Tja7eJaUaAf/6Eum5NwwdEuI2eh58QUxy4wOdMzzqFTC6+YhuInLYqVIA0C/oLGykV1FNxA6aMAmr45c9/OM4l2x1zTzWICjYwzm+qBVGFOMTQjWSbjg2I0eF4loV+6OKMlSqkmotiHkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D/CbMCIGfH8nk6gcLmaeG4pdTyIRvg9WkMT9K1NzUw=;
 b=Z756y0f4qt9lLb0XsFI1v2NjQ4gsyhMM6cf1ZMSfZNGK3Wvvb568EjrwfeFqwyWyNJegpnrEW4Xs+Ym4hQbhVcrTTxD5dZ7T4VrKL+9NgeK/A46oDzbO/4cxzFSxxvTBnuBDnCZ6uq4raZkHDDLhUhQGZg3a1qaBoD37quGE40SvPuWeoqj7VPd9WNM89efiWU4F5ID6UbccrLN0cLw8HHW1MdPowyDFPp5jn5WJrN9mQGuhfh9AQVSgqvDzWzNZ4hJMT/q8RBLqWPdb4CTTDlpuSY6ed6m7FJd+qEkSR8Rgyrlo0ye3th1pPUO3Fs6TH9nWMZsfEc8O9Y+1Ay/+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D/CbMCIGfH8nk6gcLmaeG4pdTyIRvg9WkMT9K1NzUw=;
 b=Myvk5rQ7c/5IkMYbsMmenGqq36hsBpeQibILPFkWD2WfsJ9Q/olJkEYbN5oNECmIhD7YnX7p2E3xAMAT19j1ad1X05d0+xrHohQ3ZcL1F1FUUzAfOdjkLqtZ20Y0mpaPPQcTLpA0er13R1Ix5v2o0bs1c+RllLy32EcfW4LMJyE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 12:54:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 12:54:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Thread-Topic: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Thread-Index: AQHYSn6qJ1ojdD401U6yY6Wxen9BEQ==
Date:   Thu, 7 Apr 2022 12:54:49 +0000
Message-ID: <0d1ad948-278d-4cad-9a20-99cf4fa984b9@microchip.com>
References: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8989c1b-20cd-4a00-489a-08da1895cd01
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5830EAD6AFAF647F0AC2D318F0E69@PH0PR11MB5830.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDTzRLxMiSdz5wWIIpT5WQQpw1/feAinaEwVohsHHhte9BouiGpQItnW48t7ZJtFAhPMzD8ZKXYBMnIqkIiqhxsQOlfSOS4CJTA8PAzh3cmJFlBoXQVd+z8IDBUtL+PDVFxVRng0+8avYL6VbAyyqcuLZqhphQzUYRmXhET4pu9DsisJVqK5W8cV0C/nxC08OorDAkzHDI4QPGW1S3IGHCuVlyYYX/XTRG8tGX5tTAjTiDYiRZY6V/tB/nGgZcpPnnxItNx8AOwq18xaV6yXWtDC738j9W1yDkQ/qRm5YPMd+J16SwOSfgEJ93kK5u1MiVEzq4hrBS/cSoP9Zesb5Jkt6M9A3r/5MTIItn7Fb4X1vfBIqziNeswEtczcG5T8qh1i44DGwrpwOwkYqqpJS+Spzadqza2OTGpNx9JV40zNjSZfUaXycunNd75tKTfAfSJcDIQBYUOWMfog9wB9idplvU0ph9NEIJFHbZf11CsHdHO2ID8x7+TcKzy1SLyl7Elw1qSzTFC7gBZDkEi5MRRCkAwq65TZe8s6hAQLDHPfa8EcokJ8jjYUvBzLMYHjhwOumPEOSX7UIzd/RekbQqUdXk0Ftr1FPgSlySaDKef1+wGruLNdhteJpvORG/2OdmGsQIzxd/0MGdLaK76NsdTsM+DGV61Cq8gvnqovdY79WqBG4FMSU//N0FqHFWDi5Hi7pOtfs4Q/f9HOgVfGVVtRnR2hwgIXCSVpmgX5HWyp8iuuBJZVTFcbKTdvSfyKXacv3NzHCtDQsfJ2Xh2XnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(91956017)(8676002)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(4326008)(83380400001)(71200400001)(6512007)(186003)(53546011)(6506007)(31696002)(86362001)(8936002)(508600001)(5660300002)(107886003)(2906002)(26005)(6486002)(4744005)(2616005)(36756003)(316002)(122000001)(38100700002)(31686004)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZRSnNSbnpObGFFWnVZamVGMEplbU43czdBSkE5TXlzRjhUZ25yaHhjSU1V?=
 =?utf-8?B?Sjh5ampUNnhnSlZ1dG0zT1J6WDdvRHNqZnltNCtIZjU0OXYyNFpIZkNuMlRH?=
 =?utf-8?B?dk1OOFNYbFdaNkNKMVRwbHAybDJGaXVCYjdSRndQQU1FTE0vRVJHeHdOWDRB?=
 =?utf-8?B?RmN1Tkp4UVlZTHBnZ2RFVW9Pb2pIeWVqK2hGV08veVN3NUcvVUNtWFpyTytm?=
 =?utf-8?B?bnJXUmo4UUxHdWZVQW16YS9wM2NoTFBSSWpMQmtVZXZMdE4ya0U5d0dFL3V1?=
 =?utf-8?B?Nno2OEFEUXZpdFRVRWpCbDk5TVFnSkVRWlFSRDVHSlBteUx1MVNTSjNqcENH?=
 =?utf-8?B?OHhJQi9iazlrUWlNVUZuQTQwektHNkJKTnVsS0V0blpuRWl2V2lvUGg5bTVR?=
 =?utf-8?B?RWgrVTdjMWZWa09MY20ycmR0VXljcUppdkVNVC9nYVBjbmJKK2h4Zy9KaDB0?=
 =?utf-8?B?VWQ1V1JFRC94MDl6N1N1Z3BZU2s3c1JSaGwwcml0TTgyNUZjQ0xXNnBMbllq?=
 =?utf-8?B?anRYY1B0b3k3dDgvU3JHUXZMUVVaVDdrWk1zOG5GSmhKTjVsVWxnaHorZzEz?=
 =?utf-8?B?K0tqU1hFV0xVT0xDTkoyWEI2eGE1Y3dqTkxnQ3lkUFZtblU5aTFwejJsZ3BC?=
 =?utf-8?B?bDRDWW9BVUgyT3FiZU4xNmIyWVRET1F4c1VDREovUWZkdXNaQmtQWlc2YXgz?=
 =?utf-8?B?SEQ1TGIzZGdTaDl0VEpZSE42bk83bGtxZEpQU1lGNlo4TWxXMjM1QUwyd2k5?=
 =?utf-8?B?YWVPaHJPYkE3VXpZSkY5U1BBajFObTA1WUE5UUpmbVQvMml4ZFp3b3lqVEdO?=
 =?utf-8?B?dEVkZm9tMWJJZlI5YzEvVTQvOUZ6cUF6RUxON2pCZ3R4ZWh1bjV4amtDRnJr?=
 =?utf-8?B?TFVTZWxDTzFqNWlQVEQ5aXY1d055bDVGc3N0ODhScHVzaFNQNyt3amtQNmw5?=
 =?utf-8?B?dFlHSG9jTENKRFBKUUx5TWh2dTF6bWZiNWRuankrK3gwamlLbFI2eEVkS1Er?=
 =?utf-8?B?aTNJR25URlVrMjR4dnZVRmxDd2ZWU3ZwNTd5ZXlMUWlObUxIOERRcUdxdlhx?=
 =?utf-8?B?MjdCb2pocWJ2ODdvemR2aXlqZkVUV1JuemR1N1VyOU5TeTZ1Y01UQVdITDdG?=
 =?utf-8?B?QWx0OUpac1BBUFRsem5NQitUcTNTWDFXK2kxc3B6ZU9PamZMSVhqSVNOTjg5?=
 =?utf-8?B?UWcwNXdCL2VGWC9RNXdEQmM5aUFDZmE0Tm9SbkpTc0xMT0JIVzdqR1d4Y0h0?=
 =?utf-8?B?Vk9yRjhJTlBRbnBOSGlPSzZWdTR1cWhMRUo2QjRKYUE1VDdONko1bk5mRHl5?=
 =?utf-8?B?WGd5N0E4T2JCaFFGT20yVXRkSEhWNkxDTjF6NnRTNU0vMUhEWnNIVnBJMUp6?=
 =?utf-8?B?ejg5ZW5veFd5OXk4Y2JIZC9LbTZrdUdlcG5wY09LZUFuTmZzV0hmSUpFRk1S?=
 =?utf-8?B?dS81RlJHM3hNQUthZkIrdGRzcWJQdTJiQ2h2dk9tZzZzbXhtSVdHWWJxczlC?=
 =?utf-8?B?SkVOM2tsL0dDVk9ocUtaQ3J6Y3hmYzYzZkxyV0o4U1FhZFoxREtsZWk3WThu?=
 =?utf-8?B?dzhBQXczMW1wc0IwVkxPUDZpTWpMeVN6elVzc213aTBUaWNhdCtDY2htcGE4?=
 =?utf-8?B?dUJTV0hDMVF3UnJXWUNGVDF5bkxQY1JYQ09ISFlZUlpkZHA4eDM5RGxyb2FG?=
 =?utf-8?B?VDJpRmtYaGtOcjBEZ2ZiOHl2UVNvWmxZcFlYUlVjbmU2V082NktPZDZJL20x?=
 =?utf-8?B?YjhsSHBMdmFsYkpOMEtVUWRORUlVeGNsWTNxUHhSemZmUnN1SjRSRUh6a0Er?=
 =?utf-8?B?Q2lDZDhBd2ZiWjVRd2RNT1RTN0M4MzliOEI0b005QVNsaXBEWGozNlArckwv?=
 =?utf-8?B?R05OdnR1Um45UklSZ0w4UEpjQXRLb0FqUjdXcEUxTVNsbmtIR3E1MTJOdnJl?=
 =?utf-8?B?Z2VMR0U1eWk3TGdNR0ZCS0xtcW9ZaVRzQndCMUR4TjVKVkQ4L3lqOXdtZDlk?=
 =?utf-8?B?UzRQYjI3Mzg4enZXQ2ZMY2xCU29hT3BWb2VyZTE0VnBHMHVhV1RRazZqcmJa?=
 =?utf-8?B?ZXZueFBYcGpqd0s0bzVITDA0YzhxRHIvM29vdnkzUGJGT3ZkYXlaZkpocWxs?=
 =?utf-8?B?bm9vRk0zVjdYdEtLMFBPUmFVNnlQeXJwQnlrUlhDWkNaWW9uaWxjU2wxVUVI?=
 =?utf-8?B?R1docFk3dFZsM1FqdTErSXZ6OGUvV1J2YnlScm05YW5WbGZnckJHb0d4NDcx?=
 =?utf-8?B?WitocUlDcnNaeTdpQ2NGNVZTNks1eHAyYkdGQWFmdTltcUVIUFhPanQ0cXhL?=
 =?utf-8?B?QTZxUWpLc01lUS9nNHJSZmtYWWtyNytOYzZMSDNrMTV5bE05Mm9haFpiNU1h?=
 =?utf-8?Q?JG5N2pJwHsS55yDI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B612E37ED2F2E45809A23D44328B433@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8989c1b-20cd-4a00-489a-08da1895cd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 12:54:49.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ygjV9GJemwMxaW5nbZUfAbnsyd3pixLh9bb+GV7jKJ9dPy/qJqNDzz9bKir+X/k2w7WRHnref/eQ/f2uS4OF1J6ffDxtcb9Qr1On1nmP9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
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

T24gNC83LzIyIDEzOjU0LCBLYXZ5YXNyZWUgS290YWdpcmkgd3JvdGU6DQo+IExBTjk2NnggU29D
IHN1cHBvcnRzIDMgUVNQSSBjb250cm9sbGVycy4gRWFjaCBvZiB0aGVtIHN1cHBvcnQNCj4gZGF0
YSBhbmQgY2xvY2sgZnJlcXVlbmN5IHVwdG8gMTAwTWh6IEREUiBhbmQgUVVBRCBwcm90b2NvbC4N
Cg0KSG93IGlzIHRoaXMgSVAgZGlmZmVyZW50IHRoYW4gbWljcm9jaGlwLHNhbWE3ZzUtcXNwaT8g
RG9lcyB0aGlzIHNwZWVkDQpsaW1pdGF0aW9uIGNvbWUgZnJvbSB0aGUgSVAgaXRzZWxmIG9yIGZy
b20gdGhlIGJvYXJkIHRoYXQgeW91J3JlIHVzaW5nPw0KDQpOZWl0aGVyIG9mIHRoZXNlIGluc3Rh
bmNlcyBzdXBwb3J0IG9jdGFsIG1vZGU/DQoNCkNoZWVycywNCnRhDQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5j
b20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1l
bCxxdWFkc3BpLnlhbWwgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
YXRtZWwscXVhZHNwaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nw
aS9hdG1lbCxxdWFkc3BpLnlhbWwNCj4gaW5kZXggMWQ0OTNhZGQ0MDUzLi4xMDBkNmU3ZjI3NDgg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRt
ZWwscXVhZHNwaS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvYXRtZWwscXVhZHNwaS55YW1sDQo+IEBAIC0xOSw2ICsxOSw3IEBAIHByb3BlcnRpZXM6
DQo+ICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXFzcGkNCj4gICAgICAgIC0gbWljcm9jaGlw
LHNhbWE3ZzUtcXNwaQ0KPiAgICAgICAgLSBtaWNyb2NoaXAsc2FtYTdnNS1vc3BpDQo+ICsgICAg
ICAtIG1pY3JvY2hpcCxsYW45NjZ4LXFzcGkNCj4gIA0KPiAgICByZWc6DQo+ICAgICAgaXRlbXM6
DQoNCg==
