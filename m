Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C65AA4CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiIBBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiIBBC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:02:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452665C952
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662080524; x=1693616524;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uKWCAEy+xEQvL8sV5pXwFx2Dg9e8LttCjUmDr+NfTVE=;
  b=NTG4NyREqZ8pbZAc2UcuXgP06Hhj9d+NuAtSTPmzKx7gnnXGDRlIYKZ0
   +ytD4eccrND77SQ77+Q4v6Dm8pwYpPRoLKgoVUFCeWCEyNnZ+Igdfmsju
   Wa4gfjCi0hXJ4z//5kszV7uvDw5WyMt9jsdFGVukbBDKU2lzWRMb6rb/d
   +4SMPIA5PXgNotsBXOxTTSIy2WxScM8n97KI3quUf4cHVC9CAvKuDHG2m
   16+XzxC0f2XVp29QORYBPBT1Njh9HJOSSBU7Bz+MbblnvPdBaHiovbMoA
   R3yOLc9BjBV45B5k7++AJsCaBZkYAjxXAJ5nmbZqWGSPeNqLSn1KdUcjQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293441460"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293441460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 18:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642652764"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 18:02:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 18:02:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 18:02:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 18:02:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 18:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eADLaa0ejfq3Rj2TSOZ2qy4qk1SROwkHeJuyKC6hA6/vJFIIm76qfYMbgrd91CqSe7oP4ZqTsKjWbf2yCfzXij9J7SRH1704FNd/mCqF7yLwZEOaxbAK24CpH47W75kLonekD8iF0obdVv+E2dD4b1n8Ffs5yMKEnrYAhpcxoBcS06z0ExzwYXHWdq8+0JyAvzPJ9mITD4yJD/CotAGiZA5r5GLBAOmRoB07TkGFgMMhEmDlCIbwE9xIpdHD2WMCET+18Zww5NnNbnVXnQwgS0Gl6E9CjLsb9JZ7VWNMa3USfHVDM/sxFshDHGEjHHgeGKbippTLRFXs1KHD8kjlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7fs6uOpyILCHtgHYrTxvO068PWQ5Oesy5Gu3jXaF9g=;
 b=kHhWRpolLbBXM6XXoD1ZC9xWjQzPg6HvT3o1om2jKcScQIeBRl41I8/7ZqcADhVw/CjpfsPImwfJNW6FkU6AYo4s55oLmiNybm7lHCWetF04YPKyNVxOeMQFlNiFHjUcnh2pNGmoZNdIEeL6+uPLkYqU2GbL/tahsQcJbZjZG8L9heWAhCtQqQt842N8zMzHX60gRMRe8RhmhS9m3yqDJps8ZUbBOxSAEogKi+ccHkM+XMyFUKBQsmKoQw3FNEM3sVacatcYxOk34Qmmbt0NjlW2o7KXgPi53z/Wz5NnRly6wKPqOj5mAFuSOUz4cTjfv03ymhi6DV6/qSBIxb0moQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 01:01:59 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be%4]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 01:01:59 +0000
Date:   Fri, 2 Sep 2022 09:01:47 +0800
From:   Philip Li <philip.li@intel.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "kernel test robot" <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: powerpc-linux-objdump: Warning: Unrecognized
 form: 0x23
