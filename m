Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311FA5AA806
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiIBG1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:27:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746DA50E5;
        Thu,  1 Sep 2022 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662100058; x=1693636058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fy50VC0UYAOYZ0ZcUH7vIbYvhcpjWQp/t5TQoDM2Uqo=;
  b=EXaEltW4H7shX/L9ZjQ6sYrNuYGAB+aFtUZNDhdW2MMJDJPUoygyPZGp
   5RxTgtBf9dx2QGDSWih+6e9+wK7qs04n2rpw7PF/Oj9Tdt0mT3A88wua9
   FTm07WzX0+Ci58UrOISdutJSP8VI1LlsACvlZ6ZAHhQ7QmofS/GjAeaZC
   z1eznYM0zibrtz1PJdyl86IayVbedqI88i9cast83vbgJgOtcqaLLn9ui
   NCr8LxT4MMXCAUivkvVgKlvpOAgO/QC+yi7l2hyOneTkW29v1mHMLfBpy
   avAvrHCv/y6IbEjAvLwxGMluIOkdzj+27+jm7JGfPYBdvnhqidFRpY+up
   w==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="172086447"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 23:27:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 23:27:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 23:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGMKdi3No8LMCghsSESHGIzC97+w2HphKpvDsyFrMtCYRgyBycSSL53mRDOsKNMHEGiJ2ZiWFP1dGePHSdM7lcsuGBgQka6sKUkVDo6iibt+Blhbv8uI4ElirYV5M1xXjXkL/ypReA0H2FbSPRMaje03xsxdes77a/Cdt4UGoqG8wiycuqSkOZ/Cm4Azrvu0NzE2TOXD20mbij2NwA/qT+3KhV/rMWk1rkS3k8uM6XfhEOiz5pszCrszRnPgQj4o+q2HtLa3/EDFudn7W2msaPtAQQQyP+dztMqx32N6bv9s0bPx9gdsVqpGnlU/OHKXKx/65Qd/eX5UJr6lz+Xf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy50VC0UYAOYZ0ZcUH7vIbYvhcpjWQp/t5TQoDM2Uqo=;
 b=nLfTGNT60QjIzOEGPZybk8KQQCU3MLO7HvkCsReQTo7KaOMIIERndEfWfKaOuVzCcBVOO1Lgj85smPrTaHlL+1yoF7JsoNxztRcNfQksdPy04pfK+yWgyi2r0M0ycfIkpGzMlEqTEU489VA+IFKUHz6a75KBDiPVoY7hBQulKD8nmV2lO2pdzRn9vmT8iTDg5joS7+nCqOEZ7OV3YkiwOz8uohoShq9mJNvE3tvcI604ryYIhU+n4q8upC8yMLVhpfpiB3Lr5r3BdRMPc41GT5KWfL6E7fWhvVha8OX57YwZGgvU4myr88vpor026t2lYjIoYUV4uYQzhLvDd03e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy50VC0UYAOYZ0ZcUH7vIbYvhcpjWQp/t5TQoDM2Uqo=;
 b=NilMdPyXmH1Qhwf6Ketv2lu0xm/RUcefTQGEXwkZFcWQVFuQbFMVkrt7/czB6E+NkeyBxcuT2nj3MDucJAVuRFkA9DML52W3024KF+J5gd30i3G5jWdbWBS+WC2wzbI7MkAwcmZnKlFa9eerBWOiWNoAg9Tp5lK6lTjTcyDRQEw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 06:27:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 06:27:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <cristian.ciocaltea@collabora.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <michael.zhu@starfivetech.com>, <drew@beagleboard.org>,
        <kernel@esmil.dk>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 0/3] Enable initial support for StarFive VisionFive V1 SBC
Thread-Topic: [PATCH 0/3] Enable initial support for StarFive VisionFive V1
 SBC
