Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094A052A7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbiEQQdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEQQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:33:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6D43193C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652805180; x=1684341180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qe4LIFT49VN/IVvl50czFXImIVyT8V7bld71clAHhnU=;
  b=V05TyuaJgBOI2mwbqNnxbrmscp3IrNngRio6hFVbNf+rePj292p9EEh9
   dE/DbnUfR0TxGcOx9kkZTShn9uaoP+KZqjjhayVQ12ISnfLQRjfaGrh6c
   yXVBnm7EhNE09q/mKgbd8GFM0z29HN/K5ddJJNGuKbgzeuXu4zxQQdiER
   M5Gf14ucGRzuadJoxVOA4s5DTYy7eYTIYzDsX+dTvfd0epvyFOXjsZuK+
   XgbyibfErAe/3VvxYYkr8rr8l7Ecfc/PbgjUylVzM3BzEwnc+ukUzel1D
   PxAnDxAbFNQtRDQfflzg30mXO6uYryyzUXhhoeIgXvAo/NVCQPyTEW25M
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270932050"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270932050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:33:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597222799"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:32:59 -0700
Date:   Tue, 17 May 2022 09:33:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        babu.moger@amd.com, x86@kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Message-ID: <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
References: <20220517001234.3137157-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517001234.3137157-1-eranian@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eranian,

On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
...
> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	first_bit = find_first_bit(&val, cbm_len);
>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>  
> +	/* no need to check bits if arch supports no bits set */
> +	if (r->cache.arch_has_empty_bitmaps && val == 0)
> +		goto done;
> +
>  	/* Are non-contiguous bitmaps allowed? */
>  	if (!r->cache.arch_has_sparse_bitmaps &&
>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  				    r->cache.min_cbm_bits);
>  		return false;
>  	}
> -
> +done:
>  	*data = val;
>  	return true;
>  }

Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
Is the following patch a better fix? I don't have AMD machine and cannot
test the patch.

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6055d05af4cc..031d77dd982d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
+			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
 			hw_res->msr_update = mba_wrmsr_amd;
