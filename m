Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E83258CC33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbiHHQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiHHQiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:38:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C387E01E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659976696; x=1691512696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdtKQDr/7hNuJqSsyBjbXL9BpkN6bXL5MCwDsuiI8z4=;
  b=Y4sOgoqg+GE3/HdGLRvf9zwJUIFuNIR2aVoyf7eNUjm0Rap4v/+5nZze
   ZVlRfI85TRZAIxmf6vNIzp6JyekL9hjn/ZnbiU8J9Tl03O0PZMAfXboWP
   rPMkgrBm7EaX05JNVgnwoiR0WmGAc3qP9L5pPwaSi9aodM3jfxrKot6nK
   LiOjsa8bzeTRuR4ruVWcG+mU0JaDVhlpZ5nuCb7UPTXwffW6l2knfq89v
   ibTmP3eGon+jFxlJ8cyd1eNBqnvWZSPU6M3V0J/zt9Y5KspruphxzykK9
   iQ8zyX+elij7aNM+/C6zHABtIbpZ+3RpPEYY5oIcZqLTNCUzCyaLa2/Vx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288202763"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288202763"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:38:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664030714"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.40.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:38:00 -0700
Date:   Mon, 8 Aug 2022 18:37:58 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Michael Cheng <michael.cheng@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm/i915: pass a pointer for tlb seqno at
 vma_invalidate_tlb()
Message-ID: <YvE75o0uOtDGayNK@alfio.lan>
References: <cover.1659598090.git.mchehab@kernel.org>
 <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, Aug 04, 2022 at 09:37:22AM +0200, Mauro Carvalho Chehab wrote:
> WRITE_ONCE() should happen at the original var, not on a local
> copy of it.
> 
> Fixes: 5d36acb7198b ("drm/i915/gt: Batch TLB invalidations")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Are you going to send it to the stable mailing list?

Andi
