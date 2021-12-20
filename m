Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3547B5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhLTWQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhLTWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:16:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8B33B810DE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 22:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C5C36AE8;
        Mon, 20 Dec 2021 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640038559;
        bh=NvzUcorftFDufwHxLvjFkT88ytvP40DRNvsxQGK0hDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDvwWGj7xIm+MlE+mJUD8BLRJ892Qtci8NA9RJzVB0qJfp1X3UM7+s58oQRTzQzJL
         L4QdwcIf89g2oxC0IS2TUXxSwMMo4MyIgzkxC7rfAbdVvUuCOWr77XXGxJbTHyOKoY
         4Nf+5hcknmKjVuAlfZ2lulQWRfMuDwSfdhq2jU1qoBknk4xtQIIkVM0C/RTbtP6KF7
         zcP9Dyo+7muAvRJZF1mnWjpBgQ9L/ojW0ImJjpxFJCnKPl0vU0X/EyY63CuFFInHrw
         IczNATA148HCROdsK/7Om597mgNx7va5rTp5wci8fvgZTx7Aqrs23CRguMOWV/dVsR
         ZP3M3TRbhDRrA==
Date:   Mon, 20 Dec 2021 14:15:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
Message-ID: <YcEAnX2+ARaGXrtx@google.com>
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
 <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Chao Yu wrote:
> On 2021/12/15 2:24, Jaegeuk Kim wrote:
> > Let's cache nat entry if there's no lock contention only.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/node.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 556fcd8457f3..b1bc7d76da3b 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
> >   	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >   	struct nat_entry *new, *e;
> > +	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
> > +	if (rwsem_is_locked(&sbi->cp_global_sem))
> 
> Why not down_write_trylock(nat_tree_lock)? cp_global_sem lock coverage is larger than
> nat_tree_lock's in f2fs_write_checkpoint().

I'm focusing on faster checkpoint by minimizing the nat_tree_lock holding time.

> 
> Thanks,
> 
> > +		return;
> > +
> >   	new = __alloc_nat_entry(sbi, nid, false);
> >   	if (!new)
> >   		return;
