Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520285768EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiGOVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGOVdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:33:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391A7AB2E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657920785; x=1689456785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uxif2CgA7QUoh0BJGWE89tjgrV1lEZZEgkHxnt8TGOo=;
  b=G0Pc4nguh5qrZHFjrZSQj86rgCF3N7P1cXcHMqidvC1agomUywRn2wW3
   2J77L2pPBH39O+024LJ7y7T1tP03cQ9yNnO43i8TuKk9urpMkQL8Lz3mA
   r41n9OJcwzW69gSyB8OrUQx0AZuJGXAlx+QHjKYOx04iV8zY9sGrZucs0
   D91yZW+yXEd9Cegs+EbI1tNxD1XS7q7lBtP41kCDJ0gh8aGMuE6zsZysy
   uKRjqo/a+1SuXwz6yAp2ZWpae2OgEkKjGG0uieVx3tv0AvtzqkZrwHAnR
   AekK6t41XLt1x45wdHjHYZs7TfN3zdneo4A4t5LTs07N9cyJhKeGjwsri
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283462233"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="283462233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="686111756"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2022 14:33:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 14:33:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 14:33:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 14:33:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 14:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5zNzcVTUUvNQAUP0vqe+lcfRwnY04X8w31AvGQiZBSNY7fwIT8/M3Dfpzj1RXWYWMw7vQbAtgnFVei3kJZ7iwHmhmY/tXuTjKLdw3cmpOXGTtxFKhV0WcLjFyAg2fVw/y0B0mPYI1yHnrXq5UoZdSsaZIM77i9J0gnkG7Sy07pwmbTtpOApGW7djzMlPhWT1dHIrsFbnGVrUpULD8I5bGvMVwLPn2fZUGwRnk8k6fprNlexuJei3BY/9rRG+CA7cRR7CrOn90eja+Hm6qlGt372gA/ZnSSScgK1gXNu7+w26UZLpJBHlNKvOguOJs7DALI1JhFeGlJPN8vDzw5Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpl3NKQiSG8PBnVHiX+hlv9V+O/cBZ/cQkJuirhs+j0=;
 b=RMzOcDB+YdATCF/zu565vxUJVtXe12P8ct5stfQcnftPJJBMo5deFcpsC6BDmsQZDMQuBdHBnzIC5rDN06Wn1VaLRY5/hcE9tnF1slWboJ285dqC8fSUspPB4QVMM13gv/IbntPBCKeGxYgGqTnuYtB4wc7o8wNrF78RiBXNaiTRpDPywsFzJbRILZunX/ns39nCtgYkc0fMP+PhqZj/6yFSPTkhRnpf4uk6AAhHHgX6jV0PxvrYURkOgzzq8VzXaUN6c8ehjHmLeSjt6KYV+WjQ3p746j5P2NnT0KhmVh2v1KjlshVscQUJxkRtE9g1QTsfDeQibM9F/k0rFiIOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM6PR11MB4090.namprd11.prod.outlook.com (2603:10b6:5:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 21:33:02 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615%9]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 21:33:01 +0000
Date:   Fri, 15 Jul 2022 17:32:57 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 25/39] drm/i915: i915_vma_resource.c: fix some
 kernel-doc markups
Message-ID: <YtHdCTN0Bnztsnqm@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
 <a830bd63085178004106069a914e80758e321fcd.1657699522.git.mchehab@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a830bd63085178004106069a914e80758e321fcd.1657699522.git.mchehab@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ccbe47-d27d-4f25-8fb7-08da66a9982b
