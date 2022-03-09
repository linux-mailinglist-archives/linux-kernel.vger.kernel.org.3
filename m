Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEF4D3D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiCIWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiCIWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:47:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397EF94D5;
        Wed,  9 Mar 2022 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865997; x=1678401997;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WnuCku9hZPBs/mDKV7KBZmMyPCNAfntcGPIenVgkhuA=;
  b=arUZg/Yx/fIcvBRvbKfx4LfqyTMH5VsQoBUPVdfsavWqvCAd3PfahbUR
   qQ8OPmclP6Vu0ivehSzGXKPyekH+kdwAIGXu38lplZi91s3yDMbQfX6lW
   T/l9UCg2gnqQr2LChJRl/idg6tvpoOxI5udfMHEdKlw+iMxNnIN9ygNHF
   RDiSzizHSvI0U1YRp3Gwe24x5Yjs5RqmgeXgzsVUXw/bmesvcCfNcrVVr
   QoWmWqHHo5EKLxwlDa1fzvNWfSrQct+mqkxjw4zdpEW4AcZCh3m49Ni/m
   ZB52JTM6Ah8wBULFESYLxJeHFYaCxKE+inD4zrrhKwy8f9C84qw3qlIx2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252678655"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="252678655"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:46:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642323617"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:46:37 -0800
Message-ID: <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
Date:   Wed, 9 Mar 2022 14:46:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-2-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
In-Reply-To: <20220309223431.26560-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 14:34, Chang S. Bae wrote:
> +/*
> + * Initialize register state that may prevent from entering low-power idle.
> + * This function will be invoked from the cpuidle driver only when needed.
> + */
> +void fpu_idle_fpregs(void)
> +{
> +	if (!fpu_state_size_dynamic())
> +		return;

Is this check just an optimization?  I'm having trouble imagining a
situation where we would have:

	(xfeatures_in_use() & XFEATURE_MASK_XTILE) == true
but
	fpu_state_size_dynamic() == false

> +	if (xfeatures_in_use() & XFEATURE_MASK_XTILE) {
> +		tile_release();
> +		fpregs_deactivate(&current->thread.fpu);
> +	}
> +}

xfeatures_in_use() isn't exactly expensive either.
