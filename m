Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D75B0A35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIGQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiIGQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:36:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11027F139
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662568559; x=1694104559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tvI2zzPjltIDW6QUaT0yJE8itGLsQb+U9kYMWRRGqyI=;
  b=Z213rlzS6+VU4WtIFDGZ1miYIjxuE5yfb4jey9uDSuxNeXA2rmdBxbbC
   N35JhMY9xJqdCwvgOOgy2expSOo7B1GkRJnSlkKU4jnS9DH6dNlQ5/XBv
   2khKU63jSgrxrUG89w1c70Ny8+UWjuEeRWgQIg6BMkRSQFsmxfklwY3U/
   2ugzAxPxcmIftRL06y/GYfdItI/rVcqc+ebfqcqah+/OgXaJlpsMnmuXg
   jMjl2N8LSVzNgScLf4CiF5SfoKzd/mLfS2K3BXWoZov6zkbFQorGGAqS+
   Sh0+VlSRZ1yY8tCcv0qB2X1tMR0WpoZsi8azyoc8I/qFrYRAl20C6D7Y6
   g==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="176049535"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 09:35:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 09:35:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 09:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLXtAMUmKbNDy4dHWa+PLp7B3jJ22hiftV1eQsmWIpGQORV+0TXN83ZTRMxRKYTB3kcIF+bJRzP88qDIv2qhZ+3N1mojmoXoQY3T70Vsw8F0U4HQgZsuiPRPf81FOXFe0i12Uxc/6tkJqMkZEq5cnK/sDssk5USrnNm/s785cV4mTkpNReOY43ZOCoqhqLy3xvBjxZKCynL/4BWCM5RkKrXfrttmiinNtpFJyd/wJicwYrfntudGV3GND4wz+bVp36yVvYs57dAZaXqnMP05JMJqf4y4w7NUC6hMPzmRcIKFYWoU5epBkMX9hGyIlSPsuWqycCl3TsAZy4YosPwJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvI2zzPjltIDW6QUaT0yJE8itGLsQb+U9kYMWRRGqyI=;
 b=cSriqCQ1Vi1LKwgcgx14FmBXya/Ae55pBBQlWP6rJgPiLWlLYYXpEBR222KPcAgTj6Icz0U7/O+J9R1Lxe0PAQas4sxM3xOFFjbhVKrKSTYhmWsiySCNE5YGrTjF1y2/hQtQNoom8Nv0g+Q9+RIUgVElAeVb2go6GvvLyGYSLqLig5BT8ZWvPrOJP70PqlzQJguUhMRXnYG10Ug1II6gIXhQjvnVTE1LDowtbvd92xWKrMPmqnS8vp8NCeX0U2uREAr20v7t5e/5LZToqiknym6Ue+pcjK3xdTJoJNeE+siIvriezzPSnewORWTCxg9+RXkyfauHO3FiyqGGS982Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvI2zzPjltIDW6QUaT0yJE8itGLsQb+U9kYMWRRGqyI=;
 b=iVu/XtNgjd3n3eIPftT3uNRB/t/g3vIHCsJ/Ilx7krV3xLIhedUrrywwURqKPmNmJ/uahkI+eDfXW4dBeyLL60Imc7t72vi001pzor2TOXtiaR3UlIc5x5HuZMJI7mSmhtHYYZcKCk3XIZY0nocy7OlWmeptWDNvVZLlP1g/HRA=
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2862.namprd11.prod.outlook.com (2603:10b6:805:5b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Wed, 7 Sep
 2022 16:35:50 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220%5]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 16:35:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <samuel@sholland.org>, <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH] riscv: make t-head erratas depend on MMU
