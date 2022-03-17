Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4E4DCEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiCQTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiCQTfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C29DF485;
        Thu, 17 Mar 2022 12:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED11618AC;
        Thu, 17 Mar 2022 19:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15511C340E9;
        Thu, 17 Mar 2022 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647545643;
        bh=Cplw1DogFBiyO3f6JlbndQ+AtgWmf6UgQThui5qA4l0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sZzLiMwITzd3BzRnpJpr1/JbIRjadbOCiFGo/Efy6fvH+S58iXbZRsLjdiePjbx+x
         j/CFMH80CP532XN4nakMzxfcJRLHaraoUhlNYAedpDPQ7v1E8pA2rdgsbNamllmLMc
         Wqpbv+sgrUMY23UyWoKRD3jhV8EZCnQinkvmpS5vZhb0DmtId7fwFo0yIXorfM+TaF
         G3PqVyo7UOJ4TPHNp0HqhqJT5GthYjRfwQL+xMjGGVwQ2O++9Qrksw4L5vkg4Z2XfS
         gYvD72ZTrLwskOH1uxBjdnsn1b3QGG6uqW6KhYnftPYVvJFofsL73qUDXTTX5SRCEc
         xUnfVDD+CL6Gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YjIGbs+Pz2EK9riB@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-13-ansuelsmth@gmail.com> <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org> <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain> <20220315213431.DB6C4C340EE@smtp.kernel.org> <YjEJjB/Hwj/1Ncum@Ansuel-xps.localdomain> <20220315224115.EA1F9C340E8@smtp.kernel.org> <YjIGbs+Pz2EK9riB@Ansuel-xps.localdomain>
Subject: Re: [PATCH 12/16] clk: qcom: clk-krait: add 8064 errata workaround
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 17 Mar 2022 12:34:01 -0700
User-Agent: alot/0.10
Message-Id: <20220317193403.15511C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-16 08:46:54)
> On Tue, Mar 15, 2022 at 03:41:14PM -0700, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-03-15 14:47:56)
> > > On Tue, Mar 15, 2022 at 02:34:30PM -0700, Stephen Boyd wrote:
> > > > Quoting Ansuel Smith (2022-03-14 05:43:20)
> > > > > On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> > > > > > On 13/03/2022 22:04, Ansuel Smith wrote:
> > > > > > > Add 8064 errata workaround where the sec_src clock gating nee=
ds to be
> > > > > >=20
> > > > > > Could you please be more specific whether the errata applies on=
ly to the
> > > > > > ipq8064 or to the apq8064 too? 8064 is not specific enough.
> > > > > >
> > > > >=20
> > > > > That's a good question... Problem is that we really don't know the
> > > > > answer. This errata comes from qsdk on an old sourcecode. I assum=
e this
> > > > > is specific to ipq8064 and apq8064 have different mux configurati=
on.
> > > > >=20
> > > >=20
> > > > I think it was some glitch that happened when the automatic clk gat=
ing
> > > > was enabled during a switch. The automatic clk gating didn't know t=
hat
> > > > software was running and switching the input so it killed the CPU a=
nd
> > > > stopped the clk. That lead to hangs and super badness. I assume it =
was
> > > > applicable to apq8064 as well because ipq8064 is basically apq8064 =
with
> > > > the multimedia subsystem replaced by the networking subsystem. Also=
 I
> > > > wouldn't remember all these details because I worked on apq8064 but=
 not
> > > > so much on ipq8064 :)
> > >=20
> > > Honest question. Do you remember other glitch present on the platform?
> > > We are trying to bisect an instability problem and we still needs to
> > > find the reason. We really can't understand if it's just a power
> > > delivery problem or a scaling problem from muxes or other things.
> > >=20
> > > The current problem is that after some time the device kernel panics
> > > with a number of strange reason like invalid kernel paging and other
> > > strange (or the device just freze and reboots, not even a crash log)
> > > Many kernel panics reports the crash near the mux switch (like random
> > > error right before the mux switch) So I suspect there is a problem
> > > there. But due to the fact that is very random we have NO exact way to
> > > repro it. I manage sometime, while playing with the code, to repo
> > > similar kernel crash but still i'm not sure of the real cause.
> > >=20
> > > I know it's OT but do you have any idea about it? If you remember
> > > anything about it?
> > > (To scale the freq i'm using a dedicated cpufreq driver that works th=
is
> > > way:
> > > - We first scale the cache to the max freq across all core, we set the
> > >   voltage
> > > - We scale the cpu to the correct target.
> > > This is all done under a lock. Do you see anything wrong in this logi=
c?
> >=20
> > I honestly don't remember much anymore about this. It's been a decade.
> > Scaling the cache used to be an independent clk and operation vs. the
> > CPU. Basically the clk domain and power domain for the cache was
> > separate from the CPU. There's also the fuse stuff that means you have
> > to read the fuse to know what OPP table to use. Otherwise you may be
> > overclocking the CPU or undervolting it. It may also be that cpuidle
> > can't happen during a frequency transition. Otherwise the clk gating
> > will be reenabled when the cpu startup code reinitializes all the cpu
> > registers? I'd have to look through some old vendor kernels to see if
> > anything jogs my memory.
> >=20
> > > To mee these random crash looks to be really related to something wro=
ng
> > > with the mux or with the cache set to a wrong state)
> > >=20
> > > Thx for any suggestion about this.
> > > (also I will update this commit and mention both apq and ipq in the
> > > comments)
>=20
> Hi, i'm checking the spm qcom idle driver and something doesn't look
> right to me... Aside from the different sequence used for boot cpu and
> the abset l2 sequence, it looks like to me that WFI is enabled anyway
> (even if it's not defined in the DTS or set disabled) and on top of that
> it looks like we overwrite the WFI logic but we actually set to
> enter power collapse (spc). Why?

When the CPU is power collapsed they need to notify software running in
the secure world that the CPU is going to be reset. The CPU comes out of
reset in secure mode and it has to jump to non-secure mode. It's still a
WFI, but we don't see it in the kernel because the secure world code
executes the wfi and that runs the power collapse sequence to turn all
the power off. On power up the secure world will restore various cpu
registers (*cough* workarounds *cough*) and then switch to non-secure
mode wherever linux told it to execute at on warm boot.

>=20
> Also I think we are missing the assembly code to enter wfi on krait cpu.
> Am I totally confused or there are some problems in the code that nobody
> notice?
>=20

I'd expect that to run through some scm_call() path into the secure
world. The wfi can still be run by the kernel in non-secure mode, but
that will only gate the CPU clk and not actually power collapse the
core. It's a "light sleep" for the CPU. All this stuff predates PSCI but
it is very similar, just a bespoke solution instead of a standard
calling format.
