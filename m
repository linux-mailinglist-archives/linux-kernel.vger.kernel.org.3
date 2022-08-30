Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F85A64E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiH3Ngw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiH3Ngr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:36:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD194E39B6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661866599; x=1693402599;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O9CgTkDBOczWNsw6xgnL7AlVgHCVygWfHTMUKa/QgD8=;
  b=d8YuDrvsUXU2NT992PGZ3eotpCrktdhojJf8pVMRj+fcwKWLbe0GZZtm
   jIBdjYv2oBkMDZIFCGt0iwkkk+w3bWFoJQMIJbJcuzWe+hJ2ghHT98L4i
   OMusSZaWd7GqULYvF89gQeXFn4tQxEDnoT1jX4trc5g8wxt9atYHYqTpw
   6F4yJsF+gDuDjh7aPBm2xnpL6W2GHTa+xsIr4QOmKae71qY0PTx6HzO56
   QmD6PPInon52r0u7HIqpLW0eLTI54DM2sDmukr+j+/wrnWS/qNSAgIYBx
   uTnL1+dOqEX7tnhE1iHeTHce9nEtcN5FjQRoHFnYqerJvY/6Uv8pJFc2O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="359136439"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="359136439"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:36:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672867819"
Received: from amrabet-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:36:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Subject: Re: [PATCH v2 14/41] drm/modes: Move named modes parsing to a
 separate function
In-Reply-To: <20220830120330.6f5f22d35gu7cbr3@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-14-459522d653a7@cerno.tech>
 <CAMuHMdV9wVgHFfwHoqtBoYzJDnjDmKTfaZkAKvTVKh1Y-2x1pA@mail.gmail.com>
 <87czcidnb8.fsf@intel.com> <20220830120330.6f5f22d35gu7cbr3@houat>
Date:   Tue, 30 Aug 2022 16:36:23 +0300
Message-ID: <875yi9etuw.fsf@intel.com>
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

On Tue, 30 Aug 2022, Maxime Ripard <maxime@cerno.tech> wrote:
> Hi,
>
> On Tue, Aug 30, 2022 at 01:43:07PM +0300, Jani Nikula wrote:
>> On Tue, 30 Aug 2022, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Mon, Aug 29, 2022 at 3:13 PM Maxime Ripard <maxime@cerno.tech> wrote:
>> >> +#define STR_STRICT_EQ(str, len, cmp) \
>> >> +       ((strlen(cmp) == len) && !strncmp(str, cmp, len))
>> >
>> > This is not part of the move, but newly added.
>> 
>> The same construct is also duplicated elsewhere in the series, and I
>> kept being confused by it.
>
> I'm not sure what is confusing, but I can add a comment if needed.

STR_STRICT_EQ() is what's confusing. I have to look at the
implementation to understand what it means. What does "strict" string
equality mean?

>
>> The above is precisely the same as:
>> 
>> 	str_has_prefix(str, cmp) == len
>
> Here, it's used to make sure we don't have a named mode starting with
> either e, d, or D.
>
> If I understood str_has_prefix() right, str_has_prefix("DUMB-MODE", "D")
> == strlen("DUMB-MODE") would return true, while it's actually what we
> want to avoid.

That's not true, str_has_prefix("DUMB-MODE", "D") == strlen("D") is.

> It's also used indeed in drm_get_tv_mode_from_name(), where we try to
> match a list of names with one passed as argument.
>
> With drm_get_tv_mode_from_name("NSTC", strlen("NTSC")), we would end up
> calling str_has_prefix("NTSC-J", "NTSC") == strlen("NTSC-J") which would
> work. However, we end up calling prefix not a prefix, but an entire
> string we want to match against, which is very confusing to me too.

If I get this right, you have a string and you want to check if that has
a certain prefix. Additionally, you want to check the prefix is a
certain length.

Sure, that the prefix is a certain length is more of a property of the
string, which is NUL terminated later than at length, but that's doesn't
really matter.

That condition is simply str_has_prefix(string, prefix) == length.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
