Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6654EDFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379432AbiFPXpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379414AbiFPXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:44:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132A5A2C7;
        Thu, 16 Jun 2022 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655423094; x=1686959094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ykKlJk99wgtBwKR1luXGj5VxnMDsJrJ+G6Zk+oE0Kc=;
  b=SAGp6PKHPLyW/WGuG9TaSXNPmjR0y26iY8iqlxciHki0tYyo7GDsf0c9
   bOFjpym+fr7hJEWj/9E49qJF3hLSuSluOEh2PitlyyekigoGH5zTYMXkF
   3dagUrZHWL9ryIEF+RyxH0v7ibKC32MIhYVyBxaPxzpO49i5ipD+N2hry
   CSsVgMd6RGoxcu4QfaX5mVOClTc8O0upHmkxvrHUGu6TUVLX2Cu6dgelM
   3SSYrE1jUYGN6Ka7DvJ0mphaZd3TItQ7k19X99Lkw524mlUg0K/+XKhjg
   ORfVLVXFLX30DIkpzi6EVsbRyaypSY0gvSV/5LjOLsRGMAzXlK1EwoHu8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343340106"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343340106"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912379519"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2022 16:44:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 16:44:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 16:44:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 16:44:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 16:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXkM1u50AorUlb2ag8K0+dGk8aJ8SXDnicDDVWjSSMMPRcwPas4z3ovSEUcCBf53xa3U+WEVV5Wdvw8X+LM/08/tRGdIHCi1lFUw6EhfmJgnQiTVCyPL4c2Fg0S0fEOeNxFXMxNmD5zd9m2voIfDT47ru03fDyPz2LnPXtKGVRht9TPx935/kAWSfAlMvh8CnAk5MNN6UGYe7pXTAQvDi76kBM9scgGbhrhxit7LaxT8fHSgbyBwyHF6/FgHCZDr4gkcaWSZXMRHm3E0pMAYvSPvmwqAXwbqmOtFUTdMW4R7qGjtZIFPZ+2jNEzx5WSba85au9dwa2hWke9RQKVq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ykKlJk99wgtBwKR1luXGj5VxnMDsJrJ+G6Zk+oE0Kc=;
 b=kMhHvmpdf7zozrfCy5cFEX5+6IczVwSqjGFpRSQRMzcNcUi0Hj6pzSXJ3Nn7j+0akz0VT8FuyoyClwo1ErKnrdDtYhhdMuFfM8Ubh4qmgXUd4uXTohqKoXV3DhR/DUcJ1AcWPTSubd2fwAvWeEegy0wjMKv1GQlA3k/yr2UT99ihooZ6UHHHsPJprh1QfW7watgp1buiqTsVrnBXhZkPF4nTHixlWDKRiy2wDSa1+mnGofYug6VP9vF/dhMO/heQh0zqv9KhHm9fJcS5wJr6j8E7DS5/7i5KQZSVKvWuyGlm9Q7Hc3NhOKQLFBazrWjOoyC3sVfIy8E5dKfLDUoHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM6PR11MB2729.namprd11.prod.outlook.com (2603:10b6:5:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 23:44:36 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::40ef:2d29:7d1a:21be]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::40ef:2d29:7d1a:21be%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 23:44:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Thread-Topic: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command
 support
Thread-Index: AQHYgExj1stLEY66B0u13FAZUL4jYK1SciEAgAAOFwCAACS4gIAACF4AgAAIKQA=
Date:   Thu, 16 Jun 2022 23:44:35 +0000
Message-ID: <b708b1b0929317b9b087505c3177d830f69066d1.camel@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
         <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
         <20220616194334.pvorvoozt4rrzr66@offworld>
         <20220616203400.GA1529208@alison-desk>
         <20220616224525.fufa4dnpw4vl344n@offworld>
         <20220616231522.GA1529779@alison-desk>
