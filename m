Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8155FCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiF2KP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiF2KPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:15:23 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920B286DE;
        Wed, 29 Jun 2022 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656497722; x=1657102522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qREvaKNttrNmGJMEMoAuoqJKoUebrTibPDqdtv5CRKc=;
  b=ig2nQ1g9qwcMxP1xUY0jJkiit/m6VioQZkr5TizYABoKxi2gUf6NVVF0
   vWCoEBEYNiy2iWhu1IVHWk3+qSqu3Vg2R3F3b1OczFo7ke/SjTD5/5LRP
   rnhsto8mFgFEDLzofdpOeg3dZ+liQwJtcT7069mYxIkFsWduFmwCP3ysr
   Q=;
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 10:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEIxZmMaKm08XmYorBnUNgoCQ4x5tk1YfdEIUqgZGWo4bn8fKEECoQ+cgci14Yum2k6TF0UvzcwFqnmqsc7boJyWGRgX/M6s6pEZBEaOG4Rr6oGoBcpGRFxQrF+0mJ/EjylU2m/qDIJJSRstQHSIfGL0QT1/fu7LCkHIgqLKNzvYCAWencfe2Z2sIklpZVWadw8unjC9qrBAoUvPCdHkiWiOMS08uIdryWfXmXZfaJAVKl89l0GxqizaNFe5OL7i74P8hvb5lfY+tadY+RcW4aVmYmxxU/Z5wae9ctV6wLqDh6lYxda9jVkN8d+MQofspmD2dsSj+7y5r0j0fYHVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qREvaKNttrNmGJMEMoAuoqJKoUebrTibPDqdtv5CRKc=;
 b=RCOt0DftG2M/1vP455MhQO6mrSFwvMb8XOqm7XzpeO/X7oYexbRc5jB6rHebXH9trJgchD6ZMQZLD9xLGSPtFq+J3dctQhWsXLftstkCFX3zHsc8gBicKyQDbn5rizSj8EQq7+A2NT8cpbCTf5Tz6Mkg8U+BN+wktXbuhp4jCBEO5RU/EXpTO1yIIWjQxeHZjP8XjQoHFAz6K0eatR7V7la+WWo1tdVoiV7CoP6AjG4X0lzge0vTDc0SPjQ9GdA7T92rdM3dq+3MdiFEAO7dXO3mNwN86ZdIgtNgbS37CZjIHUngVUnEcRDw0+wAyS6OxnEHaQ9yHAiyj/7kirwpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by CH0PR02MB7962.namprd02.prod.outlook.com (2603:10b6:610:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 10:15:18 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::74ed:8851:fc13:a4ad]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::74ed:8851:fc13:a4ad%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 10:15:18 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: RE: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
