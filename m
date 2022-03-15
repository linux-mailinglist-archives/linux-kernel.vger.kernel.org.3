Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA04D96AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbiCOIsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346175AbiCOIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:48:11 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DD4D252
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647334019; x=1678870019;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kakqjQCanOuw2LyERSzNKINczvU+7ul6+uHm8qhPuHs=;
  b=TLSS7l60N/JBA4NbZit6/cfkPQ29RqN9+gaFJxZFpwA84Z29BgHCy+WN
   9vkgW14bIku8hGOseMEcx/ysHH5nYKma1MOi+7m7PpNZnYDyj88Q0bEir
   PxCZZMcqvrVzTiYUEiH+Zcqav0cvUw+bmaNC+ABmM6sHip0oaXczbzY5h
   19+TBLw6TMDORzZlk0fx8CyNG9B11OSqOv1FM6twNt7r1hKjQ7pZt5JSe
   FnzY6ioegMyiK4WglXWZuAUAb4jqM/0j6hPtIs3hMDHLY7Fhsd4WJFnqP
   jsn3/9R3oUUYpLnVEV0Ayh+b2yuKE96q6DruUdmo0CPZ1Pd49cj2TRZbg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316969519"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="316969519"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:46:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="556827480"
Received: from cgrilli-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:46:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v6 1/3] i915/gvt: Introduce the mmio table to support
 VFIO new mdev API
In-Reply-To: <20220315075217.GA2830@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220208111151.13115-1-zhi.a.wang@intel.com>
 <871r0dqtjf.fsf@intel.com> <20220209072805.GA9050@lst.de>
 <4e2faf7b-383e-58b3-8ae9-8f8d25c64420@intel.com>
 <20220315075217.GA2830@lst.de>
Date:   Tue, 15 Mar 2022 10:46:53 +0200
Message-ID: <87a6drvc02.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022, Christoph Hellwig <hch@lst.de> wrote:
> Just curious, what is the state of this seris?  It would be good to
> have it ready early on for the next merge window as there is quite
> a backlog that depends on it.

Can't speak for the status of the series, but for drm the deadline for
changes headed for the merge window is around -rc5/-rc6 timeframe
i.e. this has already missed the upcoming merge window.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
