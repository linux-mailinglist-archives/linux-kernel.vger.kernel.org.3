Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71244586230
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiHAB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHAB2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:28:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E811183D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4OXpbg+lcfD9yIQJV4CiTyIuJlq8Om82cN3ysXJ1IOnDkDUoPVRpDO7VisPM5F43nVnNpanjs8GNmLBS4DUEuaxjgDYrHtyvDsCyHX/2Y9Mt68AW+S2bjuKqsBXijJiQFXgacgLhYv4yrfXgFqLESjwQPtTA9HAkiu1YFjk63kzXFZIVwXFKFIF8EkpnSmGmtH2Oy3aJ8f915+HKmKw7n5gQuO5yV38UxVWhc3R9WexFEjs3a00AToKBWl5+kEMo5sqQwqXTApukqhAVwFCUGR0uSRHiBROaoAKw2GKzBnycD38xczdBytOy8V6SL+BRTZOvk6KGi/8JIj5sB5NJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb2DCQmArqxk6DjWD9xi1HTxvhhTdGz8r2B94lyQthU=;
 b=lvrgc4JMt9wu+/ZxYe7XjQDeYNprkhZEYKZxgnkOXmINPqgmebYtmmEDMAqcmkRCLP7b9UC/9uZARMmnY/jQgpT6yso1pyk5mpFa6vpVZEv6r52yRQzRo7wa3y6P4ySY+4VjhgLrGt6paO+JP42VcWO843luNE8e1PxD21qX5vI3dEDsID/aNIkuWSFiDEo+HrLkPEQ4PYTe9mcBiKsBFJbrEH4BZ0ZnGWmkpDYBbeYRdw7prhSrb2L1Y54TQg84srv/wWa2eV1RYI2ZhLTitPnAzKR9cqEBwusLcLJ38gB0N5zM4dDd36qYByvNbkTM7QN2+RAbcE7yigf3roEqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb2DCQmArqxk6DjWD9xi1HTxvhhTdGz8r2B94lyQthU=;
 b=GY6iEoqW2OJnK59s3xocpiSC1vBXxedjEZ0VpG6L3N7vYMgwT9paXL4qSKoirsGpX8ypwvbamQlkA+eX06SDWuDlQ/l3V99AHnv+r+RB3BtsHK6GuUK2kIx+ELiTA5LU+a/ll8gqBVZQunawusabuWGP69rQ22y3dfBXWCh/oM4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 01:28:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382%7]) with mapi id 15.20.5482.012; Mon, 1 Aug 2022
 01:28:06 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Sebin Sebastian <mailmesebin00@gmail.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "StDenis, Tom" <Tom.StDenis@amd.com>,
        "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
        =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
