Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914284B5E76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiBNXw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:52:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBNXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:52:54 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95712408E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:52:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c4so10603771pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=q/68wf5KGxajLpQXjSmh69B044maP9rOcGCawmFkP2M=;
        b=B7/gLLy6iIQ0Tnw0byEE+VGNXe/uVAdHXdQJICGKkCA/59oHc/3VkSEF1GaEOnN+th
         /6wjSZnPNDbMcdI2Y/L2Sqv0xttgkywZmIkMEiwChHJ0iPD9qlrLBGZfhh+exvwz4DAl
         XTJn+h5VAeyMUrI7GI38VbiqI3uMDAf4t3ohZCMJCEpoOYZhuTxiR1RWhdhV4s8HCZ4B
         S6PIOhRjMlkmj/DEWLUm4nNr007OE0vYStZequcWI1H64U/RbJ0hWD1/+7popGBJ6szs
         DOWt6CVIJ75Ef2I29BsZuJyF8H0kN9j3WMFBGhZ8NlH1yEKh/OS3GF1WymvbiUjD1ADM
         Dybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=q/68wf5KGxajLpQXjSmh69B044maP9rOcGCawmFkP2M=;
        b=23D3XO0E9hU5nU6vC0fUmrNs8+AXpjtQdgQrGJ7fJuJ7dUAJMq736ijD6NhWCJ7Ant
         pi6ASU8x6vpoqHcpPZO5Lmid0gOzslffHWuqqmGdLgbxBD0ZPdu3ZxAJIZYh7duLuICE
         Oej+N04zBDNRZlj4qFOVl8Ub0ctbcqmoqnq3wIVrNCDEoZRsyYsoH5gMABw5y3tSIiYL
         YA5wc4sQIJq8BgyanPSnm9eLIodb8NFGzgkTalWSvYkbSyji0e9scym1/Q19+LerN2/M
         7+p2zu/S3F0H11eE5C7U5cRPopxkI7ThsCtOovv8rzacs5BSNxcAUoen7OpvTecw2LA1
         G9og==
X-Gm-Message-State: AOAM531LSAOdh3GiquSetEREHv5MMjG8qk4FlacNoQm2vAQ8wJk4mZ5R
        X/ei3yU6zitR5dSM+3+dIBIEBw==
X-Google-Smtp-Source: ABdhPJx5mA9kZ2Gy8fry94nzIgW+4WlYvtgr57alEdRWSRRjLC4AV5ngjOPE/jrhYHczARd0X/c/KA==
X-Received: by 2002:a63:b17:: with SMTP id 23mr1249158pgl.103.1644882765243;
        Mon, 14 Feb 2022 15:52:45 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id q26sm540251pgt.67.2022.02.14.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:52:44 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:52:44 -0800 (PST)
X-Google-Original-Date: Mon, 14 Feb 2022 15:51:43 PST (-0800)
Subject:     Re: [PATCH 0/3] unified way to use static key and optimize pgtable_l4_enabled
In-Reply-To: <20220125165036.987-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, alexandre.ghiti@canonical.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-41f2520d-7583-41b3-ae7a-95e74117676a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 08:50:33 PST (-0800), jszhang@kernel.org wrote:
> Currently, riscv has several features why may not be supported on all
> riscv platforms, for example, FPU, SV48 and so on. To support unified
> kernel Image style, we need to check whether the feature is suportted
> or not. If the check sits at hot code path, then performance will be
> impacted a lot. static key can be used to solve the issue. In the
> past FPU support has been converted to use static key mechanism. I
> believe we will have similar cases in the future. For example, the
> SV48 support can take advantage of static key[1].
>
> patch1 introduces an unified mechanism to use static key for riscv cpu
> features.
> patch2 converts has_cpu() to use the mechanism.
> patch3 uses the mechanism to optimize pgtable_l4_enabled.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
>
> Jisheng Zhang (3):
>   riscv: introduce unified static key mechanism for CPU features
>   riscv: replace has_fpu() with system_supports_fpu()
>   riscv: convert pgtable_l4_enabled to static key

I see some build failures from LKP, but I don't see a v2.  LMK if I 
missed it.

>
>  arch/riscv/Makefile                 |   3 +
>  arch/riscv/include/asm/cpufeature.h | 105 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/pgalloc.h    |   8 +--
>  arch/riscv/include/asm/pgtable-64.h |  21 +++---
>  arch/riscv/include/asm/pgtable.h    |   3 +-
>  arch/riscv/include/asm/switch_to.h  |   9 +--
>  arch/riscv/kernel/cpu.c             |   2 +-
>  arch/riscv/kernel/cpufeature.c      |  29 ++++++--
>  arch/riscv/kernel/process.c         |   2 +-
>  arch/riscv/kernel/signal.c          |   4 +-
>  arch/riscv/mm/init.c                |  23 +++---
>  arch/riscv/mm/kasan_init.c          |   6 +-
>  arch/riscv/tools/Makefile           |  22 ++++++
>  arch/riscv/tools/cpucaps            |   6 ++
>  arch/riscv/tools/gen-cpucaps.awk    |  40 +++++++++++
>  15 files changed, 234 insertions(+), 49 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpufeature.h
>  create mode 100644 arch/riscv/tools/Makefile
>  create mode 100644 arch/riscv/tools/cpucaps
>  create mode 100755 arch/riscv/tools/gen-cpucaps.awk
