Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CD56002E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiF2Mhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiF2Mh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:37:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D428E3D;
        Wed, 29 Jun 2022 05:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsVd78W47kEXkCzG8Ddcshc/Go5ylNJNXbrRy/emMzJUgIyViv1y5+nvd5e3+zNqH/8xiHeN9T502HDlJyY6LQQKWKSCTzifNUY69ajtF23CyXWmfcjZPfgwd+siSVKdHKi7ZWWBeDKtgk9CSpHrDF71r11XwSWnL5xxdVVNJGqVbmFea3UdWNOAylj5pOwZ62okk5+U9aHx8i16AJ7EvRaazvd9pQg2d8L2EUwD3UyaX60kX/esPagKvZo4c/7DvDwHYU8Zw42FEa4N1mH1vDUwhIs6SdpW1W9IRtZSsU5/iMdhS3Y2m3zJLAW9mKFi7ZU3FIV0CrI97gdZeagYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gsDPyPx0FUgq+25Fj3eHABDX+M8k8ZX7eSTkLgWLWg=;
 b=eRz2NixqCv5UsP3iPZFO68e2lziSDfuzG0G5PnlV/cpD34OCLJI/mqsUsc1BS+1Y/t4sWAf2UoVpNItMY222CFTnXosCJOeSFMN2I0lntvCEiy7c8NSNJL9IHov3WKRsX+aaNA9HVcyHFsy00gssQNJODwe+zMhRKIoWR58EOb1CIPHmUamxJ6crWrGtGMNH1dioCjMUr7OLbkrBmzYePsN5rLMk1mAI5EQvf89H+6jc0XJ5AN5T6cU0+Q6mfIZOM7yzwdqLoRWnzZOPSXsA7cnFoh7XuGCzENS9rKj2C3Zk4yV0YiNqHwARy0pZkbMzEjW4+SB0zOgEFcQWMuWtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gsDPyPx0FUgq+25Fj3eHABDX+M8k8ZX7eSTkLgWLWg=;
 b=1MyURhhX2j3uIRAWDOhJ0LAuNlB3JtDlQyVxB4d43Slmvs9U+LdSxjkgjqH7ZXc/RMvwRmO/9SXjS3qKM5P4bumgnU+5/Y3kJekKaX4nwYDtARcscHagMJrlA+eksPU8wFbHS7yBxx/PsUPoxTW/SERu0Nq6yhmrPcy23SEGWiE=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 12:37:24 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 12:37:23 +0000
