Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F7468CF1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhLETOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 14:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhLETOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 14:14:23 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820DC061714;
        Sun,  5 Dec 2021 11:10:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 133so8365524pgc.12;
        Sun, 05 Dec 2021 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7PKgcD6CRCuYFewb9iDJgPShfY4HlviRqF3QruuqdzA=;
        b=qfIwd3xDhzKU0oh3atB+ZSXfCDuF7515eeR7AmkbLjsNQIyrkrwn8LbtT9GqoZaA6t
         KVuusEqUvYJwxPvftL85ChNLYpwO9hYhQhm+Oog2X0M73Pj/+4IWqnVErXYtMl9/UDZD
         ELC4Xe8+WnhIqCbuossb7tfZfYoUKM5h5KSFxZIbF6/u4ZkKGrOIWMuF4zP/lO0gOBeC
         KoI3Y/lZjah04JQu4dMze6L38D4fVmiDheI9Jc331a3csP86O3qN4piGI46Rxee6s0wh
         6T02e6X1D3+Dz11SMe3QoghMvojjwC1I+DVONOjUOstfVSWjmRu3VUD+c4yARob0Gv6v
         Mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7PKgcD6CRCuYFewb9iDJgPShfY4HlviRqF3QruuqdzA=;
        b=am8RkJ9Uw1t0cPOfgct2SFRXBMOeCA9QGj6tzOGrPerpzGVM+qPttZOGq+VGmtcxOq
         rwxpvyU2DbBJ5fqTYJ6OKMdU1rK0mS9zCVjbhvsGUKD5SpBO1JWVaV/QWUZVfg1wpJ2K
         CV62JhdUBzB/N5wEF2o0ijemEGahGtLgU1zUWiZLSMuudevydXt/MpXMoP30u1rH7RUK
         Imw6SzUEASSdRVtP85UzGHKAHwZZm4BhvLvs/wxYSXOZcJUdNw9uGaYWYAB+S1gI8AMF
         Xj+o638Fq87Ww+/XQ/eefWxG0wb16K13U6mwwrBJWfMyYJSXQabuJK7nIvUrCA2svwfF
         wALA==
X-Gm-Message-State: AOAM533GDc71BqKajwYjLNxMlsb7+sCrMicf6f4iNT5PiobUEZWtU0o+
        0VD+l/MSduqstUJP7s11aNFqfDDT8AXdTdUQHkQ=
X-Google-Smtp-Source: ABdhPJxkWomqIVIog9yiMR7bm0QA1Ot51gkjyKc2c+3MHOQJpj6lt3TxALWaZS79ERgAAc36BtTxww==
X-Received: by 2002:a05:6a00:10d2:b0:4a8:3613:c475 with SMTP id d18-20020a056a0010d200b004a83613c475mr32327924pfu.0.1638731456032;
        Sun, 05 Dec 2021 11:10:56 -0800 (PST)
Received: from localhost.localdomain ([49.207.207.227])
        by smtp.gmail.com with ESMTPSA id t7sm10720797pjs.45.2021.12.05.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 11:10:55 -0800 (PST)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Add support for the eMMC RTC feature in mmc_ops
Date:   Mon,  6 Dec 2021 00:40:08 +0530
Message-Id: <20211205191009.32454-1-nishadkamdar@gmail.com>
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
 drivers/mmc/core/mmc_ops.c | 59 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |  2 ++
 include/linux/mmc/mmc.h    |  1 +
 3 files changed, 62 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d63d1c735335..490372341b3b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
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
+	int err = 0;
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
+		memcpy(&data_buf[2], &seconds, sizeof(u64));
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
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+out:
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

