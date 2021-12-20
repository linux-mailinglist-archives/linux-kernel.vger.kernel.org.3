Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7047B05B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhLTPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:35:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58621 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhLTPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:35:00 -0500
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BKEvjuT081035;
        Mon, 20 Dec 2021 23:57:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Mon, 20 Dec 2021 23:57:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BKEviZT081032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Dec 2021 23:57:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <ee718d4e-7681-d09a-5d2a-4f9ac2172038@i-love.sakura.ne.jp>
Date:   Mon, 20 Dec 2021 23:57:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [loop] 322c4293ec: xfstests.xfs.049.fail
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-block <linux-block@vger.kernel.org>
References: <20211219150933.GJ14057@xsang-OptiPlex-9020>
 <dd707dfd-6421-b1df-4820-e30787b84181@i-love.sakura.ne.jp>
 <20211220115823.GB20005@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211220115823.GB20005@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/20 20:58, Jan Kara wrote:
> On Mon 20-12-21 00:45:46, Tetsuo Handa wrote:
>> On 2021/12/20 0:09, kernel test robot wrote:
>>>     @@ -13,3 +13,5 @@
>>>      --- clean
>>>      --- umount ext2 on xfs
>>>      --- umount xfs
>>>     +!!! umount xfs failed
>>>     +(see /lkp/benchmarks/xfstests/results//xfs/049.full for details)
>>>     ...
>>>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/049.out /lkp/benchmarks/xfstests/results//xfs/049.out.bad'  to see the entire diff)
>>
>> Yes, we know this race condition can happen.
>>
>> https://lkml.kernel.org/r/16c7d304-60ef-103f-1b2c-8592b48f47c6@i-love.sakura.ne.jp
>> https://lkml.kernel.org/r/YaYfu0H2k0PSQL6W@infradead.org
>>
>> Should we try to wait for autoclear operation to complete?
> 
> So I think we should try to fix this because as Dave writes in the
> changelog for a1ecac3b0656 ("loop: Make explicit loop device destruction
> lazy") which started all this, having random EBUSY failures (either from
> losetup or umount) is annoying and you need to work it around it lots of
> unexpected places.

OK. Let's wait for autoclear operation to complete.

> 
> We cannot easily wait for work completion in the loop device code without
> reintroducing the deadlock - whole lo_release() is called under
> disk->open_mutex which you also need to grab in __loop_clr_fd(). So to
> avoid holding backing file busy longer than expected, we could use
> task_work instead of ordinary work as I suggested - but you were right that
> we need to be somewhat careful and in case we are running in a kthread, we
> would still need to offload to a normal work (but in that case we don't
> care about delaying file release anyway).

Like fput_many() shows, it is not easy to implement fallback correctly.
I worry that exporting task_work_add() to loadable kernel modules results in
random abuse of task_work which does not implement fallback.

Instead of exporting task_work_add(), I think we can apply below diff.
I chose not to rely on WQ context, for there is fput(filp) in __loop_clr_fd()
which we should make sure that __fput(filp) is processed by a thread which
triggered autoclear operation. If this __fput(filp) is scheduled by other thread
because fput(filp) is called by a thread which did not trigger autoclear operation,
I think it is possible that a thread which triggered autoclear operation fails to
wait for completion of __fput(filp), and results in the same problem.

---
 block/bdev.c           |  2 ++
 drivers/block/loop.c   | 42 ++++++++++++------------------------------
 drivers/block/loop.h   |  2 +-
 include/linux/blkdev.h |  5 +++++
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c80cfaefc0a8..b252b1d87471 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1227,6 +1227,11 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+	/*
+	 * Special callback for doing post-release callback without
+	 * disk->open_mutex held. Used by loop driver.
+	 */
+	void (*post_release)(struct gendisk *disk);
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b..0cb638d81a27 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -948,6 +948,8 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	else
 		blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
+	if (bdev->bd_disk->fops->post_release)
+		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..f2e9f38694dc 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	struct task_struct	*rundown_owner; /* current or NULL */
 };
 
 struct loop_cmd {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..faa3a3097b22 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1165,40 +1165,12 @@ static void __loop_clr_fd(struct loop_device *lo)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
 	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
-{
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__loop_clr_fd(lo);
-	kobject_put(&bdev->bd_device.kobj);
-	module_put(disk->fops->owner);
-	loop_rundown_completed(lo);
-}
-
-static void loop_schedule_rundown(struct loop_device *lo)
-{
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__module_get(disk->fops->owner);
-	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
-}
-
 static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
@@ -1229,7 +1201,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1754,7 +1725,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		lo->rundown_owner = current;
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
@@ -1769,10 +1740,21 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void lo_post_release(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	if (lo->rundown_owner != current)
+		return;
+	lo->rundown_owner = NULL;
+	__loop_clr_fd(lo);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
 	.release =	lo_release,
+	.post_release = lo_post_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
-- 
2.32.0

