Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A415697C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiGGCJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGGCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:09:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540EB2F012;
        Wed,  6 Jul 2022 19:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMfZelk1PelM8peoZhMtUYQNkMgcRFZgPVnV3Cyfbd3ifAQv1DtWCI5ABGH2zW0FJ+LcUpiZyRNU5zmh+CrDcz+uxaYcs4CSuRAIyaScEqfP+P2+eaGwYTMI8VEt+Q098rHs4xCzVbK/6EMSA4cO+q0i6ybuEOYqK1Ui5A3s3vX0ImuPh4iCS1FNSOE9Llfi/t/AmEugE+yj15z66cwWwCznYPdcldDO0cr9OCiWx8OhXi0znzc6OY0W5ZFn05G6HsHLepEf9Rx7ViX/1hSHKgpUu9InHSGU4sR3iwsnvnX9R+0AfTeDa9JE2G0bpwtvSbqBzg/kfORgaTWU0JvIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNwtRaP3eaD6gzFxeXUXkyoBZwlzUdIFBulCf5RZhQo=;
 b=hxqavEclZB0OXXy+Uiz7AUHmxXC30mHS8N/Dj3Q6K+yfGRNtD6FptyzFwOdyYPwEpSWFi8QXbci6V1OQRsKF8X7f1bt+wgMkfxXRWtKYp+Jy/tzbKRFEGdjiZnKC3yvP2ByfDgaqwdZaFdlT5EeAexTN51gh2BzHN9mRxay04eWgNHPQT5OWm+ylz95BxcrnrrMy0utRzUvUZSjbmfbs7xJyDbzCuQ4oFiCiqIAAD/tdXwiyK0lMbTCqvLc6mq+V/StHVxg+DWsGiz3SElDfS+B9c/GYWOfWJ8Rr1Adu1TKgYwSmgQIaxWZ6/rks4JQqVaJyDG/bi6OKZqI/VtYOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNwtRaP3eaD6gzFxeXUXkyoBZwlzUdIFBulCf5RZhQo=;
 b=ddvHm/B494Qwrnsh0lVFogrm2xCTZEM+TKyF2ISdArvywQaTvIuCv2PGD3jBY5lH/olIk4AoC4hjNq3RIrtPXs6FaGff5LBMKDu1XoC4qiuT61EhQKKWQEocB12dZiLiznK7w936ivAPqpUM/HgafvlUTSCMZBJMNDJ29+oTW3g=
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5c::14) by PS2PR01MB2246.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Thu, 7 Jul
 2022 02:09:14 +0000
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::688b:31d:d1a9:1fae]) by SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::688b:31d:d1a9:1fae%8]) with mapi id 15.20.5395.019; Thu, 7 Jul 2022
 02:09:14 +0000
From:   =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] Add an entry for MOXA platform board
Thread-Topic: [PATCH 2/2] Add an entry for MOXA platform board
Thread-Index: AdiRCQhzXENiN+J4RBSxmos7e7A6YAASow6AABSrMtA=
Date:   Thu, 7 Jul 2022 02:09:13 +0000
Message-ID: <SEYPR01MB427261455EFBC92622F87ED1FA839@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
 <20220706161517.GA140402-robh@kernel.org>
