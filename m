Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320EC46E4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhLIJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:02:49 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:33900 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235471AbhLIJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:02:47 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAD3_p5ExbFhvtbuAQ--.47934S2;
        Thu, 09 Dec 2021 16:58:48 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: meson: vdec: potential dereference of null pointer
Date:   Thu,  9 Dec 2021 16:58:40 +0800
Message-Id: <20211209085840.2081024-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3_p5ExbFhvtbuAQ--.47934S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xtrW8Cw4xAF4fGr1DAwb_yoWfWrc_Gr
        ZFqrnxZryDZa1Skr15tw4F9FWFqr4IvFsYvanxtFW3uFyDA3W5Z39F9rn5Jr1UJFWSkrZr
        A393tr13Kr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjNJ55UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

he return value of kzalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/staging/media/meson/vdec/vdec_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index 7f07a9175815..025885fcfec6 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -234,6 +234,8 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
 	unsigned long flags;
 
 	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts)
+		return;
 	new_ts->ts = ts;
 	new_ts->tc = tc;
 	new_ts->offset = offset;
-- 
2.25.1

