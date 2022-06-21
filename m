Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157B55296C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbiFUCgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbiFUCgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:36:40 -0400
Received: from p3plwbeout15-03.prod.phx3.secureserver.net (p3plsmtp15-03-2.prod.phx3.secureserver.net [173.201.193.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70B1580C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:36:36 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id 3Tkoojc5Ig7Zl3TkpoLUgb; Mon, 20 Jun 2022 19:36:35 -0700
X-CMAE-Analysis: v=2.4 cv=a//1SWeF c=1 sm=1 tr=0 ts=62b12eb3
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=NTb5vJx-PtTLRpkcHBgA:9
 a=6RyHdP9wf0s6W1bbVaoE2bQoMl4=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  3Tkoojc5Ig7Zl
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp03.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1o3Tko-0002Om-4h; Tue, 21 Jun 2022 03:36:34 +0100
Message-ID: <d6e27dae-0fba-cabf-465b-b2d1c258752b@squashfs.org.uk>
Date:   Tue, 21 Jun 2022 03:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 0/4] Implement readahead for squashfs
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220617083810.337573-1-hsinyi@chromium.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220617083810.337573-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfIFYN3kADVjENKES00lDTs3NJ0pXybwYCAquBLhJgCuPOVHs/Nj2IoACJqrV6fZD05wExQFTy1ReIiqPHmGU0A4rOCAJmaF32TgEupCZj04Zxed9iHU9
 g6SiLqyNMHOhv1dXJ+gwyWjJj1rN8yKvWLhFa6X2hSwLFxLJK5blDB1QvWtsSHjcXtt8d1ZF9iVkxEf4G14OVi4/ibpDs1LkfuE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 09:38, Hsin-Yi Wang wrote:
> Commit 9eec1d897139("squashfs: provide backing_dev_info in order to
> disable read-ahead") mitigates the performance drop issue for squashfs
> by closing readahead for it.
> 
> This series implements readahead callback for squashfs. The previous
> discussions are in [1] and [2].

Patch series looks OK to me.

I will be offline at the Glastonbury festival from Tuesday 21 June to
Monday 27 June.

Thanks

Phillip

> 
> [1]
> https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/
> [2]
> https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m4af4473b94f98a4996cb11756b633a07e5e059d1
> 
> v7 adds the patch to support reading fragments in readahead call[3]. No
> changes on other patches since v6, which is included in next-20220617.
> 
> [3]
> https://patchwork.kernel.org/project/linux-mm/patch/20220617030345.24712-1-phillip@squashfs.org.uk/
> 
> Hsin-Yi Wang (2):
>    Revert "squashfs: provide backing_dev_info in order to disable
>      read-ahead"
>    squashfs: implement readahead
> 
> Phillip Lougher (2):
>    squashfs: always build "file direct" version of page actor
>    squashfs: support reading fragments in readahead call
> 
>   fs/squashfs/Makefile     |   4 +-
>   fs/squashfs/file.c       | 133 ++++++++++++++++++++++++++++++++++++++-
>   fs/squashfs/page_actor.h |  46 --------------
>   fs/squashfs/super.c      |  33 ----------
>   4 files changed, 134 insertions(+), 82 deletions(-)
> 

