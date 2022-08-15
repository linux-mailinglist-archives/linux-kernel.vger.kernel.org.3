Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23A5933A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiHOQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiHOQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:56:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5225E9E;
        Mon, 15 Aug 2022 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660582608; x=1692118608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GmDA2y9fn7j7fFStWhWg7Yu9vyYnkbDj0PzxzxS+O2E=;
  b=cfdfG7BtLYe7b+KAmpycIjrfuI9jIYECX64Msvs5OoNEAG2v2Ylk7Cdt
   Uq1WrcpWaeIQhPLHBkB8rK2A3jvDf8plA7Lrh/C6+OrWhZv+3u6WQz3j+
   MVAwZRpYIOJaBmWybnH0xquQ+AnpRZB8K1BWDBMmjDGLA3Nbl3+6WsE1K
   OU3X5GZjVEo7Lo1GSxrbos+Mjd1OEC4hWU3/GuNBvnu3rI8qi4nOc5geK
   xCCzMPOFMYpUOWx1AMI0pLm4H6ehiNsNOUb4EX7zIsBONvzo/tCbuOrDP
   /ojry+5KVvjad06XlG0rQcAwD25rbpFbqyk5Hpnp3xPfoUYpRDHbrnyGb
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="176299337"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 09:56:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 09:56:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 09:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1bX+Ft3XgQ9EcXf1AWqHBlSm6STk2M1PdWhf24NrJ3yaQw8VMDaMHBqCT0YyYDRVHFnFd4ogUB2OjMluYZ9eyEfebW6d0iFp6YMf5erGo77N18nrbqknMsEpGLnPy0r0gwe9aSbUAuZtx4wkm5I01Sh8IPXuzrrJ5xyhoQAVcUoXhkvW7XZlrYQ/mkih1oJi19k4QGnFNStXREK+I+9sJNqvzdSKx+BXAw3PHn2phDxYKJr2L0nympDmcxNMQ+IxEQL8cIk1yctbZKZLe4ilz0uraadFWY7cZLd18S+QzdRiNRLTOwOakA735SD5DUfeDujskYFoigKOzky7gxRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmDA2y9fn7j7fFStWhWg7Yu9vyYnkbDj0PzxzxS+O2E=;
 b=IdB7wkFChAbwehMr0YUij+libs9kSlU19I3+k9T8uUqsqHLjcNBXkA8pTCiAylIgc+3nwV3GMp4tiQ3zefU/5boXNz0eo3ilEdr3S1Ts7Hm8rvDx/gWIpo93zxWHWejEqgL7BZ2LCtS7JSP+kZ6KUnl5peDwiWWQeHrTF189Bou2kPRG5GH/s0h88BwYCP0wwmPHQq5lO1lXCGogdro74xwYoAvAZNoA3RAoAymMOHwBZRz4DDCip6fj929UT7hdWWoEXbjYqQjBlxHr5Is4zOh+NUICtT1jorCbxHfykCzMMmhQdrZwuPFA0IKabOCj1WCV52FbUpyEixAo0+DUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmDA2y9fn7j7fFStWhWg7Yu9vyYnkbDj0PzxzxS+O2E=;
 b=oFEiVGPODnKrL9o5O45W2RvQbbQhyAXDfk1ww1geKVNRsiqGWZivATEUqscQhUDeXfvnZN8TP4RHbDDFOouebAnYjlM8Vwksk/MdC/oPORvlwFvvylZSHeHIDwlzYhFTNw4b9CZ1XIljusWJ2VgOp4cqKS8qouG5TRQnT7H3W1U=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 16:56:23 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 16:56:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Thread-Topic: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Thread-Index: AQHYsGUenAhsNLm10UuriMAjeDMYs62wLxoA
