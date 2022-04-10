Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4C4FAE6F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiDJPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:23:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB54FD03
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:20:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso9653809otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ui9lp0TA3JfVzfhgkvP/Tb30LS8kZ/gurQz/lTE7yo=;
        b=Haux9mtaj2UidFgxiVkuLzl22ZI2PUsAqeM8HjJciz/gi++9XG5iNydIiUSXWUfJs6
         6epyuD4k7Furn17pSBWR6d0lAjA/hMmsaistudACKPYIG1mq2oyK3GCQUwxXXWGrpLJr
         Lrq82f3VSXwVRQnTw8atituGEQXg0X4VENxpallGnCHIy384qvTqmoWTkaLG6iNhz9bM
         gfrLGcWn/vW9PmMhOG6nqHeJ9sWLSVAKYtQjurUUDaZKUu9EDZ3YrIDmzRiqwUbyCMHr
         xAAhcNBgbaKmZpy+q99xzgikAoGXZWe0MluGztRbmrFen01BA6MYUsnExpvisIrwJ6+z
         RgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ui9lp0TA3JfVzfhgkvP/Tb30LS8kZ/gurQz/lTE7yo=;
        b=e+mPhd0KTlDAnqp+h5as2tKVaMXpsi0W0bO0GwTi4534glOUafGs8fER0gWiUbQ//h
         R9TOmcfWZiQFIzEBRuJiSGlKo85Qx8wXyS/1TJMMFdr7QTfkOYL6i1LUANchkFI0xFrL
         2FJ8r2drNX4qt71TIqiauTPPa8kttdEzOp+OQkYonHwhSuF4nNpbaeSCTjoPlJW1K2aI
         tbhex/SdkPHLD+g+TxWFJ1/DaBd+DTnbKRkBbotXJstXWTibcbrjlzAJRfdE0+OjURzG
         wtflrA78JEpp9saSH+M+zM4x4TlP23tSvXiCQRLX5G2KN/ZoDaJfY1Ig00IIXYZPu3x7
         LLTg==
X-Gm-Message-State: AOAM532vB4afQicBwGJgxVLn1soXKND8hHFjcLoGtsBI2UebuquhDL+k
        I2NFC+LKYIB+QVPVJBzLrqF+zpwEyZNeClhaKQ==
X-Google-Smtp-Source: ABdhPJzw0FAZ5I+MkYSnUYreFjDMKChto1zrLpFl41H05V+lM+J5PkkYeIbiZYkVXY3uiUSleYUg+8RInXgT+z9Shoc=
X-Received: by 2002:a9d:f27:0:b0:5cf:8702:9ee9 with SMTP id
 36-20020a9d0f27000000b005cf87029ee9mr9682041ott.194.1649604057931; Sun, 10
 Apr 2022 08:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220408223827.GR2731@worktop.programming.kicks-ass.net> <20220408231447.GS2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220408231447.GS2731@worktop.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 10 Apr 2022 11:20:46 -0400
Message-ID: <CAMzpN2hN4xtJfZ0Jpu=TkMcX-5gNartYVQ867Ni8J1YW14qbXw@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: PUSH_AND_CLEAR_REGS_COMPAT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 1:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Apr 09, 2022 at 12:38:27AM +0200, Peter Zijlstra wrote:
> >
> > How insane?
>
> Anyway, the questino is; since int80 doesn't wipe the high regs, can we
> get away with the SYS*_compat things not doing that either and then all
> using the normal PUSH_AND_CLEAR_REGS without having to invent _COMPAT
> for that?

For a pure 32-bit process it doesn't matter whether the upper
registers are preserved or not, since they are inaccessible.
Mixed-mode code may assume the upper registers are preserved across a
call to 32-bit code, although it would be very unlikely to encounter
SYSENTER or SYSCALL instructions anywhere but the Linux VDSO (and use
anywhere else would cause undesirable results).

There is no compelling reason to not preserve them, and code
simplification is a good benefit.

--
Brian Gerst
