Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5A5AFA15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIGCnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIGCnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:43:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEADA792E1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn0iJr/uTlZpjHICKg9CUGEEgJg3KB+9KX3FK8uq7PW7gTzPxM1qniwnvykN4yFCq/+RG4CjIMqUlgCpj5sqos16CkauYvo22ewiei/O6sbSkh2IuNWJNtc0IixcmSU8s9Yri24pXbEr03ip29O9k8oUNFGDKIR41oySeCE2lbRd6oXHKJszYE+pFzHEY4ysOT8lFeZkIxKqFG4iQRjPm3sP6WTIM81yYDhE96/6VPE02BpkitNgtAC0+gG3Y2ko3KK/swd8HQyHCXPqVe56c+9G46wWKZ0HlMtGfa1mfu2RADpzbvB5SPkJLtxQZfkHzMt2ZO+TewgdmHyl6OoOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stk0ASZEmo+jh4SLMUQAWSyrJwbRahQbQn/eYZGDKpU=;
 b=c2drChDbAF/vHVCv6FV9+WuLKqwHrcBM2s5TRo8Eqt8/hQK6BDBUIdHIyTNBiXhSKdacfNqdThUEjKPzMzOoLkRq/Xc/xuwt83VU6/jlqE6Gzl0hKDK48y6qUUw7DgRPAKAt5yFVyg0BJULxp8fvw32L9E0dB/FUonlzP5C+a8IOKiZpjtis7U/r7spJWhHaLSc3omOkACDQ1uLh77lCEAKQBluwMxCVJJjq17YqFGOxE3RMnOAF8hxjj44oMgIimSCFZJ96FWBsb5KE4n1LQ58WPSWf5hIPIdPP9hKZ9x6Gc+xu+7Icow3EEVoN3z7uCq14Tir21IZ1KGNsGZw8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stk0ASZEmo+jh4SLMUQAWSyrJwbRahQbQn/eYZGDKpU=;
 b=tgC0wpJ9Wqo4kYJCAv+v6HLOR1kxaTdSyweoPcnu+ezsU4mrL6lVLM1dDJsedHx6yatPE/UsPbnMkoJQyjkLCmIdoKSfj5TloRcvTzHzweqLgyUYJ2HImJF9qpr5RKnGqpBOgHE9yTUjc2r2uPrFWDBHaZkq1YBtn3RzHEnY8ESSg04OoZ7x71bsdC2U3xPlQqgiwm65+tiEBi0VKWAumRC13BVYU+BRUVgt4HH26PIyzSzmHtnUJavWCGwAz5oWKPxPZeyRD+3qIBC4uaXfivMjpxsVggaJiwqFNVvYr2Fq8/cSlBnsjOEdwkS3dwZBB006vhwVQV9sBUC4EgLC7Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 02:43:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 02:43:47 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Topic: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Index: AQHYwcPRcm6CrzlLu0+cYsV2b6mBrq3S8p0AgAALrACAAEV9gA==
Date:   Wed, 7 Sep 2022 02:43:47 +0000
Message-ID: <36b16998-3720-cc30-3ee8-b4d92c3b266d@nvidia.com>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
 <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
 <8154fb0a-4cda-a4bc-29ef-8435a3edb264@opensource.wdc.com>
