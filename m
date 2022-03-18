Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730544DD26C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiCRB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:29:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DB2BD96D;
        Thu, 17 Mar 2022 18:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS3O/N1njBz1HoISoYnZsdDqtNqN+PyZyncUr5wCsZbKAWLz8dFWXE3KT7HAxv0Xjv25buDG/ljpNpJtXHcqejUBMGFKUAPvrUn63zhDJ9yDgfwWTl+H9eVLLUjGb6FPzs6dhOG95GXYzCZgQXsX3mEo+vBWTG7j6JDJLXZyTerJq+Rvw2vFkWvt3C5FHUpHPHgB4a6sO+mnKKvv1hKPsKLC3CKGR4Wk8T496XshfTN/sAubhWeJjL1a31TA84FsMNBmrTS7S99zk3vSM2O91sBeZvHvYA+M/oy0yVWw1O4PfTQlaetKBHMthtV4uBA80qLs+JpHwM3RjELQ1K5ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoqRf2YY4UeD04z0uI8oJyCM+D9Gmo0Fn/WThsdyEOY=;
 b=CpNMHZvRGsXPRGbSZxMng+pbAeOBzIDs/Ya9BJ1SMs3PR3TBlMKFwgHHYWzJwCw7Lp9BJBSgRpnrBaF077TEGLcZ1n8n4Zj32BMGSaw+CowUzzqiV72WLSSS0m9Jbh6KTW9Y0zd+zjkDsQe5o2E1685N1Y44XeY4Y3DGmnqgLe+LmayPdmL0Gr51RGyoEdrAoWAL/gGq2+Tt+IV24WtIkwRk4yvZd+RKeL8xmorqgSDsiPGuj/8jEZS9mQ2THUhvYRBrQHLulVY+pmcMn7sObcAyAy6TjmkzvGiO5cvNN+jqeOKZk1lG1VQoN6wZ47ndricItCIlGvppIPCT+niAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoqRf2YY4UeD04z0uI8oJyCM+D9Gmo0Fn/WThsdyEOY=;
 b=brsX8qeoK71OsqeGq7tH7l37rTkiqsjHtbR93Aj+Vo1Uk4O6vKfGeftE03G1wNaCz+YfxFbIVzdbykqo5r7O+o5yATBcwb6pooR/5zPRs/S7EbFo6g0MF4H2Y1SgcnUjc6gQWl1oPKmcMa0l+02kZBzW/6mWIJa9QYyTS0VZOzQ=
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SI2PR06MB5162.apcprd06.prod.outlook.com (2603:1096:4:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Fri, 18 Mar
 2022 01:27:40 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::1168:21dd:36ff:be89]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::1168:21dd:36ff:be89%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 01:27:40 +0000
