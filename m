Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9A477AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhLPRt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhLPRtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:49:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:49:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d10so51181099lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms/wuM8WAzRPY4WykXwi0/YehvvfoHEwDko5JETWgyY=;
        b=Yt6iQrPRR02VnMfhyQFLe4lPoyYi1LLJZh1EAgoFFL5odLJNrpYEgdV1gCmEQ/8Ebm
         vqyvFiXql5+DLQ9/AE42zzsnV8GD+7jyfxwfcG0fq/qlAeVI5VhSB0SiPNjhiYS6tgxi
         kvXLQUaOrvL+UE8xSz2YpOdT/AUCe9TuJhNKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms/wuM8WAzRPY4WykXwi0/YehvvfoHEwDko5JETWgyY=;
        b=SSo9A6PLMwrw+VR+PlWFGeyOM0b+Gn7eotW0uYVhJN0DVmw5EbLicTPiLUgxhpMWe+
         0Xnq4NjuL6h2CvPoZwzrSUf63L1go2saAcKeb7+UXB16ASXR9PpboOiz4/PoEvUeeopW
         WXtSkpaiptgTrDaiK8qjbOs6ZTUFjYrdIgBZO2jjnNHsiWTymsPfneF5BUJaDqWAudgv
         hyip1BDNMSdfdQ1VxfvC8Z4UUxbjTQ/GTFu/gGYne7ngoUY7JfiTRPidhmsUFNTnl10j
         IMd2HuhRn84/S/mXs6Aj5OMLoy7hlT/dYdTNWNgEH740veA9IlR+LHQqxCZ+c/SiM43t
         JwSA==
X-Gm-Message-State: AOAM53236+BQXI6DV/SRx1lQsrcwIljGJO/bEuczPdWonQQshcQ+CgTI
        WDDPlrnLuOMq8z8D6fFxMgCNNQg3dq/ldqJIHPw=
X-Google-Smtp-Source: ABdhPJxrtala47JLscM/aclrPjpvENGULeaN1Y81DupZci1U+v1CfZ4MpxvpNGbB5HTeGLi7dwAO4Q==
X-Received: by 2002:a05:6512:1324:: with SMTP id x36mr15799892lfu.141.1639676962446;
        Thu, 16 Dec 2021 09:49:22 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q16sm1251316ljg.51.2021.12.16.09.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:49:22 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id p8so39737584ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:49:22 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr9660488wra.281.1639676577218;
 Thu, 16 Dec 2021 09:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
In-Reply-To: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 09:42:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKkdYLY0bv+nXrcJz3NH9mAqPAafX7PpW5EwVtxsEu7Q@mail.gmail.com>
Message-ID: <CAHk-=wiKkdYLY0bv+nXrcJz3NH9mAqPAafX7PpW5EwVtxsEu7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jens Axboe <axboe@kernel.dk>,
        John Johansen <john.johansen@canonical.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        openrisc@lists.librecores.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>, linux-ntfs-dev@lists.sourceforge.net,
        linux-block <linux-block@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 9:29 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in many places to
> conditionally emit code that violates C alignment rules. E.g., there
> is this example in Documentation/core-api/unaligned-memory-access.rst:
>
> bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
> {
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   u32 fold = ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
>              ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));
>   return fold == 0;
> #else

It probably works fine in practice - the one case we had was really
pretty special, and about the vectorizer doing odd things.

But I think we should strive to convert these to use
"get_unaligned()", since code generation is fine. It still often makes
sense to have that test for the config variable, simply because the
approach might be different if we know unaligned accesses are slow.

So I'll happily take patches that do obvious conversions to
get_unaligned() where they make sense, but I don't think we should
consider this some huge hard requirement.

                 Linus
