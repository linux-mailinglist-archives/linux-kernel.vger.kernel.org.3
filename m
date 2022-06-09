Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B45450D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbiFIP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiFIP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:29:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0CA44B;
        Thu,  9 Jun 2022 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654788595; x=1686324595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HwHigHJcniU9knds2UCoBpDmY8FH768qOYTwChm0uQY=;
  b=AoVuaz/2gLdVgX1xGdc6GnHemvgIsaZch+pKKELVJCvwzgFGT0+/eBpr
   J/mW/RwPRgf8QI9HE69yurF9pjJuSHOptp2qkU0FFZwcCyEpCHONOi1/D
   BxDT6DQ3PO5CvM8SPOBOOhYZ4M5BjRiviJTH4kHs76NSgU3y0BvDtFyYX
   6UUQVuGZk/hs+HuCVQLYaNXOY9vSwEZKJDcDDm15To6i/88KFm7K6Qj/j
   xA3MU5XLwKvQwPgk0oQLVkrQ55Q+twdfR6xmqgVl3BcVelyVdhUlwlaa1
   4sb1hHNGl9tigpm2LCCDJT0d3tqGhQwefkgLpcSHf70mXtRxQPhJ/PRfl
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167780113"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 08:28:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 08:28:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 08:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVbJd1oPhCeQmNTqKbYdFw0gF6XMVXNmjupnGCm3/mUdjOdtZXSmFdPXKBVXrP+uEdIazS+HIrZcvnHyuB0ZKSyls5X7Cnd6s/CVH8T1HyHRf8qwx+F9PmUtSwI1C0MPE0Im8EoiJ6GWFxQYup8b0p1sEWtN8xuOO5nGY1LJ4yzcaFQpBzXQR6osZU7mFy9IjULb6s886bU9d2zJ0r8FBHF+TMuVFjxds+6/4oGNkssfIi/NvHu4hX/lG96KzgLrkjBYj7+PN93nzoeehDh0bRc0RM+H9kmtvVYZ4HCDPCmslZfeYBRoLfjc46PqnTFc4HNP4BKFhmncuq3X4UqocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwHigHJcniU9knds2UCoBpDmY8FH768qOYTwChm0uQY=;
 b=mXRcQnb0LxcAyesL5cS8d/u6v7mA11XvBGda0AM6KTqcSpaCcFoF09/FSuj6MgE5rtP011G9rpFgllQvQTuhcMJ59c3Iqwzx5VbusQa936T/uWjahzgYdxDEfMq6nMKPVGrlIrjtTrFx7fSQDf/ffgOp0sK0/nJVPPBdKkpJwMY+LQrrJw+7KhgdjK1xSWEIA9of5GrjW7yUrWEu2Nooe2Mn/C/5JeEFdgseW2Cilr493uZn3Mbhedp4HT6Xh4DUQaOmtqu1cSfkwWBcVKZLPaB61A6jReJzDl5MPB4Wx1NRNBCCr/ovhoEXuHKFBRX6Vs1/dycFe9uNsctX3HHBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwHigHJcniU9knds2UCoBpDmY8FH768qOYTwChm0uQY=;
 b=TvrPLV7sd2B2RTCS03NPGlQYJBYxgQJv/zIIl1d//EDhBldJH78PJ8Nhe96KSEjTribpixujRjo5q7Cf3yaZ81+CHyFhWD8nghF6TnAtQ0nls/5uXzi8DUWX+ZzUZhTSeAhbKlhgP/y8AEYRcJOBposwak3uwBNIEOGIkGHSTRo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR1101MB2084.namprd11.prod.outlook.com (2603:10b6:405:50::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 15:28:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 15:28:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <yang.lee@linux.alibaba.com>
CC:     <andi@etezian.org>, <broonie@kernel.org>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: Return true/false (not 1/0) from bool function
Thread-Topic: [PATCH -next] spi: Return true/false (not 1/0) from bool
 function
Thread-Index: AQHYfBWGK6vLozsMNkCTl//OwTjqNg==
Date:   Thu, 9 Jun 2022 15:28:10 +0000
Message-ID: <e28c0a30-9d49-f366-9562-f5a254bb4b09@microchip.com>
References: <20220609060323.106095-1-yang.lee@linux.alibaba.com>
 <c0062aad-50f2-a9ea-ad04-8af9e70f8bba@linaro.org>
