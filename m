Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3B5818AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiGZRju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiGZRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:39:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C831DF8;
        Tue, 26 Jul 2022 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658857162; x=1690393162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MLuVHe4yUNvZZ7QdYV72POM00ooZcmsf5MxsAfzPoro=;
  b=b3PjF4q5/s1QzFskoU5Wco6C//Tkt/1qek0G2lMVfzK0y5z9ceFalnrV
   p4Nlwc/GssREDD4mRr1a4TsNQ/hoqAoMcyrrMImOt8ui5TCPDcPkGt7ot
   1Rk1zST9pGOZ6gWqMwBBlr4wAGPTktAkr8Ay90hLCKkVzEeQpLgu0ltFq
   rY9GCKdrDeOHgjNaaY/N41MEHbt8sbOw7jE2/uI/O6AxHb9agoG1oUeRg
   BhDJFjprnaOOAf3OlP0ydxM0SpaNQcNmxYW1OMbJl6KUXaQfiq++/5XTZ
   t7MGK31GGz630uBEoKKB2ZsYWZqfnokUXOtxIaOsg9uvvlDwf/E8vffUA
   w==;
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="183836888"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 10:39:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:39:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 10:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cccESMjtnHMizvf9ckHSuGC5ER/ZnZKFYbcTyDvRSUJGl/0eJikukrBduwygkZhFJcxtQMevKzBYGrWyNt5jQHNe6YjmTFBOJ+mtThyBh1cemzbW66K7wOdPKbzETDUnttGP3vEcMRcRtCF27XOUyEzO26MPkuEqLIzPO/t1zybFH1pY147ziWldxHX94p9jqc6ogvgAO7Oj0weZLNyiXSzi1C++Aae0ghr5Ee8hRDVGpm349usya6rwFFK2meKLihXH1zv8lYsgTW4mVDk1quJJ376Ls3uYEXfe9x5a4VRGG1yzW0AQSaKG3ChgIjFI5pyrOk3h9dMayU5obsIDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLuVHe4yUNvZZ7QdYV72POM00ooZcmsf5MxsAfzPoro=;
 b=bB51/kOHTbeRyKIYFTtG3D/B9AX0TCZjnH/AGJcpNCw4SAChgH3zLbhEu+UEnkWujXmNROP1CzKDbTG2bHV7SOfishZxnmXx4m5468mp3C4xRMbV3Q7jWpW3UtBdAvZf79Ye1fwEuGTqMknWvEhJbw2z4dPo4DtG6GPbomyNOnVtQTANR2QuAfUDyauAZ+Xiz8RxNHmdE2RNiuLyD2OxSqOIBmjqeOACrY+Y/zcmFjpDddpDsEqe2x5dvXIO+JzITRqKVhXNCaA27nHmPmlttnwc3JGzbQBsnLZ0n7sxrU0m7GkHKalTqv1uI/EMc8nRhnHDEGGSyCg2DO4RZh0NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLuVHe4yUNvZZ7QdYV72POM00ooZcmsf5MxsAfzPoro=;
 b=sQWPIm7qYWS8HSUjUUCPbrzabgzJbNrMW/V19LKGhzortKy0iUAYUxNjzc3BAV5v9IQyx7JItKOmSRImwHv0EAfqFTOcKn3ScGAHaMjovclIuMQjND7qeoiIKsttxUTrWSefYRCcRE3Penj27BRDG+OolZbuE6vmuUuBgsGzK4Q=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB3597.namprd11.prod.outlook.com (2603:10b6:208:ee::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 17:39:15 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 17:39:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <Conor.Dooley@microchip.com>, <atulkhare@rivosinc.com>,
        <sagar.kadam@sifive.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Thread-Topic: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Thread-Index: AQHYoRJORxZFGGFwkky2Nc2hNdByz62Q6giAgAABE4A=
Date:   Tue, 26 Jul 2022 17:39:15 +0000
Message-ID: <c77f34aa-ff29-b18a-a3a7-9d90145364a8@microchip.com>
References: <20220726170725.3245278-1-mail@conchuod.ie>
 <20220726170725.3245278-2-mail@conchuod.ie>
 <246f132a-a23d-7c53-38a7-2bcec50d65e5@linaro.org>
In-Reply-To: <246f132a-a23d-7c53-38a7-2bcec50d65e5@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b98e055a-8504-4324-2c20-08da6f2dc28b
x-ms-traffictypediagnostic: MN2PR11MB3597:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5aLDO0lbxnp91kPLPQrxBKel9EmN3iv1C+eps1BtqMaRY6TWgj6jPCFGrtvpSa+0MmOgR2mmR/mJgdQ46Lb4RrPMctmTQjoaVznzyI4QFDzGMoLR7Vb4BMovxrlbxV4hJ9inznOaK6xv+B3cQM1aUki6RvcdvM3sROhsqe3VQPwv/ybGuRpVWsy+4jPwVUlrt8I0rNANv/eQDqQ48+AEBJcDmZCaM94RtJlisU+ry4R+yZTmz3/kRhLtk98573MGQKA0noXGgScSV5MnnoHjF0WERy8MSjTdzAFWdJ4BhZA7QOayHj6qtCBUfW7K2lDUaNjYkKgRTg3f8Jhh3tJ4+lL7y9ikjLL9N3qQB3W+nEvW+S3h00AG2DHh5NsIwELkuiWRnkUoBQedR/D0SRrfSZ/FyvbNHxFuaGFYdA7AhUwYnGj6mvT0c+QRFZlfFCGpviPnkzMZld4kOcWdJ2h8oFEUH0Wi6M6qnKdl/ugYL5Ze0ZddWeyfvP8SL428agScMSW7N8BOkbfZjN9V7cMz7lQ2QiJVrajCmT76CV8Ig0S0Y+aJDUhnKWVwtwHQ3OYpJ0iJ7X702bTQOSoj/wd2ZSD/ryxue5em9nBceXIkCsZkV1zdqO+TnM9LafmzOb/0PvZv/AOi6gohIsfEjujeTz5PIRDZNOEdQgaZ9xXDmSk4hp6fNEM7GuI8m2xQKovBzpyukQyF4R7iLyDqZfnTKJomsY7ZoWBYU73tL0RUDU1zQqHLD24Iv8ezYxOG7WONzuAijisGCyx3tY2+CInGj6KhWtVYSDJIcZEBq2TU1AuUli0Ne/nc0oXq9qYLmXxlRP7KEa8jgGUv+UD5lKO+D6M/lNfCNgw2uEtti2BmNkIFCKpvf/RI+5Ek5qg9yQVH9ArCu8AqIQ/IJjQ72bQMBhVGLfFP/kWLE/kalPG0/Yk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(6506007)(41300700001)(36756003)(122000001)(38070700005)(38100700002)(54906003)(186003)(316002)(2616005)(31686004)(110136005)(83380400001)(921005)(86362001)(31696002)(2906002)(4326008)(66556008)(6486002)(966005)(91956017)(8676002)(64756008)(53546011)(76116006)(66946007)(66476007)(66446008)(71200400001)(7416002)(5660300002)(478600001)(8936002)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnBUVlkxUTIwVEFUNms0M1Q4KzFoZkk0c3ZoSWNsNVlmdXZ3OFI4YlluUFRW?=
 =?utf-8?B?czJZdThjZnl5eXFqUEJ6bVMzUitIK0hNVlI0ZG1kcGN5VUxVbGVYaWZpZWxz?=
 =?utf-8?B?cFRyS2F4S1NydWZleTgwZUF2dTZjM05pMGcvcEI5d1ROK0NNMTNjeUtHMHQw?=
 =?utf-8?B?c0pFT0RoZ2tEWnVTLzNpem1KSXZqaWYvVnNSZkdjaUhXakdnVU1NcGw0dlo5?=
 =?utf-8?B?eURFU0JXUE5XVE8zbmJDT3d1V2o5dVo5WGFTVjlZY3c5ZUpFZEp1RUsvQUtQ?=
 =?utf-8?B?QlB2blBKOGx3dFFoc3MrN0cvUmlkdmNrVU4veWd5K2Q1YkhIVGFHVHRGN1dK?=
 =?utf-8?B?NkROUDkrMzFBaTRsc2wxLzJ1Q0JIZEp4TG5XSEc3cHBQSnAzVnE5NCtyU25r?=
 =?utf-8?B?N2FuMGhmaXh1Y01jM1Y1OEhOa29CNWF3bnoyUVI0RENHMDVWc2NqdG05VUc2?=
 =?utf-8?B?WmovV3ZWZndSZU81dERCeEczYnJpSTVaTnl5MkdXdXhEeXBZYzJZOXFjWlpY?=
 =?utf-8?B?bS9XMWRLNWFwK1JpbWxhZWZVMUovVTlVMkI1NXcvVW16RHZpdlFiMHpnMjlS?=
 =?utf-8?B?MzROVndOc0kyMmF1SncyenJNL2lBSEhGamRsSlZ3NTVKeDFRbjZFcURyYis5?=
 =?utf-8?B?aitMUDlJSWhKS201RU1KaDFma0dGS0ZQeGFZMlBpcy83bmgveW9NeERZZk41?=
 =?utf-8?B?OG42OTF1ZXFReEgxeHpOU3I1d2xUZG5yblp0OUtsV05hd1NlQ0gzYlh2eDhN?=
 =?utf-8?B?OGg3RzM4V2IyVGtrNVdmd1JOVXZtenVyanEwZEE0UHpmSlh4ZXdoU0VMVEVO?=
 =?utf-8?B?dlF0bUlqVWNaK2ZySFlkL1V5K0ljWmJCb0dUeXNiZC85Ymg1M2xJaTVibmk5?=
 =?utf-8?B?dEtUZG0wLzF5M205V1ZMWE90N0lDUndRd3AxTWdwbTcyVEVNUDR4dUs3cm85?=
 =?utf-8?B?UjcrcUtzdUplaGtHa3dJKzZyM2ZHU3F4eC9TM1g4Zm1YTDhETVNlTjg4Z0Zh?=
 =?utf-8?B?aEtUa0tLMHVIQ0xwSEIyUkFqVDNEUmJkSjNFS2drS2h4emFtSnplUThZV0tG?=
 =?utf-8?B?cUVScjF1M0tTZXpFajBJWlB5aHduakFRS0FJNUNaclF1a0lFbkcvT1J1R3RR?=
 =?utf-8?B?cy8vRDVyWEpad2pXODNLNGtuNnZORGVmNklnTjJtLytNN0R5N2hjZ0MvTGly?=
 =?utf-8?B?MUJyQk9FblFIUUNyazVrRHR4WGhXWkF0aEZFeUNLZDdUV1NKbEF0K1MycnFS?=
 =?utf-8?B?WXZJZ2pSS3lPS29WRjRjOUlIRnNwSjA3YjRWeTMyWXpaU2VWaUFrYmNDUjVo?=
 =?utf-8?B?Y2Rxbm83QW54T1ZYUXVDUU5NS0JtbVRpcG1tOGFsVEl4QTNWL2I5RldsdkJD?=
 =?utf-8?B?dlpKcXF2YUxGU0ZVcVRaanROcGdBL1o0T2htc2RmYWNIbkc5THNUOS9WVnBQ?=
 =?utf-8?B?WEQvb0RKMFJ0d2VEMmQyVGdZOVlreGFBOGdkUXBLYkZWR05EcEI2cUtKbXda?=
 =?utf-8?B?eWpXRFZBVHFKRWJmeUhIYWxpa01IV2ZDdzlMNWM3RnJjSmlQOVJhOE9BL2ZI?=
 =?utf-8?B?S3pzMnRYWml1eVM0VzJ6M2E0d0NrM2Jnb0NlaDlYdlFpc3lQRVFLL2Vmd3Zu?=
 =?utf-8?B?cTh1N3FuWWJSZEcvc0greklFRyt4T2lqZkF5aW9aUzc4ZU5OdnlDby82NHls?=
 =?utf-8?B?WENJcW5yT3pXaU9XVTVFeEoxVFlRKzJLNjNjVHV4bjIrYk9xMmk0ZEk0V1VW?=
 =?utf-8?B?V3AraTJJTzFXaHRsbjErazlBVGl1WGU2a1ZJK1YzQU1iRkMrWGlIaThQb2hr?=
 =?utf-8?B?Y2pSTDZORSszSHpSYUFNNGVpemlaQVJFUGV0K1ppT21KdTFmcDJUSElWdHZU?=
 =?utf-8?B?VllMd0hITXhUdkpQQ2x1Q1QyaS9TN1VtVzkyV2htcnhlazZuSXJnTlg0eTli?=
 =?utf-8?B?RFVrdDBBMzFhaHFWRUlDZzFGSkt5ZnowRDFucHRsZzlRb1VlaVVXcDJwMkxZ?=
 =?utf-8?B?K2xpd2xHTHFCLzZ0K0R6aDhhcC94M3YyKzRJUW52dlBmUDUvNzlYUy94bDlO?=
 =?utf-8?B?YTdDemZ4bkZ4alV6VTMxSGpvL0xHZmpYQm5vRWNQM1NXNkRZTzFndGFLS3dK?=
 =?utf-8?B?NHBpa1JDVzlDWmVFWjhGZWtsRFZpVk1QcVUzdlF0YlVnaUhXa3VOeC9iU204?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BEF8D7C32C6024BB0D662678C73E924@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e055a-8504-4324-2c20-08da6f2dc28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 17:39:15.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBZ4k2Bzm5zGNwDFhHBUSrjeVzi2g4hsgfnFcHE694yaLOrKwBcWkNMAZGKUgv4Ji9GRjGqCwRoj2VVnUOypYGzXqSon2FnI/4DpnjQeF3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3597
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI2LzA3LzIwMjIgMTg6MzUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9u
IDI2LzA3LzIwMjIgMTk6MDcsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEZyb206IEF0dWwgS2hh
cmUgPGF0dWxraGFyZUByaXZvc2luYy5jb20+DQo+Pg0KPj4gRml4ZXMgUnVubmluZyBkZXZpY2Ug
dHJlZSBzY2hlbWEgdmFsaWRhdGlvbiBlcnJvciBtZXNzYWdlcyBsaWtlDQo+PiAnLi4uIGNhY2hl
LXNldHM6MDowOiAxMDI0IHdhcyBleHBlY3RlZCcuDQo+Pg0KPj4gVGhlIGV4aXN0aW5nIGJpbmRp
bmdzIGhhZCBhIHNpbmdsZSBlbnVtZXJhdGVkIHZhbHVlIG9mIDEwMjQsIHdoaWNoDQo+PiB0cmlw
cyB1cCB0aGUgZHQtc2NoZW1hIGNoZWNrcy4gVGhlIElTQSBwZXJtaXRzIGFueSBhcmJpdHJhcnkg
cG93ZXINCj4+IG9mIHR3byBmb3IgdGhlIGNhY2hlLXNldHMgdmFsdWUsIGJ1dCB3ZSBkZWNpZGVk
IHRvIGFkZCB0aGUgc2luZ2xlDQo+PiBhZGRpdGlvbmFsIHZhbHVlIG9mIDIwNDggYmVjYXVzZSB3
ZSBjb3VsZG4ndCBzcG90IGFuIG9idmlvdXMgd2F5DQo+PiB0byBleHByZXNzIHRoZSBjb25zdHJh
aW50IGluIHRoZSBzY2hlbWEuDQo+IA0KPiBUaGVyZSBpcyBubyB3YXkgdG8gZXhwcmVzcyAicG93
ZXIgb2YgdHdvIiBidXQgZW51bSBmb3IgbXVsdGlwbGUgdmFsdWVzDQo+IHdvdWxkIHdvcmsuIElz
IHRoZXJlIGEgcmVhc29uIHRvIGxpbWl0IG9ubHkgdG8gMjA0OD8NCg0KQ29weSBwYXN0aW5nIGZy
b20gdGhlIGNvdmVyOg0KPiBJIGRvbid0IHRoaW5rIHRoYXQgdGhlcmUncyB2YWx1ZSBpbiBzcGVj
dWxhdGl2ZWx5IGFkZGluZyB2YWx1ZXMgdG8gdGhpcw0KPiBlbnVtIGVzcGVjaWFsbHkgYXMgKEkg
dGhpbmsgYXQgbGVhc3QpIHRoZSBzY2FsYSBmb3IgdGhpcyBjYWNoZSBJUCBoYXMNCj4gYmVlbiBy
ZWxlYXNlZCBwdWJsaWNseToNCj4gaHR0cHM6Ly9naXRodWIuY29tL3NpZml2ZS9ibG9jay1pbmNs
dXNpdmVjYWNoZS1zaWZpdmUvYmxvYi9tYXN0ZXIvZGVzaWduL2NyYWZ0L2luY2x1c2l2ZWNhY2hl
L3NyYy9QYXJhbWV0ZXJzLnNjYWxhI0wzMg0KPiANCj4gVGhlIHR3byBjb21wYXRpYmxlcyBpbiB0
aGUgZmlsZSBtYXRjaCBvbmx5IGFnYWluc3QgdHdvIHNwZWNpZmljIGNhY2hlDQo+IGltcGxlbWVu
YXRpb25zOiB0aGUgZnU1NDAncyAmIHRoZSBmdTc0MCdzLiBJIHdvdWxkIHNlZW0gdG8gbWUgdGhh
dCwgaXQNCj4gd291bGQgYmUgYmV0dGVyIHRvIGxvY2sgdGhpcyB0byBhIHNpbmdsZSB2YWx1ZSBw
ZXIgY29tcGF0aWJsZSBzaW5jZSB0aGUNCj4gMTAyNCBhcHBsaWVzIHRvIHRoZSBmdTU0MCAmIHRo
ZSBuZXcgdmFsdWUgb2YgMjA0OCBhcHBsaWVzIG9ubHkgdG8gdGhlDQo+IGZ1NzQwLg0KPiANCj4g
SSBoYXZlIG5vdCBtYWRlIHRoYXQgY2hhbmdlLCBJIHNpbXBseSB3YW50ZWQgdG8gcmVwYWNrYWdl
IHRoaXMgc2VyaWVzDQo+IGluIGEgd2F5IHRoYXQgY291bGQgYmUgbW9yZSBlYXNpbHkgYXBwbGll
ZCAmIHJlc3RhcnQgdGhlIGRpc2N1c3Npb24uDQoNClRMO0RSOiBJIHdvdWxkIGxpbWl0IGl0IHRv
IDEwMjQgJiAyMDQ4IHRvIG1hdGNoIHRoZSBvbmx5IGltcGxlbWVudGF0aW9ucw0KYWx0aG91Z2gg
bm90IGluIHRoZSB3YXkgdGhpcyBwYXRjaCBkaWQgaXQuDQoNCkhvcGUgdGhhdCBoZWxwcywNCkNv
bm9yLg0K
