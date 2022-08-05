Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D132958A8C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiHEJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiHEJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:26:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B27821F;
        Fri,  5 Aug 2022 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659691602; x=1691227602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tG8kUD3ji7GDYQSEFarrC17CSyndXtVIb31RNBiVtX4=;
  b=NHhh/conhaMMFuyUXq59VQLp7q9d/bX9y4mM9GMXSOLkLoSx6KVTq2Gx
   U9u4HvBQQz3fTiG7+PZDwpMcxlZdyWVHLhtHxYqbtQjUiULZQoEea2c2n
   UUz/CEZXzF6I82wwamyAxZtZL7zT0BHltESUX7YcPPq832r84yhNXDTni
   jcSYmw8UCREjCurfq3U6QpO7z2rUuS3YTMumGBHfNGnRUDvHRRo2mVa47
   xgihbM70jaY1YIdadrqqs3lkyhJX3Oq9qRvWpLbvOvZ/zWrw/uFDPfMeI
   sr5lR5/Zd7PE7hyagM0w43nQCQO0TpwftmKMsCdtKC/R55Fm5LgtrJj1U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="351874347"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="351874347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 02:24:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="554052121"
Received: from bfglenno-mobl.ger.corp.intel.com (HELO [10.213.238.183]) ([10.213.238.183])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 02:24:27 -0700
Message-ID: <7156b3bd-69d7-de53-dd2b-96e82a8cf0f7@linux.intel.com>
Date:   Fri, 5 Aug 2022 10:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] drm/i915/gt: document TLB cache invalidation
 functions
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1659598090.git.mchehab@kernel.org>
 <cc68d62a1979ea859b447b94413e100472331f57.1659598090.git.mchehab@kernel.org>
 <0698c5a5-3bf2-daa4-e10e-2715f9b0d080@infradead.org>
 <Yuzd9Ysc3BDQHuSW@alfio.lan>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Yuzd9Ysc3BDQHuSW@alfio.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/08/2022 10:08, Andi Shyti wrote:
> Hi Randy,
> 
>>> +/**
>>> + * intel_gt_invalidate_tlb_full - do full TLB cache invalidation
>>> + * @gt: GT structure
>>
>> In multiple places (here and below) it would be nice to know what a
>> GT structure is. I looked thru multiple C and header files yesterday
>> and didn't find any comments about it.
>>
>> Just saying that @gt is a GT structure isn't very helpful, other
>> than making kernel-doc shut up.
> 
> the 'gt' belongs to the drivers/gpu/drm/i915/gt/ subsystem and
> it's widely used a throughout i915.
> 
> I think it's inappropriate to describe it just here. On the other
> hand I agree that a better documentation is required for the GT
> itself where other parts can point to.

Yeah agreed there is no point of copy pasting some explanation all over 
the place. Could we just do s/GT structure/struct intel_gt/, or "pointer 
to struct intel_gt to operate on", would that be good enough?

Regards,

Tvrtko
