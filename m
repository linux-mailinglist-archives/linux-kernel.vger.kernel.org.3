Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333F759C1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiHVOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiHVOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:34:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381629CA3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:34:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o204so4908583oia.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bmiBTQn9bSIFciJROo/TZ9R+2ykRpH3UDlEuqmz67Do=;
        b=QFfVHH0V30TcdZpqIAz0ZNO5wXWwse55tYigeXqgTTLokyHCs19zERRtXe0ZLOBtkk
         AnBVPgjknLBvXqPxvwcUR4eXLgfrDRNNY75P8JidWn6hv4+0OiLye4h7ngbDnvjBaeHR
         mTUyN+/udtZutllAghkEpqSrYlz/EqhCbi24csj0hz4ElEMzLxASuTMWzOTbxjTAVfdi
         d1bhptdshe6HoArg5+gDRq8la6slexjDMSHOAevYLIsAOQBYTruD8Ea5VT6WQTzouQXb
         TV5WBor1ryx2hoyJpm12z4FV6gMOJfMOZnoL/Akasjote+MMjv9JBP+x9aO2zivxmnob
         dfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bmiBTQn9bSIFciJROo/TZ9R+2ykRpH3UDlEuqmz67Do=;
        b=GA/2aBS86ygoH+w6QAP6sVtg9tLQCoXAtSjibysr9i1zxImDaYJtHADE0VP5UXY7vp
         sRDpNF+3/9hCemoBBrl/EwS4GMWTS5mHdQCPUxuvpIu9+RuI4dTqZLmDtOy3I0yr7wQW
         fqEss1oCMUHTWBnqo7kz9letLMUmLv3ap+a432qfS6upAfeZDRZ9eiin6qsDrXLN7AdR
         VtfaWYoBSU3KRaRVjCjYjjRqFXm44yVKKhCgIVG+9Crx0123uvUToFwoWaQSwjhUMbCB
         9tZBSNnW3QAqczWzNvWj/nCWvCRfwt6fwKg9bjqhW/IE+NFCqxRVgD8yuZGV9+yjHMvX
         7WKA==
X-Gm-Message-State: ACgBeo06byAqJ6G63iu9WHtLSs1sj4qgSFWMztWm7zRbXAoEOUXE/0W/
        h9FBIk/TVl4libDtww7M5dCsZN6O8cGwnSdQqSNJ
X-Google-Smtp-Source: AA6agR6IBSVhuEjhhepGg5sjOT30TqAxm9GhBVarGe21AIXPI6fI8jlXHftGkMWyDIyfj7pgUKiNXDgst5dbgMo/Aas=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr9254403oif.136.1661178865731; Mon, 22
 Aug 2022 07:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com> <20220822085050.hxj6qmgj2x2tj6uv@quack3>
In-Reply-To: <20220822085050.hxj6qmgj2x2tj6uv@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 10:34:15 -0400
Message-ID: <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
Subject: Re: [PATCH next] audit: fix potential double free on error path from fsnotify_add_inode_mark
To:     Jan Kara <jack@suse.cz>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, eparis@redhat.com,
        mszeredi@redhat.com, amir73il@gmail.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 4:50 AM Jan Kara <jack@suse.cz> wrote:
> On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
> > Audit_alloc_mark() assign pathname to audit_mark->path, on error path
> > from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
> > of audit_mark->path, but the caller of audit_alloc_mark will free
> > the pathname again, so there will be double free problem.
> >
> > Fix this by resetting audit_mark->path to NULL pointer on error path
> > from fsnotify_add_inode_mark().
> >
> > Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>
> Good spotting! The patch looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> > ---
> >  kernel/audit_fsnotify.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > index 6432a37ac1c9..c565fbf66ac8 100644
> > --- a/kernel/audit_fsnotify.c
> > +++ b/kernel/audit_fsnotify.c
> > @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
> >
> >       ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> >       if (ret < 0) {
> > +             audit_mark->path = NULL;
> >               fsnotify_put_mark(&audit_mark->mark);

As I'm tracing the code path from audit through fsnotify, and back
into audit, I'm wondering if we still have a problem.  When
fsnotify_add_inode_mark() fails it will end up freeing not just
audit_mark->path, but audit_mark itself via audit_fsnotify_mark_free()
(via a call into fsnotify_put_mark()), yes?  If that is the case, I
think the better fix would simply be to just remove the
fsnotify_put_mark() call and add a small comment in this error patch
mentioning that fsnotify_put_mark() will release audit_mark on error.

Thoughts?

> >               audit_mark = ERR_PTR(ret);
> >       }

-- 
paul-moore.com
