Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E853233F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiEXG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiEXG3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D772E3D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A021F614FA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 06:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5513EC385AA;
        Tue, 24 May 2022 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653373794;
        bh=pvaK40OKCL4qKe8jz4FmcrdheHkRl9UGB66B2uyK7bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b5xeMrfLHjrebDw3mwc5bitrk2GZSMknsjZQqgWSVpId8mYP6sSDGprH20ApTTXrJ
         MaveXMlqu1bzFj/ZKK3ZVo+OcziD6ujfg77tDDuPCYqOa4ToIYEsaGlzzfU0irRcEb
         zKA3fbEPuf6xuypqO9xMpUZfmBLCxqyoF98bt/yG5vOqPcbReuPXvVz+czZDnwBb1A
         FQA2lPrz5p7TQAq3AJdxaEDsLf8H+iUaEWNYQKrfCBNTAA70AhRSBn1tLw+QR82447
         4J115HbswUNBfH68N+GCHkvehmZR9JzL+b6axctW/W13k51nwVZ1famSk+hRITUHq2
         hwQz9nYeyE3Dg==
Message-ID: <227d10d5-2afe-acfa-7cfc-3a2f45331c6f@kernel.org>
Date:   Tue, 24 May 2022 14:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20220428181809.2352352-1-daeho43@gmail.com>
 <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
 <YovMeQO2n0XAxMhe@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YovMeQO2n0XAxMhe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 2:03, Jaegeuk Kim wrote:
> On 05/22, Chao Yu wrote:
>> On 2022/4/29 2:18, Daeho Jeong wrote:> +		*old_addr = dn.data_blkaddr;
>>> +		f2fs_truncate_data_blocks_range(&dn, 1);
>>> +		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
>>> +		inc_valid_block_count(sbi, inode, &count);
>>> +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
>>> +					ni.version, true, false);
>>
>> My concern is, if cow_inode's data was persisted into previous checkpoint,
>> and then f2fs_replace_block() will update SSA from cow_inode to inode?
> 
> SSA for original file is intact, so we'll see the orignal file's block addresses
> and SSA, if we flush cow_inode's SSA after committing the atomic writes?
> It'd be good to flush any SSA for cow_inode, since we'll truncate
> cow_inode after powercut by the ohphan recovery?

I think it's safe for recovery flow, but before that, fsck will report inconsistent
status during checking orphan atomic_write inode.

Thanks,

> 
>> it will cause inconsistent status of last valid checkpoint? Or am I mssing
>> something?
>>
>>> -		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
>>> +			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
>>> +							true, NULL);
>>> +			if (!new) {
>>> +				f2fs_put_dnode(&dn);
>>> +				ret = -ENOMEM;
>>> +				goto out;
>>
>> It doesn't need to handle failure of f2fs_kmem_cache_alloc()
>> due to nofail parameter is true.
>>
>> Thanks,
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
