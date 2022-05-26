Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F61534742
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbiEZACY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345893AbiEZACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:02:18 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137D19037;
        Wed, 25 May 2022 17:02:16 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PIEvXA030157;
        Wed, 25 May 2022 17:02:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=SPnoPyODjpRWTZrcRKKc3tOa2Twqu28Nae/Sb1clfyk=;
 b=Hp1tuHTukFjkl+iWwv5nVjWREx6X9iJWPOlgMOg/egxO7NGu4DTk4WSOm9pCHDdZdAQC
 auunJY/xsoEGsfLEME1yuuAlBneSOEibPa2LvfpaG1Cj/lxPVjhcrtP3g7iGhtXic4+E
 zftGzsPJfvxq+zuLWjvcF1k0WWCfhcmJ4X0zqyEguAQ+pMXjZUrpIq/S8VIG41pV2wLZ
 i2WiBa68ZIWUj/5O0dAyDLiMmu4O37LxLLTvLeQrkcYSEcUtFdPAsKM2WwRgWhZ+XLyK
 e9SF96FAD92EUrB8JlmkDw2UNx84mnYf2xPL+I/ToHYVLhQ6f6a0rfKwvq6M8r9Aon7Y 6g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3g93vb36c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGxSOVWL+RAWm92gYlKOU8x1vOxfgUljZ5LRt5ZDbxgwazqaCjQq2KRrHuLONE9WoTqgeAn6uk3ckcintrpkT9IBJcZA3wM5DpiGZ9Kzc7o71ep6pTcKzH8zWp33V6v4mkZDcckPE4sD1K4/r9qmE5MvObvEVDSwkyjdStZSDf6Lap95t4+xOanwbQjhJmsjjB0MnExZ8QbazXnu+HhyAJ6X8vbPMrvQjDidMZqybGbX1S0fGw9lh36uqhvxpYhlsnOcm+XnHFEsXtCzTTzNuOQLh+9vIb8BmUO4k1+ky7g5s1ir0yf5uMQuYnT4K9hY8oBwtpxtRy/v16lCZ68V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPnoPyODjpRWTZrcRKKc3tOa2Twqu28Nae/Sb1clfyk=;
 b=YqBRs/63dXsclB4XiXK9quE1njbziT3w4BvR4Cu0fLgqMCjXtIh/OxS+Z5lofcXY7FvZ3pX7IwsiWAwGelefA7Fm4wXf35YLiI+NgxN3MgZhUDokkaDNzPmKAQfeLd/1gSfh7DdWxgk153/SzcSm6q0gl1gZXeUVlSTs6Ow6+2E7n6TbTzIJ6jKtmMtlJ3E9YrUpESvJr/ZXhMj7d68tUHT5lmp1qliiVbtMXYCQj/B40GUnAOOmVP/OJjF6W6p83DjPrrq0UxWFEo//MdSnM+gYT/Y2gD9s1+/CDVHBek7tLy0RNscnILmnxlHx2Eicdx8G3i8JU8yv93/Pl3Lj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB6399.namprd02.prod.outlook.com (2603:10b6:208:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 26 May
 2022 00:02:00 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3%5]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 00:02:00 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>
Subject: Re: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Topic: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Index: AQHYbwBVMVcdSUyOvkKa597s5rjAfq0vw8EAgACF4YA=
Date:   Thu, 26 May 2022 00:02:00 +0000
Message-ID: <684B8F16-CD02-452D-9D52-F60D5147500E@nutanix.com>
References: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
 <20220525120248.5cb37817@gandalf.local.home>
