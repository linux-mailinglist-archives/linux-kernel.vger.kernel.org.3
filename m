Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A224CD0EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiCDJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiCDJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:20:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBBDE0AD6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5606184D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764FEC340E9;
        Fri,  4 Mar 2022 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646385607;
        bh=BgT01SavR8sDl65eqFTvI9Ru7MGrthbPR0fmy3vPemE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DOVv5kkvwhV8JpVukdBOCGyIWtRXHDKc+OENyWtAKDq4F3lrX4u8GQ/r50vgoYe0u
         yBFs9t+S95NGxe/SssdAi6u7e4JMwc2nqa48xSefxeRdNxXpiQrXcxbvFvue/0ElCC
         iVlilFQdVqQol0I9hzbsf3pmUl5tK3JMsD5z7X6XjbAtQ4QZnzgJ5uLO1fe6bA6MzP
         0pcZFOLEp3bfFHHuCU+nuSP7gMxcOpTZWE+wyltraswt5I2RvFeu6FKQ4EdmULg6Mc
         XROAke2QmhmZMlzdHG6e+7dHQ4jOxekVucwwUxFzffdFxVk1bpc3lhsHNweuZaRq9u
         gnR7fHKI/ltkQ==
Message-ID: <303313a4-f529-ce12-e512-082db535d0f5@kernel.org>
Date:   Fri, 4 Mar 2022 17:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid an infinite loop in
 f2fs_sync_dirty_inodes
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220304021955.2524246-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220304021955.2524246-1-jaegeuk@kernel.org>
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
> If one read IO is always failing, we can fall into an infinite loop in
> f2fs_sync_dirty_inodes. This happens during xfstests/generic/475.
> 
> [  142.803335] Buffer I/O error on dev dm-1, logical block 8388592, async page read
> ...
> [  382.887210]  submit_bio_noacct+0xdd/0x2a0
> [  382.887213]  submit_bio+0x80/0x110
> [  382.887223]  __submit_bio+0x4d/0x300 [f2fs]
> [  382.887282]  f2fs_submit_page_bio+0x125/0x200 [f2fs]
> [  382.887299]  __get_meta_page+0xc9/0x280 [f2fs]
> [  382.887315]  f2fs_get_meta_page+0x13/0x20 [f2fs]
> [  382.887331]  f2fs_get_node_info+0x317/0x3c0 [f2fs]
> [  382.887350]  f2fs_do_write_data_page+0x327/0x6f0 [f2fs]
> [  382.887367]  f2fs_write_single_data_page+0x5b7/0x960 [f2fs]
> [  382.887386]  f2fs_write_cache_pages+0x302/0x890 [f2fs]
> [  382.887405]  ? preempt_count_add+0x7a/0xc0
> [  382.887408]  f2fs_write_data_pages+0xfd/0x320 [f2fs]
> [  382.887425]  ? _raw_spin_unlock+0x1a/0x30
> [  382.887428]  do_writepages+0xd3/0x1d0
> [  382.887432]  filemap_fdatawrite_wbc+0x69/0x90
> [  382.887434]  filemap_fdatawrite+0x50/0x70
> [  382.887437]  f2fs_sync_dirty_inodes+0xa4/0x270 [f2fs]
> [  382.887453]  f2fs_write_checkpoint+0x189/0x1640 [f2fs]
> [  382.887469]  ? schedule_timeout+0x114/0x150
> [  382.887471]  ? ttwu_do_activate+0x6d/0xb0
> [  382.887473]  ? preempt_count_add+0x7a/0xc0
> [  382.887476]  kill_f2fs_super+0xca/0x100 [f2fs]
> [  382.887491]  deactivate_locked_super+0x35/0xa0
> [  382.887494]  deactivate_super+0x40/0x50
> [  382.887497]  cleanup_mnt+0x139/0x190
> [  382.887499]  __cleanup_mnt+0x12/0x20
> [  382.887501]  task_work_run+0x64/0xa0
> [  382.887505]  exit_to_user_mode_prepare+0x1b7/0x1c0
> [  382.887508]  syscall_exit_to_user_mode+0x27/0x50
> [  382.887510]  do_syscall_64+0x48/0xc0
> [  382.887513]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
