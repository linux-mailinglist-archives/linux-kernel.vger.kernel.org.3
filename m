Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600858893A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiHCJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiHCJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:19:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4C2654E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659518369; x=1691054369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O2RWXOyQbCHw094fygQkTJRWCFZm1J7VsOY45hRzZ3g=;
  b=fr/aUUP+yRaS579x7MpHXrCRED/KJUxVfMvIbIxnPWoMb0+LCA/WTYrB
   OypIryYtMQ6Q+i3XOjtw0Gpo09FMxHU2fnRc56Q2ZjdNjFQoeU5LVcOEG
   E+/2yg/dbIErHfEi4PuiiAR1y6jj1jtZTzRHZh+XHIhi6/A5zr0b8QFFo
   aOa90OMDe4hF0Y3E7yFw5dXnc4FKefqJHKMqzObRHD0Eu2JS/2EWSeiyX
   eYgfAanxcHrjbiHnIu4gqNdhkF2yIEGFKv9TSN/TamcOsCIDrLI4Y0imx
   f05o8JCK8RQizR7OBZJH5Pnvnd0G+r4CSz03w733F7n27097Kh70abSte
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290843985"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="290843985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="662004375"
Received: from alubinsk-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.61.200])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:19:24 -0700
Date:   Wed, 3 Aug 2022 11:19:07 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chris Wilson <chris.p.wilson@intel.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fei Yang <fei.yang@intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915/gt: Move TLB invalidation to its own file
Message-ID: <Yuo9ixhBLYztz6CI@alfio.lan>
References: <cover.1659077372.git.mchehab@kernel.org>
 <f4d7b534511b57336eaea0ce696afdf675cf5892.1659077372.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d7b534511b57336eaea0ce696afdf675cf5892.1659077372.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Jul 29, 2022 at 09:03:54AM +0200, Mauro Carvalho Chehab wrote:
> From: Chris Wilson <chris.p.wilson@intel.com>
> 
> Prepare for supporting more TLB invalidation scenarios by moving
> the current MMIO invalidation to its own file.
> 
> Signed-off-by: Chris Wilson <chris.p.wilson@intel.com>
> Cc: Fei Yang <fei.yang@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

I already reviewed this patch... anyway I checked it again and
it's all correct.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
