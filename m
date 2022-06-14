Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0F54B9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358504AbiFNSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358398AbiFNSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:54:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015735241;
        Tue, 14 Jun 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655232491; x=1686768491;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOyqDZuqaiOs6xJm5q38O8F9rb//aReCl5ThOZoPPXI=;
  b=iNtkZF7lswF84ys3SpcvQ0XoQV0FqsMUi+pvWmEvt6S5pBqekNvdHGHN
   EJs+xV16uX6L0gGcpcyAVhBphbhNf178See2fnn2BKeayEJ9c3OgbOr1K
   90Om1teRqfIYZGNlja+mRQm/T4gwjo7mfreNC+expi0OWmjPJ//9i0dL+
   fC3qyz0Oja0LtqWI2cd8H6Xdd0QVjRsPZ2CeXz2CBB7J7lVBNdULttg74
   rkHBP7vQvS/BXqQwZCf6acuregQfpfpdZuI4Bxe38wPtV7IX7hk1t1I+5
   IAdOg2mcznxwvRyx1kMR/teqrifDRyGkMR0/cwnW037dD38fH43yzRRlD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342673912"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342673912"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 11:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640525207"
Received: from ticela-or-153.amr.corp.intel.com ([10.254.6.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 11:48:10 -0700
Message-ID: <606859dd0edcc2330fc353b0cb15395ed883b5bc.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove redundant re-assignments
 to pointer array
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 11:48:10 -0700
In-Reply-To: <20220614183809.163531-1-colin.i.king@gmail.com>
References: <20220614183809.163531-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 19:38 +0100, Colin Ian King wrote:
> There are two occurrences where the pointer array is being assigned a
> value
> that is never read, the pointer gets updated in the next iteration of
> a
> loop. These assignments are redundant and can be removed.
> 
> Cleans up clang scan-build warnings:
> sound/soc/intel/skylake/skl-topology.c:2953:3: warning: Value stored
> to
> 'array' is never read [deadcode.DeadStores]
> sound/soc/intel/skylake/skl-topology.c:3602:3: warning: Value stored
> to
> 'array' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

LGTM, thanks!

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

