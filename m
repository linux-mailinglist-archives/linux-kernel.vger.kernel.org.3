Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0D4DA4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiCOVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352030AbiCOVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:49:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC112607;
        Tue, 15 Mar 2022 14:47:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so2192498wmj.2;
        Tue, 15 Mar 2022 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVS5/8gEjVie69Zd1ZcQN/pGDDEZHwC8MbV9kBXhXw4=;
        b=JtRDL+jzbA2CpurhEq5sqgs358rQIRV66oS4ax27Q5FIwee91BsFKXRfAcsyZW+Yg5
         V8ns6DXulMc+y79s5zhn+KblPUpB6ufd/w34jdO6HJaKIrmSMMteg+BQ7yNQywPqwgYd
         3tAyl9IP9vggSW7W1QUBDeXYJoP+36xSVuobPkL2ykUq7czylMI5nuyi1ys+fbT5VsvY
         +6ozn4khs71KEWDEmHBeyWX7et0PllMbAS2hnN0/2tsiKZmgkW1mLH9FL43LXMzzWO4l
         zR4PvF/akG7dFa++4h8HMIsP72Y4Gpfep/hIBTaT9jfMVTqnA/rLKFyPX8H8tWVlklkH
         nGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVS5/8gEjVie69Zd1ZcQN/pGDDEZHwC8MbV9kBXhXw4=;
        b=em2ruH9o0ZRC65OBDPtt0qVVgZuklmAkRhX0h0NNKdPn9kFPCxP4ZAHC7ltXqdMUt0
         GtkR1hURGhltjIq0mtvpN38nw6V+riwfDE7Onuo/KSVfP0uEE53Xe5ZK2YNAoTKY7WKp
         iyALZVqp9lK1H7Y479E2oImzN8hkM6IjoGL+UQdCMMJqjOvHGf1slEfmBihSv30zD4O7
         9PeSgLN5sDTmPqPkN1DdGO9pred6jQZsYbWGTmvKSLQbruSVQQi4sbGYlRD3o4PdT/p7
         skXhBx4T/jBWej7nZZzYVHX39sG935qzVpzW8LSwFU7lFtrjWED+MDUrsnPPUiGI2ieb
         +qpw==
X-Gm-Message-State: AOAM531qGvGJ6gyYH0p2R9IzD7xIkz69m9WFr4i41JWuG7adWxGbs9R/
        oqEGUdq8Cf3dtuPFVj9AWBM=
X-Google-Smtp-Source: ABdhPJwOrSdxpfcB+uohas2LIQ75m5vJw/ALpy3BAkbWX8f2zPpTcazNBqNf3LZE1b5IpEg2uguYoQ==
X-Received: by 2002:a05:600c:19d4:b0:389:d5d2:e90f with SMTP id u20-20020a05600c19d400b00389d5d2e90fmr4930004wmq.103.1647380877546;
        Tue, 15 Mar 2022 14:47:57 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d4586000000b001f0436cb325sm113567wrq.52.2022.03.15.14.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:47:57 -0700 (PDT)
Date:   Tue, 15 Mar 2022 22:47:56 +0100
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
Message-ID: <YjEJjB/Hwj/1Ncum@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
 <20220313190419.2207-13-ansuelsmth@gmail.com>
 <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org>
 <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain>
 <20220315213431.DB6C4C340EE@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315213431.DB6C4C340EE@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:34:30PM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-14 05:43:20)
> > On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> > > On 13/03/2022 22:04, Ansuel Smith wrote:
> > > > Add 8064 errata workaround where the sec_src clock gating needs to be
> > > 
> > > Could you please be more specific whether the errata applies only to the
> > > ipq8064 or to the apq8064 too? 8064 is not specific enough.
> > >
> > 
> > That's a good question... Problem is that we really don't know the
> > answer. This errata comes from qsdk on an old sourcecode. I assume this
> > is specific to ipq8064 and apq8064 have different mux configuration.
> > 
> 
> I think it was some glitch that happened when the automatic clk gating
> was enabled during a switch. The automatic clk gating didn't know that
> software was running and switching the input so it killed the CPU and
> stopped the clk. That lead to hangs and super badness. I assume it was
> applicable to apq8064 as well because ipq8064 is basically apq8064 with
> the multimedia subsystem replaced by the networking subsystem. Also I
> wouldn't remember all these details because I worked on apq8064 but not
> so much on ipq8064 :)

Honest question. Do you remember other glitch present on the platform?
We are trying to bisect an instability problem and we still needs to
find the reason. We really can't understand if it's just a power
delivery problem or a scaling problem from muxes or other things.

The current problem is that after some time the device kernel panics
with a number of strange reason like invalid kernel paging and other
strange (or the device just freze and reboots, not even a crash log)
Many kernel panics reports the crash near the mux switch (like random
error right before the mux switch) So I suspect there is a problem
there. But due to the fact that is very random we have NO exact way to
repro it. I manage sometime, while playing with the code, to repo
similar kernel crash but still i'm not sure of the real cause.

I know it's OT but do you have any idea about it? If you remember
anything about it?
(To scale the freq i'm using a dedicated cpufreq driver that works this
way:
- We first scale the cache to the max freq across all core, we set the
  voltage
- We scale the cpu to the correct target.
This is all done under a lock. Do you see anything wrong in this logic?
To mee these random crash looks to be really related to something wrong
with the mux or with the cache set to a wrong state)

Thx for any suggestion about this.
(also I will update this commit and mention both apq and ipq in the
comments)

-- 
	Ansuel