From:   =?gb2312?B?s6O37+mq?= <changfengnan@vivo.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the f2fs tree
Thread-Topic: linux-next: Fixes tag needs some work in the f2fs tree
Thread-Index: AQHYOkN/ijtmq0wX0Ey4mcp8Yha986zEWVHg
Date:   Fri, 18 Mar 2022 01:27:40 +0000
Message-ID: <KL1PR0601MB4003BBAF56FFA52CC10599AFBB139@KL1PR0601MB4003.apcprd06.prod.outlook.com>
References: <20220318081029.55bb053b@canb.auug.org.au>
In-Reply-To: <20220318081029.55bb053b@canb.auug.org.au>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2443196-24fb-48a2-ca34-08da087e7e7a
x-ms-traffictypediagnostic: SI2PR06MB5162:EE_
x-microsoft-antispam-prvs: <SI2PR06MB5162322431A3196BE2EE72A5BB139@SI2PR06MB5162.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2hmK8oxcTOcdJw4x3A5Ncozxyyt4M6znVhDWkW1in0yTHHCWKiJuMeOL4h4XLb7bQ4z+afejDj6Dop1VY5E9OCdZFi9mJfPNV5LUd6aqTpaZOvNgCAwQC8bAL4yVE/5OmvOESMWZnd8xWVYEVK0uzuzWyLHswwFCyIbfOBFkw5cLzAimpsnXTvlf6hCpnIlp19peSG04GQMdPuYxkeALAFarSoUPk1Hm3UkMIF5Q+6iM7oBpkW0dDh9GSu9YjnOz8NonKSE5zgtf7PavYYDvR73Jd4MIYjFZprruNoY9SoQ2dvOQqBEZ8K7HElqrWh1O7BuBUlBgB6ILAmWq31+Gbfy81FxbcnDGcjj/4xkurBPTBDEM+CyRUf5DdE3vGN2PCExhp35iESdtP48J+Hv//5r2rdZw8peS2jc2fZ5ewDk0Ue31CgbGdsqkifWfHZcZf7Y4b1rScDiUv/7l8xxsQSaKDV25HStjCDN+B3tIdklZhyfc5Sn66gmR2cle8WhpaPsgseGUodDICOfXWsGLwZ9uNWCcVyaJjzm92Ct2QKE5EN+1IVU57d1MRvFXndcqchDflBm5KeNW+ZzCGGR9alCgbgFyfK84zYg6WtS/Cnzv8+KGxKnIxocYswnqG1TXpcRUlAIhvS7ov44vbUmxGMpU1dBDfNvRHxyXuYQ+yHx85TfdYw5wnpK/y5oha4bFSQ7A5EbwIWNzvcRCbEB+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(316002)(54906003)(122000001)(2906002)(4744005)(38100700002)(52536014)(55016003)(8936002)(5660300002)(6506007)(7696005)(53546011)(9686003)(66556008)(64756008)(4326008)(33656002)(86362001)(83380400001)(38070700005)(8676002)(85182001)(110136005)(508600001)(26005)(186003)(76116006)(66476007)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?LzhIWDNCRWx1elNKWkZnbWZMTEEzVnNwRnMvczJObWtycU5LYUJrQW50SjZ0?=
 =?gb2312?B?WXhsbnFFYTVkZVVzMU1JWnQxZ3Z1bU9tTXBBUlFyREZMMXdkRTEvdlJ2dkZR?=
 =?gb2312?B?ZHlJK0Jnbjc3Q2lBZDluSEdxZ0dQTVdJUlZBUWZUUHFOZFRPdzF5QkcvMHFE?=
 =?gb2312?B?OEN0bXNCOU9Xa3ZSVkQxb3dDckpsejdCem01QlArN0Z5Yk1QUEoyWlN0MGJ4?=
 =?gb2312?B?QlNwZVJJNFNxcjErKzIzS3ZMT0xPYTZJS2ZYNUpaVXNyV0xVNUR1TEc2L3cy?=
 =?gb2312?B?K2YvSHA1cVRZR1BzRmtCa2JYZXdHRElZeXVYeVgrSFdDa2lIVjNwSi9NSlUy?=
 =?gb2312?B?emROK3duYTR6c2psV2RQWHVnMHFGQ2djRFNWOXlXYUVsdUhLdFcwdlBaRHlG?=
 =?gb2312?B?QTltNURIWnBMNFJEZkpkdHkzZ2k3MWJqSC9HRTNyelY1U1h2MWxnRVNKdWwx?=
 =?gb2312?B?VTBiOEpSVkl5b012Y25XeStacWw5ODZCQjhFeGQ3WGJOWEVJcUVxL1BjaWVD?=
 =?gb2312?B?bDlaS2Nma04yenJCbVR1d3lONHMzakhQRXZJWkJ1K0pWSFlRZGFMMTdPdEN4?=
 =?gb2312?B?eTI4RVRocXUzK0lDdFdNb0pIOHVaM0d3WVgwQUtxaVZyTW1FdFQvQTlQdFc2?=
 =?gb2312?B?amlXYWhKbU5DbjRZUVo1NlNUVE1kNW9nSnhtQzRqUTBXZlJoMTBFL21PYi90?=
 =?gb2312?B?WFN0SDZFcGxHeEV3Rk1jQ212VUpac3ZPL1IyV2ZzZmtjRjMvSjg0ZFkzMVBw?=
 =?gb2312?B?aTNYUFJqVnVlMFNIcW1HdWJQRWJXRDNqTllMWHE1VmdtbXhuQnhHYUlRL1N4?=
 =?gb2312?B?eTZFeG5uSXBSRHVzL2ZQYm45ZEJ1Z2J6YmdCc0xydlNNSGhDUlZZVFgrVUM1?=
 =?gb2312?B?d2hqUW04b0JKVEZnRWtZQ3NaNzVFUUZaNWpNUVdqM0tuWkp0bEVPSDVkZklw?=
 =?gb2312?B?czE2Z01HdFpucDhwWkR4UnB1MEVLOWZjUXNaeC8rWW44cFZ0OHdHd3NFM29i?=
 =?gb2312?B?eXZJVXluQlQvRXdFV3M5WkhtMnZnSHkwTlV2WkdvSkxjY1hOWlBETUdyUW5G?=
 =?gb2312?B?VEdmN1h1YnBoRDN0czczVnFNN0YrWm43MTlPaXhkSHkyR1BvanZEcHZPN3hq?=
 =?gb2312?B?VXZERmVaMW1Kakt3VG5qZG9wbWlRbkYrdEJGUzRoQmRjcW1HSlNHbDB3RnBI?=
 =?gb2312?B?TlRnU3pCak0wOHNObmtCUXZvVVBQTjMrTGdkQjR4eGw5czRPVDdPUVoyQ0No?=
 =?gb2312?B?QzZEaFIrNEwydk56WTR1dVJXTjJuSThrOHdRRkd3bjR6M1BpRm4zM1lXQ3Nk?=
 =?gb2312?B?Qit4amhWcTFUQ2Vhc1NoYTVLYTBVaXdFM1Bwc2hNYkV0MnRRcEcydVAxai8z?=
 =?gb2312?B?a0JweWpBenZvS2I0Wkw4dkxEeU05TFUvOWU0VDE2cFpqYVlxYUh5aCtWM21O?=
 =?gb2312?B?WmVaNnp5VVJhb1hRV0J5M0UrTkMweXcycEs1TWVKS1c0SzVZRDNqSERlQ0RM?=
 =?gb2312?B?K1RlVExLZVpKYVE4QXZlb3JkMHE1Q1VSL2NQbEYxaSt3WXBEV1BlbmVZNmtl?=
 =?gb2312?B?WFp4Wm5tc2NZWVREYkhqT3VvT01QK3ZsbzQ4UDFhZndOR2twWXJoVzYrWWpp?=
 =?gb2312?B?TDZlQk1KemRYNWliYldFakt1b1NpbXlYeEV6eUFhKzd1ZVB1TUVnVGNkbldZ?=
 =?gb2312?B?NnlkcU1PRzhjMnBYRHRocUZyNHFqTFlmRFdCNW5QSVN2Smprck5zYjNTbEdK?=
 =?gb2312?B?Mnp2R1lrU2FFTXBoM0w3V3V1aUh4UWVjazdBVUhwMmJUNzdpeUlrR1lkOGpk?=
 =?gb2312?B?cDNjUDRmVFhWbmxMaTVwMXZqK1lzZUlRYzFmOXovNVRyRjgwTnpoM3FIRjJw?=
 =?gb2312?B?d2oxd25nNFdWVnFObUVBdGR0ZFVkNU5DSTVEYWtvbWptM1NLQkhqVnZXekZo?=
 =?gb2312?Q?xtfiMnd2Jiw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2443196-24fb-48a2-ca34-08da087e7e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:27:40.4724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKG7HcTSDIa8Pf/hf44NGrkR99CYLIo7CeN1waYKvKvnRzOmLRyWCvAEGegEEv9eGY3Fhc22rtZJQ53UCC4wUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5162
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFlZ2V1azoNCglbUEFUQ0ggdjVdIGYyZnM6IGZpeCBjb21wcmVzc2VkIGZpbGUgc3RhcnQg
YXRvbWljIHdyaXRlIG1heSBjYXVzZSBkYXRhIGNvcnJ1cHRpb24NCglUaGUgbmV3IHZlcnNpb24g
aGFkIGZpeCB0aGlzICxwbGVhc2UgaGVscCB0byBtZXJnZSB0aGlzLg0KDQpUaGFua3MuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBSb3Rod2VsbCA8c2Zy
QGNhbmIuYXV1Zy5vcmcuYXU+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTgsIDIwMjIgNToxMCBB
TQ0KPiBUbzogSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4NCj4gQ2M6ILOjt+/pqiA8
Y2hhbmdmZW5nbmFuQHZpdm8uY29tPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4IE5leHQgTWFpbGluZyBMaXN0DQo+IDxs
aW51eC1uZXh0QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogbGludXgtbmV4dDogRml4ZXMg
dGFnIG5lZWRzIHNvbWUgd29yayBpbiB0aGUgZjJmcyB0cmVlDQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBJbiBjb21taXQNCj4gDQo+ICAgMzQ1OTUzOGEzNjU0ICgiZjJmczogZml4IGNvbXByZXNzZWQg
ZmlsZSBzdGFydCBhdG9taWMgd3JpdGUgbWF5IGNhdXNlIGRhdGENCj4gY29ycnVwdGlvbiIpDQo+
IA0KPiBGaXhlcyB0YWcNCj4gDQo+ICAgRml4ZXM6IDdlYWI3YTY5NjgyNyAoImYyZnM6IGNvbXBy
ZXNzOiByZW1vdmUgdW5uZWVkZWQgcmVhZCB3aGVuDQo+IHJld3JpdGUgd2hvbGUNCj4gDQo+IGhh
cyB0aGVzZSBwcm9ibGVtKHMpOg0KPiANCj4gICAtIFN1YmplY3QgaGFzIGxlYWRpbmcgYnV0IG5v
IHRyYWlsaW5nIHBhcmVudGhlc2VzDQo+ICAgLSBTdWJqZWN0IGhhcyBsZWFkaW5nIGJ1dCBubyB0
cmFpbGluZyBxdW90ZXMNCj4gDQo+IFBsZWFzZSBkbyBub3Qgc3BsaXQgRml4ZXMgdGFncyBvdmVy
IG1vcmUgdGhhbiBvbmUgbGluZS4NCj4gDQo+IC0tDQo+IENoZWVycywNCj4gU3RlcGhlbiBSb3Ro
d2VsbA0K
