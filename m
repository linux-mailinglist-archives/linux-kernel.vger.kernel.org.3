Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D644C9E83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiCBHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCBHno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:43:44 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7F75DA47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 23:43:01 -0800 (PST)
X-QQ-mid: bizesmtp83t1646206969ta5kjd02
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 15:42:45 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: zD6y7hNAcUD/3wlbXio0BPozXLW9pL5wqWTOA31Jq7oAQZTipKOvJ3Bz/j2Gu
        pu2ZdhZWaTpg61ZMNTAK1g1tiLYdkOraCID8c3xAb5akGX74hFGKu+HIXtN4WCLxQ8gIvmi
        fefR57OKk5FvSIbwSR0o7KoUtwT7iWO5V8eutYr2fdOiP0nPQT3gkqYB65NYABfKr0HmNW7
        1kNNbWhNJlB/3A9KCcyB2uKe+eFFPGR0gi/7gZmv3Fs+CWQuQolUcScoVCn3cam0ys3in+Y
        wzJJH9saXlDGfwUvyUY+PXmhKoZWt/Wpffe4c0aE0nEFzitJIk0s70Q9fCxuUq1tYsmVKKH
        tfpB+c92fBFl6kwwqHDStp4EXZzk53iar2HcQer
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ALSA: intel_hdmi: Fix reference to PCM buffer address
Date:   Wed,  2 Mar 2022 15:42:41 +0800
Message-Id: <20220302074241.30469-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM buffers might be allocated dynamically when the buffer
preallocation failed or a larger buffer is requested, and it's not
guaranteed that substream->dma_buffer points to the actually used
buffer.  The driver needs to refer to substream->runtime->dma_addr
instead for the buffer address.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 1c94eaff1931..4a3ff6468aa7 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1261,7 +1261,7 @@ static int had_pcm_mmap(struct snd_pcm_substream *substream,
 {
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	return remap_pfn_range(vma, vma->vm_start,
-			substream->dma_buffer.addr >> PAGE_SHIFT,
+			substream->runtime->dma_addr >> PAGE_SHIFT,
 			vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-- 
2.20.1



