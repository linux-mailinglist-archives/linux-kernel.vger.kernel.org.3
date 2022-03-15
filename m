Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0534DA582
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352301AbiCOWmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbiCOWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DEC5D191;
        Tue, 15 Mar 2022 15:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE7661375;
        Tue, 15 Mar 2022 22:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1F9C340E8;
        Tue, 15 Mar 2022 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384076;
        bh=QJySxIrBFyO2J4pGMuN4V88tfN+T8HlJrnBR2Ek3/Go=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dbeYwPMA+kTG7ZgLzdU9tD5BjqbSBZgwwHMnn7xNl20ZI6Lc3+eQTN+TDtCI0XKrf
         beBlw5oU26UsNs11wY6liecUUe2Y7gotd2VrMvsEsZdLXuCDofc1+HTGWKWHuvOUHY
         YwhXTP+Wcf/cotszDCRQ9+zIGx+EpywxdgCwbVcGk7EMYOs4lhwLdLqTqsAyfQ3I+T
         g5oM5XTKUCmYxw4yNlKrmy1ymUeueg0r7PqbSD7pzY38qUq/Ei0Wogq2p2vUe3gwUP
         +ALTOpw3i9Zbo8Gwn1jOfNkfyI0BPrJk9LcEW/DXZ2u3QzgV1A3vKNNMNXP5OITDrw
         /ui9SD0MMuKIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YjEJjB/Hwj/1Ncum@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-13-ansuelsmth@gmail.com> <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org> <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain> <20220315213431.DB6C4C340EE@smtp.kernel.org> <YjEJjB/Hwj/1Ncum@Ansuel-xps.localdomain>
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
Date:   Tue, 15 Mar 2022 15:41:14 -0700
User-Agent: alot/0.10
Message-Id: <20220315224115.EA1F9C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-15 14:47:56)
> On Tue, Mar 15, 2022 at 02:34:30PM -0700, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-03-14 05:43:20)
> > > On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> > > > On 13/03/2022 22:04, Ansuel Smith wrote:
> > > > > Add 8064 errata workaround where the sec_src clock gating needs t=
o be
> > > >=20
> > > > Could you please be more specific whether the errata applies only t=
o the
> > > > ipq8064 or to the apq8064 too? 8064 is not specific enough.
> > > >
> > >=20
> > > That's a good question... Problem is that we really don't know the
> > > answer. This errata comes from qsdk on an old sourcecode. I assume th=
is
> > > is specific to ipq8064 and apq8064 have different mux configuration.
> > >=20
> >=20
> > I think it was some glitch that happened when the automatic clk gating
> > was enabled during a switch. The automatic clk gating didn't know that
> > software was running and switching the input so it killed the CPU and
> > stopped the clk. That lead to hangs and super badness. I assume it was
> > applicable to apq8064 as well because ipq8064 is basically apq8064 with
> > the multimedia subsystem replaced by the networking subsystem. Also I
> > wouldn't remember all these details because I worked on apq8064 but not
> > so much on ipq8064 :)
>=20
> Honest question. Do you remember other glitch present on the platform?
> We are trying to bisect an instability problem and we still needs to
> find the reason. We really can't understand if it's just a power
> delivery problem or a scaling problem from muxes or other things.
>=20
> The current problem is that after some time the device kernel panics
> with a number of strange reason like invalid kernel paging and other
> strange (or the device just freze and reboots, not even a crash log)
> Many kernel panics reports the crash near the mux switch (like random
> error right before the mux switch) So I suspect there is a problem
> there. But due to the fact that is very random we have NO exact way to
> repro it. I manage sometime, while playing with the code, to repo
> similar kernel crash but still i'm not sure of the real cause.
>=20
> I know it's OT but do you have any idea about it? If you remember
> anything about it?
> (To scale the freq i'm using a dedicated cpufreq driver that works this
> way:
> - We first scale the cache to the max freq across all core, we set the
>   voltage
> - We scale the cpu to the correct target.
> This is all done under a lock. Do you see anything wrong in this logic?

I honestly don't remember much anymore about this. It's been a decade.
Scaling the cache used to be an independent clk and operation vs. the
CPU. Basically the clk domain and power domain for the cache was
separate from the CPU. There's also the fuse stuff that means you have
to read the fuse to know what OPP table to use. Otherwise you may be
overclocking the CPU or undervolting it. It may also be that cpuidle
can't happen during a frequency transition. Otherwise the clk gating
will be reenabled when the cpu startup code reinitializes all the cpu
registers? I'd have to look through some old vendor kernels to see if
anything jogs my memory.

> To mee these random crash looks to be really related to something wrong
> with the mux or with the cache set to a wrong state)
>=20
> Thx for any suggestion about this.
> (also I will update this commit and mention both apq and ipq in the
> comments)
