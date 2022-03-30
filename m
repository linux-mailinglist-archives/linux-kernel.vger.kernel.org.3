Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31014ECFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351690AbiC3Wr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbiC3Wr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:47:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4251303
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:45:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so38324695lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1j9fz3Cu/QbX1kgXPUdhqmgSvv8o6W31ctsgESbDYXI=;
        b=Y+oenZnAxOs0Oa/LxOoHw7V5U4iFWLEMeu8CTU6FX6z+2ZA1JrG7HNlzdz+bEnT5Gf
         xL/OQUTzZ6rGnWa6NWFrb7YSrzZgXJGk8plp0vvpmHUo9GZqvXFMbI2UiAdG9NGHRVtb
         onftG7gZ4l4Q+v6UgEQb6enus9m9G/kv6XmMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1j9fz3Cu/QbX1kgXPUdhqmgSvv8o6W31ctsgESbDYXI=;
        b=YSXF4cf+EwHGtuORJ9BHq8ezIL+f9RMT97b7q7VC9AiTxUnwiLN7v15W+aOg4PDesB
         cxKb21P3gWJO4ZY8Y7ua7tTCa729E2ArvXe7iODN2sHEi3vMSLOAMDMl9A/ixeMshS3x
         Vojsc6WJMMutIEaYB7/4tGoZL99SgoL82vzVp8c1/q46W8Ymh61LXgURyPFoCNtxEPtt
         HDcJ1Aj7fR/jIAyOolJawo4gJzKTctglB5SSCCOdPjBuPmo4tGBlgRlBGvjHgvqt8JVO
         gNsxHfWIGGzuQui+qQUrwEL9MaLG/crqlbASrkCOoIqDCjNM6JA/Gq9DPEZ77G5LP9Lk
         kz8Q==
X-Gm-Message-State: AOAM532t3z1NapvrpMWOzrbl7L7l9mSa9L1Kg4TqFQvUcmvJfuS1gagb
        BL+36iO3VRYQs5nolVWboLCJpjoabq1QGFbb
X-Google-Smtp-Source: ABdhPJy7LI6aVHZJ4JQw6MJIEyb9iQdFQk/ufLY+gqjCHxz6oy+hpEyxNyVU0gPxLhuFkFvHQ86AXA==
X-Received: by 2002:a05:6512:318c:b0:44a:5104:55bc with SMTP id i12-20020a056512318c00b0044a510455bcmr8609858lfe.421.1648680338552;
        Wed, 30 Mar 2022 15:45:38 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id bt23-20020a056512261700b0044330517d68sm2465869lfb.191.2022.03.30.15.45.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 15:45:38 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t25so38323846lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:45:37 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr5326995lfu.449.1648680337352; Wed, 30
 Mar 2022 15:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
 <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
 <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com> <4eed252caf56f16c290f0c54b5d850d4eab5dc1b.camel@hammerspace.com>
In-Reply-To: <4eed252caf56f16c290f0c54b5d850d4eab5dc1b.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 15:45:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_0L4u_Fd1S3r+-1Ok95HveaXNqY8h3McJOUCfk-tqDg@mail.gmail.com>
Message-ID: <CAHk-=wi_0L4u_Fd1S3r+-1Ok95HveaXNqY8h3McJOUCfk-tqDg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.18
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Mar 30, 2022 at 3:22 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> With 9175 ext4 offsets, I see 157 collisions (== hash buckets with > 1
> entry). So hash_64() does perform less well when you're hashing a value
> that is already a hash.

No collisions with xxhash? Because xxhash() reality seems to do pretty
similar things in the end (multiply by a prime, shift bits down and
xor them).

In fact, the main difference seems to be that xxhash() will do a
"rotl()" by 27 before doing the prime multiplication, and then it will
finish the thing by a few more multiples mixed with shifting the high
bits down a few times.

Our regular fast hash doesn't do the "shift bits down", because it
relies on only using the upper bits anyway (and it is pretty heavily
geared towards "fast and good enough").

But if the *source* of the hash has a lot of low bits clear, I can
imagine that the "rotl" that xxhash does improves on the bit
distribution of the multiplication (which will only move bits
upwards).

And if it turns out our default hash has some bad cases, I'd prefer to
fix _that_ regardless..

             Linus
