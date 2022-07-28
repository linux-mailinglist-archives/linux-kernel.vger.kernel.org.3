Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7F583DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiG1LqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiG1LqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:46:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF15140D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:46:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q14so1193614iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTAI4NBWGTQ5h3Og/iXOFE6+j1LyXYJBHvMW6aUVVzs=;
        b=3yuVzJ0kJ50eg55Qut9vgq+oU18lNCriJe7K+l/NMy1M1TeJu/Cvgm2OSsSllF4CtD
         7yLRDb3+hTj7inXwlwwyor84uWesrJQdHqh+s3ypreV2jOUH04k7o9JDQneNozHUjMne
         nIwpEFe0sMjHsKBY94w/2VZhwckL4ko5Mf7mxCNCMogbU47WIemkLqdSUVq+MhCCDdeB
         E+4lniUGs1Jq8dnleXXg/cO25yiptnB1cXcDtUTFnUZMnLCAWDPXtbxAqIJocfFDmnMt
         ljCzrjDtUkho540gcPKjgZhsK3Qx247NMazeZhqYcqVjrMW+LboIngd3b7vTW8EIM1Mf
         c7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTAI4NBWGTQ5h3Og/iXOFE6+j1LyXYJBHvMW6aUVVzs=;
        b=cCdKkUBS8S2plg0l1Y7FZZwJkvT8o35kwHYz34P/eaWBUhI3gKaPrCSYbEDb+ZK1t0
         C9j1Xu3xULs9Pr/ahPtEvKNtaskD8r+pSkY2Qt9T4FbWkBi9oBDZGZIovalqvH0A9BwL
         Tj6FcTBtG9BUXmVwF1CYjA26ksS9B34+b08Bif9c4djJLxe8gtM9s3LWDyidcxCb6bEy
         Rdx87wycbuFyGXuBOm7UeNO5K8NM7++tGnhGfpvXkW7WCak+zPNIGD+lZFHBwQoAsO2a
         267kSacD6gqVHHFsZEFiYDgcKe2KjtSfDYGzTLX0zRBkik2ZErbaYU67BQOtF4m9O2jr
         znVg==
X-Gm-Message-State: AJIora8XK8xY5zbpLhNRXDaqVQBXfqYBHUwl749WpZiBDEUFplHvX/73
        PNOHgFw1Zixx2K75SU3NlI3u+HCNHSF/I5bUkP15jw==
X-Google-Smtp-Source: AGRyM1ugrvrSsb7yRxRfEHxgKZdj4iicx5noLl7XxjN5iOiB+xVZH44oPJIYfkMBjU1FtW9yPjkMrkbXYKHpcaVHK1M=
X-Received: by 2002:a05:6638:2486:b0:33f:85cb:f387 with SMTP id
 x6-20020a056638248600b0033f85cbf387mr10458707jat.247.1659008771414; Thu, 28
 Jul 2022 04:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220728063856.72705-1-zhangjiachen.jaycee@bytedance.com> <CAJfpegsAf=VzvC=ej+60bHgK7zOoKwQehabTAmvNYQPCQwmFKA@mail.gmail.com>
In-Reply-To: <CAJfpegsAf=VzvC=ej+60bHgK7zOoKwQehabTAmvNYQPCQwmFKA@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Thu, 28 Jul 2022 19:46:00 +0800
Message-ID: <CAFQAk7jW9ZpSURW4+h9SZNNtqXqq65LxsXrtheaijk4HFzbqcg@mail.gmail.com>
Subject: [PATCH] ovl: only WARN_ON_ONCE() if dentry is NULL in ovl_encode_fh()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 4:57 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 28 Jul 2022 at 08:39, Jiachen Zhang
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
> > So let's replace WARN_ON() with WARN_ON_ONCE() to avoid kernel log
> > flooding.
>
> Better just drop the WARN_ON() completely in that case, since it's a
> normally occurring condition.
>
> Thanks,
> Miklos

OK. I will send the v2 patch later.

Thanks,
Jiachen
