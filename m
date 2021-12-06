Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B746904D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhLFGGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:06:46 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60886 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235803AbhLFGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:06:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UzX-aeR_1638770593;
Received: from 30.225.24.27(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UzX-aeR_1638770593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 14:03:14 +0800
Message-ID: <1e9cb07e-aef7-1461-25c4-1e9cfbe41c12@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 14:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] ocfs2: fix uninitialized variable in
 ocfs2_dio_wr_get_block()
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>, ryan.ding@oracle.com,
        Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Sunil Mushran <sunil.mushran@oracle.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Mark Fasheh <mark@fasheh.com>
References: <20211130104043.GB5827@kili>
 <92d4d393-9734-9f7e-4440-20429bdac14f@linux.alibaba.com>
In-Reply-To: <92d4d393-9734-9f7e-4440-20429bdac14f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/21 10:24 AM, Joseph Qi wrote:
> 
> 
> On 11/30/21 6:40 PM, Dan Carpenter wrote:
>> The callers assume that "*fsdata" is set on the success path, but
>> that's not necessarily true on this path.
>>
> 
> In ocfs2_page_mkwrite(), since in this case no target page locked, it
> will finally return VM_FAULT_NOPAGE (better VM_FAULT_RETRY?) and throw 
> to handle_mm_fault(). So no problem as comments described.
> 
> But things seems changed since append direct io path started to use
> write_[begin/end]. In this path, the target page is expected as NULL.
> This needs more discussion.
> 

ocfs2_grab_pages_for_write() returns EAGAIN only in case of mmap. So
current code won't have any issue.
I'll send a cleanup to make the code more clearly.

Thanks,
Joseph
