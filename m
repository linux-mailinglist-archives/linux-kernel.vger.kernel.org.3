Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BF580EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiGZIJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiGZII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:08:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946B2FFE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:08:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x91so16815424ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV3IfowOa4f7bKUN6AX8X5ooA1QleCE648viTjFBD8U=;
        b=Jdfp/cPqcX0B9PQBSmL/wz4CUY8IPpiBoUgDY89BlBkwbYbksK76sggwVWy1raCB9G
         7sGIQt3y+7mIPfCEDfdSeuPehLn48Fa7BBAS9Mys6f2qJluCd/zUtWJ6tV6v81mwZBR8
         SJ9ov7J0ij747pY2dnMc0UbFQaZtwQIfXCdJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV3IfowOa4f7bKUN6AX8X5ooA1QleCE648viTjFBD8U=;
        b=rbVnx/29QmHQY9cdYd4UkB3MeIw20ZXM4kaqogIQee0pLVkOjdjFnWmlfhl3rQB6hJ
         8PPa7FfbTVzlIvweEKy06NS89bUSWWQqGmFPpPG00NE7JLWmV3rgG7Gf8UiG1E46z+TI
         ZEB3NLXcyQm7NDTLHC3JIgf8LXp841LQHVdG2oqQOAnvvXHRogQhnSr2KbtgnH3eq4V0
         OUjUauLDk6ViVirMflhLamXCljK9DsjkwKGUZ0gLlAY5C2XjN0JToALPDS9vSlDVKpll
         b/mu5ksPVxKUoio+C/fBwFxAPFZZxtooMT6vNN/dAPuzSVAAMQaMjzIueQEfX8UP9u07
         FFBg==
X-Gm-Message-State: AJIora8abyhDARN6SMBjI+t5D/7SMaeem4YPFq3uJK577y/+GUcPJ5sQ
        bZLBugqMDj8S8XH6NXZHceOPzSagSD/oEPk+F3ZhlA==
X-Google-Smtp-Source: AGRyM1ufvT/mGD401pwlFLLqRE2jKLjkDRkRa2FwL7+Dw2nRBtHz9JuFmJCDzaYgH0KrL0to45rXT4w1Tge03s1twR0=
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id
 fj13-20020a0564022b8d00b0043a5410a9fcmr17476758edb.99.1658822931062; Tue, 26
 Jul 2022 01:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <CAJfpegsitwAnrU3H3ig3a7AWKknTZNo0cFc5kPm09KzZGgO-bQ@mail.gmail.com> <CAONX=-cB+hhjoZc_sy_swe6Tq6yMPdgdXu6mQE6y=fT+PVtMyg@mail.gmail.com>
In-Reply-To: <CAONX=-cB+hhjoZc_sy_swe6Tq6yMPdgdXu6mQE6y=fT+PVtMyg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 26 Jul 2022 10:08:46 +0200
Message-ID: <CAJfpegt4Jnr3GyP4Y9TrHU_kfxBqEfQrrs0SPQx7s1k+kwd8fg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] FUSE: Retire superblock on force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 at 02:50, Daniil Lunev <dlunev@chromium.org> wrote:
>
> Hi Miklos,
> Thanks for your response and apologies for my delayed reply.
>
> > Why the double sign-off?
> Some misconfiguration on my side. I will remove the extra line in the
> next patch version
>
> > And this is called for both block and non-block supers.  Which means
> > that the bdi will be unregistered, yet the sb could still be reused
> > (see fuse_test_super()).
>
> Just to confirm my understanding, fuse_test_super needs to have the
> same check as the super.c test_* function, correct?

Or make calling retire_super() conditional on sb->s_bdev != NULL.

Please only enable this for non-bdev fuse (which is the vast majority
of cases) if it's justified.  Otherwise it will just be a source of
bugs.

Thanks,
Miklos
