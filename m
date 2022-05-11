Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5E5237DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbiEKP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbiEKPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:55:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AE2DE8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so4911829eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l19L6fTMT+2abs+HVT48B36V7g+rXx3Nn4f/wCqyd8=;
        b=D91q8Wyo1ALfiHRP4ScLq7BqPgwaUuS/VfK4gJdCec3fBY8DVmQSqW6ZPF8okCRFOY
         j3sqTbLKdhBH8NNQaT8XJmdepHbhLmCroUXchv6gct/lJWtjy4LqNVbF292jdiAFI3/X
         3dufOa9MeWHPHOpS6z4M/YUeJg7Di5KISRdOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l19L6fTMT+2abs+HVT48B36V7g+rXx3Nn4f/wCqyd8=;
        b=CraPG8A8CXgioZERkRw+4tugmIAARnqXxTX0OQgXzIpPLJog8P9NMW2suG/BCeRPiX
         kBSsCFpEXaiIz+1ug8NlA9iNTYDS0vKpcWFOeLtqPhSX43O9TDPf7Ppkj/81iQuvjOmi
         84fxIxHpvw9oSqawaHI4K7lPxMNsj2KKdCZSiAtcg5LG0ETJyNllMup2fg9m5oxV3i4n
         Xrn4HlPXLZQjaxKrgL5fDMX2CdgpI7P/SZZrS6BXg4Qy36IkOfwJYnFP/a2lXHI4+f+E
         IGx02Rn1KetOBX1JJWc+VUYU9Au5Go27EZDxiP2B1BdQQv9YdL1GVBGYsqjo2p4qbEDR
         3QEA==
X-Gm-Message-State: AOAM531j6dtsLj5Bpvu8A2nS3nMQ6rJyqQztRi/K3l5zzwe3GXy6ZgbW
        8SnU9V+kTcFakl+dcwDW7WF646Sz1XaDsqJFVAU=
X-Google-Smtp-Source: ABdhPJzmvZYE2EbOpPFvqH/oijzbXXGAG8j+rC5+f/JgjH25J6S2+Y+Uf0BeIqNCQSWc30ySpbG6Cw==
X-Received: by 2002:a17:906:c284:b0:6f4:dcc3:7939 with SMTP id r4-20020a170906c28400b006f4dcc37939mr24566150ejz.444.1652284552234;
        Wed, 11 May 2022 08:55:52 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170907984a00b006f3ef214e70sm1084348ejc.214.2022.05.11.08.55.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:55:51 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id u3so3638916wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:50 -0700 (PDT)
X-Received: by 2002:a5d:6dad:0:b0:20c:4dc1:e247 with SMTP id
 u13-20020a5d6dad000000b0020c4dc1e247mr23326807wrs.274.1652284550591; Wed, 11
 May 2022 08:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info> <Ynt1z0eZ19eMqp8I@zn.tnic>
 <YnvbLx9FKgQwZJ/F@mit.edu>
In-Reply-To: <YnvbLx9FKgQwZJ/F@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 May 2022 08:55:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
Message-ID: <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> I would argue that it should be the patch submitter's responsibility
> to explicitly add a URL to the problem report.

I agree in the perfect case.

But in practice, we have a lot more patch submitters than we have
maintainers, and not all "leaf developers" necessarily know how to do
everything.

So the maintainer should probably expect to fix things up. Not always,
but also not a "the developer should have done this, so I won't do it"

This isn't so different from the fact that not everybody writes
English proficiently - people do hopefully end up fixing things up as
they get passed onwards.

               Linus
