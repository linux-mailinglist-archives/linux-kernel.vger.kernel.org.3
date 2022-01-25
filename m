Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9822F49AB53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390314AbiAYEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:48:53 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31185 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S249456AbiAYEIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:08:55 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JjYDh5yLsz8wX5;
        Tue, 25 Jan 2022 12:05:56 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:08:52 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:08:51 +0800
Content-Type: multipart/mixed;
        boundary="------------F0Ms0Bgpgimwe3x0FCyWuKwt"
Message-ID: <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
Date:   Tue, 25 Jan 2022 12:08:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
Content-Language: en-US
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, <axboe@kernel.dk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-block@vger.kernel.org>
CC:     <john.garry@huawei.com>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <akpm@linux-foundation.org>, <bvanassche@acm.org>,
        <linux-kernel@vger.kernel.org>
References: <1643040870.3bwvk3sis4.none.ref@localhost>
 <1643040870.3bwvk3sis4.none@localhost>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <1643040870.3bwvk3sis4.none@localhost>
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------F0Ms0Bgpgimwe3x0FCyWuKwt
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex

1、Please help to import this structure:

blk_mq_tags <= request_queue->blk_mq_hw_ctx->blk_mq_tags

If there is no kernel dump, help to see the value of

cat /sys/block/sda/mq/0/nr_tags
                __ <= Change it to the problem device

And how many block devices in total by lsblk.

2、Please describe in detail how to reproduce the issue,

And what type of USB device?

3、Please help to try the attachment patch and see if it can be reproduced.

Thanks.

On 2022/1/25 0:24, Alex Xu (Hello71) wrote:
> Hi,
> 
> Recently on torvalds master, I/O on USB flash drives started hanging
> here:
> 
> task:systemd-udevd   state:D stack:    0 pid:  374 ppid:   347 flags:0x00004000
> Call Trace:
>   <TASK>
>   ? __schedule+0x319/0x4a0
>   ? schedule+0x77/0xa0
>   ? io_schedule+0x43/0x60
>   ? blk_mq_get_tag+0x175/0x2b0
>   ? mempool_alloc+0x33/0x170
>   ? init_wait_entry+0x30/0x30
>   ? __blk_mq_alloc_requests+0x1b4/0x220
>   ? blk_mq_submit_bio+0x213/0x490
>   ? submit_bio_noacct+0x22c/0x270
>   ? xa_load+0x48/0x80
>   ? mpage_readahead+0x114/0x130
>   ? blkdev_fallocate+0x170/0x170
>   ? read_pages+0x48/0x1d0
>   ? page_cache_ra_unbounded+0xee/0x1f0
>   ? force_page_cache_ra+0x68/0xc0
>   ? filemap_read+0x18c/0x9a0
>   ? blkdev_read_iter+0x4e/0x120
>   ? vfs_read+0x265/0x2d0
>   ? ksys_read+0x50/0xa0
>   ? do_syscall_64+0x62/0x90
>   ? do_user_addr_fault+0x271/0x3c0
>   ? asm_exc_page_fault+0x8/0x30
>   ? exc_page_fault+0x58/0x80
>   ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>   </TASK>
> 
> mount(8) hangs with a similar backtrace, making the device effectively
> unusable. It does not seem to affect NVMe or SATA attached drives. The
> affected drive does not support UAS. I don't currently have UAS drives
> to test with. The default I/O scheduler is set to noop.
> 
> I found that reverting 180dccb0dba4 ("blk-mq: fix tag_get wait
> task can't be awakened") appears to resolve the issue.
> 
> Let me know what other information is needed.
> 
> Cheers,
> Alex.
> .
> 

BR
Laibin

--------------F0Ms0Bgpgimwe3x0FCyWuKwt
Content-Type: text/plain; charset="UTF-8"; name="fix_hang.patch"
Content-Disposition: attachment; filename="fix_hang.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9zYml0bWFwLmMgYi9saWIvc2JpdG1hcC5jCmluZGV4IDYyMjBm
YTY3ZmI3ZS4uMDlkMjkzYzMwZmQyIDEwMDY0NAotLS0gYS9saWIvc2JpdG1hcC5jCisrKyBi
L2xpYi9zYml0bWFwLmMKQEAgLTQ4OCw5ICs0ODgsMTMgQEAgdm9pZCBzYml0bWFwX3F1ZXVl
X3JlY2FsY3VsYXRlX3dha2VfYmF0Y2goc3RydWN0IHNiaXRtYXBfcXVldWUgKnNicSwKIAkJ
CQkJICAgIHVuc2lnbmVkIGludCB1c2VycykKIHsKIAl1bnNpZ25lZCBpbnQgd2FrZV9iYXRj
aDsKKwl1bnNpZ25lZCBpbnQgbWluX2JhdGNoOworCXVuc2lnbmVkIGludCBkZXB0aCA9IChz
YnEtPnNiLmRlcHRoICsgdXNlcnMgLSAxKSAvIHVzZXJzOwogCi0Jd2FrZV9iYXRjaCA9IGNs
YW1wX3ZhbCgoc2JxLT5zYi5kZXB0aCArIHVzZXJzIC0gMSkgLwotCQkJdXNlcnMsIDQsIFNC
UV9XQUtFX0JBVENIKTsKKwltaW5fYmF0Y2ggPSBzYnEtPnNiLmRlcHRoID49ICg0ICogU0JR
X1dBSVRfUVVFVUVTKSA/IDQgOiAxOworCisJd2FrZV9iYXRjaCA9IGNsYW1wX3ZhbChkZXB0
aCAvIFNCUV9XQUlUX1FVRVVFUywKKwkJCW1pbl9iYXRjaCwgU0JRX1dBS0VfQkFUQ0gpOwog
CV9fc2JpdG1hcF9xdWV1ZV91cGRhdGVfd2FrZV9iYXRjaChzYnEsIHdha2VfYmF0Y2gpOwog
fQogRVhQT1JUX1NZTUJPTF9HUEwoc2JpdG1hcF9xdWV1ZV9yZWNhbGN1bGF0ZV93YWtlX2Jh
dGNoKTsK
--------------F0Ms0Bgpgimwe3x0FCyWuKwt--
