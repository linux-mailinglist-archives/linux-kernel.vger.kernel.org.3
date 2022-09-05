Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56385ADB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiIEWyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiIEWyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:54:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DF69F48
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:54:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w63so581602pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=48qJgrxCEf3JYYmjsBGoS8jX6ALhpP8RedKEGxQ2qws=;
        b=RjbqBoTNkberUr5FewsblIi04URaOKDWlGUvM7CCAq9EXZqWh9HxvbFTHUqHk33qB2
         DqYRhmiTP1ZFWyNDkzs0AUHiD6XKdR1zdmVK0EwoxnDNtsJUEri3pr78nm2yS3HAWw5y
         8/Y/r+Kgi5CxwiS4SmwLb0xBioP1ZwRUA8sUBHsJQ2nPviJJX6+B0V8STLfPKqX8wAJT
         y1j7IyC/KYyJZZrHGo/wiCVo07buCxX9V+sOEG+De1ocLINiNohMwy4duhbPZE1J4FbZ
         +DWspcX9UGrtoLiR2VCVa9yNzX2c8sDMxT/AXJbp0PWgSZSbZzLg1IHx2sDlskmpHIfJ
         V3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=48qJgrxCEf3JYYmjsBGoS8jX6ALhpP8RedKEGxQ2qws=;
        b=rG0gtNY66vy/AiUX3f4efpX4onIy/sAy9QF3yRkdeAca+LL886bq0XXcx2TxleOhdg
         cLLr1XdI52SAshz05sNQIgyixHklW8yUm6RiLv90DrAXhu8b9MFMrjO+A8gRgddQcCSL
         cvaKBR66j0QtmUoLAB5mHBs5VFvA/7aH8+L08Hd8Wh/1jTXzSpbHJkStPzzJXe1vRZ+m
         w2YMNBnY/tUFNsn/VQfaSOrwPEio+sHYV3ZfIs15MW13srzLwF1QHWQ4zCfKLY8mm9wI
         Si4UdeuGyZEzvyNBzfzyJ0EoxMoqI52Op+EASKaHIBKoMwttvNjK1kqFlzRzSu5ZPNt/
         GcRA==
X-Gm-Message-State: ACgBeo3fmWLs0GX++UkXGj7Syj8mUejrBiD6WsbTRTQBdisqTvTizzWU
        4BhOVnSQhNJbo1zeLRsQ8AN2BEJQsG+M+ECKpboepA==
X-Google-Smtp-Source: AA6agR4OTz/WZfQ5bcZyNyg1Sw3LLZURm6sIins3i9ghQvhwOSZAofuhJKeBOhxdkdOw4KMhK/c/+I6Xv8HYnOW129k=
X-Received: by 2002:a63:d55:0:b0:41c:86b0:59b5 with SMTP id
 21-20020a630d55000000b0041c86b059b5mr43333165pgn.351.1662418445605; Mon, 05
 Sep 2022 15:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220902034135.2853973-1-ovt@google.com> <20220905083914.msdgd575tblq4syj@wittgenstein>
In-Reply-To: <20220905083914.msdgd575tblq4syj@wittgenstein>
From:   Oleksandr Tymoshenko <ovt@google.com>
Date:   Mon, 5 Sep 2022 15:53:54 -0700
Message-ID: <CACGj0CgTVVAhBrL7DsP_fL7R9EhZUwu+MkQ1_GpPEtHQW4ojOQ@mail.gmail.com>
Subject: Re: [PATCH] seccomp: fix refcounter leak if fork/clone is terminated
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
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

Hi Christian,

The patch in the seccomp tree, adapted to 5.10 branch, fixed the
memory leak in my reproducer.
Thanks for working on this, I should have checked the seccomp tree first :)
Please disregard the patch in my submission.

Thank you

On Mon, Sep 5, 2022 at 1:39 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 02, 2022 at 03:41:35AM +0000, Oleksandr Tymoshenko wrote:
> > release_task, where the seccomp's filter refcounter is released, is not
> > called for the case when the fork/clone is terminated midway by a
> > signal. This leaves an extra reference that prevents filter from being
> > destroyed even after all processes using it exit leading to a BPF JIT
> > memory leak. Dereference the refcounter in the failure path of the
> > copy_process function.
> >
> > Fixes: 3a15fb6ed92c ("seccomp: release filter after task is fully dead")
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
> > ---
>
> Hey Oleksandr,
>
> Thanks for the patch! I'm really puzzled as to why we never noticed this
> and I'm trying to re-architect how this happend. But in any case,
> there's a patch in the seccomp tree that fixes this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=6d17452707ca
>
> which is slighly different from your approach in that it moves
> copy_seccomp() after the point of no return. Let us know if you see any
> issues with this!
>
> Christian
