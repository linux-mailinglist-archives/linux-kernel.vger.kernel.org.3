Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC415A3914
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiH0RDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiH0RDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:03:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5F27151
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:03:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so8324309ejy.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rRDti8pG5KQhB9aQRg3hhb8VtLpSc2P6R68v5/WJ7bA=;
        b=fZrwq1K/4KC18yPfoKnLiFQb9JiKd8RuKuMcF0++26zFG1xldWwkxC7D3GluruvgS7
         EEsixWQ/CLV8XthQXHxUVNJH2QWxAGoV6o8GvRcG5g36PyXM4yoJj9IdVd6YQnFW2daA
         FV4no7gR7FsbzmjcNWHJzFVyEUwwjZ5OVkjEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rRDti8pG5KQhB9aQRg3hhb8VtLpSc2P6R68v5/WJ7bA=;
        b=AgHHTkS2DwPimpII2pgtlXWuf3SxmEQ9NEbSBEmz+nMZ7ne041Ami+fATHqH1v8/Dd
         YGkkdKfldctGT3DDapPw2u3gvx1LYu/086p4AsCvyscyYk2URq9IVTdPeO1xI6h89CXo
         PvlAe3+6SsFgTRDXE0YgvUq819IsQn0lydjVmYs2t+Lgkh1HvsiKEIqSEgG8wevv0I+3
         2cblkIL1L5KjwQehYjeC7NxeU1VRZq0CgGcRijwigS/tw36LDZS+v7CZDs7mU4BgFeAp
         xLcy4bX5XjPcU3cyFa0xIhOuAdJJk+kngBZotXVwuJPWDuDp6MQB2UK2HTGy1W/oKelG
         FVJA==
X-Gm-Message-State: ACgBeo2rDtlq78bXqlpY3zkaBN3HPD+/cU/qNmmOpXfewRO4TAIJvsXy
        xWgACQ9i9WRluoS321MlJwr+Ye9Punsa3HLP69U=
X-Google-Smtp-Source: AA6agR48rn3fqXG8jY0hJmzTSdquLn+n8qPhiHH7UXxJhcm1yyHg0reEeBnf5l0NECzN++MxWQG/iw==
X-Received: by 2002:a17:907:6818:b0:730:d99f:7b91 with SMTP id qz24-20020a170907681800b00730d99f7b91mr8260764ejc.496.1661619809739;
        Sat, 27 Aug 2022 10:03:29 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id kv6-20020a17090778c600b0072eddcc807fsm2124857ejc.155.2022.08.27.10.03.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 10:03:29 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id m16so5235980wru.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:03:28 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr2570178wrv.97.1661619808375; Sat, 27 Aug
 2022 10:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <YwniL0M7Rxz8lua+@debian>
In-Reply-To: <YwniL0M7Rxz8lua+@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Aug 2022 10:03:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
Message-ID: <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
Subject: Re: mainline build failure due to 8238b4579866 ("wait_on_bit: add an
 acquire memory barrier")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 27, 2022 at 2:21 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> I will be happy to test any patch or provide any extra log if needed.

This should now be fixed by commit d6ffe6067a54 ("provide
arch_test_bit_acquire for architectures that define test_bit").

                 Linus
