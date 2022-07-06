Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B175568B18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGFOVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGFOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6616586
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E113B81D0A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85DBC3411C;
        Wed,  6 Jul 2022 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657117270;
        bh=BBqleXYQ4a7+Wf4AHDy7c+4UEGJSou8ATB/bmunX1rA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UF6BlsoxCRU5TKLF4xnkYYWEKLfFj3c2cds3rlDoddcl8smCvLtUkRvYSGRL8jlO3
         dnPFuYXv1gsW9f+1MEv5ePP2rGOv1fxpkuLCANbWReBFTJa8mAX2fihls9IZ+ROBD5
         9NZCVuPMttGwlgEnTv9XPK5bK54RbZltrMCkGiAU1Jw8sTEspPH0uC0va7NQjQA48V
         bUI8TOz3Bhg0tJXyf1X1IZdHCHCSEuQ+rv8vHzM25Upd5EYCPfIqi/PhFNeooyNlEH
         PuHFP98BfSFNv6oaAl7/9s0iVHALb3onJ5V06yrcityGJQ5wBc5eynWMo7jQmYvCxa
         0FTdgcqZv8eLw==
Message-ID: <089b4584-2142-c761-27ca-bfb4d75e0f36@kernel.org>
Date:   Wed, 6 Jul 2022 22:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL
 at the same time
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Xiaoyu Qi <qxy65535@gmail.com>, Chao Liu <liuchao@coolpad.com>
References: <20220621064833.1079383-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220621064833.1079383-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 14:48, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> If the inode has the compress flag, it will fail to use
> 'chattr -c +m' to remove its compress flag and tag no compress flag.
> However, the same command will be successful when executed again,
> as shown below:
> 
>    $ touch foo.txt
>    $ chattr +c foo.txt
>    $ chattr -c +m foo.txt
>    chattr: Invalid argument while setting flags on foo.txt
>    $ chattr -c +m foo.txt
>    $ f2fs_io getflags foo.txt
>    get a flag on foo.txt ret=0, flags=nocompression,inline_data
> 
> Fix this by removing some checks in f2fs_setflags_common()
> that do not affect the original logic. I go through all the
> possible scenarios, and the results are as follows. Bold is
> the only thing that has changed.
> 
> +---------------+-----------+-----------+----------+
> |               |            file flags            |
> + command       +-----------+-----------+----------+
> |               | no flag   | compr     | nocompr  |
> +---------------+-----------+-----------+----------+
> | chattr +c     | compr     | compr     | -EINVAL  |
> | chattr -c     | no flag   | no flag   | nocompr  |
> | chattr +m     | nocompr   | -EINVAL   | nocompr  |
> | chattr -m     | no flag   | compr     | no flag  |
> | chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
> | chattr +c -m  | compr     | compr     | compr    |
> | chattr -c +m  | nocompr   | *nocompr* | nocompr  |
> | chattr -c -m  | no flag   | no flag   | no flag  |
> +---------------+-----------+-----------+----------+
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