Thread-Topic: [PATCHv2 -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
Thread-Index: AQHYo8dhmTQk6H8R40KIO/iRlFn6Na2ZRDXg
Date:   Mon, 1 Aug 2022 01:28:06 +0000
Message-ID: <DM6PR12MB2619E4EC2D02A13ECEAF45D4E49A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220730034923.25500-1-mailmesebin00@gmail.com>
In-Reply-To: <20220730034923.25500-1-mailmesebin00@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-01T01:28:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33387ca3-6376-43f0-a7ee-1d1e2109f40a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30927d5a-185f-48b2-10a4-08da735d15d6
x-ms-traffictypediagnostic: BY5PR12MB4291:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDBn8vxeeOTybl4zHeJjP1pYssW39l8nZv11qIJqxQ3GRhWX8blXgKoHdPpXxSgYH2YWWrzr5S+ifpo3YjbGJyP5KA1VOvuPxOc7ofKixuwZU5KMlvLnHAEv+WcKVVlbMmZBLiBlSS5RlQPi6mnJZ8k7E1cENCv3rWc3kDK0lJqPin2RXotu+hm0SH0wQf1Ol9S62Ow8c90S9UPRhtFOI/k6Fc2DKAyDGBSshhmf/5esVs3CaXmLuLMrHzMjwnNqB+bokK6/mwrWYcD73XeNXxPkKGWZigOslG3VtMVCKTCXwsp0BU/pw/ahHv4D3PGMmS0rxIe1S9xVprxPvDxM9VMucY68641yLIh4sJU3jr0P8ASV8eUFWRNc7Cf2lib7g7A47WR+EDXMTrLP1d7Kc/Qz3/xYCQ4sPHopqvHRZxZVsKUaBmMx3lOUawq8SZoYPcZAKVILuzJydrDqEJt+UQpDTkVZ6pYWEVO4x/vJNxs1ZpqUoooYxy7f4ERuAkNGXURrAuAVsNs9qJuGoMBvUIvoB7PhVaX96a30j/jm9KnRLEATuSPZDY/MuOEyTplWvV4P1pve0Fv0usJsLelzwXR5MQ94MPHdNX/r263dnvtPUtIhknFvTqdTAXM1aJ/9YYn88DmrrfbxHCyq8a8hetldwAQhY3PNvW8dMprSYiemDLdhwVJO7LipMLTzyFIKvuTTq59+1TR2+ErTTd8MEjQiFsMfWBS3r20pGC+rymC9TUveQHo1n93+PdUOeQheurHGfmMgxTW1EVJctBnz/c0h0RwffvkjJdBxDV3oMf+0xGHOx+92+T1DZ5Y+0GX70+Rs9mO/IpoqNhMjumAVeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(33656002)(186003)(7696005)(6506007)(2906002)(26005)(9686003)(38100700002)(86362001)(38070700005)(122000001)(55016003)(83380400001)(41300700001)(76116006)(71200400001)(66946007)(66556008)(4326008)(8676002)(66476007)(66446008)(64756008)(5660300002)(478600001)(8936002)(52536014)(6916009)(54906003)(316002)(62123004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlQQmVydlRzOTlIZUtrZmR0NFEwekorN3pPSFNnVEdoSk1OdytNWkcwRVhM?=
 =?utf-8?B?VG81NUZaNzhnNHVVUytQaGxVVjIvdHlmNEpVRzVPL0dGeHM5eE8zRkhFZXdD?=
 =?utf-8?B?Q0tKOXRaUHpMTzRsUDZ2NUxHSElRZXhGbldWcUk3VFhuN1g1Um13R2tBdnZV?=
 =?utf-8?B?RnhTejhXaDE5WEM3cmdkaC96ZlBuMHRZTDF3QnJqUkF1SmE0amF1bWl5L1hx?=
 =?utf-8?B?Mk9GT2gybHA0RmZINnNtZExNYVFjN3JlRTh0Z1RzUEQvcFliWlNZTXMyYnQ4?=
 =?utf-8?B?LzFKekFuemZkYnd5L1Iwc2Y0K0RKU0FIUDgrbWEvbjR6SjE1UGVmSjVTaTdC?=
 =?utf-8?B?SFNVdjByWktUSVlzaXlxRTZMUkpkWFprVHNEbWk3TmNaRXZuMW50ZlV6bjRh?=
 =?utf-8?B?VCsreUk5dWJwZHdrbkVYRGJvRFoyL0h5YWVDRFl6ekYyamk5MXkwU1E5VlFi?=
 =?utf-8?B?VFZaZU5nOU5XcmI0L0JlWnpYam9RcVB2ZGU3VEhlNm1oNEVFTEt0am9QOFlE?=
 =?utf-8?B?SjQvVEpVcG5hTmk2blVzai9kY09kRjdZakRmQ0gvYnFxblJMSS90b2hIOU1z?=
 =?utf-8?B?WDU1czZxTGp1VHVINDk5c0k1MUdwdnZyVElJVmo4WUxLMXdwU1lBbU9PQXJZ?=
 =?utf-8?B?Z3haVVMvbFdieVV3blA5S3JZbFBqY2g3SkUvNEFJZ0FuekxmSGVsNEhSaDQ0?=
 =?utf-8?B?R3MveDZYS1NkVFBDL2ZpQjJNb0dCd2hLSEtuckFuaHd5SzNFQlpFZDhiUk1Q?=
 =?utf-8?B?OVdKb2czdWZtMk5pbjN0Z1VNb0NtcTVraFhHM3VGNFoweW9VRHlvenREMWlH?=
 =?utf-8?B?dGxuLzVOYVU0M1c0ajhnV1ptVW9PbTNJOXdraGlNTSs5S0RuL3NOdnhVdTBq?=
 =?utf-8?B?YWJ0WVZSWC9XeWsxRTgvZUIzcDc5cGk5SC9wcHh5ZW8rbGJobWlXZUk4NjJ0?=
 =?utf-8?B?L29nTDhUcWFtVnFjMW90dnQ4aGoxR2FYZndRWWRCdlZydWF1Ymo5RzhtdVZN?=
 =?utf-8?B?MDg3M3RnSzFhTjFuQ1RZNXZHb1hhVDFBQ3BGcjNpVS9WYVRhZFo5eWJzSFd1?=
 =?utf-8?B?NlRrUjQrWkIxQWdSbGo3VGJCVFVYSWtvZi9MMnJaVWtId2lrOHgwYS9hSjBs?=
 =?utf-8?B?TlBGWXlTMFlMZTNua1BjeXRoMTFRU3pMQzJKNzJOQlpSaEZVV2tsL1dQWk9P?=
 =?utf-8?B?d3lVc1FiZjRQcjVFL0Y0TTNKUDd2TU9jWVg4NEEzYjllRmViZEM0V0VGNjZL?=
 =?utf-8?B?ZFRRSDU2akl4MU4vM213aHhMWDBqYXoyc25BOXIyM2hLellLQmY4OFMzNERO?=
 =?utf-8?B?UXdjeVdvQ001dGNReTZlTmRsMzFZcmtWRTNjekVRbG5CbVJLakhzVVNOaW5n?=
 =?utf-8?B?Vmsvbnc3ZFFPcCs2MFhKZ0lXNVFheENnSXREc0xGbzArMzVBNlRhM3FrNTN5?=
 =?utf-8?B?clVkSzlJYXpvUythYWtEdEZKMzJ6Wi9FbVR2eWNXVmgxR1pBaWhOTkFsc1BH?=
 =?utf-8?B?eFdRMm9nYWZrcVNBSGgvQW5TU3RVZndac09JWXdZazFWQmdTN2hqckI4THY4?=
 =?utf-8?B?cHNTYlRpU3Q4cCtNRGlleWlGd1hCT1FvSTQyVVNSdEVDOGM3M0JMZG1yT3Za?=
 =?utf-8?B?MEI0UTZXOERtQ2JuRGgvZ3hoQnd3WUZPenJwZEtTejRpQzl4Y2JPRGk2azRJ?=
 =?utf-8?B?ZkgvTzlJRnhZRXZQenVtZ0FpRWV2RlhQRkRza0VZWWlxUW4raFlYMFBmc0pT?=
 =?utf-8?B?L3F1b1ZpUzcwN0tEZlF0dUxENFJzVlFuVzVMYzVWTVg1N0RhM25oZVYyNVRx?=
 =?utf-8?B?TEQ0UndIWFRPTTh4SFFFVGpvcHdrdy9BL0NUNUtMUzlwSGdkYkd5cjVsNHFz?=
 =?utf-8?B?TXJZMzFRYmI0V0FEZ1hVSkM1cDZqNXlaRWNha1pMUWhOWkpVWEh6MVB5NDZR?=
 =?utf-8?B?dzVHNGh2bis4ZHdZdkhqeURQWVRhT25QbFdFWm9QcjNMaGdvSXo3VjIxb3RR?=
 =?utf-8?B?WGk3Lyszd1RPdjhwejgrV3VSempXTiszdDVwN093U2NXbmR5WmRHY3VyNzc5?=
 =?utf-8?B?T3hieGNyUjBEeW10WTd0bXpkWEFsVGZZMnBUWXltd2h1MTRKVVlQUERHd0JP?=
 =?utf-8?Q?88UU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30927d5a-185f-48b2-10a4-08da735d15d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 01:28:06.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjtjoa3f6IT+WKHcwBlO/k7OrIWGpJZSnu0QJfcLitBdtjccC8RvQb86z2PAn/yx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFNlYmluIFNlYmFzdGlhbiA8bWFpbG1lc2ViaW4wMEBnbWFpbC5jb20+DQo+IFNlbnQ6
IFNhdHVyZGF5LCBKdWx5IDMwLCAyMDIyIDExOjQ3IEFNDQo+IENjOiBtYWlsbWVzZWJpbjAwQGdt
YWlsLmNvbTsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFBhbiwg
WGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBEYXZpZA0KPiBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+OyBOaXJtb3kgRGFzDQo+IDxu
aXJtb3kuZGFzQGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgUXVh
biwgRXZhbg0KPiA8RXZhbi5RdWFuQGFtZC5jb20+OyBTdERlbmlzLCBUb20gPFRvbS5TdERlbmlz
QGFtZC5jb20+Ow0KPiBTb21hbGFwdXJhbSwgQW1hcmFuYXRoIDxBbWFyYW5hdGguU29tYWxhcHVy
YW1AYW1kLmNvbT47IEFuZHLDqQ0KPiBBbG1laWRhIDxhbmRyZWFsbWVpZEBpZ2FsaWEuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS0NCj4gZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRD
SHYyIC1uZXh0XSBkcm0vYW1kZ3B1OiBkb3VibGUgZnJlZSBlcnJvciBhbmQgZnJlZWluZw0KPiB1
bmluaXRpYWxpemVkIG51bGwgcG9pbnRlcg0KPiANCj4gRml4IGEgZG91YmxlIGZyZWUgYW5kIGFu
IHVuaW5pdGlhbGl6ZWQgcG9pbnRlciByZWFkIGVycm9yLiBCb3RoIHRtcCBhbmQNCj4gbmV3IGFy
ZSBwb2ludGluZyBhdCBzYW1lIGFkZHJlc3MgYW5kIGJvdGggYXJlIGZyZWVkIHdoaWNoIGxlYWRz
IHRvDQo+IGRvdWJsZSBmcmVlLiBBZGRpbmcgYSBjaGVjayB0byB2ZXJpZnkgaWYgbmV3IGFuZCB0
bXAgYXJlIGZyZWUgaW4gdGhlDQo+IGVycm9yX2ZyZWUgbGFiZWwgZml4ZXMgdGhlIGRvdWJsZSBm
cmVlIGlzc3VlLiBuZXcgaXMgbm90IGluaXRpYWxpemVkIHRvDQo+IG51bGwgd2hpY2ggYWxzbyBs
ZWFkcyB0byBhIGZyZWUgb24gYW4gdW5pbml0aWFsaXplZCBwb2ludGVyLg0KPiANCj4gU3VnZ2Vz
dGVkIGJ5OiBTLiBBbWFyYW5hdGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBTZWJpbiBTZWJhc3RpYW4gPG1haWxtZXNlYmluMDBAZ21haWwuY29tPg0K
PiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gVXBkYXRlZCBwYXRjaCBib2R5IGFzIHN1Z2dlc3Rl
ZCBieSBBbmRyw6kgQWxtZWlkYQ0KPiA8YW5kcmVhbG1laWRAaWdhbGlhLmNvbT4NCj4gUmV3b3Jr
ZWQgdG8gaW1wbGVtZW50IGEgY2hlY2sgaW4gZXJyb3JfZnJlZSBmb3IgZml4aW5nIGRvdWJsZSBm
cmVlIGVycm9yDQo+IGFzIHN1Z2dlc3RlZCBieSBTLiBBbWFyYW5hdGggPEFtYXJhbmF0aC5Tb21h
bGFwdXJhbUBhbWQuY29tPg0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZWJ1Z2ZzLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGVidWdmcy5jDQo+IGluZGV4IGUyZWVjOTg1YWRiMy4uY2IwMGM3ZDZmNTBiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gQEAg
LTE3MDUsNyArMTcwNSw3IEBAIHN0YXRpYyBzc2l6ZV90DQo+IGFtZGdwdV9yZXNldF9kdW1wX3Jl
Z2lzdGVyX2xpc3Rfd3JpdGUoc3RydWN0IGZpbGUgKmYsDQo+ICB7DQo+ICAJc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKilmaWxlX2lub2RlKGYp
LT5pX3ByaXZhdGU7DQo+ICAJY2hhciByZWdfb2Zmc2V0WzExXTsNCj4gLQl1aW50MzJfdCAqbmV3
LCAqdG1wID0gTlVMTDsNCj4gKwl1aW50MzJfdCAqbmV3ID0gTlVMTCwgKnRtcCA9IE5VTEw7DQo+
ICAJaW50IHJldCwgaSA9IDAsIGxlbiA9IDA7DQo+IA0KPiAgCWRvIHsNCj4gQEAgLTE3NDcsNyAr
MTc0Nyw4IEBAIHN0YXRpYyBzc2l6ZV90DQo+IGFtZGdwdV9yZXNldF9kdW1wX3JlZ2lzdGVyX2xp
c3Rfd3JpdGUoc3RydWN0IGZpbGUgKmYsDQo+ICAJcmV0ID0gc2l6ZTsNCj4gDQo+ICBlcnJvcl9m
cmVlOg0KPiAtCWtmcmVlKHRtcCk7DQo+ICsJaWYgKHRtcCAhPSBuZXcpDQo+ICsJCWtmcmVlKHRt
cCk7DQo+ICAJa2ZyZWUobmV3KTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAtLQ0KPiAyLjM0
LjENCg==
