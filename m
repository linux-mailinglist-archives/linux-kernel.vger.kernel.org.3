Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3367758CC70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiHHQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiHHQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:58:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5559BCA6;
        Mon,  8 Aug 2022 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659977937; x=1691513937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CyZ9KFHsK3W8qpzogvHPOd+GVdfB3OgqatLSpmKZvks=;
  b=TRf4/Fa+7NEcR0h132sXexl/+Wo30Xhzro0vn+Gcl6qV3AaGrBKLoRSH
   HmG64BvbtbD5nsw7eNc0zsOGtFcAdvlqFls3cmKpjCN7YNGpKUdzOthQJ
   nAx+lMURurhwBO82iuryDNmkGHTaroA32jgXwChYctoYeQ6Be82ZstHX1
   vnPiBkhhY0INzR4LUdHKtUW01jKxrICXbsrPcixSXCExRUMb+G+TWhiTb
   ZqH9VrGTjBIGD9WuQHADtFoGDAresHih8JRAXRP0XPjlwVs3jjycBku25
   lYIAw5keOGCXsHs0l+kEet72VOeJgZSrXks5ktWDs5hv7x9GNlwfLzYLl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="376935456"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376935456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:58:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664040274"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.40.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:58:53 -0700
Date:   Mon, 8 Aug 2022 18:58:50 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/i915/gt: document TLB cache invalidation
 functions
Message-ID: <YvFAyhjeGSwJkEjc@alfio.lan>
References: <cover.1659598090.git.mchehab@kernel.org>
 <cc68d62a1979ea859b447b94413e100472331f57.1659598090.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc68d62a1979ea859b447b94413e100472331f57.1659598090.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, Aug 04, 2022 at 09:37:24AM +0200, Mauro Carvalho Chehab wrote:
> Add a description for the TLB cache invalidation algorithm and for
> the related kAPI functions.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
