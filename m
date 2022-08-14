Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D5591D58
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiHNArJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiHNAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:46:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461F54663
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:46:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tl27so7941802ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x2TJWb9VPxfS4WbEMgi+9muxipCHahNie+FBh69toFk=;
        b=P41/CsUxUsIATZkpcMv7hdU0X8HMf8UCtVaJc7H8Q8F2QNKlOWLaIFBPC6yPc3vg1i
         a7Uk1CF19oMNKx3AYrY2X8JAB2w5R3MtuWbQzl3X+6aEhHMXM1ZVZ0UOwc/mpV4JX1jb
         YmsL38vP2Ozuut9ebAJlYTOg4L4aWsVdFPa1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x2TJWb9VPxfS4WbEMgi+9muxipCHahNie+FBh69toFk=;
        b=54wDC32vWsFuiELN6WsNH1F+kuLG27Ztjc+yGbn9TnpTxHhLwvfRxHiik85kMVFPQg
         DhinGG84pxBdhK5dFJSqR/P9SC4HArwCGV+06QVMRZlRwhDRY8ZXxfIkaVLSlgHRW/lc
         4KDPjGkiI4sBh9V62/2zyIOu4a5b9Y6AMBaYuUrU/4HrF/ria57nOnGxv2Z7Kl+YBUMO
         j4bbUvYkPQJIq3vNWRVVKC2QK9KoQ5JLRMoIJmWaB8rXVBZPNDFoagGqn3PeJqTmDXIs
         OWDDz6d62C3VBLMCmS5i8EXduOGLSnjS9H/cFluK+cNixaoNsudG4iU4Tn8KHnqYGs0e
         X7RQ==
X-Gm-Message-State: ACgBeo3kLbewZoPaZiqa6kTD5KLuA6iopkIugcgzuE/yQ150ufLW9djj
        V7NllrCsTOn6vp9Ej3JuO+GZPV8WJCE5NNO1
X-Google-Smtp-Source: AA6agR6EkdRHI5SM3FkZ86RqP60eJgogZtuUy7nj/zV962J7qXb9dLzdinEVcqBJPNil7Xv9/gqmyw==
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id he16-20020a1709073d9000b00730a937fb04mr6766096ejc.176.1660438014403;
        Sat, 13 Aug 2022 17:46:54 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id bv18-20020a170906b1d200b007315e57ba0asm2424301ejb.114.2022.08.13.17.46.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 17:46:53 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id z16so5058907wrh.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:46:53 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr5340552wru.193.1660438013290; Sat, 13
 Aug 2022 17:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <87czd3d8ra.fsf@mpe.ellerman.id.au>
In-Reply-To: <87czd3d8ra.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 17:46:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLWWteYdVgXuLv9TA3aGsUaKV8gS3WxBo+NHHn5ZHkPw@mail.gmail.com>
Message-ID: <CAHk-=wiLWWteYdVgXuLv9TA3aGsUaKV8gS3WxBo+NHHn5ZHkPw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-2 tag
To:     mpe@ellerman.id.au
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        ndesaulniers@google.com, ruscur@russell.cc
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

On Sat, Aug 13, 2022 at 4:27 PM <mpe@ellerman.id.au> wrote:
> [..]

Btw, could you please fix whatever your email setup is, so that you
have a proper name?

Seeing that 'mpe' as a source in my inbox just makes me think it's
spam and not real mail.

My search for "git pull" will find it, so it's not a huge problem in
practice, it's more of a "what is that garbage in my inbox - ooh, it's
Michael Ellerman's badly configured email again"

               Linus
