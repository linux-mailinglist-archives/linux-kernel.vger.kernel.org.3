Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD84E800D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiCZIm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCZImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:42:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE495A16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 01:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 570DBB80159
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B5C2BBE4;
        Sat, 26 Mar 2022 08:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648284076;
        bh=MzvQcR96gyo7RqQQpE892/lFN19x54FxFHC5aLVYzKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rXVumBjYyJgGoDJQvG0zZZrIvOjRYcNSmF9H+qWFcfBXO6sc0IFlQKcEXJczfuhoH
         1Zp/RMudRTfydYWOjbLhkv27ZlBT2GU6glq06x7b1SGqZwxb1gApbpNaYEIZJlcdJV
         slSm3qQlpjDuC8UkzC7yBlA/QmaN87YCZQswSWnkm9hwekKL4z3CH/H3JIbjVTVz7t
         tvvJfMXgCSzS6G+NVRn8ySnBT/hSw6tyfDtOcBY+7XjkqZ55K9hdZNaWDZXu5bmtBG
         /vP+FuQD/cYo9HgLFnEfY3WoFyZB8DpJaH8gVrgbd6YBXXa26Izs4E9a8fVpLiOoRx
         4J613z2NQZk3g==
Message-ID: <c1101316-fd59-812c-aa4a-a0fa2d2004eb@kernel.org>
Date:   Sat, 26 Mar 2022 16:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary f2fs_lock_op in
 f2fs_new_inode
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
References: <20220325181850.513023-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220325181850.513023-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/26 2:18, Jaegeuk Kim wrote:
> This can be removed, since f2fs_alloc_nid() actually doesn't require to block
> checkpoint and __f2fs_build_free_nids() is covered by nm_i->nat_tree_lock.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks fine, but still it needs more test to check stability w/ the patch. ;)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
