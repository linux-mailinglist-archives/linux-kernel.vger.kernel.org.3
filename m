Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB54BC05B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiBRTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiBRTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:42:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A19D226F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645213345; x=1676749345;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=baOXokhByXXziWZwCqa3Bh4RX/PKcroubuFVmmtj6zE=;
  b=dRU8lUmu1CzSWq80Hkn/nBmRgFeR2dB9Q1YT6RR4vdDV4Mejvex/oUXH
   HGgn6xT6F3qM7x0ld4dw2oTcNNmSzvP32h6kD4pXadjksdCppwaY03XXV
   6lqXCPFDLWpmrqveepwO+/p4aLiyvgB7pU+tGAWjb/Bu/wzXpqfYD1t/z
   kRYYU9QVW9Ontp5a7UJruuVxdBNCHMM9ZQkKlxM0OZalbxxcLY6xU6hBt
   4RRXmvUKOVkELD1ovqywEYV9cMET2PAQ+gMQclkd3hEScVZWZ7yHBaFE+
   aXsBFgjpON0q9/jDE1HAzqZDMHezffs/2u109jkmWMPvGB7DP2j2TyB6M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="251144521"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251144521"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 11:42:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="504111596"
Received: from sporter-mobl.ger.corp.intel.com (HELO localhost) ([10.209.62.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 11:42:24 -0800
From:   Jordan Justen <jordan.l.justen@intel.com>
To:     Ramalingam C <ramalingam.c@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Simon Ser <contact@emersion.fr>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Kenneth Graunke <kenneth@whitecape.org>,
        mesa-dev@lists.freedesktop.org, Tony Ye <tony.ye@intel.com>,
        Slawomir Milczarek <slawomir.milczarek@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] drm/i915/uapi: document behaviour for DG2 64K
 support
In-Reply-To: <20220218185540.GA7762@intel.com>
References: <20220208203419.1094362-1-bob.beckett@collabora.com>
 <20220208203419.1094362-6-bob.beckett@collabora.com>
 <87ee40ojpc.fsf@jljusten-skl> <20220218134735.GB3646@intel.com>
 <78df4b73-9b2d-670b-a6b0-a45b476f1f0a@collabora.com>
 <20220218185540.GA7762@intel.com>
Date:   Fri, 18 Feb 2022 11:42:23 -0800
Message-ID: <875ypcneqo.fsf@jljusten-skl>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramalingam C <ramalingam.c@intel.com> writes:

> On 2022-02-18 at 18:06:00 +0000, Robert Beckett wrote:
>> 
>> If desired, we can make the wording clearer, maybe something like:
>> 
>> "To keep things simple for userland, we mandate that any GTT mappings
>> must be aligned to 2MB. The kernel will internally pad them out to the next
>> 2MB boundary"
>
> Added the extra information in next version @
> https://patchwork.freedesktop.org/patch/475166/?series=100419&rev=1
>
> Jordan, hope this explanation clears your doubt.

Ok. It sounds like what we are doing in Mesa matches what is required by
hardware and the kernel. Thanks.

-Jordan
