Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075765AC99D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 06:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiIEEfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiIEEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 00:35:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229A248EA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 21:35:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q63so7097035pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=p7bpzUxA24JVBJL6tYO0cQUjiRQ/ywUI0NOz8q1iwAI=;
        b=Zz4nIDoEWyGiaK4nDcY1uwX4ASsnqLnRyJiiUsoh/AVeAPp+SS2dinlwOXgbbr6CZF
         0maI1ijyfiAla+LNJWV0rRuj33iX/NWHY3hSi+q+iKtPnRAjGBKn392PfWa+Ty/5LRqS
         IcuYI6vgiqygCyE+NX9YVaUq9tLaFG9a2I3zqMrS0GPtyNc4aijTFLO+3ou+rTXCQhu/
         fTZblg+SJfcVySNwFp5s4BAaA+ay+0oU7uJ+CP9GRjqaMwfrt+0ID0aCzsEGjpFDM3HV
         rjLFSIrMidQTYSHnReHIdixJZewhphkaKMyR7Ic/PGoKIx4TzPgS2tCKWJi2630TpyR7
         TGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=p7bpzUxA24JVBJL6tYO0cQUjiRQ/ywUI0NOz8q1iwAI=;
        b=AxK8tqv6uDh/hnI1vmJP67OQNmeQizSdlN+LHRJ5q/BZjRerlNVw1OhDt1IqJuPCHI
         wzznfsayrLbFS7pwUOZ/CEnWCNYREkI0m1Wugh/4CmOcOaDBdP9vHcPWQCETiF50OEyg
         bWNKve7UYyFUd6+Vw7/fnIGWepZRnaO9KFnKrvbP1RB2TcHyMwzW5viAldBMEOb/A2cy
         SbFA9a7hr8aaUd5RRLIGf05XxbWcYnmKDXesJ1RuKjVj8+1lNNEwaTQIsVTdOKMCvexB
         +67J7f7IdYOokUG2grrLFVqpsbdGKbyBeFfX+Wiy9IfeyLNh6m8p3XshTpvJpqJa8WVX
         4ujQ==
X-Gm-Message-State: ACgBeo3nfPFVaItzk3egsmKQIVhs6jmAuT7VVOCezls2CBIxDSTvNFSd
        rJHDz1trcknmPKEf1TSMa/3lyg==
X-Google-Smtp-Source: AA6agR5dxNMK2DdrCeyQfDls0gXLKTkCjQPQZR8JSOr5ufsQdLqQd8kref3Q8T/8KJhIx2XogqpKWw==
X-Received: by 2002:a05:6a00:cd:b0:535:d9e2:d137 with SMTP id e13-20020a056a0000cd00b00535d9e2d137mr29739901pfj.29.1662352546905;
        Sun, 04 Sep 2022 21:35:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0015e8d4eb1d7sm6328318plg.33.2022.09.04.21.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 21:35:46 -0700 (PDT)
Date:   Mon, 5 Sep 2022 10:05:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
Message-ID: <20220905043543.huxq7mmpclto2h7k@vireshk-i7>
References: <cover.1589528491.git.viresh.kumar@linaro.org>
 <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
 <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
 <CAJiuCccmVtyHbd7ZvEwmw67aesyPe=eVzSE5z_KjCC5__7brjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCccmVtyHbd7ZvEwmw67aesyPe=eVzSE5z_KjCC5__7brjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-22, 22:35, Clément Péron wrote:
> Today, I compiled my kernel without any program requiring GPU
> computing at boot. This makes the dev_pm_opp_set_rate() to never be
> called and so the regulator is not enabled before the regulator
> framework switches off all the regulators that haven't been enabled.
> 
> Unfortunately switching off the GPU regulator makes my board hang..

Why does the board hang? I mean the kernel should boot fine with the
GPU disabled, isn't it ? Or is the regulator shared with some other
critical resource, or something else.

> I'm not sure what is the best approach to fix this.
> 
> Is it required that the dev_pm_opp_set_rate() must be called one time
> at the GPU driver init?

Right now, Yes. And it looks like the right approach as well.

> Panfost already calls devfreq_recommended_opp() and dev_pm_opp_put()
> but that doesn't trigger dev_pm_opp_set_rate().

Can you also point to your code ? Which file are you working on ?

-- 
viresh
