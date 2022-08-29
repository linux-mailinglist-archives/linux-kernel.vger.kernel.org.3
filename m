Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCE5A535F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiH2RlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2RlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:41:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A797ED0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661794867; x=1693330867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f0SDPFqsC9wYb71TLxAti8ltotPUal3ldLFeX5nzz1g=;
  b=kHsU3gurLNuybxETZJSe98FxMlPMeKfyz1ktl6EBUe/PAIlXt0jq8B5R
   zI9XVab9eOqd3deCpUaG1Xv9NX1e9XzKMwHvnCGYVZTFla/1fxL0Wi1EN
   cnP8/ctEpC/xddBzKFaV3xfNzLbMKQc9gqtzLRa32x6+TdRQ6GSfeVISF
   GdxGBnn2wRPu77+CkSVgmV0MJl/rOkFWwG4wlQN6Rhux9Fki5TQB3pJ6b
   uSGlIDAnvshweWGz/8IOdD6UdJG3rFGT48g+Iv1KkJWD4+ogBWou1NAdX
   x+vSiJqvHOl05fGpTItVjg4wj57aFND03YIKg36YdU1BIedQaHk9Ecyj4
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="178182391"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 10:41:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 10:41:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 10:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqxh2dZBgHyUgEtfXqbtuUxqTMWDxbZnVUHvM6qYo0hgz9zjeXAanAqVWkbGTy/QhfCgoeH5brcNrm87Vc+cLDa86WO8akW1Bb4Z/MHM0MQ3tbAcPf6x+9PK3kNyWxp0OT3XeCTJFcgLTsGamK+NSJG+ZP/cwa6dmQ/yl1Dn6128Nak2qShJ41lxTkki7oThooTbe9q9R2tMR3rE4Gj+QSuQDXUFQICvYBceI+l5GgQUje8g4KAC0Pd5oH2G/cStxLUGRkPj5XNXNURRpiKMFHjrc5qtQ9aGg4mqJ9L3jloL7pyzdxGZHA0G+b1rEY75k32rC8jJv41EzH9dFvw2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0SDPFqsC9wYb71TLxAti8ltotPUal3ldLFeX5nzz1g=;
 b=fTf0E44khhNwmW8v+xObMJS4Vq4z0hH8ZeL8iFeo/C84oRTNQ7KIzaNnBar1Zzf4olt5KJRj2HEP6DwQX+x+H6ne8Z/O2OmGRT7hedDWrZIn1gJtm4ErNLygwD4vVjxVZL8WSvVgItzDgFauUmyiSRV0fqP+k8Ic27h+Y7c3+AL5k/t6vCxKH6eeZLYNjXzQ+zzqpcZe5Sx4kYUaJ1tugZKhoS+rM14SZW3xIhpPU/J8jyknmWg7vClFPuOclQviz2yENz6HQs5JvdwZlCD96S9DUVAeU/YJTGBrd+pGJqS+Ofily3UsUGpkx6iNjQKAVNR1RGR8O1NfN3lIDuxkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0SDPFqsC9wYb71TLxAti8ltotPUal3ldLFeX5nzz1g=;
 b=J6vNjwARDehbG2xIseiO2HsRBOt02eiPniw5acUdP7Tinb+Vcdi5upD3gOzC+SkK0qzS7MGlbyRkiq0trj3ImuHEzbVGd+7DxOy2AV9oQbYmg46vTQCz8+c8ujwhdrpjzMTkchrci2o+RJa+RfzXsmvIQSDFvHaYFUHSx809XVU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 17:40:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:40:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <atishp@atishpatra.org>, <heiko@sntech.de>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add PMEM support for RISC-V
