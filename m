Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46B5B244E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIHRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:21:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3945D21D5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:21:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso3141699pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QSC9/JxlDSGT+O5ILF8zg3hfD0efmyK/EUQhHIx6ex8=;
        b=M87gAZebZeVAjcE7FVwEzkqUy/zpY/uInRWMijM4pO5g5fVULP2EfdvE/WV7ycypOB
         33U2wTgQKMtJMPLryKtwrd1L82Z6Wi+1yotqDSrgO3b+XMUhG8OCj8rs5dH2HIRfG4YT
         Zy0f0r74yVTQty6B3ZHNLwdRPQ92lZKns/xJkg+OssL84kvFPJ6Ix5DNWn0p6XMo/xfZ
         8sxTZYzbE/hL4S/L6KyicZbEuTE/yUZTNDk+SIeAQtxaeZcdKNko6R61BjI03ALzFXC8
         84ebs59gXx2lbc0LxcdrNOwg7ROUpNmkzrbmCJ2LkRmCrYR1VdFAa1a7uJXRwvvwW+JP
         Yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QSC9/JxlDSGT+O5ILF8zg3hfD0efmyK/EUQhHIx6ex8=;
        b=kbqez1HbXNG6XiC31KB7MzXHQzGqk7Qu6q64QElb5z88tFtUgOStCM1xbHLxab21Y7
         uETpNd4t8FEpagCMJ8W6steKjLfPRuAf2v2Y6iHCGE74JKviaaMVPs9DX0mVWs29uTZl
         Y4Xv+IHiq/a0tp+gkMoL1xK2WpfUMa7moiCatmmIewEOm+1CCSraZYY87ELGDzW34E4j
         uiOrmVblraDjWAJaosyhuy5Jy68R+xRgOhvLO/V99nxofAvUyZdmaGA7NysX3raU8mxi
         bso8s8Cl4aycfr8qh3jtj5lFNLUFTq8/dB+lOV204YANW9Bk2WKy1YXOOl5Fg9JzRSte
         wDQQ==
X-Gm-Message-State: ACgBeo186rrjFmg3ZgNLiypwScVCj0HuWiFV5VlcIyhFYwk9hEn/EfAd
        a2Ru3SMYsqmZ78YqzgeHVdckjNy9uJbNkWFdJpwWvF2J9RcQwNoLUdNrKQ==
X-Google-Smtp-Source: AA6agR7Xeg3nQg1T99ip9VlFHLMdwIdx0y5yxJPkxPD84LN3YTfYEjH8DXhT4YDTtaFu1/rLSk2ygeggw/b1deT4pPk=
X-Received: by 2002:a17:90b:3e84:b0:1fe:3c34:8c5a with SMTP id
 rj4-20020a17090b3e8400b001fe3c348c5amr5263514pjb.77.1662657689081; Thu, 08
 Sep 2022 10:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
In-Reply-To: <20220908170133.1159747-1-abrestic@rivosinc.com>
From:   SS JieJi <c141028@gmail.com>
Date:   Fri, 9 Sep 2022 01:21:18 +0800
Message-ID: <CANaf2scedFxwDwBYNwk-9Y_p4O7Sc62FFjZPptdZeAs4H4JGiQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Allow PROT_WRITE-only mmap()
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

> is unnecessary since RISC-V defines its protection_map such that PROT_WRITE
> maps to the same PTE permissions as PROT_WRITE|PROT_READ, and it is
> inconsistent with other architectures that don't support write-only PTEs,
> creating a potential software portability issue.

I don't believe that the check is unnecessary. The missing check is
discovered in realworld scenario, while we are fixing libaio's test
failure on RISC-V [1]. A minimum reproducible example is uploaded to
https://fars.ee/1sPb, showing *inconsistent* read results on -r- pages
before/after a write attempt performed by the kernel.

[1]: https://pagure.io/libaio/blob/1b18bfafc6a2f7b9fa2c6be77a95afed8b7be448/f/harness/cases/5.t

> -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> -               return -EINVAL;
> -

Just to mention, this revert patch is removing the check of exec
without read (--x), too.
