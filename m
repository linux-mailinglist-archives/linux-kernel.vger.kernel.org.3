Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F6F4E6CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356323AbiCYDp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiCYDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:45:56 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50089.outbound.protection.outlook.com [40.107.5.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D779BA315;
        Thu, 24 Mar 2022 20:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBum1JfGkInAVgqzlTJn63s1nb9pMRISJEkhmRvpQThGemFSum+pNpPH6qG9WLCle45biGOxtr/mkNda5sTSU6/GqVvNqTWIvUTmAGTxdYc/Grj0ejzBgGeNE44rY5y4pwzq1LeauoXoBtRcUtfinmg5j4n03nBtMXMyLrb7oUC5DKBlIuhfqV3JiYKEOBW6iWcLP/IoXtL3l9nv7VaK8KKAETJLbFPFbVrhrwJeSuTZc8JxlRmDcNFc4Gd+OYaqFpzCDhAhYYnNNLLKTvsmEkKckJRZhTycBwNRJyGtdo2lAksc9ox0P0NMnJO73BKyMqRWrhGokgVqRyJyHCM9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sgmUXvI+7jNK7SiCZILcAaYJROJUQrMADPDxmMojLg=;
 b=MTxcd24otoPfv8nQCIK5Jfqvivk5b+fensSfYuJLw7/c/nlqeu31YkLX3od3gMBfpw/FsATE7JX2cKJmEUEgUJ7w2fwjSM4NesCUMzUSkZPP3IZB3xdHksIu7Di6aASkxD3Fzrp0/KbAbSZ1XIpM0UjKnslqo8mCdT51wO8kkoVdwxL/JlGKhWCme8Ekd/0GfXCpnH2Jdj5JVR0Mv/FMo8uHzjFHomEzthK39M71trjR/139+wQ1q7BZblFiIUu1OEtxIP3BPh5CXw97PgMvnPtmnatXhzeF3itIarMU0fUbuvxRzp87B78VDcDp8Tajg/trGFOV+UJA10g3vA1COA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sgmUXvI+7jNK7SiCZILcAaYJROJUQrMADPDxmMojLg=;
 b=Z7Je+JuF2bndEmyRphSpRSJSexlJ82Bupv8fEUTPL+pKsW+omySqrYpEMiZuoxjqP8XFCBaaQP8kmLiVrIT0O+Fwv9qcIBH4xVeCvknH9Y6ZFszjZJzp+72COd1ZtyGKH6e9Zp1DiJO6odrauM/Y531/rb7i6qFHbpYfSRns5h8=
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 03:44:20 +0000
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb]) by PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb%8]) with mapi id 15.20.5081.022; Fri, 25 Mar 2022
 03:44:20 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove state checking before changing
 state
Thread-Topic: [PATCH] remoteproc: core: Remove state checking before changing
 state
