Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920E59E829
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbiHWQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbiHWQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:56:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340B13CFB8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661261191; x=1692797191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jluuRip8XV3q1bnNv9P16C32v7SEiX8DiLvjlflM7SE=;
  b=iAi5ix7NMVMizd+Kz21+gVw0k2v6/i/vDZ5wVMhu6f7h6RA9tQ5td66y
   nt/Jo79Xw9aOwBhzwOc0UGAuhZpE+kBLK/tibprEEDwC9Bnuo1LTQlDFS
   /ysM/UrdZXLSvbaAihrxMB15c4/eEt+tESxVmwPdiRiPqY6c58SnvLd9y
   CWZLJ4eoukO0BuInhVTViJuH+yVZ5pIQct5bbsOQzmk8vzwOxI11He33t
   pT4gpQN4Haw9ApZn1+vnb3o5F8IgSYI+LKLg8BzAYfk+qYv3WbK8nss/O
   IqPOI38IDwjC3Ve2Ldo3AeuHeOmX3W0q+TWaRfQm5XlYd+6r20HW/AO1T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291246539"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="291246539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="585973169"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2022 06:26:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 06:26:30 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 06:26:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 06:26:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 06:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do6kO1Kkk/+BXDu/cCmgnMVctflXHMJYHniPsgCzlRX8vwEi9BdE//5cw3wwqRiYn2l+g6OJVkhtsOFRJB3HA01qQmOMDb0A29S10mp6lJcH7vlE6aYriZ9zADAYkQDNoWTuhB9L+shg8qNbHf2Qqr2k5SkF9MODrCZHbFRFlq6xGnMJJw+8TKOKiSqbORHB7yjKY9PGdZyKC/1GLdMTsWOZ2hAH088lkRx4KuF0r37BwXPLdIosIbMyaqp0/VAW38Dlau9Fo13SjF8iZk3oNQxq3MPyOhe5gTgbYOv0Ks5ge8VZ20sULUbWdi6EEtvL7FTZtWq0+7edBLEPddE3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jluuRip8XV3q1bnNv9P16C32v7SEiX8DiLvjlflM7SE=;
 b=Sl2ewEPzEgwUrEurWyEk/PAAQelb/+QIGreYK8XT0yzWGBpTMigx5HNKC+MDKLr5AxtLFZ9nUK7aEKt9ATYBVOeprOQGopRtk11enR0NUZZvVPZUfPS3V804byjjUjUtkopUj190tg/tlmtxoFHigKIFslnthlMgYoNZWk0FniYxUjna3pZk/VP1Fh84gg1P/dEI33ts+/NFEwAUfRTLk1ZSFVWp5UGGIwfWuHba2y3p3ZzRtHyRGinAk0QjD4Oskjpm9Bi21IkhFet3QknJcj9I1QVPvs/iriHb5VtlDeMTvXc+95yytw4F/Hv63CWi97FphZ7UAjuxoOysTP3Ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by SN6PR11MB3071.namprd11.prod.outlook.com (2603:10b6:805:d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 13:26:28 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 13:26:28 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Topic: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Index: AQHYsRbT4TRHNhnl3UqDOo236vL4WK2yYX0AgAnshQCAADdpMA==
Date:   Tue, 23 Aug 2022 13:26:28 +0000
Message-ID: <BYAPR11MB3495477AF580B94D1EA75108F7709@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
 <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
 <36925544-8127-fe0c-76e5-49138dff45ae@redhat.com>
In-Reply-To: <36925544-8127-fe0c-76e5-49138dff45ae@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158694b4-c8d7-438c-a9dc-08da850b15b3
x-ms-traffictypediagnostic: SN6PR11MB3071:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5oZw40c7q+ScQRv2VCYnH8mwJsSo+k8ugoVrmXzlzb/ojera/qRIoQ8Atpkl+zd3IP3275jsH20xOGLiFZqPOvu39faM1dbBQ/RFs26ngBXSzZ6J69w1K3NGL2Yww4MrClDHvGk4djTkMmlDtNefC/gvFCtneB8zuTz3044lZiSMm3wBKFOKg6B68r4Y0ClH8uplT/IazvpGdSJjcQe7UGHZEqGQpF9Dsb53VpnNCy9o3R6sPyTBq98NOV9BRe0JA+IyntRXScl/pnlp6Twa6Z9Ux9hSIJY2AKvvBebt54vfA4zusVBfsaICRvpLF+mw9HKRf+6WcOCjUChIAIhRyqIRBRIUMUMlqMqT+4ljTKPBmoRut4oe9cgVigaO1ZFS0kG5d7kwYO/4BA4F7bbwTggDrg6+tbkhvqUID8ptpP0QffnlqxUUMsOxLMcQ6hNLgS6p0rFvwDoWUk6LRwoFL4oJiHZz/KazHJ6vBAFO22/RdIteybrjRBoQk6g7EjK5o+s9hR4SCuApbd5ebFGDPtCQCoCqLheZxJu8qRyFutmgOiFg+0s8T+DJhFyHzTrrv/MiKG2t4fSevlsvsfnrjtwGjiYHELGTvJGDnLBTH6aRr8TUr+piVT2EoFEDy0k4HNjcFYfHlNCpj/azIklBvTz5cufpbDQE9kpTdw60fRB+1h096e2vHH59MHP5+ZgLwTZgD8Z9EePZGrm4YGoFFEunp8gfcXaLi8Ss1Ijy4cSdudRVeqT6n3YsCZF15kuH4GzKcRTd4uMTiyx0Xgt+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(186003)(316002)(55016003)(110136005)(54906003)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(38100700002)(66946007)(76116006)(86362001)(41300700001)(53546011)(7696005)(9686003)(26005)(6506007)(82960400001)(38070700005)(478600001)(71200400001)(2906002)(122000001)(7416002)(5660300002)(8936002)(52536014)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTBIcFpNM0NUSDkzbzM5UytRSVgxbkhYYlA0UzBiSUg2K05YdVBPbVJONjFP?=
 =?utf-8?B?SllQUTZhaXBhbWJaNkJWQklxelQ5T0tIM25FbUNKNTg1cG1odTNQVnZwOFNG?=
 =?utf-8?B?VnpqN1RkTWNSblYzTjBna0dwbWp6azBZSjRnV1VhR3FLN2FVSWxoUWtyZktS?=
 =?utf-8?B?bE80OXhnK1M5QkhXMEFPc0pNV3ZPRmVJV0ZFRVI1cVRONk9BWGlxYVBxUWZP?=
 =?utf-8?B?aDhYcEZVa0pEYjc3d2VpTzg1OHpFbmQ4YllUZ0Q1anVYbGg5R3JIbDJFRXNT?=
 =?utf-8?B?QzVpZ2dlaWFiZkZVRVJmZk4vbElOVjJMdTR6clUwOHpSY01vbjNaUG1mbHBs?=
 =?utf-8?B?MmI4dFFURmNxTFdaUUtaNzJOWEJZZjgvckszKzZBeVBCdjBSWWc2cVhFZ3FW?=
 =?utf-8?B?azduY1MyK0IyM1I2S08zU1JyS2RnRVdoRG9sMjJSWThPdDNpS2hyNzM4anNT?=
 =?utf-8?B?NWpjQnIzdWl2dFVMU2dXd29TSk12R212MWJuYTFXWDJ5NU44Y1FiTEtkZGE5?=
 =?utf-8?B?MDBPNE9ycFZKWmpVWDdlYzVGbDB3THZrNUlpYXUxVFUydzVQRWhZdmw2Rk5W?=
 =?utf-8?B?QUhKS1NnWEg2Z2VFb0JmUCswMmQzcGZrdVRyQjR2R0hUQ1JBWTlSVnAxUlNT?=
 =?utf-8?B?VGRjVFJoa3Q3eWt1VWFRN0dHRGdaOURpOWc3YW9hdHJTUEZQd2EyWlRGUzBu?=
 =?utf-8?B?Z1c3SXNHZVI4VXRwUjJ5cWVjcmFkYmNhVjE5TXlORFN6SFRTUCtYWGxCbDd0?=
 =?utf-8?B?QWVnc3MyZWFzdnNiNnBOUjVFeGVwZnhkS3YyTjdxVk91QVoxR0pHcGRtOWth?=
 =?utf-8?B?M1BnY09hZm5sK293Q1g3clAxV3dzK3dSbjFRaE5Hak5lNk5rcXQ2bmVkOHdN?=
 =?utf-8?B?cmpFQ2s1dFQ5eVZsWEU5RGx1ZU1qdlFmZzNhVE5oZFlRWGVkVExseGlkL01G?=
 =?utf-8?B?VEtSemZqWGRFQUxIc3VWQ1JvYWQvcWlpWjRLVFB4WkY2S0d6NWZGNlN2UWF3?=
 =?utf-8?B?Z2ltSGwyZ3VrZ3JkaUd0Zk9JSEsrZnU1aUdzWDhxeVVVZXJOT1hLKzYrQlhF?=
 =?utf-8?B?eXdFbEJmOU8yTUFFbGxkNnhaZjRxbXFoY0tSVlRrZ0NMcTFBMm9ER3hmc2ZO?=
 =?utf-8?B?YnhDcUVhZTZBbmp6ZVVVQ3l6VnVIaEFpK3B0bWE5UGNkQmhnVTJsV0NzNzF0?=
 =?utf-8?B?Y0c4RDAzcnZnSDB3bCt5K1pnWmhjNHVrM2JPaWtJVWY2SExFY3BUMWpqYzB6?=
 =?utf-8?B?amtoUFdyZXhhckpKWldxY1FtREw2NjN0MDE5QStGY0ZtaDB6d3ZmQVpoM3Qr?=
 =?utf-8?B?aDJsVmlzMUt4NGhOMDFiSC9HOXJHVmpnWTl2NDVLVDZjcFdJT2hWQ2IzcWx1?=
 =?utf-8?B?MkN2eWlCZUNrS3UzZVVqcTlGOUFDaWlsa3pWUUtxTjZ2YkhkUEhGNjJGb0c1?=
 =?utf-8?B?S3dmZXFyc0VwaDZuTFU2Y0tZNWhqMGh1UmF1T2hMazJvL1lIRzNUYWJXSDB0?=
 =?utf-8?B?OXFzY1JZdGFwUGJVWU5VS29JQ0ZyS3pFTjR6aW1CMHhLeVk4VVJqMVdCd0Uw?=
 =?utf-8?B?L0RZYUVIWGJYZHdUbVc0bXE0MHlNTFp1clFaU0VVSjVSeER0QldoZ0UrWUhr?=
 =?utf-8?B?SXRiZy8zOHFCdzRpTDRFRkNtOEFOZ0ZGQTEzSUVNSnZuQnZqKzFWalAzSlhN?=
 =?utf-8?B?WXdtVGdONDZOcW11djllaXN4c1BHQlFtL1JiK29acHVjMVBQVlJuMkF0bkNB?=
 =?utf-8?B?VC9zV08rcmxMMFJ0cUJZVm91cWNwakFKUXZEYjFZNlRYWkRRR3VkN3V5ZFlN?=
 =?utf-8?B?R2ljSFArWHNuaVU0NVVhZG1UOEZCVzE0ZzBOT2ovMXgvUDNHV2wrREtkTk1R?=
 =?utf-8?B?THpMMkVXTGUrdkpyT3lLSU12aHQ5KzgzZGdVbnNqSm1HbmFRZ2tUc3ZSZFd2?=
 =?utf-8?B?REVtdFNkNUIvd3NEUDFCUEVaTEorOE9hSU85RVlFNFEzSFhjZFRGRzBTS2dQ?=
 =?utf-8?B?WWpLMjVrNW91Z2tJT1dDcDZ6aXRjSExkRTFvQUpXcjBERG9XYlVZLzlhUGFu?=
 =?utf-8?B?bzhVQ1VUOVRYWWFFdXNmR3pjMXV2SVBGUHoveUt6UmlaL0djYklzTjB5K0ZP?=
 =?utf-8?Q?HMUHUuyjIkv5zT6QOKj4t1rK/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158694b4-c8d7-438c-a9dc-08da850b15b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 13:26:28.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yko9rt/FNfrdtYeFL5xmE7tb3EXHoXBPyKC2iymWx9BU8bs+BYkHy188oyBxXL8pUbrYT/5nbU5MsMgdS2H73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3071
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDE4OjA3
DQo+IFRvOiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT47IFdhbmcsIEhhaXl1ZSA8
aGFpeXVlLndhbmdAaW50ZWwuY29tPjsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBhcG9w
cGxlQG52aWRpYS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IHNv
bmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsgbmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldjsgYWxleC5z
aWVycmFAYW1kLmNvbTsgRmVsaXggS3VlaGxpbmcNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi8yXSBtbTogZml4IHRoZSBoYW5kbGluZyBOb24t
TFJVIHBhZ2VzIHJldHVybmVkIGJ5IGZvbGxvd19wYWdlDQo+IA0KPiBPbiAxNy4wOC4yMiAwNDoz
NCwgTWlhb2hlIExpbiB3cm90ZToNCj4gPiBPbiAyMDIyLzgvMTYgMTA6MjEsIEhhaXl1ZSBXYW5n
IHdyb3RlOg0KPiA+PiBUaGUgaGFuZGxpbmcgTm9uLUxSVSBwYWdlcyByZXR1cm5lZCBieSBmb2xs
b3dfcGFnZSgpIGp1bXBzIGRpcmVjdGx5LCBpdA0KPiA+PiBkb2Vzbid0IGNhbGwgcHV0X3BhZ2Uo
KSB0byBoYW5kbGUgdGhlIHJlZmVyZW5jZSBjb3VudCwgc2luY2UgJ0ZPTExfR0VUJw0KPiA+PiBm
bGFnIGZvciBmb2xsb3dfcGFnZSgpIGhhcyBnZXRfcGFnZSgpIGNhbGxlZC4gRml4IHRoZSB6b25l
IGRldmljZSBwYWdlDQo+ID4+IGNoZWNrIGJ5IGhhbmRsaW5nIHRoZSBwYWdlIHJlZmVyZW5jZSBj
b3VudCBjb3JyZWN0bHkgYmVmb3JlIHJldHVybmluZy4NCj4gPj4NCj4gPj4gQW5kIGFzIERhdmlk
IHJldmlld2VkLCAiZGV2aWNlIHBhZ2VzIGFyZSBuZXZlciBQYWdlS3NtIHBhZ2VzIi4gRHJvcCB0
aGlzDQo+ID4+IHpvbmUgZGV2aWNlIHBhZ2UgY2hlY2sgZm9yIGJyZWFrX2tzbSgpLg0KPiA+Pg0K
PiA+PiBGaXhlczogMzIxOGY4NzEyZDZiICgibW06IGhhbmRsaW5nIE5vbi1MUlUgcGFnZXMgcmV0
dXJuZWQgYnkgdm1fbm9ybWFsX3BhZ2VzIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogSGFpeXVlIFdh
bmcgPGhhaXl1ZS53YW5nQGludGVsLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6ICJIdWFuZywgWWlu
ZyIgPHlpbmcuaHVhbmdAaW50ZWwuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgZml4
aW5nLiBMR1RNIHdpdGggb25lIG5pdCBiZWxvdy4gQnV0IEkgaGF2ZSBubyBzdHJvbmcgb3Bpbmlv
biBvbiBpdC4NCj4gPiBTbyB3aXRoIG9yIHdpdGhvdXQgZml4aW5nIGJlbG93IG5pdDoNCj4gPg0K
PiA+IFJldmlld2VkLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gPg0K
PiA+PiAtLS0NCj4gPj4gIG1tL2h1Z2VfbWVtb3J5LmMgfCAgNCArKy0tDQo+ID4+ICBtbS9rc20u
YyAgICAgICAgIHwgMTIgKysrKysrKysrLS0tDQo+ID4+ICBtbS9taWdyYXRlLmMgICAgIHwgMTkg
KysrKysrKysrKysrLS0tLS0tLQ0KPiA+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL21tL2h1Z2VfbWVt
b3J5LmMgYi9tbS9odWdlX21lbW9yeS5jDQo+ID4+IGluZGV4IDhhN2MxYjM0NGFiZS4uYjJiYTE3
YzNkY2Q3IDEwMDY0NA0KPiA+PiAtLS0gYS9tbS9odWdlX21lbW9yeS5jDQo+ID4+ICsrKyBiL21t
L2h1Z2VfbWVtb3J5LmMNCj4gPj4gQEAgLTI5NjMsMTAgKzI5NjMsMTAgQEAgc3RhdGljIGludCBz
cGxpdF9odWdlX3BhZ2VzX3BpZChpbnQgcGlkLCB1bnNpZ25lZCBsb25nIHZhZGRyX3N0YXJ0LA0K
PiA+PiAgCQkvKiBGT0xMX0RVTVAgdG8gaWdub3JlIHNwZWNpYWwgKGxpa2UgemVybykgcGFnZXMg
Ki8NCj4gPj4gIAkJcGFnZSA9IGZvbGxvd19wYWdlKHZtYSwgYWRkciwgRk9MTF9HRVQgfCBGT0xM
X0RVTVApOw0KPiA+Pg0KPiA+PiAtCQlpZiAoSVNfRVJSX09SX05VTEwocGFnZSkgfHwgaXNfem9u
ZV9kZXZpY2VfcGFnZShwYWdlKSkNCj4gPj4gKwkJaWYgKElTX0VSUl9PUl9OVUxMKHBhZ2UpKQ0K
PiA+PiAgCQkJY29udGludWU7DQo+ID4+DQo+ID4+IC0JCWlmICghaXNfdHJhbnNwYXJlbnRfaHVn
ZXBhZ2UocGFnZSkpDQo+ID4+ICsJCWlmIChpc196b25lX2RldmljZV9wYWdlKHBhZ2UpIHx8ICFp
c190cmFuc3BhcmVudF9odWdlcGFnZShwYWdlKSkNCj4gPg0KPiA+ICFpc190cmFuc3BhcmVudF9o
dWdlcGFnZSBzaG91bGQgYWxyZWFkeSBkbyB0aGUgd29yayBoZXJlPyBJSVJDLCB6b25lX2Rldmlj
ZV9wYWdlIGNhbid0IGJlDQo+ID4gYSB0cmFuc2h1Z2UgcGFnZSBhbnl3YXkuIEFuZCBvbmx5IHRy
YW5zcGFyZW50X2h1Z2VwYWdlIGlzIGNhcmVkIGhlcmUuDQo+IA0KPiBJIGFncmVlLg0KDQpPSywg
d2lsbCByZW1vdmUgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBDYW4gd2UgYXZvaWQgc2Vu
ZGluZyBhIG5ldyB2ZXJzaW9uIG9mIGEgcGF0Y2ggc2VyaWVzIGFzIHJlcGx5IHRvIGFub3RoZXIN
Cj4gcGF0Y2ggc2VyaWVzIChwcmV2aW91cyB2ZXJzaW9uKT8NCg0KRG9uJ3QgdXNlICctLWluLXJl
cGx5LXRvPScgd2hlbiBydW5uaW5nICdnaXQgc2VuZC1lbWFpbCcgPyANCg0KPiANCj4gDQo+IEFj
a2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gDQo+IC0tDQo+
IFRoYW5rcywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCg0K
