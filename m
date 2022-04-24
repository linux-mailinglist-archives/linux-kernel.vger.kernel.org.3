Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D260A50D551
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiDXVpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbiDXVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:45:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1756210E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:42:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so23185570lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MOvdDWFomD1nJ5GdyiOljnnxohoncHWbCnMwGFS3Nw=;
        b=cIO+GGhoCShCdoHOaekc0Dd3Zn20Ajx6KNM9RIVWQANU7JQc64mQ2VRKGeDxwVofxb
         aXXGspJ1zsoi/XEx4RlK2UsZ2Dr48k+QhRm9+5uZ22gG6p3bycyshuaOP9vC2n6zWJ57
         SWBjYcKaLh1+iwJHq97THJm1elyRtpxtDXesE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MOvdDWFomD1nJ5GdyiOljnnxohoncHWbCnMwGFS3Nw=;
        b=XLdDjsQlfdSKGzZCGadTJ3caZbJW7828lGpeERlLB3X76g+S9mg5BMqPU3qE8Pewv+
         deO3XsK29bpwnOK458ZsXgW8c8NCeyTmu8GFXiYyw+n7qz78Oxl9+EKdgHPUiKYRvYzB
         CGItD994+FGZdyH4fI4jXQBH+d9Yv2S4TbIWv4e7We2X//aKM0oOEz9HPRq+i2OFH3la
         6C0ijd5A22+PaUpmGSxoRpqLve01jtUIbN0boKjGdLZWNUpMY0ia7dnVUq4D4TiA2IX6
         xpEbBV/dt4AR+W/XLzftNmgag6Fz+aF/YwkJxXjhJCo6GgzZ9ECGxLiXkkgytjPqnYbn
         eoSQ==
X-Gm-Message-State: AOAM533WN/W7DBl4e//KyOUmCIoPec8gRU1t/baMAhP0ebMWsWKvqoB3
        COQFG7hzwWmDmOtXt6XDqfzsIMlN/w9MiU5U8xU=
X-Google-Smtp-Source: ABdhPJwYKPauM84nT69LmlncAw7neNpzaMdozkMk92SxeeKmSBifVrErBzy/dGhFIWkZh5WEvq+dww==
X-Received: by 2002:a05:6512:3b09:b0:472:70c:13d6 with SMTP id f9-20020a0565123b0900b00472070c13d6mr1280294lfv.266.1650836565547;
        Sun, 24 Apr 2022 14:42:45 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z22-20020a195e56000000b004720c4be97bsm1872lfi.152.2022.04.24.14.42.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 14:42:44 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q185so6514268ljb.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:42:44 -0700 (PDT)
X-Received: by 2002:a2e:8789:0:b0:24f:124c:864a with SMTP id
 n9-20020a2e8789000000b0024f124c864amr824977lji.164.1650836564386; Sun, 24 Apr
 2022 14:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
In-Reply-To: <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 14:42:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibmkFz6dybsdpW_3kUnV20FhJazerWDcbm7yCp_Xv+CA@mail.gmail.com>
Message-ID: <CAHk-=wibmkFz6dybsdpW_3kUnV20FhJazerWDcbm7yCp_Xv+CA@mail.gmail.com>
Subject: Re: [PATCH] hex2bin: make the function hex_to_bin constant-time
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
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

On Sun, Apr 24, 2022 at 2:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Finally, for the same reason - please don't use ">> 8".  Because I do
> not believe that bit 8 is well-defined in your arithmetic. The *sign*
> bit will be, but I'm not convinced bit 8 is.

Hmm.. I think it's ok. It can indeed overflow in 'char' and change the
sign in bit #7, but I suspect bit #8 is always fine.

Still, If you want to just extend the sign bit, ">> 31" _is_ the
obvious thing to use (yeah, yeah, properly "sizeof(int)*8-1" or
whatever, you get my drift).

           Linus
