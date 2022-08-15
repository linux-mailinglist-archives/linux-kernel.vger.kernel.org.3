Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC5D592799
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiHOBrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHOBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:47:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA611838
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528049; x=1692064049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lg/5/cXpBaqa6ydIVHvSMJMDr0vUM3zTnR1A5s4HBm4=;
  b=nYqP0smjc+ewUzsgygdmW6cADLkhKzYph5S9NqxThAHKN3izM9xk36+S
   hgHoXtsMIZbS+NdfslS0uwDz2tcKHzpX5AM4XpiwaxQNzpN+/amYMACu2
   kAuCNMugWl7oIpGxe3zCBiklMaxPKoJOdL1KHHR7eFZktSu20R85R97Du
   T3Qi7oKdyZ1pixczzlwewmqcYfIoZglxbwIBSLGsnbHdjO6btyyzvm4yW
   4PVUs0Rdeiaw8zq+osIessaSQu/WdT10BwTLfk2d1xeRGIdEJxYc7NQI5
   k1DxkCtmmersQb6GH1PIaMgD/jDWyPhjUa0kII856VswnjkE40Y2VaAVK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="291869080"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="291869080"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="635311720"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2022 18:47:27 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:47:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:47:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 18:47:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 18:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMmelniTpfNEmTgS0h5Hhf7lUyyW864GZKPl6zuCTMMnrrT0ZLwxUFcLbQ7hlP0Z3nMB45d960MBvSxzWpDXQzdv3W+aJHZmD+7zlsaISqCycywrThxqb3/kxakjoxJQK/BbvdBYmBYXrfoLs7h2J7yHLq98XbgFp8Qm4BZLLWexqOR5WYTqhBIs4dr6CljSCgnV+P+3ByKSTupxdwPVL1ZZldZLatV/vDYMKkbpEIIZMdew3RYY+szE5NMokkwSMKLmiNaGPwwwiJyOUNBa2BS6eZ9CVpGS5iqAVHuug26QRLklY5VugHrkRZiVdlQyaHTuZ/7jbsxK6Bx/jaueuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCOYaEboymHsJYevNAvQTgJ2GLat/YBjf540VCYINAo=;
 b=TqtBxZe4HcsDOqoPvDDl8XyiNdzqsAHoAlIzZ5nfxg9onK/ECd2MniOD4eW+xboKZ/L959MqXC1QdtNAuh0CzVcuUCOyZfZqF7Le99k6wwgzxIU16RS/1ZgQ98yYsPCi44sdNA6LiH4cSfz2TObNoGVVyZiOQgWbw9s7CcamUOIH/+WNVSpJKW5jsz43YzCuVbSRpSj4UhSQDXI12l1ica7GZ7jvr7bROsLEI539NMjAx/XRzCqj2UTeZ3lOIrIL6WqpVCdgSLIuBFOx/4Fkpr7sT230QeJSXrWzDlTtkqRxaRI0cyzUB9/OICjAJMnYObXTQ63gtmI2+L23wsdz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:46:59 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:46:59 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: RE: [PATCH v3 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Topic: [PATCH v3 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Index: AQHYsELgmLPn7hXKS0eClb7ub+l7+62vL4regAABCHA=
Date:   Mon, 15 Aug 2022 01:46:59 +0000
Message-ID: <BYAPR11MB34957681936F3AD544E9BB5DF7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-3-haiyue.wang@intel.com>
 <87czd2e13k.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87czd2e13k.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
x-ms-office365-filtering-correlation-id: bbd6c9cd-bb97-4aed-5488-08da7e600b1b
x-ms-traffictypediagnostic: PH7PR11MB6770:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfsfDBDxUaKJWP4jMFZBD3L3MvhaNXybu4R70S4d1Na9z+FiGFU75RlCei18u6agZYyeJ3OqMjPeLL6yGwvKKUaWz16O4wBOhHGQp7XSoAjol148CSFbPqXigrEgQorJnp0kgVpDxTdcccB5wubEp+aJw3Sk1BTgL/f5iL8BCcMLmHhsNst4ejoLC6pGkqyzoqottQXJTRWxPi5fjYtcP3zpt/ahAkMJ9O9mCoAphydJoeHL+BYfpWVCCmCUo0krYGO9r5d9VHIf6NvnL5PF/WSS6i8uCrtClmOXDq589qobnLumN2T7ISmlH44/fCalHSKQzBWP1PM5JnqGFGDmNzq11nppJVHUjALnEgDQxvkwXWbxOkQhklcRjSsIScByNx6xFfY0+gyGsxZc0jxO2134QPn0YBaCc8lVubiwz13wX/KOmDufJPvrhkY2Ue1Ca9j7zylaXhhATqkvr3IywYJFmybE7Y/2Zo309Im1WYJfqPsWqw8nFTjed1JKDr7tfOom0+g1Ts44kCyIQ9S9H6LwWtgEC3Q27vfaM/EcmUeKVqBwfOEkz/oGm599IqpdaRnZQxVsKOoe40BN/iAh7Dt2wBgVlE4OqSuw5UWrx2n5fYiSsaaodpRKIeoGR1D+xirOsPDZoMQS1wXYwq4mrPf0drDEGs4cCkB9kZEj7MON4BsPZng7W5Y+vzipEgR/tt8em4mOroEQM9zTPVGJz9TD3dBFkjct/LTNW87GQgquNiRTL9onfXM6kD6JFEnGBqgaoCyJRAC+XGgyyYO7ApdiwT6GaU3xs/Fc8mkEtCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(346002)(39860400002)(6636002)(316002)(55016003)(66446008)(66556008)(64756008)(41300700001)(8676002)(76116006)(83380400001)(4326008)(2906002)(66946007)(54906003)(186003)(38100700002)(122000001)(82960400001)(26005)(9686003)(6862004)(66476007)(33656002)(38070700005)(8936002)(86362001)(71200400001)(478600001)(6506007)(7696005)(7416002)(5660300002)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnHquES3r6bskhDercjzc3hon2OK9woyH/zoyZQ7+IrKzmxJAw2Ho0J8tmi8?=
 =?us-ascii?Q?C5hKVkg48lyywhTsqSXIcCvCbHDDZ+6igVnvcLmXyz78H3XHaQ1HrDeu1YIC?=
 =?us-ascii?Q?TRCXS/rQOW2Cezj0B0RRY9aBnJywYGTbSvV25AeSKluVyrWgcDtEGJwgsxfO?=
 =?us-ascii?Q?YXXsyco0DLx4vBzHE5LrxvOLLBBOSrMIr8BhPktP/4vvTSftcjSiQz7gszGw?=
 =?us-ascii?Q?abHtdva8OxHmET9TJdba4EN7kjaZGyKF8fNBhrjgNi/2GbpZkmiQvn2pM/LO?=
 =?us-ascii?Q?WDqUWGZziEm9V57div08K5xJeBHu0TGWPWggrNns++xgj6Ek2qAcGYMrhjFH?=
 =?us-ascii?Q?MmzGb6NCvmXaRrtGJYotOPL1OAs3Jtx5al+Joc0Hy7+lWGBmPN2RfxoymQpq?=
 =?us-ascii?Q?4yf8KOBuORZB6tVRAZeOVIyoYhvame6S+bJ/WogbamXbzNa2VLk6KpZUjijB?=
 =?us-ascii?Q?j38ZhB0ro2eejdUsLPb62cUdhRkREWFw4qMfbobxV7T9QNQyFxDqJMWhV7pd?=
 =?us-ascii?Q?VzowLdPquYpdUDtBwlJKQ/lWqUq8QWfDYGPfMPxprL4vM21LSeFuHwiN7ILg?=
 =?us-ascii?Q?IgVFb9MHRpa+ZODZX6xDbXfyzvBSwk5Zi1Zwrg6CSIP4pcweRHHh3Gog8HqL?=
 =?us-ascii?Q?hPVhhvcrBzDku4Obd5Ox5Id2skNbgC7VjmNwpVA+d4W/xJqAOYukoer0JcK2?=
 =?us-ascii?Q?6EPQSQlI/OEOOrfddmp7q/8JZeWn24u5TrRs1T2EJkajlWD0Gwcx1oYax1g8?=
 =?us-ascii?Q?57uVbp1LK6fzlRSC6kZIvU+w/e07a8NmWFhSyk93V4Lf8BCYNQeXcV3gS6q6?=
 =?us-ascii?Q?dhfV+KGX9OsWE4ZDd2lUAJByCZ4wNWHKqZI6ScTCumeEBtelUnePbHO+6sHk?=
 =?us-ascii?Q?4wbls9lAGnDXl2ICycXz9hsM8C9Ry+G1OH1ERxWISIxL+1Vo5cfODhvHAUFu?=
 =?us-ascii?Q?RfzHkLZ5xMbtLnmLiNUEPRK6yLQ3HWblOV+U9o95KiCq9y+3KS2KxzzsWMmL?=
 =?us-ascii?Q?snykq3bHoYwzhv9nZfOAd/TXreRqPi6O/jNU3nqmEs8Mj+y1ULSvyjBlt1cs?=
 =?us-ascii?Q?6GhNTlu7SAFOaoYT02i4XXvCf0qD2fb+nNmDJkhxgJExbrVuznZcOJTLXl16?=
 =?us-ascii?Q?xq9MnmdD0tIXnmi7fmM+1Ch3U3vVhwDApi7jEAD0B87K2D0wqv5mkMG+B4XR?=
 =?us-ascii?Q?/Sx9fEuWb3tcuiyX0BGiwoNwSRq5TX5Qsq3zgeemNc075f7L+ZOomIifKgQK?=
 =?us-ascii?Q?G/De64rbZpzI5CNZm0ZF4uIWEwyJ6SUmpNXTKrrGrycBWuS6MJ3bA7+edkiE?=
 =?us-ascii?Q?A3FD+oBq/yAlRFQeh3fOEakhZB3uvaK82ra0gK85Pz1iXrjjsCm8TyHe2MdJ?=
 =?us-ascii?Q?CoSDBbUI/b1l5mTnoGSuGrcpoKtJudKd6SFdwcWdKcXzzVOkj4DYOxZratkY?=
 =?us-ascii?Q?4ESoWvFowM6g/am1/QnJnVJFqs5WX868M9F8DY8qnE/Vq2ipz1N4069Pqou1?=
 =?us-ascii?Q?AkeGI1RzUzvMJMe+JmkIxHZUwfDQZxc3cRekLrOAKhq4Ux4Xvdol5PzkGZiY?=
 =?us-ascii?Q?NZbLCGd56JwOr09nSIjTNTKsitZ9rjbzdwn9cdIb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd6c9cd-bb97-4aed-5488-08da7e600b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 01:46:59.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu6ftBoHbWCmfB8OJj2g7IP+hzQ4Rr/oxDehaRDL9GvTaqBscpBCoY8Z+kx3uxSAWzSQOW3+B78LYmMucIcxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Monday, August 15, 2022 09:40
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundati=
on.org; david@redhat.com;
> linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.dev=
; alex.sierra@amd.com; Felix
> Kuehling <Felix.Kuehling@amd.com>; Alistair Popple <apopple@nvidia.com>
> Subject: Re: [PATCH v3 2/2] mm: fix the handling Non-LRU pages returned b=
y follow_page
>=20
> Haiyue Wang <haiyue.wang@intel.com> writes:
>=20
> > The page returned by follow_page with 'FOLL_GET' has get_page called, s=
o
>=20
> Better to add "()" after function name to improve the readability, for
> example, "follow_page()".

Got it, didn't notice this. ;-)

>=20
> > it needs to call put_page for handling the reference count correctly.
> >
> > And as David reviewed, "device pages are never PageKsm pages". Drop thi=
s
> > zone device page check for break_ksm.
> >
> > Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_=
pages")
>=20
> In your patch description, I cannot find how the above commit is related
> to the bug you fixed.  Add some words about that?

The first commit session, but maybe not very clear, will try to add more wo=
rds
In v4.

>=20
> Best Regards,
> Huang, Ying
>=20
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  mm/huge_memory.c |  4 ++--
> >  mm/ksm.c         | 12 +++++++++---
> >  mm/migrate.c     | 10 +++++++---
> >  3 files changed, 18 insertions(+), 8 deletions(-)
> >

