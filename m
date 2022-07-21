Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9B57D229
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGURCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGURCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:02:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399443302
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQzhagRyLQlC50BGA48iXZthyHA37RK5pPuo77RByneM3/8KVuZBbA+Z1i1aGjWxzQy/x7Nxt7vTI1izD+6I3/4rrT7RJJFZSciQBkVtYms8Lhsr25guhDbrSb/DMTINU2tlHp2U5yF/POCQt7++s9NDAeLNKMW1r3kXd97SvdFuB+yvwZW3/DfAGvDARoKHFAe6L+RWLXEJk1JiF6bLhRiI7Uwx8mp1uklNGuCgwiF53ayyHLgur3E+AV0MmttlP56ziPWUIBFByjoWW1yn7WLHi9UfeYT8kiH1ltOZ0mS0KISOR08O6bKGnrP6FqimxasMBISF+CRDHdMRotipnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZhiipPXWmt1qglSKojOqu3uXqsJHaca4qlVPu4cDDk=;
 b=HV+r0ZtUJg6TypiCJ4Q71tnF2SGmA8UlaZQBLelm2dnSumGBPH3uIsuX0ZnFDnIO00MNpSZ6Z1TKNOVtuliXEMenal70aN6WTeiM2ILUPMigRW5JS9B5NP5+Koi/ADqXdQ8t+WRmOks4N6DEpHScj+qsNmBvaEKGRkPWeCVx4x3VzohEX0Sm/a7c1mXOhVS3NTKa/PbnLoznRVDsjyO7OFYcPoKEDNmlwrslEE3S9JK8z3P6/BFcdc+f/flMtJQLm7Dj2jsnft98BvC+zgfKSfKoc63WehfH2uHPFTHEtasf+/KusobboJj/FHrFduYZvQq6ubvkJm+v4PYByWwz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZhiipPXWmt1qglSKojOqu3uXqsJHaca4qlVPu4cDDk=;
 b=ZkN4S7oJDc2781m4z4fWynyhua4tVnjN02kSJ9Nuy5T9z3JE2gIKVyUubKBp1IK0Qdyp6ONAZleJEXVUrS2CY5j6ibkcbIudvJbxpupjQpKg9FCtQOI7L1k3pKb1GmNVAAzV34fPqliEXwCyaKwNgMOQpl6tBqvqxde4LpkqAYXYRz8dVmzVhbGLFMDqVbiyy1+5Q83uYpetrcXcfzcpKv1f2D0Bp8fqOMt9QeCDhiv41Nm2AHTxmgJRZTimNnUrKCRSAPdVemSsEc6C8ntGYN4eizFFGNGf4r/YaTuT2ycu00omb0TFR9It+XfBPhJlUJl2UZMVyPIZvPc6lfXMGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4602.namprd12.prod.outlook.com (2603:10b6:5:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 17:02:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 17:02:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Xin Gao <gaoxin@cdjrlc.com>, "richard@nod.at" <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hoeppner@linux.ibm.com" <hoeppner@linux.ibm.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "frederic.danis@collabora.com" <frederic.danis@collabora.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ubd:do not initialise statics to 0.
Thread-Topic: [PATCH] ubd:do not initialise statics to 0.
Thread-Index: AQHYnG9hqOxPhCawa0SI26xKilPxoq2JDoAA
Date:   Thu, 21 Jul 2022 17:02:40 +0000
Message-ID: <7cafc7ad-be8f-4093-1df8-8bbae37308ad@nvidia.com>
References: <20220720192916.7564-1-gaoxin@cdjrlc.com>
In-Reply-To: <20220720192916.7564-1-gaoxin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0124582-16b0-4a38-6dc3-08da6b3ad2aa
x-ms-traffictypediagnostic: DM6PR12MB4602:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ivgx6wdkorcHHfugZh7Yycy7hVTIKE/m4fKNwC0fNxNC5vL0ZIT03S51Yd5aCeFCy+5M+c253CvFC9yXXM748qdvlnHjsv3MjyIykL/hjRfMuRI5hEgwwo+YQPxb4eWfHe9bhAYyrc25UPqzv3HY6I8Z8MjsLbUzg1koDTJAsKT1oHEhZxLfuqIuDzUQ/r7R3B7SNNQ7ec1njiYx+dV4lsTCWD7Sbqs443TvlyVKCdwwzyAgmj7307i3lSZXI9TJtXqopSdbJqr5Fimp0VXFJqnOC42kPgnUufLhh+LEdeWBhegVHx7W8VIndC+ohKBfBnBZD1w6JiuaGWqPXCoODvhwfKQITrun6szlQ4e2IFkfKL8pcCnFhm2RHxldTHU4YwNSstxcyaEujH4ahAJx3icx6TgHu5kys///pCAPlAel4AzRtcxYjvGUcmFDnFdm1evNSBsGZN/qcB6+UUMLiTY8cR7YhlKXyC+OvlHP6r4n4kOvNfcJw1Fdi8Irb6oqXqnOULVAGJPhxYKBMIsW7C4kD/XuWW/wpDg/lZ+RGsz9POP2xP04ejh+8PanZMh0N4SiwdWnTAX02RR+E4lAnK/sGoW5laWuD2gfQIp33NJC0X77IJng6zxCTMNx5WYTL+qJdMQIu8nB/5NwLZw0n8AmUPaULZb/SyUC1aT+0LiUfQB44URPzqUpb1ejUhacDAibtXT9CWY+tIQyhQFSSQ0gT+IAj+yzMndHNjpl7lzvLgy74UYnRKwE0Os8BU4m3sFljBw0xEtU95wAYHMVlgFtvfmzXVcScUlIfglg53MqDvnAkaDKnirpnsnDUnwPyIZ/rjH+x/DSEcZI+HXgTRKsz3O4WkxmtG1YsQN/IcHeMJGZD/hW8776cuC9gXE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(66446008)(36756003)(31696002)(31686004)(38070700005)(5660300002)(54906003)(41300700001)(478600001)(7416002)(110136005)(2616005)(316002)(186003)(91956017)(76116006)(4326008)(6506007)(8676002)(38100700002)(71200400001)(6486002)(2906002)(122000001)(86362001)(6512007)(64756008)(53546011)(558084003)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzBza2xWMWQybHNGYmZkOU0za1AzeWw0M1dPQWFBRnQ3S2FZU2gwSDNPYnBG?=
 =?utf-8?B?QWhqY2tpSWN2Ny9rZjZQelpuN096alBDaTE4RHo2SXFsYmNZVlc3c2Vhc0VZ?=
 =?utf-8?B?RmJCdVJFdXBNM0U2TGNSV0V1eG42a1pvNzJMZ3ZyU2NrQzNxdEVORW1WR3FR?=
 =?utf-8?B?bjJnNGhoMnBSek1VUVgwaGt2bURLSjZldXVML21qKys1NTJZUEJsY0xzZVpK?=
 =?utf-8?B?VCthSjlQaGkwRGZobWlqMlhXNHFRVklhNkpCdHF4RHIrRThsd084MzVaZFg2?=
 =?utf-8?B?YW82OTVuczF3TWxvV2pSdXpjc3p1bkNXY2NvdTBEb3BHeW53bmlSQmV2bHpV?=
 =?utf-8?B?QjVjME1KSUp5cFhES2RmajZTcGUrY2s4aGFuMjdzN05TQnRVZU5PRkRrajJK?=
 =?utf-8?B?R2cxZW1FWFhva2pENEdrT0tKR0FVWlVLNzVCd0xYMGd2bFlXWWNKRkFzTmV5?=
 =?utf-8?B?OXNRdnRGRmFOK1pEdE1pVStwRWJma3l2U3E4QisvRm8yWmt5Z1I3YW05RzA1?=
 =?utf-8?B?Q1NOekVaNFpOWUxma2lVNU15Y3FXZFZoM0p3eGZ1TE1hbjVZZFdETnJDRGoz?=
 =?utf-8?B?QUVmVitLMVdjOVdrcHRvdVpwamtBK3RqM3BXWHVUMkxQYTZGS0IvS0VLWHM1?=
 =?utf-8?B?M2NWMXpPQnZMTU9qTDMydnhqSERVMHkwZGpJcXJVc2NZdk13RUx0OC9UUXpN?=
 =?utf-8?B?VnA2SFkrcWtTR1Y0ck5ONzhpOE5leEVzVjFIYW1ManJNM2lKeStQc1JSb2Fl?=
 =?utf-8?B?L0o5dklDdHZweVM4WkhYY2ZCTHdVek92S0JwOHRVYjlIaXhPRGswZHRYaXhK?=
 =?utf-8?B?WEp1RXJicmdWUmZ5UFZqTDJwWnVWMXZiaWZweWhXSFNiWGg0eXVqTnNmamZ3?=
 =?utf-8?B?R2V2b01hUmJjMCsxOEJoV2prSmx0R1M4UlJ4ekNST1E0aDV2ODdkRjNtWTdW?=
 =?utf-8?B?cWxjV3NXM3h5OGdyVmlkZmV3Mi9haldtK0N2QmFZVGsrMU1mNDgxQVVGVnA4?=
 =?utf-8?B?SHJwMEE4N3hPZTZHR3luNzN0V3hLZHEvM0tmUkd1dFlIZ1BGcG13YzZqbS9s?=
 =?utf-8?B?QXB4R0sxcHFQeDk1eGYzM0FrZWpYbEVHSzd3RXBXMHcvRXU0S3M2cHVvcnBN?=
 =?utf-8?B?NzFDOCt1LzA1NStOMUx6STBJNzlORjBpZyszMURhUmpueWI1WlhueW9uRFBX?=
 =?utf-8?B?eU4vNVNaMnd1OTRoMllGNjQ0d2xXOUswTXNPeWdjM0xIckpXcXNVMG1PRGNS?=
 =?utf-8?B?ZEY0UVJRZVQzY1FyaW9nZUhBb2FQWUExT21ZRG9tVmhFSE9UcG9zdzkveUtL?=
 =?utf-8?B?TEs4VE9nbFgwQi8ySDNkdE43ZVRvT2hKVTcybjJDeXVwdVFEWHBzUVZnUFlT?=
 =?utf-8?B?K0p4WmpyZ0RJTVZuN2dDMmVBbm8yMHF4NWlpUHZWa1IwMGtaUVVmQlVWNGgw?=
 =?utf-8?B?UW84Rm5TamhNKzBueFIrNUp0aEZIUVpZZDFVZlMyTFJXRW5rSm40RmFWUHh5?=
 =?utf-8?B?ck43bC95WW1mMDNuUXNnSXJmSEwxbldzcHNaekE0amljbHpRZG1sbXEzdG1w?=
 =?utf-8?B?V2g2ZktjK0pKdTFUZENzdTU2THpPU3hOY2h5dEI4RFVFUUpnWlJRbm9seGNQ?=
 =?utf-8?B?QnkzRE11WDJmUGRMY1NzOEdtQjlZSGhkdDc3WEJOS1pUaWpGSVpGREMybnV0?=
 =?utf-8?B?ME43MjVKUUZjUkNvcWZXT2VCdnhSNXZkc3JvaWhhUHhPelR2ZU1IUm5sNFVU?=
 =?utf-8?B?Yzgwa21sZExIVHplYUxpdzRYcGd0WDdOM1VVQXZTakpTUUsxK213RzRWYUtN?=
 =?utf-8?B?Z2hVc3J1OXRsL1NWMWZzL2xjSjZJOWVWdFRuTEpOT0NLRk9XK1NqS0pnUW5U?=
 =?utf-8?B?R1VUMlVzTlMrWXkrbUxJQWdnV0ZoeEFXckx3MHIxenJCeGxWVTBGY3ozaE4z?=
 =?utf-8?B?TUJ3MHpLSHNaRXVqL1BKWFRtbjRzQ2tkdWViRlRUREFlL1NGdnY5d3BheDht?=
 =?utf-8?B?ZjBRQW1MbXFPNGtsOHR5SEV0dVRaUndnc2VpZ29uVFVMaFFQb2FWUGt6dlZo?=
 =?utf-8?B?VXdaMW5LUnYyRzZQQk9GQ2ZXV1E3UVF5aEZZb2RGVHRLTmRHai9qdVV5V2Fi?=
 =?utf-8?B?MXRWT2xHd1hkZU05emZLaytkblNncERER1NGNEpPOW0yYzFndXhKVitTVnNp?=
 =?utf-8?Q?dAg/X7jprJpNSNl6fYz12X0Z3+INWR6A6xziKQVjv2KJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ACBAE718C403043A89C48E62B6C9E69@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0124582-16b0-4a38-6dc3-08da6b3ad2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 17:02:41.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKMLbKniJt9a0EhplbyFQ7dxDjDGyZnKrn/yYcqgZ5onvri+hCW505vuC7lR6BNfDq8fYFNRNxnhZoYoeshgdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4602
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMC8yMDIyIDEyOjI5IFBNLCBYaW4gR2FvIHdyb3RlOg0KPiBkbyBub3QgaW5pdGlhbGlz
ZSBzdGF0aWNzIHRvIDAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaW4gR2FvIDxnYW94aW5AY2Rq
cmxjLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
