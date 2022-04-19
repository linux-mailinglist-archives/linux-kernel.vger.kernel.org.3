Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B836B507CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbiDSWul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDSWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:50:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8ED27CF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6941CE1B13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07842C385A7;
        Tue, 19 Apr 2022 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408473;
        bh=dPPIfXbZmC5wjSWim42Hh9CV6QDmZuiHOOhATFqi7iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHu9LbfiE7riITqbGfeNYlSsHrfTenqTgAHnD3GDcRA+HNIswG89wNc2yNcW2Dazk
         P6sQ4sBTupkxO/Grto42/r5M2DL4CV8CIWthm1KD8gqHgqaT26Eb6R7ecjlGzARJVO
         9WAYKmU64t5CMIc1Yg+tN6FRDrTvM2Xe8srM4f5wliRq2Zbph+AwP/ij6rZyFCvj3M
         0m31D2I7bJOV+oFxA53LmiAWFJp/buyuRroJd2+XFhKw521dIF5UxQV2B9yZ0cp9Tv
         V/85kznCiJSaOvBgDuwgGhloYoknOOBPB0f2ems+gKUMeY03+aOtHcnumAgAA8J2UI
         o7TYi9Sm5Kg1Q==
Date:   Tue, 19 Apr 2022 15:47:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: keep io_flags to avoid IO split due
 to different op_flags in two fio holders
Message-ID: <Yl88F3RVRMfwyB7+@google.com>
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
 <20220413154920.2024872-2-jaegeuk@kernel.org>
 <d22c42f8-525a-a0a6-2fef-a43b2fc3a2c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22c42f8-525a-a0a6-2fef-a43b2fc3a2c7@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17, Chao Yu wrote:
> On 2022/4/13 23:49, Jaegeuk Kim wrote:
> > Let's attach io_flags to bio only, so that we can merge IOs given original
> > io_flags only.
> > 
> > Fixes: 64bf0eef0171 ("f2fs: pass the bio operation to bio_alloc_bioset")
> 
> Nice catch.
> 
> Wasn't this bug introduced by:

I don't think so.

> 
> commit da9953b729c1 ("f2fs: introduce sysfs/data_io_flag to attach REQ_META/FUA")
> 
> static void __attach_data_io_flag(struct f2fs_io_info *fio)
> {
> ...
>        if ((1 << fio->temp) & meta_flag)
>                fio->op_flags |= REQ_META;
>        if ((1 << fio->temp) & fua_flag)
>                fio->op_flags |= REQ_FUA;
> ...
> 
> Thanks,
> 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/data.c | 33 +++++++++++++++++++++------------
> >   1 file changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index acc523f893ba..fcf0daa386de 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -387,11 +387,23 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
> >   	return 0;
> >   }
> > -static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
> > +static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
> >   {
> >   	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
> > -	unsigned int fua_flag = io_flag & temp_mask;
> > -	unsigned int meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
> > +	unsigned int fua_flag, meta_flag, io_flag;
> > +	unsigned int op_flags = 0;
> > +
> > +	if (fio->op != REQ_OP_WRITE)
> > +		return 0;
> > +	if (fio->type == DATA)
> > +		io_flag = fio->sbi->data_io_flag;
> > +	else if (fio->type == NODE)
> > +		io_flag = fio->sbi->node_io_flag;
> > +	else
> > +		return 0;
> > +
> > +	fua_flag = io_flag & temp_mask;
> > +	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
> >   	/*
> >   	 * data/node io flag bits per temp:
> > @@ -400,9 +412,10 @@ static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
> >   	 * Cold | Warm | Hot | Cold | Warm | Hot |
> >   	 */
> >   	if ((1 << fio->temp) & meta_flag)
> > -		fio->op_flags |= REQ_META;
> > +		op_flags |= REQ_META;
> >   	if ((1 << fio->temp) & fua_flag)
> > -		fio->op_flags |= REQ_FUA;
> > +		op_flags |= REQ_FUA;
> > +	return op_flags;
> >   }
> >   static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
> > @@ -412,14 +425,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
> >   	sector_t sector;
> >   	struct bio *bio;
> > -	if (fio->type == DATA)
> > -		__attach_io_flag(fio, sbi->data_io_flag);
> > -	else if (fio->type == NODE)
> > -		__attach_io_flag(fio, sbi->node_io_flag);
> > -
> >   	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
> > -	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags, GFP_NOIO,
> > -			       &f2fs_bioset);
> > +	bio = bio_alloc_bioset(bdev, npages,
> > +				fio->op | fio->op_flags | f2fs_io_flags(fio),
> > +				GFP_NOIO, &f2fs_bioset);
> >   	bio->bi_iter.bi_sector = sector;
> >   	if (is_read_io(fio->op)) {
> >   		bio->bi_end_io = f2fs_read_end_io;
