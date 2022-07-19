Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132425795D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiGSJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGSJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:12:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8101C13E;
        Tue, 19 Jul 2022 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658221930; x=1689757930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+/hP45Ilam1Yx4IlWYve40aTCKZ10LdKyfN4z2hSLRo=;
  b=MWOJN5NUy1ZQ4DmQiC9F1BDCRQ/UtuGOvzxkYb7seRWTXy+QcBuNFdP6
   41rikj+cFeTvZ8XusSr4DYz+k4hqhor0AyZiGz6hsoRyrTBmEoDcVQtGl
   oPKEfeTNOf0554j4fLIV7C8IGGwB6aNHjtlUG2SdyHxUvPxk0lLs4Jpsh
   ko9MQ1in1DDeSfSIYf9iUQdSrLb8ZgN7tkTVuKcmV6BPdOrB5P8GhWCoA
   OeN0KcLy0Fik+4nTMuM/2XFakx1AvZ9PoSQqKOrY9WzPypYzZlSgGQCTk
   vkPn0av3C1A2Yio+sYZ5kyjI1MAzhx8247AfV69qnuZQc53+va+qJi1FX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="165373038"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 02:12:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 02:12:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 02:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYUHny1NoeGscnSriW12fkPq/zbKU/VmSY/jHijN70GObHdMIk0wwSzB0CQ+rQgELnqGgn9IXo1RV8BXE/j1iw9xo2A4tkNkLJyuaMnfnnJ9nBV2vx27gKbLHvwAy6schk/5KPWaZrPyAG58K0x0/oWR1o2PlYMpdcAg2FSG0Yc6qHbaoMWuB4pQT7fjvFyRpXpWIYoXEZlafyfNkt8i8thCqfhZzDqUaJsx6143Lto0ZS7KRcjuA+tLfZnNqu6vF1WKoL9uQa1w/Wkv3ydykzNjZEq20Dc5U+aAMnrNc1WQdHe/tP72HEqIhKiEian1ZkKK34feSn+tSfs3Uwiw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/hP45Ilam1Yx4IlWYve40aTCKZ10LdKyfN4z2hSLRo=;
 b=KzV739iZQKGyWjrKx+CHxeiLjwSB6t1ukrZQFD33hWeXJinSOD+hOHpLo6OjnjAyp/ttt34zmzVmbda9f7pii9clceL2NRKFMgNrLh0YzdIRin1LorhO998HpRZiq/H/e2tE3bSXoLL77+9JfloGLhRGrdigXp405owE36ZaJ8aR/ibzb8jihSJv51++5lvqPN5jy8J6C+SZjnMamne6Sokd019v0G3DChxJjrFIx5TKtq7xPpcDU/BNPi3jIvqKC8s307YpwInUgEQQmHPS/4eroPAWEbeF3XeWHRGriOmi3t4szOHmDrvp3+Qk7pP9I4v0hj8X2pUkVP+CO9CMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/hP45Ilam1Yx4IlWYve40aTCKZ10LdKyfN4z2hSLRo=;
 b=En4Itjn+IgtXxbZKfRKHSeOzOMaEg+n2iLl2Ms8PMAYFF4URA1jf40Uae5Ka+93C+HHG7fz4kmaLvRPChBlpvS1/9dF38EhKOd8Q/t0sVZpXVhoQ0AWi9qSaH1wQR32w0d0rRUC5xTNk0n/E1ramgL+RhuHSCKx23M2nb2zzTvg=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.17; Tue, 19 Jul 2022 09:12:05 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:12:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <oocheret@cisco.com>
