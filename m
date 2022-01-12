Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF83048CD41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357758AbiALUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:49:07 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:35792 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbiALUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:49:00 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:8be6:7813:530e:2d21] (unknown [IPv6:2a02:a03f:eafe:c901:8be6:7813:530e:2d21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 963972908E9;
        Wed, 12 Jan 2022 21:48:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642020534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyLn+1iZg8U+1VoC+Sc82PZQ0iI/L12fBI5+NQV+CPE=;
        b=fnAVrlBH7KefO7aFpo6HqO78v1+xvueeKyQLruB4NPtiLKpObPAta8kEEzPj59QW/xY3Pq
        +d6oOelSj/DeXOiUq4RfYtP2dF4EDQxOzO3IwoZcbJ7+g/11TmZP1aukQ9u10cQ4xRyWlg
        xGQPHniThyXnAdUTnunmdHjKOZSUElBIonNbrcjI/lDGlKbHAW8384sBeU5axlH8ZWatsF
        fNAIe1LKuLlEd7MD8l71XVHRvYGBVpCOZv7FDFydTeiCv73ty4uDuF3X+3i+wpIDY/dh1Q
        PgpMlbhCITCjBQgRBVsFpqL/0vWVPGlXHhm9Bd1ag+iJUn4vRxGOoJhRyNnvOQ==
Message-ID: <71fffde0704d240f5ec8773fe0e738b6e069a6b8.camel@svanheule.net>
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-restart: Correct
 default priority
From:   Sander Vanheule <sander@svanheule.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jan 2022 21:48:53 +0100
In-Reply-To: <Yd46ayLnvT/3ch9e@robh.at.kernel.org>
References: <20220110214456.67087-1-sander@svanheule.net>
         <Yd46ayLnvT/3ch9e@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 2022-01-11 at 20:18 -0600, Rob Herring wrote:
> On Mon, 10 Jan 2022 22:44:56 +0100, Sander Vanheule wrote:
> > Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
> > slightly") changed the default restart priority 129, but did not update
> > the documentation. Correct this, so the driver and documentation have
> > the same default value.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> > This is a resubmission of RFC:
> > https://lore.kernel.org/all/cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net/
> > 
> > The commit message for bcd56fe1aa97 mentions that it is a workaround for
> > rk3288-veryon boards. However, commit e28ea9dbc52d3 ("ARM: dts:
> > rockchip: add shared rk3288-veyron files") later adds a gpio-restart
> > node with a priority value of <200> for those boards, effectively
> > rendering bcd56fe1aa97 obsolete (for their use case).
> > 
> > Perhaps bcd56fe1aa97 could just be reverted instead of updating the
> > documentation.
> > 
> > An argument against reverting (a 6 year old patch) is that other boards
> > may have come to depend on the default value of 129. I don't know about
> > out-of-tree user of gpio-restart, but there are a few in-tree users of
> > gpio-restart /without/ an explicit priority:
> > 
> > arch/arm/boot/dts/imx53-ppd.dts (commit 2952d67637716)
> >   DTS submitted after changed default, but DTS copyright predates the
> >   changed default.
> > 
> > arch/microblaze/boot/dts/system.dts (commit 7cca9b8b7c5bc)
> >   The original DTS commit predates the changed default, but didn't use
> >   gpio-restart. The commit adding gpio-restart appears to indicate no
> >   other restart handlers are present on this platform, although it could
> >   be these were just being shadowed by the custom restart code.
> > 
> > arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts (commit 0a91330b2af9f)
> >   Recently added board; couldn't find any obvious alternative restart
> >   handlers.
> > 
> > Best,
> > Sander
> > 
> >  .../devicetree/bindings/power/reset/gpio-restart.yaml         | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review!

I've noticed the devicetree patchwork has this patch marked as "Not  applicable", but
linux-pm patchwork has it marked "Handled elsewhere". Since you merged the gpio-restart
conversion patch, can you also take this one, Rob?

Best,
Sander
