Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A57561C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiF3N7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiF3N5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BA3B294
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C26AB82AED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4E0C341CB;
        Thu, 30 Jun 2022 13:50:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OtweVgIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656597043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13SHuqpSu+R+MVUze8sTlmBDblqHyuwi7syy964nsTM=;
        b=OtweVgIl+CVlL+n/AsPRQrFEgVWJhuPArt4HdYBW3W2n7IpAPAzXpeRpca9vdDRUfvI98l
        qNEmmiRtDZEzIwpJFfxweK3CmeCMsrrDH6mZpsFG70tyMTbGIxApKFI2t5iQm5JgXg6B7N
        O7Oe4fk0wqQJ4ijWwBvDvNgeYk5GDkc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 146c7382 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Jun 2022 13:50:43 +0000 (UTC)
Date:   Thu, 30 Jun 2022 15:50:41 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 5/7] fs: remove no_llseek
Message-ID: <Yr2qMekERjBU58DZ@zx2c4.com>
References: <20220629130702.954310-1-Jason@zx2c4.com>
 <20220629130702.954310-6-Jason@zx2c4.com>
 <feb7d93c-76bc-a7fc-0714-ed71495a16b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb7d93c-76bc-a7fc-0714-ed71495a16b9@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolay,

On Thu, Jun 30, 2022 at 09:45:04AM +0300, Nikolay Borisov wrote:
> 
> 
> On 29.06.22 г. 16:07 ч., Jason A. Donenfeld wrote:
> > Now that all callers of ->llseek are going through vfs_llseek(), we
> > don't gain anything by keeping no_llseek around. Nothing compares it or
> > calls it.
> > 
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >   fs/read_write.c    | 17 +++--------------
> >   include/linux/fs.h |  1 -
> >   2 files changed, 3 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index b1b1cdfee9d3..69cd8d72d91e 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -227,12 +227,6 @@ loff_t noop_llseek(struct file *file, loff_t offset, int whence)
> >   }
> >   EXPORT_SYMBOL(noop_llseek);
> >   
> > -loff_t no_llseek(struct file *file, loff_t offset, int whence)
> > -{
> > -	return -ESPIPE;
> > -}
> > -EXPORT_SYMBOL(no_llseek);
> > -
> >   loff_t default_llseek(struct file *file, loff_t offset, int whence)
> >   {
> >   	struct inode *inode = file_inode(file);
> > @@ -290,14 +284,9 @@ EXPORT_SYMBOL(default_llseek);
> >   
> >   loff_t vfs_llseek(struct file *file, loff_t offset, int whence)
> >   {
> > -	loff_t (*fn)(struct file *, loff_t, int);
> > -
> > -	fn = no_llseek;
> > -	if (file->f_mode & FMODE_LSEEK) {
> > -		if (file->f_op->llseek)
> > -			fn = file->f_op->llseek;
> > -	}
> > -	return fn(file, offset, whence);
> > +	if (!(file->f_mode & FMODE_LSEEK) || !file->f_op->llseek)
> 
> Is it not sufficient here to just check for the presence of FMODE_LSEEK? 
> NULL  llseek shall result in FMODE_LSEEK not being set when the file is 
> opened?

Yes, that's probably fine. I did this out of an abundance of caution,
but I have a feeling Al might agree with you that useless is useless. I
can send a v4 changing that.

Al, what do you think?

Jason
