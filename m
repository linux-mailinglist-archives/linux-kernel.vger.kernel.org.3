Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDAD483436
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiACPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:30:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiACPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A57CFB80F02;
        Mon,  3 Jan 2022 15:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C2C36AED;
        Mon,  3 Jan 2022 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641223817;
        bh=xF1wUuBGwl8cywKSiYLlPRBu49Oq3z4IdXLowrf6NNs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CrVAH7x8/9DiClHBBaLT6lX/vtqzsgjsG6214lpeRzCU5YfqjlLsHsV7ubnWOm6iK
         YbCix4R2Z0UsIM8YxohtwuI+rOWjjGhoj7XU6bzho44wwrI85AfXKvsAHA5C9vVo+y
         6pD2CPDiYwzz9Ox69qG9M/c6AuhGQUrmm6oWuquTkivni4w6fGQnRIKQq8+MTQ02xX
         ppBMlfJRZwmwtT5ucvdZily2draTk+nkS0bIFxJJlvMc5g5cnpLRw4Jqw/NVrWrbU4
         Fm5FTDoWmVbStKPOyOIBiQ6oMbzqrbb9kz65tPyo7BXFpuz/l5/No+L/jsMt8YgyIM
         faHfG4BqpxXog==
Message-ID: <7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org>
Subject: Re: [PATCH] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     cgel.zte@gmail.com, Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 03 Jan 2022 10:30:15 -0500
In-Reply-To: <CAOi1vP-uVjgcbHj6n_BesjS6-9H+02P-cy=1MKZsy9wk=OW7-Q@mail.gmail.com>
References: <20211221143614.480385-1-deng.changcheng@zte.com.cn>
         <bc8803b511ed25ddc7091ba1f09f10ca415ca51e.camel@kernel.org>
         <CAOi1vP-uVjgcbHj6n_BesjS6-9H+02P-cy=1MKZsy9wk=OW7-Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 16:03 +0100, Ilya Dryomov wrote:
> On Mon, Jan 3, 2022 at 3:41 PM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Tue, 2021-12-21 at 14:36 +0000, cgel.zte@gmail.com wrote:
> > > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> > > 
> > > Fix the following coccicheck warning:
> > > ./fs/ceph/debugfs.c: 390: 0-23: WARNING: congestion_kb_fops should be
> > > defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > 
> > > Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> > > debugfs files.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> > > ---
> > >  fs/ceph/debugfs.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > > index 3cf7c9c1085b..64c4158c17c8 100644
> > > --- a/fs/ceph/debugfs.c
> > > +++ b/fs/ceph/debugfs.c
> > > @@ -387,8 +387,8 @@ static int congestion_kb_get(void *data, u64 *val)
> > >       return 0;
> > >  }
> > > 
> > > -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> > > -                     congestion_kb_set, "%llu\n");
> > > +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> > > +                      congestion_kb_set, "%llu\n");
> > > 
> > > 
> > >  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
> > 
> > Thanks, merged into our testing branch. This should make v5.17.
> 
> Hi Jeff,
> 
> This came up last year, has anything changed?
> 
> https://www.spinics.net/lists/ceph-devel/msg50492.html
> 

Good point, that discussion had totally slipped my mind. Dropping this
patch again for now until the rationale is clearer.

Jiapeng, could you clarify why you didn't do the other part of that
conversion?

Thanks, 
-- 
Jeff Layton <jlayton@kernel.org>
