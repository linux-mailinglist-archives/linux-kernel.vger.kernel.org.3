Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857A564DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGDGs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiGDGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:48:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C70215;
        Sun,  3 Jul 2022 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656917301; x=1688453301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IzHLPtnOuvedo1gtz54PFfhoYTwJQgAtx54VAijKQTo=;
  b=aPxF+VNvYE5sT8wSCON/7MnK8K0kT1b7x034PUjsLVrwSo5ro5caWaoU
   jQPjxqj7FnWpI/yoxiNXIs+DDo3w1i8JT7DdnsB9KUKU7WZcSqziJkJvr
   REq9RBtqAIZ8LWxkOmbzSyTF3RWiyz/1Tljeb2CE3M3xwx3kiddvvZG08
   bONxTPXM91udf3CeWY9e+CqTCnAivBicZUCmn4bl+k9k8PHK421X2oPxu
   EY5vTJIy11NvXyaZeJ2dzcdYb7mBcFKqiNfO1T2zR8H1SY/b7GjGrl4dl
   fGwTjyy5CsKyJTHVZWhRAGqD1E/A6b0KFgT/3H6Vo3+J8UROMr1/uNoGb
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="180607698"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 23:48:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 23:48:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 3 Jul 2022 23:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guQLqVYsknE/BXuBpRj3KZ0YkjXCKevgrgWBVkKhPL+Dy9Yc80nhPHuWEVgOtoLc6djTV2+ANyPDeFFaL1iWtsIcbL2wBmKzp0egg9RYr7DN1JatFDhIYakR35A8GCNhAOhzHDD72XC2Sy4t5zpHVhZ0DSjwgWzaSBB7Dck2xf2Oj1Lx9TsQtbUgKCxyUU5tsnDp5/Wp/G5cx8Pkqwd+88vGEMLbMGaA1bBNbg6qkxiY236Y9X8x8Dhh+TZUeQJ/TnHbLB94ZPlgYcbO3lCWyIV5vpUsxaIOB2iBuTPjAx9MRuCo0wV5knuwMdlBkl6Tl0jjuvKt4iT1IOJlmk5UlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzHLPtnOuvedo1gtz54PFfhoYTwJQgAtx54VAijKQTo=;
 b=LYeXRL5uwULLgkiMQ/+4g/qRoPbuACzzhKYPoy9FP6a4BszaJ9PvwCGzKf6mp7mHcHYzE200znag9Rj8kYrNLaqIGhNdPxO5NSu3PhjisRL78hxy18GLi2Ygtu2GuBNyGyYcWpGGl4W8DUSPLF1goW6Kyvfjg3t+XB4iyoUmDzg4d/dt8RZ6F6lun/ss+4233pZRmi3skk2k4OAFNVMc+CHWbQTeS937ayT/FRv0bMLIJNtl+QH5X2jM8Dyhv5KvCVnzuM1+GB/Iis4k9tdA99yqwlL9r3sy39oysOJPYkIIW4FEYnRd3vQ62DqIYUGO4KGc9rSBDGEicaf99gNNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzHLPtnOuvedo1gtz54PFfhoYTwJQgAtx54VAijKQTo=;
 b=sqDxGAqfDJ/sVttFb7Pr8koWgGDPr/D4EFqjY8Ox2m09tNKbsgIjT9lzYAVqgiFeo9begUhYTW4KYY+fBotLBZuDg/T9YLnrAP1GvWPPJUsdm2+pNEUG/kaaquUe3Z//5jtDm6CeJsnh1CkCe8gSB9PP1jSOF+ZDTPTyCtff7WM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BYAPR11MB3014.namprd11.prod.outlook.com (2603:10b6:a03:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:48:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:48:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add mcan1 node.
