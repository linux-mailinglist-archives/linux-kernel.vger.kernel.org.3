Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4425492340
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiARJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:53:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57844 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiARJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A1161256
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC096C00446;
        Tue, 18 Jan 2022 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642499584;
        bh=gMdBtQYDJLAK8ioF6FJ5GqmvRCsOVfKh/Bd5dSM7Cd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9nWilbQvN2UPwJIXW9PqFf3H7iD1TSxSZcRurbKlePMLcQqrX31PuyHQR0UqavMx
         0r09/g8K20ggi18Dja3gtc8Q5YFUsBfKn0FG9qx1+7XZQabl0UKau1r0JAM8KsE9Ha
         oe7x4Ii2iKDXIn4yir9f0VO6qpDgUHuXj6vW7hWTSJyhH0zlZ/zZeihQVwtZLtBFjs
         N6KOpukL46F8DC6gfQvr48vd6/q/m/uvwBHW6pmH/7zDMFcHq0+FiIIXg/3ZNgMXfJ
         lc09/KIkZPGol7P6pXzvbmCZpWpKzKTYATk7UKAx5RDMAfif4TwtW7U0yD+TkOsMY9
         QYe8iydunVhnw==
Date:   Tue, 18 Jan 2022 09:52:58 +0000
From:   Will Deacon <will@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, james.clark@arm.com, leo.yan@linaro.org
Subject: Re: [RFC PATCH 2/2] perf: arm_spe: Enable CONTEXT packets in SPE
 traces if the profiler runs in CPU mode.
Message-ID: <20220118095258.GA16547@willie-the-truck>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117124432.3119132-3-german.gomez@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:44:32PM +0000, German Gomez wrote:
> Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.
> This is no less permissive than the existing behavior for the following
> reason:
> 
> If perf_event_paranoid <= 0, then non perfmon_capable() users can open
> a per-CPU event. With a per-CPU event, unpriviledged users are allowed
> to profile _all_ processes, even ones owned by root.
> 
> Without this change, users could see kernel addresses, root processes,
> etc, but not gather the PIDs of those processes. The PID is probably the
> least sensitive of all the information.
> 
> It would be more idiomatic to check the perf_event_paranoid level with
> perf_allow_cpu(), but this function is not exported so cannot be used
> from a module. Looking for cpu != -1 is the indirect way of checking
> the same thing as it could never get to arm_spe_pmu_event_init() without
> perf_event_paranoid <= 0.

perf_allow_cpu() is a static inline so there's no need to export it. What's
missing?

Will
