Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18F5996CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347206AbiHSIQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347702AbiHSIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:15:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBE0C0E67
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660896919; x=1692432919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fd3oTHNt2McxYG7+DUOhTMZbhSb2uKCVtFsK4/Iy7f8=;
  b=NZHFQaIiPhLObCA48ZskopuyAxKpa2AXH/8QXKEy0ir5a549yUDFfDte
   Va0HMJ7DTGzYO2duv8YLz6C+AsI79uVfAwb4vhy6BaANkrNbbeFqjKzDb
   i1WpaerCoOLaAH71BcH4EVCRBlgoczjv4IuBhe5mvHbh3YwQMUZ6FBK9z
   S6uTBZT99wIOdz2yHB9kVCzpN+H1BXRiKIxrxJXyejnJCzXuxsotMRl1q
   SC6yV6kvMowcC+ah3jmTz/QOhWMqBVdF7MH6Mg2YMe9NvprBXfVbv+iOl
   9B70D2sHjh76ORAYKvIikmRYpKhCrC4dWK5yuZ9lsA1SmATyrsre7YCqG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="356950015"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="356950015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="676380527"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 01:15:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 01:15:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 01:15:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 01:15:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 01:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP5vk1ZTxUyUte6X72K5Tbvl+3b5uKfagfthUjhoFf5kTEjHCOPrWgQruqFEgR2AalZQppwv31//3lK3h8pDEnLz6LWGhhRGQ2ETrgfIRF2umQfHKYuHHXZdbJ9o7TOz3oFj5XzhSWeJgqfa7vWbAhaGzgeXWi2llb3c6iugmvvOoeNo2GlK7g88oUD0gdVHCrOClp3iU99KsRjQ4GCAPPjZ8AANt5nvF4NHmbXdIlJdqs+jvF9ZDoLAkLiIgH8ttMekOCxhvIcBebONx/Wgo45S7H0zknQJIp7LzjS0jo/Qka1NAaBodOpUKizkgnHMaTnn678hievAu9wQLYTCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPSIDYFQfgZoS66eTkBrEXIBAfh6v4pGIagR4v2mgJc=;
 b=QgNTDShhgoCXYrZh3qIBtmVopXVw1ef9/crRAZL5PSlFsRmQO31nOt0x3oCopYEm1t+gnRAMskfVw8jy4QIWoMVHujuPwyR3IYEdKM9EsaQYGKBkrgOI25AKOzhU8DS05Tf8cLetr9ZJ3p8XUj/bJf2r//yWT/Gba8mSHrGBLGfPQbQYK5efEXnhmCr+kJLQ/2oKJJ+83lW9//8Zi4YPSnMWpNOaBHdvEC3mbXA0RxC3czIDkX/DMIYs2JI81STqsvn+95fscb6ulS+sJLPcZcWc9GtdTRwCWfKVrd/cffF2eKDw0F2ABPOThUQYxnOqbCKtFP6tpSBWHkFclbw2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 08:15:14 +0000