Thread-Topic: [PATCH] riscv: make t-head erratas depend on MMU
Thread-Index: AQHYwtGjWFgnBf3Kq0easQ/4mXN9Fa3UKiKA
Date:   Wed, 7 Sep 2022 16:35:50 +0000
Message-ID: <861b6cf0-c120-212f-43d8-3431551fe871@microchip.com>
References: <20220907154932.2858518-1-heiko@sntech.de>
In-Reply-To: <20220907154932.2858518-1-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3633ea50-a297-44f7-358a-08da90ef063b
x-ms-traffictypediagnostic: SN6PR11MB2862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AExSxhJkJZ/Edd0g+siWTe4iRaXDx+DYqvS+ZQP/3gQ4Urj6WTOATFhTc0kl7srg7bmuxW3xUbqSHzXKEtnQcuEjwSatnz9sJ/TNz4FxAZUuYAF9cOC4/LSO8fl42UQVlVsQMNPqk5Ola/ZIVUYZeSj5anoCvWMKYnY4o3STFYCHk3ClSPIvEbi8GKybxKjIHFS0XWXHBcyzuMRzAmNiterq/asVupb6c6OsIpscXTuYlv17yvULePhwa23FxxL2sOd59ZeJ1+WW7mRiGCkfrRKIQsD490W0mn9JSNHa1cTcLUjHwCQwGbG1c/nuloFkqIKgmumPM8/tc8cNn4RbXfvGUs92qNMx9P3582H9+MZvCxuP89Hp9S3apwyLZ2hMi8lTk/dqz8+jhNQrGpBQvSKLAjub84BrM3p+g7ItnTix06Nx6hJUk3xKsbuOytNQBKSVn5eVi61wLUUuIoBQ9cjngYi//44xGMe3GISi7gcztF7RXmuT+Z0i0BBIM/7FyxE2DAmPXosGlH0og9VE8BkQJTXG+PAKZn7IoaEL0R5TfDoDCiMDmnVx7S9LoeZZqMHJZhw5vbAvuOh/F1pJHXztqcFm9wzLSdjbNLSW7AexxdMwmbGOdnNI9Dpi9o5tPrQ8b5XzHvHPriyamZVpbdpQpGyV2kWqsjo3+7NcgLGEpW3HFdRqT12wqN/o52/welHGHNVnJYrkNNDD4m7disD24xgplY2AwCkIVtF3CLuuJ15DVcu36h0dRkkkIbw+GehpD1gYD/xmV1yZnOYY++cf2gjR+1ROh4xF6//27SeSGb+c2+7+zXj/Tp8HL9m27b1Lny17S0591IlIT9dKaRwxvW7fI93URgGXMH3z1GTYVj7yUTLXVlhZlwRbaEbaw2EElYecXGVX9Dn7TZfmiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(396003)(136003)(346002)(39860400002)(966005)(4326008)(86362001)(66946007)(64756008)(71200400001)(76116006)(66476007)(8676002)(91956017)(316002)(110136005)(478600001)(5660300002)(26005)(41300700001)(6512007)(31686004)(6486002)(53546011)(6506007)(54906003)(66556008)(66446008)(38070700005)(31696002)(2906002)(2616005)(8936002)(36756003)(38100700002)(186003)(83380400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEYxcmhQaVN2ZEJMZUpDUnZmZ0QzM2RyVmg3aVYyNzc2bHN5OXNyS2YrME9U?=
 =?utf-8?B?S1Y0NEFUZnowRzlEZkpYSy9oaDRhNWtRY1JjVVp4UEZiSTdkTy9EZHUwcUY2?=
 =?utf-8?B?aG4zYVdyWnhaN1lwTlNOVGhZZUZFbmhOMzJpZGh4VXdpQlU2TlJ6ZkVrTHp6?=
 =?utf-8?B?TVNxcmo2V2tUVHJ3a1VEbURLUkRKZk0zaVNhTGtRT1NEcGdsQ09Oa09OQUZu?=
 =?utf-8?B?RFNpc0NHc2pES01EaVBSSjB3VkVRRzdjblI2cE9MbGFNbFhRaCtUNFJ1aURM?=
 =?utf-8?B?clE3bnFtczVpMHN2RTJ5dmw4QWpuSFg3cUZyQjdraUxINmxPKzhiS081dUVR?=
 =?utf-8?B?ekdrazNaNzhhU21Kakp6ckkxOGxqSTF2K1htV09pczgxQytXTHRocmdJQ09L?=
 =?utf-8?B?U3BFT3lkL05NZmFhbFJGTDdMSWhkWHZvQ0ZrenhaWVE2OXhjbk1iUDYwK214?=
 =?utf-8?B?ZGZ2VTFUaFQ1dFpBOEl1blNvbTRDZ0E4ZGtMSUNFb25nZmluT29CY1NqQlp5?=
 =?utf-8?B?TmdSMTJhS1BUbmRrUys5dEwxNmYxRVZhR1BmOUVmVTdvcml3czZRek1GYlBB?=
 =?utf-8?B?N1FRK1dhVUlOYmJWeStyZFdLZmFZTDJ3dWlLSTQ0MG1waXdRU0pvdFBOQVV0?=
 =?utf-8?B?T2JLdExmTEUvZTRlblZlbGdqbTBORTBJRkRFWUxhN05md3laY0RUdFdyNnMr?=
 =?utf-8?B?VDZ4SHBWT0d0K1NDdzIwZGM5YVRCSS9FcGpiRWlyNHNnNkt0Y2dxR3JXYmxs?=
 =?utf-8?B?amdYeXB2Z2ErSklhUUd1anhsbjY2T3BuY0ZIRTZpU0pENmZUOFZJZWoram85?=
 =?utf-8?B?emx2UDZ1VmtJNUtTZFFrcTJYZ0pudWJtWlp1cHJDR2hYcGh2azVYY3IzTGho?=
 =?utf-8?B?UlBHamJ3YTl4R3Z0blNGL0FiNFpPUHIzeUpQbXJhZ25WY2p2VkFQQ3owZElI?=
 =?utf-8?B?dll2VFd5QW9PYnBnaVJDMzVvWjNCaE0rbWdzWEZGYnlsejMwczZlelp6ZWx6?=
 =?utf-8?B?UXIvYm9iVm1rMGxtS0pXSmlnTTlhSFp1N3ZqTmxUZlRBZEhydnQrSCtlY3Ns?=
 =?utf-8?B?UkthVXRpVGJndm1KTHZKakpjaktFK24xaml3TmRRRXZBUG5yVE5xMk9mZHh6?=
 =?utf-8?B?WUJGb0wrTXBEcjJvbTFValYyZ2JZckJITW9ZMTV5Y1orTlpQSUJzMTEvdENC?=
 =?utf-8?B?eUVreHRtUE9VVTU4QncwcmlkYURDWUc3RC9KUys2YnMyRTZHL2lkQXFQS2Jp?=
 =?utf-8?B?Mmk3NWZONWdBWjg3Y3E4UzVaWGREUUtQWjRYNHZseGpWTVpDUmFCYk1UY1A5?=
 =?utf-8?B?NjFhbEtVWUorWmRGMEdkckFaN0N0QnNONU9NSm90bUFpL1VMeEErMmJDQTRB?=
 =?utf-8?B?QmlNUXBjMjdFTHdFTVozeHNpZm5GaWo0emovSjRVVHdwamErRGkvMTFCaElM?=
 =?utf-8?B?d2RWVjZoT01acW1aeC9RZG1OSmlxR3lOYUZqc2tNeEtkbndPSWJzQUx3UXRR?=
 =?utf-8?B?UE85RTYzeUF2T2I0WkxqclB4bU1QWmpQdndyYUlGOG5nbk9Jb3ZqaThValFj?=
 =?utf-8?B?clZmWmFXekhLQTMwVUFRL2FONXNEQUUrZzFwV00wa040Rk43MFdGWHNvMk0x?=
 =?utf-8?B?Q3pZWW5nL1hCWEM5aFJwQ0dqUTIxdEVKNFJjS2c5M002ZHJWZnNJbWJnaXdR?=
 =?utf-8?B?Y3JqS05SQjVZRnRtODg5RTl2eWIxemt6cC9maGg2SjNyWVp2YjZOS3grSHVw?=
 =?utf-8?B?YkdxWWtmNmI1VUpsMU4xNDVKMkE5TnVNYkpqUmV5ZVlEQVVqNlN4Y3IvUzl6?=
 =?utf-8?B?QWwycmh0NGVwbnQwNXFWTG1wT0dwS200VXJyMUE0NS9NNUZLVUZjdUdkOXZF?=
 =?utf-8?B?V01aTEFQOFZkSDBlb2QzMkxxSGhXSUkyVUI3YjdIMERKcmdkNXlUMWZQRlRU?=
 =?utf-8?B?dnVpNW5PTDlwTERrUEQ0VHlwemZDeU5KSS9jdHc2MTdHa2pkQ0VwR2thWE1y?=
 =?utf-8?B?TkNxYXp0NmFqc3g0cHM3RE0wMlppRzh2QzVDSEVZK2RDQWs0R1ZBZjRJdUFj?=
 =?utf-8?B?WlpxaDJERU1IM1dhQmZTaXFmQUVmeHd2eW11eWhOQW1hSmkxUVh3Zy9nVVZu?=
 =?utf-8?Q?HpkigIpjqgcemIk2IsCT1pwlk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8B45EC54958CB47B89C97B9F1F5E0A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3633ea50-a297-44f7-358a-08da90ef063b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:35:50.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CKVBvviBVGLlJXuPn7vSJaP/MUn7TtavI3lebciI1/MlcK1KfF5CXIYdQK8lghNDhA1l8R1eN9Hm35rBbnf6DhT51c/pM8hXq4h+7ki1PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2862
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDkvMjAyMiAxNjo0OSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQm90aCBiYXNpYyBleHRlbnNpb25zIG9mIFNW
UEJNVCBhbmQgWklDQk9NIGRlcGVuZCBvbiBDT05GSUdfTU1VLg0KPiBNYWtlIHRoZSBULUhlYWQg
ZXJyYXRhIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgc2ltaWxhciBmdW5jdGlvbmFsaXR5DQo+IGFs
c28gZGVwZW5kIG9uIGl0IHRvIHByZXZlbnQgYnVpbGQgZXJyb3JzLg0KPiANCj4gRml4ZXM6IGEz
NTcwN2MzZDg1MCAoInJpc2N2OiBhZGQgbWVtb3J5LXR5cGUgZXJyYXRhIGZvciBULUhlYWQiKQ0K
PiBGaXhlczogZDIwZWM3NTI5MjM2ICgicmlzY3Y6IGltcGxlbWVudCBjYWNoZS1tYW5hZ2VtZW50
IGVycmF0YSBmb3IgVC1IZWFkIFNvQ3MiKQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+DQoNCkluIGNhc2UgYW55b25lIGNhcmVzOg0KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwOTA3MDUzNi5sSWVmc0J1Ui1sa3BAaW50ZWwuY29t
Lw0KDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+
IC0tLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnLmVycmF0YXMgfCA0ICsrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9LY29uZmlnLmVycmF0YXMgYi9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRh
cw0KPiBpbmRleCA2ODUwZTkzODk5MzAuLmYzNjIzZGYyM2I1ZiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9yaXNjdi9LY29uZmlnLmVycmF0YXMNCj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnLmVycmF0
YXMNCj4gQEAgLTQ2LDcgKzQ2LDcgQEAgY29uZmlnIEVSUkFUQV9USEVBRA0KPiANCj4gIGNvbmZp
ZyBFUlJBVEFfVEhFQURfUEJNVA0KPiAgICAgICAgIGJvb2wgIkFwcGx5IFQtSGVhZCBtZW1vcnkg
dHlwZSBlcnJhdGEiDQo+IC0gICAgICAgZGVwZW5kcyBvbiBFUlJBVEFfVEhFQUQgJiYgNjRCSVQN
Cj4gKyAgICAgICBkZXBlbmRzIG9uIEVSUkFUQV9USEVBRCAmJiA2NEJJVCAmJiBNTVUNCj4gICAg
ICAgICBzZWxlY3QgUklTQ1ZfQUxURVJOQVRJVkVfRUFSTFkNCj4gICAgICAgICBkZWZhdWx0IHkN
Cj4gICAgICAgICBoZWxwDQo+IEBAIC01Nyw3ICs1Nyw3IEBAIGNvbmZpZyBFUlJBVEFfVEhFQURf
UEJNVA0KPiANCj4gIGNvbmZpZyBFUlJBVEFfVEhFQURfQ01PDQo+ICAgICAgICAgYm9vbCAiQXBw
bHkgVC1IZWFkIGNhY2hlIG1hbmFnZW1lbnQgZXJyYXRhIg0KPiAtICAgICAgIGRlcGVuZHMgb24g
RVJSQVRBX1RIRUFEDQo+ICsgICAgICAgZGVwZW5kcyBvbiBFUlJBVEFfVEhFQUQgJiYgTU1VDQoN
CiJSYW5kb20iIHRob3VnaHQvcXVlc3Rpb246DQpUaGVzZSB0d28gKGFuZCB0aGUgc2lmaXZlKSBl
cnJhdGEgYWxsIHVzZSBvbmVsaW5lciBkZXBlbmRzDQpidXQgdGhlIFBNVSBzZXJpZXMgb2YgeW91
cnMgaGFzOg0KY29uZmlnIEVSUkFUQV9USEVBRF9QTVUNCglib29sICJBcHBseSBULUhlYWQgUE1V
IGVycmF0YSINCglkZXBlbmRzIG9uIEVSUkFUQV9USEVBRA0KCWRlcGVuZHMgb24gUklTQ1ZfUE1V
X1NCSQ0KDQpXaGF0J3MgdGhlIHJhdGlvbmFsZSBiZWhpbmQgbm90IG9uZWxpbmVyLWluZyB0aGF0
IG9uZT8NCg0KVGhhdCdzIG9idmlvdXNseSBvcnRob2dvbmFsIHRvIHRoaXMgcGF0Y2ggdGhvdWdo
LCBzbzoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KDQo+ICAgICAgICAgc2VsZWN0IFJJU0NWX0RNQV9OT05DT0hFUkVOVA0KPiAgICAgICAg
IGRlZmF1bHQgeQ0KPiAgICAgICAgIGhlbHANCj4gLS0NCj4gMi4zNS4xDQo+IA0KPiANCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