From:   "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Thread-Index: AQHYirIQab0wAYrAk0yu4tMbwbitVa1mKqAAgAAVbYCAAAYogIAAA8kAgABmrYA=
Date:   Wed, 29 Jun 2022 12:37:23 +0000
Message-ID: <dd709b5a-1cd8-0343-028a-5d134a9de81a@amd.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
 <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
 <e43bede7-2a0a-5114-e9ec-9e1449bf4e47@linaro.org>
 <a653cb16-4aa9-693a-ac32-cc7b1b999b92@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.50.21061301
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85ca438-6f78-4ad2-a4b2-08da59cc1daa
x-ms-traffictypediagnostic: DM4PR12MB5294:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IDRe6lamJbRno1g7By0O+tvhilobFVouoWE1TWPs7ysjxaI1r6P0R7voH+AvtXlW8AAoBq3a8n1sE+BN4c7NJ2ecypoc3ELLscCppG7RDkyl9nnHy9YbdfWM4Rv6RDRBqBJlPLi759F664HZMhaG+/YR8hBuO8VyWabGWnuZ3FheAQQ0RzyQSPwPVRjmNIfZWvhcD6dJXHjlW1jf84DIQ3zvOB5XFKKQpeQZXesB0uoic9FSU7kzDOrQwnxGIllNMTk6Q82gwrEUFKl03pAL7S6FTb8LCW4bv3g+fjZUBRGaYOt3NflL3UibxRHjoScY5YSr3eyGJC+P1o4c/wkkcOJdPsc4UITcWnzXQHC2j5Sfq+g55xy7WL/Vv8Ykqzr8eAUu73CH1hMfxgkmjfQ00eEeQQmKLcSxm4m+Bk4/3ffqqDAbCnLIu5io1c7zjZiUoBOb9zX88ZSa4m/j92mSlj1RVjBXDBB3VLT76ujnfPxgSY/p6wkynpsTeDlJPL0jyPmEJIXmM8DTg/vgktUVNbtbZUZU7D2DoBjW8qEgoUgcMeEuBirGL1nrbIzdWEfX3qaHxTeIbRQfoGy3mf4lxXSQFMGEBFX+dM2UPHxFoZiDqK3Wo7PyvSb3SM/oZyfvEWKwzWbR+ZtYaduKKJeryCraMYh1w8r3sXqIkPGfuFqKyA6Rf+xxWU8hp/P3k8Nkl81Q/HMch0DIZZNQefxBXquRHAP95pXJprHRHTR8a+WNJkkv78WqKKaqyRrMyQw2WOevfWo1kvqsp4Tc2tk0+PMultbMxkCdM7IeZC3WKvxQf+UHH0yTh3UnUGvAidx84Y6sMK92r7hKhPYUaltzpeuPvh3Y1cG6nKm464eH6dHnSBQyTTSuB+zGVsVw3uJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(8936002)(64756008)(31696002)(107886003)(91956017)(8676002)(66446008)(54906003)(4326008)(2616005)(186003)(6512007)(66556008)(41300700001)(110136005)(71200400001)(53546011)(6506007)(66946007)(86362001)(38070700005)(6486002)(316002)(921005)(31686004)(478600001)(76116006)(26005)(122000001)(66476007)(2906002)(36756003)(966005)(5660300002)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJZbC8zSmsxa1F1SitFSUx4cjhrRmRtVFNFR1Q4bUZkS09WbXdJRHhnajJR?=
 =?utf-8?B?aE9iY2Noc3o0UmdtUXNKWXFsTkJ6WkxHa0lJL0NmeHVIZnhjUmU5dVdqK3N4?=
 =?utf-8?B?T1VYQWc4aEluc1pmcVBwcC9qUUpHbWtTL3pqczdoSEJKYVlTQWhIOHBkaE0w?=
 =?utf-8?B?MnVYV0M4NGRObm12T0QrZTRQL2ljWll0c2toditaNll0U1hDc2p0NmExQVlB?=
 =?utf-8?B?QS9iUmNZZ3FzRmczbjM0eEZuYnJpbE16Y1htQk5rdnBKRUdvZWdXOWNnSU9z?=
 =?utf-8?B?NjM2NzVFd09URm1LZis2ZTh1WTlOQTUzNzhITkhhcHFkQUh1eGFjTllLeXBn?=
 =?utf-8?B?b2hSV3hxOE9hN3VYTDFhVzlqUXlXdTI3OWFyNms2bWtCR3BPbzdmNnFjQXhs?=
 =?utf-8?B?ckZLaVU1N0pjcEFncFlsLzlJTk1McWMrY0pxYVdGd1kxeFlYRHU1aEZSa1pl?=
 =?utf-8?B?NGdmRFBRZG0yUzNzUWNlRDUxTWRXYStUUEVTVGtIV204a1o4VjVkVmxmNnFU?=
 =?utf-8?B?eGU1MlI4dGE3OGRlYVdpYjI3Yi9ZMldqUkNINU1vSU5vUTNja1pQeU5VcmJ4?=
 =?utf-8?B?Z1Bha0lVb21IMWxWUzlFdFRLMG9OQm1VS3pISlRJeDJEaVQ5S0g4bnlZbUI5?=
 =?utf-8?B?aU8vUXdUcnQzK1NackVMSnhYVGxsWWJESmlxTndiNENrZnZXaTVWaVZyMnJw?=
 =?utf-8?B?d1BjRWhBWXBYQitoY2g2QXpzbUlwUTdBakZYNHRQaVBjRkJiemoxRHV5T3g3?=
 =?utf-8?B?blFHYjU2VktHV1N1S1ZNSHNRSzNhTnZNSmdDNE4xRkUwcXh2a25DUjI3cFRD?=
 =?utf-8?B?SEIyVGE1dWxrVHIrdS9vSHpGUXlwZHRGNjdqZC9pY2VpTFhLdTRDTkVhejNi?=
 =?utf-8?B?dVR3M0g0bVEvQngyK1pKR3U5MXdkZG84VSs5Z0I3bnZUQUJpdzZzamRuWlht?=
 =?utf-8?B?dzdzdW9MT0VJek5zQXBscGRrb1QyalRhQkdIRHoxTitIelQ1aWV0dlhDQ0J1?=
 =?utf-8?B?RG1lYkFEaklGSUZLWE1mY21zbDROeVNSUXl1clZ4NmY2U3g0YnFEemdZcThB?=
 =?utf-8?B?cDUrQlBQNVEyekZBZElUVVN2R2xUSDZXWlFjYm4zNlhSRXFTSEJ4R0tHL1Vq?=
 =?utf-8?B?M2FUdnEyUzd1NjYyU25nekg2UFdvN2RMYm5VVHdIdERuWUc0U2JsNFcxZ2NY?=
 =?utf-8?B?QlM5aW5nWGo3b1VQTmxLSk1iRVVyNWIxVkRGbnM5V09YYTlYMVpaUFVCTEJv?=
 =?utf-8?B?aTBORUNWcEluMTFiOGtIZFhTaE5GZmpIVk40RVV1TkgvYmtRVERIN0d3di9R?=
 =?utf-8?B?MUh2MzdrNGxMSUxqc3hUL290cVVoSFpueUtQejAvcUZqR2x0bWYvM280cldO?=
 =?utf-8?B?WUdFZkpnWUxGMWl1OS81MzJXK2dzVHU4MmI0WnRkN1I4eVQ3cU1qbmpzRk83?=
 =?utf-8?B?VStsU3g2bHM1LzdMTkpOUVE0MzIrWFYvWjcxM3NaMVBObDIraktYdlVWK0s3?=
 =?utf-8?B?NXBBczFaK09xSW1wa21YOUNGQm1GQzhCVkk3RDRrYWVVeDFjckxSNUlQbHlT?=
 =?utf-8?B?NkJjc3JBVUJlb1V6c3NKYnBSMWRKRHQ5SndTUWRsVHNVam9UYVk2MHltckRI?=
 =?utf-8?B?OUc0cDdmR1VCMmFEeFM4QkhpUlY4aWFvMUpVc1pVNGI3aVUyaXpmcllDbDA1?=
 =?utf-8?B?R3k2MVRVV0h6MkN2NERNVVoyenF5Vzl2cHV0cjBPVHIwalQrb011MTlINnNF?=
 =?utf-8?B?WllnYjlLbGFHeDhIODR6VTZGa3BqWmhnOGtQN2NaSWxkazdhQmJYNm8wa09D?=
 =?utf-8?B?V1dOSSsvZU00Z09HL2tQZ1gxeXYrcE53L3RiVkVvWi90eG9lOExRaEZLRkFq?=
 =?utf-8?B?Q3lJbkJlcm1RQUFmMDF2aCttbGUrVGJVK1kvbk02ZHpQS1ovcVRJbit3R2Jr?=
 =?utf-8?B?QmFvaGhtbXVBZ1pLVU12c0lQWThvYTVsakMvYVdOSmZJUStTRzQ5aGxVYk9N?=
 =?utf-8?B?bU5xWEpGb090SjhvNWVDV0xYMEFBVVc0cXNEVk1xWk9tbUdJMVRqVHZhbmRJ?=
 =?utf-8?B?L0pmRURuN3cxL1R5anI4K3dzT21ZSHYraElBYjBzVkNFaFFIcG9qbXorV3dC?=
 =?utf-8?Q?duaHZKOe9683rWEQG1GMStzUy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC66EF886568E942881C181435561481@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ca438-6f78-4ad2-a4b2-08da59cc1daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 12:37:23.1800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqdG1xVIqI0EQgKKzIvVPFPJuVcS4B6LkeWaDTB6D0hlQF5Bjugy/jORk2CHUymV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KT24gMjkvMDYvMjIgNToyOSBwbSwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDYvMjkvMjIgMTM6NDUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+PiBPbiAy
OS8wNi8yMDIyIDEzOjIzLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDYv
MjkvMjIgMTI6MDcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+IE9uIDI4LzA2LzIw
MjIgMDc6NDMsIEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSByYW8gd3JvdGU6DQo+Pj4+PiBUaGlz
IGNvbW1pdCBhZGRzIGRvY3VtZW50YXRpb24gZm9yIFRyaXBsZSBNb2R1bGFyIFJlZHVuZGFuY3ko
VE1SKSANCj4+Pj4+IE1hbmFnZXINCj4+Pj4+IElQLiBUaGUgVHJpcGxlIE1vZHVsYXIgUmVkdW5k
YW5jeShUTVIpIE1hbmFnZXIgaXMgcmVzcG9uc2libGUgZm9yIA0KPj4+Pj4gaGFuZGxpbmcNCj4+
Pj4+IHRoZSBUTVIgc3Vic3lzdGVtIHN0YXRlLCBpbmNsdWRpbmcgZmF1bHQgZGV0ZWN0aW9uIGFu
ZCBlcnJvciByZWNvdmVyeQ0KPj4+Pj4gcHJvdmlkZXMgc29mdCBlcnJvciBkZXRlY3Rpb24sIGNv
cnJlY3Rpb24gYW5kIHJlY292ZXJ5IGZlYXR1cmVzLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSByYW8gDQo+Pj4+PiA8YXBwYW5hLmR1cmdhLnJh
b0B4aWxpbnguY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAuLi4vYmluZGluZ3MvbWlzYy94bG54
LHRtci1tYW5hZ2VyLnlhbWwgICAgICAgfCA0OCANCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysN
Cj4+Pj4NCj4+Pj4gVGhpcyBpcyBub3QgYSBtaXNjIGRldmljZS4gRmluZCBhcHByb3ByaWF0ZSBz
dWJzeXN0ZW0gZm9yIGl0LiBJdCdzIG5vdA0KPj4+PiBFREFDLCByaWdodD8NCj4+Pg0KPj4+IFdl
IHdlcmUgdGhpbmtpbmcgd2hlcmUgdG8gcHV0IGl0IGJ1dCBpdCBpcyBub3QgRURBQyBkcml2ZXIu
DQo+Pj4gSWYgeW91IGhhdmUgYmV0dGVyIHN1Z2dlc3Rpb24gZm9yIHN1YnN5c3RlbSBwbGVhc2Ug
bGV0IHVzIGtub3cuDQo+Pg0KPj4gSSBkb24ndCBrbm93IHdoYXQncyB0aGUgZGV2aWNlIGFib3V0
LiBUaGUgZGVzY3JpcHRpb24gZG9lcyBub3QgaGVscDoNCj4+DQo+PiAiVE1SIE1hbmFnZXIgaXMg
cmVzcG9uc2libGUgZm9yIFRNUiBzdWJzeXN0ZW0gc3RhdGUuLi4iDQo+IA0KPiBvay4gbGV0J3Mg
aW1wcm92ZSBjb21taXQgbWVzc2FnZSBpbiB2Mi4NCg0KU3VyZSB3aWxsIGltcHJvdmUgdGhlIGNv
bW1pdCBtZXNzYWdlIGluIHYyLg0KPiANCj4gVE1SIC0gdHJpcGxlIG1vZHVsZSByZWR1bmRhbmN5
Lg0KPiANCj4gWW91IGRlc2lnbiB0aGUgc3lzdGVtIHdpdGggb25lIENQVSB3aGljaCBpcyBkZWZh
dWx0IG1pY3JvYmxhemUgDQo+IGNvbmZpZ3VyYXRpb24gd2l0aCBpbnRlcnJ1cHQgY29udHJvbGxl
ciwgdGltZXIgYW5kIG90aGVyIElQcy4NCj4gDQo+IEFuZCB0aGVuIHNheSBJIHdhbnQgdG8gZG8g
aXQgdHJpcGxlIHJlZHVuZGFudCB3aXRoIGFsbCB0aGF0IHZvdGluZywgZXRjLg0KPiBJZiB5b3Ug
d2FudCB0byBnZXQgYWxsIGRldGFpbHMgeW91IGNhbiB0YWtlIGEgbG9vayBhdCB0aGlzIGd1aWRl
DQo+IA0KPiBodHRwczovL3d3dy54aWxpbnguY29tL2NvbnRlbnQvZGFtL3hpbGlueC9zdXBwb3J0
L2RvY3VtZW50cy9pcF9kb2N1bWVudGF0aW9uL3Rtci92MV8wL3BnMjY4LXRtci5wZGYgDQo+IA0K
PiANCj4gSW4gc2hvcnQgVE1SIG1hbmFnZXIgaXMgc2VydmljaW5nIGFsbCB0aGF0IDMgY29yZXMg
YW5kIG1ha2luZyBzdXJlIHRoYXQgDQo+IHRoZXkgYXJlIGFsbCBydW5uaW5nIGluIHN5bmMuIElm
IG5vdCBpdCBoYXMgY2FwYWJpbGl0eSByZWNvdmVyIHRoZSANCj4gc3lzdGVtLiBJdCBtZWFucyBj
cHUgZ2V0cyB0byBicmVhayBoYW5kbGVyIChpdCBpcyB0aGUgcGFydCBvZiBtaWNyb2JsYXplIA0K
PiBzZXJpZXMpIGFuZCBpdCByZXN0YXJ0cyBhbGwgY3B1cy4NCj4gDQo+IEFuZCBUTVIgaW5qZWN0
IGRyaXZlciBpcyBtb2R1bGUgd2hpY2ggaXMgY2FwYWJsZSB0byBpbmplY3QgZXJyb3IgdG8gDQo+
IGludGVybmFsIG1lbW9yeSB0byBjYXVzZSB0aGUgZXhjZXB0aW9uIHRvIGV4ZXJjaXNlIHRoYXQg
cmVjb3ZlcnkgY29kZS4NCj4gDQo+IEtlZGFyOiBGZWVsIGZyZWUgdG8gY29ycmVjdCBtZSBvciBh
ZGQgbW9yZSBkZXRhaWxzLg0KDQpUaGFua3MgTWljaGFsIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFu
YXRpb24uDQoNClRoZSBUcmlwbGUgTW9kdWxhciBSZWR1bmRhbmN5KFRNUikgc3Vic3lzdGVtIGhh
cyB0aHJlZSBNaWNyb2JsYXplIA0KcHJvY2Vzc29yIGluc3RhbmNlcywgSWYgYW55IG9uZSBvZiB0
aGUgTWljcm9ibGF6ZSBwcm9jZXNzb3JzIGdvZXMgdG8gYW4gDQp1bmtub3duIHN0YXRlIGR1ZSB0
byBmYXVsdCBpbmplY3Rpb24gYnJlYWsgaGFuZGxlciB3aWxsIGdldCBjYWxsZWQsIA0Kd2hpY2gg
aW4gdHVybiBjYWxscyB0aGUgdG1yIG1hbmFnZXIgZHJpdmVyIEFQSSB0byBwZXJmb3JtIHJlY292
ZXJ5Lg0KbGlrZSBNaWNoYWwgc2FpZCBUTVIgaW5qZWN0IGRyaXZlciBpcyBjYXBhYmxlIG9mIGlu
amVjdCBlcnJvciB0bw0KaW50ZXJuYWwgbWVtb3J5IHRvIGNhdXNlIGZhdWx0IGluIG9uZSB0aGUg
TWljcm9ibGF6ZSBwcm9jZXNzb3INCg0KQEtyenlzenRvZiA6IHBsZWFzZSBsZXQgbWUga25vdyBp
ZiBtb3JlIGluZm9ybWF0aW9uIHJlcXVpcmVkIGFib3V0DQp0aGlzIFRNUiBzdWJzeXN0ZW0gd2ls
bCBwcm92aWRlLg0KDQpSZWdhcmRzLA0KS2VkYXIuDQoNCg0KPiANCj4gVGhhbmtzLA0KPiBNaWNo
YWwNCg0K
