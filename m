Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E7533BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiEYLrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiEYLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:47:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EFA2062
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:47:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd25so26689577edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z94MYv8k8bV/URFvVno28GWfvWkQrgsJ5KRI8yTugR8=;
        b=PKnJP1N9bdSX6/NI2eXSMyoHNNNQ4ZilFOFVTnP8GGV7IfCA08sjwrlTgB2j55elS+
         3LZhMvAnn2WqUChs4tV3g2cFIa1E61te7QByECiWhABglyDNQc4SrCf8UfawajTzz8Ei
         6KL66Y+HabypAccOiufHZZ40QmFG4Vi3LouqxmvTU17YiudVCyeWVW+i/FJCBiHIGqLY
         hzvQeDej4s6BkVyxYEW0gfRCMTh+QR8wknATbdY07Ht7bw/8F/ZYEZqBW39YVE75ksWr
         FS7/FuYrAuyvJs7AgZa7zUaUQKX2YCVyoIedY+cze7Od2pYG9MdB7dOSNxKD/Y9gRdIj
         7RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z94MYv8k8bV/URFvVno28GWfvWkQrgsJ5KRI8yTugR8=;
        b=ZrvgDgjf8QRAbNcBjgiTeqhScEq/atF1NeqSNGDtLpxVjOdL6ljxduw79+lRU6KTMX
         5nv7xtgaAyDrBZLUgfg6a2DooMOmOsw+JD2Wa+oOg4vgbh+Luak7kBvc45e69AIx99YI
         vIO2bad6aqKDM6fHBC1GlwidZViLRgx7Mg38vcZgekKlOS1JpE6HrX0yVS51T94NILna
         /uPoRJHp/nQlRUmj27C5pUME2uPPrS/QgAcBRHYRhetuphQoTFF5yieBpR7wFfY8EzDU
         KTYlkZyxt0naV+Acr2QAPWdcS7hC7mlvVFbRnOwRzN5fxCO4MQGqnNI8TRTE5IecUkrf
         N0uA==
X-Gm-Message-State: AOAM530Jdgh2TJtJqGbxXePGatyCJ+anV4/SsF20UbMkgnQexxvylWQA
        ppTbjUA89wJzjPCzUI/oBys=
X-Google-Smtp-Source: ABdhPJxoF//fOej66iB4b5rW/cuygMP/GrO2SHWL+w8vk0TC6EwuCCiP4dT1aiSALl1m7eRD6g9fuQ==
X-Received: by 2002:aa7:ce08:0:b0:42a:f7c9:2afd with SMTP id d8-20020aa7ce08000000b0042af7c92afdmr33632130edv.344.1653479246241;
        Wed, 25 May 2022 04:47:26 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c455000000b0042ac2705444sm10494717edr.58.2022.05.25.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:47:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 25 May 2022 13:47:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.19
Message-ID: <Yo4XSzZp68hGAZnF@gmail.com>
References: <You+G0njuvLvLll3@gmail.com>
 <Yoxx5MeAyIki0peI@gmail.com>
 <20220524140035.GL1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524140035.GL1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> > >  23 files changed, 266 insertions(+), 331 deletions(-)
> > 
> > Note that the above is a v5.18 based shortlog and diffstat, but because the 
> > RCU tree deep-merged one of the scheduler commits that introduced better, 
> > Kconfig-invariant preemption model accessors:
> > 
> >    cfe43f478b79 preempt/dynamic: Introduce preemption model accessors
> 
> Ah, this one:
> 
> cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")
> 
> Please accept my apologies for the disruption.  This commit was needed
> to be able to properly handle CONFIG_PREEMPT_DYNAMIC=y kernels booting
> with preempt=none or preempt=voluntary.  But I should have called this
> out in my pull request, and failed to do so.  Again, please accept my
> apologies for the disruption.

No problem - Linus pulled the scheduler tree and all is good now I think.

Thanks,

	Ingo
