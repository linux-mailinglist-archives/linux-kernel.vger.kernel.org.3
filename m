Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC74E8A83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiC0Wdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiC0Wdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:33:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20949C99
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:32:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h7so21829161lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhspFAC09wnm+6Eh2TE7utcbggJMlqMOLI9aX60zVD8=;
        b=K7BQ2fnrxBITIiKXXqYXNEq1mjbFT/RDmtdUZ9GXVaKpGUTN+WKtKNSkpKXwCrAMJy
         78dGOmuOG6vNftRvFPk4qDr4TxLtFm+TI/tQHnTeYhC9GLGkhiiFgovdb3NR/8RzMXdX
         Nl283+wES+W+ntTy8aPqUED24Da2xl0PWQET8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhspFAC09wnm+6Eh2TE7utcbggJMlqMOLI9aX60zVD8=;
        b=XV4GXm8wfLJH4l3gsnD2t5dA55Xb+Q+kd9krLTn5ib0RTusL/zu67MS+QJhpUue15z
         2uYsgQZr628hzJB35FORxa2buLB7kM4ne/pDLgt/BfZ6yo6kjHCQjrJQKiiRydSw3qzD
         nCZB+tu6eRwIaaEYv1CeNQ7cxd8Ri2hV+vKqcL2xSRoAv600x7B7xcrpC4f6YxHRnb9M
         JS0Jnq0FIjMmUA7UbN7UxUhxKS/vU3v+JIL5D+/YsoG9NQTgNhQ+mefZ43dpH+r6hjM2
         1jf1LiTRAsTGLWTfieL+rAcqrgvUBZaHyFx53w9k/Yanaw4fypv5KIvekoIPDYo/7g0R
         RC6g==
X-Gm-Message-State: AOAM530TZxPYBadrb3VpvU9W1qxCWa9U+x/gLegzImodK9/WXiKQAIAA
        L6tf4xEDjifcpziqlJKkCI6AheTfrpOZDj9IJB8=
X-Google-Smtp-Source: ABdhPJyYNX4K9MG7e9q6U0u41gutXtlJbtDJz0OW2Yv6gbl6Ry1SkYdh7Noi8fd5swzMD9EC2+uHUA==
X-Received: by 2002:ac2:4e0f:0:b0:44a:8577:1f63 with SMTP id e15-20020ac24e0f000000b0044a85771f63mr7399929lfr.554.1648420325971;
        Sun, 27 Mar 2022 15:32:05 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m12-20020a19434c000000b0044a23fdc8e6sm1459385lfj.217.2022.03.27.15.32.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 15:32:04 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id p10so15942827lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:32:03 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr17393349lfs.27.1648420323009; Sun, 27
 Mar 2022 15:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220328090111.26f8980f@canb.auug.org.au> <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
In-Reply-To: <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 15:31:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqZaY0oZ86fJtpZSfCJJ48xqC0jjRC4m6WWrnL7q5Leg@mail.gmail.com>
Message-ID: <CAHk-=wiqZaY0oZ86fJtpZSfCJJ48xqC0jjRC4m6WWrnL7q5Leg@mail.gmail.com>
Subject: Re: linux-next: build failure in Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
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

-#endif /* CONFIG_LIVEPATCH */


On Sun, Mar 27, 2022 at 3:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I even *looked* at that code when merging, and convinced myself I had
> gotten the #ifdef/#endif chain right. Apparently I can't count.
>
> What a maroon I am.

Oh, and I see why I screwed up: I even did a "git diff" against the
original powerpc tree, but then I visually matched

  -#define klp_get_ftrace_location klp_get_ftrace_location
   ...
  -#endif /* CONFIG_LIVEPATCH */

as a #ifdef/#endif pair.

Now that I look at it knowing that I screwed up, I go "Duh!".

Time to take my meds,

              Linus
