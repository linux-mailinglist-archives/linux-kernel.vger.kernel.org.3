Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85B51C25D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380573AbiEEOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380562AbiEEOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:25:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA7E5A58F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:21:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2AE3106F;
        Thu,  5 May 2022 07:21:56 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694763F85F;
        Thu,  5 May 2022 07:21:55 -0700 (PDT)
Date:   Thu, 5 May 2022 15:21:53 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to
 boot due to firmware bug
Message-ID: <YnPdgUvEvitCPbfG@e120937-lin>
References: <1698297.NAKyZzlH2u@archbook>
 <20220504132130.wmmmge6qjc675jw6@bogus>
 <3764923.NsmnsBrXv5@archbook>
 <YnOEwuuyO2/h7c1G@e120937-lin>
 <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
 <YnOrTRZyRbmmQMVR@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnOrTRZyRbmmQMVR@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:47:41AM +0100, Cristian Marussi wrote:
> On Thu, May 05, 2022 at 11:40:09AM +0200, Etienne Carriere wrote:
> > Hello Nicolas, Cristian,
> > 
> > On Thu, 5 May 2022 at 10:03, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > On Wed, May 04, 2022 at 07:51:45PM +0200, Nicolas Frattaroli wrote:
> > > > On Mittwoch, 4. Mai 2022 15:21:30 CEST Sudeep Holla wrote:
> > > > > + Cristian
> > >
> > > +Etieenne
> > >
> > > Hi Nicolas,
> > >
> 
> Hi Etienne,
> 
> [snip]
> 
> > > Having a quick look at TF-A SCMI code in charge of this message (at least in
> > > the upstream):
> > >
> > > https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/drivers/scmi-msg/base.c#n136
> > >
> > > it seems to me that the bug lies in the fact that the BASE_DISCOVER_PROTOCOLS
> > > response message built by the function above is not properly sized: the trailing
> > > message payload carrying the list of protocols (after returned_protos field) returns
> > > always a fixed arbitrarily sized payload, possibly zeroed if fewer protocols are
> > > carried.
> > >
> > > IOW, even though the answer in this case carries 3 items/protocols, the payload
> > > is anyway 8 bytes (with the last 5 bytes zeroed), while by the spec it should have
> > > been just 4 bytes.
> > >
> > > (in fact testing the kernel fix on a JUNO with last SCP fw release did NOT expose
> > > any issue...)
> > >
> > > I think a fix FW side could be something along these lines (UNTESTED NOR
> > > BUILT ! ... I Cc'ed Etienne that seems the author of this bit)
> > >
> > > This basically mirrors the same checks introduced in kernel...if someone
> > > is fancy/able to test it....
> > 
> > Indeed the firmware implementation is wrong in TF-A.
> > And also in OP-TEE by the way:
> > https://github.com/OP-TEE/optee_os/blob/3.17.0/core/drivers/scmi-msg/base.c#L163-L166
> > 
> > @Nicoals, do you want to send a patch to TF-A, or do you want me to do it?
> > 
> > I can fix the optee_os implementation. I'll tell you when I'll have
> > created a P-R.
> > The fix is the same for TF-A and OP-TEE.
> > Proposal from Cristian looks good to me, maybe simplified:
> > 
> > ```patch
> >          memcpy(outargs, &p2a, sizeof(p2a));
> >          memcpy(outargs + sizeof(p2a), list + a2p->skip, count);
> > 
> > -        scmi_write_response(msg, outargs, sizeof(outargs));
> > +        list_sz = (1 + (count - 1) / sizeof(uint32_t)) * sizeof(uint32_t);
> > +        scmi_write_response(msg, outargs, sizeof(p2a) + list_sz);
> > ```
> > 
> 
> I don't think list_sz is properly calculated if you don't rule out the
> count = 0 case (did the same mistake in Kernel at first :D)...if count is
> zero list_sz ends up being 4 [(1 + (0 - 1)  / 4 ) * 4] while it should be
> zero. (...and 'if (count)' also avoid an unneeded memcpy of zero bytes)
> 
> Moreover reviewing my own proposal code below it's probably easier to use
> some sort of macro like ALIGN(count, 4) if there's one in TF-A/OP-TEE.
> (...checking anyway that can handle correctly the zero case..)
> 
> Thanks,
> Etienne
> 
 Sorry this was meant to be
 
 Thanks,
 Cristian

:P but I messed up the snipping

Cristian

