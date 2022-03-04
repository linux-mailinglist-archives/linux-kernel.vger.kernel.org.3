Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E964CD106
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiCDJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiCDJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:29:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B015C650
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E3AD61882
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98404C340E9;
        Fri,  4 Mar 2022 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386126;
        bh=3ZyGHoh6IanTsSvqHkAqFuBcwQnAyxkVM3EI89FxsvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J/veIj1vtbDybWYerGw3lXjK+ySuWAXxTr6gAZNl90zMlIWxoBGvmmyysLDTxUclj
         qjUCOsPaZB2tkCm5McrasfHjow1XEeGNe9PCGx2wwcODeJqQm/03N3pasadBU2N31i
         HhsIZ41i141/Eh8hDk5fCn6zelHz0bJCXHf6clQu+epx/E65joOgMhPY4BPzVg43zb
         PTS4hy2Y+aqXNCIonWxEGu66sVnvE9U+IlOIPUENkuv3dh0ZCDcbHv8nq21YcnSwPh
         /MoTmGt8/WSMyyK5Wu75F725f5nMq18insR+znYtTC1WNUKe+fWKUp+iwGtSBLitbF
         pOe6fvmurTPOQ==
Message-ID: <cac5624c-6338-b42a-346b-b6bfd86dda74@kernel.org>
Date:   Fri, 4 Mar 2022 17:28:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce F2FS_UNFAIR_RWSEM to
 support unfair rwsem
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     kernel test robot <oliver.sang@intel.com>
References: <20220304021955.2524246-1-jaegeuk@kernel.org>
 <20220304021955.2524246-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220304021955.2524246-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/4 10:19, Jaegeuk Kim wrote:
> Unfair rwsem should be used when blk-cg is on. Otherwise, there is regression.
> 
> FYI, we noticed a -26.7% regression of aim7.jobs-per-min due to commit:
> 
> commit: e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae ("f2fs: move f2fs to use reader-unfair rwsems")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: aim7
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
> with following parameters:
> 
> 	disk: 4BRD_12G
> 	md: RAID0
> 	fs: f2fs
> 	test: sync_disk_rw
> 	load: 100
> 	cpufreq_governor: performance
> 	ucode: 0x500320a
> 
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsourceforge.net%2Fprojects%2Faimbench%2Ffiles%2Faim-suite7%2F&amp;data=04%7C01%7Cchao.yu%40oppo.com%7C22ad61cc1e204e1d63e908d9fd858d65%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637819572336831789%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=SMV5sGpVhSvjC8sbrKpKGT27J35Bm1%2B3KoM4yeraceA%3D&amp;reserved=0
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
