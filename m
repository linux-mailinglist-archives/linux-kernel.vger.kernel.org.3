Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFE5808A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiGZAL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGZALy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:11:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2084.outbound.protection.outlook.com [40.92.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16227FCC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkVzT05ICkTra2DltlIqPqchrvCqpnZk48BlHLBgYUJsBW/hAvn5TggQ/e36oyeawNd2k/MSc6tES/dgD73kAtqPo1ClkQccRvegvJpBD2VZuGoVpPyysQgaPJu6QXKEVQmJnayv/xZeZNn9HDWTcmTHPJAO6HU4yiMlZOxFaZ2XNAbkpw/UmsgkEXDLGPjKUKOrtQ4PfoMXUfh5zA8stWZtIMlsSOaezd6jYv8DfdBW7XqVJN9xuYd5QQYjUNFRNTj9wn/uMR8zVecezsnJevG7zZqWGt7Tu5s2MHZwG/kVKsxX2zCDvbXo8MTVUIKJd7YJfOocLcipIKWO2rCmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCH8adpSMb+/dma24xDz6khTWvJqYepgL3WJQ08mjHU=;
 b=ScPEVtR0iArj28F45Sz4nPiAuxyY/1XnnpQBOYWDHKYj0QnbFaGZYCkpz8AaQWN3aVeA9efH7w76rf/QzUIzQLjBvVr0n3cIMNryUuBnli+Vt69cg6K+9N3AUNHvZ1Rckyrk5Awyc+rsZwR6DuihexS5aobtfFtK9qEygc1PW1MUTIMTAxIjGgVpWw92xLF7gVnvc2/uzJlgHirwmR5xj8gZMABtCMUAm8OMmW8ypn0Avg/6SlCXz9Hghn2S3NPlx2dgt8r9WgTpkdZDYy+7W7pfhig6TSMAhwTqf7hX9J99HvdqKWUiZp6lmwYLSBeRlGVk/K9ttdMd5XU8G7UswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCH8adpSMb+/dma24xDz6khTWvJqYepgL3WJQ08mjHU=;
 b=b/HBhFzyxj6yXm7uh0kJOQnJRWBeeMuVIrM1P+Y03USRQ4FHLI+SMnDYqW+H6MzLyweraXDRM8C+YbK/Dbk5PFmIKpFIP12CWTl8bH2wBDqA7cjR/t9qeO7E13dhM/wv+i6peHyHDFCg/ygEfFgy9f/OAhCju5ZQMra0Aca9S35H4/F2I6lMAtM0jLCBgH8d3M5PSNHJeQhZtWI1cLbyullVDHQhzrUtP43X47PB+1q3nXHTg/bC7AyG1YhuyKCN4NbAgmRyctJcFgGey3/3tVwUpNmTPSjQ2lC89msZZZl2SY0f3TKQtqvCj6eaBALBQaiAJt84vRU1koS6Mm01Dw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by BY5PR17MB3857.namprd17.prod.outlook.com (2603:10b6:a03:239::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 00:11:49 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 00:11:49 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     Yifei Liu <yifeliu@cs.stonybrook.edu>
CC:     "ezk@cs.stonybrook.edu" <ezk@cs.stonybrook.edu>,
        "madkar@cs.stonybrook.edu" <madkar@cs.stonybrook.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Topic: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5VgAEeYNeAACJU2w==
Date:   Tue, 26 Jul 2022 00:11:49 +0000
Message-ID: <MN2PR17MB33753129D81B1E42A54768BDB8949@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
 <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
 <MN2PR17MB3375207FA1AF24E6666BC95AB8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB3375207FA1AF24E6666BC95AB8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [hjLrHaLqhokicLRemqAAbINj+ugOibHUCCCRaCyVivYHlimH7BinLRuyMUHJzLY0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3574e4c4-2edb-4366-2a7f-08da6e9b6f7a
x-ms-traffictypediagnostic: BY5PR17MB3857:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsTj7XfE/10BlaPvMUd9hzEbZLD4gSh0xVEZ/23YN7ndLH6RAxkPrtre/Uwi6PrId7Kwr8oPi3F3DEAaLIDsuz/u709P3/ZJRZbIhEG/fND/WZIm7YVqaUUFIIFHnrKjY1DZmgMaS+iNr/weXf7k9CNDoTmhAXJxfzIQ/5LUFsEd4l9A2StDjcYaZX42cdyLQsduIvfBMsFLjoxmZ857E4F68dYeuDc+RfSGhcP/88YusicJeLQB9jEGWCX3obcNXg6xw0iMkIAqI9AyGrseYU0rKNC/QwfHMry51R+H2ThQ7reeuHzzT7jBoxzAQiKCux5kTs9QHN+2S2H8n0D9SR5G+ggp/2tHpI4tCfx+phP6u/yN6X5BICbnnC9TMCo862piP5em/nW7mFd2LUZ/DhgoptsHPacvBq1MRLfcPGmog77EG9chjbzrtu5Cp9168PaK7x5mn+ObvINuyxywqECBwO+jT9xZyKcJxglmS0ZCUfMCOqbEPRKKnv1NxYApBF0KmBr2vpnHou5S+2PJ0MNP2y3DkvTNbUfELF2TpvdE/SwqtrFPdvJa/tI2ALDRilWD+zfFc1b+tYMtk5SpNyPVXGx9RXLy+RWCucgXPONqb33Fxg6JQtNbzKpMfkP9IoJciaUK4TN6BLEBtgPmlg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm1tWllicEVUdlltSnFrTktHY3ErSVZWanMyYXBRYmdZMGV1c2RLb2UrQmdx?=
 =?utf-8?B?MVNCQUkvRitQNkJOOFdQemp6RnJYU2V3K1NWSjE0OHBZeEJWSW9mdnFPelBu?=
 =?utf-8?B?Y2ZEVXo0aXo0c1FUTWR2M3p4N3cxcXhlM0c1T1VpdlhMMmJKOURqTG0yVzVl?=
 =?utf-8?B?Q2p1d1V0WW1wVExXSUJtWUl1cU1LOXR5b25naDVYNThUQit0NFVaSFJiM0Fw?=
 =?utf-8?B?OUFpWjZpaHdSMG5aTnNMVlYrcnZabjAwS2dkemF1bG0rdkJxZnp2dXI2NFlR?=
 =?utf-8?B?cUcvalcva1M3VFROejBRbURyMWxPQ0JvZEltS1JUbnRweHBQb21CT0hrNjlZ?=
 =?utf-8?B?N3dTYlRud2tyUVo2Z1lJUm9tOUhwdG9GNEFEb1JMT0h2Z1FGaXBzMVEvdVEr?=
 =?utf-8?B?WVJhbmUzVDlpb1g5L0hNZmUyemF2NXdpdWdHWFpkSlBsVHA2Q3R3VFhtT3Bm?=
 =?utf-8?B?MlF4MEVyYmtWbXYySnkzbGVtTWt4ZytSZ0lMbmpUc3lYM2dsazY5TkZtOVNh?=
 =?utf-8?B?RTJ5MkxiaVhDdzQwRGdGZFRSbnZMbUxvWm9OYUVKN1g5eU9qbFFTaGVGVmtx?=
 =?utf-8?B?SGFLQ3dZSnNEeWNhK0dFeGVOSXRnS3FqeVIyQ0tSa1gxeFlySGVNQUtVRDZx?=
 =?utf-8?B?dStjNUtwMUJqR0RyellQR0lBelY3NVducWx2OFR3MTE2N3dNbTljMUw1RU9i?=
 =?utf-8?B?MnZ1Mk9GNU5jYmF2RjdFUDQwdjkwZDhFbHZkM0RyTXBOS1pJbTU3NGRZQURw?=
 =?utf-8?B?cFdReWhncE05UzVRcFh1eDJsOUNRaFREYk9hejNOWDBmL2lsczltbWMzaVJv?=
 =?utf-8?B?Nm1xekptN2xkbUNWRm43d2ZpeWpQdUdQa0FQRkIydEJEQkN1OEdEV01nUFV6?=
 =?utf-8?B?OGo2dFZ2MnVLWkFjRE9WNlRRS0lWMEtFRDUrSURoZDRsWURIcGZpaGs3N2ZY?=
 =?utf-8?B?bHltallnZzNpVXhSQkVWelRGZk81TWkzL3g1eFRWMlVQSWZwZ1VKRzA5djhS?=
 =?utf-8?B?YUNwaGpWV0d5VXNuYlppVDRncUFGempPUmF5cloyRllpb3dpYmtLYXZ0bHND?=
 =?utf-8?B?RU9sNTZMWndjWEdGZ28zTWZ5ZFVTamxwc2o1aCtQdnNtMVNIRTZlWWRrMHJZ?=
 =?utf-8?B?OFdGYUdHRk1DeHFaZXZXZmJlWVg0aUxvT3lMUHRRa29ZTWV0VkE1Nmc1bmlv?=
 =?utf-8?B?eUNQWVhLZ3VIRU1od3paOUl4aVBZVndkb1R3N2RXNy9CNW44Z0NsVW1JTXJS?=
 =?utf-8?B?dVhLOFlDV240RkRUU2lIOWhDWXFtTGY2eWs4Si8yQWtLZk0zRjVHRnUwcTFS?=
 =?utf-8?B?eE9xMTUwb2pzMGlkY1FMcDJrYTJGVzFGQzFJY1ZEUDI4SHNsRUU3bjdGSWpO?=
 =?utf-8?B?R2h0Q1VLTGc5eUdOeWUxMDBRbUUzRDlQd2Q0NFdwZ0JLd3BkbCtzbG0vck43?=
 =?utf-8?B?UDZGRzB1d0dmcDJDYTkwcUYxcVFjVmRMbXFjbTlueWNNQzE1ZEVibFNYYi9H?=
 =?utf-8?B?TlRhTytjQWNjL1EyakJ4YWswbmlHZk41NmEyV3VvQlBvcFRKYVAydklCaUh5?=
 =?utf-8?B?WGJWaU00VThWTmcxNG9xVkNEK2tGcXJaeWRwUmVqRWE5Sk8xOFhadXYybVdM?=
 =?utf-8?B?VmVPa1Y1YmNKZnVxV2dNSE9seFNSaHgzTVRJMlhMeUlmd0IyTzJUanZzN3BO?=
 =?utf-8?B?enVjVktFTWhWaWwzVFM2b2N1VUFQNWlNUFVxSDdLb2hVdHQ1U1J0ZFVJZm9V?=
 =?utf-8?Q?oTv3C2y/Ql66rGOY28YSO3pPbOSlVUuan9jYs3s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3574e4c4-2edb-4366-2a7f-08da6e9b6f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 00:11:49.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RvcCBmdWNraW5nIGVtYWlsaW5nIG1lIHlvdSBzdWNrIGZ1Y2suIFlvdSB3YW50IGEgcGFzc3dv
cmQgc28geW91IGNhbiBoYWNrIG15IHNoaXQgeW91IGJyb2tlIG1vdGhlcmZ1Y2tlcg0KDQpQZW9w
bGUgYXJlIG5vdCBUSEFUIHN0dXBpZC4gDQoNCj4gT24gSnVsIDI1LCAyMDIyLCBhdCA2OjExIFBN
LCBWYW5lc3NhIFBhZ2UgPFZlYnBlQG91dGxvb2suY29tPiB3cm90ZToNCj4gDQo+IO+7v1lvdSBs
YW1lIGFzcyBzdGFsa2luZyBtb3RoZXJmdWNrZXIuIFlvdSBhcmUgY29tbWl0dGluZyBhIGNyaW1l
IGFuZCBJIGhhdmUgcmVwb3J0ZWQgeW91IHRvIHRoZSBwb2xpY2UuIA0KPiANCj4gS29vcPCfmILw
n5iC8J+YkfCfmJHwn5iR8J+YjvCfmITwn5iE8J+YtPCfmLTwn5GA8J+RgPCfkoHwn5mI8J+ZiPCf
mYjwn5mI8J+SgfCfkYDwn5GA8J+YkfCfkoHwn5iB8J+Ys/CfmI7wn5i08J+YkfCfkYDwn5iR8J+Y
hPCfpKPwn6Sj8J+YgPCfmIPwn5iR8J+YtPCfmITwn6Sl8J+kq/CfmKXwn5iw8J+ltfCfpbXwn5ih
8J+YofCfpKzwn6Sv8J+YrfCfmK3wn5if8J+Yn/CfpbPwn6Sp8J+luPCfpbjwn6W48J+ZgfCfmKnw
n6W64pi577iP8J+Yo/CfmJTwn5iU8J+YlPCfmJbwn5ij8J+YovCfmKHwn6W28J+YsPCfmLDwn5il
8J+YpfCfmLbigI3wn4yr77iP8J+krPCfpKzwn6Ss8J+kr/CfmLbigI3wn4yr77iP8J+ltvCfmLDw
n5iw8J+kq/CfpKvwn5iT8J+kr/CfpK/wn6SvDQo+IE9vaWdndmtscG91cmXwn6Ss8J+krPCfpKzw
n6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Ss8J+kr/CfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+kr/Cf
pK/wn6Sv8J+kq/CfmJPwn6Ss8J+kr/CfpK/wn6Ss8J+krPCfmYHwn5iS8J+YjfCfmJLwn5iS8J+Y
jvCfpbjwn6Sp8J+ls/CfmJ/wn5iW8J+luvCfmKnwn5ip8J+kqfCfpbPwn6Wz8J+Yn/CfmJbwn5ij
8J+ZgfCfmKnimLnvuI/wn5if8J+Yq/CfmKTwn5it8J+krPCfpKnwn6Sp8J+luPCfmI7wn5mB8J+Y
qfCfmKHwn5i18J+YqvCfmKfwn6Sl8J+kpfCfmK/wn5i18J+krvCfmKzwn6Sl8J+Yk/CfpJfwn6SX
8J+YtvCfmLLwn6Sk8J+kkPCfpJLwn6SV8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr
8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/Cf
mLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfpJHwn5i88J+YveKYoO+4j/CfkoDwn5KA
8J+Ru/Cfkbvwn5G78J+RufCfkbnwn5G68J+RvfCfkb3wn5KA8J+SgPCfkbvwn5KA8J+SgPCfkoDi
mKDvuI/imKDvuI/imKDvuI/imKDvuI8NCj4gDQo+PiBPbiBKdWwgMjUsIDIwMjIsIGF0IDE6MDQg
QU0sIFZhbmVzc2EgUGFnZSA8VmVicGVAb3V0bG9vay5jb20+IHdyb3RlOg0KPj4gDQo+PiDvu7/w
n6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn5iN8J+RjPCfmI3wn5GM8J+YjfCf
mI3wn5iN8J+YjfCfmI3imLrvuI/imLrvuI/imLrvuI/imLrvuI/imLrvuI/wn5KV8J+SlfCfmJrw
n5ia8J+YmvCfmJrwn6Ww8J+YmvCfmI3wn5iN8J+YjfCfmJrwn5ia8J+YjeKYuu+4j+KYuu+4j+KY
uu+4j/CfmI3wn5KV8J+YmvCfpbDwn6Ww8J+YjeKYuu+4j+KYuu+4j/CfmJrwn6Ww8J+YjeKYuu+4
j/CfmI3wn6Ww8J+YjeKYuu+4j+KYuu+4j/CfkpXwn6Ww8J+lsPCfmI3imLrvuI/imLrvuI/wn5iK
DQo+PiANCj4+IFNlbnQgZnJvbSBteSBpUGhvbuKcjO+4jw0KPj4gDQo+Pj4+IE9uIEp1bCAyNSwg
MjAyMiwgYXQgMTowMSBBTSwgWWlmZWkgTGl1IDx5aWZlbGl1QGNzLnN0b255YnJvb2suZWR1PiB3
cm90ZToNCj4+PiANCj4+PiDvu79CdWcgZGVzY3JpcHRpb24gYW5kIGZpeDoNCj4+PiANCj4+PiAx
LiBXcml0ZSBkYXRhIHRvIGEgZmlsZSwgc2F5IGFsbCAxcyBmcm9tIG9mZnNldCAwIHRvIDE2Lg0K
Pj4+IA0KPj4+IDIuIFRydW5jYXRlIHRoZSBmaWxlIHRvIGEgc21hbGxlciBzaXplLCBzYXkgOCBi
eXRlcy4NCj4+PiANCj4+PiAzLiBXcml0ZSBuZXcgYnl0ZXMgKHNheSAycykgZnJvbSBhbiBvZmZz
ZXQgcGFzdCB0aGUgb3JpZ2luYWwgc2l6ZSBvZiB0aGUNCj4+PiBmaWxlLCBzYXkgYXQgb2Zmc2V0
IDIwLCBmb3IgNCBieXRlcy4gIFRoaXMgaXMgc3VwcG9zZWQgdG8gY3JlYXRlIGEgImhvbGUiDQo+
Pj4gaW4gdGhlIGZpbGUsIG1lYW5pbmcgdGhhdCB0aGUgYnl0ZXMgZnJvbSBvZmZzZXQgOCAod2hl
cmUgaXQgd2FzIHRydW5jYXRlZA0KPj4+IGFib3ZlKSB1cCB0byB0aGUgbmV3IHdyaXRlIGF0IG9m
ZnNldCAyMCwgc2hvdWxkIGFsbCBiZSAwcyAoemVyb3MpLg0KPj4+IA0KPj4+IDQuIGZsdXNoIGFs
bCBjYWNoZXMgdXNpbmcgImVjaG8gMyA+IC9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcyIgKG9yIHVu
bW91bnQNCj4+PiBhbmQgcmVtb3VudCkgdGhlIGYvcy4NCj4+PiANCj4+PiA1LiBDaGVjayB0aGUg
Y29udGVudCBvZiB0aGUgZmlsZS4gIEl0IGlzIHdyb25nLiAgVGhlIDFzIHRoYXQgdXNlZCB0byBi
ZQ0KPj4+IGJldHdlZW4gYnl0ZXMgOSBhbmQgMTYsIGJlZm9yZSB0aGUgdHJ1bmNhdGlvbiwgaGF2
ZSBSRUFQUEVBUkVEICh0aGV5IHNob3VsZA0KPj4+IGJlIDBzKS4NCj4+PiANCj4+PiBXZSB3cm90
ZSBhIHNjcmlwdCBhbmQgaGVscGVyIEMgcHJvZ3JhbSB0byByZXByb2R1Y2UgdGhlIGJ1Zw0KPj4+
IChyZXByb2R1Y2VfamZmczJfd3JpdGVfYmVnaW5faXNzdWUuc2gsIHdyaXRlX2ZpbGUuYywgYW5k
IE1ha2VmaWxlKS4gIFdlIGNhbg0KPj4+IG1ha2UgdGhlbSBhdmFpbGFibGUgdG8gYW55b25lLg0K
Pj4+IA0KPj4+IFRoZSBhYm92ZSBleGFtcGxlIGlzIHNob3duIHdoZW4gd3JpdGluZyBhIHNtYWxs
IGZpbGUgd2l0aGluIHRoZSBzYW1lIGZpcnN0DQo+Pj4gcGFnZS4gIEJ1dCB0aGUgYnVnIGhhcHBl
bnMgZm9yIGxhcmdlciBmaWxlcywgYXMgbG9uZyBhcyBzdGVwcyAxLCAyLCBhbmQgMw0KPj4+IGFi
b3ZlIGFsbCBoYXBwZW4gd2l0aGluIHRoZSBzYW1lIHBhZ2UuDQo+Pj4gDQo+Pj4gVGhlIHByb2Js
ZW0gd2FzIHRyYWNlZCB0byB0aGUgamZmczJfd3JpdGVfYmVnaW4gY29kZSwgd2hlcmUgaXQgZ29l
cyBpbnRvIGFuDQo+Pj4gJ2lmJyBzdGF0ZW1lbnQgaW50ZW5kZWQgdG8gaGFuZGxlIHdyaXRlcyBw
YXN0IHRoZSBjdXJyZW50IEVPRiAoaS5lLiwgd3JpdGVzDQo+Pj4gdGhhdCBtYXkgY3JlYXRlIGEg
aG9sZSkuICBUaGUgY29kZSBjb21wdXRlcyBhICdwYWdlb2ZzJyB0aGF0IGlzIHRoZSBmbG9vcg0K
Pj4+IG9mIHRoZSB3cml0ZSBwb3NpdGlvbiAocG9zKSwgYWxpZ25lZCB0byB0aGUgcGFnZSBzaXpl
IGJvdW5kYXJ5LiAgSW4gb3RoZXINCj4+PiB3b3JkcywgJ3BhZ2VvZnMnIHdpbGwgbmV2ZXIgYmUg
bGFyZ2VyIHRoYW4gJ3BvcycuICBUaGUgY29kZSB0aGVuIHNldHMgdGhlDQo+Pj4gaW50ZXJuYWwg
amZmczJfcmF3X2lub2RlLT5pc2l6ZSB0byB0aGUgc2l6ZSBvZiBtYXgoY3VycmVudCBpbm9kZSBz
aXplLA0KPj4+IHBhZ2VvZnMpIGJ1dCB0aGF0IGlzIHdyb25nOiB0aGUgbmV3IGZpbGUgc2l6ZSBz
aG91bGQgYmUgdGhlICdwb3MnLCB3aGljaCBpcw0KPj4+IGxhcmdlciB0aGFuIGJvdGggdGhlIGN1
cnJlbnQgaW5vZGUgc2l6ZSBhbmQgcGFnZW9mcy4NCj4+PiANCj4+PiBTaW1pbGFybHksIHRoZSBj
b2RlIGluY29ycmVjdGx5IHNldHMgdGhlIGludGVybmFsIGpmZnMyX3Jhd19pbm9kZS0+ZHNpemUg
dG8NCj4+PiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBwYWdlb2ZzIG1pbnVzIGN1cnJlbnQg
aW5vZGUgc2l6ZTsgaW5zdGVhZCBpdA0KPj4+IHNob3VsZCBiZSB0aGUgY3VycmVudCBwb3MgbWlu
dXMgdGhlIGN1cnJlbnQgaW5vZGUgc2l6ZS4gIEZpbmFsbHksDQo+Pj4gaW5vZGUtPmlfc2l6ZSB3
YXMgYWxzbyBzZXQgaW5jb3JyZWN0bHkuDQo+Pj4gDQo+Pj4gVGhlIHBhdGNoIGJlbG93IGZpeGVz
IHRoaXMgYnVnLiAgVGhlIGJ1ZyB3YXMgZGlzY292ZXJlZCB1c2luZyBhIG5ldyB0b29sDQo+Pj4g
Zm9yIGZpbmRpbmcgZi9zIGJ1Z3MgdXNpbmcgbW9kZWwgY2hlY2tpbmcsIGNhbGxlZCBNQ0ZTIChN
b2RlbCBDaGVja2luZyBGaWxlDQo+Pj4gU3lzdGVtcykuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1i
eTogWWlmZWkgTGl1IDx5aWZlbGl1QGNzLnN0b255YnJvb2suZWR1Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IEVyZXogWmFkb2sgPGV6a0Bjcy5zdG9ueWJyb29rLmVkdT4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBNYW5pc2ggQWRrYXIgPG1hZGthckBjcy5zdG9ueWJyb29rLmVkdT4NCj4+PiAtLS0NCj4+PiBm
cy9qZmZzMi9maWxlLmMgfCAxNSArKysrKysrLS0tLS0tLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9m
cy9qZmZzMi9maWxlLmMgYi9mcy9qZmZzMi9maWxlLmMNCj4+PiBpbmRleCBiYTg2YWNiZTEyZDMu
LjA0NzkwOTZiOTZlNCAxMDA2NDQNCj4+PiAtLS0gYS9mcy9qZmZzMi9maWxlLmMNCj4+PiArKysg
Yi9mcy9qZmZzMi9maWxlLmMNCj4+PiBAQCAtMTM3LDE5ICsxMzcsMTggQEAgc3RhdGljIGludCBq
ZmZzMl93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsDQo+Pj4gIHN0cnVjdCBqZmZzMl9pbm9kZV9pbmZvICpmID0gSkZGUzJfSU5PREVf
SU5GTyhpbm9kZSk7DQo+Pj4gIHN0cnVjdCBqZmZzMl9zYl9pbmZvICpjID0gSkZGUzJfU0JfSU5G
Tyhpbm9kZS0+aV9zYik7DQo+Pj4gIHBnb2ZmX3QgaW5kZXggPSBwb3MgPj4gUEFHRV9TSElGVDsN
Cj4+PiAtICAgIHVpbnQzMl90IHBhZ2VvZnMgPSBpbmRleCA8PCBQQUdFX1NISUZUOw0KPj4+ICBp
bnQgcmV0ID0gMDsNCj4+PiANCj4+PiAgamZmczJfZGJnKDEsICIlcygpXG4iLCBfX2Z1bmNfXyk7
DQo+Pj4gDQo+Pj4gLSAgICBpZiAocGFnZW9mcyA+IGlub2RlLT5pX3NpemUpIHsNCj4+PiAtICAg
ICAgICAvKiBNYWtlIG5ldyBob2xlIGZyYWcgZnJvbSBvbGQgRU9GIHRvIG5ldyBwYWdlICovDQo+
Pj4gKyAgICBpZiAocG9zID4gaW5vZGUtPmlfc2l6ZSkgew0KPj4+ICsgICAgICAgIC8qIE1ha2Ug
bmV3IGhvbGUgZnJhZyBmcm9tIG9sZCBFT0YgdG8gbmV3IHBvc2l0aW9uICovDQo+Pj4gICAgICBz
dHJ1Y3QgamZmczJfcmF3X2lub2RlIHJpOw0KPj4+ICAgICAgc3RydWN0IGpmZnMyX2Z1bGxfZG5v
ZGUgKmZuOw0KPj4+ICAgICAgdWludDMyX3QgYWxsb2NfbGVuOw0KPj4+IA0KPj4+IC0gICAgICAg
IGpmZnMyX2RiZygxLCAiV3JpdGluZyBuZXcgaG9sZSBmcmFnIDB4JXgtMHgleCBiZXR3ZWVuIGN1
cnJlbnQgRU9GIGFuZCBuZXcgcGFnZVxuIiwNCj4+PiAtICAgICAgICAgICAgICAodW5zaWduZWQg
aW50KWlub2RlLT5pX3NpemUsIHBhZ2VvZnMpOw0KPj4+ICsgICAgICAgIGpmZnMyX2RiZygxLCAi
V3JpdGluZyBuZXcgaG9sZSBmcmFnIDB4JXgtMHgleCBiZXR3ZWVuIGN1cnJlbnQgRU9GIGFuZCBu
ZXcgcG9zaXRpb25cbiIsDQo+Pj4gKyAgICAgICAgICAgICAgKHVuc2lnbmVkIGludClpbm9kZS0+
aV9zaXplLCAodWludDMyX3QpcG9zKTsNCj4+PiANCj4+PiAgICAgIHJldCA9IGpmZnMyX3Jlc2Vy
dmVfc3BhY2UoYywgc2l6ZW9mKHJpKSwgJmFsbG9jX2xlbiwNCj4+PiAgICAgICAgICAgICAgICAg
ICAgQUxMT0NfTk9STUFMLCBKRkZTMl9TVU1NQVJZX0lOT0RFX1NJWkUpOw0KPj4+IEBAIC0xNjks
MTAgKzE2OCwxMCBAQCBzdGF0aWMgaW50IGpmZnMyX3dyaXRlX2JlZ2luKHN0cnVjdCBmaWxlICpm
aWxwLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4+PiAgICAgIHJpLm1vZGUgPSBj
cHVfdG9famVtb2RlKGlub2RlLT5pX21vZGUpOw0KPj4+ICAgICAgcmkudWlkID0gY3B1X3RvX2pl
MTYoaV91aWRfcmVhZChpbm9kZSkpOw0KPj4+ICAgICAgcmkuZ2lkID0gY3B1X3RvX2plMTYoaV9n
aWRfcmVhZChpbm9kZSkpOw0KPj4+IC0gICAgICAgIHJpLmlzaXplID0gY3B1X3RvX2plMzIobWF4
KCh1aW50MzJfdClpbm9kZS0+aV9zaXplLCBwYWdlb2ZzKSk7DQo+Pj4gKyAgICAgICAgcmkuaXNp
emUgPSBjcHVfdG9famUzMigodWludDMyX3QpcG9zKTsNCj4+PiAgICAgIHJpLmF0aW1lID0gcmku
Y3RpbWUgPSByaS5tdGltZSA9IGNwdV90b19qZTMyKEpGRlMyX05PVygpKTsNCj4+PiAgICAgIHJp
Lm9mZnNldCA9IGNwdV90b19qZTMyKGlub2RlLT5pX3NpemUpOw0KPj4+IC0gICAgICAgIHJpLmRz
aXplID0gY3B1X3RvX2plMzIocGFnZW9mcyAtIGlub2RlLT5pX3NpemUpOw0KPj4+ICsgICAgICAg
IHJpLmRzaXplID0gY3B1X3RvX2plMzIoKHVpbnQzMl90KXBvcyAtIGlub2RlLT5pX3NpemUpOw0K
Pj4+ICAgICAgcmkuY3NpemUgPSBjcHVfdG9famUzMigwKTsNCj4+PiAgICAgIHJpLmNvbXByID0g
SkZGUzJfQ09NUFJfWkVSTzsNCj4+PiAgICAgIHJpLm5vZGVfY3JjID0gY3B1X3RvX2plMzIoY3Jj
MzIoMCwgJnJpLCBzaXplb2YocmkpLTgpKTsNCj4+PiBAQCAtMjAyLDcgKzIwMSw3IEBAIHN0YXRp
YyBpbnQgamZmczJfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBhZGRyZXNz
X3NwYWNlICptYXBwaW5nLA0KPj4+ICAgICAgICAgIGdvdG8gb3V0X2VycjsNCj4+PiAgICAgIH0N
Cj4+PiAgICAgIGpmZnMyX2NvbXBsZXRlX3Jlc2VydmF0aW9uKGMpOw0KPj4+IC0gICAgICAgIGlu
b2RlLT5pX3NpemUgPSBwYWdlb2ZzOw0KPj4+ICsgICAgICAgIGlub2RlLT5pX3NpemUgPSBwb3M7
DQo+Pj4gICAgICBtdXRleF91bmxvY2soJmYtPnNlbSk7DQo+Pj4gIH0NCj4+PiANCj4+PiAtLSAN
Cj4+PiAyLjI1LjENCj4+PiANCj4+PiANCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWls
aW5nIGxpc3QNCj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW10ZC8NCg==
