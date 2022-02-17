Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B34BACB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbiBQWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbiBQWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:37:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942E169235;
        Thu, 17 Feb 2022 14:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D84F61755;
        Thu, 17 Feb 2022 22:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC2EC340E8;
        Thu, 17 Feb 2022 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137457;
        bh=nYXGEcTwGIOXhjX/wlgdLjWw4uZu5iED6zGc9Z3ENc0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UreO/S9roUEZ7rVE6PFiepDoLKeV+CwRaOXY0jDafGSpUVhFxfdHhwOjjyK3UfdUY
         UcCnJYF9rftREVlZeXtxoj+TPIb7M0boQB5vBXtgoH2UhhGq2fq4NIt3SQQ34M2OLs
         9flfR6lWIHfIAeZLAHfYtcVow/62H+y8W1UdhJ4aDMt2JFpDgJ2I+niSNItAWznwOh
         Jc0D1rOq7jB/mx/sgy863esaG6n62VFH2azV7VcEgFq5fc0VoCv4u+L3EvStSVCBXx
         BpkfXjFn0n26VdJiqmXSZDMrcuqpFq+qvHMxIwNMboXcORwfwBKOQKL8k/nMLYFDsC
         bt2IwtlLOvhBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cc4241105bfd2249c1c309a4efa2e6aa@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru> <20211209163720.106185-2-nikita@trvn.ru> <20220108005209.5140EC36AEB@smtp.kernel.org> <991533e0fddd6999c8a06a536ae57999@trvn.ru> <20220110201452.2B3E4C36AE3@smtp.kernel.org> <cc4241105bfd2249c1c309a4efa2e6aa@trvn.ru>
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
To:     Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 17 Feb 2022 14:37:35 -0800
User-Agent: alot/0.10
Message-Id: <20220217223736.DFC2EC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2022-01-26 07:14:21)
> Stephen Boyd =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 11.01.2022 01:14:
> > Quoting Nikita Travkin (2022-01-07 23:25:19)
> >> Hi,
> >>
> >> Stephen Boyd =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 08.01.2022 05:52:
> >> > Quoting Nikita Travkin (2021-12-09 08:37:17)
> >> I'm adding this error here primarily to bring attention of the
> >> user (e.g. developer enabling some peripheral that needs
> >> duty cycle control) who might have to change their clock tree
> >> to make this control effective. So, assuming that if someone
> >> sets the duty cycle to 50% then they might set it to some other
> >> value later, it makes sense to fail the first call anyway.
> >>
> >> If you think there are some other possibilities for this call
> >> to happen specifically with 50% duty cycle (e.g. some
> >> preparations or cleanups in the clk subsystem or some drivers
> >> that I'm not aware of) then I can make an exemption in the check
> >> for that.
> >>
> >=20
> > I don't see anywhere in clk_set_duty_cycle() where it would bail out
> > early if the duty cycle was set to what it already is. The default for
> > these clks is 50%, so I worry that some driver may try to set the duty
> > cycle to 50% and then fail now. Either we need to check the duty cycle
> > in the core before calling down into the driver or we need to check it
> > here in the driver. Can you send a patch to check the current duty cycle
> > in the core before calling down into the clk ops?
>=20
> Hi, sorry for a rather delayed response,
> I spent a bit of time looking at how to make the clk core be
> careful with ineffective duty-cycle calls and I can't find a
> nice way to do this... My idea was something like this:
>=20
> static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
>                                           struct clk_duty *duty)
> {       /* ... */
>=20
>         /* Update core->duty values */
>         clk_core_update_duty_cycle_nolock(core);
>=20
>         if ( /* duty doesn't match core->duty */ ) {
>                 ret =3D core->ops->set_duty_cycle(core->hw, duty);
>         /* ... */
> }
>=20
> However there seem to be drawbacks to any variant of the
> comparison that I could come up with:
>=20
> Naive one would be to do
>     if (duty->num !=3D core->duty->num || duty->den !=3D core->duty->den)
> but it won't correctly compare e.g. 1/2 and 10/20.
>=20
> Other idea was to do
>     if (duty->den / duty->num !=3D core->duty->den / core->duty->num)
> but it will likely fail with very close values (e.g. 100/500 and 101/500)
>=20
> I briefly thought of some more sophisticated math but I don't
> like the idea of complicating this too far.
>=20
> I briefly grepped the kernel sources for duty-cycle related methods
> and I saw only one user of the clk_set_duty_cycle:
>     sound/soc/meson/axg-tdm-interface.c
> Notably it sets the cycle to 1/2 in some cases, though it seems to
> be tied to the drivers/clk/meson/sclk-div.c clock driver by being
> the blocks of the same SoC.

Indeed, so this patch is untested? I doubt the qcom driver is being used
with the one caller of clk_set_duty_cycle() in the kernel.

>=20
> Thinking of it a bit more, I saw another approach to the problem
> I want to solve: Since I just want to make developers aware of the
> hardware quirk, maybe I don't need to fail the set but just put a
> WARN or even WARN_ONCE there? This way the behavior will be unchanged.
>=20

I don't like the idea of a WARN or a WARN_ONCE as most likely nobody is
going to read it or do anything about it. Returning an error should be
fine then. If the duty cycle call fails for 50% then that's something we
have to live with.
