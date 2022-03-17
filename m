Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAE4DCE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiCQTDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiCQTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:03:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52021F9FEE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPlxGxaNDuQTurgFRxtmra3kJTURJbAOH7MF18MfmO8spflcFXPalHMzaZsPWoCt7h+JssaRVvci6rUT9jIPCjZgwNn85rdNwLWJvNrCAdY+DR6hAOUCtTUS39R7HT+EQOSFifYtyIM+DZyn3dsk/OSDzR1yhS67Opzt7wicMIu5UNrEoAitPmPnYFKrsUv0etCWCH7XQiZ5jYrURk5XubKlc+s53sZb23SIrrTf8FQL3ebiDuZGPM0iVH0f1odtLA0s0teuC6G1L225HAxHH/yPefKf7jfyUHn9uWTpLtWTE6bg9r0Np7cEBUFnvBfP2p33WmRRYltSXOoDaLdOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GygiDThT1/ZDoW/k0+yi1hnT9Rkrv5dMxtF4N83pN5Y=;
 b=glwi9ywMlVi8XnjyySbOX4EWZ3IY4b4gtCN4bsC6w56VmaTIFtGXglrFYGPFKTLYu602d3bUjK3cksDvcKj/Ywrgyi6rt8mKX92fPjHEf22a+LWpO2nNOREQL1v0dnjg9iJTarorNPrU2ZHH6hMUbBO9zECKksOOaNYRBsPSKaJe0nQp3oGux6UUkL48MjyaLChhA1zZocaDid3nygE8m++8ceD/M04IawyPtqlrANEceJhm0vgOy4VURh8Bj89nUmPEQYrDJy6c4lGms8h0iPdxvf5sp9y0i44U0glK/cH3r5MuAj39AfY1pj+KKw89Tah+BX4A0HgGYgsOS0olJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GygiDThT1/ZDoW/k0+yi1hnT9Rkrv5dMxtF4N83pN5Y=;
 b=Vq7Yr/mNqtpQoM7JVzooi5Gu6pWCEFfBoC2oYUb607TnvfFHfbVispUtUNwfDVPBOq+V2If6s0Sz9rPBhJxaa8BCALzkVJwteWy7gg5Ou32C0NciBhz+vpUlI0u4rBQTG9c84asrMP1uCn33VIRlkfghWc1pGDgQgMe965H/ZOs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY1PR05MB2682.namprd05.prod.outlook.com (2a01:111:e400:c617::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 19:02:33 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%7]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 19:02:32 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Topic: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Index: AQHYOi5EArGolB6T3UOsBVoO+LEc5qzD7r8A
