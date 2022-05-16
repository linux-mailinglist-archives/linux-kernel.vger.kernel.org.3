Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3A528DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiEPTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEPTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:08:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DF39164
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:08:41 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dm17so3947307qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWhuSwJ1k6HUpGLnD2KZPbkFRnPK5pZaeOwgp6ocvUQ=;
        b=Cg7RLNiUvMpwSqS52vzZr3wCjLHtOYPis74p3myx73AJzSpif89nUgrKcHtYiCwEQG
         AZEms7Vdrb0iq+RhVIWFYwYJOzygMkcDirDYhZ6X7kKPyyvFABqV90LHXFOh1fTotcN0
         ptfNCac6kOciXfSNzbxtJKTZeXkvazIhvQAIcSY82q9+cHCzczJEw4keUEHl6KmW3CCn
         11+wsoX2VRO8Jwc34ZgusdJgCC112nQyOXezBln7A6y4JmovpC59vhA6MHeSB4DOL55n
         V3rGns77tU1GtVuIyo49A4cx5dCMhFAUDilet6zxR4rSXgPnCZDjdH7dZQOGVwgEPxEU
         SH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWhuSwJ1k6HUpGLnD2KZPbkFRnPK5pZaeOwgp6ocvUQ=;
        b=RTacMMiixDtTHSi7ZKf2hsViDWSsWDUV/2Ba61Vwftx52w0wnpKeBzpVweCUt+GnFS
         89cNAoQNeVD7D91ZxWEypBEdITTP8/juJyI7ktPEg6QOJUgLfwTiuJQvB2NPqmGNO6r9
         DID7V8VKiyGlhLGgAoND3S5IzO0w0UP8AlO3qdioey1V8Szz0LiolHLLfCx766DbmouS
         ssGwRr6s7d7s2h3D11lyFagzwth3V1XFh8m1MrkNWk8ecajRfx1Fb4RnKo3b9YTK36wq
         U/NodcBDVD6EGia6FwBtBUmKrE2gkfwwQQ1mC78yOtJvWOLlLy4GSocCoYJMsiNIPH96
         GeYA==
X-Gm-Message-State: AOAM533n7vx0zx6XAI+JoIOblhvIWUU9OQtQdHw9yaAr17y1ZqUoN00c
        GIvCDOJ4R3hXJUqetJsk4JrApe1V97JFjTjGz0sCUu2UdSY=
X-Google-Smtp-Source: ABdhPJwLQgKuHGP4v3UTVYu0rmSD1z1cvEF8y/Yvzp9dGSDjpnes1BwVXkyrqWIwzHVGCM7O4O5ODcxZ/OMnkwceK04=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr16674186qvf.35.1652728119973; Mon, 16
 May 2022 12:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220516182859.3131675-1-haoluo@google.com> <YoKa6CLLF25xx6QX@slm.duckdns.org>
In-Reply-To: <YoKa6CLLF25xx6QX@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 16 May 2022 12:08:29 -0700
Message-ID: <CA+khW7jwDE0OvvJ=WoEMJGNLh+z8FG9iZcpGv7eMCaEyNLmfvw@mail.gmail.com>
Subject: Re: [PATCH] kernfs: Separate kernfs_pr_cont_buf and rename_lock.
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> Can you please add a comment explaining why the lock is separate? Other than
> that:
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

Sure, will do and resend.

>
> --
> tejun
