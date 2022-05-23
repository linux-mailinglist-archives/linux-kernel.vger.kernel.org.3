Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD50A530EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiEWLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiEWLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:48:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F250E04;
        Mon, 23 May 2022 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653306491; x=1684842491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pR4+kEY+0rtUovZl4eo/B8pmoADnqVpCRumI+HV0sts=;
  b=Fi/IFESO9Ur/xqbIT1sGP3s2NEhGzH1Q0XlxQ3rZM9mvShypWz//OFOh
   prYmL4J70vW4/70qd5TMfE6PEoqBZXpNTLaNCVtzqvmmtb8ygjRUMP6/2
   4GDyGy4njEviwhXHzrVsGfSxs62ulOQaMMr+W+nAoWFjl620hr1Ro/Px3
   Y4mRFRFaM+soTJc0Kefwii+o86paNkRGUcMSeyFzk2GIVbVrBNwvsC55F
   0nw/BSfKPSNSYNybrj/0t16lfz25mYNGkmMegyElFZxUe39zYFIiTqSVN
   aPG2pTP5/d8gAUQDYgegkMw+0AYM065sDQke0ttOCm2mnP7mGMhQaPC5z
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="165251347"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 04:48:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 04:48:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 04:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W74SKFJwYQzUYQg77fI7h5z2x484wTfk4JaqoY8ORZPetXG1sbX67ICJNUh3AVQedR7lTgPAK0hQTlyNh8YqVL794JYxAYPRNQcTy7hfuJeGYtmiWNr5bcJcF2gANz/asCORCN6/87MDJDE7kzPyK02APY8e/5kGihT8FQ9FSDy7zr6FB4c63YP9jDu06GSbNol53TEtZZa4srz32/9+BkFWSfqiBcV2Vekn6+FCp11H+xhcw9w67yNAy7+dkgS5/TuJMyPvyqfTA1rQ+q/XbOI0ep4s+48w4d/kyWNeULajqVB/rv4Fkcys6LmgVz7eNcVOsouMnBLTEDZtk4wHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR4+kEY+0rtUovZl4eo/B8pmoADnqVpCRumI+HV0sts=;
 b=nbjLX+8aJb0Twa5sIrPjdCF1d8JBhpPyHFjH9dhNiCycJOtsnogbj/HspRupdQ/dhJ+ogsF7LSjFWsLjgh9NaKp8CSvDZc3V+YTYa2LqD0h9HpTtAyYveSSKUVzlLbnXQv7axog3WTzRNkk7BcW17OFrwbK9Z6oAnax1M6U+hJuK175zurm9wmxqRBxRTuzfemjmGjjRQ2sDRwDIKfjdffSMOdHCviPZkVqb48TTSyZlBmC3K/oM6P5J0AeJRxA28gFve0D7L1YX7YKLIVsgQekb+el0U1bOVlRyDt6/PfX78ZYaWw2of8S1uBlwXBJZv59M+g0YogvkN7BM9pDZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR4+kEY+0rtUovZl4eo/B8pmoADnqVpCRumI+HV0sts=;
 b=fbPQ3qBYDkm4lcl7CTba9cCuIH/sryb4eY0E0tLSCci0wILVZ0mH6ltR4f4hA4g2HeADvFZztJXm2qpH7C4lCBuTchhBb6jtTi/LLVRdjGeuV/4p5LI8B17xGBQTfiiOe7S8fUh4XLsDRMqXTzHPUfkbwHfLexsXyCedxeAFiko=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1915.namprd11.prod.outlook.com (2603:10b6:3:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 11:47:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%5]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 11:47:56 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <palmer@rivosinc.com>,
        <palmer@dabbelt.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <Daire.McNamara@microchip.com>, <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko@sntech.de>, <arnd@arndb.de>
