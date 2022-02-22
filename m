Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB04BFF40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiBVQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiBVQv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:51:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D37116BCC9;
        Tue, 22 Feb 2022 08:51:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ6Q/2ZiPyDsNMUg4a2TBVStdpztN1rN/ITK3e4MatfB2pR5I2NLieVYeR0btJ4kgonBD2GfXJ+176ZvPAfm0JcOTVJ9Wh1CugVSF855izR8pQ9nw0Vu+oqUuaqN7r1SakelmGbaGuvND/+HRxX5TQfmyTRBvzjxhcc1TObVyXGselpOdXnLBYreZBcvsgOm2lmomoNB/W8yEcTS28Xxn/iSZ7brr52ffnROTZo9eNdSYQD70i39MMDnM0XTGCFGxXYPH3yfEBD4HqFmFEAlch7V4lAjDR4aZENKoMzaVeNCCwRENzD0NieuW7Sn9+LDRDAlRSqGPk3ShZNG0Ai6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24c9jIcvYvx45oCS+mxplTLgxKf7BbzNGegTWS03qtQ=;
 b=KW6gFWMgDTmYvlSGOAAp8U5PoO4Cegn0AGSxSmqW8/9avxhVJugOAUKgQ7mjiDq0bMcYQMl+y7iHoeatWT680CvDRkluwVEr27dikQLnzFDLmpXAje07OoYwWRcuQzhyHFdK5uzCbrFu0pzjrAbPCdQjoxj6OKe86evuJl3gEMT5IRsiYik1jwvZ4tnVVfvPBSscUSdZPrizzq+6wQ4KoW3d+NpGNGjrVoTnbXKWMbo3ZsmOAEynP//n9nKSPhTXHCA9KdtzNpTq8JpHx4env5R6FlLdafHnmrHbfSu53wNBMQixRAAizX5YNJR1Yr+XBVeoMXO8VrY2oEvKCb0IzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24c9jIcvYvx45oCS+mxplTLgxKf7BbzNGegTWS03qtQ=;
 b=ZRUEgroASby5rI9rA+L5S/463QPB7c0FhS5WCqzFeD2XByF7NHjaGrS9Z5Gxo/GMYX787dfc/yJdU1AA6t62m4cv7F/pla4Ib9/Kh1cFDMfKXtLMhwAdhR7+dqBfQ3eAqBGJIeMhECULLJc3qDopZfegwnkfyaGXvkFGBAloeKt9w2J/1eQZZ5LvwB1W4Dt19wuCWHHY/QdxNXYP+lx2Ky+fxA3LQiujlnzvez3rmp7Hgi4eiiKZjHxg2HH9w6dZMmo5G93D0bZqpZVN2y4ymhE3Oqfo6rwWCUYtP8LguVo/3/6iamyXI38KYlELdvwGL5Ley0zLExFe6Pw5P4oyFw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB3988.namprd12.prod.outlook.com (2603:10b6:a03:1a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 16:50:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:50:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCHv3 07/10] lib: add crc64 tests