Thread-Index: AQHYvlRcpKoVIbqogkSJP0ZrelqTMq3LrWOA
Date:   Fri, 2 Sep 2022 06:27:24 +0000
Message-ID: <04151f8b-5722-b5a0-a4ab-4958f55b8dec@microchip.com>
References: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2abe7821-481a-497a-f784-08da8cac3319
x-ms-traffictypediagnostic: MW4PR11MB7101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1qUtdykOMFrcSIGyO3jsvSPN2yfHlZRgO9T1145N2twG7nkddmJpJTzVg89ynfquHJhxJ7FaEOCpGU0tBJ2WRJ6tBitN0+veAcWLcP+l+pUPq72o2mEu1lxsAKYlM0AlQWhNDUp9BFuMT4rAxzzi6VIYxqHaj20/eBpBRh03vI13HfPpau2H4goQDr6cgedfIh4cGcc6d2slmEmq/I3dhwvIbCYWqLugATxTPvW16dgoNss4WJJ8ML/loYUvH6Kndd3CVgLffnS8EJ3TVYHB/pRCswj3myG5UfI+zbqio6yqWUMhXRGq4R09p/oNDMgWWsZsV0Wr5Y4k++LriO8dOOiys+sQb4a88HSqLmUS/oJvbF/BDnQ+3/2iOKjy3M/otdYvjIkyOwH/x+RumF+aAAjgsgAzZPr1dO2Yr//sF5GrZ4v50ShvzvlDRL7V0xy3NZxIyxrnZ2wtyPS5Lx5QcIAGC36L1AlTE6MGjw9tQCOFyWAas+/qIM5kIsRb706yFpdKTUOtYXODd2FJL3ggKW0wt1nr0+oE6nsUplogAAxX4mYU6Y9h8WE3AWyNg2ZOS9ABL4haBf/hKrhK9KDokT60PjayEhWovikcQj2wR5qyadC3LR+qSybEFdQSvq5Dy+XUDEWhKrGFJ3254kPKTl3czUMDpnjCIQ2+ooqd4pKNCdLJ7V/UQDfCTMRIiY8KC9CP1PjKI9hpLo3Ojmg17+O1Kk3J2koXVYktlVwz98nroc0Crl6XtAbSfK+pW3dIrecieA6e97J7aW22w2gFfG4vDL3gUHMMOPWumK7A2a31D+lchmqgtkiiQDtWpw2rtcAXSV3wkCpH9P+Ewk1BUI9nI70ql0QVPxPXE21OQIgMSQhXpWz0/lDTY6V/59jAyMOKBtbpFyheNonRUuNdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39860400002)(376002)(478600001)(26005)(6512007)(53546011)(71200400001)(966005)(6486002)(41300700001)(83380400001)(2616005)(186003)(8936002)(5660300002)(7416002)(6506007)(110136005)(2906002)(54906003)(316002)(66446008)(64756008)(8676002)(66476007)(4326008)(66556008)(66946007)(76116006)(91956017)(38070700005)(86362001)(31696002)(36756003)(31686004)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkVWNTdEekNSN25hSjU0a1ZHN0hJMk1CWmpuR2NxQmZTTU9CSHRGczhyVU1v?=
 =?utf-8?B?Y0RuWGEzakh2N29HMDYvRTBtM1dMZ2FMZFdia1kwbXovNWVNQW0rRE1kVGc4?=
 =?utf-8?B?cG82UGJWdkxhSzZzVUh3UDM2OW1pYVJkU3BaWU1kcUxXR0lXalNDbUdHNGx5?=
 =?utf-8?B?UHNham01dGJka3NyVXJIdFhmR0tzNzE2Q3J3TU9jd0djRHFJU3hiRXlOK0Jy?=
 =?utf-8?B?UUc1blRkL1VUMVU2ZVhycnprNzIxYll0VlJ6eXR5R1A4YWZCYzRrZUlPYUJ6?=
 =?utf-8?B?RVpEcjZWWkpRa0ZXM2hUOGdoR1B5cE5mUGdvODJLdER2ZkYxaE15Tkc1K1RY?=
 =?utf-8?B?Z2QwR0FVV2dSZkVsa0dKTVpvVmRrendoSFNramt2RzNyUVhxRDltZ1Mvckph?=
 =?utf-8?B?Vk03Z0ZvZkpSWXo5LzgveWl0VkRTbnBzTXZKckZ3a0JoRk9wTmtldkRxNkEr?=
 =?utf-8?B?d0xrbmFKTktoQ3RzaFIyYWFYTWh3TnBiNVpoU2Zhd1F3V3grOTVQVzFXcW1o?=
 =?utf-8?B?QUl4dHFmSitEOGVCWDRXa083eEhqT1UwS25KVWxiQnVMOVhpK1NWdThLM2Q4?=
 =?utf-8?B?VmVreGd6SWlYNURoQjdtaUxQdjVyTjh2WWpQZHFZaHhtS3pSdlZLKzVDZVcw?=
 =?utf-8?B?NEMyQTNaYmRIRkk1NlBrSXlwTkxoMkJicFQ3NFNoZDd1MEJOYm43VkZMbGo5?=
 =?utf-8?B?cmhCUTdQN1ppU0w0WmpHSEoyRFRPTjRjVE9YSkgxWGd2aDNWbDRPUlEyQUZz?=
 =?utf-8?B?cHRXRmh5VEhYclV0c1hGdlMxMm5kMkI2K2tmRFh5TVRGcWhXN0JBK1JVc0Vw?=
 =?utf-8?B?RUN4dUN2N3ZJNllwRWl5N2w5Y3VrR1dPYnE2aUtFK1dDZVRDYUxoVDBrRFhI?=
 =?utf-8?B?elhUck9MRVEwakh3cnU3Sy9xT2d4ZUxQNEtSN2lCdjVSVWJjZ215cjRCZnk0?=
 =?utf-8?B?YTNHVHV5WWpXTnhYQlF1UlJBUCtlSnZBbytJU1BCNE1EeUpWaEJPRnY4YVlF?=
 =?utf-8?B?ajlLdDk4K0M0VU5HTGdRUDNNanppWFlMNk1kMjlJK01ZeU9MK0lFc0UwNVFx?=
 =?utf-8?B?VWFuSXZVQTE3QmlrQVdUWS95WFBYYTJ5Q3BidFdWMDIrQ2VLVmQwQmR0VXh0?=
 =?utf-8?B?NFZNd2NKUlJRbXVsZWx4WWt5Z01TN29DNzhlc1hweFBhK3FaR2k4RjhDcEV1?=
 =?utf-8?B?M1o0Z1hWRnBxVW16Ulc1YWVWMVMzaitMaVhIV2xxQlVGSDZHZDlVMzFEL3ln?=
 =?utf-8?B?UTZVTVpPSTFiOWlDOFZLRjFaUUhBamoxNmFWTVlCUlpYZlVYSzl6Y3YyVFc3?=
 =?utf-8?B?c2x5UWprMlo2THQ0eU12OE1LaS9hdkxyZ01kbSt2Zm5jckJlOU9BRllYalk3?=
 =?utf-8?B?NEZwUFZIRkREY1lzYjJ5TGNxTU1QN2hOZjY5Q2NiYjhzWk5aMWtWNjhacnd1?=
 =?utf-8?B?ZDRtQlhVOXB4aFJnaDNxN0lpTWJFMDFOWkJ2R3krbnJSR0RTMDJyaFo2dTRo?=
 =?utf-8?B?YW1hSmRiblJZZ2JpQ2dRcmJqeTdReFM2UXEvOEREWnEzZ0xZZXhmU0tHZVNV?=
 =?utf-8?B?cS93QUtyM3B6WWdBNUFWSWtIa1JhMEZUblNGc0RnSUozTTFLR3VVSjZMbXV6?=
 =?utf-8?B?RFFGbEsvWUh3Z2dEMG81c0g0NzNjZlZCU05vZmZjQWtwdFZXYlRNbWhCZW51?=
 =?utf-8?B?VjZSYVpGOEJZaUJiZ09FSHJXMUFzY0VmNkFsNWdLZXlhZTdUK0xWLzNoOWhI?=
 =?utf-8?B?cWpXeTNGWWpFMHcvRmxWeW5QNzdzMG0yMGRjUytIQzA2SnJWTUwzbUt3cFBt?=
 =?utf-8?B?d20zUG1OVWdveUdaTTRiNmV4UjVkbEdUK3B2RzRsOTR6K1B6M1RxZEkwYmVy?=
 =?utf-8?B?eTRVYTc3OEZ2SmxvZWZRenZaRmQvOFBhS1RSamR4Z1lSL1l0NkJ3OG81aGhD?=
 =?utf-8?B?dFBkVGN1b2tLaVRYV0FqWElDaDZWdHEzSWwwSWxwYi91L3RZWUxBN3AzSHR3?=
 =?utf-8?B?YVd3SFlLM3RxZEhFdmdJNUt4VGN5Z3lsaW5xWTgwdTVwRHVFdEYxeTY1TlYy?=
 =?utf-8?B?TTBrTXdIMzVmaCtPZEhUTGJJUXU4ajA1SGZwL1UwQlJENGtOVGJjSWZ0ZERn?=
 =?utf-8?Q?FYqHbQ5bIw8RHVuhUCXkwzP6f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F7748178F3A3540AFB1CFC6A36FA33E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abe7821-481a-497a-f784-08da8cac3319
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 06:27:24.5637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TojLm9jXe71CKYURPelQSNJrhGhI3HkiC3qysroq4bSjDzZraWe+y8kt8S0cYEWjUKgVrZQAe6u+MnckX474UBZ9wLs9TNC00K/+ZN3CdTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDkvMjAyMiAyMzo0MiwgQ3Jpc3RpYW4gQ2lvY2FsdGVhIHdyb3RlOg0KPiBbWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGNyaXN0aWFuLmNpb2NhbHRlYUBjb2xsYWJvcmEuY29t
LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPiANCj4gVGhlIFN0YXJGaXZlIFZpc2lvbkZpdmUgVjEgU0JDIFsxXSBpcyBzaW1p
bGFyIHdpdGggdGhlIGFscmVhZHkgc3VwcG9ydGVkDQo+IEJlYWdsZVYgU3RhcmxpZ2h0IEJldGEg
Ym9hcmQsIGJvdGggYmVpbmcgYmFzZWQgb24gdGhlIFN0YXJGaXZlIEpINzEwMCBTb0MuDQo+IA0K
PiBJbiBhZGRpdGlvbiB0byBkb2N1bWVudGluZyB0aGUgbmVjZXNzYXJ5IGNvbXBhdGlibGVzLCB0
aGlzIHBhdGNoIHNlcmllcw0KPiBtb3ZlcyBtb3N0IG9mIHRoZSBjb250ZW50IGZyb20gamg3MTAw
LWJlYWdsZXYtc3RhcmxpZ2h0LmR0cyB0byBhIG5ldyBmaWxlDQo+IGpoNzEwMC1jb21tb24uZHRz
aSwgdG8gYmUgc2hhcmVkIGJldHdlZW4gdGhlIHR3byBib2FyZHMuDQo+IA0KPiBObyBvdGhlciBj
aGFuZ2VzIGFyZSByZXF1aXJlZCBpbiBvcmRlciB0byBzdWNjZXNzZnVsbHkgYm9vdCB0aGUgYm9h
cmQuDQoNCkdhdmUgaXQgYSBnbyB0aGlzIG1vcm5pbmcsIGR0cyBzdHVmZiBpdHNlbGYgbG9va3Mg
Z29vZCB0byBtZS4gTm8gbmV3DQp3YXJuaW5ncywgYWx0aG91Z2ggdGhhdCdzIHRvIGJlIGV4cGVj
dGVkLCAmIGJvb3RzIGZpbmUuDQoNCkkga25vdyB0aGF0IG1vc3Qgam43MTAwIHN0dWZmIGlzIG5v
dCByZWFsbHkgd2FudGVkIHVwc3RyZWFtLCBidXQgSSdkDQpzYXkgdGhhdCB0aGUgbWluaW1hbCB2
aXNpb241IGR0cyBpcyBhbiBleGNlcHRpb24gdG8gdGhhdCwgc28gd2l0aCB0aGUNCm9uZSBjb21t
ZW50IG9uIHBhdGNoIDEgcmVzb2x2ZWQ6DQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gWzFd
IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGFyZml2ZS10ZWNoL1Zpc2lvbkZpdmUNCj4gDQo+IENyaXN0
aWFuIENpb2NhbHRlYSAoMyk6DQo+ICAgIGR0LWJpbmRpbmdzOiByaXNjdjogc3RhcmZpdmU6IEFk
ZCBTdGFyRml2ZSBWaXNpb25GaXZlIFYxIGJvYXJkDQo+ICAgIHJpc2N2OiBkdHM6IHN0YXJmaXZl
OiBBZGQgY29tbW9uIERUIGZvciBKSDcxMDAgYmFzZWQgYm9hcmRzDQo+ICAgIHJpc2N2OiBkdHM6
IHN0YXJmaXZlOiBBZGQgU3RhckZpdmUgVmlzaW9uRml2ZSBWMSBkZXZpY2UgdHJlZQ0KPiANCj4g
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdGFyZml2ZS55YW1sICAgfCAgIDMgKw0K
PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvTWFrZWZpbGUgICAgICAgICB8ICAgMiAr
LQ0KPiAgIC4uLi9kdHMvc3RhcmZpdmUvamg3MTAwLWJlYWdsZXYtc3RhcmxpZ2h0LmR0cyB8IDE1
MyArLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIC4uLi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAtY29t
bW9uLmR0c2kgICAgICB8IDE2MSArKysrKysrKysrKysrKysrKysNCj4gICAuLi4vamg3MTAwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtdjEuZHRzICAgICAgICAgfCAgMjAgKysrDQo+ICAgNSBmaWxlcyBj
aGFuZ2VkLCAxODYgaW5zZXJ0aW9ucygrKSwgMTUzIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC1jb21tb24uZHRz
aQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
NzEwMC1zdGFyZml2ZS12aXNpb25maXZlLXYxLmR0cw0KPiANCj4gLS0NCj4gMi4zNy4yDQo+IA0K
PiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
bGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1y
aXNjdg0KDQo=
