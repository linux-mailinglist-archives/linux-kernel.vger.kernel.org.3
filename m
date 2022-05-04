Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4772251A4D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353026AbiEDQEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353060AbiEDQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:04:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56DBDF32
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:00:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so1482047pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkWAh/zEKnD9qRinAOAqcRHDKnyhx2C9kbdq3Vzq1JU=;
        b=ewE0aA6uLeto/nVe/PJGDnD5Zb6f5fg9VvE+LN/Ks9woM1TP5xCQCC3v05q+On3t60
         XHP2UQSObCPMbVOFXr5nELPeB+f06tSvBK1d1RvfXEumgOTQa7eLJzIBgDcXhehLjUJJ
         HVyVzMi+3plLFQRKAKXVJruM7qnNIvyKe7sbgKaeg1lK/18b2D4hruZr8O4w/5qIJ16U
         fRPi5vo1SGiNrNPUgYx4WE3O7kE/x5WNqCBFx8dUgwUL4GYu2RrSMNr5T6fyFaOVNg5z
         gT4vuRIuXSQ3zXvaHLXUNjF0m20ZfUEE4/Lb0p5e072jD7XhxteMcS3mjSrtFVg6ZWla
         Psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkWAh/zEKnD9qRinAOAqcRHDKnyhx2C9kbdq3Vzq1JU=;
        b=Jl13XNfDZZlHTptHYqHvFqqRh3TZ00wGdVkVJr2/4n1BceMlKtr5B50KSKDbB2daSk
         Gi+tILdNRyeNlFb7bnioQ3MWUCwJk7+oAhzCsgGdZTOL8tpzoYge3Ap6JJ7My5cDR3KV
         5otldwvEbHOXFPDtTB15wa9IRHxHlLHcwlDIcDKslQqGycJxTsRdAWgM3wh5Al+wiJAH
         PDiiPTuYfUSiKFZm3TPDIJgYxEFM7KqZT7ISVFNW36AdasZDfrC0bnBRp2ePiM1UEa0a
         wbJU3E9/JyE7GGo3sNBxljR5smcZnxfY5bThLxRQvJohRZ5tDpsDCQt1BchkXIOFx396
         zhcQ==
X-Gm-Message-State: AOAM531lxu5+I+MQ5itG7/tK+wxncHu+2iQ5wX/c2q0NDN3T2trXEMTs
        F8sV539wpR1k22ORj0eonmXG
X-Google-Smtp-Source: ABdhPJy9JetOr3XHoQXjint5jAscYPRn3DBeO/Mgpg4CnjM2dLrUuvZsZP/4GJjz1y6YrYXVCUiJDg==
X-Received: by 2002:a63:90ca:0:b0:3aa:fff3:6f76 with SMTP id a193-20020a6390ca000000b003aafff36f76mr18287435pge.206.1651680026330;
        Wed, 04 May 2022 09:00:26 -0700 (PDT)
Received: from thinkpad ([117.207.25.57])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b0050dc76281bdsm8383185pfm.151.2022.05.04.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:00:26 -0700 (PDT)
Date:   Wed, 4 May 2022 21:30:19 +0530
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
Message-ID: <20220504160019.GB3507@thinkpad>
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Wed, May 04, 2022 at 03:57:45PM +0530, Viresh Kumar wrote:
> On 04-05-22, 16:51, Hector Martin wrote:
> > Hi folks,
> > 
> > Here's a second take on the cpufreq driver for Apple SoCs. This is a
> > complete rewrite using a stand-alone cpufreq driver instead of using the
> > cpufreq-dt infrastructure.
> > 
> > Since v1 we ran some experiments on the memory controller performance
> > switching and it turns out it doesn't make a huge difference, so it
> > makes sense to punt that feature to the future (perhaps once a proper
> > memory controller driver exists for other reasons, e.g. for error
> > handling).
> > 
> > One advantage of having a standalone cpufreq driver is that we can
> > support fast switching. This also means any future interaction with
> > the memory controller will probably use some bespoke mechanism instead
> > of the genpd infrastructure, so we can keep the fast path without
> > allowing sleeps/etc.
> > 
> > The driver is based on scpi-cpufreq.c, with some bits (e.g. the
> > apple,freq-domain stuff) inspired by how cpufreq-qcom-hw does it.
> > I'm not sure if that particular property should be described
> > in a binding, since it goes in the cpu nodes (qcom doesn't have it
> > anywhere...).
> 
> Hi Mani,
> 
> I can see that Rob asked you to add this somewhere, maybe in arm/cpu
> stuff, but I don't think you ever sent a patch with that. What
> happened ?
> 
> https://lore.kernel.org/lkml/20201013171800.GA3716411@bogus/
> 

Oops. Looks like that one slipped through the cracks. I did add it to my todo
list for qcom-cpufreq but missed it completely.

I will look into it.

Thanks,
Mani

> -- 
> viresh