Received: from CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::584f:2178:c6be:abf3]) by CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::584f:2178:c6be:abf3%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 08:15:14 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Weihong" <weihong.zhang@intel.com>
Subject: RE: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
Thread-Topic: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
Thread-Index: AQHYsF3oJDX/VqQwxkuwP50rjb2Iwq215fvQ
Date:   Fri, 19 Aug 2022 08:15:13 +0000
Message-ID: <CY5PR11MB6187230204E669607437716FE06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220815041803.17954-10-kirill.shutemov@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: b675945c-81fa-4704-02bd-08da81baf15c
x-ms-traffictypediagnostic: BY5PR11MB3912:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UL3wX00jF3yrc4b6aplHk3Za9bI9HCZ96vvLlo0hi0JlRzpymplc/No/tutIbBiOk7yuQL8DSSKd07djtMmYy1h1w1VwQvPk68Uocm+AzqoAjxwSD56slHvtOSaoUrL3CZHjD3CzypoDtlyl0nH5KJkdjULjN4UcTdJYT1Np+GvPUCkTIZR7YZq8amWsv4+CesEefJP4adsLMpm5Tf4FvjMUwIurwXEPwh3b3d9XbuEe5Msy6xs4tAr/9eFsxxgdNqoEbDcD+W3FWxFpx0CuhzpkP1Oo/6zn6HAw+zsu7H1TEV0Aekw7eqIRQckm9NzNsE7blOkWCs11gJylNLi+n1H21hnQk+5Eiwj/VEYrgOvWv3l93j06l4UfC632sLHKW2/Gyp4DUYa8R8jTcZwyxFfL0k8brprGLWK40rSJSJHAUMqoZ/M/mJ1jqt1YJHm7EFyz0oaPvsXZwlElE/gWwKiZuRbmMk5U66ADKQc/miXrpvjthaHyzHcFwxpbBnu4CkzWyCKHc5XKFSAPj9XKWUteo+AWKXSuagbVja7ieLBRiYgusgwVeS0d/JDhYGdCSK6o+BV7F5yxjXMV0GRcI7E951VY7im1VMpd8zkihxNu3BYFBmH2g9aIgUIxQpst0mJ43Rv0fE2TGLTpNz/nMPER7mS2BfR5vnYrMrr74GnVn61pS4HGcbrJRyb+TiWoKgNOsqbBrIB4i3qKlNYGmHlb7PcCHoQwjGFw5Ibp2sZZ0HN0G6gP0qPlsyFNgcWN5ysHMM8m5aq597gX+ip0oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(39860400002)(376002)(110136005)(186003)(54906003)(316002)(83380400001)(71200400001)(55016003)(38100700002)(122000001)(6506007)(7696005)(66946007)(76116006)(66446008)(38070700005)(8676002)(4326008)(66556008)(53546011)(66476007)(2906002)(33656002)(41300700001)(478600001)(82960400001)(26005)(86362001)(8936002)(5660300002)(64756008)(7416002)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0EJxKzGPq8ilvE90bQ5AFB7wQF9TsrUa7melLsCABKrR7Ke4DOrMv6Dsz6p?=
 =?us-ascii?Q?tb6EBKu2s8TTdizJ5zu4KK6eXXnBFDbAQYXrbP9CibdRpFZj9E6IjDXTVr08?=
 =?us-ascii?Q?3cUvUMfneaZNGWBTm/rbFN0nU/ET+H4bCN7CihV0ZkIRJT69Vo7RzLp9lkQi?=
 =?us-ascii?Q?R6G1DNo0L9dHrfMG9zr1mGqSp8R7yxTfI6da7c7uhco5yg6AYWVW9ZGN6Brt?=
 =?us-ascii?Q?AIxrpIvN0elte9jQ3BeKqXNo2CHsLn6T9BTyMN6qERfBW7zAgzOVLwm+FrGo?=
 =?us-ascii?Q?+4MoFAvpGQmgcYp5rHiCfwMNktOoLKGzf0j9e5b0REFA3aKY/49OgaUQaMCh?=
 =?us-ascii?Q?6Qi9ho0bVTm3CoaKqN/K1717uv1NbmM9d6/cGUsmxX3rax5GlCFiAwhZlabk?=
 =?us-ascii?Q?NZmy165RmQNWyfmlFDoZSsYzc49dqf7XwWiJGsUf50hLPQzC30jVbUJFqPmZ?=
 =?us-ascii?Q?kUZe3Yi9m08UfMaIS3ZQ9Ms3EkELmu9FqA6r3P0xV/m97iUhM5td5p3eF5/L?=
 =?us-ascii?Q?oBZw/etijnPZ3uvPfhYzhlvwRx3uzykS8tG0tClSKfjecW4Y1t53NR0QcxG1?=
 =?us-ascii?Q?j1A1i1/p4hI6EhaVwB28GD26BVOzMf64THmbro6X5thlMheRx9zgA5p14J2x?=
 =?us-ascii?Q?JQ2C6xqznbxckKEsXiH6jMoxHPXMYD3JAGnVtElBQKowWfdPWsZOQxZEotE8?=
 =?us-ascii?Q?dHsxpKKXlgcKYSSLzGIPV8xR3MzqD+2kz3S42RsVDmWvFPMYYLRjAEO/bhbk?=
 =?us-ascii?Q?s6PF5IYKzmkapwXG2mJDk+lP2PBixJI8GmQHVabNHpD2ge1Bx9CuU/Jx1Pjz?=
 =?us-ascii?Q?nKwsxQXUl4C5FEMGkexpTB6XGnP8a08uWxWWcJIJBt8vmtHMOWOld1S5gNCD?=
 =?us-ascii?Q?KcHHv0ZI7GSTJMVVMQW9dZfSkCy8yJBAg7D9dfEKuTg+RlLXQhuaplNyfr9p?=
 =?us-ascii?Q?4sPyvvzMoSlZhOKMT/4Zvd+Uf4BcLdx/3qiKdVXTb5nWus6mSnh3PB4qfZIX?=
 =?us-ascii?Q?EDDp3Kqn6L0W8qVEwbf2Lar/3W5SqOP/ashv922nI1Le2aPgo2L5QNom38Jd?=
 =?us-ascii?Q?jB+9poV0DryM3havU5fRby/YBKbE5d4uRcBoXeKUPUkiJ5GeqMlgIztvCOeH?=
 =?us-ascii?Q?EdK1YPtWH5+sHrywZhmn567ZA8RZEARyzz1tNpE3vSDd4xfz0X3VzhvKStiR?=
 =?us-ascii?Q?MX8r3Mw563A5wxzDZK04Ujve9UPGXusIUQWD3Q5lyVC3unFNrrHS1Kt9NHJw?=
 =?us-ascii?Q?6DQJ+pMu79cLzD0nl4y+hJOMqqHmiA1mjjXOohrkwKBHzAyp+PZqVaLxi0/+?=
 =?us-ascii?Q?GN0aRVLvZ6n9YRCUpuA4vXdb2O1ACFInhiPVOCoKChsUduLg9pQhZ6mzHo/h?=
 =?us-ascii?Q?Z253BY9VUVW/ahyPcrGIQ/X9spsGu1LnF2LxHWtdxAyRAleKw+Ij/2b7cSul?=
 =?us-ascii?Q?4PszvOdh9b5gONAU/BliadKxtsbOcQSkD7fW61Pkk1/07feb7xVC7VAZN88S?=
 =?us-ascii?Q?2aO2P0LfPfoRUDhgzikDx4BnEaljV+seQTFwW3G+lj7lsU6q63Y1D8Xk2P/o?=
 =?us-ascii?Q?+4tFCkjE36u38LxTpa/DWHRqEjDNxSTKJw/Bb80M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b675945c-81fa-4704-02bd-08da81baf15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 08:15:13.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an3piKYPnpGwEuJHryck5Zq1HaHdpzqmw9ogcOn9anC4ETma862peF/d2cTcWMhkqA489vMzrABKxP+FokJVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
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

