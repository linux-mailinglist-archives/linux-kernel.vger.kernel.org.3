Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A184D5953
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiCKD4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiCKD4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:56:17 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631D1903D4;
        Thu, 10 Mar 2022 19:55:15 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2E61AC19C4;
        Fri, 11 Mar 2022 03:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646970915; bh=Hct+zRsGLqLhBM7zukCT6tZVNZq4me6v8e2GHJXLasI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YQzp3dv8r7Req9svxw8hU9u+AXBS7y+BdSNqi85Zrc9Gxg3Mvaott4SiHW0cmc5q/
         6wl20pdiqMffKpjvgHfJgQ85BruIdpUDra5TYD7SXSk26ahxcEXR0BmC8L1gSdIzw4
         QvUMpUJmPgmW9QK6+P3Ue4otPdyz2ALr3EcvHagFovcvZrR4VNjXsHSs1duHOlEOI2
         h4UmpGC+umKwrRs5CS9sBdDNKndvCcTf6CPctcFgFCNxhwWH0e+qksahCaD0Fz5yyn
         xUsPzKWYRssygtBk4z9zCjBxLIOtNlD4Dyhb92lyrKDg9U+m3li2vNBXN5Pe5ya6AA
         SQz+Z2mrG7XVg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3B5E4A0063;
        Fri, 11 Mar 2022 03:55:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CFADD4005A;
        Fri, 11 Mar 2022 03:55:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uXQr8KL7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVanoPosrPEbS73n3OCuLEAjO2Jw7T2UHlowvpMXeG1P5mjAxcboZCf9m5efgex4UVuSRr42c790Tps6ChWrMH2kUkVfeEy94rklBh5nEaW80L3Tmyvd66BRijOe+3CZAcPYFaCcVTa3BSlE1XX9cPB49OEapiPZlalX5wX5k8ie0hdXstniQlBWcfpT/iVZ0/oIGCxT+C4a9e1mbb1XWEQtYq3cRz2t2NRs45UC43RtB8dI0s1Cj7ZpuyBWYUX47XXPcyGKYFLbsveTzOakiGOnABSkXJGGz9ytSvUczsWBBsK4MLbphYK01kjaaPTDOTyCrEPTxr6DgCF0FzmgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hct+zRsGLqLhBM7zukCT6tZVNZq4me6v8e2GHJXLasI=;
 b=Qz6pkzmFsiJf0gW4zIKCkb1ksYMvWCQMik0VuCwt+Ut/goXN5zjTRMigo53hqcMiVu6UGIQEIfjbEcuz+i9vk56a2O6kge5fuuDc2r346RQm6Y1P+EwZJtYEugEA/Sut1gqmrTyZ10Lj/I0zMW0kkU+oZJJ3BFLQnKk0/UZJoe4yLHxzp3KWzDkCKfsWB/w+9/110ZbK9+C8P0NVerC2ftDo/SkwD4w9+jw4PbGu+cPD8GPJzVZ5ptcsANmzL9UCbcBOduk5+wAjVXmxRVdmGh2KaY+VgBKws1eBIGfH3bnmfWoGhhyURLgosNo2p/6oEe0HiV1M9XFuEusvPJjKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hct+zRsGLqLhBM7zukCT6tZVNZq4me6v8e2GHJXLasI=;
 b=uXQr8KL7RyEFe4yllolh8bToyP3a1CYHF8suvVkBDHOojFTohjGbjh3QbDwZBtuFy+ecZwJvYrtQTbT2KkhHRWZrULyM+1fFH/O+qKhuRDoM6n3mWRxnhqG4urr7pIvR8p/OMH9852j/b0+jK0lOxbEFBvG9Vc73+PKu7WAS+P4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY4PR12MB1719.namprd12.prod.outlook.com (2603:10b6:903:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 03:55:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Fri, 11 Mar 2022
 03:55:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "cpgsproxy5@samsung.com" <cpgsproxy5@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Topic: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Index: AQHYMePmBfflf4nAkkGdLNAaNOlrkay35TEAgAGF7ICAAAeXgIAADPuAgAAS/oCAAAEkAA==
Date:   Fri, 11 Mar 2022 03:55:08 +0000
Message-ID: <a1b9752f-96e6-7abb-d6d3-ce4742742a0c@synopsys.com>
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
 <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
 <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
 <016a01d834e7$72b11fd0$58135f70$@samsung.com>
 <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
 <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
 <0ae388d8-0809-f09a-55a8-b682c9dc42c5@synopsys.com>
In-Reply-To: <0ae388d8-0809-f09a-55a8-b682c9dc42c5@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04e24cf7-6226-43d2-e002-08da0312ef6c
x-ms-traffictypediagnostic: CY4PR12MB1719:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1719FDCCE9973A713DBCFD9CAA0C9@CY4PR12MB1719.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IN1X4xKNrEgFDzPIxK/3uoWsWDaS4S6Hear9dqxGtnr6QdV4/ARk8JNY7lix5NMhTa85DxzHol/ZunP6/IgX3Kyz+u0Yg+pW43tD/Npw7q3EuU/E0AoetxtyS1XdyixaCfjFm0Gs85PN1iUtHNsMJ7q95KCLegyKXvMeJ+EUSKe8xEOaMX8bxNQpvmz9U5vL2QyDWijmPAd2LcqzY2zfQTDNxux2hZaVLhDLUhVOCChSf81x2et5mSTvnH/aYKhk7hzjiV9f70nieMmZ0ydJmM5sBbbkaOOtvnuKjRXHPoG3PDEhuXfK8RGpBxtlsTjcFOtClZuvUJ/2Hq4SYbi1n1XUcuFSoLOLmmJ4/kryabF5D0itNFC7iTrj6rZVKVFanufLGyL1OGluB27rtkGQO9yeMn+uWCx5W26cJ0hC3fchpXVh4dPxnOac2K8Q2ggR4ZZIuOVNAkjDgkdSMBE9BVyHdxu9G5i3AnvUnMSweWbCm6C30S6u8k5RLvviLPhFTF7eMUEPJ3yazlfQN2hmnrKtuf6XjYzP/uvZzWqlkVkX3JLAg7D/jKhTeYBdoq6K7ZTuE+TJwSgTO7E7Aq/8O0AWvD0p0v2mM8F3ilTxoqxe9145rJaLW3R5gbna451nlio26Dkd3X7h1tlFBzSLgwcosp3uiosNEfDVHNaYv84MFWkJGXq8X0goL54/0F7RQOji8U8Qax7yoX1olewqOKd/nlnU4y9s92OSGoXOQSR8m5X4hHJF8Z9jof8R7dt4fza0UW0bxrQypcjj/j0cuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(186003)(31686004)(64756008)(76116006)(8676002)(110136005)(54906003)(4326008)(36756003)(86362001)(31696002)(122000001)(2616005)(5660300002)(83380400001)(6506007)(53546011)(66946007)(6486002)(26005)(38100700002)(6512007)(508600001)(66556008)(8936002)(66476007)(66446008)(2906002)(71200400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk8zSGxGNllmQ1hpdWZPN1c1eTZDS3ZxTjIxQUNNMHNEVFo4czJnS1JRekpL?=
 =?utf-8?B?clFXMjBTZEhzS3dqVFQxUkVhZ0hrUDhpQmhSN1Q5NUpVWEgrM2NPTmg0ZDlS?=
 =?utf-8?B?cUdsZTQvbElPY2pQRWUyYjh3MVlDQVRhY3FyNXdYbXpyR3ZlZFNQUTAwanJy?=
 =?utf-8?B?d3FlZ0VsRXlsQWtKTmgrRXBOVUlsUzdUVkNHTzl0Ky8yZ3pGN3JRY0hMSkdX?=
 =?utf-8?B?Z1QvczFlUUFJL0wxK2hxaTk4R3JsYnl4TWp0RUE3RDdMSmErU2l5ZlVRWkpi?=
 =?utf-8?B?UzhXY0FzYlBRNmZtL0VDTWtmN3hWMm9GcERER2JOVU11QVBXTm5oeVdhNStN?=
 =?utf-8?B?Ri9BM1VKbytEVi82ejB6N2xoUzRpNkt3U1prNHpLc0hla09zSVkwN1k2ck9W?=
 =?utf-8?B?TkJ4L21nalJwMi9jd0R5akdoUGlPa0xVekhTcWRsWWc1MFVTMVl1dHJ3TWdC?=
 =?utf-8?B?bjlKdU5TOVpYeW11ZDEzSzhzTExVRHhUOUdBeVl4UDZRalZtVk1acWpUc2Uw?=
 =?utf-8?B?WTNuMXVDeTBPSzJVNUtYU3FRU0QzK09RYmpLamhjcHJpV1doRkkzRkFBbm9q?=
 =?utf-8?B?aDJvMTgyd0FIY1cxdWZISnRIRXZSek5TUVFtMWExYjZ4UTB6MXVlSlN6dU9q?=
 =?utf-8?B?VTBoUk5Td01GcnRlcUxaOHBoa293QTJpOXQrR01zb0ZMdTBwRkRFRTFaNVZQ?=
 =?utf-8?B?ejBaeExXYzQyQ2RvSVA1OWpiY3Bwa2swWVh1ZTUxWXRZR2F5L0M2bkRZb3Bz?=
 =?utf-8?B?MktxVitBLzhGM1RiajludDQ0ZWJackVmcUMvOVY0cGpWT0ZwVWE0MzkvQi9S?=
 =?utf-8?B?ZDZ2N1k5SGxiL0pzSkhDV0lPTnE4cXIxZEdhL1BoZ3MzTmlUWkRoUmpzQ3dx?=
 =?utf-8?B?VDhPUEY0Z1QyQWovMEpJYjc0UDYvY2VlL0lSc28yVUROd3RpQldjdzFMVjRH?=
 =?utf-8?B?KzFTOFU0NHJNZmRWR0lnUDJQV1FIdGRuaUJiNlRBUmVuM1V3RFlYdENIV1JV?=
 =?utf-8?B?MzhDb1U2QkhzeVdkVlB2WG9oSSs0U1dBNTBzRkFOM0R6bHhrelhCSVhPM0tL?=
 =?utf-8?B?KzBzS1E3YzhaNzhiang4K0FCdUJQK2xtNnh1Q3hBbEsxbFV6UnF5NEtFOHdw?=
 =?utf-8?B?dGlveTBxOVZtZS9oOXE2SEtKa2dvcmpQby9FWkRrZkNGaGVNd1JrMWtaWTFw?=
 =?utf-8?B?dlFrVW1tY2czVkpsUk9VOUs2RGY1eHppZ3FncDdaU0E5Z2JRZmN1TnF6V0Z4?=
 =?utf-8?B?dnFucVJpcjl0U3IrRUNRODFwTGVvNjJuQlAwMkdUY1dFYTJMMlpBR3hIbW5P?=
 =?utf-8?B?ZE91bjFRYXFRRWN2RmxtMmZFOGtUSE9XL0hpNS8rSFlUcVEzekpnQXlUQjQv?=
 =?utf-8?B?YUJaTHB5bGlpaFpyQUI3aVdhWnJvcUhtMk9hYmxnVy9hSG9TQ1ZSUzJpRkJx?=
 =?utf-8?B?cUIwOENpMlV5Wm9QYnB1eXdMYW5DY1NxMXpUbCtpa2NMbHZvMnp5ck0zRzdo?=
 =?utf-8?B?UVFHTUtmQ0w4dEplV2sweFgxaDg5cmd5UWpqZm5xYXZjaW4rdytXSTk1QUFG?=
 =?utf-8?B?anFaNEZWTmdFTWh0cy96M3lRaFdwSlFqUW5EZEt4YWV6WVZLMk1TSGl0MFN1?=
 =?utf-8?B?SjllMFFMcWI3Uk5HVlJ0SXRxTXFmTFdrY3NtWnJJSURkUXJ4VHN2RjVpZHpK?=
 =?utf-8?B?NE93cjI0azNFUGk2dS9GVmZFL1VZOTdLd3JHNTFrRk14ekRVTU80U0dGT2Zv?=
 =?utf-8?B?cXNtamoxK0RvdmJYbitubGFFdWVZcGJlZGJ2SnVlUTJyWXF0R0JPMzkzNGhT?=
 =?utf-8?B?aWQrSW5Va0dRUGdRNHVyVzNkWlVlOFgyb1pVc1ZFclpGaC9GWXp1c1lRTkZZ?=
 =?utf-8?B?TXdsRmNyTHE4em9ZSEUwTzQ4cHBKa2RqK2pxb0VxSy9RL0VtM245elRORkh6?=
 =?utf-8?B?RTcwM2dLZktFZC9kQ1NJdmxaVmZkMVBNSlR6cUV5c2k0bjB3QjU2UURmOENt?=
 =?utf-8?B?dEhUakV1TlBYUHF2aFZnbGsxZDJ5TEpLWDlBaFNqcmJkczJDaHpPMGx0RFpK?=
 =?utf-8?B?TWE1TnVmcFVSZFJvU0xGZlVKNGVodThHMXc2REMyTU9wYVVvWVVPQjRGMjdD?=
 =?utf-8?B?TUVRVnRtZ0h4UXVyZUdVY251YVczM2h4L21DUVBRSEtlZ0Y2QzNTTHpLVHhI?=
 =?utf-8?Q?k6A0OM/9wjFbrAaDNOIyiJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAB30C72CC032C4194FE454C3F62E4E6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e24cf7-6226-43d2-e002-08da0312ef6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 03:55:08.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx94NvVtE8PxO1Y/4nsc1Ug01jYDTLPL/Wxo9JYGNSDHqWlEtP8p9isEUG5z4JB7vKbuB7H9TdqC05r/hkP3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiDsoJXsnqztm4ggd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBUaGluaCBOZ3V5ZW4gW21haWx0bzpUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tXQ0KPj4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTEsIDIwMjIgMTA6NTcg
QU0NCj4+PiBUbzog7KCV7J6s7ZuIOyBUaGluaCBOZ3V5ZW47ICdGZWxpcGUgQmFsYmknOyAnR3Jl
ZyBLcm9haC1IYXJ0bWFuJw0KPj4+IENjOiAnb3BlbiBsaXN0OlVTQiBYSENJIERSSVZFUic7ICdv
cGVuIGxpc3QnOyAnU2V1bmdjaHVsbCBTdWgnOyAnRGFlaHdhbg0KPj4+IEp1bmcnOyBjcGdzQHNh
bXN1bmcuY29tOyBjcGdzcHJveHk1QHNhbXN1bmcuY29tDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBsb2NrIGZvciBibG9ja2luZyBpbnRlcnJ1cHQNCj4+PiBz
dG9ybWluZw0KPj4+DQo+Pj4g7KCV7J6s7ZuIIHdyb3RlOg0KPj4+PiBIaS4NCj4+Pj4NCj4+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBUaGluaCBOZ3V5ZW4gW21h
aWx0bzpUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tXQ0KPj4+Pj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEwLCAyMDIyIDExOjE0IEFNDQo+Pj4+PiBUbzogSmFlSHVuIEp1bmc7IEZlbGlwZSBCYWxi
aTsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+Pj4+PiBDYzogb3BlbiBsaXN0OlVTQiBYSENJIERSSVZF
Ujsgb3BlbiBsaXN0OyBTZXVuZ2NodWxsIFN1aDsgRGFlaHdhbg0KPj4+Pj4gSnVuZw0KPj4+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBsb2NrIGZvciBibG9ja2lu
ZyBpbnRlcnJ1cHQNCj4+Pj4+IHN0b3JtaW5nDQo+Pj4+Pg0KPj4+Pj4gSGksDQo+Pj4+Pg0KPj4+
Pj4gSmFlSHVuIEp1bmcgd3JvdGU6DQo+Pj4+Pj4gSW50ZXJydXB0IFN0b3JtaW5nIG9jY3VycmVk
IHdpdGggYSB2ZXJ5IGxvdyBwcm9iYWJpbGl0eSBvZiBvY2N1cnJlbmNlLg0KPj4+Pj4+IFRoZSBv
Y2N1cnJlbmNlIG9mIHRoZSBwcm9ibGVtIGlzIGVzdGltYXRlZCB0byBiZSBjYXVzZWQgYnkgYSBy
YWNlDQo+Pj4+Pj4gY29uZGl0aW9uIGJldHdlZW4gdGhlIHRvcCBoYWxmIGFuZCBib3R0b20gaGFs
ZiBvZiB0aGUgaW50ZXJydXB0DQo+Pj4+Pj4gc2VydmljZQ0KPj4+Pj4gcm91dGluZS4NCj4+Pj4+
PiBJdCB3YXMgY29uZmlybWVkIHRoYXQgdmFyaWFibGVzIGhhdmUgdmFsdWVzIHRoYXQgY2Fubm90
IGJlIGhlbGQgd2hlbg0KPj4+Pj4+IElTUiBvY2N1cnMgdGhyb3VnaCBub3JtYWwgSCAvIFcgaXJx
Lg0KPj4+Pj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+Pj4+Pj4gPSAoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVy
ICopIGV2X2J1ZiA9IDB4RkZGRkZGODhERTZBMDM4MCAoDQo+Pj4+Pj4gCSh2b2lkICopIGJ1ZiA9
IDB4RkZGRkZGQzAxNTk0RTAwMCwNCj4+Pj4+PiAJKHZvaWQgKikgY2FjaGUgPSAweEZGRkZGRjg4
RERDMTQwODAsDQo+Pj4+Pj4gCSh1bnNpZ25lZCBpbnQpIGxlbmd0aCA9IDQwOTYsDQo+Pj4+Pj4g
CSh1bnNpZ25lZCBpbnQpIGxwb3MgPSAwLA0KPj4+Pj4+IAkodW5zaWduZWQgaW50KSBjb3VudCA9
IDAsIDw8DQo+Pj4+Pj4gCSh1bnNpZ25lZCBpbnQpIGZsYWdzID0gMSwgPDwNCj4+Pj4+PiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPj4+Pj4+ID0gImV2dC0+Y291bnQ9MCIgYW5kICJldnQtPmZsYWdzPURXQzNfRVZF
TlRfUEVORElORyIgY2Fubm90IGJlIHNldA0KPj4+Pj4+IGF0IHRoZSBzYW1lIHRpbWUuDQo+Pj4+
Pj4NCj4+Pj4+PiBXZSBlc3RpbWF0ZSB0aGF0IGEgcmFjZSBjb25kaXRpb24gb2NjdXJyZWQgYmV0
d2VlbiBkd2MzX2ludGVycnVwdCgpDQo+Pj4+Pj4gYW5kIGR3YzNfcHJvY2Vzc19ldmVudF9idWYo
KSBjYWxsZWQgYnkNCj4+Pj4+PiBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKCku
DQo+Pj4+Pj4gU28gSSB0cnkgdG8gYmxvY2sgdGhlIHJhY2UgY29uZGl0aW9uIHRocm91Z2ggc3Bp
bl9sb2NrLg0KPj4+Pj4NCj4+Pj4+IFRoaXMgbG9va3MgbGlrZSBpdCBuZWVkcyBhIG1lbW9yeSBi
YXJyaWVyLiBXb3VsZCB0aGlzIHdvcmsgZm9yIHlvdT8NCj4+Pj4gTWF5YmUgaXQgY291bGQgYmUu
IEJ1dCAiZXZ0LT5jb3VudCA9IDA7IiBpcyB1cGRhdGVkIG9uDQo+Pj4gZHdjM19wcm9jZXNzX2V2
ZW50X2J1ZigpLg0KPj4+PiBTbywgSSB0aGluayBzcGluX2xvY2sgaXMgbW9yZSBjbGVhciByb3V0
aW5lIGZvciB0aGlzIGlzc3VlLg0KPj4+Pg0KPj4+DQo+Pj4gTm90IHJlYWxseS4gSWYgcHJvYmxl
bSBpcyBkdWUgdG8gdGhlIGV2dC0+ZmxhZ3Mgbm90IHVwZGF0ZWQgaW4gdGltZSwgdGhlbg0KPj4+
IHRoZSBzb2x1dGlvbiBzaG91bGQgYmUgdXNpbmcgdGhlIG1lbW9yeSBiYXJyaWVyLiBUaGUgc3Bp
bl9sb2NrIHdvdWxkDQo+Pj4gb2JmdXNjYXRlIHRoZSBpc3N1ZS4gQW5kIHdlIHNob3VsZCBhdm9p
ZCB1c2luZyBzcGluX2xvY2sgaW4gdGhlIHRvcC1oYWxmLg0KPj4NCj4+IFRoaXMgaXNzdWUgd2Fz
IG9jY3VycmVkIGJ5IHdhdGNoZG9nLiBUaGUgaW50ZXJydXB0IG9jY3VycmVkIGluIHVuaXRzIG9m
IDQgdG8gNXVzIGFuZCBjYW5ub3QgYmUgcmVsZWFzZWQgdW50aWwgdGhlIGJvdHRvbSBpcyBleGVj
dXRlZC4NCj4+IElmIGl0IGlzIGEgcHJvYmxlbSB3aXRoIHRoZSBtZW1vcnkgYmFycmllciwgdGhl
IHZhbHVlIHNob3VsZCBiZSB1cGRhdGVkIGFmdGVyIGEgZmV3IGNsb2NrcyBhbmQgdGhlIFRPUCBz
aG91bGQgcnVuIG5vcm1hbGx5LiBJc24ndCBpdD8NCj4gDQo+IENhbiB5b3UgZ3VhcmFudGVlIHRo
YXQgYSB2YWx1ZSBpcyBzdG9yZWQgYWZ0ZXIgWCBhbW91bnQgb2YgdGltZSwgZXZlcnkgdGltZT8N
Cj4gDQo+PiBBbmQgQ291bGQgeW91IGV4cGxhaW4gbWUgd2h5IHdlIHNob3VsZCBhdm9pZCB1c2lu
ZyBzcGluX2xvY2sgaW4gdGhlIHRvcC1oYWxmLg0KPj4NCj4gDQo+IFRoZSB0b3AtaGFsZiBhbmQg
Ym90dG9tLWhhbGYgYXJlIHNlcmlhbGl6ZWQuIFdoaWxlIHRoZSBib3R0b20taGFsZg0KPiBoYW5k
bGVyIGlzIHJ1bm5pbmcsIHRoZSBpbnRlcnJ1cHQgc2hvdWxkIGJlIG1hc2tlZC4gSWYgdGhlIHRv
cC1oYWxmIGdvdA0KPiBjYWxsZWQgaW4gdGhlIG1pZGRsZSBvZiB0aGUgYm90dG9tLWhhbGYgaGFu
ZGxlciwgc29tZXRoaW5nIGVsc2UgaXMNCj4gd3JvbmcuIFRoZXJlIHNob3VsZCBub3QgYmUgYSBy
YWNlIHRoYXQgcmVxdWlyZXMgYSBzcGluX2xvY2sgZm9yIHRoaXMNCj4gcGFydGljdWxhciBjcml0
aWNhbCBzZWN0aW9uLg0KPiANCj4gVGhlIHByb2JsZW0geW91J3JlIHNlZWluZyBpcyBwb2ludGlu
ZyB0b3dhcmQgYSBtZW1vcnkgYmFycmllciBpc3N1ZS4NCj4gDQo+IEFsc28geW91IG5vdGVkIHRo
YXQgdGhlcmUncyBhbiAiaW50ZXJydXB0IHN0b3JtIiwgd2hpY2ggZG9lc24ndCBpbmRpY2F0ZQ0K
PiB0byBtZSB0aGF0IGl0J3MgZHVlIHRvIFBDSWUgbGVnYWN5IGludGVycnVwdCBkZS1hc3NlcnRp
b24gZGVsYXkgcmVzcG9uc2UNCj4gZWl0aGVyLg0KPiANCj4gQ2FuIHlvdSB0ZXN0IGl0IG91dCBh
bmQgd2UgY2FuIHRha2UgYSBsb29rIGZ1cnRoZXI/DQo+DQpXZSB3YW50IHRvIGF2b2lkIHNwaW5f
bG9jayBiZWNhdXNlIHRoZSB0b3AtaGFsZiBzaG91bGRuJ3Qgc3RhbGwgZm9yIHRvbw0KbG9uZywg
YWZmZWN0aW5nIHBlcmZvcm1hbmNlLiBUaGlzIGNhbiBoYXBwZW4gaWYgc29tZSBhc3luYyBjYWxs
IGZyb20gdGhlDQp1cHBlcmxheWVyIGRyaXZlcidzIGhvbGRpbmcgdGhlIGxvY2suDQoNClRoaW5o
DQo=
