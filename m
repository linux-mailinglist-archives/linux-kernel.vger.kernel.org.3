Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE951B1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378955AbiEDWM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358624AbiEDWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:12:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5822A1A3AE;
        Wed,  4 May 2022 15:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBiPJSgdWtNqSEByCxxVop0lft2Q3pmOPOPo1OTJa75lz+KnBxIahq+9WWv7jBd7B9dLJhmZoOmALmWh9P1NWZZCG5r+DY45GCGTILbHXd9wJnUgIXqQ+jK/xK/gMAscz7A5rrgLDA8zyJp21c1cGg0oET6iP3REgnq8x+JAA7ObOq4GsSWc5f0J9AtAhq6Zu/xmXDHwziBjq8b2N1UIH7btIpmeg3IfV0E5WrLwiQOjE3orfOjy7bssKkjGPB8PDeIvoTgISV3uemODvNB9Ym04C0o3HaFqo+XqnD6YkvWHLeMykPauB0088q0UgwqLsNvp7tgt7q9LjQdKHvDuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xc6rN50WKVcJMujmj6xVy1TEDY8Xyy5g9p1rEvm34E=;
 b=YUv6qfIGZUVWt7SLN68/9hnIDYMRchP14gsneePGVXLafb4RlXWZPDAZdsgjoA4rwVMEN97xR4NHPcpujcceobzq2KcVuBo3vFt51uXA+YZUkIJyTha/VEVCp9d/QEi8LdFtZBHhB20XPO6Uf5FjpyQcJBEbrsNuab/m3HXI+wJXltDswHRJ+WmKYFpqiz4DRE7esWPioOxrN7uj2yILdqxHffCqmPoOVOm1lOljpx0xkgXxfR9hL8uwImSo/ozRcJKdyMQosm42zcTQuWopEb1Q1KYBxjx+6rT886i+1EnVAs1nJHGS6Mih+W/TQ7qa/Cm08Od+T7j938to0BjOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xc6rN50WKVcJMujmj6xVy1TEDY8Xyy5g9p1rEvm34E=;
 b=XYk6u5xC8ouTV7ikIsycsROX6kCUgvaj71s76MrCC42hXVHlVOzb3JRBZm0QQEpoGvH1FyYPywXQbEx+Gi02q2dXmzw0s2BqF2oNktgFVZx/oohmRd1bfUWY1RHViVZPohOtkf2lWO35Gyy5Z09vIN6aXnYj5AwNOL9O+BZ2lhCtH9SFayBK9BlGcDbxROrpo3ox9tP8/OYBeyvO2I3wnJY+3UtwIjbzldpt1mHrIzDnYKNv8lOvdXvt0qJslh396Ce8E2WH/ssvtS91DaYlHVxO84LsxLzmqpsui9PEk3KHr9u0mTuftSUxb3RNGnM3pH8GcUnl3c//tXz2xg57zQ==
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 22:08:39 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::1d6:c3c0:6c38:d39c]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::1d6:c3c0:6c38:d39c%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 22:08:39 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Topic: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Index: AQHYVC/lc4y/VBnhnUChitXD8Ovg3K0PIJaAgAAT9PA=
Date:   Wed, 4 May 2022 22:08:39 +0000
Message-ID: <SN6PR12MB4719E05A6BC7CAA2C00F35EFA0C39@SN6PR12MB4719.namprd12.prod.outlook.com>
References: <20220419205432.46021-1-bwicaksono@nvidia.com>
 <20220419205432.46021-3-bwicaksono@nvidia.com>
 <20220504182633.a3mwuiohfqtjvpep@bogus>
