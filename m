Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57E4D976E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiCOJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbiCOJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:18:08 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A34BBAF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647335816; x=1678871816;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qOPa+F54O4/TfxmNFtroDQz1EVEjO7MUzBSRnv58S9w=;
  b=X9rTqzHm05FnDkFr7ANq2R/l/UuaLIyxkIoQlBJyOpKYg7PLG9wChvct
   oN+CsbRgD9r5WpZxenawMCgy6E1oiT3UJD9nBcv7MhoITyXN0K8CqryZW
   YXIsGECYiFTo9FSdJ5MJojV6PvytbZJA3L3pyq+/C14PijrFnE78M0Llf
   dttvi3DEADwvSQ6BOWmuG4qvEhVXN08Bt95JkiwxxpINSuxvAMkeEfWio
   QWsDRJRRyl188zATVDMs4EwliCnLvZsyGCbPNKOiFowJdXQI+m6j5bp2/
   ruMnnnUgC9QUreEmanj7CiavnpA+2M3iBLokwJtfTxWsNEBiQJqaG1V6+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316974929"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="316974929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:16:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540355567"
Received: from cgrilli-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.234])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:16:52 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
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
In-Reply-To: <20220315084817.GA4105@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220208111151.13115-1-zhi.a.wang@intel.com>
 <871r0dqtjf.fsf@intel.com> <20220209072805.GA9050@lst.de>
 <4e2faf7b-383e-58b3-8ae9-8f8d25c64420@intel.com>
 <20220315075217.GA2830@lst.de> <87a6drvc02.fsf@intel.com>
 <20220315084817.GA4105@lst.de>
Date:   Tue, 15 Mar 2022 11:16:50 +0200
Message-ID: <877d8vvam5.fsf@intel.com>
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
> I know.  I meant the next one, not the one ending now.  And I don't
> want to miss another one.

Ok, good, thanks.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
