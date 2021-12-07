Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBAE46B360
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhLGHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:10:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53138 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhLGHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:10:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63758B816A1;
        Tue,  7 Dec 2021 07:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69468C341C1;
        Tue,  7 Dec 2021 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638860828;
        bh=+2G/X5h3+hoYNKZYrwC4jUbRuh1P7OkgWwsP4LDLnyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2/t/5C1Y3UeAUtmCEQrkuXmrwdtbX/q4YuJ4wQ/NPupe2+6VWL7VtfORTwSJGQoc
         Z2i7+ufESsn6D9DQ92u8u2ZFzAjiBOTz369/vdJbU+PSNuzk7l90Fw/cLGBQuSSxsJ
         AXBm0cgYR+hSqQ2zd7As10LO0SM3IRrFousT89mPGPwus+TqWNST/lpmASShHY7gAe
         E8QBfKRr8hmRdoJor0Se6aHdX3M3Mf2VmgAB4ZSq7ddj42XtzUiX9VvKikavdwrDap
         72WCWwvElZhUNslWdQvw/ldIiw9iX8PGolJud10bT/cWiEjihkQPocp/8wfn+7DHsB
         L3cdhFaIsbwOw==
Date:   Tue, 7 Dec 2021 12:37:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Message-ID: <Ya8IGPJCBl+seblO@matsya>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 19:56, Bjorn Andersson wrote:
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. Failure to enable these clocks seems
> to have been silently ignored in the past, but starting in SM8350 this
> failure will prevent the GDSC to turn on.
> 
> At least on SM8350 this operation will enable the RCG per the
> configuration in CFG_REG. This means that the current model where the
> current configuration is written back to CF_REG immediately after

s/CF_REG/CFG_REG

> parking the RCG doesn't work.
> 
> Instead, keep track of the currently requested rate of the clock and
> upon enabling the clock reapply the configuration per the saved rate.

With that fixed:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
