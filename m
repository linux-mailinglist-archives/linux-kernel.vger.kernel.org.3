Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830D57F282
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiGXB2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGXB2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:28:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2076.outbound.protection.outlook.com [40.92.41.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5718E34;
        Sat, 23 Jul 2022 18:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqQ1Q9dJk3wNS0KBTCZ1tRRCYVujEmoYyu079zj9g8xIgY8Fn9LjSYDutH+ar3phvpZnPlg+Kp6/W9f13p6DGcqG5xtZ7nX5hnAUukriNcvHK0WgGGNvw0SME8KyNS+hns2rx1fzkwVjvkT0BLvWP5UU6Xra0xNYgSV/LFOfNC0P+3k2bvrF2dqP7k479sp0zp9dmPVPJZO/Xd8dhDwI+UR47DMK0+RFNJpOY+zOGLYw/CcI8GbRFE3aNN1EgPzB5aQBX9VQ1LcGWTXsOww+iHgCWnKSK8Q24gDS/cYA4A/CQEuBO1SYwEPBOjBAEgedMoxkU2VUUvSCbQ96bhSOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKNe+L3SRHjF36HT8NkfeAA1QNfMLLH64xU1P4S7PGE=;
 b=SIVh0+lnWWJOs3ChW6YqV5V/pGrS0CC/cED837OqgLNhcZ2Ax5a2FpqqotDEbL3NnRdvur/F+PBQp/LqBbLxtIG5HFvPfiy66RCxMPMiB+LDv6hjwbk9f1lfj/G+t56uZG1IBX0hwPbwXropW6xVx8rhrcv0WFjDNW9n29gmoaXMB8MscGS5tfuKXzUa5eFDuNo95gT+1SyevqQnPvQplafzQ/LxXWKUG+ZQxJKcJnDOfAMcecboxb1v2cI59NS7yfFLyb7rFhGX58OxlVQE+0mwWnVGIGgRRekDBqZ6J7ucvo2342UM2+4qtV8HQDzdAWCx6bIAoYUcTBZUc/Xp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKNe+L3SRHjF36HT8NkfeAA1QNfMLLH64xU1P4S7PGE=;
 b=iNlVkUmArFY2k6Gc04GnfJ0ZP3dSDNqHr8w2PwVpLyKnLdw3FbU1YZFN84aC7UVHrhRXonERvVfFC1wvZxtodnxpLHbLdc1BPgGDlY2npcsPotC1ZXq84Kfp0C4IlsTbbhBHKz6MWsO96MDLVwQ7mfvpThpwKeNZ/kEd0zNf1bGXoYEP8NlR000972xRvdt8bU41RXiIhJqiqeGmKjNnv/LtfjollbXhkl5iLlX4rUM1yj3T/iW7vUNcKIxkmVJYoybWq4ZjX1foiR28M8zezX8YlKYQRAPQofBD6H779ZUcSVBvCXC/b9iwQNSb9qn0cOd6PRkHinRLGF2gmZ2tmA==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by CY4PR17MB2024.namprd17.prod.outlook.com (2603:10b6:903:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Sun, 24 Jul
 2022 01:28:29 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 01:28:29 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     kernel test robot <lkp@intel.com>
CC:     =?ks_c_5601-1987?B?IPGy5vzL+SAoWmhvdSBZYW5qaWUpIA==?= 
        <zhouyanjie@wanyeetech.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aidanmacdonald.0x0@gmail.com" <aidanmacdonald.0x0@gmail.com>,
        "tmn505@gmail.com" <tmn505@gmail.com>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "dongsheng.qiu@ingenic.com" <dongsheng.qiu@ingenic.com>,
        "aric.pzqi@ingenic.com" <aric.pzqi@ingenic.com>,
        "rick.tyliu@ingenic.com" <rick.tyliu@ingenic.com>,
        "jinghui.liu@ingenic.com" <jinghui.liu@ingenic.com>,
        "sernia.zhou@foxmail.com" <sernia.zhou@foxmail.com>,
        "reimu@sudomaker.com" <reimu@sudomaker.com>
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Thread-Topic: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Thread-Index: AQHYnetNUOaTJqPXOUWAkct1ePh+ua2MsOQAgAAMoGc=
Date:   Sun, 24 Jul 2022 01:28:29 +0000
Message-ID: <MN2PR17MB337549EACCAA9E83CB484F9FB8929@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
 <202207240839.YeZ8uQ0T-lkp@intel.com>
In-Reply-To: <202207240839.YeZ8uQ0T-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [HBRMvXPQdeHP9N0OFK0rEBuUpz8143CheIM27yrwJtCKmLxEo8V+mPmR0T++2y7OzDJbujS7NUQ=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2088d9d-a764-406c-de0c-08da6d13d073
x-ms-traffictypediagnostic: CY4PR17MB2024:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3pgkuUHtwRmCpe3UvBX9RqbTnKxYfIUHeBX8GGFEVjQlcOX281b4IMDZ7a1lIPDZxhxyHnkSCTpoH/HD7DR5nPTcIbGC+1LrWzNy168YbEw/DWFiESCz6XsSxZTFPcMXa1yFksRfoPX9F4X7g/T6teNycU7gAL5KcuBkU5lyxQwIgQmN/xAzUqUrH6/ZI719OXy1vc3Gf5o5WU5T8snmk9afRos8TUJ9t+0+IMLtjRpECTcdd38dM6rut+ig40yjn3/GtrGLUQqk8j7WZlw3LurwWuVONPQMRMFrKElLVfXuiX5d2bVxpuok67VJAmpqf47aCwLEnpyatPEYOsMBzdAdl2a00sHlPPJbsTdIQPLLoDnARKpcAMscskoW2Q0QYYA/vvkTJCtoS+tt6oX7sivj756Kr2k91NWC4+ai09z+58nSLwXbKFd6wqMC5aj8Hc1ZJ8FMKHJeKN3JnxUDew9XdOzZ6m5G9r5Ffub5G624ontSh6PmdQwwJLdaNQIhW/0sFVPI8z1RUMy0xtBe62Cd7Qen1GHjLZ5VsnnimiNB5scRKQD8jqOTUtBLkm7zbtgyqoOuCvotNrLi4dAZE2J9Nu24CyV6aWS9voQYOituEVxr4Ebu8cbiYTBcBu/fdSOWUKsCSlafpsERM+dwlehaPp2/zN7h9BchLE1PcvcDIVWCH4nsI9ikzDAS6q4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?anNyaDVHbmJiYW9xQUpnVFpUYmZlbTlBdEgwRXNuQU1vZkRkRXJw?=
 =?ks_c_5601-1987?B?NXR3SlpZMUNVVnBEa1M0STU3MnNCazBsMWZDZ2l5VVJiM083ZTh5?=
 =?ks_c_5601-1987?B?TXl3dFY5Y04yQy9RdTBuOTNHNzNocWxnd201c3JvdHEzT2kwRThB?=
 =?ks_c_5601-1987?B?S3dVS3Avelo2ZlYzMnBGZ0hscWs2NlRjZlJFSWpZcXhqTTUyVXhj?=
 =?ks_c_5601-1987?B?UEhRY1BuNitiUGZDT0ZBaXkzQkpyZ3JoSUIwdlllK3dCOTd6ejBh?=
 =?ks_c_5601-1987?B?RFUzbVNVVy9neVpCa1ZvenZIcDlwOUcrQW4yWkdmdEpmZFRnanU3?=
 =?ks_c_5601-1987?B?akVaNmt6WDlwZExydmJDczVlU08raVhnd0pIS1hVQk5BV0JzWFpz?=
 =?ks_c_5601-1987?B?Uk1YQTRTbE41ajQwQm1jQTJIcU1IK1dVMVpSWDhmS1ViNXlmd0R5?=
 =?ks_c_5601-1987?B?RWZjeE1nQ0I1V3o1NkUxZXlPQ3JhYkRBWUh5RW1ZTndGWk4yM3BF?=
 =?ks_c_5601-1987?B?QmNlYjkwa3NpODduelR0VmtFNEV2dmx2a0QrVThVOElVdms0aklG?=
 =?ks_c_5601-1987?B?TjNSNEJhTUJoVHc3ZEZicUtHTEJVenJodEVadTR5TzFWR0lwM2Jt?=
 =?ks_c_5601-1987?B?MmxBVXhXQXlFbnZUUU1Ka2tQNnFkRTZUWDNpakFCYUdheTlJOGtH?=
 =?ks_c_5601-1987?B?RmdJSDdUblB3K3dVMjg4YjVZTkZrZ0p2WUV5Y2NtbDgvZlA0MmJE?=
 =?ks_c_5601-1987?B?WmxaRk50MGloYUhGTXJrM2pQeWhGalJFSzVVc1Q0VFdNZ1BOWDl1?=
 =?ks_c_5601-1987?B?VjFxVnhRRUdrWlJUcFkzMDhrT2VuSW1TelVzNFFITEE4LzhIVGZt?=
 =?ks_c_5601-1987?B?RkRRYzVMZTlKcjhkRExYejJ4S21vVjUyQU5NUkUxNkZrU2NyU1p0?=
 =?ks_c_5601-1987?B?dm5vWjVvQnZVd3F3UWUyeW1RZFNySllqbEZ2ZjNlSGRVY3d5czI0?=
 =?ks_c_5601-1987?B?WEpLdTZvTW5NZ1BKSjFWUlVqNkJoMGlyemNMU2ZZL0R3ZmdhNTZQ?=
 =?ks_c_5601-1987?B?WGRVcU1QUHhFczdrdVJWcE1tdUVXNDdSOGZuNlBISHlNTk5sbFZH?=
 =?ks_c_5601-1987?B?dkNIMWdwenV4WXVnaXhKTDJjenRSeWhXOVRkM2lJWDVYZnkyWkdR?=
 =?ks_c_5601-1987?B?cnFCMFV2cHdsTzhhWk5IS3owRnJNalR2VGlyVFBydjlSL0x6Z2dE?=
 =?ks_c_5601-1987?B?OTlYNDNxSE1SbEJENmxZTVRCOUZVbXgrNkl5dVRPeGN0NFhiUHV5?=
 =?ks_c_5601-1987?B?WHgzNFNUVVlHS0E5TjRJZ2pUdmRDdmlYbmMrbER2WTF0aEk1RHQv?=
 =?ks_c_5601-1987?B?bFJrdndzaWcxc2RnWGZvNkRENnZ4ejFIcmFtREJqWVRtS2dkWXV5?=
 =?ks_c_5601-1987?B?d25wY3lOb2EydHdmQWRjUTI4Yis4amJnTGJ5Y1BOSVcwa1dER1o0?=
 =?ks_c_5601-1987?B?K1VqT0p2NzFQdngyNmZLLzRNQWtsb3dPQ1h6Z2MwZlpqTkE3S2Nm?=
 =?ks_c_5601-1987?B?QWNMY1kxSGJrYkpwb1FyRFRoUVliWVV6NlN0UU8wZTFuajBxQTJ0?=
 =?ks_c_5601-1987?B?dEpaeDV5cUk0aStrbWxGTkdjSnUvbG9WL3p6WXZkR3QyckV4bFYw?=
 =?ks_c_5601-1987?B?d0tNZnFGQXBMRG03NTBWTEpsenJHVlZhblk5S0J0c0hlQ2NOK2hV?=
 =?ks_c_5601-1987?B?bWt3Yk5YMWZGUkMrZnhJNGdLV09pWUlOSmNsNUc2QzNSV2RJQnF6?=
 =?ks_c_5601-1987?B?ajhJTzhCdndoUCt0RWxMVFBscFBtU0ZJaTV1N095U2k2amJmSFdv?=
 =?ks_c_5601-1987?B?cVpYZlhaKzNpMEJ0ZnR5bVIzbUd4WlJ1ZXhHbU1FUXhadHhpVlBQ?=
 =?ks_c_5601-1987?B?RFhPemNhemRMbWRoOGVxc1hldGE0eWNlYnM3MTd3ZWtLeUc1VVlG?=
 =?ks_c_5601-1987?B?MDdXYTVEcTBWQW1pU0N1ZDRGSEFWc2Q0bFBBWGZBbmlaVHd5T2lB?=
 =?ks_c_5601-1987?B?OTlWcmU0S2JiWDNCVExac1NMVHdTcUIvak5adG1Ic2p0R203dkh0?=
 =?ks_c_5601-1987?B?UT09?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2088d9d-a764-406c-de0c-08da6d13d073
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 01:28:29.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR17MB2024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mjg4ICAgICAgICAgICAgICAgICAgICBvcC0+ZHVtbXkubmJ5dGVzICogOCAvIG9wLT5kdW1teS5i
dXN3aWR0aCk7DQogIDI4OSAgICANCiAgMjkwICAgICAgICBpZiAob3AtPmRhdGEubmJ5dGVzID4g
MCkNCiAgMjkxICAgICAgICAgICAgdmFsIHw9IFRSQU5fQ09ORl9EQVRBX0VOOw0KICAyOTIgICAg
DQogIDI5MyAgICAgICAgd3JpdGVsKHZhbCwgc2ZjLT5iYXNlICsgU0ZDX1JFR19UUkFOX0NPTkYo
MCkpOw0KICAyOTQgICAgICAgIHdyaXRlbChvcC0+ZGF0YS5uYnl0ZXMsIHNmYy0+YmFzZSArIFNG
Q19SRUdfVFJBTl9MRU4pOw0KICAyOTUgICAgDQogIDI5NiAgICAgICANCg0KU2VudCBmcm9tIG15
IGlQaG9uZQ0KDQo+IE9uIEp1bCAyMywgMjAyMiwgYXQgODo0NyBQTSwga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gMjg4ICAgICAgICAgICAgICAgICAgICBv
cC0+ZHVtbXkubmJ5dGVzICogOCAvIG9wLT5kdW1teS5idXN3aWR0aCk7DQo+ICAgMjg5ICAgIA0K
PiAgIDI5MCAgICAgICAgaWYgKG9wLT5kYXRhLm5ieXRlcyA+IDApDQo+ICAgMjkxICAgICAgICAg
ICAgdmFsIHw9IFRSQU5fQ09ORl9EQVRBX0VOOw0KPiAgIDI5MiAgICANCj4gICAyOTMgICAgICAg
IHdyaXRlbCh2YWwsIHNmYy0+YmFzZSArIFNGQ19SRUdfVFJBTl9DT05GKDApKTsNCj4gICAyOTQg
ICAgICAgIHdyaXRlbChvcC0+ZGF0YS5uYnl0ZXMsIHNmYy0+YmFzZSArIFNGQ19SRUdfVFJBTl9M
RU4pOw0KPiAgIDI5NSAgICANCj4gICAyOTYgICAgICANCg==
