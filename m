Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAF473D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhLNHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:08:43 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52934 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231272AbhLNHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:08:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-bWsut_1639465719;
Received: from 30.225.24.59(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V-bWsut_1639465719)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Dec 2021 15:08:40 +0800
Message-ID: <bd6dfb63-6d3d-c8f6-f401-8bdd5334afed@linux.alibaba.com>
Date:   Tue, 14 Dec 2021 15:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [BUG] fs: ocfs2: possible ABBA deadlock in
 ocfs2_dio_end_io_write() and ocfs2_move_extents()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8ae1bb9c-3e58-c8b6-8823-3d2ea8b241e2@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <8ae1bb9c-3e58-c8b6-8823-3d2ea8b241e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the report. But I don't think this is a possible deadlock in
practice. Please see my comments below.

On 12/10/21 4:38 PM, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible ABBA deadlock in the ocfs2 module in Linux 5.10:
> 
> ocfs2_dio_end_io_write()
>   down_write(&oi->ip_alloc_sem); --> Line 2322 (Lock A)
>   ocfs2_del_inode_from_orphan()
>     inode_lock(orphan_dir_inode);  --> Line 2701 (Lock B)

Just as the variable name indicates, it is orphan dir inode, which is a
system file (something hidden inside the filesystem) and not visible for
end user.

> 
> ocfs2_move_extents()
>   inode_lock(inode); --> Line 916 (Lock B)

This is called from a ioctl from user, it a normal file inode.

Thanks,
Joseph

>   down_write(&OCFS2_I(inode)->ip_alloc_sem); --> Line 936 (Lock A)
> 
> When ocfs2_dio_end_io_write() and ocfs2_move_extents() are concurrently executed, the deadlocks can occur.
> 
> I am not quite sure whether this possible deadlock is real and how to fix it if it is real.
> Any feedback would be appreciated, thanks :)
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> 
> 
> Best wishes,
> Jia-Ju Bai
