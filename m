Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5B46B2D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhLGG0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhLGG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:26:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA2C061746;
        Mon,  6 Dec 2021 22:22:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id j11so12855074pgs.2;
        Mon, 06 Dec 2021 22:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=z+i82pf+oH2BfYmnr5LAY+FtfcnUlpgUn61NQDZI6+Q=;
        b=RYxgRbnXRSlt7lEmSVIy3ZMGHYKbUjIsVie+ktGASJJFm9rxJ179XG7Uuq7G0nNNiA
         oPj569sIb2AVPhJgZblSFCB1JYMZi+CZWte6TZihnVjWkV1T7VD9y72SCS4G1PQz5o+r
         6sqsR4i7yLoSbHvNxek1PQzkAsY46bqeX0Ey7qdJHfuPv9d9MWCgU6w/Mufpk0pi50JH
         hsvkbNJa+KHHc31Sh2IApM5UfewohtcBItNbpuoNCm0+mbASi2/CVy9M+qo4Jfqjutoh
         28QcnW+QIDF0HVVibdO5fqlowT4q8YZXg3rDHcUDUqHDtPGT7iG0GZiigW18x/13swiZ
         jfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z+i82pf+oH2BfYmnr5LAY+FtfcnUlpgUn61NQDZI6+Q=;
        b=o/jBJgauyDuga3QuLm/5jkeKe+WpM7UTtfoDFrR7RhWt7s59kNJI0ZF0Yjr50lkSiy
         Gr30gMA+xq3a9EESLxNjUxPVydSarFlgm4VogLBuTf1FdZSH79PkbESI7AEI2p/w0cXV
         CF4ScDvAKjOMTqah1cesCvwYLvkA3VM96fraFfs/JTnx/O4UJ1doXTH6VyIxrk0u8fPb
         PvxUrR5AsaJQ3gWdwMhYWgOex9Bjv4WUJICjsZxe1GAIlb9l3J7Iqp5QC97X+FyVyQgZ
         GK5IgJRaKW9SpJ8OfMFkd/EKMGYhHPokvzoUXzISBe9Awn8TQprjbkVtFPMZ2KlpmhuM
         yoQw==
X-Gm-Message-State: AOAM5317tgeg/0fNibC3kP3/S8m3sRaM45UGeI4fH4Ko2ux4YQyJapc5
        ST2queHYVw8oqTkRYRWExuE=
X-Google-Smtp-Source: ABdhPJySIDZ7Z098kjh4TiUmhzUSxXSFE8mWkDahRVkEPeZcSozB3yinqpTyIjCqg2wolQZvdqVopQ==
X-Received: by 2002:a63:1c46:: with SMTP id c6mr15343714pgm.230.1638858152742;
        Mon, 06 Dec 2021 22:22:32 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:61:6687:fd10:b36d:bcea:520])
        by smtp.gmail.com with ESMTPSA id q11sm14703232pfk.192.2021.12.06.22.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 22:22:32 -0800 (PST)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     nishadkamdar@gmail.com, Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: core: Add support for the eMMC RTC feature in mmc_ops
Date:   Tue,  7 Dec 2021 11:51:55 +0530
Message-Id: <20211207062155.10689-1-nishadkamdar@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to set the RTC information in
the eMMC device. This is based on the JEDEC specification.

There is no way however, to read the RTC time from the
device. Hence we rely on the response of the CMD49 to
confirm the completion of the operation.

This patch has been tested successfully with the ioctl
interface. This patch has also been tested suceessfully
with all the three RTC_INFO_TYPEs.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
  - Use sizeof(seconds) instead of sizeof(u64)
  - Drop out: and the assignment of err to 0
  - Keep 512 value as it is as no #define available for the same and
    other functions in the file use the 512 value

 drivers/mmc/core/mmc_ops.c | 56 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |  2 ++
 include/linux/mmc/mmc.h    |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d63d1c735335..d3ca68585c71 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1063,3 +1063,59 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_sanitize);
+
+int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
+		 u8 rtc_info_type, u64 seconds)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+	int err;
+	u8 *data_buf;
+
+	data_buf = kzalloc(512, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	if (rtc_info_type == 0x01 || rtc_info_type == 0x02 ||
+	    rtc_info_type == 0x03) {
+		data_buf[0] = 0x01;
+		data_buf[1] = rtc_info_type;
+		memcpy(&data_buf[2], &seconds, sizeof(seconds));
+	} else {
+		pr_err("%s: invalid rtc_info_type %d\n",
+		       mmc_hostname(host), rtc_info_type);
+		kfree(data_buf);
+		return -EINVAL;
+	}
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	cmd.opcode = MMC_SET_TIME;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	data.blksz = 512;
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+	sg_init_one(&sg, data_buf, 512);
+
+	mmc_set_data_timeout(&data, card);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (cmd.error)
+		err = cmd.error;
+	else if (data.error)
+		err = data.error;
+	else
+		err = 0;
+
+	kfree(data_buf);
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_set_time);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9c813b851d0b..0c8695d1b363 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -55,6 +55,8 @@ void mmc_run_bkops(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
+int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
+		 u8 rtc_info_type, u64 seconds);
 
 #endif
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..52a3bf873d50 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -64,6 +64,7 @@
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 #define MMC_PROGRAM_CID          26   /* adtc                    R1  */
 #define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+#define MMC_SET_TIME	         49   /* adtc                    R1  */
 
   /* class 6 */
 #define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
-- 
2.17.1

