Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE19C577974
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiGRB5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiGRB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:57:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B6DECE
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:57:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v21so7787106plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qFwGFcEKEQw3yJ7UGKN0HjyfrAbYSulURdjdgoshPik=;
        b=TNUZQC9kGZ+kGAQNU7B0mUUu2K646jYzhGxe13ErMPxTuWHQ5A3WufDM12XUzinf3s
         n8goKXvkcvUhgMPyTK9Jv9ktpeJi8Wo2uXCTt6GsYBeCzvggAu8VYAy1rwuFZc2LhmKC
         WTWbTkPsc6uYPfLkraUjACiyySCzRVjc/KIeDb5lyZOd4DLAP+Sl3WyKKEm6r5p8dH5P
         CxiWYl0wDYuH6tFnVPPZzTlD+TRaDEsZtcdrRob4tPks5l28KR+Ws9G06PcNfRUSOUfN
         ZW/BENjxf9NmHPC3JbGiZ1QFkUVawr0E7Jp00Fl8eJj3TxtaXaVs4I0uIf4oUdH2Hu49
         nUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFwGFcEKEQw3yJ7UGKN0HjyfrAbYSulURdjdgoshPik=;
        b=cybgzQ+RBYOEmnHOBW4ZKht1YRyTQLsGcUr6Aa3TLBDwbmZblRrM9bfZ8cxKf0rbTp
         d3+/wlkZYihIr9eeNfYrAVZ2PB+vVR6tLDboIlVSLVHMGG3XAeISez8iHa+rllefLxk2
         KXptKsLXuAZI+fL5fADLOsNQ9iIfGPyqfQ7nbjXp7iGAg6g6oNfZavYoCAdRoV6Gg1RW
         s5IH89ikBQjxNOY0nnVgdJYTWHNbW1rKoccCminFWiIFoJHkKirYY7HUuA5A2CV8zS0w
         LpSXBeneoN8ekHfNrY+78Z0mHsgNRMicxZKJOKPVA/Hw+HIZncfB6PfFqXlSvguv7HjF
         OBkA==
X-Gm-Message-State: AJIora8X64nl07QgBi6gV2WD0C06DRgc78nUKx1rz2LZiYuciFLOWtwy
        qRvbAuwiT6JJHq9l5PCqmh0PkA==
X-Google-Smtp-Source: AGRyM1voJaQBp7UiP0HnDcWi/MPZsRbjZHLfBOaFNRkC/vvTFrkjVyWxp12IzNFGk7inIbdvCOYNpg==
X-Received: by 2002:a17:903:2c7:b0:16c:ebf6:db22 with SMTP id s7-20020a17090302c700b0016cebf6db22mr4687400plk.16.1658109464837;
        Sun, 17 Jul 2022 18:57:44 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w75-20020a627b4e000000b005251f4596f0sm7900487pfc.107.2022.07.17.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:57:44 -0700 (PDT)
Date:   Mon, 18 Jul 2022 07:27:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] cpufreq: qcom-hw: Move clocks to CPU node
Message-ID: <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715160933.GD12197@workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-22, 21:39, Manivannan Sadhasivam wrote:
> The clocks defined in the devicetree currently (CXO, GPLL) are the source
> clocks of the EPSS block (cpufreq-hw). And EPSS will supply clock and
> voltage through other blocks to the CPU domains. Even though the end
> consumer of the source clocks are the CPUs, those clocks are not
> directly reachign the CPUs but instead through some other blocks in EPSS.

Fair enough, o these clocks should be present in the cpufreq-hw node,
as there were.

> Initially I was temped to add cpufreq-hw as the clock provider and have
> it source clocks to the individual CPUs. This somehow models the clock
> topology also

Right.

> , but after having a discussion with Bjorn we concluded that
> it is best to leave it as it is.
> 
> The main issue that Bjorn pointed out was the fact that the clocks coming
> out of EPSS are not exactly of the same frequency that was requested.
> EPSS will do its own logic to generate the clocks to the CPUs based on
> the input frequency vote and limits.

The OPP tables, which are part of the CPU nodes, mentions clock rates.
Are these values for the cxo/gpll clocks or the clock that reaches the
CPUs? I believe the latter. The DT is not really complete if the CPU
node mentions the frequency, but not the source clock. It works for
you because you don't want to do clk_set_rate() in this case, but then
it leaves other frameworks, like OPP, confused and rightly so.

Normally, there is always a difference in what the OPP table contains
as frequency value and what the hardware programs, mostly it is small
though. It shouldn't prevent us from having the hierarchy clearly
defined in the DT.

Based on your description, I think it would be better to make
cpufreq-hw a clock provider and CPUs the consumer of it. It would then
allow the OPP core to not carry the hack to make it all work.

-- 
viresh
