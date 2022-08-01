Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735CC5862B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiHACiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiHACiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:38:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50C13CFD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:38:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t2so9250777ply.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yvmSjML8a5pPk4nlvJWOM6aDBbo3zvbP+pNRPGiTonI=;
        b=vA3/CQNlFFtMHU+07rq77cfaOIAsYb+ML1fq7rQQD67WeXZiBMzCJ9lZ63IFx7zgl0
         FLDjLtpvfXTNSHvqFR3QWxDqQFYZFC186vmKschB2UBJA2vRI9sJGAA2HRXObFSTENs8
         hGc51EQt43kRo8nP7AMUHJV8nZe7Th/dENdEJ9p6jt5HYoc1Jeioj7lS+n1tw/OoPA36
         BWNVBlJlo3OMTyxYKbyAT/WsRpyJv0Wjq9SknmR+TQOlVq9MVf/ZOJV26Vbjxj3HgP+U
         fvgpCQq3IYem8qJ9rAT3KBhA5Y9HwCc/Ov2qaV6Z7tAFBOJAs1QX6ON1Ah2VrqFujU0J
         YWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvmSjML8a5pPk4nlvJWOM6aDBbo3zvbP+pNRPGiTonI=;
        b=nwj0lvgOacviTlXfNnqbol7bokNgjBa4Obu8ZKCOxT5gTUfNKhWNSZfOlcgpIsFK/N
         cy055NzA5ZbrOq/NCBgP2nDgQGJ4c718NnjtKK5qUVu3QWoYh8FtugGJUDiO/XSAIOVk
         cMh3LVdNZF3m5Er8cvQeN5U1+lNeq4cvUFACbU11lNIxnyNu7uN/dyri/6N4y5qU+2ll
         eGtRjmFPwtnTv2jdStzeRYvLb7qP+4ljWAcfWDYF411ou507zCRW8tWvmYb04MM4oaeI
         S+qmQs3OuFQb4m6N0Xf7wXumjF/Gr8p/GyyT8qSmsHnez5rhqq4WA+yznffjDKWdSv34
         C7+Q==
X-Gm-Message-State: ACgBeo3uBUbgZA+HeAg55dF99F14v3hdumMjc9Pex/1uox045FWlIC5k
        OFFNtDCnWM1P24b2BITgpao/0A==
X-Google-Smtp-Source: AA6agR4z76zzZuloVZRYXx+iiBvptQGrQ0c6R1Pm71Sj+85P7YkqFiRVHXE3d5bSSHDrA2vuEGRVLQ==
X-Received: by 2002:a17:90b:4b50:b0:1f0:5643:fa5c with SMTP id mi16-20020a17090b4b5000b001f05643fa5cmr17836502pjb.131.1659321485726;
        Sun, 31 Jul 2022 19:38:05 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0052cdb06c125sm5015850pfy.159.2022.07.31.19.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:38:05 -0700 (PDT)
Date:   Mon, 1 Aug 2022 08:07:56 +0530
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
Message-ID: <20220801023756.76jswkbwivuntqof@vireshk-i7>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
 <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-22, 07:27, Viresh Kumar wrote:
> The OPP tables, which are part of the CPU nodes, mentions clock rates.
> Are these values for the cxo/gpll clocks or the clock that reaches the
> CPUs? I believe the latter. The DT is not really complete if the CPU
> node mentions the frequency, but not the source clock. It works for
> you because you don't want to do clk_set_rate() in this case, but then
> it leaves other frameworks, like OPP, confused and rightly so.
> 
> Normally, there is always a difference in what the OPP table contains
> as frequency value and what the hardware programs, mostly it is small
> though. It shouldn't prevent us from having the hierarchy clearly
> defined in the DT.
> 
> Based on your description, I think it would be better to make
> cpufreq-hw a clock provider and CPUs the consumer of it. It would then
> allow the OPP core to not carry the hack to make it all work.

Bjorn / Mani,

Can we please get this sorted out ? I don't want to carry an unnecessary hack in
the OPP core for this.

-- 
viresh
