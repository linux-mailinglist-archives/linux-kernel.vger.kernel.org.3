Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD94F6053
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiDFNfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiDFNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:35:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E43E14A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649219962; x=1680755962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9qKera1kS3FNY0GCPrF5iXn8OLczEVOQ6vK5obEfMi8=;
  b=IKCAMr2GoSuTpCQTvDuwCAy+UzU73ERAnXVPtBdueITqbzAqZq56Je2p
   fJ+VzAJkHMo3Zgmelkn12Wee8Y892Pey3ZRf2jBoTGYdC6XyeH051RIFP
   tlFaaX5Jk+JvmjKEYJ5iB+SyjSzv3tSd9q/vsT1g5Z6+TCRz0bAfaC1/A
   bh1yri0PfMMbd6K4Qhk1EQYpvbyTkk8EDXVz+tDxWFD5iyZU3rPjG7cNA
   0B6PRSTrNoeSiHbOnGwHGDzR12l1R4c4Bu6bKO9Gv3Sselef9cAsiYX4g
   K89nq2RcMpS2jqNMJKwNUbfjyTI7NTOLCmlapCqeGtP88WV1215tL4oyN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347391727"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347391727"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 21:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="790205264"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 05 Apr 2022 21:39:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 21:39:20 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 21:39:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 21:39:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 21:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEpY8vI7TSb1PixfiVqQVfFIg5TAGS0sHR0THcNoH0eq80wDWDmI7PA04D+UkIhR8Uf/0WqQQvtus66D8sE0jrzWOtjFEscjM1sbUK41aWa8CP8wSVSbGsGPcYqfmT+/xUIbepWgMcdTEB/WnPtJAc9rsnAGiVecLWHHSnazdn1+dn43QJEmz36386bvSHUBR7SBCUa0bYmnvcfgnNK6Ac5u29XOoVvpu+rRQdWQsrjEbPGwbSW0tYy4pUuZXtcBzhWyPtBeFq0e+Azb9PleJOfVK8qAP6xMu+89IUDWzfx3oqm4QBUtPT0EJ7JnxFSoJ2ss2w5dinFkbYFrKy4Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qKera1kS3FNY0GCPrF5iXn8OLczEVOQ6vK5obEfMi8=;
 b=DSVyLjv80l2+N6IQj5YWbB6oUh38kFgNE/ixXxzTpbBx1ARqhnI7zOhuSVezSUWLvHcvGh1/wM5vQAiNU3eVfrvvEF23jcPOfNODEu7looV4+OwjwpJU5a/OHpxDMeg6KPSp4BQynBfMrsJRC6wO1zsxEyrvA2btWgheMZyffSJdYqDVXQZTpM0dhIP0e8mKCKyE2gKilGixPxvtov25UNMc4pLpa/swo5OWvU/moSjAPfe+/XiUFLOTYJ/mbhlheIi1xWC32dHYx0bn16wfjScVuN3l3+Lr66plP/yqPdlSL5XgwQlPXBskpP4IJ/nXjDiXT9sb1eWd5KUztdj9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB1657.namprd11.prod.outlook.com (2603:10b6:4:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 04:39:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 04:39:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: RE: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Thread-Topic: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Thread-Index: AQHYRc7zp74DBEdkEUK28aFOHFLlt6zbOVYAgAB1GPCAAIWQAIAGIHZg
Date:   Wed, 6 Apr 2022 04:39:18 +0000
Message-ID: <PH0PR11MB5880AF5035443BA97E69B95EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220401134649.2222485-1-qiang1.zhang@intel.com>
 <CACT4Y+YrKd=+uJT9UN8QvctPUGKnOgcReYfX41vNuVC0ecWXcg@mail.gmail.com>
 <PH0PR11MB588000A40081EC48536CA7A3DAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CACT4Y+YdRTu=5JhGcbzSra5mTJA4n6mimPSSwXtS=GswRa8CAA@mail.gmail.com>
In-Reply-To: <CACT4Y+YdRTu=5JhGcbzSra5mTJA4n6mimPSSwXtS=GswRa8CAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cf0ac02-9d2a-4855-2ee1-08da178769bc
x-ms-traffictypediagnostic: DM5PR11MB1657:EE_
x-microsoft-antispam-prvs: <DM5PR11MB16577C712EA1691B4BD2EB53DAE79@DM5PR11MB1657.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJUt57+aU73GMLTlVA4D9KKGGbGez3S7oaOiptWrUU+l6LURSus1NSFjDDzqcehaT+2KwUXwzvJ+Incy8ix9nrGnuncJWaUr4Q7JIXQx4V1oGHSk0uE0mfuVn96dse5NAUnQcLO3muKSNdAAaj8NYX98wbUPnp8gph8Ud/ArvxHsooAP9ahNnKIRY6HflalHardTJVEMWBEQPyK/iVShrV8k0L8oXTRHySWC8J3zhMD1x7LAupSE25ZbOpQguH6acSpSb1NYQv4+fO9aSBZvy7g5Ag2wBaQqh8cEPK1V1JdcHbiudNqKzZf+Y9uZDP+DweW4ByPyvqW995uR9CFEX9SpjXmXllBfnMr5yKiKHC0Dp1AWPmRku3ntTFFP2eANEa+SNICQxgTZ7dPiZ/01k6h5661xl7vMayqOCstBUzSbHQOfqdQNCto951XWOH8LA01ZeVvuFp7yF+ur/1fQwp1+iOv7n3HbBeJIzZKE5wE8X8r2gM+jJ3R4bEs12SpCp7TQh5fef6UrtlFmRzVE1MPxbVZGTqNMqoWX0OZJssBocO+W2lSKbcr1iYkqJlO7deyE5OH6YZkrWrZ2hHvK8NzF21qZE3b5vpTF6UeCMSEObjz9sB7tRH26Oa7c0laPIhBqRWyZNqhyknOmcEdKTe3wjSUuSk8jKy1dPecjMcwwQcFq9OqWG52sSnxKl+c4QrZfTkWnuDPX925XqmfopA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52536014)(26005)(186003)(508600001)(33656002)(86362001)(2906002)(7696005)(66946007)(5660300002)(4326008)(66556008)(66446008)(66476007)(83380400001)(64756008)(76116006)(316002)(122000001)(82960400001)(38100700002)(71200400001)(9686003)(55016003)(54906003)(110136005)(8936002)(38070700005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0YvSjR0N0RSUlpHb1ViWlk5Nk8zU2ZBS2ZTeXV1WWgvTE13ZWpqUGFFRFhQ?=
 =?utf-8?B?ZWdLSUx0YWZaWERJaVVhcFRleHZoUTJRc2U3cDk3Qm5YYmRYR2JEbXJRbDA2?=
 =?utf-8?B?M3hHL04yUlUxSHh4QWszSVhGOGlYdGx0MTFSQjh0WWVEMFNiaW1KUkRLdTdk?=
 =?utf-8?B?dXcvZWc4dExLVFlvTStpcTVNY2EwcUdUaFJ4dEs1L2NxWVlsRGhCY0lMRFFl?=
 =?utf-8?B?dmdaVVNHOVFKRC91M1lBV3I4SFUrQWhMS0FDV3g4dlc0SGhFRWQ1NjNLK25L?=
 =?utf-8?B?dGNOVnYwem5yL1o5VVVBMmNPZWxVbGFZV2drV0RKK0RjNjFVNTc1cHcvdXN3?=
 =?utf-8?B?WFNKOGlvcTdaSjJqYUV4OFEyeUYyc2t5MUpQMktlQVBUM3A2SExtdzhOR1lk?=
 =?utf-8?B?WlVjQm9kZkxNSEhRdTBoMVNVMUhwaUk3VkxWRHNsSWg0WXVGUURGNUVUY3pK?=
 =?utf-8?B?bzBES2tSUldJbnlZRysvNXZsSXhhVnNXYnV2YURSVG1pUHY5eWtIMUxWZktn?=
 =?utf-8?B?SlFvTXpTalZiZ3JuRUFsZ2FMWmpXQThlaktzRWU4WGVIaHRCZk83ZkM3SXVs?=
 =?utf-8?B?ZENFSEJaRDlxQ0lheEcvSEJMdUlwL2c1SjA5SHBJNzdDaTNhQnRMUFZVdFZ0?=
 =?utf-8?B?Nmcyc2JmOFpJdGYwWXppRWliUmRpN0ZoTFU1NGJRdDNYc0tGNWhTcVJ4OWdz?=
 =?utf-8?B?Tk1ocEtaeXNDbmlqODEwRUZ6c2tWVy80UFQ5ZGZxWXY0N012dy9JNENTdWtJ?=
 =?utf-8?B?UEVURTlsSmZxWlIrNnB5SWZ1TjR5RnB2ZWgxVE10a3FEK1hRbmhKSDFPUmVD?=
 =?utf-8?B?ZXg1cDU2K3JhMXBkZFloc2ZBbG44ZjlIYysycTFKV3pXdm1oaXJpY0t2eGZR?=
 =?utf-8?B?dG5nSzFpRzRwT1ZCY3ZZdGxYQVFqdmFhMTJhMzB4Zk5pZVh5Tm9UUXVsM09m?=
 =?utf-8?B?RWxrcUlKbkdhbmdEMHZJN0ppZVJxcENwM0V3Sm5RSnRKa2YyaFYyZ1VxSk9j?=
 =?utf-8?B?V3h3SkhtUHVnaDdFUjQ4cUtCcVRBZlZYcTQ5eEhoSzlqTW5xYTdBUmxyWm1U?=
 =?utf-8?B?NXhJODdxYzZOSmI2QmN1UXZpSVNYNzJpZE1naEN1MCtXekVYdWJybzJKTU85?=
 =?utf-8?B?SzkzR2cvK05kNDVHNnZXTXlhcnRSREVDaEJIbjRiTFRteXExSGxXL3BaQ1hO?=
 =?utf-8?B?OXVsdTRoOXVqMFZPaXVGZkhrUWlCNUJZVUxUWDQzbHVicTNQNWtuVGRTSGZ6?=
 =?utf-8?B?QXFPTkdtQUZQalZzNHZoTG5IZUg4VmVyQ290a1A4VjJWLytJNEdZTXBQdkdp?=
 =?utf-8?B?NStsdmlUMVVodVBuT2dxeHRtS05kQjF0enIveU5xQmhpMWUrWkNvTW5TcjMw?=
 =?utf-8?B?N3FrVEo1d1d1bEpGZG1qOWlOTEJ5a0Z3OEYxU2tFaG10S2s5dE5BSSs3Mzd5?=
 =?utf-8?B?ZFlDQ0YyVEJWZmlrcjAwdUNRREo0Y253VnloVktuNStnU0VSY01oM1RiYXQ3?=
 =?utf-8?B?ZlI4bXF4cForNG90K2dHVi85aStDRUU3WXFacU82VDZ5WW1iWTBuZ2RTWWNk?=
 =?utf-8?B?UlhxSTRlamVpTVp1YncrNWZFVEwvUlUzZXNhaG4wV01SWFF1Ukp0Y09ZUVJL?=
 =?utf-8?B?bWVtdUlEd2pZanpKeVZ3NkxlallYTEdFM2s4YWlscDhEQmhSSnQveHd0WGlM?=
 =?utf-8?B?bWpuRDhVdk9wZkRSTzFQSytaeWZoVm9oYUtIeEt2TDdZSStOTkRRRktnSlBJ?=
 =?utf-8?B?ekt0NWtjd0NpSGZha21KVXZneU5hMFhReGxaZmZ2LzNldDFGWjRmc1ZlS1Bh?=
 =?utf-8?B?aTBIbXlmamgxMHpjR0dSNklZS2pyMkdpS2tTWHpEc0FNaUtmaTc1ZXlqZWl5?=
 =?utf-8?B?WFhveVhlSGhpakxma0JwOEVwR084YXVMNGtVVnlESmpuWlcrUlZzOEFIRGt4?=
 =?utf-8?B?dHlNZTZ0TEZYVkxoeW1HUzFNd1B2N2Njb2NEdkFveVhEWWt5aStMMUlBbEpD?=
 =?utf-8?B?YnNFdWJzUS9aWlVCWEtRVk5WK2NBZTFYaDVjT1VpT3Y1NS85MjdDSE9sa0cv?=
 =?utf-8?B?L2llNHM3UXRMZFliVEVNc1gvNEwzVDQ1L094N1pqSGJWNDhoN3BxM2FMTUNP?=
 =?utf-8?B?bEhGOUpWd0VFdU5kODdCdVRhOWNrT3A3a2Vuby9WS1hnRjFSbXFHUXhqYlZK?=
 =?utf-8?B?ekliWFpIUmYrSllnWWt2MDZ2TzdWZEovU1JSaytYNHdwSnFndzNlTy9YM1lx?=
 =?utf-8?B?bTRDKzc1ZzJuZ0JnUE5RUUdreWtEQUV6NlNQeUNiRE94bFl2Q3BjUXJiRXNv?=
 =?utf-8?B?bVpJdW5QYnpsRXV6VnVpOUZCNTI5anR2YmZkZGF4ZzhOenRoUklTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf0ac02-9d2a-4855-2ee1-08da178769bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 04:39:18.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yztZKfia1PPIX1r1nRcDySpMomUUpHmxqL6nH+7jDWNh/kAmVyQMYREsu8xy8McNIjfkqJtTLtsWHH7ZQO+19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTYXQsIDIgQXByIDIwMjIgYXQgMDE6MTUsIFpoYW5nLCBRaWFuZzEgPHFpYW5nMS56aGFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPg0KPg0KPiAgT24gRnJpLCAxIEFwciAyMDIyIGF0IDE1OjQ2
LCBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQlVHOiBz
bGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQNCj4gPiBrZXJu
ZWwvbG9ja2luZy9zcGlubG9ja19ydC5jOjQ2DQo+ID4gaW5fYXRvbWljKCk6IDEsIGlycXNfZGlz
YWJsZWQoKTogMSwgbm9uX2Jsb2NrOiAwLCBwaWQ6IDEsIG5hbWU6DQo+ID4gc3dhcHBlci8wDQo+
ID4gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDANCj4gPiAuLi4uLi4uLi4uLg0KPiA+IENQ
VTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIA0KPiA+IDUuMTcuMS1ydDE2
LXlvY3RvLXByZWVtcHQtcnQNCj4gPiAjMjIgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQ
QyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgDQo+ID4gcmVsLTEuMTUuMC0wLWcyZGQ0YjliM2Y4
NDAtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNCBDYWxsIFRyYWNlOg0KPiA+IDxUQVNLPg0K
PiA+IGR1bXBfc3RhY2tfbHZsKzB4NjAvMHg4Yw0KPiA+IGR1bXBfc3RhY2srMHgxMC8weDEyDQo+
ID4gIF9fbWlnaHRfcmVzY2hlZC5jb2xkKzB4MTNiLzB4MTczDQo+ID4gcnRfc3Bpbl9sb2NrKzB4
NWIvMHhmMA0KPiA+ICBfX19jYWNoZV9mcmVlKzB4YTUvMHgxODANCj4gPiBxbGlzdF9mcmVlX2Fs
bCsweDdhLzB4MTYwDQo+ID4gcGVyX2NwdV9yZW1vdmVfY2FjaGUrMHg1Zi8weDcwDQo+ID4gc21w
X2NhbGxfZnVuY3Rpb25fbWFueV9jb25kKzB4NGM0LzB4NGYwDQo+ID4gb25fZWFjaF9jcHVfY29u
ZF9tYXNrKzB4NDkvMHhjMA0KPiA+IGthc2FuX3F1YXJhbnRpbmVfcmVtb3ZlX2NhY2hlKzB4NTQv
MHhmMA0KPiA+IGthc2FuX2NhY2hlX3NocmluaysweDkvMHgxMA0KPiA+IGttZW1fY2FjaGVfc2hy
aW5rKzB4MTMvMHgyMA0KPiA+IGFjcGlfb3NfcHVyZ2VfY2FjaGUrMHhlLzB4MjANCj4gPiBhY3Bp
X3B1cmdlX2NhY2hlZF9vYmplY3RzKzB4MjEvMHg2ZA0KPiA+IGFjcGlfaW5pdGlhbGl6ZV9vYmpl
Y3RzKzB4MTUvMHgzYg0KPiA+IGFjcGlfaW5pdCsweDEzMC8weDViYQ0KPiA+IGRvX29uZV9pbml0
Y2FsbCsweGU1LzB4NWIwDQo+ID4ga2VybmVsX2luaXRfZnJlZWFibGUrMHgzNGYvMHgzYWQNCj4g
PiBrZXJuZWxfaW5pdCsweDFlLzB4MTQwDQo+ID4gcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCj4g
Pg0KPiA+IFdoZW4gdGhlIGttZW1fY2FjaGVfc2hyaW5rKCkgYmUgY2FsbGVkLCB0aGUgSVBJIHdh
cyB0cmlnZ2VyZWQsIHRoZQ0KPiA+IF9fX2NhY2hlX2ZyZWUoKSBpcyBjYWxsZWQgaW4gSVBJIGlu
dGVycnVwdCBjb250ZXh0LCB0aGUgbG9jYWwtbG9jayANCj4gPiBvciBzcGluLWxvY2sgd2lsbCBi
ZSBhY3F1aXJlZC4gb24gUFJFRU1QVF9SVCBrZXJuZWwsIHRoZXNlIGxvY2sgaXMgDQo+ID4gcmVw
bGFjZWQgd2l0aCBzbGVlcGJhbGUgcnQtc3BpbmxvY2ssIHNvIHRoZSBhYm92ZSBwcm9ibGVtIGlz
IHRyaWdnZXJlZC4NCj4gPiBmaXggaXQgYnkgbW92ZSB0aGUgcWxpc3RfZnJlZV9hbGxmcm9tKCkg
dGhlIElQSSBpbnRlcnJ1cHQgY29udGV4dCB0byANCj4gPiB0aGUgdGFzayBjb250ZXh0IHdoZW4g
UFJFRU1QVF9SVCBpcyBlbmFibGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxx
aWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB2MS0+djI6DQo+ID4gIEFkZCBy
YXdfc3BpbmxvY2sgcHJvdGVjdCBwZXItY3B1IHNocmluayBxbGlzdC4NCj4gPg0KPiA+ICBtbS9r
YXNhbi9xdWFyYW50aW5lLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL2thc2FuL3F1YXJhbnRpbmUuYyBiL21tL2th
c2FuL3F1YXJhbnRpbmUuYyBpbmRleCANCj4gPiAwODI5MWVkMzNlOTMuLjBlMzNkMzBhYmI4ZCAx
MDA2NDQNCj4gPiAtLS0gYS9tbS9rYXNhbi9xdWFyYW50aW5lLmMNCj4gPiArKysgYi9tbS9rYXNh
bi9xdWFyYW50aW5lLmMNCj4gPiBAQCAtOTksNiArOTksMTcgQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgcXVhcmFudGluZV9zaXplOyAgc3RhdGljIA0KPiA+IERFRklORV9SQVdfU1BJTkxPQ0socXVh
cmFudGluZV9sb2NrKTsNCj4gPiAgREVGSU5FX1NUQVRJQ19TUkNVKHJlbW92ZV9jYWNoZV9zcmN1
KTsNCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4gPiArc3RydWN0IGNwdV9z
aHJpbmtfcWxpc3Qgew0KPiA+ICsgICAgICAgcmF3X3NwaW5sb2NrX3QgbG9jazsNCj4gPiArICAg
ICAgIHN0cnVjdCBxbGlzdF9oZWFkIHFsaXN0Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IERFRklORV9QRVJfQ1BVKHN0cnVjdCBjcHVfc2hyaW5rX3FsaXN0LCBzaHJpbmtfcWxpc3QpID0g
ew0KPiA+ICsgICAgICAgLmxvY2sgPSBfX1JBV19TUElOX0xPQ0tfVU5MT0NLRUQoc2hyaW5rX3Fs
aXN0LmxvY2spLA0KPiA+ICt9Ow0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gIC8qIE1heGltdW0g
c2l6ZSBvZiB0aGUgZ2xvYmFsIHF1ZXVlLiAqLyAgc3RhdGljIHVuc2lnbmVkIGxvbmcgDQo+ID4g
cXVhcmFudGluZV9tYXhfc2l6ZTsNCj4gPg0KPiA+IEBAIC0zMTEsMTIgKzMyMiwyMyBAQCBzdGF0
aWMgdm9pZCBxbGlzdF9tb3ZlX2NhY2hlKHN0cnVjdCBxbGlzdF9oZWFkIA0KPiA+ICpmcm9tLCAg
c3RhdGljIHZvaWQgcGVyX2NwdV9yZW1vdmVfY2FjaGUodm9pZCAqYXJnKSAgew0KPiA+ICAgICAg
ICAgc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlID0gYXJnOw0KPiA+IC0gICAgICAgc3RydWN0IHFs
aXN0X2hlYWQgdG9fZnJlZSA9IFFMSVNUX0lOSVQ7DQo+ID4gICAgICAgICBzdHJ1Y3QgcWxpc3Rf
aGVhZCAqcTsNCj4gPiAtDQo+ID4gKyNpZm5kZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4gPiArICAg
ICAgIHN0cnVjdCBxbGlzdF9oZWFkIHRvX2ZyZWUgPSBRTElTVF9JTklUOyAjZWxzZQ0KPiA+ICsg
ICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArICAgICAgIHN0cnVjdCBjcHVfc2hyaW5r
X3FsaXN0ICpzcTsgI2VuZGlmDQo+ID4gICAgICAgICBxID0gdGhpc19jcHVfcHRyKCZjcHVfcXVh
cmFudGluZSk7DQo+ID4gKyNpZm5kZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4gPiAgICAgICAgIHFs
aXN0X21vdmVfY2FjaGUocSwgJnRvX2ZyZWUsIGNhY2hlKTsNCj4gPiAgICAgICAgIHFsaXN0X2Zy
ZWVfYWxsKCZ0b19mcmVlLCBjYWNoZSk7DQo+ID4gKyNlbHNlDQo+ID4gKyAgICAgICBzcSA9IHRo
aXNfY3B1X3B0cigmc2hyaW5rX3FsaXN0KTsNCj4gPiArICAgICAgIHJhd19zcGluX2xvY2tfaXJx
c2F2ZSgmc3EtPmxvY2ssIGZsYWdzKTsNCj4gPiArICAgICAgIHFsaXN0X21vdmVfY2FjaGUocSwg
JnNxLT5xbGlzdCwgY2FjaGUpOw0KPiA+ICsgICAgICAgcmF3X3NwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJnNxLT5sb2NrLCBmbGFncyk7ICNlbmRpZg0KPiA+ICB9DQo+ID4NCj4gPiAgLyogRnJlZSBh
bGwgcXVhcmFudGluZWQgb2JqZWN0cyBiZWxvbmdpbmcgdG8gY2FjaGUuICovIEBAIC0zMjQsNg0K
PiA+ICszNDYsMTAgQEAgdm9pZCBrYXNhbl9xdWFyYW50aW5lX3JlbW92ZV9jYWNoZShzdHJ1Y3Qg
a21lbV9jYWNoZQ0KPiA+ICpjYWNoZSkgIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxh
Z3MsIGk7DQo+ID4gICAgICAgICBzdHJ1Y3QgcWxpc3RfaGVhZCB0b19mcmVlID0gUUxJU1RfSU5J
VDsNCj4gPiArI2lmZGVmIENPTkZJR19QUkVFTVBUX1JUDQo+ID4gKyAgICAgICBpbnQgY3B1Ow0K
PiA+ICsgICAgICAgc3RydWN0IGNwdV9zaHJpbmtfcWxpc3QgKnNxOyAjZW5kaWYNCj4gPg0KPiA+
ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIE11c3QgYmUgY2FyZWZ1bCB0byBub3QgbWlzcyBh
bnkgb2JqZWN0cyB0aGF0IGFyZSBiZWluZyANCj4gPiBtb3ZlZCBmcm9tIEBAIC0zMzQsNiArMzYw
LDE2IEBAIHZvaWQga2FzYW5fcXVhcmFudGluZV9yZW1vdmVfY2FjaGUoc3RydWN0IGttZW1fY2Fj
aGUgKmNhY2hlKQ0KPiA+ICAgICAgICAgICovDQo+ID4gICAgICAgICBvbl9lYWNoX2NwdShwZXJf
Y3B1X3JlbW92ZV9jYWNoZSwgY2FjaGUsIDEpOw0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfUFJF
RU1QVF9SVA0KPiA+ICsgICAgICAgZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4gPiArICAg
ICAgICAgICAgICAgc3EgPSBwZXJfY3B1X3B0cigmc2hyaW5rX3FsaXN0LCBjcHUpOw0KPiA+ICsg
ICAgICAgICAgICAgICByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJnNxLT5sb2NrLCBmbGFncyk7DQo+
ID4gKyAgICAgICAgICAgICAgIHFsaXN0X21vdmVfY2FjaGUoJnNxLT5xbGlzdCwgJnRvX2ZyZWUs
IGNhY2hlKTsNCj4gPiArICAgICAgICAgICAgICAgcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnNxLT5sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBxbGlzdF9mcmVl
X2FsbCgmdG9fZnJlZSwgY2FjaGUpOw0KPg0KPiA+DQo+ID5JIHRoaW5rIG5vdyB0aGVyZSBpcyBh
bm90aGVyIHN1YnRsZSBidWcuDQo+ID5JIGFzc3VtZSB0aGF0IGJ5IHRoZSB0aW1lIGthc2FuX3F1
YXJhbnRpbmVfcmVtb3ZlX2NhY2hlKGNhY2hlKSByZXR1cm5zIGFsbCBvYmplY3RzIGJlbG9uZ2lu
ZyB0byB0aGUgY2FjaGUgbXVzdCBiZSBmcmVlZC4gSSB0aGluayB0aGVyZSBhcmUgc2NlbmFyaW9z
IHdoZXJlIGl0J3Mgbm90IHRoZSBjYXNlLg0KPiA+Q29uc2lkZXIgdGhlcmUgaXMgdGhyZWFkIDEg
dGhhdCBjYWxscyBrYXNhbl9xdWFyYW50aW5lX3JlbW92ZV9jYWNoZShBKSBhbmQgdGhyZWFkIDIg
dGhhdCBjYWxscyBrYXNhbl9xdWFyYW50aW5lX3JlbW92ZV9jYWNoZShCKS4NCj4gPkNvbnNpZGVy
IHRoYXQga2FzYW5fcXVhcmFudGluZV9yZW1vdmVfY2FjaGUgY2FsbGJhY2tzIGZvciBib3RoIEEg
YW5kIEIgaGFzIGZpbmlzaGVkIGFuZCBzaHJpbmtfcWxpc3QgY29udGFpbnMgYWxsIG9iamVjdHMg
dGhhdCBiZWxvbmcgdG8gY2FjaGVzIEEgYW5kIEIuDQo+ID5Ob3cgdGhyZWFkIDEgZXhlY3V0ZXMg
Zm9yX2VhY2hfb25saW5lX2NwdSBwYXJ0IGFuZCBjb2xsZWN0cyBhbGwgb2JqZWN0cyBpbnRvIHRo
ZSBsb2NhbCB0b19mcmVlIGxpc3QuDQo+DQo+IEFjY29yZGluZyB0byBteSB1bmRlcnN0YW5kaW5n
DQo+IFRocmVhZCAxIG9ubHkgY29sbGVjdHMgb2JqZWN0cyB3aGljaCBiZWxvbmcgdG8gY2FjaGVz
IEEgLCBiZWNhdXNlIHRoZSANCj4gcWxpc3RfbW92ZV9jYWNoZSgmc3EtPnFsaXN0LCAmdG9fZnJl
ZSwgY2FjaGUpIFdpbGwgZmlsdGVyZWQgYWdhaW4sICBvciBkaWQgSSBtaXNzIHNvbWV0aGluZz8N
Cg0KPllvdSBhcmUgcmlnaHQuIEkgbWlzc2VkIHRoYXQga2FzYW5fcXVhcmFudGluZV9yZW1vdmVf
Y2FjaGUgYWxzbyBmaWx0ZXJzIGJhc2VkIG9uIGNhY2hlLg0KPg0KPkFja2VkLWJ5OiBEbWl0cnkg
Vnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQoNCkNjOiBBbmRyZXcgTW9ydG9uDQoNCj4gPk5v
dyB0aHJlYWQgMiBleGVjdXRlcyB0aGUgZm9yX2VhY2hfb25saW5lX2NwdSwgY2FsbHMgcWxpc3Rf
ZnJlZV9hbGwgKG9uIGFuIGVtcHR5IGxpc3QpIGFuZCByZXR1cm5zIGZyb20ga2FzYW5fcXVhcmFu
dGluZV9yZW1vdmVfY2FjaGUuDQo+ID5UaGVuIGNhY2hlIEIgaXMgY29tcGxldGVseSBkZXN0cm95
ZWQgYW5kIGZyZWVkLg0KPiA+Tm93IHRocmVhZCAxIHJlc3VtZXMgYW5kIGNhbGxzIHFsaXN0X2Zy
ZWVfYWxsIGZvciBvYmplY3RzIGZyb20gY2FjaGUgQi4NCj4gPkJhbmchDQo+DQo+DQo+DQo+DQo+
ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcXVh
cmFudGluZV9sb2NrLCBmbGFncyk7DQo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgUVVBUkFO
VElORV9CQVRDSEVTOyBpKyspIHsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHFsaXN0X2VtcHR5
KCZnbG9iYWxfcXVhcmFudGluZVtpXSkpDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
