Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FD54BFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiFOC25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiFOC2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:28:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B44DF5A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:28:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o16so13469680wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na2oOp1hRvl9W53PhhQRBpj8OcRTH2+o/fCj7cVNOSE=;
        b=kFn/mK5OVaqqw7nfeAsfeuirk6HGKHL+Mw1YwAsX5EgjBnwBmhCNBMdWvNfTUFGKpe
         HVUwdbnkVxFd7tL4J8owI5rjOw3ysrNdxdBEUlllHujJu5n8GOWfQYTH9ow8mqB8+MRi
         8kb6pkzd8Ye0xkSCGyvtCCmZBl/we5WdKm/Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na2oOp1hRvl9W53PhhQRBpj8OcRTH2+o/fCj7cVNOSE=;
        b=k4z4yycSSF6dSr1DdStBXV3ER3NHW5FjpTnLqjBTUbC9tNwTS6X7UWeKKgueHxFhJC
         fTEi4SLqkt7MVgnhO7znlRSYtYjlxphcUV2haMb/zHnN9o0181SQHDLJVMM/uyi8am8V
         NAHWk5MakZLVEMzk6x+OmsWt4cd/ElQXbqjo9s+wS+35aPGAhpGIwoC9IHgowBF7PxyI
         Gei+O3QuTcgHXVaCrMypWL+jmhF2AkETvgXfKhCk0xCYedVkHIxWPqNHHZujC8FMyqPk
         KWax3guTAIBWN/ROKcfXi9J4AhcshmS6+gooa7tGZQIdaculubm9c7ck/iBw1kamTWgu
         8QPA==
X-Gm-Message-State: AJIora+cnIQ02N4gt/TWaGAX1ZWFI+FtkZMejNHin5emgR4ttRo5hhT0
        CKhwm3ledpcLOXLtd44vATCdGgnO9DbjTBZvfWXIUg==
X-Google-Smtp-Source: AGRyM1tHDA+FnwmnezpK6y3lYgFcE2a6eOPhCu40247trR7WTy3KnZJDwC2w2Q9o94Fdl6lHSR9pZ4jttT0ISd+gItY=
X-Received: by 2002:a05:6000:144e:b0:218:405f:d34 with SMTP id
 v14-20020a056000144e00b00218405f0d34mr7507776wrx.457.1655260133079; Tue, 14
 Jun 2022 19:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
In-Reply-To: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 14 Jun 2022 19:28:41 -0700
Message-ID: <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, wrong email for Krzysztof.

On Tue, Jun 14, 2022 at 7:25 PM Julius Werner <jwerner@chromium.org> wrote:
>
> We (Chromium OS) have been trying to find a way to pass LPDDR memory
> chip information that is available to the firmware through the FDT
> (mostly for userspace informational purposes, for now). We have been
> using and expanding the existing "jedec,lpddr2" and "jedec,lpddr3"
> bindings for this (e.g. [1]). The goal is to be able to identify the
> memory layout of the system (how the parts look like, how they're tied
> together, how much capacity there is in total) as accurately as
> possible from software-probed values.
>
> The existing bindings contain the fields "io-width" and "density",
> which is terminology directly matching what an LPDDR chip can report
> to firmware through the "Mode Register" interface, specifically MR8.
> (The LPDDR specs describing this are not public, but you can see the
> register definitions in most LPDDR chip datasheets that can be
> randomly found online, e.g. [2] page 37.) The code in
> drivers/memory/of_memory.c also suggests that these are supposed to
> directly correspond to the MR8 values read from the chip, since when
> of_lpddr2_get_info() copies the device tree values into struct
> lpddr2_info, it encodes them in a format that directly matches the
> mode register bit field patterns.
>
> The problem with this is that each individual LPDDR chip has its own
> set of mode registers (per rank) that only describe the density of
> that particular chip (rank). The host memory controller may have
> multiple channels (each of which is basically an entirely separate set
> of physical LPDDR pins on the board), a single channel may be
> connected to multiple LPDDR chips (e.g. if the memory controller has
> an outgoing 32-bit channel, that channel could be tied to two 16-bit
> LPDDR chips by tying the low 16 bits to one and the high 16 bits to
> the other), and then each of those chips may offer multiple
> independent ranks (which rank is being accessed at a given time is
> controlled by a separate chip select pin).
>
> So if we just have one "io-width" and one "density" field in the FDT,
> there's no way to figure out how much memory there's actually
> connected in total, because that only describes a single LPDDR chip.
> Worse, there may be chips where different ranks have different
> densities (e.g. a 6GB dual-rank chip with one 4GB and one 2GB rank),
> and different channels could theoretically be connected to chips of
> completely different manufacturers.
>
> We need to be able to report the information that's currently encoded
> in the "jedec,lpddr2" binding separately for each channel+rank
> combination, and we need to be able to tell how many LPDDR chips are
> combined under a single memory channel. For the former, I'd suggest
> creating a separate FDT node for each channel, and then creating
> subnodes under those for each rank that implement the binding. For the
> latter, I would suggest adding a new property "channel-io-width" which
> describes the width of the channel from the host memory controller's
> point of view, so that you can divide that property by the already
> existing "io-width" property to figure out how many parts are tied
> together in series in a single channel. The final layout, then, would
> look something like this:
>
> lpddr2-channel0 {
>     rank0 {
>         compatible = "jedec,lpddr2";
>         density = <2048>;
>         channel-io-width = <32>;
>         io-width = <16>;
>     };
>     rank1 {
>         compatible = "jedec,lpddr2";
>         density = <1024>;
>         channel-io-width = <32>;
>         io-width = <16>;
>     };
> };
> lpddr2-channel0 {
>     rank0 {
>         compatible = "jedec,lpddr2";
>         density = <2048>;
>         channel-io-width = <32>;
>         io-width = <16>;
>     };
>     rank1 {
>         compatible = "jedec,lpddr2";
>         density = <1024>;
>         channel-io-width = <32>;
>         io-width = <16>;
>     };
> };
>
> This would be describing a dual-channel, dual-rank layout where each
> 32-bit channel is connected to two 16-bit LPDDR chips in series. The
> total capacity would be (2048 Mbits * (32/16) chips + 1024 Mbits *
> (32/16) chips) * 2 channels = 12Gbits.
>
> Does this seem reasonable? If nobody has any objections, I can draft
> up a real patch to change the respective bindings. (The two existing
> uses in platform device trees would stay how they are until the
> respective platform maintainers choose to update them, since only they
> would know the exact configuration. They wouldn't technically violate
> the changed binding since they still contain the same properties
> (other than "channel-io-width" which could be declared optional), but
> they wouldn't represent the total memory layout.)
>
> (Also, btw, would it make sense to use this opportunity to combine the
> "jedec,lpddr2" and "jedec,lpddr3" bindings into a single document?
> They contain all the same properties and I think it makes sense to
> keep them in sync, so duplicating the documentation is just
> unnecessary maintenance overhead. I would also like to add a
> "jedec,lpddr4" binding that has the same properties.)
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> [2] https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/dram/mobile-dram/low-power-dram/lpddr2/2gb_automotive_lpddr2_u89n.pdf
