Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F150CD7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiDWVF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiDWVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:05:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B014F5C2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:02:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v1so10091164ljv.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WN/DG0q4+jzfz1mU579gg3tZvR498Ae1TRTixSJPvVk=;
        b=QiAjxF6JHYt4g96xcOLkBA1vcImx6D1u8E/I+15F39QyDzFJYAvDS+0TZg3NjkclSW
         pGYLgEC31LBKeymyQgMQ42nW4fICvOumuk012IuFpOnZRTk8m/EX5GcgPhsDzy3lFlXW
         HaUzxFbwQlQIYpws9iyz8yi/kCA6M8gH5+FHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WN/DG0q4+jzfz1mU579gg3tZvR498Ae1TRTixSJPvVk=;
        b=maBvl/4FcLw5rOn9A10AXRrmIPJRWc8t7F2Klj6v/V5y0i6yEfwQbP7P9XZ7DMZVgl
         ByPiuMIDIP8A8WZZaHFK8t3yPau4Ezy+DYgP2WTmoBGHEpFGlxt+wfv5ZMGE0KolZgEW
         XU/fGyTj5tPnl5Yy7xNZ9TGnXcTD/7AvMbVwd3r+S7juE0rGs+Q3IK2WbM8lgWN8G5tR
         X0bCYOWOGSUiIG30Ivill774oZWvdobOkswxM5LuQhPXTKkAve2tMfI0kqzHimvHQJJ4
         cGCRft/n6fwpxnEIw+xti/3zsXrvq7Bi1UJ4c9A51JQlW2yICiMFL/LFuQGIBVGaS+yE
         uTRA==
X-Gm-Message-State: AOAM5318nvCsdUaYiZnluCDqQYUuCSbG2PPl4rjtLCs3ZxlqsSj7S8O4
        iMVS12L/US12Drr0WWB5W2s+USgVAqSVan4G
X-Google-Smtp-Source: ABdhPJwKpnKwPv/wqn/CAReRGM95Z7weBhij9cR835Jl41htB0E77FaGeo7V6G5U96Nn8H1y7BlMrg==
X-Received: by 2002:a2e:709:0:b0:24b:46c2:1b8f with SMTP id 9-20020a2e0709000000b0024b46c21b8fmr6475527ljh.29.1650747775674;
        Sat, 23 Apr 2022 14:02:55 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m25-20020a2e97d9000000b002456e6cdab2sm652998ljj.93.2022.04.23.14.02.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 14:02:53 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h27so19692644lfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:02:53 -0700 (PDT)
X-Received: by 2002:ac2:5084:0:b0:471:ccb3:8c99 with SMTP id
 f4-20020ac25084000000b00471ccb38c99mr7722441lfm.435.1650747772827; Sat, 23
 Apr 2022 14:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
 <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
 <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
 <CANaxB-zDKVtGTRrqh4SpPKS96Ux6s01BL3BdAe-ZY_9HWSX9dw@mail.gmail.com>
 <CAHk-=wj8OCHqYkB2hVQ2FG6n5g4R0H3eetzbo9NrHooY1-4pwg@mail.gmail.com> <CANaxB-whArowHWaWsFMJf6B4idPabAmJNawzk9FdokNQ-1xrSA@mail.gmail.com>
In-Reply-To: <CANaxB-whArowHWaWsFMJf6B4idPabAmJNawzk9FdokNQ-1xrSA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Apr 2022 14:02:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBH+11vHDEKaPmDeVQ557mSruEXmEwBThACz3Xx-pvKA@mail.gmail.com>
Message-ID: <CAHk-=wgBH+11vHDEKaPmDeVQ557mSruEXmEwBThACz3Xx-pvKA@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Andrei Vagin <avagin@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 1:23 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> vmsplice & splice  is the best. /proc/pid/mem is 30% slower.
> process_vm_readv is 20% slower.

Hmm.

I wonder how much low-hanging fruit there would be to optimize there.

Because process_vm_readv() in particular is pretty much _designed_ for
what you do, so it would be much nicer to basically work on that being
optimal, rather than doing vmsplice hackery.

(And yes, vmsplice is designed for efficient copies from the VM too,
of course, but that "limited to kernel pipe buffer" part is arguably
even more fundamental to it)

            Linus
