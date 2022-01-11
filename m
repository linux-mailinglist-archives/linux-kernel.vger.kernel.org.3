Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC148ACC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiAKLji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:39:38 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:41477 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349776AbiAKLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:38:54 -0500
Received: by mail-vk1-f177.google.com with SMTP id e123so1157150vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJaUukQoKhW53x2bHtJSlGwXc7nhzyhVjvRNxKxNxbE=;
        b=uauRkGCpXTlJg8Tl+OTbjXpphuWm4bHrOvtzx9/krTlI3zfknnjreAwOmcsJzixQWG
         f+DHN/0o0Dwd6ff3tKwoc//CKm3lLB6hM9jsFhP7DNEmdWJrUhs1kcJyljrVmBi3aYVS
         d24fIeP/np7pU/zeatAbJEyg6up9LNyxQOFkNJf2o8u/BsLgqcDilnm24UrlwzcIz5FD
         EtXZKfedoJoxGZ1kT+Wz4ACgzSQKUmaEnPFmOW8zYe0uw2z/Iph50dhwGB8ookN4i+ni
         sEBIX3JkxiGQjbvdiMHPRrLY6Bhf4UNL2+9QpERCiCjVAcKz+mcOQkMGOR2FeIC+3PQk
         yCvw==
X-Gm-Message-State: AOAM532uDzDS5fS26Z6CWHXVOiOq23MIsxbiWNQYc7NL9DUJjqFmFjXt
        8h4oZyc5jgv3DL3dNiOW5nie8quDAVoPmQ==
X-Google-Smtp-Source: ABdhPJxedoe7+MNf/iUQsIGZG86RIgA1W25WeYPrNXOuF/glNm6wTA+EKmjx5iswsg61EYsC0q6sDw==
X-Received: by 2002:a05:6122:21ab:: with SMTP id j43mr147763vkd.17.1641901133404;
        Tue, 11 Jan 2022 03:38:53 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id d123sm3903620vkg.28.2022.01.11.03.38.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 03:38:52 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id p37so29088426uae.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:38:52 -0800 (PST)
X-Received: by 2002:ab0:1861:: with SMTP id j33mr1810744uag.14.1641901132325;
 Tue, 11 Jan 2022 03:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
In-Reply-To: <20211223141113.1240679-2-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jan 2022 12:38:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
Message-ID: <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jsaon,

On Sat, Dec 25, 2021 at 1:52 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This commit addresses one of the lower hanging fruits of the RNG: its
> usage of SHA1.
>
> BLAKE2s is generally faster, and certainly more secure, than SHA1, which
> has [1] been [2] really [3] very [4] broken [5]. Additionally, the
> current construction in the RNG doesn't use the full SHA1 function, as
> specified, and allows overwriting the IV with RDRAND output in an
> undocumented way, even in the case when RDRAND isn't set to "trusted",
> which means potential malicious IV choices. And its short length means
> that keeping only half of it secret when feeding back into the mixer
> gives us only 2^80 bits of forward secrecy. In other words, not only is
> the choice of hash function dated, but the use of it isn't really great
> either.

m68k bloat-o-meter:

blake2s_compress_generic                       -    4448   +4448
blake2s256_hmac                                -     302    +302
blake2s_update                                 -     156    +156
blake2s_final                                  -     124    +124
blake2s_init.constprop                         -      94     +94
__ksymtab_blake2s_update                       -      12     +12
__ksymtab_blake2s_final                        -      12     +12
__ksymtab_blake2s_compress_generic             -      12     +12
__ksymtab_blake2s256_hmac                      -      12     +12
blake2s_mod_init                               -       4      +4
__initcall__kmod_libblake2s__101_82_blake2s_mod_init6       -       4      +4

Unfortunately we cannot get rid of the sha1 code yet (lib/sha1.o is
built-in unconditionally), as there are other users...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
