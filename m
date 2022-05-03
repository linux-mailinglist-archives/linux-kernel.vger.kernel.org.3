Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BF517E05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiECHGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiECHF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:05:57 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654522293;
        Tue,  3 May 2022 00:02:26 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id j6so12993535qkp.9;
        Tue, 03 May 2022 00:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSeOpGTWqeqaJ05xwK7hbvzXrVoyzqa0yoZQ8B3RFC8=;
        b=4Uy1+tbI/THbs14zNjeL1pIvxBKXmodlGrblbrWoSsHAqOBpmMWUbqBrUx5ay1ClQe
         OnGCDYVKUMexJo1XMzxqGRwiQtUOSunQ13Um/GpPIw9zfJzC/joIYiSQf15KAjSOclbv
         n2hHTeORVVBAEMhYhBLZZFVR3/pKTm9Qhi9rt5mZSv/Zi96AHX/4Dm4+x5Gh42XrqN8T
         PmAnW+l+1SVbQUf+s3I/VJZrreCQmSNZ3mED8N0LQFbpp2TWQEhFrKhguLCz+gj/SWuG
         I72Bpld2owFj9IYSnS+fxwMPumKRZ8dVfyCrcGvp9Ds09OJsIgC3/Nv8rRZeDD9qec/D
         z6WQ==
X-Gm-Message-State: AOAM530dmMgW8ZB+f+pMIk+f0hc9YLObeGBrGc5IlT65P3sc6U2tEWUG
        Hpbq8zZYV4f6BDW44w5O8tXVJI66GrGWdg==
X-Google-Smtp-Source: ABdhPJy77pWp0ojqYVlqQubLtoCJp5QQzLlFugoCo+5U7Jp2XCmml/O1I8wLPbx9zsWQZQQ4RQf91A==
X-Received: by 2002:a05:620a:1a97:b0:69e:b83e:bb9a with SMTP id bl23-20020a05620a1a9700b0069eb83ebb9amr11181772qkb.711.1651561345137;
        Tue, 03 May 2022 00:02:25 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id a140-20020ae9e892000000b0069fc13ce1e1sm5582504qkg.18.2022.05.03.00.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 00:02:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso170447047b3.5;
        Tue, 03 May 2022 00:02:23 -0700 (PDT)
X-Received: by 2002:a81:547:0:b0:2f8:6e8:19d7 with SMTP id 68-20020a810547000000b002f806e819d7mr14236459ywf.383.1651561343489;
 Tue, 03 May 2022 00:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru> <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net> <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
 <2a3f8b4c-2c0d-28bc-8dcd-c56c7b8a2bb4@landley.net>
In-Reply-To: <2a3f8b4c-2c0d-28bc-8dcd-c56c7b8a2bb4@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 09:02:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZ-fTKPk1kXodjg1yi5vm3RZJ=wO9o5afA81yNvt0KYA@mail.gmail.com>
Message-ID: <CAMuHMdUZ-fTKPk1kXodjg1yi5vm3RZJ=wO9o5afA81yNvt0KYA@mail.gmail.com>
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, May 2, 2022 at 10:02 PM Rob Landley <rob@landley.net> wrote:
> Sounds like it's now outside of the IRQ range allocation, but I can't find where
> that's requested when registering the controller? (What is a "swizzle" anyway?)

PCI slots have 4 interrupts (#A, #B, #C, #D). In machines with
multiple slots, the interrupts lines are "swizzled", to avoid that all cards
using a single interrupt are mapped to the same host interrupt.

Typically, the mapping is:

    host_irq = bus_irqs[(slot + irq_pin) % 4];

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
