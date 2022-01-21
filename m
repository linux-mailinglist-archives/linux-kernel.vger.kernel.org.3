Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F22495F70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380555AbiAUNHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:07:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13551 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350469AbiAUNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642770440; x=1674306440;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Uzj3Ns65Nas0RP6phFFitRAX3tcFJ3klg3j+uRxfs0I=;
  b=SL3yzCKJ33bfYtzkWv/FA+F7orSvjMeJc5HAxCe2vPQ1XN4G2SeMyTuC
   zRCx0/ge0anJg39ZKf8i8PA/nydv+aX428Zbc4r3DEaLhpK/WIkxRIXbk
   o/LOTt3T2TVwc4BrdvmH8dqw/ZzXzKOm7pZhxc4uMKLBDf98q5PMtKLF6
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jan 2022 05:07:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 05:07:20 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 05:07:17 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <john.ogness@linutronix.de>, <pmladek@suse.com>,
        <senozhatsky@chromium.org>, <rostedt@goodmis.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3] printk: ringbuffer: Improve prb_next_seq() performance
Date:   Fri, 21 Jan 2022 18:36:28 +0530
Message-ID: <1642770388-17327-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

prb_next_seq() always iterates from the first known sequence number.
In the worst case, it might loop 8k times for 256kB buffer,
15k times for 512kB buffer, and 64k times for 2MB buffer.

It was reported that pooling and reading using syslog interface
might occupy 50% of CPU.

Speedup the search by storing @id of the last finalized descriptor.

The loop is still needed because the @id is stored and read in the best
effort way. An atomic variable is used to keep the @id consistent.
But the stores and reads are not serialized against each other.
The descriptor could get reused in the meantime. The related sequence
number will be used only when it is still valid.

An invalid value should be read _only_ when there is a flood of messages
and the ringbuffer is rapidly reused. The performance is the least
problem in this case.

Link: https://lore.kernel.org/lkml/YXlddJxLh77DKfIO@alley/T/#m43062e8b2a17f8dbc8c6ccdb8851fb0dbaabbb14
Reported-by: Chunlei Wang <chunlei.wang@mediatek.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes against v2:
  Added the hunk suggested by John

Changes against v1:
  Read @seq by the last finalized @id directly in prb_next_seq() (John)

 kernel/printk/printk_ringbuffer.c | 48 +++++++++++++++++++++++++++++++++++----
 kernel/printk/printk_ringbuffer.h |  2 ++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 8a7b736..297bc18 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -474,8 +474,11 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 * state has been re-checked. A memcpy() for all of @desc
 	 * cannot be used because of the atomic_t @state_var field.
 	 */
-	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
-	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
+	if (desc_out) {
+		memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
+			sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
+	}
+
 	if (seq_out)
 		*seq_out = info->seq; /* also part of desc_read:C */
 	if (caller_id_out)
@@ -528,7 +531,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:E) */
 	d_state = get_desc_state(id, state_val);
 out:
-	atomic_long_set(&desc_out->state_var, state_val);
+	if (desc_out)
+		atomic_long_set(&desc_out->state_var, state_val);
 	return d_state;
 }
 
@@ -1449,6 +1453,7 @@ static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
 
 	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
 			DESC_SV(id, desc_finalized)); /* LMM(desc_make_final:A) */
+	atomic_long_set(&desc_ring->last_finalized_id, id);
 }
 
 /**
@@ -1657,7 +1662,11 @@ void prb_commit(struct prb_reserved_entry *e)
  */
 void prb_final_commit(struct prb_reserved_entry *e)
 {
+	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
+
 	_prb_commit(e, desc_finalized);
+	/* Best effort to remember the last finalized @id. */
+	atomic_long_set(&desc_ring->last_finalized_id, e->id);
 }
 
 /*
@@ -2005,8 +2014,38 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
  */
 u64 prb_next_seq(struct printk_ringbuffer *rb)
 {
-	u64 seq = 0;
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	enum desc_state d_state;
+	unsigned long id;
+	u64 seq;
+
+	/* Check if the cached @id still points to a valid @seq. */
+	id = atomic_long_read(&desc_ring->last_finalized_id);
+	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
 
+	if (d_state == desc_finalized || d_state == desc_reusable) {
+		/*
+		 * Begin searching after the last finalized record.
+		 * (On 0, the search must begin at 0 because of hack#2
+		 * of the bootstrapping phase it is not known if a
+		 * record at index 0 exists.)
+		*/
+		if (seq != 0)
+			seq++;
+	} else {
+		/*
+		 * The information about the last finalized sequence number
+		 * has gone. It should happen only when there is a flood of
+		 * new messages and the ringbuffer is rapidly recycled.
+		 * Give up and start from the beginning.
+		 */
+		seq = 0;
+	}
+
+	/*
+	 * The information about the last finalized @seq might be inaccurate.
+	 * Search forward to find the current one.
+	 */
 	/* Search forward from the oldest descriptor. */
 	while (_prb_read_valid(rb, &seq, NULL, NULL))
 		seq++;
@@ -2044,6 +2083,7 @@ void prb_init(struct printk_ringbuffer *rb,
 	rb->desc_ring.infos = infos;
 	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
 	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
+	atomic_long_set(&rb->desc_ring.last_finalized_id, DESC0_ID(descbits));
 
 	rb->text_data_ring.size_bits = textbits;
 	rb->text_data_ring.data = text_buf;
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 73cc80e..18cd25e 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -75,6 +75,7 @@ struct prb_desc_ring {
 	struct printk_info	*infos;
 	atomic_long_t		head_id;
 	atomic_long_t		tail_id;
+	atomic_long_t		last_finalized_id;
 };
 
 /*
@@ -258,6 +259,7 @@ static struct printk_ringbuffer name = {							\
 		.infos		= &_##name##_infos[0],						\
 		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
+		.last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)),				\
 	},											\
 	.text_data_ring = {									\
 		.size_bits	= (avgtextbits) + (descbits),					\
-- 
2.7.4

