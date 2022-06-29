Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B455FFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiF2Mcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiF2Mco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:32:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE4101DF;
        Wed, 29 Jun 2022 05:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au87+az+TlvZX2fJSQDgcTbQNvmAe2o8Hc+bH92hSZxY0d8jRmwQYcj6MvEUQHzawsSbpAEih5cAXfn/aw5YRJIhAE3tZ+ru5Qg/26+mnKcn4RhMKlvAvPGwAlmn0T+WgXHYmx/JxMljoLBWJinzBD0Csl2zYQTCsoO73laWYShqtWebxhjwALzyZp38P7F2+iLyLj/JBlunp6txNVOKCvmzr42kMIbch6H+8ADcYte057G+JgEQuoodwctI1b1Q9F61aZrg1GHwnduluNhts8g23pFvP4Qb5FjlYyxuWTdN2JPlq4oNxEfgvK4rZX1LjbqnroWrBme/H4UWAWbM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpqTzMZylFoHwIACez9xaIc55oorLsf3GOG9bg4OfVk=;
 b=jCeppRIg0iapVuxrPdzlu38maJ4NHq/4A4nmvhh7DaSLm029YNwoTeAnXEivdbH9bX5gYyfL2T91tBI1ay0SW6lJkIsqnl1ra00XWQYUS3WKvRVVG6+NhpEXKh8ELw6dPEK+uapvn470jf4gIz4nnb47C9qylRsv+P5b2LtA744KNFJ0Mf+ElPb1ryAO6LwhmxmvU92s0qK8kqYKPPd8xyaPsAsnyKKsf2sVbPdJM5fm9P5rU9ku2igIZH5AQY4S5lEtTySm+SfnDHSddegNPulSPlDwlUrCXFCeeXRI1xAsfvhIRUGPAwbWa494KrwGdqs4nR24ESgxs/vo7oCPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpqTzMZylFoHwIACez9xaIc55oorLsf3GOG9bg4OfVk=;
 b=h+vdOT1nNsVV/BD1d9St3qp4tDawIcI1CmEh/4oKkaO0hsskutNKXE9xNPeUXZHUv7gXDRf1BHPZHaLRP7H/y2Hx8saXV/FSMothCx464RYfkDrpA7jSIYxjYsn4jmAQlbXa+Y0WAphT4fhWFSgKczHJHRmK2vcd31OrJxJsZiA=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:32:41 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 12:32:41 +0000
