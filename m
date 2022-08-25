Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8165A1689
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbiHYQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiHYQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:17:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF2923DD;
        Thu, 25 Aug 2022 09:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSrlXLtYFFcNn8cauT5/PwBYqy/RJuvm7O/fVC4t9MmHAbgbbMlJm4kRlQD8NDJKsa3QjEY3JcKHCG68TmWndGBo2IYPgo0xmlFL6xKtS79XMQXVp3h4o6h9AIxcaHp7jXSQvieUIEsV1neDnES+E1vK4KIC5o/OTtBgwbVzfnJjZSq1eH0RX5mampv9Cwpfav4VmK7JXRPgCovk0s7l9JZ47gHgWwspaTONfbRYbyuIU/44Sy/XgDDV5WyYw0tar1dPDmntZpz+9PECVL8N/AKXjU+Yx5yhHP98grLihmqxQKON/bS1ZlA+mbwRanaGiPd+5Bn1SfgIi5gErJ5t8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2U+Fv93Nje9Ps8icdQSLuBvkRlGjioNnMp76xe+C9E=;
 b=TjPm+myg+FAfj18Fa3lOMHTOqDb7HjdESwzC8OD0WVdX5FLzBhgzA5nnrnXvqGEePHBNeFTsu8ABzV3zlffuyJkP5AG6fdIq1DLdj0SDGf7/8MursrqJ1RFmDVUM+dR9N/IueVXd2pm9aCdXSQZtVgz634+EAfNTiFEml/ebhum77wEdaBhfw8Cg0JcID1MH7n901ZfkSdKjMEUUWdNVcY+qdNZnj/GTCqOsIiMRNQZimLu17fjc4jIRahHOsGgEF/vLN94Q5hL6X8M+0wvlqIYDzmVNEA+JPIALJ4YNId++Uru0QwiOMhedJ0HKJ6iJTYMrMb12KgnI++NGbA5C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2U+Fv93Nje9Ps8icdQSLuBvkRlGjioNnMp76xe+C9E=;
 b=jh940XfvqxV8ngdbcFvI+r32Lj88ec0/GhqnVxt2kgWzpl9mSWE2y1t5ICrrLjwu5Bio1xbc8KOnnGAovSGAMIN8lltZWB4S/2J+zXR+y2Yc3eVx11PpSYCIWwyg/hbmH6qKOVfruQbVbksldyYVHvR2DFcslAgYcYKSVZK4B47m89Ty00t6ykNdwiJzj5M9BsrQ/vap+eF4OzaKeSllWXDN6F2AjFTnXVbFJ6kS6VFqFk5Hx9Tw8cEzvh5rvFix0uPaIELjan3B7wewSYrxbOKQjf1BxJC1bH8TH40kIz1UN6Abv/ikhbJBqtbVTVS+l2U3J7S9CuboSdpbWtDT4g==
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 16:17:23 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::fc3b:7484:71b4:c149]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::fc3b:7484:71b4:c149%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 16:17:23 +0000
From:   Stephen Warren <swarren@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH 14/14] dt-bindings: reset: Convert to yaml
Thread-Topic: [PATCH 14/14] dt-bindings: reset: Convert to yaml
Thread-Index: AQHYSpaIh9ucOZgHh0OebwRy4ISjLqzk4BaAgCrByiCAsP55gIAAA8uQ
Date:   Thu, 25 Aug 2022 16:17:23 +0000
Message-ID: <BY5PR12MB5544C00A9752BEC5C834E295C6729@BY5PR12MB5544.namprd12.prod.outlook.com>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-14-p.zabel@pengutronix.de>
 <Yk9DtXO/yUIO45gN@robh.at.kernel.org>
 <BY5PR12MB55444E24360883E7AD731E77C6C29@BY5PR12MB5544.namprd12.prod.outlook.com>
 <CAL_Jsq+g=oXz+j-D_xpMuiaumM5akKpJcdhm8LgRhuE0Uf1_bQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+g=oXz+j-D_xpMuiaumM5akKpJcdhm8LgRhuE0Uf1_bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42585e17-68bc-49dd-da54-08da86b54b15
