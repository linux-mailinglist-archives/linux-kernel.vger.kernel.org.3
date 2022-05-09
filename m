Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B951F3D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiEIFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiEIFPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:15:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FB20F44
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:11:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s16so979075pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rDSFCO+czyrWwVIb/ri2W/5CAZ/bjTYqyMNHNUzLBgc=;
        b=NGeVsQ++HGtjZxzvUZn1nbfaCrKKTfnM27oWvJsxcQJiAy3hRTbcCH2794ZktMDynH
         R9268OPrKnRi0SxVYCY6APSONAAW56+inot6dKaYvxxiVLvViByq6EpMmXmtQQ9W3zvM
         noWZh5xnsQQHzXO1FSFi+X4Gumb189wYfLmLhtqViQkZVktne7fXneH4BFF7cj6X4rsq
         6QI1jPOs3L5/8JvrCyigC6idtOfVxKY1C9aluVUxfuDMub6jQGS5embdFASWhukIScVZ
         SOatnziUTIe157Q6TVh9w90rUGNYDl7h0PZEjTMKQ0OZlr0FEd9q3rIyrlMMKzdAKDX6
         5+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rDSFCO+czyrWwVIb/ri2W/5CAZ/bjTYqyMNHNUzLBgc=;
        b=L0Q3vF6tsyN9jglGcbcHUqynBB5AIIsCEiMnV3JW9Qdsa2krctJCoaVdWB4+FGQRXz
         vgZ8Ab8zA1BEQr9WwO0A9f91XfllaDMDB84Lsaq79dvvSZnKgJjbeYed91jcoZ3OJWSo
         M6Zpkut3QItWRhpH5Fgc9KRV7HhjELZMrImcQswqu0koFzpraWAaRF2AM2Hr4uGFeKaL
         CQoHxjTxZnFfxdgCWVp3o1EKdrqJrkdcEkTYQnlE8iKUFEAXZ9Y1JNy+vyxkVGFKalUv
         P2zbytmWfTEHXWUW+Q3jkFZgCPGLxNsFIjHTJs69ASC98HpZzaAu8MnUYmKcESxeTggV
         l5/g==
X-Gm-Message-State: AOAM5323PkqJyz3MqAaa1JAHr9P4upN277JZi26HLC2z42wFSLNhzN2Y
        3uyMH0FZVTE/FMYtrJURT6yoGQ==
X-Google-Smtp-Source: ABdhPJzQmAGyTKxouc0RQtiPKY+fyHgHySgxrAsDXhahZmKoQArbKkfoIBffIe19H+asxSznCOZPgA==
X-Received: by 2002:a63:7d4a:0:b0:398:dad:6963 with SMTP id m10-20020a637d4a000000b003980dad6963mr11871980pgn.329.1652073071387;
        Sun, 08 May 2022 22:11:11 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:8a29:6b15:2464:b015])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902a5c900b0015e8d4eb1e3sm6027714plq.45.2022.05.08.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 22:11:10 -0700 (PDT)
Date:   Sun, 8 May 2022 22:12:08 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: dmtimer: ack pending interrupt during suspend on am335x/am437x?
Message-ID: <YniiqM0S+hwsGFni@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel, Tony suggested I mail you along with the list to get
feedback. I'm attempting to upstream these two patches [1][2] from
ti-linux-5.4.y for arch/arm/mach-omap2/timer.c:
96f4c6e2ba8a ("ARM: OMAP2+: timer: Ack pending interrupt during suspend")
7ae7dd5f8272 ("ARM: OMAP2+: timer: Extend pending interrupt ACK for gic")

On the TI AM335x and AM437x SoCs, it is possible for a late interrupt to
be generated which will cause a suspend failure. The first patch makes
omap_clkevt_idle() ack the irq both in the timer peripheral register
and in the interrupt controller to avoid the issue.

On AM437x only, the GIC cannot be directly acked using only the irqchip
calls. To workaround that, the second patch maps the GIC_CPU_BASE and
reads the GIC_CPU_INTACK register before calling irq_eoi to properly ack
the late timer interrupts that show up during suspend.

However, Tony removed most of arch/arm/mach-omap2/timer.c with:
2ee04b88547a ("ARM: OMAP2+: Drop old timer code for dmtimer and 32k counter")

The timers are now implemented in drivers/clocksource/timer-ti-dm.c and
drivers/clocksource/timer-ti-dm-systimer.c. The function
dmtimer_clocksource_suspend() disables the dmtimer and clock but does
not ack any interrupts.

Tony suggested the right place to ack the interrupt during suspend is
in CPU_CLUSTER_PM_ENTER inside omap_timer_context_notifier().

Do you think that would be an acceptable approach?

Thank you,
Drew

[1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.4.y&id=96f4c6e2ba8a
[2] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.4.y&id=7ae7dd5f8272
