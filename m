Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725175033AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiDPCcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiDPCcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:32:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F87556742
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FC12B831D5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 02:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232A0C385A7;
        Sat, 16 Apr 2022 02:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650076182;
        bh=uUd/Mmr+LuhyFMq1LsPUx9KBDlPY2jN3/XYmm96PzHc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kKdejRF7VlO3kQkyjktX96UX47hHrzVNgIL/LXmp3ngoBfXC3HxgotFjJNnHqgmlZ
         k3nLSsdniN2ACPKyFWFUKOwE24IU3fKN8aM/W06LHPWiMY1lmCIECJgskTqB9RwUOU
         j//fH5jUbQGTnfJpGJUw7mmdKJdgcFHKIOAkojp0ZupHywV23GEAOqbtG5bgxy7TQk
         AKgTXrcmaVPaTnXflmZnPtOjisMy4eYqdTfAgpE3TZKrqN7A+LK2QE6U/K9MXGAjUP
         j0chy/yNhQAMH/evjg4zu2KapVcm/MeNXTMPyexv4vOsAq3z8xRKIhAlXp6aooZlFB
         D5L5L9pmdOyLQ==
Message-ID: <ec26e65f-5e5d-3c99-d631-148717333cf5@kernel.org>
Date:   Sat, 16 Apr 2022 10:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220415131902.55028-1-dzm91@hust.edu.cn>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220415131902.55028-1-dzm91@hust.edu.cn>
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



On 2022/4/15 21:19, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzbot triggers two WARNs in f2fs_is_valid_blkaddr and
> __is_bitmap_valid. For example, in f2fs_is_valid_blkaddr,
> if type is DATA_GENERIC_ENHANCE or DATA_GENERIC_ENHANCE_READ,
> it invokes WARN_ON if blkaddr is not in the right range.
> The call trace is as follows:
> 
>   f2fs_get_node_info+0x45f/0x1070
>   read_node_page+0x577/0x1190
>   __get_node_page.part.0+0x9e/0x10e0
>   __get_node_page
>   f2fs_get_node_page+0x109/0x180
>   do_read_inode
>   f2fs_iget+0x2a5/0x58b0
>   f2fs_fill_super+0x3b39/0x7ca0
> 
> Fix these two WARNs by replacing WARN_ON with dump_stack.
> 
> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
