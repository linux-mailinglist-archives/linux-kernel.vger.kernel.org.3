Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4146A082
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388725AbhLFQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442405AbhLFP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:59:12 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C910C08EB4A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:42:58 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u74so22090701oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hSfDh7txPsCycOs0HAwdmZonlUVK7JVMigsN8QRLArU=;
        b=L639osgIuxzP6akD21MGy3O6Ndpnqd2XYz6qZEokZS29GfZRMZGA+s2YDzVOCqI79c
         R+LFM6MRgCtbinRnAB+OwABEgwTPHAFf1m8nnFvyR4QR4GE1MPivd/DGCHyRd1sk7YTy
         b81JHHZsgL9eQPOUhUVjYBF23yK+C4Yeoi7wYJDhpH3uwh+Y+upMCpesHgCqUw7l5kYw
         mqSlLGK5Xi5K+m0bHdRVsgdqRM6vt02/N+WXxBZPxRBJHyczvtOisEt7aoD4N8Nn7BK8
         zYXEwzXbwu2+f62F/ylU0gLVYDVlvt+snaxhwyT41wmdFJwBKufaqwht86wE9K0vpP9C
         yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hSfDh7txPsCycOs0HAwdmZonlUVK7JVMigsN8QRLArU=;
        b=gk33oV8sQ4nhgacbo9SsyaQ+7CRNxpPd3gGPaPM/YXxevAnYq7FfC1VLKZMXETV/ob
         uOS+Gz5EJp7hhvLTRQuSSyig+NRhjFLiFtPMxV3bK4CuuF45nK0BQocN/BgptGYAcjEY
         XS8T5aKg9xpKXchGUioL0ZXH/cjdIgz6NvT9F8QerNpZNa1yrCIF+zjX2d0EVBDlOS/k
         ADQkQ09lhgTtXN9gwZvDU/XonZoeaUNS/fKL7HNrL1Nks77adMdg1Q8LHtiVOGdXSO6S
         PiODobnHfSGhtUwzOAdUS2Cr2mBbeNOcUlEDOYENdEJezbKQW89SMiNB6yyNSNlBDGqa
         iYGQ==
X-Gm-Message-State: AOAM5327p6DqQoSfYH39pNTyz+z3sx6sKx/KKsmWak+cbuQXkYbxerOW
        Cegi50OS11DtmCd0AOIYUZteig==
X-Google-Smtp-Source: ABdhPJx5cAznI7khSOPAIAXSRq2RqYuzmYvaDs63fsXB+ucYlnOMXGc8z7DWJ0RPmuy3nPu6/PqEbw==
X-Received: by 2002:aca:1b08:: with SMTP id b8mr23615727oib.148.1638805377692;
        Mon, 06 Dec 2021 07:42:57 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d8sm2791187oiw.24.2021.12.06.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:42:57 -0800 (PST)
Date:   Mon, 6 Dec 2021 09:42:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: qcom: smd-rpm: Report enable state to framework
Message-ID: <Ya4vfCZ8UTVBRpYU@builder.lan>
References: <20211109022558.14529-1-shawn.guo@linaro.org>
 <YYpMzau3CWRQYlkJ@gerhold.net>
 <20211110131507.GJ7231@dragon>
 <YYvNmrSeJNCE4BEC@ripper>
 <20211111093926.GL7231@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111093926.GL7231@dragon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Nov 03:39 CST 2021, Shawn Guo wrote:

> On Wed, Nov 10, 2021 at 05:48:10AM -0800, Bjorn Andersson wrote:
> > > IMHO, properly reporting enable state to framework is definitely the
> > > right thing to do, and should have been done from day one.
> > > 
> > 
> > I always thought is_enabled() should reflect the hardware state - in
> > particular for clk_summary. The particular concern being that by
> > initializing the is_enabled() state to either true or false, we're
> > making an assumption about the hardware state. And if something where to
> > do if (enabled) disable (or if (disabled) enable), we might skip a
> > critical operation just because we tricked the logic.
> 
> That's probably why clk_smd_rpm_handoff() is called.  As there is no way
> to query RPM for resource state, we send enable request for all RPM
> clocks to get hardware and software state in sync.
> 

clk_smd_rpm_handoff() will ensure that all SMD clocks are enabled, and
at max speed during rpm_smd_clk_probe(). Once clients starts actually
voting for rates that will change.

(Un)fortunately as we don't provide an implementation of is_enabled()
clk_disable_unused() won't try to turn them off. This similar to a
problem I have elsewhere, for which I proposed:
https://lore.kernel.org/linux-arm-msm/20211203035436.3505743-1-bjorn.andersson@linaro.org/

We should at some point introduce this for the SMD clocks as well.


However, we have two problems:
1) Compiling e.g. the interconnect provider as a module would mean that
clk_disable_unused() kicks in before the client has had a chance to vote
for the clock.

2) One client may enable the clock during its probe and then disable it.
Being the last active user the clock framework happily turns off the
clock.


For both of these cases, we need to ensure that the clocks aren't
disabled until sync_state() kicks in.

Regards,
Bjorn

> > So, do you need it for anything other than clk_disable_unused()?
> 
> Not critical, but I need it for debugfs clk_summary as well.
> 
> Shawn