X-MS-TrafficTypeDiagnostic: DM6PR11MB4090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdiGEKBk36C6+c2zrTcXEUz8jQAKaVbfZhRO0wBRapRhzrH745wWvQtBizocMzyYCrR1OHY7BOGxaPU5V8BuQzDz2ON6XBDtSb6HpSBHpmyR+9LN/4gcwvRIAWPw6hv4bbrPWgHPtRBNJC/Di4iAW9Td8PlbXwa5vM3mq4iV4FDfEjcjrXymN9lR1WpQ/c2o7TOVkOs97B8Nn24NauunjIN/SDZehzoFqi7HYku9/NabCr3Y3L4tvvSRsfG26YD1VZpfEVn+Tg2eCwcZRjZiGNiMfewP2u6gfuYBH60asXw7S8pm0wFbbg9rVVqGhVOLXi4R4rIv6lEJ9YzmI6xUraMGPycZTLeSxdKuPADvouBCg28I7A35QXS8zt9ON83ZRFlV+gcFr3iAAsyyMNnh5tubJ0rQX1haASsOKtrB1Y+jEazuv2kl5g0m/ScwhOxexmIpqXhHqYMPgRlMuhPuB2EBqi9pVehooLVLv9t9/Z3rniQuk7h2l2cR00MtHFquqCdNlWwOLI6TtpOy/94nSuvKBlzScjVJqhOkW9bW69hrG7buKPNDB8fCMVUFWEfALOqc7TY4ljidx/WqfDTSS0c/n6eq+WxVrtmf325tcGvpD1uNvcUDtqjDrNvm/lWwDEKj0UJ2schpuiXLZbtbs0+wpqzA2RXd5Yc/2GHJBqipVg5bp8BKm+fwM76gYLXzqiPa/PlSiC469Yo9N0CRWfUtjBkuZe9vzE3BbMufwLHWtiKYezKUMTRDY7CaF2N22cL3x8jxY551WmWIFKM3TSOKQuLZ6cKbM/YblDQSWB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(2906002)(66946007)(54906003)(86362001)(6512007)(66556008)(83380400001)(2616005)(8676002)(186003)(26005)(5660300002)(966005)(478600001)(82960400001)(316002)(4326008)(36756003)(66476007)(44832011)(8936002)(6916009)(38100700002)(6666004)(6506007)(41300700001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1frJWlnVyG8GfRPakG3OKnLwdcCDotwhR1Sl4xMGkATu5cD+Rx8IzA1OY2ps?=
 =?us-ascii?Q?18c81tjsf3Ik5txPxS6H00c2LffKApBLPFK2ZuUAxyyfCahq8qmXAsAPSZQx?=
 =?us-ascii?Q?U54nfOmjOAzdBWAu5rljhWNYjoolH/oanIRP2Mto4VcWjXw9STqG19xIVo0F?=
 =?us-ascii?Q?igUiOCXYtbarfYuQDuLZShdKsNbi3m5hyabZN5ZutvPWwKdorXugOSZWxfau?=
 =?us-ascii?Q?GyGQ1/tduZ9TwlebqWfoJeuNJg21T6Nek+IW8h9Z0HmeLQ3ItlC+QhdraP3k?=
 =?us-ascii?Q?OJeNfjeMU4JT/4afviNnYVNSnCQK2ywvG1FfIFXfGTqkYqEM3XzxIeW3eDqP?=
 =?us-ascii?Q?2awUH7a9bYfnzF7GkCi9WjOrcK0ljgXoAziOWP09Dd+5Y5yp6gJGuuijDs2d?=
 =?us-ascii?Q?5fBxL3axlHWaEP0orASC188yHByckmjp9o/MYiU08g4DBiMOlmG5mzVZ2TLh?=
 =?us-ascii?Q?/3vJjOgCIY1Ze1EPY37QHx98I9lKuNlDZfvSfRFJBSAnkJHtesNfcwt6Eync?=
 =?us-ascii?Q?O5OWMVpSaY4iUgf1sjve2CdwFdqfnwYWSKOU/iWSz3ZPD1BN80PexsZhG+7S?=
 =?us-ascii?Q?3LkiMW98n2kyeIFcbMBE7zX5ICCTAvLPB9/wVN43vRj1VDTSbSrqfmLSQVZk?=
 =?us-ascii?Q?u4esDjmP2+g6zXJaJksj+/HodNGBklOySyKAlfx5WC5o5AlFr+dWOO2u1iIm?=
 =?us-ascii?Q?myvb4EBa/2Di9ksfBMg/QDvbMaiQcD8IsYVgad877/LqgH7W+xM6mPPA0OmA?=
 =?us-ascii?Q?t0NZ2UdGnjMtq8k6PydPMtAGmdyKu2oaiuQqVEJa4kO9qUL7ZB4dJIuCV+th?=
 =?us-ascii?Q?TUswekyRqda0y56iJwXYYMkyg5WvQbk++mUf+wZ86FymYZCq+7VD06DzMusS?=
 =?us-ascii?Q?cH1LTUMUKzqwlYuF8iKiNjElfHuQkpI3HGzUPs0rMHej3iy41XsrJZcePMxV?=
 =?us-ascii?Q?Msq7ltAdkESD/xKo81pzJaTKqTxyftox0KdHSd69wCy2QHuJLzrG3IcGaF/p?=
 =?us-ascii?Q?XPrn8Ph5iTqX9sg0WgFaA5041qYMncwDoZwPfVj8BzZ/oAQXEep5LUSA4xz1?=
 =?us-ascii?Q?bR7a5wi+U3h7N79xXKwCi0SHocEDfg7eTEFASuwmjYaGQUFLKd8xoRzfxygn?=
 =?us-ascii?Q?Cio1laA8HZ6N8ZdSlF2LuAaqwu/2F3hcfTSqIDqVzuPyyupXHZE/xPirC/1U?=
 =?us-ascii?Q?D3/KAl6srMonkzFlC0UeMv1ZgFXRQPtmdDc2xFzErTSC+PXxmMJqOWFLfF5A?=
 =?us-ascii?Q?DXs2dEcuR4gvSDhl82c7G8ilxvKkD+L+D5t/hPuQUcVJHHqOn7h4AQdSZNhb?=
 =?us-ascii?Q?vWc/h0ySVqLOtr8pSFz1GZ4a2hMIuLCmG0iR0GjKe67Q4seku/IbWz4eZtic?=
 =?us-ascii?Q?0tZ/FsMa9Cut1Ve0uAq8gA9bzKN/Ip0rfzn2OhvQxzaWh2NaqUqZTbiXKV5c?=
 =?us-ascii?Q?CkcMDL6V+tRTSaHtwW6lChTC7IY/g3/Qst6nPX6AJ1MASrhOIcsGwK+mO5Sl?=
 =?us-ascii?Q?axsjKlufKivDGnQb01ru8lAs1gy3uGnhx7nDgWhncME/40XuPQxlXlIKRtly?=
 =?us-ascii?Q?Q62KC+pQIb54pwjcGpwM/ufAr9+8YlhQ6Qsny6sM09wmNbo4VbHmDG/NMYSn?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ccbe47-d27d-4f25-8fb7-08da66a9982b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 21:33:01.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsqSI7to/sMVP8j2qLz9pC5TR6fLzhmRDj4Yd0D4/nw1WNxiO+2Ent4nQT8ctAllw4Z6tLCsoRdQt+ttKnjwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:12:13AM +0100, Mauro Carvalho Chehab wrote:
> Building docs currently produces two warnings:
> 
>     Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:286: WARNING: Inline strong start-string without end-string.
>     Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:370: WARNING: Inline strong start-string without end-string.
> 
> That's because @foo evaluates into **foo**, and placing anything
> after it without spaces cause Sphinx to warn and do the wrong
> thing.. So, replace them by a different Sphinx-compatible tag.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> 
>  drivers/gpu/drm/i915/i915_vma_resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
> index 27c55027387a..fa5a678018d9 100644
> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
> @@ -283,7 +283,7 @@ i915_vma_resource_color_adjust_range(struct i915_address_space *vm,
>   *
>   * The function needs to be called with the vm lock held.
>   *
> - * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
> + * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
>   */
>  int i915_vma_resource_bind_dep_sync(struct i915_address_space *vm,
>  				    u64 offset,
> @@ -367,7 +367,7 @@ void i915_vma_resource_bind_dep_sync_all(struct i915_address_space *vm)
>   * this means that during heavy memory pressure, we will sync in this
>   * function.
>   *
> - * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
> + * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
>   */
>  int i915_vma_resource_bind_dep_await(struct i915_address_space *vm,
>  				     struct i915_sw_fence *sw_fence,
> -- 
> 2.36.1
> 
