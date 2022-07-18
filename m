Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760557839B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiGRNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiGRNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:21:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E07248E4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658150511; x=1689686511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t54h+03DTals7K9cEuEjuoCsltxBcdxS92lbUylXBc8=;
  b=BEAJABlXUVgYws/TJp3k3kMktpAxKWiVqa6iP15Lo9G6GAXUBXqrw1M4
   tEF8X+s6QBdG4JE0hKSzKF3l/WG5L94pmTAEiwiuLLqSEPInNy2ofwtfS
   +nP9DgP7Eo42fGO50ZXXPwzim/WtNb0cQd+8J4dpkwDoxnXANPNYwMlmo
   f6BJa3jAIlo2Z67eAfNn23nkdDo5dxryurHpwVrvqnkh/IUIejA0rH8Ug
   pG1RyPiOhsb8g+sSXxWO1engYnLkcF/Y7S9qxsZvVcXiywTN7TR8knk0t
   EgZvEBFO5h5i8O1n7luHNSp7RBtEQk1p6DGKnQaeYkJUIM4OJg8TK+Tm2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266622262"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266622262"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:21:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="686732431"
Received: from smyint-mobl1.amr.corp.intel.com (HELO [10.212.107.15]) ([10.212.107.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:21:49 -0700
Message-ID: <de7c7b5d-267b-25c7-6695-cd9e47a0217d@linux.intel.com>
Date:   Mon, 18 Jul 2022 14:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 02/21] drm/i915/gt: document
 with_intel_gt_pm_if_awake()
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1657800199.git.mchehab@kernel.org>
 <1ed105f9fd605e1ccdaecc18c394c17eaec1035e.1657800199.git.mchehab@kernel.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <1ed105f9fd605e1ccdaecc18c394c17eaec1035e.1657800199.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/07/2022 13:06, Mauro Carvalho Chehab wrote:
> Add a kernel-doc markup to document this new macro.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/21] at: https://lore.kernel.org/all/cover.1657800199.git.mchehab@kernel.org/
> 
>   drivers/gpu/drm/i915/gt/intel_gt_pm.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> index a334787a4939..4d4caf612fdc 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> @@ -55,6 +55,13 @@ static inline void intel_gt_pm_might_put(struct intel_gt *gt)
>   	for (tmp = 1, intel_gt_pm_get(gt); tmp; \
>   	     intel_gt_pm_put(gt), tmp = 0)
>   
> +/**
> + * with_intel_gt_pm_if_awake - if GT is PM awake, get a reference to prevent
> + *	it to sleep, run some code and then put the reference away.
> + *
> + * @gt: pointer to the gt
> + * @wf: pointer to a temporary wakeref.
> + */
>   #define with_intel_gt_pm_if_awake(gt, wf) \
>   	for (wf = intel_gt_pm_get_if_awake(gt); wf; intel_gt_pm_put_async(gt), wf = 0)

Maybe say in kerneldoc the put is async. Although for me documenting 
trivial helpers is a bit over the top by anyway..

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