Thread-Topic: [PATCHv3 07/10] lib: add crc64 tests
Thread-Index: AQHYKAnwSuSKvXUn4Eu+rkAJ836S9KyfyKcA
Date:   Tue, 22 Feb 2022 16:50:58 +0000
Message-ID: <d3a2d4ca-1d24-966c-f78b-955062592bec@nvidia.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-8-kbusch@kernel.org>
In-Reply-To: <20220222163144.1782447-8-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef1ec260-b7eb-4516-aa0d-08d9f6238079
x-ms-traffictypediagnostic: BY5PR12MB3988:EE_
x-microsoft-antispam-prvs: <BY5PR12MB398825294A0395AF4921FC45A33B9@BY5PR12MB3988.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdirLbg33qmvygaqWh2eeYAZaNKFES7/16pRKLBFGrSDCqptnwYk7IHUc9FozQWQMUKnrdpgPbE1K4Zs37WwlcvCai+8srT5PUkfXUqwSpuToCFb0r0KmZ0WtOtFLFksaOzdEHOSVYJpqUnFeEzdkopuwLkRqzqyunbCOc0XwIMeXBKHH2aUD0UXvoCAEpP66rX29H9jeSx9orvu1A4BP/hmvQQQDCA2nejBXqQHGLWrUrHJa1d5qY63kvuIYKogUFuGX4g1DjZGeulk1cRl2ROf/bG6OlO2fnJ3UbjvTwp4B3P2+DMoTvvvLqoIkF/C7Ea6bIlYrm8ixaOUxn4jDIn/uHSA8A10mqw6mgYPHhfngYtSb9nXZB8SCODEUh1R7xHZCeCbZUwxxOhTia4h9pnDgYYAr0kk84MxC8kyT9bqkNaW1NoVGIqgWR2iW4yKxx2WlofGg8yxa6lj30TBelZLzofj5I7z4H3VBPUlofeR7E+AoH6RUbx/Ap6JaFZH+d9elZ/rJYXX78Ac+9Lh92m16bCBEc2y6qSabgiZuaB/FR/V1c+dq9TzNVQaYCGJuvp9xG4aRR4Y+gcRRA/8Xru9IgzCJwlwkXyMIOXycRAgANMhRiJOftkMulcFjltcR1FCxVtfyR7rtR4aZ0ikU6H6YdgcPfV6DMH99p0qlR2LZV4yM3fr6DyQh7q7gKuKUTTgkAnCUrYn7ELVMNSzjdJEwFkZjtjjHICjVnpV0j9SksjWY4LDD6aYKO5ra4oO3OzfTvYW5Bvy2ZHprfWjgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(66476007)(64756008)(66946007)(8936002)(7416002)(66556008)(186003)(5660300002)(76116006)(31696002)(86362001)(4326008)(4744005)(8676002)(66446008)(122000001)(316002)(91956017)(2616005)(31686004)(38070700005)(6486002)(36756003)(71200400001)(6506007)(2906002)(38100700002)(508600001)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUlvOTRIQTIyQXJBQTBUeUsyeTNycjA4Zm1LY21HZnF2SGlWclhNZVlYTE04?=
 =?utf-8?B?Y3BYTjhuYWFmOUpvT2N0ZFREMG4weE1NV3Y1ZUdYVDJ3NnpXMUpGbmJ4dkZK?=
 =?utf-8?B?Wk9vc3pxcTl0aGg0bi9CZWFya2orWWNPQytVVkx5dWEwQXN3V3kwbXJkYnRa?=
 =?utf-8?B?TjdnM3A2QkF5ZzRYNWxvOTBFV3VRSXQxeVdLT2Q0bGJ4Q3VDWElwMEJ3eWFn?=
 =?utf-8?B?L1pmYTdyaFh0OGtEaHl6MjUwL3Q3Z2NQU2plRXRTNGdreWp3cWNvNWN0VnQr?=
 =?utf-8?B?RTI5SzBUOTNWckxXTnE5UDY5aVJDOFNNTGhLVG13bS9mZXVYQnBkYW44YVlr?=
 =?utf-8?B?OCtsSlEzUzdiMnRnb3lVQUo2cE9iNEFnRExlQjNibDRzbnZkR0dhcTU4aHNt?=
 =?utf-8?B?M1JmS1VmRHQ1K2IrYXhRbGdoTXdRSlZBbmdvMjFpTW5xWEI1UFBiMXFPRkI3?=
 =?utf-8?B?SS90eVBlaEZhaFJ2Mm5YaWdwaGphVGhHNmFxUkFLbHJ1a09NLzZ6aVcvZU1N?=
 =?utf-8?B?a1QrMklpUzN6OUh0SkcxdEVscjdQRmdwaXpUMmFnamlwR2syQmgxUGpLTXk4?=
 =?utf-8?B?ek9mUlU4NVBIYU5vYStDbjJLOVRTaUJvNldsdVB1WkV3NDFPdVdNdEQ5WTJ3?=
 =?utf-8?B?MFZhY2xBVkxqbDZCMXpxMTR4TXZIaTJ6dGxBVk82eWpDaWdNNG5WYnFwamh4?=
 =?utf-8?B?Vk94QjhydVRvNTN2NDdYKzI1d3dQaVBUYitQMzRJMkVWaE96cTFwclFxM244?=
 =?utf-8?B?MGd3NTJLZmd4eXNSWFF3WUNlZ1JWbE1tbVV0SDI0azhlbU5RZHoyNFBBYk1r?=
 =?utf-8?B?QTlOTFF1QlV5YzhVV0xLZHo4V2lTN0dkYWlvRE5Gc2lQVzkwWkowQ25hcE1I?=
 =?utf-8?B?c3QvWllLYk9VNVMzMUptL2JvRmlzMHBxRXB1UVlFODNKSVRTb3EwakJkOW15?=
 =?utf-8?B?VWRYVFJKTlRoeUpwcVQvdnpGNW5mODIrWGxjRzhISGpXc0w5VnVsS3pwK2Iy?=
 =?utf-8?B?U1A1cUhjWGJxSXY4QmJxNVQ5akJjWkgxRENKN2l6L2V6eVRGUDcraEx3Rng1?=
 =?utf-8?B?Mm0rWXRzZWI2VjR2MElQRjFzS3FHMzB1VmVXZDg4NlFIYlVrS1FqaTZZNDJa?=
 =?utf-8?B?RDlzVTFCL3ExaStoMVk3SHNzQ2dtWFNnMncxOGlsRXZteVFsVlJQUmNGdklX?=
 =?utf-8?B?cTNib2pJdWo3YTdVQ3VCYkxvZm5ZRUp4MlNVRExNQ284N3NUS2dqNjMxb1k2?=
 =?utf-8?B?UjIwaHR0VkxJWGR1T1NUYXVtSmxwaWU2NWl6Um11T3JOUWgwNVFYckh6S0I4?=
 =?utf-8?B?ZWRrOFdDbWNsdDlaLzc5UUJiMlo0OWlqMFJEOGFWOGk3TzBESitxaVNyK0tX?=
 =?utf-8?B?SzVaY2Z1OWdnei9WV0s1RVh4UGk1Z1dPQjZQRTZ4WkFJQzhvdVVMTWpCT1ZM?=
 =?utf-8?B?MndvRkRtVXZQWThzVDU4OGlPRGplYXJmSVRHZlpnUVBSVFhoc2d0TGZRSnBU?=
 =?utf-8?B?ZHlTUDFQdFh5bWN3REd1UlQyV3FoMTJJVkpDTjA5by9NejhYOUlQMmtZNCsx?=
 =?utf-8?B?REJITmxPZURxK1FHNW9LbCtMeXpZbVg2RjJQWnBCRzdncytGMVg5UkVjQlYz?=
 =?utf-8?B?ejhsbkhFUjVTMnkwbmV3QW1GVzVJZERENzFjMzI1cG9tQjlvY0NIc013cGN1?=
 =?utf-8?B?TFZuT1MzbjlTaGYvUVBENkx3VHg1K1loUHFvRGM0VW5OMnhDSll0d0Z0bmNQ?=
 =?utf-8?B?V3E0V2E3TmQ1MDFYWldETmUwWVlwNTltSnBnYXltTkk5ZmNUQTdaVVV5am1o?=
 =?utf-8?B?NitIVVRNc0p5UDhSUzdobWVtZVp5ZFNFTkl0cUZsUVlWOXBBRTg3THFzN0JC?=
 =?utf-8?B?UmNKMTQ3S0tkY3Q3bC9aOFFpbzlhSlhGVmgzT1Azb00rNEN4azJ0blZuckdT?=
 =?utf-8?B?TGFnaFdOU0dwNENiNks5K1hOWTFGS1RQV08zNDlZSlh2T01JZ0xWakUyVytp?=
 =?utf-8?B?Q01yQlhTbm02Nk9BWXVidjNiTkNWY1RYL1ExMUJpMTBTVlpSN1J2LzNiYnd5?=
 =?utf-8?B?anNiQW1MSnM5QnRrK1JIVTl1UjBQUW9SeUFBVXJjdzJLS1JkZEh1TDNNQkZy?=
 =?utf-8?B?R05wTjR5RkNMRUVnZThVM2NsWEZTcDRvbS9wdDczNFBRbzlOMFJZM1Vpblkz?=
 =?utf-8?B?OWhSTzBHYXlGMjR2VVh1Q3NPQzcyaTR3VFFneGhYMGV4bFhBOEJLS205Mi8z?=
 =?utf-8?B?dDJicUJ5QU5lcGpZcm01aWlxY0R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C37103A2DE635247B54F7BC57C282310@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ec260-b7eb-4516-aa0d-08d9f6238079
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 16:50:58.8599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/hn0W1fBRcvgmQ+B7KRwqpcM/Mv1HYYHKyLndCNOGiB74PQWihtCuikThn+jeNHkDDI6UQlQsEUg4HGt8yklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMi8yMiAwODozMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFByb3ZpZGUgYSBtb2R1bGUg
dG8gdGVzdCB0aGUgcm9ja3NvZnQgY3JjNjQgY2FsY3VsYXRpb25zIHdpdGggd2VsbCBrbm93bg0K
PiBpbnB1dHMgYW5kIGV4ZXBlY3RlZCB2YWx1ZXMuIENoZWNrIHRoZSBnZW5lcmljIHRhYmxlIGlt
cGxlbWVudGF0aW9uIGFuZA0KPiB3aGF0ZXZlciBtb2R1bGUgaXMgcmVnaXN0ZXJlZCBmcm9tIHRo
ZSBjcnlwdG8gbGlicmFyeSwgYW5kIGNvbXBhcmUgdGhlaXINCj4gc3BlZWRzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg0KDQo=
