Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD155C927
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiF0KIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiF0KIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:08:44 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FA63B9;
        Mon, 27 Jun 2022 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656324523;
  x=1687860523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfH4/auxP0BAKuTQeGybZpgGABQyp48s3Z6um0lD/Hs=;
  b=fWZ21eVjCbKnjljkJYQjleMbQf4e8TtlglcW8XlUr+q601bze3yiwO17
   QwqZvYWhAyXbflR3EbzSqJWEDiq8+hBOzdikgi1nqIsnVUx81IJtsiZTr
   Ko3tqTqY7KauVnfPAvzfy4W+xaDUCQGMr8B2t2LSXM+s/gzjGgK6Zj2y8
   DVnR6vmquVzzRakwdRTh4znVXVx/XtwoGznUWPhwZhqyARHjyLZ+Ymvtp
   yBKpEkh6v0HxMGyPCiUw3GQMHEfrKbGF7P+23Qd7UEWUG7wbXpK7hbG/6
   lKB6TpOxNok7i3rev+zpYojVX5dD1fJoHiEoyoCBP9HgI5EoyFDvSY+jH
   Q==;
Date:   Mon, 27 Jun 2022 12:08:40 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: Allow speed modes to be adjusted via module
 param
Message-ID: <20220627100840.GA12705@axis.com>
References: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
 <CAPDyKFpg9Gs3qOeXWM2A1gSDEKA89i72NoTcF0M_a3jO-AC+dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpg9Gs3qOeXWM2A1gSDEKA89i72NoTcF0M_a3jO-AC+dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 03:53:41PM +0200, Ulf Hansson wrote:
> On Thu, 23 Jun 2022 at 10:00, Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > During board verification, there is a need to test the various supported
> > eMMC/SD speed modes.  However, since the framework chooses the best mode
> > supported by the card and the host controller's caps, this currently
> > necessitates changing the devicetree for every iteration.
> >
> > To make changing the modes easier, allow the various host controller
> > capabilities to be cleared via a module parameter.  (A per-controller
> > debugfs wouldn't work since the controller needs to be re-probed to
> > trigger re-init of cards.  A module parameter is used instead of a
> 
> I think we could make use of a per-controller debugfs thing, if used
> in combination with MMC_CAP_AGGRESSIVE_PM and runtime PM.
> 
> As runtime PM also has sysfs interface for each device, we can control
> runtime PM for the card's device (to trigger re-initialization of the
> card). In between runtime suspend/resume of the card's device, we
> should be able to change the supported speed modes, through debug fs.
> 
> Would this work for you?

I got it to work with the below commands and the following patch.  Note
that:

(1) MMC_CAP_AGGRESSIVE_PM also needs to be turned on via debugfs to
    avoid having to patch the kernel.  The cap is checked on every call
    to runtime_suspend so it (currently) works to set it without
    re-probing the host.

(2) I had to call mmc_select_card_type() even if there is an old card
    since currently it's only called from mmc_decode_ext_csd().

Also, unlike the module parameter, this can't be set from bootargs, but
that part is not important for my use case.

 root@(none):/sys/kernel/debug/mmc0# grep timing ios
 timing spec:	9 (mmc HS200)
 
 // Turn on MMC_CAP_AGGRESSIVE_PM and re-trigger runtime suspend
 root@(none):/sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
 root@(none):/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
 root@(none):/sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control
 
 // MMC_CAP2_HS200_1_8V_SDR
 root@(none):/sys/kernel/debug/mmc0# echo $(($(cat caps2) & ~(1 << 5))) > caps2
 root@(none):/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
 root@(none):/sys/kernel/debug/mmc0# grep timing ios
 timing spec:	8 (mmc DDR52)

8<----
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 3fdbc801e64a..721925300611 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -12,9 +12,12 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/fault-inject.h>
+#include <linux/time.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
 
 #include "core.h"
 #include "card.h"
@@ -223,6 +226,47 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
+static int mmc_caps_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int mmc_caps_set(void *data, u64 val)
+{
+	u32 *caps = data;
+	u32 diff = *caps ^ val;
+	u32 allowed = MMC_CAP_AGGRESSIVE_PM |
+		MMC_CAP_SD_HIGHSPEED |
+		MMC_CAP_MMC_HIGHSPEED |
+		MMC_CAP_UHS |
+		MMC_CAP_DDR;
+
+	if (diff & ~allowed)
+		return -EINVAL;
+
+	*caps = val;
+
+	return 0;
+}
+
+static int mmc_caps2_set(void *data, u64 val)
+{
+	u32 *caps = data;
+	u32 diff = *caps ^ val;
+	u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
+
+	if (diff & ~allowed)
+		return -EINVAL;
+
+	*caps = val;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps_fops, mmc_caps_get, mmc_caps_set, "0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps2_fops, mmc_caps_get, mmc_caps2_set, "0x%08llx\n");
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -231,8 +275,10 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	host->debugfs_root = root;
 
 	debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
-	debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
-	debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
+	debugfs_create_file("caps", S_IRUSR | S_IWUSR, root, &host->caps,
+			&mmc_caps_fops);
+	debugfs_create_file("caps2", S_IRUSR | S_IWUSR, root, &host->caps2,
+			&mmc_caps2_fops);
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..c79c26add3da 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1730,7 +1730,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		/* Erase size depends on CSD and Extended CSD */
 		mmc_set_erase_size(card);
-	}
+	} else
+		mmc_select_card_type(card);
 
 	/* Enable ERASE_GRP_DEF. This bit is lost after a reset or power off. */
 	if (card->ext_csd.rev >= 3) {
