Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872885047A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiDQLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiDQLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 07:12:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAEBBAB;
        Sun, 17 Apr 2022 04:10:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b15so14728074edn.4;
        Sun, 17 Apr 2022 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scbjRhQc3dC9uDF//ZfZgBhT9QtztPDwfTGJnmb4ISg=;
        b=h3IZfSoIP7/Hmyn5pnGsTIEOlEKL3fP+UsSqfFr0aSQw8vhp8VaGclKalQIB66fy63
         kAJRkXG6a5SvBFtm63pDQgbnbwmaM2Y7XuddtkOptmLMWcGVqm/7wAexHdtyFTYTxktd
         sAddoDsaQKjensJ0AAawyBpATA3OLnhHyPtZAnb9Znh/V8k2eqtgtQp6F7juNKE2kJfJ
         yM9EZKb4uz14iFQOta+xH/JeES95w+UbrS3l6NRMu6PGRjdetxrR6nit8uzE/Ves+4lm
         tr/IxTnEr6b2O703juMYKflvQOdbCxXrFHNG2wxJqhv3RaSe6xfox9RFRzn6KbU2DdGP
         rDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scbjRhQc3dC9uDF//ZfZgBhT9QtztPDwfTGJnmb4ISg=;
        b=MnTliuDmAbfPdG7AP/V+/6WNIYtm8ndGyBLcspGOA+wZAxtCNLLMQLUORwnQ1kRYPv
         K601nANfxlUQxvRn9qE3uuygXJgkJAQjNusFQ4T5wmu5SHp9lJ7DBM/eVH41MAykIwPr
         2cvVEbUJyOZzmzJmjknlZyrMaVeT2qXSz94a8QBdADiAXGk0rcsbIfSdYfgSJ4hyjoQa
         BoRgu84m0CL6Z/jvgv0Zusy85nhEaYGEUohrzB3OOSOnim8JxmOxy7eS16unErwUw39B
         0jNDfuINGB8U+rAaR3AZFa5GnzZfWzAMh9kKSicR2Vtl9P38s+beO3IIEz2p37OyW43m
         L+EQ==
X-Gm-Message-State: AOAM530jxNw5n3BGFPjBZawsmq8EI0qZzWatTLhIV5PXm5Gcu0Itzn4E
        h66eivzdjUSsB+hUYz6ViCQ=
X-Google-Smtp-Source: ABdhPJwbNM8JKHydXAk5G7aF0sEd/dSgHhBYR4n2/QrIrj5J3nFjFKBveurtwJ5VzQ0ex/QQJt0djg==
X-Received: by 2002:a05:6402:1d55:b0:423:e3a9:d455 with SMTP id dz21-20020a0564021d5500b00423e3a9d455mr1505245edb.340.1650193800248;
        Sun, 17 Apr 2022 04:10:00 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id j2-20020a056402238200b0041f351a8b83sm5382386eda.43.2022.04.17.04.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 04:09:59 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        jakob.rossler@nokia.com, Avri.Altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2] mmc-utils: Add General command CMD56 read support
Date:   Sun, 17 Apr 2022 13:09:34 +0200
Message-Id: <20220417110934.621035-1-huobean@gmail.com>
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

