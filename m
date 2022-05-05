Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2051B98F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiEEIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbiEEIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:06:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F3DC31365
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:03:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E50E1042;
        Thu,  5 May 2022 01:03:17 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 294DF3FA27;
        Thu,  5 May 2022 01:03:16 -0700 (PDT)
Date:   Thu, 5 May 2022 09:03:14 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to
 boot due to firmware bug
Message-ID: <YnOEwuuyO2/h7c1G@e120937-lin>
References: <1698297.NAKyZzlH2u@archbook>
 <20220504132130.wmmmge6qjc675jw6@bogus>
 <3764923.NsmnsBrXv5@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3764923.NsmnsBrXv5@archbook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 07:51:45PM +0200, Nicolas Frattaroli wrote:
> On Mittwoch, 4. Mai 2022 15:21:30 CEST Sudeep Holla wrote:
> > + Cristian

+Etieenne

Hi Nicolas,

> > 
> > Hi Nicolas,
> > 
> > Thanks for the formal report.
> > 
> > On Wed, May 04, 2022 at 02:49:07PM +0200, Nicolas Frattaroli wrote:
> > > Good day,
> > > 
> > > a user on the #linux-rockchip channel on the Libera.chat IRC network
> > > reported that their RK3568 was no longer getting a CPU and GPU clock
> > > from scmi and consequently not booting when using linux-next. This
> > > was bisected down to the following commit:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/firmware/arm_scmi/base.c?h=next-20220503&id=3b0041f6e10e5bdbb646d98172be43e88734ed62
> > > 
> > > The error message in the log is as follows:
> > > 
> > > arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz:4, t->rx.len is 12, sizeof(u32) is 4, loop_num_ret is 3
> > > 
> > > The rockchip firmware (bl31) being used was v1.32, from here:
> > > 
> > > https://github.com/JeffyCN/rockchip_mirrors/blob/rkbin/bin/rk35/rk3568_bl31_v1.32.elf
> > >
> > 
> > So this platform is not supported in upstream TF-A like its predecessors ?
> 
> Hello,
> 
> it is not yet supported by upstream. Rockchip plans to release the sources
> for it at some point if I recall correctly, but I believe their software
> team has been very busy due to new hardware releases, so it hasn't happened
> yet. I hope we'll see an open source release of the TF-A sources eventually,
> so that for bugs like this we can always fix them without the vendor needing
> to do it for us.
> 
> > 
> > > This seems like a non-fatal firmware bug, for which a kernel workaround is
> > > certainly possible, but it would be good if rockchip could fix this in their
> > > firmware.
> > >
> > 
> > Indeed, we added this check finding issue in one of our tests. Luckily
> > it helped to unearth the same issue on this platform, but due to the
> > nature of its f/w release, it is bit unfortunate that it can't be fixed
> > easily and quickly. But I really wish this gets fixed in the firmware.
> > Are there any other f/w bugs reported so far ? If so how are they fixed
> > as I don't expect all such bugs can be worked around in the kernel though
> > this might be. I would like to hear details there if possible.
> 
> I'm not aware of how the rockchip bug report workflow works. They seemingly
> did update the firmware multiple times, last in October of 2021.
> 
> The official rockchip repository at [1] hasn't been kept as up to date as
> the mirror by a rockchip employee at [2], so most people seem to have been
> using the latter. Speaking of which, I'll add the owner of that repo to 
> the CC of this thread to make sure this doesn't get lost.
> 
> Rockchip lists an e-mail at [3] for reporting issues at, but this seems to
> relate to their open-source documentation. The official github repository
> of "rkbin" on the "rockchip-linux" organisation does not have issues
> enabled, so submitting a bug report through that is unfortunately not
> possible.

Having a quick look at TF-A SCMI code in charge of this message (at least in
the upstream):

https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/drivers/scmi-msg/base.c#n136

