Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5305D530321
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbiEVMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiEVMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 08:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E53584A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 05:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9976360FB7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1534CC385AA;
        Sun, 22 May 2022 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653223439;
        bh=DEteYEjM+AM/wXkRopNu1+2DJQAvofJ3C+iGOSkSiPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aHQE+A/MzK8H3SZ55YRN+/j56oazYVYQ9CsJl4y5fwEWnyK/Mijf4P0TQydnVpQTW
         dHM6eZx5jem8IvprgD7NqgxO7DjguXTtSlODsjo8H2B9v/8FQjojehfc/XAMeZM8bL
         ur1UaNIQs+WL1Pu3JhBL3yoydHFApgCNfj66Sbtz9vdJ8gzoqFOs+SmpR2SMNCrMue
         lZqyuGuBssNW3FLeP/nJ2nzczX0+mGiihmn/KXi8J22SPPSPFJodYDl/hYrOwYCjSZ
         H6yELqghWGGdFqkfNOI+CbFPtmCZiNqY5l/8g1s+45D9DQuVUJxKw700UcYjtHvIE2
         yr6ayKVyAJbdQ==
Message-ID: <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
Date:   Sun, 22 May 2022 20:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220428181809.2352352-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220428181809.2352352-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 2:18, Daeho Jeong wrote:> +		*old_addr = dn.data_blkaddr;
> +		f2fs_truncate_data_blocks_range(&dn, 1);
> +		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
> +		inc_valid_block_count(sbi, inode, &count);
> +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
> +					ni.version, true, false);

My concern is, if cow_inode's data was persisted into previous checkpoint,
and then f2fs_replace_block() will update SSA from cow_inode to inode?
it will cause inconsistent status of last valid checkpoint? Or am I mssing
something?

> -		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
> +			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
> +							true, NULL);
> +			if (!new) {
> +				f2fs_put_dnode(&dn);
> +				ret = -ENOMEM;
> +				goto out;

It doesn't need to handle failure of f2fs_kmem_cache_alloc()
due to nofail parameter is true.

Thanks,
