Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB104833DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiACPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiACPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:03:35 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B8C061761;
        Mon,  3 Jan 2022 07:03:34 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v12so46338574uar.7;
        Mon, 03 Jan 2022 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGuic1oifrNLOsnYg8TP87dUZ5BftJE8sD2UVQG0Aus=;
        b=doQmxPP2d+u+nuW5xCZwlQ8bPNVCQjVekcYfpmaxF32IafNJckmMGOwPI3asnnmJVg
         lU5ZUpGCFO04aIi6VsNOygDBeTMzDwhLmOmKUvqaRa5IcEMhD9pcfncSZEj1m2X9iVGU
         bqsUJ7ENxuxRtF1WRMJNCd+drE7OxCOqUmdxjXZt7p3oxFvRz26UG5pNb7RUeOUaz17X
         F3KJbTAWDmUsSIdHFGcpOOhN3OfqJhhI/GLS7K/rrvpAsTkOwEfQ99pgtrdg2DVBw4/N
         vmzV9sTFHQKaIR9K6o9xRVgSJqYpyIv+2RNtR28h/m+VRr5fMEqIjZtH58FHwVBuASDa
         RUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGuic1oifrNLOsnYg8TP87dUZ5BftJE8sD2UVQG0Aus=;
        b=Z8ZaBHd1ndbc6TcbMQ7+VoCqd/TVjIltYZQfAelAwMaFbSJicEVF5cclDHSXV4e2KT
         2fL1PplVbTBFDYxAmXQsN+K3N9xb9Qsmo9HFpG8+lY70a+xpgEfrPr+ccqniGFNUIA3K
         ClFPFqWj97txOH4w7z23OEZrFD7tPtRzwmT89mR3a2ExqXHOs9cBtu36vFaY1wvnomqB
         J4ohGN0JOPuaTf7AvFR8hDvOAMYEj2D9O99CdmbQTYg60lNyBZd++GKymA3a9v3Om4CF
         ajtplMWVbs8Y9UEhQvER4VPoMx5PS88EmwAZKmaeY1gvCVCK7LjFeGFFwrFir0Ff42EB
         v+KQ==
X-Gm-Message-State: AOAM531O3OLotcCS36/SemQ66eVAwBDSYt3iQ6xNRxZX+g5s64RNbd9l
        seUDn9+z4nRdcYPDwPXb+HsigiWJ5NKi8Z0sJV4=
X-Google-Smtp-Source: ABdhPJztNdhJnI8z8JrXBxf8JGhSZZubSuIVYtRM8JYAhJmwn0luMOVJsAuDzx0HTEW2jcD1URd4aTzeV/JC3WNKwf0=
X-Received: by 2002:ab0:239a:: with SMTP id b26mr15334154uan.101.1641222213907;
 Mon, 03 Jan 2022 07:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20211221143614.480385-1-deng.changcheng@zte.com.cn> <bc8803b511ed25ddc7091ba1f09f10ca415ca51e.camel@kernel.org>
In-Reply-To: <bc8803b511ed25ddc7091ba1f09f10ca415ca51e.camel@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 3 Jan 2022 16:03:31 +0100
Message-ID: <CAOi1vP-uVjgcbHj6n_BesjS6-9H+02P-cy=1MKZsy9wk=OW7-Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
To:     Jeff Layton <jlayton@kernel.org>
Cc:     cgel.zte@gmail.com, Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 3:41 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Tue, 2021-12-21 at 14:36 +0000, cgel.zte@gmail.com wrote:
> > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> >
> > Fix the following coccicheck warning:
> > ./fs/ceph/debugfs.c: 390: 0-23: WARNING: congestion_kb_fops should be
> > defined with DEFINE_DEBUGFS_ATTRIBUTE
> >
> > Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> > debugfs files.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> > ---
> >  fs/ceph/debugfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index 3cf7c9c1085b..64c4158c17c8 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -387,8 +387,8 @@ static int congestion_kb_get(void *data, u64 *val)
> >       return 0;
> >  }
> >
> > -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> > -                     congestion_kb_set, "%llu\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> > +                      congestion_kb_set, "%llu\n");
> >
> >
> >  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
>
> Thanks, merged into our testing branch. This should make v5.17.

Hi Jeff,

This came up last year, has anything changed?

https://www.spinics.net/lists/ceph-devel/msg50492.html

Thanks,

                Ilya
