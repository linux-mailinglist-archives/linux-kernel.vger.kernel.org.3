Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F94C2169
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiBXB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiBXB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:57:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524FFDF8A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667829; x=1677203829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPpr3/4tQ6FdUxu6+MROFk6L5zEtzncetYEslMj+hwk=;
  b=fCE7kCVcr0r2R+/raqDPMmOfAgkFJ8jaOJ+fGjic+9Ydq9osa9U2xop3
   PtY8786bElILf0oWl7CARtM1UQTU4y74R3KO4WJVdZZkxQ8NbPD0C0rNL
   QdJWCSZNARmw4rx57N6wXINyTb02g2JUY/ReVoxuEsaKi4IpkBcuCh+6P
   65l4x3igKjlXnrXxxu3aaNb1pOns0zl2GxMJzDg3IhnYELgFZG4hEEugY
   avj4M3TqAhnxfKKloKzb4lLSm7CjV9XSqVA8NOHk5ZlPs+H2LMd+B+KI6
   AHHicdJsr5UZ3omtBT8jd4zBREvlWhOKMNuaHCInk2ijoM5fp360KgfKI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232746766"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232746766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491419551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 17:34:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 17:34:41 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 17:34:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 17:34:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 17:34:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrNQKomugj1UMa2YmslihGZykgYPLNcc+JpOfVUPsdjbKfgdTcHwfvFow1RD9zkLc/57FrI94RW2gam4LBAKjBVRTDHzkMeiQj9jEwOiEHHNKBjVUPEwP4OBw/w17gbjsiicPuW+t3iVQAOzBUP9oDfFyy8tlz1Nl1izdzYo8pHhbtiQ3vpkdm0cq50v8hlV7NPLneBrK5baMVlhR9ZSMXhySrqSRxG5w2m34mMCK4mR4pErQXI+fHwGjITnY93dLW728AP1jT/oBXvEpPrbJrr1XqNnxY3H5vCS9EAI6SJDWs8GtGN6g6Qly4e3EZGTL2HM8bq0dODRYmncs7vH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPpr3/4tQ6FdUxu6+MROFk6L5zEtzncetYEslMj+hwk=;
 b=PKFVhpuUfEAFEp0gWlcd874K4N/YMjZ7G46EtOMw/ydaEC5xbdMgEu6pDHMGEK67oQBdA8XvVXLDVY1KFUHlFwA7XJizSNL9IrMjG3FWnDWj1mjA815vY/41HrAc4c0lDkbhnGvi83yt8vv6N5kDThHVxZvsEhMngticXZUjGkoMwQ5PH2x1Zgw4uH2froySlMbOnhczLKU8t136gd/OkikiAFmKC1nPy+rG7zzpjYxlpZigYMRBF/JTMjffob7G105xQsRIusn6eYs25GiSTtGNNcZuJW+VewRXUBB7VaMKGHEIs9nQz+pJ0HEoa+SwBE8e+O1aJPZX/mAgTWQBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY4PR1101MB2248.namprd11.prod.outlook.com (2603:10b6:910:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 01:34:37 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.028; Thu, 24 Feb 2022
 01:34:37 +0000
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Brouer, Jesper" <brouer@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Thread-Topic: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Thread-Index: AQHYI5ScMYrkQI2gYEWIP5E+maINLayW+w8AgAB//YCAATtkgIAFUv0AgAMBCgCAABp8AIAA0UaA
Date:   Thu, 24 Feb 2022 01:34:37 +0000
Message-ID: <75a3bf996be7445216df83bd4f9cd55c2cffc16a.camel@intel.com>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
         <20220217002227.5739-6-mgorman@techsingularity.net>
         <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
         <20220217093113.GU3366@techsingularity.net>
         <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn> <YhOVzktqtWIJFjiJ@ziqianlu-nuc9qn>
         <YhYa7PzhzEqRYXHp@ziqianlu-nuc9qn>
         <20220223130540.GF4423@techsingularity.net>
In-Reply-To: <20220223130540.GF4423@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92fb5bd1-cc35-43a3-3d8f-08d9f735d1ed
x-ms-traffictypediagnostic: CY4PR1101MB2248:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR1101MB22487D887424D9B11C963B278B3D9@CY4PR1101MB2248.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcOMX5rYXFclQDQOmZuQ3G3RP1metTgVIT1yCqgSUiz2zoBQke00yf1PxIwcMid7oScA5jpLMhzl5elkKwph/15umOgx2mXGtBMwSjZTRLRgkO7fcT7AJBuBa1jPlRQEWM4pPkAye8Vz52dwJm1Y/VPUhhkQd/4o1BFssSAA/O5lWdfR8ABJ6vFV0Uw0rA5llCREe/raWFRqfakSjdyRP8zIRWWbfw7Yb8+LKMd4nGhqNof1uXuf7Gz/BKXoeCoplO6GqOJ4REvNu9Gwnm6DgwoyjDinaOwaW1y5DjTdfT6MyQp28+uPdZPfulWGXe/nKcQJ2un02gpq7wXICve90v1S0KklKUk6fHxtrHSB65m/t9XHuBgjYK4oshqANURCiOj4+nTEO0VAST1HEA8dpE0HMp71ZB0cZIIMNpaR0Jwk+fQDOX0MO2dJKmpO2hbyvIEYyw2gQRnTyLULobFRpmJBjCfjk7qE3J6ALZXc7yba1pQfh2lcDb8OJJ3pjQw/jX4fkydb/OPM4FsuXu1KqZ9bAgZ1d/23A7T/EUpWfV0NdLrOaZ3smhqin2K7aknP6diDP9fg4khl5w8Ok6nPTMutt5jrUNFwCC92sa/AZoiE7VpN905HO+97qdEnJj9/HpcMWtat0V2kopSx5hGA4JzhhaF676edy8CHpqTFlJF1azWLZfM8hL5NcisZg/MY+EkQN2i/Sq9X42M4OpGBJTTQ3FRrPsS6OehQpnPDzTgZPGFEW6skHVz7J+z+eSpKfSlIJaNkxkizlbtVgdmeo2cHzfNdZThJOjxl2VFAAik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(38070700005)(2906002)(8936002)(5660300002)(508600001)(86362001)(71200400001)(186003)(91956017)(83380400001)(54906003)(66946007)(66476007)(38100700002)(66556008)(6486002)(316002)(76116006)(2616005)(122000001)(66446008)(26005)(64756008)(82960400001)(6512007)(6506007)(8676002)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJZMnhzSyt1Y3NXUk1tbkI2cVZ4TW9mOFJXSGkrQlI2b24valJJRmVWb0N3?=
 =?utf-8?B?d1hKVndHTVRjZ3FRQ1V0OC9NM0hVS3JvWk1qZlpZTlhpUWZoeGQwb0RiRFpq?=
 =?utf-8?B?L05TaHBieTBuNnZaWXZBOUtZRGl5cTdWYitmYWRmZVhaakJJazhEWlR6OTR5?=
 =?utf-8?B?MWR3R2JxLzBIam1xeGJWUGswU0M2OFpkaitDT0NkZ1R0TWY0L2ZZajVuRFdJ?=
 =?utf-8?B?eVI2c0JaRVJ1ZU5Qa1ZIZkdQTGVaRFprRlJ3MnFpSFlLeWhYQzJQQXZJRWVh?=
 =?utf-8?B?eGxScjlFNmE5VEJnRjV1RzBsbzRJbEJCUWl5Vmg0YkI1SlFrc2NpdXB0OHRP?=
 =?utf-8?B?Zk96U1gwZ2JCeDVFVC9nYW9kSUxrU3ZwZVZPYjlUTHYzY0ZLUkpmN0Y2V3la?=
 =?utf-8?B?d0VRQ0NrNGo3TUVNelhYMGQzZTZwRnBwNjVQWUtmNzZlTnZKQ1ZNMWpGdHNB?=
 =?utf-8?B?V2t6RWJLeVBTdXRISG5hbm81YUlndmljTDhraXo3cnRCUTlEcjlFS2tiZmdQ?=
 =?utf-8?B?QXU0bFFBMUhxZ0pyQVpuQ3E5TmlWMUZSbkMwVWpkT3lLNllKL0hMb3V5dkZ5?=
 =?utf-8?B?a0JvVnAyYnlJZjhnUWhFYXZBV29KZTFOVno0Z1FBa28yYXB5LytBYjZnM0do?=
 =?utf-8?B?dzZBMlNJaUcwd3M1bFFqOGQxU1RoT0UwY1VuWjhVNFJ5a2szUmJNRjRoWDFu?=
 =?utf-8?B?Q1BIZmNzdndZTSt5bGlJUjJBWWIrd1FWY2NXdUVJbFZlbDN3NVhMVFZUa3Jv?=
 =?utf-8?B?SlZjb1YwM3ZvVmNzZW4xbm1iNzJnbk0vUGY4eUJXRHVtTjNLVnBGczQrejN2?=
 =?utf-8?B?Zk9NS1IwQnh6VS9rbi9hYzR6MUJFSEdmMUczM0ovR0s5eHRwRENzc3QrZHZx?=
 =?utf-8?B?bVJJQ3hZdEo4NzJqUEY2VG9PZE5YZkh2V0FEL2FBVGRVQUtxY3d3UkJnMjgx?=
 =?utf-8?B?Ynp3L0x0TTRGb2szVFQrUW5kVFpSa3Bpc2ZZZHFlQnpDUHhjNlhXQ3IxU1ZW?=
 =?utf-8?B?eW14bkFlbXNQRE9NQXY5bEVDN0I3YjU2VEk1a2k2dWNaelVieWxESkNvak41?=
 =?utf-8?B?N3JoYTdxL0xmME9SLzE3akU3VVl5a3JEZ05iQnh2c1FSTHh4Z2ZDS0dtaFBy?=
 =?utf-8?B?c1dqNi91YVpneWJqN0E1clg4ZmlpSXQ1N09oMlgyQXhWeEJ1bWdzSUY3Q2hY?=
 =?utf-8?B?R1JQYVRuY0g1bTNjWEhIUnMvemVVWHNLbVorN3R6Z2FkUTZpY2U2dy9XSllX?=
 =?utf-8?B?eGk5Q0wyMUx3SmtRb2hNdlhLNjgycGJhd2tTS1NWSDFTT1FCL0FmaVNCdXRC?=
 =?utf-8?B?SWN2ckxuWGhrSFF4dlVMNi9uQmVveTg0cWlYekZOSzd4YzdtL1A1RkU2eEcz?=
 =?utf-8?B?b2hFL2lnL1VYdENEcW5GQWFReUdhVHJrUkJ0S2ZvSFVPUHMrZlA5MGtPTytY?=
 =?utf-8?B?RU14UGU4eUcwV01obGlHL3dHK1lkVEtJdTVLQ3psTXAybzVseVRiNjFwOHNI?=
 =?utf-8?B?bURHNldYMHpwQXBoTUl4bU5wdjV1dHU5Nzhib25jQ2FtZmtJelZRK1VRVWJY?=
 =?utf-8?B?TmhhZWFoWUNIQmhoSGZ4VGdVTlZySmJDakt3QVUydHFhV3RQL1FaRytHa0xW?=
 =?utf-8?B?QkJETGtMdlRER1YrYmhIL0RpbGpOMzAwU1B3d2RNazhQUG1UM3U0YWhmTWww?=
 =?utf-8?B?WE1aRDQrRFczK2pxWXhWeGRUV1ZMWUVDTzlRV2c2VGF0dXRIVFhJbjQvWjZJ?=
 =?utf-8?B?NU1mVWRua3BWVmJzT1JSeVBpSXd5WkhXdllDb1ZrY1dad3p3a1d1OG9kQzBN?=
 =?utf-8?B?SWx6UERnM1hrYllBRVpUcUhOOUhEQ1RobTJOZnU2bzFaOW53VUlzQnllMmR0?=
 =?utf-8?B?dFA4eW5MZ3k2WVRMMEFhWWpZNGhVemwzVFlDQWJVUVJ4QzRPa0t6UGNCenYr?=
 =?utf-8?B?Z2N0cVZtbmFDWUVqajdRemlFTHd2Zmh5alZBcHF4VU55aGFDVE5hVjRyQW5s?=
 =?utf-8?B?YytGZkxlQldtd3hnVDFLaDFScEN1NHN4OFNiUG5xanJEWmk0WVpxNUNvY25L?=
 =?utf-8?B?dlpCNnhuY3RWV0NNWnhOYkNRUWxmRTg0K1owckxaYmFDUVNSZmVvV2ZjcWN4?=
 =?utf-8?B?bTdPMTcvdW5GbDRuYXFuSzlLQ2RhekNLTTdLQkk2L1lDSkF0L2RkOUk1MWhu?=
 =?utf-8?Q?xTRBmEyqJMRNgiLXa3bPfyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A9CA4E4666281448B933155018BD3FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fb5bd1-cc35-43a3-3d8f-08d9f735d1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 01:34:37.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gs2FZjOR8YD+1Cnyl/Xlaqf6DR0Mxcutnuj/VG/Hl1liAScmpGR5eQEwyHoHb211auVVvRzPiRTizn6eK/zVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2248
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

T24gV2VkLCAyMDIyLTAyLTIzIGF0IDEzOjA1ICswMDAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiBP
biBXZWQsIEZlYiAyMywgMjAyMiBhdCAwNzozMDo1MlBNICswODAwLCBBYXJvbiBMdSB3cm90ZToN
Cj4gPiBPbiBNb24sIEZlYiAyMSwgMjAyMiBhdCAwOTozODoyMlBNICswODAwLCBBYXJvbiBMdSB3
cm90ZToNCj4gPiA+IE9uIEZyaSwgRmViIDE4LCAyMDIyIGF0IDEyOjIwOjAzUE0gKzA4MDAsIEFh
cm9uIEx1IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIEZlYiAxNywgMjAyMiBhdCAwOTozMToxM0FN
ICswMDAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgRmViIDE3LCAyMDIy
IGF0IDA5OjUzOjA4QU0gKzA4MDAsIEFhcm9uIEx1IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiAyLXNv
Y2tldCBDYXNjYWRlTGFrZSAoNDAgY29yZXMsIDgwIENQVXMgSFQgZW5hYmxlZCkNCj4gPiA+ID4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDUuMTcuMC1yYzMgICAgICAgICAgICAgICAgIDUuMTcuMC1yYzMNCj4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbmls
bGEgICAgICAgICAgIG1tLWhpZ2hwY3BvcHQtdjINCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAgIHBh
Z2VfZmF1bHQxLXByb2Nlc3Nlcy0yICAgICAgICAyNjk0NjYyLjI2ICggICAwLjAwJSkgICAgICAy
Njk1NzgwLjM1ICggICAwLjA0JSkNCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAgIHBhZ2VfZmF1bHQx
LXByb2Nlc3Nlcy01ICAgICAgICA2NDI1ODE5LjM0ICggICAwLjAwJSkgICAgICA2NDM1NTQ0LjU3
ICogICAwLjE1JSoNCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAgIHBhZ2VfZmF1bHQxLXByb2Nlc3Nl
cy04ICAgICAgICA5NjQyMTY5LjEwICggICAwLjAwJSkgICAgICA5NjU4OTYyLjM5ICggICAwLjE3
JSkNCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAgIHBhZ2VfZmF1bHQxLXByb2Nlc3Nlcy0xMiAgICAg
IDEyMTY3NTAyLjEwICggICAwLjAwJSkgICAgIDEyMTkwMTYzLjc5ICggICAwLjE5JSkNCj4gPiA+
ID4gPiA+ID4gSG1lYW4gICAgIHBhZ2VfZmF1bHQxLXByb2Nlc3Nlcy0yMSAgICAgIDE1NjM2ODU5
LjAzICggICAwLjAwJSkgICAgIDE1NjEyNDQ3LjI2ICggIC0wLjE2JSkNCj4gPiA+ID4gPiA+ID4g
SG1lYW4gICAgIHBhZ2VfZmF1bHQxLXByb2Nlc3Nlcy0zMCAgICAgIDI1MTU3MzQ4LjYxICggICAw
LjAwJSkgICAgIDI1MTY5NDU2LjY1ICggICAwLjA1JSkNCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAg
IHBhZ2VfZmF1bHQxLXByb2Nlc3Nlcy00OCAgICAgIDI3Njk0MDEzLjg1ICggICAwLjAwJSkgICAg
IDI3NjcxMTExLjQ2ICggIC0wLjA4JSkNCj4gPiA+ID4gPiA+ID4gSG1lYW4gICAgIHBhZ2VfZmF1
bHQxLXByb2Nlc3Nlcy03OSAgICAgIDI1OTI4NzQyLjY0ICggICAwLjAwJSkgICAgIDI1OTM0MjAy
LjAyICggICAwLjAyJSkgPC0tDQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0MS1w
cm9jZXNzZXMtMTEwICAgICAyNTczMDg2OS43NSAoICAgMC4wMCUpICAgICAyNTY3MTg4MC42NSAq
ICAtMC4yMyUqDQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0MS1wcm9jZXNzZXMt
MTQxICAgICAyNTYyNjk5Mi40MiAoICAgMC4wMCUpICAgICAyNTYyOTU1MS42MSAoICAgMC4wMSUp
DQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0MS1wcm9jZXNzZXMtMTcyICAgICAy
NTYxMTY1MS4zNSAoICAgMC4wMCUpICAgICAyNTYxNDkyNy45OSAoICAgMC4wMSUpDQo+ID4gPiA+
ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0MS1wcm9jZXNzZXMtMjAzICAgICAyNTU3NzI5OC43
NSAoICAgMC4wMCUpICAgICAyNTU4MzQ0NS41OSAoICAgMC4wMiUpDQo+ID4gPiA+ID4gPiA+IEht
ZWFuICAgICBwYWdlX2ZhdWx0MS1wcm9jZXNzZXMtMjM0ICAgICAyNTU4MDY4Ni4wNyAoICAgMC4w
MCUpICAgICAyNTYwODI0MC43MSAoICAgMC4xMSUpDQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBw
YWdlX2ZhdWx0MS1wcm9jZXNzZXMtMjY1ICAgICAyNTU3MDIxNS40NyAoICAgMC4wMCUpICAgICAy
NTU2ODY0Ny41OCAoICAtMC4wMSUpDQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0
MS1wcm9jZXNzZXMtMjk2ICAgICAyNTU0OTQ4OC42MiAoICAgMC4wMCUpICAgICAyNTU0MzkzNS4w
MCAoICAtMC4wMiUpDQo+ID4gPiA+ID4gPiA+IEhtZWFuICAgICBwYWdlX2ZhdWx0MS1wcm9jZXNz
ZXMtMzIwICAgICAyNTU1NTE0OS4wNSAoICAgMC4wMCUpICAgICAyNTU3NTY5Ni43NCAoICAgMC4w
OCUpDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgZGlmZmVyZW5jZXMgYXJlIG1v
c3RseSB3aXRoaW4gdGhlIG5vaXNlIGFuZCB0aGUgZGlmZmVyZW5jZSBjbG9zZSB0bw0KPiA+ID4g
PiA+ID4gPiAkbnJfY3B1cyBpcyBuZWdsaWdpYmxlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBJIGhhdmUgcXVldWVkIHdpbGwtaXQtc2NhbGUvcGFnZV9mYXVsdDEvcHJvY2Vzc2VzLyRucl9j
cHUgb24gMiA0LXNvY2tldHMNCj4gPiA+ID4gPiA+IHNlcnZlcnM6IENhc2NhZGVMYWtlIGFuZCBD
b29wZXJMYWtlciBhbmQgd2lsbCBsZXQgeW91IGtub3cgdGhlIHJlc3VsdA0KPiA+ID4gPiA+ID4g
b25jZSBpdCdzIG91dC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5r
cywgNCBzb2NrZXRzIGFuZCBhIGxhdGVyIGdlbmVyYXRpb24gd291bGQgYmUgbmljZSB0byBjb3Zl
ci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEknbSB1c2luZyAnaHR0cHM6Ly9naXRodWIuY29t
L2huYXovbGludXgtbW0gbWFzdGVyJyBhbmQgZG9pbmcgdGhlDQo+ID4gPiA+ID4gPiBjb21wYXJp
c29uIHdpdGggY29tbWl0IGMwMDBkNjg3Y2UyMigibW0vcGFnZV9hbGxvYzogc2ltcGxpZnkgaG93
IG1hbnkNCj4gPiA+ID4gPiA+IHBhZ2VzIGFyZSBzZWxlY3RlZCBwZXIgcGNwIGxpc3QgZHVyaW5n
IGJ1bGsgZnJlZSIpIGFuZCBjb21taXQgODM5MWUwYTdlMTcyDQo+ID4gPiA+ID4gPiAoIm1tL3Bh
Z2VfYWxsb2M6IGZyZWUgcGFnZXMgaW4gYSBzaW5nbGUgcGFzcyBkdXJpbmcgYnVsayBmcmVlIikg
dGhlcmUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgYmFzZWxpbmUg
bG9va3MgZmluZS4gSXQncyBkaWZmZXJlbnQgdG8gd2hhdCBJIHVzZWQgYnV0IHRoZSBwYWdlX2Fs
bG9jDQo+ID4gPiA+ID4gc2hvdWxkbid0IGhhdmUgbXVjaCBpbXBhY3QuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gV2hlbiBsb29raW5nIGF0IHdpbGwtaXQtc2NhbGUsIHBsZWFzZSBwYXkgYXR0ZW50
aW9uIHRvIGxvd2VyIENQVSBjb3VudHMNCj4gPiA+ID4gPiBhcyB3ZWxsIGFuZCB0YWtlIGFjY291
bnQgY2hhbmdlcyBpbiBzdGFuZGFyZCBkZXZpYXRpb24uIExvb2tpbmcgYXQgdGhlDQo+ID4gPiA+
IA0KPiA+ID4gPiBJJ2xsIGFsc28gdGVzdCBucl90YXNrPTQvMTYvNjQgb24gdGhlIDRzb2NrZXRz
IENvb3Blckxha2UobnJfY3B1PTE0NCkgdGhlbi4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEZv
ciB0aGUgcmVjb3JkLCB0aGVzZSB0ZXN0cyBkb24ndCBzaG93IGFueSB2aXNpYmxlIHBlcmZvcm1h
bmNlIGNoYW5nZXMNCj4gPiA+IG9uIENvb3Blckxha2UuDQo+ID4gDQo+ID4gT25lIHRoaW5nIEkg
anVzdCBub3RpY2VkIGlzIHRoYXQsIHpvbmUgbG9jayBjb250ZW50aW9uIGluY3JlYXNlZCB0byBz
b21lDQo+ID4gZXh0ZW50LiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyB3b3JyaXNvbWUgc28gSSBz
dXBwb3NlIEkgc2hvdWxkIGF0IGxlYXN0DQo+ID4gbWVudGlvbiBpdCBoZXJlLg0KPiA+IA0KPiA+
IFRoZSBucl90YXNrPTEwMCUgdGVzdCBvbiB0aGUgNCBzb2NrZXRzIENvb3BlciBMYWtlIHNob3dl
ZCB0aGF0IHpvbmUgbG9jaw0KPiA+IGNvbnRlbnRpb24gaW5jcmVhc2VkIGZyb20gMTMuNTYlIHRv
IDIwLjE2JSBhbmQgZm9yIG5yX3Rhc2s9MTYsIGl0DQo+ID4gaW5jcmVhc2VkIGZyb20gNC43NSUg
dG8gNi4xOCUuDQo+ID4gDQo+ID4gVGhlIHJlYXNvbiBpcyBwcm9iYWJseSBkdWUgdG8gbW9yZSBj
b2RlIGFyZSBub3cgaW5zaWRlIHRoZSBsb2NrIGFuZCB3aGVuDQo+ID4gdGhlcmUgaXMgY29udGVu
dGlvbiwgaXQgd2lsbCBtYWtlIHRoaW5ncyB3b3JzZS4gSSdtIGF3YXJlIG9mIHRoYXQNCj4gPiBu
cl90YXNrPTEwMCUgaXMgYSByYXJlIGNhc2UgYW5kIHRoaXMgcGF0Y2hzZXQgaXMgbWVhbnQgdG8g
aW1wcm92ZSB0aGluZ3MNCj4gPiB3aGVuIHRoZXJlIGlzIHZlcnkgbGl0dGxlIGNvbnRlbnRpb24s
IHdoaWNoIHNob3VsZCBiZSB0aGUgY29tbW9uIGNhc2UuDQo+ID4gU28gSSBndWVzcyB0aGF0J3Mg
anVzdCB0aGUgdHJhZGVvZmYgd2UgaGF2ZSB0byBtYWtlLi4uDQo+ID4gDQo+IA0KPiBJIHRoaW5r
IGl0J3MgYSByZWFzb25hYmxlIHRyYWRlb2ZmLiBUaGUgcGFnZV9mYXVsdDEgd2lsbC1pdC1zY2Fs
ZSBpcw0KPiBhbiBleHRyZW1lIGNhc2UgdGhhdCBleGVyY2lzZXMgc2V2ZXJlIGNvbnRlbnRpb24g
Zm9yIHRoZSB6b25lIGxvY2sgd2l0aA0KPiBib3RoIGFsbG9jYXRvcnMgYW5kIGZyZWVpbmcgY29u
dGVuZGluZyBmb3IgdGhlIGxvY2sgYXQgdGhlIHNhbWUgdGltZS4gSQ0KPiB0aGluayBpdCdzIHJl
YXNvbmFibGUgdG8gb3B0aW1pc2UgZm9yIHRoZSBjb21tb24gY2FzZSBvZiBjb21wbGV0aW5nIHRo
ZQ0KPiBidWxrIGZyZWVpbmcgYXMgcXVpY2tseSBhcyBwb3NzaWJsZS4gSWYgYW55dGhpbmcsIEkg
dGhpbmsgd2lsbC1pdC1zY2FsZQ0KPiB3b3VsZCBiZW5lZml0IG1vcmUgaWYgem9uZS0+bG9jayB3
YXMgc3BsaXQgdG8gY292ZXIgcmVnaW9ucyB3aXRoaW4gYSB6b25lDQo+IGluc3RlYWQgb2YgcHJv
dGVjdGluZyBhbiBlbnRpcmUgem9uZSB3aGljaCBjb3VsZCBiZSBodW5kcmVkcyBvZiBHQiBpbiBz
aXplLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24gYW5kIHN1Z2dlc3Rpb24gb24g
aG93IHRvIGRlYWwgd2l0aCB6b25lIGxvY2sNCmNvbnRlbnRpb24uDQo=
