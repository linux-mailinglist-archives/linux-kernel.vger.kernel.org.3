Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E155929A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiFXGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:01:43 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFE6800F;
        Thu, 23 Jun 2022 23:01:42 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7BE60C3239;
        Fri, 24 Jun 2022 06:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1656050502; bh=nEpRtLdCqR3C7+JWdlCfqNkrNfH3fyoPtkrQFmXlCBA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=APeqdDQmHvGY2mPIobKQQjdeiROcUj8ZoMYky5P74nBuRvR458ZrzTBTeuTKQB0Wc
         lhzIWRMxLRVu0Tj3uyYyk+QHNr2t/iVgx3jM/su4ByO3dR7CmbtVjw0sAjevohB6Rv
         dZTo/q3V0Hp9L67WL3zxOaZDES0tyMicHUtfHMDz0chwzgUp0o/V415S/zsn+bgSbA
         ZN1MAT774GZwFPUuQ/nssc3D+duyBii8TPl2jia3vKiE0+uCVWMOMtNS+8+nmM+oXA
         7zG/L6zqTIaG3YESQsSFdUnfPF2WwBbBG1I4aMf7JAXj8h9YjbhvofXLtnr2B53/6W
         V9eTExl1ZRFng==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1B4DFA0090;
        Fri, 24 Jun 2022 06:01:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8EC02400E9;
        Fri, 24 Jun 2022 06:01:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AhBlAEZJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiBu7VsoFFjKFlqbV3//5nzpJX3g/D7yvqoEUVI/wAFz5BmdidY26kHXJMWz1xSQ7DwpJlvGDmAKTSiMdO9YOiESqyFO0tthTwMdrts+skALkQjSbgaM38fWMIbL8LjIEmiEreyXwJbhjyQqwdpXX/N/afoO3dtnM3Zkfqm7Mp27OG6SotZVNljsF7rgh4uPjlI+fLRQXwdFl30caqRAMYp/4fP24RU/sMPNafUqC1eTwrm95RghZphq9155i8EMe69zccaZmtRZunIL0OlH3nOsckYtinYAdml4C1iq2yWIEV9hHhA+LUEwyZJxdpcxGhw+JpwJOOLUk7p+T583ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEpRtLdCqR3C7+JWdlCfqNkrNfH3fyoPtkrQFmXlCBA=;
 b=CnseSq76Sbjqd/7lRiQGZg3IleQSbOx7fZ4pnrcV9gGDbAOWFajHu/NMMojHyc32LToUOzKE7iPWC0/QQFWs6l5RAr5Ux5+zssTdiHD4HiPS7hBuPcKEJ1Ihami3waspDbv42tfbJECo6voR3GLhKp27SuPUco0HDl4s+mSfbBjesSowO6yyeT6kTPh+XymXxWK/Mig1IQjNYTlddQShJisGkjZXwcrpdyJbLlZ5KznuuNQJC7dYeXN3o4n0vSSZkB59c47xsTD6fyfLY+Uv5pNh9rb7dBSm3ztpWOV88Z5DEDdabSUxA0odo8t+c1fSZ4gtudoe8aL4MAuzruAf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEpRtLdCqR3C7+JWdlCfqNkrNfH3fyoPtkrQFmXlCBA=;
 b=AhBlAEZJVS6XtVJAfzi8SjsD3rkHcLtN0DuMpCOw0dUDg4BpOHZXCvPccCFaZwIz6YEc9ytKHYNLEoRqn4qdQYdAuAGlLGfRIKIAtaQkL2dFB6RtlnKhw6yKfB4FCn9evFM9WirUzeqvD2ASC/xXN59x4WN/WF4PZJpvhbA1IhA=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 06:01:35 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 06:01:35 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] usb: dwc2: gadget: remove D+ pull-up while no vbus with
 usb-role-switch
Thread-Topic: [PATCH] usb: dwc2: gadget: remove D+ pull-up while no vbus with
 usb-role-switch