it seems to me that the bug lies in the fact that the BASE_DISCOVER_PROTOCOLS
response message built by the function above is not properly sized: the trailing
message payload carrying the list of protocols (after returned_protos field) returns
always a fixed arbitrarily sized payload, possibly zeroed if fewer protocols are
carried.

IOW, even though the answer in this case carries 3 items/protocols, the payload
is anyway 8 bytes (with the last 5 bytes zeroed), while by the spec it should have
been just 4 bytes.

(in fact testing the kernel fix on a JUNO with last SCP fw release did NOT expose
any issue...)

I think a fix FW side could be something along these lines (UNTESTED NOR
BUILT ! ... I Cc'ed Etienne that seems the author of this bit)

This basically mirrors the same checks introduced in kernel...if someone
is fancy/able to test it....

---

diff --git a/drivers/scmi-msg/base.c b/drivers/scmi-msg/base.c
index 2d7203451..35c99e308 100644
--- a/drivers/scmi-msg/base.c
+++ b/drivers/scmi-msg/base.c
@@ -142,6 +142,7 @@ static void discover_list_protocols(struct scmi_msg *msg)
        uint8_t outargs[sizeof(p2a) + MAX_PROTOCOL_IN_LIST] = { 0U };
        const uint8_t *list = NULL;
        unsigned int count = 0U;
+       size_t list_sz = 0U;
 
        if (msg->in_size != sizeof(*a2p)) {
                scmi_status_response(msg, SCMI_PROTOCOL_ERROR);
@@ -163,9 +164,12 @@ static void discover_list_protocols(struct scmi_msg *msg)
        p2a.num_protocols = count;
 
        memcpy(outargs, &p2a, sizeof(p2a));
-       memcpy(outargs + sizeof(p2a), list + a2p->skip, count);
-
-       scmi_write_response(msg, outargs, sizeof(outargs));
+       if (count) {
+               memcpy(outargs + sizeof(p2a), list + a2p->skip, count);
+               list_sz = (1 + (count - 1) / sizeof(uint32_t)) *
+                          sizeof(uint32_t);
+       }
+       scmi_write_response(msg, outargs, sizeof(p2a) + list_sz);
 }


> 
> > 
> > > The user going by "amazingfate" reported that commenting out the
> > >   ret = -EPROTO; break;
> > > fixes the issue for them.
> > >
> > 
> > Sure, or we could relax the check as calc_sz <= real_sz or something so
> > that the reverse is still caught and handled as OS might read junk data in
> > the later case.
> 
> This seems like a good solution, that way we're unlikely to ever run into a
> situation where the kernel does the wrong thing here even if we're less
> strict about the check. In either case, it should print a dev_err though,
> it's still an error even if we can tolerate it in some cases.
> 
> > 

Beside fixing the FW, adding a workaround like the one Sudeep mentioned to
avoid killing old fw plaform seems reasonable: we can just _err() as long as
Kernel is not put into peril (i.e. calc_sz <= real_sz ) without
necessarily bail out if an out of spec, but harmless, message is
spotted.

> > > I'm writing here to get the discussion started on how we can resolve this
> > > before the Linux 5.19 release.
> > >
> > 
> > Agreed, I just sent by pull request for this literally few hours ago.
> > 
> > > Sudeep Holla has already told me they'll gladly add a workaround before
> > > the 5.19 release, but would rather see this fixed in the vendor firmware
> > > first. Would rockchip be able and willing to fix it and publish a new
> > > bl31 for rk3568?
> > >
> > 
> > Indeed and as mentioned above details on how other such f/w bugs are dealt
> > in general esp that the firmware is blob release and one can't fix it easily.
> > Do we have a bugzilla kind of setup to report and get the bugs fixed ?
> 
> It's worth mentioning that I think even if we get Rockchip to fix the bug in
> the firmware, I believe Linux should still add a workaround, as otherwise
> people running older firmware who are upgrading their kernels could suddenly
> have unbootable systems and don't know why that happened.
> 

Agree.

Thanks,
Cristian
