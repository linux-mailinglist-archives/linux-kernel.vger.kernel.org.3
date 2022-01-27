Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FD49E768
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbiA0QXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiA0QXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BB1C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:23:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so551826pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6y8wjaR4vxJ8579JrqWtOWVGBP8Ocpho3Gs/0sO8C2Q=;
        b=Cxk8MCnimiHPkkbbllSaMa1YFEHnvs6PW8LZ0mwwmuBX9LY7ybpXVaqZi19rCLfhFO
         XVncqmS4p5+FKb0SIPHU9SV9G8p6EIJ5WsNdlfjcHCtvCzN22UpxGQpSmind30O2LnHf
         P7h+RGAe+V1Mmc4ZhtY0FEsuvRcaJO+plCXow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6y8wjaR4vxJ8579JrqWtOWVGBP8Ocpho3Gs/0sO8C2Q=;
        b=zAN4xzwhBggNTQRZNQ8wF0PFB3Um0dtrP75ZnCJ02/UVUiBdWIBcF9xJ8jP9uy5afh
         iWRSz4qYVfCBd80WQUA0542L+v8UzvE15jYU9EQq2teZRrT50U384vU9qCG0XfvXhQtP
         1yJkHxvas1zqjdq9IValOpwX8QgqbBy/zya1dDIdr959078/gxHKC6M3eJdYJsrciTGq
         aC6Xq4u1KpTRSvYAkmM38T9z35zHyNNFiXjajI1sIyObnIDDJepPo9VEl/jop95x2eRP
         D6BGwWeKy6olAMrqbMPYKEtVe76T2HlJdiwx23JeOZWF1IPr4GSnwKalKV8CzWlRqk0g
         A0GA==
X-Gm-Message-State: AOAM530fLdnkz1eby+4ZeH0WrbEncefdnmOFptYh6n3TBPyCur4Vmq/q
        EBGhwUKcay5cLGM/wRStinD5XQ==
X-Google-Smtp-Source: ABdhPJyMCj2t5XQMopodXETjSm7BwS4JfRV64awaq5lK9uUxhfSbHwY0vLd5SNeYG2gUhMNHkuVcCA==
X-Received: by 2002:a17:902:c7cb:: with SMTP id r11mr3982582pla.135.1643300632462;
        Thu, 27 Jan 2022 08:23:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm5611259pfk.65.2022.01.27.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:52 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:23:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <202201270816.5030A2A4B5@keescook>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-2-akirakawata1@gmail.com>
 <202201261955.F86F391@keescook>
 <20220127125643.cifk2ihnbnxo5wcl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127125643.cifk2ihnbnxo5wcl@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:56:43PM +0900, Akira Kawata wrote:
> On Wed, Jan 26, 2022 at 09:01:30PM -0800, Kees Cook wrote:
> > [...]
> > 1) The ELF spec says e_phoff is 0 if there's no program header table.
> > 
> > The old code would just pass the load_addr as a result. This patch will
> > now retain the same result (phdr_addr defaults to 0). I wonder if there
> > is a bug in this behavior, though? (To be addressed in a different patch
> > if needed...)
> >
> 
> It is better to return NULL from load_elf_phdrs when e_phoff == 0, I
> think.

Yeah, right now it just returns a pointer to file offset 0.

I also wonder if we should sanity-check e_phoff vs PT_PHDR? Right now
Linux ignores PT_PHDR. Should we reject loading when e_phoff != PT_PHDR
file offset? (And I wonder if there are "broken" binaries right now that
have bad PT_PHDR segments that have gone unnoticed...)

And now I'm thinking about the excellent ELF loading analysis at:
https://nathanotterness.com/2021/10/tiny_elf_modernized.html

;)

-- 
Kees Cook