Thread-Topic: [PATCH] ARM: dts: lan966x: Add mcan1 node.
Thread-Index: AQHYj3IIxLsOU6r1/Uu4oA+5isUq6A==
Date:   Mon, 4 Jul 2022 06:48:13 +0000
Message-ID: <4c17f88a-7e82-4734-1001-0bd5da218654@microchip.com>
References: <20220627110552.26315-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220627110552.26315-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89556365-3366-468a-f2e2-08da5d892af2
x-ms-traffictypediagnostic: BYAPR11MB3014:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYR5yvmWIGdGQevXnnl55eKIAljoYAr585McPgMviq/mJt7/XbAxUelTjzjwYvCiG9/6Sru306gVSaX5XO4zApaFRjWONJnqWX00en7IIKJA+kdM6uH4HJCLacWjfDi3SyQif0HpXrhwUFIz1aK9OOGtx9n+QXcF1LsDl5oMSkTBkssGt5HsKJFap2Kbvwk4nGqbKaGcRVGpJFDXDphgeF2MOtTDOlcM0Qg+9PIFags7gkhJtGnd2GkEcsA9zLfBB4fQ3ChNEuo2IZpnm8+QC3uwabj2fQeMcF53lkE3g+xFU8LEAW+waxoIIW/cbLGpbnRfb06blWUszD7hn9HResbiXzQ7oOgZxTKpO9aK8VTUcLB3UiSlSGFjviL+SRqzO2M7W3nMk8IkPWBa/B7+ZYe2MbU9KAUbeUPJXFobxNoFTlYtX0jQNLbcC13evHpxjlck6wediRYyIRDopLS8bx6GRPpeO9X7hW6KwBBHQA9VEnlUBo6LdDophHOg/Iqcf3n45/vpQrXOSyVvJHoSzPYWNFjcz5FKe7uqamrlCp5ef021od2H9AO63nWunP8iBzN+oSA0IbIDIJmiW7GWp9wB8MLN0cVaE2cYsMVOyRreKI3oTZNalYGg7/5Z8UJUehqvC31ZD9OPg46T+3zhzRGmFJ2gL6K5xXmWVvR8/c6IprTKb0D+krLgNyenpDVyI/IDepdHOFfMokONg3BV30PI2PD5NiC+VN4Q1pUkzOxjRw7YCws1KIbTm0vG6wEiDyQOZHo45pB5lfwkYf3VE1AdFsMasPxVYHXlBKm+UrfxI9TDAp/Ko27akVO34PWvq2HGa1OR7ZHuMp2+nWfEh1vc6Dpg3eLhqPbnPrv3saW6eKEWtXvJQGY7Wb3QsGQ/itKD6EP4ncs22UZ3ExMauR2XqX76tLZLtfsDBCYIp9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(5660300002)(54906003)(6636002)(8936002)(110136005)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(76116006)(64756008)(107886003)(91956017)(2616005)(316002)(31696002)(86362001)(41300700001)(38100700002)(6512007)(26005)(53546011)(6506007)(71200400001)(31686004)(966005)(6486002)(478600001)(122000001)(2906002)(38070700005)(36756003)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3dTcS9UREQwYUdaRzZWMERBQjlzV2JzSTFVbnQ2Z2NYZUpkYXl4VVBGbTRT?=
 =?utf-8?B?dkVTR1djUXRqM1NvbEdNQ1hiMk1RUS9TU1cwL3daNm9rZ1kvbEVCWE5GMHJM?=
 =?utf-8?B?V2xicC9Tdkx4WWpKRjZPSGIwZmkrdFNXd1JTVHZDYnRNa0J2UmRDdjE4SGxi?=
 =?utf-8?B?TUhzZkVxVU5ZUDNlcUExMHJYR3gwdi9OM3d6QmNQM0VRbEU3WVdJVUE3ZXNH?=
 =?utf-8?B?YlZ5Ry9GV011L1R4OHhnMXNtZjkvTzRuU0lnVllYUE1jTWRydlVhUHdKcG81?=
 =?utf-8?B?RktsTk12VUtQcXY3aDlocU45Zms1UFgrZFQ5bmdtWUhBVEJCS1dMd2xrYThI?=
 =?utf-8?B?T0NzL25yUG1zdytDR2t0eE1vK2R1V0tzZmx4VjlXZy9SSW01K3lqTFRBSkpF?=
 =?utf-8?B?MlFLSFZ5U04zaU1qcHQ0Um1ydGJyT0c4QjlBaWt5WnBTbmZCaWRyY3NoUkxR?=
 =?utf-8?B?cjRISkRFMUZlenQ5LzZOK1JjbEtobFVuekpDN1I1Qm5oUGFaTjBHQTVUaThu?=
 =?utf-8?B?U1pxaVpqbEhkelRrNEhEc1lreTNaZ2VkTjA2WlVWa3hka2NBZFBBSms2R0FL?=
 =?utf-8?B?elpJNkRPeFY5Y1dYcC9NR0d4dDZML0w1SlNlTG43TGxnZmJreDE1Q0N6R3VC?=
 =?utf-8?B?YUpIKzdOZXgxTENDTEplbVhsU01lYUdJZVFjamFxZy9ORDV2NkUzaXJ2UFg3?=
 =?utf-8?B?V1o1UkhrUkViRTExYWdTZHlWWmhYdXJwbi9MOHQraDBvSmNyZDlSem5HNFkw?=
 =?utf-8?B?L3lUUURTck5QUjZtOTArS1dpeDE2dGxYK05vVFY5QjZxUmlPTnBvZ09BY2NE?=
 =?utf-8?B?SDMrRk1XelZ4N0VsbU5aZG8wc0VLQWhXZjZyNUxXckFuU2pRZ3p5VGlYZ01r?=
 =?utf-8?B?c0pmTmsxQ1haR09NbXlhaHhHVFdnaHlCZ2t0UVlkYldHaDI1UER3bU9EejRY?=
 =?utf-8?B?OFNoZkpFUmU3bEJGYXhmTzBlaDdKekQrNVhaQUVOYTZCUlZod2kwbzI2NG5u?=
 =?utf-8?B?YUlBMzFSSDZCcWtpZWZ6QkNSTEVpeEFuQjgreFlDVURoM2JnWHE2NjRyQ1dm?=
 =?utf-8?B?L0FadUxXSjVRNDNsNVREeU5PRVFsQ1RyMkdzZTNxUHJYc1REVkFySThFenEw?=
 =?utf-8?B?YVZXb09sQUh3Mk1pQVQvU2dqcWlrczNtQ28yUDFtcXJXakZ1NEQxOFF4YTNL?=
 =?utf-8?B?QzBuUjBuMUVxcGRzblY2Vk1RT24xei84ZlFHV3FuczdnQkMyTmlDMTNDVkZW?=
 =?utf-8?B?azNDSDRjTzJLaDkzY095dTU4NStCNE16WXRwcFZ5U0RvcU1wejBqVDNlOHJP?=
 =?utf-8?B?VjN6RXVOcHlLZmU5Y2NXMWQ0S09PSWVxbWl0TUgrWjRCcWZLUDFxR05zZkxS?=
 =?utf-8?B?Q2kzV0xLYjNoZDVSaEdPMjZ4c1IrTUphcXJnblQ2MGkybUNDMU51MEl4am91?=
 =?utf-8?B?REVLN2hsVHR1Q3ZaTk11TmY4d1dPYy9sNUZFdVZZYnpoTnVSbkU2bTdMRURV?=
 =?utf-8?B?Yi9QZTNEOWkxTWVMRXpERWFIZWpHNU5YNTdaNDg4b3l6SkNod2hWNXpKWDR1?=
 =?utf-8?B?aGVBcU5MWjhtcTZ5c0tPMnNYTUVjbHNnR3FkR2ovOUptclZrckpvN280S0FZ?=
 =?utf-8?B?S0l6Qkp3VGlmY21iekFqbEE2Zk1tQlFISjkrY2UzQWFGZkIza0J6TVFnTG9G?=
 =?utf-8?B?ZlRvMys4Q1F6SXJOWFVxRG8yYzJhaWdsVGZXQkE5SEhvTkFWYUxPMk1iV3p5?=
 =?utf-8?B?a0JzU0s3NHlYREh1SGhIMUttd0ZvWVRwaXloWEEyeVVUN3hCQ2RHTExRV2VD?=
 =?utf-8?B?a3Nnb3FoUU9aU3hUczZDVTNycHd5RzRwOU1mNy82RTZmNTNtT0wzdUhqTWpp?=
 =?utf-8?B?aytpaFdydDRxMzY0SWRuTktDWFRIenh0VWFXckpvZFJrcVUwRHhKY0dKbVYv?=
 =?utf-8?B?OC9NWm4zNXZUZlljYkowa2Q3a2hwMlJGRVAyTGpEMTRIeUljT1VmT3FnRlFG?=
 =?utf-8?B?TnhDL3RFaVNOWDZ5QTBTOUZTNzdYMlJQbW9zbVVFdWErLys2YlM3WXp6Skl4?=
 =?utf-8?B?SEpaZmxxQnUxeXk5SGtkdDBzNFlzck9JendCUHZ6Y1JVK3cvbzl5enBtK00z?=
 =?utf-8?B?MVpOZ0RINTRjMjdNVG9ia3U0MU1PaExZODFCL3JhNTlrOXBEcU9lK2J5azNu?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <959DFE877623D5429C364067C22AE076@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89556365-3366-468a-f2e2-08da5d892af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:48:13.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cG9xPpTTGDdw/PkM21w4V+mZX/cCSbxaHdHRs6R8TBfTJvHDqmT8EviQv8GZE7+fma1mjkOqtSGrkb9H9uqQ+rXpNI1m5FtH3KJvxzL+1qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3014
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuMDYuMjAyMiAxNDowNSwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCB0aGUgbWNhbjEgbm9kZS4gQnkg
ZGVmYXVsdCwga2VlcCBpdCBkaXNhYmxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthdnlhc3Jl
ZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxpZWQg
dG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBpbmRleCAzY2IwMmZmZmU3MTYu
LjI1Y2ZhODlkZGU3YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBAQCAtNDczLDYg
KzQ3MywyMSBAQA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4gDQo+ICsgICAgICAgICAgICAgICBjYW4xOiBjYW5A
ZTA4MjAwMDAgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImJvc2No
LG1fY2FuIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZTA4MjAwMDAgMHhm
Yz4sIDwweDAwMTAwMDAwIDB4ODAwMD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZy1u
YW1lcyA9ICJtX2NhbiIsICJtZXNzYWdlX3JhbSI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8R0lDX1NQSSA3NCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDc1IElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiaW50
MCIsICJpbnQxIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtzIEdD
S19JRF9NQ0FOMT4sIDwmY2xrcyBHQ0tfSURfTUNBTjE+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBjbG9jay1uYW1lcyA9ICJoY2xrIiwgImNjbGsiOw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsa3MgR0NLX0lEX01DQU4xPjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDAwMDAwMDA+Ow0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBib3NjaCxtcmFtLWNmZyA9IDwweDQwMDAgMCAwIDY0IDAgMCAz
MiAzMj47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICsgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICAgICAgICAgICAgICAgICByZXNldDogcmVzZXQt
Y29udHJvbGxlckBlMjAwNDAwYyB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAibWljcm9jaGlwLGxhbjk2Nngtc3dpdGNoLXJlc2V0IjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4ZTIwMDQwMGMgMHg0PjsNCj4gLS0NCj4gMi4xNy4xDQo+IA0KPiAN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbA0KDQo=
