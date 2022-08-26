Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBA5A2BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbiHZPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbiHZPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:49:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A03FC6E96
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:49:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io24so1925131plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9Xr0k1F/n6DXUYyny/jSc9xyKQVr9bMMBjQ0x9hJugc=;
        b=EFek5s+75roAZuIl4BSgg8kXDr1+N1he6wQ9DGg6l6S91/oI41FAUIF1zAinsrbmEu
         QPE743pmSEttSnsgEY7SIvXx+NG59pxAfXWRmKW/vDRqcfiv4M+JSKkDRQZP50ynbPIs
         YuxCzxvqjk62RMWy7fSbDXP9JbxIU/v2XBmWOcyooYH+kCjF1xZgNytPj0TSEktMQkjQ
         3cAGIVmPZCQEzIBJ+2SVB8LeXK3IAwGiSJB5HNjNe7qKmcD1vAsklEO5RdrfgnE7hn2F
         cDeCGF++9Z1E55kAUk4Ub8jtVBAcazTYnzHCP8C65q5chM0dzRzXKmqyVuoCuDlhMDGl
         RjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9Xr0k1F/n6DXUYyny/jSc9xyKQVr9bMMBjQ0x9hJugc=;
        b=mMdUGDMXC36xJfhMLJ0dpXvbGQtBpGWHNcMAskRDOcZdHFrAXdFBhWIBEmXa7E71em
         fvyidhdSez/Mae15GAddBYf+3b739er8LnlHSQzS9CGRUYBoD2RzCt1hk591eOPw9Rm6
         mL3QyEdAADDdWMUcV6abP0T1oePt7kpauzXs84LMtiK1yxXTxUkuWiZcZrvgSrbiKnnL
         6sYZH9GCPAMwObO19zKL3UuqHydP/sK+3LOHxBgwK/C7T2fiY+4ww9ZmPDMgK2Rcyutw
         lPKEf3ELmBo+BQwFvKh77lkos3ebPWezLr8G/Hry5suRBGpsTxFUKijpv6+KMomtOPpt
         5ZNg==
X-Gm-Message-State: ACgBeo39onamS7TDjY7KAiPm27oDTy6uXoZmYZaN3h0vfZCui3Ambl5h
        j7RlEfHXaTR/AcljhzLanuA=
X-Google-Smtp-Source: AA6agR40CnhS7gTvEftrm3vIxOndD/sHMM/MGhyRdeYci8Oq8W9u/jnQ5Cxvolba0GoK9xvfVY52bQ==
X-Received: by 2002:a17:90b:4a0e:b0:1fb:4c5e:9584 with SMTP id kk14-20020a17090b4a0e00b001fb4c5e9584mr5137723pjb.152.1661528959477;
        Fri, 26 Aug 2022 08:49:19 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b00173164792aasm1741388pln.127.2022.08.26.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 08:49:19 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Fri, 26 Aug 2022 23:42:32 +0800
Message-Id: <20220826154231.6634-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826151520.GF2071@kadam>
References: <20220826151520.GF2071@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 23:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Aug 26, 2022 at 08:32:57PM +0800, Hawkins Jiawei wrote:
> > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >
> > > Looks like it is improper check order that causes this bug.
> >
> > Sorry for wrong command.
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >
> > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > index 52615e6090e1..6480cd2d371d 100644
> > --- a/fs/ntfs/attrib.c
> > +++ b/fs/ntfs/attrib.c
> > @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> >               u8 *mrec_end = (u8 *)ctx->mrec +
> >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > +             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> > +                     break;
>
> This definitely seems like a bug.  But your code won't build.  Syzbot
> must have -Werror turned off?
Hi Dan,
Did you mean we should put the variable declares at the beginning of the function?
(Correct me if I understand anything wrong)

>
> Btw, this was in the original code, but those casts are ugly.  Ideally
> there would be some way to get rid of them.  But otherwise at least
> put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".
>
> >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> >                              a->name_length * sizeof(ntfschar);
> > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > -                 name_end > mrec_end)
> > +             if (name_end > mrec_end)
> >                       break;
>
> regards,
> dan carpenter
So maybe I can try to refactor these codes. But I wonder if this can be
done in a seperate bug