CC:     <miquel.raynal@bootlin.com>, <p.yadav@ti.com>, <michael@walle.cc>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <mauro.lima@eclypsium.com>, <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <xe-linux-external@cisco.com>
Subject: Re: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Thread-Topic: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Thread-Index: AQHYm0+cFqhDOvlg80ym2KPsa3wqqQ==
Date:   Tue, 19 Jul 2022 09:12:05 +0000
Message-ID: <9ff9b84d-dc86-fb6d-4446-b39dfd9430ea@microchip.com>
References: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
 <20220615191153.3017939-1-oocheret@cisco.com> <YqrAGKLUazeNH1XK@lahna>
 <BYAPR11MB2757B1146457E3860389F4D1CDAC9@BYAPR11MB2757.namprd11.prod.outlook.com>
 <YqsHcL5NPcZ4De77@lahna>
In-Reply-To: <YqsHcL5NPcZ4De77@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74753377-8dfc-4708-8071-08da6966bfd5
x-ms-traffictypediagnostic: CH0PR11MB5220:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWRzTvEDbIy18P+/78qVWEuL2/D5ihEyfwfAJyFLjdWrtnPt5TNcrYAEfduOjhgeXlEzhkvKlQjIrKOQRYnGgVET2WQyKSJANugiaLQvE3pvxrEEutM223zYyrGIfONUBevmVlyWT0abNhgKMrm2l8L0pfe+pvfgIyI/CRW59g7mRTt+bCqQuKb8Mq2ArkfRBmpegHidQXuhe73Lg+hB3ma+TRx1BzSH35hgX6L5DG/p0r/t5NyYUXABoOXM/3ooMPBH35EMTpSmoiGBgS8bJ11cLmDglLQ7aj5tRp5eAxq1ZSvVQmrRN/c6Sm5YbwgMgXpQnHOJpt1fVr9w4bheMIsJukgZZrdmg+6SjbqY7kNesfic/ZqpqapZNg/DWU7jbaCzsZKsZHertiJWbREdqcZQVy4JIalmQEXaqO514yP9sj6+mdu29rjVgfYRD9Rs90hClVCS2Qcavt5UYD5xJ2Nra1Mcow+EG79jRAneMEel/X5Od/Y+d7ZSuWhNUVZaofU8cRJydNHja1Oi/Co6w42kfJpbqE6JEfOrgbQo11gr1fGxqnJjTZKaspEd2qvO/xYvsCpzxyxTMzqeY6DGdO7ioytSkvQNv0epA9UOUzWZXCw8Ean9ztZVTLMUV4eI/vCoCU50uVaPBRpxlTLEx0TDONb5txlFkQHgY6VP5vzKrxFinsBjAjlHzfXb5r8lvgHOMDL7Y9UtbvdqSOb4mVDpp7/XwK1wDcrhxIz53F5XBjftB6gGwl7WnpClXYee/Nsl90G5glprfP3dnnuJn9mGj7Tm9Yvayjrgjz5qZVV1F8OMEcqe720EU3wfNI0jMtO8a9ZaqiOLUh1JciG5jFFeA3J0uKUybMZeERNGy92kjPrqlQh661N3Mcxqyap0MY6wgc299D4NHQQro6LRSZ1PHLmkVh2Q2rNHVomoCUStZWXsKwny78VIjZVOi35D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(376002)(136003)(38100700002)(54906003)(41300700001)(71200400001)(186003)(5660300002)(6506007)(110136005)(2906002)(6512007)(83380400001)(26005)(31686004)(316002)(36756003)(91956017)(66446008)(53546011)(2616005)(66946007)(66556008)(8676002)(64756008)(66476007)(38070700005)(4326008)(31696002)(76116006)(122000001)(86362001)(478600001)(8936002)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZ0TUFrMFBScmtqUm1yY1lCeWZvUnloRUNXYVoraHNNeXpFTGQ0WW9xZVBn?=
 =?utf-8?B?UzYyUHpLSDFtV1JyN0JGaVRBQUdWakRjVG01RHl4U1YzcVQvT3dpbjdYcDNj?=
 =?utf-8?B?TzkxR1ZNemZuQkJUT2ZKYW9tTmcxdnZIRWZ4MExxM0dSL2hZNTF2R1BjYjNw?=
 =?utf-8?B?K2tpVTdPTlFIdlM1VmErVTd3S2lsU1V5VmZmQzdlNG5hZ29JS2NMU3d5MEMy?=
 =?utf-8?B?TWh1bUEwSHdlVUVHM0xWd1N4Vm8yZWxaTXNpSjQwKzlRN3lRUTFjRXZxOU5M?=
 =?utf-8?B?cW8xY2xmU2NqU2gvdGdybU9sK2tISHl3UzRpeHIxUStDcjFPMDByWGNqb21a?=
 =?utf-8?B?TlJkZERob1NzSU4rRWsxQngxOUd3clBwY1luNFZraU4vRmcxampzRC9EWUtQ?=
 =?utf-8?B?QkRpb2FqNjJsU2lkeWdnUFBKSytQc1MrUEJmd0RSNE9lVU1HVW9yNXM2dzdG?=
 =?utf-8?B?NEtWalVEL1MxOUxBeEltelNnU1ZXKzBybUNMNjRST1NwVUprcHFQek5nbmhZ?=
 =?utf-8?B?MU5qWlpEYWRXWGc0VXJlWWF4V0V4cDZHbjJRWEdzeUtldVp1Y25hVUVoazNE?=
 =?utf-8?B?YzU1SkJNUjFNWVBLaXNpZldKY0FoczJkUHhneDVpMk83WE12ZlJsM0k2N2pv?=
 =?utf-8?B?ekpycXlRL2FJVEZjTGR5NnZ4dzRCYmovNEN6QnlrendaamxiLzNNaHVXUFZ1?=
 =?utf-8?B?TE5ZZ1lVeGNVTjVIZFJqTzFrMmhEa1k4dHlMd1FwbGpnbzA1NW5YYlREdmhp?=
 =?utf-8?B?QjllUFBMNGg5WEpRKytKa2twZmlROGRjRUhXQTg2Syt0ajNPU2gvcVV5SXRI?=
 =?utf-8?B?ZWxEVG8zcUZtYjdjQmcyei9TRHhpSmVaSzRtZlJ3YnpPc0k5T0ptaEQ5aERQ?=
 =?utf-8?B?bEw5S2F0V3pCTXVZZlpRTFZDemtBdUtVMHE3Z0drK2FaVGZnNDA2ZmV2d0lF?=
 =?utf-8?B?L0JwUGgyTm0rYmFUeTJJaW10Tmo1Qld1K0RhcWZOUStVOU5GMXFVUUk3R3Ro?=
 =?utf-8?B?UnUzdkFFODB1cjlMMzJHRy96MDNMZ3FGNTJTREZLVHRRTFhUcU1Zb3p5YWw2?=
 =?utf-8?B?SlYzK1hFb1BzZ3cramVkZnM4cFlha3R0MW85RTQ1MDdha2lkZUY4aUhLd0NJ?=
 =?utf-8?B?M1VTbXprUk9CYm44ZXhJKy9namMrSUtucnJZRGhPZGVveHBEdFRkdjVrNEty?=
 =?utf-8?B?VWpuYTZMRUZwQXgrS2QwQXF3Um10NjZaOStMNHFLa3YwS3VLTUFzMXRvd2RS?=
 =?utf-8?B?NVBYK1BCT09xaWZneHAwTkpHb2RteVVkbUNRU1k2NUYxMk9rTVVsNXpyM3M2?=
 =?utf-8?B?RWtEZ1FGb2RnQWNLV3pIdjN4cWJPbHpmcjQ3cGp5bFFyMmtVQWZkT3JVNHVo?=
 =?utf-8?B?TFhWVWhzRU5kZ3U3a2xFekQ1WG8reWwyM3lnQzNpdXpPa0NpQVErTVVLNHZS?=
 =?utf-8?B?eW5kRklFYTRLVzJBL3g0V1kzOG1MWWhzVW9TenlvQWFhZmo1bVQ5cnIzcmps?=
 =?utf-8?B?RUVsTWtsOXB0RHJVekdLQ1lpeCtYZVkvNXpsanl3dWxZNXNXZ0xOT2k1eFBH?=
 =?utf-8?B?TSswdE0wd3F2cjFlRlJrTXlMQmNockpMczlsOTVWNkFGZURiTDZEZHhPRmxl?=
 =?utf-8?B?Skd5amZmaHUrcm5xMVY2eElCUGIyQkZqWi9IR0dYeDdPeDl4aWZyOEhlUHdx?=
 =?utf-8?B?WHZGTjhNUWo1SmlqK09BQU1xQzVQMVFJSFBybDFZS0EwYTNDb3VNTGRXN3B0?=
 =?utf-8?B?dlVwS3RyTnpRQVd6clRWL1Q1ZjBDMExUUTZLR3p5enVab0I2SFRnZ2VUYUNW?=
 =?utf-8?B?czc4L0dpRVZvSHMyWUE1WmhsMW5vU3A1dUw5dEdPSGR1ckhWMytSSGRFRmtW?=
 =?utf-8?B?bS9rUjZmT1psVlg0ZFMzWFpEdlZOTlNUWTROUzNERVN5TkhzWHlFZzdtSkJ0?=
 =?utf-8?B?bmFXdWV3dFBzVklISStxSUo1ajdnZkhGZ1A2L0JSSHNYbWFTK2FyT2dTWGZu?=
 =?utf-8?B?bzJRTzFMM3lzWllVcklxM2dBK0Q3MXBqWmMwRGFnSS8rZFh1K1NKbC9MekRC?=
 =?utf-8?B?dFZRd3BnTWtSU0Zwb0laNmpkeGFjZWRhOWx0dGtpQmxaL3lBSkhKZEYzK01Z?=
 =?utf-8?B?SjRLMFFEOTJGR3IwK2d0ZXMxbDd5ejE3K0tUYnZYYjEwUlIzZ1JhTXBOaWto?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7F5DA2C8CB874CABB97DE904FA2BEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74753377-8dfc-4708-8071-08da6966bfd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 09:12:05.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BL3UwUr2kfrFy4rYYELOIotkGQh0sxw0fyh2WUTGTtF6seFVLLJteDCNY94PCJj/kxdPyWvtkLjzRFcWGEYZNQbqNRGy4I7A2Xs9/tGhi1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNi8yMiAxMzozNSwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gT24gVGh1LCBKdW4gMTYsIDIw
