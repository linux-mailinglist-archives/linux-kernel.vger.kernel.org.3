Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5788046F8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhLJCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:00:25 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:60248 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232642AbhLJCAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:00:25 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowACHj1fFs7JhU_EOAg--.23696S2;
        Fri, 10 Dec 2021 09:56:21 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] media: meson: vdec: potential dereference of null pointer
Date:   Fri, 10 Dec 2021 09:56:20 +0800
Message-Id: <20211210015620.2143555-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHj1fFs7JhU_EOAg--.23696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkWF1fZF1rZr4rKr43GFg_yoW5tryxpF
        10v342gFyUtFyUAr4UJr1kWFWSq348GFyI9a97Xw1fZry7tF17XFnayFWjgr98Jr1S9a18
        CFyrWw1Uuw4jqrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbLiSPUUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kzalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

*Change 1. Change the return type of amvdec_add_ts from void to int.
*Change 2. Return -ENOMEN if alloc fail and return 0 if not.
*Change 3. Modify the caller to deal with the error.
---
 drivers/staging/media/meson/vdec/esparser.c     | 6 +++++-
 drivers/staging/media/meson/vdec/vdec_helpers.c | 5 ++++-
 drivers/staging/media/meson/vdec/vdec_helpers.h | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index db7022707ff8..7e78288cc551 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -328,9 +328,13 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 
 	offset = esparser_get_offset(sess);
 
-	amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
 	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
 		vb->timestamp, payload_size, offset, vbuf->flags);
+	if (ret) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return ret;
+	}
 
 	vbuf->flags = 0;
 	vbuf->field = V4L2_FIELD_NONE;
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index 7f07a9175815..972a1d1a12a5 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -227,13 +227,15 @@ int amvdec_set_canvases(struct amvdec_session *sess,
 }
 EXPORT_SYMBOL_GPL(amvdec_set_canvases);
 
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
 {
 	struct amvdec_timestamp *new_ts;
 	unsigned long flags;
 
 	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts)
+		return -ENOMEM;
 	new_ts->ts = ts;
 	new_ts->tc = tc;
 	new_ts->offset = offset;
@@ -242,6 +244,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
 	spin_lock_irqsave(&sess->ts_spinlock, flags);
 	list_add_tail(&new_ts->list, &sess->timestamps);
 	spin_unlock_irqrestore(&sess->ts_spinlock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(amvdec_add_ts);
 
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
index cfaed52ab526..1bcb697290de 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.h
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
@@ -55,7 +55,7 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
  * @offset: offset in the VIFIFO where the associated packet was written
  * @flags the vb2_v4l2_buffer flags
  */
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 flags);
 void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
 
-- 
2.25.1