In-Reply-To: <c0062aad-50f2-a9ea-ad04-8af9e70f8bba@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d04134b-2875-41d7-0cb5-08da4a2ca951
x-ms-traffictypediagnostic: BN6PR1101MB2084:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB2084B718402F8AE1679371E598A79@BN6PR1101MB2084.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffihogz63wwatbw2t5cYFogzDVyc1WrxKUA+oMB3dkRAtWALB+NXwLbgTmjezSzE1GMAQUa1lSeVn2b1x6gynJXQe0jyLYmY65dC2eUy5LFaLschZoCeMvce/KKP13socLCgMdDfyrg1ioWetgrmpGZc+i8ytAHzvC/5jSXCTJ+vY+G7gO9+PfEeNUBhunoIoR2kGCEkf5287NKp0G9JdZeK7oyn4iL7dYkfrn9k53WsAgssT46I5/dZ2Y1XcVVb/6MeEYTk0HZHOubTRNPEkdcT1Hzvti24SavP8CwJ+yQyM6FR8ZUp22ySnCaRPQbR7SyEGoTGsxfRqpan2mzSxLkWbvGRsU1v22oSbOBpEBwB6ymOLvMTQ/R9CCGBiXD1Ezb4KpIKVUyMorqM6pEKIWLMjoS1C7sq+p14PHU8G5H0XtiqIUFEG09n9rFv0N/UP42uqGnHyFO4p2wU1gw8NmvsoYPFtQEU9y0Lxltx8/9qTednnVmmdCPDwALxSD8WymoP1SQaK6SMnNs16p8k7BaDHoIdJi53hJNlW4NV9tdmGGydz3WztIWQsnVw1Ap/PgeLYAMxNbXY2c9IzrRTOYp4ybBVodZctX5yeUARo3RgPGY2mrLksoYkmR4nJ4WdRU8XY9FeVFlAGG14grbJR7oXXsf16Ii7tq+9pwxE1GsG/KoLZJxqYCV4RiruNEPeiT4ijKRhG69Y/FcV4CXuomR0n8PlH27nSZZlBaV27LHN1uQiUHYvppAX8JnzrMK+y7KQMH7+K9n2NzZEwfpdCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(31696002)(86362001)(38100700002)(122000001)(38070700005)(5660300002)(508600001)(7416002)(2906002)(6486002)(316002)(54906003)(71200400001)(91956017)(4326008)(64756008)(66476007)(186003)(8676002)(66446008)(66556008)(66946007)(76116006)(83380400001)(53546011)(6506007)(2616005)(26005)(6512007)(31686004)(110136005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3dOaWQrbDB1RUo2OTlTeDNqaE1vc1hmTHJSYkpjNzVvT0UyRnJiTFpkTGVL?=
 =?utf-8?B?VXp2Sk0vK1JWRDdLaVptUSt5cGY0OEhTRkY4NG5wOGdCMXhXVitZWFFMbU5N?=
 =?utf-8?B?YkQzK1I1QVJRR3d4MWZwUVBIVWZKR0drTFNWVkNyVGN3dVBkY3Zram1HS29C?=
 =?utf-8?B?VVI1dURpa1E0TTlvNTlRdVlyOXNLQTBOYVc0aW1xNURFSU9xUXZIYnJwcG83?=
 =?utf-8?B?aFZGa3IzRWZiWVhPWlpzb29nWlJNeXFXSUNFNzh6M0RzOU1MaTJsZ21hOFhS?=
 =?utf-8?B?a2UzZTFCNE9COUUyOGJhQXdKMjlsUDNDazhSSFFyZ3loeTdobiszMlN1ZWdn?=
 =?utf-8?B?bkxEejhWaTJLRnovOEN4c0FNU3lMZnBGNUwyV3B1MDRkRHVRdTRVanA2V1NO?=
 =?utf-8?B?QlhFM3BtbUJ4OGQ0anI3aGNNTzE0djhKOVhydktESjFObEFDM2s3RDZDRldJ?=
 =?utf-8?B?YU5JS29ycllydWI5VGpYdE9mOGFTNjgvK1NTS1p0cytheDJ6K09PeUF2OGln?=
 =?utf-8?B?ZU9odXZQRWlsRUVlbzVBdnVCdFNRNC9rT0pRV2UxbWtQSXB4a05PTWJObHhC?=
 =?utf-8?B?K0VyMDJHN3hoZytYcHJ6WjVlcTNEWnM4NTErTjZ6QUowZHYrOGZmWWcvckJW?=
 =?utf-8?B?bHI2V09FcktyUC81YUZjZnZqQm5Ddmc3VGlJY1NLYWRXSml1dDV0UnlHTldW?=
 =?utf-8?B?TVlWMGR1cjNMSXFZWWNsVVdMQ3lHSkxualdCWXYrRTdzc2ZJdjhhZGhQQUlJ?=
 =?utf-8?B?dHBEeEZnYy8zNktGcHc0OUJoYU5hZ1VzZ3dVQ1VJS0VLNEQwY01rdUtuUVFK?=
 =?utf-8?B?ZXB6ZGtJYktld0dzTFg2Z2FkdDhTam5relU2VXpZMElWUlpDdGVBYkUyMm8w?=
 =?utf-8?B?TVY2ZmY1RmlFcVY1ZitMZzVWVEZBbGpUYWxlNXlGVkZKQ3g4L2diM0FDYWZV?=
 =?utf-8?B?VFoxSmh5SnVvMmtlOGgzQ05YN0hxSGc4dlplaHNZZzV1OVE1cUQwSFd5a2ZU?=
 =?utf-8?B?ZE9xK2xreFdyTWw3STEySkVEWi96bFhZTnMvRWlMckl4UlBWNVpDcEc0d0pZ?=
 =?utf-8?B?WUZLQXpzZ2pxc2JTckl2MDFtUXBDYXFTSnFtbHNRVWc3ZnJVOXZmZTk0em5V?=
 =?utf-8?B?WWtJampTUWtzQ0krS3dFVnlYUTJBUERoUEFFczZ4a1hDVWcwdTVHaG9abER5?=
 =?utf-8?B?NnlaWnpKVlcxZXFxL2M1SUZMbEtpaXFpMm1PZkV3TC8vVzZtWTdLS1JQMmlh?=
 =?utf-8?B?bll4T0hZVUp6YXR5bFFQaHhNWTYwK2VBQkY1UGZWTmN0R0tMQjIxTzNPaEhp?=
 =?utf-8?B?MnNRREhuM0FFVHp6RzlCMzZmSWtBWExwLzR3TEdPaVZGMXNPWkxhU1lUMldM?=
 =?utf-8?B?NkhQQzhrcjN3RGxtcUxjcmwyYjVaT3pIT2FFUWJXcGxpNnczMnRFZUVvN2NV?=
 =?utf-8?B?cm5KMkIrWEIxdDY4TG93YWFyWk1YN3IvRS9mdlY5UkMxcEdqMDNLSWtmNmJj?=
 =?utf-8?B?bXRBL05uSjA5a3hXaUNSdFF1bVZveTNRbVM4SktHazl5M0s0YTBsQis3dDhu?=
 =?utf-8?B?VVpQazlqaE8xZjBVYkpjQ3A5SEtrUHFaRjNMM0U3bUtxMjBmYXhaOHFOUFNS?=
 =?utf-8?B?eVYzYnhOQm5Va1Y1L2o2Q2oyZVBEdlJ4Vk9XdDEyTzVySHZrYmQ5ekJHSVZQ?=
 =?utf-8?B?LzFnRzFnYkJqNFhuTVJjWmFyWGJMeXlwRGQwWks3ZG9LZS9lblJ1NTBXY0I4?=
 =?utf-8?B?cU9YOXBROVVnVnVDUEFjVzRNZlAzK29IWjVLQnMzY0ZmS1JKNld1am85d1J1?=
 =?utf-8?B?UzhhakwzRmNIcUszbHA2Ri9QK1JyTzNEWjN6d0RRSTJBcjV3WTdvcDVFNEYx?=
 =?utf-8?B?OENwY1ZqaHN1SWszeTY2VU5yVTd3S2ZVS1pXd3F6MXdteS9HNk5HM2dZdGlo?=
 =?utf-8?B?UmU2MXFDMERDekhNL3BYN0NQUlJZandteE9MODZIUGVteHpTQU50UHpJWmps?=
 =?utf-8?B?WU8va09hYWVNWk5KdHhyVEk3UE5RbTE4R1NBNVZOYklZdHMyR0JYb2NHYXpH?=
 =?utf-8?B?VU14bU1mUHFrYklNajMwOHBvODVoQ3V0YkVMWUhWL3NMQVBab0h2djBPKy83?=
 =?utf-8?B?MCt0MmdlQmY2eS9Kd0p6OGUzd1l5VU54S00wazVqam1JWWpOQUxZQ3J1RzJQ?=
 =?utf-8?B?bkRBdGZJT2RGS1E1Y3F1TFZwelY0UzltWW8raENsWTZEaFNuYkNUZnRrcUlT?=
 =?utf-8?B?QW82eVNDbFJOMXo5MWZCUkE1aVJZMmhocUh6RlZhcXFFM3RtOFZUOUtXcDc1?=
 =?utf-8?B?dnpWUEpiYnVtVUNYd2hDTTAzWVduV1Qwc2gxMTJrVzNSalhEK0lUWnBOWVBL?=
 =?utf-8?Q?4SW2QhU9Pk6P4sBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5AAA620887EA24589E8D543CB2BC40D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d04134b-2875-41d7-0cb5-08da4a2ca951
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 15:28:10.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSNGPvKxv1r0TDarWv59weVp7OcE3DD7/Tk//LMeJSb5GNpbUBYfgNTczf7mKAbeakhFVG2tbZmnWdYQNoSYMlX2s+gG0+m2BwunipyrxOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2084
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDYvMjAyMiAwNzozNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDkv
MDYvMjAyMiAwODowMywgWWFuZyBMaSB3cm90ZToNCj4+IFJldHVybiBib29sZWFuIHZhbHVlcyAo
InRydWUiIG9yICJmYWxzZSIpIGluc3RlYWQgb2YgMSBvciAwIGZyb20gYm9vbA0KPj4gZnVuY3Rp
b24uIFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5ncyBmcm9tIGNvY2NpY2hlY2s6DQo+
Pg0KPj4gLi9kcml2ZXJzL3NwaS9zcGktczNjNjR4eC5jOjM4NTo5LTEwOiBXQVJOSU5HOiByZXR1
cm4gb2YgMC8xIGluIGZ1bmN0aW9uDQo+PiAnczNjNjR4eF9zcGlfY2FuX2RtYScgd2l0aCByZXR1
cm4gdHlwZSBib29sDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51
eC5hbGliYWJhLmNvbT4NCj4gDQo+IEl0IHdhcyByZXBvcnRlZCBieSBjb2NjaW5lbGxlLCBub3Qg
cm9ib3QsIHdhc24ndCBpdD8NCj4gDQo+IEkgY2Fubm90IGZpbmQgdGhpcyByZXBvcnQuIA0KDQpZ
ZWFoLCBJIHdhcyBzaW1pbGFybHkgY29uZnVzZWQgYnkgdGhlIHBhdGNoZXMgb24gbXkgZHJpdmVy
Lg0KU3BlbnQgc29tZSB0aW1lIGRpZ2dpbmcgdGhyb3VnaCBxdWFyYW50aW5lIHN5c3RlbXMgZXRj
IHRvDQp0cnkgYW5kIGZpbmQgdGhlIHJlcG9ydCAmIGNvdWxkbid0Lg0KDQpJIGhvcGUgSSBkaWRu
J3QgbWlzcyBzb21ldGhpbmcuDQoNCj4gVGhpcyBpcyBhbiBvcGVuIHNvdXJjZSB3b3JrIGFuZCBw
dWJsaWMNCj4gY29sbGFib3JhdGlvbi4gVGhlICJSZXBvcnRlZC1ieSIgdXN1YWxseSBtZWFucyB0
aGF0IHRoZSBpc3N1ZSB3YXMNCj4gcmVwb3J0ZWQuIFVzdWFsbHkgaW4gcHVibGljLiBDYW4gd2Ug
c2VlIHRoZSByZXBvcnQ/DQo+IE90aGVyd2lzZSBhZGRpbmcgbm9uLXB1YmxpYyByZXBvcnRzIGlz
IHVzZWxlc3MgYW5kIGNsdXR0ZXJzIG91cg0KPiByZXBvcnQtY3JlZGl0LXN5c3RlbS4NCj4gDQo+
IA0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgTGkgPHlhbmcubGVlQGxpbnV4LmFsaWJhYmEu
Y29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9zcGkvc3BpLXMzYzY0eHguYyB8IDIgKy0NCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLXMzYzY0eHguYyBiL2RyaXZlcnMvc3BpL3NwaS1zM2M2
NHh4LmMNCj4+IGluZGV4IDgyNTU4ZTM3YzczNS4uMjhlN2I3Y2I2OGE3IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9zcGkvc3BpLXMzYzY0eHguYw0KPj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLXMz
YzY0eHguYw0KPj4gQEAgLTM4Miw3ICszODIsNyBAQCBzdGF0aWMgYm9vbCBzM2M2NHh4X3NwaV9j
YW5fZG1hKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIsDQo+PiAgCWlmIChzZGQtPnJ4X2RtYS5j
aCAmJiBzZGQtPnR4X2RtYS5jaCkgew0KPj4gIAkJcmV0dXJuIHhmZXItPmxlbiA+IChGSUZPX0xW
TF9NQVNLKHNkZCkgPj4gMSkgKyAxOw0KPj4gIAl9IGVsc2Ugew0KPj4gLQkJcmV0dXJuIDA7DQo+
PiArCQlyZXR1cm4gZmFsc2U7DQo+PiAgCX0NCj4+ICANCj4+ICB9DQo+IA0KPiANCj4gUmV2aWV3
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
