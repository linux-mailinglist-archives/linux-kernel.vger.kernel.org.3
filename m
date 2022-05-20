Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FB52F37D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352916AbiETS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiETS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:57:20 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4E15FFE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:57:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j7so6133024ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csQj3ib6KpNkN5bv9vkVD9s25tn2ay6dwGnp7G2PxZk=;
        b=McQ/3Ewl8k9H0HObINKOQBGKSdu2PuQDhmS/+DgjFXksHKDOD+EF7/hWFtAYEYGwjE
         o6p8Ju2y0k60bVIn2+lifX7h6Ppf1OHbTOL8l6Pp2CQxB1ZOCe0fnZkZNNmb+Rnegbl7
         /iSTpUNLNL2K+daGEmsME45/aMYXzmR0++y+fb/zoiu8Js8HAUwJvWWwNzrZuCIckdya
         VgfUE/1oMmePNPlcBMiMVXi2G8IFzJg3+LStawYcIICU+PjFJhYg8Iv7evbfJxxZuPk4
         s8dV3e+O27lz305dCxL0gIN5pzxVefmXtVlIkrPTO/s0IC1fLxMIRJooZlL/VEYY62mU
         TU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csQj3ib6KpNkN5bv9vkVD9s25tn2ay6dwGnp7G2PxZk=;
        b=254yLXUoxqx0sJm79w2xGKAa9EZNVoCApkV5Gji/wmjtEUjhaAqz02/Blf5aih2rji
         5Nmvnpc4hu44jLxL6r8uj2rLgi4QnDLGl03h9BAv6oZ85YdlnlaIvwutg3L0OE6/BbWm
         xBKJPMWjitbmfzoG3m1EyUe7ik6HW3WGTKLROZREYP/rpkWKAvauGZSBnN+eYFpEfT3d
         lTfxu5VIDJNQSgYwLINmWjxI2wqV+9frq5igDIbHdcmPzAthUIDCPM7d1xiFbIufzysE
         T9KrIo16oWgGhesitlZpNOKuYOV9kCPTKL1b0BguIVmzey2nWu/PM1oHWI6j3aFvhxHI
         xM1Q==
X-Gm-Message-State: AOAM5329oL0bxwhNlUjL3M5Xf0hDZ7gJGmI2dBVzXaRLAeKgdWitPJof
        pWN7j237VSlvWKWPGO8afNwbEQ58s2xN3gnq/2Q=
X-Google-Smtp-Source: ABdhPJwdbucanBr6WHmHcempnoRguCOcI2wNpVRGvdYArTFBsypERitXgjSCUIowggIQNBVIuEVd+rVgBPUDdiAxipg=
X-Received: by 2002:a05:6e02:1c81:b0:2d1:3971:9343 with SMTP id
 w1-20020a056e021c8100b002d139719343mr6207735ill.237.1653073038368; Fri, 20
 May 2022 11:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <20220506160106.522341-5-mic@digikod.net>
 <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
 <5be32ddf7688db38408466315a80e03e9af7ac40.camel@perches.com>
 <CANiq72=e9LMujmsk-mh8YHcGoKuLAnBttNz7JbiXH_2-hpvUvw@mail.gmail.com> <b49d037c38715c3fd82c07309e32aad70c97890b.camel@perches.com>
In-Reply-To: <b49d037c38715c3fd82c07309e32aad70c97890b.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 20:57:05 +0200
Message-ID: <CANiq72=SLoKSUzbWV4r3jt31trEV2ooHH7r_pSDF_dkU4bc7fQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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

On Fri, May 20, 2022 at 8:00 PM Joe Perches <joe@perches.com> wrote:
>
> As you wish.
>
> I think it's more that there's no "one true style" issue than anything.

Indeed, there are many instances of both. Not sure which one we should pick.

Maybe everything in a line is less annoying in more cases for people
that want to automate formatting (and `clang-format` will wrap it if
it goes over the column limit anyway, and then it will split it in
several lines, so it is OK).

Cheers,
Miguel
