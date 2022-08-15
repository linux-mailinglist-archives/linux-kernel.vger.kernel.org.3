Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DC592833
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiHODiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiHODiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7913EB4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19812B80CF2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB18C433D6;
        Mon, 15 Aug 2022 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660534683;
        bh=VsYtEaLrultUzMYq2W9FqRUKe3E7Yctk9vn8SCRVUCs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=EvOM/yGowHJ9MBWHDjna0JIomwNTVgijPeGdq6G3VY8JUttonvroTfsUwAvjQvCrw
         Fqb2/qo2zTVQ8zbM+J6iY2T2cqj2svwY62g0ZZp4yRHDjmgvjitEbd8nX7hmpTifOV
         DAUPbKubdiEl81nimPayRZ2jxXl0XCHpNEyK+7SasLXgZdTBPkrw0BNmIdNLnfG8JD
         qmdkI6y1/s0wnfvCGBMzfVxMMLbPXst5buOxtVy7knkYE/I8LAU4Z+a298DvTmir/n
         kakBEk/4l2qb4AFMFO3vo3GWk7NmLh2J50hDwgl2hhxONvlddVnj6DLFSpMN+HxgPp
         OLhGcU2nwM7Fw==
Message-ID: <f13d4881-820f-f6cd-4a70-c46ca3c5089f@kernel.org>
Date:   Mon, 15 Aug 2022 11:38:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: zoned device does not support ATGC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220811225454.2125297-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220811225454.2125297-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/12 6:54, Jaegeuk Kim wrote:
> ATGC is using SSR which violates zoned device. >
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/super.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2451623c05a7..212ec2b4926b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1298,6 +1298,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			F2FS_OPTION(sbi).discard_unit =
>   					DISCARD_UNIT_SECTION;
>   		}
> +		if (test_opt(sbi, ATGC)) {
> +			f2fs_err(sbi, "Zoned block device doesn't support ATGC.");
> +			return -EINVAL;
> +		}

ATGC is incompatible with LFS mode, we can check f2fs_lfs_mode() and ATGC
mountoption instead, as zoned device depends on LFS mode.

Thanks,

>   	}
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