> -----Original Message-----
> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Monday, August 15, 2022 12:18
> To: Dave Hansen <dave.hansen@linux.intel.com>; Lutomirski, Andy
> <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey Ryabinin
> <ryabinin.a.a@gmail.com>; Andrey Konovalov <andreyknvl@gmail.com>;
> Alexander Potapenko <glider@google.com>; Taras Madan
> <tarasmadan@google.com>; Dmitry Vyukov <dvyukov@google.com>; H . J . Lu
> <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>; Edgecombe, Rick P
> <rick.p.edgecombe@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; Zhang, Weihong <weihong.zhang@intel.com>; Kirill =
A .
> Shutemov <kirill.shutemov@linux.intel.com>
> Subject: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
> cases for linear-address masking
>=20
> From: Weihong Zhang <weihong.zhang@intel.com>
>=20
> Add mmap and SYSCALL test cases.
>=20
> SYSCALL test cases:
>=20
>  - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user point=
er,
> pass
>    the pointer to SYSCALL, SYSCALL can dereference the pointer and return
> correct
>    result.
>=20
>  - Disable LAM, pass a pointer with metadata in high bits to SYSCALL,
>    SYSCALL returns -1 (EFAULT).
>=20
> MMAP test cases:
>=20
>  - Enable LAM_U57, MMAP with low address (below bits 47), set metadata
>    in high bits of the address, dereference the address should be
>    allowed.
>=20
>  - Enable LAM_U57, MMAP with high address (above bits 47), set metadata
>    in high bits of the address, dereference the address should be
>    allowed.
>=20
> Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  tools/testing/selftests/x86/lam.c | 135 +++++++++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/=
x86/lam.c
> index 4c6c6dbf7db6..e9e92ab7fea8 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -7,6 +7,7 @@
>  #include <signal.h>
>  #include <setjmp.h>
>  #include <sys/mman.h>
> +#include <sys/utsname.h>
>  #include <sys/wait.h>
>  #include <inttypes.h>
>=20
> @@ -27,11 +28,18 @@
>  /* Specified test function bits */
>  #define FUNC_MALLOC             0x1
>  #define FUNC_BITS               0x2
> +#define FUNC_MMAP               0x4
> +#define FUNC_SYSCALL            0x8
>=20
> -#define TEST_MASK               0x3
> +#define TEST_MASK               0xf
> +
> +#define LOW_ADDR                (0x1UL << 30)
> +#define HIGH_ADDR               (0x3UL << 48)
>=20
>  #define MALLOC_LEN              32
>=20
> +#define PAGE_SIZE               (4 << 10)
> +
>  struct testcases {
>  	unsigned int later;
>  	int expected; /* 2: SIGSEGV Error; 1: other errors */ @@ -47,6 +55,7
> @@ jmp_buf segv_env;  static void segv_handler(int sig)  {
>  	ksft_print_msg("Get segmentation fault(%d).", sig);
> +
>  	siglongjmp(segv_env, 1);
>  }
>=20
> @@ -59,6 +68,16 @@ static inline int cpu_has_lam(void)
>  	return (cpuinfo[0] & (1 << 26));
>  }
>=20
> +/* Check 5-level page table feature in CPUID.(EAX=3D07H,
> +ECX=3D00H):ECX.[bit 16] */ static inline int cpu_has_la57(void) {
> +	unsigned int cpuinfo[4];
> +
> +	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
> +
> +	return (cpuinfo[2] & (1 << 16));
> +}
> +
>  /*
>   * Set tagged address and read back untag mask.
>   * check if the untagged mask is expected.
> @@ -204,6 +223,68 @@ static int handle_malloc(struct testcases *test)
>  	return ret;
>  }
>=20
> +static int handle_mmap(struct testcases *test) {
> +	void *ptr;
> +	unsigned int flags =3D MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED;
> +	int ret =3D 0;
> +
> +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) !=3D 0)
> +			return 1;
> +
> +	ptr =3D mmap((void *)test->addr, PAGE_SIZE, PROT_READ |
> PROT_WRITE,
> +		   flags, -1, 0);
> +	if (ptr =3D=3D MAP_FAILED) {
> +		if (test->addr =3D=3D HIGH_ADDR)
> +			if (!cpu_has_la57())
> +				return 3; /* unsupport LA57 */
> +		return 1;
> +	}
> +
> +	if (test->later !=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) !=3D 0)
> +			ret =3D 1;
> +
> +	if (ret =3D=3D 0) {
> +		if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> +			signal(SIGSEGV, segv_handler);
> +			ret =3D handle_lam_test(ptr, test->lam);
> +		} else {
> +			ret =3D 2;
> +		}
> +	}
> +
> +	munmap(ptr, PAGE_SIZE);
> +	return ret;
> +}
> +
> +static int handle_syscall(struct testcases *test) {
> +	struct utsname unme, *pu;
> +	int ret =3D 0;
> +
> +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) !=3D 0)
> +			return 1;
> +
> +	if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> +		signal(SIGSEGV, segv_handler);
> +		pu =3D (struct utsname *)get_metadata((uint64_t)&unme, test-
> >lam);
> +		ret =3D uname(pu);
> +		if (ret < 0)
> +			ret =3D 1;
> +	} else {
> +		ret =3D 2;
> +	}
> +
> +	if (test->later !=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) !=3D -1 && ret =3D=3D 0)
> +			ret =3D 1;
> +
> +	return ret;
> +}
> +
>  static int fork_test(struct testcases *test)  {
>  	int ret, child_ret;
> @@ -259,7 +340,6 @@ static struct testcases malloc_cases[] =3D {
>  	},
>  };
>=20
> -
>  static struct testcases bits_cases[] =3D {
>  	{
>  		.test_func =3D handle_max_bits,
> @@ -267,11 +347,54 @@ static struct testcases bits_cases[] =3D {
>  	},
>  };
>=20
> +static struct testcases syscall_cases[] =3D {
> +	{
> +		.later =3D 0,
> +		.lam =3D LAM_U57_BITS,
> +		.test_func =3D handle_syscall,
> +		.msg =3D "SYSCALL: LAM_U57. syscall with metadata\n",
> +	},
> +	{
> +		.later =3D 1,
> +		.expected =3D 1,
> +		.lam =3D LAM_U57_BITS,
> +		.test_func =3D handle_syscall,
> +		.msg =3D "SYSCALL:[Negtive] Disable LAM. Dereferencing pointer
[Hu, Robert]=20
Trivial, Negtive --> Negative.

> with metadata.\n",
> +	},
> +};
> +
> +static struct testcases mmap_cases[] =3D {
[Hu, Robert]=20
Can mmap also have negative case?

> +	{
> +		.later =3D 1,
> +		.expected =3D 0,
> +		.lam =3D LAM_U57_BITS,
> +		.addr =3D HIGH_ADDR,
> +		.test_func =3D handle_mmap,
> +		.msg =3D "MMAP: First mmap high address, then set
> LAM_U57.\n",
> +	},
> +	{
> +		.later =3D 0,
> +		.expected =3D 0,
> +		.lam =3D LAM_U57_BITS,
> +		.addr =3D HIGH_ADDR,
> +		.test_func =3D handle_mmap,
> +		.msg =3D "MMAP: First LAM_U57, then High address.\n",
> +	},
> +	{
> +		.later =3D 0,
> +		.expected =3D 0,
> +		.lam =3D LAM_U57_BITS,
> +		.addr =3D LOW_ADDR,
> +		.test_func =3D handle_mmap,
> +		.msg =3D "MMAP: First LAM_U57, then Low address.\n",
> +	},
> +};
> +
>  static void cmd_help(void)
>  {
>  	printf("usage: lam [-h] [-t test list]\n");
>  	printf("\t-t test list: run tests specified in the test list, default:0=
x%x\n",
> TEST_MASK);
> -	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
> +	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall.\n");
>  	printf("\t-h: help\n");
>  }
>=20
> @@ -311,6 +434,12 @@ int main(int argc, char **argv)
>  	if (tests & FUNC_BITS)
>  		run_test(bits_cases, ARRAY_SIZE(bits_cases));
>=20
> +	if (tests & FUNC_MMAP)
> +		run_test(mmap_cases, ARRAY_SIZE(mmap_cases));
> +
> +	if (tests & FUNC_SYSCALL)
> +		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
> +
>  	ksft_set_plan(tests_cnt);
>=20
>  	return ksft_exit_pass();
> --
> 2.35.1

