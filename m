Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD15758B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiGOAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiGOAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:52:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AF47B9C;
        Thu, 14 Jul 2022 17:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z8kOPQco54RZV7WyIfV3pg4It53JMw8lFGZmv04yyFI=; b=LpPeQBNyw1PqozGc6RwnbDkGpj
        eAUPzpHMZFG2gJaR256d2Tgk3ya0g7W+g6OySThVLdDrxxuO2sdDWfQrd6ikfv62P+g5tF0LhVwHf
        WbyKpt6Al1HFJDvqAoD6KPhWRNv6mse21Q3HYZOKr4d+JQHA6oisRfxnwG6XjHC7zr0U4zdayogct
        5NItiuCUiTNkc6hn65V3difsAqr/TuOheaCaTTYcwxFSiog1LyP4AuqR3xdoTnAcIzevHLNTSLp8K
        F92X1O0z0GAwbjTdNcgRxC0sFZCvBYKnNsZy1lOMw7Diu4KZUiDl6wI6ocnkzbcxmpqdmeOK8rvf1
        5bSlaS5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oC9ZB-00C8Ac-G5;
        Fri, 15 Jul 2022 00:52:25 +0000
Date:   Fri, 15 Jul 2022 01:52:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <YtC6SUmyaCSKe2HX@ZenIV>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:36:35AM -0600, Jens Axboe wrote:
> On 7/13/22 8:08 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the block tree got a conflict in:
> > 
> >   block/bio.c
> > 
> > between commits:
> > 
> >   35006342b739 ("block: ensure iov_iter advances for added pages")
> >   248022ffae3f ("block: ensure bio_iov_add_page can't fail")
> >   7b1ccdf617ca ("block: fix leaking page ref on truncated direct io")
> >   9a6469060316 ("block: convert to advancing variants of iov_iter_get_pages{,_alloc}()")
> > 
> > from the vfs tree and commits:
> > 
> >   5a044eef1265 ("block: ensure iov_iter advances for added pages")
> >   ac3c48e32c04 ("block: ensure bio_iov_add_page can't fail")
> >   44b6b0b0e980 ("block: fix leaking page ref on truncated direct io")
> > 
> > from the block tree.
> 
> I pinged Al about this the other day, but haven't heard back yet. It's
> not clear to me what block bits he has in his tree. We'll get it sorted
> out.

Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
one of the commits in it got changed since then - the difference in
__bio_iov_iter_get_pages() (unsigned int i initialization).

Sigh...  I'll rebase on top of that.

Al, digging through the vicinity of propagate_umount() and cursing himself
and ebiederman in about equal proportions since the last weekend...
