Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DE48A0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbiAJUOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbiAJUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:14:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F3C061748;
        Mon, 10 Jan 2022 12:14:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E99612FA;
        Mon, 10 Jan 2022 20:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E4C36AE3;
        Mon, 10 Jan 2022 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641845692;
        bh=r24yN07MYyKv+1b+zerD+vIcwUaYal1HbYEztIuAink=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eqKYahqLBtySojhaUYLMfHwwWrop8HUssVOK1RSArk4sNkP4aMfaQFOaIvKyhN6Ry
         +oFc9QZVKBUO+yDxhmpYrCJ1lj0AD+QEN5M3q1VDXAlr6bknoZv+kgdXSZxY+ccQzv
         wQS1hb8c0QDqW45uLGIjIy1A9RhoG/jbFgeldyTVBSmTYOOlSKhY9m55xFJBt6584F
         bNFbOll8dr7XCRuqFcXa3ZQdo6gv6A2mgps+I5KLl22IZhZsohb9re50cfoTbzOEvp
         L2co/3GWBYQJIiW/S+ZiiaCr1acyI1dFokyxYspvEXrTfqwiDUvEqxHRFslEzzO9wX
         rkIhUOF+eW6Hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <991533e0fddd6999c8a06a536ae57999@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru> <20211209163720.106185-2-nikita@trvn.ru> <20220108005209.5140EC36AEB@smtp.kernel.org> <991533e0fddd6999c8a06a536ae57999@trvn.ru>
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
To:     Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 10 Jan 2022 12:14:50 -0800
User-Agent: alot/0.9.1
Message-Id: <20220110201452.2B3E4C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2022-01-07 23:25:19)
> Hi,
>=20
> Stephen Boyd =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 08.01.2022 05:52:
> > Quoting Nikita Travkin (2021-12-09 08:37:17)
> I'm adding this error here primarily to bring attention of the
> user (e.g. developer enabling some peripheral that needs
> duty cycle control) who might have to change their clock tree
> to make this control effective. So, assuming that if someone
> sets the duty cycle to 50% then they might set it to some other
> value later, it makes sense to fail the first call anyway.
>=20
> If you think there are some other possibilities for this call
> to happen specifically with 50% duty cycle (e.g. some
> preparations or cleanups in the clk subsystem or some drivers
> that I'm not aware of) then I can make an exemption in the check
> for that.
>=20

I don't see anywhere in clk_set_duty_cycle() where it would bail out
early if the duty cycle was set to what it already is. The default for
these clks is 50%, so I worry that some driver may try to set the duty
cycle to 50% and then fail now. Either we need to check the duty cycle
in the core before calling down into the driver or we need to check it
here in the driver. Can you send a patch to check the current duty cycle
in the core before calling down into the clk ops?
