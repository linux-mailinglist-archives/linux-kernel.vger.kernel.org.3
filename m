Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D35598179
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiHRKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:31:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F878231
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660818686; x=1692354686;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=t8Rq1gQAoemnCUCEVfnVYlyYdtJjUbQsitsuxWe88dw=;
  b=EpnfCuDD3fdJHqd6G+M2hyTs1ud1XK2lajFfruZ4ytRFCjtu41mDi/fa
   wQJ2tMX1s3Wjz079q/ukzfOAn3GSnO1j0MO3pBzP49fFTvEITFWPpSM7y
   ZiauBp9GWXKlf7WrkBkgp8aiirD3OGi9YVZBMC2BU9YgzUw11AVaS0AhD
   25SMPExXNkB2xKVJs+to8SgDMBStz6hFcKPPNyx4X2UATpuVYTBM6zkLS
   LiRz5shqGzj77q0fSOlMtIZkPS1DXaBI4Oh4XZbxlBrQYyyk39ev2rK4t
   vA7Yq+cfsmBvepNarWf6dhpW9r5oRWR087Q4DXyCZy09iQcmBseqhyf0F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279690785"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="279690785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:31:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668048685"
Received: from mwiniars-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.40.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:31:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [RFC PATCH] drm/edid: Make 144 Hz not preferred on Sharp
 LQ140M1JW46
In-Reply-To: <CAD=FV=W9sK2dKMnDZmW_ipLGZJFrrvNHz6zHsXVaSCD_u4JpiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220721152314.RFC.1.Ie333b3e4aff6e4a5b58c4aa805e030e561be8773@changeid>
 <269f2610-425b-f296-dcfc-89bdc2e1d587@quicinc.com>
 <CAD=FV=XSVXasU5PMR2kL0WQjQ458xDePuTGd1m14_v9JO5B6oA@mail.gmail.com>
 <CAF6AEGv_Vikf80v-7ccz90fvGPrk5pV1tOxRoWKxKHYuEW8=aA@mail.gmail.com>
 <5c8ca71c-5f0b-d5f5-9f16-e312dec0d01b@quicinc.com>
 <CAD=FV=UGYV1mZenDCRrbpC+gpE12-Uis7fm_=H3PeEjK=t36yA@mail.gmail.com>
 <20220729075118.ofnpk52tk4usm3n3@penduick>
 <CAD=FV=WUB68-DQ-pAFjGaG-kid33ve4Qc3iqb8OUh61xTBohmg@mail.gmail.com>
 <20220729164136.opucqg64qz4ypmvo@penduick>
 <CAD=FV=UKYksHjuVR27DPdUFFtJrQKB2KbT08qjeYLNW_3y_Mfg@mail.gmail.com>
 <20220815064543.g7loqfb6rtwkookl@houat>
 <CAD=FV=W9sK2dKMnDZmW_ipLGZJFrrvNHz6zHsXVaSCD_u4JpiA@mail.gmail.com>
Date:   Thu, 18 Aug 2022 13:31:21 +0300
Message-ID: <8735dtq1vq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Sun, Aug 14, 2022 at 11:46 PM Maxime Ripard <maxime@cerno.tech> wrote:
>>
>> On Fri, Jul 29, 2022 at 12:57:40PM -0700, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Fri, Jul 29, 2022 at 9:41 AM Maxime Ripard <maxime@cerno.tech> wrote:
>> > > You raise some good points, but most of the discussion around that patch
>> > > were mostly around performances, power consumption and so on.
>> > >
>> > > This is very much a policy decision, and if there is some panel where
>> > > the EDID reports 60Hz but is broken, then that panel should be the
>> > > exception to the policy
>> > >
>> > > But doing it for a single panel is just odd
>> >
>> > OK, fair enough. I'll abandon this patch at least as far as mainline
>> > is concerned, then.
>>
>> That wasn't really my point though :)
>>
>> If you think that this change is needed, then we should totally discuss
>> it and I'm not opposed to it.
>>
>> What I don't really like about this patch is that it's about a single
>> panel: if we're doing it we should do it for all the panels.
>>
>> Where we do it can also be discussed, but we should remain consistent
>> there.
>
> I was never massively confident about it, which is why I added the
> "RFC" tag to begin with. ;-) In general I suspect that either change
> will make people upset. In other words, if we programmatically always
> try to put the "high refresh rate" first for all displays then people
> will be upset and if we programmatically always try to put the "60 Hz
> rate" first then people will be upset. Unless someone wants to stand
> up and say that one side or the other is wrong, I think we're going to
> simply leave this up to the whim of individual panels. Someone could
> stand up and demand that it go one way or the other, but I certainly
> don't have that clout.
>
> The spec, as far as I can tell, says that it's up to the panel vendor
> to use whatever means they want to decide on the "preferred" refresh
> rate. Thus, as far as the spec is concerned this decision is made on
> an individual panel basis. ;-) This was really the justification for
> why my patch was just on one panel.
>
> In any case, as I said I'm OK w/ dropping this. We'll find other ways
> to work around the issue.

FWIW, if the EDID reported preferred mode works, I also think that's
what we should prefer.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