In-Reply-To: <20220706161517.GA140402-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 237c6f77-f53f-4b99-898c-08da5fbdb077
x-ms-traffictypediagnostic: PS2PR01MB2246:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKBZN5xEZb10tGwdcnIQalFLmBtRPCp+vVoL52EJ/JsuJEBLMLrTy37F8+VXOStgsZfA5CL/5CglMi6rSrbTHsveun5caLklOukG4FBSXkzELDDwmusjlNe2ShYqNwMenXZbBTyId7o6C5DL4cX9ej0o51UDMFNBDuhsVxDS1Ti0PBobc4C/1tDZ3OWtRaapEkbxKFlkUa72kPbG9BJT6Cx27x+pRntRcU4jhb3SlwtRM6+GhaHwFcnfiD//YqNes9OLOfeKp+AbBSZ50+qZd70hVFFIkNrrLpQYIeMn0UHQAgEB803A4Xt9ku+fwyv4Xzxy9/TvGzefaP4hHL4iDZSTEtM9BHqDUw9muYUWbJZSmQVUGB5I8IZCbx1Vx73ztA50I2Zpu9bQ3EAbb4NCkCcO/bHmq4mkiDBXfkmth0b5tsCadvj7begFAPBSlhh4Koz3iDR7eMXkJgJuB0Bnp2GKkkc+IgI5Eku8aSaGZ369ZC/X+SA4D4vpZG9RbD09NIOcEs3x+wKujAakrSQmJEaks5U2LgRF2pCnUtjyAe7ydGiPG7n3qTautLLIZLy8x26LbcH2GtwuAn18B37avEQJiTJ6JGkPmjqCf+bTKOBNmSPHHTBDBlLGAzNCXFjJqRha+y1QVYF6TZgCCu9dQeCd1GwScMIRQRXcWEQ7rcpWnqRr+qcyFUQg2OX5bQsDPfvrWKkX3piPqDVYrfUgsmrg6DCwtE5pXtSFoS7jbT2wnaM5A3ZdsOVPO1IG1qgwughaRNBg8s8gc2AW4wHQvPSwyiQCivqfhIQ2KS0ohFLhFxXZCOMl2RObk97y8+crQyoNPnLxQhJMr3urb+wBoTnW3K/lzM0Qleto50CT9OM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB4272.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(8676002)(4326008)(478600001)(66946007)(38070700005)(66446008)(66556008)(71200400001)(64756008)(76116006)(83380400001)(53546011)(7696005)(66476007)(6506007)(41300700001)(6916009)(9686003)(186003)(54906003)(316002)(86362001)(26005)(2906002)(122000001)(45080400002)(85182001)(38100700002)(8936002)(52536014)(33656002)(55016003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?UjlBdDVOL0l5K3llM0s1cEEySVYvNkNNVytZSG5jV3VPbXNXOWs0M3l6cklQZTNz?=
 =?big5?B?SXhUdjZCdGppVkNxcjdFZy91OEhnblBtekhYUmFrMHZSS09EOHpOSDNJS1kvWGpL?=
 =?big5?B?aVZOSVR0emlCRzFmYkVIQ3c2azV5VDdTR01oM1B0OWtXQmRSV0FMWTJYbnhXQlh6?=
 =?big5?B?SlQ2MUlFem5RQWpreXVrNjdNMkl6NVFNa2NhMkdveTlUU1FWc3Z1RFJzaXhpZ2R4?=
 =?big5?B?Q1VWNlUwblZ0dW9CVERFbjRlaU5pOWhmcmFMYy9abU96bEJ2OG9tWFlJMk5qajZp?=
 =?big5?B?Mk5UTUkrWnBJdFZpdFRzdVh0Wm1ET0ZjWE9VMFpwTXV6QlV4Q3A0S2FOM1A2aHJP?=
 =?big5?B?YkwrZG9meXpwd2k5RUFmYVFCaGtvNUlkeFFQV2czOTVOcnQwMEpuYUoyQWlGUlgz?=
 =?big5?B?bTBkeXpxTGVGc3JxWGd2QmJJVFl2UGlGd2ZCbmN6R0ZWaXZocW93bU1IZi9rUTMw?=
 =?big5?B?NW1ZS0UwcTcyWTRWTXhDNmh3bWx1Nk16U0NsTVNuSERMekdacW01V21pVE55Z25P?=
 =?big5?B?NXZqVTRkWk0rSnErb0VYanNnY2JlSC9maGJCVkpjRm5iMUZ1Sk4rS09MaGQvc3Jx?=
 =?big5?B?anNEaUlHVUZhS1J4L1hoK0NLTWtXU2ZwSnhQT3QrUEx5UDFuL1I1eHRzV1BvRFZO?=
 =?big5?B?WjBUWjlQY3FMcVBkRXZBcnBSRXZRQjIwMVhXdmJ4ejA3aGl1L3ZQb09SeExyYlBy?=
 =?big5?B?N2NiTjE1M2laZ2RDSjc0djlYcC9SZUFJR2RvMmZPalVXcjRqb2pvUG85SGNNZk1Y?=
 =?big5?B?dnlYUmJzVXlKTXVHTjBmbThjSEt1UzZYME1XOFBBamI1TklGb2h5dFk0N0lyNXor?=
 =?big5?B?clFmbEpjUjRlVDR6cEtUSThyNGFxME1zV0RoNkUxZkxqUVVvMkd2Undtbm9JVTdu?=
 =?big5?B?Y2d2SWRFaDhqTWVNTWpMK0NLbHlLNW9RTkVzelZmYWJFS01zcnhTbENHZ0JCTlAr?=
 =?big5?B?T0FIYk5qbjFadzAvMEl1UFduYmxpcFAwWWYzd09sMWM4VmE1VjZLWkxlQTNKYnBD?=
 =?big5?B?aFFDZmtOaEtYVG82WW1oN0ZOL2dIRXUrUldlU09OVHJKb0U1MjhVUCsrY3QvRDdP?=
 =?big5?B?ZVV1N2htQ2E2UmtwVVJrQ0RMWHNoRmdBVGlHY093azFtcFdraTNlT1JFNDQreW9I?=
 =?big5?B?NVJ6cStrVlRaVmt3dVpsZ2lraGdmbGVmSUlFR3plNmE1QnJNK050cXVaZ0pqaGFl?=
 =?big5?B?UzEvQ05TUXRUeTNJTUdVbTVQNllnbGZBdGJaMTl3NnprOFRrMW05UVdHQjV0MUpE?=
 =?big5?B?enl3Skw5OVljeWhIb0pOTm5jZ0g4aUVpUDNEK1FhWTkzdk1ETUxRcGVacURtOHNY?=
 =?big5?B?enIwcE9UVHJxVGJTQVV5RUQ0d0IvVGpyWjNtdEF2TDlMbEtieFhWbkNPL0NzcG9u?=
 =?big5?B?QUpSSngwRDQ3d25DazZ1bElCQUZPYmRScElSbmpHeU5RNC81VWJBTzRLZXozZlhu?=
 =?big5?B?TnhLNkJUWnZqZkxTQ1JjME0vMGhlN0g5bWNBcTNKaGl4STUzNEhjNFhwRExHM0h4?=
 =?big5?B?MEo5R3pJcDBmbVFzaGtEMDRaMjBHRFFOSEQ5ZjQ4dWYyeDY0Y3FaTjFYMHV5QnZp?=
 =?big5?B?WEg4Y1V3SEp1cHpyVXB5UW53eDlTTVV2UkU3bDk4SVZ1NVlCZTB4V3dlSFd2SWVR?=
 =?big5?B?bEQwNk1ISkVoVFFZRmsrZXEyaGp6a0R1ZkY2VDdHdlJ6M0ROcWpoYnJyallGdHM0?=
 =?big5?B?TDdFNFpuaWdXSzNWaWtPOTBOVytjNEY5L3RaNlpJNFM4YnFVNUpUOVk1QVdHYjdh?=
 =?big5?B?dWdOY1lWdW5zVHBrZWozWjkyYW5zYTQ2Ui81UCtDRlcrVURtRkN5MjZPV1B5V0hq?=
 =?big5?B?bnFGaS9Laml5YnBWc3pxdjFRc01VYUR6RjdGcnRnUGhyeERzTE5WZjQ5SlFqWDVY?=
 =?big5?B?TW03MjhENmhxbWloMVZjUnFqL3VTMlZmbzk1M05Za05HRkZlSURIWFdqR1R1Tjk1?=
 =?big5?B?NVhac0JvOG82M3RCbytVTjJva1V5WCs2NHkxb3ZNZS84RkZDT1RJKytySzJmNUVj?=
 =?big5?Q?PgQnE6aMrJz5b+C1?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4272.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237c6f77-f53f-4b99-898c-08da5fbdb077
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 02:09:13.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7l4vATGT53Dp50BwRbaZfZQ87MrjQfKIeuOrpD36OUyybn+pdbqvfP7guQ83634DHOoz54/7Ky1O6U4lIYDGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR01MB2246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9iLA0KCVVDODIxMC84MjIwIHVzZSBGcmVlc2NhbGUgQ1BVLCBVQzcxMTAvNzExMiB1c2UgTW94
YUFydChtb3hhcnQueWFtbCkgcHJvcHJpZXRhcnkgTU9YQSBDUFUuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiANClNlbnQ6
IFRodXJzZGF5LCBKdWx5IDcsIDIwMjIgMTI6MTUgQU0NClRvOiBKaW1teSBDaGVuICizr6XDuUYp
IDxqaW1teS5jaGVuQG1veGEuY29tPg0KQ2M6IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBBZGQgYW4gZW50cnkgZm9yIE1PWEEgcGxh
dGZvcm0gYm9hcmQNCg0KT24gV2VkLCBKdWwgMDYsIDIwMjIgYXQgMDc6MjI6MjNBTSArMDAwMCwg
SmltbXkgQ2hlbiAos6+lw7lGKSB3cm90ZToNCj4gVUMtODIyMCAmIFVDLTgyMTAgaGFyZHdhcmUg
Y29tcGF0aWJpbGl0eSBtb2RlbA0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmltbXkgQ2hlbiA8amlt
bXkuY2hlbkBtb3hhLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bW94YS55YW1sICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbW94YS55YW1sDQoNCldoYXQncyB0aGUgcmVsYXRp
b25zaGlwIHRvIG1veGFydC55YW1sPw0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tb3hhLnlhbWwgDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tb3hhLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi43M2Y0YmY4ODNiMDYNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21veGEueWFtbA0KPiBA
QCAtMCwwICsxLDIxIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkgT1IgQlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IA0KPiAraHR0cHM6
Ly9hcGMwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZkZXZpDQo+ICtjZXRyZWUub3JnJTJGc2NoZW1hcyUyRmFybSUyRm1veGEueWFtbCUyMyZhbXA7
ZGF0YT0wNSU3QzAxJTdDamltbXkuY2gNCj4gK2VuJTQwbW94YS5jb20lN0NiMWE3NTkzMTkwYjA0
MGFmYmMwYjA4ZGE1ZjZhYjk2NyU3QzU1NzFjN2Q0Mjg2YjQ3ZjY5ZA0KPiArZDUwYWE2ODg3NzNj
OGUlN0MwJTdDMCU3QzYzNzkyNzIwOTIzMDUxMDM3NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
DQo+ICt5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lM
Q0pYVkNJNk1uMCUzRCU3QzMNCj4gKzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9SDZLUVFjb0k1S2t6
aFBIS010TWF0SE9xODRiaUJ3THBIWSUyRjdGU2E3d1BjJQ0KPiArM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gKyRzY2hlbWE6IA0KPiAraHR0cHM6Ly9hcGMwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hl
bWFzJTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMDElN0NqaW1teS5jaGUNCj4gK24lNDBt
b3hhLmNvbSU3Q2IxYTc1OTMxOTBiMDQwYWZiYzBiMDhkYTVmNmFiOTY3JTdDNTU3MWM3ZDQyODZi
NDdmNjlkZA0KPiArNTBhYTY4ODc3M2M4ZSU3QzAlN0MwJTdDNjM3OTI3MjA5MjMwNTEwMzc0JTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5DQo+ICtKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzANCj4gKzAwJTdDJTdDJTdD
JmFtcDtzZGF0YT1xR2V4djNFcHRXTzYxWDJvJTJCY1kwQ2xsZTJxSGxFR0ZEY2tzTVIxQTRHV3cl
Mw0KPiArRCZhbXA7cmVzZXJ2ZWQ9MA0KPiArDQo+ICt0aXRsZTogTU9YQSBwbGF0Zm9ybSBkZXZp
Y2UgdHJlZSBiaW5kaW5ncw0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBKaW1teSBDaGVu
IDxqaW1teS5jaGVuQG1veGEuY29tPg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRp
YmxlOg0KPiArICAgIGRlc2NyaXB0aW9uOiBVQy04MlhYLUxYIGVtYmVkZGVkIGNvbXB1dGVyDQo+
ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBtb3hhLHVjLTgyMTANCj4gKyAgICAgIC0g
Y29uc3Q6IG1veGEsdWMtODIyMA0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0K
PiArLi4uDQo+ICsNCj4gLS0NCj4gMi4yMC4xDQo+IA0K
