Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71473537884
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiE3Jdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiE3Jd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:33:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DE6FA3C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653903207; x=1685439207;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TBSc0KNGpzSlLLY6lieGvmYQxKAskO2xitesyVYh6/0=;
  b=QGZ3+P4Ij6XGFmwq+TB8htG172nwvfQGwrQ9m5x7LPU440WMg01Sw9qp
   Jjgx6wxwieI97E3ZtXUCsfHb8ljrHr7eDIvi4Oyk1lRR4tNIDyyn4yJap
   9XOVuvvqstwImuoV0HdVXGHV0AGIfUEI6kncd0VEHgA+tvUlqlfmXpJCg
   3gObW55TuTCNqM/eXThw+cBDR5DsVYftfjY65MLmeI+oIhhmgSewBhYCR
   ylCZpkuvLXRToZ9fGVXdweTfxXEqzH8QrCnmNmS2l/h22qpBcSBwRt3Wa
   nZ8hL/6wR+b4Y+XpXLpuKm4S1ACjBtwweKE7v8R99+orTn1bihxMrbtdK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="275040850"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="275040850"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 02:33:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="529103807"
Received: from jkuna-mobl.ger.corp.intel.com (HELO localhost) ([10.249.150.228])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 02:33:20 -0700
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
In-Reply-To: <87a6aztli2.fsf@intel.com>
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
 <87a6aztli2.fsf@intel.com>
Date:   Mon, 30 May 2022 12:33:17 +0300
Message-ID: <877d63tleq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Jani Nikula <jani.nikula@intel.com> wrote:
> On Sat, 28 May 2022, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Sat, May 28, 2022 at 11:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> It's CONFIG_ARM_AEABI, which is normally set everywhere. Without this
>>> option, you the kernel is built for the old 'OABI' that forces all non-packed
>>> struct members to be at least 16-bit aligned.
>>
>> Looks like forced word (32 bit) alignment to me.
>>
>> I wonder how many other structures that messes up, but I committed the
>> EDID fix for now.
>
> Thanks for the fix, and the thorough commit message!
>
>> This has presumably been broken for a long time, but maybe the
>> affected targets don't typically use EDID and kernel modesetting, and
>> only use some fixed display setup instead.
>>
>> Those structure definitions go back a _loong_ time (from a quick 'git
>> blame' I see November 2008).
>>
>> But despite that, I did not mark my fix 'cc:stable' because I don't
>> know if any of those machines affected by this bad arm ABI issue could
>> possibly care.
>>
>> At least my tree hopefully now builds on them, with the BUILD_BUG_ON()
>> that uncovered this.
>
> Indeed the bug is ancient. I just threw in the BUILD_BUG_ON() on a whim
> as an extra sanity check when doing pointer arithmetics on struct edid
> *.
>
> If there are affected machines, buffer overflows are the real danger due
> to edid->extensions indicating the number of extensions.

That is, for EDID. Makes you wonder about all the other packed structs
with enum members across the kernel.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
