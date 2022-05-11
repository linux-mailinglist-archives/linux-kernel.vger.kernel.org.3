Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885BD523C70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbiEKS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiEKS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:27:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828D6623F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:27:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ch13so5685286ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8i5OqL859EJUndLqdpyRDZH0AKz1Nfbg5NkEZBumyYc=;
        b=F6YUNe9JYU5exa1en7crUAFK+IeIw5wm5JMGme/AEz7g6vN52RFIEcQcD/G21CCjRZ
         b467EIkBU5M1TKpIY4myh0XwqOBshQypUujtntee3xmYSWRS4cl1doIzj1mendYjL5j7
         Ai1PtykjGc7qTjXN3nuZJtpoH/Di2UULVtiavKLilDIRTDu6DiI9yrkaWD7vEjJtWUeY
         Y9FvW+d2yPucKBBzdOuHx3xmFByxjbIaFRW2tPj33TsVW+e7ji/BDmo+tLQvLG+0orwy
         661nqi4oX56tfPHd+HkgOAbQYvsiAPRT8KC+iG9R6BTFFYqvBOCY345Y9gAel+l1QC8X
         HT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8i5OqL859EJUndLqdpyRDZH0AKz1Nfbg5NkEZBumyYc=;
        b=JI/VrwMu3+AJdNujDIOCT9fVyooOC2rO4qAPaa7rhoS6e826pRr33iedSJZk4fDhpX
         NeXrLuZa5/8JYt5Ss44epl/JV2xpNMw3gvNI7s9VgdgWxuAWBZGIAxPKGr+LOdMTwt8k
         8G1zAsisFAja8u+ioBfluqZd+mxfXrUyyxUmwD8OfHS+gu/IQ59feygSWbgtpaqHDyrE
         YeiEutSRA7UzBlF5+NbqQo8UaUOrvEhR9Fj+r3yOnkXPY5Hod9bz2+MkJ+nWx7N8nW/0
         Xm9/tDsqFB9WqbHUBbU+9+ON008xuc5FXB8Eb1CcEOjvYoVOxSkc5aGzhuu03o6j3QEa
         tnFg==
X-Gm-Message-State: AOAM532MpeIwSn93V+8uEDoMUhj6ZyUoHV6bY7mP3zXnGDg3PjWaVl0d
        A7RnX10lZwMkysVLSo/vfT39OVRFPg4fV4Spu2wjKw==
X-Google-Smtp-Source: ABdhPJz8PQsE966KybB3t7TlW7Rim3780OS2G5SrFf8O6unqFgUy8x0/fq7MqIYU0bnTay5CY4mVC+0ZXmQXFhKy5RA=
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id
 e14-20020a170906314e00b006f006590963mr26522983eje.358.1652293657552; Wed, 11
 May 2022 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511174531.1098548-1-keescook@chromium.org>
In-Reply-To: <20220511174531.1098548-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 11 May 2022 11:27:26 -0700
Message-ID: <CAGS_qxokQAjQRip2vPi80toW7hmBnXf=KMTNT51B1wuDqSZuVQ@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> systems; the types exist there too. Remove the #ifdefs.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Daniel Latypov <dlatypov@google.com>

Makes sense and looks good to me, I was able to run it via
$ ./tools/testing/kunit/kunit.py run --arch=i386
--build_dir=kunit_i386/ overflow

Raw output was:
    # u64_overflow_test: 17 u64 arithmetic tests finished
    ok 7 - u64_overflow_test
    # s64_overflow_test: 21 s64 arithmetic tests finished
    ok 8 - s64_overflow_test