In-Reply-To: <20220525120248.5cb37817@gandalf.local.home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d539a49f-208d-490a-b2d6-08da3eaaf520
x-ms-traffictypediagnostic: MN2PR02MB6399:EE_
x-microsoft-antispam-prvs: <MN2PR02MB639935329DDF2766132098A180D99@MN2PR02MB6399.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5UQQm7N9bnLpci5/SpJAMLrmDe17zTAoecCTO0fEvNLYdpWqaTnqJMqcOeqtfMTEm5slb+TB7Z+zjgL6vZYAh1v7TyoDsVSgakNAQd4WkEDpFatgMidhfJPPjqOuJlTaFPDZt0IXwgv1OeHrrHblTEfPeTHFzChydr+Vbg/dVL32n8zzxZUB6el6AI9FRIk/2g9lmD6+H7LN58yRUOhQpz14DKZpXTc9ahHhNXxxMn/EJLWZZpilywGlmNjd+U00uw190ugzgf7a8JFZ5TBzIrMUhdHvagZQYuw2FoNH1d8elrGODwMKhWO1CG4OwebPW4d9EnIeQbGc43I4CCH34mCjJIzxPDdh9TUEUgRHafS/S5tccBmbdnOHFJThoRLaPQEmgh6McUr1sVuTcJuwnss5TvLoYS6hV0vjrB8geeuaIh5gLk0vjtYISr8v9oK3T+RUe3i3Vkzs2hvbiGDH31M8JgsjRdkLXYjXYL8MT9VJ6gkmVn7j3i39PmDFjDwCn+wcEGyovNz+52mvPohJC0lDmQi0tdnsVYJ348ouZO/w1W3bktXds7mub9Lr4KU/l4699yn52TG2UuKGHY6Ags/KA72HDqRsoqORSh0v8Ux/c3cqOmmX3dIha91F2sbJTmsw4KtbMDBmkravoUtMmFPtP1NlqMwfwyW0eneO59f62LJdxsHmelamhueYXbr6rhnt2HS/9BCXKMAeJOv0ZPXxONSxbufqBh/W/PNmOQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66556008)(66476007)(66946007)(8936002)(44832011)(38100700002)(76116006)(91956017)(66446008)(4326008)(36756003)(5660300002)(186003)(83380400001)(71200400001)(6486002)(508600001)(54906003)(33656002)(2616005)(6916009)(316002)(122000001)(2906002)(38070700005)(86362001)(8676002)(6512007)(26005)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWJOTFg1WnhHTjlVMVRQVGZhWXVkOHU0QWtXUGRkYmh5TEJPTEtVZjhNdE1n?=
 =?utf-8?B?Z0VZUWVuVnhzY3pYOUo2Z0xRSFBjRTNtZWR2WTk5Z2h5UTdIMEhSQjNhMXJC?=
 =?utf-8?B?SXk3MWRCSjhrMFFrRUJMdXhtaGRBSVVCeXUrWEdjZTBJWVJZYkQ0TExMc3M5?=
 =?utf-8?B?aDVtTG9ic1NaWEZBcDZ6RXBHMVdSd2Iyc3hpcTgyb1ZNK2o0T2hLMjBrRCtX?=
 =?utf-8?B?ZkJONDNDcGFqSEV6U2JEcmoyUWpVUFJKei9ibXo1WTUvNXMyYkpUZkN3TFJS?=
 =?utf-8?B?TGF1ZnFaQmlUYkVEV0JTUE1nMENGdjRJOVNtNm1qQk9OYVlqb2QwL1RIbkRY?=
 =?utf-8?B?QlNKOS8zYTBSR2c3Nm1tMVRZQnlBZkt5K0tCaTB2cHFxQVRnbU5RV3YvalJ1?=
 =?utf-8?B?N3Y2aEZKbC9HeTJxYTRNQ29wU1F2L2FSL05VVmd0ajFNaG1KRjFiQWJNTEhZ?=
 =?utf-8?B?T0IvSE1VcllDVXcvSDBqMFhHWXlCYnlTUmNFT0pVWHpHSHJmeVN2WlhHUjdi?=
 =?utf-8?B?ek5UbDRQTkNhRWRjTnRXOXo2RDhFc2piN2hMZmRoM2tScW5mbG9EM1Q0ay8w?=
 =?utf-8?B?Wnk4eEY3ai9SRU15NUxVSTQyUGo5VVRyTmc4em1JZnZxMGVnZkU1eVIyVERF?=
 =?utf-8?B?THhJYXVJUkxESFBMWFZTd2tBTVZ3Q3lIcERkeXFVcTlERHJxREMxUUlkVk10?=
 =?utf-8?B?emEyUThQS0hsSCs0eHZKVm5QUFp0SWJwbUw1UmpreW81WkxxaGxCTkZ6NnJV?=
 =?utf-8?B?cFNuNFFSdFl1MUc1OHpMTFhaY3RoT3JiZWFuYVVaN3RzQzNJTzJOQnVPV2lS?=
 =?utf-8?B?dHQ1L1pxRTZKS3czS2MvVEQ4TTVKQUQ3Z3BHblJtU1NLK1RBZitESDYrbEtE?=
 =?utf-8?B?d1pNb1pTVG4wNUl3UnNpQkpSdm5rTEU3a2Jlc0VLZGVDWnRnTnhNUi8yWnlT?=
 =?utf-8?B?ZUppVVQ1cFdyZlFnRjRVbkNLZzdXbnpydzc3OE1mTGNRbEQ4YVkrN1lKczVk?=
 =?utf-8?B?VGd6WDZiQkdGWlROM1JadzFuQnYxZHlGYklhWVZWbXJiUEFhVEoveDkzVk9M?=
 =?utf-8?B?d05HRENvR3lHcFBTckNXM3VUVW5ZaTQzVDVKUUdJK1N2SjRZMDZGdndiWC96?=
 =?utf-8?B?UUtPYXRQQ2RBdU9zKzFNd01tU1ZmRi9YMUcvZ1pYdkdXUThrYXhabmZpdzJt?=
 =?utf-8?B?NGpZYWYydFgrK1JzQzFEZzlHUkxMbUZBL2dkRERIMTlzemdVd2dVTm1kYXF3?=
 =?utf-8?B?SlJFaDluQ1BYdGxiM2pBSHRkeW5CNW56Z0hUWGZ4dnI0ajlha2xZK29CNGxV?=
 =?utf-8?B?UDF5WHZJaWlMeFhkOThRUWhLZUZsdmNScUp6cVBVMHpZMGxvUktoS2dWWHNn?=
 =?utf-8?B?anFvOEpqY3laRHBrdGZIYStERnQ4RjhPRk9JTUxyWW1uU25JSDh2L21Nclk3?=
 =?utf-8?B?dXBQbmQ3Wlh3UWlpSWtlbWhYRjUrYThKb2o3ekY2elRidEtiTlRuSUZnQzdD?=
 =?utf-8?B?NS9mYkpGMXNzeFQ3Y1I1Q2xLVW5jNjREYmt1aHB4bW1oMURhUDNjeTlYekNS?=
 =?utf-8?B?dHdXR2QvVmpMUmJKK2Z0WUxvWTBaV09wSTdDeDhvaTVyN0d6Sk9SaTFuYjRD?=
 =?utf-8?B?ejdKUzVxZVBhT0tGb04vYlNGOU5mUnNMQW4xdmNDaWFHbjlHSWFLZG5DTmJm?=
 =?utf-8?B?US9WVDRwdk0rVzhtNXFhRFNIL0h5ZDh6c0pFNktJbUpLV3BXRUJEd1Z1NS9V?=
 =?utf-8?B?MDBnc2dMTHJWUy9qU0ZPQmVkdHlwNWI1UGoyZm5sQk9YelBBY0dIWkFQSXVx?=
 =?utf-8?B?SDBSUVpsbGtaOVdob2pFaDZQaHo3VTZyU3IzUFNyYjZHc1Z3bXV5ajVkT3RI?=
 =?utf-8?B?VWxaN3J4OG92U2tkQlNoeDIya3Fvc2ZEK3A2VWpJd1BKOUZwbWlXL3hNc0pL?=
 =?utf-8?B?eFNhV2VyUythRllaY2xyUDc3T2l1YTBmdmFoU3E1Z0JxN3BTUFdpWUxHbWlP?=
 =?utf-8?B?RXBnKzJHZXdqZWtIOVNJWjBMVTNCUkFiY0VoeGZJSXZwcHRnY281UUs3WElh?=
 =?utf-8?B?NVBSeFdzQ2pOK2FsTVIrQ29XcmQ0Mzk3S0JNWEprRjBQa2V2Y3ZSY2dIL2lx?=
 =?utf-8?B?OGhXT2h3WXZ0Tm0xRHp1SkdNOHIvSEZUa2dVUjJRUzc0TEJ0RWI4c2E2Zmpj?=
 =?utf-8?B?SStZcXBvOGExUHZqNkxrbTZPbGpIWGlDSU9LekZudjJXa1RrNkZpcTQrbG5E?=
 =?utf-8?B?UGlWc05rVVJBU0RYSVAyc3J3RllRdU9yakpwUUFtbFQ3N2VTYlpoVjAvb0xJ?=
 =?utf-8?B?eWhDZjh5NTMzd21raVFFY3Mydms3ZmpDMFFCYnBaZFpSOHU5T1BNUjRENU92?=
 =?utf-8?Q?mnHjYIAUogm8guPY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2DB074AE51E62449546354559FF941A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d539a49f-208d-490a-b2d6-08da3eaaf520
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 00:02:00.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwZVF4srcGvGbQPd0xoUoepMXPU1hgOp8Ur9QJxxUWEKZg92lveFTD6z67YOoIzR5tzZypYnU8NkB3YNNivgfZlCXZoeRrcoh5zXK77oGUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6399
X-Proofpoint-ORIG-GUID: 2XuZ91xlEq9h0r7QiE1VgYUaF6cbkLWF
X-Proofpoint-GUID: 2XuZ91xlEq9h0r7QiE1VgYUaF6cbkLWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RldmVuDQoNCj4gT24gTWF5IDI2LCAyMDIyLCBhdCAxOjAyLCBTdGV2ZW4gUm9zdGVkdCA8
cm9zdGVkdEBnb29kbWlzLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIzIE1heSAyMDIyIDIz
OjUzOjMyICswMDAwDQo+IEVpaWNoaSBUc3VrYXRhIDxlaWljaGkudHN1a2F0YUBudXRhbml4LmNv
bT4gd3JvdGU6DQo+IA0KPj4gQEAgLTkxLDE2ICs5NSwxNyBAQCBzdGF0aWMgdm9pZCBhZGp1c3Rf
cG9sbF9saW1pdChzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwgdTY0IGJsb2NrX25zKQ0KPj4g
CQkJdmFsID0gZ3Vlc3RfaGFsdF9wb2xsX25zOw0KPj4gDQo+PiAJCWRldi0+cG9sbF9saW1pdF9u
cyA9IHZhbDsNCj4+ICsJCXRyYWNlX2d1ZXN0X2hhbHRfcG9sbF9uc19ncm93KHNtcF9wcm9jZXNz
b3JfaWQoKSwgdmFsLCBvbGQpOw0KPiANCj4gV2h5IGFyZSB5b3UgcGFzc2luZyBpbiBzbXBfcHJv
Y2Vzc29yX2lkKCk/DQo+IA0KPj4gCX0gZWxzZSBpZiAoYmxvY2tfbnMgPiBndWVzdF9oYWx0X3Bv
bGxfbnMgJiYNCj4+IAkJICAgZ3Vlc3RfaGFsdF9wb2xsX2FsbG93X3Nocmluaykgew0KPj4gCQl1
bnNpZ25lZCBpbnQgc2hyaW5rID0gZ3Vlc3RfaGFsdF9wb2xsX3NocmluazsNCj4+IA0KPj4gLQkJ
dmFsID0gZGV2LT5wb2xsX2xpbWl0X25zOw0KPj4gCQlpZiAoc2hyaW5rID09IDApDQo+PiAJCQl2
YWwgPSAwOw0KPj4gCQllbHNlDQo+PiAJCQl2YWwgLz0gc2hyaW5rOw0KPj4gCQlkZXYtPnBvbGxf
bGltaXRfbnMgPSB2YWw7DQo+PiArCQl0cmFjZV9ndWVzdF9oYWx0X3BvbGxfbnNfc2hyaW5rKHNt
cF9wcm9jZXNzb3JfaWQoKSwgdmFsLCBvbGQpOw0KPj4gCX0NCj4+IH0NCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3Bvd2VyLmggYi9pbmNsdWRlL3RyYWNlL2V2ZW50
cy9wb3dlci5oDQo+PiBpbmRleCBhZjUwMThhYTk1MTcuLmRiMDY1YWY5YzNjMCAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3Bvd2VyLmgNCj4+ICsrKyBiL2luY2x1ZGUvdHJh
Y2UvZXZlbnRzL3Bvd2VyLmgNCj4+IEBAIC01MDAsNiArNTAwLDM5IEBAIERFRklORV9FVkVOVChk
ZXZfcG1fcW9zX3JlcXVlc3QsIGRldl9wbV9xb3NfcmVtb3ZlX3JlcXVlc3QsDQo+PiANCj4+IAlU
UF9BUkdTKG5hbWUsIHR5cGUsIG5ld192YWx1ZSkNCj4+ICk7DQo+PiArDQo+PiArVFJBQ0VfRVZF
TlQoZ3Vlc3RfaGFsdF9wb2xsX25zLA0KPj4gKw0KPj4gKwlUUF9QUk9UTyhib29sIGdyb3csIHVu
c2lnbmVkIGludCBjcHVfaWQsDQo+PiArCQkgdW5zaWduZWQgaW50IG5ldywgdW5zaWduZWQgaW50
IG9sZCksDQo+PiArDQo+PiArCVRQX0FSR1MoZ3JvdywgY3B1X2lkLCBuZXcsIG9sZCksDQo+PiAr
DQo+PiArCVRQX1NUUlVDVF9fZW50cnkoDQo+PiArCQlfX2ZpZWxkKGJvb2wsIGdyb3cpDQo+PiAr
CQlfX2ZpZWxkKHVuc2lnbmVkIGludCwgY3B1X2lkKQ0KPj4gKwkJX19maWVsZCh1bnNpZ25lZCBp
bnQsIG5ldykNCj4+ICsJCV9fZmllbGQodW5zaWduZWQgaW50LCBvbGQpDQo+PiArCSksDQo+PiAr
DQo+PiArCVRQX2Zhc3RfYXNzaWduKA0KPj4gKwkJX19lbnRyeS0+Z3JvdyAgID0gZ3JvdzsNCj4+
ICsJCV9fZW50cnktPmNwdV9pZCA9IGNwdV9pZDsNCj4gDQo+IFlvdSBhcmUgd2FzdGluZyBzcGFj
ZSB0byBzYXZlIHRoZSBjcHVfaWQsIGFzIHRoZSB0cmFjZSBldmVudCBhbHJlYWR5IGtub3dzDQo+
IHdoYXQgQ1BVIGl0IG9jY3VycmVkIG9uLg0KPiANCj4gIyBlY2hvIDEgPiBldmVudHMvc2NoZWQv
ZW5hYmxlDQo+ICMgY2F0IHRyYWNlDQo+ICMgICAgICAgICAgIFRBU0stUElEICAgICBDUFUjICB8
fHx8fCAgVElNRVNUQU1QICBGVU5DVElPTg0KPiAjICAgICAgICAgICAgICB8IHwgICAgICAgICB8
ICAgfHx8fHwgICAgIHwgICAgICAgICB8DQo+ICAgICAgICAgc3lzdGVtZC0xICAgICAgIFswMDRd
IC4uLi4uICAgIDE1Ljg3MjcxNTogZnRyYWNlX2Jvb3Rfc25hcHNob3Q6ICoqIEJvb3Qgc25hcHNo
b3QgdGFrZW4gKioNCj4gICAgICAgICBzeXN0ZW1kLTEgICAgICAgWzAwMV0gLi4uLi4gICAgMjIu
NTU1NDE4OiBpbml0Y2FsbF9zdGFydDogZnVuYz1mdXNlX2xlbl9hcmdzKzB4MC8weDMwIFtmdXNl
XQ0KPiAgICAgICAgIHN5c3RlbWQtMSAgICAgICBbMDAxXSAuLi4uLiAgICAyMi41NTU0MjU6IGlu
aXRjYWxsX2ZpbmlzaDogZnVuYz1mdXNlX2xlbl9hcmdzKzB4MC8weDMwIFtmdXNlXSByZXQ9MA0K
PiAgICAgICAgbW9kcHJvYmUtNjQzICAgICBbMDA2XSAuLi4uLiAgICAyNi43MzczNTU6IGluaXRj
YWxsX3N0YXJ0OiBmdW5jPXdtaWRldl9ldmFsdWF0ZV9tZXRob2QrMHg0Ni8weDEwMCBbd21pXQ0K
PiAgICAgICAgbW9kcHJvYmUtNjQzICAgICBbMDA2XSAuLi4uLiAgICAyNi43NDI0OTE6IGluaXRj
YWxsX2ZpbmlzaDogZnVuYz13bWlkZXZfZXZhbHVhdGVfbWV0aG9kKzB4NDYvMHgxMDAgW3dtaV0g
cmV0PTANCj4gDQo+IC0tIFN0ZXZlDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KSSBh
ZGRlZCBjcHVfaWQgYXMgdGhlcmUgaXMgYSBzaW1pbGFyIHByZWNlZGVudCDigJx0cmFjZV9jcHVf
aWRsZeKAnSBidXQgSSB0aGluayB3ZSBjYW4gcmVtb3ZlIGNwdV9pZC4NCldpbGwgZml4IGl0IGlu
IHYzLg0KDQpFaWljaGk=
