Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCC4DA88B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbiCPCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiCPCr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:47:27 -0400
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300137.outbound.protection.outlook.com [40.107.130.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E894617B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5yw7aNRSylCiA6DpPZRfF37PnQb2DAN9NGKnKG1mqc98CkqolGvRXySGZTMA5bclAKZ7+7PxkdwRmaOkzC6GwChsDkhDN4oeZds+CUBSw/n2NLUBK+iz73AaL4rqNlJBtJUX68ZJOMSQndIqBeg5jmzHJMfDJYz29OnwLqWIVagBzAVCrVyusA+wSNRKQrU7eMNsF2BUslxQgO51arAGSs0i6Y5+dfTCgcXx4aM9wK8fIt9u0MeJEPfNBlm8WVV6G+FnG8as3gdnQ0vPymfe0RfJutHEcEWx1zzd8ZaUcASSEAXp7K33cz+uPsGXy7IEUpIjTQScOaA3fP2dXRWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKkNbfnOyg3FhfqFf/NQB8AWtL77a+lwmLQWJWJzUZ4=;
 b=i+Ir7xODEN2FNs+QEWgfNGLcU3i9FUjKZ+Zl1UEyepWbVAQ4iU39ZTmbwfJOt8FSkV+4KhgY7FQuKDHZx6WOV7vrS95+2DxX1yPqACOOAzXKQG6PGnkSLYKk9AdgccvTdrxSY5N2Oe6Rq7InGz0i2iLERIky7bYgdCRjpjdWQL8KyfsvGSMUGN5Pg8bfx0xmyT6jvd/6X3lb49CregyQbAic1aX+HTzoIqdlOAq9Rl//9IDJDRxFzQuP2aM9Jta9kl5pJo1z2WGz0gcLwiKWQLZGbZVdhZbUagXJZ/ziG6pS7gUdW0zwpX2ag3hq1delENzbt7+MyPaLT46hW4wAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKkNbfnOyg3FhfqFf/NQB8AWtL77a+lwmLQWJWJzUZ4=;
 b=Mmy8EB2y6qBK5SW68hhZ2i6FRM5Z9DhrenRFKY18j+w/cHp7TJ1qu0RmW2ug9B+GniNv9aEEUTsrjHQw/1ZE72wu79B8WzHl89XQDUvlJqCh0csZ/tT3tbZ7YnDQKizdCNDpFshCncB4U5pPlM4paFKh5WPkZYRkC/sdJF6+x6w=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PU1PR06MB2405.apcprd06.prod.outlook.com (2603:1096:803:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 02:46:08 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 02:46:07 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH] sched: dynamic config sd_flags if described in DT
Thread-Topic: [PATCH] sched: dynamic config sd_flags if described in DT
Thread-Index: AQHYOEKbopUZOeviIUquO7ORmgh/j6zAsP6AgACNF0w=
Date:   Wed, 16 Mar 2022 02:46:06 +0000
Message-ID: <SL2PR06MB3082DBB58303601F73FB77D3BD119@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
 <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
In-Reply-To: <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 430b6062-2583-2789-d5fd-84283918e278
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1796665a-4a20-4161-2ede-08da06f71f5d
x-ms-traffictypediagnostic: PU1PR06MB2405:EE_
x-microsoft-antispam-prvs: <PU1PR06MB2405997404BF49944932CE8FBD119@PU1PR06MB2405.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvkLHkySdtWvb7lZKjyeOYzh3+LtUmsGX/RZL9WoskOw8GUfYHqibDph6HBMHgA6L1XHnSykeuK5B9wpboFpHMrR3EdafH8rqZrPfWSfAnDBZqqIR2WKrdvDvUfLVBg8K2Fge7f93drZQv76AnrAfAIhWtUYUEiGs6Qf4WKrmQgELEvQEbzrUxoKr8NYzuqPV4DmnaXTeM/tvZSMlu8sY+aPnar+BkwEJp9KNGiqWtVDS5VkkQNZwugPg5fqNwMQPZLYtQkTV3GLgg/qVktxLSG1fR9TipNOIzwxo+UpkIvTtXpkPV0gXKaQG3nvQeN/yiGaLfzQoAf8483BSWaTqjEAHbKzKcCoWdJoyq6w3iZ8SuyHzlCkBcMn11RNXPvdLVGpArTr/2bFdwaOJq2crvjKe95hGYt101Q/xoGhyL9uEzNTflXnBTNywLcOUfi5WocTP6lErJWDZg4IWTiy9KRbVW2v0lvU8kAnHcNHStuxMMn7i32ziejdKeKR0QjRyjI5+6cXUhaSqwslWFCMhSvK7RfLAmSyUlOaN0FNS0qfCEppSRrRpe0FguhCMCJSrqZB0CPpbB4/4mpNvZGmvchZC9SN2jYvM/LGrWpe82QnzGd37b5H8frrm3R4qMHiJe8xQxZccLkpZassnZzDcMEKG+R5NA+U+w4Z+llN6fEN3cNhdJ9xm3Bd7a9/jePoG+8V63Zkn4HBQsPXgWy9V/w4qPtxW0MN6XsauLQOnWDV8H0n4HfaxsvNk9fyt/rCA6BCST0Bk2tYjXdFWAeDstsvBvmwe731KLWA3LoXks6Iv+hx+hFgwDlGVAqbeVvZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(66946007)(64756008)(45080400002)(38070700005)(66556008)(91956017)(76116006)(6506007)(66446008)(7696005)(66476007)(9686003)(86362001)(110136005)(508600001)(316002)(26005)(186003)(38100700002)(83380400001)(921005)(7416002)(122000001)(33656002)(8936002)(5660300002)(52536014)(55016003)(85182001)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?LzN6aFljaWZnYzc3WVRMZDYya1ZicEJVN0YvRjZCYlRSTkV2d3JCNjRyYk1R?=
 =?gb2312?B?U05OZXdFZVZSRUd6YWFtSGVnWkJqQnlzMWM2ek5tUjRHZUVyMUQ2YmcrekF2?=
 =?gb2312?B?WUNDTEVoZ2ZkMzg5bVJSWHJLczhpa3VUcURXYW8vU0Yvb1pPTlc0WVVDcGNn?=
 =?gb2312?B?UzR0TUoyYUVlSlgvOVhHK0hzM0N2MWRIQ2sxalpkeTlXSTRFNHN5WDNZbjZq?=
 =?gb2312?B?clBLUmR2S20rWEVScmtmS1h1K21ZK3dTd2p2TzZreWZwelp1SUFxVW94ZEs3?=
 =?gb2312?B?dW9JczJWK2ZUbnFlMjJLL3JyZDdEOThqZE5hRldLS0pqQ0xEUDdPMzR3Znkz?=
 =?gb2312?B?MW1UQkMzV1NPeFlnL3Y2UWo4azArenNrWDhXM3Nvck92K05QU09jQXlQMnhL?=
 =?gb2312?B?aG1xNW5iUnJnbjNtWFRPRzN5aUhpTlRzNk85T1Z4Q2hzMkRrbmR5RGp3b3BU?=
 =?gb2312?B?UUYxRlJ5Rm1qZDJ4Q25BYzF3UXJXVXZrdzFnVVQ0Tlp6RDV6Y1h2azFiSW9I?=
 =?gb2312?B?NzF3WUZIVnJFd0RLRkhkUVlVWFZyOFRKaTlpeHlIUkNETXRKK0NSOGdSbldq?=
 =?gb2312?B?VFJ6bnpIQkp0V3pkejdqSnpBMmtsWXRlc2Z5Q3FtVTdrM2h4UkM1UWtGUnpj?=
 =?gb2312?B?Q1lXTVhndU9Kdm8vdWFMelg4TFhqYzhhTCtVRTdiYS9SUVl1cXl2d1Y5SmtG?=
 =?gb2312?B?LzN0Z1NVQmJST1lDaFBBWDFyMjlJWm56NnMrS1FVNHIxK3J0OW1vRmYzMThx?=
 =?gb2312?B?TzloTktZVVF4cG1xa01EM3oxZVhpMjFDMnBrcG5WK0hWOHVvTk9Xd1RGUEtp?=
 =?gb2312?B?UUgrU2dLMWNkYU5yb29tYmltOHJuZEg2WUN5VllxclVXWWpmTEY0c3A1ajAr?=
 =?gb2312?B?dVB6eEZySWJiL1V0bG9KY0xYZFBuRWFkSjdZd3Noa1JoZFE4Tm1yVGJWVXpG?=
 =?gb2312?B?cjczcVE1NjU0SDY2a25uZUJ6NENtZjJPdW5iN1IvQnp0dUpPWDZ1MHFicVRm?=
 =?gb2312?B?QW8rUjNGeVBnYmVTUkkvZ1ptWUlFY0Ywc0hsb2xPeTZkTlBoQ3FiUjQ3NWdi?=
 =?gb2312?B?YlVmZnVzNVVEQnAwZTk2ajRRejFUNExKbW1DRVJVSWFOblRwS3RNNDlUOUpj?=
 =?gb2312?B?aVF4NHJSWm1abXBYb2g2bWlGVlRTWFlrS3VlTTJwZXhBR3pJOU5RSFAzOG9m?=
 =?gb2312?B?Si8vRFh1bzlVR21JV25IOTF0V2NLNU5BWHN3bWUxU29FUXg4cWJvSGNBQmpx?=
 =?gb2312?B?ZmZBOFNqaUN5NGxRRXpsYkxnZ1ZaOHY3MXhJTGkvV2JzN1Z6MTNpbzFSdnFo?=
 =?gb2312?B?YVRWVWVqNSt0citpOEtHMHVMTFJVcC96WW9ORm5rY05aMXcvR1gzSm9BcjB1?=
 =?gb2312?B?bzI1MVBqM09QRHdEb1YxSU9oaEs5WWl6OFVDeUVIc0kzM2ozQXlZdUw0N0ZF?=
 =?gb2312?B?TXVvcDZaWUNOdXR6QUNsc200Z0d3OEhJRmNXUk4rNlhEenF1L3JWcDJIZVph?=
 =?gb2312?B?S3VIMjdsSzlqQVZ3VndwTUovaDBYa2JWSDZqbnZNeHkvOFBtK2JVaHdrS2Vl?=
 =?gb2312?B?bnNnTkZBSlFsOHJoR1pqNU5QdmN1dnR1STBmSTQ3VDBsNHRxVnNid0V4Vzdp?=
 =?gb2312?B?c1lSb21XcXNScUNxWDJlVUZoWTJUaHBOcDluQnNiTmVidXh3VXNvT0x6RW1t?=
 =?gb2312?B?NjlqckFrQ2tXdHBkMG9Ic0s0dzYvLzc5YjN5eXk5Ti9XaUptaHVUaUpySk9o?=
 =?gb2312?B?em9zOGlPR0FoaWl4eDdMMzF6SnBBSXc0cGtqMStZOHB6UkZhWFc0aysvdTJP?=
 =?gb2312?B?UXJRUnk3MUd5TUkwb0VDclgydjlSdjhGanBEQWtTUGd1L0lPNUZXT3VrSjVO?=
 =?gb2312?B?NGZVdEZKZzBtVm5KU0FSTkhsMTFjQkxERVlnU2t1SDArZDNSa2VNZEZSeHB6?=
 =?gb2312?Q?/u6TQW/VhLs=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1796665a-4a20-4161-2ede-08da06f71f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 02:46:06.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9gp6zu1fAYylmHXONFmAWH1t27g9bstDMwNpGkHh5tv1iS8YWNiys7WtNnM0vqD/1GaX6KMw5Fd8W1MZoFQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2405
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4oMSkgQ2FuIHlvdSBzaGFyZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHlvdXIgQ1BVIHRvcG9s
b2d5Pwo+Cj5JIGd1ZXNzIGl0IGlzIGEgc2luZ2xlIERTVSAoRHluYW1JUSBTaGFyZWQgVW5pdCkg
QVJNdjkgc3lzdGVtIHdpdGggOAo+Q1BVcz8gU28gTDMgc3BhbnMgb3ZlciBbQ1BVMC4uQ1BVN10u
Cj4KPllvdSBhbHNvIG1lbnRpb25lZCBjb21wbGV4ZXMuIEFtIEkgcmlnaHQgaW4gYXNzdW1pbmcg
dGhhdCBbQ1BVMC4uQ1BVM10KPmFyZSBDb3J0ZXgtQTUxMCBjb3JlcyB3aGVyZSBlYWNoIDIgQ1BV
cyBzaGFyZSBhIGNvbXBsZXg/Cj4KPldoYXQga2luZCBvZiB1YXJjaCBhcmUgdGhlIENQVXMgaW4g
W0NQVTQuLkNQVTddPyBBcmUgdGhleSBDb3J0ZXgtQTUxMCdzCj5hcyB3ZWxsPyBJJ20gbm90IHN1
cmUgYWZ0ZXIgcmVhZGluZyB5b3VyIGVtYWlsOgoKWWVzLCBBbmRyb2lkIHN5c3RlbXMgYXJlIGN1
cnJlbnRseSB1c2VkIGRlZmF1bHRfZG9tYWluIHdpdGggd3Jvbmcgc2RfZmxhZ3MsIAp0YWtlIFF1
YWxjb21tIFNNODQ1MCBhcyBhbiBleGFtcGxlLCB0aGUgQ1BVIGFuZCBjYWNoZSB0b3BvbG9neSgx
KzMrNCk6CnwgICAgICAgICAgICAgICAgICAgICAgICAgICBEU1UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfAp8ICAgICAgICAgICBjbHVzdGVyMCAgICAgICAgIHwgICAgICAgY2x1c3RlcjEg
ICAgIHxjbHVzdGVyMnwKfCBjb3JlMCAgY29yZTEgIGNvcmUyICBjb3JlMyB8ICBjb3JlNCBjb3Jl
NSBjb3JlNiB8IGNvcmU3ICB8CnwgICBjb21wbGV4MCAgfCAgIGNvbXBsZXgxICAgfCAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tICAgfAp8ICAgTDIgY2FjaGUgIHwgICBMMiBjYWNoZSAgIHwgICBM
MiAgfCAgTDIgfCAgTDIgIHwgICBMMiAgIHwKfCAgICAgICAgICAgICAgICAgICAgICAgICBMMyBj
YWNoZSAgICAgICAgICAgICAgICAgICAgICAgICB8CgpUaGUgc2NoZWQgZG9tYWluIG5vdzoKRElF
WzAtN10gIChubyBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQpNQ1swLTNdWzQtNl1bN10gKFNEX1NI
QVJFX1BLR19SRVNPVVJDRVMpCgpUaGUgc2NoZWQgZG9tYWluIHNob3VsZCBiZToKRElFWzAtN10g
IChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQpNQ1swLTNdWzQtNl1bN10gKG5vIFNEX1NIQVJFX1BL
R19SRVNPVVJDRVMpCipDTFNbMC0xXVsyLTNdKFNEX1NIQVJFX1BLR19SRVNPVVJDRVMpCgo+aHR0
cHM6Ly9sa21sLmtlcm5lbC5vcmcvci9TTDJQUjA2TUIzMDgyOENGOUZGMjg3OUFGQzlEQzUzRDJC
RDBDOUBTTDJQUjA2TUIzMDgyLmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20KPgo+WW91IG1pZ2h0
IHJ1biBpbnRvIHRoZSBpc3N1ZSB0aGF0IGluZGl2aWR1YWwgQ1BVcyBvZiB5b3VyIHN5c3RlbSBz
ZWUgYQo+ZGlmZmVyZW50IFNEIGhpZXJhcmNoeSBpbiBjYXNlIHRoYXQgW0NQVTQuLkNQVTddIGFy
ZW4ndCBDb3J0ZXgtQTUxMCdzLAo+aS5lLiBDUFVzIG5vdCBzaGFyaW5nIGNvbXBsZXhlcy4KPgo+
KDIpIFJlbGF0ZWQgdG8geW91ciBNQyBTY2hlZCBEb21haW4gKFNEKSBsYXllcjoKPgo+SWYgeW91
IGhhdmUgYSBzaW5nbGUgRFNVIEFSTXY5IHN5c3RlbSwgdGhlbiBpbiBMaW51eCBrZXJuZWwgbWFp
bmxpbmUgeW91Cj5zaG91bGRuJ3QgaGF2ZSBzdWItY2x1c3RlcmluZyBvZiBbQ1BVMC4uQ1BVM10g
YW5kIFtDUFU0Li4uQ1BVN10uCj4KPkkuZS4gdGhlIGNwdS1tYXAgZW50cnkgaW4geW91ciBkdHMg
ZmlsZSBzaG91bGQgb25seSBsaXN0IGNvcmVzLCBub3QKPmNsdXN0ZXJzLgoKQnV0IGluIGZhY3Qg
d2Ugd2lsbCwgYXMgbWVudGlvbmVkIGFib3ZlLgo+Cj5JIGtub3cgdGhhdCBpbiBBbmRyb2lkIHRo
ZSBjbHVzdGVyIGVudHJpZXMgYXJlIHVzZWQgdG8gc3ViLWdyb3VwCj5kaWZmZXJlbnQgdWFyY2gg
Q1BVcyBpbiBhbiBhc3ltbWV0cmljIENQVSBjYXBhY2l0eSBzeXN0ZW0gKGEuay5hLiBBcm0KPkR5
bmFtSVEgYW5kIFBoYW50b20gZG9tYWlucykgYnV0IHRoaXMgaXMgZWNsaXBzaW5nIHRoZSB0cnVl
IEwzIChMTEMpCj5pbmZvcm1hdGlvbiBhbmQgaXMgbm90ICJzdXBwb3J0ZWQiIChpbiB0aGUgc2Vu
c2Ugb2YgInVzZWQiKSBpbiBtYWlubGluZS4KPgo+QnV0IEkgaGF2ZSBhIGhhcmQgdGltZSB0byBz
ZWUgd2hhdCBbQ1BVMC4uQ1BVM10gb3IgW0NQVTQuLkNQVTddIGFyZQo+c2hhcmVpbmcgaW4geW91
ciBzeXN0ZW0uCgpUaGV5IHNoYXJlIEwzIGNhY2hlLCBidXQgbm8gc2hhcmUgTDIgd2hpY2ggb25s
eSBzaGFyZWQgd2l0aGluIGNvbXBsZXguCj4KPigzKSBXaHkgZG8geW91IHdhbnQgdGhpcyBkaWZm
ZXJlbnQgU0QgaGllcmFyY2h5Pwo+Cj5JIGFzc3VtZSBpbiBtYWlubGluZSB5b3VyIHN5c3RlbSB3
aWxsIGhhdmUgYSBzaW5nbGUgU0Qgd2hpY2ggaXMgTUMgKHcvbwo+dGhlIFBoYW50b20gZG9tYWlu
IGFwcHJvYWNoIGZyb20gQW5kcm9pZCkuCj4KPllvdSBtZW50aW9uZWQgY3B1c19zaGFyZV9jYWNo
ZSgpLiBPciBpcyBpdCB0aGUgZXh0cmEgU0QgbGV2ZWwgd2hpY2gKPmNoYW5nZXMgdGhlIGJlaGF2
aW91ciBvZiBDRlMgbG9hZC1iYWxhbmNpbmc/IEknbSBqdXN0IHdvbmRlcmluZyBzaW5jZQo+RUFT
IHdvdWxkbid0IGJlIGFmZmVjdGVkIGhlcmUuIEknbSBzdXJlIEkgY2FuIHVuZGVyc3RhbmQgdGhp
cyBiZXR0ZXIKPm9uY2Ugd2Uga25vdyBtb3JlIGFib3V0IHlvdXIgQ1BVIHRvcG9sb2d5LgoKV2hh
dCBJIHdhbnQgdG8gZG8gaXMgOgoxLkNvbmZpZyB0aGUgcmlnaHQgc2RfbGxjIHRvIHNkLCBiZXR0
ZXIgdG8gZ2V0IGl0IGR5bmFtaWNhbGx5IGZyb20gRFQKMi5CZW5lZml0IGZyb20gdGhlIHNoYXJl
ZCBjYWNoZShMMikgb2YgdGhlIGNvbXBsZXgKaS5lLiB3aGVuIHdlIGxvb2sgZm9yIHNpYmxpbmcg
aWRsZSBDUFUsIHByaW9yIHNlbGVjdCB0aGUgTDIgc2hhcmVkIENQVShpbm5lciBjb21wbGV4KSBp
ZiBMMyBpcyBhbGwgc2hhcmVkLgoKVGhhbmtzLApXYW5n
