Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480E50F2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbiDZHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiDZHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:40:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C013FD09;
        Tue, 26 Apr 2022 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650958622; x=1682494622;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=S3egy43WTJExLU3u7/k2FT8QCl0oLX3uS9BX5mAWDfo=;
  b=XcA+cL+wgB+W1k7iSFPniozzMSxbeHS1t4nDiyJKL95vcRv2P8wI5NLP
   dtXQ051jkZ2p53lMEX5C1MLkBchg2iT4QXjExJ7d1KMP0lDUQH9WmpAkM
   35ny3nfqEm+AHrr9ZomeaiqC8D4JEunL5ycPOa4gIv1Ktfoley8Am1Iqr
   3iPIAl7a0VqG7vd6sIDQIyhkR3Vp7znOEteYyF7kw/UKtk91mXu2xCxlr
   loFB7AYMAK6GzJNk4Hd+DDkfiGWVnPgp2BnU43gmmE1hz8JIe401kExb0
   fS5SQM0rV+fF30U79+q2XfkgMgzSHh2qww7ZZndcfgEYxuSQNf6SgSDaZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247417826"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247417826"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="532528422"
Received: from vhlushch-mobl.ger.corp.intel.com (HELO localhost) ([10.249.132.136])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:36:52 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Christoph Hellwig <hch@lst.de>, Zhi Wang <zhi.a.wang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
In-Reply-To: <20220426120802.574a9659@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220426120802.574a9659@canb.auug.org.au>
Date:   Tue, 26 Apr 2022 10:36:50 +0300
Message-ID: <87a6c8uwh9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: modpost: "intel_runtime_pm_put" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
>
> Possibly caused by commit
>
>   8b750bf74418 ("drm/i915/gvt: move the gvt code into kvmgt.ko")
>
> or one of tehe follow ups.
>
> I have used the drm-intel tree from next-20220422 for today.

Details at [1], fix at [2].

BR,
Jani.

[1] https://lore.kernel.org/r/87ilqxuyu3.fsf@intel.com
[2] https://lore.kernel.org/r/20220425220331.24865-1-zhi.a.wang@intel.com


-- 
Jani Nikula, Intel Open Source Graphics Center
