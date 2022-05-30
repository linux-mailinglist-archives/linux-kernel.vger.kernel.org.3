Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29160537897
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiE3Jb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiE3Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:31:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032A6CAB1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653903086; x=1685439086;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RNo1VFn9TNhcSAwdGqSc/kbrNGzlnlE99QCowyLqR4c=;
  b=QdzTZAuWxkmY5K5sRLkwYkYQyUGYKwdw1FeqZL61F4y0z+n4iUE1Vdny
   Wv6S/nHg7FAstK1OthiSUzBQRDQp1/QiDxTX1OJWVhD3jUQpYQrY240yb
   mPREj2jEJYJwC0vujhKFkvPhgY1NWzi4sgcoPxO4cW1LjXbiaIGS4bSJn
   BusZOOH21ABLDJPIQcHcs4bRCh708KB9ySwXLpeujwlnCoMo5RYrmPtlB
   pu9GjLSC82cgmADg6gAkYIYe76pEi/g8w0hps53omrH+4YICgHkgj+8A7
   UOH7PypfYUvg9br8yC32tLQBdyRps7Lg14rJkGwfJkXiOp4U4Xs1Gfo11
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="255438074"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="255438074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 02:31:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="706083847"
Received: from jkuna-mobl.ger.corp.intel.com (HELO localhost) ([10.249.150.228])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 02:31:20 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
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
In-Reply-To: <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
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
Date:   Mon, 30 May 2022 12:31:17 +0300
Message-ID: <87a6aztli2.fsf@intel.com>
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

On Sat, 28 May 2022, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, May 28, 2022 at 11:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> It's CONFIG_ARM_AEABI, which is normally set everywhere. Without this
>> option, you the kernel is built for the old 'OABI' that forces all non-packed
>> struct members to be at least 16-bit aligned.
>
> Looks like forced word (32 bit) alignment to me.
>
> I wonder how many other structures that messes up, but I committed the
> EDID fix for now.

Thanks for the fix, and the thorough commit message!

> This has presumably been broken for a long time, but maybe the
> affected targets don't typically use EDID and kernel modesetting, and
> only use some fixed display setup instead.
>
> Those structure definitions go back a _loong_ time (from a quick 'git
> blame' I see November 2008).
>
> But despite that, I did not mark my fix 'cc:stable' because I don't
> know if any of those machines affected by this bad arm ABI issue could
> possibly care.
>
> At least my tree hopefully now builds on them, with the BUILD_BUG_ON()
> that uncovered this.

Indeed the bug is ancient. I just threw in the BUILD_BUG_ON() on a whim
as an extra sanity check when doing pointer arithmetics on struct edid
*.

If there are affected machines, buffer overflows are the real danger due
to edid->extensions indicating the number of extensions.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
