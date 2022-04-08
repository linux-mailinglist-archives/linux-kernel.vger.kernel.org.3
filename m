Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB44F9C01
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiDHRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiDHRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:50:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9940BF947;
        Fri,  8 Apr 2022 10:48:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so18770915ejd.3;
        Fri, 08 Apr 2022 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dYMooINZBesZgE+qatHQg2DcF3xb71Lnrv9t8f9hFE=;
        b=mJSARCmDj7mvEdVm4LUW8tlKV5ZElMGZfO2fPLhyqzHIzl3y20W7IVKyfZmJPOjD0A
         xbMhzT6SkWuSQ33KIdYEXcm3uX/eQpod49u6ikQV0lXivg+Mfbk+hRDiUw77vUZ1/+NQ
         YE+G0D8zjG5Uh1YHzHlNfAkY7yNF8adKNthr9F0DpQhD+ckMxfW0Lqdvd2Ictu/X21kO
         AqRM8UxZfst7TxtSzZR8kevNOYLuEBuH0i+ESYBAorzi9A1JEmlKheUs3rez2ndS0csB
         PEgjDsgvlXYKMwXuS8xNfMuE8ZgKMQayFGmMoNClN8XW8O+vMmqxV+nIGjxdgMjDDBWm
         IAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dYMooINZBesZgE+qatHQg2DcF3xb71Lnrv9t8f9hFE=;
        b=OCW3kXDhORV7AmkkJpgusyNFpHBwMXMkciCEFPAd5wI1goanA2zqp54rCMKvYAzgnH
         j0QSdjI5+VWTr6Naubqw9szr+WmO8AwFzFvcJs176t037JIY20U5rzND6JJudiOW+6zT
         Q07R4GVWWB22b1qKDypxjNxdABHPTBSAiY7Rz2eZNyRTqmCdR+hAPoQQ6VVgX29SWra7
         uj1PRsvgAPodjjGY5WK05Yim2Gb/SQtfErrD/wWTCcPvXkBtMoMtROC3wk06ILLHbsnM
         zjXck8kSkRVHu2lYLv6OHDiSEnFaMbgwJZ6xnWFx1c8kAQB5eohiVeyBMt5oDIU8tAU+
         oOOw==
X-Gm-Message-State: AOAM533ZQJDKnJYYZxLLRzfwOpMT1yEfAkj40bfrOvab2YH9xebQ62Ha
        RePMNNufDGtfVxe8RK7N5TMD+wWOHZY8tA==
X-Google-Smtp-Source: ABdhPJygv+AX+HiGiURYc2MGuFx9svBO5zEHUCxAXyqMDd394Zipfk1quOQo/017eoEzkg4iDbFp2g==
X-Received: by 2002:a17:907:2d93:b0:6db:ab5e:7e0b with SMTP id gt19-20020a1709072d9300b006dbab5e7e0bmr19341556ejc.262.1649440121391;
        Fri, 08 Apr 2022 10:48:41 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id gh9-20020a1709073c0900b006e803954409sm4487654ejc.5.2022.04.08.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:48:41 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jakob.rossler@nokia.com, sperson@micron.com,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1] mmc-utils: Add General command CMD56 read support
Date:   Fri,  8 Apr 2022 19:48:32 +0200
Message-Id: <20220408174832.303915-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Micron eMMC offers an additional set of commands that go beyond the JEDEC Device
Health Report. These additional DEVICE HEALTH commands are implemented using the
generic CMD56 command and they return a significant amount of useful information
about the status of the NAND device. Such as bad block counters, block erase
counters ,etc. For more information, refer to TN-FC-32: e·MMC Device Health Report.

Since the CMD56 is specified in JEDEC, to make CMD56 universal used and let more
users of mmc-utils get the benefit for this. I add CMD56 read, and let the user
to input the CMD56 argument, also, here I didn't add data parsing, just print raw
data, since it is vendor-specific.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c      |  7 +++++++
 mmc.h      |  2 ++
 mmc_cmds.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 62 insertions(+)

diff --git a/mmc.c b/mmc.c
index eb2638b12271..ea465e59fdf3 100644
--- a/mmc.c
+++ b/mmc.c
@@ -237,6 +237,13 @@ static struct Command commands[] = {
 		"secure-trim1 | secure-trim2 | trim \n",
 	NULL
 	},
+	{ do_general_cmd_read, -2,
+	"gen_cmd read", "<arg> <device>\n"
+		"Send GEN_CMD (CMD56) with specific <arg> to  <device> to read vendor\n"
+		"specific data. <arg> must be 32 bits length hex number prefixed with 0x/0X.\n\n"
+		"NOTE!: Because this option is only used to read, the bit0 in <arg> must be 1",
+	NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 25d6864ac76f..b621374a1ed1 100644
--- a/mmc.h
+++ b/mmc.h
@@ -41,6 +41,8 @@
 					      [1] Discard Enable
 					      [0] Identify Write Blocks for
 					      Erase (or TRIM Enable)  R1b */
+#define MMC_GEN_CMD		56   /* adtc  [31:1] stuff bits.
+					      [0]: RD/WR1 R1 */
 
 #define R1_OUT_OF_RANGE         (1 << 31)       /* er, c */
 #define R1_ADDRESS_ERROR        (1 << 30)       /* erx, c */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 49d3e324d266..6e006b10d4fd 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2981,3 +2981,55 @@ out:
 	return ret;
 #endif
 }
+
+int do_general_cmd_read(int nargs, char **argv)
+{
+	int dev_fd;
+	__u8 buf[512];
+	__u32 arg;
+	char *device;
+	char *endptr;
+	int ret = -EINVAL, i;
+	struct mmc_ioc_cmd idata;
+
+	if (nargs != 3) {
+		fprintf(stderr, "Usage: gen_cmd read <arg> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	device = argv[2];
+	dev_fd = open(device, O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open failed");
+		exit(1);
+	}
+	arg = strtol(argv[1], &endptr, 16);
+	if (errno != 0 || *endptr != '\0' || !arg&0x1) {
+		fprintf(stderr, "Wrong ARG, it should be Hex number and bit0 must be 1\n");
+		goto out;
+	}
+	memset(&idata, 0, sizeof(idata));
+	idata.write_flag = 0;
+	idata.opcode = MMC_GEN_CMD;
+	idata.arg = arg;
+	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata.blksz = 512;
+	idata.blocks = 1;
+	mmc_ioc_cmd_set_data(idata, buf);
+
+	ret = ioctl(dev_fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		perror("ioctl");
+		goto out;
+	}
+
+	printf("Data:\n");
+	for (i = 0; i < 512; i++) {
+		printf("%2x ", buf[i]);
+		if ((i + 1) % 16 == 0)
+			printf("\n");
+	}
+out:
+	close(dev_fd);
+	return ret;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 8331ab2373fd..0f7c0041f753 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -46,3 +46,4 @@ int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
 int do_erase(int nargs, char **argv);
+int do_general_cmd_read(int nargs, char **argv);
-- 
2.34.1

