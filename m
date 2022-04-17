Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07F35046E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiDQG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiDQG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:58:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71731C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FB3FB808C5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE0C385A7;
        Sun, 17 Apr 2022 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650178522;
        bh=8OuAouHw/QXVOEC4ptQed+yz6u6Ut5mUHhE6SJFh6ME=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CNw02Yw7xd3rCVoVWcZYKH1ld6uXC38hTSdp3ODqDTFqvvXgleMSk+/7UVnJyRuyz
         LYVj0Fwtas/6SEse7UgpwwGovvj7Xs4BlntKOlcKVpblmoN1GT4AvR32XtEFLixlby
         Z3sCg5Tdp4SVAF64taNtnTfaCdDlLeHA9j8gBTOEghcygle3aaV+UYgBjzzbAszcxi
         epYhiY1Bd8MIwBsp0WN3ujP1s4FUnHKhQMFDeSri8+g1frJBCnLwjOy0WjUoP8DDhD
         g6PVEzwpjnV36awfgB3X2SSIvJxMbc3v0BJEM7ODhglkwtVT+mxv2kICA8ASjm2r2o
         RTmJtOfCoH8sA==
Message-ID: <d22c42f8-525a-a0a6-2fef-a43b2fc3a2c7@kernel.org>
Date:   Sun, 17 Apr 2022 14:55:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: keep io_flags to avoid IO split due
 to different op_flags in two fio holders
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
 <20220413154920.2024872-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220413154920.2024872-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/13 23:49, Jaegeuk Kim wrote:
> Let's attach io_flags to bio only, so that we can merge IOs given original
> io_flags only.
> 
> Fixes: 64bf0eef0171 ("f2fs: pass the bio operation to bio_alloc_bioset")

Nice catch.

Wasn't this bug introduced by:

commit da9953b729c1 ("f2fs: introduce sysfs/data_io_flag to attach REQ_META/FUA")

static void __attach_data_io_flag(struct f2fs_io_info *fio)
{
...
        if ((1 << fio->temp) & meta_flag)
                fio->op_flags |= REQ_META;
        if ((1 << fio->temp) & fua_flag)
                fio->op_flags |= REQ_FUA;
...

Thanks,

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/data.c | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index acc523f893ba..fcf0daa386de 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -387,11 +387,23 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
>   	return 0;
>   }
>   
> -static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
> +static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
>   {
>   	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
> -	unsigned int fua_flag = io_flag & temp_mask;
> -	unsigned int meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
> +	unsigned int fua_flag, meta_flag, io_flag;
> +	unsigned int op_flags = 0;
> +
> +	if (fio->op != REQ_OP_WRITE)
> +		return 0;
> +	if (fio->type == DATA)
> +		io_flag = fio->sbi->data_io_flag;
> +	else if (fio->type == NODE)
> +		io_flag = fio->sbi->node_io_flag;
> +	else
> +		return 0;
> +
> +	fua_flag = io_flag & temp_mask;
> +	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
>   
>   	/*
>   	 * data/node io flag bits per temp:
> @@ -400,9 +412,10 @@ static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
>   	 * Cold | Warm | Hot | Cold | Warm | Hot |
>   	 */
>   	if ((1 << fio->temp) & meta_flag)
> -		fio->op_flags |= REQ_META;
> +		op_flags |= REQ_META;
>   	if ((1 << fio->temp) & fua_flag)
> -		fio->op_flags |= REQ_FUA;
> +		op_flags |= REQ_FUA;
> +	return op_flags;
>   }
>   
>   static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
> @@ -412,14 +425,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	sector_t sector;
>   	struct bio *bio;
>   
> -	if (fio->type == DATA)
> -		__attach_io_flag(fio, sbi->data_io_flag);
> -	else if (fio->type == NODE)
> -		__attach_io_flag(fio, sbi->node_io_flag);
> -
>   	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
> -	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags, GFP_NOIO,
> -			       &f2fs_bioset);
> +	bio = bio_alloc_bioset(bdev, npages,
> +				fio->op | fio->op_flags | f2fs_io_flags(fio),
> +				GFP_NOIO, &f2fs_bioset);
>   	bio->bi_iter.bi_sector = sector;
>   	if (is_read_io(fio->op)) {
>   		bio->bi_end_io = f2fs_read_end_io;
