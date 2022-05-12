Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C338524D87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353995AbiELMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiELMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:51:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049EE3ED3D;
        Thu, 12 May 2022 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WSIXDWoWhUX8n7imNCPH8e48agYhT4xUKD1pQ6vTWU8=; b=ljjOYQwaLTm69ZjncJWJrVQt4d
        7rlw+tAxAfv5KDuhx+0zhSl8IqqRc2cF9pfZsCeiIX8SD5URBmD70dRoiP3LKsaU+6pW1VlnuOFlV
        8BrL/LjySLhAL9pDJSj+wWhXuf3Dn8zyue0WgMJ3Yms4/uwSLaNfFMuAN4vrkmUncr7pGOhx1/y8r
        tNt9lW1eC1OTvZczWe4SDuo5fesUmiaM86fLMKydghZgbWmMfDMhsdzt1nD5eqf/bBfCqOk9whbgz
        9n7Wp3dLrleWRnSZtSC24PwHFKwDl9Av0a9iZ2uivd16nJL9POPr0Ndmtnlo/D6tVgNCfDy4xJGEw
        qpNxtRlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np8HY-006OiR-0D; Thu, 12 May 2022 12:51:04 +0000
Date:   Thu, 12 May 2022 13:51:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <Yn0Ct66Ww44HDj7S@casper.infradead.org>
References: <20220512182650.7d1a94c7@canb.auug.org.au>
 <CAKFNMokFYi4AGd8+B6sT73Pu9k_bAu53-d_u1=0fsiHbz3Jgxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKFNMokFYi4AGd8+B6sT73Pu9k_bAu53-d_u1=0fsiHbz3Jgxg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:52:17PM +0900, Ryusuke Konishi wrote:
> On Thu, May 12, 2022 at 5:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the mm tree got a conflict in:
> >
> >   fs/nilfs2/inode.c
> >
> > between commit:
> >
> >   f132ab7d3ab0 ("fs: Convert mpage_readpage to mpage_read_folio")
> >
> > from the folio tree and commit:
> >
> >   e38ed506c42f ("nilfs2: Fix some kernel-doc comments")
> >
> > from the mm tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks, Stephen.
> 
> Andrew,  please once drop
> 
>  e38ed506c42f ("nilfs2: Fix some kernel-doc comments")
> 
> from -mm tree.   I will resend a modified patch after the folio patch is merged
> to the mainline.

I'd be happy to take this patch through my tree instead, if you point me
to where I can pick it up (I don't see it on fsdevel or mm).

Although I do think we need to consider whether implementations of
fs entry points (aops, fops, iops, etc) should have documentation in
the individual filesystems.  I understand why individual filesystem
authors want that, but it would be better if we had really
good central documentation of VFS/FS requirements (and honestly
Documentation/filesystems/{locking.rst,vfs.rst} aren't bad) instead of
reiterating them in each individual filesystem.
