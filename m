Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F779592642
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiHNUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:03:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65161DD8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:03:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y3so7353390eda.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EQf+dWgsYoxxd2dvzOjUZKth6ahCt1jz8pAa/2/RQdU=;
        b=Z34M9+Q1uuvvvI+KYw/avRL2yyUA1m8DGjvaprLJbVuoikvV5MBvcGm2QdAoO6deNq
         GU6cmr8JZETRMdUSJPeQ/TNKqz4kQLXn/KwQnzaD96e1EokSnzXcJtM1v45F7UVSDS2+
         JwQdCJohE3gveqyFlczZ8JXPsxpLBEglcSYyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EQf+dWgsYoxxd2dvzOjUZKth6ahCt1jz8pAa/2/RQdU=;
        b=gmqnOGzpLR6BCRutbF2H14zG+kxmjjwgEnjkWAycoWEk3JXA99BPfPhvVTs/P862co
         X3utw2VhJnWiRP6EgBPNh6J0n6bnrF+bYYc+slUhUtpGxIXi9MqX87rTnwqHIVMuxUnW
         olkN5PxLcTEIy+z06dNRKMEiMJ8fnWOAgKDsl84PamyvDXDFzKeAMRXvK5UpFyzxO0al
         YRigZBGUL1cXhJZjPKSNz6XvWkpFqm62RH8pd3eGEGk5Dm7OvK9sZNmfvF/Und/Ae6/e
         zU8gh4ugUBtiTdz4iOiBdIirOT0LuzOvBWuajt2R/zLT7l8yozv/6ww0yf9979v7uNZq
         kD4Q==
X-Gm-Message-State: ACgBeo2BHhlRPyYI7TDlJtcGuDlKZda5J/d1ep9GLuaHl8TeKUYCLlsf
        7HCqFFlrdGFNc89EswXvampqdfafPHIkQs3R
X-Google-Smtp-Source: AA6agR5awCOL0Cjg6+KhCq5BiRqGOEBlPGrpdzVPp4kAgt8U/RiA9nhqHwtDH/qzvVVecFGYYa9jfA==
X-Received: by 2002:aa7:c983:0:b0:43d:3879:216b with SMTP id c3-20020aa7c983000000b0043d3879216bmr11744584edt.131.1660507425637;
        Sun, 14 Aug 2022 13:03:45 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id gv11-20020a170906f10b00b0072af4af2f46sm3260371ejb.74.2022.08.14.13.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 13:03:44 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id p10so6953387wru.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:03:44 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr6817978wrw.281.1660507424308; Sun, 14
 Aug 2022 13:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV> <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
 <YvV2zfT0XbgwHGe/@ZenIV> <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
 <YvV86p5DjBLjjXHo@ZenIV> <CAHk-=wjCa=Xf=pA2Z844WnwEeYgy9OPoB2kWphvg7PVn3ohScw@mail.gmail.com>
 <CAHk-=wjLLw0xjL+TZs5DUGL8hOpmLMa4B92aDVFxw4HZthLraw@mail.gmail.com>
 <CAHk-=wjyOB66pofW0mfzDN7SO8zS1EMRZuR-_2aHeO+7kuSrAg@mail.gmail.com> <YvlILbn1ERLgZreh@ZenIV>
In-Reply-To: <YvlILbn1ERLgZreh@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 13:03:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvKtkqF9AXx8GoA80h_RNUV=Ld8qhi8ZEPmDXC0VUDUA@mail.gmail.com>
Message-ID: <CAHk-=wjvKtkqF9AXx8GoA80h_RNUV=Ld8qhi8ZEPmDXC0VUDUA@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Sun, Aug 14, 2022 at 12:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
> There's a cheap way to reduce the register pressure:
>                 seq = raw_seqcount_begin(&dentry->d_seq);
>                 if (dentry->d_parent != parent)
>                         continue;
>                 if (d_unhashed(dentry))
>                         continue;
>                 if (dentry->d_name.hash_len != hashlen)
>                         continue;
>                 if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
>                         continue;
>                 *seqp = seq;
> could move the last store to before dentry_cmp().

I actually tried that, it doesn't really end up helping.

Gcc does well regardless, and clang ends up really wanting to move so
much out of the dentry_cmp() loop that it runs out of registers and
always ends up doing a couple of spills.

I think it reduced the spills by one, but not enough to generate the
nice non-frame code that gcc does.

It's a bit ugly, but the code probably performs quite well - the
spills aren't in the inner loop.

             Linus
