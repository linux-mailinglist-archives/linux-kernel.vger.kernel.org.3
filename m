Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202F5047A4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiDQLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiDQLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 07:19:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBEDFE;
        Sun, 17 Apr 2022 04:16:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y10so5171119ejw.8;
        Sun, 17 Apr 2022 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfrGP66WrBzG96HgL3U6ijgtUczQ+IlvOu7P8DwUlvM=;
        b=ZB83+qeHedQQtzaBLhpm3L6S6LIsC9/o4/molKhfmELh8L1G/bEFe9WwSEzMw+OqvT
         qFlhIW199EenZhCv1I/EFS4KU42rrmKnCkir7bWaYKnLwRCelRhAfGsfNcuGrDWMa20W
         sbi4Yp5/maKStJepbAVLyg+BOebWK+XgdakdOXPO60vJXuxtsOhfH9NhBS76I3pjc7Ns
         ottuJiGdepNkj34SlF1MZxg9QFBYARk6i0h6rc9zx9qnwllF28LPTvv441fErJq1woLH
         NsX1izlLDIJsznX2FQa1uZa5ANfFKmpbloaGZ0s+9bgxnSpsn+UOzYqwqS+4Zn/c+4MC
         a1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfrGP66WrBzG96HgL3U6ijgtUczQ+IlvOu7P8DwUlvM=;
        b=Fpk81Ov36+Lc5L320JbsAD3/i2sIDShdycz/GJx3ykmis3OCqIJ06D/Qjzp5K4RMmM
         KgJzUOVP7SqLn+5yhuqQbuhrKhkwaxbSQxkbY0A+HZLZdrgn/YOEsX6XUmMSZbVJq89U
         nH8RICUmgmhP7FTB3cRYdPhaZfaJYUD31irFjP8Gr/IeUg4eQPfYex0x70HQOYDRHPhe
         Yk22K0oawujGbST7xY9vMAtBZO6c/oqdLQ99haTJvozTpAffQVYwXr0s1OQ5Yeg9sb+y
         b/MjO0K2rzx+HfTTr+jheBr8dmViDz7RWf/W3u1ttXOPeiH58NaWXevCvDAeHvUmM86O
         5VzQ==
X-Gm-Message-State: AOAM533NssDJf97D+Ck1fIt3Z8YlDThfUEFRhdfCYoCgcLxrnyHrGvd+
        x9HiS7MWyo5B1VeHehDOlHA=
X-Google-Smtp-Source: ABdhPJw8HRXHjTVCpDQTfZ9mTOXxcxmnwKmFv6EWI+KoSU4WmVrMgCHSOyJFEYXJVR7yOIhU05dV7w==
X-Received: by 2002:a17:906:4fc7:b0:6da:92b2:f572 with SMTP id i7-20020a1709064fc700b006da92b2f572mr5416606ejw.184.1650194196556;
        Sun, 17 Apr 2022 04:16:36 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id i3-20020a056402054300b00423133147cesm2948781edx.38.2022.04.17.04.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 04:16:36 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        jakob.rossler@nokia.com, Avri.Altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 RESENT] mmc-utils: Add General command CMD56 read support
Date:   Sun, 17 Apr 2022 13:16:22 +0200
Message-Id: <20220417111622.621650-1-huobean@gmail.com>
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

We can use GEN_CMD (CMD56) to read a  data block with vendor-specific
format and meaning, which is very helpful and useful for customers to
analyze device health. This patch is to add support for this command.

At the same time, in order to make CMD56 universal, let more users of
mmc-utils can benefit from this. We will allow the user to enter [arg]
for special commands. Because some eMMC vendors provide an additional
set of commands beyond the GEN_CMD (CMD56) definition in the JEDEC
specification. These additional commands are implemented using generic
CMD56 commands, and they return a wealth of useful information about the
state of the NAND device. For these special purposes, the [31:1]stuff
bits in the CMD56 argument are used. You can refer to  Micron eMMC
"TN-FC-32: e·MMC Device Health Report" as an example.

I didn't add data parsing, just print the raw data as it is vendor-specific.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <Avri.Altman@wdc.com>
Tested-by: Rossler Jakob (Nokia - DE/Ulm) <jakob.rossler@nokia.com>
---
V2:
 1. Fix coding type issue
 2. Add CMD56 argument default value 0x01 support, make [arg] optional
---
 mmc.c      |  8 ++++++++
 mmc.h      |  2 ++
 mmc_cmds.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 68 insertions(+)

diff --git a/mmc.c b/mmc.c
index eb2638b12271..6c563879cf1a 100644
--- a/mmc.c
+++ b/mmc.c
@@ -237,6 +237,14 @@ static struct Command commands[] = {
 		"secure-trim1 | secure-trim2 | trim \n",
 	NULL
 	},
+	{ do_general_cmd_read, -1,
+	"gen_cmd read", "<device> [arg]\n"
+		"Send GEN_CMD (CMD56) to read vendor-specific format/meaning data from <device>\n\n"
+		"NOTE!: [arg] is optional and defaults to 0x1. If [arg] is specified, then [arg]\n"
+		"must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [arg] must\n"
+		"be 1.",
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
index 49d3e324d266..bb0f0226bf23 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2981,3 +2981,60 @@ out:
 	return ret;
 #endif
 }
+
+int do_general_cmd_read(int nargs, char **argv)
+{
+	int dev_fd;
+	char *device;
+	char *endptr;
+	__u8 buf[512];
+	__u32 arg = 0x01;
+	int ret = -EINVAL, i;
+	struct mmc_ioc_cmd idata;
+
+	if (nargs != 2 && nargs != 3) {
+		fprintf(stderr, "Usage: gen_cmd read </path/to/mmcblkX> [arg]\n");
+		exit(1);
+	}
+
+	device = argv[1];
+	dev_fd = open(device, O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open failed");
+		exit(1);
+	}
+
+	/* arg is specified */
+	if (nargs == 3) {
+		arg = strtol(argv[2], &endptr, 16);
+		if (errno != 0 || *endptr != '\0' || !(arg & 0x1)) {
+			fprintf(stderr, "Wrong ARG, it should be Hex number and bit0 must be 1\n");
+			goto out;
+		}
+	}
+
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

