Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7845525BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377634AbiEMHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiEMHCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:02:36 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2164.outbound.protection.outlook.com [40.92.63.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D56E15D9;
        Fri, 13 May 2022 00:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDWGJYjC/yQ+87flrIKWF1E/8IbquatJkNs9WddYyJBEp8FZw8yw4ABoKe8F3dDDHOdjImHTI4o9Uo+kQ9CN/Cl6AoLLf0kNjUy3QDVc2uQ8XRYfOIOUd6Fd3Qx6gyfBOZv5JKpWdYSXTCt7Rd524+w6uCe+9mGJJhCfhK73f8xe1PEmxCwkQVHxjjnjbXxIuZ0ZPaI/EKsSOQgf/ubbZrgKLo1r1tt/0aVyBr4vC031oHzYCS/urs9k9yIPeyRlUO776UKmOtOVgoaTOyE0oS3Y0U9cOGwnUdlzpJMC0iIwb73t4//aaqCcrTE0XdEHyLLZjkigcyJKx53xNbKwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA1rcOeCoJbj9UlQc43BCDF7dG66g1FbnFDGUfcvlm8=;
 b=aO2xASJ+iNekP4J+JaH/DLUFMWd3VPuNDvE3ytnh78/0MS1y+OAafnpBbMgdfnSKOmeDQ/zqUGScHiR1wDjbflksYT7y1iHbt7OUDBnVJwfz2rmlTHhqdkH9qJIE3MD8/j1UNoJNnXJ31pag5oMzbYvMTqs6kSoeFj2YMAqDONlsnA9w58qVC9jOcnV9vaZ7HGiLVtXgJJiIzkZO0JfLhtLKhANA0/6lIXdsKzDqDj0/5J0E8Dfww/JTJZz5zprXvCHXBzZMXXQAQ2xqgNXshqQyKzXKk0uacq+TdQFu+9PqCDSn6Fef1tAHD8izxJqPiblLanDUYp4PzPZNq1ri9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA1rcOeCoJbj9UlQc43BCDF7dG66g1FbnFDGUfcvlm8=;
 b=qwOa/eL4qFtRXvf8VJcmtvNK7DRObCuCvs8uQKZIYp5tyyyLtAeBuoHu20COUu4DS0jWikFRZJzyNw7fxmiwrgqhX96CKnO1I2E1qhhbEBhAcW7rPEIiSC42wb6FRGIL+Kfut9mzVy92AE/cORPx1AH3kwJLjKXgdTYoWVqwwWGxSIJIylXLzsAGO0qgybae4P5E6/4AvNlB9l9QqFtR4VJN7S98tkx+vckGZeZE+r+aV2koT4/32uDOxWXcr1Yt6mP1dtfOX8i6flFXdLj3Y0F+ezD/8d8fNd+L3kl7yG5SwcAEs9g+fxjoDYm/f5Ux4BU3V9DuKyUYTsuGT1qJog==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY7P282MB3836.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 07:02:32 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 07:02:32 +0000
From:   =?gb2312?B?zLcg08DB1g==?= <yonglin.tan@outlook.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSAgICAgYnVzOiBtaGk6IGhvc3Q6IEFkZCBzdXBwb3J0?=
 =?gb2312?Q?_for_Quectel_EM120_FCCL_project.?=
Thread-Topic: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL
 project.
Thread-Index: AQHYZo6bvlP9NbkcAk+5cZqFGYR6t60cUaqAgAANZbA=
Date:   Fri, 13 May 2022 07:02:32 +0000
Message-ID: <MEYP282MB2374A2C19E2EBCC4E090AA77FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2374B995796DE1B2D23FFA02FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yn31EYLyfrHaTe6S@kroah.com>
In-Reply-To: <Yn31EYLyfrHaTe6S@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [MTy39XB83cZIjk9i/hyEyCIy6r6t7nn5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0209e8-a4de-4955-6a21-08da34ae8d0d
x-ms-traffictypediagnostic: SY7P282MB3836:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URU6i4+0P6wmEyxnqTz9Ne0QS6wWpDDKK02DbRc5Y7X2xrJ5OZBMfp3n6bI8z9y8UdAIIRfLtAh3a39H9Vbu0i+sGzGDuRYoqvUqwBFaDDuk/yiBPOJvwJ02dWfs3DmPzK/9f+4H/31H5sqXgwPqE2cFX8GDyV9w74zMmc/PzY+mR8PTpAwQtrrpKlBIznxagSf8JHQAif5VPSbwOMRY5axHnW1mCRsYoMntPj0Hvl21wRBDX0yRYujeAU9hOKvYRCSaJARV0WHbZcJaSc59UNNxYJjeY4D8Uy8SDedk56Rzql/wHeNE0QS1RMv6305IU+0RTAX01XPY6SZeRO8kGYtOgiAwWJvUtNqLPBTIsASLt0PvM3qZUDSUalhUEvBPHOuC3sPc0UW7moxQJkWQIqXhGikiIBK0K/Z1Mlcbl8nxUe+zKwoZr5PwIHBrwpD0GrmF+AaBAXe7LzOC1g52zBTxGpBWvYwgBm5fM8pj/q3DbLMQGXHbOy+Gj/RUiqZTAw5KqAUyOWrGNVQbXlyv8/9PvNQfLl4RbaEx6j5+PLdIJii1BnkmGcQxr3egv7OSmfZkkm0OG4xnqifDSS4TnG+KHwui2ITdM/m/VitONNEZmuveEJwyjbr5RZuU5i3/
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QXZsT2k5cjNOTGJBS05ORUdsbi9ZQWQxbUVnOGxwZXlxNXZFNjJXSjVUNmhV?=
 =?gb2312?B?V1d0UUZ3c2RXYit3aWR5Um1aQzM4Y3lKcjNiOWx6SlZvKzV6TGpuMDlzTDZN?=
 =?gb2312?B?ZFZTUWIwSE5uaUNaWlgyUE4yVFY2aFFHQ2VFdTFlZTZGNFRYaWFXbi9iTUd0?=
 =?gb2312?B?T1ZWR2JRNHd0R1RzN1k0Z2dzblBYTE85SkpQaTEzQTMyZEJOS0pUSGNVMkl3?=
 =?gb2312?B?UTkvK0hBLzRHVUZpdWc2Z1R4aFhtVTZFNjFrdlIzQTZ3SXppY3NhU252UnFM?=
 =?gb2312?B?bmFtMTdYc1JmdjUwcjdWb0dsd3RhamtMZWpLWFFVTGg3TVNqQXFHUTZvL3VV?=
 =?gb2312?B?cE1uS3ZXZUJFYzBkbUx5OVIxdkZtWXRXMVZNSzJGSGVGUyttNEZQYVN3eU1n?=
 =?gb2312?B?UzMxNlY1bU5zMTR6Q2haYTFtS0tzTUd5OVNJa2s5cDNXZzg3UjR2WmxLdWVp?=
 =?gb2312?B?dk9WSDJucWF2TFBJYjRIWWJiWlhpSEdFbHc2L2IzczgzM2tBR3RtWjkwT3N6?=
 =?gb2312?B?Q29QZkhRNGd0bmZqYjY5aXNRYWV2anhtSkZCTm9UdSttemVlQlFyb3pTMmlI?=
 =?gb2312?B?d25uSWpNTG1zcDBTZnk2OHBxWWxJenRoTTRmakhnSDZCKy9wOEhLYzRnQ21r?=
 =?gb2312?B?aEZUNnozSUpUa0MybURob3pQRVh3TWNFbFBOa3puTDZ1cmE0VlFibHFkaFE4?=
 =?gb2312?B?NzRBSzJxRU5KZVQ0NTNoWGkxK3k3KzVXVDdQSjdJNkRLdXNsdmM0U2RlV2Vv?=
 =?gb2312?B?TUlFWVI5THVsWi9FaWV4OEZLTlJRUXhhZUNzRmpJU2w1aFR0Z0dUY0c2RTZo?=
 =?gb2312?B?TlZlZnE0OTBUTWZGU3R4MUIycGZka0VUUEpSUGJxVDNObEFtdHZWOUI4UFJ5?=
 =?gb2312?B?aVBoZjB2ak9MWjltRXJXdlJrUlRONTBEbGhnQkNPaytsV2l6RUM2WDNTSGFp?=
 =?gb2312?B?MGFkRm1jWFVic0JSWVFCODNqemZKOWFjYU8yRUU0eklRMW9VUHpWbUUwNW9i?=
 =?gb2312?B?eCtHS1dqVGJKTHpGMzFrdE9DYU9jZ3hFdTZmeitLYlUwQUF4NUovVlRKRzli?=
 =?gb2312?B?SEpPWDVNWUtTYmZUdzF1Ykp0QWNOWGsvMmlMVVdWWDA0TmVKcUd2QzhWODQ0?=
 =?gb2312?B?R0RCbkF2Y1VONHM4V1ZlVjZUR1hJM205RVo0M25tVElobkhFYU9wRlMxZjFk?=
 =?gb2312?B?R0tzWVdNK0F2aFJiOFhoSjM3d0NFcVg1dEFnM2IvcXVSblpWaUk3ZnU5cUZh?=
 =?gb2312?B?NlJFZ0JtMmg3UGMxayt6c0dWWVdhTjhGMk5IR0I0RUliVkRRUWhEYkI3QkFk?=
 =?gb2312?B?ZEt6ejE0R2swUVgzaGhoaUcwQW1OejNXSi82TVhiMnRJaE8xbHB4MC9XTy9p?=
 =?gb2312?B?UXVyd1FGdWlJcTFkT3RwN2NWZnR2ZVArUURvOEhQS3loK1ZHbTdDU24rYUU3?=
 =?gb2312?B?bDczQ1NiMEtMUG9KcFpxeFp2d2FzbjlOUGtVNDg3aHI3VXVHNTM5MGNZenpu?=
 =?gb2312?B?L2J2TERONnI2QmxjNUY5YVJMNWlSOHJ4Q1ljdUhuT0MxV1N4WElISkFjZm1Y?=
 =?gb2312?B?TnJRL1dZRE9IelhJUEpmYUxRM3l5K2h0ZWtTaXdYbEpzdnU5Q3hSeEc2UmFB?=
 =?gb2312?B?Si9JMWQxUHgrZmpjNW5uVGtydjl4VDdxejNubllpNy8xMjh0Zks4YTIzN2ht?=
 =?gb2312?B?K1IyLzdzWFRIc3pxV3UxdU9ERkx6REp2TUxZV0I5dHVZUnRGaXJWN0NST1VL?=
 =?gb2312?B?b1ZOWlZERHRPZUtldjY5Y2J6MUVGMk1TRktlM1RUS3JXbHY3SzU3dlRPUER0?=
 =?gb2312?B?cXFVclhKT2o4TU5ueVZYWUVpYlNmenl2VGlpbklDcDdDMHlpQ3pSbWQ3VDM0?=
 =?gb2312?B?VGlqTXdGdWxJQmFiVUM2Rjg2RnBYeUlRT3NvUkFWNWliY0s0RVJhcnFoUkZY?=
 =?gb2312?Q?3+XNeJjUAnI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0209e8-a4de-4955-6a21-08da34ae8d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:02:32.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVnLA0KDQpJJ20gc28gc29ycnkgdG8gYm90aGVyIHlvdSBzbyBtYW55IHRpbWVzLiBJ
IGp1c3QgcmVtb3ZlZCB0aGUgc2lnbmVkLW9mZi1ieSBsaW5lIGFuZCBwbGVhc2UgY2hlY2sgaXQg
YWdhaW4sIA0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogR3JlZyBLSCA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjLE6jXUwjEzyNUgMTQ6MDUNCsrVvP7I
yzogWW9uZ2xpbiBUYW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0Ks63LzTogbWFuaUBrZXJu
ZWwub3JnOyBxdWljX2hlbWFudGtAcXVpY2luYy5jb207IGxvaWMucG91bGFpbkBsaW5hcm8ub3Jn
OyBtaGlAbGlzdHMubGludXguZGV2OyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRDSF0gYnVzOiBtaGk6IGhv
c3Q6IEFkZCBzdXBwb3J0IGZvciBRdWVjdGVsIEVNMTIwIEZDQ0wgcHJvamVjdC4NCg0KT24gRnJp
LCBNYXkgMTMsIDIwMjIgYXQgMDE6NTk6MTFQTSArMDgwMCwgWW9uZ2xpbiBUYW4gd3JvdGU6DQo+
IEZyb206IHlsaW50YW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0KPiANCj4gICAgIFRoaXMg
cGF0Y2ggYWRkIFZlbmRvcklEL0RldmljZUlEIGRlZmluaXRpb25zIGZvciBFTTEyMCBGQ0NMIHBy
b2plY3QuDQo+ICAgICBJdCBoYXMgdGhlIHNhbWUgY29uZmlncmF0aW9uIGFzIFF1ZWN0ZWwgRU0x
NjBSLUdMIGFuZCBFTTEyMFItR0wuDQo+IA0KPiAgICAgU2lnbmVkLW9mZi1ieTogWW9uZ2xpbiBU
YW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0KPiAgICAgUmV2aWV3ZWQtYnk6IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ICAgICBTaWduZWQtb2Zm
LWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KDQpJ
IHNpZ25lZCBvZmYgb24gdGhpcyBjb21taXQ/DQpQbGVhc2UgTkVWRVIgYWRkIHRoZXNlIGxpbmVz
IGZyb20gc29tZW9uZSBlbHNlLiAgVEhhdCBpcyBhIGxlZ2FsIHN0YXRlbWVudCB5b3UgYXJlIG1h
a2luZyB0aGVyZSwgYW5kIEkgZG8gbm90IHJlbWVtYmVyIG1ha2luZyBpdC4NCg0KPiAgICAgTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1luelJjRnkxendoZFNQNURAa3JvYWguY29t
Lw0KDQpUaGF0IHBvaW50cyB0byBhIHJlc3BvbnNlIGZyb20gbWUsIG5vdCB0aGUgb3JpZ2luYWwg
Y29tbWl0Lg0KDQpTb21ldGhpbmcgd2VudCByZWFsbHkgd3Jvbmcgd2l0aCB0aGlzIHN1Ym1pc3Np
b24sIHBsZWFzZSB0cnkgYWdhaW4uDQoNCmdyZWcgay1oDQo=
