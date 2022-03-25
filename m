Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D864E72B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358381AbiCYMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356606AbiCYMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:07:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56575D4CB1;
        Fri, 25 Mar 2022 05:06:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z6so8666649iot.0;
        Fri, 25 Mar 2022 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=upyfPWKTPijUu3LLQdvbz1D8OMw+mC3Oz2F2WhQvJt4=;
        b=npdtURY/YiERuAzKtZGMP/LS3dMpKsj1NsO5BLExrPJk6guwVpuuO0O9UlWq+HXM0/
         Zv6pQHlw4laO9hR07emE79hqoKszXrt9haw5CCXp+Abb1rsY6HkvVwtOjlDiaA24g6OV
         8YI7hw5O0Mnr1bYZn0Bfd3p1tpqNbJjRT/2u0aT63aKBe38pbUZkjN/nWHJMXJUw6673
         UvDHXfYIA8M4LsjMliaKJ0YxW5JafOMpVHkotPw5U4Wse4yo62SPfTNlM0Xt3KrzCw3V
         k8k8SMsdkwgAaMTAOrOxlXst2XlIBHwb39NiItn1dYZxgdLkb6P79+xCfmblCB3EkT6E
         h1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=upyfPWKTPijUu3LLQdvbz1D8OMw+mC3Oz2F2WhQvJt4=;
        b=Qik5pyYullbD1poJDq56C6gLPmbvxxmEa9/V1zl6kzM0//XfCvy+tJJ1FnmrE2GRnt
         /TY8+Q0Nyu8xA8yFK2UOLH1hzkmjM/PBTOJiUFL3aWdRxVYP3F4oHoJNt+ZZhvgw6+ms
         HAdJgrJEynOfeAp6/JmpNr4r6onGz5U67n0+U/M0gea+Kz4NBhsIma1RtcsU8Ev8Twt7
         oDbKdsqTf6nq7TJgGxX5uO9hhf8sozohXmO+Q5zYigUnsN/HW589cv/rY/Sdv4prYPd4
         xHZZK6gAnMd2DI0IqYIy8+67rbq5BAB3WMjresA5k+QPWIWZzoVZ3T8z1Fcie9VmmxaS
         Mp1Q==
X-Gm-Message-State: AOAM531xRawT6kWZJHQC1oPziNrIk5zsbDyIfllu958ME5SXM+4gbtwC
        HkUbZtYjwpnv64JFS3cYUpXLBOs7swZq/dCc7u6qJoJcw7L5w8eW
X-Google-Smtp-Source: ABdhPJwkAQDiWnSJUsJArQAnI9ev1oWkpSQv1DV045+CV+bFcuX5Gms1yu5UKjwjoG2qluwCGUG3JmmKCRsb3U3xPRM=
X-Received: by 2002:a6b:ed11:0:b0:645:ebea:782f with SMTP id
 n17-20020a6bed11000000b00645ebea782fmr5346482iog.48.1648209961734; Fri, 25
 Mar 2022 05:06:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Mar 2022 13:05:26 +0100
Message-ID: <CA+icZUUuxphqCBhgGF+XhBG12v-rJ9BB9r5xEWJHLUAHfxFJWA@mail.gmail.com>
Subject: [PATCH 1/2] x86/chacha20: Avoid spurious jumps to other functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, ebiggers@google.com,
        herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

[ CC me I am not subscribed to LKML/linux-x86 mailing-lists ]

[ CC Nathan and Nick D. ]

Hi Peter,

Thanks for the patch it fixes a long standing build warning for me
with LLVM/Clang toolchain (here: v14.0.0).

Along with a workaround in [1] I am now "warning-free".

Just a note:
I guess crypto folk want a "***crypto:*** x86/chacha20: ..." in the
subject line.

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v14.0.0 (x86-64)

Regards,
- Sedat -

[0] https://github.com/ClangBuiltLinux/linux/issues/1613
[1] https://github.com/ClangBuiltLinux/linux/issues/1613#issuecomment-1078663165
