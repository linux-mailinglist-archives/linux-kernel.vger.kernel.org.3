Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD95900C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiHKPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiHKPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:45:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB898D35
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:40:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gk3so34151618ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=x6h3ZUYE+fSHbOcAtnhM53hC5fi6FUTsoF2x5uuPJ2I=;
        b=HeMQ8zAXI4QJmplndokyGN4KBA2GRue+xq74R5DjkSz15v0bKh6AhytDDiX37HKdpR
         ho0aHxKcelq9/L6PPYv9w2sMZURJjljYqPVMZ8dH8/fres9luFz8AHpK4pO9dGonPjXy
         0MmrvWv42qdBW0TVMQOjQ0rRic8iIwEMO3R/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=x6h3ZUYE+fSHbOcAtnhM53hC5fi6FUTsoF2x5uuPJ2I=;
        b=dHJ5lOig7/776sQ+yJPvK7turFpO5FWu3PWd6fWgnBTxZliguLUIp+yZDpuPE0fWsb
         LkybVJRJ3gEBgXRpbNM5TaP5+gwzfYRS/eeiDzg64v6tWRiwXsWWUiodKXzxMSnAj77x
         Vgr65MF64OFlAfkboKTz7s6+qbHneeoUAJY57TCFwc7xox6Bd6ZVUhxS7IuSQL0ncTev
         6FXQj/RwEDceK2bd5H/O0B/jEPXht6oN7wlHwCNcCmiVWwtIlytPiD8WXnghTPmCdU+9
         WnuoFsL+3PtlO+gDuHn538+3oe4DDv6UAiP2Ufh8cWNMr2tbCSYmFORzUwRRSP1+IoCJ
         uVmw==
X-Gm-Message-State: ACgBeo0hkf1EbtyYvSFHhGW7woObrzNmYiYXyPqcr/wab5Rl3CXmhnV1
        tDPXOwWN1QNtnBabxw8U03KWZVlVgyKCdTUd
X-Google-Smtp-Source: AA6agR4ZyPSdKTvZos+0D1RSacRCfDQTZ2mbdZFV0hbnSM9qkYTqS4PAKARSKyRpAZuqTzGWhVTfWg==
X-Received: by 2002:a17:907:7d86:b0:730:cd48:e2bc with SMTP id oz6-20020a1709077d8600b00730cd48e2bcmr24428992ejc.167.1660232399004;
        Thu, 11 Aug 2022 08:39:59 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id rl24-20020a170907217800b0073156e6cd59sm3613616ejb.4.2022.08.11.08.39.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:39:53 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v3so21856804wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:39:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr11935404wri.442.1660232392668; Thu, 11
 Aug 2022 08:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <YvSxeDkmwxcJL+Z0@debian> <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
In-Reply-To: <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Aug 2022 08:39:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
Message-ID: <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
Subject: Re: mainline build failure for arm64 allmodconfig with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 8:05 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> Right, these are exposed by commit 258fafcd0683 ("Makefile.extrawarn:
> re-enable -Wformat for clang").

Christ. Why is clang's format warning SO COMPLETELY BROKEN?

The warning is *WRONG*, for chrissake. Printing an 'int' with '%hhu'
is perfectly fine, and has well-defined semantics, and is what you
*want* to do in some cases.

I'm going to turn it off again, because honestly, this is a clang bug.
I don't care one whit if there are pending "fixes" for this clang bug,
until those fixes are in *clang*, not in the correct kernel code.

For chrissake, the value it is trying to print out as a char is '3'.

But even if it wasn't, and even if you wanted to print out "0xf365" as
a "char" value, then that is how C varargs *work*. It's an "int".

In fact, even a *character* is an "int". This program:

        #include <stdio.h>

        int main(int argc, char **argv)
        {
                printf("%hhu\n", 'a');
        }

generates a warning with "clang -Wformat", and dammit, if you are a
clang developer and you see no problem with that warning, then I don't
know what to say.

Nathan, please make clang people see some sense.

Because no, I'm not in the least interested in getting kernel "fixes"
for this issue. -Wformat for clang goes away until people have gotten
their heads extracted from their derri=C3=A8res.

This is ridiculous.

              Linus
