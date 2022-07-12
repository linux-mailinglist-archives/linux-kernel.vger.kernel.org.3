Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E5571380
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiGLHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiGLHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:52:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CF9D504
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:52:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so6828219pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDE9efA6tNnV2IAGh2LYLxXJO4QIDeRatDZhQ/9xv0Y=;
        b=aIVJoOrYsOxTCnwRWJsJsadg8YScTtWaD0KWY7O/2+d8GVdTuEwcbqHC65rXN8wf++
         3HyfuAZeUSNgl+yUHx/5KlRezG7txR0FdQaKUCs2dK0RgqKtkIgKMHUn4a3fWXtchUD8
         g7IW4PdmeGjP3yX98W+7cqVp78RzOGcfYR2jVyT+kDsObWUtEQhH3ipi3c2vyzkFN7va
         evzX9xXekM3lXyocMknYXWvrCdbXQa0fWYKFk+OPPr6btstHwE+thj2ExuI+0c/1nZaE
         VVpSXpq1Vet9CUK+J3jdAlNviHFp/4+V2qoSblLUDATIq/8mDyFEOkl3La/CM4Q0VqgH
         8E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDE9efA6tNnV2IAGh2LYLxXJO4QIDeRatDZhQ/9xv0Y=;
        b=yIyGt9qD/5qqsYaAH+GUqIZjxlvcIahe/n73PnU6+tZkzBa53uCZ6Bp9/hL45IDYKp
         eNaK6iABiRkxIodMhlEDyvRmLUkYA8AhPoy6IexK4tUjnsJSfy/zrEJFv5nds3a8tSfT
         J/uWnTwaR/gnxvLoaMn5ZaGDua7VaAmBaBMGKaxifI3E8AC15kF/FZg4vbuzIa3Hsl9/
         ZWCL2FFfkHoiFWOK9hbYM/na2I6wRFqkN8E+2TmCUg6HdPeUbbOu6y0YqzsbhDFNFQws
         YK9RXP5tb0jrafycnBpCNtXHRzCQ6nKOR92u7/CCyvXc9RrohDCNV3hoH97N5Xo3Nccj
         kvVQ==
X-Gm-Message-State: AJIora/imi5xtSK9+TJTy96m1wDrGFgTB/ZWnG7pjKxhChoHOgh8SQCq
        Hefi4u8lqtq4SK1oigQIvVTRXg==
X-Google-Smtp-Source: AGRyM1vRTqycGBlzrqk2OttaehDP+MhVi+0ovxCWFXTXmuSWvayqxox7e6xtAjUzE9s1bj017NCd/Q==
X-Received: by 2002:a63:754:0:b0:415:4578:248a with SMTP id 81-20020a630754000000b004154578248amr19503049pgh.196.1657612362818;
        Tue, 12 Jul 2022 00:52:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016bdf53b303sm5739118plk.205.2022.07.12.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:52:42 -0700 (PDT)
Date:   Tue, 12 Jul 2022 13:22:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsxSkswzsqgMOc0l@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-22, 18:40, Johan Hovold wrote:
> This break OPP parsing on SC8280XP and hence cpufreq and other things:
> 
> [  +0.010890] cpu cpu0: _opp_add_static_v2: opp key field not found
> [  +0.000019] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -19
> [  +0.000060] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 403200000, volt: 576000, enabled: 1
> [  +0.000030] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 499200000, volt: 576000, enabled: 1
> ...
> 
> I just did a rebase on next-20220708 and hit this.
> 
> I've narrowed it down to _read_rate() now returning -ENODEV since
> opp_table->clk_count is zero.
> 
> Similar to what was reported for tegra for v1:
> 
> 	https://lore.kernel.org/all/58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com/
> 
> I don't have time to look at this any more today, but it would we nice
> if you could unbreak linux-next.
> 
> Perhaps Bjorn or Mani can help with further details, but this doesn't
> look like something that is specific to SC8280XP.

It is actually. This is yet another corner case, Tegra had one as
well.

I have tried to understand the Qcom code / setup to best of my
abilities, and the problem as per me is that qcom-cpufreq-hw doesn't
provide a clk to the OPP core, which breaks it after the new updates
to the OPP core. I believe following will solve it. Can someone please
try this ? I will then merge it with the right commit.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 666e1ebf91d1..4f4a285886fa 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1384,6 +1384,20 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
        }

        if (ret == -ENOENT) {
+               /*
+                * There are few platforms which don't want the OPP core to
+                * manage device's clock settings. In such cases neither the
+                * platform provides the clks explicitly to us, nor the DT
+                * contains a valid clk entry. The OPP nodes in DT may still
+                * contain "opp-hz" property though, which we need to parse and
+                * allow the platform to find an OPP based on freq later on.
+                *
+                * This is a simple solution to take care of such corner cases,
+                * i.e. make the clk_count 1, which lets us allocate space for
+                * frequency in opp->rates and also parse the entries in DT.
+                */
+               opp_table->clk_count = 1;
+
                dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
                return opp_table;
        }

-- 
viresh
