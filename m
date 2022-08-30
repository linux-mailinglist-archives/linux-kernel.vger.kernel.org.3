Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825555A5CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH3HPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiH3HPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:15:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2083.outbound.protection.outlook.com [40.107.114.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28851D0C8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDG/IQEvE5Wq4Qb6Fjp5802uFk/Dr+6G3r1m+GpF13u7Q0YqUEsVLd8kGu8bl2xMX+GxAr99DFaVHMzsb3tcxQCTD843/EUHv81GaEmFd3miUNnptCo5LUPgza3AZSZOGk95wYMQK7PeNP7AwknS2StL5rz0hx+RG3LSnvY58/LqVhSmXFaGRCj8wRzLvjHK+ZWRijM0C2eODATUhyZCyowhXAxCj4zvmIlnEAGuhZM8RCzL73e6xjARXmv0Jqa+U/YeRzKzX7YfN9bb2nlHUG0rMnH69QXlJzltC4poN4bjklZQ3XG6kj+zyM8c/NCxL+u2m67nVtXAH7U+S6M7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8nazYxDMCAoKu2wnY9sFyWyrgksHytaDR0CKGG2TmQ=;
 b=gnz9V3oi4tumPiWuRvNlmn8c2/4MUWLMjjnGT5RJXIzdr8O+kIYpaA+PccLjI/8d6RyqpYcelwlXpbe4OYwQrizZnAmzapaMuc53grgFNksuLNNLzHXLrGbW73xoBBMTAb66E0b/mmR5SYLL9w/MhmCHsKE5uYckjYwj8iBFqunodbUTHq1mlSpfLES0NRMzQ4pbzOiOxQ4U3mbciFQU2WzZtsn/NH9IhprRXsSt2jmyeh/TAetqAnfV2EQ8YZMKQHdl5A2YxMUpakBitkHog9MTfPEeDuYikPIZoJQHaxjbnmwU7xCmLPW6k58Wr+CnNV9bNbpvWMo+eaX1Qptd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8nazYxDMCAoKu2wnY9sFyWyrgksHytaDR0CKGG2TmQ=;
 b=OA48/fI24mG0k30JDuTyFHztSTs9Wj+d6Huo/1Z0gGiGrdhoM2lmgHIMwEm+98vB6Pmem0UP0O1Xk5SZtE3liEuKR1L9gR6tfBpN+WjmcsUjyDKLFwCnZedm6UjDea8LojqeQca5VaMAOq5Lsv7xjjl0TBJGzpOM5VaNHklgY7s=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB9386.jpnprd01.prod.outlook.com (2603:1096:400:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 07:15:16 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 07:15:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Thread-Topic: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Thread-Index: AQHYvEA/gShSCwxubk2vNqgBxyOLog==
Date:   Tue, 30 Aug 2022 07:15:16 +0000
Message-ID: <20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
 <20220819033402.156519-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20220819033402.156519-2-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c664e9a-2254-44a6-3521-08da8a5763e1
x-ms-traffictypediagnostic: TYCPR01MB9386:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YamzadN+jEyKDJOGGzSFwpVmMhlyoRYVN250NvfOMYM+pPkUL1s5mILtORHdHMT41OQlKHpOIBcgPXKBWnhymw/+yrIptDXdK2BK+ZyxfwO6fTUydzPex46J/K9Q/RJ/INMLzP9SgZ6XN4C8f1Covq/fPF2ftanIBLI6cDp4v8oZOUKngQrObwT7M/ptiakmkGLFcbQTqyrJP04fUtz6uMz8HqQ+12c8AMZs1I5wAoXIY/hqLygnjw5oKM9zk8EEQNMFhq/Ip9ri9AEuDxaCYe1Hvo77uBZxng9lt6PaAdgtIddiWZJddexfk01YNioqILxYTZoK3GNvNmGU9QCu5sH5wehblkskBC2j6oKLZwJijHBVkOtaIL3RAWfpej4GQEn/a2f4+tiWL71Kv4ssayV6yFQRU+Ex5CmSPEeg/DAornA55O6zUH5bqahH6zCnMnYPTkfr0pGc5LlcgJjcx5vWFb7fILscZoQzGHzKK6zRWfP+26SGr+VwSVqyAJ1eluRHmAcd6PEGcWPC5IMvfhMEArGQJTKo+rCFRUQqUujhcHVoxXqDmmqOGtmGGN40/WIGCMkwUuDkGOwp5Yd4XtPGDFcrYVu1xxgH0aGhAgsboVlWUwpxmwl04dIRRRomtJKWTSjPOFMCusYDj5aUbatBcG2ry1YkiTc4zfoCFK1d9reg6WPIQFvWdQ6GJwzhnAz41bZ4LguUnDGkgvBr61Q0hx3ogWYI3h4tnGN0sSmApS4QVuEvns+Vwfhh8rYwwQP6TcOIdQeYAZx13DsIdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(38070700005)(6916009)(71200400001)(316002)(1076003)(186003)(85182001)(38100700002)(86362001)(82960400001)(54906003)(64756008)(122000001)(9686003)(66476007)(2906002)(83380400001)(66946007)(6506007)(8676002)(66556008)(4326008)(6486002)(76116006)(66446008)(478600001)(41300700001)(33656002)(8936002)(6512007)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bERiMlF6cllVb3RQejMvWXI0TFNpejUwb2RZcXZ2cEplM1c5cGFpUFRrb01t?=
 =?utf-8?B?MytVUHh4Z3p3QWgwMHcwWDNVakJGa1E2VlVoZmVsMkRnaVIwV0tvaC9Xb1NX?=
 =?utf-8?B?cEtxT0pxNkJxVElVQ2g4YWlFWUl6dHl0N1MzSGpCOHNSRXA3b281UTBIcnpK?=
 =?utf-8?B?R2pQQkR0YWJpVmJrNjJTVklEQUpJV2Z0dUdYdDZYRlRtYlhFME5FZGZmakNI?=
 =?utf-8?B?eVB4bGR4THllUXdTeXphOVdXU3pZajZGaDN0OFIxb1AwVUVpZ2hwSGVFNjA4?=
 =?utf-8?B?aUNaVTlhRk84U0lrMTE5MUZSTzZicGxSQzlxc2hDTFRVVGhUYy9PSFQvS0JX?=
 =?utf-8?B?MTUzaDlNcjI1ZFNTSUQvZExScXArc2l1QU5USUZiTWkxeGVvSWFKTzB1TzNo?=
 =?utf-8?B?aEtLd2MyNXF2cEZERDRwZXFwQjV3OE9YZVIvUUNyQ3BYVVBSN0RUQ3FBN3oz?=
 =?utf-8?B?U2tjMnQvbjhWZ2hBYXJFQ0svNEZISCtYaGRHMGZVbk1FVlBiOVFrMDE1SmhL?=
 =?utf-8?B?S0JrZGp0Q1BEaWk0dExBc0VqSTNKdVRxR2pRemJjMWQ3VE9oc2NndkQ3TFFG?=
 =?utf-8?B?bVdUQzIrWnpjV0lXSFJXNGxZcWdPY1MrYzVtU2l2TzNDVnQybE9wTWt5MlpW?=
 =?utf-8?B?QjRVaDRYZkFqOUo0VmpicmxOUEMyQkZjMEJTSi80Q2NUZjhjRHNaVHdiQ3JS?=
 =?utf-8?B?dGRzcGFhWk1iUnd5VkxONmI5RTdaNUo5Q3kwMTlRNHFBazBEYUZKYWUrMkZj?=
 =?utf-8?B?dnJNTlNlL2tiTVZudkl4bEVZWnl0Z0Q3QWpTMktRTnFMSGRrQVdUT0VUMDRk?=
 =?utf-8?B?WGhFZHF0alF2U0s4aDRNOFRwY3VEWWh3SCtUS0o4YlJiTWVGUnJjazJueTR0?=
 =?utf-8?B?NTdFZ2doWmRTdmtsTW1zdWpJb1N4SUkvaWtTRzBJSVl1U21COTJmaXZramZq?=
 =?utf-8?B?SG50MHlTNFJvZ3JUOXBOQlRPbDJGaGRQcmVwVGtTL2xIMlFYUDNtRTZ5M1lh?=
 =?utf-8?B?eStubVpWR0o0T2I4QTQvRlcwVU5xS3BmL2R1SkE1Q04rZjhKV2ZFMTBleUJ4?=
 =?utf-8?B?T1oyVGhsUlVRakUzYmhzdVBjcktoYmxxWlNobXY5WExUanBnUjNiTS8xL1Z4?=
 =?utf-8?B?V3FJcXJPcVd6aU1rOE40VjRQTk1GRFdUSVdDcXZGSEFxY1ZzTGdOSFhQbFh6?=
 =?utf-8?B?YXQ1c25lZWtwQUhPcVhjVGNSOXdTVHg1VHNDRTc3SnVMZlVPSWEvZ050bkNL?=
 =?utf-8?B?OTc1REt5dnNCK3dwMGU2Q3FyOTlSZVRXNWdMR3J1RzgzOXhjUC9yV0JHMC9k?=
 =?utf-8?B?Q3hBSk1Ga0plQ0lERzJuSnl2bWlmVWFHQzVkcFZWeXErS2pya2pod3lXVHRN?=
 =?utf-8?B?dkszTUhFOHNZbDNlZ1NwbjgzaE5MUWhVY1J0Qk1tRnF5VFZwMWZ4c2poTndv?=
 =?utf-8?B?UWQ4U1B3Z2h0YS9XRmV3QldNNS9iS3BuQk1KcTIzeWcwNEVyWFZHRStOblBN?=
 =?utf-8?B?VE9CYldBYnVKZjhBUFpEWVFNaSs5bzhaVkNnOVZrSllmbFozdWRBNjAvNmFE?=
 =?utf-8?B?VVBkbzdzcUpYU3ZBQmVRNmJYNG53S2p0UURlbGo1ay9QUVhzMzB3NTl2Nys3?=
 =?utf-8?B?c2hVRFEzd3B2WHlIQi96S0tZeURnd21XVlQ4aVgxRkx1M0tjUnV1UkQ4M3Rr?=
 =?utf-8?B?S011M05MdC9tbnk0aENPNnI2SDEyZzg0NDE3MjdwN0hJY25pRXBqd0pGaFlu?=
 =?utf-8?B?ZEVOeTdtU0RuUytmQnQxSFA4Vm5lejVIbTBjcUtrR3NsTmhEbGRCOG9UOXJW?=
 =?utf-8?B?Z1l3TTA1dTg0VHhaZDhlVmdBd05zM1lZRVFFcDN4MGk0V3oyaGY5SEM5ZmhF?=
 =?utf-8?B?R0dpSXlOV210YmpXeC9BUmhJaWJTOG96VTQzbVMrdjJqVnRrckZWbUh2eTA1?=
 =?utf-8?B?RmtYUmtVb3llZ2o0dU1GaTlld0s5cWMwTnE1SW5pQ0NLcE5rQXlnMVNiaGFv?=
 =?utf-8?B?RDd6cUJSYnpGS3dsQ2FxVzhRdDRncFFqd3FuR1JHSFRRUllVN2xNTGQzdzRa?=
 =?utf-8?B?VXRPSHF4L203cUtyV29FMzB1U2swU3BpVTdyd2xKeGVLQkZEOWFMZ2k2ejNO?=
 =?utf-8?B?RHlNSEVOMXh4UzRaYXFLaDV4a2xjd0VCdm5qa08vMlp0TllxQ0Njbm5CRStO?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40FD763F6E16324FB9900FF72CFCF3B9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c664e9a-2254-44a6-3521-08da8a5763e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 07:15:16.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g3KgJNzb/E90exH8tZZa/FLJOuBkqT63XF1eZeFy23g0617IPKWmMZrbAB7IPGm2G5bDhL0C490oDwaexSsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMTE6MzQ6MDJBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFNxdWFzaCB0aGUgX19zb2Z0X29mZmxpbmVfcGFnZSgpIGludG8gc29mdF9vZmZsaW5l
X2luX3VzZV9wYWdlKCkgYW5kDQo+IGtpbGwgX19zb2Z0X29mZmxpbmVfcGFnZSgpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2VmZW5nIFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0K
PiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAyNCArKysrKysrKystLS0tLS0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVy
ZS5jDQo+IGluZGV4IDFhN2Q2NTQ4Y2NiMi4uNWIzNjgxMjQ5NTZkIDEwMDY0NA0KPiAtLS0gYS9t
bS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTI0
MzIsMTEgKzI0MzIsMTEgQEAgc3RhdGljIGJvb2wgaXNvbGF0ZV9wYWdlKHN0cnVjdCBwYWdlICpw
YWdlLCBzdHJ1Y3QgbGlzdF9oZWFkICpwYWdlbGlzdCkNCj4gIH0NCj4gIA0KPiAgLyoNCj4gLSAq
IF9fc29mdF9vZmZsaW5lX3BhZ2UgaGFuZGxlcyBodWdldGxiLXBhZ2VzIGFuZCBub24taHVnZXRs
YiBwYWdlcy4NCj4gKyAqIHNvZnRfb2ZmbGluZV9pbl91c2VfcGFnZSBoYW5kbGVzIGh1Z2V0bGIt
cGFnZXMgYW5kIG5vbi1odWdldGxiIHBhZ2VzLg0KPiAgICogSWYgdGhlIHBhZ2UgaXMgYSBub24t
ZGlydHkgdW5tYXBwZWQgcGFnZS1jYWNoZSBwYWdlLCBpdCBzaW1wbHkgaW52YWxpZGF0ZXMuDQo+
ICAgKiBJZiB0aGUgcGFnZSBpcyBtYXBwZWQsIGl0IG1pZ3JhdGVzIHRoZSBjb250ZW50cyBvdmVy
Lg0KPiAgICovDQo+IC1zdGF0aWMgaW50IF9fc29mdF9vZmZsaW5lX3BhZ2Uoc3RydWN0IHBhZ2Ug
KnBhZ2UpDQo+ICtzdGF0aWMgaW50IHNvZnRfb2ZmbGluZV9pbl91c2VfcGFnZShzdHJ1Y3QgcGFn
ZSAqcGFnZSkNCj4gIHsNCj4gIAlsb25nIHJldCA9IDA7DQo+ICAJdW5zaWduZWQgbG9uZyBwZm4g
PSBwYWdlX3RvX3BmbihwYWdlKTsNCj4gQEAgLTI0NDksNiArMjQ0OSwxMyBAQCBzdGF0aWMgaW50
IF9fc29mdF9vZmZsaW5lX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICAJCS5nZnBfbWFzayA9
IEdGUF9VU0VSIHwgX19HRlBfTU9WQUJMRSB8IF9fR0ZQX1JFVFJZX01BWUZBSUwsDQo+ICAJfTsN
Cj4gIA0KPiArCWlmICghaHVnZSAmJiBQYWdlVHJhbnNIdWdlKGhwYWdlKSkgew0KPiArCQlpZiAo
dHJ5X3RvX3NwbGl0X3RocF9wYWdlKHBhZ2UpKSB7DQo+ICsJCQlwcl9pbmZvKCJzb2Z0IG9mZmxp
bmU6ICUjbHg6IHRocCBzcGxpdCBmYWlsZWRcbiIsIHBmbik7DQo+ICsJCQlyZXR1cm4gLUVCVVNZ
Ow0KPiArCQl9DQoNCkkndmUgZm91bmQgdGhhdCB0aGlzIGNoYW5nZSBjYXVzZXMgYSByZWdyZXNz
aW9uLiBBZnRlciB0aGUgdGhwIGlzDQpzdWNjZXNzZnVsbHkgc3BsaXQgaGVyZSwgaHBhZ2Ugbm8g
bG9uZ2VyIHBvaW50cyB0byBhIHByb3BlciBwYWdlLg0KU28gaHBhZ2Ugc2hvdWxkIGJlIHVwZGF0
ZWQgdG8gcG9pbnQgdG8gdGhlIHJhdyBlcnJvciBwYWdlLg0KDQorCQlocGFnZSA9IHBhZ2U7DQoN
CkNvdWxkIHlvdSB1cGRhdGUgdGhlIHBhdGNoPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
