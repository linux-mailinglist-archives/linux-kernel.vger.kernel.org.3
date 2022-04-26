Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E34C50EEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiDZC0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiDZC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:26:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9672ABF66
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5HoQ7TfJBcCnsHA9JF4Kiz9NRwdPYkaIeIInHsxhqJLuj7/pXZBt+IfqDpoj4JuKcENCwwznKX7clnVj3L6WQgJJpzDMBWyThnF9h3Z2MNFS6OhBmuSHxZH2hfZAqKVX3Q9dzIHpE+WqA4QxqtddbINbLal3vLv20ZBCFrMQzNKTGmOUujZZk5jNSuqveqIJW0SSOUtuiGWeMa4Lqp/+Bd+BEqH/rVQTm/xtn6fXS0ko8mJFgcchFPSHseE7orTXInERUJ1iyhhiIbS2IfkvTw6hS+HQHz1fZmmRmMf78BDqmZW683a4NLeeg5UJuqH2fxe09+FEqZNyd/ugEvfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLrhLsFw+G1zHDIdNwVpZMFDiW3LK+YxVzW9eXbNdew=;
 b=LKKuEoZtdmhKdJXtOoILGYya+A2HOwoB1qWHHlqQALnJYiNxuhUB7oVxPNbwj7jMRzmQDNKkH6XqWXOlNLA0vC0UhzMPr9y5P1/pN4Hoknv3CT5PTjaAO4J9TGtUL3VroW35IfenOm1wto/YRaFtHD9mHV+/bFZVIKzDFRLalEV6LoldUz6F9veqx4mQL8ix8mxT/5z6lyUHqy9PeFtqh6xiyFRSea4QsnZ0FWXdAZaoYwySelKW6KlAMh8yKbbxNmwCmpmozap6NhM1kDXq+/sGgGlkErshHhY2oyc95g9wxKhVTNeE2P27xG+uDx5mkgxoFBKDD0fgbO3M4FecSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLrhLsFw+G1zHDIdNwVpZMFDiW3LK+YxVzW9eXbNdew=;
 b=dcW7RMWMYmaLlkNuMdPidgnHlrW/b0WaWNmIjdk7/Zj4WEq5Yro1pbZuLqhKTTN3flmKD+XZABz9uqT0zzTJVFLRMeJlsLSDNgZMxSD65sMoT28u+js0mvJQ9A82R71JLdfLFJ/NOwO6wuJIlW7nIzDZk6lNMaTjuzkBO3/smJs=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SEZPR06MB5317.apcprd06.prod.outlook.com (2603:1096:101:7c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 02:23:26 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:23:26 +0000
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
Thread-Index: AQHYWE/nPyW0oeJKi0iRN/lm7iJKMK0AZ6qAgAAP2UeAAGOYAIAAnATT
Date:   Tue, 26 Apr 2022 02:23:25 +0000
Message-ID: <SL2PR06MB3082544EFB9C6F518A2EBF04BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220425165946.qb6xilgmjahdh4pa@bogus>
In-Reply-To: <20220425165946.qb6xilgmjahdh4pa@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b2722e2-c4f3-4409-a80e-08da272bbe62
x-ms-traffictypediagnostic: SEZPR06MB5317:EE_
x-microsoft-antispam-prvs: <SEZPR06MB53171574E624A773564CDAB0BDFB9@SEZPR06MB5317.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eT7yADGVi05ruUInhA4zbUUr/eHl8fnIJUGSNX09KPF1y+R5hokk+mtXKPrvEl7tv9Oc8odydQG8NnCHcXEFf1xrg8TWSQ7Xlm77pBtr3TsVEt00w3KjrAf+MRjxEe0Ao1t8n+XzkMX8lZELwzRhDmY508r6KT2NQciu5c4SXIO2BPxh+Ig21UK6CynfLMlVs09VGQ8JnlVktBVMcHoa37HySg7jb4BkctVR/O1Gi8uaP21RClZ8QFWN29IUHundll/MRHmzq9CnG/T9unDPpBLGTW2rQEboOiF3Q9Ptc2AGgQrsT8bGRDsQj4vBxDp1R5PQ2rQSumLujyoEUtNwScRhip0AMqBJpJ9Rbwap2IsWTZElrHz1GY9mjLVK8oBGMeW04k8i5AzQ4wtSREM7Vk6gv4uuKVbETEsNFmdm7jxar9s/9hQCjIqS3ayBBsaCGDSNK7H3hTv9c7b7MWQBEpOUhNc8RRhNvvz+PnlnEot+GorG+zIf8fMJE6B/YnUT6QbB78gIG7btgWlzk5AlOsCXur1U2t8Ao/NLi5ToJaQPEKRq5BjxUAWJKbcsv+8xfG/BBSjJb6B8UhqPXxLgKuOiEavoNEXABnvUfYKu8twPt0yIKV/8f0gF1V3meQ3fS+xH74XVfs1IEb6vPUs7/pMERwVehGikq3VN3gTGNNP1pJmbE3jRFleqsVXYYdw82oSBGn4NsF0BqxaYcvYuMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(316002)(4326008)(85182001)(508600001)(66476007)(76116006)(66446008)(66556008)(8676002)(83380400001)(9686003)(5660300002)(7696005)(86362001)(26005)(6506007)(122000001)(64756008)(66946007)(2906002)(33656002)(52536014)(6916009)(8936002)(54906003)(71200400001)(38070700005)(55016003)(38100700002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Znp5V01uRzBORklFTDdQb2ZrVXpFU2kyY2RiTUZEMGNuZFJuc3dpaisya1JL?=
 =?gb2312?B?bWVDWXBWOXJhT0RMUjlyRkhwaXRBTk1JRkZObVo3TkQ5aThRSjJxVkFqdk5E?=
 =?gb2312?B?b3Qxak4vZzR3bVBYV0dCOWpsRWU1OFFWL3crRnhRcmxBZFFqMk0vSDZVM0RG?=
 =?gb2312?B?aHBoUEVrTmVGOVZwa0d1NlFSRVlUamdQRWZBNE12Zm5BdTluWHB4OWVVSkEz?=
 =?gb2312?B?a2JlNVZsUWxVay83MTJlUklER2hHTmdyWVFZMC9BaGZBVGNtWWRtSVgzKzdt?=
 =?gb2312?B?MmFGZ0tDbkk4MmtMZkptODBKaGlNdVJCeDlLM2JhUy9Id1YvVlhUckQwbXJi?=
 =?gb2312?B?cmFNUlFRTDlTR2lZV2x0QU40alRyN3FBM0ZzbHhGR2RjMStkTHRXQzNtTTJn?=
 =?gb2312?B?ekxzWXEzN1lhUEc4dFBaRTFyWnFWWnMwaHo3a2NlZERkQWR1RDk1NEI2Z1kw?=
 =?gb2312?B?YjJQN1R5aWVGWWJwTEh3aGFwT05zejBQZFhVUktHNUJGZmsvWllyQlFOTE5S?=
 =?gb2312?B?NWpSUkNQYkVXaXVFbkZSRU5XeFU5OC9OVUlnekpBQVhSL3FuYkVUTEV4Z01k?=
 =?gb2312?B?K1RGc0JWY09YR2RRaGVYMDVKYkpCWU5oMUkxd2VpSTNCdVpmVkVsbFhZMkxP?=
 =?gb2312?B?VGNtUm5CV3MrRjQyUnBlN0tHUjdrSGQzZlAwclluNmhPTXFOWXI4V25pdWFH?=
 =?gb2312?B?UU5SRFVkYzFBU01EbDV1UVJJbFZqdnhtR3JSaDBDM1VQTWpoMjJnbU4vc2N2?=
 =?gb2312?B?ekJmYzdlcmlReDZFMDBIbDI0Q0pzZFZ4WCtIWHB4MnZnNEttanVRK3lRZ0pO?=
 =?gb2312?B?ZCs1bFdYVTRZWkt0dDFoQ0NnY0kyM1EzSWtyZ3cxUVVBaDE1cDhma2x1SVVT?=
 =?gb2312?B?OCt1ZHlUbTRva0o2SmZwcVdzNUpqcWlGSDcwc29NTGZjcHNLV2ZLWFphRE9K?=
 =?gb2312?B?SXBHU3IrTFpNR0Y0ZjlsdUpBckFVaVVsaFFSRlpHeElibWFlRFJ3bm04dDls?=
 =?gb2312?B?SHZqZ2xrYTZ2MFkvR3E3c0lERUJBVVh5ekh4ZGN6Z0dqRU45eFFGTHlBd3Q1?=
 =?gb2312?B?a3o1V1RUU1ZKbHIvV05KZzVpbS9WMlZySks1R291akxwMDArOWFqMldkSUFi?=
 =?gb2312?B?TVpjenZIUldFTm1QcmNPeUVVOEZnbTlmQjJsdW1wVGxpMU81aUpXMXIyYjhU?=
 =?gb2312?B?N2wrRGJGVElSMW11MXVGd0JUVCtiQWZXRHd5MmcvS2g3TkJ2cTlQbytqV3Az?=
 =?gb2312?B?aXQ0TE82RWl3bEpua1dhcWJhQmZha2xpUWNYVlh5VFhDK2diMlZjN3FLRjRl?=
 =?gb2312?B?UTdqWjM4TnU0Y05aTzN3dVVoRmhzU29VM01tT0k2bG1McHZ3NTRaWXpuZzRI?=
 =?gb2312?B?WWU1QXVYVHQrVEgzamc4cWRCWUFsMklkRHA3cXdVek0ySHdZV2xnVlQ2NUZm?=
 =?gb2312?B?ZUowTHdOeVVhYlMvSUFXK0dBalMwLzhKNlZHcW1US1llM05JRDA1eldTT051?=
 =?gb2312?B?blBINkhJZndYbEZnSzhwNWVEL3BDeTNmSzgwdHBRbHFsRGJJU2tVRXBMMlA2?=
 =?gb2312?B?NTdsUkZSS0ZXaFpXcTVpbC9wVVdMTURMYlU1cUZ2T1dxMm5GdW5QU24vMEFr?=
 =?gb2312?B?SE5XbnVpTlBZUHZXeXl3WStXODhzYVZhTit6bzBVVTdVNXdZKzBGRHF3YzU2?=
 =?gb2312?B?dkthK2RxN3BaaU1Zemk2cjZrQStJWmE4ZE84M0QzTzREejVpalpIaXpkWTJj?=
 =?gb2312?B?T2dUVkp6SHdPbDY0WDlQUDZjM20zTXdCTk5DTWUyMnZqREl3TURQNkVHbi96?=
 =?gb2312?B?dGxlN09tRDBxOHpuaWorVk8yL2FmRS9hcDFic0hITzYyNXJ0TGFSZTJtNW1v?=
 =?gb2312?B?WElQU2k2WjN5RTZZOFZXVGp5TjROOE96T1dGay8xa0xHYXNpbS83cDNHbG13?=
 =?gb2312?B?UFpWVVk5ZTNXemY0VkZob3J0T3VCL1E3WUVMQ3MwMDRxNGU4UjNkbHcvbzhx?=
 =?gb2312?B?MU1FOW9FTVQxOHVUdmR5aVE0Vy96RUdsbHM0MjFwWnlndmVQYWxOSHl6d3ZJ?=
 =?gb2312?B?SjAwQWcwMm9tRFVTT3JHK3IvY0lWeHV1aGM2WmtQVTFLQ1UrU1hXcTlhbk1o?=
 =?gb2312?B?VDNyOC9zZmQzUzNxNnlYekxyMUlCajJ2MVc3OUpvd1JxMGMwMWlDUmV2VFZ6?=
 =?gb2312?B?Yit1YnZ6cnpnSjNxQy9JR0tQb2wwcUdCNnQ2Uk9EU3h0dy9KUWxzUHFuZFlP?=
 =?gb2312?B?VHY5Szh5anIxb3A1aXowSHNDZFZNRk9hOFNxU3pseU1WSjhVVlc0ODNJV2R1?=
 =?gb2312?Q?UQ6EVWrEai39+YWcaf?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2722e2-c4f3-4409-a80e-08da272bbe62
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:23:25.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRqzxJ3ziM6sSweR0d5OTwJApLJ7wKtj4+nyO63HSbrppaQsILJKp8osTiFDWlSK5/5dSJ1TI96Js1zuq88k9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5317
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+PiA+PiBGcm9tOiBXYW5nIFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPgo+PiA+PiAKPj4g
Pj4gY2x1c3RlciBzY2hlZF9kb21haW4gY29uZmlndXJlZCBieSBjcHVfdG9wb2xvZ3lbXS5jbHVz
dGVyX3NpYmxpbmcsIAo+PiA+PiB3aGljaCBpcyBzZXQgYnkgY2x1c3Rlcl9pZCwgY2x1c3Rlcl9p
ZCBjYW4gb25seSBnZXQgZnJvbSBBQ1BJLgo+PiA+PiAKPj4gPj4gSWYgdGhlIHN5c3RlbSBkb2Vz
IG5vdCBlbmFibGUgQUNQSSwgY2x1c3Rlcl9pZCBpcyBhbHdheXMgLTEsIGV2ZW4gZW5hYmxlCj4+
ID4+IFNDSEVEX0NMVVNURVIgaXMgaW52YWxpZCwgdGhpcyBpcyBtaXNsZWFkaW5nLiAKPj4gPj4g
Cj4+ID4+IFNvIHdlIGFkZCBTQ0hFRF9DTFVTVEVSJ3MgZGVwZW5kZW5jeSBvbiBBQ1BJIGhlcmUu
Cj4+ID4+Cj4+ID4KPj4gPkFueSByZWFzb24gd2h5IHRoaXMgY2FuJ3QgYmUgZXh0ZW5kZWQgdG8g
c3VwcG9ydCBEVCBiYXNlZCBzeXN0ZW1zIHZpYQo+PiA+Y3B1LW1hcCBpbiB0aGUgZGV2aWNlIHRy
ZWUuIElNTyB3ZSBhbG1vc3QgaGF2ZSBldmVyeXRoaW5nIHcuci50IHRvcG9sb2d5Cj4+ID5pbiBE
VCBhbmQgbm8gcmVhc29uIHRvIGRldmlhdGUgdGhpcyBmZWF0dXJlIGJldHdlZW4gQUNQSSBhbmQg
RFQuCj4+ID4KPj4gVGhhdCdzIHRoZSBwcm9ibGVtLCB3ZSBwYXJzZSBvdXQgImNsdXN0ZXIiIGlu
Zm8gYWNjb3JkaW5nIHRvIHRoZQo+PiBkZXNjcmlwdGlvbiBpbiBjcHUtbWFwLCBidXQgZG8gYXNz
aWduIGl0IHRvIHBhY2thZ2VfaWQsIHdoaWNoIHVzZWQgdG8KPj4gY29uZmlndXJlIHRoZSBNQyBz
Y2hlZCBkb21haW4sIG5vdCBjbHVzdGVyIHNjaGVkIGRvbWFpbi4KPj4KPgo+UmlnaHQsIHdlIGhh
dmVuJ3QgdXBkYXRlZCB0aGUgY29kZSBhZnRlciB1cGRhdGluZyB0aGUgYmluZGluZ3MgdG8gbWF0
Y2gKPkFDUEkgc29ja2V0cyB3aGljaCBhcmUgdGhlIHBoeXNpY2FsIHBhY2thZ2UgYm91bmRhcmll
cy4gQ2x1c3RlcnMgYXJlIG5vdAo+dGhlIHBoeXNpY2FsIGJvdW5kYXJpZXMgYW5kIHRoZSBjdXJy
ZW50IHRvcG9sb2d5IGNvZGUgaXMgbm90IDEwMCUgYWxpZ25lZAo+d2l0aCB0aGUgYmluZGluZ3Mg
YWZ0ZXIgQ29tbWl0IDg0OWIzODRmOTJiYyAoIkRvY3VtZW50YXRpb246IERUOiBhcm06IGFkZAo+
c3VwcG9ydCBmb3Igc29ja2V0cyBkZWZpbmluZyBwYWNrYWdlIGJvdW5kYXJpZXMiKQoKSSBzZWUs
IGJ1dCB0aGlzIGNvbW1pdCBpcyBhIGxvbmcgdGltZSBhZ28sIHdoeSBoYXNuJ3QgaXQgYmVlbiB1
c2VkIHdpZGVseS4KTWF5YmUgSSBjYW4gaGVscCBhYm91dCBpdCBpZiB5b3UgbmVlZC4KClRoYW5r
cywKUWluZwoKPgo+PiBUaGF0IGlzIHRvIHNheSwgImNsdXN0ZXIiIGluIGNwdS1tYXAgaXMgdXNl
ZCB0byBkZXNjcmliZSB0aGUgcGFja2FnZV9pZC4KPj4gV2UgY2FuJ3QgZ2V0IGNsdXN0ZXJfaWQg
ZnJvbSBEVC4KPj4KPgo+VGhhdCBpcyB3cm9uZywgd2UgaGF2ZSAic29ja2V0IiB0byBkZXNjcmli
ZSB0aGUgcGFja2FnZV9pZCBub3cuCj4KPi0tCj5SZWdhcmRzLAo+U3VkZWVw
