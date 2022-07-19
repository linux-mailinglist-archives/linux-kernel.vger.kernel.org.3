Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A65791C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiGSETR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiGSETK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:19:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095B3AE6D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:19:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c3so11532284pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRXpkzFCaONc6uIVW7OHVXWrx1/ZSo2vjvlOlBazeIk=;
        b=DRjY/k5F4uoLY5Z0MV/U+eii0rcgt1LVT/Y9xiRMLQK6sfxMwKS2pQCYV5UtxxNINV
         ZNkZCzHhp4anjvWElcaBFa8siXkTy+1bJlYkPeevoaw7Vh9KU/WJ81vqGSeJ6Z1AzQDK
         q9x8HPbiHIslAVdLTn4VnJk6yH0j4actgvI9GEbHj4LNlSJgf1m2pPaIpP3Uij6Dz36c
         ddzx9vNbyZV7ZneqH8qdgq7YYtJVJbPNXuGZ0wrvXKo0zva2x8QejMUu8ykJ3g2Q2bk6
         X9OG1LiWF9ofE3uYZJSLvbVKNd4I0tbmbhRsNr29Fb77EOiJALCR5tTRzBLzuVRxA8Ie
         Ie3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRXpkzFCaONc6uIVW7OHVXWrx1/ZSo2vjvlOlBazeIk=;
        b=oqFdSUbLc/zuohO5lYChNOlP5KWhvpAr8n0cpMNApsAunw7YLjKEdk7SfqkLethddw
         Rj8ROIkazw8j2MORe0OXj9a9YAaiktC8zukOtGLScsbM1IfB4rdFzKbX2i2Ikjn7vWy2
         e2TGn73E2D+Fhgr64HIBIuaEbmSU3i2rpzBmI6zxaczJQWacZuvnM9QpL6e+m9lIu+pY
         99HWzzmjnQMS0XPrwDNMl9Cuz4tV0GZgNPDFC+pku0QOwmyP+HxelAnChDEpZQAf1uM/
         KThQpEUkyDgpAiu45p1yH7Bb8UiQvkwDsNEtN1kNeTurySb4H7IqcscJpyR1nMf5UuVc
         zDaw==
X-Gm-Message-State: AJIora/j5Bm2/9AlM+YGo8/0eT5TkpizttwM9SUer8g5eXkY6oZxNQku
        EEJILadPHOJhjgWkKSuF7u+7LA==
X-Google-Smtp-Source: AGRyM1vRiMVK3BuNDcvKsw/Kos77pHtWi9dvCe41+Gc7wm8NhqjA4yMjwKTxFTF8yIkK5RM+258btA==
X-Received: by 2002:a63:97:0:b0:41a:3c2:6238 with SMTP id 145-20020a630097000000b0041a03c26238mr11549036pga.499.1658204348031;
        Mon, 18 Jul 2022 21:19:08 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b0016c0c82e85csm10379725pla.75.2022.07.18.21.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:19:07 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:49:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] dt-bindings: cpufreq-qcom-hw: Move clocks to CPU
 nodes
Message-ID: <20220719041905.idpo5uemowgtu6yp@vireshk-i7>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <035fe13689dad6d3867a1d33f7d5e91d4637d14a.1657695140.git.viresh.kumar@linaro.org>
 <20220718204651.GA3505083-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718204651.GA3505083-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-22, 14:46, Rob Herring wrote:
> On Wed, Jul 13, 2022 at 12:22:56PM +0530, Viresh Kumar wrote:
> > cpufreq-hw is a hardware engine, which takes care of frequency
> > management for CPUs. The engine manages the clocks for CPU devices, but
> > it isn't the end consumer of the clocks, which are the CPUs in this
> > case.
> 
> The question is really where does the clock mux live?

As Manivannan clarified in another email, these clocks are actually consumed by
the cpufreq-hw node, so existing code was fine.

> > For this reason, it looks incorrect to keep the clock related properties
> > in the cpufreq-hw node. They should really be present at the end user,
> > i.e. the CPUs.
> 
> The issue is that the CPU itself probably only has 1 clock input (at 
> least for its core frequency).

Right, and they (Qcom) have skipped adding that in DT currently. I have
suggested to him to add it there, which will solve the issue as well.

> Listing out all possible clock sources in CPU node 'clocks' is wrong too.

Yes, we need to mention only the clocks which are consumed directly by the CPU,
maybe just one of them which comes out of cpufreq-hw node.

> > The case was simple currently as all the devices, i.e. the CPUs, that
> > the engine manages share the same clock names. What if the clock names
> > are different for different CPUs or clusters ? How will keeping the
> > clock properties in the cpufreq-hw node work in that case ?
> > 
> > This design creates further problems for frameworks like OPP, which
> > expects all such details (clocks) to be present in the end device node
> > itself, instead of another related node.
> > 
> > Move the clocks properties to the node that uses them instead.
> 
> What's the purpose of freq-domain binding now? I thought the idea was to 
> use that instead of clocks directly.

Not always I think. It provides register access for programming or voting for
the clock, etc. Yes, the code won't do clk_set_rate() but the DT should still
mention the clock in the CPU node if it mentions an OPP table with frequencies
in it.

-- 
viresh
