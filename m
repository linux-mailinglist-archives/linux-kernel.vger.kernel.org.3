Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557904D6B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiCKXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCKXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:47:14 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8C11C2E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:46:05 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bn33so14153667ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKgNteeSs8waKyLOLw45kd3flSMQZY4zJAPGQOzaWJA=;
        b=XqqEYbzb63TmNG/vtuAXveOQfa1kaMwCB/TbVx00c/6MltvzYwXso7W0mcBlvcJ4zU
         NEmwEb4WDW4prFwdJAvlm7ei8E45hztPhJ7xvP7lh9VhdsHXAcE0NtPi8yAuSEEY+mWg
         RWCx+q3JfDCkhMF2UXbsxbOrcd6ruv75kg23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKgNteeSs8waKyLOLw45kd3flSMQZY4zJAPGQOzaWJA=;
        b=waGpwKzFh5C+30rUadUSIzYFHCLCyDnYsvW+RN/Z286WcXaBwc5ACi1eTvnIm9Qun2
         x1wBCyDrpz2fEApfXNy+rymFW8ouoM24bnBIYqoMi465NsKTl32j26qC8SShqlFXqibi
         E8m8YavYLMNcSxZV+sRbfzfqp7PFHP4noFtiIEC+ufihpGqmmbuXba3saiQysqusWVzr
         nsvf/ghBmFx4xaeShoCD34a5N9pCAyFhy4J4aMlGAkj56xIjnTXLhaF16/YGR6s0K5x1
         LzpDYJ/mJQarB0xjTB701XHKzYSEcNGEXCMV/MMStO8ujiZyGTjfVJgrjPUI4OH8Y04X
         Vxjw==
X-Gm-Message-State: AOAM5317DxcBvDxWKQyevMirREwgnKhmxHZ414tJ3hsZUhW/3WOkci6P
        kkMW7c8zLZ0OY418EEkQ1itQKFM4PFMYhvOuwqM=
X-Google-Smtp-Source: ABdhPJxx8o5WDY74UrZ2QHMYlmdpRB/SgHY3pFL3RzMs8arxNPUyMe/a9tttNVaHFrefX7WfVwanHw==
X-Received: by 2002:a2e:160f:0:b0:247:fd10:7ba9 with SMTP id w15-20020a2e160f000000b00247fd107ba9mr7050779ljd.216.1647042363980;
        Fri, 11 Mar 2022 15:46:03 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e11-20020ac2546b000000b004482059541asm1873969lfn.167.2022.03.11.15.46.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 15:46:02 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v28so14125089ljv.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:46:01 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr7250096lja.443.1647042361569; Fri, 11
 Mar 2022 15:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20220311013238.3387227-1-pobrn@protonmail.com>
 <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
 <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
 <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com>
 <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com> <1D4riYxukWActDG6uXJOjvSq0GvTWaO4KZGVfqmX5RG_HGGjzgBb3srCUNRZqyPOzzNzVIrKRw0ktupkVs0DWQGTiZ1cSuWEcu5z3O1Pk4Y=@protonmail.com>
In-Reply-To: <1D4riYxukWActDG6uXJOjvSq0GvTWaO4KZGVfqmX5RG_HGGjzgBb3srCUNRZqyPOzzNzVIrKRw0ktupkVs0DWQGTiZ1cSuWEcu5z3O1Pk4Y=@protonmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 15:45:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wioAxtdJJejq08N3J3t=Qe47Tnii4H0fiYdgDwc8fpZHg@mail.gmail.com>
Message-ID: <CAHk-=wioAxtdJJejq08N3J3t=Qe47Tnii4H0fiYdgDwc8fpZHg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 2:15 PM Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.=
com> wrote:
>
>      So, sorry to be this obtuse, but I gather the proposed interface
> is a no-go in all ways, shapes, and forms in your eyes?

Yeah, not with the limitation that it only works on global list heads.
We already have a lot of different list traversal things (rcu, safe,
hlist, continue-in-the-middle etc etc), and we clearly are going to
add a new set - but I don't want to add one that is so limited that it
only works for the simplest kind of list.

                  Linus