In-Reply-To: <8154fb0a-4cda-a4bc-29ef-8435a3edb264@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 581ff2fc-beb1-46d6-4c13-08da907ac9ff
x-ms-traffictypediagnostic: LV2PR12MB6014:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pRFAII8vyvHvwzDIkmTesHCtf3qz0fQCUCe58aKX+TakCnCXgRsfmAEHOSQW7dUxmniNJilQWu4Zjd3ZxAjY7kfLm4IeM2D1T2c6hB+JpabNY5eRUTZQpCkU88ZJizhirjNkJSnLGpUX+V3fSm7VDeor5DARNrp1nDy7yHosnxhgtdwtv5KcHRwXgmvP0vSCo+vef71O0qEveJuRMKBYaUB3zUH20kcIFPKyOUpXXnItnRWIAl+5SssdFtx2u3PGB46k95Ik96WYiNMXWeYzSb4i4OufY7e0NBkFxqj2uWaJX9ilcdKiyKx3Z6eLi2tF5TPneQZewx3yrGldI/fK98/6yKK4pSYOsh/v4htgvJoflFTcwEt62bWciDp7chyp10MC8d/FUEwtLIzOmLTp6i0KpCS85JVaeezqzRpLPbOIlu21owKAkqEibSskjs/Q+3t1RV+p9T5lQHNil4s8+Id8dwT+K/UuR+bQH3omtxGgeKvaZ94V63qq+pnrAXqbtHhANptBxkAjVrDPAYuCs1q8jqX9yJXJgaGpqOYYkCXzi3BQPxmxjn9YKQnyqZuj38u3ZqwLkK0bUQ22cygK9e/1k5KTwW+9PSt8FJ1HQ2HKEiAIundMf8TS6ke5utzX4ht4SK1pTeQA5UT5bAcrxLUu8q7hEmcfqVAZOGverpFSAoMaC7T1mtt4S7zqChMCPdnxzfU6oRXwovS+u0dycGtaKBpOOnhmDesw4+XfIz0ZSv58TWjszGcJrvRSDXI7p4SvDZaI3KjbdM3V7AgjbgexJWqCKvCYCOJLLnzR0Mx/ZiQTnRg1sHQ8oTEg4I2+9dMyIAqFnn9gj7JgIG0pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(76116006)(110136005)(2906002)(36756003)(4326008)(66946007)(66446008)(6506007)(64756008)(478600001)(41300700001)(71200400001)(66476007)(8676002)(186003)(54906003)(6486002)(6512007)(2616005)(66556008)(122000001)(316002)(91956017)(38070700005)(5660300002)(31686004)(83380400001)(31696002)(8936002)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFRzMHlpUXUvV2wrUU5TZk1QdzRHTm5OQTczVDFGdUNmUUVPSHlucHdxTE84?=
 =?utf-8?B?L3V3QnUzbkVvUnI1Q05yYU9NS0plMzhBSW1VdUtpQnNWekJMSk9ZMGRiemJJ?=
 =?utf-8?B?KytIZmswbzJyRUFHNDd3eUcwMXBqZ0xOcVBmUnAvTEMrY0g2cjEyYnEwUkZC?=
 =?utf-8?B?UUp1OFEvQys2UFlLUG15Qm9qK2REWURQMlU1a3lmVjdzamFCZWVMN2VGblF5?=
 =?utf-8?B?N3NydVY2SDBrUFFaaDJ5RkJHSjI5R0hEeS9VWElKTVNHNDg3Zis2UU1TUnBy?=
 =?utf-8?B?a1dzdDVKZzcvZEFYQkdidG1PZG1rUURjaDVKV2p1UnFKaFNOWkFKQmNiSUxk?=
 =?utf-8?B?SUtQbVdWYStsenAyQlJnRVc2S3plbjZPMkRMZW9qd3dPSEF2RUt4bWZETmtx?=
 =?utf-8?B?Y3IwYmZNTEd5eVYxWjdnbGkwWEJaSGlzalRkMFNQaDlsbmlxUkQ5aVorb2NX?=
 =?utf-8?B?bXFhRkh0NnF3NlppK2d4eFg2QUI1N1piMDFkVlMybjNEcmcwQ3NQMnVoUmlt?=
 =?utf-8?B?ZDZoUU14Y3FmdFNYUmVIcHBZR1hzZldrUjkrQlAzM1NLbTN0S1MvR0d4K3Uv?=
 =?utf-8?B?Ni9CdC9PbVdBUFRnbnZEUURzelZvbmpwblJ3dVhMUWZISWVlYlZaTmhhY016?=
 =?utf-8?B?Z2hSRjRUZEkvYnJLWm1RMkpNSzNKeEZpQzdUZ1JvRTJmZUVlanlsNnhPYUpl?=
 =?utf-8?B?ZTJ6Z0VSUHVhbGJMU2swZXFvL2xucGdZcmVvWEFHL2FIYXkrOS9YOGZySTRU?=
 =?utf-8?B?OTBzbUVvUDhrVlpiZGVKMWlnQml4QWRlYUYzRTRMWEhZVXRhVGU4cXFEbG1K?=
 =?utf-8?B?QmJqQWwvaUV3QnZEREc3dmRNcGhpOFcrczRac2FXUHNSbEFuMVJ1Z2lka1dx?=
 =?utf-8?B?ckd2VkFzSFdLYVcwYy9ibHRIcHhOMUdzRU9zSENnL0luMDAyRDRhdEpJejdV?=
 =?utf-8?B?Y044SVlza0FvNFRDdjhJSENMc3hCdWlYajVBSnZKdXdLL2dvdGJuYSsraEpG?=
 =?utf-8?B?MHA0N2tJdEs0K1VIOUpvRnBWSHZJVHFXdElQd0FvSXpndEVCV1QwRjVPVTRS?=
 =?utf-8?B?U2JnaGw1VHdwUU15djQxTm8ydTR6RjJpN0NvV2RDZkZpSGc5V3p1WXdQRHRs?=
 =?utf-8?B?R3g5Mzk1MFN2TFEvQ0xnK0lCa1B0WHpSTUx6aUN4NVZaV2ZkRFNsemN6STZG?=
 =?utf-8?B?MlpDWDkzMkVqYmFrTjVaWHlUajU5YXpTaHdybkRzeUJtQzcyK1k2b2Y0SXc5?=
 =?utf-8?B?dDRBZkMxWTNrS2xyUW9GVitoYkFxRHhkSzNaSnZmWTJneVBIS0VibFhjV2JF?=
 =?utf-8?B?R0V3VUFtMUJCekJSVEoxQzc0VGc5d1VRczhKamRLYjQraXpJdlcyTlZMZHQv?=
 =?utf-8?B?TkFWbjBTeVk3U1dtc1E4cXkwYXB5RGJRZjZ6V3VMQk1jNWp2Nkh2dDZCMnBk?=
 =?utf-8?B?Y0NXOUdhanJwOEJ0WTlwMjZxTVlpTUVpL2dTRjhyc25LRExoTHZqR1Jha1dW?=
 =?utf-8?B?RjBJMTRFMmNuV0xDdTZtMkM5dlByZ3FBVXdlQzExWmt5TUp5ZGNWdWJ4TldT?=
 =?utf-8?B?ZktpOC93Zy9wa0krMFFmbDIvR2padWtkRDZncWdlQmZ0L1B4TGhvMjVUSjl5?=
 =?utf-8?B?a2VYbTQwWWtISk4yOHJDRUNtNEVsQUpGbkhwZWJaRE42NFBiTm1Gc2RoV015?=
 =?utf-8?B?THFnSzVtUWxCbWdJUVRFYldWQXBNaUFmaDJkOEsxZ0tnUlNrZ2NMZWpMMCs0?=
 =?utf-8?B?SkxXRVNwYjJnZ3BOLytxVXppSWpQcERDaUprL3hTdEQxdFdsUWtFTysyYTJS?=
 =?utf-8?B?NmdBb29Db0J6YzF0T3hkczR4N3hKeTV5WWkyNEVaZXdKSEtaQ2g3NWFOVVN2?=
 =?utf-8?B?b3NrWXhzK2hVUGU3NEM2VWI2MDVGcDZkME85MFZ1M3FtZGJVNWJLWE1haUtt?=
 =?utf-8?B?QkRrWFgvQ0k3c2w5OWhqb2ZaMmh0OHlyb1IxL0trTGJHcWRyUWN4Z2dWbmc2?=
 =?utf-8?B?OXUyNnE5ekdDVHBLNVM4WllNMEptZjZWdlB4MXJzVnJNbVdZVzNxOTRWVmJV?=
 =?utf-8?B?eGczelZKNjVReVc4U1JlcEczOFkzUVlBdi9yaVJ2UTJQeE4ycGtvRnB1Y0R5?=
 =?utf-8?B?Wm1tL2Yvc0lCemRJUEZVanVQSFlURlN0QkF3SHR1REpIN0paQktQNENDVTZY?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D13E1FF58A9544EA98A7D63F379F6E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581ff2fc-beb1-46d6-4c13-08da907ac9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 02:43:47.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38lFfknpyMr1LcXPt5LACZeYEwVosSzfpz82aFCHenKRqdozHm/XbfQ3ca7eqhhOagmwyMo0gThdItFdNjUbag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+Pj4gICAgCWlmIChsZTMyX3RvX2NwdShyZXEtPmNtZC0+aWRlbnRpZnkubnNpZCkgPT0gTlZN
