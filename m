Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635858DA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiHIOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiHIOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:14:40 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE5DEDF;
        Tue,  9 Aug 2022 07:14:40 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id e69so9662799iof.5;
        Tue, 09 Aug 2022 07:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Qgyr+32CceGsT0l+h5ryRLscX/cbGb6A+xgqfxNnSjE=;
        b=uzd7OniKT7wJWEw5o23AGZgkWDwj/z2FPVxsUsyGOPRLpON+Mvz4l10tgPPTWhjnan
         5O3ihB9NEBop/gVmRW+hnvEoD9t5NVRFvQsz7HL5ZgF/KAwI7SfOB9s24Uxc9BR1t1uv
         jyNGu3b7N0ZeZS+c0U2VsW0+zntrLvz3VPyRHu7thWI0UBGitK5vf1AkghIUsL4ThnSN
         IRFl74dElhjaca1/qTq3KbPgKdCNkNaYKQsUso8y2V5RRrNds/F6anVmy089tWT8XxqG
         a2AVXVgan6jzGxZTJLCQVntASaydQEk0o8u29eJifuCDQEARKEupyxy738HNMERg8svB
         2kdA==
X-Gm-Message-State: ACgBeo0raATBnJdnLBGMNNeZLUHHeg4gYuW2nt2hLnlCWepBjTE5OeES
        UE4/WuuKKKxLrJ46+LzxRw==
X-Google-Smtp-Source: AA6agR4Ha6qVwthQuAETuobnGoOie1LPqRZXH3lXZnPOwMUi0rO7JQSfIeH7D7YvlZQ/DynOPNiZxw==
X-Received: by 2002:a05:6638:1386:b0:342:8d69:71c2 with SMTP id w6-20020a056638138600b003428d6971c2mr10163189jad.315.1660054479123;
        Tue, 09 Aug 2022 07:14:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c20-20020a0566022d1400b0068226bcb7aasm1151011iow.38.2022.08.09.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:14:38 -0700 (PDT)
Received: (nullmailer pid 1746668 invoked by uid 1000);
        Tue, 09 Aug 2022 14:14:36 -0000
Date:   Tue, 9 Aug 2022 08:14:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     jrtc27@jrtc27.com, tglx@linutronix.de, maz@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, anup@brainfault.org, guoren@kernel.org,
        sagar.kadam@sifive.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Message-ID: <20220809141436.GA1706120-robh@kernel.org>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:01:11PM +0000, Conor.Dooley@microchip.com wrote:
> On 08/08/2022 22:34, Jessica Clarke wrote:
> > On Fri, Aug 05, 2022 at 05:28:42PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> The device trees produced automatically for the virt and spike machines
> >> fail dt-validate on several grounds. Some of these need to be fixed in
> >> the linux kernel's dt-bindings, but others are caused by bugs in QEMU.
> >>
> >> Patches been sent that fix the QEMU issues [0], but a couple of them
> >> need to be fixed in the kernel's dt-bindings. The first patches add
> >> compatibles for "riscv,{clint,plic}0" which are present in drivers and
> >> the auto generated QEMU dtbs.
> > 
> > IMO the correct thing is to have QEMU use a qemu,plicX rather than to
> > weaken the requirement that a non-generic compatible be used. Otherwise
> > you end up with QEMU using something that's marked as deprecated and
> > either the warning remains and annoys people still or it becomes too
> > weak and people ignore it when creating real hardware.
> 
> It's already in a driver so I figure it should be in the bindings too.
> 
> In arm's virt.c they use the generic gic compatible & I don't see any
> evidence of other archs using "qemu,foo" bindings. I suppose there's
> always the option of just removing the "riscv,plic0" from the riscv's
> virt.c

I think we're pretty much stuck with what's in use already.

I'm on the fence whether to mark it deprecated though if there is no 
plan to 'fix' it. Doesn't really matter until the tools can selectively 
remove deprecated properties from validation.

> >> The final patch adds some new ISA strings
> >> which needs scruitiny from someone with more knowledge about what ISA
> >> extension strings should be reported in a dt than I have.
> > 
> > Listing every possible ISA string supported by the Linux kernel really
> > is not going to scale...

How does the kernel scale? (No need to answer)

> Yeah, totally correct there. Case for adding a regex I suppose, but I
> am not sure how to go about handling the multi-letter extensions or
> if parsing them is required from a binding compliance point of view.
> Hoping for some input from Palmer really.

Yeah, looks like a regex pattern is needed.

Rob
