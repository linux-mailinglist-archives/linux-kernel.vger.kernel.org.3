Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492015127EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiD1AHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiD1AH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:07:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86235D1AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXCbp2tVXwmDc72iAv0zuC+Eq9ZO9bYrCFIeYKW7DIEfAlB6/hpPkJAP7Lah/OeOk1JyhPkjvnuVmSjc/oixCLGyW3Wh0ew8senz2J1UVaFNKQpI3pTmyKYxrMzi2IUBYQvYFB8BT4SDCHF+7pfqXtLp9A6pyzmQCjoz/WlshjfJwWbsnH18PQVhz+0wGSQQ8WJIMBYKIYQWkVOYl4k6FEG2/ZxuyuNNejSfbHhHyveCsjNXF02RBuBoE5N0ac4Qsorhh6BajAn0IJH9uVS4FQ6EQy6hQGmj46u+36LKTfJsCclM8TMo3L0iXoyDjDU5NX0PLudLjzEyl+Lk5TDUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IpshmpGcXRuYgDHkeilZRfh7vFEuDfkf1BRdQ/h0r8=;
 b=XVow2DZlqmXiLsU8YLvUk960+3N0BkZL6bM1KlPeJpbiGHxiZrunGI6AwrpiCF4FrN2RoFMax3HU9weWjSk2hY7tkLrNhDPXpQGrJkT03nrfSljlrYdtS1nKv0nGmlraDQ8Fcx2JiI57dojP4oH8SjwQeL/twNFfljINsgIdE++NgcvKAcYfB2sd2WKL/ATDD1uXS3i+Pl8t63kxeSsvWPFNNEMk84VH96PeHP7DqIQKjhr54VI6fIVnwm4eGxSdPI90rdI0eK29ItI4RCcHlwjlns7IX/lst9LDuyTWQiX2OxNNOZt6l9KUZNDtWSLJfgzB47ThV3lvSzWnIJ7HrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IpshmpGcXRuYgDHkeilZRfh7vFEuDfkf1BRdQ/h0r8=;
 b=MHUGyApMb6zMrW5ZlhXDaM2bhg7X1HIaZguS+WRKxTT3HHFwFvG+V5YcfXXhVZxSOtLCVBCs8t7EIGQ4JLDbxPlWbYpzmGjtMLCUktOnxz6VyZD4isMbwE1JDOi2icfJHsm49ifNgJ+DkokQYabBq1DzykHDI1Ulkkfy4859igM=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4436.apcprd06.prod.outlook.com (2603:1096:820:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 00:04:06 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 00:04:06 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Topic: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Index: AQHYWE/nPyW0oeJKi0iRN/lm7iJKMK0AZ6qAgAAP2UeAAGOYAIAAnATTgABJZ4CAAAB5jYAAcH2AgABhugCAAHY9QYAA4hcAgACIdBs=
Date:   Thu, 28 Apr 2022 00:04:06 +0000
Message-ID: <SL2PR06MB3082F1E280EBC79DD7F82B0ABDFA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220425165946.qb6xilgmjahdh4pa@bogus>
 <SL2PR06MB3082544EFB9C6F518A2EBF04BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426064053.h4rwvcdvmwxj2hmt@bogus>
 <SL2PR06MB3082F1AEE684E638C1B5F226BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426132511.7zo4w42kauvrq26n@bogus>
 <2244a7f7-9894-06a0-ea51-edf84f6caada@arm.com>
 <SL2PR06MB3082EA14946F2E207B3043E2BDFA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <9f0589d5-ab0a-9203-b961-984c61cc7283@arm.com>
In-Reply-To: <9f0589d5-ab0a-9203-b961-984c61cc7283@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3467611-29ff-4858-8386-08da28aa9c8c
x-ms-traffictypediagnostic: KL1PR0601MB4436:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB44364D55F3671E4153E68339BDFD9@KL1PR0601MB4436.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsSUkLXyshBV5G8JdcHunzG6PUAZuaAtj9iSJGEnP2FKRutvCgAI48ByajA9qHV4RKNMpxmnmzRnj8i/mokKPkKnbOX8PmuBSysXo57p+B2T6cV0LRGuvdegCzEjz68lGlb4wsPCpIxxYXoBKHg8cNfdU6uLnTIx7ZmXBEqEYr6410m49vHapigvpURNXba8hv6t8te/2I2O6xldMEHnS1lpT89Yy82u5wG59Ya8IZbvmf4Jl+ko5jghb8Ct108vls1UkeZjOKV4i5USfJbitV7wAMTAQxQ2rabXUCDjtC8HobQvsJ5LYmaaQFl9VtFA8D0aPxANTsLdvg9ONCj9uyyoM4TsB1H0Ye3+YF1DZ6WfkGygdfEfPg2BfST1D2HXohiAfDPUYda5oZ8ygMLSpUAHtNx+8YUvjgnaCRzMHZVnkJtMBa3Tcyg4xC12WI9yUSasTU6qjfps+6Hil+PY7Zd8a5hXCYCYx8d6YvxwDR2YDtptlhRP4O5Z/HDn/+RCuz916r9decbnG9uQayiQX/O4YLZXe6UHk47wr3BUs6Wb8hDkQORpDqRsAOvWbKFP+wUI/H+kYfv1H0SQ+uYaV6eUbEGEq3yU3QyMrw27vM/LuTsk4/bkY9RlreGMfzobRM5AO3rK1EDe4UQwsgQePSimKa+orGd3A/YbBnyo3jjAOdHqMQ8MU6aEE4prT4BltFTceOEE0+vtYeKVfqnoqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(55016003)(6506007)(86362001)(2906002)(9686003)(8936002)(122000001)(508600001)(38100700002)(38070700005)(52536014)(71200400001)(5660300002)(7696005)(85182001)(76116006)(83380400001)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(8676002)(33656002)(91956017)(316002)(186003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UTBlRHVMZFFxaFhwdjN6YzltaTY4V2lxWUlwZEZTVGVZRlQ4MGtVNERkN2s4?=
 =?gb2312?B?akRSTTFhK0pTSFZRVHV2UnR5aXpUTDF4aURmUDNiY1hmaDFrb0p4RklkbmdE?=
 =?gb2312?B?d0hpUGZWdVh3U2dWaDBrUGtnd2tNRXNoaE0rSHlIak10SW1Ec01mZTlRdmZH?=
 =?gb2312?B?RXpyYmR1SkhFalkyRzIwR2dkTHc0QTU0d01XOWJ1YnM2MGpqczJncjJoc0hR?=
 =?gb2312?B?a2FnSDNqcS9jRGlyRFBXM3lWZi9ZSThFVHlHc2YvNlYzMnNoSURVYXZFUllS?=
 =?gb2312?B?ZjBSQllFazRmNHpndndLOVJYOEh0Q3VOZnl6NnZ3dzVrd2xOb2VNdmVZVG9F?=
 =?gb2312?B?Q1k2dVNPT0lUUGkraUpucFF6dVk2QXArMHZ2OFFKaGpCeDhNYURrSXpkamZ2?=
 =?gb2312?B?RDVtT2F1Q2tCK2JhTDZTZkZSRnBpTzJlS3B4Zk9IZnBBT2lwd3hpQndsMFVQ?=
 =?gb2312?B?RWxzRUw5UDJrL3NvYm5zWU1ocG5YZU4rbUdVT3JDUlczMEY4ZXBNMDhuV2do?=
 =?gb2312?B?c1l6Qm1Ybm5acmhjYUE3S0tzbzJYYXFHQ05SNDErdDduallNM3JwbU9WU09B?=
 =?gb2312?B?Tm1sL1ltd0FkZWZLYURmNnU1UVZ0M0xWa0NzeU9CVXJ0VnlnTlZpZng4cHQ0?=
 =?gb2312?B?UHJCN09LZXpGNjhVdUJXdDRCM2QyQmJlb2lHN2NPNzMyNHgvNm80WFQ1TjYv?=
 =?gb2312?B?Wms1MUdKc2VJclgzQ1BSOGdFSE1neTVDWGtQRlB3em13ajBXVUF0QUhINis3?=
 =?gb2312?B?ek0xdHloeVcxNWR6MW1ia1Z6UkZLOXpGQ2o5ekRqb1FYUVhjU3JUMXJjNnE0?=
 =?gb2312?B?d2h4WFZHZnI4cnl4M21ZMUxRSnQ5V3I0MXNYS0ZrMGxJaDJLeExFYXNxd0xI?=
 =?gb2312?B?eUc0UTR6UUZXQlRjRjVla2dOSDlLMllwMzd2WDJ5aW0yYVE2U1dCSXYwMEZp?=
 =?gb2312?B?dmYxYzByY0tPa1ZnZ3NRZlMvWk9tWU9GaC9ZOGhsOG4wYUhaaHlHZTNsb1JM?=
 =?gb2312?B?UjhQQ1pJanhaYmR1Y1VlMTE4c3VLREpiUDFBcTlqTHd2WnNrWXpiSVdwSWRP?=
 =?gb2312?B?S3VKbGJ6TUdrQ3grYnhUaFN6RUViUVNpaWluak9MT3N1M0NyMXJabGQwMXZv?=
 =?gb2312?B?QnkvQkNSaHo5c3lHTkY0S3NNQ3hvQzZQQ1NQdStuNGdnRHdKS1NGdTVmalY1?=
 =?gb2312?B?Y2ZxRDlCc3JNRlREK0VyVGhxU0FQMTJjL29KWmZxbU9wUmE4WFJVYWNHdStL?=
 =?gb2312?B?YmdXcVd6SnNMT0lJVkM3VGJ0Qy9OSTJPcmhLdW1EVDNFWjBoWm5VL09jQUo3?=
 =?gb2312?B?QXdJKytaMElqblR3TjlZZGpsYUx1RVNpMmgvR1lOdnNzNFh6cmV3NWxRWHJO?=
 =?gb2312?B?NVhXaFRWUHJMeDFTU0haZWt0RitFQkRKZWlvTDVMRktFeGRXZVNqRkRKSXor?=
 =?gb2312?B?SGEzU292bS9ZaDhWc1kzeEpsWU5vdDI3SXh3cGoyM1ViWkY4MjZJdEVFdU1K?=
 =?gb2312?B?OC9FL1YvWXRBdlpwQkdrUkt1d2YwemJ1VXR2Z1dUSE1QS2pqTXppZndBaHN0?=
 =?gb2312?B?Yy9QTjZrYTBXWVgxL21uNXNneTdwbEIvTU5XQ0Q1Znk4ckdLd0xqR1VkWThQ?=
 =?gb2312?B?elJ0cUxleFdjS3JFWFk2V3pKRUJYRXNGb21UbHlXOUIyNmE4YnhOYjY0NUJ5?=
 =?gb2312?B?U3ZaM1JldW04U3Nycy92dFVoZXZVNjdRbTJsbGtWSkNrY1d4OVVFc2p2VTJt?=
 =?gb2312?B?cURBTVI4MENOckQzdVBwN05xYlAyaHlvTEZhakhHS2Y2Rm1md2ZlV3VKK1h3?=
 =?gb2312?B?Z0U5NXNtc1RLd2t4Z214cUlJOGZqSE56T3R0b2lqN0VlZ1h6VmVhc285cDRl?=
 =?gb2312?B?WkgyWm56RzNiNEVleHVzaDFuaUxRUEVjQzBTSUM1U3k1eDBmeVArd05ZVE5Q?=
 =?gb2312?B?TlFZVlhKVmtncVR0ZXZ2dWNncUdEbEs3NFpGVkkxQWZ2cGZ5UHAraFhRQmtn?=
 =?gb2312?B?MmZib0JGSGJUemVIVW9tTGlzLzAzL0hHSmVtSHpqZEJIYkQ5MTVySXBJSXNN?=
 =?gb2312?B?aEtCclQzak1SQ3oyTktpWjVURVZlUE5DS3crTUJ0NHczcnhXckdOV1NlbHc1?=
 =?gb2312?B?TGszUzNUV0lnbFZ1U0pnWlJ5RkZLRitQSWVSWG04eldlZDNOSGxqQ29ZNW5N?=
 =?gb2312?B?d2Yxd3d5UEZFbklIejNmT0o0Slc5SkNFVzNzbmRwL3dWdzNqVzJRTWoxTVJj?=
 =?gb2312?B?YlVsQ29aaHI3VnZEMHpQUFhKcm1XYlA1MjBoSU1zZ0w5anRSSG1xWnMzam9O?=
 =?gb2312?Q?SZspOTx4rZpFD0HN0C?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3467611-29ff-4858-8386-08da28aa9c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 00:04:06.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GgmxyVbvfHg71G4rM0+DVoYAg4ssP4xVZ3/XB7NWjAzKKXc9hXqgSNs1e3VPJUZuW03Ya6USxHQttMy2MEl1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+Pj4+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA2OjUyOjM0QU0gKzAwMDAsIM31x+Yg
d3JvdGU6Cj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5j
b20+Cj4KPlsuLi5dCj4KPj4+ICAgICAgLi0tLS0tLS0tLS0tLS0tLS4KPj4+IENQVSAgIHwwIDEg
MiAzIDQgNSA2IDd8Cj4+PiAgICAgICstLS0tLS0tLS0tLS0tLS0rCj4+PiB1YXJjaCB8bCBsIGwg
bCBtIG0gbSBifCAoc28gY2FsbGVkIHRyaS1nZWFyOiBsaXR0bGUsIG1lZGl1bSwgYmlnKQo+Pj4g
ICAgICArLS0tLS0tLS0tLS0tLS0tKwo+Pj4gIEwyICB8ICAgfCAgIHwgfCB8IHwgfAo+Pj4gICAg
ICArLS0tLS0tLS0tLS0tLS0tKwo+Pj4gIEwzICB8PC0tICAgICAgICAgLS0+fAo+Pj4gICAgICAr
LS0tLS0tLS0tLS0tLS0tKwo+Pj4gICAgICB8PC0tIGNsdXN0ZXIgLS0+fAo+Pj4gICAgICArLS0t
LS0tLS0tLS0tLS0tKwo+Pj4gICAgICB8PC0tICAgRFNVICAgLS0+fAo+Pj4gICAgICAnLS0tLS0t
LS0tLS0tLS0tJwo+Pj4KPj4+IChhbmQgSSdtIG5vdCBzYXlpbmcgaGVyZSBpdCBkb2VzISkgdGhl
biB0aGUgZXhpc3RpbmcgU0NIRURfQ0xVU1RFUgo+Pj4gc2hvdWxkIGJlIHVzZWQgaW4gRFQgYXMg
d2VsbC4gU2luY2UgaXQgcHJvdmlkZXMgZXhhY3RseSB0aGUgc2FtZQo+Pj4gZnVuY3Rpb25hbGl0
eSBmb3IgdGhlIHRhc2sgc2NoZWR1bGVyIG5vIG1hdHRlciB3aGV0aGVyIGl0J3Mgc2V0dXAgZnJv
bQo+Pj4gQUNQSSBvciBEVC4KPj4+Cj4+PiBwYXJzZV9jbHVzdGVyKCkgLT4gcGFyc2VfY29yZSgp
IHNob3VsZCBiZSBjaGFuZ2VkIHRvIGJlIGFibGUgdG8gZGVjb2RlCj4+PiBib3RoIGlkJ3MgKHBh
Y2thZ2VfaWQgYW5kIGNsdXN0ZXJfaWQpIGluIHRoaXMgY2FzZS4KPj4gCj4+IFRvdGFsbHkgYWdy
ZWUsIGJ1dCBub3QgaW1wbGVtZW50ZWQgeWV0LiBCZWNhdXNlIG5vdyBjbHVzdGVyX2lkIGlzIHVz
ZWQKPj4gdG8gZGVzY3JpYmUgdGhlIHBhY2thZ2Uvc29ja2V0LCB0aGUgbW9kaWZpY2F0aW9uIHdp
bGwgaW52b2x2ZSBhbGwgRFRTLgo+Cj5Zb3UncmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0
IDEuIGxldmVsIGNsdXN0ZXJYICgxKSBpbiBjcHVfbWFwIGlzCj51c2VkIHRvIHNldCBgY3B1X3Rv
cG9sb2d5W2NwdV0ucGFja2FnZV9pZGAsIHJpZ2h0PyBUaGF0J3MgdGhlCj5pbmZvcm1hdGlvbiBm
b3IgdGhlIERJRSBsYXllci4KPlRoZSBmaXJzdCBsZXZlbCBjbHVzdGVyWzAsMSwyXSBzcGF3biBh
bGwgOCBDUFVzIGFuZCBmb3JtIDMgZ3JvdXBzIG9mCj5DUFVTICgwLTMsIDQtNiwgNyksIHRoZSBs
YXRlciBzY2hlZCBncm91cHMgb2YgdGhlIERJRSBzY2hlZCBkb21haW4uCj5XZSBkb24ndCBoYXZl
IGFueSBzb2NrZXROIHNpbmNlIGl0IGlzIGEgc2luZ2xlIHNvY2tldCBzeXN0ZW0uIFRoaW5rCj5h
Ym91dCBhIHN5c3RlbSB3aXRoIDIgRFNVcyB3aGVyZSB5b3Ugd291bGQgaGF2ZSBzb2NrZXRbMCwx
XS4KPgo+U3ViLWNoYXB0ZXIgNCBpbiBgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2NwdS9jcHUtdG9wb2xvZ3kudHh0YDoKPgo+Y3B1LW1hcCB7Cj4gICAgICAgIHNvY2tldDAgewo+
ICAgICAgICAgICAgICAgIGNsdXN0ZXIwIHsgPC0tLSAoMSkKPgo+U3ViLWNoYXB0ZXIgMyBzYXlz
Ogo+Cj4gIC0gY2x1c3RlciBub2RlCj4KPiAgICAuLi4gQSBzeXN0ZW0gY2FuIGNvbnRhaW4gc2V2
ZXJhbCBsYXllcnMgb2YgY2x1c3RlcmluZyB3aXRoaW4gYSAgIAo+ICAgIHNpbmdsZSBwaHlzaWNh
bCBzb2NrZXQgYW5kIGNsdXN0ZXIgbm9kZXMgY2FuIGJlIGNvbnRhaW5lZCBpbiBwYXJlbnQgCj4g
ICAgY2x1c3RlciBub2Rlcy4KPgo+ICAgIEEgY2x1c3RlciBub2RlJ3MgY2hpbGQgbm9kZXMgbXVz
dCBiZToKPiAgICAgIG9uZSBvciBtb3JlIGNsdXN0ZXIgbm9kZXMKPgo+VGhpcyBtdWx0aS1sZXZl
bCBjbHVzdGVyIHRoaW5nIGhhc24ndCBiZWVuIGNvZGVkIHlldC4KPgo+cGFyc2VfY2x1c3Rlcigp
Cj4KPiAgICAuLi4KPiAgICAvKgo+ICAgICAqIEZpcnN0IGNoZWNrIGZvciBjaGlsZCBjbHVzdGVy
czsgd2UgY3VycmVudGx5IGlnbm9yZSBhbnkKPiAgICAgKiBpbmZvcm1hdGlvbiBhYm91dCB0aGUg
bmVzdGluZyBvZiBjbHVzdGVycyBhbmQgcHJlc2VudCB0aGUKPiAgICAgKiBzY2hlZHVsZXIgd2l0
aCBhIGZsYXQgbGlzdCBvZiB0aGVtLgo+ICAgICAqLwo+ICAgIC4uLgo+Cj5bLi4uXQo+Cj4+PiBJ
IHBpbXBlZCBteSBIaWtleSA5NjAgdG8gbG9vayBsaWtlIG9uZSBvZiB0aG9zZSBBcm12OSA0LTMt
MSBzeXN0ZW1zIHdpdGgKPj4+IEwyLWNvbXBsZXhlcyBvbiB0aGUgTElUVExFUyBhbmQgSSBnZXQ6
Cj4+IAo+PiBUaGlzIHN5c3RlbSBpcyBleGFjdGx5IHdoYXQgSSBtZW50aW9uZWQsIGJ1dCBJIGhh
dmUgYSBxdWVzdGlvbiwKPj4gSG93IGRpZCB5b3UgcGFyc2Ugb3V0IHRoZSBjbHVzdGVyX2lkIGJh
c2VkIG9uIGZvbzAvZm9vMj8KPj4gQmVjYXVzZSBpZiBBQ1BJIGlzIG5vdCB1c2VkLCBjbHVzdGVy
X2lkIGlzIGFsd2F5cyAtMS4KPgo+SSBoYXZlbid0IHB1dCBpbiB0aGUgZXh0ZW5zaW9uIHRvIGRl
Y29kZSBhIDItbGV2ZWwgY2x1c3RlclggY3B1X21hcCBpbgo+cGFyc2VfY2x1c3RlcigpIC0+IHBh
cnNlX2NvcmUoKS4gSSBqdXN0IGRpZCBhIG1vY2stdXAgZm9yIGlsbHVzdHJhdGlvbgo+cHVycG9z
ZSBpbnNpZGUgcGFyc2VfY29yZSgpIGZvciBteSBIOTYwIHdpdGggYSA0LTMtMSBjcHUtbWFwOgo+
Cj5jcHUtbWFwCj4gICAgY2x1c3RlcjAKPiAgICAgICAgY29yZTAKPiAgICAgICAgY29yZTEKPiAg
ICAgICAgY29yZTIKPiAgICAgICAgY29yZTMKPiAgICBjbHVzdGVyMQo+ICAgICAgICBjb3JlMAo+
ICAgICAgICBjb3JlMQo+ICAgICAgICBjb3JlMgo+ICAgIGNsdXN0ZXIyCj4gICAgICAgIGNvcmUw
Cj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIGIvZHJpdmVycy9i
YXNlL2FyY2hfdG9wb2xvZ3kuYwo+aW5kZXggMWQ2NjM2ZWJhYWM1Li44YWY0MGYxM2ZkYjUgMTAw
NjQ0Cj4tLS0gYS9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jCj4rKysgYi9kcml2ZXJzL2Jh
c2UvYXJjaF90b3BvbG9neS5jCj5AQCAtNTI5LDYgKzUyOSwxMSBAQCBzdGF0aWMgaW50IF9faW5p
dCBwYXJzZV9jb3JlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqY29yZSwgaW50IHBhY2thZ2VfaWQsCj4g
Cj4gICAgICAgICAgICAgICAgY3B1X3RvcG9sb2d5W2NwdV0ucGFja2FnZV9pZCA9IHBhY2thZ2Vf
aWQ7Cj4gICAgICAgICAgICAgICAgY3B1X3RvcG9sb2d5W2NwdV0uY29yZV9pZCA9IGNvcmVfaWQ7
Cj4rCj4rICAgICAgICAgICAgICAgLyogbW9jay11cCBDTFMgU0Qgb24gNC0zLTEgQXJtdjkgRFNV
IGNsdXN0ZXIgdy8gTDItY29tcGxleGVzICovCj4rICAgICAgICAgICAgICAgaWYgKGNwdSA8PSAz
KQo+KyAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvcG9sb2d5W2NwdV0uY2x1c3Rlcl9pZCA9
IGNwdSAvIDI7Cj4rCj4gICAgICAgIH0gZWxzZSBpZiAobGVhZiAmJiBjcHUgIT0gLUVOT0RFVikg
ewo+ICAgICAgICAgICAgICAgIHByX2VycigiJXBPRjogQ2FuJ3QgZ2V0IENQVSBmb3IgbGVhZiBj
b3JlXG4iLCBjb3JlKTsKPiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPgo+QW5kIG9u
IHRoZSBzY2hlZHVsZXItc2lkZSBJIG9ubHkgaGFkIHRvIGVuYWJsZSBDT05GSUdfU0NIRURfQ0xV
U1RFUiBhbmQKPmV2ZXJ5dGhpbmcgd29ya2VkIGp1c3QgZmluZSwgbm8gbmVlZCBmb3IgYW55IGFy
bTY0LXNwZWNpZmljIHRvcG8gdGFibGUKPmFuZCBhbGlrZS4KPgo+SU1ITywgdGhpcyBpcyB3aGF0
IHlvdSBoYXZlIHRvIGRvLiBNYWtlIGEgMiBsZXZlbCBjbHVzdGVyIGNwdW1hcDoKPgo+Y3B1LW1h
cAo+ICAgIGNsdXN0ZXIwCj4gICAgICAgIGNsdXN0ZXIwCj4gICAgICAgICAgICBjb3JlMAo+ICAg
ICAgICAgICAgY29yZTEKPiAgICAgICAgY2x1c3RlcjEKPiAgICAgICAgICAgIGNvcmUyCj4gICAg
ICAgICAgICBjb3JlMwo+ICAgIGNsdXN0ZXIxCj4gICAgICAgIGNvcmUwCj4gICAgICAgIGNvcmUx
Cj4gICAgICAgIGNvcmUyCj4gICAgY2x1c3RlcjIKPiAgICAgICAgY29yZTAKPgo+cGFyc2UtYWJs
ZSBhbmQgc2V0IGBjcHVfdG9wb2xvZ3lbY3B1XS5jbHVzdGVyX2lkYCBpbiBwYXJzZV9jb3JlKCku
CgpPaCwgdGhlcmUgYXJlIG1hbnkgd2F5cyBJIGNhbiBpbXBsZW1lbnQgaXQgaW4gbXkgb3duIHN5
c3RlbSwgYnV0IG15CnB1cnBvc2UgaGVyZSBpcyB0byBtb2RpZnkgdGhlIG1haW5saW5lIGNvZGUg
c28gdGhhdCBhbGwgQW5kcm9pZApkZXZlbG9wZXJzIGNhbiB1c2UgaXQuCgo+IAo+PiBXaGF0IEkg
d2FudCB0byBkbyBpcyB0byBjaGFuZ2UgdGhlIGZvbzAvZm9vMiB0byBjb21wbGV4MC9jb21wbGV4
MiBoZXJlLAo+PiB0aGVuIHBhcnNlIGl0IGxpa2UgcGFyc2VfY2x1c3RlcigpIC0+IHBhcnNlX2Nv
bXBsZXgoKSAtPiBwYXJzZV9jb3JlKCkuCj4KPllvdSBzaG91bGQgcmVhZCBgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdS9jcHUtdG9wb2xvZ3kudHh0YAo+YW5kIGltcGxlbWVu
dCB0aGUgbXVsdGktbGV2ZWwgY2x1c3RlciBhcHByb2FjaCBpbnN0ZWFkLiBCaWcgYWR2YW50YWdl
Cj53b3VsZCBiZSB0aGF0IHRoZXJlIHdvbid0IGJlIGFueSBEVCByZWxhdGVkIGNoYW5nZXMvZXh0
ZW5zaW9ucyBuZWVkZWQuCj4KClRoYW5rcyBmb3IgdGhlIGFkdmljZSwgSSB3aWxsIGNvbnNpZGVy
IGFib3V0IGl0LgpRaW5nCgo+Wy4uLl0KPgo+PiBZZXMsIHRoYXQncyB3aGF0IEkgd2FudCwgYnV0
IHN0aWxsIGEgbGl0dGxlIGNvbmZ1c2VkLCB3aHkgd2UgdXNlIE1DIHRvCj4+IGRlc2NyaWJlICJj
bHVzdGVyIiBhbmQgdXNlIENMUyBkZXNjcmliZSAiY29tcGxleCIsIGNhbiB5b3Ugc2hvdyBzb21l
IGRldGFpbHM/Cj4KPlRoZSBEVCBlbnRpdHkgYGNsdXN0ZXJgIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGggdGhlIHRhc2sgc2NoZWR1bGVyIGRvbWFpbgo+bmFtZSBgU0NIRURfQ0xVU1RFUmAuIFRoZSBu
YW1lIGlzIGFjdHVhbGx5IG1lYW5pbmdsZXNzIGFuZCBqdXN0IHRoZXJlIGZvcgo+ZGVidWcgcHVy
cG9zZXMu
