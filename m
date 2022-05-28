Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7C536C71
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiE1LBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiE1LBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 07:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB21EADA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 04:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0BB60DDE
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D38C34100
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:01:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hGmhkDsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653735695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ebxb2yEET8cq5O+L+DGLBATjTjCW37wGjozGgZgVV2s=;
        b=hGmhkDszfsTx7fDSH9zSVvZMr7Qelpz+SAiCTluQCf/HK9raU1ZqN7CaO+hgZbe3iFqHyH
        C9z0nxCjqyrAsIYU7oi+OzBpp/YivLi/Ueq7RRQHdwB0oPt6SOFYwsVu/VE48zbrguXly3
        yh2fQuromdWGzaYaalNgTmnK54OOyz8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5fb93a62 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 28 May 2022 11:01:35 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id v26so11823992ybd.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 04:01:34 -0700 (PDT)
X-Gm-Message-State: AOAM532wZZBMiJPT8fqquCu1WRL/X21thBtlJtMJeMba1brz33MewOYW
        MLiNyOW78OJP3x/yLkn5okXgsNeu8i5OMsCxf+4=
X-Google-Smtp-Source: ABdhPJzzGNIu2iCowK1yezOBdMlT4bN30byRAHpUpg3bigIt/zt62Jilq3fIdxa6dkm7WUvoVZvyC4lD1V8IjqH8Od0=
X-Received: by 2002:a5b:dcf:0:b0:64a:6923:bbba with SMTP id
 t15-20020a5b0dcf000000b0064a6923bbbamr45441492ybr.398.1653735694311; Sat, 28
 May 2022 04:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <YpH84wrg4ZxIkkie@debian> <CAHmME9qHRd-t8mupAG1w0jV-uE5UNrMeRO+8-0b_4N1cCPyM+w@mail.gmail.com>
In-Reply-To: <CAHmME9qHRd-t8mupAG1w0jV-uE5UNrMeRO+8-0b_4N1cCPyM+w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 28 May 2022 13:01:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9pS1ODLqJ8rw0hzH5+ZrUW8pwC2nkeD4mLVG4swp8BnQQ@mail.gmail.com>
Message-ID: <CAHmME9pS1ODLqJ8rw0hzH5+ZrUW8pwC2nkeD4mLVG4swp8BnQQ@mail.gmail.com>
Subject: Re: mainline build failure due to 8bdc2a190105 ("crypto: poly1305 -
 cleanup stray CRYPTO_LIB_POLY1305_RSIZE")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Actually, I think 8bdc2a190105 should just be reverted wholesale.
There are too many headers that depend on it (e.g. caam) even if
there's no .o that winds up using it. I could try to enumerate them
all in kconfig language, but that doesn't seem much cleaner.

[Aside: note that none of this was a problem with my proposed "zinc"
patchset from a few years ago, which cleaned up all this crypto layer
stuff. The frankenstein that landed instead is just a never ending
source of annoying bugs like this one. Until there are larger changes,
I think a lot of the woes of crypto/ are terminally hopeless. :-\]

Jason
