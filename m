Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18153E631
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiFFOzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbiFFOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:55:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC902914F2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:55:16 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nyE8N-0007Ur-G7; Mon, 06 Jun 2022 16:55:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on protocol list
Date:   Mon, 06 Jun 2022 16:55:10 +0200
Message-ID: <4402272.LvFx2qVVIh@diego>
In-Reply-To: <20220606144305.agzzyf7c4kp2nwlw@bogus>
References: <20220523171559.472112-1-cristian.marussi@arm.com> <Yp4Br5d0jMnlF5yy@e120937-lin> <20220606144305.agzzyf7c4kp2nwlw@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. Juni 2022, 16:43:05 CEST schrieb Sudeep Holla:
> On Mon, Jun 06, 2022 at 02:31:48PM +0100, Cristian Marussi wrote:
> > On Mon, Jun 06, 2022 at 02:59:10PM +0200, Michael Riesch wrote:
> > > Hi Cristian,
> > >
> > Hi Michael,
> >
> > > On 5/23/22 19:15, Cristian Marussi wrote:
> > > > Even though malformed replies from firmware must be treated carefully to
> > > > avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> > > > be tolerated to avoid breaking existing deployed system, as long as they
> > > > won't cause memory issues.
> > > >
> > > > Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > >
> > > Thanks a lot, without this fix the Mali G52 GPU won't probe on my RK3568
> > > EVB1 in vanilla v5.19-rc1.
> > >
> >
> > Yes, the break was reported on -next and today it appeared in 5.19-rc1.
> > A proper FW fix is also up for review by Etienne but in the meantime
> > this tries to limit damages relaxing a bit the checks.
> >
> > > I guess this patch should have a Fixes: tag, right?
> > >
> >
> > It has not a Fixes tag because the issue was introduced in 5.19-rc1 and the
> > fix will go in with the next round of v5.19 fixes by Sudeep (AFAIU) so it
> > will be solved within the v5.19 cycle and I thought the Fixes tag was
> > not needed in this case (I could be wrong...)
> 
> Correct, if for some reason, we can't push this before v5.19, then fixes
> tag needs to added. I will add that then, but for now let us target getting
> it in before v5.19

hmm, I'd disagree for the generalization.

While true that is not 100% necessary to be present in all cases, so
definitly no reason for a new version when applied to the same -rc series,
having the Fixes tag not only clearly marks the patch as such, but also
allows people reading either mailing lists or the later the git history
to actually see where the issue started. So I really think it is a
nice-to-have in most cases.


Heiko


