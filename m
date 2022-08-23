Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB559E88D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiHWQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiHWQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:58:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97835148083
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661261389; x=1692797389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4q8q+AnqvTfEBilat7zKjsbVUErnVTRo9Fmk7fF3zRY=;
  b=EYfx4NruCb2fFpcTzl9l7CC9gB87u4+Q8fmf6t/9jIzxnBD7keoXFGij
   GkuRCiFaUSdyUGqUcpkDzEcFSzY4lptsrjo3BU5VcmaF1Ie180w5uoxzO
   mlJHT+wcWHDCyfX1RneqcCTpBHimWuQtyBxBhqVzx7hYB3QrUhu/WFJ02
   Xia5k1P+FIWN25aERepKQ1e0i/jLYHQFiQ+3IJtRF2GB3zLjgF4MaiLyU
   BvJZ4ewlH9/EBDvuIOX+QmQWIb90zt5b263RMeH+GCoDU4HowxLYjdWKk
   DfcZy4kNQbsJlWSSczYY6TF/B8v2aqWuxA/ntb8AAqeHiLFLUZhIK/keU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276712773"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276712773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751686523"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2022 06:29:48 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 06:29:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 06:29:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 06:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLSahGMecmHk7li+8crFLsxHBBXMo1hp/JPXPjKtIzF01+U5nmTzS5rzwtUw70EIQ9ECnLzyWaPOT1/n7K6HDZf/67A1OhioM4PZb4/mmyuOnzajaqJuWySxI1TNh63oOu/V5ukMNAVJhrMVX6kZihTlrT6TpeZFOMJw7WZtaDbrt9yoTZh9xlwsixtPnCMuJq6646Alc59BBOnTbbso2EX+jt/cmKqeLJsuaj8SlchuDnMBM95oZ56RmNHW//NkP7UW1LbBdqGUcGTPdB6aBx+V0DdGHyHM830Q05YEg2pA7aXXotNL77B50aUK+mlBhflKJ8I8Vp9aSrRn15QTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q8q+AnqvTfEBilat7zKjsbVUErnVTRo9Fmk7fF3zRY=;
 b=LdjMRWba78WpmWJbdqqngw99ikHjwOqoJxF03IkBeQsjThx3FdIQte2FGVsWGJIeQ4AOu0I95aWC6E/lHlif8GWfB0XBUV+MaUr3QsbOllcy461DF6n178moPxhg0jg8Ziz3Z8fhgZMu7nYM4NyjrMxn7pXKVi+SXuYeRxt7x/a7dhLW3KSZtqoamZ2tHrF4xvGXM1yZatI3Dbx5YH4/8JE/CrXEet/DkSpATihKZ/prT8RhPOwT4ABmJdsBqEcLwCOEhKSDDbI/NOjRHKiXPRPsUGRhviUerr0bIFWIQQpDBQeIbqpDvPSs5t7qvUT1LznWWwGfd20+GNuCYafg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by BN6PR11MB1857.namprd11.prod.outlook.com (2603:10b6:404:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 13:29:45 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 13:29:45 +0000
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
Thread-Index: AQHYsRbT4TRHNhnl3UqDOo236vL4WK2yYX0AgAnshQCAADdpMIAAALQAgAAAUqA=
Date:   Tue, 23 Aug 2022 13:29:45 +0000
Message-ID: <BYAPR11MB3495AA8A91C2E2D9492C38B9F7709@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
 <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
 <36925544-8127-fe0c-76e5-49138dff45ae@redhat.com>
 <BYAPR11MB3495477AF580B94D1EA75108F7709@BYAPR11MB3495.namprd11.prod.outlook.com>
 <1206b559-2917-2ce0-6c54-ec78727b826d@redhat.com>
In-Reply-To: <1206b559-2917-2ce0-6c54-ec78727b826d@redhat.com>
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
x-ms-office365-filtering-correlation-id: 5d8a607e-d0e2-4578-fb38-08da850b8b4c
x-ms-traffictypediagnostic: BN6PR11MB1857:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuxlaZYtmy44MbSRkOztr3q6M39W3l7rOSBAA8X5pEDkWPNCtLsRurheBz1N5MmuScNT3e1sn/1KFol8BaUgSZTXcbWG+S1KZKnCkFFVjz88qYl51bP5kyeoDrTXaiCEynyiq/PlCotRsDYVIp7dd0MBNR8ov4auAI9a4G5nUfXmTHTi24MA6t/to0eUDytB4Gx5JS6pY2WvsNTg9AgjUU5T54JyRzcazsufjipfvClX9uRzQzVXjrKFAvdABXUoAdxuBOCkjsUpJCv77QMgeLb5DxsAtcSkxcZttGF3ti64mWNtxzEWW2nQWkFmZNtCHkDpZq9vmszSOZRaxIAcRWidNpb1dymSsjkihPvZM/st3NY6DhtvwwHlsYZmwiVm5ifcck7wK5M7uBEgk6LrvOOY2eWlJuBk9a0iatkWb9rKh/JaMdbwecFOqSCD6S6JWMnVeuLYs4uyy6zFLTcBVj7fSvBS4wh5OMI0cCrLWmUzIwN9K0ebZ8WB6CBe7Y/A476QfIq04WWu23r5V+nrwkJUILo0qPmDg0XnVXOTVMT5/2GdSkn4QuhexRXVxyi9qRt2A7iiCxyiYLlFek9ljXWqc7OHd/MMuEjaUfgTbwtzA4EBX2NhAhxtbKJxvOvZKGFZicy1maBBd+PLSddidk6+D43dEJ92g5iKrad1d3JJFdiiN5L1GigrhHSMpeabbPpnvfAN+KUujHiHtvKodzxCEOun8Z00NK6qPoyaI8ikKcIMJU4rqIvGdePni9bPzESNZ4ur+LKYwvnJXNp7lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(366004)(136003)(33656002)(7696005)(6506007)(41300700001)(83380400001)(186003)(8936002)(26005)(9686003)(478600001)(52536014)(2906002)(53546011)(5660300002)(71200400001)(55016003)(7416002)(316002)(54906003)(110136005)(64756008)(66446008)(66476007)(4326008)(8676002)(66556008)(76116006)(66946007)(38100700002)(122000001)(86362001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWxjR3ZBYVRqTXRDMnBKOTJYS1gzY3FDS1I1eC9ZWjE2VUFkQXU1TkR1dHdW?=
 =?utf-8?B?MHFPOXU2d1N2WDlvNXVxS0h6MUk5SllCaFpkVTNuOTdNWTQwNnFWajdLdE4r?=
 =?utf-8?B?RzBudkRxYW5udVpJY00vc1p2VDQ3WDUvMTdPSDA5UkZvNWVtN1JicCtpL29m?=
 =?utf-8?B?N2ZOR2FrZERYQ3djeW5LZGlZM01MMlVJbUx2bC9qN05zbk5BNGJxR3o5RmI0?=
 =?utf-8?B?ZlVnVjZFVnZhU3UxSHZHYko0NTlPSVY0VG5ZWmQzek5PWE5pQ1UyRnNndnFZ?=
 =?utf-8?B?QTllYzIreXB6aC82Tk1pTmpqdGJlZXgvc1VuWEJXR0JwVGllTFpKZjN5UDRW?=
 =?utf-8?B?N3d0QjJFVklVZ3MraFFRdGVUY3ltUndhZEJhSVRSRWxWOXRMTFN1NXYrNW0z?=
 =?utf-8?B?RWpzRlNudG5wTVFLVmM3Sk14WFVpMmhUbzZCUVAvWjJsR3AvTmFyTHRZbWlV?=
 =?utf-8?B?V04wYWIwdGZaMjZjNEJmTTdUeGxMMEJkZWtZY1R6clZLbEpNRmhpdEQyOXhh?=
 =?utf-8?B?VjRjTXJ2NmFRMG1DSHdZTURKbGh1cUxxVW5KNkJzNDJSNnZWbkNreEJKWFZU?=
 =?utf-8?B?SjUvSG9VMTc1Sk85ZjBmN0VKa3V1RGRnYm1vZ1hCZ0dtMmQxY3VET3BxWktk?=
 =?utf-8?B?RUVzVFpUQnVSdFBsRGhGREZFVG52WEt2TGxHZUFYNlBWVW1wVndSczVkQXpX?=
 =?utf-8?B?a0FRZk93bW8renBMeFQ4RitWaUIzOEJ1cXpKM05GUnJqdEt0bDZlYUR4UmNH?=
 =?utf-8?B?cVdBMkI4eGNHZ1VDTE1qT080VG5TUFVFWGI3bXBXZXBmeFdSVU54bUxJeWhT?=
 =?utf-8?B?Vmg1WmFUR0tkbDM0SWlkSFFSdmxZTjlwTGNwWXYrd3RaS0p6OHVuZ2VGNzlw?=
 =?utf-8?B?dytCMTNqNUI0dnphS1FPbjQvMCtsMEFoVHFDYkgydkJ1S2FWYi9waXY4NTFn?=
 =?utf-8?B?QkhmZmUxWHc3dzNPRVd0TklxWFBzcmkrUTUydmlSRjN0ZVQ2UjNtb01CUXhi?=
 =?utf-8?B?aU1xQTdhUFFDV21NK3diSzBjUEZnTFVscVdNVzR0dGx2WHJvNHU5eTR6NFRW?=
 =?utf-8?B?UU5oWTUxNEFSU05SdGpINzFMdjBQQk1xY0NkUzl2OTNyMmF5V2Q3bGlvY2ly?=
 =?utf-8?B?aUFmYm1SSEY2VkdkV1VNZCtzT09oVXZQWGhYQkorS3lGT2JRVHBkWkJWcTVk?=
 =?utf-8?B?RHRXQXZpR3lGRFZHK2dOVkhXekZmbS9UdUtmOW5od2dnQ0lsM0ZPR1REckhU?=
 =?utf-8?B?TkZFR0dzN29mSWwrWStZekg1QjFZc05NN0hoSUZCR05GZmtHaEdLR1l6VkdG?=
 =?utf-8?B?RmwxVkZ3Nk5WNDBNS3FPc0QxK1UrK2JVYXY5b0s3MXVCYlBBNGpZY2RGbXlC?=
 =?utf-8?B?MVh2T0RFdTZ2TjlXTXJMbzR6OWo0NzU3TUpuQk9YU1JRUkVQTCs1MU1GQVlr?=
 =?utf-8?B?bHhLUGZNVGxlWWhDem1KSktqczZtL0c5VWRDUFg2SEM3NDZlTnVna1BRUzlq?=
 =?utf-8?B?dm1SeEZ2NTViWkdLWE05NUpoREtieDZvOVlRU0RDU1dYTExFdE5TbS9PRllY?=
 =?utf-8?B?a2w5TFM1dkVuS1Q1WEVYOGdOSzY5RVpWdTkyRTEycVRJdzRnazR1ZVBQM2g1?=
 =?utf-8?B?dU04TGp3OGREcXY5OCswVmxyKy9QbVpRbE1FcVAwQmY5U0V1S1J6S2wzV3Nl?=
 =?utf-8?B?ZXNvVk8zeGpmMk1wSTBNRjlOV09WT1dWc3lXSFRldW0zUHlpYWVWU3RkOGdv?=
 =?utf-8?B?elQ4U0dDQTYvWXJmczZIaVpZY3ZXL0ZxeG5vSldmN1FDcnVsb2RuVE5QSGI4?=
 =?utf-8?B?NHF1U2M0WDZVYm91OXpsdmQ2UnJ4VDF2NlhnSHhBY0hzeDByWVdSSytzVFZ1?=
 =?utf-8?B?SWFoRGdzaklscUZTRTA3czZGWWNrbDVZT01KR2RCR2toYTc3YTJBTUY3dTFr?=
 =?utf-8?B?WURoWWROaE9xNThmU0JXdmd6NGtMcnRwdDNHSFJad1NCSmlqUGpaakN3cko5?=
 =?utf-8?B?aVFGVW5hYVJjYlE2Z3BGVXQxL21pV3I3T29wVjV3UC9hSU11MTQ0OXd6WVda?=
 =?utf-8?B?QmNHSWg0VUFKaS93NXJqNnN2MzZXcy8rZHA5aTRKamE3KzJJMGgxZW9MLys4?=
 =?utf-8?Q?uffI6A5e5fTKXkEfd7T93fjaW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8a607e-d0e2-4578-fb38-08da850b8b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 13:29:45.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfQyo0t0V/eHtypWmKjPgtgkj9I+tLS87H/jfbBrsYwHuzzZZJJbMm9zjpwAsc3+tjnCoSQXdP9sfdQ28El8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDIxOjI4
DQo+IFRvOiBXYW5nLCBIYWl5dWUgPGhhaXl1ZS53YW5nQGludGVsLmNvbT47IE1pYW9oZSBMaW4g
PGxpbm1pYW9oZUBodWF3ZWkuY29tPjsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBhcG9w
cGxlQG52aWRpYS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IHNv
bmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsgbmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldjsgYWxleC5z
aWVycmFAYW1kLmNvbTsgRmVsaXggS3VlaGxpbmcNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi8yXSBtbTogZml4IHRoZSBoYW5kbGluZyBOb24t
TFJVIHBhZ2VzIHJldHVybmVkIGJ5IGZvbGxvd19wYWdlDQo+IA0KPiBPbiAyMy4wOC4yMiAxNToy
NiwgV2FuZywgSGFpeXVlIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDE4OjA3DQo+ID4+IFRvOiBNaWFvaGUgTGluIDxs
aW5taWFvaGVAaHVhd2VpLmNvbT47IFdhbmcsIEhhaXl1ZSA8aGFpeXVlLndhbmdAaW50ZWwuY29t
PjsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+ID4+IENjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBhcG9wcGxlQG52aWRpYS5jb207
IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+ID4+IHNvbmdtdWNodW5AYnl0
ZWRhbmNlLmNvbTsgbmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldjsgYWxleC5zaWVycmFAYW1kLmNv
bTsgRmVsaXggS3VlaGxpbmcNCj4gPj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi8yXSBtbTogZml4IHRoZSBoYW5kbGluZyBOb24tTFJVIHBh
Z2VzIHJldHVybmVkIGJ5IGZvbGxvd19wYWdlDQo+ID4+DQo+ID4+IE9uIDE3LjA4LjIyIDA0OjM0
LCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+Pj4gT24gMjAyMi84LzE2IDEwOjIxLCBIYWl5dWUgV2Fu
ZyB3cm90ZToNCj4gPj4+PiBUaGUgaGFuZGxpbmcgTm9uLUxSVSBwYWdlcyByZXR1cm5lZCBieSBm
b2xsb3dfcGFnZSgpIGp1bXBzIGRpcmVjdGx5LCBpdA0KPiA+Pj4+IGRvZXNuJ3QgY2FsbCBwdXRf
cGFnZSgpIHRvIGhhbmRsZSB0aGUgcmVmZXJlbmNlIGNvdW50LCBzaW5jZSAnRk9MTF9HRVQnDQo+
ID4+Pj4gZmxhZyBmb3IgZm9sbG93X3BhZ2UoKSBoYXMgZ2V0X3BhZ2UoKSBjYWxsZWQuIEZpeCB0
aGUgem9uZSBkZXZpY2UgcGFnZQ0KPiA+Pj4+IGNoZWNrIGJ5IGhhbmRsaW5nIHRoZSBwYWdlIHJl
ZmVyZW5jZSBjb3VudCBjb3JyZWN0bHkgYmVmb3JlIHJldHVybmluZy4NCj4gPj4+Pg0KPiA+Pj4+
IEFuZCBhcyBEYXZpZCByZXZpZXdlZCwgImRldmljZSBwYWdlcyBhcmUgbmV2ZXIgUGFnZUtzbSBw
YWdlcyIuIERyb3AgdGhpcw0KPiA+Pj4+IHpvbmUgZGV2aWNlIHBhZ2UgY2hlY2sgZm9yIGJyZWFr
X2tzbSgpLg0KPiA+Pj4+DQo+ID4+Pj4gRml4ZXM6IDMyMThmODcxMmQ2YiAoIm1tOiBoYW5kbGlu
ZyBOb24tTFJVIHBhZ2VzIHJldHVybmVkIGJ5IHZtX25vcm1hbF9wYWdlcyIpDQo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogSGFpeXVlIFdhbmcgPGhhaXl1ZS53YW5nQGludGVsLmNvbT4NCj4gPj4+PiBS
ZXZpZXdlZC1ieTogIkh1YW5nLCBZaW5nIiA8eWluZy5odWFuZ0BpbnRlbC5jb20+DQo+ID4+Pj4g
UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiA+
Pj4NCj4gPj4+IFRoYW5rcyBmb3IgeW91ciBmaXhpbmcuIExHVE0gd2l0aCBvbmUgbml0IGJlbG93
LiBCdXQgSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uIG9uIGl0Lg0KPiA+Pj4gU28gd2l0aCBvciB3
aXRob3V0IGZpeGluZyBiZWxvdyBuaXQ6DQo+ID4+Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IE1pYW9o
ZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiA+Pj4NCj4gPj4+PiAtLS0NCj4gPj4+PiAg
bW0vaHVnZV9tZW1vcnkuYyB8ICA0ICsrLS0NCj4gPj4+PiAgbW0va3NtLmMgICAgICAgICB8IDEy
ICsrKysrKysrKy0tLQ0KPiA+Pj4+ICBtbS9taWdyYXRlLmMgICAgIHwgMTkgKysrKysrKysrKysr
LS0tLS0tLQ0KPiA+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL21tL2h1Z2VfbWVtb3J5LmMg
Yi9tbS9odWdlX21lbW9yeS5jDQo+ID4+Pj4gaW5kZXggOGE3YzFiMzQ0YWJlLi5iMmJhMTdjM2Rj
ZDcgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvbW0vaHVnZV9tZW1vcnkuYw0KPiA+Pj4+ICsrKyBiL21t
L2h1Z2VfbWVtb3J5LmMNCj4gPj4+PiBAQCAtMjk2MywxMCArMjk2MywxMCBAQCBzdGF0aWMgaW50
IHNwbGl0X2h1Z2VfcGFnZXNfcGlkKGludCBwaWQsIHVuc2lnbmVkIGxvbmcgdmFkZHJfc3RhcnQs
DQo+ID4+Pj4gIAkJLyogRk9MTF9EVU1QIHRvIGlnbm9yZSBzcGVjaWFsIChsaWtlIHplcm8pIHBh
Z2VzICovDQo+ID4+Pj4gIAkJcGFnZSA9IGZvbGxvd19wYWdlKHZtYSwgYWRkciwgRk9MTF9HRVQg
fCBGT0xMX0RVTVApOw0KPiA+Pj4+DQo+ID4+Pj4gLQkJaWYgKElTX0VSUl9PUl9OVUxMKHBhZ2Up
IHx8IGlzX3pvbmVfZGV2aWNlX3BhZ2UocGFnZSkpDQo+ID4+Pj4gKwkJaWYgKElTX0VSUl9PUl9O
VUxMKHBhZ2UpKQ0KPiA+Pj4+ICAJCQljb250aW51ZTsNCj4gPj4+Pg0KPiA+Pj4+IC0JCWlmICgh
aXNfdHJhbnNwYXJlbnRfaHVnZXBhZ2UocGFnZSkpDQo+ID4+Pj4gKwkJaWYgKGlzX3pvbmVfZGV2
aWNlX3BhZ2UocGFnZSkgfHwgIWlzX3RyYW5zcGFyZW50X2h1Z2VwYWdlKHBhZ2UpKQ0KPiA+Pj4N
Cj4gPj4+ICFpc190cmFuc3BhcmVudF9odWdlcGFnZSBzaG91bGQgYWxyZWFkeSBkbyB0aGUgd29y
ayBoZXJlPyBJSVJDLCB6b25lX2RldmljZV9wYWdlIGNhbid0IGJlDQo+ID4+PiBhIHRyYW5zaHVn
ZSBwYWdlIGFueXdheS4gQW5kIG9ubHkgdHJhbnNwYXJlbnRfaHVnZXBhZ2UgaXMgY2FyZWQgaGVy
ZS4NCj4gPj4NCj4gPj4gSSBhZ3JlZS4NCj4gPg0KPiA+IE9LLCB3aWxsIHJlbW92ZSBpdCBpbiBu
ZXh0IHZlcnNpb24uDQo+ID4NCj4gPj4NCj4gPj4gQ2FuIHdlIGF2b2lkIHNlbmRpbmcgYSBuZXcg
dmVyc2lvbiBvZiBhIHBhdGNoIHNlcmllcyBhcyByZXBseSB0byBhbm90aGVyDQo+ID4+IHBhdGNo
IHNlcmllcyAocHJldmlvdXMgdmVyc2lvbik/DQo+ID4NCj4gPiBEb24ndCB1c2UgJy0taW4tcmVw
bHktdG89JyB3aGVuIHJ1bm5pbmcgJ2dpdCBzZW5kLWVtYWlsJyA/DQo+IA0KPiBZZXMuIFRoYXQg
bWFrZXMgaXQgZWFzaWVyIHRvcCBpZGVudGlmeSB2ZXJzaW9ucyBvZiBwYXRjaCBzZXJpZXMsIHdp
dGhvdXQNCj4gaGF2aW5nIHRvIGRpZyBkb3duIGludG8gYW4gZXZlci1ncm93aW5nIHRocmVhZC4N
Cg0KR290IGl0LCB0aGFua3MuIDstKQ0KDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBEYXZp
ZCAvIGRoaWxkZW5iDQoNCg==
