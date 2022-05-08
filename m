Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821951EC0B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiEHHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiEHHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 03:20:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74516BF41
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 00:17:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so7050001pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pmia3f83d9c4z0pslQdQjq3eRCIFxyb8z/IWO9Z38ao=;
        b=t6kDm7iTCtb4FmyDMxma8umwQwzKL2JupjfLGk02JjYTGCWzc8I9DDOPnVU/JulmG3
         KszspKzJB8w+ttIZYkI7L9z8UUJJLtx7CRWRGfS4VPRBlXRFRwct2yAOUziTqaForIGg
         cQ2nzM8vWDrOU+oGjD+0OaCFvvIOTShiAvA3dEbYlt4A1OjormyjvG4wAs5wuCYWCo+v
         GtVuJvYGKEok/g5gq8PoHIBzscVGuzN6nrWgmAw/Oy8ah9YMJAt0zOlTYX64UPACkMcq
         6ej+hbT8CBfWY63RjIuDHc97Tm1zW/HQl8Zg9TEzo4m3QuLQ+oD/beHpyUnUbWMgCFBH
         JeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pmia3f83d9c4z0pslQdQjq3eRCIFxyb8z/IWO9Z38ao=;
        b=ZFBKwa53jORH5AG5lnl1VhL0SE5mYIOjbqkj+1MCSfCPAR7g+ReY1JF27S7dhzcVfH
         sg+ZtjDT8RUPj5avSI6Z9kth5U9YinkFIB5JTMRxwCTx2whrvSDUUGthT8ISzjv0kvCq
         r0cCaHD4tpS4RFwJE6n1f14G9hSK0nRkk+ujp0am87BukqIGN8vkp6rcUAeGwhcH6xOd
         h6yCtgMirGeyIulRqbKwIJA3yP7cgD4JXcwsrUssB5vgyTlvPbFBpJT+UkfAJLq7vP6M
         cWOU2QayTdIwSUQPLu8TdTouOYk7O6Gw5d3ttwxUuzcIE+l5LZEKNXM1PWbAZdHeVHHB
         iUPw==
X-Gm-Message-State: AOAM532Kia4+ywf3u/3mqmnUW7x/wht4HU/YrTrn7UlMvHThTKZpvTml
        rdxjYzAmVCtWOlaSx7FjVVjW
X-Google-Smtp-Source: ABdhPJxu5CrFctjLtjT1lTJIK1jFwL+XEsVaS5Sz7j5qObZKbONmEaEZJKQEO5T8vskmUppYOSmqGw==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr10673139pfw.39.1651994222762;
        Sun, 08 May 2022 00:17:02 -0700 (PDT)
Received: from thinkpad ([27.111.75.235])
        by smtp.gmail.com with ESMTPSA id iy11-20020a17090b16cb00b001dc37aef4ffsm6363055pjb.48.2022.05.08.00.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 00:17:02 -0700 (PDT)
Date:   Sun, 8 May 2022 12:46:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20220508071656.GA42059@thinkpad>
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
 <20220504160019.GB3507@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220504160019.GB3507@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 09:30:26PM +0530, Manivannan Sadhasivam wrote:
> Hi Viresh,
> 
> On Wed, May 04, 2022 at 03:57:45PM +0530, Viresh Kumar wrote:
> > On 04-05-22, 16:51, Hector Martin wrote:
> > > Hi folks,
> > > 
> > > Here's a second take on the cpufreq driver for Apple SoCs. This is a
> > > complete rewrite using a stand-alone cpufreq driver instead of using the
> > > cpufreq-dt infrastructure.
> > > 
> > > Since v1 we ran some experiments on the memory controller performance
> > > switching and it turns out it doesn't make a huge difference, so it
> > > makes sense to punt that feature to the future (perhaps once a proper
> > > memory controller driver exists for other reasons, e.g. for error
> > > handling).
> > > 
> > > One advantage of having a standalone cpufreq driver is that we can
> > > support fast switching. This also means any future interaction with
> > > the memory controller will probably use some bespoke mechanism instead
> > > of the genpd infrastructure, so we can keep the fast path without
> > > allowing sleeps/etc.
> > > 
> > > The driver is based on scpi-cpufreq.c, with some bits (e.g. the
> > > apple,freq-domain stuff) inspired by how cpufreq-qcom-hw does it.
> > > I'm not sure if that particular property should be described
> > > in a binding, since it goes in the cpu nodes (qcom doesn't have it
> > > anywhere...).
> > 
> > Hi Mani,
> > 
> > I can see that Rob asked you to add this somewhere, maybe in arm/cpu
> > stuff, but I don't think you ever sent a patch with that. What
> > happened ?
> > 
> > https://lore.kernel.org/lkml/20201013171800.GA3716411@bogus/
> > 
> 
> Oops. Looks like that one slipped through the cracks. I did add it to my todo
> list for qcom-cpufreq but missed it completely.
> 
> I will look into it.
> 

So I did send a patch for adding the qcom specific property [1], but Rob asked
for a common one and that's where it got lost.

But in the last revision [2], you've asked for converting the qcom cpufreq
driver to support the generic performance domains instead. For maintaining
compatibility with the old dts files, we need to support the qcom specific
property as well.

I will send a series for that.

Thanks,
Mani

[1] https://patchwork.kernel.org/project/linux-pm/patch/20201020153944.18047-1-manivannan.sadhasivam@linaro.org/#23718065
[2] https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-4-angelogioacchino.delregno@somainline.org/ 
> Thanks,
> Mani
> 
> > -- 
> > viresh

-- 
மணிவண்ணன் சதாசிவம்
