Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9184D1A12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbiCHOL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiCHOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:11:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B64AE0E;
        Tue,  8 Mar 2022 06:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B71D0B818B4;
        Tue,  8 Mar 2022 14:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DDC340EB;
        Tue,  8 Mar 2022 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646748656;
        bh=K5hOSnCQGMOmt/IEIcA7LTELy76XtsnTeSUtRHpSjMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8ZgAweQxHnQcRrc7YeQLvfiGEP7eJ7VE4JoZvnjij9ixBcX2oaN8pur5zg0MxOhZ
         GY3fBqHK2sZQXIpTJMOE4F2VqSkYWhKyEHHTfl0wJYQlipLCtvLLsucs8nW4lq7lZI
         Bc22y9OVZKU7zzpJ/BQ5NuwONONqA6GYZ6NnkGuTd4jHTpOgMhAvGbc6AMurdwAApp
         pYg2pn7j2TH2ut5VcSwOzL88pt962JlNG1MZ1jQkScxlR2jUT+/emich1hvPrPJRvM
         i42TlTqc7ncLlF1gfgvXfMplqnxyRHzGlt9nXQxfNbNmtPpI7yXUPsdt7qbtvNiGlA
         0Uc36aPUNUJ1g==
Date:   Tue, 8 Mar 2022 14:10:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v5 00/10] drivers/perf: CPU PMU driver for Apple M1
Message-ID: <20220308141049.GA31812@willie-the-truck>
References: <20220208185604.1097957-1-maz@kernel.org>
 <875yop21vj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yop21vj.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:55:44PM +0000, Marc Zyngier wrote:
> On Tue, 08 Feb 2022 18:55:54 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
> > 
> > The M1 SoC embeds a per-CPU PMU that has a very different programming
> > interface compared to the architected PMUv3 that is normally present
> > on standard implementations.
> > 
> > This small series adds a driver for this HW by leveraging the arm_pmu
> > infrastructure, resulting in a rather simple driver.
> > 
> > Of course, we know next to nothing about the actual events this PMU
> > counts, aside from CPU cycles and instructions. Everything else is
> > undocumented (though as Dougall pointed out, someone could extract the
> > relevant information from a macOS install if they wanted -- I don't).
> > I'm looking at allowing the perf userspace tool to load the event
> > descriptions at runtime, which would probably help.
> 
> [...]
> 
> FWIW, I have created two branches:
> 
> - [1] has the full series
> - [2] has the irqchip/DT prefix of [1]
> 
> Both branches are stable, and I expect [2] to be used as a shared
> branch between the irqchip and perf trees.

Cheers, I've picked this up in the arm64 tree (by pulling [2] and applying
the two extra patches from [1] on top) here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/perf-m1

Will
