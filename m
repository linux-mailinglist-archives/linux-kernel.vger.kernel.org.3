Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F604AB95F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbiBGLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiBGLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:06:08 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:06:08 PST
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BA7C043188;
        Mon,  7 Feb 2022 03:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644231968; x=1675767968;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vKJ4QcP9fRqWs4tGoyWgQwEyJftVIBFH0F7ZDLnXbgE=;
  b=YTqVopbV7Yprp1smcwWntyi7L9pCGNTVe8xdzmtBnIPqi1HaE+44ofjg
   QACugBIve4qwicGfQ5yX9wua8i7lr+nMiZ4InBrhCy611YExaEgGXROtW
   /T3MV1jBrqs3ZKeP/P85/VHom8MoSIW7Lzns9waXiojFaPDKlh4y4GqKC
   vre4XlXkYPGFIFLM2McTrLEwc4oLNAqXo0MtTF9YfeL1koVUcO88oayBg
   QqiMQCePj3jFCUBDL7WCbGcZlKE0F0GoI7GhmC1tomcJJMjefAGjEqPNf
   zfe/0OeTGiZOKwcWqrk6hlGcndhRrsQZi9fUpXuViAvPjEccfQrQTRvrQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="232257838"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="232257838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:05:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="628486542"
Received: from nbaca1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.18.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:05:00 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Remove common Post Cursor2 register handling
In-Reply-To: <202202041740.F368F91F5@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220105173507.2420910-1-keescook@chromium.org>
 <202202041740.F368F91F5@keescook>
Date:   Mon, 07 Feb 2022 13:04:55 +0200
Message-ID: <87y22nq6nc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2022, Kees Cook <keescook@chromium.org> wrote:
> Ping,
>
> This is a OOB read fix. Can someone please pick this up?

Daniel? Thierry?

As I said, I reviewed this but I'm not comfortable applying patches that
change the functionality of drivers I don't maintain.

BR,
Jani.


>
> -Kees
>
> On Wed, Jan 05, 2022 at 09:35:07AM -0800, Kees Cook wrote:
>> The link_status array was not large enough to read the Adjust Request
>> Post Cursor2 register, so remove the common helper function to avoid
>> an OOB read, found with a -Warray-bounds build:
>> 
>> drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
>> drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
>>    59 |         return link_status[r - DP_LANE0_1_STATUS];
>>       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
>>   147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
>>       |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> Replace the only user of the helper with an open-coded fetch and decode,
>> similar to drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.
>> 
>> Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This is the alternative to:
>> https://lore.kernel.org/lkml/20211203084354.3105253-1-keescook@chromium.org/
>> ---
>>  drivers/gpu/drm/drm_dp_helper.c | 10 ----------
>>  drivers/gpu/drm/tegra/dp.c      | 11 ++++++++++-
>>  include/drm/drm_dp_helper.h     |  2 --
>>  3 files changed, 10 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
>> index 23f9073bc473..c9528aa62c9c 100644
>> --- a/drivers/gpu/drm/drm_dp_helper.c
>> +++ b/drivers/gpu/drm/drm_dp_helper.c
>> @@ -144,16 +144,6 @@ u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>>  }
>>  EXPORT_SYMBOL(drm_dp_get_adjust_tx_ffe_preset);
>>  
>> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
>> -					 unsigned int lane)
>> -{
>> -	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
>> -	u8 value = dp_link_status(link_status, offset);
>> -
>> -	return (value >> (lane << 1)) & 0x3;
>> -}
>> -EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
>> -
>>  static int __8b10b_clock_recovery_delay_us(const struct drm_dp_aux *aux, u8 rd_interval)
>>  {
>>  	if (rd_interval > 4)
>> diff --git a/drivers/gpu/drm/tegra/dp.c b/drivers/gpu/drm/tegra/dp.c
>> index 70dfb7d1dec5..f5535eb04c6b 100644
>> --- a/drivers/gpu/drm/tegra/dp.c
>> +++ b/drivers/gpu/drm/tegra/dp.c
>> @@ -549,6 +549,15 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>>  {
>>  	struct drm_dp_link_train_set *adjust = &link->train.adjust;
>>  	unsigned int i;
>> +	u8 post_cursor;
>> +	int err;
>> +
>> +	err = drm_dp_dpcd_read(link->aux, DP_ADJUST_REQUEST_POST_CURSOR2,
>> +			       &post_cursor, sizeof(post_cursor));
>> +	if (err < 0) {
>> +		DRM_ERROR("failed to read post_cursor2: %d\n", err);
>> +		post_cursor = 0;
>> +	}
>>  
>>  	for (i = 0; i < link->lanes; i++) {
>>  		adjust->voltage_swing[i] =
>> @@ -560,7 +569,7 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>>  				DP_TRAIN_PRE_EMPHASIS_SHIFT;
>>  
>>  		adjust->post_cursor[i] =
>> -			drm_dp_get_adjust_request_post_cursor(status, i);
>> +			(post_cursor >> (i << 1)) & 0x3;
>>  	}
>>  }
>>  
>> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
>> index 472dac376284..fdf3cf6ccc02 100644
>> --- a/include/drm/drm_dp_helper.h
>> +++ b/include/drm/drm_dp_helper.h
>> @@ -1528,8 +1528,6 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>>  					  int lane);
>>  u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>>  				   int lane);
>> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
>> -					 unsigned int lane);
>>  
>>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
>>  #define DP_RECEIVER_CAP_SIZE		0xf
>> -- 
>> 2.30.2
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
