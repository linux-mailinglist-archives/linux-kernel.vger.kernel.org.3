Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDD525D61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378232AbiEMIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378275AbiEMIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:30:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6382D2A83C6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsZBW9OPOR8XfVRfsrdgojISvRfSdgvuH+OxSZYbb5OzfW9Stxw+yDCV2QEmLzzePujM85k9ie11TvjBkDjgT5xrQ2f2owQ+qXR7aXHWeCNSTQZErhocGIyJnxLPgr0pXrBhoW5WR1XAieE01usNAVlZr6LY7zYPS18dtds8HXJl1BNMjYV/W6eOztmEdn2RJCd47pJ2gZrD1UmHxUT0X9lOxZS2nfrbxC4jRofpMU0Mb/1lyISzptvYyNsfGGS5qVa73WwqzCMKy4ynuA87KZ7NyCTHfvzkw8ae591fmCmjEbw5IDL0R45L6Sw5yMnpEKccIwxnP3k559LLb4hYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUP3QcXii/SUwNDbH8MdMog6C4/PQeXWZU+B1a65/Q4=;
 b=f16I/aqVe2a2G9ggLqLCBetdamQbB/Q6al1UiEOiac8otRBj8KEn15qNItqisL8gNLjDLlkb13vvonRKMpTk2a0iMKdVEoEBJcH5OvcyZFkIL+2MUSauSKk0Schzv+MelmjxgqI3FPBfljjegZw39kTmuGimFO4VW340mBEVkmoB8NKhR1tdm5wgh8xEHmAAY00f33/ypU5ZMo4xbTNUUkF4xTLCbVOEWtgr+sfKr6lJq9isDAHT5dscTQlTK3yaxfxgx3hG0fAtJEQjRYMZ5a5gb0Jua+GBZwgrpmHxv7Dh4MwNPtDjKIsnqlbJN2w2MeafQdkul0hzqEIia49Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUP3QcXii/SUwNDbH8MdMog6C4/PQeXWZU+B1a65/Q4=;
 b=VtUYbkrQfVxewnGxEPGrGuVq5zFrvB1heiAMSF32/2P07MU18dD3Vw0fFSSFWxvKlt519oU02bCgC8OiiyryYgq9sE6i49Odsdh//JR53BUQgzi8OkbfVN1IpPxSJM842Lb9O7zDwArQSVLobpKOJaP2kG2etxn9UEq++7gjD+U=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB3898.apcprd06.prod.outlook.com (2603:1096:4:f9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 08:30:10 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0%7]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 08:30:10 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2] arch_topology: support parsing cluster_id from DT
Thread-Topic: [PATCH V2] arch_topology: support parsing cluster_id from DT
Thread-Index: AQHYZRz4UmkE46baoUWBVBVWQAmP3K0bS+uAgAEuOJk=
Date:   Fri, 13 May 2022 08:30:10 +0000
Message-ID: <SL2PR06MB3082CAA7318834D00872DE0DBDCA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
 <Yn0XE3szFk9f2VyL@bogus>
