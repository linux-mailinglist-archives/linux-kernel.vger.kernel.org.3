Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4724DBFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiCQHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCQHAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:00:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B87B859;
        Wed, 16 Mar 2022 23:59:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a5so6114854pfv.2;
        Wed, 16 Mar 2022 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bTvA02fwUpyoJi/TzzKPy+j0AsQcZbGmLjHeosuRf4Q=;
        b=pTGUQD+ckQk39GSvZd5kI1ahBZ0yEYZAb7yDmSWUWOXhgYqtbS5sQyXRgTgBnogrth
         R9qNKKLCg8KXg20mdV9Q/q1Lh+xnuqMCSW1OW/xZ836JF2btzp7Uuui2fOowHfOmhJyr
         nZ+hmUcokobxlSaJ2ZQ7qiA5q7q5omaLaiOW6v0ciAv289ZHGrA1+bngMu9kF1P/xFys
         DAmVZsU3+/R9v6gwvQLlIY6v/rB/Ha4Ry2Zxr87FPcKjBBbi1N5Q4ljyIWEaKyYozYIf
         sQmkco0WX8O+9/uXXa6mIteeW/9T8exZy4UZrMg4TGESFaqyoemtJAVuf8bGjK1mlKZV
         B6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTvA02fwUpyoJi/TzzKPy+j0AsQcZbGmLjHeosuRf4Q=;
        b=154oGisoVMD/UH6Vr4SnpMPvPRnLDQrGs2wAJNIFqnm34/EjeRDPP3bPbvjqwOOMNR
         1a3zmbMawfe+SMIXhinbbUjoMcc4xkYF6rWjqhwqV3KUWkfztqElQ6PWfn7y7pFGp/Kj
         62iuMqU50cUMx5cNb1YgzP73WQMx0frcAQGWShTbLomYQpr9Sl8rH4u9IAMpO/E6GfCw
         PApRExIAIKRMVAkx7iscOESkmbne8TU33tcMB69epGQraPxe0I6/PU+h8UITa5ZtUoua
         MpBd9ElUlalc31lm8RonCpCFO8oFCMu2c5mNIvaIyGgVSE5icl/A+M3Cro/fEQx9f0zW
         dBYw==
X-Gm-Message-State: AOAM532/Uz0OZ7aWhQc5XeLq8z5g59Mf71veG7cijMPfzQaT9jRgFovG
        BknVyV0UGRcfNvbv0n0JLt0=
X-Google-Smtp-Source: ABdhPJzIXGxkuvnkQM2cnNQzBYQ2FKsgiG91ui1C5izJ0oeQe+1doQKw4YWF0CThFj3ChdYUqe8p5g==
X-Received: by 2002:a05:6a00:b52:b0:4f7:ae2d:64a with SMTP id p18-20020a056a000b5200b004f7ae2d064amr3672127pfo.0.1647500371837;
        Wed, 16 Mar 2022 23:59:31 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm4275259pgn.2.2022.03.16.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:59:31 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:29:25 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] clocksource: arch_timer: Add arm,cortex-a7/15-timer
 in of_match list
Message-ID: <20220317065925.GA9158@9a2d8922b8f1>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
 <f54b0647-12ad-5861-8b8b-5d4233bb9bd2@canonical.com>
 <20220316174108.GB21737@9a2d8922b8f1>
 <87zglpybzw.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zglpybzw.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:43:15PM +0000, Marc Zyngier wrote:
> On Wed, 16 Mar 2022 17:41:08 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> > 
> > On Wed, Mar 16, 2022 at 05:30:26PM +0100, Krzysztof Kozlowski wrote:
> > > On 16/03/2022 10:54, Kuldeep Singh wrote:
> > > > Few platforms such as Renesas RZ/N1D, Calxeda, Alpine etc. are using
> > > > arm,cortex-a15-timer and arm,cortex-a7-timer entries in conjugation with
> > > > arm,armv7-timer which are not currently defined in driver file. Add
> > > > these entries in arch_timer_of_match list to bring them in use.
> > > > 
> > > 
> > > This looks wrong (also Marc pointed this out) and rationale is not
> > > sufficient. Why do you need these compatibles in the driver?
> > 
> > Hi Krzysztof and Marc,
> > 
> > I find myself in trouble whenever dealing with compatible entries and
> > had 2 options when I stumble this issue.
> > 	1. Remove unused compatible
> 
> That'd be silly.
> 
> > 	2. Add required compatible to binding and driver
> 
> To the binding, yes. But to the driver?
> 
> > My past experience and advise from other developer says not to remove an
> > existing compatible. And also I found "arm,cortex-a15-timer" in binding
> > which was again not documented and was present in DT. This prompted me
> > to go for second option and make necessary additions in binding and
> > driver following current entries.
> 
> The "arm,cortex-a15-timer" compatible is documentation, and only
> that. If, one day, we find a bug in this implementation, we could work
> around it in the driver thanks to the separate compatible (although in
> this case, we'd have much better way of doing that).
> 
> > As per your perspective, current configuration isn't apt which means
> > "arm,cortex-a15-timer" is a stub and is wrongly present in binding.
> 
> That's not what I said. This compatible string is perfectly fine, and
> accurately describe the HW. The driver doesn't need to know about the
> fine details of the implementation, and is perfectly happy with the
> current state of things.
> 
> Think of it as an instance of a class. The driver doesn't need to know
> the instance, only that it is a certain class.
> 

Thanks Marc for sharing knowledge. This was indeed helpful.
To sum up from what I understood, bindings and DTs should always be in
sync and driver file may not need to define all compatible entries as
long as purpose is served.

This means no driver change will be required to address
"arm,cortex-a7-timer". To which I have a question to Krzysztof.

Hi Krzysztof,

As per your comments on 2/3 patch, that it's DT which is not aligned
with binding w.r.t arm,cortex-a7-timer.

What makes "arm,cortex-a7-timer" an invalid entry from binding
perspective when we have a similar entry "arm,cortex-a15-timer" already
present?

I think we should share some common grounds here and keep both of them
in bindings or remove them altogether. I prefer first option, What's
your say?
Or please let me know in case there's better way to address this.

- Kuldeep

> > I also observed many other DTs have compatibles which are not present in
> > driver. What is an ideal idealogy behind such cases?
> 
> I think I've made myself clear above.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