Message-ID: <YxFV+7Xp34cxx1Gl@rli9-MOBL1.ccr.corp.intel.com>
References: <202208311414.4OPuYS9K-lkp@intel.com>
 <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
 <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
 <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
 <8d2c3aef-aa4f-1f4d-dc89-622554ffda31@intel.com>
 <9d77cb93-2eff-d87d-6554-1636d5e7d5ec@csgroup.eu>
 <0acfb209-a792-a47b-0261-9fb29824e4b9@intel.com>
 <YxDj6v5p+wHop0Wm@dev-arch.thelio-3990X>
 <CAKwvOdmzuupyAMhy-jT3O=-PT36T01N4SXkCPz6Cv0CPsxkK3Q@mail.gmail.com>
 <4c6da74c-4dc1-796c-5f22-bdd075b23c2b@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c6da74c-4dc1-796c-5f22-bdd075b23c2b@intel.com>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8604a164-13af-44cf-29c0-08da8c7ebcf9
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYIk0hWevH4XSNfmirJI8If28SrRZcqrXQe5ATpI5seR5eeHovd5Xt9qGVNo2EAXfCGbB6uF0WP10m/d3NXs7a91reVxgf5dpxQ4dgU60xSwRVhi3TKinfEmES7Wj11dd3aVxoadCtkpv8mlAGc4Guqn2CKfOKIr+6Up3m6LxcJbJSxohP2H8isYvjgkCJVI88sDR7dPXmaljrE1/6MVb2ALZYPArkgG9Ot+KPJoiCrvuit8RC6KMLJRekch/lWrnpqS2wWi30OEpMGUGM12uOpzlUFnD6GIRHyW4BnW4e6iTfHYThvhxXZFGnMLkW0aCg3HCzmsPqDMTZb/E6pag1IKzB7WFbmib9NlheEIC5SpbYLmeXZBrKlJBcYXh8gHSWj5dp2Ae9YLhs4sti6MLqMwsAe0ezrE42lMQlNQSvKGb25xKRm/CldqwMFP/SG6j0xar5FjjMjZikmImU3Tq0aM9Zoal2uaYvmt0kxgHKmHQfzJUDAOiGAg1C0DsSaT1hevyXZ7/pC1zuJiyp2puQTHW38ZCjpOW8vw41ngvk2/i3hcIYvXKgfs3sleriEsxkLLStcWXYQNUSJj4yQYfTV7JwBZl+OQgkW7jDtqnVGFPLkTH4OQYY9HBzHZWQ72pPGQyafcpOc4ne9eCaVdyCfbG54Cs58J09xVpkP4AP6AmkTYXVVZ+F5Sk61muOTYNAZgS3FkPJuuK7opKOS9E41BhT3fl7w1PB16QFg1STpx4THTCg3IQsLaCImSsgAHHHzNad9cZYIjXx5JBwXrN30NPps0nNts+QJVYd5UvZfYyCT/Wrhtwc2GXFOU6iNps4pBZ3RWI2mGDKpDcn4jEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(396003)(39860400002)(136003)(6636002)(86362001)(82960400001)(54906003)(2906002)(8936002)(966005)(6862004)(6486002)(478600001)(83380400001)(7416002)(44832011)(186003)(8676002)(66574015)(4326008)(66556008)(66476007)(66946007)(5660300002)(6666004)(41300700001)(38100700002)(316002)(26005)(6512007)(53546011)(6506007)(2004002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UHYUQ6GgwvSp400Id/LSE4raBGNkps5UW/U+IV7d4La1QAjygBjV3iznB2?=
 =?iso-8859-1?Q?EbYZG7wHTQyIkbUWbK2ghVQl7EkKs0uJjoMOEjv6Ou614U+X3wP+SqUU7x?=
 =?iso-8859-1?Q?rMjsjUoJ8dI4sHHhTeHhT/wrhwX0mewwjmrgYcBb5ofwdaAIFc4i0GjeKA?=
 =?iso-8859-1?Q?aOYZRmtcyZW/NCnuqvenPOBAfY+WsgH4gQ0uE5/xBmzrm9r/PvcXhCVLPZ?=
 =?iso-8859-1?Q?eSR/CD/yPpxePPYiPmpmOzXa1dh1A0zTK5LTlGjdktQFM/aFVWU+DAAtdd?=
 =?iso-8859-1?Q?Lfp+7CNuH60wdkoqtueosfXhNRAUYsiCWqpGVkTQjy8310qkBL7cMtGaUo?=
 =?iso-8859-1?Q?hI/eeRtl/xjqjCBoHWKfk/fJNYSJ0Xm00SoUJKyxpcRWZYBLMc6cEprlvk?=
 =?iso-8859-1?Q?e9D5wVl/5iIPlHf26V0hiYSAchT2PTt8I77M5g9Q5mML9+cwFMEMG6vn1Z?=
 =?iso-8859-1?Q?/xuNMfhHA3EXutcHvyguNhhSKzzS9t3Vn+0D4TtpWoC/fZR2isvhkT8UMg?=
 =?iso-8859-1?Q?HuMup7Np7eWJgfH7mbPmnJMAJKuDSlg5pc4pJd+kNoJrirOGPMdN6M0CgG?=
 =?iso-8859-1?Q?Nr+NMv1mzACSUF+wXDY+GblrfMXjlT40Vwg2Y8UAYHEO/vq/wD51+YHIdT?=
 =?iso-8859-1?Q?AjgX4zUtiC6BYlME99FmfDG3LWhdmVHcY3fs5K8KdUsy5ITfqUfy2KDNnN?=
 =?iso-8859-1?Q?2GigDoRwi7UCgZyKZqbUpPleeMCU06rp0Aklq25A3sn+PHvc1Em/gIPcWT?=
 =?iso-8859-1?Q?cLajyEtk6+0WRPqdZhRwaaHBuwOKRpWcWzHGdS/x3phZozcXNLY6UYHf7C?=
 =?iso-8859-1?Q?W+ijs4UutfwZNArun5zM7GlxvJnR9L6ZhKEbOYLp28UrR+AHXa1vopbihl?=
 =?iso-8859-1?Q?ow/3whyCXKu9Ryh8OFprF1xeTv/NGKGPg/2fGahFxOch7Yifi0OoEZY3ky?=
 =?iso-8859-1?Q?YkQh9CBvgCtMuHh3eoFuEyPVeAXJ/3+VtUGn7f1d0muRPsOcspRDbogSWE?=
 =?iso-8859-1?Q?Ns/338MwmKeXBkAbTWsOpEWNYwctqyPWPTOfuPxnqMbrWf05E9TsaENGLh?=
 =?iso-8859-1?Q?wMiM0EXlRQNRDjBbIgIeGCPxrvOrV0DVQoOFi3+CMYKs/2v/+xrVbzh0jv?=
 =?iso-8859-1?Q?zAj4Eo4hi01pUXVmEfcx5YDeHKM46xP17AQRk5zBXv+8+++77XY65rUeFA?=
 =?iso-8859-1?Q?U+CkVs2G0rydVEplGRjJVgUFi1HG4ivD6w4yyLwlN0jzUpo56IH8mly+iB?=
 =?iso-8859-1?Q?HHpiBCN5RR6rkPxI8sS97UUgg6jZNNLKFDtINnO4/T+wuE41vuvsr5maQH?=
 =?iso-8859-1?Q?4Iw3Zs2X2fGzPMs2/Ta1Cjn8OjvVUFIol6nKeWLCTDojtnV9AmeACfUyKs?=
 =?iso-8859-1?Q?GXZ45uiCfkv/tcFK2Bmt6mEDF3iiCPKumgVm1QxisXtcZKGNUelFwNL+C+?=
 =?iso-8859-1?Q?43FDrt2ppzwS431UomHh03JFqfNed87X4s3DrYYNbTnGp8nljRF8crNdnu?=
 =?iso-8859-1?Q?Vw5YejELM7b3TnWkJf8XC8AIn9lt5YKkHFQvY1n+ZiOCY/UDvCxVoBMXVa?=
 =?iso-8859-1?Q?zPNknv5ZGh9hWhK7/BCT9TTwifG+0/e8jKqyBepHrglC4Pjrgm24Xge2Qa?=
 =?iso-8859-1?Q?RRGkTCsCfM3iPF2V+ejrRbtC0hVKxe/8X+IgPUh6hawVyWhV0/59mxqg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8604a164-13af-44cf-29c0-08da8c7ebcf9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 01:01:59.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIlKrgB+kWXLcNCMswMiZ/9eqOJ400v6m7ocEWf2xesuoyJYY72gVoEODSLotXM7LXNEw4TxbeY5KEl4Vged+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:54:14AM +0800, Chen, Rong A wrote:
> 
> 
> On 9/2/2022 1:04 AM, Nick Desaulniers wrote:
> > On Thu, Sep 1, 2022 at 9:55 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > 
> > > On Thu, Sep 01, 2022 at 01:52:42PM +0800, Chen, Rong A wrote:
> > > > 
> > > > 
> > > > On 9/1/2022 1:45 PM, Christophe Leroy wrote:
> > > > > 
> > > > > 
> > > > > Le 01/09/2022 à 06:59, Chen, Rong A a écrit :
> > > > > > 
> > > > > > 
> > > > > > On 9/1/2022 10:03 AM, Nathan Chancellor wrote:
> > > > > > > Hi Rong,
> > > > > > > 
> > > > > > > On Thu, Sep 01, 2022 at 09:15:58AM +0800, Chen, Rong A wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 8/31/2022 11:40 PM, Nathan Chancellor wrote:
> > > > > > > > > On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
> > > > > > > > > > tree:
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > > > > > > master
> > > > > > > > > > head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> > > > > > > > > > commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug:
> > > > > > > > > > make DEBUG_INFO selectable from a choice
> > > > > > > > > > date:   5 months ago
> > > > > > > > > > config: powerpc-buildonly-randconfig-r003-20220830
> > > > > > > > > > (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
> > > > > > > > > > compiler: clang version 16.0.0
> > > > > > > > > > (https://github.com/llvm/llvm-project
> > > > > > > > > > c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> > > > > > > > > > reproduce (this is a W=1 build):
> > > > > > > > > >             wget
> > > > > > > > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > > > > > > >             chmod +x ~/bin/make.cross
> > > > > > > > > >             # install powerpc cross compiling tool for clang build
> > > > > > > > > >             # apt-get install binutils-powerpc-linux-gnu
> > > > > > > > > >             #
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
> > > > > > > > > >             git remote add linus
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > > > > > >             git fetch --no-tags linus master
> > > > > > > > > >             git checkout f9b3cd24578401e7a392974b3353277286e49cee
> > > > > > > > > >             # save the config file
> > > > > > > > > >             mkdir build_dir && cp config build_dir/.config
> > > > > > > > > >             COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > > > > > > > > make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > > > > > > > > > 
> > > > > > > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > > > > 
> > > > > > > > > > All warnings (new ones prefixed by >>):
> > > > > > > > > > 
> > > > > > > > > > > > powerpc-linux-objdump: Warning: Unrecognized form: 0x23
> > > > > > > > > 
> > > > > > > > > Given this is clang 16.0.0 with
> > > > > > > > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
> > > > > > > > > default instead of DWARF4, it looks like older binutils not
> > > > > > > > > understanding DWARF5. What version of binutils is being used by the
> > > > > > > > > bot?
> > > > > > > > 
> > > > > > > > Hi Nathan,
> > > > > > > > 
> > > > > > > > We're using binutils v2.38.90.20220713-2
> > > > > > > > 
> > > > > > > > ||/ Name           Version            Architecture Description
> > > > > > > > +++-==============-==================-============-==========================================
> > > > > > > > ii  binutils       2.38.90.20220713-2 amd64        GNU assembler,
> > > > > > > > linker and binary utilities
> > > > > > > 
> > > > > > > Thanks for chiming in! This looks like the output of 'dpkg -l', right? I
> > > > > > 
> > > > > > Hi Nathan,
> > > > > > 
> > > > > > oh, yes, I misunderstood, it's not related to this package.
> > > > > > 
> > > > > > > noticed on second glance that the tuple for the objdump warning above is
> > > > > > > 'powerpc-linux-', which leads me to believe that a kernel.org toolchain
> > > > > > > (or a self compiled one) is being used. I would expect the tuple to be
> > > > > > > 'powerpc-linux-gnu-' if Debian's package was being used. Is that
> > > > > > > possible?
> > > > > > 
> > > > > > you are right, we used a self-compiled toolchain, we'll try the binutils
> > > > > > from debian package.
> > > > > 
> > > > > Can you first tell us the version you are using ?
> > > > > 
> > > > >      powerpc-linux-objdump -v
> > > > > 
> > > > > That will tell you the version.
> > > > 
> > > > Hi Christophe,
> > > > 
> > > > the version is v2.38:
> > > > 
> > > > $ ./powerpc-linux-objdump -v
> > > > GNU objdump (GNU Binutils) 2.38
> > > > Copyright (C) 2022 Free Software Foundation, Inc.
> > > > This program is free software; you may redistribute it under the terms of
> > > > the GNU General Public License version 3 or (at your option) any later
> > > > version.
> > > > This program has absolutely no warranty.
> > > 
> > > Thanks! I did some research and it seems like this warning is expected
> > > with binutils older than 2.39. The warning appears to come from
> > > read_and_display_attr_value() in binutils/dwarf.c. 0x22 and 0x23 are
> > > DW_FORM_loclistx and DW_FORM_rnglistx, which were only recently
> > > supported in that function.
> > > 
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=28981
> > > https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=19c26da69d68d5d863f37c06ad73ab6292d02ffa
> > > 
> > > That change shipped in binutils 2.39. I am not really sure how we should
> > > work around this in the kernel, other than maybe requiring binutils
> > > 2.39+ for CONFIG_DEBUG_INFO_DWARF5. Unfortunately, that will not fix
> > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT when DWARF5 is the default
> > > version...
> > 
> > I've been working on a series that will encode the default implicit
> > dwarf version based on compiler version check. Maybe that can be
> > extended/reused here once that lands?
> > https://lore.kernel.org/llvm/20220831184408.2778264-1-ndesaulniers@google.com/
> > Series needs revision, but it's on the right track.
> > 
> > > Alternatively, switching to llvm-objdump for clang builds
> > > would help :) I am not aware of any issues that would affect that switch
> > > for PowerPC:
> > > 
> > > https://github.com/ClangBuiltLinux/linux/labels/%5BTOOL%5D%20llvm-objdump
> > 
> > Oh, is 0day doing `make CC=clang` rather than `make LLVM=1`?  Rong,
> > any chance we get 0day folks to test LLVM=1 for more architectures?
> > Ideally we'd test both, preferably LLVM=1 if we had to choose.
> 
> Hi Nick,
> 
> Thanks for your advice, yes, we are doing `make CC=clang`, we'll plan it
> recently.

Hi Nick, add one question here, if we switch to LLVM=1, as not all old kernel
commits can support this option, do you suggest we only focus clang build on the kernel
that supports LLVM=1 or we need switch to CC=clang if LLVM is not supported?

> 
> Best Regards,
> Rong Chen
> 
> > 
> > > 
> > > Cheers,
> > > Nathan
> > 
> > 
> > 
> 