Date:   Mon, 15 Aug 2022 16:56:23 +0000
Message-ID: <a70e34b9-7106-ad2a-16e1-5f115e34ff1e@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-6-samuel@sholland.org>
In-Reply-To: <20220815050815.22340-6-samuel@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe6084dd-3478-4580-4af8-08da7edf1590
x-ms-traffictypediagnostic: BN6PR11MB1875:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AK5ACGQ+ONmdM6SVIWkVqYq87KCqwTCUw2lNcIt65tBXDOcvKtpmBVhuA1viSbaG6g2wmRyQWh+jJWGC9HnLSPSblCIo1JWYqwKPLHSyr+QGijUdNAJsTmDV3Pqqu1Wgo/I0UHUMSnx0qaN8Q13HoGXPSAQyQTRZPJkpGjTG/wc8klqxrE4zFPWmK6LcfwSQo2JuatWTmBNM/Bp1xX+i1HpMjwE8gsExmQXkbsTnyxtxnTOftk9bPurXHfH1P2mAYV6U0l/JEey+s79+9gyVp/xla09ilSbOkZ69M9OMHxdHW8GJ0KayGxYFDtr8Sq+M+JIQErXB3jZvWOBCtE2LNDNpnRYtCJUJzJJBFUNtHyTs/eZpxRdJxjPgG9kCWYGcGR544LCnKxsDw7kpxDJRTidfFJQVv1uSDE/+DlO79r2sGm5P07tPgeSQqoaXaVXuCRo4UcWkTsxiSrZE7pjuQquO3NYgsI/S3HvO5Dgdvv4+PQcGi6N+mHe0YdE7EO3eb/q3XynXi3fQYpzt4QqsbPEyPp5+fXI32B7fJnnDmKd8GAl96bbXW8Wlu9xb1LfwLQntSRgyDQMfUW8GwHiwWt1E4tAIJ66vazyjGUWr2ChugF9+iyKEc20gbNbmGMk5DtY8SllxcfbzkZUOw3M8J3nSufZwVq0s6lc/enY26ZShIJ4SCDdL7onW+hMv6LAe3DOHJTZp+Ain8xoXwqLjiko4Uo9PnLh0i5ThbyYFzeQaQMJiWy+Cir+U/tkp1W4f7Wizg9GBOb4ItCHSMucOFteKcc7n2bHIM8vaVKGtJklPnEm6A5r0V1xl1NGhCEifaGbevrxJyGAC5mPBaQQ11wXkH9LxliJIZSxHCeFoC/FTbB10ZF4Zln9W/BbMTfpX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(376002)(396003)(136003)(38100700002)(122000001)(26005)(5660300002)(7416002)(66476007)(6512007)(478600001)(6506007)(8936002)(38070700005)(86362001)(6486002)(71200400001)(64756008)(83380400001)(41300700001)(91956017)(76116006)(8676002)(2906002)(4326008)(66946007)(53546011)(66556008)(66446008)(31696002)(316002)(31686004)(110136005)(54906003)(2616005)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZhMzJ4VnhlQXByK3VIRU95OEtZSW9NWHVIQlhjbGR1UnJXTXBBaEJHTnEy?=
 =?utf-8?B?SVE5aHFOZ1g5QmNWcGhIbm5PZWFNZWpIaDk3YitqTGhzMERtMWxCaVM1ZXA1?=
 =?utf-8?B?azB4Q2pzVmNkSWMraHA2OFkxWWZBUTI3eWV2R2pWZ0FUUHhTQ3BaRm1QeGhR?=
 =?utf-8?B?UkdIaWo3VVIwck53V21iNWhDb2phbGNpTGkxSmx4OEFuRmFWaTBqOUZ2dzNn?=
 =?utf-8?B?MHZpbFdDQm1lbkxuL0l4RU04dkVrVDQwOVBpM3hET2ZEN3NsM2kvK3p3MGZ4?=
 =?utf-8?B?N3d2UWV0dUJSOGRHcXNDRzczTTJBL2lpS3JHaDlGQXlXejU4aTl5WjRyMmRq?=
 =?utf-8?B?QktEcUI5Z1AwTWJYT1ZGckpHMkh0QVFCM0I1OGJBQlFDVFBsUzQweWQ5UUhm?=
 =?utf-8?B?Wk5OWFZsa1NWbmx2VGhlOHROVEYrWVZ1TVh2Rm11WmxwU0kxWXMydnM3MElZ?=
 =?utf-8?B?OTg0ZWVlWVRtemJmOEwydzNMTzBsbjlOL01tM3ZBQzlkWFplVk9CT3U0QnNN?=
 =?utf-8?B?QkIxNm5JdUpHWnJtSVBVN1d1a25UOGpMdU03S2RmTFc1UmpzQmltaFQ3OW1P?=
 =?utf-8?B?RDFwWWdSK2p6VXp4dTZGNmc5WDNjRGtpbm5uN0FkT3JHVUQxS2Z3dlJjRlQ2?=
 =?utf-8?B?Vm11clpQMVNFV1VuaVdLYkRMbVpYeE8xckVDeFd5ekFkQUlUVW1tMmtabXRR?=
 =?utf-8?B?eTBlYVlveThtTDhlYmJaVnpoc2xBdCszYUNrWXhQaXdXSndGeml0VE11dXVs?=
 =?utf-8?B?L0RNZVhuYzAvdEh3NEFlUSs3d1RWaGxVVy9pWmx3d1N6dGlNZVBhTzRObHNY?=
 =?utf-8?B?QTh1NjRmQmNpM3BuaU1iTFQ1UDdSdHlBTGRZY1E2SnRXZ3dJempOeUlzSmd2?=
 =?utf-8?B?dkMvY3dRRWdFS2QwbkUxMlhwMjlQV1p1b2dUYWUwNDFMVzNRMGtCNi9JbDFX?=
 =?utf-8?B?S3ArdFRQUmowbzRVRjdOSm5xdm1ZbHJ4WmpMVTZqZG01aUU3bmNiN3BQcjh5?=
 =?utf-8?B?WkJ0T0dFVTcya2svQ2t1OVFiRE92MTFoQzJTSjJaOE1JU0F1RjVVZmZJZE5x?=
 =?utf-8?B?WWxReU9LaTVZZkVZcXZaSmlKRWc1SWZjekttay9OU3hmOW00Z1lJZHQwd3hW?=
 =?utf-8?B?b2JDVldPNGkvZ1B0T0MzSG1CSng1VDBtVWNlUVJNZjlTNWJKQTlJTUgrMldT?=
 =?utf-8?B?S1FPWE56SWlOTjhrb0pLTUh0ZkdhUjZtZzN3bDdOZklVYStZUGxwQTFtYUxh?=
 =?utf-8?B?dHNZMWxrSG9CYyt6TEprd0pqTkdxYW16SUZ4dFU1MnNPSTVrN3RnazJXLzhK?=
 =?utf-8?B?NU9jdnJLSzkyS0oybzkvcHNnenREajhYZTdNOGlPT2x1a1ZOdHZHaGRZVjNm?=
 =?utf-8?B?NWZnOWJIMzZVbGZRU3BPcWJoZ1M3L2NPZ1h3a01HVHBQY1ZNcmxMUnphRUlK?=
 =?utf-8?B?Si9wNHZTdzdTekRZTlRJMitSckZFRk5PRktiMk5EMHdrOEl3N1oram1wYzV1?=
 =?utf-8?B?cGRsOXNRdmVoVENXdG1LZmR1N1JmTUxlYURCVlVleVVaUjFXc2k5aUhudWRl?=
 =?utf-8?B?bW1lMlBNUXJ1bFJkc1E3QzJIai9kbHZLUzRZV3IxWW9EdVhtcUVickV1dWJx?=
 =?utf-8?B?MlkwbElRRVVhYTBORjZjTHdnSGZ3N0Ywdzd4Slc2WU9tWWxNODVZd1pVZkNG?=
 =?utf-8?B?Sk9HeTJoZmJTaHNuOXlFcUZPbkIwRGQzbHNvaHJiczFwMFRLSXFzS1VGakE3?=
 =?utf-8?B?SmwzRlY1ZitsK2VsS0RqZ1JydjZMcEV1K1NWdWdzNmlkRHBNRGFpcFEwN2xL?=
 =?utf-8?B?SnBDOWwrZzdmc3puK3gvOXRrdWJLOXMxcGJkeU9XeGE1c1dEaSt0aGdxR2lH?=
 =?utf-8?B?MjBZMVdFbmd5VXJtNk0wcldMZjFNeXhpUnlITC9pSGl2SFlZV2VHczlQUEx1?=
 =?utf-8?B?MTR3VGk5UVZkRUNSV21QeWowWC83Z1RaQUoydk8rR083cDhXcFRzWWdLQkJU?=
 =?utf-8?B?MzBnR2h3Z3FWN1JEU0RjcEUvd1pzdlZOQXBhY2YyMHB5eVVxTlZIZXdWTlZq?=
 =?utf-8?B?QVlhd3NpWFZ2T1RxOTkvRGY2YjFFRU01N2tTWnJydHkrVXpPZVAvd1o3MHho?=
 =?utf-8?Q?j/IFgM2ss3Vt7CvukFaT9+k4G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBAF0C774DDEF6499D168EFC8E89846D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6084dd-3478-4580-4af8-08da7edf1590
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 16:56:23.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEpIqCJXRclrua3b5J0NIiZztGM+Ka0q2tVvhb/s5zfjtnc/ZkGUhEsIYU3l+Z09t/aJgz+66gwof22lg2Py49TSa4LIYSgS5G/iBxJ7rkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1875
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAwNjowOCwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWxsd2lubmVyIG1hbnVmYWN0dXJlcyB0aGUg
c3VueGkgZmFtaWx5IG9mIGFwcGxpY2F0aW9uIHByb2Nlc3NvcnMuIFRoaXMNCj4gaW5jbHVkZXMg
dGhlICJzdW44aSIgc2VyaWVzIG9mIEFSTXY3IFNvQ3MsIHRoZSAic3VuNTBpIiBzZXJpZXMgb2Yg
QVJNdjgNCj4gU29DcywgYW5kIG5vdyB0aGUgInN1bjIwaSIgc2VyaWVzIG9mIDY0LWJpdCBSSVND
LVYgU29Dcy4NCj4gDQo+IFRoZSBmaXJzdCBTb0MgaW4gdGhlIHN1bjIwaSBzZXJpZXMgaXMgRDEs
IGNvbnRhaW5pbmcgYSBzaW5nbGUgVC1IRUFEDQo+IEM5MDYgY29yZS4gRDFzIGlzIGEgbG93LXBp
bi1jb3VudCB2YXJpYW50IG9mIEQxIHdpdGggY28tcGFja2FnZWQgRFJBTS4NCj4gDQo+IE1vc3Qg
cGVyaXBoZXJhbHMgYXJlIHNoYXJlZCBhY3Jvc3MgdGhlIGVudGlyZSBjaGlwIGZhbWlseS4gSW4g
ZmFjdCwgdGhlDQo+IEFSTXY3IFQxMTMgU29DIGlzIHBpbi1jb21wYXRpYmxlIGFuZCBhbG1vc3Qg
ZW50aXJlbHkgcmVnaXN0ZXItY29tcGF0aWJsZQ0KPiB3aXRoIHRoZSBEMXMuDQo+IA0KPiBUaGlz
IG1lYW5zIG1hbnkgZXhpc3RpbmcgZGV2aWNlIGRyaXZlcnMgY2FuIGJlIHJldXNlZC4gVG8gZmFj
aWxpdGF0ZQ0KPiB0aGlzIHJldXNlLCBuYW1lIHRoZSBzeW1ib2wgQVJDSF9TVU5YSSwgc2luY2Ug
dGhhdCBpcyB3aGF0IHRoZSBleGlzdGluZw0KPiBkcml2ZXJzIGhhdmUgYXMgdGhlaXIgZGVwZW5k
ZW5jeS4NCg0KSGV5IFNhbXVlbCwNCkkgdGhpbmsgdGhpcyBhbmQgcGF0Y2ggMTIvMTIgd2l0aCB0
aGUgZGVmY29uZmlnIGNoYW5nZXMgc2hvdWxkIGJlDQpkZWZlcnJlZCB1bnRpbCBwb3N0IExQQyAo
d2hpY2ggc3RpbGwgbGVhdmVzIHBsZW50eSBvZiB0aW1lIGZvcg0KbWFraW5nIHRoZSA2LjEgbWVy
Z2Ugd2luZG93KS4gV2UgYWxyZWFkeSBoYXZlIGxpa2UgNCBkaWZmZXJlbnQNCmFwcHJvYWNoZXMg
YmV0d2VlbiB0aGUgZXhpc3RpbmcgU09DX0ZPTyBzeW1ib2xzICYgdHdvIG1vcmUgd2hlbg0KRDEg
c3R1ZmYgYW5kIHRoZSBSZW5lc2FzIHN0dWZmIGlzIGNvbnNpZGVyZWQuDQoNClBsYW4gaXMgdG8g
ZGVjaWRlIGF0IExQQyBvbiBvbmUgYXBwcm9hY2ggZm9yIHdoYXQgdG8gZG8gd2l0aA0KS2NvbmZp
Zy5zb2NzICYgdG8gbWUgaXQgc2VlbXMgbGlrZSBhIGdvb2QgaWRlYSB0byBkbyB3aGF0J3MgYmVp
bmcNCmRvbmUgaGVyZSAtIGl0J3MgbGlrZWx5IHRoYXQgZnVydGhlciBhcm0gdmVuZG9ycyB3aWxs
IG1vdmUgYW5kDQprZWVwaW5nIHRoZSBjb21tb24gc3ltYm9scyBtYWtlcyBhIGxvdCBvZiBzZW5z
ZSB0byBtZS4uLg0KDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2Ft
dWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5vcmc+DQo+IC0tLQ0KPiANCj4gIGFyY2gvcmlz
Y3YvS2NvbmZpZy5zb2NzIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcuc29jcyBiL2Fy
Y2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+IGluZGV4IDY5Nzc0YmIzNjJkNi4uMWNhYWNiZmFjMWE1
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPiArKysgYi9hcmNoL3Jp
c2N2L0tjb25maWcuc29jcw0KPiBAQCAtMSw1ICsxLDE0IEBADQo+ICBtZW51ICJTb0Mgc2VsZWN0
aW9uIg0KPiANCj4gK2NvbmZpZyBBUkNIX1NVTlhJDQo+ICsgICAgICAgYm9vbCAiQWxsd2lubmVy
IHN1bjIwaSBTb0NzIg0KPiArICAgICAgIHNlbGVjdCBFUlJBVEFfVEhFQUQgaWYgTU1VICYmICFY
SVBfS0VSTkVMDQo+ICsgICAgICAgc2VsZWN0IFNJRklWRV9QTElDDQo+ICsgICAgICAgc2VsZWN0
IFNVTjRJX1RJTUVSDQo+ICsgICAgICAgaGVscA0KPiArICAgICAgICAgVGhpcyBlbmFibGVzIHN1
cHBvcnQgZm9yIEFsbHdpbm5lciBzdW4yMGkgcGxhdGZvcm0gaGFyZHdhcmUsDQo+ICsgICAgICAg
ICBpbmNsdWRpbmcgYm9hcmRzIGJhc2VkIG9uIHRoZSBEMSBhbmQgRDFzIFNvQ3MuDQo+ICsNCj4g
IGNvbmZpZyBTT0NfTUlDUk9DSElQX1BPTEFSRklSRQ0KPiAgICAgICAgIGJvb2wgIk1pY3JvY2hp
cCBQb2xhckZpcmUgU29DcyINCj4gICAgICAgICBzZWxlY3QgTUNIUF9DTEtfTVBGUw0KPiAtLQ0K
PiAyLjM1LjENCj4gDQoNCg==
