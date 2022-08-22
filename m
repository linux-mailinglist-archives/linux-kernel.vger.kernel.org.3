Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422659C2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiHVPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiHVPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:24:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032964F7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:20:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F634346C1;
        Mon, 22 Aug 2022 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661181656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOugp0arXi6PbnZspKBUOzjZp1e4ktn4gDiB2vuIYYU=;
        b=s4590lSMJAQ601yDxFsZVYneQsn6DwfFjYfUFfKcK2gIl2wuIIxRjhIeHl/jSyccbKwP1G
        LRQTmQ68P0iMdIuM2mYFno0Zgq27TCHYJUR58KGF4alQECUnYp/63yTXdaiOJYM3bZl6Y3
        +iFOA3BKgzYb0sngAbHf18Cy6r0rvn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661181656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOugp0arXi6PbnZspKBUOzjZp1e4ktn4gDiB2vuIYYU=;
        b=z6j9pD47ERTNCUbZfNwdCmXEQOHSCwqe1Wt1BFPqvGlV5vn+FPmZIg5DtwqkPsoaaXdMqE
        rDaeAHQqbnnWjSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D547E1332D;
        Mon, 22 Aug 2022 15:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FDwFNNeeA2MPFgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 22 Aug 2022 15:20:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D2F3A066F; Mon, 22 Aug 2022 17:20:55 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:20:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>, Gaosheng Cui <cuigaosheng1@huawei.com>,
        eparis@redhat.com, mszeredi@redhat.com, amir73il@gmail.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] audit: fix potential double free on error path from
 fsnotify_add_inode_mark
Message-ID: <20220822152055.hitwrvi3lmldhcgx@quack3>
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
 <20220822085050.hxj6qmgj2x2tj6uv@quack3>
 <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-08-22 10:34:15, Paul Moore wrote:
> On Mon, Aug 22, 2022 at 4:50 AM Jan Kara <jack@suse.cz> wrote:
> > On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
> > > Audit_alloc_mark() assign pathname to audit_mark->path, on error path
> > > from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
> > > of audit_mark->path, but the caller of audit_alloc_mark will free
> > > the pathname again, so there will be double free problem.
> > >
> > > Fix this by resetting audit_mark->path to NULL pointer on error path
> > > from fsnotify_add_inode_mark().
> > >
> > > Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
> > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> >
> > Good spotting! The patch looks good to me. Feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > > ---
> > >  kernel/audit_fsnotify.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > > index 6432a37ac1c9..c565fbf66ac8 100644
> > > --- a/kernel/audit_fsnotify.c
> > > +++ b/kernel/audit_fsnotify.c
> > > @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
> > >
> > >       ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> > >       if (ret < 0) {
> > > +             audit_mark->path = NULL;
> > >               fsnotify_put_mark(&audit_mark->mark);
> 
> As I'm tracing the code path from audit through fsnotify, and back
> into audit, I'm wondering if we still have a problem.  When
> fsnotify_add_inode_mark() fails it will end up freeing not just
> audit_mark->path, but audit_mark itself via audit_fsnotify_mark_free()
> (via a call into fsnotify_put_mark()), yes?

I don't think so. fsnotify_add_mark_locked() will call fsnotify_put_mark()
but that is just a counter part to fsnotify_get_mark() a few lines above.
The caller of fsnotify_add_inode_mark() still holds its own mark reference
which prevents mark from being freed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
