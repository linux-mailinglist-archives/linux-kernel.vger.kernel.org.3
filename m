Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71059B594
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHURMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:12:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A993921E0A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:12:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c39so11207245edf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2IG7yxCXKhrrmlYS5yO7XY8+9kSj2TtQKMSIeXBcBeM=;
        b=KzixGCuDnswaMadZqR4ynhhwNXnoXEVyUxEjeuDGHd5tL+ljlGzsi+LE8LF7F5lwRn
         v9mjz4V1ufMkIAeKimYo9EAgIy0HyOy9AOd/PAq3eqylpiDSkisiUMxEQp1Y8V7AtTGo
         NbrWgFjyqJ/5NmxocTy3bgtBX7ufagCwkWDhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2IG7yxCXKhrrmlYS5yO7XY8+9kSj2TtQKMSIeXBcBeM=;
        b=MGcHrQy572z4VB/IEaB5SuIMKmIPkxQRba7xX16CciYZRne7/4Jpuwst8K3aop41ON
         nIrL41JuHMuABWFeIO3CRNXLO8EM1aJts9BTKD7S9jDmw0wm6Kt/WppAtVfKEEJbYZce
         DUiCNGCwL8EuY89VlfORfpjjdn8Y4ZH58CKdGAAVeJVpilvQqWwL710CpgRuE8oX/k9V
         RBbDB1b56CvZCVR56O2ItJhYEGMmK5puuw0Dx4/3HeeW34RESh67t/A/U/atFjnAaav6
         RYj3cbw3hXRojinwMcD1ayh6L1tYelBkJRIGBDl1+C0nYfNdB3y40qwc4mjK5l4+LJNn
         p+9A==
X-Gm-Message-State: ACgBeo0Jz0Fnm6LRWPlxd5ApuUooNFNH1ZYqUijiyuDJLocBy3NNlyUW
        aDOGh1WXcOsU4GgRvYfsGJZuciWFrWOruGYg
X-Google-Smtp-Source: AA6agR7pBgSiujJMXEL2u8TYenx0VTTbbOZyA+a1JprtCx8gvaXE6o4EWhISi4RGCNheHWtrz+D7Vg==
X-Received: by 2002:a05:6402:f29:b0:446:6629:bbb6 with SMTP id i41-20020a0564020f2900b004466629bbb6mr6883128eda.384.1661101924910;
        Sun, 21 Aug 2022 10:12:04 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906171500b0072b342ad997sm5053252eje.199.2022.08.21.10.12.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 10:12:03 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id j26so4526460wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:12:03 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr10127541wmj.38.1661101922857; Sun, 21
 Aug 2022 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJFc9AnH_9CW+bSRotkKvOmkO9jq-RF6dmyPYOpq691Yg@mail.gmail.com>
 <20220819190640.2763586-1-ndesaulniers@google.com>
In-Reply-To: <20220819190640.2763586-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Aug 2022 10:11:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLcuvDDS3rZfEgDrwbdJrTx8HCRNiZ5cDc80-_gzHCxw@mail.gmail.com>
Message-ID: <CAHk-=whLcuvDDS3rZfEgDrwbdJrTx8HCRNiZ5cDc80-_gzHCxw@mail.gmail.com>
Subject: Re: [PATCH v2] asm goto: eradicate CC_HAS_ASM_GOTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        kvm@vger.kernel.org, llvm@lists.linux.dev,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Borislav Petkov <bp@suse.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

Applied directly, just because I love seeing old nasty stuff like this go away.

             Linus
