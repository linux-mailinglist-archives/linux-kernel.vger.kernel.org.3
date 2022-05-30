Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB090537B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiE3NKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiE3NKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:10:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2517092B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653916240; x=1685452240;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yR4CvAYEHnhJy9L0L3rshOUShjBlml110o6x0DwIo1A=;
  b=LXT3rX902qcHmZS8ShzsCqkwy/X062sfDvAymc0pO/U5FbLjkrLRSxnx
   g8OirrZFgLrMFqZrD1X13yAeqj9k7cy4abRWWUHJGafXLLrXnWBk4OqAc
   AKxyvcU7gmMxPWxCWmJR16/xEynb15OhRNDLct2HjpbC/5ccfxeVTYsC7
   uTlKJUDzoB5sKUubOYgHOnWUZGlr+OCZTGWAHOVHLg92gBZdoFQpgFgl/
   sv8I5qwu7GMwIlCxyNBge+JgfbacDqDaOpZ9vMYtxto2U51PcxDwvHmX6
   kALBll5/2GAAoDUtcn+WqntzuOfoOA7CAJSqza8B8p22GL5Ho2oH5NHVL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="274998691"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="274998691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:10:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="605183061"
Received: from jkuna-mobl.ger.corp.intel.com (HELO localhost) ([10.249.150.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:10:10 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
In-Reply-To: <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <YpCUzStDnSgQLNFN@debian>
 <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian>
 <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
 <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
 <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
 <87a6aztli2.fsf@intel.com> <877d63tleq.fsf@intel.com>
 <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
Date:   Mon, 30 May 2022 16:10:08 +0300
Message-ID: <87czfvrwsv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 30, 2022 at 11:33 AM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> That is, for EDID. Makes you wonder about all the other packed structs
>> with enum members across the kernel.
>
> It is not the 'enum' that is special here, it's the 'union' having
> unpacked members,

Obviously meant union not enum, that was just a -ENOCOFFEE on my part.

> and the same thing happens when you have nested structs: both the inner
> and the outer aggregate need to be packed, either with __packed at the
> end, or on each individual member that is not fully aligned to
> max(sizeof(member), 4)).
>
> I think in general, most __packed annotations we have in the kernel are
> completely pointless because they do not change the structure layout on
> any architecture but instead just make member access slower on

Please explain.

They are used quite a bit for parsing blob data, or
serialization/deserialization, like in the EDID case at hand. Try
removing __attribute__((packed)) from include/drm/drm_edid.h and see the
sizeof(struct edid) on any architecture.

BR,
Jani.

> architectures that lack unaligned load/store instructions. There have
> definitely been other cases though where a __packed annotation is
> not needed on any sane architecture but is needed for OABI ARM.
>
> Overall I'm not that worried because the only machines running OABI
> kernels would be on really old hardware that runs a limited set of
> driver code.
>
> A completely different matter are the extraneous __packed annotations
> that lead to possible problems when accessed through a misaligned
> pointer. We ignore -Waddress-of-packed-member and -Wcast-align
> in the kernel, so these never get caught at build time, but we have
> seen bugs from gcc making incorrect assumptions about alignment
> even on architectures that have unaligned load/store instructions.
>
>       Arnd

-- 
Jani Nikula, Intel Open Source Graphics Center
