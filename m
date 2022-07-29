Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1593E584A04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiG2DBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiG2DBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:01:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049968DD8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659063661; x=1690599661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xgSDcmGerdj8nZT77duN+p3PksE1tk7I3EW2RSMJAS4=;
  b=ESxkoNegzz/t4pi7jh0iOcUhtGqF2X2t7x7No4CX/CGeAtco3KyI9/Vc
   E+INVq5AEBdzvFljkpLUYCxyNsH/NYeOS8FcFNcWlCXzragiC98NCHeXP
   Eb3qCd1G0nzL/FEdL1GvoIxmhfjD1l9x51LiWTZo18q4crSn6CkE856SG
   ip5OfF7PZbWTMZJ4xjdb9iwLSso3DrZXOcX54FgvKQC4/MJV7bnqS5+vP
   JjsEldnpt9x0kb6bSecASlFVXNtpyFLERT1jszTa0vMCv1FVynsBYO9jM
   u+pNJ/dZu276KMaOTaCQTewY3IGQtnYMYIwUFP3altDVOlSM/lS2UQ0Y0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374979291"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="374979291"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="604827949"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2022 20:01:00 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 20:01:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 20:01:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 20:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwD0sZXtZ4/ugh5L8msAP03En7cer/OlyW9oi+FAP0Uhpa8KSePmf4avi4vTpsMB5v7Jz37zodZJREHXCZkYRgH3SVTOnNnmFB6fBYFiyscPeVJltFqIy6bAvUE6pAEE5xEHnpe8VsyT22I4F1qx+VhhJdq/MFzwCsIswjzEX3TBlbrIVtuYgXyLXkk3E5g25ejQ40NR9Ik3neqLZc/wu7WjzSIjyKHzomrD4vfPinp6RIwo4SfHyrJhPHHw9AI1gtohekT/zrC6EhGLg6dunNUH/06DQE+2uXv7KQ81pfzz48/NyS3jMTodtWppusR7/ADfavKW7QZRetjSLdsvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpiYlbnfqQ9sN0DmUAk3iIaswBg55h3Qjs8jTWSc5TY=;
 b=kCVuciXpl/yezAhkr79TaQgzp5hvzesQYPNohKp2AfCWgi9VrsHdn5eYlq/tb8tR+SInEFZBDIRbzK71sKCYmA4RbQsQtZcCZA1iMqBxwhmNXh2a2InHAxwDv7CIbUmlq0gpRKTmLRiNFrAgp1BO/uOKLKkV9X3n6wCQyBsNe8SrsgS7rO9gaj1jcdCHpqKe3PJ03Mu7R5lkRQ/Tv8d3VIU/RNBjGDp8VRCB9D4kknZ2cvUt/1XTwidEwg1Pc8IiZF5mz5pT+bJK4XwjYMycgnS6+e1+2+YwzlN1hTWg5Ak0nlKMjjpGHHi5stTYfwahX3lG0wVneS4HRfz2hyFyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 03:00:52 +0000