In-Reply-To: <20220616231522.GA1529779@alison-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dd7b316-caba-407a-7a18-08da4ff22b87
x-ms-traffictypediagnostic: DM6PR11MB2729:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB27299C58A316515555E2E27CC7AC9@DM6PR11MB2729.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkyD1On2VmHvuRMRfReNQA9FfJYS5mTjvRj+MF6WzeyHQsbNUW5XIgIJ0Pp8QBk09QXl0jYDK5iWgvHge2aLqnT+q8CPXjE29Op+svFlVB3ckUx4wgr2qR2fbibfZOLciSx68AgUYT3dyK9trmsIQdMlBWqHCit2MTBDUvUuwg4Ugik8nltbX0yyaKKtbbDh2RWgKr1v7XAPvVbs75lM1GxA02/tE50FaWwagGkg0st+5iW88jjrQJnj/as2yhTaWRnqbvt7kD1X5yOAVOVNuzP+ENjSGso9M4ckQuxpZiGUoERmX3R4OOsybSZdYH+yFXCrjj3jeUZLfUs3e6neYfBaoBwoMOqaEtyc+s3NIfo1qJjPkIIV55ZXoadg3VWXq56aIiWKdjnuMYB2b+Yoikeb5ExJAnMwXpYjiz8u6d/dnU8OdwrzBPNyvsEkM9ldEYuJUbMQfJeQbrIwXZiRP/q8uwe/uyqdPJ6SNyBzzUccb4V3bEvTFWsB0UR4oEn4lBWBd0eqKulIky41X1YUlVvZPIc9NXqppDICYTxYy3QAT9EHzk8TuL6Dr7bW2jfPIj0P2s4EHuhUQnQxqPffXmV2cHUF61NIQUyE0hK0n2Q0bSegPnKP6BjR2Hj8u0x9fv+sJoQYu6q1sgnB9dp263b2moeB896IrNPFI75Jk3VBezWM38kE1+c4W0D6z5NgCIF07sp+U+VIcOzRf+BuAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(71200400001)(38070700005)(6486002)(8936002)(91956017)(6506007)(122000001)(5660300002)(498600001)(83380400001)(186003)(66476007)(82960400001)(86362001)(66446008)(2906002)(66946007)(66556008)(64756008)(4326008)(6512007)(26005)(8676002)(316002)(38100700002)(110136005)(76116006)(36756003)(54906003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RFcVFVVEdKQVByTVZtZUtUWlBNSEs0a21LMjcrSHJ1RmlVd2RqY2FrSWdS?=
 =?utf-8?B?N3pJSVlmSFNJSzY1VUhrWS9aQ2lBZXlNWS9WZzZENGh4Nm1CamJoNGhJV2or?=
 =?utf-8?B?MzFyYmFzWkpIVEFRN0JJRWdvcSsyOHAxeHdYVGtJa01IWnR2bC9tWWszVTEy?=
 =?utf-8?B?U2Rsd0RpOWpxWGlKU0pBOHl4aCsvTEFobXl5V0M2dU12Qk92eE9oVWpBTUhs?=
 =?utf-8?B?eDI3MEozOG01eHhhaXR6ZDFjdTR4ZWluOGVKa3YzSkZmeVE0NWFHUmNHTXA0?=
 =?utf-8?B?Q0xoMEpuelRZdFpDRmNycE92dzFGRjBzcmk3cjFDRW9uNUg0N3J2aDl4THd5?=
 =?utf-8?B?RjJuSVJjZGlxSFo2YkZhUGgzWmtSZDV2c24zUmFnTlMwcGRDWmJuSGhtV1pn?=
 =?utf-8?B?V2hJSjhSRExib0gvSTJzR3lRcFozNkVIYTdFbWttdlFBWFBMS081dGNaZkVX?=
 =?utf-8?B?WmlUa2EvU2pSRW94U1RFN3l0bW1wbmx6TEJjejNGR1Y4SDVFelhJVlpiR3Ay?=
 =?utf-8?B?VjBUZGxSRDNSV3c0YmVQYk0rd3lvS1BlZC9CWmZTam9aWVhyUVlKd2poazRm?=
 =?utf-8?B?eUZwR3FaOGVxVUtza1JjRk53cjMrZTRPdFZwcCsySzhCYjlyUjhTOFc0bnNo?=
 =?utf-8?B?QmZHTzlRSkpQdk9lS2hzYi9IMGxROGJhRGJvU25VRlJva2xPcFpsOFk4dy9s?=
 =?utf-8?B?WHVULzI1UVpjV3h6QXAyMFlLWlM5NE4wZ1E2RFRXQTNFaTdJbCsyUkZGQXRx?=
 =?utf-8?B?SEdGTUIrckFzV05qN3R6Vk15UlNPdVlzYkV5NjFGSHdjNmUzZWwzRHEzNXJG?=
 =?utf-8?B?eDAyK05nVEkrZWtpVVdCOGtyREtnS3lGTlNVWkhpQ2d0Z2pNazhua2d6WTdL?=
 =?utf-8?B?SWoyaWxGWU1KVUl1QXZIcm80eEUyRGVsTnQ1MER3U3luM3NhMkxVNFhuMUlt?=
 =?utf-8?B?bGdpbmpWNDd1VUdSVU54Q2hpUnhHVmlLVVFrN01aMG1pMERHcmtaV2ZKU0RP?=
 =?utf-8?B?K25XSmdMV3kxRVM5RTl6cUlUTFpDU2RYYkNDRUxzRU1nOTlzWXJsQkJZeC9n?=
 =?utf-8?B?VkpUam9rUDliN0YzRzhVTzg5SjI2TjBaYmw5dFBvMEIvLy9wQVc2b2JwbVZF?=
 =?utf-8?B?NTNvUFoydnlSM0tLdTdXeWYvTjBLVmNnRmFpMlQ2Z3JxMkU5NXVTc2dJTWFN?=
 =?utf-8?B?bUFJWXBLcWdla1JmaW5JbTc3UFFBR01LL1hRKzdXdXJ4aDZLbU14M1JWcWxx?=
 =?utf-8?B?K3dSamIrOFlZVkhlNldPWTk0Y00zQ1RrNS8zbVhGUDc4eGJoUUY0L2pXY3BV?=
 =?utf-8?B?UE8xdUtITHgxcElvNGNVaC9oZ1N2MExzZjlsVWhsdjBMVEFwbWEyREhKQWxh?=
 =?utf-8?B?TGU2UTBxazFwU1lvZmVRQ1hhRHhkSXhtMmFKbTVBbDVLVzZoR3VFcDVFLzZE?=
 =?utf-8?B?NTJVYzN3aG91VEx0emh6dkxZMUxoTFI5aUNSMzFqTHlFcWQ3dUlyM1h4Ym14?=
 =?utf-8?B?UW4zOEYxZngyYWlsTmg4MFRtN3pSbFBXK2ZoMGFjV204OXp2eUVuWkRHTjhN?=
 =?utf-8?B?MUg5N2lUM2o3aHpoSVBqYS9JMmdXeSs5aUVVdUU2dU52MGxTazZzZ0pEbjhq?=
 =?utf-8?B?T0lLbTM3WWRTam4vb0hFSHRNeDE3b0Z6MXlTaWNDMmFwdjVYVE1EMjJuVGVG?=
 =?utf-8?B?NFJwVWVlOHdFc1RrZWwvOWxIeHAxQjhGMEVZRG1NUjV3YlZSeWVKa1RZZ2VP?=
 =?utf-8?B?c0R1YVNUTmkyT01VQlJmNTEyQU5JczF6bHFERzNreEVYaUdTMlBTaDg4OVND?=
 =?utf-8?B?aXAvaU1lV1J3c0dJYmUvdENyTzZEWVBiNnZMYVNiWHpPd0kvVnNic3VnMFpl?=
 =?utf-8?B?cER6bVcrVTdSQWhoL05GbnZzVE9Yb1I1WTlIdVVvSmdUU25hOHdlSzZTY1VD?=
 =?utf-8?B?aE9qSVBiaUh3QmRZMGhHOHNlWFNobk1LT29Eb1NSTjNpTUZuOFQwbzNlUS9l?=
 =?utf-8?B?c3NxVTYwOUZhRnZ5K1R4TnhjcmR3b2FnR1RMSnQzM0Z6TlNXa1FQR0ZJZlpH?=
 =?utf-8?B?S1dIaFBRRzVWU1NPcWFVZk53dUJxU1ZIRUNuMy9hNThYRE91cjE5V1daY3lp?=
 =?utf-8?B?T0llRkdYMEswWHdtbW1ZOGQ5cFF4dWY1YTA0NkkxOHNuZThYbXVvTTdhNjlE?=
 =?utf-8?B?T25mcVZBa2pLT2NvU3REeVpWaEVrZ3ByZVJxN0RUTzdpSWhObnhlNUZzNWlR?=
 =?utf-8?B?WlVRbzJnSVFaa0loeW5DSisrTUk5d2xNSGlzWXJRNjlWQ09QazQ4Z0g4QmF1?=
 =?utf-8?B?NGxJYk9CQ0RDQlFxVW1wR0p6RjNsZENBRjBjT0lYZkpJOUhsUm5ZUmVLK2kw?=
 =?utf-8?Q?az4TvRf1WcgXQDRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A22978B153506D4E93F2C55616D395DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd7b316-caba-407a-7a18-08da4ff22b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 23:44:35.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibuBxZGTw0GwBKRYnvEnwUBb0+T+JjS0tzscHxKRlUmTDj3cEMw7lOxGPLg2tOJEuob2RbzGeK/JyMrkVVnc5sDckp+7VuznbEl8fV1pc1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2729
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTE2IGF0IDE2OjE1IC0wNzAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBPbiBUaHUsIEp1biAxNiwgMjAyMiBhdCAwMzo0NToyNVBNIC0wNzAwLCBEYXZpZGxvaHIg
QnVlc28gd3JvdGU6DQo+ID4gT24gVGh1LCAxNiBKdW4gMjAyMiwgQWxpc29uIFNjaG9maWVsZCB3
cm90ZToNCj4gPiANCj4gPiA+IGN4bCBsaXN0IC0tbWVkaWEtZXJyb3JzIC1tIG1lbTENCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBsaXN0cyBtZWRpYSBlcnJvcnMgZm9yIHJlcXVlc3RlZCBtZW1kZXYN
Cj4gPiA+IA0KPiA+ID4gY3hsIGxpc3QgLS1tZWRpYS1lcnJvcnMgLXIgcmVnaW9uIw0KPiA+IA0K
PiA+IEEgcXVpY2sgcXVlc3Rpb24gb24gdGhlIHRvb2xpbmcgZnJvbnQ6IHRoZSBhYm92ZSBnb2Vz
IG5pY2VseSB3aXRoDQo+ID4gY3hsLWxpc3QsIGJ1dCB3aGF0IGFib3V0IHRoZSByZXN0IG9mIHRo
ZSBwb2lzb25pbmcgY21kcz8gRG8geW91DQo+ID4gaGF2ZQ0KPiA+IGFueXRoaW5nIGluIG1pbmQ/
IERvIHdlIHdhbnQgc29tZXRoaW5nIHNwZWNpZmljIGZvciBtZWRpYSBhbmQNCj4gPiBwb2lzb24N
Cj4gPiBtYW5hZ2VtZW50IGluc3RlYWQ/IEllOg0KPiA+IA0KPiA+IGN4bCBtZWRpYSAtLWxpc3Qt
ZXJyb3JzIDxwYXJhbXM+DQo+IE5vdCBjbGVhciBob3cgdGhpcyBvbmUgZGlmZmVycy4gU2VlbXMg
bGlrZSB3ZSBjYW4gZ2V0IGFueSBwaWVjZSBvZiANCj4gdGhlIGxpc3QgdyBjeGwgbGlzdC4NCj4g
DQo+ID4gY3hsIG1lZGlhIC0taW5qZWN0LWVycm9ycyA8cGFyYW1zPg0KPiA+IGN4bCBtZWRpYSAt
LWNsZWFyLWVycm9ycyA8cGFyYW1zPg0KPiBGb3IgaW5qZWN0L2NsZWFyIEknZCBwcm9iYWJseSBz
dGFydCB3IHdoYXQgbmRjdGwgZG9lcyB0b2RheS4NCj4gbmRjdGwgaW5qZWN04oiSZXJyb3LCoCA8
bmFtZXNwYWNlPiBbPG9wdGlvbnM+XQ0KPiB3aGVyZSBvcHRpb24gLWQgLS11bmluamVjdCBwZXJm
b3JtcyB0aGUgY2xlYXIuDQoNClllYWggYWdyZWVkIHdpdGggQWxpc29uIHRoYXQgY3hsIGluamVj
dC1lcnJvciA8b3B0aW9ucz4gc291bmRzIGdvb2QuDQpHZW5lcmFsbHkgc3BlYWtpbmcsIHdlJ3Zl
IHRyaWVkIHRvIGF2b2lkIHRoZSAnc3ViLWNvbW1hbmQgb2YgYQ0Kc3ViY29tbWFuZCcgc2l0dWF0
aW9uIC0gc3VjaCBhcyAnY3hsIDxtZWRpYT4gPHN1Yi1zdWItY29tbWFuZD4NCjxvcHRpb25zPics
IGluc3RlYWQgcHJlZmVyaW5nICdjeGwgPGFjdGlvbi1vYmplY3Q+IDxvcHRpb25zPicuDQoNCj4g
DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IERhdmlkbG9ocg0KDQo=