In-Reply-To: <Yn0XE3szFk9f2VyL@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 092f98f5-fb6f-4deb-45e6-08da34bacb17
x-ms-traffictypediagnostic: SI2PR06MB3898:EE_
x-microsoft-antispam-prvs: <SI2PR06MB389815A7B1845D8D9066D515BDCA9@SI2PR06MB3898.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qy99sMy0FDlzBjVN/7qtAbsuHKhP/GfthhOQJs6QiG3T+2JEaJnAM0p+ESt+h8h5UnWu2vdl5NImtwJQJulwR0Hf+ZLxnTf+gxkgvlDgWtWQLNE6dwEBbvGRnnd2bXs9ys+ap4FPb9OUovANrC5UYdzfr/iV2wsZDXZeBD3FjzX9NdD6ssVHmq/kD0VHViYu9WcR0qC0R3xp0m2SJwPjpCLez4CUclXjnB9pafv3O/TZgEwgWJQfSV7TgFi+6BUWTUyO40Sl20qwL7lHEXChw5qi7Q2+4E7F2Ohj/ELqrM1iY6k5ZpWkx9XxvtuseIswjYH3faZw7R8aM4fR30a5dB1uukPirInk5tSA/om9xAGodqRI6hsAw5euAdaT4VyIiCTIImOO8SFQ9jMeHkgkNKJ8VxggyvdBCapZQzeYlUj9YXDmExuj8bWomq3GzNIfuS8p7qjkQ4a+LIIA7+Syxsjgt3LzP6WTAAK1Oan+WwBvbKaSzp/tl9LAWY/rbFfTtKrgbG6zq0weACPwqfS4370U6nJ68SA0MTo9oyqcTCBs7VPjbB95qXrMk0xwRDwwElzCvNnjvjQJiyeDVgeAygUcQA8N4fK4KIUKWdwp2oyisIfLxwdU+i8oFCGL/CaewXg3GI6IuUhB4eLoJMUridx/qimVEx4z8lHgBQ7fNwt0gWWas1eezTzd1nKNDfJgOMot6FymFapXHOlAHb/TYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(316002)(9686003)(52536014)(122000001)(91956017)(76116006)(7696005)(6506007)(85182001)(6916009)(54906003)(508600001)(71200400001)(86362001)(8936002)(186003)(55016003)(64756008)(66446008)(66556008)(4326008)(66476007)(8676002)(66946007)(38070700005)(38100700002)(33656002)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d3NBU0hmUGRjN1NMZ3g5V0NkR0Jkb2dEUU9NYVdZcTRoVDNOdnMveHZ3aGo1?=
 =?gb2312?B?YWdPN0NGUW9KWk9pZzRrNVd5dVprMGQvcGZWMlJoQTVPSDIrT25QVm5Panpv?=
 =?gb2312?B?bVhMY3dvREVMc1c1cVk4TVdEVVk0UDhjRVFIdzVyZjBFVjBDU0FDTUxITFZ6?=
 =?gb2312?B?L29HYkVyenpNenBXZHZQTTlHZlM0TDhwZXphQmtrNzl3S1BLa09rVnV6anAv?=
 =?gb2312?B?dWI0ZGdSaTEyZy83QmIxZ0Z3NFp3VXVqYWN5ekw0YlhVUTA4TDV6ejJDRlU0?=
 =?gb2312?B?enVCaDZWeGJXSGhWNTE3RWZCU3hmWlpMNWh2aHZJOXQ4cTlySitnL1hOaHRQ?=
 =?gb2312?B?RGxDTTVCMWJzTjdvNlk0SlZhSndHMEdHQ3JEdnlPUm5VSWl5M0NudllhUEFF?=
 =?gb2312?B?NnA0Q0Zxd0tTUjFuZkYwd01Qa2dWTVozUXdQc0lYQmM5ZXE2eHdTNlJTdG1a?=
 =?gb2312?B?Nk9zV1NBNnFsYzZ1OUxsZS8wd3dCazlPbkhnM0FFNDF2ZEgzNVBUZUJKdi9s?=
 =?gb2312?B?WVFsdE90bEVOcXd5cUVsUlpzWjJ1YStRemRHb3VjZE1tNXRtcEhlUTdWSm84?=
 =?gb2312?B?S1F6eUhVUXZoVmZjaTVhWjBaZVNnRVgzWFdlRTRTSkx4VCtlNTl4WUM1eXpm?=
 =?gb2312?B?WTdSNG9ZQnQxclJPSGFNcDJOaGl1Q3MrRmwxM0JhQ2tscFFxWEMxT3A2Wmw5?=
 =?gb2312?B?cmQ3K1AycUJwUXdNOEZ3TGloekl2cDZzTktQQkFrZW1lTTR4TnBUdEsyTW5o?=
 =?gb2312?B?SVJFc2FLMkREdlpyYnZvOWhjZ2xOak5hallDSmdnS3VwaVJhM0NFc2FhVGpJ?=
 =?gb2312?B?eEdFODFnMnZSTTNwdWJQUlB4U0owTkRObmNodE5QMTZvQzlOVjlGbXlJcVJY?=
 =?gb2312?B?TGhnSTZ0TTNJcUp5LzhGRm9xRXdreXRPYURUV2hjSHduRWhVdERGSWtqUHo2?=
 =?gb2312?B?c3lqSVdCY0dlRDdwUXp4b0NWL2dEdE5NaWsrR2I4YXJIU3VXRlVSaHI1ZzMx?=
 =?gb2312?B?Mm9FMVIvU0I1aXAxamp4dUtmWHVHY29iVm9SZ3krWWdZaVpWY3llRXRvYWln?=
 =?gb2312?B?TytpOGM1QWJPMG1OVWpVdmtlRkFISG5lRkZTZ25zZjlEeitTTFZHMTFIemRv?=
 =?gb2312?B?Q283NnhlY2d5eU1wK3RTWU53VGF2K2RxTnorUFR0enByL0tIV3lLVlFNR3JQ?=
 =?gb2312?B?M1JlUmZuWjZ0bXlNbUlYRVBZbUVrcjNudDk5dWhlNXRZQlFiMHAydHlDZXZ5?=
 =?gb2312?B?bTZtTTE3MEdjSURmUjk3eTdyNXlLRlVyZi9ESlZidzJJNWJoR2pOalFNUG4v?=
 =?gb2312?B?M1VzZUpnZXkrS050WXZKQ1g5Y1dOUDhpdFBUTHpzckZGcDVNcFZENFV3czRs?=
 =?gb2312?B?YlF0alZxcEJWeTNKTzRYWlYxQnFkVTFRNGFjZFFGRktqWU42aHQ0dnFvTzZJ?=
 =?gb2312?B?MU9hbnVmTy9nMElFVzErR1RVanNGcXpjVDl1R0p6bHpNc0JqVkJzUzl4Z1Vr?=
 =?gb2312?B?VXFnYS9MSXlreDlGZG4rUnpBR2lFRUM5aHJ6VWY4Z05uZ2pDREJSNmo4VXow?=
 =?gb2312?B?LzN1blJKUHRoSVVzTWIyaUEyWlhjYXZsbU5CNStaVGxWaUwwYU1Zd2lqd0kx?=
 =?gb2312?B?d1Z1RklHZkJMTDJKOWk3V3lwRXA4dW1GTHFWSlRpMnlud21zY2FRU3QrQmFX?=
 =?gb2312?B?MEloWDJzczlrWkV2c08xdjEzaFRtaTZOb0kzdGJNdFU4WndRYXdHbnV2NCto?=
 =?gb2312?B?SHVHUTNFL3hOa2dkc1V2NWpiQWY2aW5rZXNrMWdMYmc2bXEwNE5GbkU3dGJ2?=
 =?gb2312?B?WWd3TEViL0xwYzJ0MjRRVitvaVZSaFloS1JDb3RlWk1pSVJielNXbUZRcU9E?=
 =?gb2312?B?OUg0NHFOc0U1Z3k1OEtWREtVc0FTa21qYnVZUDhNQXBQdU5ucjlkdTRBdHJl?=
 =?gb2312?B?S043cTZORmdZN0c2OTlsVlNVQWh6a0ZKZnRBVlljWURFN25RbG9LMSt5REx1?=
 =?gb2312?B?KzhTNDJSTHFqRS9qMkRydTcrcGVhbVJPR2tJU2VDaUp4TU80NXp6YmFSNExM?=
 =?gb2312?B?MDZqTlliVGV4TWJ2RGRoUHdUZUszTzhkbVNweVFCcEZFSVQ3cG1IY3FmUG5Q?=
 =?gb2312?B?bFRHWitNeDYzOXI1MmFwUjh4VFZibXpkYStOK29VY2M1cXJFcFdFQlFjNEJn?=
 =?gb2312?B?cjhsVUxrRFkvbFNwMXFWd0xjWXJIc1ZZcUtQQjdPRDZjeFNYNGhLSENtN2xE?=
 =?gb2312?B?aVZjM1JSbVROQksxL1BNOGpFOWdITHVMM2NTZ0pHN1Y2SlRUUWJKUTBDTlp4?=
 =?gb2312?Q?QQ2mwKHo6452Nh3m42?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092f98f5-fb6f-4deb-45e6-08da34bacb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:30:10.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwhekb76NQUxrhHgxozX8Jq6twD4+X3hYMNudUd9UfA/EwLYv2ExMRn8fKMSkZZkL/3/Te/URmAXznoMBHjyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3898
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBVc2UgbmVzdGVk
IGNsdXN0ZXIgc3RydWN0dXJlcyBpbiBEVCB0byBzdXBwb3J0IGRlc2NyaWJpbmcgbXVsdGktbGV2
ZWwKPj4gY2x1c3RlciB0b3BvbG9naWVzIGFuZCBpbmNyZWFzZSB0aGUgcGFyc2luZyBvZiBuZXN0
ZWQgY2x1c3Rlci4KPj4gCj4+IE5vdGljZTogdGhlIGNsdXN0ZXJzIGRlc2NyaWJpbmcgaW4gRFQg
Y3VycmVudGx5IGFyZSBub3QgcGh5c2ljYWwKPj4gYm91bmRhcmllcywgc2luY2UgY2hhbmdpbmcg
ImNsdXN0ZXIiIHRvICJzb2NrZXQiIGlzIHRvbyBpbnZvbHZlZCBhbmQgZXJyb3IKPj4gcHJvbmUs
IHRoaXMgcGF0Y2ggd2lsbCBub3QgaGF2ZSBhbnkgZWZmZWN0IG9uIG9uZS1sZXZlbCBjbHVzdGVy
IHRvcG8sIGJ1dAo+PiBjYW4gc3VwcG9ydCB0aGUgbXV0aWwtbGV2ZWwgY2x1c3RlciB0b3BvIHRv
IHN1cHBvcnQgQ0xVU1RFUl9TQ0hFRC4KPgo+U29ycnkgdGhlIHNvY2tldC9wYWNrYWdlX2lkIGlz
IGJyb2tlbi4gSWYgd2UgYXJlIHBsYXlpbmcgd2l0aCBjbHVzdGVyX2lkCj53aGljaCBpcyBub3cg
d3JvbmdseSBwcmVzZW50ZWQgYXMgcGFja2FnZV9pZCwgeW91IGFyZSBmb3JjZWQgdG8gZml4IHRo
YXQKPnRvby4gV2UgZG9uJ3Qgd2FudCB0byBicmVhayB0aGF0IGluIGEgZGlmZmVyZW50IHdheSBv
ciBsZWF2ZSB0aGF0IGFzIGlzCj5zaW5jZSB0aGUgY2x1c3Rlcl9pZCBhbmQgcGFja2FnZSBpZHMg
bm93IHNob3cgdXAgYXMgc2FtZSBub3cuIEVhcmxpZXIgdGhlCj5jbHVzdGVyX2lkIHdhcyAtMS4K
Pgo+SSBoYWQgYSBsb29rIHdoZW4gSSBzdGFydGVkIHJldmlld2luZyB5b3VyIHBhdGNoLiBBc3N1
bWluZyB3ZSBkb24ndCBuZWVkCj5uZXN0ZWQgY2x1c3RlciBzdXBwb3J0IHlldCwgSSBoYXZlIHNv
bWUgcGF0Y2hlcyhub3QgYnVpbHQgb3IgdGVzdGVkCj51bmZvcnR1bmF0ZWx5IHlldCkuIExldCBt
ZSBrbm93IHlvdXIgdGhvdWdodHMuIElmIHlvdSB0aGluayB5b3Ugc3RpbGwKPm5lZWQgc3VwcG9y
dCBmb3Igc29tZSBraW5kIG9mIG5lc3RlZCBjbHVzdGVyLCBidWlsZCB0aGF0IG9uIHRvcCBvZiB0
aGlzLgo+QWxzbyBJIGhhdmVuJ3QgYm90aGVyZWQgYWJvdXQgc2NoZWQgZG9tYWlucyBhcyB0aGlz
IHB1cmVseSByZWxhdGVzIHRvCj50b3BvbG9neSBhbmQgaG93IHRoaXMgaXMgbWFwcGVkIHRvIHNj
aGVkIGRvbWFpbiBpcyBvcnRob2dvbmFsLgo+Cj5JZiBhbnl0aGluZyBpcyBicm9rZW4sIHRoYXQg
bmVlZHMgdG8gYmUgZml4ZWQgc2VwYXJhdGVseSB0aGVyZS4gSSBzZWUgdGhlCj5pZGVhIGhlcmUg
aXMgY29ycmVjdCBhbmQgd291bGQgbGlrZSB0byBwdXNoIHRoZSBwYXRjaGVzIG9uY2UgSSBidWls
ZC90ZXN0Cj5hbmQgZ2V0IHNvbWUgcmV2aWV3L21vcmUgdGVzdGluZy4KPgo+UmVnYXJkcywKPlN1
ZGVlcAoKWW91IGhhdmUgdG8gbW9kaWZ5IGFsbCBEVFMocmVuYW1lICJjbHVzdGVyIiB0byAic29j
a2V0IiksIG90aGVyd2lzZSwgCm5ldyBwYWNrYWdlX2lkID0gLTEgYW5kIG5ldyBjbHVzdGVyX2lk
ID0gb2xkIHBhY2thZ2VfaWQuCgpUaGlzIHdpbGwgYWZmZWN0IE1DIGFuZCBDTFMgdXNlYWdlLCBk
byB5b3UgaGF2ZSBhbnkgcGxhbnMgYWJvdXQgdGhpcz8KClRoYW5rcywKUWluZwoKPgo+Li4uCg==
