Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9850AF42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443997AbiDVEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiDVEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:52:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313346B04
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:49:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w187so3033819ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/b3w8P6bSnNfxAO7ag4JKSVtKkG2fkyEmTQEAkbscs=;
        b=KJINXpYet8aUp8C/KTg+TqfMCepBCAW6P3mLf4r90SkX/8WfMhX5QFos+uaLjsQYLS
         qJH+ympXXIUTgufBH+Rgsd3Y4ofq9gyh/jacXGMgS4Q3POEQNZ9NGGvHqa7Qy+I6zaXo
         ibmYZfXo8CY4V9RSHV2ZHxtmbGic9VTvtySonnjZKXd81wHgC4kLJ0HwQcV+TAD8T9EQ
         ET06H1aJVNGJLcxmC4XqnXyNnWpjVW/zQ6Gp93XzuT1nw/7YZMkYFMiAvz6loCvvLXtP
         sKb/HhT2z4FJuHRB/fGHS2uWi2uqXnNdPJktwx9dRcwfMJ8Fc9UbWYqMggJ/jGEp0US9
         OoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/b3w8P6bSnNfxAO7ag4JKSVtKkG2fkyEmTQEAkbscs=;
        b=CtU5LHV1ynJ2LFFGcgoJwaQVNC/ojB0pI1oZ1sSY8pZWYxZw3B2b9cQTmOKyNPKC7Q
         4HZvEEcbC440FtDmVY2Y7lZx04U79OikOJOiPOFB6DrFkac4tvsNKRTDnrP+KAqG2188
         V2Rmd0V9U7ga9UVRCmPMnG/syRfBMALRYSgA7676yFveYy4rQczfWrFAXW/sPED6j4X4
         CCU3sDRbxPhLpeEUBfmTfSGEhsx+q67AANiaO6ojyHjWuWvaIjJZ15EnNopTxGNjMmBs
         tPiE39GFP5t2z42OUB+O3zEIMJijBQWSRnOcaJ5nijIfH7sanv8FP4ggcSmVHjBa51It
         pLuA==
X-Gm-Message-State: AOAM530ORcBqhxy5q7RdifKslw89CDikOvfEXO3DrGaip2PsCrMa1bbD
        HhB5bnwyIxbbYQvPSQ6empfWV9OzDEKVpMl+oHJ4Bg==
X-Google-Smtp-Source: ABdhPJwdxTs2hv0KjkLaK1w197ODv/+vWu74yWxNz56GC7PrApk3LFt317uWWvBPyTko3+1W+ejoyU9SS4a3l95qFxM=
X-Received: by 2002:a5b:50f:0:b0:629:5d05:aebf with SMTP id
 o15-20020a5b050f000000b006295d05aebfmr2859178ybp.618.1650602965328; Thu, 21
 Apr 2022 21:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org> <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org> <YmFJ4zKn/9MpjhOh@lunn.ch>
In-Reply-To: <YmFJ4zKn/9MpjhOh@lunn.ch>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Fri, 22 Apr 2022 14:49:14 +1000
Message-ID: <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 22:11, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I guess we can get at least some testing from the platform maintainers
> > to check that this doesn't regress the UP systems.
>
> I have a 370rd which is single core. Let me know what you want
> testing.

If you have a PCIe device that you can use with the 370 rd. Please
test that the PCIe device probes and generates its interrupts in
normal operation. I have sent out a v2 of this patch, So if testing
please use that version
https://lore.kernel.org/linux-arm-kernel/20220422043532.146946-1-nathan@nathanrossi.com/

Thanks,
Nathan

>
>         Andrew
