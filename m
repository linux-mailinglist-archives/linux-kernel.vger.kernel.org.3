Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378F646E4B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhLII7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:59:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38652 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhLII7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA191CE2503;
        Thu,  9 Dec 2021 08:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6498C341C8;
        Thu,  9 Dec 2021 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040170;
        bh=7IG24HOkShHSrcn7rVATu3Of+NL/GfzZh/UiustVOQU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=boW0SAMm8YHpQRqEY/pnw1uqDWet7xYuKvkMjuPv3de87U5aqcw1RZkQyYmKr0wAk
         qchFT4oWoq5zVYE++BxbxEZ8Q16fWLxgdSib/5FlL8uQqDTBa8PWZLDhDhjfpsszwZ
         hGH3dyM5wO6Z7iTp2CpAcfsnPo8vmVFJbx3JDb+Jj5ngr6g1MXBmK/AONlc7SbaBHj
         54czDN/mmG/zdimLc751k32R/sYphlbKyeHCdHmjvA4/51EKFMehMYTkKbTYr0dYUv
         z8S9uD1z1MwD0dSRlsXUDkKVrMV9BLuy8+W9bpTqN/eafac5V9hpCM8vLlTbBaP4gV
         bL2Duw8VimN9Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
References: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        dmitry.baryshkov@linaro.org
Date:   Thu, 09 Dec 2021 00:56:08 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209085609.E6498C341C8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-02 19:54:35)
> Some clock implementations doesn't provide means of implementing
> is_enabled(), but still requires to be explicitly disabled when found
> unused as part of clk_disable_unused().
>=20
> One such set of clocks are Qualcomm's display RCGs. These can be enabled
> and disabled automatically by the hardware, so it's not possible to
> reliably query their configuration. Further more, these clocks need to
> be disabled when unused, to allow them to be "parked" onto a safe
> parent. Failure to disable the RCG results in the hardware locking up as
> clk_disable_unused() traverses up the tree and turns off its source
> clocks.
>=20
> Add a new flag, CLK_ASSUME_ENABLED_BOOT, which clock drivers can use to
> signal that these clocks should be disabled even if they don't implement
> the is_enabled() ops.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

I'm inclined to remove the disable unused logic. It is the main cause of
problems in the clk framework and with android pushing everyone to use
modules it's become a more broken design in need of an actual fix.  The
best approach is probably to just rip it out and start over, kicking off
the process for someone to fix the power regression of any clks that are
left enabled at boot. Or we can take the regulator approach and delay
disabling for 30 seconds and keep it around.

I'd prefer we take the approach of parking clks at init instead as
Dmitry proposed. It will break continuous splash screen but I don't
think that's being used anyway?
