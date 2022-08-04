Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4358A2F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiHDV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:59:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24C1B794
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:59:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id uj29so1808273ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IcNrO1+0hMqd184OyaCGXcplDsRzgmMXiA2NSTUXMiA=;
        b=DgUfEmbFi+7iccqebXv/ZmxHK9r9RdQFXNZ8Dr8nUqVqSFRu1k1i4dkyHQybTDWbVO
         sp+j5Hqj+Tzo+GWbTEgXuKCuNQljNQ9hMiFfoJp1J9Mgms1GKmSOP/+HzKIHuHs4qy4O
         3hYvbGIWtatQX31kWhmvlVBT2gIyBbOi9AxB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IcNrO1+0hMqd184OyaCGXcplDsRzgmMXiA2NSTUXMiA=;
        b=zdmga2gWThQ7R3YxCdInB9aGD6o6iLYRvyd2vRrMtF7OI6SSqlku5H6OQ9S9yyS5fd
         KP3mcebJa1XPAVzctCBfYrYbXwC+4fO4jQYwbhB7vNkNQFAAhrfZOstTe20HE4CnxenK
         cZdWhzZjE8B1wO5tSRI+hA5pxHMBBlsZSglqEjBCjOhZbnlwlnGuLCJrS7SPEy2VHW73
         VKYtBKYDjMnkFTaUxl89SiitQcfCHRk44VlK4CHfqmHRL5LLUy9yXQ/1Yw6VNm6Lu5xX
         GDgT157u3buxCub7eIiuoottZohlM2cxACWIFUv2LBad2BDJlEPNwsM2+ek8xg9pkwh0
         p/lA==
X-Gm-Message-State: ACgBeo3T6mvVG9A5rvP++m0fZpqImSsFvemf9svAzxnWHGV5S+E+3t2X
        E3SDGDUT+XucnsX64tmlWYWDc376O3Nx6Gfa
X-Google-Smtp-Source: AA6agR4QfR16Kp2/z9EYYip//6E4zm1vhmilW7dEQgmpyoWcxbSg4wzOwBZhT9WkLU0PLbEi9f6F3A==
X-Received: by 2002:a17:906:8a74:b0:730:7aa8:69eb with SMTP id hy20-20020a1709068a7400b007307aa869ebmr2759733ejc.573.1659650358576;
        Thu, 04 Aug 2022 14:59:18 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0072af930cf97sm758116ejc.115.2022.08.04.14.59.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 14:59:18 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id l4so1201796wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 14:59:17 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr2534090wru.193.1659650357549; Thu, 04
 Aug 2022 14:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian> <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com> <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
In-Reply-To: <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 14:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpa_FJjvzWdWdSzecTbVtndbQqg35=_o+ohM3X1_xKTA@mail.gmail.com>
Message-ID: <CAHk-=whpa_FJjvzWdWdSzecTbVtndbQqg35=_o+ohM3X1_xKTA@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Aug 4, 2022 at 1:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I do note that commit 1b54a0121dba ("drm/amd/display: Reduce stack size
> in the mode support function") did have a workaround for GCC. It appears
> clang will still inline mode_support_configuration(). If I mark it as
> 'noinline', the warning disappears in that file.

That sounds like probably the best option for now. Gcc does not inline
that function (at least for allmodconfig builds in my testing), so if
that makes clang match what gcc does, it seems a reasonable thing to
do.

            Linus
