Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B92C4B2533
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbiBKMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiBKMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:06:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5866F65;
        Fri, 11 Feb 2022 04:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644581176; x=1676117176;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oPJ3HrbBkuSthMTs0EG6JJSdCgStR5rAPs5DdmwBg3c=;
  b=Yk+/i2VuJC1i8OUxoy1XV8p+tD2QHhzMvAf6SrqtTFYGWnrDrB6gCdgb
   anhb4py3iX4Gcbav18+Rshi+iardKcZklyEHUNf2fUYDQLh7KpYdfpeZS
   s8w6R4r/ZCOqj2TVGkfI25VADPus25bfEaml5em2xcDxBQDmWH/gKNebO
   tVx9r2xCltZi/AtfZpc0kZJIulbnmpc+0hFEVjXIwF4PU7Rz3RdgLjbwz
   CAj7ROjcDDL25f0l71HLHwTezzkEmOqGp3TPJ6Wc9xSZu+kbtpnYWsyoV
   NHyPIsFElT4ZzHLVrIe/0IHhAUPm38IJ7oJUP9J6OKBEJFy9OqixC4mcE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="313001726"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="313001726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:06:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="526937460"
Received: from rriverox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:05:58 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
In-Reply-To: <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
Date:   Fri, 11 Feb 2022 14:05:56 +0200
Message-ID: <87pmnt7gm3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi
>
> Am 11.02.22 um 12:12 schrieb Andy Shevchenko:
>> On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:
>>> On 2/11/22 11:28, Andy Shevchenko wrote:
>>>> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
>> 
>> ...
>> 
>>>>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
>>>>> +{
>>>>> +	unsigned int x;
>>>>> +
>>>>> +	for (x = 0; x < pixels; x++) {
>>>>> +		u8 r = (*src & 0x00ff0000) >> 16;
>>>>> +		u8 g = (*src & 0x0000ff00) >> 8;
>>>>> +		u8 b =  *src & 0x000000ff;
>>>>> +
>>>>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
>>>>> +		*dst++ = (3 * r + 6 * g + b) / 10;
>>>>> +		src++;
>>>>> +	}
>>>>
>>>> Can be done as
>>>>
>>>> 	while (pixels--) {
>>>> 		...
>>>> 	}
>>>>
>>>> or
>>>>
>>>> 	do {
>>>> 		...
>>>> 	} while (--pixels);
>>>>
>>>
>>> I don't see why a while loop would be an improvement here TBH.
>> 
>> Less letters to parse when reading the code.
>
> It's a simple refactoring of code that has worked well so far. Let's 
> leave it as-is for now.

IMO *always* prefer a for loop over while or do-while.

The for (i = 0; i < N; i++) is such a strong paradigm in C. You
instantly know how many times you're going to loop, at a glance. Not so
with with the alternatives, which should be used sparingly.

And yes, the do-while suggested above is buggy, and you actually need to
stop and think to see why.


BR,
Jani.



>
> Best regards
> Thomas
>
>> 
>>> In any case, I just pulled the line conversion logic as a separate
>>> function with minimal code changes since doing that should be in a
>>> separate patch.
>> 
>> 
>>> Feel free to post a patch if you want to change that while loop.
>> 
>> Perhaps some day :-)
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
