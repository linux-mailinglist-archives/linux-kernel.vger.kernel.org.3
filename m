Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437A351EF3E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiEHTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbiEHSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:14:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0863B4
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:10:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so22968613ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxJVHNIyRwN5ME+CiXPLd/3NxUAvRgeQ9Fit1n6jV0c=;
        b=AqLB8jPDDWff1fp/bh3Nn7ZhGkGt2i9i7xSNvs00KVuFnJZ71SOjRS2WJ+cDtTjB8N
         DgG5nYnHsubCf63aw3wQmFqmzpV34tthqoUwOuw5uBQrv2nUcb7YkEOZalk9WjLR8xMV
         8cTxnxK9nywotYQGa4kb7UyTe1cVSfDQJBUk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxJVHNIyRwN5ME+CiXPLd/3NxUAvRgeQ9Fit1n6jV0c=;
        b=Kwdgh4ymahJqjR9o5PWRMD/mAGjgfRYj/4euTSSRXHJAir0ClgWDZNTySQHF5wLMK2
         uCC/X11ihcgCFpppNgqE5+huS00MTRPFv4iDHYvANC6lewhHX9p2WyNJHKLgn7A6gnrk
         xcI4/70O4aZp17SJfuqhstV5QnGNI/JQeS0/vVBuRcMUKjvB5G97+wigUmZ/CwBZuJf/
         K2dsbEhqwvV185rNWlLsrKqlMRC2rhk0xJZqzVuJF5m3er3ovTewKQQbDCdW/KcRkGU6
         FXQEMRvnGqrm7SnpjgptqjHJTfdSdwJDnr5eqc6tO8iZuHaPwdtLjOelwzC7ywiR0T9C
         Y8IQ==
X-Gm-Message-State: AOAM53379OSQnZ1bbaeGyUUQXY070urvIp0UmLyCD7TW9nrvnIJXfuOt
        q8R8UnbDwS/PM7mOsNrGh9QZbgbXF+pRaq3j
X-Google-Smtp-Source: ABdhPJz/Li8Jv7XyB37D4xVH/iH5iaZBek6yQYfFu8B/RJ09rkvbsfaqxiMchv+1d/1mA0pe7xaepQ==
X-Received: by 2002:a17:907:728b:b0:6f9:a9bf:a8e7 with SMTP id dt11-20020a170907728b00b006f9a9bfa8e7mr3546483ejc.696.1652033406117;
        Sun, 08 May 2022 11:10:06 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 18-20020a508e52000000b0042617ba63b1sm5055400edx.59.2022.05.08.11.10.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:10:04 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so7132516wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:10:04 -0700 (PDT)
X-Received: by 2002:a1c:cc16:0:b0:394:61e1:94f with SMTP id
 h22-20020a1ccc16000000b0039461e1094fmr12691422wmb.38.1652033404168; Sun, 08
 May 2022 11:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <165201148069.536527.1960632033331546251.tglx@xen13> <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
In-Reply-To: <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 May 2022 11:09:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj6m0B9ys4XyE4AAPPoXE7XpBtxL7mD3Rk6EYX1=Ugng@mail.gmail.com>
Message-ID: <CAHk-=whj6m0B9ys4XyE4AAPPoXE7XpBtxL7mD3Rk6EYX1=Ugng@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.18-rc6
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Sun, May 8, 2022 at 11:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I suspect it's related to mmu_notifiers or something, but I really
> would have liked a more exact "this is where things go wrong".

Looks like it is

 ->(*sva_bind)()
    -> intel_svm_bind_mm()
      -> mmu_notifier_register(&svm->notifier, mm)

and yes, the mmu notifiers annoyingly end up doing an mmgrab, because
they actually don't want to affect the state of mm teardown, they just
want to be notified about it.

Annoying, but it seems to explain the issue if I followed this right.

Unlike the commit message.

                Linus
