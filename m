Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F7465462
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbhLASAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:00:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351957AbhLAR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:59:57 -0500
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1409:4a00:c103:6980:2c3:d021])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 713D81F45E4E;
        Wed,  1 Dec 2021 17:56:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638381393; bh=z4yjDZMHbL7khpV9qKXUGvaNdJTMLt5a7ZsWb+Iwb9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mX44Zp3gbHwdPDogj4MOskryMw/Jw6qYdHY0uG8mT15uLKRbGEH6khdSO10qkyLsW
         Y5Nm2zNgaykxl8SnJAf4kt1xkQSWtFCQJ8KDZdxQTEoy+A05jeInqYeukNqMeaeQ1a
         O/UcrOLaeYNw3Tts8fMZ/UIA9eb0Ddm8aKyggggOXCLr9jHT//TZu3qNUlE9YGgMmc
         p4r8zeJRc4x07VrkM0BxrHO+7chfnfw5bE7058eWlu5/No8MJpz6hQpAHicio0xFzp
         Jd9b7H6q+ohQjJisy/HFWLLzxn8zimsfCwrJ+qywXyTTt4iczrAXzzLIsPIEDuNtQY
         Jzc7queYiYqhA==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, daniel@0x0f.com
Subject: [PATCH v4 4/6] staging: media: wave5: Add TODO file
Date:   Wed,  1 Dec 2021 19:56:11 +0200
Message-Id: <20211201175613.13710-5-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a TODO file listing all that is need for destaging.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/wave5/TODO | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 drivers/staging/media/wave5/TODO

diff --git a/drivers/staging/media/wave5/TODO b/drivers/staging/media/wave5/TODO
new file mode 100644
index 000000000000..425ed42a234c
--- /dev/null
+++ b/drivers/staging/media/wave5/TODO
@@ -0,0 +1,64 @@
+* Test on real silicon once available
+
+  This driver has so far been tested on pre-silicon FPGA and on the beta BeagleV
+  board which uses the StarFive JH7100 beta SoC.
+
+  Testing on FPGA shows it working fine, though the FPGA uses polled interrupts
+  and copied buffers between the host and it's on board RAM.
+
+  Testing on BeagleV shows buffer corruption that is currently attributed to a
+  known silicon issue in the SoC that makes the cache coherent interconnect not
+  so coherent.
+  This can likely be solved when the riscv non-coherent dma support lands and
+  provide optional v4l2 non-contiguous allocator, though it remains to be seen
+  whether support non-coherent use cases will be useful in real world hw.
+
+  Until we can test and resolve any issues on final silicon (due 2H 2021)
+  this driver should remain in staging.
+
+* Handle interrupts better
+
+  Currently the interrupt handling uses an unusual design employing a kfifo to
+  transfer irq status to irq thread. This was done as a work around for dropped
+  interrupts seen with IRQF_ONESHOT based handling.
+
+  This needs further investigation and fixing properly, with the aid of
+  C&M and StarFive engineers.
+
+* Fix early end of stream handling
+
+  When using a gstreamer pipeline like this:
+  gst-launch-1.0 filesrc location=<file> ! parsebin ! h264parse ! v4l2h264dec ! jpegenc ! identity eos-after=3 !  multifilesink location=%05d.jpeg
+  i.e. forced eos after 3 buffers
+  the pipeline stalls on exit waiting for end of job.
+  We need to add some form of early exit detection, instead of the current
+  behaviour of only considering a job finish on PIC_END.
+
+* Support more formats
+
+  The current frontend v4l2 layer only supports V4L2_PIX_FMT_HEVC and
+  V4L2_PIX_FMT_H264.
+  The backend logic supports other formats, so we should wire up the support
+  for further bitsream formats.
+
+* appropreate error handling:
+allocation failure, mutex acquire failure etc.
+
+* remove all unused struct fields
+
+* change struct fields to 'bool' type or bitfield when appropreate
+Likely good candidates are fields named '*_enable' , '*_on'
+
+* handle vdi_allocate_dma_memory failure , each function has to clean after itself
+
+* make sure that 'u32', 's32' etc. are only used when reading/writing hw
+and change s32 to u32 when s32 is not required
+
+* power management handling - add (runtime_)suspen/resume cb where the clock is enabled
+
+* fix checkpatch issues (mostly fixes , only left to fix MACRO_ARG_REUSE, LONG_LINE)
+
+* revise logic of wave5_vpu_(dec/enc)_register_framebuffer
+
+* check if the  normal kernel endianness/__swab32 routines are sufficient. (instead of the ones
+  implemented in the driver
-- 
2.17.1

