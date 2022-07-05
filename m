Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80618566ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiGEMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiGEMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:00:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9D118363;
        Tue,  5 Jul 2022 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657022438; x=1688558438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zuW5cITosvmTWuK5UEde8l0NPFYwfWFbAZ14hITU5ds=;
  b=altD3MujXn9Eowe8ejRVcEFCZF5aXCbUvoXmE01rGcsKrHtBnU36a5X1
   Goc5+L0V9y7tkPYBJ6oFdp/XOLXtxkWXwHcqei3dz2NXrlobPq9Kg9SDS
   +drIFCjsnlaB62w+h05pF9nxvFPFCpco/wKS9qU5TBnuAoQpHSDd3D10y
   j61b7rDeYw7bxqoFcDP7u2RXOsoQB9sL7ekEktOE2eRXHn23mYWXlmiS5
   3c43glRtcQ6uFSZHpCtzPYBg9rFV7gAOr6BYBlLPszdCi+Pe30rdESgtV
   YaYJuu5jwbM09ayq4ldkgssVnP10ZD7g2otPQCltkyxb0CHrUjpKt6WB+
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="171070502"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 05:00:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 05:00:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 05:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HigKqWh2bacek8aIk7WRDjJwaCi44T+i6AQBKhAXWG7QPuHwkUa/HJ4Y9MjJHu+ye4DdiyDOzxGPtxGxDr7cl13VYg2cu2U8wUqRekL7hKeTFABtI8vW80Zt23Cx3vXRR2hTWGR6PeHSzhat4t7re0Vr5q1nm/w82jMfmUl0cCAwLYMSc0U5JgRRzmf2d0lG/tuG7et34aMAC2xFheiuyKwkaX94CmInJpdsiESA0sRLyDmN9ULB4HdACdaD4DJL+KAXMOicTWDArqi1tm9jrh27rLI/cegaKt+wKY+SXZRjk/vYw0PeC7BbHKQDN1Gt9CAdyj9fj+P/r4tpSwvU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuW5cITosvmTWuK5UEde8l0NPFYwfWFbAZ14hITU5ds=;
 b=gOT5PsWvMyUlOIm0GKgdnnMHI9wdDqz7QnkvcLh64JKiYO5JP5pT0e2nkGijZFVK2UoHEIfDJLVZm4Jn1RWFqs+K3JTQwemyOsXpxFYYLJjfN1Vox39AxyYaHEx4blUEHacoqgyRd3cOfdVRvn6byeTlW2E17KFr+W/Kn9MrfM2JAedaPTT8hrL8RQYSvqV4ps0cZFMj+MXw5sR+5xArUMlZc/lj4Ds8vsIqTPoSi0TIazwPlBNapkOQVn/gtHe7gPUGX49wzj7rn0lXSmikBj5mA26s/wi+qtV/EWsoVC6w0307kDJg+Wh5yEb4kWfCoALs4ma2gsWNfescedDMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuW5cITosvmTWuK5UEde8l0NPFYwfWFbAZ14hITU5ds=;
 b=A18D3CkHL7j4DpkcZr0jxf5Rt9elMIpdzy9XYzYxDVSm9hk7u37oNy/bjl2ygmrbYFm9MJ3xBpu+jGje/JOAjYve6yOesK0qedH6F4ahM7Fh5QO3W+f1XDhV13AWQ0gtrgTOkxMXC+/CW+hnYNtdXr4bK5YaROVMhQM8W6MxVCs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 12:00:22 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9%9]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 12:00:22 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v6 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v6 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYkDylS4nKU2FbDUGrfIzLB4j3fa1vd0eAgAAz9+A=
Date:   Tue, 5 Jul 2022 12:00:22 +0000
Message-ID: <SA2PR11MB4874514AC2B74A46B4CA454192819@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220705065758.17051-1-kavyasree.kotagiri@microchip.com>
 <20220705065758.17051-2-kavyasree.kotagiri@microchip.com>
 <0ca30eca-5c12-4b58-ccbf-b008d3413d4f@microchip.com>
