Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5615A34CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiH0FTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0FTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:19:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF5E1A8C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:19:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 145so3050196pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc;
        bh=Ex0DoxIOtIfWz5X46PeAPnGzyykJrHfV/bGWTZ5nQcY=;
        b=EyOcoNilxAH8K0R71Y6zbckdTPkzzkPKPFNRK6hDGN3Tlo6bs3pyBadh812ekIk4XW
         8bbMg/wz+SIOxI+FZxcSxrnNPdSMdFHGUeAxFD6bS9PyXcE9xR6MlsOCrkXUOPTiH8aK
         CcU6MHFbHT8YEW+P7BdoZwMK9JUr6tnqgWDp8MvXaU0deHfffycU19rdK312qtonTLxC
         ij4GiSeFTnqNVBbdWlNzjZJLQgUR+LPv4hV24UwRiXXYlPVlhBj9xmP54iLr04/JgDYs
         npff3WDcO7oPcVxqctslLoKIAjmrPI8W1Vav83YrA/Loj1DttlgDVj8XO4YLju7kRu5r
         zfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc;
        bh=Ex0DoxIOtIfWz5X46PeAPnGzyykJrHfV/bGWTZ5nQcY=;
        b=Rn/dHAKuEb4oHl+kHaoBWylHfX/UomFavzQAzAZ5oEAnFc7YtPYZ2jhnKro7mF6ucW
         nf2NXxw+IKiYjisDB4tyhwZDGAbB3oiq2ORi2IKnm92QIie541EdZZpu8M55+Vm9w6qa
         wj4GvOO4n0zZYkPcE7P+dNvi1yvPM4BManNcPWyTE8BjQTybJ6KlVbubfjFP4nT7Xg3D
         H+8/YRYo58Nmu3YMVFGphtXsS/x0qHJMNj3zWAYE8ECokLKSzr4mNVbJn5eMHdPElTvR
         UNIOhFdJwT0pojo6uRYIBZBaZcvDFHrQNRnAmXwyC3gYLXJUE+kbJLr73s8VzCi80zN2
         G1fw==
X-Gm-Message-State: ACgBeo3CbR9rfzLkr2WKx73JeX2Ssbg76bItqN2l+j80QFmbq0/AZ0VP
        P0y/ZSa9gOlrHo4rlgP7CuU=
X-Google-Smtp-Source: AA6agR6bs3WLKaxLVBPy8T7ozF8/KJOD966dsMFGaRz89fSPfIYBBQJk1+w/iPnLWsSe0RLxmArO2Q==
X-Received: by 2002:a05:6a00:16cb:b0:52b:cc59:9468 with SMTP id l11-20020a056a0016cb00b0052bcc599468mr7064536pfc.46.1661577574477;
        Fri, 26 Aug 2022 22:19:34 -0700 (PDT)
Received: from lu-N56VJ ([113.88.94.120])
        by smtp.gmail.com with ESMTPSA id u22-20020a62d456000000b00536aa488062sm2727084pfl.163.2022.08.26.22.19.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Aug 2022 22:19:34 -0700 (PDT)
Date:   Sat, 27 Aug 2022 13:19:27 +0800
From:   Puyou Lu <puyou.lu@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Robert Richter <rrichter@cavium.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Puyou Lu <puyou.lu@gmail.com>
Subject: [PATCH] irqchip/gic-v3: do runtime cpu cap check only when necessary
Message-ID: <20220827051328.GA18042@lu-N56VJ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now cpu cap check is done every exception happens on every arm64 platform,
but this check is necessary on just few of then, so we can drop this
check at compile time on others. This can decrease exception handle time
on most cases.

Fixes: 6d4e11c5e2e8 ("irqchip/gicv3: Workaround for Cavium ThunderX erratum 23154")
Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 262658fd5f9e..3f08c2ef1251 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -237,9 +237,11 @@ static void gic_redist_wait_for_rwp(void)
 
 static u64 __maybe_unused gic_read_iar(void)
 {
+#ifdef CONFIG_CAVIUM_ERRATUM_23154
 	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
 		return gic_read_iar_cavium_thunderx();
 	else
+#endif
 		return gic_read_iar_common();
 }
 #endif
-- 
2.17.1

