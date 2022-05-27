Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88073536712
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353697AbiE0SpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347644AbiE0SpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:45:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7095ED8EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:45:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so10446740ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52zOsCc6qEBLSd0EvVPsjC9FUkx7ysoIDr7i7kJhu7I=;
        b=eViVbPMW3o5xWiLGbwthVcpGNrkna0bmofKE98fV4grdZ6eH74UtthI/lzXo3RPIjz
         RwnfnWgzerkx2YzKRb/M9ndnInTc35IAUyAVqW91mVF2CtO8uqf6h5cuCiAiSN2JPaGP
         jC2VXu6WQjuai5tXQAtG6xajiwkx+dnQ+3/T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52zOsCc6qEBLSd0EvVPsjC9FUkx7ysoIDr7i7kJhu7I=;
        b=YTOQKudwgOc6il2yQK0aWOFv8NEhR1KzJGQYV/dSBPB+PkNakZ8MwsnYqTv+SNjxPl
         cQ2OCe1aAWa9qo4pNcP2gjo13jriP4c58FUxWGwp4SEBHEC7jT02G3e7vMxRm2I3HBWZ
         Z909NHlLTHYkxRkBsbZbv92FL3FuljKOj7hYXlpLOxkGLKU3iZwuq82o4/TlImds2g7p
         Y8bnPZkmncTNOLdUJBoVIbB3JOPnMfwGqvgE7tZmlldsz6w7DfweM/nn8x6TYzRSrL5k
         PAZReAbq2tWJ+RjSGZ+CD8tUs+VFUiIdIsblD096zxbygQFY2HZ+d02UIPunRTV0ENJ8
         2aOA==
X-Gm-Message-State: AOAM5331fu+ycqcmjn79J/e4LwGy7VmS12bT8PLbreoijbpiCBoxInTQ
        SDMyIoWWY9+vDKwBYprmtrkq5ubSHoBDf6u5
X-Google-Smtp-Source: ABdhPJz8cyTkA28uEJrJibMxjfjjkELz3zdughjdwNLmPdFJxJmLX0hb5DjBK6kl6xBy/XusijqB2w==
X-Received: by 2002:a17:907:6d0c:b0:6fe:f835:ae54 with SMTP id sa12-20020a1709076d0c00b006fef835ae54mr22018544ejc.173.1653677106076;
        Fri, 27 May 2022 11:45:06 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709065e0400b006feb7b1379dsm1651561eju.181.2022.05.27.11.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 11:45:05 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id l188-20020a1c25c5000000b003978df8a1e2so1117867wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:45:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr8216306wmq.145.1653677104449; Fri, 27
 May 2022 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
In-Reply-To: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 May 2022 11:44:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi72yLMW6vrnCpGJCO8Sj35miJMH74dWu2kJ0bYD1P42w@mail.gmail.com>
Message-ID: <CAHk-=wi72yLMW6vrnCpGJCO8Sj35miJMH74dWu2kJ0bYD1P42w@mail.gmail.com>
Subject: Re: [GIT PULL] additional MM updates for 5.19-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:30 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> There's a merge conflict in init/Kconfig.  We resolved that by removing
> the VM_EVENT_COUNTERS..MMAP_ALLOW_UNINITIALIZED entries.
>
> And another in lib/Kconfig.debug.  Similarly resolved by removing the
> DEBUG_SLAB..SLUB_STATS entries.

Both of those also needed fixups for the new mm/Kconfig.debug thing to
enable the proper STACKDEPOT things.

               Linus
