Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928D48F5FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiAOIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:22:17 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30282 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiAOIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:22:16 -0500
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JbWND3YzlzbjN0;
        Sat, 15 Jan 2022 16:21:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 15 Jan 2022 16:22:14 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 15 Jan 2022 16:22:13 +0800
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        "kirill shutemov" <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
 <244238061.248369.1641886066066.JavaMail.zimbra@nod.at>
 <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com>
 <11976804.249069.1641902225370.JavaMail.zimbra@nod.at>
 <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
 <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at>
 <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com>
 <23886736.260777.1642185939371.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <88df000c-97a6-ff3f-a1e2-10fa4da8c604@huawei.com>
Date:   Sat, 15 Jan 2022 16:22:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <23886736.260777.1642185939371.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>           if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
>>>                       ai->bad_peb_count - fm->used_blocks))
>>>                   goto fail_bad;
>>>
>>> It does not account ai->fastmap. So if ai->fastmap contains old anchor PEBs
>>> this check will trigger and force falling back to scanning mode.
>>> With this check fixed, ubi_wl_init() will erase all old PEBs from ai->fastmap.
>> Forgive my stubbornness, I think this strict check is good, could you
>> show me a process to trigger this WARN_ON, it would be nice to provide a
>> reproducer.
> 
> You can trigger this by interrupting UBI.
> e.g. When UBI writes a new fastmap to the NAND, it schedules the old fastmap
> PEBs for erasure. PEB erasure is asynchronous in UBI. So this can be delayed
> for a very long time.
I tried with following modifications:

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 01dcdd94c9d2..253e76e2a7d7 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -679,6 +679,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
  		if (fm_pos >= fm_size)
  			goto fail_bad;

+		pr_err("%s: add %d to erase list\n", __func__, be32_to_cpu(fmec->pnum));
  		ret = add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
  			      be32_to_cpu(fmec->ec), 1);
  		if (ret)
@@ -1103,6 +1104,7 @@ void ubi_fastmap_destroy_checkmap(struct 
ubi_volume *vol)
   *
   * Returns 0 on success, < 0 indicates an internal error.
   */
