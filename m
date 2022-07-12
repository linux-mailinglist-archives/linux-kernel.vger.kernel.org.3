Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDA5710BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiGLDUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGLDUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:20:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C622FFCF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04287B81648
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B198DC34115;
        Tue, 12 Jul 2022 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657596026;
        bh=A94ul8mweh+4BJqDHv4Og+e7RYGSYz/Z21kD0JyUEWw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nNmF6prIjjCZkD+2RNfpv8Yve7XSQpXtIIZSBU1U7YIfd0bS7Fz8ePIKCDYZ7Cjv+
         IJapziuZ6Ensnhb1o0QfsVie+XhXgFx1bOzaz0oHt3Kz68rl9PKEydYp9MSh9UmGQL
         j4Q939pbwRPP0V59MjH5xlrl8kBmQHeHjg6CMKSniqeYTT7Q9FL9fQsXa0yjndBpLo
         7Lm7xMDO+o+qipcj1lO28+PvLdHmTALBG2TzXHa2DHUWAQJ508uhmhSTqqmvl1WARl
         6vqaUfoJhikZaC7YXR5O2raNrw8eEIGKNV6jKSv9qmw5W5mHWD3L9xqCctSBEQbBj8
         vv5ag2UHBPp/w==
Message-ID: <3ee4ce0d-2f50-ca7d-14a9-2368b9db7d13@kernel.org>
Date:   Tue, 12 Jul 2022 11:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] f2fs: allow compression of files without blocks
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Liu <chaoliu719@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220707090924.4183376-1-chaoliu719@gmail.com>
 <YszQD8Pk3YTvPgpn@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YszQD8Pk3YTvPgpn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/12 9:36, Jaegeuk Kim wrote:
> On 07/07, Chao Liu wrote:
>> From: Chao Liu <liuchao@coolpad.com>
>>
>> Files created by truncate(1) have a size but no blocks, so
>> they can be allowed to enable compression.
>>
>> Signed-off-by: Chao Liu <liuchao@coolpad.com>
>> ---
>> v2:
>>   - update commit message: truncate -> truncate(1)
>>
>>   fs/f2fs/file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 0f29af7876a6..f7a82858486a 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   		if (iflags & F2FS_COMPR_FL) {
>>   			if (!f2fs_may_compress(inode))
>>   				return -EINVAL;
>> -			if (S_ISREG(inode->i_mode) && inode->i_size)
>> +			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> 
> What about inline_data case?

How about fixing this w/ a separated patch?

f2fs: fix to check inline_data during compressed inode conversion

Thanks,

> 
>>   				return -EINVAL;
>>
>>   			set_compress_context(inode);
>> --
>> 2.36.1
