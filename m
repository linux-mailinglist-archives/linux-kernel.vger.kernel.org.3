Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99AD58FB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiHKLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiHKLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:33:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6676E96756;
        Thu, 11 Aug 2022 04:32:44 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxHOTS6PRizJQNAA--.37999S2;
        Thu, 11 Aug 2022 19:32:41 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] blk-wbt: do not throttle swap write on processes other than kswapd
Date:   Thu, 11 Aug 2022 19:32:25 +0800
Message-Id: <1660217545-10697-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9BxHOTS6PRizJQNAA--.37999S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4rtw47KF15Ar4fJw4xZwb_yoW3ZF15pr
        yUC340gw48JrnrAa4UAF1UZF4UJ34UCF4DJr1UJF1jvr1kXr1UXw17trW5Jw1DZr18Jry3
        Jr1ktr1rtr48u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,LOTS_OF_MONEY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do ltp test using large swap,we get the following error:
[34196.558224] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[34196.566010] float_exp_log   D    0 16985  16971 0x00004000
[34196.571462] Stack : 900000010a33bdd8 0000000000027100 900000027417d680 900000010dfc3778
[34196.579421]         006200ca00000054 0000000000000004 000000fff424c000 9000000276ba8060
[34196.587378]         0000000000000002 90000000014bdfa0 0000000000000000 9000000276ba8000
[34196.595358]         900000010da17dd0 9000000276ba8068 9000000276ba8060 0000000000000002
[34196.603313]         900000010dfc3778 9000000000c1df80 ffffffffffffffff 9000000000c2170c
[34196.611269]         0000000000000001 900000010a33bdc0 900000010a177dd0 900000010da17dd0
[34196.619224]         900000010a692d80 000000ff00000001 9000000276ba8060 900000010a33bea0
[34196.627180]         900000010a692d80 000000fff424ce04 9000000276ba8060 9000000000c20b3c
[34196.635135]         0000000000000070 9000000000c23a24 000000000000003a fffffffffffffffb
[34196.643090]         000000fff365c8b0 000000fff365e8f0 0000000128259020 0000000128259130
[34196.651045]         ...
[34196.653469] Call Trace:
[34196.655902] [<9000000000c1d7ac>] __schedule+0x4b4/0xc5c
[34196.661094] [<9000000000c1df7c>] schedule+0x28/0x7c
[34196.665940] [<9000000000c21708>] rwsem_down_read_failed+0xfc/0x164
[34196.672082] [<9000000000c20b38>] down_read+0x50/0x58
[34196.677013] [<9000000000c23a20>] do_page_fault+0xf4/0x58c
[34196.682380] [<9000000000218220>] tlb_do_page_fault_0+0x110/0x128
		...
		...
