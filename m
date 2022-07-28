Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4283A584390
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiG1Pua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiG1PuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:50:23 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD35D2C659;
        Thu, 28 Jul 2022 08:50:21 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a63so1995634vsa.3;
        Thu, 28 Jul 2022 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juoHghnTH32Kj8QlI0i1YTL6DmztcBwrLPBQKpcOZMI=;
        b=n0sSIBhNYa6kx90pgcTt7Lkyv45jX4qx/E8T3eJ/FoHc6a0frmm81j+MtOFijSl+N8
         5alA/gnLJmptcpuLEsffjJqe0/W8jNqUkqHT65svJcl/y3WwY0ft/xsDRLBO14VgrfFo
         uDFqsP29P5axCTkpKsM7XoZiiVHxnO1qsc9Dw+7IFCylF8W0+UWdoP1TmTBqPD0Wyaez
         rHtEgXCmOK07tHwueeW5+watPJ+FBqcugOO9JjVIyyPd7PNQqW7IGvRgRGZq/+9SfnnO
         65yqUww1/EnQk4Xf6ycVy0dCeBxf+Q6F7gmgAfb+y80JgXTTcQ2qfX1dRjHVocI6rLOL
         oZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juoHghnTH32Kj8QlI0i1YTL6DmztcBwrLPBQKpcOZMI=;
        b=I//IiI7ZTbb0Xo4+WmiHWM1C3Jjp2Hi6D6bHTyGOY0ntAko14QSqGJ8EfPEIYUrT9x
         9yhcpvr9HytgThI38ueam5nzfHf8/ZqvG1XOchc7kjwehYDPRRuTSJeA6FX7tvOdZvl+
         BitOgnsUnk7sVqdm0Ntl6jCrmlD54ytQDHwqn3O+m48vD3UJpQPcotnmacN9W2MK68Q8
         LvNdQMErWsbd6pVGIrgbpej/j2/8SAqo1rlFiInK6c0nPpoixQhyvvoRDm+FAHHIx9+N
         rCiC13cL/XjN/UM/VPB6siy/HNdr7w3g9DeVuqFvBPIBBSDrHZ/+PD629GKmkPAl7gFq
         TuUw==
X-Gm-Message-State: AJIora/bcT5GTjLYJpVkwAkRPqey7vj4XYxAvRYPuPQWAAV0qnH8i7Ed
        jUE/zkpLQDsXSuG/szTrqs+5dl48L0P8f/30SPCoWAn2Jx/Y2vTZ
X-Google-Smtp-Source: AGRyM1vpuFNgo7HIa/fGEhMt/kzGZB5qof4A3otEJacdUABYApLReXpj0Ho2OHifa++57hKbxoP9uTd6S+SOzf4nBmw=
X-Received: by 2002:a67:eb98:0:b0:358:6274:71b3 with SMTP id
 e24-20020a67eb98000000b00358627471b3mr5972297vso.72.1659023420760; Thu, 28
 Jul 2022 08:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220728114915.91021-1-zhangjiachen.jaycee@bytedance.com> <CAJfpegtxUrytqTFjVG0J03ZmEzzpFr8Ra1KP8HiZNPzTtgY3kw@mail.gmail.com>
In-Reply-To: <CAJfpegtxUrytqTFjVG0J03ZmEzzpFr8Ra1KP8HiZNPzTtgY3kw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 28 Jul 2022 17:50:09 +0200
Message-ID: <CAOQ4uxgbVi4F9hbsVAG9v1Ay8P_MB=QBTLv2-y9M2f9jcbq5NA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        songmuchun@bytedance.com, Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 28 Jul 2022 at 13:49, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
> >
> > Some code paths cannot guarantee the inode have any dentry alias. So
> > WARN_ON() all !dentry may flood the kernel logs.
> >
> > For example, when an overlayfs inode is watched by inotifywait (1), and
> > someone is trying to read the /proc/$(pidof inotifywait)/fdinfo/INOTIFY_FD,
> > at that time if the dentry has been reclaimed by kernel (such as
> > echo 2 > /proc/sys/vm/drop_caches), there will be a WARN_ON(). The
> > printed call stack would be like:
> >
> >     ? show_mark_fhandle+0xf0/0xf0
> >     show_mark_fhandle+0x4a/0xf0
> >     ? show_mark_fhandle+0xf0/0xf0
> >     ? seq_vprintf+0x30/0x50
> >     ? seq_printf+0x53/0x70
> >     ? show_mark_fhandle+0xf0/0xf0
> >     inotify_fdinfo+0x70/0x90
> >     show_fdinfo.isra.4+0x53/0x70
> >     seq_show+0x130/0x170
> >     seq_read+0x153/0x440
> >     vfs_read+0x94/0x150
> >     ksys_read+0x5f/0xe0
> >     do_syscall_64+0x59/0x1e0
> >     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > So let's drop WARN_ON() to avoid kernel log flooding.
>
>
> Applied, thanks.

FWIW, no objection to this fix, but for the record, encode_fh
is basically an inode operation, so it shouldn't require an alias.

The only thing in the call chain down from ovl_encode_fh()
that needs the ovl dentry is ovl_connect_layer(). The rest of the
referenced to ovl dentry can use an ovl inode instead.

In some cases (e.g. non-dir or pure upper dir), ovl_connect_layer()
will not be called at all, but even if it would need to be called, it is
better to skip it and encode the lower inode if there is no ovl dentry
available.

The possible eventual outcome of an fh changing after disconnected
dir copy up is probably better than failing encode_fh out right.

No need to make any of those changes for this corner case IMO.
Just wanted to add this analysis to the thread.

Thanks,
Amir.