x-ms-traffictypediagnostic: BN6PR12MB1377:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSo9XKMtGn18bdxts05mKoj0dHaFF8fQz0u0e1g+cxgb75HSWr/2pk6RTSGsmXNPLWW1crvLZS16GODT4dRr0/480LHNczAoKYKMMNl5e9sxGcGTOPAt1vp66vAkQnVLUYt6FC3GZ3ORU237Qntxlq0cB8Wl30NbzQTAIQ80LGv9choc7ZUVKuVpCGvm8Ci6aec+LTJIQFLrvjkNJNI0U9MeYVbH+jzsnmtrUFFBMLulpbqzljqA1gHPkxvmr9c6iZ9OoN7m/idVITFHjQ4zbd1772n8k9JbW7Ca8Ju2nJXUjumZPzinH2HRnNo5KmzYthl2XxP0lxS7Qkf22osRuzTWkbHU3AGQQxrXYfC/dK8qyLcX69EyubflEDy1X+/031HYy3I/jfpoABQatrSwGqS/bnb5Ys3A12Y2KXek8a4zUfhVPw4o9rK5Wz8tzWugArcB2MMDGhkvyvxlzYyxiP6/E5pjxHSOdZz7B9hMMr7PW3F/FD6Pg7Mk6EV9L81qMw6yXaBvUUt3xdGGjXA8PQJAnVfZ948/mAJufNa8FS0b0L+Ds3Gm7wpdNHagJwUCJlnlMHRCXtZYSOcCqlqmlrWv224ySg9BdVkLTQ12dpvo0pKSOmBFC/BOvJIlAFDhRNy5eFFDEbQX9+o+HAEXg7lbssJN9LGEq3ZZXF340xk2fzyl/mesR1QlR+JIZxaKZvStn5dr22hPKnQtbJCZnveFV/7T/iYF6yFro2MjOB9RWh4IOzbLD91AxTDVOnT/t7hhAcuGT7hJ/Wav0wk1AfpbKmAjGtMtsh6njakb0BrXIjBLbWYsDSrX23l8PyTgGNx0R6OHCWJ2vPGH77Ei/IFPQSL+0qGy0PnInPiHU2xywOTe7TcagdDBTsYKCezI5FJ9kV8sxv22BY9lPat3JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB5544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(53546011)(83380400001)(122000001)(186003)(4326008)(107886003)(38070700005)(9686003)(7696005)(6506007)(26005)(71200400001)(54906003)(478600001)(41300700001)(55016003)(45080400002)(66446008)(64756008)(66556008)(316002)(66476007)(6916009)(966005)(76116006)(66946007)(8936002)(2906002)(38100700002)(86362001)(52536014)(33656002)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUN1aTVIeTVvUEpvTnV2M3JHdlltcE9hZ2RqRHFENGJOWG53b3NncmRFd0xJ?=
 =?utf-8?B?bnhVZlBIaldYVSt2aU5mZzdmRExOejhyMTlicGZJOWV5Z3hBaDZJT09yQkpP?=
 =?utf-8?B?ZEtOMUE1SWxUazZ3UjlRVmJwb2x6UDRZWXRPTjBkazdQV1VUNHNLZSs5UnZq?=
 =?utf-8?B?SUNDK212NXVjY2hrbEpKWm9YclFSaUw1VDN6Rk5NNkg4MEdMNHdVRnRpNWZt?=
 =?utf-8?B?ay84M0hpMllzRXhJSllFRjhRWi9jR1k5UVUvcURJWjBna1hseXV6YXpRSFFU?=
 =?utf-8?B?dmtETWt2MXhCbW00bzh2c1dDU0VjeW9mTVhvMW5tUXIzcWlWZHBsS2pKVW1s?=
 =?utf-8?B?V3ZoU0ZMQ0xxOG9aQktGL3hUN09XeG5XNGMzbXZyV2ZoeGI3Z3FEYUlrdGVl?=
 =?utf-8?B?TXl0aFhXMEw0U0VYTE00Y3ROSTFJendEL0ZsVHpnSFRWUXRMbHViU3R5dmdO?=
 =?utf-8?B?RERYbWRTMnBzcTk2cDk1aGxrQWJiNktWY2N3b21rSnhBYVdJZDd6dzlBVGtF?=
 =?utf-8?B?TUhoOHFYSHBHcEFObnZiMTU0MEV6VWN5aStaOU03d2EvMEVhZDRSaWlKNkZk?=
 =?utf-8?B?YWtnUmh4d3dSZnFFS29tamR3M0gxZ1pBbnZCWWFWVnhBUzVNV3hEMWhORGpW?=
 =?utf-8?B?bHNjN1J4clhpczVhSFAyUkgyZ0NScE9mRUQ1YmM3elBuVU1pbGl2bkRZYkk5?=
 =?utf-8?B?VmJ0RGU2Sk1pTWc4S0RpMXdLRXV5STdaNnhLNnlWQ0JMcEhmckxHTWxYU3ZC?=
 =?utf-8?B?R2dGVkl6M3BSM0FVZ0pGbXB4UVcwMFR0d2c3YVMyNWp1RjY1QjE4d1ZUTlc5?=
 =?utf-8?B?Y0FUMzBlK3FLRWxic1N4RmdUTjRMK2NUdCtLSVhqdkY5OXNxbGNTZkZrdGsx?=
 =?utf-8?B?dVg1ZmVUcW1kV29Ebkx1TWR6VEpnbWtjdEFQVlRDbHRmQ0ZGTWxFWFprZ2ow?=
 =?utf-8?B?blpaL0pDU0FQdUxKYlgyL1lwRUQrR2RFbFJBK0x2MGVyWlNqV25uS3FNRHV5?=
 =?utf-8?B?WlNEenJPM0p5WVFWSk0rZ2YwVkk2SGF6Zjh4Qm1vWXV5Zmd3QjVSbXNtWUVM?=
 =?utf-8?B?UEhCVVNQbnYvNGNJVk0wRmp2aGRiK3Q0Y2RVNVF5MlE3TlZIemhPUWoyMHpr?=
 =?utf-8?B?ZHdCc3lSWTZ0U2JWemdDSTlMc3RiK21YS0haaFp3eHNjM1lJRU1FUHJhMk93?=
 =?utf-8?B?UmJKbDBSWWxZMGIzOGtQRlpLeFFZdkh2emJLdWI4MzA4bWh3ampVSWZDSVE3?=
 =?utf-8?B?aUFKSHFXQkQ5TjRTcUM2M21KZTRpUUpSRkxpeTVPL0lxSGhDS0VuVnl5aGRo?=
 =?utf-8?B?RThPeGhHeXYxUHJFd3hMdnJvemRNSStHNGpiaHlsRE9GMmFsc3hkblhnYkM0?=
 =?utf-8?B?Y25mejF4UDJkbmI2REhoYlhVYTZtcVE1YjM4VVdRaXdpZmJ5UzJhbko3OEc0?=
 =?utf-8?B?MktWMFNldU5iYlVpZzlBT1BQR3kwWHRZMytDa1l0M3R3OTAxREZjVUNmUVhO?=
 =?utf-8?B?SGgyZ2VGU3hpRWJCYWJmUWFldVNLL0ZycXlDbDVHUXR2V2FNUndCK2daejZY?=
 =?utf-8?B?MjU0Wmw3K0hINUUzZXhRZWRhK2NjSFJ0NnRYUnNIdUdRcXFOWkRCR0NYdGdR?=
 =?utf-8?B?NTladkxJWk5ZRFRGeW1pRW5lQmk4aWdjeE42NUNBZ1N4T05kYXRnK0J5S21m?=
 =?utf-8?B?UDJJRDZTSDFMeTFYQWMxbHlkT1BoUm9xWWVwRGUwWHBZSkl0OEJSN2NMS3lt?=
 =?utf-8?B?TTU5aFM0ZDlmVFNiZ3hHN0N0bEV5T0RsdXRCc3NSdTg4L2FFTVNtbGJjK3Vq?=
 =?utf-8?B?Ri9iSnkxRDhnS0Vvc0FDU0t0RTE5VmJyWVNtTXd0VWdKR1JkK2N4RkswNjFB?=
 =?utf-8?B?TzRtRkh4TnUxeUFFZ2xyblBMajgyQ1dJNi9nWmx4eXdKMlAxa01qekZqVGdi?=
 =?utf-8?B?U3Q4RTJiQ0hDU3hlV1NKbTdWeHRnNTlpUEtkT1V2S0FNeFdZVTFYVXEvUjhj?=
 =?utf-8?B?Ui9sa0ppN2ZHb1YrMkhjNW1LUkhaNTNXdm9UNkpUWFBtMnhWck91TG1ReG1P?=
 =?utf-8?B?TjVPN2xsTGJHSUVTWTZKSzI3eE9OSldpL1VJd0RlMjBONm9CNHliamk2R3ZH?=
 =?utf-8?Q?HEiXaNb305axEKDuB60QSQVQq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42585e17-68bc-49dd-da54-08da86b54b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 16:17:23.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pleb/ZD9GmxpZPDvXL+rudNvkCayBmVeCxmqCW+PVQDpFt4fP0r+z2PogNanIuMOCqr5Mb2vG20pt0B+rSsPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9iIEhlcnJpbmcgd3JvdGUgYXQgVGh1cnNkYXksIEF1Z3VzdCAyNSwgMjAyMiA5OjUzIEFNOg0K
