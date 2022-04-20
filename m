Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF08508D08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380457AbiDTQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbiDTQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:20:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150272E9E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650471436; x=1682007436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y1a4pcTqymAWKcsqfTocRlg43sp5JlsqbUEBLfk5npw=;
  b=gRsHsRA49Aelf+LYQHYamHevXE4k0f6N77YZtOEmbWkqs41jZHVB6KK9
   xyvRUghvh4fwDfC9V/UVIhwccz/aGdOpCKvudtsmL5F+EyLj0C6BVd6il
   PL+mWugerdzHP15bcRy3pj/gX/PcbYss4oNc9rR+wjN4K/+2b1mHD/AQv
   JviSrlyH8kJaOu+DbbXr+2zeFZj5u+MaKcvDVRbK2CzIW6vkpwpxgmZsg
   HUla9W557pUbF/kOneW81AGDYm0+lhcTmdswckNgakI8HEgu0uAiBCBEs
   +1clR8O9rykKTsW+FgsSGtR21zSMXUVCb48GiGkG+KaOBLrxmqHs8pPDR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263537620"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263537620"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 09:11:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576661339"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 09:11:04 -0700
Message-ID: <2572220e-57d0-4f10-1695-bfeab54de38d@linux.intel.com>
Date:   Wed, 20 Apr 2022 11:11:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify
 the code
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        cgel.zte@gmail.com, Zeal Robot <zealci@zte.com.cn>,
        lgirdwood@gmail.com, Minghao Chi <chi.minghao@zte.com.cn>,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
 <78c7edc3-f431-9735-238d-9aa2b45ec45e@linux.intel.com>
 <YmAljQjpLCoBv+nj@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YmAljQjpLCoBv+nj@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 10:23, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 08:28:31AM -0500, Pierre-Louis Bossart wrote:
>> On 4/19/22 22:03, cgel.zte@gmail.com wrote:
>>> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
>>> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
>>> pm_runtime_put_noidle. This change is just to simplify the code, no
>>> actual functional changes.
> 
>> Well, maybe that's a simplification, but we've been using the same pattern for years now.
> 
>> Is there really a clear direction to use this new function?
> 
> It seems like a much better pattern and there's been a steady stream of
> conversion patches.  The whole get/idle thing is pretty much just sharp
> edges.
> 
>> the overwhelming majority of drivers in sound/soc still rely on the pm_runtime_get_sync (111 v. 7).
> 
> We'll get there I'm sure.

ok, I'll send follow-up patches for the remaining code.

For this patch: 

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