In-Reply-To: <0ca30eca-5c12-4b58-ccbf-b008d3413d4f@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98b8093a-2031-4a38-5a19-08da5e7df09d
x-ms-traffictypediagnostic: CO1PR11MB4801:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bYxYLfUvVrFlEBOc+b0R33GfC/WW2vRYShWBWTCdsUtERaxZwwOdSMIDStuvVbzYOA9VvKW0tPw6X/nqWWDkzjIkXUCghtKZKYvFFW8eyGB1DNln4V4GYnYDGXmD6dQ3OoGjqiGPRGNhBKIYAywTVR0Rzk26paUMFwvQvaCMXTjdmV3sp8MqC/h5hWtoUVWE5jNZ5nZga5M0bgUS0PvE3Os/joTlfQnWdavShX0+uCeKmixID+eizjxIbuYXE/HcrnhlpS9jVVTnXR3dO6r8qddgxGf7wnJgLv9qi2bEPB2N0YmYLajl/HSewMrrqt8q7O3Gyy4B+eyypnRzxAgFvB5QsteXlpMfm8nm4DSDDDwZ11MLElrH+v+d42ArtboNDKeQfk6OHmavL5RmN2DHGBmiK8qoYID4NyT0dCpGZ5XC4N6rPf6496zapzYSwpoQABQ7zmb30M6XPhzdzoDsSqzTYdkQW4H2kRqot4Vqv9oPxxwZll84/txcBMZ4UZhYIduY80u+DHoo3ggmWzqbRL0FzlXG81tK78E3iHlhumo5fLp/WOrFlwccwVIIJkgY10g+fo3JnecfiSaJoT/DFUp5mxxh2/7/5G2Rw/I1XwmskHtpy5y/shnAJuH1kbk2hUPsOMvxFbbhCIZ++bfj9g3TtI1nkg50NdunwRMzLfVeC393RR341+SwmsBp/YTPhvDRMWuEp+xWuL0lHxJXeXHsmP7rc6/K777TppjFcQMucthYDqPq5UDSlx2ax2uWzNSM44HvrFQMn22tvn/tcEHNPREaIm9cFrBICkAiAz+eKsbxVRk4GEkFIrY5S9fLkInURQlGwJYl8/aSh13dzvJmmb3T4sEAxFd+ft11XAHy+q4JbSZ3RjhnMyxi9vY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(366004)(396003)(966005)(478600001)(8936002)(2906002)(52536014)(6862004)(83380400001)(66946007)(71200400001)(76116006)(5660300002)(86362001)(9686003)(55016003)(26005)(186003)(107886003)(33656002)(122000001)(41300700001)(38070700005)(7696005)(6506007)(66556008)(66446008)(64756008)(38100700002)(8676002)(6636002)(66476007)(54906003)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFE2NUtzOEZjUGZKMlFWeHVHdXEzUGR6NHJqQVUwTzFhZ0VndFhyQ2RvaGRT?=
 =?utf-8?B?MzNKZGJXSXJkMTBqcVRBZXlIeDhQYWJjWnR4YUlZZU0wNC9NdXhYZ1VaeGhF?=
 =?utf-8?B?N250c2w4L2JPcitEK2UzaFVvbEQyZEtydmY2VnBGV2F0akJUc3BZZFNDRmdT?=
 =?utf-8?B?Tkdib2NKUk1JaGwwWGM1RU5CQXRQZUlLZE1kSEhtZjNON0t1L1hqRU12c0hM?=
 =?utf-8?B?OGdVY0tOWGtXY0JlRUxBMFp4eHZsUlpyV29Pa2sxTHM3S2lva1FqdnljaTFh?=
 =?utf-8?B?ejNyVnlNWUpyNkd2b3hBYWxsWTBCVVdHclBtb2RkRHZCYU9DL05LaFQ5NERJ?=
 =?utf-8?B?Qi9uWHpnVEJLSVFuY3hGbEpCbG45a2hIZHVuaVFpR05uS2tmdVNSSlF1YW9r?=
 =?utf-8?B?L3cwbnluNmticmpMNUVybm9PVFIrQVRqbWF5VVlzVVNwOE5ONHRjYnZrZitH?=
 =?utf-8?B?OU9FSmNtbFBZUU1Jem5VWjh0U3lXcnlIWWMveUdJWloyUTVhem5Kem11K2x6?=
 =?utf-8?B?cDYwSUFYRG54YjZwSUVqQWxZNm95anZTdzRsbGJOaFhlYk9LNjg4blFnWFN0?=
 =?utf-8?B?cVJNZ2hyRFEwaVpUSWxHWmNES3BkdHVPenhVeFhaejhmdjRzbWZmd2xPcmhZ?=
 =?utf-8?B?N1FCa0hIN1FlZzR2T1AwdmdMSElRTXhoY1RNclU3MmR3UDVDazhFaFdKL3FC?=
 =?utf-8?B?QUFYdjl5aS9BZk9hcHNvNkx4VUorR0RTQkxSZlFMVlpqZHdmTllpRjZqaTdF?=
 =?utf-8?B?aERTNHh1b0QxZ3NKdkRPcjJiR2RmZTNEYmkzQVBHT0pvTXM3RUZKRkI0V3NG?=
 =?utf-8?B?dWpITGZZZ3FId3F0VHBsOUVWeUNQOEVnUnFubVVxcWo5VDRpOUJTZ3d2TzlC?=
 =?utf-8?B?NkRUNnFuQWpiNDE2VDlrci9ERnYwV1oveTZwWEkzS09RRkZEQ0NlbG53SERD?=
 =?utf-8?B?SW8yTGJ6aGJ5NXI2RmJiSFgwRXlZMUZBZmtYbzVJbVhvWkNxZmtxYjMzM0sw?=
 =?utf-8?B?U0NsQmloaUhZVG5wMUFVZEdXR0h6clZmNUVlWkVIOFBaVzZIVlhWOGpzb3VW?=
 =?utf-8?B?OFU3QzlYbDhlWnlUQUhKNzFVdkVQbENvSDZnSUZwT0IzQlVPSkQvbTZBeFJZ?=
 =?utf-8?B?c1QyRW9xQjduYm9sR0tEL3lwRVU4MkcrTEt2OFNaT2lKWUZHbk8raWdzWFcw?=
 =?utf-8?B?R2NtMG1kcGZDeWttbXR1R2xoUGMySTJGY0NxTUZRc09NT3h6LzZLdUVUaTF4?=
 =?utf-8?B?NGRVdW5mT2lCbHdYNlByVHJ1V1ltbTd6bGtqSHVvT2JlVS9Ra0FVb0QyWTNQ?=
 =?utf-8?B?ajBtMGxmWkwxTFZrSkZYZTBta1VPT2hyRkNIME9aUmZLOW9tY3dVTFVwN0wr?=
 =?utf-8?B?bXh0ZzlhdFlBUFI2YnJSKzRGM2NhZXM0RlRGazg1TnJQYTFldWJiMnFYSW5q?=
 =?utf-8?B?TmRNTzI5VHNxZ1ZZaW1xUTFDdlROTUNielZwNXBRdkwrTW1KTy9XcFBMQmlR?=
 =?utf-8?B?bm8vYTlaYTRtS1pqTURHL2lHRHZhUC9PZGpYNGV4UnpFUUdFY0YrZHVyMTRQ?=
 =?utf-8?B?MEJOOVRxWUd3eVdUTk1KTnNoU3dOTnBkVVlTdmdQdFZJemNJdFVHVnlrakhi?=
 =?utf-8?B?c0lTZ0RQUFlUQmJVc0dnK2w2NGh5TzV6cmxQV2JyYkVIZy9EeWdYTW90QTV4?=
 =?utf-8?B?MFZoOEdNK3UyS2VwaDd5WHJyY3hkWnV4anNuKzg2Y0p0SkZOSUlQdXUycXNn?=
 =?utf-8?B?V0JWVEtpc0krWXR4bEZ4S01LcVZJdUV2R1UzU1I0UXRicHFoT2FhcWJoT1Jm?=
 =?utf-8?B?cHdzbXNkSUtKZWZnNnBWbHNaM3FLK2F2Sm9kKzE4VVpLbnNRWXBsTHNLRDVU?=
 =?utf-8?B?MlkzVVpWZEF1K3pqR3kwVUtyeHZXU1IxVDRrZlZkeVpaZER6RzJFWUgwZzJm?=
 =?utf-8?B?OVB4ODRQUXJ6eGhNcFRDOUNzanhFbGV0aG5YMUxWVFJPblpGUUphYngwTy9i?=
 =?utf-8?B?dzNQeUg5Q1Y3cXU0NytaQ3llenowK2NxMENKVWRoZmJyUlBzZUROSU82ZW41?=
 =?utf-8?B?RWVTd2ZqbklocFhIWW1RQ2I3SzBxcmo3ekY1V3ZoTEU1NHZBbXpibGR0dVQ2?=
 =?utf-8?B?dFBEYWRZbWZZa3FpWnFkL0l1OUlYa05qamhkTjFQS2pRbThoTXVPeHlNdWRT?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b8093a-2031-4a38-5a19-08da5e7df09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 12:00:22.6644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a70gKOtENFA8CSvR3lcjs1lsRBdV58yJXBnK22VWmotidN1JocmhxOnhpQGojiZmPUGdKgbfVET0pfEhHT+JFgFlpaujBtecceuQ52mx+qkw5hZh4d0vrYwMzXuXYr5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IENvbnZlcnQgdGhlIEF0bWVsIGZsZXhjb20gZGV2aWNlIHRyZWUgYmluZGluZ3MgdG8ganNv