From:   "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>, "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Thread-Topic: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Thread-Index: AQHYirIQab0wAYrAk0yu4tMbwbitVa1mKqAAgACB1gA=
Date:   Wed, 29 Jun 2022 12:32:41 +0000
Message-ID: <c0d80c8d-d5e3-3b99-d554-10ed411c0eee@amd.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.50.21061301
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bead1c74-4b1e-4312-5628-08da59cb7587
x-ms-traffictypediagnostic: SJ0PR12MB5438:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aY2FFCAdnXqZbiR2LZQhfx05Cf4VppEfuHEaPZlNAgjuaITjGFqJIjPR/2XVVMKRX9D7ZuYppiVYuAz3kPJGbkq71FusotZk7nxNi3I3lDfs/bk1C/diHJciatjQzjPJSCLBxMjfkuO3RGRiMyxJfZ0Chcj8IzCbL0tif1FL6slY8Z5oQBMzCNw1fQNanjl+5Rgu8qle4RzAQcwQ3IfI+LTgRAHBZ97eoR7YUJuapeFArdfp3E/2hRgIML0KPR59n3ZLQk565jKAnpPGt0JTHpw4tQgXMY0ORAdfAGZJX2np0FAQLy7TGtU6vDxWXhaCVO9A5tE67SZmjUBy6Fd9JHhLsUvD+6NNypZAakO8mgncueAf/RRZHc7gsxMIKpmjlzrhjCdvDm0vf4+g5Ir5eixN2RoBI8Tm641rUTaTni5g7H+Xdx/2HIEy/yd3iwDFiMWrIR8NRKs4WlGjIG3BoPyCwgNLFdVaNRSHTY8UTHrNziEsEl/lGzvqIn04a+JBOypXqK2DoBTC5HeVbaGKBG3YqQDsK5CKjuW7nqHVt9MBirOz4Z2X7JKrEiNdcNKT6iuuMFhMJaFufaIp06C0rPkxv9aUovf3+y8rxZ/rIXmggNKmQBF9p8hC2lRV7Aj6iP3ylXZiJphKnmh/6xoirakqL8fKE/IWtcrjjulqImA/ny1SfI1sfA8aOg4LpaKxpE0K3GlsXiMaltql6tJLUcyDYtZkLQ8HGqOSBgLFoPLoi1iO/T7ufyfutKujbpLu/Q2OPe5TFGnEQz9YtI5Lzi4U5TPXINmQHCChxul63a01m7qqshHp3vGdO1YnTIqIBZS8uNWtv7KEPYu6HmFnjzKwqlP2V7h1GRJN9YTcwgnOjN6r9IFq0xOkRiEeV0QnqWMGU9SwJdgBsxlRXcOnGb4U0crJG2TWIkjZL1awoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(8936002)(8676002)(64756008)(66476007)(26005)(76116006)(4326008)(122000001)(5660300002)(66556008)(66446008)(91956017)(66946007)(6486002)(966005)(83380400001)(6512007)(478600001)(71200400001)(921005)(53546011)(38100700002)(54906003)(110136005)(316002)(31696002)(186003)(6506007)(36756003)(31686004)(86362001)(107886003)(2616005)(2906002)(41300700001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFVOGErOFpCenRjNWFJUTdRd0l4eFZXYXhPTmQ1MlBocU5mZGJvbEViSmZ1?=
 =?utf-8?B?RnhFR0F3RkFxUEU1Y1FwV0grYUZscGdtUXNFbUpMSCtmV0VCQ2NFYUVzVEt2?=
 =?utf-8?B?aHZOOVZzUHRYNXRsUFRhME5TUExjVGg4UkFlK0xlMUY1ZVJ3RmVxUlkwUGtT?=
 =?utf-8?B?SEY3OXVrQytzS3lYOUxuQmN4K2Via001VnBWcVNFMkVHNk1lZEZlNEJ6bloz?=
 =?utf-8?B?OUhJVEk5ZDIrZUI0dEFLcG9uejlkbFFrcWpLcDJHbnNIYlREaGRkVGZxNkY4?=
 =?utf-8?B?TVNjN3pqbFZTQlZoTHI2czJzaVF2QmxvWXkzd3JUcUpKZ21ZQ1owSkExeG1k?=
 =?utf-8?B?Y0tzT1R3aThCYnEzbFJGNzBXLy9hQk9EV3BTMXdmdVFpcUh1WndCS0diSTls?=
 =?utf-8?B?c1lTNDZ3UUFLZm51cDZ3bkQ5bjdNRHlMbjl5KzVGYmFGNWJCT1M1VkxSZ3FF?=
 =?utf-8?B?TmE4c1hwYXN1bUprU1g2MTFQNTdVcGZhbVBQSnFYVFZ3a3pMNWNzR2tva21v?=
 =?utf-8?B?Z1Vka1pIQ0NCSGtMbTdSZ2dpS2h1d0VjbFNQaUNYWlhGVjZ1MWxKZTIvMWoy?=
 =?utf-8?B?dmxibGZOTU12bGY3YXFLbCtOU0d4NWRkbmdiQ20rVHJrbjZVQ2trZ25iZkV0?=
 =?utf-8?B?eXl2RGdVdWwzZjVLWmI3UEVKLzFaS3NLU2JpaGNPMmFjSC9oOURVY05qNUdX?=
 =?utf-8?B?V2loaEptWHhGNHlMSFkyTUpkWUJoZ0E0MVZGRGNjSlJkYmNkdEZ3a21ZNGJM?=
 =?utf-8?B?Y2tMTGpjbFByc21ZZXRrQXJjN25UMkN6WlNVRTY4TnZZUDF3K3dhWHRUcVl5?=
 =?utf-8?B?elVISXJIR1VkRjRxdDJCbUlDRXo2WVNZNzdRUGFJZTVnbEg2TkluQlNWc1ZM?=
 =?utf-8?B?NUFMR2dBaWpMcXQyMFcxeDYxT2kyZENpb0FzZ3NXbDhyeDVSdWZGMTdIODZl?=
 =?utf-8?B?M3p2SHBLMUpnZmxYZE1FZWxVdEdoeGVScEhmbC9GbkErenVPdHVzZHZMdXN0?=
 =?utf-8?B?ZFBTMTgxSmdiTURNbGE1Mk8rRmFabVRHcUpNemxpSE1YNkdjcExpS0V6ZnNi?=
 =?utf-8?B?UlZqZnV4eEM2NEtvZWlvQlpKVzRrWFRjUHljYkRET2FJMEpsMjBlZ2IvWnBN?=
 =?utf-8?B?VWc0RlhKN09TbWtlU09oOFkwZ0s1ZmJXSkx2WGIzV1JTZ1RxQlI0RjZycGd5?=
 =?utf-8?B?Mk96VnMzTmdYSUJ4YjdRQUg5cmF1WGp3eXgzanp2Ulc3bjVma0hDMHdkalRY?=
 =?utf-8?B?Tjgyd1N6TFR5ajJHR25ycS9yNllSK3lGRW95WlEyUHhjRG94K3g3VWw2LzJs?=
 =?utf-8?B?MUhxVk1OOFhnTE1PSGE4c0UxYkhHeEtzUTJtNHVoUVZJVEwrTTlXdE15YW5C?=
 =?utf-8?B?N0VhZDlnRi9yeG1rQXl3a3UyTURTdEwvQXV3NTlURW13cyt0d29yNXRtSmU3?=
 =?utf-8?B?RVBIS3dRUlc2L1YxTnB4dDg3dHVpR3lqQjAxOFdVTWRLZUZHa29vK05iUmhW?=
 =?utf-8?B?VmxyUUlKaXJTNExwcDV6U2VBWjdGV0ExS2NxZytxaUd1OUhRUmd1ZklzbUx6?=
 =?utf-8?B?U0xTejlVcDQ1RGl0b3FHZmpuenNBLzhxME9EcXZhaWtjcmVLUktqM2JUTGVM?=
 =?utf-8?B?VmJwcXVpZFh4QUR1YmJRdTBTbU9VUEVJL08zVkxRTk1xVG1kVUQ0MHdKOHhN?=
 =?utf-8?B?T1FKSDQ3czNEV2xmNVVrRVJkK1BhcGcrM3Vwb0c3dU4ydVhPVGZMSWVOWnJm?=
 =?utf-8?B?elF5RGc1NldSbjJONGpNOGJ1YWRDdlBUTEo3UlQ4Q2t0bEVYb01MTWVXV2dt?=
 =?utf-8?B?QTE5M25XZGl5WGRIb1RtanB5cFlsSmlObzJxQnRwZGoxK0o5cFZ5UkorS3R6?=
 =?utf-8?B?M3lIeFN1cDB4UGdpMWt3K2pTaXcrZk4xaGlkU2h6cGdqQ2ZDN2pPZTZQSmFx?=
 =?utf-8?B?dk9UWkJiZFdEbHdkT0NsZmx2eWhtcURuRmJPWHZnc201aFhuTFQwSHBQZzlG?=
 =?utf-8?B?M1BCcWpKdEd5S3kyVDh0ZGhrZXQxd29oRjF5ZG1Dc1NXb3RJSlRSNDVhR2RH?=
 =?utf-8?B?cjF1K1VPRWJzMWdrM25FUTNQWis4d1BVTVgzM2c1L0lkK1lYRXBFVmpFK1ZN?=
 =?utf-8?Q?s0A0prkSGAgj4li2/ZS2vFFOz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5D7DCDC9F65F438F81909089A9E44B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bead1c74-4b1e-4312-5628-08da59cb7587
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 12:32:41.0914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiJARMFKIuU9p2aGHAaCDCnDxk1PAck3wLn1cHGiPajE6yXzENsVRbUbjjDf0p8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsIHBsZWFzZSBmaW5kIHJlc3Bv
bnNlIGlubGluZS4NCg0KT24gMjkvMDYvMjIgMzozNyBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gT24gMjgvMDYvMjAyMiAwNzo0MywgQXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJh
byB3cm90ZToNCj4+IFRoaXMgY29tbWl0IGFkZHMgZG9jdW1lbnRhdGlvbiBmb3IgVHJpcGxlIE1v
ZHVsYXIgUmVkdW5kYW5jeShUTVIpIE1hbmFnZXINCj4+IElQLiBUaGUgVHJpcGxlIE1vZHVsYXIg
UmVkdW5kYW5jeShUTVIpIE1hbmFnZXIgaXMgcmVzcG9uc2libGUgZm9yIGhhbmRsaW5nDQo+PiB0
aGUgVE1SIHN1YnN5c3RlbSBzdGF0ZSwgaW5jbHVkaW5nIGZhdWx0IGRldGVjdGlvbiBhbmQgZXJy
b3IgcmVjb3ZlcnkNCj4+IHByb3ZpZGVzIHNvZnQgZXJyb3IgZGV0ZWN0aW9uLCBjb3JyZWN0aW9u
IGFuZCByZWNvdmVyeSBmZWF0dXJlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBcHBhbmEgRHVy
Z2EgS2VkYXJlc3dhcmEgcmFvIDxhcHBhbmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+PiAtLS0N
Cj4+ICAgLi4uL2JpbmRpbmdzL21pc2MveGxueCx0bXItbWFuYWdlci55YW1sICAgICAgIHwgNDgg
KysrKysrKysrKysrKysrKysrKw0KPiANCj4gVGhpcyBpcyBub3QgYSBtaXNjIGRldmljZS4gRmlu
ZCBhcHByb3ByaWF0ZSBzdWJzeXN0ZW0gZm9yIGl0LiBJdCdzIG5vdA0KPiBFREFDLCByaWdodD8N
Cj4gDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy94bG54LHRt
ci1tYW5hZ2VyLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21pc2MveGxueCx0bXItbWFuYWdlci55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MveGxueCx0bXItbWFuYWdlci55YW1sDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mNmNiNGQyMzU5ODENCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
aXNjL3hsbngsdG1yLW1hbmFnZXIueWFtbA0KPj4gQEAgLTAsMCArMSw0OCBAQA0KPj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFN
TCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21p
c2MveGxueCx0bXItbWFuYWdlci55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBYaWxpbnggVE1S
IE1pY3JvYmxhemUgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gDQo+IHMvRGV2aWNlIFRyZWUgQmlu
ZGluZ3MvLw0KDQpTdXJlIHdpbGwgZml4IGluIHYyLg0KPiANCj4+ICsNCj4+ICttYWludGFpbmVy
czoNCj4+ICsgIC0gQXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJhbyA8YXBwYW5hLmR1cmdhLnJh
b0B4aWxpbnguY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOiB8DQo+PiArICBUaGUgVHJpcGxl
IE1vZHVsYXIgUmVkdW5kYW5jeShUTVIpIE1hbmFnZXIgaXMgcmVzcG9uc2libGUgZm9yIGhhbmRs
aW5nIHRoZQ0KPj4gKyAgVE1SIHN1YnN5c3RlbSBzdGF0ZSwgaW5jbHVkaW5nIGZhdWx0IGRldGVj
dGlvbiBhbmQgZXJyb3IgcmVjb3ZlcnkuIFRoZSBjb3JlDQo+PiArICBpcyB0cmlwbGljYXRlZCBp
biBlYWNoIG9mIHRoZSBzdWItYmxvY2tzIGluIHRoZSBUTVIgc3Vic3lzdGVtLCBhbmQgcHJvdmlk
ZXMNCj4+ICsgIG1ham9yaXR5IHZvdGluZyBvZiBpdHMgaW50ZXJuYWwgc3RhdGUuDQo+PiArDQo+
PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiArICAg
ICAgLSB4bG54LHRtci1tYW5hZ2VyLTEuMA0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJ
dGVtczogMQ0KPj4gKw0KPj4gKyAgeGxueCxtYWdpYzE6DQo+PiArICAgIG1pbmltdW06IDANCj4+
ICsgICAgbWF4aW11bTogMjU1DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIE1hZ2lj
IG51bWJlciAxLCBXaGVuIHdyaXRpbmcgdG8gdGhlIGNvbnRyb2wgcmVnaXN0ZXIgdGhlIGZpcnN0
IHdyaXRlIGRhdGENCj4+ICsgICAgICBieXRlIChiaXRzIDc6MCkgbXVzdCBtYXRjaCB0aGlzIHZh
bHVlIGluIG9yZGVyIHRvIGhhdmUgYW55IGVmZmVjdCBvbiB0aGUNCj4+ICsgICAgICBub21pbmFs
IHJlY292ZXJ5IGZ1bmN0aW9uLg0KPiANCj4gUmVnaXN0ZXIgdmFsdWVzIGFyZSB1c3VhbGx5IG5v
dCBpbiB0aGUgc2NvcGUgb2YgYmluZGluZ3MuIFdlIGRlc2NyaWJlDQo+IGhlcmUgaGFyZHdhcmUs
IG5vdCBwcm9ncmFtbWluZyBtb2RlbCwgYWx0aG91Z2ggaW4gY2FzZSBvZiBzb2Z0IGNvcmVzDQo+
IG1heWJlIGl0J3MgYSBiaXQgZGlmZmVyZW50Lg0KPiANCj4gQW55d2F5IHlvdSBuZWVkIHRvIGRl
c2NyaWJlIHRoZSBhY3R1YWwgZmVhdHVyZSwgbm90IE9TIGJlaGF2aW9yLg0KDQpMaWtlIE1pY2hh
bCBzYWlkIGZvciBldmVyeSBpbnN0YW5jZSBvZiB0aGUgaGFyZHdhcmUNCnRoaXMgdmFsdWUgY2Fu
IGJlIGNvbmZpZ3VyZWQgYXQgdml2YWRvIHRvb2wgbGV2ZWwuDQoNCj4gDQo+PiArICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4gKw0KPj4gK3JlcXVp
cmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSB4bG54LG1hZ2lj
MQ0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1w
bGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIHRtci1tYW5hZ2VyQDQ0YTEwMDAwIHsNCj4gDQo+IERl
cGVuZGluZyBvbiB3aGF0IGlzIHRoaXMsIHlvdSBzaG91bGQgdXNlIGFwcHJvcHJpYXRlIGdlbmVy
aWMgbm9kZSBuYW1lLg0KDQpTdXJlIHdpbGwgZml4IGluIHYyLi4uDQoNClJlZ2FyZHMsDQpLZWRh
ci4NCj4gDQo+PiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHRtci1tYW5hZ2VyLTEu
MCI7DQo+PiArICAgICAgICAgICAgcmVnID0gPDB4NDRhMTAwMDAgMHgxMDAwMD47DQo+PiArICAg
ICAgICAgICAgeGxueCxtYWdpYzEgPSA8MHg0Nj47DQo+PiArICAgIH07DQo+IA0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
