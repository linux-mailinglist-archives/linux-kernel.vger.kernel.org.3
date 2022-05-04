Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8A51ACA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbiEDS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377152AbiEDSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:25:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A54CD69
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:51:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k27so2557287edk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6OQETHjxsNPeiQwlJ9nRZ0Zhe1S3npqCHoNCu8Hhwc=;
        b=GuABBy4VBrNuYj0GTLVz/YET1IoX938bnOFRsEwutc/h7zSzR4dRfAO8DubT+Ycc7Q
         rgRvClsWH2sRR8KX1Gwf5zL13W5RB/j1SXnCeb8jMywk2ivpZMfUxUUVFnf1JL6onVZx
         QCrLPkTIRIpnTUl5XJomzEGsDth7d8nnnty+4ctCa7GAZ1aKdM4/aiad/5MareclwqAT
         OZSRqcnYlqKfObymPQlEIMNpud145TBInDS+uQBK4MRep0DOOLPks5PpKMdvN8+ufPkL
         1u+Bgxbsr4eDXZU8yv3hauZpSNYtEeZpljR0Y7KmMEEsylm5MG+3N0U9A/lHyz/nXYdP
         VwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6OQETHjxsNPeiQwlJ9nRZ0Zhe1S3npqCHoNCu8Hhwc=;
        b=vHjVRQVJjZjALO+pk0dKVeTN4+KLZAI50tNgRRhqC7Yx/m5qNQU9O0365/IXrQV7x1
         NIL7EKpxR3eazsN095gtX67V3NcgvyZZPIHz86UlQ2LfeltEhCIlifhRYE7GcxwN08eE
         stLa00oCon4mEKw729u8LBWpsNA5XG6eIHVl2vP3UCnLghKLRob+hyTGs6oycuEdRFuz
         YKvGBCefV36hfZWF7LdsVbNrQjN7uI3GT58fq8NO+3c/STmiy6bAU+NtWWWX70eBOhaF
         ZbvfKn02jFwv8wHK2K3jMP76eEHdeMs44pZ/4EUHgPPU2LyWg1zI8VWGe0vUr5tWIbEJ
         BXsw==
X-Gm-Message-State: AOAM530G1V50SLsLNIMAI7EEmk8X+tasR0EkY8NlSq2bxwUxRXa9CwS2
        nPd0aei6peBjLei6Lpqg1JU=
X-Google-Smtp-Source: ABdhPJz0hb6SOgdPZdyzU9O0kQKQPCTbTz0FGLWDIVrCS5K5zZNt1y5LFDTv1pG707NEZlnJ2W5OEA==
X-Received: by 2002:aa7:d393:0:b0:425:a8f8:663a with SMTP id x19-20020aa7d393000000b00425a8f8663amr24212615edq.323.1651686707464;
        Wed, 04 May 2022 10:51:47 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006f3ef214e0esm5914003ejc.116.2022.05.04.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:51:46 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to boot due to firmware bug
Date:   Wed, 04 May 2022 19:51:45 +0200
Message-ID: <3764923.NsmnsBrXv5@archbook>
In-Reply-To: <20220504132130.wmmmge6qjc675jw6@bogus>
References: <1698297.NAKyZzlH2u@archbook> <20220504132130.wmmmge6qjc675jw6@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 4. Mai 2022 15:21:30 CEST Sudeep Holla wrote:
> + Cristian
> 
> Hi Nicolas,
> 
> Thanks for the formal report.
> 
> On Wed, May 04, 2022 at 02:49:07PM +0200, Nicolas Frattaroli wrote:
> > Good day,
> > 
> > a user on the #linux-rockchip channel on the Libera.chat IRC network
> > reported that their RK3568 was no longer getting a CPU and GPU clock
> > from scmi and consequently not booting when using linux-next. This
> > was bisected down to the following commit:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/firmware/arm_scmi/base.c?h=next-20220503&id=3b0041f6e10e5bdbb646d98172be43e88734ed62
> > 
> > The error message in the log is as follows:
> > 
> > arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz:4, t->rx.len is 12, sizeof(u32) is 4, loop_num_ret is 3
> > 
> > The rockchip firmware (bl31) being used was v1.32, from here:
> > 
> > https://github.com/JeffyCN/rockchip_mirrors/blob/rkbin/bin/rk35/rk3568_bl31_v1.32.elf
> >
> 
> So this platform is not supported in upstream TF-A like its predecessors ?

