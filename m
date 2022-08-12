Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48423590A75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiHLDFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLDFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:05:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFCA1A45
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660273500; x=1691809500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QXG9ATJjakBHe5NkDGul+1kxvEdWSFVKGc9HE376eLk=;
  b=VLdiOTqc+cIJJ2whv69MZR5ssILG6nTbrlcu+bVi6wnloS3DvQH5qnkp
   Brge3YzX8G5ujAV96RjdtoZErMNHZd2jNH33/CO3n4YABJ0GDAn0beWKE
   YQ2ez1bvD16XDTMuIl411O6vgXRaoMNnFeH6+C1eJwiEctnfX8Q4Jq7H/
   n2EvbgvRKeJwlrV119hV1EnACbZqE1BuINZRgIeot4Sm9qGCndbow9XdE
   MCh9E+J1qN/PSyL0xgUJbMflShkSsdWO968BQtJKhA0hcLcGOqvXoooFG
   jFAIc9BlJRAtB/nmyP6LF0Ohb43L75SqBOOA4NcUfhaxHAy5W0KcW7Yje
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="278459288"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="278459288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 20:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="781822078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2022 20:05:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 20:04:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 20:04:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 20:04:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 20:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgYZ54bvTcSFmQGqMdlVDmeelhp1nEAjwoiIz5sOuRIUM9nwU+JqEpkWaDJo2SZiqcDkXc9gGHjv0c1Km+vmav9vODPaKUQlyEX4iW/IMM45am+vihYUjtkSORbBdvVdR/5fdipXSUajJ7+lmk3+SN2BZfcFX7Z9TLTTvweU/soOSmZV7FB39xSVaSmr3cHeplWZ+0WNfFRKCwQ+sWW0cr6iNQ7CCo7pzZVqf1S/s9owbeMdNS5yMlfuBFGNGrc/NvetrbD26tJQtJ6W28M5RUq1fUTRR2dSz1BKPspBjLue0iIPplgrF6ykMggTEqelRdXgAp7R9apveP2ZF/xucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXG9ATJjakBHe5NkDGul+1kxvEdWSFVKGc9HE376eLk=;
 b=ZuVd7wrXiGXxnR4fYXNxnNTy7DUDNeLr6Tjy/6AMO/FoavY7NhpErHei9nShyVOry5LK4h+M02KG845S2RUoFktx5I0Z3SEYu3VRH7gf2TY6IEWbN/hUaO4zKPySm6DJBYbvyYEhSZcMej4jJehz9yeouYO9niMgBF/DklBM+46GlawAk1SRJSaDKuCc2csghht1/OULo4SnhycgNX/7haAqMEHCATDBlOz4C0UGNndtkpoe5iGm/Vof2nTVVgGUwiqwm2zpFMw0ozYOuafvmPyyHmuVsUSPYk0ps0jCPkpudFE0lZTF8R71xTDq7DQsomp7YKneJ3PVu7VcTprrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by BL0PR11MB2994.namprd11.prod.outlook.com (2603:10b6:208:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 03:04:57 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 03:04:57 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Naoya Horiguchi" <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>
Subject: RE: Linux 5.19 __NR_move_pages failed for hugepage
Thread-Topic: Linux 5.19 __NR_move_pages failed for hugepage
Thread-Index: AditV6ayifgPLLrQT++lwJgko5ZyagAl3dUAAAFiRDA=
Date:   Fri, 12 Aug 2022 03:04:56 +0000
Message-ID: <BYAPR11MB349577B5D98EF6748CDE8873F7679@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <BYAPR11MB3495837E180867B47E551EFCF7649@BYAPR11MB3495.namprd11.prod.outlook.com>
 <d3966b09-ce41-9e92-e676-262e84b8e2e1@huawei.com>
In-Reply-To: <d3966b09-ce41-9e92-e676-262e84b8e2e1@huawei.com>
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
x-ms-office365-filtering-correlation-id: 87d75517-22ae-4dfa-e934-08da7c0f6fd6
x-ms-traffictypediagnostic: BL0PR11MB2994:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3MURhbhmnYRjc0cINPDRGdWhnOwjuWLgvyrQyAFb3XTuWsEeIcQcQm4v9VZeYEmXz7/IKqKmwU6aQHAyyDyyFg5J0+9cdDEUh8m2wPM1ca0qoD4jBkFtu1jxiQsvz3JYspw3w6M9YKzkwyYjmnFW7x3HrGEYa+QMevbneGFjKds9vFs4MW1OWzWgluu/hihAgkR7H4bvaqRNMi+i1hJ6vE1J19VOo3b7AiW0wuZ81n4z7W0xje0Em5pzJQ1O5UUd3d1lVhQHKEGKDVvrjzvPCe35snXBA8nO8IYAYb6J4BweiUe9EV4m33ktJpDAF/0u/3wJjdujAtctxnXh0Yby7y9OjwPCGJNt+gj7mVjMIpUvaRZeywSciBVecu8+Bg7HZlkcdetk4o08txY5s/e5LNU4zuE1U4IYLVPD52wvJA+ucGJPUamLjdQCrjGOOXKl58bTNDiJPN0AJuucgcrQDB+de0T3KPXL0YPhfwsg1EmPEpPW+Ka3neZCW7d476b7WkgjgzEK1Pw50OhbODpV6MlqXr+7hL9Nve6N6VavpSm2xvWV6kceW0/LyeEF2B6dAP2AwWPgbdldKMOdxkFOVPvn27QRIwRP1rB4XTPlYipyrEGnW1JFWx2sAjLqFAQ2cFrmgYRnLU3V8uugGoHyK6FDe6264NBtWCi+DPW5XDPhqQKJxJbDeeiy0bb1RgzHqRi7nfI3jI1tWRf29ut5PDg/XZclUOtzNNas1WcCKpFX834onRMsx9yz/5sCrHVogPRYf26z0MeHcSNAf2YERBVJ0N/bUnsYPFbqz3tEffaDO04l6v5ZyDK1l6sR2jnJTwk8IJw9+g+gxW8R1SeZ+rFB2NFTPH8CGATGyunbu4MDCkG2I4Es7S2RuS+jkpc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39860400002)(346002)(396003)(186003)(41300700001)(71200400001)(53546011)(86362001)(55016003)(6506007)(7696005)(9686003)(26005)(83380400001)(6916009)(54906003)(316002)(4326008)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(33656002)(2906002)(5660300002)(478600001)(966005)(8936002)(38070700005)(52536014)(8676002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+60OD0l4ovOYA7gS77weMSaktUXOG3IB81ugzdDCdXNYCKF+NUC4QP8OHUSk?=
 =?us-ascii?Q?3if9jiuUBiiiZ7jNU5tmY7Frx21zetqxTFPFMDEeepcACSyF3mTQmExMtmiv?=
 =?us-ascii?Q?jo/XBS8jY4XLq5poYd9F78+6sDjKGBsiDEKgLBG6tzhR005U5uAzFNnepcCO?=
 =?us-ascii?Q?XDcuOR+YgMm/La7qQ5YAR6sG2qK53p8/+9tad0cXG+mv7QLNe0GSkcPL0IJJ?=
 =?us-ascii?Q?WAftG1c830i5+d7qC4Op6Nj35V76p6zwkmIhWVRaZgIP3xwpPD0RPc5k+2Qn?=
 =?us-ascii?Q?VAP7wP/VR2wY+v6f7AZ43M6yI+zcQ8/X3uJN/K6WFSl62+zvR39Sz3y5riZL?=
 =?us-ascii?Q?zLgV2yKCWGsMHtn6lgqck5D+XZZfHLcnQFt1s0ZmZsq8WhRjPd3Gqa1CYD9A?=
 =?us-ascii?Q?xY7Vu33OlByBQmO9kmVjWyY9cqZ54LCGkZz1YuK1NlI0hbWCcIFNzA2vtvUd?=
 =?us-ascii?Q?zp4LDLniZndd5rLmY203KZaR/hBPn47rNy5n5f9KFkIffe7F3OJ9Hg1ROk4n?=
 =?us-ascii?Q?B/YNgt2BIGJvpxImqSvFUdhwoaWYPmBX7V4NfhoeEmn4Rqup0xsL5ATcmGph?=
 =?us-ascii?Q?VnB8L17X+pA+YQnZZKFTeY0nK3U5MFyePd1/LCrEDXzNDNh2W6CXD1qYzo/h?=
 =?us-ascii?Q?d4QX5EAOuXF210++R4lqlVo9NVkqiRpZ3aKnYwwdUR6kjrzt/IlB7lhj1c88?=
 =?us-ascii?Q?fZqCHd5svbM1Wr1ijeWCebl3rYPPdLNb5m2UJvkXs+zkCqbrNT/9SGTkGYQN?=
 =?us-ascii?Q?BV72hXgo2jpPlhDXZJJkq4vRWnJ5trOxyvacTSEyhUTqHRpYrE/AtqdeIeLV?=
 =?us-ascii?Q?VofgMP2hVVneMBcz+k8MT5Qoir+P3XBfqpgsq+EMlh+iaRKw+ff2yvHDChDo?=
 =?us-ascii?Q?tQoLUGGoGavpCy8prmIjkGOoHLVtSva3iijoIXP8HNXi6GHQNuGmBvEWfSB1?=
 =?us-ascii?Q?0BVvccBRa8axqvlBhdZknizhe1Kra9zzxAoBTL9fpCGB0qy2Vtl7JxQe/P2r?=
 =?us-ascii?Q?eal7ulmNPv8QA/OAmofvbRd52hV4fs3WcfVitztS/OulHUzoVhbBTFWmZhJx?=
 =?us-ascii?Q?Hf2NQjYq7zkFdpv1nFAqldDGsDc06GvXhv4A/7+aO3onSkaVQM1AEnVtO8Wu?=
 =?us-ascii?Q?2MYKkCEZhnpdeM3dWDbwboqMXn/PNH/BhNE++etIpp4cqcQKfMjAz3WuxEbO?=
 =?us-ascii?Q?gLOIcLmIP4ecSrfwGHQOZDawG7Hfy22iUyyuZgbTSnHWjU0tTIxG+NjcFtfd?=
 =?us-ascii?Q?DywflQV4+OGm2Ai9FFIajhLo6dgwIG2b8/KtSw2PkG4pOAcm0iRNPkpkI2ev?=
 =?us-ascii?Q?ef9UrN2m98fiNzcA2MC9sdKCDzlQTb1mTp8V94mE1exczOiReJPQlK0yOf91?=
 =?us-ascii?Q?ruTgQT70U/bQ8jJnUMcoHEw5m9A4Pe+mad1Po4tXgeVciQZJ2vpX5pDL8xYr?=
 =?us-ascii?Q?HzG0JGZO2/cBmRbqlY8WBefpJGGPQFQYR2VXe+twKnsWLKOaEyaaDVOJ1Fhz?=
 =?us-ascii?Q?XqHFJskjTN6AJ5bsG0qH8D8XdCbPgKOpbxFg1b+Zi5hor5z1wKxI/OWZvH9t?=
 =?us-ascii?Q?TOSgrff9yjSKU7UFVWXd0oXYQlg9WHU/Kb0JjOlt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d75517-22ae-4dfa-e934-08da7c0f6fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 03:04:56.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC1hag6BI87GGZkJKftS1n5vY5vzgT6WR51/l1wxOalQRSiw6uR/4Pgn5cu54tRJeRRrPMWS/bGyVeW+yjpGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Miaohe Lin <linmiaohe@huawei.com>
> Sent: Friday, August 12, 2022 09:59
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: akpm@linux-foundation.org; Linux-MM <linux-mm@kvack.org>; linux-kerne=
l <linux-
> kernel@vger.kernel.org>; Naoya Horiguchi <naoya.horiguchi@linux.dev>; Dav=
id Hildenbrand
> <david@redhat.com>
> Subject: Re: Linux 5.19 __NR_move_pages failed for hugepage
>=20
> On 2022/8/11 16:01, Wang, Haiyue wrote:
> > Hi Miaohe,
> >
> >
>=20
> Hi Haiyue,
>=20
> Many thanks for your report and debug.
>=20
> >
> > When I call "*syscall (__NR_move_pages, 0, n_pages, ptr, 0, status, 0)*=
" to get the huge page node
> >
> > information, it is failed with '-2' returned in 'status' array.
> >
> >
> >
> > After some debug, I found that "*follow_huge_pud*" will return NULL if =
'*FOLL_GET*' is set.
> >
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De66f17ff71772b209eed39de
> 35aaa99ba819c93d
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3De66f17ff71772b209eed39d
> e35aaa99ba819c93d>
> >
> >
> >
> > This will make your patch doesn't work for huge page.
> >
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4cd614841c06338a087769ee
> 3cfa96718784d1f5
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D4cd614841c06338a087769e
> e3cfa96718784d1f5>
> >
>=20
> Supporting of '*FOLL_GET*' in follow_huge_pud is introduced via the below=
 commit:
>=20
> https://lore.kernel.org/all/20220714042420.1847125-9-
> naoya.horiguchi@linux.dev/T/#mb3c83df087fba454b7b4ea32227fb8775ca70081
>=20
> But that's still not perfect yet. For s390 version of follow_huge_pud, FO=
LL_GET is still not supported.
> And pgd level
> hugepage doesn't support FOLL_GET now.
>=20
> >
> >
> > Not sure you know this issue or not, just share my debug information.
>=20
> I'm not sure whether it's better to revert my above "problematic" patch f=
irst then add it back when
> all hugetlb pages support FOLL_GET.
> Or we could just live with it? Any thoughts?
>=20

TBH, the issue is more complicated than I think. :-(

Looks like only '[PATCH v7 5/8] mm, hwpoison: set PG_hwpoison for busy huge=
tlb pages' will be
backported to 5.19 ? Only this patch has "Fixes:" tag. If so, it will break=
 5.19.

I just run VPP 'https://fd.io/' to find the error message about huge page a=
llocation
after I switched from 5.18 to 5.19.

>=20
> Thanks,
> Miaohe Lin
>=20
>=20
> >
> >
> >
> > BR,
> >
> > Haiyue
> >
> >
> >

