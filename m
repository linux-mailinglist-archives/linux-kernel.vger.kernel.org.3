Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3846E530
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhLIJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:13:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42530 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLIJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:13:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37998B823BD;
        Thu,  9 Dec 2021 09:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3344C004DD;
        Thu,  9 Dec 2021 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639041005;
        bh=icMiV34lW7ETCdiCn7QzllM5HJp1tlMskWw6+Ug2nm0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NsBkY8WecKgADm8TPgPcP7PDh2MiyvRPGo5pySDCdQsTzHJ9fB6R1MnI30G55QPBX
         SdQq9D5dgkMpwc/bSK9sJxliXG4ESgw8f63PrjmbhbHKDvJRcEXt4YssRSwR5NzGOv
         D+ZTeXI8tJbOdpsmd4Lgm12iSsXU7bYbMrJ+/nVBigMcEo1sHjrsyXowOpP3iJEEKX
         qlOzFS0ojCz1NcDLX7wH0Gio2GG55IYUHJrflotIFwrZo/WBZTP0fl/mOsalRHpG83
         sDaWuCTqvvAEll/ug6hbbpcCMqtmKM88lbKzi0c8cE957SFW2Ku5B+Fis63PnyJ4ng
         AK3F1cZ40H48A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YYpMzau3CWRQYlkJ@gerhold.net>
References: <20211109022558.14529-1-shawn.guo@linaro.org> <YYpMzau3CWRQYlkJ@gerhold.net>
Subject: Re: [PATCH 0/3] clk: qcom: smd-rpm: Report enable state to framework
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 09 Dec 2021 01:10:04 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209091005.D3344C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephan Gerhold (2021-11-09 02:26:21)
> Hi Shawn,
>=20
> On Tue, Nov 09, 2021 at 10:25:55AM +0800, Shawn Guo wrote:
> > Currently the enable state of smd-rpm clocks are not properly reported
> > back to framework due to missing .is_enabled and .is_prepared hooks.
> > This causes a couple of issues.
> >=20
> > - All those unused clocks are not voted for off, because framework has
> >   no knowledge that they are unused.  It becomes a problem for vlow
> >   power mode support, as we do not have every single RPM clock claimed
> >   and voted for off by client devices, and rely on clock framework to
> >   disable those unused RPM clocks.
> >=20
>=20
> I posted a similar patch a bit more than a year ago [1]. Back then one
> of the concerns was that we might disable critical clocks just because
> they have no driver using it actively. For example, not all of the
> platforms using clk-smd-rpm already have an interconnect driver.
> Disabling the interconnect related clocks will almost certainly make the
> device lock up completely. (I tried it back then, it definitely does...)
>=20
> I proposed adding CLK_IGNORE_UNUSED for the interconnect related clocks
> back then [2] which would allow disabling most of the clocks at least.
> Stephen Boyd had an alternative proposal to instead move the
> interconnect related clocks completely out of clk-smd-rpm [3].
> But I'm still unsure how this would work in a backwards compatible way. [=
4]

We should stop adding to the pile of smd-rpm clks that are clearly
interconnects. I'm ready to stop accepting patches like 78b727d02815
("clk: qcom: smd-rpm: Add QCM2290 RPM clock support").

Someone needs to put in the work to make an interconnect provider that
directly talks to the rpm, without going through the clk framework just
because the rpm talks in kHz for these resources. These clk have no
parent and are essentially a proxy for some firmware interface to the
rpm but we put it behind the clk framework for reasons I don't know why.

I honestly don't understand the backwards incompatibility argument for
this either. If we're adding more SoC support for this driver we need to
stop and figure out a better approach. Make a new interconnect driver,
plug it in via DT, wait a release cycle, and finally dump the smd-rpm
clk node from older platforms that were using the clk framework. At
least for new SoCs this problem doesn't exist.

There's that one graphics clk (RPM_SMD_GFX3D_CLK_SRC) but I don't see it
used anywhere. So it's not really important? Maybe we need to set some
bandwidth in the graphics clk driver? I dunno.

>=20
> Since your patches are more or less identical I'm afraid the same
> concerns still need to be solved somehow. :)
>=20
> Thanks,
> Stephan
>=20
> [1]: https://lore.kernel.org/linux-arm-msm/20200817140908.185976-1-stepha=
n@gerhold.net/
> [2]: https://lore.kernel.org/linux-arm-msm/20200818080738.GA46574@gerhold=
.net/
> [3]: https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657=
387381953@swboyd.mtv.corp.google.com/
> [4]: https://lore.kernel.org/linux-arm-msm/20200821064857.GA905@gerhold.n=
et/