RV9OU0lEX0FMTCkgew0KPj4+ICAgIAkJcmVxLT5lcnJvcl9sb2MgPSBvZmZzZXRvZihzdHJ1Y3Qg
bnZtZV9pZGVudGlmeSwgbnNpZCk7DQo+Pj4gQEAgLTEzMCw4ICsxMzEsMjAgQEAgdm9pZCBudm1l
dF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+Pj4g
ICAgCXpzemUgPSAoYmRldl96b25lX3NlY3RvcnMocmVxLT5ucy0+YmRldikgPDwgOSkgPj4NCj4+
PiAgICAJCQkJCXJlcS0+bnMtPmJsa3NpemVfc2hpZnQ7DQo+Pj4gICAgCWlkX3pucy0+bGJhZmVb
MF0uenN6ZSA9IGNwdV90b19sZTY0KHpzemUpOw0KPj4+IC0JaWRfem5zLT5tb3IgPSBjcHVfdG9f
bGUzMihiZGV2X21heF9vcGVuX3pvbmVzKHJlcS0+bnMtPmJkZXYpKTsNCj4+PiAtCWlkX3pucy0+
bWFyID0gY3B1X3RvX2xlMzIoYmRldl9tYXhfYWN0aXZlX3pvbmVzKHJlcS0+bnMtPmJkZXYpKTsN
Cj4+PiArDQo+Pj4gKwltb3IgPSBiZGV2X21heF9vcGVuX3pvbmVzKHJlcS0+bnMtPmJkZXYpOw0K
Pj4+ICsJaWYgKCFtb3IpDQo+Pj4gKwkJbW9yID0gVTMyX01BWDsNCj4+PiArCWVsc2UNCj4+PiAr
CQktLW1vcjsNCj4+PiArCWlkX3pucy0+bW9yID0gY3B1X3RvX2xlMzIobW9yKTsNCj4+PiArDQo+
Pj4gKwltYXIgPSBiZGV2X21heF9hY3RpdmVfem9uZXMocmVxLT5ucy0+YmRldik7DQo+Pj4gKwlp
ZiAoIW1hcikNCj4+PiArCQltYXIgPSBVMzJfTUFYOw0KPj4+ICsJZWxzZQ0KPj4+ICsJCS0tbWFy
Ow0KPj4+ICsJaWRfem5zLT5tYXIgPSBjcHVfdG9fbGUzMihtYXIpOw0KPj4+ICAgIA0KPj4NCj4+
IGFib3ZlIDE0IGxpbmVzIG9mIGNvZGUgY2FuIGJlIHNpbXBsaWZpZWQgYXMgaW4gNC01IGxpbmVz
IDotDQo+IA0KPiBTaW1wbGlmaWVkID8gSXQgaXMgbXVjaCBoYXJkZXIgdG8gcmVhZCBpbiBteSBv
cGluaW9uLi4uDQo+IA0KPj4NCg0KdGhlcmUgYXJlIHR3byBpZiAuLi4gZWxzZSAuLi4gZG9pbmcg
aWRlbnRpY2FsIHRoaW5ncyBvbiBzYW1lIGRhdGENCnR5cGUgdTMyIGFuZCBpdHMgcmV0dXJuIHR5
cGUgaXMgYWxzbyBzYW1lIGxlMzIsDQppZiBteSBzdWdnZXN0aW9uIGlzIGhhcmQgdG8gcmVhZCB0
aGVuIGNvbW1vbiBjb2RlIG5lZWRzDQp0byBiZSBtb3ZlZCB0byB0aGUgaGVscGVyIGFzIGl0IGlz
IG5vdCBjbGVhciB0aGUgbmVlZCBmb3INCmNvZGUgZHVwbGljYXRpb24gZnJvbSBjb21taXQgbWVz
c2FnZS4NCg0KLWNrDQoNCg==
