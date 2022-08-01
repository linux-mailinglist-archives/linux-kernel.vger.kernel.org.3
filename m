Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47AC5862A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiHACch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbiHACc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:32:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96C12D1D;
        Sun, 31 Jul 2022 19:32:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x11so7107687qts.13;
        Sun, 31 Jul 2022 19:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbN/7gBvVv1RRKMY+HZS9hC+6waaWky3BM3Xc+dBSts=;
        b=N4G4Be9xrzDcyeiZbeUWCt9NSltr79R7d7AqH04+P7sTBqzZWDk/PCtBLj6MNSJCr7
         QXWZTv5vqTw6gVrHg/aCMywS43F5TcLkiXHGrjuF5Unf3EZek4XRJBn/WmUI3lffTwdo
         +4cR3MTfNNy5lGMEACdsogPZLMFcKQyLli3yCS8cy8BRm29yy5+JClxif8prEkzk8HK5
         Yu6eRuK0zGstm+x0+ZSARpw2g9v/hLBLCRG0lVQ8xp2Hsa+CyPonn0x8VfXpuQjinf/8
         B9vMBvRGCDjk3fHXh3/hnwJmwaYobtWNRuanz+BAgg00142kmXiFoPqkDh7BvuB+mSVr
         BThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbN/7gBvVv1RRKMY+HZS9hC+6waaWky3BM3Xc+dBSts=;
        b=btH5LFK/4TCJUpfs83eOB3UOLlVjdRhT10KiYhkTxEA5WbTIm09ylf3iducPLnSzeP
         NuILn9CUDvdc1o7uQooJHp1EYgzM77BTOLDWGNl3jwoG6WoLmyJmrnbLO0URJ9me5snb
         RPUcMvtgflL3tqb0U6K3AQ0mIpEecWc9I/CTAbxmnmaZmRwEmjliuHJGMNFZGkUy07r2
         cdc4NS06gdYH2COy6JbFYG/v7KIVNPaDdnUrCQ5WHdykDQXCA4gEEHBuh9mqKoGvX1IG
         epYM2/b+Cyr3fz/fAGPuOeD3B/9L/HlWFI4/cXSWCWFQ2K2RoDUg11NMPe3BQ5lks9sN
         5HwQ==
X-Gm-Message-State: AJIora8JRzk3vGvq8lrcunYcLZU/dQHPmYYykF6GZuwn8iAH1KZG4iVh
        am1WWO6m13cT1EtGyelL58I/rV4uwuG15+KCJGs=
X-Google-Smtp-Source: AGRyM1vpJoZ102DrXO2dbAWQF8oCXXjGzS5L8PSc81BGtnuTdBQPRwOvGYxBGnvlxBJj96jCkHZkKHUEIWmwnV5woyc=
X-Received: by 2002:a05:622a:650:b0:31f:496:49e4 with SMTP id
 a16-20020a05622a065000b0031f049649e4mr12948149qtb.70.1659321143804; Sun, 31
 Jul 2022 19:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220729074935.115072-1-yangyingliang@huawei.com> <CAH2r5muo6yBej4J_2P+09WNmDoCSW3vbgR4JwM-42B0SQoUotA@mail.gmail.com>
In-Reply-To: <CAH2r5muo6yBej4J_2P+09WNmDoCSW3vbgR4JwM-42B0SQoUotA@mail.gmail.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 1 Aug 2022 08:02:13 +0530
Message-ID: <CANT5p=rhyrwR_EGn01Ux7wsTaP05gjmD6_CZYfyRQc1Xd97Mow@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: fix wrong unlock before return from cifs_tree_connect()
To:     Steve French <smfrench@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
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

On Fri, Jul 29, 2022 at 9:08 PM Steve French <smfrench@gmail.com> wrote:
>
> merged into cifs-2.6.git for-next
>
> On Fri, Jul 29, 2022 at 2:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >
> > It should unlock 'tcon->tc_lock' before return from cifs_tree_connect().
> >
> > Fixes: fe67bd563ec2 ("cifs: avoid use of global locks for high contention data")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  fs/cifs/connect.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > index 931d4b6fafc8..1362210f3ece 100644
> > --- a/fs/cifs/connect.c
> > +++ b/fs/cifs/connect.c
> > @@ -4583,7 +4583,7 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
> >         if (tcon->ses->ses_status != SES_GOOD ||
> >             (tcon->status != TID_NEW &&
> >             tcon->status != TID_NEED_TCON)) {
> > -               spin_unlock(&tcon->ses->ses_lock);
> > +               spin_unlock(&tcon->tc_lock);
> >                 return 0;
> >         }
> >         tcon->status = TID_IN_TCON;
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
>
> Steve

Good catch. Looks good to me.

-- 
Regards,
Shyam
