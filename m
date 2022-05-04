Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5151A0D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350486AbiEDN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350567AbiEDN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:26:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 434AD4505A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:21:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141F21042;
        Wed,  4 May 2022 06:21:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5FA33FA49;
        Wed,  4 May 2022 06:21:32 -0700 (PDT)
Date:   Wed, 4 May 2022 14:21:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to
 boot due to firmware bug
Message-ID: <20220504132130.wmmmge6qjc675jw6@bogus>
References: <1698297.NAKyZzlH2u@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698297.NAKyZzlH2u@archbook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cristian

Hi Nicolas,

Thanks for the formal report.

On Wed, May 04, 2022 at 02:49:07PM +0200, Nicolas Frattaroli wrote:
> Good day,
> 
> a user on the #linux-rockchip channel on the Libera.chat IRC network
> reported that their RK3568 was no longer getting a CPU and GPU clock
> from scmi and consequently not booting when using linux-next. This
> was bisected down to the following commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/firmware/arm_scmi/base.c?h=next-20220503&id=3b0041f6e10e5bdbb646d98172be43e88734ed62
> 
> The error message in the log is as follows:
> 
> arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz:4, t->rx.len is 12, sizeof(u32) is 4, loop_num_ret is 3
> 
> The rockchip firmware (bl31) being used was v1.32, from here:
> 
> https://github.com/JeffyCN/rockchip_mirrors/blob/rkbin/bin/rk35/rk3568_bl31_v1.32.elf
>

So this platform is not supported in upstream TF-A like its predecessors ?

> This seems like a non-fatal firmware bug, for which a kernel workaround is
> certainly possible, but it would be good if rockchip could fix this in their
> firmware.
>

Indeed, we added this check finding issue in one of our tests. Luckily
it helped to unearth the same issue on this platform, but due to the
nature of its f/w release, it is bit unfortunate that it can't be fixed
easily and quickly. But I really wish this gets fixed in the firmware.
Are there any other f/w bugs reported so far ? If so how are they fixed
as I don't expect all such bugs can be worked around in the kernel though
this might be. I would like to hear details there if possible.

> The user going by "amazingfate" reported that commenting out the
>   ret = -EPROTO; break;
> fixes the issue for them.
>

Sure, or we could relax the check as calc_sz <= real_sz or something so
that the reverse is still caught and handled as OS might read junk data in
the later case.

> I'm writing here to get the discussion started on how we can resolve this
> before the Linux 5.19 release.
>

Agreed, I just sent by pull request for this literally few hours ago.

> Sudeep Holla has already told me they'll gladly add a workaround before
> the 5.19 release, but would rather see this fixed in the vendor firmware
> first. Would rockchip be able and willing to fix it and publish a new
> bl31 for rk3568?
>

Indeed and as mentioned above details on how other such f/w bugs are dealt
in general esp that the firmware is blob release and one can't fix it easily.
Do we have a bugzilla kind of setup to report and get the bugs fixed ?

-- 
Regards,
Sudeep
