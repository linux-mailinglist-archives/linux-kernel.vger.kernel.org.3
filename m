Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB35669B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiGELev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGELes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:34:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BF6304;
        Tue,  5 Jul 2022 04:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/M7IfIVuJHKoShT98Xlom3ThaycbmTC1PA0qcrVfmNQiBNTk97z+au/tmCMr2RdnBaMoij8cbO5ZPwg6LZYVC6Rs8EbKV5JsHauXkSH7bEn4B91nheKKNkx5/iwjEy1vJeLlDIFxSfx1lEqCwqMQ6yZEp/uLzZbZoDAIGLr4LrNbYApI3Zqv8yro0nLd3T6l84is6StBeoaMQbbEeZy4YRHIwFtVy5hA52cwolm/pHAj5H8J0HqakZfdqgnu+wRlqfq14Em+pK51y5NpiS5+oZzAqWtnEENsUKhC4q4xi2pt2Qk4HoHLv5Om8Rya3FsIFK9ZwRankpK9ESE1cqnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoyA1Kdns/d8G4C7fQiJcokgwjkCQp6giSu9BtwR0XI=;
 b=ZqjjYUlfmMKDclQX7D58FtW+Qfy0+pJQYu0EXSY+nZ/nuhP7DELklpIOZ2J/YntiAe6/3f+7tAo1UOVHzrddN5UjgqYCMV4/+KwpcmmpZIEEQH0qYjmmYiTbHGA8lOam60R2Oje9AzeOruX+3HhMVyErvUxFflCODsKRRDkZjVYmFBqLcyAMi1iNGsweIbZ2rhPWliWARBxlxIU1cd0rxnWCCLUAKCGQulicoBvErhsviO4253Qkz0VLKF+4i+JfWGorSgDgrIm87kfqN83VS7RmrOjniLjz7C9gMKJKSroWBzT7r2MJfqCfBouxrstFVgKldelg1nZ6wpsclQWKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoyA1Kdns/d8G4C7fQiJcokgwjkCQp6giSu9BtwR0XI=;
 b=BjYZ1GIaNY+j1UoQ2xyQY+0vFnnjk+7UbdEO8l86ke58eNj3OB5scTluRuUvpRw3TSL4p7vk9u541YxVm0H11Sufa6nbtaGQaGtHHeUNlBYfq1QtoYY4UmXPE/1CqGQNLlj2GgNjqeEnyCY++JHZjdUnpBbsPNFWT2AA301BQkM=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6676.eurprd04.prod.outlook.com (2603:10a6:208:177::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 11:34:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:34:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG
 flag
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_CODECCONFIG flag
Thread-Index: AQHYipWDeE/RzjQxDUeRnOJpMoOdSa1uZxMAgACkm7CAAKRKcA==
Date:   Tue, 5 Jul 2022 11:34:44 +0000
Message-ID: <AM6PR04MB6341F78F9B7355C5C9188932E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
 <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
 <AM6PR04MB6341FA1173A9C5645554F882E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB6341FA1173A9C5645554F882E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5605ff-8a4a-4837-4797-08da5e7a5b88
x-ms-traffictypediagnostic: AM0PR04MB6676:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5z6Ppqh/miaa9grwTuazLbXuyzBytSJHl9I3hhxrAYfKHFQfxnkxyOml7mlQLDbGqd9UD2uXk4Ov7ZkE7YjtkDGDh4jhAW1c+1cqU73iZkQAqGEmwis7mG6Nl87Gn+fPLnERKIJD5uvdeOoUDbv518d+ZZ4tCt1bWL3KyV35BCOZgV2sSDNwm6VyyfQbr/JKx+trI3xQg7YFwC3SDUsfy1NZCj+V2L7dJ6LWRB1SA45K8AEYzo84B6H9z8vO+8q+IdMz6yMnk/NTCfyvoekdm0gc4/Di49hF3HBdJVr0DIsnhdGRoofLxmTCNyeNfNJRXaS6Yn5RqURlA7apFepTbgHTqm9Bv8MMB30XJc2WHJWSwelDddEShJEk/QVTRrjQsO7/zAX31NzfpUpcZEenCrhmFQaGSI4NiU0lzV1ougss9OUARAUGK2sNkTXak6MwPe7nlKfn1e10bYwhj9yKeSEQDScsfeHCt2wFLarkH528r76dhhK7d8Dt8jiHvP+rS/V1Uu8MEtgIZVj6fkVKMSWMJn/0D5shah4aLBV8YljlAI96yEQ5Vih7NHv4/3WD/Q5Q4Q6wMseYHdLkJqS6AyaDdEXXqHc6xBdUNMI3ygnGJ/CLRg39PF0+m3rJY4igjSLUXpjA8TIeGHkXuUlmXGzW23822zuuAiJNe/xopIdyQTy2HRPVXqwBqMoVcIdeLeycuJ/w4W3rcm0qYEYdNQnjIeSXKR6zABK4tgpenHCbD5ERVk9SccgMCmCvK0vv6gmcac43sAMXIPDtSXjsiqSes5X5qXBTAM1QF01SNCosEkXxfxUB3oIedEj15fU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(316002)(8676002)(66946007)(66446008)(76116006)(66476007)(6506007)(66556008)(64756008)(110136005)(41300700001)(478600001)(66574015)(54906003)(7696005)(55016003)(71200400001)(52536014)(44832011)(7416002)(2906002)(5660300002)(8936002)(86362001)(122000001)(38070700005)(38100700002)(33656002)(186003)(9686003)(83380400001)(26005)(2940100002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFZueXVMa2s2a3VRWkJVRVFYMmNWQktjYjUyVjNiWmUrY05pVDhsY280MVd5?=
 =?utf-8?B?YVdDUGsvSTc3TXEreDIxYmVzdEorVlY3QkkxUFcyZXgxV240UytrT3FnRTZQ?=
 =?utf-8?B?RWNjdjVtTWNlekE3ejJDRklLZnVaVjgzM2FvMkk3SUJvaTl2VGdDVkdIUmoy?=
 =?utf-8?B?NWhZTWY5VnpBTks3L1ViWXlLSk9oM1BZNzBhNFB1SzAxRnp0bEZUeTBXTmZO?=
 =?utf-8?B?MjFDVDE2RGpxZ3FVNVhnVjNhK0lkakVtU0RlYkQ3TnVzWkRjamx3ZXpuMmVt?=
 =?utf-8?B?cUUwTUk0UHZ2MDFkVExsTVBHOWN4RVFjTW1KR2ZFd0g3UjhOc0xXSFY2dFFP?=
 =?utf-8?B?dlFRUXdyVWNVcGZLdWdGZ2tLeVRnM0ErUnhjZElLbzlaQjQwSFQ4OXpCVWJw?=
 =?utf-8?B?ZlBNMTZkYU42M2dMaDB5UmNoM2pPWHdERzFXM3VYWVpiS1V0ODNPZmhBazh1?=
 =?utf-8?B?TTB2SFg2N29ieUt5N3pIVm0xbjI0Z0dJSnY0eTlKcWhBelU5Snp2ZFBtbWNn?=
 =?utf-8?B?Z25VVGhEQ0hiVVF6ek04STZFcXZTM0lMOXVZVmhSQjI5S25tWHdhd1d0U1Fp?=
 =?utf-8?B?MzkvSWJVUDlVaTVVZXZzKzFEVTJjc0hDbGs5VUpXeWYybkNWYitPcmVCWkRI?=
 =?utf-8?B?LzhnQUdhc0dyVURXWWhCUUs1TlJ6SXdaa3VacFpSRURERGFkWXZSTFNuZVpi?=
 =?utf-8?B?ckFKY0FUa3BNQjBhMTBYd0k3WHNlU0Z6aGQvSVJUU2YvSlBSVlA4N216MTl4?=
 =?utf-8?B?SHFEcnl1NVZCV1NqMFlVWE9KTWlyOWxMcHM0MTBScVUrN1psODd6N2hvOEx4?=
 =?utf-8?B?dUZrYlFVMndkU1dPMkhFZG9UeXFocUdZOHpTajRPM3VkZ05zSDJyY0FkcXlm?=
 =?utf-8?B?YlFQOUZwMFJlR2dQOElZYTJaalA3bE9kU2xqMHl4QSt4bWNpVHN1Zno3Skp0?=
 =?utf-8?B?dDBOVFN5S1BnYkZvRkVIS2JUY2wvZFlKMzc2MVFkM1FhanIyblZLMThIQzlG?=
 =?utf-8?B?TmpPQ1pUSk9ZaWhVOVhzVHQ4RHhXb2JkVGlMci9pUG1DZUlxSDBXdHBWMlBB?=
 =?utf-8?B?aEd4ZkNyM3E0cW8xMXRmd2w1aWpYRFRQcUplYWwyN3Rwb013eHJlZ1dxU2dQ?=
 =?utf-8?B?NjVxMmxkTndIdmNqNnNmV2NaU1Fqdm95MGl1NDA1SXZScnZoandTTENnMVA2?=
 =?utf-8?B?bHhDMTNjOHhqRzY2aGxFMzdXZkgrZFJLKzBLQkk3VzV3bC9GZDlNMXdZK2VU?=
 =?utf-8?B?aFZKWmpFUDRleFdPSkNqNkRDLy9DRDl2dUxNRFhNSkdGcklQSFN4bXZGMTh2?=
 =?utf-8?B?SUxSRERTeDFBU1hLYlpWaVV4bk1XWnM5b0VTODFjbFEweEJqd1FJZWk0WkQ4?=
 =?utf-8?B?d051NGJyOUE2T3JVV0xXcDNKdlVnTzNLeHBnN1BqdWxxbVptVW0zK2xibGRK?=
 =?utf-8?B?NXpUc0xjVm4yeFhnTUt3NWJKaTA0Q2ZsZzI2WWpjeG5NYlltblhrdVAzN1VV?=
 =?utf-8?B?YnRJclVLOXlvVndQcG44WFVuT1RKTlVya2VkVURPYWE1NVp2VFZSYWdPS1ha?=
 =?utf-8?B?Mm1iQ1lpRFdKK01pMTFBcFE1WjNJTVB0TWpSRHZ5SGo3L0ViUmhXVWk0RFVK?=
 =?utf-8?B?b2Zld0ZRdlJGeTNaN0ZlY3VDUmxBLy8vOTc2d1U2WHVZQzQ5SEFDOWtoV1lY?=
 =?utf-8?B?Rll4eXBrcW4wb3pDYlQxVXNDaVI1TkgrNjVlRHdMMzkrMlV2bElSS2NmSDZy?=
 =?utf-8?B?VjdaSHloeGs5ZVFVbUZEUnRJK2NqbkJWK2VPN2lKSGxsTWlSM1JHdFdRY0Zj?=
 =?utf-8?B?MHlJNzJxNHJDc01zOWlHSXV3WEpZQUt1M0c0QVRXVkhZOWpHdWt4aVpHUWlv?=
 =?utf-8?B?OUFROTBkT0Q2N0NJbUtTSFl4UmtTTEtCZUp0T1JlbmJCOXJSc2dkYS9id2U3?=
 =?utf-8?B?V3hqeFYxUnNDZE1OZHhhaXArTU1wTVlRcmI5cnIzSDByZzBkSlZKVDNLVTBJ?=
 =?utf-8?B?aVhXakRGVVE4RzNvZzhDTGUrd0tGbUhBdDd6Tjg1VlRjVUNiVENWTndydFM2?=
 =?utf-8?B?ZmVYSXJQdDBPVFBXY0xTeEs3V290SGF4dFUrWmMrNzJjWlc3aEpIWWlETUcx?=
 =?utf-8?Q?gV4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5605ff-8a4a-4837-4797-08da5e7a5b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:34:44.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvq89H12yqJ5sI4+BYJu6c6dfm6Mlc+8GsWSZfi3B3sw5V6stMRg7bQIsVzAHJsdWP68cHpblvreD/CfdSF2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj5Gcm9tOiBNaW5nIFFpYW4NCj4+U2VudDogMjAyMuW5tDfmnIg15pelIDk6NTINCj4+VG86IE5p
Y29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPjsgbWNoZWhhYkBrZXJuZWwub3Jn
Ow0KPj5odmVya3VpbC1jaXNjb0B4czRhbGwubmwNCj4+Q2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4+a2VybmVsQHBl
bmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPj48bGludXgt
aW14QG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+PmxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
Pj5TdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IHZpZGVvYnVmMjogYWRkDQo+
PlY0TDJfQlVGX0ZMQUdfQ09ERUNDT05GSUcgZmxhZw0KPj4NCj4+PiBGcm9tOiBOaWNvbGFzIER1
ZnJlc25lIDxuaWNvbGFzQG5kdWZyZXNuZS5jYT4NCj4+PiBTZW50OiAyMDIy5bm0N+aciDTml6Ug
MjM6NTMNCj4+PiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2Vy
bmVsLm9yZzsNCj4+PiBodmVya3VpbC1jaXNjb0B4czRhbGwubmwNCj4+PiBDYzogc2hhd25ndW9A
a2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0K
Pj4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1p
bXgNCj4+PiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7
DQo+Pj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+Pj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IHZp
ZGVvYnVmMjogYWRkDQo+Pj4gVjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyBmbGFnDQo+Pj4NCj4+
PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4+Pg0KPj4+IExlIG1hcmRpIDI4IGp1aW4gMjAyMiDDoCAx
MDoxOSArMDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4+PiA+IEJ5IHNldHRpbmcgdGhlIFY0
TDJfQlVGX0ZMQUdfQ09ERUNDT05GSUcgZmxhZywgdXNlci1zcGFjZSBzaG91bGQgYmUNCj4+PiA+
IGFibGUgdG8gaGludCBkZWNvZGVyIHRoZSB2YjIgb25seSBjb250YWlucyBjb2RlYyBjb25maWcg
aGVhZGVyLCBidXQNCj4+PiA+IGRvZXMgbm90IGNvbnRhaW4gYW55IGZyYW1lIGRhdGEuDQo+Pj4g
PiBJdCdzIG9ubHkgdXNlZCBmb3IgcGFyc2luZyBoZWFkZXIsIGFuZCBjYW4ndCBiZSBkZWNvZGVk
Lg0KPj4+DQo+Pj4gVGhpcyBpcyBjb3BpZWQgZnJvbSBPTVggc3BlY2lmaWNhdGlvbi4gSSB0aGlu
ayB3ZSB3ZSBpbXBvcnQgdGhpcywgd2UNCj4+PiBzaG91bGQgYXQgbGVhc3QgcmVmZXIgdG8gdGhl
IG9yaWdpbmFsLg0KPj4+DQo+Pg0KPj5IaSBOaWNvbGFzLA0KPj4gICAgRG8geW91IG1lYW4gT01Y
X0JVRkZFUkZMQUdfQ09ERUNDT05GSUc/DQo+PiAgICBJJ20gc29ycnkgdGhhdCBJIGRpZG4ndCBu
b3RpY2UgaXQgYmVmb3JlLg0KPj4gICAgQ3VycmVudGx5IHdlIG9ubHkgZW5jb3VudGVyIHRoaXMg
cmVxdWlyZW1lbnQgb24gQW5kcm9pZCwgSSdtIG5vdCBzdXJlIGlmDQo+Pml0IGhhcyBhIHJlZmVy
ZW5jZSB0byBvbXguDQo+PiAgICBBbmQgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgcG9pbnRpbmcg
b3V0IGl0Lg0KPj4NCj4NCj4gQW5kcm9pZCBtZWRpYSBzdGFjayBoYXMgYmVlbiBiYXNlZCBvbiBP
TVggZm9yIHRoZSBsYXN0IGRlY2FkZS4gVGhleSBhcmUgc2xvd2x5IG1vdmluZyB0byBDT0RFQzIg
d2hpY2ggbW9yZSBvciBsZXNzIGlzIGEgc2ltaWxhciBhYnN0cmFjdGlvbiB3aXRoIHNpbWlsYXIg
aWRlYXMuIExldCdzIHJlc2VhcmNoIHByaW9yIGFydCwgc28gd2UgZG9uJ3Qgc2NyZXcgY29tcGF0
aWJpbGl0eS4NCj4NCg0KSSBnb3QgaXQsIEknbGwgdHJ5IHRvIHN0dWR5IHRoZSBhbmRyb2lkIGNv
ZGVjMiwgDQphbmQgZG8geW91IGFncmVlIHRoYXQgd2Ugc2hvdWxkIGFkZCBWNEwyX0JVRl9GTEFH
X0NPREVDQ09ORklHIGZsYWcsIGp1c3QgbGlrZSBPTVhfQlVGRkVSRkxBR19DT0RFQ0NPTkZJRz8N
Ck9yIGlzIHRoZXJlIGFueSBvdGhlciBzb2x1dGlvbiB0aGF0IGNhbiBoYW5kbGUgdGhpcyBjYXNl
Pw0KDQo+Pk1pbmcNCj4+DQo+Pj4gPg0KPj4+ID4gQ3VycmVudCwgaXQncyB1c3VhbGx5IHVzZWQg
YnkgYW5kcm9pZC4NCj4+PiA+DQo+Pj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcu
cWlhbkBueHAuY29tPg0KPj4+ID4gLS0tDQo+Pj4gPiAgRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2Ut
YXBpL21lZGlhL3Y0bC9idWZmZXIucnN0IHwgOSArKysrKysrKysNCj4+PiA+ICBpbmNsdWRlL3Vh
cGkvbGludXgvdmlkZW9kZXYyLmggICAgICAgICAgICAgICAgICAgfCAyICsrDQo+Pj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pj4gPg0KPj4+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvYnVmZmVyLnJzdA0KPj4+ID4g
Yi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4+PiA+
IGluZGV4IDQ2MzhlYzY0ZGIwMC4uYWNkYzQ1NTZmNGY0IDEwMDY0NA0KPj4+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9idWZmZXIucnN0DQo+Pj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4+PiA+
IEBAIC02MDcsNiArNjA3LDE1IEBAIEJ1ZmZlciBGbGFncw0KPj4+ID4gICAgICAgdGhlIGZvcm1h
dC4gQW55IHN1YnNlcXVlbnQgY2FsbCB0byB0aGUNCj4+PiA+ICAgICAgIDpyZWY6YFZJRElPQ19E
UUJVRiA8VklESU9DX1FCVUY+YCBpb2N0bCB3aWxsIG5vdCBibG9jayBhbnltb3JlLA0KPj4+ID4g
ICAgICAgYnV0IHJldHVybiBhbiBgYEVQSVBFYGAgZXJyb3IgY29kZS4NCj4+PiA+ICsgICAgKiAu
LiBfYFY0TDItQlVGLUZMQUctQ09ERUNDT05GSUdgOg0KPj4+ID4gKw0KPj4+ID4gKyAgICAgIC0g
YGBWNEwyX0JVRl9GTEFHX0NPREVDQ09ORklHYGANCj4+PiA+ICsgICAgICAtIDB4MDAyMDAwMDAN
Cj4+PiA+ICsgICAgICAtIFRoaXMgZmxhZyBtYXkgYmUgc2V0IHdoZW4gdGhlIGJ1ZmZlciBvbmx5
IGNvbnRhaW5zIGNvZGVjIGNvbmZpZw0KPj4+ID4gKyAgICBoZWFkZXIsIGJ1dCBkb2VzIG5vdCBj
b250YWluIGFueSBmcmFtZSBkYXRhLiBVc3VhbGx5IHRoZSBjb2RlYw0KPj5jb25maWcNCj4+PiA+
ICsgICAgaGVhZGVyIGlzIG1lcmdlZCB0byB0aGUgbmV4dCBpZHIgZnJhbWUsIHdpdGggdGhlIGZs
YWcNCj4+PiA+ICsgICAgYGBWNEwyX0JVRl9GTEFHX0tFWUZSQU1FYGAsIGJ1dCB0aGVyZSBpcyBz
dGlsbCBzb21lIHNjZW5lcyB0aGF0DQo+PndpbGwNCj4+PiA+ICsgICAgc3BsaXQgdGhlIGhlYWRl
ciBhbmQgcXVldWUgaXQgc2VwYXJhdGVseS4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhlIGRvY3VtZW50
YXRpb24gaXMgY2xlYXIuIE5vdywgaWYgYSBkcml2ZXIgdXNlcyB0aGlzLCB3aWxsDQo+Pj4gZXhp
c3RpbmcgdXNlcmxhbmQgKHBlcmhhcHMgZ29vZCB0byBjaGVjayBHU3RyZWFtZXIsIEZGTVBFRyBh
bmQNCj4+PiBDaHJvbWl1bSA/KSB3aWxsIGJyZWFrID8NCj4+PiBTbyB3ZSBuZWVkIGV4aXN0aW5n
IGRyaXZlciB0byBkbyB0aGlzIHdoZW4gZmxhZ2dlZCB0bywgYW5kIGp1c3QNCj4+PiBjb3B5L2Fw
cGVuZCB3aGVuIHRoZSB1c2VybGFuZCBkaWRuJ3Qgb3B0LWluIHRoYXQgZmVhdHVyZSA/DQo+Pj4N
Cj4+PiA+ICAgICAgKiAuLiBfYFY0TDItQlVGLUZMQUctUkVRVUVTVC1GRGA6DQo+Pj4gPg0KPj4+
ID4gICAgICAgIC0gYGBWNEwyX0JVRl9GTEFHX1JFUVVFU1RfRkRgYCBkaWZmIC0tZ2l0DQo+Pj4g
PiBhL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92
aWRlb2RldjIuaA0KPj4+ID4gaW5kZXggNTMxMWFjNGZkZTM1Li44NzA4ZWYyNTc3MTANCj4+PiA+
IDEwMDY0NA0KPj4+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+Pj4g
PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4+PiA+IEBAIC0xMTMxLDYg
KzExMzEsOCBAQCBzdGF0aWMgaW5saW5lIF9fdTY0IHY0bDJfdGltZXZhbF90b19ucyhjb25zdA0K
Pj4+IHN0cnVjdCB0aW1ldmFsICp0dikNCj4+PiA+ICAjZGVmaW5lIFY0TDJfQlVGX0ZMQUdfVFNU
QU1QX1NSQ19TT0UgICAgICAgICAweDAwMDEwMDAwDQo+Pj4gPiAgLyogbWVtMm1lbSBlbmNvZGVy
L2RlY29kZXIgKi8NCj4+PiA+ICAjZGVmaW5lIFY0TDJfQlVGX0ZMQUdfTEFTVCAgICAgICAgICAg
ICAgICAgICAweDAwMTAwMDAwDQo+Pj4gPiArLyogQnVmZmVyIG9ubHkgY29udGFpbnMgY29kZWMg
aGVhZGVyICovDQo+Pj4gPiArI2RlZmluZSBWNEwyX0JVRl9GTEFHX0NPREVDQ09ORklHICAgICAg
ICAgICAgMHgwMDIwMDAwMA0KPj4+ID4gIC8qIHJlcXVlc3RfZmQgaXMgdmFsaWQgKi8NCj4+PiA+
ICAjZGVmaW5lIFY0TDJfQlVGX0ZMQUdfUkVRVUVTVF9GRCAgICAgICAgICAgICAweDAwODAwMDAw
DQo+Pj4gPg0KDQo=