Hello,

it is not yet supported by upstream. Rockchip plans to release the sources
for it at some point if I recall correctly, but I believe their software
team has been very busy due to new hardware releases, so it hasn't happened
yet. I hope we'll see an open source release of the TF-A sources eventually,
so that for bugs like this we can always fix them without the vendor needing
to do it for us.

> 
> > This seems like a non-fatal firmware bug, for which a kernel workaround is
> > certainly possible, but it would be good if rockchip could fix this in their
> > firmware.
> >
> 
> Indeed, we added this check finding issue in one of our tests. Luckily
> it helped to unearth the same issue on this platform, but due to the
> nature of its f/w release, it is bit unfortunate that it can't be fixed
> easily and quickly. But I really wish this gets fixed in the firmware.
> Are there any other f/w bugs reported so far ? If so how are they fixed
> as I don't expect all such bugs can be worked around in the kernel though
> this might be. I would like to hear details there if possible.

I'm not aware of how the rockchip bug report workflow works. They seemingly
did update the firmware multiple times, last in October of 2021.

The official rockchip repository at [1] hasn't been kept as up to date as
the mirror by a rockchip employee at [2], so most people seem to have been
using the latter. Speaking of which, I'll add the owner of that repo to 
the CC of this thread to make sure this doesn't get lost.

Rockchip lists an e-mail at [3] for reporting issues at, but this seems to
relate to their open-source documentation. The official github repository
of "rkbin" on the "rockchip-linux" organisation does not have issues
enabled, so submitting a bug report through that is unfortunately not
possible.

> 
> > The user going by "amazingfate" reported that commenting out the
> >   ret = -EPROTO; break;
> > fixes the issue for them.
> >
> 
> Sure, or we could relax the check as calc_sz <= real_sz or something so
> that the reverse is still caught and handled as OS might read junk data in
> the later case.

This seems like a good solution, that way we're unlikely to ever run into a
situation where the kernel does the wrong thing here even if we're less
strict about the check. In either case, it should print a dev_err though,
it's still an error even if we can tolerate it in some cases.

> 
> > I'm writing here to get the discussion started on how we can resolve this
> > before the Linux 5.19 release.
> >
> 
> Agreed, I just sent by pull request for this literally few hours ago.
> 
> > Sudeep Holla has already told me they'll gladly add a workaround before
> > the 5.19 release, but would rather see this fixed in the vendor firmware
> > first. Would rockchip be able and willing to fix it and publish a new
> > bl31 for rk3568?
> >
> 
> Indeed and as mentioned above details on how other such f/w bugs are dealt
> in general esp that the firmware is blob release and one can't fix it easily.
> Do we have a bugzilla kind of setup to report and get the bugs fixed ?

It's worth mentioning that I think even if we get Rockchip to fix the bug in
the firmware, I believe Linux should still add a workaround, as otherwise
people running older firmware who are upgrading their kernels could suddenly
have unbootable systems and don't know why that happened.

Regards,
Nicolas Frattaroli

PS: I've also CC'd Peter Geis as he has worked on the RK356x support in
    mainline a bunch and I believe he has been in contact with Rockchip
    about releasing the TF-A sources before.

[1]: https://github.com/rockchip-linux/rkbin
[2]: https://github.com/JeffyCN/rockchip_mirrors/tree/rkbin
[3]: http://opensource.rock-chips.com/wiki_Main_Page



