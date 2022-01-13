Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBD48D283
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiAMG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:57:32 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:58216 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbiAMG5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:57:31 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABnby8lzd9hYoF7BQ--.64251S2;
        Thu, 13 Jan 2022 14:56:37 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     hverkuil-cisco@xs4all.nl, narmstrong@baylibre.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: meson: vdec: potential dereference of null pointer
Date:   Thu, 13 Jan 2022 14:56:36 +0800
Message-Id: <20220113065636.1198072-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnby8lzd9hYoF7BQ--.64251S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43tFW5uF4DXrWxJF1DKFg_yoW5tF48pF
        10v342gFyUtFyUAr4UJw1kXayaq348GFyI9a9rWw1fZryakF17XFsayFWjgr98Jr1S9a1r
        CFyFg3y7uw4jqrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUndb1UUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the kzalloc(), the 'new_ts' could be NULL
pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer.
Also, the caller esparser_queue() needs to deal with the return value of
the amvdec_add_ts().

Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/staging/media/meson/vdec/esparser.c     | 7 ++++++-
 drivers/staging/media/meson/vdec/vdec_helpers.c | 8 ++++++--
 drivers/staging/media/meson/vdec/vdec_helpers.h | 4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index db7022707ff8..86ccc8937afc 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -328,7 +328,12 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 
 	offset = esparser_get_offset(sess);
 
-	amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+	if (ret) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return ret;
+	}
+
 	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
 		vb->timestamp, payload_size, offset, vbuf->flags);
 
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index 203d7afa085d..7d2a75653250 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -227,13 +227,16 @@ int amvdec_set_canvases(struct amvdec_session *sess,
 }
 EXPORT_SYMBOL_GPL(amvdec_set_canvases);
 
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-		   struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
 {
 	struct amvdec_timestamp *new_ts;
 	unsigned long flags;
 
 	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts)
+		return -ENOMEM;
+
 	new_ts->ts = ts;
 	new_ts->tc = tc;
 	new_ts->offset = offset;
@@ -242,6 +245,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
 	spin_lock_irqsave(&sess->ts_spinlock, flags);
 	list_add_tail(&new_ts->list, &sess->timestamps);
 	spin_unlock_irqrestore(&sess->ts_spinlock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(amvdec_add_ts);
 
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
index 88137d15aa3a..4bf3e61d081b 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.h
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
@@ -56,8 +56,8 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
  * @offset: offset in the VIFIFO where the associated packet was written
  * @flags: the vb2_v4l2_buffer flags
  */
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-		   struct v4l2_timecode tc, u32 offset, u32 flags);
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 flags);
 void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
 
 /**
-- 
2.25.1

