Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90588521E12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbiEJPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbiEJPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:22:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F234642;
        Tue, 10 May 2022 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zomQ09MasjYYPBWxQCtJv93X39Y9KJpEdOg9RwSYDXo=; b=OXoO3ZXIsd+8Ur5z4w2Pe9mL9y
        kzudrLhCkjg0gpejSNFjq1vrobSB32LNCkDO8x6X1nmJORQwFkbzB5FiTYnRsYHbZbAtfhzSzJA9f
        6ss8u2WraOGDeod93K8QHNDOoeS2e5ilpD+fbWLDxpktuAkZgAt+P2Z99cjvW4w6xmw+uXfcHfCIW
        D37c0E0hE46wgZ5HI1IDYq5Z548fAUknoa9H5WNLc+eE2JPQqiHuO9CSrC/vZUhoao8wgdTeX368G
        /b1FnO809d2VeEqy2nDWtAWAQcvDlzx1p67r8Q+JVCLZx/H7qEuVltTiZKUpPWjiCOm0WoF/Re3LF
        KiEV25Yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noRPw-004YZz-TA; Tue, 10 May 2022 15:04:53 +0000
Date:   Tue, 10 May 2022 16:04:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the btrfs tree
Message-ID: <Ynp/FDvASFnsVf13@casper.infradead.org>
References: <20220510183908.7571cb73@canb.auug.org.au>
 <55f4b515-1d1c-fd3e-0f93-4cda45261c91@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f4b515-1d1c-fd3e-0f93-4cda45261c91@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:43:07AM +0100, Filipe Manana wrote:
> On 10/05/22 09:39, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the folio tree got a conflict in:
> > 
> >   fs/btrfs/send.c
> > 
> > between commit:
> > 
> >   d1a1a97304b4 ("btrfs: send: keep the current inode open while processing it")
> > 
> > from the btrfs tree and commit:
> > 
> >   2ebdd1df3166 ("mm/readahead: Convert page_cache_async_readahead to take a folio")
> > 
> > from the folio tree.
> > 
> > I fixed it up (I think - see below) and can carry the fix as
> 
> Looks correct to me.

Me too.  The patch this one enables is rather sad.  It's yet another
reminder that we suck at streaming workloads.  But until we fix that,
don't you want to use invalidate_inode_pages2_range() rather than
truncate_inode_pages_range()?  If your send conflicts with someone
else's write(), you'll erase their write to the page cache.