biBzY2hlbWEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkgPGth
dnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+
ID4gdjUgLT4gdjY6DQo+ID4gIC0gUmVtb3ZlZCBzcGkgbm9kZSBmcm9tIGV4YW1wbGUgYXMgc3Vn
Z2VzdGVkIGJ5IFJvYiBhbmQNCj4gPiAgICBhbHNvIHBhdHRlcm4gcHJvcGVydGllcyhzcGkgZHQt
YmluZGluZ3MgY29udmVyc2lvbiB0byB5YW1sIHBhdGNoIGlzIHVuZGVyDQo+IHJldmlldykuDQo+
ID4gICAgT25jZSB0aGF0IGlzIGFjY2VwdGVkLCBJIHdpbGwgYWRkIGJhY2sgc3BpIGV4YW1wbGUg
dGhyb3VnaCBuZXcgcGF0Y2guDQo+ID4NCj4gPiB2NCAtPiB2NToNCj4gPiAgLSBGaXhlZCBpbmRl
bnRhdGlvbnMuDQo+ID4NCj4gPiB2MyAtPiB2NDoNCj4gPiAgLSBDb3JyZWN0ZWQgZm9ybWF0IG9m
IGVudW0gdXNlZCBmb3IgY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4NCj4gPiB2MiAtPiB2MzoNCj4g
PiAgLSB1c2VkIGVudW0gZm9yIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+ICAtIGNoYW5nZWQgaXJx
IGZsYWcgdG8gSVJRX1RZUEVfTEVWRUxfSElHSCBpbiBleGFtcGxlLg0KPiA+ICAtIGZpeGVkIGR0
c2NoZW1hIGVycm9ycy4NCj4gPg0KPiA+IHYxIC0+IHYyOg0KPiA+ICAtIEZpeCB0aXRsZS4NCj4g
Pg0KPiA+ICAuLi4vYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbCAgICAgICAgICAgfCA3
MiArKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
dG1lbC1mbGV4Y29tLnR4dCB8IDYzIC0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCA3MiBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxl
eGNvbS55YW1sDQo+IA0KPiBBRkFJQ1QgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgaXQgbmFt
ZWQgYXRtZWwsc2FtYTVkMi1mbGV4Y29tLnlhbWwuDQo+IA0KSSBzZWUgbW9zdCBvZiB0aGUgeWFt
bCBmaWxlbmFtZXMgaGF2ZSBmb3JtYXQgb2YgInZlbmRvciwgZnVuY3Rpb24ueWFtbCIuRm9yIGV4
YW1wbGU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwscXVhZHNw
aS55YW1sDQpTbywgSSB0aGluayBpdCBpcyBvayB0byB1c2UgImF0bWVsLGZsZXhjb20ueWFtbCIu
DQoNCj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0KPiANCj4gPiAgZGVsZXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtDQo+IGZs
ZXhjb20udHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5mNTc3YjhkOGUxZWENCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
dG1lbCxmbGV4Y29tLnlhbWwNCj4gPiBAQCAtMCwwICsxLDcyIEBADQo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMv
bWZkL2F0bWVsLGZsZXhjb20ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQXRtZWwgRmxl
eGNvbSAoRmxleGlibGUgU2VyaWFsIENvbW11bmljYXRpb24gVW5pdCkNCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICsgIC0gS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdp
cmlAbWljcm9jaGlwLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBB
dG1lbCBGbGV4Y29tIGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNoIGVtYmVkcyBhIFNQSSBjb250cm9s
bGVyLA0KPiA+ICsgIGFuIEkyQyBjb250cm9sbGVyIGFuZCBhbiBVU0FSVC4gT25seSBvbmUgZnVu
Y3Rpb24gY2FuIGJlIHVzZWQgYXQgYQ0KPiA+ICsgIHRpbWUgYW5kIGlzIGNob3NlbiBhdCBib290
IHRpbWUgYWNjb3JkaW5nIHRvIHRoZSBkZXZpY2UgdHJlZS4NCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gYXRt
ZWwsc2FtYTVkMi1mbGV4Y29tDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0K
PiA+ICsgICIjYWRkcmVzcy1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsNCj4gPiAr
ICAiI3NpemUtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgcmFuZ2Vz
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIE9uZSByYW5nZSBmb3IgdGhlIGZ1
bGwgSS9PIHJlZ2lzdGVyIHJlZ2lvbi4gKGluY2x1ZGluZyBVU0FSVCwNCj4gPiArICAgICAgVFdJ
IGFuZCBTUEkgcmVnaXN0ZXJzKS4NCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICBtYXhJdGVt
czogMw0KPiA+ICsNCj4gPiArICBhdG1lbCxmbGV4Y29tLW1vZGU6DQo+ID4gKyAgICBkZXNjcmlw
dGlvbjogfA0KPiA+ICsgICAgICBTcGVjaWZpZXMgdGhlIGZsZXhjb20gbW9kZSBhcyBmb2xsb3dz
Og0KPiA+ICsgICAgICAxOiBVU0FSVA0KPiA+ICsgICAgICAyOiBTUEkNCj4gPiArICAgICAgMzog
STJDLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gKyAgICBlbnVtOiBbMSwgMiwgM10NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+
ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAt
ICIjYWRkcmVzcy1jZWxscyINCj4gPiArICAtICIjc2l6ZS1jZWxscyINCj4gPiArICAtIHJhbmdl
cw0KPiA+ICsgIC0gYXRtZWwsZmxleGNvbS1tb2RlDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJv
cGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4N
Cj4gPiArDQo+ID4gKyAgICBmbHgwOiBmbGV4Y29tQGY4MDM0MDAwIHsNCj4gPiArICAgICAgICBj
b21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7DQo+ID4gKyAgICAgICAgcmVnID0g
PDB4ZjgwMzQwMDAgMHgyMDA+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmZmx4MF9jbGs+Ow0K
PiA+ICsgICAgICAgIHJhbmdlcyA9IDwweDAgMHhmODAzNDAwMCAweDgwMD47DQo+ID4gKyAgICAg
ICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwt
ZmxleGNvbS50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0
bWVsLWZsZXhjb20udHh0DQo+ID4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgg
OWQ4Mzc1MzU2MzdiLi4wMDAwMDAwMDAwMDANCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLWZsZXhjb20udHh0DQo+ID4gKysrIC9kZXYvbnVsbA0K
PiA+IEBAIC0xLDYzICswLDAgQEANCj4gPiAtKiBEZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgQXRt
ZWwgRmxleGNvbSAoRmxleGlibGUgU2VyaWFsIENvbW11bmljYXRpb24NCj4gVW5pdCkNCj4gPiAt
DQo+ID4gLVRoZSBBdG1lbCBGbGV4Y29tIGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNoIGVtYmVkcyBh
IFNQSSBjb250cm9sbGVyLCBhbiBJMkMNCj4gPiAtY29udHJvbGxlciBhbmQgYW4gVVNBUlQuIE9u
bHkgb25lIGZ1bmN0aW9uIGNhbiBiZSB1c2VkIGF0IGEgdGltZSBhbmQgaXMNCj4gY2hvc2VuDQo+
ID4gLWF0IGJvb3QgdGltZSBhY2NvcmRpbmcgdG8gdGhlIGRldmljZSB0cmVlLg0KPiA+IC0NCj4g
PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtLSBjb21wYXRpYmxlOgkJU2hvdWxkIGJlICJh
dG1lbCxzYW1hNWQyLWZsZXhjb20iDQo+ID4gLS0gcmVnOgkJCVNob3VsZCBiZSB0aGUgb2Zmc2V0
L2xlbmd0aCB2YWx1ZSBmb3IgRmxleGNvbQ0KPiBkZWRpY2F0ZWQNCj4gPiAtCQkJSS9PIHJlZ2lz
dGVycyAod2l0aG91dCBVU0FSVCwgVFdJIG9yIFNQSSByZWdpc3RlcnMpLg0KPiA+IC0tIGNsb2Nr
czoJCVNob3VsZCBiZSB0aGUgRmxleGNvbSBwZXJpcGhlcmFsIGNsb2NrIGZyb20gUE1DLg0KPiA+
IC0tICNhZGRyZXNzLWNlbGxzOglTaG91bGQgYmUgPDE+DQo+ID4gLS0gI3NpemUtY2VsbHM6CQlT
aG91bGQgYmUgPDE+DQo+ID4gLS0gcmFuZ2VzOgkJU2hvdWxkIGJlIG9uZSByYW5nZSBmb3IgdGhl
IGZ1bGwgSS9PIHJlZ2lzdGVyIHJlZ2lvbg0KPiA+IC0JCQkoaW5jbHVkaW5nIFVTQVJULCBUV0kg
YW5kIFNQSSByZWdpc3RlcnMpLg0KPiA+IC0tIGF0bWVsLGZsZXhjb20tbW9kZToJU2hvdWxkIGJl
IG9uZSBvZiB0aGUgZm9sbG93aW5nIHZhbHVlczoNCj4gPiAtCQkJLSA8MT4gZm9yIFVTQVJUDQo+
ID4gLQkJCS0gPDI+IGZvciBTUEkNCj4gPiAtCQkJLSA8Mz4gZm9yIEkyQw0KPiA+IC0NCj4gPiAt
UmVxdWlyZWQgY2hpbGQ6DQo+ID4gLUEgc2luZ2xlIGF2YWlsYWJsZSBjaGlsZCBkZXZpY2Ugb2Yg
dHlwZSBtYXRjaGluZyB0aGUgImF0bWVsLGZsZXhjb20tbW9kZSINCj4gPiAtcHJvcGVydHkuDQo+
ID4gLQ0KPiA+IC1UaGUgcGhhbmRsZSBwcm92aWRlZCBieSB0aGUgY2xvY2tzIHByb3BlcnR5IG9m
IHRoZSBjaGlsZCBpcyB0aGUgc2FtZSBhcw0KPiBvbmUgZm9yDQo+ID4gLXRoZSBGbGV4Y29tIHBh
cmVudC4NCj4gPiAtDQo+ID4gLUZvciBvdGhlciBwcm9wZXJ0aWVzLCBwbGVhc2UgcmVmZXIgdG8g
dGhlIGRvY3VtZW50YXRpb25zIG9mIHRoZSByZXNwZWN0aXZlDQo+ID4gLWRldmljZToNCj4gPiAt
LSAuLi9zZXJpYWwvYXRtZWwtdXNhcnQudHh0DQo+ID4gLS0gLi4vc3BpL3NwaV9hdG1lbC50eHQN
Cj4gPiAtLSAuLi9pMmMvaTJjLWF0OTEudHh0DQo+ID4gLQ0KPiA+IC1FeGFtcGxlOg0KPiA+IC0N
Cj4gPiAtZmxleGNvbUBmODAzNDAwMCB7DQo+ID4gLQljb21wYXRpYmxlID0gImF0bWVsLHNhbWE1
ZDItZmxleGNvbSI7DQo+ID4gLQlyZWcgPSA8MHhmODAzNDAwMCAweDIwMD47DQo+ID4gLQljbG9j
a3MgPSA8JmZseDBfY2xrPjsNCj4gPiAtCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+IC0JI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4gLQlyYW5nZXMgPSA8MHgwIDB4ZjgwMzQwMDAgMHg4MDA+Ow0K
PiA+IC0JYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiA+IC0NCj4gPiAtCXNwaUA0MDAgew0K
PiA+IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiA+IC0JCXJlZyA9
IDwweDQwMCAweDIwMD47DQo+ID4gLQkJaW50ZXJydXB0cyA9IDwxOSBJUlFfVFlQRV9MRVZFTF9I
SUdIIDc+Ow0KPiA+IC0JCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gLQkJcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2ZseDBfZGVmYXVsdD47DQo+ID4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+ID4gLQkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gLQkJY2xvY2tzID0gPCZmbHgwX2Ns
az47DQo+ID4gLQkJY2xvY2stbmFtZXMgPSAic3BpX2NsayI7DQo+ID4gLQkJYXRtZWwsZmlmby1z
aXplID0gPDMyPjsNCj4gPiAtDQo+ID4gLQkJZmxhc2hAMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUg
PSAiYXRtZWwsYXQyNWY1MTJiIjsNCj4gPiAtCQkJcmVnID0gPDA+Ow0KPiA+IC0JCQlzcGktbWF4
LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+ID4gLQkJfTsNCj4gPiAtCX07DQo+ID4gLX07DQoN
Cg==
