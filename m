Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C527588220
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiHBS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiHBSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:55:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982A140CB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:55:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 1-20020a17090a190100b001f05565f004so6539286pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=DaRQ2izucvqnfyvR2TmA8t9g6dOpwwmSS0DB8AAt990=;
        b=Ly/T2amXaGhpFs2B6F33kLC4xhEqMWV/njDT98eEk+lNKHotckSXgbK21dcXaRSkEJ
         xC4TY/pNLC0vKpjDH+hWyM/8Z5B509hJThDN0jNXjV1sIfFO1tIamw71iNskhvacGwXV
         dNKqw6o07cOIHW3GzxTWOIPg3BuCP9Mqu7z7XruKYJrZ6z0gc5FVfJKTGkVGLORTfSfo
         6hIaTTFDAMJtB/Upablei5j9czw7XRYowNd3SzztxYpfPdBQw5IDAM2Hb90NJx2QANVi
         WAW5/rZm+PxZmTV2nYO6O88EaUfncGhGnRn55ABJKqvwFrgAmkS+14oZlQLEuNedYMbf
         JCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=DaRQ2izucvqnfyvR2TmA8t9g6dOpwwmSS0DB8AAt990=;
        b=jaLpAoGaqFNLwknhVAg/uNby6ZYAToisIvgIyWLXrrg5eFHXaM4M1aJWeUwt6ABIUZ
         ZOn9vMKhH1X7OFd2py0uK9bzhs4JuKbPei32VMgOibbLp8fsqCHac4dUr8UBhmXfSxmj
         kgTOkV79yBjKW6GOPhWVc4argvVOPb77P/BulFY2uh9DVf4JHfsA2AFytbMCWphCEWld
         G3fpHCxK8OsrzYIUf1ejOVu9Ti9KYwVKU72YLM1uX5fyenmoOrTXP8FNqF7vvTNreq6h
         bw7ORcMxojB6TAzo6S6dO05Hvq3h8+TtJ6HX3Oyw23PCCmVgH8l/Bebo8UvLKC0yTiNh
         zsNw==
X-Gm-Message-State: AJIora875V5V7qfqfYEdC5EJ3vIoQLQSYrcNpi2Er7bYBahd9Brxr8gU
        kKV6h9XIMa9MCCKEzZKH/3gflV8QI/I=
X-Google-Smtp-Source: AGRyM1sWB3iGMjsNkKLdcbRYMAQl1qXz8lJEvDNwsSlg1g42TIIMXnJD1yEZwFLFr4gUcVdMpKbsvK5T7XDO
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a63:43c2:0:b0:41a:9dea:5dac with SMTP id
 q185-20020a6343c2000000b0041a9dea5dacmr17694202pga.585.1659466552250; Tue, 02
 Aug 2022 11:55:52 -0700 (PDT)
Date:   Tue,  2 Aug 2022 18:55:34 +0000
In-Reply-To: <20220802185534.735338-1-jackyli@google.com>
Message-Id: <20220802185534.735338-3-jackyli@google.com>
Mime-Version: 1.0
References: <20220802185534.735338-1-jackyli@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 2/2] crypto: ccp - Fail the PSP initialization when writing
 psp data file failed
From:   Jacky Li <jackyli@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the OS continues the PSP initialization when there is a write
failure to the init_ex_file. Therefore, the userspace would be told that
SEV is properly INIT'd even though the psp data file is not updated.
This is problematic because later when asked for the SEV data, the OS
won't be able to provide it.

Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
Reported-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Jacky Li <jackyli@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 5bb2ae250d38..fd6bb01eb198 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -233,7 +233,7 @@ static int sev_read_init_ex_file(void)
 	return 0;
 }
 
-static void sev_write_init_ex_file(void)
+static int sev_write_init_ex_file(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct file *fp;
@@ -243,14 +243,15 @@ static void sev_write_init_ex_file(void)
 	lockdep_assert_held(&sev_cmd_mutex);
 
 	if (!sev_init_ex_buffer)
-		return;
+		return 0;
 
 	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
 	if (IS_ERR(fp)) {
+		int ret = PTR_ERR(fp);
 		dev_err(sev->dev,
 			"SEV: could not open file for write, error %ld\n",
-			PTR_ERR(fp));
-		return;
+			ret);
+		return ret;
 	}
 
 	nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
@@ -261,18 +262,20 @@ static void sev_write_init_ex_file(void)
 		dev_err(sev->dev,
 			"SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
 			NV_LENGTH, nwrite);
-		return;
+		return -EIO;
 	}
 
 	dev_dbg(sev->dev, "SEV: write successful to NV file\n");
+
+	return 0;
 }
 
-static void sev_write_init_ex_file_if_required(int cmd_id)
+static int sev_write_init_ex_file_if_required(int cmd_id)
 {
 	lockdep_assert_held(&sev_cmd_mutex);
 
 	if (!sev_init_ex_buffer)
-		return;
+		return 0;
 
 	/*
 	 * Only a few platform commands modify the SPI/NV area, but none of the
@@ -287,10 +290,10 @@ static void sev_write_init_ex_file_if_required(int cmd_id)
 	case SEV_CMD_PEK_GEN:
 		break;
 	default:
-		return;
+		return 0;
 	}
 
-	sev_write_init_ex_file();
+	return sev_write_init_ex_file();
 }
 
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
@@ -363,7 +366,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 			cmd, reg & PSP_CMDRESP_ERR_MASK);
 		ret = -EIO;
 	} else {
-		sev_write_init_ex_file_if_required(cmd);
+		ret = sev_write_init_ex_file_if_required(cmd);
 	}
 
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-- 
2.37.1.455.g008518b4e5-goog

