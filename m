Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87555CA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbiF1MeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiF1MeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:34:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4F2BB2F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:34:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso12264841pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgtvVhfkB9MFjPDZk0eW6qF15/HI/14VLMJggWohgtE=;
        b=FzhYTx698OOjOlAKVGM1J4TElebsB4vmarv8/HnHUHhC7cxyADcBoWzbyvHI+muvdi
         37QqLTEMcNFXXEZeBiit0D6jJmcl+D+fogXsNTlgq1xvuTT4uNE97ebrSBBMq3d9MgBa
         BX2DT6gtYAl1Xyn2/dIDFHx039BQrHp+P/bwXZoXsw2aNMXOP5W+PXG7KJoDbLe/7aLN
         JNmYI/N87eI/KIxN4vsm7RGs119nknLqjrl5j7++iuDy/t7piYtzd22zX/BnzClkrGeR
         b6uFhQkmAgi09s6rh0Wg4+QSC06ZqH6s1M6BkiC4XSKiXfyPermoWXK1gBNmNK0fJIua
         9xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgtvVhfkB9MFjPDZk0eW6qF15/HI/14VLMJggWohgtE=;
        b=1MY0G6rJn649bPf6TT6upFLOT4D8I1Dy3NtU+7fxBWrASC2K5tvkCj6wn8IantEqB/
         x/Kl/MZdT6dhZh6YsP52JsB9rbfJXOvP6fmr8n+k/oJssTcI8L3tmrGAEfeqNH6JUYan
         C4yEuvdPqpxzF7vL2ziqISvnnDZKyjKxook+rCdeHdYIIXqI/XWPLOnShWfzkd+B/1dw
         D4noFAyzGEAk03DPun3zx3QTJMCs7PAyDgF3wBiHoLzqaZnh4CUT48oXpFWr9PdWNQBd
         RtFR3lTkWpQr0Dy4Z1eALyMhCxRvBuk744WqWzTob2ZreRuuweWyw7wO8z4LTOIARTm2
         1Msg==
X-Gm-Message-State: AJIora/BpFMeZDvdkwOFtgP5EdZp+laZlbWq7JPBPFbBqYV0YR4DPWnl
        7XI11p5+v8LPXaU7GxxQzvp6Qw==
X-Google-Smtp-Source: AGRyM1s45gTXj2HZCAEzzkN9IeQD+456rgjNd0s9t9KrgatOucowm4Ql5Rn52HnVu3lNsc2JcGW+Vw==
X-Received: by 2002:a17:90b:1982:b0:1ec:e2fa:99ae with SMTP id mv2-20020a17090b198200b001ece2fa99aemr26478986pjb.228.1656419654716;
        Tue, 28 Jun 2022 05:34:14 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090abc4500b001ea629a431bsm9409454pjv.8.2022.06.28.05.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:34:14 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     hpa@zytor.com
Cc:     bp@alien8.de, dave.hansen@intel.com, dave.hansen@linux.intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC] memmap: introduce cmdline parameter "memmap=nn[KMG]$" without start addr
Date:   Tue, 28 Jun 2022 20:34:02 +0800
Message-Id: <20220628123402.14573-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0EA9CBD4-D083-4546-BFAC-9C3A97420E5B@zytor.com>
References: <0EA9CBD4-D083-4546-BFAC-9C3A97420E5B@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 11:22:52, H. Peter Anvin <hpa@zytor.com> wrote:
>>On 6/22/22 23:24, lizhe.67@bytedance.com wrote:
>>> In our scenario, we need reserve or alloc large continous memory like
>>> 256M in machine which have different memory specification at just
>>> boot phase for a user land process.
>>
>>Just marking the memory reserved doesn't do any good by itself.  There
>>must be some *other* kernel code to find this reserved area and make it
>>available to userspace.
>>
>>It seems kinda silly to add this to the kernel without also adding the
>>other half of the solution.  Plus, we don't really even know what this
>>is for.  Are there other, better solutions?  I certainly can't offer any
>>because this changelog did not provide a full picture of the problem
>>this solves.
>
>Don't we already have a large contiguous physical memory allocator for this reason (misdesigned hardware?)

Yes we have already considered using CMA to realize the requirement. But CMA
only provides several kernel space interface for memory allocation. It seems
that userspace do not have a way to access those memory at current kernel.
In our scenario, we need to reserve large continuous physical memory for a
userspace program. It stores some data into memory and a hardware will consume
them. So allocing an area of large continuous memory for userspace program is
the best way for us.
