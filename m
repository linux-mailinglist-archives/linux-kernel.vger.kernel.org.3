Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EA586D42
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiHAOuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiHAOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:50:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE1DFDE;
        Mon,  1 Aug 2022 07:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B82AFCE16D3;
        Mon,  1 Aug 2022 14:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB3AC433D6;
        Mon,  1 Aug 2022 14:50:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hch54xq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659365413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IL1fL31Kufub455HpgLgDd5H/KhEcVXE4PfEbm2p3dk=;
        b=Hch54xq6rR0E6RYbiyyV/89OLOmKVN4Bw6ZxmnLZuw8LmSwF0XW81C3bc6mGKOEmHgU+tD
        stVWZPQWgfvM3g0yOcNAuDhj1u0bY/6XeKY+EKy42o1zWpBpgKJDIOC4/zqbRRq9WlmAx8
        yv7p88zrL9gNGF/nb54tGi7LQa55dqo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6957966a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 14:50:13 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id j195so19249768ybj.11;
        Mon, 01 Aug 2022 07:50:12 -0700 (PDT)
X-Gm-Message-State: ACgBeo3H7AFoDrboKltXaIv//KyAgqFdRk+63YFc3+ZazFoWHLMmrvLo
        rS3Ki9echLCxMLEsQhAuRO4mkJYJUUV0hIHOBJA=
X-Google-Smtp-Source: AA6agR6P70edYqiN+zUwKWi9WNeeDQlBEVmK8mzIeWJiBehF/9yUDRm2k8cgf/ZDiZNwZvbs/5SzSQc6w3Gplutopvw=
X-Received: by 2002:a25:250:0:b0:673:e6c5:27bf with SMTP id
 77-20020a250250000000b00673e6c527bfmr11691124ybc.258.1659365411128; Mon, 01
 Aug 2022 07:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
 <20220719130207.147536-1-Jason@zx2c4.com> <7285be49c459bdc8f4ec3abe85d9e171@linux.ibm.com>
In-Reply-To: <7285be49c459bdc8f4ec3abe85d9e171@linux.ibm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Aug 2022 16:50:00 +0200
X-Gmail-Original-Message-ID: <CAHmME9rk27DA0DmTY7hhedFT0ftkMKhZn30NCvjkkzkKD0hNfQ@mail.gmail.com>
Message-ID: <CAHmME9rk27DA0DmTY7hhedFT0ftkMKhZn30NCvjkkzkKD0hNfQ@mail.gmail.com>
Subject: Re: [PATCH v3] random: handle archrandom with multiple longs
To:     freude@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

On Mon, Aug 1, 2022 at 4:47 PM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> Nice interface :-)
> Here is my
> Acked-by: Harald Freudenberger <freude@linux.ibm.com>

You're too late; I already sent in my pull request. But that's okay; I
received Heiko's ack on this for s390.

> but please keep in mind that your patch does not apply cleanly as there
> is my other patch
> 918e75f77af7 ("s390/archrandom: prevent CPACF trng invocations in
> interrupt context")
> in between.

Yea, this was a late addition to 5.19, and my random tree was based on
an earlier rc of 5.19. That kind of thing happens and is fine; Stephen
caught it when doing the next merge and carries the merge conflict
resolution there. I mentioned it to Linus in my pull, so he'll be able
to work it out.

Jason
