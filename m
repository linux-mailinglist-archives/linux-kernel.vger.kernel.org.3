Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22EE535259
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348022AbiEZQ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiEZQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:56:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4F19035
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:56:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd25so2531578edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isOrsXL0jHLDNpKhO8ZEqLC8ipi0wUCiYFmfhMLBsnU=;
        b=bE6cq8VXUw1ng5S8fzhwxLsVvpBr5SVM2s8vxx5gkoxKNAfetakdLEGE8CTXa7IJZt
         K+kt/6HoJEa2Ex44jO8RkS5uhxfCoTX0Grykbi/9zAJ1IlCmATU8zUZE2TcOkYXZGSmN
         oLQGi/OQ3kqT+160gfv8dAn/LD5zrNzI2mUm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isOrsXL0jHLDNpKhO8ZEqLC8ipi0wUCiYFmfhMLBsnU=;
        b=xOY3dWP/7BQTuHn/NXKHaaUYIyVtPSDkb50gyfZImiZkBh0STycqXzZAuDMmyX8uMR
         PtMqpf7cegUVpP06UN0T1VfK7C+K+y2JfsQG9MTcQZr7gdZU6zgD9wjDs3tmEaLSa3/R
         XC+g2YOWdHCQL7pRf7/bjg7sxTIMK4EuRMKP3YPuPO5vgTHmBPyubUwOklT4Un3xXwDi
         veR7SFcJXvnKuwtl1SCaDsVxhUGDZLJAb34skfixf1cdX7Teb3QOAd4FtxOTWxEcb3Xl
         PWVbKqs1s7sQPE8X7yiJ2rOx4mwt4fNjspf6s4DO8/g23seJKLaRy+8JnNsB8njDGQqD
         QNUQ==
X-Gm-Message-State: AOAM531sl/OyIRaEp0ybfRShgHV4nvDnbZKaq23tBglhOa2oQqmhzCrh
        rRn6WiWRxBpQp2PSvr+aZI4ONsqrAZz30u8ab88=
X-Google-Smtp-Source: ABdhPJzK8fy4Q6MqPhRtdGxI7QVFCr5WZeaVA6mp9ND+XGyxEjDiddss3q/7CoMA0ZjVAsjjtYlAbg==
X-Received: by 2002:aa7:d591:0:b0:42b:de9d:423b with SMTP id r17-20020aa7d591000000b0042bde9d423bmr3203820edq.359.1653584196913;
        Thu, 26 May 2022 09:56:36 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id c23-20020a50f617000000b0042b765c2448sm996034edn.80.2022.05.26.09.56.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 09:56:36 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id z15so2848520wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:56:36 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr25595398wrs.274.1653584195719; Thu, 26
 May 2022 09:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-2-ubizjak@gmail.com>
 <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
In-Reply-To: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 09:56:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1xKLV3aWWvp46295yFkAnzxv3pmehoHk6RuEwB0pa_Q@mail.gmail.com>
Message-ID: <CAHk-=wg1xKLV3aWWvp46295yFkAnzxv3pmehoHk6RuEwB0pa_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
To:     Uros Bizjak <ubizjak@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
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

On Wed, May 25, 2022 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ack on this one regardless of the 32-bit x86 question.

.. and with confirmation from Michael and Mark (and the analysis from
Uros on the fallback code), I've applied this to my tree.

NOTE!

I have *not* applied the second patch with the x86-32 change to enable
this on 32-bit with CMPXCHG8B enabled. I think that's independent, and
will leave it up to the x86 maintainers.  Plus I think the patch
should be simplified.

             Linus
