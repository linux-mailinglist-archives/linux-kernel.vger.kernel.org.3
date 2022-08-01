Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEF586E99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiHAQeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiHAQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:34:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D137187
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:34:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ss3so21314867ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xlS2N1OjIb+Mlm2noxBpchpMfEINKP6/+80ohklA0v0=;
        b=S6+Xh17ADpvkHb70HUY1m75bVZCuHKqEJP8QQVK73WynzOhNMUclcRD6wdSwMfQN3r
         SXiJ0w43oLZjGDxkK0Pr++zEhsvlQo9Feqil+xBrlJdcNXojVLFTdULOxjvchXL61V72
         XdH3Zx9uCFkjZDR0t9Df22ikHOQLzg6bFlKpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xlS2N1OjIb+Mlm2noxBpchpMfEINKP6/+80ohklA0v0=;
        b=FX4qEStHPGa0Ce9W6zgLO41f3F9lyuXiiPZ68v8y6HQRU0PyUobTK3aE0K347EzYxZ
         aNxKZ7cpJc57a4vTORbOc/jth7yiegjCh9THdNuSgubDZSRnu4TVTP1pSIHr37LpHMqT
         x+FeNwMwjN5cIDVDg3c+68giFwdXRfamKVhf20X0mOIUTEfYopSh3efQmK3NVw3FOpWO
         43ur4I8c7SDVe7kSPgb1hFi4mdNkfxHbmnTa7B3DHKhtn0mtV1I09AdQGhg6+xP5q/LD
         EsFBX3IBWcVqxSOT1HQMuHUXNSDxtNks4DY5M+sAWMQgd3eCR9UId6/cQFHQn6YO8cVd
         h/Ow==
X-Gm-Message-State: ACgBeo3aMcfYm04RB2PE1pW94PqfQE0PwBaQpI9Q/Di+lYfYj7tQTV4Q
        7td0/N/1fJUYHYWYM5tIWMkqdWCqDnt3X/3uyUA=
X-Google-Smtp-Source: AA6agR6HZFwFSna3GaIocaFlLV8SjYbGnDorcaboyetSknjawv9VuETWED/huLKbn3LK/jLwVkPSxg==
X-Received: by 2002:a17:907:1dd3:b0:730:9340:a0a with SMTP id og19-20020a1709071dd300b0073093400a0amr2743535ejc.316.1659371682904;
        Mon, 01 Aug 2022 09:34:42 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id ta13-20020a1709078c0d00b007304a28471dsm3172104ejc.43.2022.08.01.09.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:34:42 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v3so13895198wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:34:42 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr132531wru.193.1659371682031; Mon, 01
 Aug 2022 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <YueXA90ePDFY7mKf@zn.tnic>
In-Reply-To: <YueXA90ePDFY7mKf@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 09:34:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy+R8dW4RCV4-1ydh-JTy+4LCn4BbqNvBqxshDtp-XGA@mail.gmail.com>
Message-ID: <CAHk-=wiy+R8dW4RCV4-1ydh-JTy+4LCn4BbqNvBqxshDtp-XGA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cleanups for v6.0
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 2:04 AM Borislav Petkov <bp@suse.de> wrote:
>
> pls pull what is probably the most boring branch this merge window.

Hey, I like boring.

              Linus
