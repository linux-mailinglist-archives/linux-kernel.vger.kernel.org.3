Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785CA4C979D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiCAVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiCAVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:16:10 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61B60DBD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:15:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 29so23545465ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFFQZ5G9629SYwN4GslubcgtNOJHtDCYyH5rTLKNhPs=;
        b=J7SNKN4+VaeirWCC/sELTWGxD9feSOxwo5q96qWEAmukJiV3VyojWYDxtxuMGxCyR3
         YrpHXPdAb07nriCJ8cCpxklbaMU6iL5ozLyyOZQ0PKB6soH/RogNt2jYscdgsizouIbx
         qbKugFzE7mJwHl02BxHXOCWjpLGFgeV/WWue0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFFQZ5G9629SYwN4GslubcgtNOJHtDCYyH5rTLKNhPs=;
        b=H9SQvAG7TEbgxvGO13ay8EfYb0I0Xp2dyvKHajAYFRBL0ee8Rr6U13MlQG5ZheshDP
         jSFRPiU4YIF6fg/MZeXWDJiR6F3qwkamFxxtf6oivb3VVv0gUWbx8hZqNlEjosUqaWGJ
         A8YMjJRhvPsbYAjkOJOaj97gQBRXUoAonMIZ72+K6uV3oHumVHFY8gNDECZZkJHBaTjw
         2aFvrMn1HvpFHinpL39drdLGhnDHnClk2rGUlHHtxY6mxsTB/F2paaTAZLf00df+Gt7F
         DlDOsU4q+OdKerVFuxw9JsIS98Mqovy/4Xe0R48veio8og19/UF7BFtu2QokPHhXeb65
         ap7A==
X-Gm-Message-State: AOAM5300aW2mXwGfzh63PUMXTpXiNe/mx03MZJQeSqGEAxOVw+n+bigA
        8+BcVfsxoAWAlPYJvpTY+4nI8Wfvg3PUrppxbBQ=
X-Google-Smtp-Source: ABdhPJwyVN5Kth5cba44bZmNVoOOeKinhxQ95/PdAsnVxS94TvSLOXHaT2HzKu/jWh2Cn3u4FZ9oKQ==
X-Received: by 2002:a05:651c:516:b0:247:a27c:60fd with SMTP id o22-20020a05651c051600b00247a27c60fdmr2091600ljp.73.1646169326821;
        Tue, 01 Mar 2022 13:15:26 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y23-20020ac255b7000000b004304710b837sm1671668lfg.135.2022.03.01.13.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 13:15:23 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e8so23619913ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:15:23 -0800 (PST)
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr18180017ljw.291.1646169323173; Tue, 01
 Mar 2022 13:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220301075839.4156-2-xiam0nd.tong@gmail.com> <202203020135.5duGpXM2-lkp@intel.com>
 <CAHk-=wiVF0SeV2132vaTAcL1ccVDP25LkAgNgPoHXdFc27x-0g@mail.gmail.com>
 <CAK8P3a0QAECV=_Bu5xnBxjxUHLcaGjBgJEjfMaeKT7StR=acyQ@mail.gmail.com> <CAHk-=wiFbzpyt1-9ZAigFYU7R8g9mEgJho3w7yGYe0h-W==nsw@mail.gmail.com>
In-Reply-To: <CAHk-=wiFbzpyt1-9ZAigFYU7R8g9mEgJho3w7yGYe0h-W==nsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 13:15:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiuZGzc2UaNVPr6rZnK7buvaQWfadZMcDXavE=MeCXw3g@mail.gmail.com>
Message-ID: <CAHk-=wiuZGzc2UaNVPr6rZnK7buvaQWfadZMcDXavE=MeCXw3g@mail.gmail.com>
Subject: Re: [PATCH 1/6] Kbuild: compile kernel with gnu11 std
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        kbuild-all@lists.01.org, Jakob Koschel <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>
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

On Tue, Mar 1, 2022 at 1:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, looks like that "<< 16" is likely just wrong.

.. and perhaps more importantly, I guess that means that -Wshift-overflow is

 (a) somehow new to -std=gnu11

 (b) possibly a lot more relevant and good than that
-Wshift-negative-value thing was

doing some grepping, it seems like we have never had that
'-Wshift-overflow' even in any extra warnings.

And trying it myself (keeping -std=gnu89), enabling it doesn't report
anything on a x86-64 allmodconfig build.

So I think this is likely a good new warning that -std=gnu11 brought
in by accident. No false positives that I can see, and one report for
a MIPS bug that looks real (but admittedly not a "sky-is-falling" one
;)

There's apparently a '-Wshift-overflow=2' mode too, but that warns
about things that change the sign bit, ie expressions like

        1<<31

warns.

And I would not be in the least surprised if we had a ton of those
kinds of things all over (but I didn't check).

So the plain -Wshift-overflow seems to work just fine, and while it's
surprising that it got enabled by gnu11, I think it's all good.

Famous last words.

                     Linus