Thread-Index: AQHYhlJBS82fQg6HY0+TXLrqjymXba1eExGA
Date:   Fri, 24 Jun 2022 06:01:35 +0000
Message-ID: <48d301b6-d401-de3d-7636-c73c79a584a1@synopsys.com>
References: <20220622160717.314580-1-fabrice.gasnier@foss.st.com>
In-Reply-To: <20220622160717.314580-1-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99590fba-e166-4468-f133-08da55a6feaa
x-ms-traffictypediagnostic: BY5PR12MB4260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vl0qZE0NdLSxYKQVgNG4x8wzCt6zGMfA28bfqST3z3rS/TA0Eky0gTxaP7D8i1RjjAIy6EGOfwOpKl4gBLezBYuwtGr0VBRDayEjYcFrQMZw+3l/Nzo6DBZD056RIfNdCYPx8aBMnAvmpbTZo3imhJHGPrTaeE8Lv9mvjxnou2QgqrFVH2IKg5LnXo2KNIle0Xzpe2SX9nsiHyYUVzo2f9PSB7ajBz1DZLHA/Kgt2DUAozfziBeuOCDshDZU+zLiwNyAtN6+rxmIBpSdtf4bcDR4a1mJqKo3e8p9NE1D6R8Ii359preYoQqfraEdjxfKxXAAwBfnZSr6CJndDMDx0kWTWE8DCDTWacZnapSur1z685niXQoaF8JQPx14EQge/iA9YbPon0RjZl8qRfT+Wgtfwp5NSP6MCG6lDKg14LqZX/+sEm9Cvlz56r6IC7e5x55Y2deXAxi7yLDj9mwA0xGF2n2vmkYdwEs7kvkqd5/f/CtqEQwbVaH5B727pLn8NJUeMIY3+f+kGK//2r696C7072f1e7o2YDEFM8TZzWufSzQ6/Q3BRqI4AbFvtzOf6pKW2OrBqZyQfH46tSJW7Z2i6ZvvVeLQ61WJ471oUZUGeOGA6U70mbyaitOD+aFKXjWjAj4rGWBaJAW+ByxlJclMr7+iEZWf/caIQX3tomiuhVSnArcI8cPYKuP3MSCv9t93acwd49cbBOym8o7FUgSLkOt1YBhSP+vnxcPxavrHhmuCFVEjc0wakM9Dp4sN9ScCSE58v6AQJuJeETmPJLfBvBxhlnhkFoxsM8kzJ1+Znp52uQ92iWnDblWlxieIpgulY7TB7hXnE0fvP8CsyV07UCKl5oTv39X3ncCKQJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(346002)(396003)(39860400002)(36756003)(478600001)(2906002)(122000001)(6486002)(38070700005)(186003)(5660300002)(31686004)(83380400001)(91956017)(76116006)(66946007)(66556008)(316002)(66476007)(64756008)(8676002)(4326008)(86362001)(2616005)(41300700001)(66446008)(31696002)(54906003)(8936002)(110136005)(71200400001)(6506007)(53546011)(26005)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STEzWE05SUhoNUExNGlJdEpPWmsvSXBybnF2SzZEYUp4N3puT0F5eTYyQW9h?=
 =?utf-8?B?OHpSRVdubmI4ZXRaMy96dmgrZkliZUxhQ1pDK3cwODJzVjVyb2FSZ3BocnZZ?=
 =?utf-8?B?Y0tXZTN3b3ZjRFcvbjhHaFNjYmtMMUJISC8vWFpzR0VCWkpnRDE2ZnQvMkcr?=
 =?utf-8?B?OXBvajFSR2FSc3RyZUxEYlBuZjAxVHdSRTdFUk9LSWJ2S3grZlkyU1orUUM3?=
 =?utf-8?B?RFZHcmNxN2pVKzgyOWl2RTVQNDBlcnFxWml1RDlWdHVwOGZmdFREcjB3ckdB?=
 =?utf-8?B?ZXlTL2RYa01uTkk0Ty9BRHRQeEMzOXUwQTg2dm5xWTJ5N0pPVHRjc3BKTGYr?=
 =?utf-8?B?b1J0Q25UUTg1b3kwa21JR3Bkb1RuR1JOUG41ZlhxUVZWWHcxNE81V1AwUDQ0?=
 =?utf-8?B?anY3cy8rR3JwTGpjaVZkOGlBdGZ0R3RWY1RVM0Z5L21zVk1xQUtjYWUzdFZz?=
 =?utf-8?B?VVY2ZWZUNnV0Vlp0MXhIMXJabTJUa2MwWUh2cnVkQUpGaERCZTNQaXNQbW56?=
 =?utf-8?B?eG1MRzg5OW12T1J5R2FPb1JnM0orZkVZdkloSUlYMy8wRXljczBUZXpoMmtO?=
 =?utf-8?B?NTNhSzcyS1lGOUhsTzFxMGozSHZjWTVQSXl0TU1KQlRvWXFzZnJKVWoySXFz?=
 =?utf-8?B?dmdwRDhlZmsrZVk1eGtXcHRJbllVVFhEQWxXZ2ZRblBoYnBSWFQ5bmNBbisv?=
 =?utf-8?B?QUcvQkc4Si9Xa1NnemJsb0NtczYrSmFMM2l4RVAyUWhQWFo0eHlWQXk4K2t0?=
 =?utf-8?B?SXBWUVFmTElaZ1VobFJTSHFQY21seUFGQkdJb0dYM2p5NmFRWmp6WDVhZG9j?=
 =?utf-8?B?Y203RkJ2QUo4ZjNRSHdrY0VOdGJ2WTNvL2pOdlQwdVJYbWNLNWEzNjBuS2V2?=
 =?utf-8?B?WEpRQjdKM3lYMm1HaWdLNlJqejljVXhBMU92NWw4dmNQZHpmNmFNRWthdHpH?=
 =?utf-8?B?Z2owNGUyUlFrWGV5OU0vcUhVY2ZuWlQ3OHhraXVZMmhSeWRFNm1jUU5qbW9Q?=
 =?utf-8?B?eHljYml4Yjd2WWRnSFRBUlo3VWRNdElpVXhNakVXekhyNW56eGNtUUdMeEQ0?=
 =?utf-8?B?SFlXMytuMXgyNUZVVGw5Q0RhWmdaRW1JVzBaRExzL2YrN2hJUTZwQXhsMWM2?=
 =?utf-8?B?OHVBd0dndEQrTk10V1MzUjVFZFI1bmVQcUhlV0pFN3ViZzBjRHArNEVZZUdQ?=
 =?utf-8?B?dzZoeW91Q3RqRFUyenBVb2hmQU1QSVh1dUpFcytNT0JUYlh4VDlEUkJJWWJr?=
 =?utf-8?B?WnZualNBNFgxdTlsZDF1bGJyTnVoTlhMcFNTZXRBOFVoZ3pVaEtPaVFsdGQv?=
 =?utf-8?B?REtRSEo1dVVrTXB6WnJPaXBRdmlCZXlJY1haOENBWkE2ZWxjRFl4NmlUc2RS?=
 =?utf-8?B?a1hnUnh4bHkrckhsZVBtWnphTythMFFSUlRDL1E4dGhBY1duTnE1RnVJNlp0?=
 =?utf-8?B?a3NoRnUvU0tWT3B1ZUdvRXNWVjIvekpZS29nUHRNd3pxSkR1bksrQ3JIWk14?=
 =?utf-8?B?Y2x1SG9rQm90N1ZVYTZYK1B2clFQZko5c3lRSGduYXpUZHhqVDVjU040TFJ5?=
 =?utf-8?B?LzBxZTQ1YTU3MUwvcWJiY2F1dXJJSkZDMjhuWkFNSUZ4bFRGYTBrcU55SmJu?=
 =?utf-8?B?ODYzYjhjNSsrQUxteThwMEU2SEF2TWtqWVBVYkxKb0lrU2VhZmQySG01eTBL?=
 =?utf-8?B?RmpPNzRlV3BiZVV4MU5wdzhLT2dSRUZCczNUd29JdVdCaXBmc29TK3ZvRzI4?=
 =?utf-8?B?MzhuTkxwOUtPK2JnWkpHVlh5c2w3NGNYY2NKbzNNYXo4MjNCUTdPK0ZmbTNS?=
 =?utf-8?B?cGk4ZWhWQ2xtR2dsNUdIZ2JKTTM3L2Z0K0lKU3BCdUYydHlVQWgyTXRXRE5T?=
 =?utf-8?B?RC94QkN6KzRuTHRiNmtXTE0wbW9YNVZFeEM2YzAyMCtlYzZQUUp0TUcvQ0xr?=
 =?utf-8?B?a05TL1diR1p3cTlmTGFMMll3Z0c2R2dFQjh4VUZJOVZwd21OeGpDNXJ3cE1i?=
 =?utf-8?B?ZnptWVFQTXljeW9KTWdpaEp1U0JUU29IMFAreS9vNDVPQUJQdEQwaHRpZkJI?=
 =?utf-8?B?cmZYSHBZZHYyUWNpbTdHS2l0RlRpT2hIcUEyWEVid3Bxb2tWMFlNTzNPQy90?=
 =?utf-8?Q?tkjoiKhzuNgnK+qtfrOHLoQOf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1354A068AE404F42A566AF40AD4FB0E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99590fba-e166-4468-f133-08da55a6feaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 06:01:35.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUX9FXGpiAoKB3hPqI3/2mFnTCRlEEMrSIAnQawDN4Hgnz12C0KoolqoOpFvThfvTGoXZvVY0P1Pv3o3sFWn+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMDIyIDg6MDcgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gRnJvbTogQW1l
bGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAZm9zcy5zdC5jb20+DQo+IA0KPiBXaGVuIHVz
aW5nIHVzYi1yb2xlLXN3aXRjaCwgRCsgcHVsbC11cCBpcyBzZXQgYXMgc29vbiBhcyBEVENMX1NG
VERJU0NPTiBpcw0KPiBjbGVhcmVkLCB3aGF0ZXZlciB0aGUgdmJ1cyB2YWxpZCBzaWduYWwgc3Rh
dGUgaXMuIFRoZSBwdWxsLXVwIHNob3VsZCBub3QNCj4gYmUgc2V0IHdoZW4gdmJ1cyBpc24ndCBw
cmVzZW50ICh0aGlzIGlzIGRldGVybWluZWQgYnkgdGhlIGRyZCBjb250cm9sbGVyKS4NCj4gDQo+
IFRoaXMgcGF0Y2ggZW5zdXJlcyB0aGF0IEItU2Vzc2lvbiAoc28gUGVyaXBoZXJhbCByb2xlICsg
dmJ1cyB2YWxpZCBzaWduYWwpDQo+IGlzIHZhbGlkIGJlZm9yZSBjbGVhcmluZyB0aGUgRENUTF9T
RlRESVNDT04gYml0IHdoZW4gcm9sZSBzd2l0Y2ggaXMgdXNlZC4NCj4gS2VlcCBvcmlnaW5hbCBi
ZWhhdmlvciB3aGVuIHVzYi1yb2xlLXN3aXRjaCBpc24ndCB1c2VkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAZm9zcy5zdC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEZhYnJpY2UgR2FzbmllciA8ZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29t
Pg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQoN
Cj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDMgKystDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5j
DQo+IGluZGV4IGZlMmE1OGM3NTg2MTAuLjhiMTU3NDJkOWU4YWEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQu
Yw0KPiBAQCAtMzU5NCw3ICszNTk0LDggQEAgdm9pZCBkd2MyX2hzb3RnX2NvcmVfZGlzY29ubmVj
dChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgdm9pZCBkd2MyX2hzb3RnX2NvcmVfY29u
bmVjdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgew0KPiAgIAkvKiByZW1vdmUgdGhl
IHNvZnQtZGlzY29ubmVjdCBhbmQgbGV0J3MgZ28gKi8NCj4gLQlkd2MyX2NsZWFyX2JpdChoc290
ZywgRENUTCwgRENUTF9TRlRESVNDT04pOw0KPiArCWlmICghaHNvdGctPnJvbGVfc3cgfHwgKGR3
YzJfcmVhZGwoaHNvdGcsIEdPVEdDVEwpICYgR09UR0NUTF9CU0VTVkxEKSkNCj4gKwkJZHdjMl9j
bGVhcl9iaXQoaHNvdGcsIERDVEwsIERDVExfU0ZURElTQ09OKTsNCj4gICB9DQo+ICAgDQo+ICAg
LyoqDQoNCg==
