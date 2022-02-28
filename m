Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C14C7137
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiB1QDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiB1QDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:03:13 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120079.outbound.protection.outlook.com [40.107.12.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A113E3C;
        Mon, 28 Feb 2022 08:02:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRE/4HIrqe71+NNkGH583mS47+jcViAa3byNX9u8o+XbTml0p5F7q6l5fjVrbrmyKn3U5zsfEpQSdhPPw+ik6Rt0q+O9QR7npxkm5e3vr5LRJqnvehRXarJocmYAPZwWiBsZPQpyzSmd4aCZxEm1tfPDAZse31CNcId9e/LP1V5HbSEyGPnfy9XDRBXKZp5MuRXDiE8FGxLUPMAi9pWSV0DlCj7SXGpuHklDuMhiOLLBpBvDAZkyLFwkBXwO6HtfpeAHvVinsRtF0xFDFgt6SWT4g1tobmG0PH+aVujwSC6WzyUG2uK9V/FNV3+1MUfwB6b81kuBxcFeoKqKX1seoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGGozEWN43eWys7QiAquFdVyqy1uSHo7D2FMfzj9YsA=;
 b=Q5ZKrazNDxnJSkZE5OEbiLazmx56az92EuWVH8cZ6RBesM4FwBZ3y6hCyTcmsoV8zdnE2zeg20ItuYTu4Ncsi7EYJXvyTaGkJgXzWUY7KPxw+tosbmZa9ovDCcYyzmxqKOeaCaAze7wKALFEaSIzbsluGJoigsxf9Oe4xMtvn1+drgESZOsaxcUYSbfBHKVGxkr0ImIsquTdgLbl0/Hg5hPyDIuAf2qOenc+zGZJE8gp4kEZ94XxZ9yI8MPseidLkePn8PtV35YR+jIaho+GUom0x/+RRhwS/9nowdCIgRrlQIOcbZp7iChWgNVH6S/DyX/7vgJxVOlVVDLSKzO4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3514.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:02:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 16:02:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Topic: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Index: AQHYLLYaFbn8bOSg7kWQHVbhv1kp1KypFp+AgAAJIIA=
Date:   Mon, 28 Feb 2022 16:02:30 +0000
Message-ID: <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
In-Reply-To: <YhzqbYW1q5bPNWXn@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12249049-5125-477b-4a36-08d9fad3b983
x-ms-traffictypediagnostic: PR0P264MB3514:EE_
x-microsoft-antispam-prvs: <PR0P264MB351495C9429599A2BB40C1E7ED019@PR0P264MB3514.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpI/1obqcdBzZGWMhOKj0zsyTr+slVS3Xzj7XVA4e418CPAn7p15G7oHGxeIi1+mSBaK9c+ogFKr87I9c0fz3bL3l1HPlAdptBF9o5vvmQvWrbAWjdTPwTmKHrJDIiCOzmXl2YbGINZed/mDJwvjbss4CUH/jZffhZ6whkpAEWwSeg8nb0S/7UFGvcVdaZ30jGnR+DNnxoaZhOF+H0iiH7WxvqCQ7KziEM9BWcv5lvTI8yioaA5EW6CzTiJLRdiSGNDRrYtdXv3Mt9A7OlwTR6ReO6CJiHxnN7Mfd7lkZ86UCvOMFrwbq4mdCommvJYVRPv7z1T8DFvJ1SF6lMtOI9yFD9giKX7zfMRNb1wQzuZJQ9xwqsGhwSi1b9kpTokzA88SV/swFW69eFs2H0NyLoUeVp10YxrW7y3/3cZ9/8atVrbpRkEVmvb8CyCo6tfXvpMb6ESblQmnBs5ycJV+DnuYBtvI+wyCN78AFnJS/zseiYw1nZ9pId5EzbM4O1qoHmtnFuSItGFueptzQmqCtocoXraioMmfmujty39WpigEXq1WcbSgwr+2CE+DPUhXp5Mh68xny6sFGsXZqfYiVNxLysbug/DM6ltWAncuDb1pbHS/IVyKb0s5G4nKLR9BcU8EBIKtx6I899JXtH287DGtgiDIH/+Jf64F8GIGXeSxnZGlB+W6FEYTcyB74pFGYthRW89+/zpXhKCGAPK0TvMIZLMhqTpRMNuNbitGC8MPh0b1Raw6IAlszKqmKYOxz0WZBqzyLPf1vYeUQZXq1zkS1T1IDIl8D32oU6W7td10rOQ0w/rk96cJ5aK3nsAGfxDKg/6KynvMoCSfILPqc5w/eW41q7w/l9LVGXi9wUY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(122000001)(83380400001)(31696002)(54906003)(6506007)(44832011)(6916009)(2906002)(2616005)(6512007)(5660300002)(86362001)(38070700005)(8936002)(66446008)(66556008)(66946007)(66476007)(76116006)(316002)(91956017)(4326008)(64756008)(8676002)(186003)(26005)(71200400001)(966005)(36756003)(6486002)(31686004)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2U2NmRIVVZIMzlFS0FENmFQTTdEKzdMUCsxNW1pSjQyRE5XeDVPd0NXUTdK?=
 =?utf-8?B?YkhMOEpCS0t1WXBtdzNRSGJaQ0w4QVhoaGdhZ0x3U1B1a0NXQm1FOXFwTkh6?=
 =?utf-8?B?bCtPTnZsVldlbzhZRWVzcDA1d2xYd01SYlVKbWlEYjJhUU45UzlyTnFRS3JK?=
 =?utf-8?B?MGd4ZzJDTE5GRGkxdXROK21wNHZCK1B3V0tOdkdSNFJBN3pCdnVhanZTdVZ1?=
 =?utf-8?B?UHBINGYyTnBmMmZKVVFuaW9JMU9SenR5RTV6Wll0dDAvQVZWTlRJcXlLSjNq?=
 =?utf-8?B?SlRxaXBmMnMyVVJzVC9vQ2JMZG04MEkxR1ZtM2VGZ1hYbktHN0d6YXROWlR5?=
 =?utf-8?B?Y2JDaGxPQlZ3WnJ1SFZzQ0JiK053S1o4bHhiRCthQnMwUTBpTlNDamVHTTBv?=
 =?utf-8?B?MkJ1d3A2RktrbHZrZHl5OVJubFppSWs1WkljZ2VjbUxkU3YxN3BzZ0R6b3NT?=
 =?utf-8?B?L2tiN05pS1pFMnJRaGp1QVphdk0xYXdReFN1QktUMjV0L240ZHJHVjQvRExQ?=
 =?utf-8?B?ODZDUjNkbFp1aXZUenVJSzNjdk5QSU5jdzltTTJGRjR2RU1jRG5iSGhuelVt?=
 =?utf-8?B?WGtyWGF0QTdXaW5mM09zTEZyc0Z2MGJVOWtvZnNPU3ZaK3loQ1JoL1NDWFZD?=
 =?utf-8?B?N1ZoQWJFZHltbmZTZ2diWStrck9oRS9UdmZNcUxJN2ZneTJyc05uTjEvWmJH?=
 =?utf-8?B?a2owcFhrbTh0M2tRNXlaZlhaRXJZUzd5dElacnQyN2ZGWHFwVVVjaXk2Tlky?=
 =?utf-8?B?eHE0c1B6Q08vamhRRUhESUJPVjd3Z2wvcFJpT2ZQQ0xyb2Q0NnJodjFUVE9t?=
 =?utf-8?B?UTZ1M1ZwMmhKcmVEd1FveVVUcldyQjVwN1JOU2g3cjltVDlkRkc3cE8xSkxE?=
 =?utf-8?B?cUFMM2RnR1cvUWVyUHp2NmVEZGJRZTFEdkJUSnh2M2FuWW81MkJ2Q1daVFo0?=
 =?utf-8?B?TSt4TUgxOXhBN2EzTTg5WkFBbVA4WTZTbTZkSTZiTWprTUxSRFN4b24vYzZm?=
 =?utf-8?B?Q3Z0RmYvUlVJYTEwTWkxa1VLY3I2V3U2c3hhc1o3cWhVL0Q5a0NrNWczMkh4?=
 =?utf-8?B?aUxCY2VXVFpuZk5ZMnpQS1dRb0JiOGtoVDV4dldlZWlEbzZhNDlpZzJzN0Yv?=
 =?utf-8?B?cGtuQWdUdE5ZK0JDMjF4cWNjeHZFNTVOMTM2M2ZXZHRlcVEyL1BsYk15TWlJ?=
 =?utf-8?B?eSttNjlkRTlDVFhONExiUENINE1STmVGV3I0WlNHNHdVczBqSjRkeXlCdjBQ?=
 =?utf-8?B?SVk5WTZSRTVmN2RidzZzeDJiU3hla3RxS1ZZdjBJbUh5T3hINnBXeDRiZHo5?=
 =?utf-8?B?cS8xYURFUlFMUXhHMVBwUDdFR3V6ZVF3UW56KzNlRVVpZ0EvcjU2MnFZWUlY?=
 =?utf-8?B?L3NzWjdrb0owQ3crVEwxV2N5OU1md3hCSmFwZ25XdHZ2MTd4U3pHU3p3b01E?=
 =?utf-8?B?cFNnOFNaTGM1ZGZEM1crNkpsNGdxam9aeERnaFJPVE9raVRmaXZ3dEVXdU1r?=
 =?utf-8?B?dE1Rd29UT2JQUnNzejBISjZLNE5XRTZCV3RadmFrRnVjZVovY3IzeWtVYU9H?=
 =?utf-8?B?TW5uSzRGMk1yL2pqUDNZeGpkS0JUbXRES2FrN1V6bHBpVHpuNUVsTXdyWnhB?=
 =?utf-8?B?MFJWc0J6MVFjbDJSV0lnSTVCWGl1eWtHMU52NE1zSFRNek5yVnA1NEw4c2tq?=
 =?utf-8?B?RXJSL0J1WktsSE53dkVsa3JCVWNoRkZQUWlxcUJWVlVKRTZmWHBJc1RmSEpH?=
 =?utf-8?B?ZGtJYkpyOVgrK3ZIMU5pUlc0NUZiSkhpQXc5bWRXZ3J0RnR6VS9ETjF0aU1I?=
 =?utf-8?B?VlpzRUxXTndsMFRMQVlYL1BlbTlIRisraGVLdU1zKzZBWjFaS0EzTlIwWW13?=
 =?utf-8?B?bk91M2M5bVZVd2ZKRVFrczRKZDZ0VUd0Y3cxdXQ2aGp5Q1d5SzRCNVE4V05X?=
 =?utf-8?B?WGdJdjJqN1YvZDJ6REtNWWNvKzRHTk5PVmFmcDEzZE9MMHNFUG5TWjNLc3Zt?=
 =?utf-8?B?bEF3QWJFeFFINzN6bzZ2NzBvaUVmei82dTIzYnY5cEprQXVMaW9kVTVtNWxH?=
 =?utf-8?B?OFRyR3J0OTljZEpwNkx6NnJKeGxvaEhWQlpuM2FHVDVGOTlzRW9ibWFydVpa?=
 =?utf-8?B?RjJHaEtaNVpLL2NwY3B3RXdDckxDSHJvdUk0Z0lBeEpYMFUxaDhpMGZ0cU84?=
 =?utf-8?B?Tkw4ZDRLcU41VS9KWWhFRWNGcTNhQVoxOExWczdHTWZYakdSaCtJVXZackpz?=
 =?utf-8?Q?wygKY2+VJaoXjIf0CyLbU2dPrgQ31+AIIlCi+Yo9W4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBEEE51835C01046B5085AF71B95B3DF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12249049-5125-477b-4a36-08d9fad3b983
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 16:02:30.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gn8ZIBxg7liLZLolY84wvYFnylzEq/AWqxOSQJ6eGDEcFwZ71QEZl8GMxaJwn5i4ofk4K5oILp32WnwcEEgZtfXDXG5CnBq6zJ8aqGL8NfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzAyLzIwMjIgw6AgMTY6MjksIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
TW9uLCBGZWIgMjgsIDIwMjIgYXQgMDQ6MTU6NDZQTSArMDEwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4gDQo+PiArCWlmICghc3RhdHVzICYmIHNwaS0+dHJhaWxpbmdfYml0cykgew0KPj4g
KwkJc3RydWN0IHNwaV90cmFuc2ZlciB0ID0gew0KPj4gKwkJCS5sZW4gPSAxLA0KPj4gKwkJCS50
eF9idWYgPSBlbXB0eV96ZXJvX3BhZ2UsDQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJaWYgKHNwaS0+
dHJhaWxpbmdfYml0cyA8IDQpDQo+PiArCQkJdC5iaXRzX3Blcl93b3JkID0gNDsNCj4+ICsJCWVs
c2UgaWYgKHNwaS0+dHJhaWxpbmdfYml0cyA+IDgpDQo+PiArCQkJdC5iaXRzX3Blcl93b3JkID0g
MTY7DQo+PiArCQllbHNlDQo+PiArCQkJdC5iaXRzX3Blcl93b3JkID0gc3BpLT50cmFpbGluZ19i
aXRzOw0KPj4gKw0KPj4gKwkJc3RhdHVzID0gZnNsX3NwaV9zZXR1cF90cmFuc2ZlcihzcGksICZ0
KTsNCj4+ICsJCWlmICghc3RhdHVzKQ0KPj4gKwkJCXN0YXR1cyA9IGZzbF9zcGlfYnVmcyhzcGks
ICZ0LCAwKTsNCj4+ICsJfQ0KPj4gKwltLT5zdGF0dXMgPSBzdGF0dXM7DQo+IA0KPiBUaGUgYmlu
ZGluZyBsb29rcyBnb29kIG5vdyBidXQgdGhpcyBpcyBzdGlsbCBkcml2ZXIgc3BlY2lmaWMgY29k
ZSB3aGVuDQo+IGl0IGxvb2tzIGxpa2UgaXQgY291bGQgZWFzaWx5IGJlIGltcGxlbWVudGVkIGlu
IHRoZSBjb3JlIC0gbGlrZSBJIHNhaWQNCj4gb24gdGhlIHByZXZpb3VzIHZlcnNpb24geW91J2Qg
bmVlZCB0byB1cGRhdGUgZHJpdmVycyB0byBhZHZlcnRpc2UgbGVzcw0KPiB0aGFuIDggYml0cyBi
dXQgdGhlcmUncyBiYXNpY2FsbHkgbm90aGluZyBkcml2ZXIgc3BlY2lmaWMgSSBjYW4gc2VlIGhl
cmUNCj4gc28gYW55IGRyaXZlciB1c2luZyB0cmFuc2Zlcl9vbmUoKSB3b3VsZCBnZXQgc3VwcG9y
dCB0aGF0IHdheS4NCg0KQXJnaCAhIFNvcnJ5IHlvdXIgY29tbWVudCB0byB0aGUgcHJldmlvdXMg
dmVyc2lvbiBlbmRlZCB1cCBpbiBKdW5rIA0KbWFpbHMuIEkgc2VlIGl0IG5vdy4NCg0KV2UgZGlz
Y3Vzc2VkIHRoYXQgYmFjayBpbiAyMDE2IGluIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtc3BpLzIwMTYwODI0MTEyNzAxLkdFMjIwNzZAc2lyZW5hLm9yZy51ay8gDQphbmQgbXkgdW5k
ZXJzdGFuZGluZyBhdCB0aGF0IHRpbWUgd2FzIHRoYXQgaXQgd2FzIG5vdCBzb21ldGhpbmcgdGhh
dCANCmNvdWxkIGJlIGRvbmUgYXQgY29yZSBsZXZlbC4NCg0KQnV0IG1heWJlIHRoaW5ncyBoYXZl
IGNoYW5nZWQgc2luY2UgdGhlbiA/DQoNCkJ5IHRoZSB3YXksIGZzbC1zcGkgZHJpdmVyIGRvZXNu
J3QgaW1wbGVtZW50IHRyYW5zZmVyX29uZSgpIGJ1dCANCnRyYW5zZmVyX29uZV9tZXNzYWdlKCkg
c28gaXQgdGFrZXMgY2FyZSBvZiB0aGUgY2hpcHNlbGVjdCBjaGFuZ2VzIGFuZCANCnRoZXJlZm9y
ZSB0aGUgZmluYWwgZHVtbXkgdHJhbnNmZXIgd2l0aCBDUyBvZmYgaXMgdG8gYmUgZG9uZSB0aGVy
ZSBhcyANCmZhciBhcyBJIHVuZGVyc3RhbmQuDQoNCldvdWxkIGl0IG1lYW4gY2hhbmdpbmcgZnNs
LXNwaSBkcml2ZXIgdG8gaW1wbGVtZW50IHRyYW5zZmVyX29uZSgpIGZpcnN0ID8NCg0KVGhhbmtz
DQpDaHJpc3RvcGhl
