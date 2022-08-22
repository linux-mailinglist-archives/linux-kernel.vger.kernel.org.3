Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5138259CBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiHVWuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:49:57 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138B50050
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:49:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j5so14022442oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8nKqUI0HXJF/DN2lVXpvnqKoo28eFvsWfSBgF4oecMU=;
        b=AeyTTXY0eBDEgLCqBlRGUJPrCVRydLKmxomYIImQRqtNROuHW3O0ECAdHIP3nKbv+8
         xWpKChNK/xPq3VGnXscNpnOMCvqunSbM6G0EO9ozy/PFzT3rZfk24fPHn2nqUqHesIKO
         1g2XpbvcVAQmoGKo6PamywwFbCpjbesZ+m9QAWWfAQZIxlxS+nALFXACLFFVtt1JRDxm
         ZzXHWXtXbk3egUKJXc7Yqk13qGTcOfFN6ysiLE9TR+dwZJZEchdg1Nq4Gym1yU5WXUFz
         k0GvDB+C4u+o4EwkUGTsrcNQAHTIZwBziie/sErE014i6v+jzYJAOerw9xlKTF8uPhlV
         Cisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8nKqUI0HXJF/DN2lVXpvnqKoo28eFvsWfSBgF4oecMU=;
        b=4ensK7HWXz2UrWUtd89Tjs5xwaHJlDPAOYL/+bUbUsBkCbJetQd9evFkbxikzLFOjm
         K71I9BJZ6GmGc0lXD5umQgkkGzcsqfPC5gxPZXfKLRdyiivnoFcShU+VrgSZ4O8i+tlK
         LFxMOQikRJ+GeijP4mvKv0shdfiVGmG0dG0Qk+q+QiE2ZHjEmBRcA8ZCXAIhjCUGgBty
         oePkQSask/7KMS3JIrYNSq9X859oaK0j7Hufzy3pF1ieEH8tiTal/wowtcunF7LTAleD
         T/WRO1tylGzoIeG/jUl4o4Q0EfKCRslOQYdFZS/3GAsgIsOG/Y5JWIZmiGSKEpErZnr+
         Sy+Q==
X-Gm-Message-State: ACgBeo3J146bOcLcasLe+wSPc0WyBsChtipTkBmt3dt9JHpkxmxFUVgu
        JvT0BJ8tg+FTSDyCjh49Ax0Bfih5PLg29mtwdKwu
X-Google-Smtp-Source: AA6agR4H8paCYtYRhOh4FE47j/iG7+oMzwaQ1SMIaJkQ+YE8MRjomzmqRHc/WEVl2GeAXSrEEvUgQhVcBrELgjXuJmc=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr220691oif.136.1661208595569; Mon, 22
 Aug 2022 15:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
 <20220822085050.hxj6qmgj2x2tj6uv@quack3> <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
 <20220822152055.hitwrvi3lmldhcgx@quack3> <CAHC9VhQoTHZ4SFz2k7=2OLKFdrpmxq8ei-sNDNfV0MFtJsqpFg@mail.gmail.com>
 <20220822175907.q35mhoqdtdqxture@quack3>
In-Reply-To: <20220822175907.q35mhoqdtdqxture@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 18:49:44 -0400
Message-ID: <CAHC9VhTpLqvZ7PCi3kn1NE6Sq967wLZA1MgnONUVYa0+j_EXbA@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 1:59 PM Jan Kara <jack@suse.cz> wrote:
> On Mon 22-08-22 13:39:23, Paul Moore wrote:
> > On Mon, Aug 22, 2022 at 11:20 AM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 22-08-22 10:34:15, Paul Moore wrote:
> > > > On Mon, Aug 22, 2022 at 4:50 AM Jan Kara <jack@suse.cz> wrote:
> > > > > On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
> > > > > > Audit_alloc_mark() assign pathname to audit_mark->path, on error path
> > > > > > from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
> > > > > > of audit_mark->path, but the caller of audit_alloc_mark will free
> > > > > > the pathname again, so there will be double free problem.
> > > > > >
> > > > > > Fix this by resetting audit_mark->path to NULL pointer on error path
> > > > > > from fsnotify_add_inode_mark().
> > > > > >
> > > > > > Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
> > > > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > > >
> > > > > Good spotting! The patch looks good to me. Feel free to add:
> > > > >
> > > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > >
> > > > > > ---
> > > > > >  kernel/audit_fsnotify.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > > > > > index 6432a37ac1c9..c565fbf66ac8 100644
> > > > > > --- a/kernel/audit_fsnotify.c
> > > > > > +++ b/kernel/audit_fsnotify.c
> > > > > > @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
> > > > > >
> > > > > >       ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> > > > > >       if (ret < 0) {
> > > > > > +             audit_mark->path = NULL;
> > > > > >               fsnotify_put_mark(&audit_mark->mark);
> > > >
> > > > As I'm tracing the code path from audit through fsnotify, and back
> > > > into audit, I'm wondering if we still have a problem.  When
> > > > fsnotify_add_inode_mark() fails it will end up freeing not just
> > > > audit_mark->path, but audit_mark itself via audit_fsnotify_mark_free()
> > > > (via a call into fsnotify_put_mark()), yes?
> > >
> > > I don't think so. fsnotify_add_mark_locked() will call fsnotify_put_mark()
> > > but that is just a counter part to fsnotify_get_mark() a few lines above.
> > > The caller of fsnotify_add_inode_mark() still holds its own mark reference
> > > which prevents mark from being freed.
> >
> > Okay, that sounds reasonable, but I'm still looking for a code path
> > that only frees audit_mark:path and not the audit_mark itself.  What
> > am I not seeing?
>
> The callers of audit_alloc_mark() call kfree(path) if audit_alloc_mark()
> returns error (which is a sensible thing because in some cases path indeed
> needs freeing).

Of course!  Thanks for that, I think I got a bit of tunnel vision on
this for some reason.

I'll merge this into audit/stable-6.0 now and once testing is complete
I'll send it up to Linus.  Thanks everyone!

-- 
paul-moore.com
