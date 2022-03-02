Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0424CA254
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiCBKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiCBKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:38:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395237A89
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646217445; x=1677753445;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bl/kn8wsyMQAPxCRMAmGszNM18vXJanwFRfFFWl+vmE=;
  b=UUZot5DqM/XNrUVDN0xMDbbUEkkTow5tJqrIjsMos9SBRSxFu7FrnoMq
   ee512Tgb6Q1tSb2GCbLdqq3fZpexkvZEoOwTURz6bVWgp2FO84CsTeuPd
   AobIbCfHPl24t3AFv2QED7oTFWdueQWNTXR4NoxV6iCxNOX/efLJtfqLl
   fFwRANRVhsDujoQKg/sO/Zp0sDQQm+iXbGuA3MOchd7KJEWX4Q5A90ges
   AeaXnaRlBrHxIDbIwWfG2COsY59eM1NHVi07pfFnvigCBaLWZWJSrRf4x
   rxYckU481ZWdoPgz4UF9ByZCjttIwosGPEXnNg6OHxuyL50Q8YKc5UQhg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240783552"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="240783552"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 02:37:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="641652498"
Received: from jbuller-mobl1.ger.corp.intel.com (HELO [10.213.194.231]) ([10.213.194.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 02:37:21 -0800
Message-ID: <9586bba7-ffb8-945f-eb30-88629e34737d@linux.intel.com>
Date:   Wed, 2 Mar 2022 10:37:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/i915/gt: Handle errors for i915_gem_object_trylock
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, radhakrishna.sripada@intel.com,
        ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
        lucas.demarchi@intel.com, jose.souza@intel.com,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220302061946.46630-1-jiasheng@iscas.ac.cn>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220302061946.46630-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Thomas, Matt

On 02/03/2022 06:19, Jiasheng Jiang wrote:
> As the potential failure of the i915_gem_object_trylock(),
> it should be better to check it and return error if fails.
> 
> Fixes: 94ce0d65076c ("drm/i915/gt: Setup a default migration context on the GT")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/i915/gt/selftest_migrate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
> index fa4293d2944f..79c6c68f7316 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
> @@ -465,7 +465,11 @@ create_init_lmem_internal(struct intel_gt *gt, size_t sz, bool try_lmem)
>   			return obj;
>   	}
>   
> -	i915_gem_object_trylock(obj, NULL);

Guys why is this a trylock to start with? (Since being added in 
94ce0d65076c ("drm/i915/gt: Setup a default migration context on the GT").

Surely it can't ever fail since the object has just been created.

Regards,

Tvrtko

> +	if (!i915_gem_object_trylock(obj, NULL)) {
> +		i915_gem_object_put(obj);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
>   	err = i915_gem_object_pin_pages(obj);
>   	if (err) {
>   		i915_gem_object_unlock(obj);