+#include <linux/delay.h>
  static int ubi_write_fastmap(struct ubi_device *ubi,
  			     struct ubi_fastmap_layout *new_fm)
  {
@@ -1148,6 +1150,8 @@ static int ubi_write_fastmap(struct ubi_device *ubi,
  		goto out_free_dvbuf;
  	}

+	pr_err("%s: wait all erase workers deleted from list\n", __func__);
+	msleep(500);
  	spin_lock(&ubi->volumes_lock);
  	spin_lock(&ubi->wl_lock);

@@ -1196,6 +1200,8 @@ static int ubi_write_fastmap(struct ubi_device *ubi,

  	ubi_for_each_free_peb(ubi, wl_e, tmp_rb) {
  		fec = (struct ubi_fm_ec *)(fm_raw + fm_pos);
+		if (global_old_fm_peb == wl_e->pnum)
+			pr_err("%s: count peb %d as free(cannot happen)!!!\n", __func__, 
wl_e->pnum);

  		fec->pnum = cpu_to_be32(wl_e->pnum);
  		set_seen(ubi, wl_e->pnum, seen_pebs);
@@ -1208,6 +1214,8 @@ static int ubi_write_fastmap(struct ubi_device *ubi,
  	if (ubi->fm_next_anchor) {
  		fec = (struct ubi_fm_ec *)(fm_raw + fm_pos);

+		if (global_old_fm_peb == ubi->fm_next_anchor->pnum)
+			pr_err("%s: count peb %d as next anchor(cannot happen)!!!\n", 
__func__, ubi->fm_next_anchor->pnum);
  		fec->pnum = cpu_to_be32(ubi->fm_next_anchor->pnum);
  		set_seen(ubi, ubi->fm_next_anchor->pnum, seen_pebs);
  		fec->ec = cpu_to_be32(ubi->fm_next_anchor->ec);
@@ -1264,6 +1272,8 @@ static int ubi_write_fastmap(struct ubi_device *ubi,

  			fec = (struct ubi_fm_ec *)(fm_raw + fm_pos);

+			if (wl_e->pnum == global_old_fm_peb)
+				pr_err("%s: count fm anchor %d in erase work(should happen)!!!\n", 
__func__, wl_e->pnum);
  			fec->pnum = cpu_to_be32(wl_e->pnum);
  			set_seen(ubi, wl_e->pnum, seen_pebs);
  			fec->ec = cpu_to_be32(wl_e->ec);
@@ -1520,12 +1530,14 @@ static void return_fm_pebs(struct ubi_device *ubi,
   *
   * Returns 0 on success, < 0 indicates an internal error.
   */
+int global_old_fm_peb = -1;
  int ubi_update_fastmap(struct ubi_device *ubi)
  {
  	int ret, i, j;
  	struct ubi_fastmap_layout *new_fm, *old_fm;
  	struct ubi_wl_entry *tmp_e;

+	pr_err("%s: start\n", __func__);
  	down_write(&ubi->fm_protect);
  	down_write(&ubi->work_sem);
  	down_write(&ubi->fm_eba_sem);
@@ -1634,6 +1646,9 @@ int ubi_update_fastmap(struct ubi_device *ubi)
  			/* we've got a new anchor PEB, return the old one */
  			ubi_wl_put_fm_peb(ubi, old_fm->e[0], 0,
  					  old_fm->to_be_tortured[0]);
+			global_old_fm_peb = old_fm->e[0]->pnum;
+			pr_err("%s: put old fastmap peb %d\n", __func__, old_fm->e[0]->pnum);
+			/* Not check return value ? Fault injection may cause the WARNON() 
too! */
  			new_fm->e[0] = tmp_e;
  			old_fm->e[0] = NULL;
  		}
@@ -1665,6 +1680,7 @@ int ubi_update_fastmap(struct ubi_device *ubi)

  	ubi_ensure_anchor_pebs(ubi);

+	pr_err("%s: done\n", __func__);
  	return ret;

  err:
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 7c083ad58274..17df8dcebbe9 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -37,6 +37,7 @@
  #define UBI_NAME_STR "ubi"

  struct ubi_device;
+extern int global_old_fm_peb;

  /* Normal UBI messages */
  __printf(2, 3)
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 8455f1d47f3c..a148280f4ce8 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -198,8 +198,12 @@ static int do_work(struct ubi_device *ubi)
  	 * the queue flush code has to be sure the whole queue of works is
  	 * done, and it takes the mutex in write mode.
  	 */
+	if (global_old_fm_peb != -1)
+		pr_err("-----\n");
  	down_read(&ubi->work_sem);
  	spin_lock(&ubi->wl_lock);
+	if (global_old_fm_peb != -1)
+		pr_err("=====\n");
  	if (list_empty(&ubi->works)) {
  		spin_unlock(&ubi->wl_lock);
  		up_read(&ubi->work_sem);
@@ -1070,6 +1074,7 @@ static int ensure_wear_leveling(struct ubi_device 
*ubi, int nested)
   * needed. Returns zero in case of success and a negative error code 
in case of
   * failure.
   */
+#include <linux/delay.h>
  static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
  {
  	struct ubi_wl_entry *e = wl_wrk->e;
@@ -1078,6 +1083,12 @@ static int __erase_worker(struct ubi_device *ubi, 
struct ubi_work *wl_wrk)
  	int lnum = wl_wrk->lnum;
  	int err, available_consumed = 0;

+	if (pnum == global_old_fm_peb) {
+		pr_err("%s: erase worker(erase %d) has been deleted from list!", 
__func__, pnum);
+		pr_err("Dump ubi image to file\n");
+		ubi_ro_mode(ubi);
+	}
+
  	dbg_wl("erase PEB %d EC %d LEB %d:%d",
  	       pnum, e->ec, wl_wrk->vol_id, wl_wrk->lnum);

modprobe nandsim id_bytes="0xec,0xa1,0x00,0x15"
modprobe ubi mtd="0,2048" fm_autoconvert
sleep 1   # Wait until all erase works done
ubimkvol -N vol_a -m -n 0 /dev/ubi0  # trigger fastmap updating
dd if=/dev/mtd0 of=flash
rmmod ubi
nandwrite /dev/mtd0 flash > /dev/null
modprobe ubi mtd="0,2048" fm_autoconvert

Kernel will print:
[13198.624433] ubi_update_fastmap: start
[13198.625164] ubi_write_fastmap: wait all erase workers deleted from list
[13199.134011] ubi_update_fastmap: done		# first attaching triggers 
wearleveling
[13199.623438] ubi_update_fastmap: start	# volume creation triggers 
updating fastmap
[13199.624732] ubi_update_fastmap: put old fastmap peb 2	# schedule old 
fastmap PEB to erase
[13199.624757] -----
[13199.626532] ubi_write_fastmap: wait all erase workers deleted from list
[13200.133059] ubi_write_fastmap: count fm anchor 2 in erase work(should 
happen)!!!	# Count PEB(in erase work) into 'fmh->erase_peb_count'
[13200.136996] ubi_update_fastmap: done
[13200.137000] =====
[13200.138833] __erase_worker: erase worker(erase 2) has been deleted 
from list!
[13200.138842] Dump ubi image to file
[13203.091720] ubi0: attaching mtd0
[13203.111179] ubi_attach_fastmap: add 2 to erase list
[13203.113013] ubi0: attached by fastmap

I think the WARNON cannot be triggered because old fastmap PEBs are 
always counted into 'fmh->erase_peb_count', and 'ubi->work_sem' 
serilizes ubi_update_fastmap() and do_work():
             ubi_update_fastmap                       ubi_thread
     down_write(&ubi->work_sem)
       ubi_wl_put_fm_peb(old fastmap PEB)
         schedule_erase
           list_add_tail(&wrk->list, &ubi->works)
                                                        do_work
 
down_read(&ubi->work_sem)
                                                          // Stuck here!
       ubi_write_fastmap
         list_for_each_entry(ubi_wrk, &ubi->works, list)
           fec->pnum = cpu_to_be32(wl_e->pnum)
     up_write(&ubi->work_sem)
 
list_del(&wrk->list)
                                                          erase_worker

> While developing UBI fastmap and performing powercut tests I saw this often
> on targets.
Was commit 2e8f08deabbc7ee("ubi: Fix races around ubi_refill_pools()") 
applied at that time? The WANRON can be triggered without this commit, 
because this commit makes sure do_work() cannot happen between 
ubi_wl_put_fm_peb() and ubi_write_fastmap().
> 
>> I still insist the point(after my fix patch applied): All outdated
>> fastmap PEBs are added into 'ai->fastmap'(full scanning case) or counted
>> into 'fmhdr->erase_peb_count'(fast attached case).
> 
> Yes. But if you look into ubi_wl_init() you see that fastmap anchor PEBs
> get erases synchronously(!). The comment before the erasure explains why.
About erasing fastmap anchor PEB synchronously, I admit curreunt UBI 
implementation cannot satisfy it, even with my fix applied. Wait, it 
seems that UBI has never made it sure. Old fastmap PEBs could be erased 
asynchronously, they could be counted into 'fmh->erase_peb_count' even 
in early UBI implementation code, so old fastmap anchor PEB will be 
added into 'ai->erase' and be erased asynchronously in next attaching. 
But, I feel it is not a problem, find_fm_anchor() can help us find out 
the right fastmap anchor PEB according seqnum.
> To complicate things, this code is currently unreachable because the WARN_ON()
> is not right. I misses to count ai->fastmap.
> So, when there are old fastmap PEBs found, the counter does not match
> and UBI falls back to full scanning while it could to an attach by fastmap.
>I think the mainly cause of failed fastmap attaching is half-written of 
fastmap. The counter check(eg. WARNON) is okay.
> Fastmap is full with corner cases that have been found by massive amount of testing, sadly.