In-Reply-To: <20220504182633.a3mwuiohfqtjvpep@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 496b3cd8-4ae2-4e08-adde-08da2e1aa49f
x-ms-traffictypediagnostic: MN2PR12MB4486:EE_
x-microsoft-antispam-prvs: <MN2PR12MB44868C2FEF6CBAFCDC00731EA0C39@MN2PR12MB4486.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+yZOCkAoByAk5z7I3BL2dkwjOxnqdFkKzOLN9g6L/0RpiGGbHbpMBKBkaeZJKH9TYVbl7XsWVmxddrz5OE1gfTTii6YLp/e6Z+ZQ6sOf15r/da1QCeHcrJU8lyN/jZ7g+fAgm4myglMSm44/Z/qJy+P3gVsmSz+Vetfs6gTein0a2lB4D2ZlKZdYknh/dh8uUkk19Rs1yqN5RkLwoI4sGMEw7kncvhWxc2lC9YxXu4D03pQj39wDKqjZ+JFuzWpRgauq0xQ4KpxJ7TNkGFYblMp+vdKlWl5a0dkJQ+MOXJVAGZGog2LU7mfVy7LdG4qcmKzv6SXKq0YSMXcLQ9ir3uc3OsY+mJacCpjNkVay55B2d0re6+b4MjfBSUNyGfcGGCCw1XkEaUuiLggIe4ffKbA6NIc/5nDA/3nSWyBFCXwczt86pnKwAqvKPFSv/wmB2yxOkW/++2VwPMP85Q940ScDR2aD273EWomNIa2AeZmLK4id25dCv82zsEwAdx5QQzUv2pQS6xKacWZ+cmcjM/OAmhU3aBqMbjJaXV6AWJiu1XB3z3Td8yOmjGs/VkIMHSzRQunGJEldjO+V0Q5BrcijVQh/B5jJuAsem0RYez6yajCrN0spN6CUFX4+3Id2fyT5AD4Pr1PEbb05adpNVP2BPcNLNpeh0XYuuWmPofdPbV2A9mAoSisQl9qqRIE/511Ey4JjlZNoBVOUZUiWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(110136005)(9686003)(54906003)(26005)(55016003)(4326008)(86362001)(8676002)(83380400001)(66946007)(66446008)(66556008)(66476007)(64756008)(76116006)(316002)(5660300002)(7416002)(38070700005)(38100700002)(52536014)(122000001)(33656002)(8936002)(6506007)(508600001)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGlUR3hKVzh3Q2RmcjFXaG9GR2tVWEhBOU5SZkZ1bXpuTThnVk5YYnFBaGll?=
 =?utf-8?B?UmR2RVpJa1RTQUV1aEhiTGgwdmsvZ0dLZmxoeXZZYitGODVvNjE2cW14RW0w?=
 =?utf-8?B?OW5zVDVTTUx3Qm1sZVVySUZQMmV2ZGo3cGs0aXI5eFRKSEdJeGpmVFByTDRa?=
 =?utf-8?B?ZnF3TEgxVVJDaHZReDJyem5pZVd1aExqajVPUHpvOWRVc3VoelFid25rM1U5?=
 =?utf-8?B?QjIrLysrVjdrMkhCSHlsOExCTkl1NmJmdWlvMUV3VjBpRVhPdVllSXVvd3lO?=
 =?utf-8?B?REVUQUp4OFZOVG9SOFRyNjlhWGpaU0dTRHRoTFE4Z2VaSEFPcGxlNmdZcGJk?=
 =?utf-8?B?cWNjcUVWM21WbDBCeXNxbHRJUytPMWhXZHp4aUptbjM3SGlFT2g3SFlyNWVn?=
 =?utf-8?B?cUFXdHBhSXpDWjFTUVowUGthZjZOTStPaEpMd2xORDFtWE83R2oxWUV4QU1R?=
 =?utf-8?B?MFhYQUdWdFJ1aG5aTHEwUWltTnlhL05CNFJ2My9LN3lncFJrcFo4SFpDeTQ1?=
 =?utf-8?B?bVBCOFdJQWU0UmI3aXk5Mk5NYnB2dEFKU2JLYUhPR3pqVExvdEhDeUVUeDdD?=
 =?utf-8?B?d1Rna0ZQcFhwYldIRnI4UmJYd0paMDBCdjk2OWRibmJuaDFwUWhLWjBVVUVP?=
 =?utf-8?B?eVdJOS9ucFUyN1dZR1c2aVIvbTFTVE1rdE5KRTZFeFYySHROK1VjNzNWU29s?=
 =?utf-8?B?ZmRCc2hDSDdGTENOMzVGVFFoVFh6R3EwcFZ1eWp4TktISVM1QXZzYm9GYXdl?=
 =?utf-8?B?NHUzVHNwQ0VsbklNVzJFUExpaWJYQ1dmeU1TOEtJd01JQk9JOG9GWnB6TUsr?=
 =?utf-8?B?QlRseUFyQ3Yvc2JUY3NUOVBoV3NpU09SdUlTeEVhVkxXN0F4MzdSVjNHZDVn?=
 =?utf-8?B?eU40dTdSQml0NmpyV0NzeVZrb242RjFMc0xsRm1XQzZ6UDUxWFJUS2I1TzFO?=
 =?utf-8?B?T1k4MWxPa1hRTWt2YUV6QTJueHhteFE1TDZLS1EzcG43cGNTMFVHYitHU0hK?=
 =?utf-8?B?eldHaDB2RTNZSkZHQUQvUHZ2K0tMdi9zdDA3MUUyM2RVWnVROWxuNlJkcWhL?=
 =?utf-8?B?YWtJNFk3bWdTUXBVUnZ5Q2E0c2NieWZ0WElGbG96RVR3VHFMM0gvSHhOdGZF?=
 =?utf-8?B?ZjZJN0lETlFCeGJHL3VNeUpjTmJtK0pydm0rOUY4c2NnVGM0MkhLMmgxQjB1?=
 =?utf-8?B?MFJpa0Y2R3VJOVlpcllGVFNzS095b0RoNGZZNk5iRDZ6aTltRWJvSUpZMkpY?=
 =?utf-8?B?TS9DN1VEcUlvNDNTNDQ3aStPOGRTL0xsQm8zMmdpTXp5REYxcnVrT0xzRDZI?=
 =?utf-8?B?RkVkeWlRdDBiN0hJMzV5RlpIZ3hxb1NtcVduUGhiQkJIMVM3aS9PTHR2ejZX?=
 =?utf-8?B?Vk8xcWdNUnl0TFl4VnFVU3U3RFNpZjFZYWVkdXdaZWZzTGhCaVVqNXBxOU56?=
 =?utf-8?B?MEV6Mm5Gd21SNm5QUlQyc1dnaE9VNGdEV0RoVGZiZC9nMHJ4LyszUGo3VTUw?=
 =?utf-8?B?MEdScW1KdjZ6cjNIS1JCL0hVYmswZGhFRVNDZU5WMXFwRHdVcENkcnF3S0hl?=
 =?utf-8?B?VktDMGcxUlVVcUpxeGtlbHZZcU9wS3pnd0hKY2pZOEw0RTBXdC9wQ1RPMTBK?=
 =?utf-8?B?aHRoMWt6YXRBQndYbVBvWktpL1MxWi9rWjJEY0tVVmErQThjT1J5M1BnaDNr?=
 =?utf-8?B?cEFyODlpWVo4cGljMi9VQUZHVk43bzNMWlVRc1VEVW1hSk5kZTlNMUxuVFJU?=
 =?utf-8?B?MXFyK1U3LzVrckNxZGZFV1ZXK0lYVFAxYXk1eFZHNTg3ajVzSE9NdEhNRnMw?=
 =?utf-8?B?KzUwNG1VVjFnS3VOendwcjZlN05HS05MWEF5bDhiQWhFV3BQc2ZJd0EvTWR1?=
 =?utf-8?B?V2pQY0ZUdWRmRmU3Sm13SS8rd2NFREgyLy9mZDBjVWV5QWxFSk9LaWI4aVZa?=
 =?utf-8?B?SkhFREdRYXBpam5xdGMwaDdEVkgzSmNiaDdZWXk3dXdrRS9qa1BBblgrcG40?=
 =?utf-8?B?eW1VYUNsNE1uSlBlZU9ncjRmWTU4WWswSHVzTjl1dVBrZTZ1cGRpWWpqN2Nh?=
 =?utf-8?B?YnpFYWM3dGlOT3dTK1k4MXh0U05oSWxRcGZEUWpkc2lUWWpOKzBUMmdpUG8r?=
 =?utf-8?B?cFNWRDNycGhGelVtcHZZUUVTMVJ1bWo1SHFuWTVZS3RJRjFGS1B0WjkvNGl0?=
 =?utf-8?B?VVQxOU1ERXZsZlkySTF3a3dJSTMyeUExUzQzMHZNUDZnSVNlRzhjbU5oMEly?=
 =?utf-8?B?dnc5REhLTk15WUNNN09UU2lHdEhad3ZvdS8xNmlHLy9VMjRYSzlzZUJZRzVZ?=
 =?utf-8?B?MmpnN05SMVVGcnVWbHo3MTRWVlRxMGtlN1BHbDdDZDFMRzJFNDV0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496b3cd8-4ae2-4e08-adde-08da2e1aa49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 22:08:39.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT2rHLun5iDWEgqd8efuK9QHjJ82q4pnyGUmy3qKMFL+t1X+Vt/3Qwe/xFoq4/I1JCKfFjBiP7TZVMOJu0ZzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+IEFueSBwYXJ0aWN1bGFyIHJlYXNvbiB3aHkgeW91IHdvdWxkIGxpa2Ug
