Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B05357F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiE0C4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiE0C4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:56:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A168E027
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:56:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q184so5788162ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JiJSTbLByeBUbNjihqq4ucy2aU+Ryl5bPLbQLP/9oss=;
        b=Ozb63YSSQHn8iwOg65YeWkay62ruIsX1IEUZM8RRaeZYTflINNHYytQTiqfgbZ61mu
         5mws/emmuO8H4TIhbNyq7HBsb0ZcExk9JtYfcWdaUKyjqpUt5zZ2H/eH7WPCvqznRTFU
         vn7z21rNg+0FKzGwGC9M0KcNwx40GaOIjq45cGhlequzhpnACcMJ/+Xb2XWymOXsJSjK
         FHBURfxDYZRZMuQY1HY768u1aNFpEir4fmRDiCOJ3PWbyieKxv2ohaA375ldJ5/MrzP+
         WSKiAAV7xCfNim5mKz3ZAqarDnkz+HbFjS9MCp5Ne18S74uqYffqKc5zK4Fe93zkeNEC
         ayLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JiJSTbLByeBUbNjihqq4ucy2aU+Ryl5bPLbQLP/9oss=;
        b=KEfOO05edHEPmdNra8AGnx3rvU7TagUfBZzP0ntHgj1PizChRYPoFltjDhLqQ5SeCJ
         mAcQVoaHUoi7C69WBRlYhpeA3g3mN5XaYXKRZuKcj2igyM9A1nb9z2nGb8iKeWrjqPe+
         oDuaNoGOByAK0V9gKciZXI3v+qUWNaRw2rB3CRH9lTb3uwLMSazFQRCUqV5nG9UfOeeV
         ZuFS3j6vZ2jTRwK9Ki/jT+jXLiy95gSf4tGR/VtnIAr6Wtr8OtD4bK7ij+JMHW1mdFlK
         T2COpJBd/qCVzO7MCTDnyRy+yawp5magr+ha8wzn+qHxvdk0pS1qoDOkmyPU0hAJK+4m
         bpgA==
X-Gm-Message-State: AOAM530PxWiDhkes7XmYx9jnKWjOImwXKmx2suO3fUElsx2Vyda9o7Ek
        zBFg3XJ4UJ2GRu0gI/7UY0cvvBHsXVx7elpxCMrYdPGy8L1Lkg==
X-Google-Smtp-Source: ABdhPJyGNTNv40JneTza56EAdqP+zzrItZRZlcDCfYTGf+w+A+P3IpJdqxt7uCEizAutTcCZGWFNaFobAekuwi5gQ/s=
X-Received: by 2002:a25:814a:0:b0:64f:f06c:cf6d with SMTP id
 j10-20020a25814a000000b0064ff06ccf6dmr19551467ybm.88.1653620195396; Thu, 26
 May 2022 19:56:35 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 May 2022 08:26:24 +0530
Message-ID: <CA+G9fYtDBZaBGkEp5tRMM5C1xHEKeyyNK1S4WoKvrOoFxGm4KQ@mail.gmail.com>
Subject: Re: mm: change huge_ptep_clear_flush() to return the original pte
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build failures noticed on arm64 on Linux mainline tree.

Which was detected and discussed at this email thread.
https://lore.kernel.org/all/20220512193855.4f6ce32f@canb.auug.org.au/T/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
arch/arm64/mm/hugetlbpage.c:515:16: error: implicit declaration of
function 'get_clear_flush'; did you mean 'ptep_clear_flush'?
[-Werror=implicit-function-declaration]
  515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
      |                ^~~~~~~~~~~~~~~
      |                ptep_clear_flush
arch/arm64/mm/hugetlbpage.c:515:16: error: incompatible types when
returning type 'int' but 'pte_t' was expected
  515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/mm/hugetlbpage.c:516:1: error: control reaches end of
non-void function [-Werror=return-type]
  516 | }
      | ^
cc1: some warnings being treated as errors

metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
    git_describe: v5.18-9901-g7f50d4dfe816
    git_sha: 7f50d4dfe816dd916a7cbf39039674825c2b388b
    git_short_log: 7f50d4dfe816 (\Merge tag 'for-linus' of
https://github.com/openrisc/linux\)
    target_arch: arm64
    toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
