Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171064EB47C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiC2UMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiC2UMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:12:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDEA1445
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:10:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so24908457ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oU9jeX9iLhMYZKUyj4AbviUR1091ghdikwJSuXqLCs=;
        b=Nsn+ciQzT1Wa4x0yQPbzfiy4QANLLiRrBUKK1/DCgDgUqrMTXpAg947w50LiufKKTr
         HN5ebNO9/oTpHluLDirWIqISaBp8aGbx2/D2Vgn5Z881qILdQSMotEVnQ10w4VfVbSts
         PzXEtkY1Xp7HOhvQw5GU8RF4QJFEHAoIF2wh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oU9jeX9iLhMYZKUyj4AbviUR1091ghdikwJSuXqLCs=;
        b=mlzUuvcws8jrNohiRDYiiBabrKMuw+0EI1a1Gvx1QTKCFk8OqvZX+a6JDj2UmlwG0R
         7UIVYQoBtiLupzxuuS3AYkQvthupaSEVwNQvPHamgUzYeWJD15bdv4ljU/PwdX4QDlbX
         ibSNlY6yLKZulnrI3XQk4Rm1s8Sl+nnYvzTMG1OW5uiFEAyTnZkA8s0h+04Z3t/QjZeE
         iVmsb3/CEMq4rfg04885K66T2Xc9V0sFNnq1u8iVbUXl39byWSMIis+r60TQqenJhprV
         fSCJEWWWqP2HdAwvewamNN1gvtZHcp5TTccuPydUHAee6sd9FGL4s/cJWbtU/2VugCJp
         SX/g==
X-Gm-Message-State: AOAM530APTs3OYwp2rC5fH8DIZg2dzE+ck2lGLY/MhKqKeMjE3M1Jf43
        G4tEhBmmbt7BNGXsy235UR4y//cROpra8vww
X-Google-Smtp-Source: ABdhPJx23ZLoFLSQV+55nsJ1BPcht1KCQwuTeirPb70xS/tsSj6kZsUsexWjVmZosZ8/sw+AuxS7uA==
X-Received: by 2002:a2e:8859:0:b0:249:79fd:f493 with SMTP id z25-20020a2e8859000000b0024979fdf493mr4147196ljj.487.1648584648170;
        Tue, 29 Mar 2022 13:10:48 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443d9064160sm2093901lft.125.2022.03.29.13.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 13:10:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m3so32198151lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:10:47 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr4181682lfh.687.1648584646973; Tue, 29
 Mar 2022 13:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATL4v40ZHJ+Ym3k_fVe4ddmMA3wFQXb5RaTz9hmPebeuQ@mail.gmail.com>
In-Reply-To: <CAK7LNATL4v40ZHJ+Ym3k_fVe4ddmMA3wFQXb5RaTz9hmPebeuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 13:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxcu9DFkXAOAFdDtLWwuv6qb5iV1E69yWE-JEVsd-NFg@mail.gmail.com>
Message-ID: <CAHk-=wgxcu9DFkXAOAFdDtLWwuv6qb5iV1E69yWE-JEVsd-NFg@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v5.18-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

I pulled this, and then immediately unpulled.

On Mon, Mar 28, 2022 at 5:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - Change the .config format to use CONFIG_FOO=n instead of
>    "# CONFIG_FOO is not set"

This is unacceptable.

The change was apparently made to make automation easier, at the
expense of making it harder for people to parse.

That is not a valid tradeoff.

I _look_ at my config files. Constantly. I don't want some mess where
it's really damn hard to visually tell the difference between "this is
enabled" and "this is not enabled".

So no, I'm not pulling this kind of horrible "make it simpler for
automation, and harder for humans" to read.

                Linus
