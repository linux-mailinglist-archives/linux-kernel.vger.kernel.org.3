Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBFD57D663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiGUV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiGUV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:59:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5293C3B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:59:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e69so5114930ybh.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QemyCLkI6dzlXbVvolGX70AxPDsM5uHjNFau1pouZoU=;
        b=EggV9eOe293C069t33s2imjH0DFks8SbaFyvA4mrzBn40aO4Zh1s/Y+o+PH03J0aum
         uKjahaNfKINcw/0Xsn87yqdaKC/X2YTOrTJTl0azsijsmNnir7bDIcgwI6B6774UoJXS
         eH3tBYgyM3zKs/Atfx6PPNT+ta/DnjRBC/UtVrIgetSvCy8qov1FzSwTFj1QIfAaC4ma
         NZd079sWBU28mv3DylqYcX0X4A8XJ4qk0PPuipu6fzXwjvdGUyYSMVC+IhllGKUPtNPu
         CqvnApM9NZAym5hGtTEHmwH3bFVsDbzxyiDLWMBZLt6ZfjNxb1lQibCkTcymqNvzkFew
         3jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QemyCLkI6dzlXbVvolGX70AxPDsM5uHjNFau1pouZoU=;
        b=YvPLqHWsk0sFLMCnLs+iV5LPMmhl3lHBWF94k4dm4Vx0OZu8yQbUBv+gmfeC4zH/Mj
         a5IJxfgcPr8WkoFjEDdlgiGqIcgIZViCIvEp+UPLBSKIRQYTkGtRAdKrX1pnKUgGvOUa
         ce0bnTLBMK8tc/56AqqzdgzkoUoWMFrg/zRLENu9ImNheAo76tY125yLpePEZELVr+Xg
         P6stu0XvgJkiZlEGi51ypL84xUlIylPFTZJiPeME4J4vpiqnqKIBYzaZNDLamsCIuiHR
         CVpJ/MmDIbwc9b8htEdqrAeokXpbtyLOS5cq+Ihnn1/TKmmcu4AA//B1ImeisHiVmUzs
         SUVQ==
X-Gm-Message-State: AJIora8F76NYIO0WJkTAvgJKdyKNEj+lneqV7n72X59cNZjnt8943XrV
        WRAeWBSxDCybFh3RklBEU+7ok2PD/Na8SRBQW6eIvw==
X-Google-Smtp-Source: AGRyM1tkHSFmZ4GKmUVpD2QHp8atjdn/vlLiq4tn3ktMlEUa04YiLlaNHlDvKpIgfQEUdIsme6hDzccfP5OU0SSG9OY=
X-Received: by 2002:a25:a86:0:b0:670:ef0:3159 with SMTP id 128-20020a250a86000000b006700ef03159mr500307ybk.563.1658440743770;
 Thu, 21 Jul 2022 14:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220719182010.637337-1-saravanak@google.com> <20220720131221.azqfidkry3cwiarw@bogus>
 <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
In-Reply-To: <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 21 Jul 2022 14:58:27 -0700
Message-ID: <CAGETcx8mVqX+FRiD9_PahpfQQ1CjG0FxN08pN7jgj+D4x2QjhQ@mail.gmail.com>
Subject: Re: [PATCH v5] amba: Remove deferred device addition
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 1:50 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 20, 2022 at 02:12:21PM +0100, Sudeep Holla wrote:
> > On Tue, Jul 19, 2022 at 11:20:10AM -0700, Saravana Kannan wrote:
> > > The uevents generated for an amba device need PID and CID information
> > > that's available only when the amba device is powered on, clocked and
> > > out of reset. So, if those resources aren't available, the information
> > > can't be read to generate the uevents. To workaround this requirement,
> > > if the resources weren't available, the device addition was deferred and
> > > retried periodically.
> > >
> > > However, this deferred addition retry isn't based on resources becoming
> > > available. Instead, it's retried every 5 seconds and causes arbitrary
> > > probe delays for amba devices and their consumers.
> > >
> > > Also, maintaining a separate deferred-probe like mechanism is
> > > maintenance headache.
> > >
> > > With this commit, instead of deferring the device addition, we simply
> > > defer the generation of uevents for the device and probing of the device
> > > (because drivers needs PID and CID to match) until the PID and CID
> > > information can be read. This allows us to delete all the amba specific
> > > deferring code and also avoid the arbitrary probing delays.
> > >
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > on Juno with linux-next(which had the reported issue [1]) + this patch(which
> > fixes the issue)
>
> Ok, but this patch needs to end up in the patch system for me to apply
> it. Can someone please add "KernelVersion: 5.19-rc7" or whatever version

Where am I supposed to add that? Just somewhere in the email body?

The patch you are replying to was based on your linu-arm/for-next the
day I sent it. Do you still need me to rebase it on Linus's tree?

> the patch was generated against (just the tagged version is sufficient)
> somewhere in the email, and send it to patches@armlinu.org.uk.

I'll send out the same patch as is to that email. Wait, is there a
typo in the domain name? Did you leave out the x by accident or is it
really armlinu? I'm also getting a DNS failure for either one of those
domains.

I'll wait to hear from you before I send another email.

-Saravana

>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
