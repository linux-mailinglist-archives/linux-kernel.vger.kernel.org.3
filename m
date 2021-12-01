Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A455464F94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349898AbhLAO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhLAO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:28:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5206C061574;
        Wed,  1 Dec 2021 06:24:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b68so24585981pfg.11;
        Wed, 01 Dec 2021 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nqjIwk41+U9tH9eGUNa4mmueteq5RxG7HgTGB7HKEw=;
        b=HRVy0Wi/A0TE+Qh4oMjxWCoWKpQGZrhJrwtLf3lCRLWtxw7zazcBWCI06PUQER51u8
         B1sBrqfdc6icul15x5SAyP3YZ3ci45+7BJ4D3+pT+VKrnOXRYq/yzz+lU5DT6I7rVY4y
         Jzcei8vdj34llKWyPIlfvLeFqyIdau178sqjCjd/dg+BwGENCATh4sBo7UtjIgAePt1i
         flha/MzqVGioxlvGRQbBVnZiLtpkT9rdbqP1b4twmtYtJfFkh+ZQXBRt3rrWQDf6LiRv
         sX5w02bqE2WAjHcFGu9eFo6IBV9LKkeB/nIKxJ6w8r5fovjohhQ+jN1esM0qRKoVJLzD
         7kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nqjIwk41+U9tH9eGUNa4mmueteq5RxG7HgTGB7HKEw=;
        b=K9+Ndhp7mEA/hUoc/oOglhCGcbiwKkEb5wpLXlWxECSnXMNQY4ayKB3a/Z8SoBo1ul
         kvtdx4EDIPEQKL5/sxfCqm2Pqh6rjTwlviWloI0d1gXlMAeYP4aYI1CJLrFlz4iMNN3k
         3MGh0Qx54vsMsoskMZgS1P+W1HwBIIg+y1wGGUQ/7RpoH3h5j/gekvboKq+t/2EZcDNc
         mhMiwrQmg1/JVcuaU2F0wRBpjAsYcK1Z0Ttgx3YV6YF/2L/kfANrUnJsNudMUU2A5R/G
         xPxjbpBXgOyLX8Ibghr3LqpS0bADX8EG2umCVWrCRpcyYcoSXD244EAfnyIfZ9tS7kJ7
         a8vQ==
X-Gm-Message-State: AOAM5315XBy/FN4q8WL0Y6PE5vj/64ib04qpgQ7zeq6sXvQsO7mbtRWU
        TIofiLDI+5OM2nXA1nb0Tlk=
X-Google-Smtp-Source: ABdhPJyhWQxVQrsZzaIFTMTAEpHxBdK84+D+Vb58aq+d8wtkU/Slp1916zxM0upFzx4h23XtLNMLzQ==
X-Received: by 2002:a05:6a00:888:b0:4a8:56c:d2c with SMTP id q8-20020a056a00088800b004a8056c0d2cmr6578052pfj.40.1638368684323;
        Wed, 01 Dec 2021 06:24:44 -0800 (PST)
Received: from sbwpb-arch.flets-east.jp ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id o7sm18293825pgq.59.2021.12.01.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:24:43 -0800 (PST)
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1 1/1] media: atomisp: fix "variable dereferenced before check 'asd'"
Date:   Wed,  1 Dec 2021 23:19:04 +0900
Message-Id: <20211201141904.47231-1-kitakar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two occurrences where the variable 'asd' is dereferenced
before check. Fix this issue by using the variable after the check.

Link: https://lore.kernel.org/linux-media/20211122074122.GA6581@kili/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>

---

I didn't add the Fixes tag considering that the media_stage tree can
be rebased. Here is the commit of the media_stage tree pointed out in
the Link,

	c10bcb13462e ("media: atomisp: add NULL check for asd obtained from atomisp_video_pipe")

Can be applied on the top of media_stage tree.
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c   | 3 ++-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 5a90cc31cd1a..97d5a528969b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -5185,7 +5185,7 @@ static int atomisp_set_fmt_to_isp(struct video_device *vdev,
 	int (*configure_pp_input)(struct atomisp_sub_device *asd,
 				  unsigned int width, unsigned int height) =
 				      configure_pp_input_nop;
-	u16 stream_index = atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_index;
 	const struct atomisp_in_fmt_conv *fc;
 	int ret, i;
 
@@ -5194,6 +5194,7 @@ static int atomisp_set_fmt_to_isp(struct video_device *vdev,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_index = atomisp_source_pad_to_stream_id(asd, source_pad);
 
 	v4l2_fh_init(&fh.vfh, vdev);
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 562789c75299..8fd470efd658 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1182,7 +1182,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 	struct ia_css_frame *frame;
 	struct videobuf_vmalloc_memory *vm_mem;
 	u16 source_pad = atomisp_subdev_source_pad(vdev);
-	u16 stream_id = atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_id;
 	int ret = 0, i = 0;
 
 	if (!asd) {
@@ -1190,6 +1190,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_id = atomisp_source_pad_to_stream_id(asd, source_pad);
 
 	if (req->count == 0) {
 		mutex_lock(&pipe->capq.vb_lock);
-- 
2.34.1

