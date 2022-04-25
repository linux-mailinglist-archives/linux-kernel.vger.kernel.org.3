Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40A50E772
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiDYRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiDYRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EAD3ACD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB20B81907
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD4C385A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:42:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Np40sjFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650908566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emr/eZ9O5nqIe1U2cNBS+25IfmVTCGZ2HAu0n0lsDAk=;
        b=Np40sjFIC35jcIRAZGUbROu+xW+TSnqD/4SxjmrXe8eeAZy8uqGYyJ6Q9fI+nVtUSqQ/Fd
        wh7rrnLpqb5/i3si5nZkHipG6EppEVMTExcVcleJ2AWYRQm3Jp5Q/+HN593rZsfGRW1y7w
        c9BX/CHZc6Xjh2QvF++mJMZwOK2jeFE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43df90a4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 25 Apr 2022 17:42:46 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id i38so9393268ybj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:42:46 -0700 (PDT)
X-Gm-Message-State: AOAM533mFSzSE2DPtev+B3fq6tXPwr6uUPHTobqXwcG7j/Clkl9ZHvSJ
        oU1N60NyjCHKZvV+OM8czkdxwbrDw68GDp0PVIg=
X-Google-Smtp-Source: ABdhPJxO3jAAigEDU5ojFEvrPAY9lFZIgK3YCqEfw3msG8vaazX/dzMAqgR98WDtTUPg18FhTW+Lkkqx2Hm89J9+X8o=
X-Received: by 2002:a25:bd8e:0:b0:644:d8dc:1198 with SMTP id
 f14-20020a25bd8e000000b00644d8dc1198mr17577856ybh.398.1650908565448; Mon, 25
 Apr 2022 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com> <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com> <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com> <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
 <YmbD/oPIUBvJ/YjQ@zx2c4.com> <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
 <YmbUBZg/nGV7gLyy@zx2c4.com> <CAK8P3a1YNQG0xvC+tKPfFPSXuGESjwr5zz_Ubt3QwvY3_QjGdw@mail.gmail.com>
In-Reply-To: <CAK8P3a1YNQG0xvC+tKPfFPSXuGESjwr5zz_Ubt3QwvY3_QjGdw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 25 Apr 2022 19:42:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9ok_PhGenKNhY-y+BRcdPMpSM55mkh54uVK+G5qpA9nxw@mail.gmail.com>
Message-ID: <CAHmME9ok_PhGenKNhY-y+BRcdPMpSM55mkh54uVK+G5qpA9nxw@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 25, 2022 at 7:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > For ppc64, I see the same. I'll try to look into it more though.
> >
> > > Regarding the the ELF ABI, I'm not sure how to check, but I think it
> > > only does ELFv1, which is the default for big-endian glibc.
> >
> > Yes, it only is doing ELFv1 right now. musl checks this in
> > <https://git.musl-libc.org/cgit/musl/tree/configure#n689> with this:
> >
> >     trycppif "_CALL_ELF == 2" "$t" || fail "$0: error: unsupported powerpc64 ABI"
>
> Does it work if you pass -mabi=elfv2? This seems to be ignored here as well:
>
> $ powerpc-linux-gcc  -mlittle-endian -mabi=elfv2 -xc -c /dev/null  -o /tmp/a.o
> $ file /tmp/a.o
> /tmp/a.o: ELF 32-bit LSB relocatable, PowerPC or cisco 4500, version 1
> (SYSV), not stripped

You're mixing things up I think. -mabi=elfv2 is what powerpc64 needs,
but I don't think powerpc32 has it.

If you try to add -mabi=elfv2 to your existing powerpc64 compiler, it
gets upset when linking to libgcc.

Jason