Subject: Re: [PATCH v5 00/10] PolarFire SoC dt for 5.19
Thread-Topic: [PATCH v5 00/10] PolarFire SoC dt for 5.19
Thread-Index: AQHYY7DQ3kLmJTwM1kCphTDz2RbFs60sbhUA
Date:   Mon, 23 May 2022 11:47:55 +0000
Message-ID: <3cf58174-1ddd-219f-9f14-4d0015f697e7@microchip.com>
References: <20220509142610.128590-1-conor.dooley@microchip.com>
In-Reply-To: <20220509142610.128590-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 776081ab-31ce-4fd3-3217-08da3cb213bf
x-ms-traffictypediagnostic: DM5PR11MB1915:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1915A1902F8319DBBC660D3B98D49@DM5PR11MB1915.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKXEeUyosU36R65jnVOaLaJrswp2hl5kHDYkBC1+cFIAeIIH3XWL4M5aWAMDTazifpYZOcQdyAR7OAfapvzubq7byAkyBFwO1USqtBxxM4tzUeiJnwXBjgvznxbqSK65aVFyk9z1fJ7KQ3U3G6YuguisbhFsoUUp4UPrQqFXLifx3Ip4xDhxbm2P3FFL8MmUQCOvdfhVcJPGXDRR1NCe6A63RWtoFaQHR5n18huy207u0znkm10W2qudZdjUEolODDt2kkcy974ZMzsEttbzR8Q6oAjDSJTKzC1gc+I9iXWQxLSAR3riiu6r/Q6zLEqKDXplhV996ezepE97e5tshQJyIggjHKuFDYgk6BjieRCGAd4Dn6CXj2KF7UGm3bG0znUQKjTUGNnMFjGo6E/2b/9QsPFHDoJ6Wpmdsa6jjHguRe+0S33b2BRrr3fErERm1KjHKkBGODK8HPSx2zR3sKq6em8pR8R9RgS6PqJPYLULF0p+WxbwPDlDmJNakDg8R2exbyDn20Dp3QvgR3acIoOxc3HuNXW873lpGyir0J+3YN0PH3E5VLmHAnml6St4OJ6JESMBza6XhluPNke1K0C5PZG83lN/1uybeiu8/T4U/pp98tio1o003Jv+HgUiLI6Lmyf655FTGaN/FvhkmJrJI2HXeBQD3E205XxjhraxWhWyPyQYqjzfMsCw49FgrifnJkgNE/9d1DSwctH/wdPN8zNL4S+jKxDbz3ZWNahJVmvtkUrSapr7uHE1xV7hyxslv1MNwBkCeXsapctQCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(110136005)(54906003)(122000001)(38070700005)(4326008)(8676002)(64756008)(86362001)(2616005)(66446008)(91956017)(66946007)(66556008)(66476007)(76116006)(31696002)(186003)(6486002)(508600001)(71200400001)(26005)(6512007)(6506007)(53546011)(8936002)(31686004)(2906002)(7416002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0Z4Vis0MlVCd1F1STNaWnQ0SFIwYmpQQVA0eHlhSmxlbW00d0hleTZhQklD?=
 =?utf-8?B?R011V05xamczMVBxNlNxcndQTnBOZFBiNWhjUWNnczVZdnp3Vlo0L2h5YXo1?=
 =?utf-8?B?RnNwSWRwYkRINHltNTJndm5HSVdpOXIxUnIvM090bTdna2U0QlA4VUVXVG5V?=
 =?utf-8?B?VWFKM2NUVDJtYUxMamZsUDRDTUlMODVETFlBTWh5QzdLaXhWc1V4U081b2dt?=
 =?utf-8?B?Rml2T3NVR0hINTVuU1U4NEdORHNvSy8wSGlLcll2dWpRWHZOM1pOZmhMRkg3?=
 =?utf-8?B?cHM3REZENnVWOE9NRlQ5N0k4UlYxekhKUlRDczJMQXNRUHJFTTNjMXBoNko3?=
 =?utf-8?B?N0VNclZMTklFc3p0bE1BNGRYNXcwQ2ppTTBKMXR4b3hPQkVDdGdIbEpBQVJr?=
 =?utf-8?B?S3hUR2VXT0JpRzllYTB2NXpRYjVUU0R3NHI4SEJER0FPUWtPYjZmb0hXL2di?=
 =?utf-8?B?SzdndkFJR2N3VGFReUVmVHc3MTFzcjJKaTMwNFNnNVdsbUF1RkVHVEFsQ0JU?=
 =?utf-8?B?M0x0eGt6UWVmTWNlaytndVVLb2FCb1daU2JkR0h6VnJOTmVGRWVlYzRRR3dw?=
 =?utf-8?B?UnF1TFlJbzNLK05xZ21hKzJSYktrUDQ4TWdLcXpYbm5aSmNkdDVEMUJON1E0?=
 =?utf-8?B?Y3JTaUJta2svZHR1Wkk2TEdZamhaS2I2M3p0dkFJaFVydmt5cjNOcEtpWDlQ?=
 =?utf-8?B?alh1cWZlZm5zMVR2clc4VlhHMnM0MWZwNjJXeE12dVF5dmxhdndzbzVaSUxv?=
 =?utf-8?B?aW9yTkZoYStsb3ZBSHFOc2d6eDg4b0JCRmFjSXI2cDQ5bkkra0E5dDVLU2Nq?=
 =?utf-8?B?dTZvd1pIaWpyWUtucERQK1huMDdzZEx6b082bVpldHZzM2NvcVdpYUxYQ3RI?=
 =?utf-8?B?czM0cTNhVkVPUGc2TmNNSGg4cWZDbGZOMnlrWGs3a0FXRWErSlFnVzgzRUl5?=
 =?utf-8?B?b0RPQlNuS1ZqdUY4SThTMGk2bFdJUHVaWExQYUliN2IzdGYzdjdib3NOOEVn?=
 =?utf-8?B?SEo5SmlSSjUxL0JTVHQrRjc5ODNVbWc2NkNYOExldUZqNnI1cTF0VGZzdHRE?=
 =?utf-8?B?MEYxeUhCVHJoRis1bW5sR0h5SThMUE00bFZGN3ZIeW5aZkZHWnpkeWFEN1JF?=
 =?utf-8?B?dEJ3WG1wZ0xnZnJvbE56T01id2s0am5xZVplNU80UjZ3OWdOMlV6RC9EbWth?=
 =?utf-8?B?aXgxOTliTU1vMDRZR2tOLzlBaCtGYUZaSndsdGNac2lRck5xdFlPbFI1M0pq?=
 =?utf-8?B?NHY0V1ZJY3dhVzQvcDYyOVVRRnkzaUR0cWV2VUNRWjdYSjZOVldhbjNyK1F6?=
 =?utf-8?B?NzFURnhBajhSelRBTHlBbENTVms2ZzNSaUgzNFlqdXUyVTFhTmFkNWxGeHgr?=
 =?utf-8?B?R0xFenF0UzlmbmJjL2Y3WTZlcHdyZ1pYOWpPblNYZjBNU09Ua1JuYWpNSnJ0?=
 =?utf-8?B?QmF0aTZJMThtdHhWS0tZTWh5QWtmZXE2TzhWcThGeGc5UC90eFgyM0pWYUZk?=
 =?utf-8?B?OTdWL0pqVjUzVFoxTE5IMi9zTzVKRXFvSmg2TG04Z1E0RXZnaGdUaGN3OVY4?=
 =?utf-8?B?OVU3NmNEQ01SWFpxK1ZYUFBnbG0wdnh0d28wb3Rpd0Z2c3BZeDV6TXNMdzJ1?=
 =?utf-8?B?TGJrd0JCSUJPa3dLUFhSdW5yemVobEhUY3FsQUYrMWZDdzNyM0tadGR1U25D?=
 =?utf-8?B?ZGtuS0poNjdLcDc1QjVweDZGL245Mlg3U3dpOEkwQUpic3R5YXMyWFRYQVVi?=
 =?utf-8?B?MHpsTVNUb1BvYnZOK04zZkNaQmlvSWJFV3hxRWxKRkdzdWNNdk1WbXkxS2xx?=
 =?utf-8?B?Tkpoa3Rydmo3NGFjblBNS3ZMVVNHZ0tRUkIxcVB5LzF4MXBLMHQ4WklFSnNF?=
 =?utf-8?B?RWF4a0JOVk9KaDFtamxpanhUVUloTFArRXgrQi9qTzg1Ri9qNHdGdm1Sak4w?=
 =?utf-8?B?d0U3ZldGRC9FSUUxUXM3a0dzM2U5SWo5NjBsb2dvcEF5MWoydGlDY2FFTVBr?=
 =?utf-8?B?M2NyVDVHbk5KWU9qOXIzdzZ3NWRSQXIwVUt3VHNHY3JWUS9ZK0EzYzV0alpi?=
 =?utf-8?B?UjhKd0s2c1ZtL24wbjN4NlowUkxWUnlnaFlJZzg4RFdDNmxtdWpFR1BMSWl0?=
 =?utf-8?B?ZGZSVmMxUEgwVXo3ODAzYjRlN3NMSEwzSHRFdVc5WG5PbXh2NUpveDdIay9z?=
 =?utf-8?B?SWdwU2NLbVd2eVlKdnk2RU5PN2p1amxNdGNOTDYwL2hyOU43Sy9MOUdvWUhp?=
 =?utf-8?B?M1J1dVB3ME1aV2NvekdVRHUrbGp2NFlmUnRWYVA0UFg0M2NTMCtsYS81Z21T?=
 =?utf-8?B?cTdvUDhBZXczVmIyWDdvVDJ6bXdDWUxYVS9WSFdMdlk0ajhtL3Fsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E47401514341B4A9A98C634C6FADF5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776081ab-31ce-4fd3-3217-08da3cb213bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 11:47:55.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwuNea9eby6v6EPXtOXVnrruu7xIblSq8dxp0xFLlUcaKiFb9hPiEAVUww6sZfwQmmlyeB2v2kT0Gjm0BfNPseQ1fDWAg+d+ddVM6gz1VJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1915
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDUvMjAyMiAxNToyNiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgYWxsLA0KPiBH
b3QgYSBmZXcgUG9sYXJGaXJlIFNvQyBkZXZpY2UgdHJlZSByZWxhdGVkIGNoYW5nZXMgaGVyZSBm
b3IgNS4xOS4NCg0KSGV5IFBhbG1lciwNCkkga25vdyB5b3UncmUgYnVzeSBldGMgYnV0IEkgaGFk
IGJlZW4gaG9waW5nIHlvdSdkIHRha2UgdGhpcyBmb3INCjUuMTkuIEkga25vdyBpdCdzIGxhdGUs
IHNvIG53IGlmIGl0J3MgdG9vIGxhdGUuDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gRmlyc3Rs
eSwgcGF0Y2hlcyAxICYgMiBvZiB0aGlzIHNlcmllcyBzdXBlcnNlZGUgWzBdICYgYXJlIHVuY2hh
bmdlZA0KPiBjb21wYXJlZCB0byB0aGF0IHN1Ym1pc3Npb24sIGZpZ3VyZWQgaXQgd291bGQganVz
dCBiZSBlYXNpZXIgdG8ga2VlcA0KPiBhbGwgdGhlIGNoYW5nZXMgaW4gb25lIHNlcmllcy4NCj4g
DQo+IEFzIGRpc2N1c3NlZCBvbiBpcmMsIHBhdGNoIDMgcmVtb3ZlcyB0aGUgZHVwbGljYXRlZCAi
bWljcm9jaGlwIiBmcm9tDQo+IHRoZSBkZXZpY2UgdHJlZSBmaWxlcyBzbyB0aGF0IHRoZXkgZm9s
bG93IGEgc29jLWJvYXJkLmR0cyAmIGENCj4gc29jeywtZmFicmljfS5kdHNpIGZvcm1hdC4NCj4g
DQo+IFBhdGNoIDUgbWFrZXMgdGhlIGZhYnJpYyBkdHNpIGJvYXJkIHNwZWNpZmljIGJ5IHJlbmFt
aW5nIHRoZSBmaWxlIHRvDQo+IG1wZnMtaWNpY2xlLWtpdC1mYWJyaWMuZHRzaSAmIGluY2x1ZGlu
ZyBpdCBpbiB0aGUgZHRzIHJhdGhlciB0aGFuDQo+IG1wZnMuZHRzaS4gQWRkaXRpb25hbGx5IHRo
aXMgd2lsbCBhbGxvdyBvdGhlciBib2FyZHMgdG8gZGVmaW5lIHRoZWlyDQo+IG93biByZWZlcmVu
Y2UgZmFicmljIGRlc2lnbi4gQSByZXZpc2lvbiBzcGVjaWZpYyBjb21wYXRpYmxlLCBhZGRlZCBp
bg0KPiBwYXRjaCA0LCBpcyBhZGRlZCB0byB0aGUgZHQgYWxzby4NCj4gDQo+IFRoZSByZW1haW5k
ZXIgb2YgdGhlIHNlcmllcyBhZGRzIGEgYmFyZSBtaW5pbXVtIGRldmljZXRyZWUgZm9yIHRoZQ0K
PiBTdW5kYW5jZSBQb2xhcmJlcnJ5Lg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+IENo
YW5nZXMgc2luY2UgdjQ6DQo+IC0gV2hpdGVzcGFjZSBhbmQgc3RhdHVzIG9yZGVyaW5nIGNoYW5n
ZXMgaW4gdGhlIHBvbGFyYmVycnkgZHQgcG9pbnRlZA0KPiAgICBvdXQgYnkgSGVpa28NCj4gLSBB
IG5ldyBwYXRjaCBmb3Igc2FtZSB3aGl0c3BhY2UgYW5kIHN0YXR1cyBvcmRlciBjaGFuZ2VzLCBi
dXQgYXBwbGllZA0KPiAgICB0byB0aGUgaWNpY2xlIGR0DQo+IC0gQSByZW9yZGVyaW5nIG9mIHRo
ZSBpY2ljbGUgZHQgYWxwaGFiZXRpY2FsbHkgdG8gbWF0Y2ggdGhlIGZvcm1hdHRpbmcNCj4gICAg
b2YgdGhlIHBvbGFyYmVycnkgZHQNCj4gDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0gcmVtb3Zl
IGFuIGV4dHJhIGxpbmUgb2Ygd3NoaXRlc3BhY2UgYWRkZWQgdG8gZHQtYmluZGluZw0KPiAtIHJl
bW92ZSB1bm5lZWRlZCAib2theSIgc3RhdHVzICYgc29ydCBzdGF0dXMgdG8gbm9kZSBlbmQNCj4g
LSBzb3J0IHBvbGFyYmVycnkgZHRzIGVudHJpZXMgaW4gfmFscGhhYmV0aWNhbCBvcmRlcg0KPiAt
IGFkZCBhIGNvbW1lbnQgZXhwbGFpbmluZyB3aHkgdGhlIHNlY29uZCBtYWMgKG1hYzApIGlzIGRp
c2FibGVkIG9uDQo+ICAgIHBvbGFyYmVycnkNCj4gDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IC0g
bWFrZSAsaWNpY2xlLXJlZmVyZW5jZSBjb21wYXRpYmxlIHdpdGggLG1wZnMgJiBwdXQgaXQgaW5z
aWRlIHRoZSBlbnVtDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtIGZpeGVkIHdoaXRlc3Bh
Y2UgcHJvYmxlbXMgaW4gdGhlIHBvbGFyYmVycnkgZHRzDQo+IC0gZGlzYWJsZWQgbWFjMCBmb3Ig
dGhlIHBvbGFyYmVycnkgYXMgaXRzIHBvcnQgaXMgb24gdGhlIG9wdGlvbmFsDQo+ICAgIGNhcnJp
ZXIgYm9hcmQNCj4gDQo+IENvbm9yIERvb2xleSAoMTApOg0KPiAgICByaXNjdjogZHRzOiBtaWNy
b2NoaXA6IHJlbW92ZSBpY2ljbGUgbWVtb3J5IGNsb2Nrcw0KPiAgICByaXNjdjogZHRzOiBtaWNy
b2NoaXA6IG1vdmUgc3lzY3RybHIgb3V0IG9mIHNvYyBidXMNCj4gICAgcmlzY3Y6IGR0czogbWlj
cm9jaGlwOiByZW1vdmUgc29jIHZlbmRvciBmcm9tIGZpbGVuYW1lcw0KPiAgICBkdC1iaW5kaW5n
czogcmlzY3Y6IG1pY3JvY2hpcDogZG9jdW1lbnQgaWNpY2xlIHJlZmVyZW5jZSBkZXNpZ24NCj4g
ICAgcmlzY3Y6IGR0czogbWljcm9jaGlwOiBtYWtlIHRoZSBmYWJyaWMgZHRzaSBib2FyZCBzcGVj
aWZpYw0KPiAgICBkdC1iaW5kaW5nczogdmVuZG9yLXByZWZpeGVzOiBhZGQgU3VuZGFuY2UgRFNQ
DQo+ICAgIGR0LWJpbmRpbmdzOiByaXNjdjogbWljcm9jaGlwOiBhZGQgcG9sYXJiZXJyeSBjb21w
YXRpYmxlIHN0cmluZw0KPiAgICByaXNjdjogZHRzOiBtaWNyb2NoaXA6IGFkZCB0aGUgc3VuZGFu
Y2UgcG9sYXJiZXJyeQ0KPiAgICByaXNjdjogbWljcm9jaGlwOiBpY2ljbGU6IHJlYWRhYmlsaXR5
IGZpeGVzDQo+ICAgIHJpc2N2OiBkdHM6IGljaWNsZTogc29ydCBub2RlcyBhbHBoYWJldGljYWxs
eQ0KPiANCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9taWNyb2NoaXAueWFtbCAg
fCAgIDIgKw0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1s
ICB8ICAgMiArDQo+ICAgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvTWFrZWZpbGUgICAg
ICAgIHwgICAzICstDQo+ICAgLi4uYWJyaWMuZHRzaSA9PiBtcGZzLWljaWNsZS1raXQtZmFicmlj
LmR0c2l9IHwgICAyICsNCj4gICAuLi5wZnMtaWNpY2xlLWtpdC5kdHMgPT4gbXBmcy1pY2ljbGUt
a2l0LmR0c30gfCAxMDUgKysrKysrKysrLS0tLS0tLS0tDQo+ICAgLi4uL2R0cy9taWNyb2NoaXAv
bXBmcy1wb2xhcmJlcnJ5LWZhYnJpYy5kdHNpIHwgIDE2ICsrKw0KPiAgIC4uLi9ib290L2R0cy9t
aWNyb2NoaXAvbXBmcy1wb2xhcmJlcnJ5LmR0cyAgICB8ICA5OSArKysrKysrKysrKysrKysrKw0K
PiAgIC4uLi97bWljcm9jaGlwLW1wZnMuZHRzaSA9PiBtcGZzLmR0c2l9ICAgICAgICB8ICAxMSAr
LQ0KPiAgIDggZmlsZXMgY2hhbmdlZCwgMTgxIGluc2VydGlvbnMoKyksIDU5IGRlbGV0aW9ucygt
KQ0KPiAgIHJlbmFtZSBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC97bWljcm9jaGlwLW1w
ZnMtZmFicmljLmR0c2kgPT4gbXBmcy1pY2ljbGUta2l0LWZhYnJpYy5kdHNpfSAoOTElKQ0KPiAg
IHJlbmFtZSBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC97bWljcm9jaGlwLW1wZnMtaWNp
Y2xlLWtpdC5kdHMgPT4gbXBmcy1pY2ljbGUta2l0LmR0c30gKDk1JSkNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1wb2xhcmJlcnJ5LWZh
YnJpYy5kdHNpDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWlj
cm9jaGlwL21wZnMtcG9sYXJiZXJyeS5kdHMNCj4gICByZW5hbWUgYXJjaC9yaXNjdi9ib290L2R0
cy9taWNyb2NoaXAve21pY3JvY2hpcC1tcGZzLmR0c2kgPT4gbXBmcy5kdHNpfSAoOTglKQ0KPiAN
Cg0K
