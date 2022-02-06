Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F294AB13A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiBFSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBFSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:34:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26BC043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:34:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id st12so10993542ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipr/Xj8fJQrczHUCPPzyBQs76OpGS0ISVv/nwSX/Q/g=;
        b=dYRZuMOdE0zra95En3hQ336g936a76Wau4yHF4u1bfE01951DLVfumlqZ9Q74obZqc
         hPZ9xZ99bpUlqu83kcZVxPY/qOaQZOqvKsZfDCRfBBsZYHufiU6QnM0FeFVF0s/hqsd1
         PuZGdkt8GAATL9YRERL6Kc+k6WnrbrcLjLnV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipr/Xj8fJQrczHUCPPzyBQs76OpGS0ISVv/nwSX/Q/g=;
        b=aq7Pn6gftIUKhRqxiEBJhxlUkDCuuHO6pY38nkPd2niQtutGq8p+4apTIL6Vv/Iu4l
         5foDEwJasod1Hte0KIwYNCpO0PpfeQJP6grPLXVxeoGfkEwzS8CN5jKKOMK1ubos18Oo
         6W+jai1LXg/F6g/ddpAQoriIJ8VvCaiWovP67fo+uBXRdlePVgB3PYFJox9sh/W5KHVs
         2eIZSmlFIrN0Fzk6Iz3b0gS89SfH2X1PFxmTPkyaPWOZExcWlZuxwWUYjgxuEhNk2Z/+
         /OocBgPAE/QNwexCUdDDY0DNVrZwQid4328mSPLWIwCok9S70zIPjha1EhjIJNDqJ/bL
         s5xw==
X-Gm-Message-State: AOAM531cC9hAqe08y8SopBW4adKEFW4dwyRT8Z54f7bgFjpj9KuCvEmP
        liLkKjb7VoTkGpCX6y/n+3QZW/5XFXbzSSs8
X-Google-Smtp-Source: ABdhPJzkLnbM4raWCsl4ubYVP8gvA4ZPZ21YJD34Nb3dOfEt50nj6D693MGXt+w7guw73epuS5J+yQ==
X-Received: by 2002:a17:906:f156:: with SMTP id gw22mr4652656ejb.321.1644172469351;
        Sun, 06 Feb 2022 10:34:29 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id qk26sm957843ejb.145.2022.02.06.10.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 10:34:28 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id m5so3860836wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 10:34:27 -0800 (PST)
X-Received: by 2002:adf:d1c8:: with SMTP id b8mr7032248wrd.442.1644172467014;
 Sun, 06 Feb 2022 10:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20220206174508.2425076-1-keescook@chromium.org> <20220206174508.2425076-3-keescook@chromium.org>
In-Reply-To: <20220206174508.2425076-3-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Feb 2022 10:34:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
Message-ID: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gcc-plugins/stackleak: Exactly match strings instead
 of prefixes
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Sun, Feb 6, 2022 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> +       return !strncmp(TREE_STRING_POINTER(node), string, length);

Why is this "strncmp()"? That makes no sense when you've just checked
the exact lengths of both sides.

You're not comparing strings any more, you've already checked the end
of the string - you are comparing memory contents.

So make it just do a "memcmp()".

> +#define STRING_EQUAL(node, str)        string_equal(node, str, strlen(str))

.. and please change this name too, since it's not comparing two
strings. The first argument is something else entirely.

It's checking the node value of a section, give it some name related to that.

I do also get the feeling that the nodes should actually be checked to
be a STRING_CST rather than these blind TREE_VALUE() following things,
but I don't really know the rules for gcc plugin internals very well -
or at all, really.

                   Linus
