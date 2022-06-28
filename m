Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608F55C545
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiF1HJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiF1HJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:09:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59B1C924
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:09:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h192so11354003pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3XMK98yTF7rwQ7mnNqiKavXCsADLxJEzVfR+4Zz4WF0=;
        b=zWSmtNZ9qNY6UVxItaNgbAeLqd5873FBJyKmcWEeCrm6xpPi5/FSSNwO6dcTsTDqfq
         DnvwpQ+94ZnXYb9D20ym7ZWBx0eCNxk/GVk4kGINYnhQ6dIHCycrjeCQIXhpuEVsqluI
         dlRx0guc1WFWLchA1qpzXHQgZQtlCyzEiIqx9gj+s8BK4k9XIWukz3FVBH26XcA4foHq
         0uBmm0VTpl7A6iKt2KatPhABuvIFNhG8I7DdXPeF9Lx3l1a80XnHWwJyJkFsGw9kqwwO
         Qtosfyt9lwP9C2O/chNro/bxsb/hU3c1CdLJwWDdcJhGFVdPiv82JjvnKi+g3moOwG7T
         sESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3XMK98yTF7rwQ7mnNqiKavXCsADLxJEzVfR+4Zz4WF0=;
        b=FRT+/ou5aqWSj79bPGYfz1uQHemR9CSRtgK+r+a0i9qYxo5UzIPjLeIKOWyO2/gxk1
         Qp/FEC7E6UfO80Ht0iUKMikteAIxX/LbRtaYmxogtBRGpM4OEEPtQClWyhq/dzlzVywk
         B8AOoWGyWe3cQevn9gN7vYQkjBvPW2V3rhGItDeYDG2JJVNx+OO89b0LwdU4woutKtI1
         m2lnjeDL8U3ONXxHOOnd6ISHViey8XmeL67TFBZCtBtyfiisMk9oIPhzVjt+yovK3Pdr
         T0YsN8B7urpYQyFsa63DOGwdrvWlu1RrzXdPrhhiK35YNIT+oLk/jzq9AEtPmXSpzFzA
         aHSQ==
X-Gm-Message-State: AJIora+qNXMCb89ZkAQuGdnvTH7hW5qQxN9jii5MMxk/R8FlRfFtuPiZ
        5aWGWosQnltb/Y+T2KEmjRH1rA==
X-Google-Smtp-Source: AGRyM1uEl0n+zjcKdvvyyLVPuhE9wU3a13Tz8GsNbCb4aCUjWCDeNHLF2ac7/nnQGXUqy1ODqa1Hyg==
X-Received: by 2002:a63:3713:0:b0:40c:b98c:5e4b with SMTP id e19-20020a633713000000b0040cb98c5e4bmr16156287pga.8.1656400185761;
        Tue, 28 Jun 2022 00:09:45 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b0015e8d4eb1dbsm8412488plk.37.2022.06.28.00.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:09:45 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:39:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220628070943.5tfyad63rh6niq6x@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
 <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
 <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-06-22, 12:51, Viresh Kumar wrote:
> On 27-06-22, 10:14, Dmitry Osipenko wrote:
> > 27.06.2022 09:45, Viresh Kumar пишет:
> > >> Looks okay. If you'll solve the cpufreq problem where OPP config is set
> > >> by two drivers for the same cpu device
> > > This is supported, there is some early freeing of resources on the
> > > removal path though, the reasoning for which I already gave in another
> > > email. Though, I am open to sorting that out as well, but nothing
> > > breaks the code for now AFAICT.
> > > 
> > 
> > In case of Tegra, we use tegra-cpufreq driver that sets supported_hw and
> > registers cpufreq-dt. If cpufreq-dt driver defers the probe, then the
> > supported_hw will be lost on the re-probe. I haven't checked yet, but I
> > suppose that cpufreq-dt driver defers on Tegra30 because of the CPU
> > regulator and that's why we get the "OPP table is missing" error.
> 
> Aha, I get it now. I see, this is a real problem. Will fix it. Give me
> some time to think. Thanks.

Okay, I fixed this in opp/linux-next, can you or Jon please give it a
go on tegra30 to see if the issue is fixed ?

FWIW, I have fixed this with the IDR API and the OPP core will only
free the resources in clear-config, that the corresponding set-config
has configured. I have tested it with the clk API only though.

Once you confirm, I will resend all the patches and hope no issues are
left here.

Thanks for helping out guys. Really appreciate it.

-- 
viresh
