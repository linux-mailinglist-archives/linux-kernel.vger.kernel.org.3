Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746624AA081
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiBDTxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBDTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:53:17 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64738C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:53:15 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s24so2083202oic.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlfMiSQDubj+Ph8MLvtPCvN6/ufw7ffJHZWfJEWSM7s=;
        b=DmZVl3HhtwyFLwUwi7HO1+M0i+lCxDISV0wxDw5RqxrQtuIfzfn2AtQJTe+gC0x+L0
         tQRfEqm2UTKOqTnGFVVwEsFbOAKBYIqzquLFzOBFOH81dMl+v79dLs+aRHbnhoNiz5fF
         nePK9zYZHUZDtWKk7Y3dmMMs+qTwS3eDOo+pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlfMiSQDubj+Ph8MLvtPCvN6/ufw7ffJHZWfJEWSM7s=;
        b=HDEYnvjGsl5gfkqdKyggyGzxlpgEjfiJemcyzI3k03I7bx2IQHBUrE8KgFsjov0j3g
         l21LxFIkYbZ0ytLSPIS8gkV3OGbqkdzHpZgjV48yerCbfRZTjbsLssyMy4t+Ehdlr2Sf
         GVGs+8YhyaIWlb/6+bKRWh6p7LIU9EoZfyzClS2dZoz3ydKxY2hQTEij4TueMkBf+pPt
         kF3Q/2JDDqP3WLZ5t80mreWYwUNHXAOQZLa/7vJjZnYSBXVJZCne5bS92zgs607VfsKU
         gGWdDOnPgDy1Jw4MV2WjMCRZHOfthIcfI64SIYlP0QZy5HnF2O8s0DlD4A6fD3SFMNq+
         p3Ng==
X-Gm-Message-State: AOAM5316vKzHlXhBrmOSSyUJcMl0WKpwGeKLrl3QW93HDuEmQ0RWJsly
        68aGD0jxL3cxA1ALuuAzOexZQSfWS+ITGA==
X-Google-Smtp-Source: ABdhPJzQE/0QJuGAOYiVsEcKYkn2HZ+pXDvJHnYS6lvg8+GFnNc1Z0FvyMDlbviRjf4II7a98sPCwQ==
X-Received: by 2002:a05:6808:3096:: with SMTP id bl22mr305511oib.280.1644004394483;
        Fri, 04 Feb 2022 11:53:14 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id k19sm1055102oot.41.2022.02.04.11.53.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 11:53:13 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id m10so9781418oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:53:13 -0800 (PST)
X-Received: by 2002:a05:6808:2026:: with SMTP id q38mr2109037oiw.243.1644004392644;
 Fri, 04 Feb 2022 11:53:12 -0800 (PST)
MIME-Version: 1.0
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk> <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk> <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk> <Ye87P19+JOjPEGTY@google.com>
 <Yf14RJbM10O3RdA+@sirena.org.uk> <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
 <Yf2BTelNlqplv06/@sirena.org.uk>
In-Reply-To: <Yf2BTelNlqplv06/@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 4 Feb 2022 11:53:01 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMJB4Egohc_V=su-tE=pU76=6zbmXSoptwwwbype1F7sw@mail.gmail.com>
Message-ID: <CA+ASDXMJB4Egohc_V=su-tE=pU76=6zbmXSoptwwwbype1F7sw@mail.gmail.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 11:41 AM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 04, 2022 at 11:21:51AM -0800, Brian Norris wrote:
> > We do actually have a cache for the case I care about, but there's
> > also a debugfs file for bypassing that and...for some reason I'm
> > dealing with some diagnostic scripts that purposely toggle that. I'm
> > not sure how wise that is, but in general I like to reduce the number
> > of ways dumb user space can screw things up. I've even had to tell
> > people that recursively grepping through sysfs or debugfs is a bad
> > idea...
>
> Are you sure this extra thing that bypasses the cache isn't an out of
> tree patch?  It really doesn't sound like a good idea to have that, and
> if people think they need it they probably have drivers doing something
> quite unfortunate.  Or are you just looking at the upstream debugfs with
> some volatile registers?

https://git.kernel.org/linus/d3dc5430d68fb91a62d971648170b34d46ab85bc
regmap: debugfs: Allow writes to cache state settings

And it's still there:
https://elixir.bootlin.com/linux/v5.16.5/source/drivers/base/regmap/regmap-debugfs.c#L521

Again, I didn't claim the *use* of that bypass in the aforementioned
diagnostic script was a good idea...but it's at least possible. I've
already carved out more exceptions so that script doesn't do bad
things on some systems, but maybe I'll poke the authors even more, to
see if they have a good reason for using the bypass.

Brian
