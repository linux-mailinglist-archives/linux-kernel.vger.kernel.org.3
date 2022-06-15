Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4754BFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiFOC0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiFOCZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:25:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4F1834D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:25:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k19so13438010wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8F/FVpqglm8qE8cD/YcY9ulLow7gQRjn5YoNZWPm/8s=;
        b=G3aV4kArKNwNmPx3WxNkrLgwMofzFkNooODCxpW7OfMNN4RVh+tyTS6N7ah0YCzph2
         FJ49Xy9CYn955YQbUamhUwHNM2OL1miuJpkwatUg9h+6q+m8m5P9t49saUL65HqXhMC+
         F+hf9fBdpbOQOd2to9dtnxV3c9Sf4QpE42ncI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8F/FVpqglm8qE8cD/YcY9ulLow7gQRjn5YoNZWPm/8s=;
        b=e0+dhdcICLLLwweHaUdVo+qR4ZkWrL/2n6I3yT+FQHGqBKzS94RT/xWIYwh/KJcz0l
         EIuHaaH6Vs/xTw4sJ14jT4VizXcbmHiYT1edWx1UW0G92vqW5psj0FjXcL0hwwYkxcyb
         gYoD7nrFxxIE9jZn/6LkACVS+w0Fp4QA3aHFYVVjZc1i/1XfHF+mnPJeSkuAfq+wMeOr
         BBHJrN7RL+DC6uyXydHDUR+7krMPqOt/1DFBeWUaWnE9yS+PrXexFWqzuoUU3W1HJyUQ
         UULMFV0tUTK7gwwhZPZ5MTgi/dLFoVIXxM+pFKuOJuJXYF2uwfzKOiGdHiNz7mY5YTFQ
         Nriw==
X-Gm-Message-State: AJIora/2KnJPPuEeksf8l3YajqF4hUU9wUflxnkv8sNEVwI5hNVJU3Ns
        CU+PFyBwgrzmNAi/l7OikxI1e8bHH848pvZCtbhW0Q==
X-Google-Smtp-Source: AGRyM1t3+b9bi2iA5wQ5TwQQ41PstAhl1x0Xp0nJenXM6HUkP9HJ6mvNO38m28aFjGzfncStOLI1OhP+zTbNxDFzit4=
X-Received: by 2002:a05:6000:156d:b0:210:3125:6012 with SMTP id
 13-20020a056000156d00b0021031256012mr7294139wrz.357.1655259953998; Tue, 14
 Jun 2022 19:25:53 -0700 (PDT)
MIME-Version: 1.0
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 14 Jun 2022 19:25:42 -0700
Message-ID: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
Subject: [RFC] Correct memory layout reporting for "jedec,lpddr2" and related bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
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
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We (Chromium OS) have been trying to find a way to pass LPDDR memory
chip information that is available to the firmware through the FDT
(mostly for userspace informational purposes, for now). We have been
using and expanding the existing "jedec,lpddr2" and "jedec,lpddr3"
bindings for this (e.g. [1]). The goal is to be able to identify the
memory layout of the system (how the parts look like, how they're tied
together, how much capacity there is in total) as accurately as
possible from software-probed values.

The existing bindings contain the fields "io-width" and "density",
which is terminology directly matching what an LPDDR chip can report
to firmware through the "Mode Register" interface, specifically MR8.
(The LPDDR specs describing this are not public, but you can see the
register definitions in most LPDDR chip datasheets that can be
randomly found online, e.g. [2] page 37.) The code in
drivers/memory/of_memory.c also suggests that these are supposed to
directly correspond to the MR8 values read from the chip, since when
of_lpddr2_get_info() copies the device tree values into struct
lpddr2_info, it encodes them in a format that directly matches the
mode register bit field patterns.

The problem with this is that each individual LPDDR chip has its own
set of mode registers (per rank) that only describe the density of
that particular chip (rank). The host memory controller may have
multiple channels (each of which is basically an entirely separate set
of physical LPDDR pins on the board), a single channel may be
connected to multiple LPDDR chips (e.g. if the memory controller has
an outgoing 32-bit channel, that channel could be tied to two 16-bit
LPDDR chips by tying the low 16 bits to one and the high 16 bits to
the other), and then each of those chips may offer multiple
independent ranks (which rank is being accessed at a given time is
controlled by a separate chip select pin).

So if we just have one "io-width" and one "density" field in the FDT,
there's no way to figure out how much memory there's actually
connected in total, because that only describes a single LPDDR chip.
Worse, there may be chips where different ranks have different
densities (e.g. a 6GB dual-rank chip with one 4GB and one 2GB rank),
and different channels could theoretically be connected to chips of
completely different manufacturers.

We need to be able to report the information that's currently encoded
in the "jedec,lpddr2" binding separately for each channel+rank
combination, and we need to be able to tell how many LPDDR chips are
combined under a single memory channel. For the former, I'd suggest
creating a separate FDT node for each channel, and then creating
subnodes under those for each rank that implement the binding. For the
latter, I would suggest adding a new property "channel-io-width" which
describes the width of the channel from the host memory controller's
point of view, so that you can divide that property by the already
existing "io-width" property to figure out how many parts are tied
together in series in a single channel. The final layout, then, would
look something like this:

lpddr2-channel0 {
    rank0 {
        compatible = "jedec,lpddr2";
        density = <2048>;
        channel-io-width = <32>;
        io-width = <16>;
    };
    rank1 {
        compatible = "jedec,lpddr2";
        density = <1024>;
        channel-io-width = <32>;
        io-width = <16>;
    };
};
lpddr2-channel0 {
    rank0 {
        compatible = "jedec,lpddr2";
        density = <2048>;
        channel-io-width = <32>;
        io-width = <16>;
    };
    rank1 {
        compatible = "jedec,lpddr2";
        density = <1024>;
        channel-io-width = <32>;
        io-width = <16>;
    };
};

This would be describing a dual-channel, dual-rank layout where each
32-bit channel is connected to two 16-bit LPDDR chips in series. The
total capacity would be (2048 Mbits * (32/16) chips + 1024 Mbits *
(32/16) chips) * 2 channels = 12Gbits.

Does this seem reasonable? If nobody has any objections, I can draft
up a real patch to change the respective bindings. (The two existing
uses in platform device trees would stay how they are until the
respective platform maintainers choose to update them, since only they
would know the exact configuration. They wouldn't technically violate
the changed binding since they still contain the same properties
(other than "channel-io-width" which could be declared optional), but
they wouldn't represent the total memory layout.)

(Also, btw, would it make sense to use this opportunity to combine the
"jedec,lpddr2" and "jedec,lpddr3" bindings into a single document?
They contain all the same properties and I think it makes sense to
keep them in sync, so duplicating the documentation is just
unnecessary maintenance overhead. I would also like to add a
"jedec,lpddr4" binding that has the same properties.)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
[2] https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/dram/mobile-dram/low-power-dram/lpddr2/2gb_automotive_lpddr2_u89n.pdf