Received: from CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::3122:d9c:5323:6f8c]) by CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::3122:d9c:5323:6f8c%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 03:00:52 +0000
From:   "Hu, Robert" <robert.hu@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv5 01/13] x86/mm: Fix CR3_ADDR_MASK
Thread-Topic: [PATCHv5 01/13] x86/mm: Fix CR3_ADDR_MASK
Thread-Index: AQHYlkUVsiMqTSAE+0yet7IGhjNcfq2UwScg
Date:   Fri, 29 Jul 2022 03:00:52 +0000
Message-ID: <CY5PR11MB6187E92E7DA80111BDBA1E63E0999@CY5PR11MB6187.namprd11.prod.outlook.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <20220712231328.5294-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3172065d-e0d6-4263-c464-08da710e8c77
x-ms-traffictypediagnostic: BL1PR11MB6051:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHuH37Tp5P0DhNWlN7pkvHOTB8keFic9CI3j8K2b3nz6/eHoyQ/M10VKvjRji/8Y7EsoAf6wwqR2yWRoWPj39j3Dp3Eu+Etvdyw5DxPEEzWWJ9ue2eT1hMfP3t405tDHb/o3WCaRqTLHtXr7P8Mg4u9do0Et8LRTIysmOb2iSGsQ0hRiOx12fMriVYH9N0in/hSR93A3+bHhjytR8Rc1W6dHS/57C38O2/GU9LNTYhlMfgBZqj8WjFpWtNXYwOuCzv3lDgl9eBSWVev9rn8ig/M1qnHdaJRHnT583LyWxkbuKP/ub4mR0CQAwiKRctTSPmKXmHoYF/uqIt1Kyp5we3biwFJRUDh4zQ+aktOh+FqNykJe08LZLIGmcutp8DLK3BQM2s3j14K6h9Lk5tD4CaqlkyJmzAWcKUwPPehib4wZbqMsn7xlepbW1GqQ4D048js/pbL9Hd/xzPelVVaFoxr0wHDCjEFHmeAmILiHO6KiyH7s7DRwn0K8qKXSHDbsgClvrFtHivnL7ck56ni78e9Cd6QyMozByWhKiGWXV346F4ftZhm0bH/JeBHSEDIUaKtJHgWhum7CcjZD+Hpg5buCYqgTv/2ZFxVzO8G+XcL7JnOHXIj+uR5bbaOZm6wlRvOElEVpZ9Ni4/l05wGMLR9cfclB8kdJV7kIU7J5H5Hz29ozCEyjcmmaEm0aQszLKr2+Z7yb6LpWuvtNqz5Qz0ksj+e7zpWO3dz9T3DSdBsvcBURkcsYCglc/aTR2FfoGHobClyi8DGqmDX06X7c4bgxLB5UBsu75CZQfzM6WAR0TDl1h2MwLpREE7bD5Wmi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(5660300002)(7416002)(66476007)(76116006)(64756008)(186003)(8936002)(52536014)(2906002)(66946007)(8676002)(66556008)(4326008)(66446008)(83380400001)(38070700005)(33656002)(82960400001)(86362001)(122000001)(55016003)(38100700002)(71200400001)(316002)(9686003)(110136005)(54906003)(478600001)(6506007)(53546011)(26005)(41300700001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Alffhe8N8D06/YmLekoE2vpxSlUuj2h8ShhVZn6stn4dED23pVM77QaGIo6J?=
 =?us-ascii?Q?TySe+sTxQro15gT9KxW3kygmUFO5Pr4oEox7rJ5H9s8Im5aI1xGDR4EwAMwr?=
 =?us-ascii?Q?aviLymZ2I8ufhgBFQTAjJO/8fFZDg7jBoCYi0WgF1RTpZWoYrGSZCQTVd6n6?=
 =?us-ascii?Q?Ld8I0mO3o2V1mJhzpgv18zaSDPn4qPhFDjTdCfzEMCPigKwVNPTDxwV8zdEA?=
 =?us-ascii?Q?j5plqU20xH7bhlFp6MhnwloMDS74ZtW3ZlMotVbzfXRgS/Ybfd7RZUnNlfR7?=
 =?us-ascii?Q?WuPUcbJS53fttxuEgoVP6/EIL9iYs5P77ByUzh1OETIhREqvy68BXmmT12Mf?=
 =?us-ascii?Q?ROO/JX5VDC2lf4luilrv9quMBtAN1IAUaer+oxNV4IOVPzkeFas4nr7DEqDP?=
 =?us-ascii?Q?M0/sd6whrHGZ9wfpNT9bXGWOxbodSNzxSV19yBBTYqVJt7mNcSohZ5Tmf422?=
 =?us-ascii?Q?JASzKMrywi/ULJkRCJRfpH6TIQmNpKJ2XkP4YPgxFy6eTPB3zE2D+OJ7Uvky?=
 =?us-ascii?Q?hnnMyiEEAGnUitO2cTopEAvAhiTJgLPX/9mDSEPuYKMgNcO0NKvHpiqwBYDG?=
 =?us-ascii?Q?6LwmkI2Ud2nie0Utf4a8PY4CbuoUp+kgfKlACxASa8kur4J7B2NEE3K2mHpO?=
 =?us-ascii?Q?N83rwTTUs6PGMtQlVVqa8fRxCodqhUREzz3cbw3m1vXhgrXMSHg3gssWqbw8?=
 =?us-ascii?Q?b1u79xtC8k1WSQSqXknm5Ni40vkCVImLAe8NYgnAds7eCwBCd+QvCVpReWlD?=
 =?us-ascii?Q?8+47hPbvo8UtbwgPYCm7nrYJfYfCXtEcuRWQgHdscNzd7tqt5xObeBxiHBX6?=
 =?us-ascii?Q?5vgSZa5XNrh3sgelY6uBu1Rl9nz2aNepp5Bj/mS8ICQ0f6OiMbBIeLVeRVmm?=
 =?us-ascii?Q?VHi7YX4GiAeaDqaFpt8hl0FP9djAZ0hxbWvZftvuMLbheSbhT3tAv7NcEgPh?=
 =?us-ascii?Q?xm8DrjSXVVFfIzsxrku1WdzfByz4gPv9mHU8h3C7CJDKr/pH+Ho+xrJxzs2U?=
 =?us-ascii?Q?d+5ofnR9GetUxX2WGqwIiVBhai7PacNJ1gB3Q6XseLC29Rk/t/eR8V9fmH71?=
 =?us-ascii?Q?uwoSjBXUDzmjUAvJzvyxvJBPV2Cta4GNqyV0V9Ee9o4tDiU93LPjoW1O120P?=
 =?us-ascii?Q?mGSzQ3IlpWk4Cw+haRC1C2h1ztya30f8KO4df8rb99s/Lr8j9ajErMg6le4J?=
 =?us-ascii?Q?4DmIM/bqtSaKzZEuwy0u+37fElABbDKbKTpp6sylDF9qqVeT3sXvW8+bF89b?=
 =?us-ascii?Q?9fyc4rq0GrChQB5CYiUFPsbNyubl6xMsQgMk8HBg6Q8kaPCs5N0rmfqqu6Hh?=
 =?us-ascii?Q?is+XqCit1X1E2q8VsER+kweBNDRhIKm39Z/mxjbA8xnqFa29y+ABFrlB70Gd?=
 =?us-ascii?Q?IIosatBiOzI7r7fzIMVAfM7dJCqgtspEJPDCqGXZZllOhqU/XOE0QgZD4oNw?=
 =?us-ascii?Q?G+84tHEpobeLvdJQxFSvfan+bo3uzAPqnEftyg8D33ALoBSfHoFCGTuTBC5+?=
 =?us-ascii?Q?hRkNWnkbty8peGtI4IOToEM2UJ63yTjpNx7FOq4d0yNDO13aRw6KgOBzYcCY?=
 =?us-ascii?Q?kPb0sNVf3XEHZL016l1tDfMNelCNbOzQVBXba+jM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3172065d-e0d6-4263-c464-08da710e8c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 03:00:52.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bF1W0XyENTv69PRXzBOgjW9sFkcWDIduOrq97+jwaH7grBmfje/JCAUivxbGFrz+XW62WtzuUDN67dhiIGv7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Wednesday, July 13, 2022 07:13
> To: Dave Hansen <dave.hansen@linux.intel.com>; Lutomirski, Andy
> <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey Ryabinin
> <ryabinin.a.a@gmail.com>; Andrey Konovalov <andreyknvl@gmail.com>;
> Alexander Potapenko <glider@google.com>; Taras Madan
> <tarasmadan@google.com>; Dmitry Vyukov <dvyukov@google.com>; H . J . Lu
> <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>; Edgecombe, Rick P
> <rick.p.edgecombe@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; Kirill A. Shutemov <kirill.shutemov@linux.intel.c=
om>
> Subject: [PATCHv5 01/13] x86/mm: Fix CR3_ADDR_MASK
>=20
> The mask must not include bits above physical address mask. These bits ar=
e
> reserved and can be used for other things. Bits 61 and 62 are used for Li=
near
> Address Masking.
>=20
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/processor-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/processor-flags.h
> b/arch/x86/include/asm/processor-flags.h
> index 02c2cbda4a74..a7f3d9100adb 100644
> --- a/arch/x86/include/asm/processor-flags.h
> +++ b/arch/x86/include/asm/processor-flags.h
> @@ -35,7 +35,7 @@
>   */
[Hu, Robert]=20
The comments above these #define's, explaining CR3 layout, can be updated o=
n
the new CR3 bits as well?

>  #ifdef CONFIG_X86_64
>  /* Mask off the address space ID and SME encryption bits. */
> -#define CR3_ADDR_MASK	__sme_clr(0x7FFFFFFFFFFFF000ull)
> +#define CR3_ADDR_MASK	__sme_clr(PHYSICAL_PAGE_MASK)
>  #define CR3_PCID_MASK	0xFFFull
>  #define CR3_NOFLUSH	BIT_ULL(63)
>=20
> --
> 2.35.1

