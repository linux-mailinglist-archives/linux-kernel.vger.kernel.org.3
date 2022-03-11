Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5114D5C43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiCKH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiCKH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:26:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CB1B6E1A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:25:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A987B82AD2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5C8C340E9;
        Fri, 11 Mar 2022 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646983529;
        bh=g84WdhT8WlUiVZ4Pe91HKYziG64yo/SO8s//Xpd2fk0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=RYbR6QstwFDm4TM9v8bCHTbEje2eF314IM+w4i62zCcjy5CbFYtxmMOKpJl1xESrz
         1BCXHnRkodtI0iUZHM1Id/Byrwtcth5mck8sVVve34jt7pFw08XUoAwxdlRGG/xbZs
         bGgog83ItM1AGidvcly4RQhLWGsbx5S5WBDhGI8gTjLDYk4BnFir5Tq35/MNVNkeCB
         MZKdaibOGRjUtHJ23sJKNEOyFufuv+omYan+GeYH1vI8J+HpgUmVsHy3lwtcYSGyly
         XlKLxpYMmGv0fIXnXZ6OMuI4YvbBOwMIkd3EwnqMZLMsMZ1cY1GJ0qdxBsBliotM5X
         x1JAFcmvQVRsg==
Message-ID: <86d59c1d-b453-5ee2-4737-b4dd03829965@kernel.org>
Date:   Fri, 11 Mar 2022 15:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: don't get FREEZE lock in
 f2fs_evict_inode in frozen fs
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220309214834.3408741-1-jaegeuk@kernel.org>
 <Yircgd9d773xnk3+@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Yircgd9d773xnk3+@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/11 13:22, Jaegeuk Kim wrote:
> Let's purge inode cache in order to avoid the below deadlock.
> 
> [freeze test]                         shrinkder
> freeze_super
>   - pwercpu_down_write(SB_FREEZE_FS)
>                                         - super_cache_scan
>                                           - down_read(&sb->s_umount)
>                                             - prune_icache_sb
>                                              - dispose_list
>                                               - evict
>                                                - f2fs_evict_inode
> thaw_super
>   - down_write(&sb->s_umount);
>                                                - __percpu_down_read(SB_FREEZE_FS)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