Thread-Index: Adg/9+1VyA/rREj7SVeAZwyzAHGzHg==
Date:   Fri, 25 Mar 2022 03:44:20 +0000
Message-ID: <PAXPR04MB9089EC1B959187335D00953BE31A9@PAXPR04MB9089.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d77783c-0417-4145-77e4-08da0e11bef5
x-ms-traffictypediagnostic: DBBPR04MB7802:EE_
x-microsoft-antispam-prvs: <DBBPR04MB7802C959FCEFE97796FC3D93E31A9@DBBPR04MB7802.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUdixkWg+pd+SXsyoa0JiRDJARNuBxJjyeIs2wFJEzQJeVm2k0KkgigCKsNZ3rehmWgoSf7TRklz2EEDTVl/3SIg+mL5ynvoAFU2Egzy1ZGMy25VT6iSUyxQS/u/ntP672AEsTJItI/ZeGF0x0xlSeImrbB98vtz6T4iZnwafHPkjG3VjKz1+yf7925AqAHqhQAP9ks/+sdQDS22abpmIR1Z55c4eWm8oTbT9f21+oRgiqFisLXZyBsidIENenmt5QiR7vakGZX+S0tWqdiSvivl/KCv17mT0z9bqWfqyjqQcb6DxauxGpAT+XrvA/o4Tv8CxFSm+jNmTYGC7U0Hmw3vnD+PDzsZmPEeTOpR2kqEt3RRrF1uY8+bYBHT6fxaoBFvJgNBljznsbzHZJUkEkp9KC5aPD6yPns6XuINDDJYHGacd7Wxk9bDV2vN/OAWcD81URXME+LZu5jHsCEGE9b9ywEO8SFLYK8k5n9ZrqUr1cj6pJzJLTFeXWISiNrk4w5szpXaG8wLbkadR407aGm5X5PPyvyk7O58zT2fK4O8Q50ARkuY7OnsAfrIn2sYo1StATZwyLMIkiFf4bo9y3JPgyzewUlukciskMDnZGSY48EAC5dyiX9lxl8du9K9hk/xgVMZ/OCkVM7LKtMydFlnatZqVzestSTF0PQHm1Lq7/tBdBl+IGHbA1Yo/V6VKAkkpsnHz4GT9NjNM9aJhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(508600001)(66556008)(33656002)(66476007)(8676002)(66446008)(64756008)(83380400001)(76116006)(7696005)(66946007)(6916009)(54906003)(316002)(186003)(26005)(71200400001)(38070700005)(55016003)(86362001)(8936002)(38100700002)(2906002)(9686003)(52536014)(122000001)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JFNnJlNTJiT3pnWlU4QVZJMzhEQ2cwRlM4Rnd4a2hQQ3dMNlNBOWROZkxm?=
 =?utf-8?B?S3RtdzZjQUhkbEEyeVg4UlNyWmRSOVRFd1pqS3ZFL0JlUXBYbFZFZlAwN0R1?=
 =?utf-8?B?WEx6MXA3cCt4dTJnUzA3NlNkTUR6V0lUMFV2ZXh1eTJiSDhnRGVaZkRYcWFK?=
 =?utf-8?B?OVVIS0ZmYmxubW1uaHNVbXNUUExrcmxrUE02VTAvYmFFUFFNdjBoT3g1NUdB?=
 =?utf-8?B?bnVMMzlNQWQ0bHBMTGJpZHl5V1lHODNTOXFxbWJxMytaTWxIZTRjQmp6WE1O?=
 =?utf-8?B?UG0rMTBrd0t3Ujl4QVp6VjBQbFVnYVAvYUlrclQva3BEQnhFd2xENUVxeW5K?=
 =?utf-8?B?cGdibGxyU3Z4NDV3dGJOUzZTMDVCRlFQdm5GYWE1alpueHJsUnJHNUFIVlRS?=
 =?utf-8?B?R1BqaHRVUDNNZmN5SVczaGovS2lENmR5UWRrQjY5WDU3V3B2elM5SElQbzkx?=
 =?utf-8?B?b3ZtSzRjbmJicmFwZzlkSjNtUmM5bkd0dktjYkhxZGdWN1BYRkVKOExOYWdK?=
 =?utf-8?B?Q3hyY0dOM2RkTXFXdlVRcTRLaDNtQzI5ZUN6RDh2L253em5XbFZTZ1VWK2Rt?=
 =?utf-8?B?QlNkSGRpYjRaQUZ0OUN5Ty9jWlBCWmUxNEZjSFdTSXIxRlhjRUZ6SHpCS1N2?=
 =?utf-8?B?ejNDcHAybFJJMGZUa2J5emd2SWo1NHR3cFg4UmMyRklsUXF6UnNLZlArUWNK?=
 =?utf-8?B?WEVueUQvVTFiazVQaU1KY1NDSXByOCtmYVlneGJvWlJRdERuN0VqVnppdkRq?=
 =?utf-8?B?eTZxa3Bha0dwWU40ZnNCdjdtRG94NWExNkVWNGZIa0l0S2d1aWhrUXFXbkhH?=
 =?utf-8?B?dUpTbG9pTnFONDRpT1RRS1pzdjBVSS9vdjhNQjg1UnduaDU3QTVRcjk4bXpB?=
 =?utf-8?B?TTU2NkNEUFY3WU4vSzdDNzhmODVQZ0J4UWhFK2hJcnBPRWRKNzBlMS84M2VL?=
 =?utf-8?B?a0JIdWdJSlFUalJxS0JYYlowZkloUGpHdmZ3UUE3dVZGRXo1alFlSTh1SHBI?=
 =?utf-8?B?STYrQUhjTmFOVlJ2RGZjZVNSVm4rOE5PQ09PUEZhYXpBcU1JZFJ5SWF4UlJ4?=
 =?utf-8?B?bitleHFlaStROTZoOXhvdkZBODJwMjhPZ0lpZWFndnYzcTk4OFdEUFZyVm84?=
 =?utf-8?B?alJVNm1YQldMbStQaXBWNUZ3NHk1ZDVhY1VhelhjZGcvdG5oc3pqYUdSckRO?=
 =?utf-8?B?TTZqNGY0OGVmUlg3Ynh6SEgwK1p1TDNBSzk4S0lvVzBJT09oNHBhR2N3ZWFl?=
 =?utf-8?B?OVJoa3F4TEhGdFdxeU1kYlY2NitacXA2d016NGJHVjZiSHdhL2JsK09WSzRC?=
 =?utf-8?B?NzFpRm5Dd0RXdGhiS1RGMGVhcjRib1M3SGZzSFpiTGwvN1hNMjFHcmZqSHcy?=
 =?utf-8?B?S0FyWGMwS2VFMWp6R0haS1V3aWxHOWhxN3VSRW5rcWQzUzdEdzlvQUo2SE54?=
 =?utf-8?B?UkZ1ZG5oSHlqNHVjMzU2aE14K3FPc1JqL2ZjdWNvUmtSWFBkNndZbDJ2aTVq?=
 =?utf-8?B?ZkRaeFQvQ0lUKy8waUxqWThJbWVBWmhlVklab29Gb1oyd2tCV2lDVkI1anRL?=
 =?utf-8?B?cC9QcFRCa0p0cDFUU1A1Nk1UTmE3RjJibGQ2RGExUkRCcS9JaHdvOHJSdnpt?=
 =?utf-8?B?Tnl3a2c0ZW9lRkROL3BlYkxVVVkrWHcvMUZhOEZGYWI2RkpTQ1lTUDl3Uy9V?=
 =?utf-8?B?cm15RGM1TGdhSFZmemhQbDgyc0VaSExoVXZXZ014QXg2WGhiMGRtU3EwWTNJ?=
 =?utf-8?B?YStaNFpvaWdkK1VqSlBjd011YktwaFBPTDNuY3BHalRmK09BaHJteE9YWURv?=
 =?utf-8?B?UU1rdVdFclUwWTdGUHJlQ3BXQzdDOTZNanBEZVlVZ3l3ek81UDZVSkhKelMw?=
 =?utf-8?B?b3dwWXozdkFqN3BqVExnVkpXaTNQVnNHWW1EWGYvMTZ1SThWWDR3UXg1Y1F4?=
 =?utf-8?B?NEpKaEFPL0xwNnJ0eFZ6RDRlclYxVHFsU3gzK080c0NaZ01ibzB2V05mbE00?=
 =?utf-8?B?Skt4eG1xUDF4RHBPZDkrMXNHSjc1bDEzZW9scHVmTStqVlA2c3c1c0ZyeW1w?=
 =?utf-8?B?TWViU2JiUGlUVHRkTnBRUGtpOExuaHFtVlZjQzB4MEY5ZE0zejIrUTBZM05B?=
 =?utf-8?B?U0pGdkJBWnJzQ211a3RxUTdZeEo3L3J2MHdlNjdXdS9DQ0xERzBtU2cyMzdx?=
 =?utf-8?B?bDVjaVB0Um9IMWYxQ0dKNGRwQ3NMVzRNbnJPbUpRWnRXbEM1Qk90OTJna2RQ?=
 =?utf-8?B?SjkxWEROa3l0eHpMRVV3WXpLWWdlWC9DYTF1ZHp0eHQrUGlaTnUyWkNvM0Nv?=
 =?utf-8?B?eWlXTE91YUN2eE41bkNyN2ZwWWdrZ2N2NGpzQ2JVREJFek1KZ3B5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d77783c-0417-4145-77e4-08da0e11bef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 03:44:20.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsT2pA9OeXalNhtQfq7W2ZkUy+4NbQ4TUJvixVbFQ1ExFBqODNA6qMQg5miYFQmtZj6hW9dCHHlxHjIwbA/q5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gbXV0ZXggcHJvdGVjdGluZyBvZiB0aGVzZSBzdGF0
