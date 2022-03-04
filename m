Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871F4CD4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiCDNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiCDNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:11:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C119D755;
        Fri,  4 Mar 2022 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646399459; x=1677935459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h3O/BeWOCoOILPpRkMTJ5Er2O4yAk1eleuNWhWytkfY=;
  b=Ao0ZUe5lTHX5soQbNALJ9WKH79DdS81rrcmEpt7GAqWxqr2Zs1AnbgzC
   jkDD5sOVW3uUxS2+X/ksP26i9/ejzZsaV9mTEsvknXZRcVF8eyelVJxZ8
   eDbxz9VpKrelveN2NgV4bh/4qwrrRx7/p2yTq+2BtOrjZjGa2GOnBGmrU
   P0OnCGXmlKde6dv3u1DjFbWSPbcpxTsx/fs0i8TF66g3+/VE5wkZ8w0TN
   chc94KuEqpOOUfk6P2BhnxZamXCIanC0Czhu6lW+nMpbv5r3uxVWTV85H
   SjdinUNh5p+2EGwmLxKIWUlsiSBLZxmZzpaF9F0vkFLNpGuqqxVB83Wcf
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150862654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:10:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:10:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 06:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv5wlb0VXwB1FCI2k+6T8byodt/wsL9MPJ8Q5FL98d+KjNej7EWBJ53fhGIYrMpXD7wvALhrpckaYiGZFxCcR8Aat8z6F8H7+v5dx60VjxJ72JW4EpWNLUaXIioY9fzQKyLlufXF3qKsgRP+uJp2ooz1M7KqjZz40jAwbsoejjnINgs85zFVfYM0e42Kfxy9VIvrs8xvxU6OEkXRdvGi6EhTeVU7vGA6Ei4GEB/7spcckekR40yTIGHhDw+/hSIyMtj74RUMVgnecf5WZEX5To/3hVtDlHDdOWvTLkeSi4AM9X657+wbdNSh20MlKyxprpQBAOtUabuG8QSzeFxGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3O/BeWOCoOILPpRkMTJ5Er2O4yAk1eleuNWhWytkfY=;
 b=Z+JmNm5gz+EzabfQoeKzikvporEiGkd2Lbwy1+IC3n/+hoDAfDa2YhfTwKpGHlVFy5F89SkfUhVvAOpPyRn0YzPyjeNm2y7ydzDK4me05Kn72fIYk48jZbOIeHEb4ekX3BF2wRwq7HpwbD07xo8QQ27Rw8Uq+S1UkDO1Z3DcGopeBHmE/Q5WbJoCNl6fbNCBRGMg968Jf+xE2oJLP+nxoa/kBh2ssjocjqIwhz6vuKKLpobHyJ9tRCSsPgeEygjqMyE+sIXrb+rX6s9lqMqVqm8Z6Brnr7roKRTpLe2n7uER3GIrp6MJeOXqkL1Gc+i/cfw6KtrgmmbYqiqNzVUpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3O/BeWOCoOILPpRkMTJ5Er2O4yAk1eleuNWhWytkfY=;
 b=S3/HrVu5gHIcKHJ5KKyAyybIWtUZbxgdH0VKp4p7B/pxM0ImNr/TiwzRJ6wOlJeJj3DjldJmzAv6p85+y1lK0HLZlLUXxdB7GsI2grh0mpa/ZdjCfeKLlg+QyAyLmzDzA+WE9ZBigLYQTbpA33551N18rxcaAt2Pbf9hcU91lA8=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN6PR11MB2004.namprd11.prod.outlook.com (2603:10b6:404:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 13:10:52 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 13:10:51 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: at91: Move rtt node properties from
 "dts" file to "dtsi" file
Thread-Topic: [PATCH v2 1/5] ARM: dts: at91: Move rtt node properties from
 "dts" file to "dtsi" file
Thread-Index: AQHYLwjD0M+7Qzq0K0yWbu5UUpYj26yt022AgAFhCwA=
Date:   Fri, 4 Mar 2022 13:10:51 +0000
Message-ID: <135b9e40-531c-963e-2d72-6c88643a34d2@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-2-sergiu.moga@microchip.com>
 <YiDns7xc5mTg7WzH@piout.net>
In-Reply-To: <YiDns7xc5mTg7WzH@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c580fd0-505b-4315-de56-08d9fde06844
x-ms-traffictypediagnostic: BN6PR11MB2004:EE_
x-microsoft-antispam-prvs: <BN6PR11MB2004C3F227942BE668D7A23CE8059@BN6PR11MB2004.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26JFawc/4mVanG6W/0HtQvXwhHBhG4SnO+UwQWVjGF+xkhSOGB8seFW4f59/P1W5I9U7JNll1/Uro3CDKsSK7syQL1O9i7hSZbGnaYVdmz7HzTnmUOOf3b5GUtLep1gFjkIJVJDFFToJ+uaWpjQNzGlSIeiF373PD05p8fJX4cwntceCpSTk3pBRN0KwAdovZ8WawKXnsY6UZrp45kMA0V3EG+tRoSHuWHvKxEg6RlRj7DiyNIy0PYx7cGJRogNi/IgaBPFAEQw7j+1gp32BIUNpU3zWB6fs3C/uU1nJ92djRjmqLDJ3ssGhRk/lQsusKbHNgezb81BByDhKPoe2UmZTNJ86s9IhdfIlu9ftPldSC76RbDDRe1cJcx4gRD8j/7cYIVJ4hXSdo5rT9KINmajZcfFidqz3J+Vp19BX+F9GC5vqIG/iv31BntZYCRJSn2euFtP/39rZHK3dVTEtKd9qBABbwIxEJNMqVvPzX0tGgG2w3T4nVxqghd/ZvKo1YC2J9nvwY79MEA3ZRarFqM1cqfUP5IcxXV/oW1heacQZODcJcP1buG0KK5B0PoE/UpBgLpiArDCOXeC8TQiXnhMRt7tkZneVT0LpMLcjOg7xOB2fvSW7jWKNuFiaJYrAlG/9cZnlqbbt6AsfaL8CLvMU1YVGXM6MhhBapFsJhU7ZiPKPZl44SgmXi3PiCk3UR2VGGimOwHdF7tJID28Ijp3Ws6tYsB1MpJn/0zKmsTZ58bOWRkaRdNxIEmaSiDSkoOktVuHTDrwiKCr4S3ZLRO62jsVsXvKa3Pc6b/nlISBJkVJRbdJmrTSEeUTkE/8A5Tu5h6e5h9x1tnWvHIMfCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2906002)(6916009)(5660300002)(38100700002)(2616005)(8936002)(86362001)(83380400001)(36756003)(53546011)(91956017)(122000001)(186003)(26005)(6506007)(76116006)(54906003)(38070700005)(316002)(66946007)(71200400001)(6512007)(508600001)(966005)(6486002)(31686004)(4326008)(66476007)(64756008)(66556008)(8676002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnRmNmp0K2VUV2FqbFlmei9GMXBHTnNDTWNqMklTSmczUjMwTnJDYkdZdFY3?=
 =?utf-8?B?bitjaW00anlIUkZwbyt4My8yazhqVENybHdjZ2tHWWU1eUkyaGdNZHZ4elBK?=
 =?utf-8?B?NUNnckloVmYzM2R4TEJNVDhhYnU1dUdRTDRZRUU3VU40R0xIK2lTbXBWdjZi?=
 =?utf-8?B?OUNPRFlnOW9iQ0FSais0MTdnc0hLeW5kd21HUlp0d3gyYVJlclBWNU1hV3FR?=
 =?utf-8?B?dHBNbG5iYTZ0c2RyLzVOTFNTdUtXWHNsTlpXS0Ewc0QxQmhCL25wc0h3Zkl4?=
 =?utf-8?B?NTZiT1dTZmpPM3B6cWVtK1gyVlZPaDRCWXNPMlU3bHA3ZStYM3A1dU5uemEy?=
 =?utf-8?B?V3A0eDVWN29Id2NSdnR2dm5SQ1pGNmhIUlFzYmJvNnZQdWhIL3h2enVTbWly?=
 =?utf-8?B?Tm1WMHlNb1dNNUN4eVZ2UUNwU1NaVHh2TW1MdEdQRXNLbkhIYVlvVW5tZG5H?=
 =?utf-8?B?N1VOUWkxbm1xeXVQbDg1c3NxdmtFY0NBZjQra3BHSDc3YVM3VXZOVzVyS2dy?=
 =?utf-8?B?RlJ5cHZzeVhzazZ2MjVOM1p1cmYrNmZ6VGlRb0o3eDlXc1Z4cmYvTWMyRHJK?=
 =?utf-8?B?Q1BINzlQSDJrSWxjaWZ0WlZOSTRtd2lkOWkvbzROT0lKNFByTlkvS2RuY0J2?=
 =?utf-8?B?dTlsUUtWWk5tMXRodzdaYTZ2Q0JjNFdVUmZtaTdSbTFELzM2YW03V0JJRW5D?=
 =?utf-8?B?Vk04NllLdzRGTU9IUG9LYldUSmtCNWVVYjdpODM2R00veFluZFIzcWNuV1JI?=
 =?utf-8?B?blRnWFpWeitraENWU2hENmtUdVRBZ0l3R2k4SFZVZkZpMFNpYkUrdnY2QXla?=
 =?utf-8?B?Q3dPc0kzamxuVjVRQjU2cXlOWm01S0piUTlkeExVK0VWMVVibzJZZ29zSTc1?=
 =?utf-8?B?aUp4VWxhb05KNkJFT1VBa20zUFdtQXVXT0plM0FOK050V0UyODVHWlNRZE9L?=
 =?utf-8?B?a00yYjUzVGZzS2ttYUxBL2VReU1hOUhwVGVHRGIwbHN5UENBamFCTXIzWDAx?=
 =?utf-8?B?QlBjckZCMmo0OWVDYW9ZQ3lrZDJ3dkxUdDZ3SHFPa0FVbS9sbk9Bc3BOVFJY?=
 =?utf-8?B?S1dRYWZkbEQ0MXBoazM4dXZtenpiQUFSd3RNcG1UY3pJZVBUcGUxckl3R2N6?=
 =?utf-8?B?MDIyNlBjTmc4QkNlTnp2MHpoMFVwQ2ZUOURDOWZwRkZSUEc5R29PYTA1U2lh?=
 =?utf-8?B?MC8xcndCOEp0c2lRZ2dlZUQzbWFqQlpLenhZSXJHSVFFS1padkM4ZElYcTZx?=
 =?utf-8?B?d2svbXRQRmhKY1lvUTZvQmY0VGMzSENjWStKcG1aSXhhMG9FWUVkTXdFODZO?=
 =?utf-8?B?V3hVTldHeXVrVng0d2xuOHVEa3M4emUvZnlQd3F3VmNCakxsVGJMeVBoTlhw?=
 =?utf-8?B?Wkt2Q3liOVJMc0VnODBxZjdMSTVkbU0vM0RvRC9kb3I1SE1GZW5EWUJpRnU5?=
 =?utf-8?B?NHdhUjJ4TTNCSmlkeVFUT1lzeXdCRmc1Ujdjbld4elJVU3dmeHUvK0llVDVS?=
 =?utf-8?B?bUVMekJWUHRTQnRvdXhHWjQ3dGFtNms2aUY5eUdjUWNTSStyR3pnTXh0MzF2?=
 =?utf-8?B?VUNXejIxMkY5eTRQcndJVEViT3E4RkFIcW84cHdRQzNMQXpnSVlRZVhubDVR?=
 =?utf-8?B?d2QyZnFWc2UvQ09tRGtuUG50b2hER1NFSjBSWVBiYjFaUm9nSVdXUEw4QlFJ?=
 =?utf-8?B?dUVUVDlOdWl0R0FYeVJZMnFVN2wxVmE2WDZIN2NhbGRYSjYyeW5jNWtTQzd2?=
 =?utf-8?B?bVd5cmx6ZWhxeEhlSDV0djU1ckNpbEVsWjM3cS8rcUZRcllaUXZVZlpkNE1B?=
 =?utf-8?B?dW1NS0gwaDRyTldodVhXd2tlRzBIcFdvWFlkZkY4R2MrWTMxSmIyZnJYZVRi?=
 =?utf-8?B?QTBDNGhZY3VSSUpnRXQyQVNlTmI4cUQ3Z0o3K203VDc1VXpRN2UrRzNraXQ2?=
 =?utf-8?B?M01CWlFjNUlJNFU4RGhrVGhtc1lMeUljd0NDZnA4bkJVMCtWQVltNnluUWxW?=
 =?utf-8?B?U2txNW0wcS83S0VsMDBDcHRXUkVqazNzSFpDR0Q3SjEwR1lvZG4wVG4wL2Z6?=
 =?utf-8?B?MXVRaVJiRFcxYW1hQThubDd5dlFtOVV6eWM0RUpqQUNQVXZiMTNjTUQ5WVcr?=
 =?utf-8?B?Yi92NWxXZkdNbnQ0R2FkV3QvbkdjZWdqVXh0L1lBZXpydjFuS0doZzNBRDU4?=
 =?utf-8?B?TDVsVkJFTGtJWjZuY0prY093T1RTNXREOWRIVC9VVXR0YmFjY3MwOUtnQ2VG?=
 =?utf-8?B?S0plMVBoNCt5aHRST2s5Q2hWQkN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <684126E8886F1C46862B4CB9BE468E01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c580fd0-505b-4315-de56-08d9fde06844
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 13:10:51.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmf95E3pb3p21dA+pEb5osiX6HKFeRf4iGp+nAUqVN9Su10Quzln2Lcx07s1QqtQv+G4YVk0Z4HcgMQr/p76cOzU99Mi44d86ex/7kla3jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2004
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDMuMjAyMiAxODowNywgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDAzLzAz
LzIwMjIgMTY6MDY6MjIrMDIwMCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBNb3ZlIHRoZSBwcm9w
ZXJ0aWVzIG9mIHRoZSBydHQgbm9kZSBvZiBSVFQgSVBzIGZyb20gdGhlICJkdHMiIGZpbGUgdG8g
dGhlDQo+PiAiZHRzaSIgZmlsZSwgc2luY2UgaXQgaXMgbW9yZSBJUCBzcGVjaWZpYyB0aGFuIGl0
IGlzIGJvYXJkIHNwZWNpZmljLg0KPj4NCj4gVGhlIGZhY3QgdGhhdCBpdCB1c2VzIGEgc3BlY2lm
aWMgR1BCUiByZWdpc3RlciBtYWtlcyBpdCBib2FyZCBzcGVjaWZpYw0KPiBzbyBJIGRvbid0IHJl
YWxseSBhZ3JlZSB3aXRoIHRoaXMgcGF0Y2guDQo+DQpBaCwgSSBzZWUuIEkgd2lsbCByZW1vdmUg
dGhpcyBwYXRjaCBmcm9tIHRoZSBzZXJpZXMgdGhlbi4NCg0KPj4gU2lnbmVkLW9mZi1ieTogU2Vy
Z2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzICAgfCA1IC0tLS0tDQo+PiAgIGFyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyAgIHwgNCAtLS0tDQo+PiAgIGFyY2gvYXJtL2Jv
b3QvZHRzL2F0OTFzYW05MjYwLmR0c2kgICAgIHwgMSArDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRz
L2F0OTFzYW05MjYwZWsuZHRzICAgIHwgMSAtDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05ZzQ1LmR0c2kgICAgIHwgMSArDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05bTEw
ZzQ1ZWsuZHRzIHwgMSAtDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSAgICAg
ICAgIHwgMSArDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaSAgICAgICAgIHwg
MSArDQo+PiAgIDggZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsu
ZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+PiBpbmRleCBiMTA2
OGNjYTQyMjguLjk3ZmY5MTM0NmNiNCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEtc2FtOXg2MGVrLmR0cw0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwZWsuZHRzDQo+PiBAQCAtNjU2LDExICs2NTYsNiBAQCBrZXJuZWxAMjAwMDAwIHsNCj4+ICAg
ICAgICB9Ow0KPj4gICB9Ow0KPj4NCj4+IC0mcnR0IHsNCj4+IC0gICAgIGF0bWVsLHJ0dC1ydGMt
dGltZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+IC0gICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+IC19
Ow0KPj4gLQ0KPj4gICAmc2h1dGRvd25fY29udHJvbGxlciB7DQo+PiAgICAgICAgZGVib3VuY2Ut
ZGVsYXktdXMgPSA8OTc2PjsNCj4+ICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzDQo+PiBpbmRleCBjY2Y5ZTIyNGRhNzguLmI3NDE2ZDk0
NjllMyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0
cw0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzDQo+PiBAQCAt
NzA4LDEwICs3MDgsNiBAQCAmcHdtIHsNCj4+ICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOyAv
KiBDb25mbGljdCB3aXRoIGxlZHMuICovDQo+PiAgIH07DQo+Pg0KPj4gLSZydHQgew0KPj4gLSAg
ICAgYXRtZWwscnR0LXJ0Yy10aW1lLXJlZyA9IDwmZ3BiciAweDA+Ow0KPj4gLX07DQo+PiAtDQo+
PiAgICZzZG1tYzAgew0KPj4gICAgICAgIGJ1cy13aWR0aCA9IDw4PjsNCj4+ICAgICAgICBub24t
cmVtb3ZhYmxlOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYw
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MC5kdHNpDQo+PiBpbmRleCA3MzY4
MzQ3YzkzNTcuLjY2ZDExYzhmMWE5YiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTFzYW05MjYwLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYw
LmR0c2kNCj4+IEBAIC03MTMsNiArNzEzLDcgQEAgcnRjQGZmZmZmZDIwIHsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhmZmZmZmQyMCAweDEwPjsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxf
SElHSCA3PjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnBt
YyBQTUNfVFlQRV9DT1JFIFBNQ19TTE9XPjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICB9Ow0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkx
c2FtOTI2MGVrLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYwZWsuZHRzDQo+PiBp
bmRleCBjZTk2MzQ1ZDI4YTMuLjY5MzJkYWI0MmYyZSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTFzYW05MjYwZWsuZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9h
dDkxc2FtOTI2MGVrLmR0cw0KPj4gQEAgLTExOCw3ICsxMTgsNiBAQCBzaGR3Y0BmZmZmZmQxMCB7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICBydGNAZmZmZmZkMjAgew0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRt
ZWwscnR0LXJ0Yy10aW1lLXJlZyA9IDwmZ3BiciAweDA+Ow0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlnNDUuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05ZzQ1LmR0c2kNCj4+IGluZGV4IDJhYjczMGZk
NjQ3Mi4uZmQzMDhlMmMxNWU4IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MXNhbTlnNDUuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlnNDUuZHRz
aQ0KPj4gQEAgLTkyOSw2ICs5MjksNyBAQCBydGNAZmZmZmZkMjAgew0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweGZmZmZmZDIwIDB4MTA+Ow0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9MRVZFTF9ISUdI
IDc+Ow0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrMzJr
PjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsLHJ0dC1ydGMtdGltZS1y
ZWcgPSA8JmdwYnIgMHgwPjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOW0xMGc0NWVrLmR0cyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTFzYW05bTEwZzQ1ZWsuZHRzDQo+PiBpbmRleCBiNjI1NmEyMGZiYzcu
LjA3YmZhOGVmNzE1ZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05
bTEwZzQ1ZWsuZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOW0xMGc0NWVr
LmR0cw0KPj4gQEAgLTIyMCw3ICsyMjAsNiBAQCBwd20wOiBwd21AZmZmYjgwMDAgew0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgcnRj
QGZmZmZmZDIwIHsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsLHJ0dC1y
dGMtdGltZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdGF0dXMgPSAib2theSI7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPj4gaW5kZXggZWM0NWNlZDNjZGU2Li41N2JhNDdjNTQw
NDMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPj4gQEAgLTY5Myw2ICs2OTMsNyBA
QCBydHQ6IHJ0dEBmZmZmZmUyMCB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4ZmZmZmZlMjAgMHgyMD47DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDwxIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGszMmsgMD47DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhdG1lbCxydHQtcnRjLXRpbWUtcmVnID0gPCZncGJyIDB4MD47
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICBwaXQ6IHRpbWVyQGZmZmZmZTQwIHsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9zYW1hN2c1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4+IGlu
ZGV4IGVkZGNmYmY0ZDIyMy4uMTUzMGQ4OGNlODBmIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1
LmR0c2kNCj4+IEBAIC0xMzgsNiArMTM4LDcgQEAgcnR0OiBydHRAZTAwMWQwMjAgew0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMDAxZDAyMCAweDMwPjsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDggSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrMzJrIDA+Ow0KPj4g
KyAgICAgICAgICAgICAgICAgICAgIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWcgPSA8JmdwYnIgMHgw
PjsNCj4+ICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICAgICAgICAgY2xrMzJrOiBj
bG9jay1jb250cm9sbGVyQGUwMDFkMDUwIHsNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQo+IC0tDQo+
IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBCb290bGluDQo+IEVtYmVkZGVk
IExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KDQpU
aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KU2VyZ2l1DQoNCg==
