Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B1589B39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiHDLvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:51:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941231BE8A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659613882; x=1691149882;
  h=from:to:cc:subject:in-reply-to:date:message-id:
   mime-version;
  bh=QndqyrQ9/ZziXeK504joH7ZNUhFvFx3RBDing9P1MtI=;
  b=mJmS6A6ExDgx26Hd5gKxiuiyrHe8notrmAf0SqyoC7NS8BXZkWgzf6v6
   WudGz3r6iJEkizJ1nXgIcHAG1bAnBLV92QtEziAEqNx5rnKcUGbmpRhRE
   OgLy/YjCYtnORrixggIYB0H5+p2quOIpsJySAY/rSyF+d1VefZmHed/7X
   S5Q0yAtqUVu669hXIzRwDB/8x5HwXtlZm+plEyxpe4TKCsUMxug2I7AbF
   /u0ozj8RRZ9SIOzh5lMqJxEjdnzxZWEcr5m7qN/Tx4e+1dCrfCFf3cuRR
   VXPECwDLNaMA9GgIw/TcUi7rM1k1xqy3O4XyqsXj3tYKG9ynBcsGnjqFR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="276831448"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="276831448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 04:51:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="631553070"
Received: from wujunyox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 04:51:18 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Ville =?utf-8?B?U3lyasOk?= =?utf-8?B?bMOk?= 
        <ville.syrjala@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>,
        LinusW <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] drm/panel-edp: Allow overriding the eDP EDID