Thread-Topic: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
Thread-Index: AQHYhZhque1aSuxCn0uPTvCaN8nem61dpOAAgAiQXVA=
Date:   Wed, 29 Jun 2022 10:15:18 +0000
Message-ID: <BL0PR02MB45640801D857DB0C075D141AFABB9@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=X9wDk2e7sVDUZg6wamX6mjBu6Wp4bUcDNAyxTNeDsiWg@mail.gmail.com>
In-Reply-To: <CAD=FV=X9wDk2e7sVDUZg6wamX6mjBu6Wp4bUcDNAyxTNeDsiWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60c57d28-8522-4fbf-4e0c-08da59b84455
x-ms-traffictypediagnostic: CH0PR02MB7962:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WeCKu+S4phhMnKgUFD+iY076WjmJuUY0WtocvVwSwlVMQesohaECbTbqDlpHbL12iu9DkJRrTFbwPG8LzIRq+G9irn6swgGiwuSd/Lzj/U9ikz5ioHO2gsqaMtUp4Vwz6joNPs8Uirzx+FPafGppaLfvX78pNM1u0QSSEiqzT3mNt7Uq9yuC0rdk3ATFwT89LidbEHUEXM3uMHniOQC523x7nbMCGEV4a7W8AKTdtMLI0JNG+nN0MI0wJQuhYmxH06MU/VLQ+83kUe/EU/LCLc1c671/Rs68nAGl4A5MUf46IsKE9fP9shad8OfZhrHgpimjtJmvLWZWDmwEF/fYefFL9daN7KhiMOjimhmKPto3i2/S6F0XGX8FHGtc+X8o6lKRVyhl1Oqn0rXrrfsWkHHOd8F66s92ASAQNN86/de4PTAWT2DgB9N2Z9BUxZM0fgDilhtpfuSKSDHDdzZfY9HLG+S6LCGhQGX0W8RsPtDxHMWvxQzpjddJhBoDXPFeLvq1ihxfYw1tlCbOHBK8ChzFtKveB0pBY3itK7mhFO70kJLR0ufqwZ29jfhz38kif4s+PiCVomrMtGzKKm30O+gPR/ean3oyZ7nj116sDj5QjwKL6TW57+e9FnFX8imDXapTQ7mcP1BXTv9x6aeE2yQxvNjN22zAWLC3CnsJ53vkm9fCPAqXBD636fOE9dk2nRoEA6irrP3un3ajXGhhQDanOMbU0nuuvTTJiR+VC2DybG1qPNXFogWziLLCu9TNuXOvJePhfviqEoN8ttrLYT9O4Rtdin2IkDaFheczUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(55016003)(186003)(41300700001)(33656002)(83380400001)(2906002)(38100700002)(66476007)(26005)(7416002)(110136005)(316002)(54906003)(122000001)(9686003)(5660300002)(71200400001)(55236004)(6506007)(7696005)(8676002)(4326008)(52536014)(8936002)(76116006)(38070700005)(66556008)(64756008)(66946007)(66446008)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmpJL2pQUG96cm9CTGloa1BXMWZqNlB6U3JJRklJbEFyc2NWWlNUTDBYSlhJ?=
 =?utf-8?B?S280d3ZEWktoVm9uanAvaWRSbG5BcUhGQW5jeWNOVmI4L0pOOU5RNUlCdnZm?=
 =?utf-8?B?M0NkdzhPQ0F5YjREYXhSVTNzOXFnd1RlWVNIYWpPVzRzbGpqRDFhR1kyeU1B?=
 =?utf-8?B?VUJqQWlKeElCcDdjd2RmOUZTVlN2YkxlYjF6SjVmVFZvaXBjdlA4MXNoRkRz?=
 =?utf-8?B?alBTeEV6TFgyblNCZmhJVWU5MXFEYnVPamYxTlB2bk1SUEhOVE1ldEg3eDVo?=
 =?utf-8?B?ekdxeDVlZVFiN2U0OUc1SUJNSEx1c0JrNi9pd1lLRHhjb3UxT0NWMlNTd09p?=
 =?utf-8?B?VktibFdSYitLWE1nY1NtcmtSY24wK3dSdUJ5ZU5xWDlFbU9hU29FdWlraWx0?=
 =?utf-8?B?L0tISGY3ZG8yUVZBcHNUUEd5dDc5Y2tObFdEZXFtUkdzdExRbTJhSXR3MWow?=
 =?utf-8?B?RlBlWXdkTXVnWFc0MklrOCtPTGYwc2JleUlPWXdQWVJ5RFYrTkR0NDQ3NSsx?=
 =?utf-8?B?QzhJbjNSQ3NlNWxsU29PU2hTZkJxSHhwWk5qSCtXRFN3cXpLUmRGbWZzbk90?=
 =?utf-8?B?amJOY0VwTFdmdHpPZUg4Q1locWNXdkdhd3hSNkxwdnF3QVprL1NtMjNPRjZ5?=
 =?utf-8?B?enZDODdZUm5yMFJoRUsyQzNHcy9ET2I4cm9FQXJTV2gvRnF4cVpIVGtSeDRZ?=
 =?utf-8?B?bmx6YkNuNndZMkNKK0FkRXlwZ0lCU1lhWXllMGRyUGZFWUw1ZTJXRkNBd2lK?=
 =?utf-8?B?UVZ2SmNDdk1HdVQzZkprelF5Q2dMSm5JL0RPSk5vZXF4dEp1V3BjaGxDdFF3?=
 =?utf-8?B?WTJvdzJEMjNQSklUdjQxeXk4ZTVnUFp6YmNGUXUyc0t4TnRNWTNEY3hQYlNT?=
 =?utf-8?B?UEI5Q25SRkxNMG9WVDJIcGg2RHNpMGd2RnlLSjVpeXlYNHE4NlVySE1tcjc5?=
 =?utf-8?B?eE84Z0hKU0pGNEtFY1lPbkRDb2xnUHdWZkFSSXg2Y3lZdCs3OFlSQm9XOE9C?=
 =?utf-8?B?U01aSy9Db1E2OFZmUWxjNjd5ZVBhQ0c4KytRS3VEYWl1T0prYSt3QnR3cWZI?=
 =?utf-8?B?d2FBVDh1a1JJbzBLNUhYQ0c2YXpWVjFISW1RUkcxU1BIQ3NlV3dkVW8wa3VG?=
 =?utf-8?B?M2RCT0ErUWg2NFA5Wm1ESkt3RFg3YzBWT251aHR4VCtBMGRGdWYrTE5TU1RI?=
 =?utf-8?B?UjkrMWg2UnFwcERGMXZrUmR5c1l2NzZJOVcwNXZTbTNnWkVjbFN2QmlLbkow?=
 =?utf-8?B?N0x2c0tQaFQxN04raUQreVF1d1ZqNmtWc1I2MFhKbi84R2k4MGYrTkZtdktS?=
 =?utf-8?B?RzFFOXNzZTdmcDcwcnNUZTlka3RBYlNtMTIyREFuVTBYSU80SjR5Y2xuRS83?=
 =?utf-8?B?WWFkamw4ZlNLc3haMlhJTlhXRDU2VjM2R3psZHFBYldaVXhlWWs1S21nb21x?=
 =?utf-8?B?OG51OTBNZnJtSEZodFd6cWMrQVVkcXN2Ukw2bHV3QWw1NjcrZ0FUNm8wNldB?=
 =?utf-8?B?RUIzbDhMejFOQ0pHVC8vUmdTWkJ4NXJLZEk0aE9HSnVXYkd5Rmx3NjhzWGxT?=
 =?utf-8?B?V0l3Skd3SEcyZ294SlQ3cStyNVZsZXRGZ1U1RkhIN0I2cEtkR3lPUlBZNmQ3?=
 =?utf-8?B?TWhka0xCL0xDWGcxNDA0M3BUWHR0OUs4enBhZUxNWTA5VTM1U0RNOElmSGk5?=
 =?utf-8?B?QVFvR21nUmE4azBKY2RGQzBsMVN6T3RJRzhtcng3U0RwaCtyWE53bVlGYU5H?=
 =?utf-8?B?OUx5U0tpMk1oYUV0SlBEQ3dQekxha0NXbTRIeXArZEZOeTd0NnJkblJJWnh6?=
 =?utf-8?B?SEY4dzQ2aWhBOEtnUk9FWEJhK0ZPOWUxSGdYTEx6V1NXdjY0SjNhcHZTNnpo?=
 =?utf-8?B?WU8zUTJaVlFMMGhNZEVYZFlna1pCdmx4YUxFWWJZNkx2b1NrekxOMjdhQWtO?=
 =?utf-8?B?QStVY2VyN3U4ekNWb0RuVGwrbWZ5bmthbmpENXJoRTNSVjgzMjZFeENoOGxj?=
 =?utf-8?B?aHhGamdWb3RGQnpIWGgwZjl0OUZ1Q1ZXZUlTcSt4Z1ZkSzMvNUlxaGhMWG95?=
 =?utf-8?B?UnFtaHMwcEFVTSs3NXgrSklkdkRaSUJMQ3JmV0VGVTR5dnkyaHZabWlxaE5o?=
 =?utf-8?Q?E0gfCKFsyiojvd/6A3lveMw70?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c57d28-8522-4fbf-4e0c-08da59b84455
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 10:15:18.1017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOsW+//ToJEyDpwlxS8i3n4MOLgSlFQxHOApnWJTSp+1eWMhQUjKmx+Dk4kmPTlJO+uFGymMnTosyfiiQv80pKSZvq6eDLFmcoUqw2gX6pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAg
ICAgICogQSBkZWFkLW9uIGZyZXEgaXMgYW4gaW5zdGEtd2luLCBsb29rIGZvciBpdCBvbmx5IGlu
IDFzdCBydW4NCj4gPiArICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgIGlm
ICgqZXhhY3RfbWF0Y2gpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIShmcmVx
ICUgZGVzaXJlZF9jbGspKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
ZXJfY2xrID0gZnJlcTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICpjbGtf
ZGl2ID0gZnJlcSAvIGRlc2lyZWRfY2xrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHNlcl9jbGs7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+
ICsgICAgICAgICAgICAgICB9DQo+IA0KPiBUaGUgIipleGFjdF9tYXRjaCIgaWYgdGVzdCBpc24n
dCBuZWVkZWQgaGVyZS4gSXQncyBub3Qgc2F2aW5nIHlvdSBhbnkNCj4gc2lnbmlmaWNhbnQgYW1v
dW50IG9mIHRpbWUuIFlvdSdyZSBzdGlsbCBkb2luZyBhbiAiaWYiIHRlc3QsIHJpZ2h0Pw0KPiAu
Li5zbyB5b3UncmUgYmFzaWNhbGx5IHNhdmluZyBhIG1vZCBvcGVyYXRpb24gYnkgYWRkaW5nIGEg
cG9pbnRlciBkZXJlZmVyZW5jZQ0KPiBhbmQgY29tcGxleGl0eT8gSSBkb24ndCB0aGluayB0aGF0
J3MgdGhlIHJpZ2h0IHRyYWRlb2ZmLg0KPiANCj4gDQoNClJlbW92ZWQgZXhhY3RfbWF0Y2ggY2hl
Y2sgZnJvbSBoZXJlLg0KDQoNCj4gPg0KPiA+IC0gICAgICAgaWYgKCFzZXJfY2xrKSB7DQo+ID4g
LSAgICAgICAgICAgICAgIHByX2VycigiJXM6IENhbid0IGZpbmQgbWF0Y2hpbmcgREZTIGVudHJ5
IGZvciBiYXVkICVkXG4iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYmF1ZCk7DQo+ID4gKyAgICAg
ICAvKiB0cnkgdG8gZmluZCBleGFjdCBjbG9jayByYXRlIG9yIHdpdGhpbiAyJSB0b2xlcmFuY2Ug
Ki8NCj4gPiArICAgICAgIHNlcl9jbGsgPSAwOw0KPiA+ICsgICAgICAgZXhhY3RfbWF0Y2ggPSB0
cnVlOw0KPiA+ICsgICAgICAgZGVzaXJlZF90b2wgPSAyOw0KPiANCj4gRG9uJ3QgbmVlZCBhICJk
ZXNpcmVkX3RvbCIgdmFyaWFibGUuIEp1c3QgcGFzcyAyIGludG8gdGhlIGZ1bmN0aW9uLg0KPiAN
Cj4NCg0KRG9uZQ0KDQogDQo+ID4gKyAgICAgICBzZXJfY2xrID0gZmluZF9jbGtfcmF0ZV9pbl90
b2woY2xrLCBkZXNpcmVkX2NsaywgY2xrX2RpdiwgZGVzaXJlZF90b2wsDQo+ICZleGFjdF9tYXRj
aCk7DQo+ID4gKyAgICAgICBpZiAoc2VyX2Nsaykgew0KPiA+ICsgICAgICAgICAgICAgICBpZiAo
IWV4YWN0X21hdGNoKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIkNhbm5v
dCBmaW5kIGV4YWN0IG1hdGNoIGNsa19yYXRlLA0KPiA+ICsgdXNpbmcgb25lIHdpdGhpbiAyIHBl
cmNlbnQgdG9sZXJhbmNlXG4iKTsNCj4gDQo+IElNTyBnZXQgcmlkIG9mIHRoaXMgcHJpbnRvdXQu
IEp1c3QgcmV0dXJuIHdoYXQgeW91IGZvdW5kIGlmIGl0J3Mgbm90IDAuIEl0J3MNCj4gcGVyZmVj
dGx5IGZpbmUuIC4uLnRoYXQgbWVhbnMgeW91IGNhbiBmdWxseSBnZXQgcmlkIG9mIHRoZSAiZXhh
Y3RfbWF0Y2giDQo+IHZhcmlhYmxlLg0KPiANCj4NCg0KRG9uZS4NCkJ1dCByZXRhaW5lZCBleGFj
dF9tYXRjaCBhcyBib29sIGluc3RlYWQgb2YgcG9pbnRlciB0byBoZWxwIGVhcmx5IG91dCBpbiAy
bmQgY2FsbC4NCiANCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHNlcl9jbGs7DQo+ID4gICAg
ICAgICB9DQo+ID4NCj4gPiAtICAgICAgICpjbGtfZGl2ID0gc2VyX2NsayAvIGRlc2lyZWRfY2xr
Ow0KPiA+IC0gICAgICAgaWYgKCEoKmNsa19kaXYpKQ0KPiA+IC0gICAgICAgICAgICAgICAqY2xr
X2RpdiA9IDE7DQo+ID4gKyAgICAgICAvKiB0cnkgd2l0aGluIDUlIHRvbGVyYW5jZSBub3csIG5v
IG5lZWQgdG8gbG9vayBmb3IgZXhhY3QgbWF0Y2ggKi8NCj4gPiArICAgICAgIGV4YWN0X21hdGNo
ID0gZmFsc2U7DQo+ID4gKyAgICAgICBkZXNpcmVkX3RvbCA9IDU7DQo+ID4gKw0KPiA+ICsgICAg
ICAgc2VyX2NsayA9IGZpbmRfY2xrX3JhdGVfaW5fdG9sKGNsaywgZGVzaXJlZF9jbGssIGNsa19k
aXYsIGRlc2lyZWRfdG9sLA0KPiAmZXhhY3RfbWF0Y2gpOw0KPiA+ICsgICAgICAgaWYgKHNlcl9j
bGspDQo+ID4gKyAgICAgICAgICAgICAgIHByX3dhcm4oIkNhbm5vdCBmaW5kIGV4YWN0IG1hdGNo
IGNsa19yYXRlLCB1c2luZyBvbmUgd2l0aGluIDUNCj4gcGVyY2VudCB0b2xlcmFuY2VcbiIpOw0K
PiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBwcl9lcnIoIkNhbm5vdCBmaW5k
IHN1aXRhYmxlIGNsa19yYXRlLCBnaXZpbmcgdXBcbiIpOw0KPiANCj4gSnVzdCBrZWVwIHRoZSBl
cnJvciBtZXNzYWdlIGJ1dCBub3QgdGhlIHdhcm5pbmcuIC4uLmFuZCBpZGVhbGx5IHVzZSAiZGV2
X2VyciINCj4gYW5kIHByaW50IG91dCB0aGUgY2xvY2sgeW91IHdlcmUgdHJ5aW5nIHRvIGFjaGll
dmUuDQoNCkRvbmUuIFJldGFpbmVkIHByX2VyciBzaW5jZSBkZXYgd2FzbuKAmXQgcmVhZGlseSBh
dmFpbGFibGUgaGVyZS4NCg0KVGhhbmsgeW91Lg0K
