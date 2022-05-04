Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0C519CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348074AbiEDKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348069AbiEDKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:31:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BE26AF0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:27:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so799899pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n8vzoy3N7pBPE7Pl8WE2bInrudsdOONjhf3PaHQ1svY=;
        b=HVmmccbsvIcZmOYCJcgcjO7yILm1zErYVEIzfrg8InamWDpIjN+6Q9P2ZLPFZ//sw+
         rOpmzpn4Tlpqgo5nIDx+9pvHbfvCvraETJu579UZDLCnABxGO4c0KDol8D43LNEKyXSd
         gv3Bl1JkxIdyijkF6B5xOOn/SHngzh+Ay7+mOkrrkSTERY8GV2w6Ympu0obKQdZcMk5z
         pfJglh8xBl3kfsZGwGSz2nwmAeVa0vD+OFeyK8j1Y0LBwGWajIWPQIjoaVqlaBmgEsJb
         9EkTQCYVkIFDmF2djn0cKTFoGIv5UFdE0TG8IR1kjrTsgsw+hG5SLZWJAM7SzARdpyIi
         fEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8vzoy3N7pBPE7Pl8WE2bInrudsdOONjhf3PaHQ1svY=;
        b=JimaE7sUg8/4kJmV2q9RpgBrTggxraN/sHCJpUfPhm7fMJuyP11Q5OR4O4e9aHYDBq
         Whw1HMRlJQtz3y7FXCyOdYKYsCEat+bOyF9v7rbXUsPfP8I4Yci3Q1MtmQ2XBkHAJvWG
         yxswxPnjp6YwdWsNhB6M8RUVOXS9+S/Sqpo04KrcUHcL3+3GuMnUb4Dyyi759UR/uNjM
         dSktJ0V+0ybAVqtUfaNYselUsnxgeiYPdq/+hFR3A7/O2/uYWIHRLyVLdX+bRQp39ya2
         /Tvkz9GPtR8bkwG+0Rtdz4ipcH972vLX+js3QIZhJ5FZSwx/RXbizkdchG/zyBl60OzC
         kk2Q==
X-Gm-Message-State: AOAM530TelWDw6WSbzJpxCxnoBMLAvlpdeYBe67ooYHCXrSsQz0WLQv1
        OveykfyHb81JgZLQEfhon4PPEA==
X-Google-Smtp-Source: ABdhPJxs5soROkk0kpKdyut/L8JDvItaFHJCeyHzhAOimp8VW+AG5fW4x5mr5jTnFDiY9DbdDgbONA==
X-Received: by 2002:a63:6bca:0:b0:3c2:13bc:2706 with SMTP id g193-20020a636bca000000b003c213bc2706mr11867564pgc.464.1651660067671;
        Wed, 04 May 2022 03:27:47 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a630200b001d5c571f487sm2938789pjj.25.2022.05.04.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:27:47 -0700 (PDT)
Date:   Wed, 4 May 2022 15:57:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>, manivannan.sadhasivam@linaro.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Apple SoC cpufreq driver
Message-ID: <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
References: <20220504075153.185208-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504075153.185208-1-marcan@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-22, 16:51, Hector Martin wrote:
> Hi folks,
> 
> Here's a second take on the cpufreq driver for Apple SoCs. This is a
> complete rewrite using a stand-alone cpufreq driver instead of using the
> cpufreq-dt infrastructure.
> 
> Since v1 we ran some experiments on the memory controller performance
> switching and it turns out it doesn't make a huge difference, so it
> makes sense to punt that feature to the future (perhaps once a proper
> memory controller driver exists for other reasons, e.g. for error
> handling).
> 
> One advantage of having a standalone cpufreq driver is that we can
> support fast switching. This also means any future interaction with
> the memory controller will probably use some bespoke mechanism instead
> of the genpd infrastructure, so we can keep the fast path without
> allowing sleeps/etc.
> 
> The driver is based on scpi-cpufreq.c, with some bits (e.g. the
> apple,freq-domain stuff) inspired by how cpufreq-qcom-hw does it.
> I'm not sure if that particular property should be described
> in a binding, since it goes in the cpu nodes (qcom doesn't have it
> anywhere...).

Hi Mani,

I can see that Rob asked you to add this somewhere, maybe in arm/cpu
stuff, but I don't think you ever sent a patch with that. What
happened ?

https://lore.kernel.org/lkml/20201013171800.GA3716411@bogus/

-- 
viresh
