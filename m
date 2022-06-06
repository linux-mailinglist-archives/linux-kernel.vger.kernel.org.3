Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404ED53EC26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiFFPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiFFPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:10:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C4D135691
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:10:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBAABD6E;
        Mon,  6 Jun 2022 08:10:54 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407A13F73B;
        Mon,  6 Jun 2022 08:10:52 -0700 (PDT)
Date:   Mon, 6 Jun 2022 16:10:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liang Chen <cl@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on
 protocol list
Message-ID: <20220606151004.hevt4zh6boypdd4x@bogus>
References: <20220523171559.472112-1-cristian.marussi@arm.com>
 <Yp4Br5d0jMnlF5yy@e120937-lin>
 <20220606144305.agzzyf7c4kp2nwlw@bogus>
 <4402272.LvFx2qVVIh@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4402272.LvFx2qVVIh@diego>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:55:10PM +0200, Heiko Stübner wrote:
> Am Montag, 6. Juni 2022, 16:43:05 CEST schrieb Sudeep Holla:
> > On Mon, Jun 06, 2022 at 02:31:48PM +0100, Cristian Marussi wrote:
> > > On Mon, Jun 06, 2022 at 02:59:10PM +0200, Michael Riesch wrote:
> > > > Hi Cristian,
> > > >
> > > Hi Michael,
> > >
> > > > On 5/23/22 19:15, Cristian Marussi wrote:
> > > > > Even though malformed replies from firmware must be treated carefully to
> > > > > avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> > > > > be tolerated to avoid breaking existing deployed system, as long as they
> > > > > won't cause memory issues.
> > > > >
> > > > > Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > >
> > > > Thanks a lot, without this fix the Mali G52 GPU won't probe on my RK3568
> > > > EVB1 in vanilla v5.19-rc1.
> > > >
> > >
> > > Yes, the break was reported on -next and today it appeared in 5.19-rc1.
> > > A proper FW fix is also up for review by Etienne but in the meantime
> > > this tries to limit damages relaxing a bit the checks.
> > >
> > > > I guess this patch should have a Fixes: tag, right?
> > > >
> > >
> > > It has not a Fixes tag because the issue was introduced in 5.19-rc1 and the
> > > fix will go in with the next round of v5.19 fixes by Sudeep (AFAIU) so it
> > > will be solved within the v5.19 cycle and I thought the Fixes tag was
> > > not needed in this case (I could be wrong...)
> > 
> > Correct, if for some reason, we can't push this before v5.19, then fixes
> > tag needs to added. I will add that then, but for now let us target getting
> > it in before v5.19
> 
> hmm, I'd disagree for the generalization.
> 
> While true that is not 100% necessary to be present in all cases, so
> definitly no reason for a new version when applied to the same -rc series,
> having the Fixes tag not only clearly marks the patch as such, but also
> allows people reading either mailing lists or the later the git history
> to actually see where the issue started. So I really think it is a
> nice-to-have in most cases.

Absolutely agreed in general. But I asked Cristian to not add as we are work
around the firmware bug by relaxing the checks in the kernel. This is not
fixing anything in the original commit IMO, it is just that the original
commit highlighted the firmware issue on that system.

-- 
Regards,
Sudeep
