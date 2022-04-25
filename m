Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB550DEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiDYLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiDYLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:21:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75200C848F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZq0Ge5VOaf2I/S6vadSscRblfPJBOyggKeSkNNkfJ0k5LPfSpJPLK4G+lhKMJruS3UChjl3SClMXEUJ1MmK5VuM2ocodAchrF2y7c0yd1pnA84HX2eWdqPOuUSm3UMdR1J2T1gE26XHqX+dwfZqrW6isIWH5rBVjOqcATV00JSknt8Orsd4R963CCJXhdAd0ueswo95KTeZNFeHXPFY56VATatGeVpXAfQj47wYbNQ9XUAFu6iQaLU1HTbwGSKKlAsfB6x6qwK5QoqE4FrjJy3BMPXOW1qXbxzetjxyIA8CbSLCW1np3/jApnPJ5A/L5dlUgzPkfodi337QStoodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60HQpwcAZRp/QG//RkUbAxkmgusSz5Yb6XW7oVzN9Uo=;
 b=eBy7QSqzN6QOYsFX/dyzFpY/dBzZYJd4e0pu5cj7RX/7S2Auj+ZEBQDBR6DIOGQnomlraC4OthQorOfSY1XkH0s+TmkmgVi4MPrfO0WvzLr/O/U8iIhATMwFBwzcsR/dxfZUqw6PruXDmcRqtt6pVtSQWvMVi/kLJUrvBmoZcqxtSE9++07/k7jeCIxVsMOLat8I6gMgI16lGRVqljV0LiEHqpaZUOveDlPzb/yS+np+r+vVNihjKx64P0ObQiC9T0KtXAfUfVJWSoTNcXt/Jo4FXwitx3be+dxEhE8Rt5g+2TV5yhWYUA9CLGzrACmzOzE4dID2hBgGiSPRPyZV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60HQpwcAZRp/QG//RkUbAxkmgusSz5Yb6XW7oVzN9Uo=;
 b=f5MZZ1gaPC6F2jcs9Fde9OIvxk5czr2DSIKxSq4hDQoFmN3Yxutuwgei2aEkmYeKrBRmV9Zr3n8UD7npKVqTv0TuTc4CtYAjJ2Mv7x9z7xHNSWuxX590t1IXzofKIcxuSB1txJp2RcjYf377qolBz6MOGwzo0ckLrjN1FRMeYeI=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4580.apcprd06.prod.outlook.com (2603:1096:400:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:18:22 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:18:21 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Topic: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Index: AQHYWE/nPyW0oeJKi0iRN/lm7iJKMK0AZ6qAgAAP2Uc=
Date:   Mon, 25 Apr 2022 11:18:21 +0000
Message-ID: <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
In-Reply-To: <20220425100635.ig4dxvlflglfagpx@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9182bda6-7858-4a04-35c7-08da26ad4ea0
x-ms-traffictypediagnostic: TYZPR06MB4580:EE_
x-microsoft-antispam-prvs: <TYZPR06MB45802FFFBA1E16267931CC7ABDF89@TYZPR06MB4580.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTFMK1mdHzQy+P9WUjY8fWbMiyB9QMaf+rSgubh8MEq6pFugXngTDYPX5WVzmB63GWJ9llB3h5D6eBA0IakC0YKXqYiAb5C3mm2tse8zsG5Zu+OV1TA5hIiyo2IhnEX9J0Kja/i9ja71krneRrpgjUJ+YhOEaXmg64Sq9DFEecckrI06k9fdiuKdIlb0P2qfIvF60p5E4d5mUB2j+kj2Jv6P9OB2jETP5jzN35BhvFkRdrmz1rRF4OGm0vQZv5G73Xda+JxS3hGiaUe/W+proH7m7DQnVH+lPZy/P36Yh27wxokoMPsn3evaUHeubA0NzTUJ/dWP27T1mu3U7WPmpYAHGFKg3Ap8LkLR+0PutcGlNoZHsGvoa5cCvISEptJZAKexX4GaOSh3LuJnmSd84gCVIbGm8U3Y9zZ8XRyc2PeLZdYsbWzKQtYynPCLeCdeIA3RdmkO0jkkWvtpW/urilb5R0+Qs7p8LbibifcbQDv5dxhZAOo60HajCKCD8hdCKIVH+eNFmOEH7t1V5fOcT7zZomMvPjBXCgHMccxSy1shX0vyoHNOuq4iJ6/txLhITaV72toCMiArmUmUpozSEwjacwWZUlZHCSbVip2FxFk9NfSu0vYz2vZwlV+5EzNBBVTw4oK7dkT5XQkzJ13WQZX7iWiKzQX0dWfIl9oHzgMUKme8RgKoKzjlWWpRCEjq1++TGzJ/tYrMKUFHWYhqgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(85182001)(9686003)(26005)(54906003)(6916009)(316002)(5660300002)(33656002)(186003)(6506007)(7696005)(2906002)(4744005)(86362001)(122000001)(508600001)(38070700005)(38100700002)(71200400001)(55016003)(8676002)(4326008)(66556008)(76116006)(66946007)(66476007)(91956017)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YlJZeTVaTUhTdnd2MXEzeDluNVhZSDQrNlVUZ1ArWTJiQVdlWW5KUmFLZW12?=
 =?gb2312?B?NDFpMU5WbUxrUjRiMXZhcjdwZkRDQjA4Qlk1V0JWSHNNTU81UWtKc1FlaXEw?=
 =?gb2312?B?cWFzOWJNUWlKM2YvWWJwa0NjcTg5dWlvSTBQaFMrNUhEaWRLK2U3L21yaDRN?=
 =?gb2312?B?ZEljQlBCZEFQeWI5NkIrWEZVUmJUamxJa2oxLzQ2V2FtNVdTaS95Y1lmaVZn?=
 =?gb2312?B?TGc0enpHNmlMNXJSVXFlNC9ERTMxOWZSRWo1ek41UFB5ZFhicTFJNElHSENr?=
 =?gb2312?B?MGhFYWtvRkZoZGhyS0l2MmQ4bnVKbk0wT0xFTWVkeW5aNE1oeSs2RzNKcnlB?=
 =?gb2312?B?dWpxSkUxdVJoelVjcEgvc3B5eTdJRWdxRVBIZXNNWWVNK0dmdWtUTHJZTHNa?=
 =?gb2312?B?YzB4UXdoTmVIRExRZ0pkOUs3QktIYklpc0drMUE0bkdPQ2s1cHN4dnhORVRS?=
 =?gb2312?B?TTNlUVNMSDJ1V3YzNXlFRWZOdjN1YmtvUDM2RUlicEJPTDZucFJ2VHdhQXly?=
 =?gb2312?B?d2RRZENVV3VQajhEUW15ZzRqY2IxNFlQUEp2WmJ5dTgxdzd4eTYrUERwbGgw?=
 =?gb2312?B?N25hN0lGMjlVVDJHUzVWdWRvTlUvelhIeTZNNFp4cUhBZlZ0R0pmWTZ4a20v?=
 =?gb2312?B?alN2VmhsZ29BeUx5WTUwOW1VSkJEaDdacU9qVk15bXJTQlM4ejZzYWg3ZWha?=
 =?gb2312?B?U2pWbnJ0YTN4SzdkTG5RTkczbUtqTEpmUkhDbE42VjV1b2h4R2RNMTdCVTla?=
 =?gb2312?B?em1MSkVxYTNpTW9ISXpDTWNwLzFuaXZWNGdJL0lyU1laaGhULzh4UlEySmtM?=
 =?gb2312?B?bTZKRGpIa3pFNVhPNVl0WWhDRXFLRW5Fb0RoSlVrM3JTcUNHM1ZiZDRTREdB?=
 =?gb2312?B?Zy92TVlyc3FlVzI4cWlsRzBkNG9ocGRXNlZNL2RkQ3ZkNXAreXhhYThzTWNF?=
 =?gb2312?B?bUkzOWh3U0ZSOUQzRnhFeXJ4NXoraWF1VExTU2NvTzQwUTdFNlpJVkF4RlZp?=
 =?gb2312?B?aldybHRzYldxT0VqY0xlc3F6d1hiVWVEcmk4cWJGZ3pLYm8rdjVETkZPbDQz?=
 =?gb2312?B?MU9KMXBieVZpNHBTZXBscFJZMllSQWlmMTZpNElzSE1scGRXRm52UndUTjMy?=
 =?gb2312?B?d09BdkRZbmdXZlNDcHhhOXJ3a1lRcWJHSEJrcE9OV3VWSVdTZGlQaTAyd0pE?=
 =?gb2312?B?eG44Smlxd1dmSW94bWsxa2VYODZhSUkvc3M2VGMxNmpwMVliRzg1Wm0vb2JR?=
 =?gb2312?B?QUp0NlYzcEFuNEFUcWJ4eHpmT2Q2dkNkRk9HdVFwaWhrSklEYzRsemtCUm0x?=
 =?gb2312?B?NGNhelpIdUY1QUJYc3hXN3Z5aWdVS0ZKRGE5UVE0aUQyVkxZdjlRVnF5Yi9k?=
 =?gb2312?B?cVA2SVlsKy9jYzE1WElxRWxibVlXdTdHZEg1TnVOTjRvekVxcWlMeFRVbExP?=
 =?gb2312?B?Z0FIZStTV1RPMHkvN0MvKytzVXZlaGVwRTd0Uk1WekIzMHVqMSszalBDaXBu?=
 =?gb2312?B?RDROdjNybTZBZHdhRWs0cTFBYUltbVo2clhOaFQ1WmRoaTh4VWJ5WlhodTZp?=
 =?gb2312?B?TTMxQzZZbzRLaVZLNlFKSHBVNGJubnNOaSt3NDRwR0QxQndjKzJNNHJGQUpn?=
 =?gb2312?B?cTUwR2gwRDVzUnpYSkNZMEpTNkFZK3pWVXQrckhhaVpINUxFUkk3TXZXSVdV?=
 =?gb2312?B?UG44Z1Z5eHMxaUhFQTlQQnhrTFpuNEZ2Nm1US0FPUmVmdEVZbnpPcWd0S3Zp?=
 =?gb2312?B?WEpPMEVTdU1FNDFROEFxRTFVa2lpQVNIOUZJdElYL1h5N0o5aE9OaGNFZ0g5?=
 =?gb2312?B?T01ZbUxsMTNxL250WEZvQitmU1FhN3M1YUhtS1lGZzNmU293dVB1Nktydlor?=
 =?gb2312?B?WERkSHF3aVFLTXNhRWRWd2JwMGtya0JjZld1eTl4Y1FJMXY3ZC96bHdNY2tN?=
 =?gb2312?B?L3IvT3QxNTlRdWo0WTRxZDNMTGZCMzltZDdIeURqTzIzYkxYcHlUY0k0RHlm?=
 =?gb2312?B?U3F4cERtUWYyRDZrMEpjOHN0Z1JQVFRFWDlQUUhUTkI4Wkl5VTZscjRad1NF?=
 =?gb2312?B?Q2VlTWJjTWdNd2IvQlU0dTd1WmlqWDNUdklCZDRkejdteW02K1RTMk1OR25W?=
 =?gb2312?B?elBLdHg4SExod0E5bkFnRzdIRmZhUEY0QWxqQmdCaHVWNjc0ZzJSMWh3OG9m?=
 =?gb2312?B?bk5UUzVJOTh4OUdCWUF2VW9HYjFQVGFubXZuNGlhRVlmVnc4VElYc01FR1NT?=
 =?gb2312?B?YVJJNDJLV3NQeXI0RjE5ZkI4azFtRjVqdWxvVFNLbTZaNVNqalB2bk1KVzJE?=
 =?gb2312?Q?6tETEQN07RpF3ebijk?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9182bda6-7858-4a04-35c7-08da26ad4ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 11:18:21.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IHNY2jN4GYzNtVF3S2waEIOyGXqmOM8Oh9N32Du6Z/rPormWWYWRbIitLnURW0oXWSPQg8hJkOXPRkqmSQwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4580
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBjbHVzdGVyIHNj
aGVkX2RvbWFpbiBjb25maWd1cmVkIGJ5IGNwdV90b3BvbG9neVtdLmNsdXN0ZXJfc2libGluZywg
Cj4+IHdoaWNoIGlzIHNldCBieSBjbHVzdGVyX2lkLCBjbHVzdGVyX2lkIGNhbiBvbmx5IGdldCBm
cm9tIEFDUEkuCj4+IAo+PiBJZiB0aGUgc3lzdGVtIGRvZXMgbm90IGVuYWJsZSBBQ1BJLCBjbHVz
dGVyX2lkIGlzIGFsd2F5cyAtMSwgZXZlbiBlbmFibGUKPj4gU0NIRURfQ0xVU1RFUiBpcyBpbnZh
bGlkLCB0aGlzIGlzIG1pc2xlYWRpbmcuIAo+PiAKPj4gU28gd2UgYWRkIFNDSEVEX0NMVVNURVIn
cyBkZXBlbmRlbmN5IG9uIEFDUEkgaGVyZS4KPj4KPgo+QW55IHJlYXNvbiB3aHkgdGhpcyBjYW4n
dCBiZSBleHRlbmRlZCB0byBzdXBwb3J0IERUIGJhc2VkIHN5c3RlbXMgdmlhCj5jcHUtbWFwIGlu
IHRoZSBkZXZpY2UgdHJlZS4gSU1PIHdlIGFsbW9zdCBoYXZlIGV2ZXJ5dGhpbmcgdy5yLnQgdG9w
b2xvZ3kKPmluIERUIGFuZCBubyByZWFzb24gdG8gZGV2aWF0ZSB0aGlzIGZlYXR1cmUgYmV0d2Vl
biBBQ1BJIGFuZCBEVC4KPgpUaGF0J3MgdGhlIHByb2JsZW0sIHdlIHBhcnNlIG91dCAiY2x1c3Rl
ciIgaW5mbyBhY2NvcmRpbmcgdG8gdGhlCmRlc2NyaXB0aW9uIGluIGNwdS1tYXAsIGJ1dCBkbyBh
c3NpZ24gaXQgdG8gcGFja2FnZV9pZCwgd2hpY2ggdXNlZCB0bwpjb25maWd1cmUgdGhlIE1DIHNj
aGVkIGRvbWFpbiwgbm90IGNsdXN0ZXIgc2NoZWQgZG9tYWluLgoKVGhhdCBpcyB0byBzYXksICJj
bHVzdGVyIiBpbiBjcHUtbWFwIGlzIHVzZWQgdG8gZGVzY3JpYmUgdGhlIHBhY2thZ2VfaWQuCldl
IGNhbid0IGdldCBjbHVzdGVyX2lkIGZyb20gRFQuCgpUaGFua3MsClFpbmcKCj4tLSAKPlJlZ2Fy
ZHMsCj5TdWRlZXA=