PiBPbiBXZWQsIE1heSA0LCAyMDIyIGF0IDg6MDggUE0gU3RlcGhlbiBXYXJyZW4gPHN3YXJyZW5A
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PiB3cm90ZSBhdCBUaHVyc2RheSwgQXByaWwgNywgMjAyMiAyOjA0IFBNOg0KPiA+ID4gT24gVGh1
LCBBcHIgMDcsIDIwMjIgYXQgMDU6NDM6MzhQTSArMDIwMCwgUGhpbGlwcCBaYWJlbCB3cm90ZToN
Cj4gPiA+ID4gQ29udmVydCB0aGUgY29tbW9uIHJlc2V0IGNvbnRyb2xsZXIgYW5kIHJlc2V0IGNv
bnN1bWVyIGRldmljZSB0cmVlDQo+ID4gPiA+IGJpbmRpbmdzIHRvIFlBTUwgc2NoZW1hLg0KPiA+
ID4NCj4gPiA+IEluIGdlbmVyYWwsIGNvbW1vbiBiaW5kaW5ncyBzaG91bGQgZ28gaW4gRFQgc2No
ZW1hIHJlcG86DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3Jn
L2R0LXNjaGVtYS9ibG9iL21haW4vZHRzY2hlbWEvc2NoZW1hcy9yZXNldC9yZXNldC55YW1sDQo+
ID4gPg0KPiA+ID4gVGhvdWdoIHBhcnQgb2YgdGhlIGlzc3VlIGlzIGR0c2NoZW1hIGlzIGR1YWwg
bGljZW5zZWQgYW5kIGFsbCB0aGUNCj4gPiA+IGV4c3RpbmcgdGV4dCBpcyBHUEwyLCBzbyBwZXJt
aXNzaW9uIHRvIHJlbGljZW5zZSBpcyBuZWVkZWQuIFRoYXQncyB3aHkNCj4gPiA+IHRoZSBzY2hl
bWFzIGFyZSBqdXN0IHRoZSBzY2hlbWEgYW5kIGxpdHRsZSBkZXNjcmlwdGlvbiBBVE0uIFNob3Vs
ZG4ndA0KPiA+ID4gYmUgdG9vIGhhcmQgaGVyZSB3aXRoIFN0ZXBoZW4vTlZJRElBIGJlaW5nIHRo
ZSBvbmx5IGNvcHlyaWdodCBob2xkZXIuDQo+ID4NCj4gPiBBbGwgdGhlIHdvcmsgSSBkaWQgZm9y
IE5WSURJQSBzaG91bGQgYmUgKGMpIE5WSURJQSwgaS5lLjoNCj4gPg0KPiA+ICMgQ29weXJpZ2h0
IChjKSAyMDEyLCBOVklESUEgQ09SUE9SQVRJT04gJiBBRkZJTElBVEVTLiBBbGwgcmlnaHRzIHJl
c2VydmVkLg0KPiA+DQo+ID4gSSBoYXZlIGNoZWNrZWQgd2l0aCBOVklESUEgbGVnYWwgZXRjLCBh
bmQgTlZJRElBIGdpdmVzIHBlcm1pc3Npb24gdG8NCj4gPiByZWxpY2Vuc2UgYW55IGZpbGUgdGhl
eSBob2xkIGNvcHlyaWdodCBvbiB3aXRoaW4gdGhlDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzIGRpcmVjdG9yeSBvZiB0aGUgTGludXgga2VybmVsIHNvdXJjZQ0KPiA+IHRy
ZWUgdG8gTUlULW9ubHksIGUuZy4gZm9yIGluY2x1c2lvbiBpbnRvIHRoZSBuZXcgZHRzY2hlbWEg
cmVwb3NpdG9yeS4NCj4NCj4gR3JlYXQhIEhvd2V2ZXIsIHRoZSBsaWNlbnNlIGZvciBkdHNjaGVt
YSBpcyBCU0QtMi1DbGF1c2UuIElzIEJTRCBva2F5Pw0KPiBXaGlsZSBNSVQgaXMgc2ltaWxhciBh
bmQgY29tcGF0aWJsZSwgSSdkIHByZWZlciBub3QgdG8gaGF2ZSBhDQo+IHByb2xpZmVyYXRpb24g
b2YgZGlmZmVyZW50IGxpY2Vuc2VzIHNpbXBseSBiZWNhdXNlIHBlb3BsZSBkb24ndCBwYXkNCj4g
YXR0ZW50aW9uIHdoZW4gY29weWluZyB0aGluZ3MuDQoNCkJhc2VkIG9uIGxlZ2FsJ3MgcHJpb3Ig
cmVzcG9uc2UsIHRoZXkgYXJlIG5vdCBmaXhhdGVkIHVwb24gTUlUIGxpY2Vuc2UsIHNvIHRoZQ0K
QlNELTItQ2xhdXNlIGxpY2Vuc2Ugd291bGQgYmUgZmluZSB0b287IHRoZXkgaW5kaWNhdGVkIHRo
YXQgZXZlbiAicHVibGljIGRvbWFpbiINCndvdWxkIGJlIGZpbmUsIGV4Y2VwdCB0aGF0IHRoZXkg
ZG9uJ3QgaGF2ZSBhIGJvaWxlcnBsYXRlIGhlYWRlciBmb3IgdGhhdCwgYW5kIGl0J3MNCm5vdCBz
dWl0YWJsZSBzaW5jZSBub3QgcmVjb2duaXplZCBldmVyeXdoZXJlLCBzbyB3ZXJlbid0IGdvaW5n
IHRvIGFjdHVhbGx5DQpyZWNvbW1lbmQgdGhhdC4NCg0KSSBhc2tlZCBsZWdhbCBhYm91dCBhcmJp
dHJhcnkgZmlsZXMgaW4gaW5jbHVkZS9kdC1iaW5kaW5ncy8gaW4gdGhlIExpbnV4IGtlcm5lbCB0
cmVlLA0Kc28gSSBiZWxpZXZlIHRoZWlyIHJlc3BvbnNlIGlzIGEgYmxhbmtldCBvbmUgZm9yIGFs
bCBzdWNoIGZpbGVzLCBpbmNsdWRpbmcgWzFdIGJlbG93Lg0KDQpGb3IgYW55IGZ1dHVyZSBzaW1p
bGFyIGlzc3VlcywgdGhlbiBUaGllcnJ5IFJlZGluZyBvciBKb25hdGhhbiBIdW50ZXIgKGJvdGgg
Q0MnZCkNCmFyZSB0aGUgcGVvcGxlIHRvIGZvbGxvdyB1cCB3aXRoLiBGb3IgdGhlaXIgY29udGV4
dCwgdGhleSBjYW4gc2VlIG52YnVnIDI0MjY0NDkuDQoNCj4gVGhlcmUncyBhbm90aGVyIGhlYWRl
ciByZWxpY2Vuc2luZyBub3dbMV0sIGdwaW8uaCwgd2hpY2ggTlZJRElBIGNvbnRyaWJ1dGVkIHRv
Lg0KPg0KPiBSb2INCj4NCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDgy
NTEwNDUwNS43OTcxOC0xLWV0aWVubmUuY2FycmllcmVAbGluYXJvLm9yZy8NCg0KKE15IGFwb2xv
Z2llcyBpZiBPdXRsb29rIG1hbmdsZXMgdGhpcyBtZXNzYWdlIG9yIGludGVyZmVyZXMgd2l0aCB0
aGUgbWFpbGluZyBsaXN0Li4uKQ0KDQotLSANCm52cHVibGljDQoNCg==
