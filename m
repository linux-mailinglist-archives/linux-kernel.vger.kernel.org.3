Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBD4C1E10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiBWVyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiBWVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:54:30 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0950451
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:54:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u20so656536lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TnD6jYOSsNtQKWO0JaU3gwq6Qdh6TjyUgcvqEl+K5I=;
        b=dX/Jy7+F597/hIqi/9qMzXNMQrDyhVkP3dTnhBEOAl49NjqeCD8FqayzKHmPDChTw3
         FXxIkt9v5pPo2K0sD+mRbJ2ze9fZjc9QQ0YoibAdDT8COHVHj0K4UemJxZnobNcdHhFL
         ecGrXKp1xqB580NwK5g7hNFGZEgHao6WIIXUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TnD6jYOSsNtQKWO0JaU3gwq6Qdh6TjyUgcvqEl+K5I=;
        b=FctymX292tA+gmkzdVNROhB9ubtoD/eWGmVAWbRGjF3qztPSudG+9pSBtnErJ/Qyfc
         RiJX7WRCUfXbGlHyeCb+Ay6TuGXfIzWCOFj4KzekENrQ6eXyMHx3PJEzMUYZm33Hdfad
         +Mji3rjGCnoQl8V1Ye73OEYsZaYBnZE9cxOmzGUMy+RmyMACwpehLTEldfMgZ4KDgPcH
         /57SxHufqpVJj+ou24OiAQv3Gbxe4noUxYPZ4JHAHaLlCCVJb0jY3UTc22HNTGpptfyL
         kOU+JghxjIQzggVn47AmxhSWMsEtk+uSmyP7AdtT6jqeZNOsYgqfmHjvBlgljFD1jZpu
         LZSg==
X-Gm-Message-State: AOAM5309retIsM6oaC/wEGluvtJpJ+6luHPTuGL+72d8APTNmbS4tcNB
        vb/hNYeSsh7vgcN2w67Puv6VkSjHevmc+lOwH6M=
X-Google-Smtp-Source: ABdhPJzEDFOJ0s1JQ5zRrqmi1ZcZ/y+AbaMxkXLw3b/Odem5AlM5Ic/jAoXr5i74TPG8NFUowMmgYQ==
X-Received: by 2002:a19:6a07:0:b0:443:ecf7:e4b4 with SMTP id u7-20020a196a07000000b00443ecf7e4b4mr1019148lfu.395.1645653239782;
        Wed, 23 Feb 2022 13:53:59 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a9sm57781lfl.180.2022.02.23.13.53.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 13:53:56 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f37so602825lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:53:56 -0800 (PST)
X-Received: by 2002:a05:6512:2033:b0:443:3d49:dac with SMTP id
 s19-20020a056512203300b004433d490dacmr1067001lfs.52.1645653236389; Wed, 23
 Feb 2022 13:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
 <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com> <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
In-Reply-To: <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 13:53:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
Message-ID: <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Nathan Chancellor <nathan@kernel.org>
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

On Wed, Feb 23, 2022 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Ok, so we should be able to basically convert '--std=gnu89' into
> > '--std=gnu11 -Wno-shift-negative-value' with no expected change of
> > behavior.
>
> Yes, I think that is correct.

Ok, somebody please remind me, and let's just try this early in the
5.18 merge window.

Because at least for me, doing

-                  -std=gnu89
+                  -std=gnu11 -Wno-shift-negative-value

for KBUILD_CFLAGS works fine both in my gcc and clang builds. But
that's obviously just one version of each.

(I left the host compiler flags alone - I have this memory of us
having had issues with people having old host compilers and wanting
headers for tools still build with gcc-4)

                Linus