[34198.279088] Sending NMI from CPU 2 to CPUs 0-1,3:
[34198.283761] NMI backtrace for cpu 1
[34198.283763] NMI backtrace for cpu 3
[34198.283764] NMI backtrace for cpu 0
[34198.283767] CPU: 3 PID: 940 Comm: Xorg Not tainted 4.19.190+ #1
[34198.283769] CPU: 0 PID: 1555 Comm: genload Not tainted 4.19.190+ #1
[34198.283770] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.028.220624.R 06/24/2022
[34198.283770] $ 0   : 0000000000000000 90000000002465a4 9000000270e4c000 9000000270e4f220
[34198.283773] $ 4   : 0000000000000001 0000000002f41000 900000026a8b1d40 9000000270e4f158
[34198.283775] $ 8   : 0000000000000040 900000010aa9e798 0000000000000a00 00000000000000e1
[34198.283776] $12   : 00000000000000b0 0000000000000004 0000000000000020 9000000276b66480
[34198.283778] $16   : 900000000600ebf0 000000000000000b 0000000000002523 9000000000c30e30
[34198.283780] $20   : 00000000eac0c6e6 90000000014485b8 9000000000fdff00 0000000000000000
[34198.283781] $24   : 900000026d317840 fffffffffffffff5 0000000000000040 900000027d0fbe00
[34198.283783] $28   : 0000000000000000 0000000000000001 90000000010ceb10 0000000000000000
[34198.283789] era   : 90000000002465bc mod_delayed_work_on+0x84/0xac
[34198.283790] ra    : 90000000002465a4 mod_delayed_work_on+0x6c/0xac
[34198.283791] CSR crmd: 00000040
[34198.283791] CSR prmd: 00000004
[34198.283792] CSR ecfg: 00071fff
[34198.283793] CSR estat: 9000000000fdff00
[34198.283793] CSR euen: 900000026d317840
[34198.283795] ExcCode : 3d (SubCode 3)
[34198.283796] PrId  : 0014c011 (Loongson-64bit)
[34198.283797] CPU: 0 PID: 1555 Comm: genload Not tainted 4.19.190+ #1
[34198.283798] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.028.220624.R 06/24/2022
[34198.283799] Stack : 0000000000000000 9000000000c16888 9000000270e4c000 900000027c167df0
[34198.283800]         0000000000000000 900000027c167df0 0000000000000000 900000000149d310
[34198.283802]         0000000000000040 90000000014a7f80 0000000000000000 0000000000000088
[34198.283804]         9000000000c16888 0000000000000007 0000000000000006 0000000000000007
[34198.283805]         9000000006000768 000002cccd7c4b02 3032322e3832302e 363020522e343236
[34198.283807]         00000000000003f3 0000000004bc4000 9000000000fdff00 ffff800000000000
[34198.283808]         90000000010bb500 0000000000000000 0000000000000000 9000000000204f54
[34198.283809]         9000000000ea53c0 0000000000000001 90000000010ceb10 0000000000000000
[34198.283811]         9000000000209628 000000fff6cb38e8 00000000000000b0 0000000000000004
[34198.283812]         0000000000000000 0000000000071fff 0000000000000000 90000000010bb500
[34198.283814]         ...
[34198.283815] Call Trace:
[34198.283817] [<9000000000209628>] show_stack+0x34/0x13c
[34198.283820] [<9000000000c16884>] dump_stack+0x98/0xd0
[34198.283822] [<9000000000bfe430>] nmi_cpu_backtrace+0xe0/0xe8
[34198.283823] [<9000000000204f68>] handle_backtrace+0x14/0x48
[34198.283827] [<90000000002d8524>] flush_smp_call_function_queue+0xac/0x194
[34198.283829] [<900000000020255c>] loongson3_ipi_interrupt+0xd4/0xec
[34198.283831] [<90000000002034f0>] except_vec_vi_handler+0xac/0xdc
[34198.283833] [<90000000002465bc>] mod_delayed_work_on+0x84/0xac
[34198.283837] [<90000000006c3e74>] kblockd_mod_delayed_work_on+0x24/0x34
[34198.283841] [<90000000006d4d88>] blk_mq_run_hw_queue+0xb0/0x128
[34198.283843] [<90000000006d7a80>] blk_mq_flush_plug_list+0x178/0x29c
[34198.283846] [<90000000006c9884>] blk_flush_plug_list+0xf0/0x298
[34198.283848] [<900000000025d1bc>] io_schedule_prepare+0x40/0x58
[34198.283850] [<9000000000c1e4fc>] io_schedule+0x14/0x40
[34198.283853] [<9000000000704dc0>] wbt_wait+0x1b0/0x374
[34198.283856] [<90000000006ebb30>] rq_qos_throttle+0x44/0x68
[34198.283858] [<90000000006d7100>] blk_mq_make_request+0xd8/0x580
[34198.283860] [<90000000006c74d4>] generic_make_request+0x11c/0x330
[34198.283862] [<90000000006c77f8>] submit_bio+0x110/0x180
[34198.283865] [<90000000003faa04>] __swap_writepage+0x174/0x434
[34198.283868] [<90000000003b73cc>] pageout.isra.10+0x144/0x3d8
[34198.283870] [<90000000003b9918>] shrink_page_list+0x7a8/0xe94
[34198.283871] [<90000000003ba984>] shrink_inactive_list+0x248/0x70c
[34198.283873] [<90000000003bb5bc>] shrink_node_memcg+0x1fc/0x748
[34198.283874] [<90000000003bbbdc>] shrink_node+0xd4/0x4b8
[34198.283875] [<90000000003bc0a8>] do_try_to_free_pages+0xe8/0x3c0
[34198.283877] [<90000000003bc45c>] try_to_free_pages+0xdc/0x23c
[34198.283880] [<90000000003a5c7c>] __alloc_pages_nodemask+0x5bc/0xffc
[34198.283883] [<900000000040e314>] alloc_pages_vma+0x98/0x274
[34198.283886] [<90000000003e5698>] __handle_mm_fault+0xd3c/0x14f0
[34198.283887] [<90000000003e5f48>] handle_mm_fault+0xfc/0x248
[34198.283889] [<9000000000c23a78>] do_page_fault+0x14c/0x58c
[34198.283890] [<9000000000218348>] tlb_do_page_fault_1+0x110/0x128

and we find out that it is because the __swap_writepage consumed too much
time,so I think when call __swap_writepage to reclaim memory,it should
complete ASAP.

For the above case,we should not do write back throttle when a process other
than kswapd is writing data to swap,because it may be reclaiming memory.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 block/blk-wbt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a998200..d6323d0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -554,7 +554,9 @@ static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
 			flags |= WBT_KSWAPD;
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			flags |= WBT_DISCARD;
-		flags |= WBT_TRACKED;
+		if (current_is_kswapd() ||
+		    (bio->bi_end_io != end_swap_bio_write))
+			flags |= WBT_TRACKED;
 	}
 	return flags;
 }
-- 
1.8.3.1

