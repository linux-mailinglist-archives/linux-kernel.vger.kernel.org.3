Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5300152F950
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354683AbiEUGiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiEUGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:38:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272515A773;
        Fri, 20 May 2022 23:38:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so9383155pfc.11;
        Fri, 20 May 2022 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=smaHFvOwAesiG7cYWVCNK0rzH0N79mjIDdkzCW+d3SU=;
        b=Xxj6incOCD6+c1sZEp8cdl1Iubj82KGyzf6Gufs0MVXDHm+WvHgQqbaTA1zK4z8Lyp
         rUQLnh1q7csxY8FzDUyyvi7Wt3kk2QOQPW7ZqUkx69AyD4OLXNG9GBpW9CPsHkoIJoeM
         jR9lKGoKYhHDzqkRmFFVSAu2SHGfgwhaTceECagDcaqou03DJGxovzRsXxdf3LV/2dZV
         D2hs+7WnM/mc+ycfZzAPyAKpD4JLc+E6xPfre3hoU7pbeylYCXZPtPvRV/E2XhMAHbbS
         KrNkwbOYflvd7rv0e5sTCHhhpkb6/tSYxgV5HxzKFsepTYRHtt9QBpXEp+xa5bWg1uEE
         Gj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=smaHFvOwAesiG7cYWVCNK0rzH0N79mjIDdkzCW+d3SU=;
        b=IxMmVDVPHJiN1TOfp9qAtblqFdZwo7rj1UPTqKEXTQNV8a9o0ewGMO5KaZtg2dQ++N
         qQ1CLKB5Rw9FC58zPzlwB58oPio4rDRnE0yRxel7Zp10kGtZG41qH5wKJeP8k59V7NmI
         flL9kJS3b1AwB1xYDPkIO9MU12GeAfbARZYODzkxwdItvv7ChrhSddyGYPXDhuarW/nA
         I1XZNf+hiNZEH96Ydv7+x8YSG5JQ/phFz6BXD/ajwXauR/KvjPo6pWf+CbDsKVG7AWgy
         HuQO6LEiuo5lng6S0f4BQtX4iXJJhMMoLAvZTaTGe1v3VWvqb0froheVtj/bRIVdrBs4
         m7bw==
X-Gm-Message-State: AOAM533FO9HnV5AsGKpcLos8uEJeFFXjxNHLwEon8Ko0gHxAWOkY5+0t
        j3dfGK/xmXqsX0OUsznUkctxZCmWcYuYYcr/BQ==
X-Google-Smtp-Source: ABdhPJzeV4LovcLtaXuvqmqsLafmDVX4iKvf+5XD6MPWdPxgl4vN/pJYu7JazY9Ir3jgpykLQ7GF/SMAT3Ai7TG0Ce0=
X-Received: by 2002:a63:9043:0:b0:3f9:6c36:3de3 with SMTP id
 a64-20020a639043000000b003f96c363de3mr4363866pge.616.1653115088581; Fri, 20
 May 2022 23:38:08 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 21 May 2022 14:37:57 +0800
Message-ID: <CAMhUBjmSVGUm+9tki3J029z=JWKY8TOB73V5hQOgn_zjodhj1Q@mail.gmail.com>
Subject: [BUG] mfd: tps65217: Got a warning when removing the module
To:     tony@atomide.com, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the driver tps65217, the following log reveals it:

[   53.301059] remove_proc_entry: removing non-empty directory
'irq/1', leaking at least 'i8042'
[   53.301774] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717
remove_proc_entry+0x389/0x3f0
[   53.304647] RIP: 0010:remove_proc_entry+0x389/0x3f0
[   53.308912] Call Trace:
[   53.309044]  <TASK>
[   53.309158]  unregister_irq_proc+0x14c/0x170
[   53.309377]  irq_free_descs+0x94/0xe0
[   53.309777]  tps65217_remove+0x117/0x280 [tps65217]

Regards,
Zheyu Ma
