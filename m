Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2F5927BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHOCPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHOCPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:15:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB6410FDF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660529745; x=1692065745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e5y2ha5YqueOsRBdo3i+siKedOe+3WsL5c5F4w/Hb84=;
  b=DYqITS5QJ5Q4NaOuxt4QtzS36fBDi+V6U/i9cWCwHvyBrjoMln+yBgdx
   VLliP7f21Os+GyfMhtDGyxIxNCVryCvlnIB21SjpsVmGQfqR8gEUoKo8x
   UsX1VkpBvUo1PONTOoxo0bOo9skWE5YWqUQfG0pb50tXSOoEZ0R6nQlR5
   MQ9JcA9gebAJwwW5k9PjYQEaq7YNpnVtdfuLpupa3N4ftZq/xw7dyakEZ
   3pvzI6UiSu4OTo+tuY+p94J8DhVxDk0J/9+SzGPD7pn7ZndqaOfVLCdEm
   L3TBBlKiZzQpy3d/eFT03ZDIO/qh3CmhvckzNMiWKuGsuBtTqDiatkKhz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378162551"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="378162551"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="582720708"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 19:15:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:15:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:15:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 19:15:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 19:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njSIx6I6kn1H33Y6VRAbiOg9zZqwfCYSIIXY3NacaLUIJk3fXUHXDSKJMHPp0JweqLp5xQyL3kfjuQvwqgVocngnRNVYFNIopmqqxOQVEOgwEVQ3JYegwQzqhhzP/G33xTNrpqoH8lOh4oAfpIcfcbCFJOgXGpp7My+PAU6vq7Ajf6X8o6XofrCmGDjE21AcWcAwuAywVv006RoPUp+8ZPzOvvv7BY64YQTQzcUDLseu5HIEiEXxLRqOERXHTs86UQwnCn7c2w/ytEUxFwzy3ABf74RWbHFpcAU4aG3tBH3dbcCBi8cpCQOz6/0dWBBbkJcoYXg7f6d5ikQgZ036cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50VcebYdmxApascJP8SE43uCOYYlJpxGba8bfG6Tkmo=;
 b=avD/NrKD+OjN6LyawmSLUyNg8rW+kNOERW9QafPgTUenhsmCzNMcJX60iK7I+Y/SQyUnwXvJPxLr8GohomvuBeWihgW8fykirxxQqWS6/XoBFAt0QLRIxq6rmDJkuRtgoS4Vfr3KbVrmxgqUIagCuQPUvSAPU7dB04z+prc5zFvuX8CIjfdtNZA/EXLSnV8xsToQgakZlJMSgIeT07REltrYglh4HoRHacnyc/lFLXtl0S9ZUElA89jp+qfL8FGS+A0JsVVexYg2Nm58YReXq4SntC+KrpXB9QO08LKdgy2sr5jWICckY2ltsd10cbyMHyAjPfItHu8MOEhZSMZ/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by CY4PR11MB1942.namprd11.prod.outlook.com (2603:10b6:903:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 02:15:41 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 02:15:41 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsELdwe4rYEhX3kmQ25LUIwgSE62vNNY6gAAAhrCAAAO+gA==
Date:   Mon, 15 Aug 2022 02:15:41 +0000
Message-ID: <BYAPR11MB34959E47398000C2430E7188F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-2-haiyue.wang@intel.com>
 <878rnqe074.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <BYAPR11MB34951FC5879F86F0183C8608F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB34951FC5879F86F0183C8608F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: e3547946-e4d7-4f95-aff9-08da7e640d7a
x-ms-traffictypediagnostic: CY4PR11MB1942:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYWes5y0EjOAANgTLO6ApQP6a+DzGNZz4TsQn4eBRV/04AgaKZF1oHmcIn7zsbsr2nRV06xx0sIbth9yu/OzXkfDFhlCtk804RBnUB+q8oP/mlM2iVUuJolh+v44UyStULtnQMJ9/UG1zhU/etvsSPzlHB4fiBIeV4ZfLen1Har5QIZBQKrIZIPjxzpLpqAopkLjYK/kAONtdi3eC6hFgC6l0tog28ms+CJq9tpOU3wjHxj21DnReVQ7WW3T7FkyuZoXCliES0kNflx7ryPEG8EMKJgus7OpB0W4gsqZ40saoo5aWbcCYI9/vfIscyMlXhLo7SySo8yzXzA58DB+HyWBizApwkAzOGxB8K6ixevukDJQQRnIA+DxcMyQECuK84RQHCN4SZQ7vuUbgAALLVnVtuYbISM9TZitCs4m58Qvfg5ES31A0fkeHxbQGLkwUlUrf4LQ3dMBQBhIq4o2YRj7OoiEPH99ZSgPw9tNGztmRC4v1juOkghrjiE/Tzk2+KwQ2W/p6cpEccxOb9+Kf+27nF0Q6sWpTC+qDlrP5q7txKXDuythCa4BSG+RjSF8UGoPUYAzvgl7YtbA+17dJhcxN3arqYjuTwOSW5eVNAsB6H8HsP0YCefqcqRuZLSo8nRB9uaYw51rgwZUJlec2qa0DQorGPSGeoBG8NxERh3thC9dokJzwVVq7zT71Mz98auKJatP2N7mM+JtIVQIQnBIH6T8/mNGjoCElLHOtTIs24dN0CaNeji1Yl0BfacwLQqSGukdhy6cQWkvULpc33Hpiw0TAnsg5ZnMh1UMpen5cTkTTCv7Ds+f/ko+5+kWv56yG3B2Ovhjg7hdORp/iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(82960400001)(83380400001)(9686003)(478600001)(53546011)(26005)(186003)(7696005)(41300700001)(8676002)(76116006)(54906003)(66946007)(6506007)(8936002)(66476007)(66556008)(6862004)(66446008)(64756008)(4326008)(316002)(6636002)(2906002)(55016003)(52536014)(5660300002)(71200400001)(2940100002)(86362001)(33656002)(122000001)(38070700005)(38100700002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqSIXrQYRwUejdUBwlygYUZK6UYIm/zinE2N7cBol/qealA+1KhKpIUaL0SU?=
 =?us-ascii?Q?xgmGerED9IeoEEOjpSBAxP3cQ+lnU8udrFt+7bS2+pawHjbBWPuaFpZp75LJ?=
 =?us-ascii?Q?dN6Mq0wCz4EW0HrzqLD/jr3mss3M5zqNj1Kf4tgXzSHu8gj9rhh3DYDv2JbZ?=
 =?us-ascii?Q?1ZkvhkSGGtk8ONk+5+Jw26FmPw5UFNXuTb3V/0xSbMR6mlkHGjn1v2q96xR6?=
 =?us-ascii?Q?QRVmQChyOXxwbbY/JAdEg7wrhBVAHw9RG0kb0WabxGf2eu7pThIY1eHD9hcZ?=
 =?us-ascii?Q?7aGBj6+jijXGiGjhmVaMuJuwsgTh0bcbCmCVnDiNnatnuiky/06uxxpu5UVj?=
 =?us-ascii?Q?vyQwDGYuXAi8Ywq63aHhOxi3T8vP1HILD8W+jvQEi89eE3DcvQbjZp0yMHqn?=
 =?us-ascii?Q?1rleUOG/FfQgGcXjq2ZtD6aMUWDIdF+dqZwntEUy1NkJAaKlgFK+b8uRQc06?=
 =?us-ascii?Q?zmgK09/YpgO4UFTH1h2nI8xiSO+H+wEyJHnbvfZLd8iB8jmKBo5yHlmLz9bB?=
 =?us-ascii?Q?5MuTPGwSR6ZQ15ZNfYFP3UdZnpgCrUzQ45ZovB4y9l+DtsbsKzsNISpYTtfR?=
 =?us-ascii?Q?SntyE1KGlSBzEobqPdqwZp9q2Ftr0mVI7oPqaXDxMqN9b6TNThnYp1BdptfQ?=
 =?us-ascii?Q?pGRC+IYqa1Vvef4D7qtt4xay01oiNb82nEejzal5a5dH+sQj308tJSdQtOy3?=
 =?us-ascii?Q?0+NLEfleMzdA7l+okfF4VxswT+LUZhRs9rSwsptuq8/FVffe9plS6g89u0uP?=
 =?us-ascii?Q?QH9sLWlGr6cVUvS6Dk8k/rs4geEJi3R1m80nd34+oGMX37Ck6s0v1mnjIDB2?=
 =?us-ascii?Q?fyhfOx7oR4jVV5QAY3leMkmsYBGEg5ckPbLUSPPlywQ2nrgGvk2DC4lX1FTu?=
 =?us-ascii?Q?k6dvOVWcuicPXl33GDkOBy7EEnrR6ZuV6ESKQ7fiSmUzRUZbIVsAWJe9kN49?=
 =?us-ascii?Q?XiZ6v7V+QCoMEmJmBxRbVPe+5G9MALMWoY7EFLvMQFPHUsKUNsMofTeCagSe?=
 =?us-ascii?Q?ABILhmp77diCyns2Er1L5+5ds+KHGqfBKX0ik4JI4vVXPkLPYHJdFLLC9ak8?=
 =?us-ascii?Q?Y2yb0HSwzvaNMCMlT/HbxIeI16iM0C0OKtAOSbxrWhZpdaJPLkpa3l8IOr87?=
 =?us-ascii?Q?qEEs5lXLejLTkjwnhI3fRJeEa951CenuK4ekF+E+H36LObyEElqS2ixyJsYr?=
 =?us-ascii?Q?4pMhqY+d7fY05E9ANQAT4a0z2xsphgDvlmxeXqHOJCSRtxcv1OhNjonkhF02?=
 =?us-ascii?Q?G0Zcd+IryGYWhrn+oBWb1SAH46WmMES7VtVjB0MCNSkLT1tKrQSEFyKS2Eoo?=
 =?us-ascii?Q?SL0HKwUmB3WTrNXjVplhVf7/LEPBzkMmqyyrPD3aUcL+N9PC+6dUbivLVxmp?=
 =?us-ascii?Q?39ZfCedNzIMLIbRSnJGLr6be+LMOGuZNuOdLigEKjkJqgC1PU4CxBGdl1RaE?=
 =?us-ascii?Q?cTad7HvIILC6D+MT/J6JaP/xMWdLVrv7kDt6W0gDQ5sNk2rlyTyYEC03Ouxe?=
 =?us-ascii?Q?VBDRJRw32YbJbYBf9wKF9JAD4Q316u3HRt5XxhYUsMLd8MteCD2q3TlWSMw6?=
 =?us-ascii?Q?whC+QliDMKP2YyyvdBVX1wwiIqNF220+Ed+0yZ+a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3547946-e4d7-4f95-aff9-08da7e640d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 02:15:41.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fqv+jWPMxnsQy8tm7og0vITlxbvroVZpTcx3tAIioFtWPuZwRVPbWAUMzMJeKaSJ+ChZgNf50/eZ1qcXAYTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Wang, Haiyue
> Sent: Monday, August 15, 2022 10:11
> To: Huang, Ying <ying.huang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundati=
on.org; david@redhat.com;
> linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.dev=
; alex.sierra@amd.com
> Subject: RE: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> > -----Original Message-----
> > From: Huang, Ying <ying.huang@intel.com>
> > Sent: Monday, August 15, 2022 09:59
> > To: Wang, Haiyue <haiyue.wang@intel.com>
> > Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-founda=
tion.org; david@redhat.com;
> > linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.d=
ev; alex.sierra@amd.com
> > Subject: Re: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on =
following huge page
> >
> > Haiyue Wang <haiyue.wang@intel.com> writes:
> >


> >
> > > This is an temporary solution to mitigate the racing fix.
> >
> > Why is it "racing fix"?  This isn't a race condition fix.
>=20
> The 'Fixes' commit is about race condition fix.
>=20
> How about " his is an temporary solution to mitigate the side effect
> Of the race condition fix"

Try to add more words to make things clean:

"This is an temporary solution to mitigate the side effect of the race
condition fix by calling follow_page() with FOLL_GET set."

>=20
> >
> > Best Regards,
> > Huang, Ying
> >
> > > After supporting follow huge page by FOLL_GET is done, this fix can b=
e
> > > reverted safely.
> > >
> > > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array=
 racing with memory offline")
> > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> >
> > [snip]
