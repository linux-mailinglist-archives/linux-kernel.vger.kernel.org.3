Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E494A2C07
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiA2Fsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:48:51 -0500
Received: from mail-ma1ind01olkn0167.outbound.protection.outlook.com ([104.47.100.167]:17923
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230162AbiA2Fsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:48:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8mcqUPE43XpBMJDl8GIydyC4O3YDw1eNV1JYmww1RBHQTCNf7ZSVOiWL06UHDTJoSCQN/MuvbkOYmfg+L7zyzpwcKN3O2AXP63wP/KjL4D1T1w+Bhus6fcYBT+wWj3z7FPeP/qzCAAeHaZiMa32LgPKGsjT+tTH5Yf3xEP/2DuJWl+LeptiJVmXS1h57GGv1JEK6EwXkWf9AoDr4eXFUkNbIXiGLVPc6WjVlzoubB4FnSODcZNY8+lPTHnEAmTUjYzOpasW3RbGAjxu+HLn9NGL7YUmXUSPRarmJZO2BdH1sJP6rMRUy5sXKVo5lTWWA7zJcPdPKB7fAw9ssMA68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K39jKmR0qU9VqqmvIYUc5Jcf69ir932T8tJ8aRTzO/4=;
 b=HjwDgcENHF6R2bXSKx/wx8LPPWn6nsfZkeI7Z+igjyP3fR8QOI98dyJq9Wb8VMYB1lBje8mv5okiOk9OEplbc6QCCmxXER4rqNXYIIEOYzwWVaVflZwCqdYM6fCvV1+uGQbmOk5RDWDHnwgdprvX0BhveWtk+eM3tTO7ZMtX0oX5d8z1vXIbhlnDjDm5WA+wYuuYw0lWW1vRhr+UI1pt+jiB58tTR2NFZBnFF7waIvQ5V6ccdk3hn8YAMlRBVMv8+89xg5YvdpKN640dq8ebqf0aPdsKT9GI0M4JGxsLRWuyYJt7ML/2QRYC5Z8qVuZ6o/YB4t0IaI2h/FdlMK9u4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K39jKmR0qU9VqqmvIYUc5Jcf69ir932T8tJ8aRTzO/4=;
 b=EduGC/Sv7+X4/8SM6Fjdv3cxGi4yAQ07sT04ZPybdg1DSPnw/lX04HxpVQvTdCBEx3edJBFV/cojnAp4TrcM/m9/JEDlSeAfgjaZr+TGBgjD+aR8k5StgF/oq0Cf0lYzGVg9hWcR2O3Fihmk+siRg0dOCgIacrJ/3vzHwwk7UrArs1N8c6Nx1Rk7SESvfXiPrMQTwVH+MPwOAwbvblPvxESf7Eoo0N85nEaNBiIBbVP4GcbvHW77YYbRGFwFoBzwhoKcJQPTOsjiYq7kq3bnHgwX6lZUt2LfGe/dgCfSIK5hIKZ4bAn1ookwG1i3e3bb3C+tc1Y4rUR3zEHTXtAd5w==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BMXPR01MB4023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 05:48:38 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 05:48:38 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Harry Wentland <hwentlan@amd.com>
CC:     Alex Deucher <alexdeucher@gmail.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "stylon.wang@amd.com" <stylon.wang@amd.com>,
        "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
        "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
        "George.Shen@amd.com" <George.Shen@amd.com>,
        "roman.li@amd.com" <roman.li@amd.com>,
        "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
        "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
        "wayne.lin@amd.com" <wayne.lin@amd.com>,
        "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
Thread-Topic: [PATCH RESEND] drm/amd/display: Force link_rate as
 LINK_RATE_RBR2 for 2018 15" Apple Retina panels
Thread-Index: AQHYEqhR1816ln+3EEa6OAaxWUF3K6x3I2yAgAFHGACAACB8AIAA92eA
Date:   Sat, 29 Jan 2022 05:48:38 +0000
Message-ID: <0128D2BE-EB65-4E9E-B8C0-33DFE8D20CBC@live.com>
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
 <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
 <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com>
 <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
In-Reply-To: <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [747WJI+bXqxQBQ/58kDRnMIsxCyKDH+v]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86187fcc-d30b-4276-6342-08d9e2eaff45
x-ms-traffictypediagnostic: BMXPR01MB4023:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Au15fPzf23yBR4JmH3HIo8IDkR+yAI0KHekmIl69Hq2rh7Ae+JFZO36IrAhJgKIRmRcEjDByf3fUSXcSoxlL54PT+XVM4I+jIJYPN+MKB6b9kHatxVLsUDmzNDDxDJLfBORLTWJjd5Af1JPAvHQpY+F9R7g94+zUJcWh5Fbcgqzsksab3k7xU3rj0062h1BVEu6QRJR5/RAWxrnu0J/LSv/nvyoS6nchCcOoPIhzZCv971TOJYUI4Nt7NDc5A5S9cFH1yxrfiAVsrLejr1k37BBYg64BoqhaRuaI4QTMzdkQXtJAq7SqOrH4XI7rgS7o8X71GvLvKLwUWaL/vg7c/Rliq4ETai2q+RXYwjbvSjZ4a2AJd+gNz1yiEUq66ooVd/hGiaAMQX3LzwiCefMwy+I5qAvqbUFr4q8AbblUUg1qTZzXiBkOire1MXP6mPPd6UAlEGGU64EqRoVCDDnydSW/KzxIqIiSvOKOU5EmSZo4ERNT0h+XMjLbbcCVzMTeELXjqKXXBIrnP2t2BPwAu5QP56GFE9oYCoT2zgQYcLH+GHhaqkisGBfVb5BLPLbF0IfNP+1Yarl6ZRqgSjSxvQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHRacnBFaGtRelVaQkZuTkVTSm8ralJGbFdOUy8vZitaRVFIazZJVlNLSFNz?=
 =?utf-8?B?U2xOUVR5U0gzVnlUMXJRUXF4Z2JGallsWm5CL0ZURElHemZDdTNxSFVJVUVU?=
 =?utf-8?B?UjRkVWhBYmNvcmhjSE1wN1NzZnZtS1Jod2VsMTZCNmxPRVlJUzA5VDgrNFg0?=
 =?utf-8?B?VUtXREppbXl1MnNKdnJ2R3BZUndsYnFsMFdKQWhUS1FCV3FJR1d1bkM2N0ZB?=
 =?utf-8?B?K3pVTFRUd3dQbit4QXRIVnNHaTR6WXA3YzN2dnVCcUNhUjF2ZHJqa0hycWVs?=
 =?utf-8?B?a1kzVUNxR3JNcmgvb1F5MU1pdlk0R2hZK0wvN2xXQ2FKdHJLTCtTNzYvYWdv?=
 =?utf-8?B?OW54bkRKbFcrQnR5M1p3VDRDNHh6YlJjUThVN0czdThUTk12L2E1SVIwZDBm?=
 =?utf-8?B?L1NkaW9QUm5TRi9rOHpsN1dZRWRhWng1SENVNXllcEpzaUl6ZGs5eXNoVEdB?=
 =?utf-8?B?RTYvdmE3OXJXWnJZckdlQWFRd1psRlJiSXlXNVpkL2toNGxSSkQ3MEtjOW1r?=
 =?utf-8?B?MWZsSlYvT0Z2ZWxwRTdSYlhJblZBTUZpSmRwanJJcDg5RDY3ZG5FRUZzT0dp?=
 =?utf-8?B?Q0VSbUdUTm80aktNdk01S3J6V3VaM1BZbitLM0VOcVNrUEQzaWg1NExHRHAz?=
 =?utf-8?B?RHJFNldpN2IrbHJ1cmtxRnY3MTVKVnZDNjhMUVlPZEVlYjJmWmpqdllMY1lW?=
 =?utf-8?B?WnN0ZG5vcUpsb1JVWnY5U2dRNFlkQ0dqL1RSRlFTeno3VXQ2Z2lrTlg2OFYv?=
 =?utf-8?B?OHptdmIvRVNxUjNQeUp5emRqMjBJcVoyd01tVktKdWNUcm9YeUZPUHl2L3BG?=
 =?utf-8?B?WGdadTl0ODJiZXhpcHpqRjlvakxGbUgwM3poSVBBY3BoMW9GYlI1M2xvWFhy?=
 =?utf-8?B?N0wwcng0cUM3SDZDYkgySkZrOHZ1VTRIa3dWY2tYN0VaR2hWVyt5TXNyTHRF?=
 =?utf-8?B?cVMxTUdMaldsa1VlRHhmSzhYbUxkSDAwVEZqYUg0bVpMeURoK0dBL3U1VUlt?=
 =?utf-8?B?S2dBUjhpRVB3QmlmS2QxVmxkT3pFN1RPN2pFcGRmTzk5T0h3Tlo4bnIrcTVT?=
 =?utf-8?B?SWtxTWtWR1c3eUNORFY0QjBKZHlER0VlWHlTNWVZWXNWa3BWTm01cCtORGVp?=
 =?utf-8?B?RVhJT2FRWTBSckJoNi9kK3dxbkdsTzFRU3VKN1c4YVpSMGgzcFJDZTB2elVC?=
 =?utf-8?B?ZGp6WTRtaHExM0p1RzkvQTRBdjdtY1lFSHlTQjlZMXJqcHpvc2hzaW5pMVZS?=
 =?utf-8?B?bzk5U3RFK3pKUlFvOFlzRGNPc1E2cWVva01PSy9pN3NTbDJmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AC236F7B49CC741B7881BDE2743B1BD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 86187fcc-d30b-4276-6342-08d9e2eaff45
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 05:48:38.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB4023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMjgtSmFuLTIwMjIsIGF0IDg6MzMgUE0sIEhhcnJ5IFdlbnRsYW5kIDxod2VudGxh
bkBhbWQuY29tPiB3cm90ZToNCj4gDQo+IEkgdGhpbmsgZWl0aGVyIGxlYXZpbmcgdGhlIDIwMTcg
cXVpcmsgaW4gaXRzIG9yaWdpbmFsIHBsYWNlIG9yIG1vdmluZyBpdCBkb3duIHdvcmtzLiBJIGRv
bid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZS4NCknigJlkIGJldHRlciBsZWF2ZSBpdCBpbiB0
aGUgb3JpZ2luYWwgcGxhY2UgdGhlbg0KPiANCj4gV2l0aCB0aGUgY29tbWVudCBzdHlsZSBhZGRy
ZXNzZWQgdGhpcyBwYXRjaCBpcw0KU2VuZGluZyBhIHYyIG5vdyB3aXRoIHRoaXMgaXNzdWUgYWRk
cmVzc2VkLg0KPiBSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+DQo+IA0KPiBIYXJyeQ0KDQoNCg==
