Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF424AAABD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380804AbiBER6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiBER6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:58:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23784C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 09:58:30 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m4so29425287ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXQN/i75UpM9/xOZNnsDaFN+ADwpyirVq8QEFHiKvd0=;
        b=PegbMigLRlHjM3CKIz16Ycv/mUvmdJBAgkBr/+/h71H9yIQ6RZwnx+IWeyI1/NTm4M
         /5lz8h/5g1V7wYcwxakyZ4E+oaHWUKSOgTQ9YQscYwglYW6V3XUOJPlUjOmt6Z1RcQtm
         jzvZ7KpvdoX49rGUYwPTVXdujyDcjBUJ8A2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXQN/i75UpM9/xOZNnsDaFN+ADwpyirVq8QEFHiKvd0=;
        b=VYnfZifMXQ0EhdQv5j088sFEGkfXc/tntiXKhtL6kGQGu2ZniqFV9CM9CYFWgE9UYI
         38fiqNHBVDPsSQ+c8nnQmc0PrEB/ffbUksEUC1o3F+LgkoTmAMM2MqdTX1YVxk2/wxrv
         aeypXGuyHim34I8TostcJ/OxYlQ8InkwlBUaDB0ga5IdBGCQj5N7nWCZz2zqb4AhbdHd
         pSWdp7YhV2ew23nG1yPGA++AMKcuALnXtoZmhS8+Xv6MTkYYEXlLj0w1yRamsZRqJa0u
         wdT3mHNytNq+C+l2WBOwVqmzvxNwccJodAEHvyrw2wurtv3R5RE3KNPyPCgqrwb8lZ20
         vXpg==
X-Gm-Message-State: AOAM530gmK+k2mH+UOcgYak9L+S2H5G3H80vTCkVX32aufARer9/Qw2d
        XZ3A2hjGzvaq7wDmhWqIz3V9vPOAUlwsO7xU
X-Google-Smtp-Source: ABdhPJwtxcGjsCieva6iOS3JcZcgH+5PtiI0snBuib4jDBPsA6mRxq1OCx7W7dRUg1TtLGBdlNl1Qw==
X-Received: by 2002:a17:907:7ea5:: with SMTP id qb37mr3830023ejc.573.1644083908005;
        Sat, 05 Feb 2022 09:58:28 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id c11sm2607375edx.42.2022.02.05.09.58.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 09:58:26 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id s10so14697584wra.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 09:58:26 -0800 (PST)
X-Received: by 2002:a5d:500c:: with SMTP id e12mr3760593wrt.193.1644083904052;
 Sat, 05 Feb 2022 09:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20220205110717.16946-1-jgross@suse.com>
In-Reply-To: <20220205110717.16946-1-jgross@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Feb 2022 09:58:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
Message-ID: <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
Subject: Re: [GIT PULL] xen: branch for v5.17-rc3
To:     Juergen Gross <jgross@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

On Sat, Feb 5, 2022 at 3:07 AM Juergen Gross <jgross@suse.com> wrote:
>
> Please git pull the following tag:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc3-tag

Diffstat? Shortlog?

This is not a valid pull request.

           Linus
