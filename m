Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30757E146
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiGVMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:07:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452FBB5E9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658491648; x=1690027648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7csoj11Ngte1VsV9j1GfxOWnYiT9h3Gecw0LVntMgDk=;
  b=mb3+C2IqsNWuRPn4vI7jYCGCjcYmZtyW3jtLMKA9qYd5YBtdwD3ltQPC
   P3DHdyjimB9VNMPpJMfv852D4UB5qfOphez5zfZZWhrEQVESyV9pOa1/y
   gOEdTZ2JaEJ9dVdoPoCB20mQgRapXQ4gwE9KaIzw6IRO2vLW8M2LmV/zE
   eburlZkIcp9Z6wUwUW9mmTUQLNXUpUbAGXufDWSCfd8gqOdF8D7USuakd
   Ol6eQgfNH2fNhPhGTJiidZ9YdiXXjFSb8Nsm9fp+JED1L+ytke/svgcRj
   mK9++c14UBdzVU0sxWDZ00of2d1Wdu7WhNB1xUsczhBJLyTh+k2h470hQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267074450"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="267074450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 05:07:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="657191932"
Received: from dstoll-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.44.132])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 05:07:22 -0700
Date:   Fri, 22 Jul 2022 14:07:22 +0200
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
        Jason Ekstrand <jason@jlekstrand.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fei Yang <fei.yang@intel.com>
Subject: Re: [PATCH v2 08/21] drm/i915/gt: Move TLB invalidation to its own
 file
Message-ID: <YtqS+kfQDgFIPfmB@alfio.lan>
References: <cover.1657800199.git.mchehab@kernel.org>
 <d9cbb37b472084a6a05f6fc8c2e802b122de08e8.1657800199.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cbb37b472084a6a05f6fc8c2e802b122de08e8.1657800199.git.mchehab@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, Jul 14, 2022 at 01:06:13PM +0100, Mauro Carvalho Chehab wrote:
> From: Chris Wilson <chris.p.wilson@intel.com>
> 
> Prepare for supporting more TLB invalidation scenarios by moving
> the current MMIO invalidation to its own file.
> 
> Signed-off-by: Chris Wilson <chris.p.wilson@intel.com>
> Cc: Fei Yang <fei.yang@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Just a copy paste, I checked line by line and it looked all
correct:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