dG8gcnVzaCBhbmQgcHVzaCB0aGlzIHdpdGhvdXQNCj4gdGhlIGFjdHVhbCBkcml2ZXIgdG8gcHJv
YmUgdGhlIGRldmljZSBiZWluZyBhZGRlZCBoZXJlID8NCg0KSSBwbGFuIHRvIGhhdmUgdHdvIHBh
dGNoIHNlcmllcywgb25lIGZvciBBQ1BJIHBhdGNoICh0aGlzIHBhdGNoKSBhbmQgb25lIGZvciBk
cml2ZXIgcGF0Y2guDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoZSBkcml2ZXIgcGF0Y2ggd2lsbCBk
ZXBlbmQgb24gdGhpcyBwYXRjaCwgYnV0IG5vdCB0aGUgb3RoZXIgd2F5LiBTbywgSSB0aG91Z2h0
IGl0IHdvdWxkIGJlIGJldHRlciB0byBnZXQgdGhpcyBwYXRjaCBhcHByb3ZlZCBmaXJzdC4NCkhv
d2V2ZXIsIGlmIGl0IGhlbHBzIHRoZSByZXZpZXcgb2YgdGhpcyBwYXRjaCwgSSBhbSBob3Bpbmcg
dG8gcG9zdCB0aGUgZHJpdmVyIHBhdGNoIGJ5IGVuZCBvZiB0aGUgd2VlayBhbmQgd2lsbCBDQyB5
b3Ugb24gdGhhdCBvbmUuDQoNCj4gSSByZWFsbHkgZG9uJ3QgcHJlZmVyIHRoaXMgbmFtZToNCj4g
MS4gYXJtLWNvcmVzaWdodC1wbXUgaXMgbXVjaCBiZXR0ZXIgdGhhbiAiY3NpdGUiLiBJIHNlZSB0
aGUgc2hvcnQgZm9ybQ0KPiAgICB1c2VkIGVsc2V3aGVyZSBpbiB0aGUga2VybmVsIGlzIGp1c3Qg
ImNzIiBhcyBpbiBjc19ldG0sLi4uZXRjDQo+IDIuIFNpbmNlIEFQTVQgaXMgbW9yZSBnZW5lcmlj
IHRoYW4ganVzdCBjb3Jlc2lnaHQoSSB1bmRlcnN0YW5kIGNvcmVzaWdodA0KPiAgICB3YXMgdGhl
IGluaXRpYWwgbW90aXZhdGlvbiBmb3IgdGhlIGdlbmVyaWMgc3BlY2lmaWNhdGlvbikgYW5kIGFs
c28NCj4gICAgdGhlIHR5cGUgbGlzdCBzZWVtIHRvIGNvdmVyIG1lbW9yeSBjb250cm9sbGVyLCBT
TU1VLC4uZXRjLCBkb2VzDQo+ICAgIGl0IG1ha2Ugc2Vuc2UgdG8gY2FsbCBpdCAiYXJtLWdlbmVy
aWMtcG11IiBvciBzb21ldGhpbmcgc2ltaWxhci4NCg0KQmV0d2VlbiB0aGVzZSB0d28sIEkgd291
bGQgcHJlZmVyIGFybS1jb3Jlc2lnaHQtcG11IGp1c3QgdG8gYW50aWNpcGF0ZSBhbm90aGVyIHN0
YW5kYXJkIGluIHRoZSBmdXR1cmUgZnJvbSBBUk0uDQpUaGUgQVBNVCwgdG8gbXkgdW5kZXJzdGFu
ZGluZywgaXMgYXBwbGljYWJsZSBvbmx5IHRvIENvcmVTaWdodCBiYXNlZCBQTVVzLiBVc2luZyAi
Y29yZXNpZ2h0IiBhcyBwYXJ0IG9mIHRoZSBkZXZpY2UgbmFtZSBpcyByZWFzb25hYmxlLg0KDQo+
IE5vdCBzdXJlIGlmIHRoZSBzYW1lIGRldmljZSBuYW1lIHdpbGwgYmUgcmUtdXNlZCBvciBQTVVz
IGNhbiBiZSByZWdpc3RlcmVkDQo+IHdpdGggZGlmZmVyZW50IG5hbWUgdW5kZXIgcGVyZiBzdWJz
eXN0ZW0sIGJ1dCB0aGUgbmFtZSBtYXR0ZXJzIGZvciB0aGUgdXNlcg0KPiBzcGFjZSB0b29scyBh
bmQgZGVjb2RlcnMuIFRoZXkgbWF5IHVzZSB0aGUgbmFtZSBvciB0eXBlIGluZm9ybWF0aW9uIHRv
IGFuYWx5c2UNCj4gdGhlIGRhdGEgc2FtcGxlcy4NCj4NCj4gU28gaXQgaXMgYmV0dGVyIHRvIHdh
aXQgZm9yIGFsbCB0aG9zZSBkaXNjdXNzaW9uIGFzIHBhcnQgb2YgdGhlIGRyaXZlcg0KPiB1cHN0
cmVhbWluZyBiZWZvcmUgeW91IHVzZSB0aGlzIGRldmljZSBuYW1lIHVubGVzcyB3ZSBhcmUgYWJz
b2x1dGVseSBzdXJlDQo+IHRoZSBQTVVzIGNhbiBiZSByZWdpc3RlcmVkIHdpdGggZGlmZmVyZW50
IG5hbWVzIGluIHRoZSBkcml2ZXIod2hpY2ggY291bGQNCj4gYmUgcG9zc2libGUsIEkganVzdCBk
b24ndCBrbm93KQ0KPg0KPiBBcGFydCBmcm9tIHRoaXMgbmFtZSwgSSBhbSBPSyB3aXRoIHRoZSBj
aGFuZ2VzIGhlcmUgYW5kIGhhcHB5IHRvIGFjayBpZiBpdA0KPiBpcyBPSyB0byBtZXJnZSB0aGlz
IHdpdGhvdXQgYW55IGRyaXZlciB0byBwcm9iZSB0aGlzIGRldmljZSB5ZXQuDQoNCkkgYmVsaWV2
ZSB1c2luZyBhIGRpZmZlcmVudCBuYW1lIHRvIHJlZ2lzdGVyIHRoZSBQTVUgaXMgcG9zc2libGUu
DQpJbiB0aGUgY3VycmVudCBkcml2ZXIgcGF0Y2gsIHdlIHVzZSBhIGRpZmZlcmVudCBuYW1lIGZv
cm1hdCB0byByZWdpc3RlciB0aGUgUE1VOiBhcm1fY3NpdGVfcG11PG51bWVyaWMgaWQ+LiBDZXJ0
YWlubHkgdGhlICJjc2l0ZSIgbmVlZHMgdG8gY2hhbmdlIGFzIHdlbGwg8J+Yig0KQW5vdGhlciBl
eGFtcGxlIGxpa2UgQVJNIENDSSBQTVUgdXNlcyBkZXZpY2UgbmFtZSAiQVJNLUNDSSBQTVUiLCBi
dXQgaXQgaXMgcmVnaXN0ZXJlZCB0byBwZXJmIHN1YnN5c3RlbSBhcyAiQ0NJXzQwMCIgb3IgIkND
SV81MDAiLg0KDQpJZiB0aGVyZSBpcyBubyBvYmplY3Rpb24sIEkgY2FuIHBvc3QgdXBkYXRlIHRv
IHRoaXMgcGF0Y2ggYW5kIGdvIGFoZWFkIHdpdGggImFybS1jb3Jlc2lnaHQtcG11IiBmb3IgdGhl
IGRldmljZSBuYW1lLg0KDQpSZWdhcmRzLA0KQmVzYXINCg0K
