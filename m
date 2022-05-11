Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35158523D61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiEKT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiEKT1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:27:45 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B82C124
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:27:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e15so3133136iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TjrcgZvHGZSbSEANuASQUUqlUaek3lSuFWWTgN3pqk=;
        b=GofzEP7DnOnxH+/F7p9fpcHxqtLWgO6h2tISMt5cLXG/9hN8+C7IQkUc79e19z6grZ
         +POSB3VOf0RstQOelnod/hFZ8+W9jxU+BQ5yL6ju5YHxpZqDWWNqtWZ+UC3rR3kZuyDx
         aioyDuWU9HMAPnZtVQXehX6cy4On3gnt5ZUMTTkg7yzC3hvDggihGqQWqyzhT5dPKG65
         Org08JpyjFAqZ2uhbQytz4fIQFgKN7a/1FC7df33Ku7zRODT+3FhiAKRdSJ/Fuc2IRcq
         nzfq42FLquXG6jAIHW118dh1DnvBTALsNxPcUweNi5oPd1Zpytd+YqGTE7vbLeaC3YBh
         nhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TjrcgZvHGZSbSEANuASQUUqlUaek3lSuFWWTgN3pqk=;
        b=1SBi4mzryyyyaToaRKpTIjLx0YFlcdlAjefdz5GjuOtjkrCf3AfuHWhizaCiHUBzYD
         jZDUgEDef97a2but+fe0iZp9khAzD3AZmJ5nWxan9yT3/4bes9Yg/qwm9JW8iVezRJPB
         PibT9Fa6BsOde/lzcksvWTECXeWwmPsTnjLBONZTPrtc5ZjzdnjZ7nIwvShZmBzFpBxI
         d4Zm3zuiXKN2f3WsYvSl+hKF0suLWIMyXJU1yWvWXRMBTFNJjGBuPQxsV1SaZtVqhdxK
         b5fut5wME3Obs8HbJNeROIFvWAp5V2pG+fhgxo+FwIFVT4UYeDEnnSOZ3+5vgN8BKqIJ
         MG0A==
X-Gm-Message-State: AOAM533njby2gN/Dl/5Lv2i3L+K0jhIOiDlyB51jcOyvjTl0kjJqXElo
        3zIoSKp0RRuJi4E4D1lyVIrNncmde0ss07nWL/0=
X-Google-Smtp-Source: ABdhPJzHr/9KnSsYp0KpZfOht7LCy76fz7jfB5P+VbzYLCQsVd4JTHr/SyN5cBjDW9+xKKtBAOV3OEPAprw0ap6i658=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr11471883iow.172.1652297263679; Wed, 11
 May 2022 12:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220511072747.3960-1-jiangshanlai@gmail.com> <20220511072747.3960-2-jiangshanlai@gmail.com>
 <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 May 2022 21:27:32 +0200
Message-ID: <CANiq72kc02DbgVdKusDUeCkxVoQoOGMLnEJnzf-Gn=BiQUggLw@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code
 written in C
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:01 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I haven't looked at the rest of the series, but isn't `noinstr` used
> in a bunch of places? Wont this commit break all those uses or at

Except the order, it expands to the same, no? Or what is the issue?

Cheers,
Miguel
