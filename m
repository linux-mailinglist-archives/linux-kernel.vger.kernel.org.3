Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7203B46BA83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhLGMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:00:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhLGMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:00:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ABDDB8175A;
        Tue,  7 Dec 2021 11:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A806C341C1;
        Tue,  7 Dec 2021 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638878220;
        bh=JcW7ci8RbLsx6u2WpWy/2v/wuQmtntbx/AliqDvbN1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcVVh60Tzs+r2saCFrhrsuBFu0KdTOWxNmfjuVPKNJbOjv3p5e9XwWI4F2LOBxWc9
         uVj+B8wusK0sfm3UPWU5U/rjCMDVpL5Lw2aKmJdxlBl+ddp3hCrf8feOWz5LljAnwB
         L8jE9Th2ijrJ+nHD9cdpAP3R1NENfNL8EpCApQziYTmqWrhudHLmlbDu9NR3xBUPYU
         a5AfcJcio6hJHqwrq1f2KOXtWj/GAiahUekyWRzSZtN6xTgzKKKWN99JrNY4ZrtRQl
         Sk/w65oeCQh3+9bAA0Ex8WgeKDejf+9rSWPgBVJe5k44liWkturyPig1AfyMWPawOP
         IRsO2/Mn4sijQ==
Date:   Tue, 7 Dec 2021 17:26:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM8450 interconnect provider
 driver
Message-ID: <Ya9MCCYHIAjaW6GM@matsya>
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-3-vkoul@kernel.org>
 <b4c43541-ffcd-d43c-3405-86d770905dd2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c43541-ffcd-d43c-3405-86d770905dd2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 18:46, Georgi Djakov wrote:
> Hi Vinod,
> 
> Thanks for working on this!
> 
> On 1.12.21 9:25, Vinod Koul wrote:
> > Add driver for the Qualcomm interconnect buses found in SM8450 based
> > platforms. The topology consists of several NoCs that are controlled by
> > a remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> > 
> > This is based on the downstream driver by
> > Vivek Aknurwar <viveka@codeaurora.org>
> 
> Maybe CC him too.

Will do

> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/interconnect/qcom/Kconfig  |    9 +
> >   drivers/interconnect/qcom/Makefile |    2 +
> >   drivers/interconnect/qcom/sm8450.c | 1988 ++++++++++++++++++++++++++++
> >   drivers/interconnect/qcom/sm8450.h |  169 +++
> >   4 files changed, 2168 insertions(+)
> >   create mode 100644 drivers/interconnect/qcom/sm8450.c
> >   create mode 100644 drivers/interconnect/qcom/sm8450.h
> > 
> [..]
> > +static struct platform_driver qnoc_driver = {
> > +	.probe = qnoc_probe,
> > +	.remove = qnoc_remove,
> > +	.driver = {
> > +		.name = "qnoc-sm8450",
> > +		.of_match_table = qnoc_of_match,
> > +		.sync_state = icc_sync_state,
> 
> We should set this callback only after we enable the client drivers to
> request bandwidth. Otherwise some path might get disabled because of no
> users. I would suggest to add sync_state after we describe the paths in
> DT.

Okay thanks for the suggestion. yeah we have only few paths described. I
will keep this as a separate patch and send few months down the line :)

-- 
~Vinod
