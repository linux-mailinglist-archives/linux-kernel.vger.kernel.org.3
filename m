Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA6531356
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiEWOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiEWOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:43:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4EF473AE;
        Mon, 23 May 2022 07:43:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c14so13919626pfn.2;
        Mon, 23 May 2022 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myT6Fqbqu1LXacuDQiYi2tYK9nlNzCLLy9owGdyn/GM=;
        b=W40Zi+DyWWgFk6zFggk1cM4+12Ds4CLiWxJJFIDCHVXXfyZ8Ad7Cqymjsn1kfL8jkv
         nicUZszJNr5iELKl2BnH40TNaf8VmqkNmstv8EuCzvV/9LsKDXT9DaMPoeb/tUSM/7Ea
         idPCl3UFMH9bUO0zky1Ig2MFMJT0VA9o4O3uWdp7NlycKRqaAXTb4+dbwEeIw/2EAh39
         IyVaGbrtl2LNmWaGYYRz5wul6aoaS7lXvjqDT5xYJvlJJzQeMNPbgQiUKnmE8nOIozqc
         5Dm5He0lxBru+N6WH0o+8ItFZ8380cIozkrcBwM1DlBkDL1i9PpJIEnNk9z5JOMm2gSM
         yETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myT6Fqbqu1LXacuDQiYi2tYK9nlNzCLLy9owGdyn/GM=;
        b=DJhmo0U2XjahFsIpT0XnBaSqjP7NIDX5Omqxd5EUX1TnqA5ogntomP7wHduwEl9a0x
         EvNVL6kcRqIydfqocYbvzZY6HqHK74x7F0xClEjPr9qM2Nmqp1BM9wMmcklPazg+evbO
         NqHA3yCuaqvq9U6fMsYREB9VtSBv4rYJsh1XE4/sQR+3lkKhyKpw79aORH2Dn3uD8JSC
         daEUSdvCSTT+LsfqJjYQ838RYw55VTlKYqEYTzF23XkvRYFcJFNImJbDtihA3Cedjhik
         reOMNVENpxoPf41ttCoJyEY6r7XKgGpdi4pwnh15ILu2522QC5+vg2UTzH5cmi24BWCJ
         +XYw==
X-Gm-Message-State: AOAM531n0W92XfKVeIU9nS178M/aHQrQQx+swOLsDj7IjKVciPzFYLPT
        L5FzguTNFa142N63MLl1Y/8=
X-Google-Smtp-Source: ABdhPJzxucuNqwrbGbtCTMKQBFrCjgq5q/YqLdQJUtRcvT+v69kGz63GH3c5bW+pWxOxdNB+QMbYLQ==
X-Received: by 2002:a05:6a00:10cc:b0:505:ada6:e03e with SMTP id d12-20020a056a0010cc00b00505ada6e03emr24006767pfu.45.1653316983287;
        Mon, 23 May 2022 07:43:03 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id jb15-20020a170903258f00b0015e8d4eb256sm5218430plb.160.2022.05.23.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:43:03 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        yangbo lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mmc: sdhci-of-esdhc: Fix refcount leak in esdhc_signal_voltage_switch
Date:   Mon, 23 May 2022 18:42:54 +0400
Message-Id: <20220523144255.10310-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() checks null pointer.

Fixes: ea35645a3c66 ("mmc: sdhci-of-esdhc: add support for signal voltage switch")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d9dc41143bb3..8b3d8119f388 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -904,6 +904,7 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
 		scfg_node = of_find_matching_node(NULL, scfg_device_ids);
 		if (scfg_node)
 			scfg_base = of_iomap(scfg_node, 0);
+		of_node_put(scfg_node);
 		if (scfg_base) {
 			sdhciovselcr = SDHCIOVSELCR_TGLEN |
 				       SDHCIOVSELCR_VSELVAL;
-- 
2.25.1