Thread-Topic: [PATCH 0/4] Add PMEM support for RISC-V
Thread-Index: AQHYu6ZO+JUY+heYt0OoC/OUwNufja3GJbOA
Date:   Mon, 29 Aug 2022 17:40:59 +0000
Message-ID: <f4b2daab-72f6-ab5a-5743-b41bd5e2c920@microchip.com>
References: <20220829125226.511564-1-apatel@ventanamicro.com>
In-Reply-To: <20220829125226.511564-1-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d294834-ba29-4f88-1f06-08da89e5a2c0
x-ms-traffictypediagnostic: MW5PR11MB5908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmI+KbDGOv9uhlEGuMk3Ng3tJj83PX0On/Wx+fkG2Jw7Mza7P4ub6W3A5DBiOeI2AeWil4t01wc9n4hvBACxtXL9qMaciqdLx3/cs94/X9qx7QGB7/P5QM3Fn8CABIlRpfcIHi1etrTZXH0U6oAvgA+/a59nugY1vVwyRvlN3aDZmS8mOdCWcMPBfJ44jq7wt5Ipj/pP6PGlpffz0DYAMvmGRNPtr1PR8YeTkNXjoBUL4QS2I7rHCblQNK/7lpHouEFRNfzW7SzVFuIHiJxBmeEmYJ2dH4KbwIMdi5k1Ctmh+/YDRFF25v/inYFKaxHA0+dj2FFAe2iG1oXdpki43B/JhZwrINSLGckX9XEAQQhuuUX0uYEfSjZCkU4PTExQxYh5mYQ7UHpQMPyOYXf2avQo+MceablXpetayzlGDnYzrmHF3DOkd1w3lNQVVFF4dCiq+wsBHmykheZx+ZmobmpH3SdMX5KZSr6xb2Ft5sHDeFebeoa8ofuYc4nYDTGCks8WzzE1A/mBhui6ucid0G+i/i3DA41gj2GpQrxBRM3MW5dvskJHzlJNTwMu5EfRz+wWcARuBgn8UrZRxXFn5pI1GlrZbYYV6Abd+8fxP5FPSdf24rwJQVYP44lpGKBJaeg7Mryv4TU8AEPwZoQV4762sSfkaU0+CMT5d+JQaRvXJgcqx9LYqSv4gplTye6sNikHJVPwZxeXASLxGr6ly4x+v8qzMYTGdyYXjTEYMWT0deSrpchic9KF1LK/fcxM+DnGgdVdyCI0ac+5B7JJoqeECTJ4kVulYJHlno9NljKeS4rI1KVh3AjD9tDhtxSrUOjUl4UjkbZ6lPHi5/i+prEujw3eBVsjH7ByIEhYYjMTNT1eLYJPkPCe1QYxONdjX5FoY457b4NVGOpRWTeBgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(396003)(39860400002)(64756008)(2616005)(41300700001)(8676002)(83380400001)(31696002)(38100700002)(38070700005)(122000001)(66556008)(31686004)(86362001)(66446008)(76116006)(66946007)(91956017)(186003)(66476007)(6506007)(316002)(36756003)(2906002)(5660300002)(8936002)(6486002)(966005)(6512007)(110136005)(478600001)(53546011)(71200400001)(26005)(4326008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDNjQ3pES3dIVG5XdTBhMlFEM0pvL1owUTBNM1dLSy9ma29zNFU4d1c0Qk9n?=
 =?utf-8?B?SU5VbVpGRkpib0swRDU5ZVo1dmF0eHk2V0dCN3VjNnFkb0MzRWF4ajBaK1ZI?=
 =?utf-8?B?c1FvamsxUmtBVVdnWnlINmZFaGRmSFAzWjkrdHVhTDJ6ZFh0b2FmdDVGWEdv?=
 =?utf-8?B?SlRZdDNOYkx0YWd0b3YrK2tMZFZKNXd2S0Zhcko1dy9XNmx2MkhiRHNCOHlo?=
 =?utf-8?B?OEsyZ1I2SWZOK283bEhka0t3dUZCMndmRGlCVklBV0I3SXNMTldmd0lXQXI2?=
 =?utf-8?B?V3JlZVNwcC9scHdRRUlZRklGbHMxWmg2R3hlaUdab1h5aGFGYzNSTFN6aHpQ?=
 =?utf-8?B?WHRZRHlGNU4zem1nV1FqWTdKeUZNYWx1TlZmNFpsR0dRRWw3UXd0NDBKU1Ez?=
 =?utf-8?B?SlF2a0l4V0FVd2xwQ2NLRGlpcVZGMGw2bmJZUVZXUU16TENHWmJxY3RsYVV2?=
 =?utf-8?B?NEt1OTdmZ09aWTEwSzc5UHo5VHE3cm1GSzEzQzVYa2dMcnppR1dkMmMweHdB?=
 =?utf-8?B?WkRtYms2YVdKdGorMzBPRkRJSE92elRqNDRqMG9jb3NhMC9WSzhBS0dQU3Jo?=
 =?utf-8?B?MWNhcFovcXgvMVFXR0E3b0J3dlJralRXY0JjSVpmWGVzdkRnUnFRRWtXU2JB?=
 =?utf-8?B?VEVOZUt0dVY5N0h0WE14SlZlUW8xdTlOMUZOV2FwMmRNTThRcmNpM3F3cWtt?=
 =?utf-8?B?TzRmSlFWQWtlZmVTeGMydHN5ejVDV3c3aWJRaUovMWhTZk1aemRhR3ZKWUFB?=
 =?utf-8?B?dXdZZEFxUk9CcnExWCs5blUxb2VTYTliTnpoajBGMzRiRExWUDJ6NXBWS3Za?=
 =?utf-8?B?d2pvSDcvZ3VyQnhVb0xsc3JyWm1ncFJaYW5KdDJGTlNpYjBVK2t3KzlQdUNJ?=
 =?utf-8?B?KzBKVXN1RXYrd0dPL3I3MHpCZytrSWMzUTVES2dtMGI0TTh6TmNGM3F2SUFL?=
 =?utf-8?B?UFZpRVJxRmw3T3lTNWdIZGZwVlRkTzl3UkF3aXIyaGU5UEovU3psTFZHZnd5?=
 =?utf-8?B?aGFqQ3FpcmM0eG9NM0lieUVyNVBlVEtnYkNHNHJGSzE2R2xmSEgzL0tPd0Jr?=
 =?utf-8?B?WXR3NXVkOFJjTTVzT25takdNRTRqeHhOdGxxelNrY3NCa1BqbDFWSTRyd3Zl?=
 =?utf-8?B?MHlPQ1ZOdWlsdGk3SXFpU3VjdVZQQW81UkJ6MmpXVzNGckN5WVJjZkpvT2Jq?=
 =?utf-8?B?Q1ZiR3UzQTRZS25YeGM3OThKUStBb0N2bThnMThaYVptYkNUekIybWloYkNr?=
 =?utf-8?B?dVF4UUljbjJ5T05yamRmdy9pdHMyeUJjUEpjdHo3MjdXVmpmbURBZDM5dkpI?=
 =?utf-8?B?THhydFRkTkpEVmQxaDJ6MEM2Q2Y5Zm5ORyt2UmtvWnhVUDBGbVVzbTROZUpR?=
 =?utf-8?B?OWR6WlFvL2JWOHAzcnFOTjlmOVpVeGdLeWlpRGZOK0dWRUozb2ZtMXA1TUNX?=
 =?utf-8?B?OHZmaWNYSmlOSHJEenZ3VDZtajduVGtvQ3JxckZLU1NYaTR1dnEwdm00NFR5?=
 =?utf-8?B?cGZ3V0NTRlBpZ1pISUM0RTFackw0RldZb3VPTWo2U0RKUFZiS3JocnUrbC9X?=
 =?utf-8?B?NUhtYW5TU2hKc3Fya2M1ZlFXUU45RVRxMFJrSzRBZ2liUitkYm9FZFJhN095?=
 =?utf-8?B?ZURydDdNYXN5NC9KTzBMb0t4MGJJY2p2VU4wTzlOZGNIeFdaU2lmbmxxQWs4?=
 =?utf-8?B?eGV4UE1hanc1SGRvVlVrZTNrNlVFbEd2WVFqNDBZeXpueG41MWNkT3lPUnpV?=
 =?utf-8?B?MTIwN0ZNeDlwd21lUFYxUVovRkdlL20wbEZmOVFaQjdjN1RjUk1ndFcwZEgv?=
 =?utf-8?B?WGZqWGhoNjZrRmhzOG9nSnZjbXZEQnlBbTlLSXJJSmYwMGowTG9lUDgrZlFm?=
 =?utf-8?B?ek9lRGxpOHRZTjBXbFI3VFdlVGpzYUpEd0M5azJINStDQTd4VmZ0QlNJaDR5?=
 =?utf-8?B?T1pUM0VKWW5BWXZDbEN5b3lYV3hjZkRLM3JoVWs1cmZHT0svMUVvTCtGb1Ex?=
 =?utf-8?B?KzZ0NFNMbDFJNVZncGw0cmpDMGFrUFg2SVBDYlBlcnhXTTYzUzEvS2tYc1pW?=
 =?utf-8?B?QUsyM2NMR2QyTWxLbGxYOG5vdGFnMTY2MXFmWmF3a1JNeHBkQjdhMXpUZlA0?=
 =?utf-8?B?RitHa211Qm1hbUxtbUVJVGVpU0UvYkVsVEZJeWFMRCtyM01QeDc3SHl0a2VT?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C7018C5307864CBAF83348D8CC4F56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d294834-ba29-4f88-1f06-08da89e5a2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 17:40:59.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j88RkXoXy7t62jTsiro94WSLeBronINgMJ1YwU62pVNbpaU/E1BvFDjWYy+SZgFxGOIS+0TJUoW7pLSPNAtBvaeXtErYPg1fdHSugCkMiJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDgvMjAyMiAxMzo1MiwgQW51cCBQYXRlbCB3cm90ZToNCj4gVGhlIExpbnV4IE5WRElN
TSBQRU0gZHJpdmVycyByZXF1aXJlIGFyY2ggc3VwcG9ydCB0byBtYXAgYW5kIGFjY2VzcyB0aGUN
Cj4gcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlLiBUaGlzIHNlcmllcyBhZGRzIFJJU0MtViBQTUVN
IHN1cHBvcnQgdXNpbmcNCj4gcmVjZW50bHkgYWRkZWQgU3ZwYm10IGFuZCBaaWNib20gc3VwcG9y
dC4NCj4gDQo+IFRoZXNlIHBhdGNoZXMgY2FuIGFsc28gYmUgZm91bmQgaW4gcmlzY3ZfcG1lbV92
MSBicmFuY2ggYXQ6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hdnBhdGVsL2xpbnV4LmdpdA0KDQpI
ZXkgQW51cCwgY291cGxlIGJ1aWxkIGVycm9ycyBoZXJlOg0KDQovc3R1ZmYvbGludXgvYXJjaC9y
aXNjdi9tbS9jYWNoZWZsdXNoLmM6OTk6MjogZXJyb3I6IGNhbGwgdG8gdW5kZWNsYXJlZCBmdW5j
dGlvbiAnZm9yX2VhY2hfb2ZfY3B1X25vZGUnOyBJU08gQzk5IGFuZCBsYXRlciBkbyBub3Qgc3Vw
cG9ydCBpbXBsaWNpdCBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgWy1XaW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dDQogICAgICAgIGZvcl9lYWNoX29mX2NwdV9ub2RlKG5vZGUpIHsNCiAgICAg
ICAgXg0KL3N0dWZmL2xpbnV4L2FyY2gvcmlzY3YvbW0vY2FjaGVmbHVzaC5jOjk5OjI4OiBlcnJv
cjogZXhwZWN0ZWQgJzsnIGFmdGVyIGV4cHJlc3Npb24NCiAgICAgICAgZm9yX2VhY2hfb2ZfY3B1
X25vZGUobm9kZSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7DQoxIHdhcm5pbmcgZ2VuZXJhdGVkLg0KL3N0
dWZmL2xpbnV4L2FyY2gvcmlzY3YvbW0vY2FjaGVmbHVzaC5jOjEwNTo0OiBlcnJvcjogJ2NvbnRp
bnVlJyBzdGF0ZW1lbnQgbm90IGluIGxvb3Agc3RhdGVtZW50DQogICAgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCiAgICAgICAgICAgICAgICAgICAgICAgIF4NCi9zdHVmZi9saW51eC9h
cmNoL3Jpc2N2L21tL2NhY2hlZmx1c2guYzoxMDg6NDogZXJyb3I6ICdjb250aW51ZScgc3RhdGVt
ZW50IG5vdCBpbiBsb29wIHN0YXRlbWVudA0KICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7DQogICAgICAgICAgICAgICAgICAgICAgICBeDQovc3R1ZmYvbGludXgvYXJjaC9yaXNjdi9t
bS9jYWNoZWZsdXNoLmM6MTExOjk6IGVycm9yOiBjYWxsIHRvIHVuZGVjbGFyZWQgZnVuY3Rpb24g
J29mX3Byb3BlcnR5X3JlYWRfdTMyJzsgSVNPIEM5OSBhbmQgbGF0ZXIgZG8gbm90IHN1cHBvcnQg
aW1wbGljaXQgZnVuY3Rpb24gZGVjbGFyYXRpb25zIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xh
cmF0aW9uXQ0KICAgICAgICAgICAgICAgIHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUs
ICJyaXNjdixjYm9tLWJsb2NrLXNpemUiLCAmdmFsKTsNCiAgICAgICAgICAgICAgICAgICAgICBe
DQovc3R1ZmYvbGludXgvYXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNoLmM6MTEzOjQ6IGVycm9yOiAn
Y29udGludWUnIHN0YXRlbWVudCBub3QgaW4gbG9vcCBzdGF0ZW1lbnQNCiAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KICAgICAgICAgICAgICAgICAgICAgICAgXg0KNiBlcnJvcnMg
Z2VuZXJhdGVkLg0KDQpMS1AgYWxyZWFkeSBjb21wbGFpbmVkIGFib3V0IHRoaXMgcHJpb3IgdG8g
eW91IHBvc3RpbmcgJiBhcyBpdCBoYXMNCmFsbCB0aGUgcmVwcm8gbmVlZGVkLCB0aGVyZSdzIG5v
dCBtdWNoIHBvaW50IGluIG1lIHNoYXJpbmcgbXkgY29uZmlnDQpldGM6DQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMjA4MjcyMDI4Lkl3ck5aMFVyLWxrcEBpbnRlbC5jb20vDQoNClRo
YW5rcywNCkNvbm9yLg0KDQpQUzogSSBsaWtlZCB0aGUgbGFzdCBwYXRjaCwgbXVzdCd2ZSBiZWVu
IGEgaGFyZCBjb25maWcgb3B0aW9uIHRvDQpmaW5kIGlmIGl0IHRvb2sgdHdvIG9mIHlvdSEgOykN
Cg0KDQo+IA0KPiBBbnVwIFBhdGVsICg0KToNCj4gICBSSVNDLVY6IEZpeCBpb3JlbWFwX2NhY2hl
KCkgYW5kIGlvcmVtYXBfd2MoKSBmb3Igc3lzdGVtcyB3aXRoIFN2cGJtdA0KPiAgIFJJU0MtVjog
TW92ZSByaXNjdl9pbml0X2Nib21fYmxvY2tzaXplKCkgdG8gY2FjaGVmbHVzaC5jDQo+ICAgUklT
Qy1WOiBJbXBsZW1lbnQgYXJjaCBzcGVjaWZpYyBQTUVNIEFQSXMNCj4gICBSSVNDLVY6IEVuYWJs
ZSBQTUVNIGRyaXZlcnMNCj4gDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAg
ICB8ICAxICsNCj4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcgICAgICAgIHwgIDEgKw0K
PiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmggfCAgMiArKw0KPiAgYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS9pby5oICAgICAgICAgfCAxMCArKysrKysrKw0KPiAgYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgfCAgMiArKw0KPiAgYXJjaC9yaXNjdi9tbS9NYWtl
ZmlsZSAgICAgICAgICAgICAgfCAgMSArDQo+ICBhcmNoL3Jpc2N2L21tL2NhY2hlZmx1c2guYyAg
ICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3Jpc2N2
L21tL2RtYS1ub25jb2hlcmVudC5jICAgICB8IDM2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIGFyY2gvcmlzY3YvbW0vcG1lbS5jICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysr
KysrKysrKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCA3NSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlv
bnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L21tL3BtZW0uYw0KPiANCg==
