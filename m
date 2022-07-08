Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67856B354
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiGHHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiGHHTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A87B345
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:19:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so1027075pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EgcXrxFHPmhqBnO22Uw6rifkBWhXEzlsDV2ZenDVWU8=;
        b=vU39rQY3c+OTwi/QX2HZiMp2QYsUfvKVx2zn6usRNfHNsEfY+XQm1hgSEt4DdABj+R
         BNsKnJ7MNpcIJ3+RU9Xqpq2+vUIjMIbjPjfiW/L0ullDWw21nN4N7vhcmv9SwjIm/reZ
         0D6JU2d9CJ09Uy6StGdnWRtxkxuDmur0f0cmeLDZfwiqOQe8OWeEPFtx8+yMSWPwbqDh
         mHd9z+NvBtNPrG9qafH6kWzHyUnKF204fzpR+3+mmVpqMb44pI7uLQ2v1zNL8yHKQflj
         tBOuwVHw7jOuNuV7I1YgF9/MVnEm1wR5ZcB7JzrDsprZEO05MU8Y+95LmzCspoQJTJ7A
         Cu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgcXrxFHPmhqBnO22Uw6rifkBWhXEzlsDV2ZenDVWU8=;
        b=RzXItzCH/S4+4A1RvYtS3ytQZuNNNZKD90hIMJyHWTQCxGdMUUHM9q+90J5PJe7Kiy
         CWSrKnA74w4fWnYNazowpv2vzhH424i8eB9C8P/beP4xLe9y3Yc+WSFjOmWnchwiCe2Q
         auj1+dLO99y+DILHVHCIFEVhz1gaDSrEKt3IAvXB+Ff2ciNIx93eP8MqH1xAxpJnqjcc
         fjgWDs95OKttrPZTt9ljob5G+AUeXUUXoD1perlE/7S595C3m9Clkz0SPjDN/NeaQWwn
         +BkOHWY8147lAMlIZy3GMOqYsabyAo/iqiTKoGV+dcbyTaBhULAkTrKcCRVltLz0ILQs
         P8Tw==
X-Gm-Message-State: AJIora8diKLq2CHso2ZL02VPcdgiHzMD5U+3D7XOZ2cBhD1kJfs4QmvJ
        KEejyGirtcJ87Hs5pVPda9rydQ==
X-Google-Smtp-Source: AGRyM1vZo8QUsmyZeVSd3mpHaBtw97+PUE+4i7ZXdQ6ibzdXhyINZfsmvaA1cspDz6ZTmsUrV7/sBw==
X-Received: by 2002:a17:90b:1807:b0:1ef:8aa5:1158 with SMTP id lw7-20020a17090b180700b001ef8aa51158mr10339270pjb.163.1657264768818;
        Fri, 08 Jul 2022 00:19:28 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b0016be7a89ac9sm9777958plx.94.2022.07.08.00.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:19:28 -0700 (PDT)
Date:   Fri, 8 Jul 2022 12:49:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <20220708071926.zehurtbcf35s5tv6@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <d557bbd0-2afb-12dc-1287-1aeb44ef55f5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d557bbd0-2afb-12dc-1287-1aeb44ef55f5@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 22:43, Dmitry Osipenko wrote:
> This patch breaks Tegra again, please take a look:

Damn, not again :(

>    OPP: Remove dev{m}_pm_opp_of_add_table_noclk()

Why did you mention this patch ? This just removed an unused API,
Tegra should have broke because of something else, isn't it ?

>  8<--- cut here ---
>  Unable to handle kernel paging request at virtual address ffffffff
>  [ffffffff] *pgd=9effd861, *pte=00000000, *ppte=00000000
>  Internal error: Oops: 37 [#1] PREEMPT SMP ARM
>  Modules linked in:
>  CPU: 3 PID: 8 Comm: kworker/u8:0 Not tainted
> 5.19.0-rc1-00040-g30b62d123f4f #82
>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>  Workqueue: events_unbound deferred_probe_work_func
>  PC is at _opp_compare_key+0x40/0xc4
>  LR is at 0xfffffffb

How is LR set to such an address ?

>  pc : [<c0b91b54>]    lr : [<fffffffb>]    psr: 20000113
>  sp : df831b08  ip : c33cd4d0  fp : df831b24
>  r10: c2586078  r9 : c258606c  r8 : 00000000
>  r7 : 00000000  r6 : 00000001  r5 : c33cd480  r4 : c2586000
>  r3 : 00000000  r2 : c33cd480  r1 : c258606c  r0 : c2586000
>  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>  Control: 10c5387d  Table: 8000404a  DAC: 00000051
> ...
>  Backtrace:
>   _opp_compare_key from _set_opp+0x80/0x408

Whatever happened, happened from _opp_compare_key() and I tried to
look at it many times, couldn't figure out what's wrong there.

For the device in question, pmc I think, we don't have any "opp-hz"
property in the DT, but still the OPP core will fetch its clock and
set clk_count to 1. But this was working earlier too, we were
comparing the rate anyways. I think one of _opp_compare_rate() or
_opp_compare_bw() is broken here, but I just couldn't figure out. The
rate one should run one loop and bw one should just return. I don't
see why a crash should come out eventually.

Can you help debug this a bit ? Also see what are the values of
opp_table->path_count and opp_table->clk_count, should be 0 and 1
AFAICT.

Sorry about this Dmitry, I think we are all settled and again went
into crap.

-- 
viresh
