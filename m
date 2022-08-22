Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7C59C521
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiHVRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHVRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:39:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11F3F332
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:39:35 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j5so13045268oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PlnhdG09sWsWaCHIcZfuaDthGF5DP+s6ro2Ew62531E=;
        b=CEOmaDwqpMPDkudRa/LpIU4ti4DWbT1aKW49rfuHxqa4Nretc72RJKN0SXsdmixuwj
         JMyQMoREo94NLa9XS0uArMQv57UglileRYYvjL8MlDEIkmgIMJldbT1KX09wO90d4TSR
         eXlxq9MRKlZ5bYj2vY0imyIKP1fsRr8s69TJcKpQ4h59MNzyoAtP2Prv2YWdVV//fJBp
         P9rJqYK+XCvavk6PwviokzI58p3sVHZj4+HGQP5HMKFy9rLVXc0kj0UndAvJEV/SglgX
         ON/yfkTdXihlsQLr7UDLsaIePuechRateD4rSuIUyLuw78MMa9z+yUBmlpX1T4ugdiNc
         LtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PlnhdG09sWsWaCHIcZfuaDthGF5DP+s6ro2Ew62531E=;
        b=IkeiGWsx9euKK1mymOiIJsknhtp09VdRt0m72i4ycWxKDMNvfhx08DtuWmTpZdulKY
         Txj5Oodw94BoJ80UdZhOQPlA0fc1hvhiwuIwwA4o5VLdSjU+yk3cAsY/IwpB7qH7YO6J
         FKbxBOs5Iv+DXaOL9SFxJ5LjPRfUebx8oYFUrYllwOeX14kyocabsOSLDvlk65P+Pxvk
         I2MXxy30NxvZSYiFZByhEuY6nmCJ6HlLvOm7YDROjyJVbBbtdIPcpwyRJlgDwSKlixBc
         goygKQLpYTehtcl5jvoTbN7NhptnNxCbr8EbRIeZ1zEYEXvuxtrh02U0zN/+OKeJe27t
         nz2w==
X-Gm-Message-State: ACgBeo2BrRTwhlsVPCtbiAHWeSHm+ZqJDuxHhhS9pw+ilmrkXhVRJWqY
        9yo8qIZDL/U3Wpd3uCFkjOAS34WISnglISQvN0V0
X-Google-Smtp-Source: AA6agR73YM2LwSgi0JPEGQZhgQugEyBXB1eQ2HCQeJeNbG9N9P/M5lTR/pG7BqBF9qghB+kE4INOOf9XhZWq/VUkmPE=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr11766466oie.41.1661189974627; Mon, 22
 Aug 2022 10:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
 <20220822085050.hxj6qmgj2x2tj6uv@quack3> <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
 <20220822152055.hitwrvi3lmldhcgx@quack3>
In-Reply-To: <20220822152055.hitwrvi3lmldhcgx@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 13:39:23 -0400
Message-ID: <CAHC9VhQoTHZ4SFz2k7=2OLKFdrpmxq8ei-sNDNfV0MFtJsqpFg@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 11:20 AM Jan Kara <jack@suse.cz> wrote:
> On Mon 22-08-22 10:34:15, Paul Moore wrote:
> > On Mon, Aug 22, 2022 at 4:50 AM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
> > > > Audit_alloc_mark() assign pathname to audit_mark->path, on error path
> > > > from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
> > > > of audit_mark->path, but the caller of audit_alloc_mark will free
> > > > the pathname again, so there will be double free problem.
> > > >
> > > > Fix this by resetting audit_mark->path to NULL pointer on error path
> > > > from fsnotify_add_inode_mark().
> > > >
> > > > Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
> > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > >
> > > Good spotting! The patch looks good to me. Feel free to add:
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > >
> > > > ---
> > > >  kernel/audit_fsnotify.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > > > index 6432a37ac1c9..c565fbf66ac8 100644
> > > > --- a/kernel/audit_fsnotify.c
> > > > +++ b/kernel/audit_fsnotify.c
> > > > @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
> > > >
> > > >       ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> > > >       if (ret < 0) {
> > > > +             audit_mark->path = NULL;
> > > >               fsnotify_put_mark(&audit_mark->mark);
> >
> > As I'm tracing the code path from audit through fsnotify, and back
> > into audit, I'm wondering if we still have a problem.  When
> > fsnotify_add_inode_mark() fails it will end up freeing not just
> > audit_mark->path, but audit_mark itself via audit_fsnotify_mark_free()
> > (via a call into fsnotify_put_mark()), yes?
>
> I don't think so. fsnotify_add_mark_locked() will call fsnotify_put_mark()
> but that is just a counter part to fsnotify_get_mark() a few lines above.
> The caller of fsnotify_add_inode_mark() still holds its own mark reference
> which prevents mark from being freed.

Okay, that sounds reasonable, but I'm still looking for a code path
that only frees audit_mark:path and not the audit_mark itself.  What
am I not seeing?

-- 
paul-moore.com
