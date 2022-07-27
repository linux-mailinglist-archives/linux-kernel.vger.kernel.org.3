Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65349582A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiG0QLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiG0QLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:11:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2444B489
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:11:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07B0220B50;
        Wed, 27 Jul 2022 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658938301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3mt4s6TRQ/5aagVzKEJ+zgYn0F6bDFqIRsrNqODGf7E=;
        b=NtaPEGWzhlotMBwyFZD3iTRpfGUTIWmOn2DW54OX/U4/D1K7gncI+DGSSzAJhCqf2znPks
        NAmwroaUvltAclyAEq0puEVsYcRPht59KEvge6L15u7RMchlaUndiVIZQ+EbriXWCzzPSo
        j+oDzlYqTPoYJBHBQyd/u6bX0iANnIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658938301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3mt4s6TRQ/5aagVzKEJ+zgYn0F6bDFqIRsrNqODGf7E=;
        b=LqPsR8ORFCwSPJ4gIbI3UO7UVOpEHStpGqXPanRx4WXmJOTOYGCxK/cT0t4QvRUyaCCBd+
        uTT2UZUYTkGIdZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C852113ABC;
        Wed, 27 Jul 2022 16:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QXDvLrxj4WLLAQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 27 Jul 2022 16:11:40 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 1/1] drivers/base/cpu: Print kernel arch
Date:   Wed, 27 Jul 2022 18:11:35 +0200
Message-Id: <20220727161135.24531-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print kernel architecture in /sys/devices/system/cpu/arch
using UTS_MACHINE, i.e. member of struct uts_namespace.machine.

This helps people who debug kernel with initramfs with minimal
environment (i.e. without coreutils or even busybox) or allow to open
sysfs file instead of run uname -m in high level languages.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 drivers/base/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..7c8032e3ff10 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -3,6 +3,7 @@
  * CPU subsystem support
  */
 
+#include <generated/compile.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -232,6 +233,13 @@ static ssize_t print_cpus_kernel_max(struct device *dev,
 }
 static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
 
+static ssize_t print_cpus_arch(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", UTS_MACHINE);
+}
+static DEVICE_ATTR(arch, 0444, print_cpus_arch, NULL);
+
 /* arch-optional setting to enable display of offline cpus >= nr_cpu_ids */
 unsigned int total_cpus;
 
@@ -464,6 +472,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&cpu_attrs[1].attr.attr,
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
+	&dev_attr_arch.attr,
 	&dev_attr_offline.attr,
 	&dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
-- 
2.37.1