Date:   Thu, 17 Mar 2022 19:02:32 +0000
Message-ID: <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
In-Reply-To: <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1a6110-b310-4b38-37b8-08da0848b12a
x-ms-traffictypediagnostic: CY1PR05MB2682:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY1PR05MB2682CC1516E04ECE1AEAEF10D0129@CY1PR05MB2682.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jh4HEqpFy3IT7LlxRPreq/yb3h/ai6erKDHo7CF5LAgehcZfzAx5d+kCu1YfoIEiaptRtqMPcHjUlnTC1AfpCyAaLm0lRftQ/dk3RjmytKswJgAnZPexoQDkFAPRWI1cpRQf6ht4aTePB6tCRITtQxKUoeka7Y8njUcfrTBuDpW+hIG9FVcq+Hiqd6ah8K08W7RpnlIQA4xZy/JtQvhQ0z0LaKUsOr0YaVmD3Pfx0gA1yT6W3ZwMByl06wNRZUNGtRbTpOUV2FBUBy/97RyPbOr6qP9O0hEhWCowfVvYlSqd39KZfVqcAfMuoTSobOdo+WgY1qu0cO3rOqCsWy/cma1EqeTxAerKu8Bc+fEOM7jmBDCTbsJT/vcVk7CQoTT/6RV1x/cK3HoG8sj9PW8NpjKr77XK1lMIUljOrHN7wurwfNJb44gJ1y1BtIkITtWpEcf7pKHXM4IsToq1L/tcDveZwoqTZmqy8NBPNJx784RhsJUUL4iJYlZQH+rHvrgnYhnfhlgKj0edmRoGci1oLy9qE9NVNNgrwMFuXPjNPGv4p4mWuCHV3nSHze+Kx9XQt4fBkdk6HHpFjbIKsWvlaIcv3pzKOPNriaft3IWZshxTO1vobZz+4L64wf5omQZJSVIl7ijMOATtIFxnSQgSThMdqO1eeSDdzT+1KBXdCI4aRuCg7iSXJY6rlfojz3/kbllzkwzHYyngUEXyq422jwd2VbXCMP+mS9UydGSPcocjMY7fcMIt9EopsHpjlCDxJRnbQmSbDywJrPCObw/+CLRNy1oxBW+NcjBdrvprURPJeeXEn0XTnz966vAmfpGe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(7416002)(8936002)(186003)(2616005)(26005)(71200400001)(6486002)(966005)(6512007)(6506007)(53546011)(33656002)(508600001)(83380400001)(45080400002)(38100700002)(38070700005)(86362001)(64756008)(4326008)(5660300002)(8676002)(66556008)(76116006)(66446008)(66476007)(54906003)(66946007)(316002)(6916009)(36756003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlVVdlRYZGVyV1pVci9VUFh1c3YvdnNxbnJ6bUZHWkFzMUp3NU42MHRsRU9n?=
 =?utf-8?B?bUdHZjdLYjJKZDh4UVlZVUxlY3dSVGl5WjhtR2NvUVZXOVRRYXlhSFFXV0F1?=
 =?utf-8?B?c2QvWTduME5UWlZzbVRYSlRLMXUrMDNsZW5OdU1PLysrQjZyQmVRcnlWK1Bi?=
 =?utf-8?B?R1BJNk9kNXEwSW5XTVpydVF2cUhNTHpjNlBIaFlNdmdqMjRXWmcxUnk5UWFS?=
 =?utf-8?B?eURiVXJVZWdmRFh0dlF1M1dnTFZqYW1NWE1DWkdPRGlIU1JKK1M4OHJLaUl1?=
 =?utf-8?B?U1RMdU8yem9ySmZLUTEva2pnQmNSSnhXVUNST0l4N2RGbE1KU0NrWFZzQ1Vh?=
 =?utf-8?B?TlBoK3gya1c1Nk5rKzJZMldSZEtHOXNOMFBkTGp2ODFUMDltbWNrZEZWM1VE?=
 =?utf-8?B?T3pHMTlVSU5yd3RBUm1PSEI4QU8vaUxkYVY0SFRoUm1XUDdxeHhDMzU5aENC?=
 =?utf-8?B?Sk9OQXF5Q2JvWFgvbEZUdzlxRzZ6WFRUTCsvZlc2TjFQcXpBWFlTMnZ1b2Yv?=
 =?utf-8?B?UnR6bHlpYUJTcnZ5VldEVkJIRjdwMnREa1JZSW1KejliWFpYSnBvTm92Tmwv?=
 =?utf-8?B?OXpYcXhIcFRocFoyZXZocEt3NGdPbm8yVlViaGlCTGVTMFQ2Tis0RThnbGl5?=
 =?utf-8?B?TmcwbEVrQ3FEZnBvSnVOZHlkcmJ1NDVRWFltM2VEeUZhdDNaSGY0U05BVjhV?=
 =?utf-8?B?Tk45MmtsRVg3M2VEdFlBWkFDZ2txVmpJWkdkUlNqbmZBNVhlbjVjZzlWSzJ5?=
 =?utf-8?B?Qm1NSTZOeFk1aGxrL3NJS2VyVWhGRDNYSE5vYjBCK0MzR2lISElFYTJCM2VL?=
 =?utf-8?B?Y0dkU0owUUMvZldpUm5NRy91aUF0U2JSeVJucWdYb2lCQU1STWdxbXdCUlY3?=
 =?utf-8?B?azBxN1Y5V3JUemNLc2JYUXZsSUZHeDhvQ2NQV2h1NVNOekhQSmszcjdPZkIx?=
 =?utf-8?B?bFNTV3pNRDc0OU02NVQwbmxndFdvNzZsUUlCNUZvWnlWbHc4cjdmeFF3NGdq?=
 =?utf-8?B?czZyUWVtcWhQNkFMQ0xOczh5dXdNQzcvaS9XL3JrcFpNakxhUVFqanc5TmNi?=
 =?utf-8?B?TzhGVTFWZXFvVTRSdm15VHJvRmcvVEdmSmlCQVk2YTdzRGVkbnB1Y1lDbDBP?=
 =?utf-8?B?VE9FUDRZc3dld1JNU1lRaWswMlFUVENkWlZJU3pGaWUxam9IUFBJaklSbkVz?=
 =?utf-8?B?eU5jVXd3NGVkY0p6dXRvVklVU1NpLzI2V2F5bHFSY0xTQmt2R2NXSFpqcFhy?=
 =?utf-8?B?UGV6U21Cdm9jbU9KNXluMmlicyt4Wi9hUGc0ZG5YMTc4RDJUZU51SDJBcm5W?=
 =?utf-8?B?N0FjSWtTaGdqSm5RNGljazlhRHBOWitVMWtaQmdwOW1td0haaUhzRVVWMXBN?=
 =?utf-8?B?UVUwcThTdnZsc0c3a2xRTmZ1bm9nVFNncCt1aDBGRUV1bC9MMnZ0SXlIMTdH?=
 =?utf-8?B?OUxjOGxhdURmaVZUMng3WHFXN3lTR2pldm5VS2c4RGROZXhQZGQrV2E1TjJa?=
 =?utf-8?B?MzdFZjRyNmY4NHcxS0VJM0dBbTBTQklFUlBwZVl6QTE0dnU3WmMwSEVRY0Vr?=
 =?utf-8?B?ZEc2dEVEVU1MaXpWQWlzSXNDUUtOY2tNb1QvbDZlM2dmWCtVRmhMN2ltV1Bz?=
 =?utf-8?B?VUljZDVscDlLUERWSG0vL0thNnNSOXprSnFrRDkrMHFSMnYzVnJSbUVsUVE2?=
 =?utf-8?B?ZllkNWYzc2JVRjEzeXZGSkwxL2Zrd2dMU3BHdXJYVFE0U2pGN3JlTThUSGZa?=
 =?utf-8?B?ZlEwRWhxYk1FYjVaeWU5VkJRNHczVHRYVlZ4dW1UOXRkWTkxbGFXV2swaHh3?=
 =?utf-8?B?TUo0YzZXc1VYMGMzcHBzZHlPZDdwZWJJV3ZzeExKSjdtYjBNR3o3SkRYSkdr?=
 =?utf-8?B?YVZ6bHFWYkFUZTI1QitieFFBcElPY29qMmlPUGFxaUpkdWtEVkFSSmtkRmtN?=
 =?utf-8?Q?lSLK0eScJdSWzjz9zMuzGfEKuZno2eIk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8487CE7088D69C4E80D74AEC8E35F084@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1a6110-b310-4b38-37b8-08da0848b12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 19:02:32.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJ3k3H+6Oi3Zffau68tfsER8bSWw1j6FBFXm3qgt+V/VRQhXhvWwLSSjq6Sub61QtpmI3ywjib+Wnz4EHqTC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR05MB2682
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDE3LCAyMDIyLCBhdCAxMTozOCBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzLzE3LzIyIDAyOjA0LCBrZXJuZWwgdGVz
dCByb2JvdCB3cm90ZToNCj4+IEZZSSwgd2Ugbm90aWNlZCBhIC0xMy4yJSByZWdyZXNzaW9uIG9m
IHdpbGwtaXQtc2NhbGUucGVyX3RocmVhZF9vcHMgZHVlIHRvIGNvbW1pdDoNCj4gLi4uDQo+PiBj
b21taXQ6IDYwMzUxNTJkOGVlYmUxNmE1YmI2MDM5OGQzZTA1ZGM3Nzk5MDY3YjAgKCJ4ODYvbW0v
dGxiOiBPcGVuLWNvZGUgb25fZWFjaF9jcHVfY29uZF9tYXNrKCkgZm9yIHRsYl9pc19ub3RfbGF6
eSgpIikNCj4+IGh0dHBzOi8vbmFtMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGY2dpdCUyRmxpbnV4JTJGa2VybmVs
JTJGZ2l0JTJGdG9ydmFsZHMlMkZsaW51eC5naXQmYW1wO2RhdGE9MDQlN0MwMSU3Q25hbWl0JTQw
dm13YXJlLmNvbSU3Q2M5NThjOWIzOWRiOTRiNmI3OGJjMDhkYTA4NDU2NGRmJTdDYjM5MTM4Y2Ez
Y2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzgzMTM5MTQwMzk1MTA1MCU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1OU0NyVUsxMkFY
NUJ0ZWhhTlptUFhJcGlyVnRET3JsbGdVY3QxbXFnbE84JTNEJmFtcDtyZXNlcnZlZD0wIG1hc3Rl
cg0KPiAuLi4NCj4+ICAgICAyNC43NyDCsSAgMiUgICAgICArOC4xICAgICAgIDMyLjg2IMKxICAz
JSAgcGVyZi1wcm9maWxlLnNlbGYuY3ljbGVzLXBwLmxsaXN0X2FkZF9iYXRjaA0KPiANCj4gDQo+
IHRsO2RyOiBUaGlzIGNvbW1pdCBtYWRlIHRoZSB0bGJfaXNfbm90X2xhenkoKSBjaGVjayBoYXBw
ZW4gZWFybGllci4NCj4gVGhhdCBlYXJsaWVyIGNoZWNrIGNhbiBtaXNzIHRocmVhZHMgX2dvaW5n
XyBsYXp5IGJlY2F1c2UgaWYgbW1hcF9sb2NrDQo+IGNvbnRlbnRpb24uICBGZXdlciBsYXp5IHRo
cmVhZHMgbWVhbnMgbW9yZSBJUElzIGFuZCBsb3dlciBwZXJmb3JtYW5jZS4NCj4gDQo+ID09PQ0K
PiANCj4gVGhlcmUncyBhIGxvdCBvZiBub2lzZSBpbiB0aGF0IHByb2ZpbGUsIGJ1dCBJIGZpbHRl
cmVkIG1vc3Qgb2YgaXQgb3V0Lg0KPiBUaGUgbWFpbiB0aGluZyBpcyB0aGF0LCBzb21laG93IHRo
ZSBsbGlzdF9hZGQoKSBpbg0KPiBzbXBfY2FsbF9mdW5jdGlvbl9tYW55X2NvbmQoKSBnb3QgbW9y
ZSBleHBlbnNpdmUuICBFaXRoZXIgd2UncmUgZG9pbmcNCj4gbW9yZSBvZiB0aGVtIG9yIHRoZSBj
YWNoZWxpbmUgaXMgYm91bmNpbmcgYXJvdW5kIG1vcmUuDQo+IA0KPiBUdXJucyBvdXQgdGhhdCB3
ZSdyZSBzZW5kaW5nICptb3JlKiBJUElzIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIHRoYW4NCj4g
d2l0aG91dC4gIFRoYXQgc2hvdWxkbid0IGhhcHBlbiBzaW5jZSB0aGUgb2xkIGNvZGUgZGlkIHRo
ZSBzYW1lIGV4YWN0DQo+IGxvZ2ljYWwgY2hlY2s6DQo+IA0KPiAJaWYgKGNvbmRfZnVuYyAmJiAh
Y29uZF9mdW5jKGNwdSwgaW5mbykpDQo+ICAgICAgICAJY29udGludWU7DQo+IA0KPiBhbmQgdGhl
IG5ldyBjb2RlIGRvZXM6DQo+IA0KPiAJaWYgKHRsYl9pc19ub3RfbGF6eShjcHUpKQ0KPiAJCS4u
Lg0KPiANCj4gd2hlcmUgY29uZF9mdW5jPT10bGJfaXNfbm90X2xhenkuDQo+IA0KPiBTbywgd2hh
dCdzIHRoZSBkaWZmZXJlbmNlPyAgVGltaW5nLiAgV2l0aCB0aGUgb2xkIHNjaGVtZSwgaWYgYSBD
UFUNCj4gZW50ZXJzIGxhenkgbW9kZSBiZXR3ZWVuIG5hdGl2ZV9mbHVzaF90bGJfb3RoZXJzKCkg
YW5kDQo+IHRoZSBsb29wIGluIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCgpLCBpdCB3b24n
dCBnZXQgYW4gSVBJIGFuZCB3b24ndA0KPiBuZWVkIHRvIGRvIHRoZSBsbGlzdF9hZGQoKS4NCj4g
DQo+IEkgc3R1Y2sgc29tZSBwcmludGsoKXMgaW4gdGhlcmUgYW5kIGNhbiBjb25maXJtIHRoYXQg
dGhlDQo+IGVhcmxpZXItY2FsY3VsYXRlZCBtYXNrIGFsd2F5cyBzZWVtcyB0byBoYXZlIG1vcmUg
Yml0cyBzZXQsIGF0IGxlYXN0DQo+IHdoZW4gcnVubmluZyB3aWxsLWl0LXNjYWxlIHRlc3RzIHRo
YXQgaW5kdWNlIFRMQiBmbHVzaCBJUElzLg0KPiANCj4gSSB3YXMga2luZGEgc3VycHJpc2VkIHRo
YXQgdGhlcmUgd2VyZSBzbyBtYW55IHRocmVhZHMgZ29pbmcgaWRsZSB3aXRoIGENCj4gY3B1LWVh
dGluZyBtaWNybyBsaWtlIHRoaXMuICBCdXQsIGl0IG1ha2VzIHNlbnNlIHNpbmNlIHRoZXkncmUN
Cj4gY29udGVuZGluZyBvbiBtbWFwX2xvY2suICBCYXNpY2FsbHksIHNpbmNlIFRMQi1mbHVzaGlu
ZyBvcGVyYXRpb25zIGxpa2UNCj4gbW1hcCgpIGhvbGQgbW1hcF9sb2NrIGZvciB3cml0ZSB0aGV5
IHRlbmQgdG8gKmZvcmNlKiBvdGhlciB0aHJlYWRzIGludG8NCj4gaWRsZS4gIElkbGUgdGhyZWFk
cyBhcmUgbGF6eSBhbmQgdGhleSB0ZW5kIHRvIF9iZWNvbWVfIGxhenkgYXJvdW5kIHRoZQ0KPiB0
aW1lIHRoYXQgdGhlIGZsdXNoaW5nIHN0YXJ0cy4NCj4gDQo+IFRoaXMgbmV3ICJlYXJseSBsYXp5
IGNoZWNrIiBiZWhhdmlvciBjb3VsZCB0aGVvcmV0aWNhbGx5IHdvcmsgYm90aCB3YXlzLg0KPiBJ
ZiB0aHJlYWRzIHRlbmRlZCB0byBiZSB3YWtpbmcgdXAgZnJvbSBpZGxlIHdoZW4gVExCIGZsdXNo
ZXMgd2VyZSBiZWluZw0KPiBzZW50LCB0aGlzIHdvdWxkIHRlbmQgdG8gcmVkdWNlIHRoZSBudW1i
ZXIgb2YgSVBJcy4gIEJ1dCwgc2luY2UgdGhleQ0KPiB0ZW5kIHRvIGJlIGdvaW5nIHRvIHNsZWVw
IGl0IGluY3JlYXNlcyB0aGUgbnVtYmVyIG9mIElQSXMuDQo+IA0KPiBBbnlib2R5IGhhdmUgYSBi
ZXR0ZXIgdGhlb3J5PyAgSSB0aGluayB3ZSBzaG91bGQgcHJvYmFibHkgcmV2ZXJ0IHRoZSBjb21t
aXQuDQoNCkxldOKAmXMgZ2V0IGJhY2sgdG8gdGhlIG1vdGl2YXRpb24gYmVoaW5kIHRoaXMgcGF0
Y2guDQoNCk9yaWdpbmFsbHkgd2UgaGFkIGFuIGluZGlyZWN0IGJyYW5jaCB0aGF0IG9uIHN5c3Rl
bSB3aGljaCBhcmUNCnZ1bG5lcmFibGUgdG8gU3BlY3RyZSB2MiB0cmFuc2xhdGVzIGludG8gYSBy
ZXRwb2xpbmUuDQoNClNvIEkgd291bGQgbm90IHBhcmFwaHJhc2UgdGhpcyBwYXRjaCBwdXJwb3Nl
IGFzIOKAnGVhcmx5IGxhenkgY2hlY2vigJ0NCmJ1dCBpbnN0ZWFkIOKAnG1vcmUgZWZmaWNpZW50
IGxhenkgY2hlY2vigJ0uIFRoZXJlIGlzIHZlcnkgbGl0dGxlIGNvZGUNCnRoYXQgd2FzIGV4ZWN1
dGVkIGJldHdlZW4gdGhlIGNhbGwgdG8gb25fZWFjaF9jcHVfY29uZF9tYXNrKCkgYW5kDQp0aGUg
YWN0dWFsIGNoZWNrIG9mIHRsYl9pc19ub3RfbGF6eSgpLiBTbyB3aGF0IGl0IHNlZW1zIHRvIGhh
cHBlbg0KaW4gdGhpcyB0ZXN0LWNhc2UgLSBhY2NvcmRpbmcgdG8gd2hhdCB5b3Ugc2F5IC0gaXMg
dGhhdCAqc2xvd2VyKg0KY2hlY2tzIG9mIGlzLWxhenkgYWxsb3dzIHRvIHNlbmQgZmV3ZXIgSVBJ
cyBzaW5jZSBzb21lIGNvcmVzIGdvDQppbnRvIGlkbGUtc3RhdGUuDQoNCldhcyB0aGlzIHRlc3Qg
cnVuIHdpdGggcmV0cG9saW5lcz8gSWYgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGluDQpwZXJmb3Jt
YW5jZSB3aXRob3V0IHJldHBvbGluZSAtIEkgYW0gcHJvYmFibHkgd3JvbmcuDQoNCk90aGVyd2lz
ZSwgSSBkbyBub3Qgc2VlIHdoeSB0aGlzIHBhdGNoIHNob3VsZCBiZSByZW1vdmVkLiBXZSBjYW4N
Cmp1c3QgYXMgd2VsbCBhZGQgYSBidXN5LXdhaXQgbG9vcCB0byB0bGJfaXNfbm90X2xhenkoKSB0
byBnZXQgdGhlDQpzYW1lIGVmZmVjdOKApg0KDQo=