MjIgYXQgMDc6NDA6MThBTSArMDAwMCwgT2xla3NhbmRyIE9jaGVyZXRueWkgLVggKG9vY2hlcmV0
IC0gR0xPQkFMTE9HSUMgSU5DIGF0IENpc2NvKSB3cm90ZToNCj4+ICAgIEhpIE1pa2EsDQo+Pg0K
Pj4gICAgICA+IE9yaWdpbmFsbHkgY29tbWl0IDA5NGQzYjkgKCJtdGQ6IHNwaS1ub3I6IEFkZCBV
U0VfRlNSIGZsYWcgZm9yDQo+PiAgICAgIG4yNXEqDQo+PiAgICAgID4gZW50cmllcyIpIGFuZCBm
b2xsb3dpbmcgb25lIDhmOTM4MjYgKCJtdGQ6IHNwaS1ub3I6IG1pY3Jvbi1zdDoNCj4+ICAgICAg
Y29udmVydA0KPj4gICAgICA+IFVTRV9GU1IgdG8gYSBtYW51ZmFjdHVyZXIgZmxhZyIpIGVuYWJs
ZWQgU1BJTk9SX09QX1JERlNSIG9wY29kZQ0KPj4gICAgICBoYW5kbGluZw0KPj4gICAgICA+IGFi
aWxpdHksIGhvd2V2ZXIgc29tZSBjb250cm9sbGVyIGRyaXZlcnMgc3RpbGwgY2Fubm90IGhhbmRs
ZSBpdA0KPj4gICAgICBwcm9wZXJseQ0KPj4gICAgICA+IGluIHRoZSBtaWNyb25fc3Rfbm9yX3Jl
YWR5KCkgY2FsbCB3aGF0IGJyZWFrcyBzb21lIG10ZCBjYWxsYmFja3MNCj4+ICAgICAgd2l0aA0K
Pj4gICAgICA+IG5leHQgZXJyb3IgbG9nczoNCj4+ICAgICAgPg0KPj4gICAgICA+IG10ZGJsb2Nr
OiBlcmFzZSBvZiByZWdpb24gW2FkZHJlc3MxLCBzaXplMV0gb24gIkJJT1MiIGZhaWxlZA0KPj4g
ICAgICA+IG10ZGJsb2NrOiBlcmFzZSBvZiByZWdpb24gW2FkZHJlc3MyLCBzaXplMl0gb24gIkJJ
T1MiIGZhaWxlZA0KPj4gICAgICA+DQo+PiAgICAgID4gVGhlIEludGVsIFNQSSBjb250cm9sbGVy
IGRvZXMgbm90IHN1cHBvcnQgbG93IGxldmVsIG9wZXJhdGlvbnMsDQo+PiAgICAgIGxpa2UNCj4+
ICAgICAgPiByZWFkaW5nIHRoZSBmbGFnIHN0YXR1cyByZWdpc3RlciAoRlNSKS4gSXQgb25seSBl
eHBvc2VzIGEgc2V0IG9mDQo+PiAgICAgIGhpZ2gNCj4+ICAgICAgPiBsZXZlbCBvcGVyYXRpb25z
IGZvciBzb2Z0d2FyZSB0byB1c2UuIEZvciB0aGlzIHJlYXNvbiBjaGVjayB0aGUNCj4+ICAgICAg
cmV0dXJuDQo+PiAgICAgID4gdmFsdWUgb2YgbWljcm9uX3N0X25vcl9yZWFkX2ZzcigpIGFuZCBp
ZiB0aGUgb3BlcmF0aW9uIHdhcyBub3QNCj4+ICAgICAgPiBzdXBwb3J0ZWQsIHVzZSB0aGUgc3Rh
dHVzIHJlZ2lzdGVyIHZhbHVlIG9ubHkuIFRoaXMgYWxsb3dzIHRoZQ0KPj4gICAgICBjaGlwIHRv
DQo+PiAgICAgID4gd29yayBldmVuIHdoZW4gYXR0YWNoZWQgdG8gSW50ZWwgU1BJIGNvbnRyb2xs
ZXIgKHRoZXJlIGFyZSBzdWNoDQo+PiAgICAgIHN5c3RlbXMNCj4+ICAgICAgPiBvdXQgdGhlcmUp
Lg0KPj4gICAgICA+DQo+Pg0KPj4gICAgPiBTaWduZWQtb2ZmLWJ5OiBNaWthIFdlc3RlcmJlcmcg
PG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+Pg0KPj4gICAgICBJIGRvbid0IHRo
aW5rIEkgc2lnbmVkIHRoaXMgb2ZmLg0KPj4NCj4+ICAgIEkgdGhvdWdodCBpZiBJIHRha2UgeW91
ciBjYXNlICgtRU9QTk9UU1VQUCkgYW5kIHVwZGF0ZSBpdCB3aXRoDQo+PiAgICAoLUVOT1RTVVBQ
KSBJIG5lZWQgdG8ga2VlcA0KPj4NCj4+ICAgIHlvdXIgU2lnaGVkLW9mZi1ieTogbm90ZSBhcyB3
ZWxsLg0KPiANCj4gVGhhdCdzIG5vdCBob3cgaXQgdHlwaWNhbGx5IHdvcmtzLiBQZW9wbGUgd2ls
bCBnaXZlIHRoZWlyIHRhZyBleHBsaWNpdGx5DQo+IGFuZCB0aGVuIHlvdSBjYW4gYWRkIHRob3Nl
Lg0KPiANCj4+ICAgID4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIE9jaGVyZXRueWkgPG9vY2hl
cmV0QGNpc2NvLmNvbT4NCj4+ICAgID4gTGluazogWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9ZbVpVQ0lFJTJGTkQ4MkJsTmhAbGFobmEvDQo+PiAgICA+IC0tLQ0KPj4NCj4+ICAgIFdo
YXQgY2hhbmdlZCBiZXR3ZWVuIHYxIGFuZCB2Mj8NCj4+DQo+PiAgICDigItJIHVwZGF0ZWQgdjEg
cGF0Y2ggdGFraW5nIGludG8gYWNjb3VudCB5b3VyIGNoYW5nZXMNCj4+ICAgIFsyXWh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIyMDUwNjEwNTE1OC40MzYxMy0xLW1pa2Eud2Vz
dGVyDQo+PiAgICBiZXJnQGxpbnV4LmludGVsLmNvbSB0byBjaGVjayAtRU9QTk9UU1VQUCBjYXNl
IGFzIHdlbGwuIEFmdGVyIEkNCj4+ICAgIGNvbWJpbmVkIGJvdGggcGF0Y2hlcyBJJ3ZlIGdvdCB2
Mi4NCj4gDQo+IFBsZWFzZSBwdXQgdGhhdCBpbmZvcm1hdGlvbiBhZnRlciB0aGUgJy0tLScgaW4g
dGhlIHBhdGNoLg0KPiANCj4+ICAgIEFuZCBkaWQgeW91IHRha2UgaW50byBjb25zaWRlcmF0aW9u
IHRoZSBjb21tZW50cyBJIGdhdmU/DQo+Pg0KPj4gICAg4oCLSWYgeW91IHNheSBhYm91dCBrZWVw
aW5nIC1FTk9UU1VQUCBhcyBpbnRlbCBkcml2ZXIgZXJyb3Jjb2RlIC0gSSB0b29rDQo+PiAgICBp
dCBob3dldmVyIGRvdWJ0ZWQgdG8gdXNlIGl0IGhlcmUgYmVjYXVzZSBvZiBub3RlIGFib3V0IG5m
cyBhYm92ZS4NCj4+ICAgIFRoZXJlIGlzIG5vIHByb2JsZW0gdG8gcmVzdG9yZSBwcmV2aW91cyB2
YXJpYW50IHdpdGggLUVOT1RTVVBQIGluIGludGVsDQo+PiAgICBkcml2ZXIgZXJyb3Jjb2RlLg0K
PiANCj4gV2VsbCB3ZSB3b3VsZCBuZWVkIHRvIGdldCBzb21lIGZlZWRiYWNrIGZyb20gU1BJLU5P
UiBtYWludGFpbmVycy4gSQ0KPiB3b3VsZCBwZXJzb25hbGx5IGtlZXAgdXNpbmcgRU5PVFNVUFAg
dG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mDQo+IHRoZSBjb2RlIGluIFNQSS1OT1Ig
Y29kZSAob3IgY29udmVydCBpdCB0byB1c2UgRU9QTk9UU1VQUCBldmVyeXdoZXJlKQ0KDQpTUEkg
Tk9SIGRvZXMgbm90IHJldHVybiAtRU5PVFNVUFAsIGJ1dCBTUEkgTUVNIGRvZXMuIExldCdzIHVz
ZSBFT1BOT1RTVVBQDQppbiBTUEkgTk9SIGFuZCB2ZXJpZnkgaWYgd2UgY2FuIGRvIGEgcGF0Y2gg
dG8gcy9FTk9UU1VQUC9FT1BOT1RTVVBQIGluIFNQSSBNRU0uDQoNCj4gYnV0IGl0IGlzIG5vdCB1
cCB0byBtZSA7LSkNCg0KPiANCj4gRm9yIEludGVsIGRyaXZlciBpdCBpcyBmaW5lIHRvIHVzZSBl
aXRoZXIgKHdoZXRldmVyIHRoZSBkZWNpc2lvbiBvZg0KPiBTUEktTk9SIG1haW50YWluZXJzJyBp
cykuDQoNCg==