ZSBjaGVja2luZywgd2hpY2ggY2FuJ3QNCj4gPiBnYXJhbnRlZSB0aGVyZSBpcyBubyBhbm90aGVy
IGluc3RhbmNlIGlzIHRyeWluZyB0byBkbyBzYW1lIG9wZXJhdGlvbi4NCj4gPg0KPiA+IFRoZSBy
ZWZlcmVuY2UgY291bnRlciBycHJvYy0+cG93ZXIgaXMgdXNlZCB0byBtYW5hZ2Ugc3RhdGUgY2hh
bmdpbmcNCj4gPiBhbmQgdGhlcmUgaXMgbXV0ZXggcHJvdGVjdGlvbiBpbiBlYWNoIG9wZXJhdGlv
biBmdW5jdGlvbiBmb3IgbXVsdGkNCj4gPiBpbnN0YW5jZSBjYXNlLg0KPiA+DQo+ID4gU28gcmVt
b3ZlIHRoaXMgc3RhdGUgY2hlY2tpbmcgaW4gcnByb2NfY2Rldl93cml0ZSgpIGFuZCBzdGF0ZV9z
dG9yZSgpLA0KPiA+IGp1c3QgbGV0IHJlZmVyZW5jZSBjb3VudGVyIHJwcm9jLT5wb3dlciB0byBt
YW5hZ2UgdGhlIGJlaGF2aW9ycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdh
bmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVw
cm9jL3JlbW90ZXByb2NfY2Rldi5jICB8IDExIC0tLS0tLS0tLS0tDQo+ID4gZHJpdmVycy9yZW1v
dGVwcm9jL3JlbW90ZXByb2Nfc3lzZnMuYyB8IDExIC0tLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMjIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9y
ZW1vdGVwcm9jL3JlbW90ZXByb2NfY2Rldi5jDQo+ID4gYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVt
b3RlcHJvY19jZGV2LmMNCj4gPiBpbmRleCA5MDZmZjNjNGRmZGQuLjY4N2YyMDVmZDcwYSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jZGV2LmMNCj4gPiAr
KysgYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jZGV2LmMNCj4gPiBAQCAtMzIsMjEg
KzMyLDEwIEBAIHN0YXRpYyBzc2l6ZV90IHJwcm9jX2NkZXZfd3JpdGUoc3RydWN0IGZpbGUgKmZp
bHAsDQo+IGNvbnN0IGNoYXIgX191c2VyICpidWYsIHNpemVfDQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiAtRUZBVUxUOw0KPiA+DQo+ID4gICAgICAgICBpZiAoIXN0cm5jbXAoY21kLCAic3Rh
cnQiLCBsZW4pKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChycHJvYy0+c3RhdGUgPT0gUlBS
T0NfUlVOTklORyB8fA0KPiA+IC0gICAgICAgICAgICAgICAgICAgcnByb2MtPnN0YXRlID09IFJQ
Uk9DX0FUVEFDSEVEKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7
DQo+ID4gLQ0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSBycHJvY19ib290KHJwcm9jKTsNCj4g
PiAgICAgICAgIH0gZWxzZSBpZiAoIXN0cm5jbXAoY21kLCAic3RvcCIsIGxlbikpIHsNCj4gPiAt
ICAgICAgICAgICAgICAgaWYgKHJwcm9jLT5zdGF0ZSAhPSBSUFJPQ19SVU5OSU5HICYmDQo+ID4g
LSAgICAgICAgICAgICAgICAgICBycHJvYy0+c3RhdGUgIT0gUlBST0NfQVRUQUNIRUQpDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gLQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXQgPSBycHJvY19zaHV0ZG93bihycHJvYyk7DQo+ID4gICAgICAgICB9IGVs
c2UgaWYgKCFzdHJuY21wKGNtZCwgImRldGFjaCIsIGxlbikpIHsNCj4gPiAtICAgICAgICAgICAg
ICAgaWYgKHJwcm9jLT5zdGF0ZSAhPSBSUFJPQ19BVFRBQ0hFRCkNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAtDQo+ID4gICAgICAgICAgICAgICAgIHJl
dCA9IHJwcm9jX2RldGFjaChycHJvYyk7DQo+ID4gICAgICAgICB9IGVsc2Ugew0KPiA+ICAgICAg
ICAgICAgICAgICBkZXZfZXJyKCZycHJvYy0+ZGV2LCAiVW5yZWNvZ25pemVkIG9wdGlvblxuIik7
IGRpZmYNCj4gPiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX3N5c2ZzLmMN
Cj4gPiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX3N5c2ZzLmMNCj4gPiBpbmRleCA1
MWEwNGJjNmJhN2EuLjhjN2VhODkyMjYzOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90
ZXByb2MvcmVtb3RlcHJvY19zeXNmcy5jDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL3Jl
bW90ZXByb2Nfc3lzZnMuYw0KPiA+IEBAIC0xOTQsMjMgKzE5NCwxMiBAQCBzdGF0aWMgc3NpemVf
dCBzdGF0ZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAgICAgICBpbnQgcmV0ID0g
MDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKHN5c2ZzX3N0cmVxKGJ1ZiwgInN0YXJ0IikpIHsNCj4g
PiAtICAgICAgICAgICAgICAgaWYgKHJwcm9jLT5zdGF0ZSA9PSBSUFJPQ19SVU5OSU5HIHx8DQo+
ID4gLSAgICAgICAgICAgICAgICAgICBycHJvYy0+c3RhdGUgPT0gUlBST0NfQVRUQUNIRUQpDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPiAtDQo+IA0KPiBB
cyBwZXIgbXkgcHJldmlvdXMgY29tbWVudCB0aGUgYWJvdmUgY29uZGl0aW9ucyBuZWVkIHRvIGJl
IG1vdmVkIGludG8NCj4gcnByb2NfYm9vdCgpLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgcmV0
ID0gcnByb2NfYm9vdChycHJvYyk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycigmcnByb2MtPmRldiwgIkJvb3QgZmFpbGVk
OiAlZFxuIiwgcmV0KTsNCj4gPiAgICAgICAgIH0gZWxzZSBpZiAoc3lzZnNfc3RyZXEoYnVmLCAi
c3RvcCIpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChycHJvYy0+c3RhdGUgIT0gUlBST0Nf
UlVOTklORyAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAgcnByb2MtPnN0YXRlICE9IFJQUk9D
X0FUVEFDSEVEKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+IC0NCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gcnByb2Nfc2h1dGRvd24ocnByb2MpOw0K
PiA+ICAgICAgICAgfSBlbHNlIGlmIChzeXNmc19zdHJlcShidWYsICJkZXRhY2giKSkgew0KPiA+
IC0gICAgICAgICAgICAgICBpZiAocnByb2MtPnN0YXRlICE9IFJQUk9DX0FUVEFDSEVEKQ0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0NCj4gDQo+IFRo
aXMgcGF0Y2ggc2hvdWxkIGhhdmUgYmVlbiBwYXJ0IG9mIGEgcGF0Y2ggc2VyaWVzIHdpdGggeW91
ciBvdGhlciB3b3JrIHNlbnQNCj4gb24gTWFyY2ggMTh0aFsxXS4NCj4gDQo+IFRoYW5rcywNCj4g
TWF0aGlldQ0KPiANCj4gWzFdLiBbUEFUQ0hdIHJlbW90ZXByb2M6IGNvcmU6IGNoZWNrIHJwcm9j
LT5wb3dlciB2YWx1ZSBiZWZvcmUgZGVjcmVhc2luZw0KPiBpdA0KPiANCg0KVGhhbmtzIGZvciB0
aGUgY29tbWVudHMuDQpJIHN0aWxsIGhhdmUgb25lIHF1ZXN0aW9uLCBpZiB0aGVyZSBhcmUgdHdv
IGluc3RhbmNlcyBpbmRlcGVuZGVudGx5IHRvICdzdGFydCcNCidzdG9wJyByZW1vdGVwcm9jLCBm
b3IgZXhhbXBsZToNCg0KSW5zdGFuY2UxOiBlY2hvIHN0YXJ0ID4gL3N5cy9jbGFzcy9yZW1vdGVw
cm9jL3JlbW90ZXByb2MwL3N0YXRlDQpJbnN0YW5jZTI6IGVjaG8gc3RhcnQgPiAvc3lzL2NsYXNz
L3JlbW90ZXByb2MvcmVtb3RlcHJvYzAvc3RhdGUNCg0KLi4uDQoNCkluc3RhbmNlMjogZWNobyBz
dG9wID4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jL3JlbW90ZXByb2MwL3N0YXRlDQouLi4NCkluc3Rh
bmNlMTogZWNobyBzdG9wID4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jL3JlbW90ZXByb2MwL3N0YXRl
DQoNCldoZW4gaW5zdGFuY2UyICdzdG9wJyB0aGUgcmVtb3RlcHJvYywgdGhlbiBpbnN0YW5jZTEg
d2lsbCBiZSBpbXBhY3RlZCBmb3INCkl0IHN0aWxsIG5lZWRzIHRoZSBzZXJ2aWNlIGZyb20gcmVt
b3RlcHJvYy4NCg0KVGhhdCdzIHdoeSBJIGp1c3QgcmVtb3ZlZCBvZiB0aGUgY2hlY2tpbmcgc3Rh
dGUsIGRpZG4ndCBtb3ZlIHRoZW0gdG8NCnJwcm9jX2Jvb3QoKS9ycHJvY19zaHV0ZG93bigpL3Jw
cm9jX2RldGFjaCgpLiBBbmQgaW4gb3JkZXIgdG8gdXRpbGl6ZQ0KdGhlIHJlZmVyZW5jZSBjb3Vu
dGVyIChycHJvYy0+cG93ZXIpIHRvIGhhbmRsZSB0aGUgbXVsdGktaW5zdGFuY2UgY2FzZS4NCg0K
DQpCZXN0IHJlZ2FyZHMNCldhbmcgU2hlbmdqaXUNCg==
