Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097BE474A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhLNSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:09:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59504 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLNSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:09:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16566B81BF7;
        Tue, 14 Dec 2021 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2B5C34604;
        Tue, 14 Dec 2021 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639505362;
        bh=/xqmz9lrxbUEJFXEd4jkNP8kMOMxCqRlgDKcoEaYJRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxMDAO85DxyMrysBXtPs7Kwg2fSgTWAGbGaytuHSJODT8PEUkCJxjE5gjLHbqe3s6
         FrDQbLDBChlHlolf8GbH2NZwVHXsD1z8GPjwGL+WN7uIDJ2op60vCXtIRREvf968Xw
         ggiLP1hUoMuDjL4c72wWQr7XcMQOPuYXYwF5G7YZsV+GFUxk7waUZJwCPLTRBcnoiF
         vucANR9tDIxfLqpoH+mOWw8m9Za2hUANY88LpMsng0H2zTwQeB7u8wDQC3+L4lmPAf
         u1+gmvIhTJxHNU7DSh8ftlSzvGRtEkkaCyqCi7kTola39ontbSHHOBiH2Scewm4YaE
         l2J4Gyzxg9F9w==
Date:   Tue, 14 Dec 2021 18:09:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@rivosinc.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, anup.patel@wdc.com,
        david.abdurachmanov@sifive.com, devicetree@vger.kernel.org,
        greentime.hu@sifive.com, guoren@linux.alibaba.com,
        xypron.glpk@gmx.de, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        robh+dt@kernel.org, vincent.chen@sifive.com
Subject: Re: [v4 00/11] Improve RISC-V Perf support using SBI PMU and
 sscofpmf extension
Message-ID: <20211214180915.GA15780@willie-the-truck>
References: <20211025195350.242914-1-atish.patra@wdc.com>
 <mhng-b8ad045e-2022-4e7d-8e64-ab4cc09c15a7@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b8ad045e-2022-4e7d-8e64-ab4cc09c15a7@palmer-ri-x1c9>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:51:28PM -0800, Palmer Dabbelt wrote:
> On Mon, 25 Oct 2021 12:53:39 PDT (-0700), Atish Patra wrote:
> > This series adds improved perf support for RISC-V based system using
> > SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension allows
> > the kernel to program the counters for different events and start/stop counters
> > while the sscofpmf extension allows the counter overflow interrupt and privilege
> > mode filtering. An hardware platform can leverage SBI PMU extension without
> > the sscofpmf extension if it supports mcountinhibit and mcounteren. However,
> > the reverse is not true. With both of these extension enabled, a platform can
> > take advantage of all both event counting and sampling using perf tool.
> > 
> > This series introduces a platform perf driver instead of a existing arch
> > specific implementation. The new perf implementation has adopted a modular
> > approach where most of the generic event handling is done in the core library
> > while individual PMUs need to only implement necessary features specific to
> > the PMU. This is easily extensible and any future RISC-V PMU implementation
> > can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
> > as a part of this series.
> > 
> > The legacy driver tries to reimplement the existing minimal perf under a new
> > config to maintain backward compatibility. This implementation only allows
> > monitoring of always running cycle/instruction counters. Moreover, they can
> > not be started or stopped. In general, this is very limited and not very useful.
> > That's why, I am not very keen to carry the support into the new driver.
> > However, I don't want to break perf for any existing hardware platforms.
> > If everybody agrees that we don't need legacy perf implementation for older
> > implementation, I will be happy to drop PATCH 4.
> 
> IMO we should keep it for a bit, so we have a transition period.  These
> extensions are pretty new so we won't be able to count on everyone having
> them yet, this way we'll avoid breaking users.
> 
> This generally looks good, but I don't see any Acks from the perf
> maintainers.  I'm happy to take this through the RISC-V tree, but I'd
> generally like to have at least an ack as perf isn't really my subsystem.
> MAINTAINERS seems to indicate that's Will and Mark, they're not To'd so
> maybe they just missed this?
> 
> I fixed a few trivial checkpatch warnings, updated Atish's email address,
> and put this on palmer/riscv-pmu.  Happy to hear any comments, if nobody
> says anything then I'll just put that on riscv/for-next whenever I get back
> to my own email.

Fine by me! Most (all?) of the other drivers under drivers/perf/ are for
arm64, so I'm more than happy for you to handle the riscv one yourself.
If I end up with something that touches all of the drivers then we can
use a shared branch or something.

Will
