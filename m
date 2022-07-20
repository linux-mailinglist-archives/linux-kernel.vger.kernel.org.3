Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334657AE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiGTCpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbiGTCpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:45:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A7326E9;
        Tue, 19 Jul 2022 19:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tfkq/jK6AMy8w3Sz1zvbcf2p9FS6/PjyhQElffDDPlE=; b=hQhvhsVmczeFcNZsANZnh4PpTQ
        MxiBKY327qnApGMu6Eh8xcRCKuKOhpnRHHnKhMpakR6mC4dR5tv9r39pIS8YoraYJaKTgGciRWIAZ
        1hQ+eVnYUUZpuF1GTAxnjO4WGFoE5/ji35LxOGjcOWWYMbo8GQghO6W1axcG5vfmfYa7NtGXYPq1z
        aC/b4zsdQOOt79+n7vQEHwaoOBpRG+01XyzEUOUg9F9ugwPzIKrSk2pZNfzqXZ2bOPgIouFVegjm9
        5Scfj6uMxr1bKXNSidua0scw7UiTnd7Ru9FGBFwhvozxtYAff2KKttOtuHgirIq0O7nEfHD+EoZ8M
        uBCdM1eA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDziC-00DxXc-BJ;
        Wed, 20 Jul 2022 02:45:20 +0000
Date:   Wed, 20 Jul 2022 03:45:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <YtdsQIm2kbmEqFRC@ZenIV>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
 <YtC6SUmyaCSKe2HX@ZenIV>
 <YtC9AgqezKXuUoy6@ZenIV>
 <20220718125932.1ab89122@canb.auug.org.au>
 <YtTofKIkWU4eXvoK@ZenIV>
 <a43c8f77-a15f-ab1b-579c-feeeb8bd8593@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43c8f77-a15f-ab1b-579c-feeeb8bd8593@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:52:12AM -0600, Jens Axboe wrote:
> On 7/17/22 10:58 PM, Al Viro wrote:
> > On Mon, Jul 18, 2022 at 12:59:32PM +1000, Stephen Rothwell wrote:
> >> Hi Al,
> >>
> >> On Fri, 15 Jul 2022 02:04:02 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
> >>>
> >>> On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:
> >>>
> >>>> Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
> >>>> one of the commits in it got changed since then - the difference in
> >>>> __bio_iov_iter_get_pages() (unsigned int i initialization).
> >>>>
> >>>> Sigh...  I'll rebase on top of that.  
> >>>
> >>> Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)
> >>
> >> BTW, these still cause a conflict.  As long as you are sharing patches
> >> (and then adding changes to the same areas), there will be conflicts.
> >> You need to share commits i.e. a shared branch.
> > 
> > Sigh...  That was (and is) a branch form Keith's tree.  Commits in block
> > tree are, AFAICS, cherry-picked from it, with lore links and Jens' s-o-b
> > added.
> > 
> > I'm fine with using that, just tell me how to refer to the branch in
> > question.  Jens?
> 
> Are you fine with rebasing that one again? Seems the better approach
> since it's all in one spot. The git location is:
> 
> git://git.kernel.dk/linux-block for-5.20/block-iter
> 
> which has all of them, and is the same base as the previous one. Do you
> want a signed tag, or is the branch fine?

Grabbed, rebased and force-pushed (identical tree object, so probably hadn't
fucked it up...)
