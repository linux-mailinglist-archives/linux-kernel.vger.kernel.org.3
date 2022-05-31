Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A880539916
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiEaVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiEaVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:52:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E6E70
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:52:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w27so12613012edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1k15B72sSbrLXkCADeeP6AzEw+boU5xN3dX9Ygix0Ho=;
        b=fziJdaGNRGa+ZTIWEzYDmG1x+thLhpnlrikLf06C4Otoz06i4B4WcWiGg1NPMmroY6
         wRvoIofy1VXG9kGwfFAU97ChR0D6KvukeW+EUmYLIOVpmgTFCBZiW0JE/GpjfJHGVf75
         jg+Vq2R40kuxG/FiSFcCGhRbQbq9GWUbtNfQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1k15B72sSbrLXkCADeeP6AzEw+boU5xN3dX9Ygix0Ho=;
        b=AWuWYhoPebWEPEwbltHzoRB2/cPPsj2loC9vDal8Bx00g8Auhv0HG8IP9OiaExlEZa
         M9nMWafsoqtFa5kvlrR+FZq1YkXkOwJuiwCXHZjK+YTrxKiN3kk/D0ZKYpX8f/2UDcxz
         20UH2llAaDiWpmwO5WIAr76bInviZcMDoWGplU3Y9c7WcNgunfwTj6Wdw1jEFvHvHMbo
         zNAFf/hSp+2ppvOti9VPocPJ0VZ+G06veSdK8Z5YRaRPAFsNBc72BowZrYJjmAgAkewU
         xg2N3Or6sdGKBzg1nAFom7IwV1kBg/JkYSjNj/8m32KO+kc7DyAFo28oz4gzI5i18MdY
         809A==
X-Gm-Message-State: AOAM531npbEasKe84JnK38CYkV13UxeI6CpGZLngyXxQ8muEkhzLOHJ1
        GWk5GNvBXwlquClvFZ9NlFkorFNUMDg/FgYX
X-Google-Smtp-Source: ABdhPJxsQQ0xM3DYzepj4sXmjV1ubWGBP9sR6ZfKD4zgjvx13hlb5EAIOocKmnInvB90uwchtLuNDA==
X-Received: by 2002:a05:6402:90d:b0:428:bda9:3e6b with SMTP id g13-20020a056402090d00b00428bda93e6bmr66028826edz.132.1654033953329;
        Tue, 31 May 2022 14:52:33 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906498f00b006fedcb78854sm5355840eju.164.2022.05.31.14.52.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 14:52:32 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso47085wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:52:32 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr25567719wmi.68.1654033952272; Tue, 31
 May 2022 14:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
In-Reply-To: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 May 2022 14:52:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMTEAuBRAS7aonfVM9wgupOok4HO6gX9X0FBzE3Uv2sA@mail.gmail.com>
Message-ID: <CAHk-=whMTEAuBRAS7aonfVM9wgupOok4HO6gX9X0FBzE3Uv2sA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, May 31, 2022 at 10:13 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> I have a single manual resolution in the fe510 device tree, just the result of
> some conflicting fixes.  It's not showing up in my merge, but a bunch of other
> automatic resolutions are which is a bit worrisome on my end -- I don't usually
> touch other trees, but we had a handful of big cross-tree things this time.

Gaah. I'd have normally preferred for things like this to go through
Arnd, but it looks like he at least ack'ed these things..

I've obviously pulled it, as you can see from the pr-tracker-bot reply
that already went out.

               Linus
