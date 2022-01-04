Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1669B4846A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiADRGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:06:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiADRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:05:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B8A87210DE;
        Tue,  4 Jan 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641315926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AfBngmkoikoFNur2GoLsVjxFAUjb8tl7MPdE1R0s/Q0=;
        b=b1VRJhKEXvbfDICsAbwkVXPH3dXdD+z6G9hT6HSf+Q9cREWiV/aNcitWK8tU55SX5Hbw6J
        ZdnOlAujzbA5EvJoEDtgFvJcBHqcHqx93UDWBnikAmXb9phnMHOzcjKNZU0hV6n3IHu+6s
        myMEjy4J2GO2vrtAcvIH4V9Pt2eFaYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641315926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AfBngmkoikoFNur2GoLsVjxFAUjb8tl7MPdE1R0s/Q0=;
        b=IPS7QgO5/jdCIJeIoydxOs9ZvTr4HK0ZlHOLaQkr6NYIiC7skCbaxa3IPED+BAG1zo4+iu
        GWmjHPu+nFLL+/Cw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 304EDA3BAF;
        Tue,  4 Jan 2022 17:05:26 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>
Subject: [PATCH] debugfs: lockdown: Allow reading debugfs files that are not world readable
Date:   Tue,  4 Jan 2022 18:05:05 +0100
Message-Id: <20220104170505.10248-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When the kernel is locked down the kernel allows reading only debugfs
files with mode 444. Mode 400 is also valid but is not allowed.

Make the 444 into a mask.

Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 7d162b0efbf0..950c63fa4d0b 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -147,7 +147,7 @@ static int debugfs_locked_down(struct inode *inode,
 			       struct file *filp,
 			       const struct file_operations *real_fops)
 {
-	if ((inode->i_mode & 07777) == 0444 &&
+	if ((inode->i_mode & 07777 & ~0444) == 0 &&
 	    !(filp->f_mode & FMODE_WRITE) &&
 	    !real_fops->unlocked_ioctl &&
 	    !real_fops->compat_ioctl &&
-- 
2.31.1

