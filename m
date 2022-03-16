Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759184DB52F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357339AbiCPPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiCPPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:48:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC66D1BA;
        Wed, 16 Mar 2022 08:46:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a8so5068243ejc.8;
        Wed, 16 Mar 2022 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3ts7NrETiD/n+vGF+vAT89sY+x2BlKtnOMPf3PZf04=;
        b=Lkv9c8HyZ6iRngQe1gj3rOwvUiOqcf11dtCXHUzAo430dtSDwHvHNs73TVoH3YS0EI
         8w9dXdJzXDyU6d9rI+E19PoW/DaPwiqFAAp7P1JDGN9ZQ4sMe4KHGPn/JL+0RDSNQP5b
         DAEn2FiUzfv6OQpa8T7/GPntezVHuP6TPzbAqpE9xydvP+P3f3LlyBA4hYYPQ7vcSMyK
         KOQcog8dO8ZeouHQDnuu9hE4XAb4lZ/pqxIUX1f2bpcH9EwMyi1SpLh70mPoVXl+/4Kt
         BXqz0jqaT1yXASDhiHXQaaRw7hn7TqmZ7ttmuZML+vpdPvN3IIalWLAInye23B5fqvbA
         c6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3ts7NrETiD/n+vGF+vAT89sY+x2BlKtnOMPf3PZf04=;
        b=hRTXUEERQ8O5wWns6ekfFO1Yy/jdRBrCItp74NxSBRIygEdDFloySWwyL8tUv0j98s
         yy1U1PPskjFIU8XbEeBopWhGrQB3OT+XGJ2Wq6/O5vObCNS/F/DRvIEczZC94PGk0/PV
         Or0pz5EBb/AK0iciD/ZJRGAQJnp9qmG0tJ7fX6DoyGMA4IUiXo0dvWPCGtP0yaI9EBoL
         lVm5s78/6glzCuvKF09DWeGu+zCyMM38kXVhlAve5SqlpEMLg5zgZD3JdOOBT7V4wEhA
         fFq7HMq6dEhyQKhWC/2dmeIFa8sX5yYSp1uylIl0r9XvWFspOwV78HH4N73TM8DmaTgP
         FD4Q==
X-Gm-Message-State: AOAM533SzPFYWa1GRuPzI/+dFjBix1qst8EnSzlYqj6kGOfHtg5exhuN
        TRRH5Wp8wj6RP2uVMXDzxq6JdKqMk1U=
X-Google-Smtp-Source: ABdhPJwTDo0b3UgbE88SkpZ3LeHwHJ4IP8X1wdvjwxvXjhF64Gmi2f42UFZQA6PavRIQ4AtL/D4JDg==
X-Received: by 2002:a17:906:1e4c:b0:6cf:7429:cfea with SMTP id i12-20020a1709061e4c00b006cf7429cfeamr556994ejj.158.1647445617173;
        Wed, 16 Mar 2022 08:46:57 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id sb31-20020a1709076d9f00b006ceb969822esm1042752ejc.76.2022.03.16.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:46:56 -0700 (PDT)
Date:   Wed, 16 Mar 2022 16:46:54 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 12/16] clk: qcom: clk-krait: add 8064 errata workaround
Message-ID: <YjIGbs+Pz2EK9riB@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
 <20220313190419.2207-13-ansuelsmth@gmail.com>
 <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org>
 <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain>
 <20220315213431.DB6C4C340EE@smtp.kernel.org>
 <YjEJjB/Hwj/1Ncum@Ansuel-xps.localdomain>
 <20220315224115.EA1F9C340E8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315224115.EA1F9C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:41:14PM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-15 14:47:56)
> > On Tue, Mar 15, 2022 at 02:34:30PM -0700, Stephen Boyd wrote:
> > > Quoting Ansuel Smith (2022-03-14 05:43:20)
> > > > On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> > > > > On 13/03/2022 22:04, Ansuel Smith wrote:
> > > > > > Add 8064 errata workaround where the sec_src clock gating needs to be
> > > > > 
> > > > > Could you please be more specific whether the errata applies only to the
> > > > > ipq8064 or to the apq8064 too? 8064 is not specific enough.
> > > > >
> > > > 
> > > > That's a good question... Problem is that we really don't know the
> > > > answer. This errata comes from qsdk on an old sourcecode. I assume this
> > > > is specific to ipq8064 and apq8064 have different mux configuration.
> > > > 
> > > 
> > > I think it was some glitch that happened when the automatic clk gating
> > > was enabled during a switch. The automatic clk gating didn't know that
> > > software was running and switching the input so it killed the CPU and
> > > stopped the clk. That lead to hangs and super badness. I assume it was
> > > applicable to apq8064 as well because ipq8064 is basically apq8064 with
> > > the multimedia subsystem replaced by the networking subsystem. Also I
> > > wouldn't remember all these details because I worked on apq8064 but not
> > > so much on ipq8064 :)
> > 
> > Honest question. Do you remember other glitch present on the platform?
> > We are trying to bisect an instability problem and we still needs to
> > find the reason. We really can't understand if it's just a power
> > delivery problem or a scaling problem from muxes or other things.
> > 
> > The current problem is that after some time the device kernel panics
> > with a number of strange reason like invalid kernel paging and other
> > strange (or the device just freze and reboots, not even a crash log)
> > Many kernel panics reports the crash near the mux switch (like random
> > error right before the mux switch) So I suspect there is a problem
> > there. But due to the fact that is very random we have NO exact way to
> > repro it. I manage sometime, while playing with the code, to repo
> > similar kernel crash but still i'm not sure of the real cause.
> > 
> > I know it's OT but do you have any idea about it? If you remember
> > anything about it?
> > (To scale the freq i'm using a dedicated cpufreq driver that works this
> > way:
> > - We first scale the cache to the max freq across all core, we set the
> >   voltage
> > - We scale the cpu to the correct target.
> > This is all done under a lock. Do you see anything wrong in this logic?
> 
> I honestly don't remember much anymore about this. It's been a decade.
> Scaling the cache used to be an independent clk and operation vs. the
> CPU. Basically the clk domain and power domain for the cache was
> separate from the CPU. There's also the fuse stuff that means you have
> to read the fuse to know what OPP table to use. Otherwise you may be
> overclocking the CPU or undervolting it. It may also be that cpuidle
> can't happen during a frequency transition. Otherwise the clk gating
> will be reenabled when the cpu startup code reinitializes all the cpu
> registers? I'd have to look through some old vendor kernels to see if
> anything jogs my memory.
> 
> > To mee these random crash looks to be really related to something wrong
> > with the mux or with the cache set to a wrong state)
> > 
> > Thx for any suggestion about this.
> > (also I will update this commit and mention both apq and ipq in the
> > comments)

Hi, i'm checking the spm qcom idle driver and something doesn't look
right to me... Aside from the different sequence used for boot cpu and
the abset l2 sequence, it looks like to me that WFI is enabled anyway
(even if it's not defined in the DTS or set disabled) and on top of that
it looks like we overwrite the WFI logic but we actually set to
enter power collapse (spc). Why?

Also I think we are missing the assembly code to enter wfi on krait cpu.
Am I totally confused or there are some problems in the code that nobody
notice?

-- 
	Ansuel