In-Reply-To: <CAD=FV=VUWouY58oX+6iBThz_PiDe1_zrs7Ls4gBKER8bo_Y8QQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date:   Thu, 04 Aug 2022 14:51:15 +0300
Message-ID: <87tu6sns5o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Jul 21, 2022 at 4:36 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Thu, 21 Jul 2022 at 01:55, Douglas Anderson <dianders@chromium.org> wrote:
>> >
>> > I found that writing to `/sys/kernel/debug/dri/*/eDP*/edid_override`
>> > wasn't working for me. I could see the new EDID take effect in
>> > `/sys/class/drm/card*-eDP*/edid` but userspace wasn't seeing it..
>> >
>> > The problem was that panel-edp was caching the EDID that it read and
>> > using that over and over again.
>> >
>> > Let's change panel-edp to look at the EDID that's stored in the
>> > connector. This is still a cache, which is important since this
>> > function is called multiple times and readin the EDID is slow, but
>> > this property is automatically updated by drm_get_edid() (which reads
>> > the EDID) and also updated when writing the edid_override in debugfs.
>> >
>> > Fixes: 63358e24ee79 ("drm/panel: panel-simple: Cache the EDID as long as we retain power")
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>
>> A different proposal for you to consider:
>> Change drm_get_edid/drm_do_get_edid to return int rather than struct
>> edid, while caching the EDID in the connector. Or maybe add a new API
>> drm_read_edid() and make drm_get_edid() deprecated in favour of it.
>> The goal should be to let all drivers use connector-cached EDID rather
>> than getting  the EDID, parsing it and kfree()ing it immediately
>> afterwards.
>
> I think the majority of drivers don't actually want the cached EDID
> behavior so the edp-panel case is actually pretty rare. For everyone
> else I think DRM is handling things in a pretty reasonable way.
> Looking closely, it looks like there have been a bunch of patches
> landed in this area recently and so I assume people are happy enough
> with the current design for the majority of cases.
>
> I guess your point though, is that the way I'm using the API right now
> in ${SUBJECT} patch is a bit gross and maybe the DRM core needs a
> helper of some sort for this case? Essentially what we're saying is
> that we have inside knowledge this is a built-in panel and thus the
> EDID will never change and it's a waste of time to read it again and
> again. We could somehow tell the DRM core that.
>
> I guess I could add a function like drm_edid_read_if_needed(). That
> would essentially use the existing blob if it was there and read it
> otherwise. Does that work? Basically:
>
> def drm_edid_read_if_needed(...):
>   if (connector->edid_blob_ptr)
>     return dupe_edid(connector->edid_blob_ptr);
>   return drm_edid_read(...);
>
> I guess maybe we'd want a _ddc variant too.
>
> Adding Jani since the recent patches I see touching this were his and
> there are even comments there about what to do about drivers that want
> to cache the EDID.
>
>
>> Most probably we should be able to move
>> drm_connector_update_edid_property() into drm_do_get_edid() and drop
>> it from the rest of the code. This might require additional thought
>> about locking, to ensure that nobody pulls the cached edid out from
>> under our feet.
>
> This all looks like it's moving now, actually. Looking around at
> recent changes, I see that now the property gets updated in a
> different call.
>
> Old (deprecated)
> 1. drm_get_edid() <-- Updates the EDID property
> 2. drm_add_edid_modes()
>
> New:
> 1. drm_edid_read()
> 2. drm_edid_connector_update() <-- Updates the EDID property
>
>
>  > Extra "bonus" points to consider:
>> - Maybe it's time to add get_edid() to the drm_panel interface, teach
>> panel_bridge about it and let drm_bridge_connector handle all the
>> details?
>>
>> So, while this looks like a longer path, I think it's worth checking
>> that we can refactor this piece of code.
>
> It's certainly interesting to consider. At the moment, though, it
> doesn't look super easy to do. Points to note:
>
> 1. We don't necessarily want to cache the EDID for all display types.
> For builtin panels it makes sense to do so, but it's less obvious for
> external displays. _In theory_ we could try to cache the EDID for
> external devices if we're really certain that we'll notice when
> they're unplugged / re-plugged again but I'm not convinced that all
> drivers always handle this. In any case, I tend to assume that when
> we're dealing with external displays we're a little less interested in
> trying to optimize all of the milliseconds away. If nothing else there
> are hundreds of milliseconds of hotplug detect debounce happening for
> external displays. Yes, we could have a rule about only caching the
> EDID only for eDP displays but then the motivation of moving it out of
> edp-panel and to drm_bridge_connector is a lot less.
>
> 2. At the moment, drm_bridge_connector only calls get_modes() if it
> doesn't have get_edid() implemented. At the moment the panel-edp code
> actually _combines_ the EDID and any hardcoded modes that were
> specified. I think we'd have to resolve this difference if we do what
> you suggest. The panel-edp behavior comes from before the split out of
> panel-simple and dates from 2013 when panel-simple was first added.
> Certainly we could arbitrarily change one behavior or the other but I
> don't know what the fallout would be.
>
> 3. We still don't have universal conversion to panel_bridge and
> drm_bridge_connector. Some drivers are still calling the panel
> functions directly. Until everything is converted it will be extra
> cruft / scaffolding to make this change without breaking those calling
> the panel directly. I don't think there's enough of a hurry to do this
> that it's worth the extra cruft. There just aren't that many built-in
> panels that read an EDID that aren't handled by the generic panel-edp.

First and foremost, please don't use connector->edid_blob_ptr for
anything outside of drm_edid.c. At least not directly. It all needs to
be completely hidden and abstracted away. Existing users need to be
dropped. Ditto for all EDID parsing, really.

The blob does actually have the data size, but most users don't look at
that, and instead assume the size indicated by EDID base block extension
count field matches the blob size.

As to caching, I've looked at it before and I think it's best left for
drivers. It's possible to cache more than just eDP, and the cache
invalidation time varies. We do just that in i915.

That said, I guess (purely by reading the code) we do have the same eDP
EDID caching problem with edid_override in i915 as you describe here. We
also have a connector init time fallback for EDID from ACPI OpRegion,
and that would never get restored if thrown away. Ugh.

I'm thinking of a number of alternatives for the fix, but I'd like to
distill them further before sharing.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
